Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUDTAq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUDTAq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDTAq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:46:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44998 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261981AbUDTAqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:46:42 -0400
Date: Tue, 20 Apr 2004 01:46:39 +0100
From: Matthew Wilcox <willy@debian.org>
To: Helge Deller <deller@gmx.de>, Andi Kleen <ak@muc.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <willy@debian.org>, joe.korty@ccur.com,
       linux-kernel@vger.kernel.org, "Carlos O'Donell" <carlos@baldric.uwo.ca>
Subject: Re: Fwd: Re: siginfo & 32 bits compat, what is the story ?
Message-ID: <20040420004639.GC18329@parcelfarce.linux.theplanet.co.uk>
References: <200404200124.50594.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404200124.50594.deller@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 01:24:50AM +0200, Helge Deller wrote:
> is Andy talking about you... ?

Thanks for forwarding this to me, Helge.  No, Andi's talking about Carlos.

> ----------  Forwarded Message  ----------
> 
> Subject: Re: siginfo & 32 bits compat, what is the story ?
> Date: Tuesday 20 April 2004 00:44
> From: Andi Kleen <ak@muc.de>
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org
> 
> BTW there was a merged version from some PA-RISC person (with yet
> another rewritten siginfo copy function) discussed, but for some
> reason he dropped the ball. 

Andi, you vetoed the patch.  Don't blame Carlos for it.  That's really
petty of you.

Here's the patch that's currently sitting in the parisc tree.  Carlos may
have a better one; I know there was one sitting in the -mm tree for
a while before Andi's whinings persuaded Andrew to drop it.  I hope
someone manages to push it in over Andi's complaints this time.

diff -urpNX dontdiff linus-2.6/include/asm-generic/compat_signal.h parisc-2.6/include/asm-generic/compat_signal.h
--- linus-2.6/include/asm-generic/compat_signal.h	Wed Dec 31 17:00:00 1969
+++ parisc-2.6/include/asm-generic/compat_signal.h	Sun Feb  1 14:43:28 2004
@@ -0,0 +1,25 @@
+#ifndef _ASM_GENERIC_COMPAT_SIGNAL_H
+#define _ASM_GENERIC_COMPAT_SIGNAL_H
+
+#ifndef __ASSEMBLY__
+#include <linux/compat.h>
+
+typedef compat_uptr_t compat_sighandler_t;
+
+typedef struct compat_sigaltstack {
+	compat_uptr_t ss_sp;
+	compat_int_t ss_flags;
+	compat_size_t ss_size;
+} compat_stack_t;
+
+/* Most things should be clean enough to redefine this at will, if care
+   is taken to make libc match.  */
+
+struct compat_sigaction {
+	compat_sighandler_t sa_handler;
+	compat_uint_t sa_flags;
+	compat_sigset_t sa_mask;		/* mask last for extensibility */
+};
+
+#endif /* !__ASSEMBLY__ */
+#endif /* !_ASM_GENERIC_COMPAT_SIGNAL_H */
diff -urpNX dontdiff linus-2.6/include/asm-ia64/compat.h parisc-2.6/include/asm-ia64/compat.h
--- linus-2.6/include/asm-ia64/compat.h	Tue Mar 16 08:45:14 2004
+++ parisc-2.6/include/asm-ia64/compat.h	Tue Mar 16 08:14:45 2004
@@ -27,6 +27,7 @@ typedef u16		compat_ipc_pid_t;
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
diff -urpNX dontdiff linus-2.6/include/asm-ia64/compat_siginfo.h parisc-2.6/include/asm-ia64/compat_siginfo.h
--- linus-2.6/include/asm-ia64/compat_siginfo.h	Wed Dec 31 17:00:00 1969
+++ parisc-2.6/include/asm-ia64/compat_siginfo.h	Thu Dec 18 14:37:20 2003
@@ -0,0 +1,2 @@
+/* We use the generic compat struct */
+#include <asm-generic/compat_siginfo.h>
diff -urpNX dontdiff linus-2.6/include/linux/compat.h parisc-2.6/include/linux/compat.h
--- linus-2.6/include/linux/compat.h	Tue Mar 16 08:45:22 2004
+++ parisc-2.6/include/linux/compat.h	Tue Mar 16 08:35:29 2004
@@ -6,10 +6,16 @@
  */
 #include <linux/config.h>
 
