Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbTCaWw2>; Mon, 31 Mar 2003 17:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbTCaWw2>; Mon, 31 Mar 2003 17:52:28 -0500
Received: from dyn-ctb-210-9-246-105.webone.com.au ([210.9.246.105]:17924 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261891AbTCaWw1>;
	Mon, 31 Mar 2003 17:52:27 -0500
Message-ID: <3E88C93D.3020107@cyberone.com.au>
Date: Tue, 01 Apr 2003 09:03:25 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: helgehaf@aitel.hist.no, erik@hensema.net, linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>	<20030328231248.GH5147@zaurus.ucw.cz>	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>	<3E8845A8.20107@aitel.hist.no>	<3E88BAF9.8040100@cyberone.com.au> <20030331144500.17bf3a2e.akpm@digeo.com>
In-Reply-To: <20030331144500.17bf3a2e.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>  
>
>>it seems to me that
>>doing writeout whenever the disk would otherwise be idle
>>(and we have dirty memory to write out) would be a good
>>solution.
>>    
>>
>
>This is what the recently-removed BDI_read_active flag in backing_dev_info
>was supposed to be for.  I let it go because I don't think it's terribly
>important and it's time to stop fiddling with the vfs writeout code and it
>wasn't right anyway.
>
>Note that 2.5 starts pdflush writeout at 10% of memory dirty.  Or even lower
>if there is a lot of mapped memory around.  Whereas 2.4 will start background
>writeout at 30% or 40% dirty.  That's a fairly significant tuning change.
>
>The algorithm for utilisation of an idle disk should be, in
>balance_dirty_pages():
>
>	if (ps.nr_dirty + ps.nr_writeback < background_thresh) {
>		if (time_after(jiffies, bdi->last_read + HZ/100)) {
>			if (bdi->write_requests_in_flight < 2) {
>				struct writeback_control wbc = {
>					.bdi		= bdi,
>					.sync_mode	= WB_SYNC_NONE,
>					.nr_to_write	= write_chunk,
>				};
>
>				writeback_inodes(&wbc);
>			}
>		}
>		return;
>	}
>
>
>Or something like that.  It's pretty close.
>
Yeah something like that looks alright.

>
>It could have pretty bad failure modes.  Short-lived files in /tmp now
>perform writeout, which needs to be waited on when those files are removed.
>  
>
I didn't think of that.

