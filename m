Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVFNHEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVFNHEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFNHEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:04:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261268AbVFNHEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:04:09 -0400
Date: Tue, 14 Jun 2005 00:03:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: spaminos-ker@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Message-Id: <20050614000352.7289d8f1.akpm@osdl.org>
In-Reply-To: <20050614021959.99775.qmail@web30707.mail.mud.yahoo.com>
References: <20050611022959.3954ff6b.akpm@osdl.org>
	<20050614021959.99775.qmail@web30707.mail.mud.yahoo.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<spaminos-ker@yahoo.com> wrote:
>
> --- Andrew Morton <akpm@osdl.org> wrote:
> > It might be useful to test 2.6.12-rc6-mm1 - it has a substantially
> > rewritten CFQ implementation.
> > 
> 
> Just did, and while things seem to be a little better, cfq still gets
> performance even worst than noop.
> 
> For this type of load, I think that cfq should get latencies much lower than
> noop.
> 
> I ran an automated vi "write to file", to get a more persistant test, on the
> different i/o scheduler.
> 
> while true ; do time vi -c '%s/a/aa/g' -c '%s/aa/a/g' -c 'x' /root/somefile >
> /dev/null ; sleep 1m ; done

Bear in mind that after one minute, all of vi's text may have been
reclaimed from pagecache, so the above would have to do a lot of randomish
reads to reload vi into memory.  Try reducing the sleep interval a lot.

> For some reason, doing a "cp" or appending to files is very fast. I suspect
> that vi's mmap calls are the reason for the latency problem.

Don't know.  Try to work out (from vmstat or diskstats) how much reading is
going on.

Try stracing the check, see if your version of vi is doing a sync() or
something odd like that.

> the times I got (to save a 200 bytes file on ext3) in seconds:
> 
> cfq 13,19,23,19,23,15,14,16,14 = 17.3 avg
> 
> deadline 7,12,11,15,15,8,17,14,16,11 = 12.6 avg
> 
> noop 23,12,14,12,12,13,14,14,14 = 14.2 avg
> 
> anticipatory 9,13,13,15,19,15,23,15,12 = 14.8 avg
> 

OK, well if the latency is mainly due to reads then one would hope that the
anticipatory scheduler would do better than that.

But what happened to this, from your first report?

> On the other hand, opening a blank new file in vi and saving it takes about 5
> minutes or so.

Are you able to reproduce that 5-minute stall in the more recent testing?

