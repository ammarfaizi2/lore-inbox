Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSHQSoC>; Sat, 17 Aug 2002 14:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSHQSoC>; Sat, 17 Aug 2002 14:44:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47781 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318726AbSHQSoA>;
	Sat, 17 Aug 2002 14:44:00 -0400
Date: Sat, 17 Aug 2002 20:48:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CLONE_DETACHED and exit notification (was user-vm-unlock-2.5.31-A2)
In-Reply-To: <Pine.LNX.4.44.0208161033090.3193-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208172044540.16707-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Linus Torvalds wrote:

> Oh, good. If it turns out that even pthreads wants the futex, let's just
> do it that way. Pls send in a patch once you have something tested
> ready, ok?

tested patch (against BK-curr-ish) attached. glibc/pthreads had been
updated to use the TID-futex, this removes an extra system-call and it
also simplifies the pthread_join() code. The pthreads testcode works just
fine with the new kernel and does not work with a kernel that does not do
the futex wakeup, so it's working fine.

	Ingo

--- linux/include/linux/futex.h.orig	Sat Aug 17 20:45:01 2002
+++ linux/include/linux/futex.h	Sat Aug 17 20:45:07 2002
@@ -6,4 +6,6 @@
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
 
+extern asmlinkage int sys_futex(void *uaddr, int op, int val, struct timespec *utime);
+
 #endif
--- linux/kernel/fork.c.orig	Sat Aug 17 20:45:17 2002
+++ linux/kernel/fork.c	Sat Aug 17 20:46:30 2002
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/futex.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -370,12 +371,14 @@
 		tsk->vfork_done = NULL;
 		complete(vfork_done);
 	}
-	if (tsk->user_tid)
+	if (tsk->user_tid) {
 		/*
 		 * We dont check the error code - if userspace has
 		 * not set up a proper pointer then tough luck.
 		 */
 		put_user(0UL, tsk->user_tid);
+		sys_futex(tsk->user_tid, FUTEX_WAKE, 1, NULL);
+	}
 }
 
 static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)

