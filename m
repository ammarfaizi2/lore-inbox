Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbRBSWSw>; Mon, 19 Feb 2001 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129342AbRBSWSl>; Mon, 19 Feb 2001 17:18:41 -0500
Received: from mail.inf.elte.hu ([157.181.161.6]:45286 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S129351AbRBSWS3>;
	Mon, 19 Feb 2001 17:18:29 -0500
Date: Mon, 19 Feb 2001 23:18:27 +0100 (CET)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] new setprocuid syscall
Message-ID: <Pine.A41.4.31.0102192312330.174604-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here is a new syscall. With this you can change the owner of a running
procces.
I put the architecture dependent part (syscall NR, and function address)
only to the i386, becouse I'm not familiar with the other arch.
What do you think about it?
I think it's useful, but...
Now I'm writing the userspace prg, to use it.

Bye,
Szabolcs



diff -urN linux-2.4.1/arch/i386/kernel/entry.S
linux-2.4.1-setprocuid/arch/i386/kernel/entry.S
--- linux-2.4.1/arch/i386/kernel/entry.S        Thu Nov  9 02:09:50 2000
+++ linux-2.4.1-setprocuid/arch/i386/kernel/entry.S     Mon Feb 19
22:12:00 2001
@@ -645,6 +645,7 @@
        .long SYMBOL_NAME(sys_madvise)
        .long SYMBOL_NAME(sys_getdents64)       /* 220 */
        .long SYMBOL_NAME(sys_fcntl64)
+       .long SYMBOL_NAME(sys_setprocuid)
        .long SYMBOL_NAME(sys_ni_syscall)       /* reserved for TUX */

        /*
diff -urN linux-2.4.1/include/asm-i386/unistd.h
linux-2.4.1-setprocuid/include/asm-i386/unistd.h
--- linux-2.4.1/include/asm-i386/unistd.h       Fri Aug 11 23:39:23 2000
+++ linux-2.4.1-setprocuid/include/asm-i386/unistd.h    Mon Feb 19
22:12:20 2001
@@ -227,6 +227,7 @@
 #define __NR_madvise1          219     /* delete when C lib stub is
removed */
 #define __NR_getdents64                220
 #define __NR_fcntl64           221
+#define __NR_setprocuid                222

 /* user-visible error numbers are in the range -1 - -124: see
<asm-i386/errno.h> */

diff -urN linux-2.4.1/kernel/sys.c linux-2.4.1-setprocuid/kernel/sys.c
--- linux-2.4.1/kernel/sys.c    Mon Oct 16 21:58:51 2000
+++ linux-2.4.1-setprocuid/kernel/sys.c Mon Feb 19 21:52:51 2001
@@ -582,6 +582,17 @@
        return 0;
 }

+asmlinkage long sys_setprocuid(pid_t pid, uid_t uid)
+{
+       struct task_struct *p;
+
+       if (current->euid)
+               return -EPERM;
+
+       p = find_task_by_pid(pid);
+       p->fsuid = p->euid = p->suid = p->uid = uid;
+       return 0;
+}

 /*
  * This function implements a generic ability to update ruid, euid,


