Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTLBSXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTLBSXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:23:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:8349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263345AbTLBSX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:23:29 -0500
Date: Tue, 2 Dec 2003 10:23:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>
cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
In-Reply-To: <20031202082713.GN12211@suse.de>
Message-ID: <Pine.LNX.4.58.0312021009070.1519@home.osdl.org>
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de>
 <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de>
 <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202082713.GN12211@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Dec 2003, Jens Axboe wrote:
>
> Smells like a bio stacking problem in raid/dm then. I'll take a quick
> look and see if anything obvious pops up, otherwise the maintainers of
> those areas should take a closer look.

There are several other problem reports which start to smell like md/raid.

> That might be a good idea, although it's not very likely to be an XFS
> problem as it happens further down the io stack. It should trigger just
> as happily on IDE or SCSI if that was the case.

There's one (by Alan Buxey) that I attributed to PREEMPT which happens on
UP with ext3 and raid0:

	md: Autodetecting RAID arrays.
	md: autorun ...
	md: considering hdd1 ...
	md:  adding hdd1 ...
	md:  adding hda1 ...
	md: created md0
	md: bind<hda1>
	md: bind<hdd1>
	md: running: <hdd1><hda1>
	raid1: raid set md0 active with 2 out of 2 mirrors
	md: ... autorun DONE.

and that one shows strange memory corruption problems too.

NOTE! The fact that it only happens with PREEMPT for some people is not
necessarily a sign of preempt-only trouble: while PREEMPT should really be
equivalent to SMP-safe, but there are some things that are much more
likely with preemption than with normal SMP.

In particular, preempt will cause every single (final) unlock to check
whether there is something else runnable with a higher priority, so it
opens up races a lot - if you touch something just outside (in particular:
_after_) the locked region, preempt is much more likely to show a race
that on SMP might be just a few instructions long.

		Linus
