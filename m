Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUDSG0w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 02:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUDSG0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 02:26:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:23454 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263204AbUDSG0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 02:26:34 -0400
Subject: [PATCH] ppc/ppc64: Add posix message queue syscalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082355976.1690.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 16:26:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds the posix message queue syscalls to ppc32 and 64 and
fixes our implementation of compat copy siginfo to 32 bits userland
which wasn't using the si_code but still doing a switch/case on the
signal number.

(Andrew: I also reserved some syscalls for the numa API)

Please apply.

Ben.

===== arch/ppc/kernel/misc.S 1.55 vs edited =====
--- 1.55/arch/ppc/kernel/misc.S	Tue Apr 13 03:54:12 2004
+++ edited/arch/ppc/kernel/misc.S	Mon Apr 19 14:47:39 2004
@@ -1372,4 +1372,16 @@
 	.long sys_statfs64
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
-	.long sys_ni_syscall	/* 255 - rtas (used on ppc64) */
+	.long sys_ni_syscall		/* 255 - rtas (used on ppc64) */
+	.long sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
+	.long sys_ni_syscall		/* 257 reserved for vserver */
+	.long sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
+	.long sys_ni_syscall		/* 259 reserved for new sys_mbind */
+	.long sys_ni_syscall		/* 260 reserved for new sys_get_mempolicy */
+	.long sys_ni_syscall		/* 261 reserved for new sys_set_mempolicy */
+	.long sys_mq_open
+	.long sys_mq_unlink
+	.long sys_mq_timedsend
+	.long sys_mq_timedreceive	/* 265 */
+	.long sys_mq_notify
+	.long sys_mq_getsetattr
===== arch/ppc64/kernel/misc.S 1.75 vs edited =====
--- 1.75/arch/ppc64/kernel/misc.S	Tue Apr 13 03:54:08 2004
+++ edited/arch/ppc64/kernel/misc.S	Mon Apr 19 14:46:54 2004
@@ -828,6 +828,18 @@
 	.llong .compat_fstatfs64
 	.llong .ppc32_fadvise64_64	/* 32bit only fadvise64_64 */
 	.llong .ppc_rtas		/* 255 */
+	.llong .sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
+	.llong .sys_ni_syscall		/* 257 reserved for vserver */
+	.llong .sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
+	.llong .sys_ni_syscall		/* 259 reserved for new sys_mbind */
+	.llong .sys_ni_syscall		/* 260 reserved for new sys_get_mempolicy */
+	.llong .sys_ni_syscall		/* 261 reserved for new sys_set_mempolicy */
+	.llong .compat_sys_mq_open
+	.llong .sys_mq_unlink
+	.llong .compat_sys_mq_timedsend
+	.llong .compat_sys_mq_timedreceive /* 265 */
+	.llong .compat_sys_mq_notify
+	.llong .compat_sys_mq_getsetattr
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1087,3 +1099,15 @@
 	.llong .sys_fstatfs64
 	.llong .sys_ni_syscall		/* 32bit only fadvise64_64 */
 	.llong .ppc_rtas		/* 255 */
+	.llong .sys_ni_syscall		/* 256 reserved for sys_debug_setcontext */
+	.llong .sys_ni_syscall		/* 257 reserved for vserver */
+	.llong .sys_ni_syscall		/* 258 reserved for new sys_remap_file_pages */
+	.llong .sys_ni_syscall		/* 259 reserved for new sys_mbind */
+	.llong .sys_ni_syscall		/* 260 reserved for new sys_get_mempolicy */
+	.llong .sys_ni_syscall		/* 261 reserved for new sys_set_mempolicy */
+	.llong .sys_mq_open
+	.llong .sys_mq_unlink
+	.llong .sys_mq_timedsend
+	.llong .sys_mq_timedreceive	/* 265 */
+	.llong .sys_mq_notify
+	.llong .sys_mq_getsetattr
===== arch/ppc64/kernel/signal32.c 1.46 vs edited =====
--- 1.46/arch/ppc64/kernel/signal32.c	Wed Apr 14 19:14:46 2004
+++ edited/arch/ppc64/kernel/signal32.c	Mon Apr 19 14:04:10 2004
@@ -437,37 +437,46 @@
 	if (!access_ok (VERIFY_WRITE, d, sizeof(*d)))
 		return -EFAULT;
 
+	/* If you change siginfo_t structure, please be sure
+	 * this code is fixed accordingly.
+	 * It should never copy any pad contained in the structure
+	 * to avoid security leaks, but must copy the generic
+	 * 3 ints plus the relevant union member.  
+	 * This routine must convert siginfo from 64bit to 32bit as well
+	 * at the same time.
+	 */
 	err = __put_user(s->si_signo, &d->si_signo);
 	err |= __put_user(s->si_errno, &d->si_errno);
 	err |= __put_user((short)s->si_code, &d->si_code);
