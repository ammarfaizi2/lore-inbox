Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbUCSNo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbUCSNo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:44:26 -0500
Received: from ns.suse.de ([195.135.220.2]:57220 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262992AbUCSNoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:44:23 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Chris Mason <mason@suse.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
In-Reply-To: <s5hsmg5awzv.wl@alsa2.suse.de>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
	 <20040318110159.321754d8.akpm@osdl.org> <s5hbrmuc6ed.wl@alsa2.suse.de>
	 <20040318112941.0221c6ac.akpm@osdl.org>
	 <1079639286.4187.2113.camel@watt.suse.com>  <s5hsmg5awzv.wl@alsa2.suse.de>
Content-Type: text/plain
Message-Id: <1079704007.11058.127.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 08:46:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 06:37, Takashi Iwai wrote:
> At Thu, 18 Mar 2004 14:48:07 -0500,
> Chris Mason wrote:
> > 
> > On Thu, 2004-03-18 at 14:29, Andrew Morton wrote:
> > 
> > > > yep, i see a similar problem also in reiserfs's do_journal_end().
> > > > it's in lock_kernel().
> > > 
> > > I have a scheduling point in journal_end() in 2.4.  But I added bugs to
> > > reiserfs a couple of times doing this - it's pretty delicate.  Beat up on
> > > Chris ;)
> > 
> > ;-) Not sure if Takashi is talking about -suse or -mm, the data=ordered
> > patches change things around.  He sent me suggestions for the
> > data=ordered latencies already, but it shouldn't be against the BKL
> > there, since I drop it before calling write_ordered_buffers().
> 
> i tested only suse kernels recently.  will try mm kernel later, again.
> 
> ok, let me explain some nasty points i found through the disk i/o load
> tests:
> 
> - in the loop in do_journal_end().  this happens periodically in
>   pdflush.
> 
This one we need.

> - in write_ordered_buffers().
> 
>   i still don't figure out where.  we have already cond_resched()
>   check in the loops.  this one is triggered when i write bulk data
>   in parallel (1GB write with 20 threads at the same time), resulting
>   in up to 2ms.
> 
Hmmm, is this a lock latency or just noticing that write() takes a long
time?

It's probably this:
	if (chunk.nr == 0 && need_resched) {

I'll bet the latencies go away when you drop the chunk.nr test.  If so
I'll need to benchmark if we want to submit before the schedule
(probably yes, as long as we've already sent down some buffers
previously).

(BTW, this code is only in the -suse patchset, data=ordered adds many
new places for possible latencies)

-chris

