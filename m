Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSHOW47>; Thu, 15 Aug 2002 18:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSHOW47>; Thu, 15 Aug 2002 18:56:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8877 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317637AbSHOW46>;
	Thu, 15 Aug 2002 18:56:58 -0400
Date: Fri, 16 Aug 2002 01:01:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160003260.24255-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208160100430.19466-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> personally i'd make it even more compact by merging the two clone flags
> as well, something along: CLONE_MANAGE_TID. I cannot see any reason for
> a thread library to use one of the bits only. This also reflects the
> fact that it's thread state that the kernel helps managing, both in the
> thread-create and in the thread-exit path. But this might be stretching
> things a bit?

the attached patch implements this. (ontop the previous patch.)

	Ingo

--- linux/arch/i386/kernel/process.c.orig	Fri Aug 16 01:01:27 2002
+++ linux/arch/i386/kernel/process.c	Fri Aug 16 01:02:03 2002
@@ -591,7 +591,7 @@
 	/*
 	 * The common fastpath:
 	 */
-	if (!(clone_flags & (CLONE_SETTLS | CLONE_SETTID | CLONE_CLEARTID)))
+	if (!(clone_flags & (CLONE_SETTLS | CLONE_MANAGE_TID)))
 		return 0;
 	/*
 	 * Set a new TLS for the child thread?
@@ -616,17 +616,13 @@
 	}
 
 	/*
-	 * Notify the child of the TID?
+	 * Notify the child of the TID, and clear it on exit?
 	 */
-	if (clone_flags & CLONE_SETTID)
+	if (clone_flags & CLONE_MANAGE_TID) {
 		if (put_user(p->pid, (pid_t *)childregs->edx))
 			return -EFAULT;
-
-	/*
-	 * Does the userspace VM want the TID cleared on mm_release()?
-	 */
-	if (clone_flags & CLONE_CLEARTID)
 		p->user_tid = (long *) childregs->edx;
+	}
 	return 0;
 }
 
--- linux/include/linux/sched.h.orig	Fri Aug 16 01:00:33 2002
+++ linux/include/linux/sched.h	Fri Aug 16 01:01:19 2002
@@ -46,10 +46,8 @@
 #define CLONE_NEWNS	0x00020000	/* New namespace group? */
 #define CLONE_SYSVSEM	0x00040000	/* share system V SEM_UNDO semantics */
 #define CLONE_SETTLS	0x00080000	/* create a new TLS for the child */
-#define CLONE_SETTID	0x00100000	/* write the TID back to userspace */
-#define CLONE_CLEARTID	0x00200000	/* clear the userspace TID */
-#define CLONE_DETACHED	0x00400000	/* parent wants no child-exit signal */
-#define CLONE_RELEASE_VM 0x00800000	/* release the userspace VM */
+#define CLONE_MANAGE_TID 0x00100000	/* set and clear the userspace TID */
+#define CLONE_DETACHED	0x00200000	/* parent wants no child-exit signal */
 
 #define CLONE_SIGNAL	(CLONE_SIGHAND | CLONE_THREAD)
 

