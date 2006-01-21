Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWAUBRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWAUBRp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWAUBRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:17:45 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:39565 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932364AbWAUBRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:17:44 -0500
Subject: Re: OOM Killer killing whole system
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chase Venters <chase.venters@clientec.com>, a.titov@host.bg,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20060120165031.7773d9c4.akpm@osdl.org>
References: <1137337516.11767.50.camel@localhost>
	 <1137793685.11771.58.camel@localhost>
	 <20060120145006.0a773262.akpm@osdl.org>
	 <200601201819.58366.chase.venters@clientec.com>
	 <20060120165031.7773d9c4.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 19:17:27 -0600
Message-Id: <1137806248.4122.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 16:50 -0800, Andrew Morton wrote:
> For linux-scsi reference, Chase's /proc/slabinfo says:
> 
> scsi_cmd_cache    1547440 1547440    384   10    1 : tunables   54   27    8 : 
> slabdata 154744 154744      0

There's another curiosity about this: the linux command stack is pretty
well counted per scsi device (it's how we control queue depth), so if a
driver leaks commands we see it not by this type of behaviour, but by
the system hanging (waiting for all the commands the mid-layer thinks
are outstanding to return).  So, the only way we could leak commands
like this is in the mid-layer command return logic ... and I can't find
anywhere this might happen.

The sequence is:

driver -> cmd->scsi_done() -> blk softirq -> scsi_softirq_done() ->
scsi_finish_cmd() (where the queue counts are decremented, so anything
after here could leak commands if the rest of the chain is broken) ->
cmd->done() (which is the ULD completion callback) ->
scsi_io_completion() (frees the sg table, so if the sgpool slabs aren't
out of whack we must be past here) -> scsi_end_request() ->
scsi_next_command() -> scsi_put_command() (which is where the command
goes back to the slab).

James


> > Curious - the -s... were you expecting the ring buffer 
> > to exceed 16384?
> 
> It can sometimes be quite large.  I always say -s 1000000 to make sure
> everything got there.
> 
> > I don't think my (boot time) buffer does.
> 
> It's compile-time configurable with CONFIG_LOG_BUF_SHIFT and boot-time
> configurable with log_buf_len=n.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