-#ifdef CONFIG_COMPAT
+#ifndef CONFIG_COMPAT
+
+/* Non-native task requiring compat... doesn't exist */
+#define is_compat_task(x) 0
+
+#else
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
+#include <linux/personality.h>  /* Conditional process compat */
 #include <linux/sem.h>
 
 #include <asm/compat.h>
@@ -17,6 +23,11 @@
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
+/* Non-native task requiring compat */
+#ifndef HAVE_ARCH_IS_COMPAT_TASK
+#define is_compat_task(x) (personality(x->personality) == PER_LINUX32)
+#endif
+	
 struct compat_itimerspec { 
 	struct compat_timespec it_interval;
 	struct compat_timespec it_value;
diff -urpNX dontdiff linus-2.6/include/linux/compat_siginfo.h parisc-2.6/include/linux/compat_siginfo.h
--- linus-2.6/include/linux/compat_siginfo.h	Wed Dec 31 17:00:00 1969
+++ parisc-2.6/include/linux/compat_siginfo.h	Wed Feb  4 05:41:41 2004
@@ -0,0 +1,170 @@
+#ifndef _ASM_GENERIC_COMPAT_SIGINFO_H
+#define _ASM_GENERIC_COMPAT_SIGINFO_H
+
+#include <linux/config.h>
+#include <linux/compat.h>
+
+#ifndef CONFIG_COMPAT
+
+/* No compatibility layer required, add empty definitions for the compiler */
+
+typedef struct compat_siginfo{
+} compat_siginfo_t;
+
+static inline int compat_copy_siginfo_to_user(compat_siginfo_t __user *to, 
+						struct siginfo *from)
+{
+	return -1;
+}
+
+#else
+
+#include <linux/compiler.h>
+#include <asm/siginfo.h>
+
+/* compat view of sigval_t */
+typedef union compat_sigval {
+	compat_int_t sival_int;
+	compat_uptr_t sival_ptr;
+} compat_sigval_t;
+
+/*
+ * This is the size (including padding) of the part of the
+ * struct siginfo that is before the union.
+ */
+#ifndef __ARCH_SI_COMPAT_PREAMBLE_SIZE
+#define __ARCH_SI_COMPAT_PREAMBLE_SIZE	(3 * sizeof(int))
+#endif
+
+#define SI_COMPAT_MAX_SIZE	128
+#ifndef SI_COMPAT_PAD_SIZE
+#define SI_COMPAT_PAD_SIZE	((SI_COMPAT_MAX_SIZE - __ARCH_SI_COMPAT_PREAMBLE_SIZE) / sizeof(int))
+#endif
+
+/* 32-bit view of si.uid_t */
+#ifndef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T compat_uid_t
+#endif
+
+/* 32-bit view of si.band_t */
+#ifndef __ARCH_SI_COMPAT_BAND_T
+#define __ARCH_SI_COMPAT_BAND_T compat_int_t
+#endif
+
+#ifndef HAVE_ARCH_COMPAT_SIGINFO_T
+
+/* Compat view of siginfo_t */
+typedef struct compat_siginfo {
+	compat_int_t si_signo;
+	compat_int_t si_errno;
+	compat_int_t si_code;
+
+	union {
+		compat_int_t _pad[SI_COMPAT_PAD_SIZE];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;	/* sender's pid */
+			__ARCH_SI_COMPAT_UID_T _uid;	/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			compat_timer_t _tid;	/* timer id */
+			compat_int_t _overrun;		/* overrun count */
+			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
+			compat_sigval_t _sigval;	/* same as below */
+			compat_int_t _sys_private;       /* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;		/* sender's pid */
+			__ARCH_SI_COMPAT_UID_T _uid;	/* sender's uid */
+			compat_sigval_t _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;		/* which child */
+			__ARCH_SI_COMPAT_UID_T _uid;	/* sender's uid */
+			compat_int_t _status;		/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		struct {
+			compat_uptr_t _addr; /* faulting insn/memory ref. */
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+			compat_int_t _trapno;	/* TRAP # which caused the signal */
+#endif
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			__ARCH_SI_COMPAT_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			compat_int_t _fd;
+		} _sigpoll;
+	} _sifields;
+} compat_siginfo_t;
+#endif /* !HAVE_ARCH_COMPAT_SIGINFO_T */
+
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+#define si_trapno	_sifields._sigfault._trapno
+#endif
+
+/*
+ * sigevent definitions
+ * 
+ * It seems likely that SIGEV_THREAD will have to be handled from 
+ * userspace, libpthread transmuting it to SIGEV_SIGNAL, which the
+ * thread manager then catches and does the appropriate nonsense.
+ * However, everything is written out here so as to not get lost.
+ */
+
+#define SIGEV_COMPAT_MAX_SIZE	64
+#ifndef SIGEV_COMPAT_PAD_SIZE
+#define SIGEV_COMPAT_PAD_SIZE	((SIGEV_COMPAT_MAX_SIZE/sizeof(int)) - 3)
+#endif
+
+#ifndef HAVE_ARCH_COMPAT_SIGEVENT_T
+
+/* 32-bit view of sigevent_t */
+typedef struct compat_sigevent {
+	compat_sigval_t sigev_value;
+	compat_int_t sigev_signo;
+	compat_int_t sigev_notify;
+	union {
+		compat_int_t _pad[SIGEV_COMPAT_PAD_SIZE];
+		compat_int_t _tid;
+
+		struct {
+			compat_uptr_t _function;
+			compat_uptr_t _attribute;	/* really pthread_attr_t */
+		} _sigev_thread;
+	} _sigev_un;
+} compat_sigevent_t;
+
+#endif /* HAVE_ARCH_COMPAT_SIGEVENT_T */
+
+#ifndef HAVE_ARCH_COMPAT_COPY_SIGINFO
+
+#include <linux/string.h>
+
+static inline void compat_copy_siginfo(struct compat_siginfo *to, struct compat_siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, __ARCH_SI_COMPAT_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
+}
+
+#endif /* !HAVE_ARCH_COMPAT_COPY_SIGINFO */
+
+extern int compat_copy_siginfo_to_user(compat_siginfo_t __user *to, struct siginfo *from);
+
+#endif /* CONFIG_COMPAT */
+#endif /* _ASM_GENERIC_COMPAT_SIGINFO_H */
+
diff -urpNX dontdiff linus-2.6/kernel/compat_signal.c parisc-2.6/kernel/compat_signal.c
--- linus-2.6/kernel/compat_signal.c	Wed Dec 31 17:00:00 1969
+++ parisc-2.6/kernel/compat_signal.c	Sun Feb  1 14:43:33 2004
@@ -0,0 +1,124 @@
+/*
+ *  Copyright (C) 2003 Carlos O'Donell
+ * 
+ *  2003-12-20  Carlos O'Donell
+ *              Copied linux/kernel/compat_signal.c (copy_siginfo_to_user)
+ *              and modified to use compat_siginfo_t for thunking down to
+ *              32-bit userspace from a 64-bit kernel.
+ *              
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
+ *
+ */
+
+#include <linux/compat_siginfo.h>
+#include <asm/errno.h>
+#include <asm/uaccess.h>
+#include <asm/siginfo.h>
+
+#ifndef HAVE_ARCH_COMPAT_COPY_SIGINFO_TO_USER
+
+int compat_copy_siginfo_to_user(compat_siginfo_t __user *to, siginfo_t *from)
+{
+	int err;
+	compat_siginfo_t compat_from;	
+
+	if (!access_ok (VERIFY_WRITE, to, sizeof(compat_siginfo_t)))
+		return -EFAULT;
+	
+	/*
+	 * If you change compat_siginfo_t structure *or* siginfo_t, 
+	 * please be sure this code is fixed accordingly.
+	 * It should never copy any pad contained in the structure
+	 * to avoid security leaks, but must copy the generic
+	 * 3 ints plus the relevant union member.
+	 */
+
+	/* Convert structure, don't leak anything in the copy */
+	memset(&compat_from,'\0',sizeof(compat_siginfo_t));
+	compat_from.si_signo = (compat_int_t)(from->si_signo);
+	compat_from.si_errno = (compat_int_t)(from->si_errno);
+	compat_from.si_code = (compat_int_t)(from->si_code);
+	
+	if (from->si_code < 0)
+		return __copy_to_user(to, &compat_from, sizeof(compat_siginfo_t))
+			? -EFAULT : 0;
+	
+	err = __put_user(compat_from.si_signo, &to->si_signo);
+	err |= __put_user(compat_from.si_errno, &to->si_errno);
+	err |= __put_user(compat_from.si_code, &to->si_code);
+	
+	switch (from->si_code & __SI_MASK) {
+	case __SI_KILL:
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		break;
+	case __SI_TIMER:
+		compat_from.si_pid = (compat_timer_t)(from->si_tid);
+		compat_from.si_overrun = (compat_int_t)(from->si_overrun);
+		compat_from.si_ptr = (compat_uptr_t)((u64)(from->si_ptr) & 0xffffffffUL);
+		err |= __put_user(compat_from.si_tid, &to->si_tid);
+		err |= __put_user(compat_from.si_overrun, &to->si_overrun);
+		err |= __put_user(compat_from.si_ptr, &to->si_ptr);
+		break;
+	case __SI_POLL:
+		compat_from.si_band = (__ARCH_SI_COMPAT_BAND_T)(from->si_band);
+		compat_from.si_fd = (compat_int_t)(from->si_fd);
+		err |= __put_user(compat_from.si_band, &to->si_band);
+		err |= __put_user(compat_from.si_fd, &to->si_fd);
+		break;
+	case __SI_FAULT:
+		compat_from.si_addr = (compat_uptr_t)((u64)(from->si_addr) & 0xffffffffUL);
+		err |= __put_user(compat_from.si_addr, &to->si_addr);
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+		compat_from.si_trapno = (compat_int_t)(from->si_addr);
+		err |= __put_user(compat_from.si_trapno, &to->si_trapno);
+#endif
+		break;
+	case __SI_CHLD:
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		compat_from.si_status = (compat_int_t)(from->si_status);
+		compat_from.si_utime = (compat_clock_t)(from->si_utime);
+		compat_from.si_stime = (compat_clock_t)(from->si_stime);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		err |= __put_user(compat_from.si_status, &to->si_status);
+		err |= __put_user(compat_from.si_utime, &to->si_utime);
+		err |= __put_user(compat_from.si_stime, &to->si_stime);
+		break;
+	case __SI_RT: /* This is not generated by the kernel as of now. */
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		compat_from.si_int = (compat_int_t)(from->si_int);
+		compat_from.si_ptr = (compat_uptr_t)((u64)(from->si_ptr) & 0xffffffffUL);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		err |= __put_user(compat_from.si_int, &to->si_int);
+		err |= __put_user(compat_from.si_ptr, &to->si_ptr);
+		break;
+	default: /* this is just in case for now ... */
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		err |= __put_user(compat_from.si_pid, &to->si_pid);
+		err |= __put_user(compat_from.si_uid, &to->si_uid);
+		break;
+	}
+	return err;
+}
+
+#endif
diff -urpNX dontdiff linus-2.6/kernel/signal.c parisc-2.6/kernel/signal.c
--- linus-2.6/kernel/signal.c	Tue Mar 16 08:45:28 2004
+++ parisc-2.6/kernel/signal.c	Tue Mar 16 08:15:00 2004
@@ -21,6 +21,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/compat_siginfo.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -2009,6 +2010,12 @@ int copy_siginfo_to_user(siginfo_t __use
 	if (from->si_code < 0)
 		return __copy_to_user(to, from, sizeof(siginfo_t))
 			? -EFAULT : 0;
+	
+	/* Use compat_siginfo_t with 32-bit signals */
+	if(is_compat_task(current)){
+		return compat_copy_siginfo_to_user((compat_siginfo_t __user *)to,from);
+	}
+	
 	/*
 	 * If you change siginfo_t structure, please be sure
 	 * this code is fixed accordingly.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
