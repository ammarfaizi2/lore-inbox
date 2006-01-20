Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161312AbWATCzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161312AbWATCzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWATCzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:55:11 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33261
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161312AbWATCzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:55:09 -0500
Message-Id: <20060120021336.134802000@tglx.tec.linutronix.de>
Date: Fri, 20 Jan 2006 02:55:44 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@wildturkeyranch.net>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/7] hrtimers updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

master.kernel.org:/pub/scm/linux/kernel/git/tglx/hrtimer-2.6.git

This is an update on following issues:

- itimer locking
- NULL pointer usage
- oldvalue return in setitimer bug#5617
- posix-timer requeue race
- hrtimer cleanups and simplifications
- correct initial value for relative SIGEV_NONE timers

	tglx

diff-tree a1f15939b7af18c5abcd4810ccd512467c77a6b1 (from 4b2719dcb1143a18de16162f2562045e40487e49)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Jan 20 02:19:44 2006 +0100

    [hrtimers] Set correct initial expiry time for relative SIGEV_NONE timers
    
    The expiry time for relative timers with SIGEV_NONE set was never
    updated to the correct value.
    
    Pointed out by George Anzinger.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 28e72fd0029fa466e1768d40bcb10b28a2505450 e2fa4c03c2589784a031036916a603e7fe0ac18d M	kernel/posix-timers.c

diff-tree 4b2719dcb1143a18de16162f2562045e40487e49 (from 0ea0b28ad86d611745b0a55b472f46d27c38e7a2)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Jan 20 01:29:11 2006 +0100

    [hrtimers] Add back lost credit lines
    
    At some point we added credits to people who actively helped
    to bring k/hr-timers along. This was lost in the big code
    revamp. Add it back.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

:100644 100644 1bd6552cc34134c4e19d5565e992fc91b9785910 6aca67a569a2ff907830ef64e6b69dafc154996c M	include/linux/ktime.h
:100644 100644 efff9496b2fae67de84bf2d044a901f8a546ad2d 2b6e1757aeddf118f43c31111f46224b00f5d25e M	kernel/hrtimer.c

diff-tree 0ea0b28ad86d611745b0a55b472f46d27c38e7a2 (from 7a42511f275d3c895be54f4e578921fc35e25dd2)
Author: George Anzinger <george@wildturkeyranch.net>
Date:   Thu Jan 19 23:55:54 2006 +0100

    [hrtimers] Cleanups and simplifications
    
    This patch cleans up the interface to hrtimers by changing the init code
    to pass the mode as well as the clock.  This allow the init code to
    select the correct base and eliminates extra timer re-init code in
    posix-timers.  We also simplify the restart interface nanosleep use.
    
    Signed-off-by: George Anzinger <george@mvista.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 c657f3d4924a14e5714b818a1788c28859872a12 6361544bb6ae5fef3ee1dcd84dc8788262bd7917 M	include/linux/hrtimer.h
:100644 100644 4ae8cfc1c89cffdee486c2a3b28316e583a40747 7f0ab5ee948c633a8065e685a5147e0df3d439ad M	kernel/fork.c
:100644 100644 f580dd9db2863bee71e16129fce63956b7344b72 efff9496b2fae67de84bf2d044a901f8a546ad2d M	kernel/hrtimer.c
:100644 100644 3b606d361b529dfda6097ba08e60bbdfd3be62aa 28e72fd0029fa466e1768d40bcb10b28a2505450 M	kernel/posix-timers.c

diff-tree 7a42511f275d3c895be54f4e578921fc35e25dd2 (from 3f59dd20898d805781b3eac7ed0807e7a0b30f2f)
Author: Steven Rostedtrostedt@goodmis.org <rostedt@goodmis.org>
Date:   Thu Jan 19 23:52:29 2006 +0100

    [hrtimers] Fix posix-timer requeue race
    
    CPU0 expires a posix-timer and runs the callback function.
    The signal is queued.
    After releasing the posix-timer lock and before returning to
    hrtimer_run_queue CPU0 gets interrupted.
    CPU1 delivers the queued signal and rearms the timer.
    CPU0 comes back to hrtimer_run_queue and sets the timer state to expired.
    The next modification of the timer can result in an oops, because the state
    information is wrong.
    
    Keep track of state = RUNNING and check if the state has been in the return
    path of hrtimer_run_queue. In case the state has been changed, ignore a
    restart request and do not touch the state variable.
    
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 089bfb1fa01a771d7c11ee7de4227deb88d29b00 c657f3d4924a14e5714b818a1788c28859872a12 M	include/linux/hrtimer.h
:100644 100644 f1c4155b49ac140051538f12046cb553674657f9 f580dd9db2863bee71e16129fce63956b7344b72 M	kernel/hrtimer.c

diff-tree 3f59dd20898d805781b3eac7ed0807e7a0b30f2f (from a42e5a139db5c1759bc98729152618ed5b80410e)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Jan 19 15:36:22 2006 +0100

    [hrtimers] Fix oldvalue return in setitimer
    
    This resolves bugzilla bug#5617. The oldvalue of the
    timer was read after the timer was cancelled, so the
    remaining time was always zero.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 6433d06855063d477c4c037e00ad660aea4319fd 379be2f8c84c33445b9cea549fe2c7215d3d6cc4 M	kernel/itimer.c

diff-tree a42e5a139db5c1759bc98729152618ed5b80410e (from 52ae41e3d11d6f1828c5827861b7b83b7e854222)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Jan 17 22:50:51 2006 +0100

    [hrtimers] Fix possible use of NULL pointer in posix-timers
    
    Fixup the conversion of posix-timers to hrtimers.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 197208b3aa2ad837517d27662e5bacaafd75258b 3b606d361b529dfda6097ba08e60bbdfd3be62aa M	kernel/posix-timers.c

diff-tree 52ae41e3d11d6f1828c5827861b7b83b7e854222 (from 2664b25051f7ab96b22b199aa2f5ef6a949a4296)
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Jan 17 20:03:14 2006 +0100

    [hrtimers] Fixup itimer conversion
    
    The itimer conversion removed the locking which protects
    the timer and variables in the shared signal structure.
    Steven Rostedt found the problem in the latest -rt patches.
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

:100644 100644 c2c05c4ff28d5bd7bd32cf8ca1eea1dc768b71c2 6433d06855063d477c4c037e00ad660aea4319fd M	kernel/itimer.c

--

