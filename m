Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSADPI3>; Fri, 4 Jan 2002 10:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288667AbSADPIU>; Fri, 4 Jan 2002 10:08:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56457 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288666AbSADPIG>;
	Fri, 4 Jan 2002 10:08:06 -0500
Date: Fri, 4 Jan 2002 18:05:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Blanchard <anton@samba.org>
Subject: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
Message-ID: <Pine.LNX.4.33.0201041743050.8766-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the next release of the O(1) scheduler:

	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-A1.patch
	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-A1.patch

this release includes fixes and small improvements. (The 2.5.2-A1 patch is
against the 2.5.2-pre7 kernel.) I cannot reproduce any more failures with
this patch, but i couldnt test the vfat lockup problem. The X lockup
problem never occured on any of my boxes, but it might be fixed by one of
the changes included in this patch nevertheless.

Changes:

 - idle process notification fixes. This fixes the idle=poll breakage
   reported by Anton Blanchard.

 - fix a bug in setscheduler() which crashed if a non-SCHED_OTHER task did
   a setscheduler() call. This fixes the crash reported by Randy Hron. The
   Linux Test Project's syscall tests do not cause a crash anymore.

 - do some more unlikely()/likely() tagging of branches along the hotpath,
   suggested by Jeff Garzik.

 - fix the compile failures in md.c and loop.c and other files, reported
   by many people.

 - fix the too-big-by-one error in the bitmat sizing define, noticed by
   Anton Blanchard.

 - fix a bug in rt_lock() + setscheduler() that had a potential for a
   spinlock lockup.

 - introduce the idle_tick() function, so that idle CPUs can do
   load-balancing as well.

 - do LINUX_VERSION_CODE checking in jffs2 (Jeff Garzik)

 - optimize the big-kernel-lock releasing/acquiring code some more. From
   now on it's absolutely illegal to schedule() from cli()-ed code. (not
   that it was legal.) This moves a few instructions off the scheduler
   hotpath.

 - move the ->need_resched setting into idle_init().

 - do not clear RT tasks in reparent_to_init(). There's nothing bad with
   running RT tasks in the background.

 - RT task's priority order was inverted, it should be 0-99, not 99-0.

 - make load-balancing a bit less eager when there are lots of processes
   running: it needs a ~10% imbalance in runqueue lengths to trigger a
   rebalance.

 - (there is a small hack in serial.c in the 2.5.2-pre7 patch, to make it
   compile.)

Comments, bug reports, suggestions are welcome,

	Ingo