-	if (s->si_signo >= SIGRTMIN) {
+	if (s->si_code < 0)
+		err |= __copy_to_user(&d->_sifields._pad, &s->_sifields._pad,
+				      SI_PAD_SIZE32);
+	else switch(s->si_code >> 16) {
+	case __SI_CHLD >> 16:
 		err |= __put_user(s->si_pid, &d->si_pid);
 		err |= __put_user(s->si_uid, &d->si_uid);
+		err |= __put_user(s->si_utime, &d->si_utime);
+		err |= __put_user(s->si_stime, &d->si_stime);
+		err |= __put_user(s->si_status, &d->si_status);
+		break;
+	case __SI_FAULT >> 16:
+		err |= __put_user((unsigned int)(unsigned long)s->si_addr,
+				  &d->si_addr);
+		break;
+	case __SI_POLL >> 16:
+	case __SI_TIMER >> 16:
+		err |= __put_user(s->si_band, &d->si_band);
+		err |= __put_user(s->si_fd, &d->si_fd);
+		break;
+	case __SI_RT >> 16: /* This is not generated by the kernel as of now.  */
+	case __SI_MESGQ >> 16:
 		err |= __put_user(s->si_int, &d->si_int);
-	} else {
-		switch (s->si_signo) {
-		/* XXX: What about POSIX1.b timers */
-		case SIGCHLD:
-			err |= __put_user(s->si_pid, &d->si_pid);
-			err |= __put_user(s->si_status, &d->si_status);
-			err |= __put_user(s->si_utime, &d->si_utime);
-			err |= __put_user(s->si_stime, &d->si_stime);
-			break;
-		case SIGSEGV:
-		case SIGBUS:
-		case SIGFPE:
-		case SIGILL:
-			err |= __put_user((long)(s->si_addr), &d->si_addr);
-	        break;
-		case SIGPOLL:
-			err |= __put_user(s->si_band, &d->si_band);
-			err |= __put_user(s->si_fd, &d->si_fd);
-			break;
-		default:
-			err |= __put_user(s->si_pid, &d->si_pid);
-			err |= __put_user(s->si_uid, &d->si_uid);
-			break;
-		}
+		/* fallthrough */
+	case __SI_KILL >> 16:
+	default:
+		err |= __put_user(s->si_pid, &d->si_pid);
+		err |= __put_user(s->si_uid, &d->si_uid);
+		break;
 	}
 	return err;
 }
===== include/asm-ppc/unistd.h 1.29 vs edited =====
--- 1.29/include/asm-ppc/unistd.h	Tue Mar 16 21:29:21 2004
+++ edited/include/asm-ppc/unistd.h	Mon Apr 19 14:45:32 2004
@@ -260,8 +260,20 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+/* Number 256 is reserved for sys_debug_setcontext */
+/* Number 257 is reserved for vserver */
+/* Number 258 is reserved for new sys_remap_file_pages */
+/* Number 259 is reserved for new sys_mbind */
+/* Number 260 is reserved for new sys_get_mempolicy */
+/* Number 261 is reserved for new sys_set_mempolicy */
+#define __NR_mq_open		262
+#define __NR_mq_unlink		263
+#define __NR_mq_timedsend	264
+#define __NR_mq_timedreceive	265
+#define __NR_mq_notify		266
+#define __NR_mq_getsetattr	267
 
-#define __NR_syscalls		256
+#define __NR_syscalls		268
 
 #define __NR(n)	#n
 
===== include/asm-ppc64/unistd.h 1.28 vs edited =====
--- 1.28/include/asm-ppc64/unistd.h	Thu Mar 18 13:43:04 2004
+++ edited/include/asm-ppc64/unistd.h	Mon Apr 19 14:44:49 2004
@@ -266,8 +266,20 @@
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
 #define __NR_rtas		255
+/* Number 256 is reserved for sys_debug_setcontext */
+/* Number 257 is reserved for vserver */
+/* Number 258 is reserved for new sys_remap_file_pages */
+/* Number 259 is reserved for new sys_mbind */
+/* Number 260 is reserved for new sys_get_mempolicy */
+/* Number 261 is reserved for new sys_set_mempolicy */
+#define __NR_mq_open		262
+#define __NR_mq_unlink		263
+#define __NR_mq_timedsend	264
+#define __NR_mq_timedreceive	265
+#define __NR_mq_notify		266
+#define __NR_mq_getsetattr	267
 
-#define __NR_syscalls		256
+#define __NR_syscalls		268
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif


