Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTLKAYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 19:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTLKAYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 19:24:55 -0500
Received: from baldric.uwo.ca ([129.100.10.225]:21267 "EHLO baldric")
	by vger.kernel.org with ESMTP id S264231AbTLKAYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 19:24:41 -0500
Date: Wed, 10 Dec 2003 19:17:56 -0500
From: "Carlos O'Donell" <carlos@baldric.uwo.ca>
To: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: [RFC] Compat siginfo_t for 64-bit kernels running 32-bit userspace.
Message-ID: <20031211001755.GC15502@systemhalted>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Useless-Header: listen, love, accept, mindfullness, patience, and humility. 
X-Mailer: Neural Implant (42% Sync Ratio [====......])
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----------------------------------------------------------
	Signal structures, their sizes, 
	and a generic compatibility
	layer for copying siginfo_t into
	userspace.
-----------------------------------------------------------

Abstract.
=========

When the Linux kernel has word widths that are different from userspace, 
certain operations require conversions. In particular we examine signals 
and their associated data structures. Proposed is an initial framework 
for copying siginfo_t, in a generic fashion, to a userspace address.

It is the hope of the author to raise awareness, get feedback, and see 
if anyone else is thinking about similar changes.

Comments welcome, flames welcome :)

Introduction.
=============

I recently cleaned up parisc's signal frame code to account for running 
a 64-bit kernel and a 32-bit userspace. James Bottomley was kind enough 
to do the initial work and prompt me to cleanup the really ugly stuff. 
Matthew Wilcox said "I'm not tall enough to play with signals, email 
XXXXXXXX, it's the right place."

The process of cleanup wasn't very hard, but my colleagues, noticing I
had started work on something that was long left untouched, began 
poking me in other directions. Apparently siginfo_t, ucontext_t, stack_t 
and various other structures were not being read properly from userspace 
signal handlers. The signal handler is passed both a siginfo_t and a
ucontext_t (for *context() function calls) from the kernel.

What I did, and what I always do, was to attempt to copy sparc64 :}
Unfortunately they had rolled their own support for this, as had ppc64
and many other arches.

I began with something simple. Many arches use the generic siginfo_t, 
and providing compat would initially simplify the parisc work.

Generic Changes:
================

o Add a generic 'compat_copy_siginfo_to_user' (kernel/compat_signal.c)
o Add a generic siginfo_t (include/asm-generic/compat_siginfo.h)
o Add generic signal structures (include/asm-generic/compat_signal.h)

The current generic kernel/signal.c has the ability to use a per-arch 
copy_siginfo_to_user function. This function could in general convert the 
kernels view of siginfo into the userspace required size. 

e.g.

	* kernel/signal.c (copy_siginfo_to_user):

#ifndef HAVE_ARCH_COPY_SIGINFO_TO_USER
copy_siginfo_to_user
{
	...
	check thread personality
	if the thread is PER_LINUX32
		return compat_copy_siginfo_to_user
	else
		Do it the normal way.
	...
}
#endif

Cases covered:
- Kernel native, process native.
- Kernel native, process non-native 32-bit.

Pro:
- Generic. Don't have to add special arch code.

Con:
- Extra branch/function in signal delivery fast path.

Thoughts:
- Arches that need speed can and will rewrite their signal path
  direclty from the syscall layer. However, they can still make
  use of the generic structures and functions. Normally in parisc
  we make such code disappear with the use of the __LP64__ macro,
  can this be done generically? Aside from that just define
  ARCH_HAVE_COPY_SIGINFO_TO_USER and do what you will.

- The meaning of PER_LINUX32 must be clear. The process is 
  non-native and 32-bit.

- When do the 128-bit processors running compat 64-bit 
  userspace arrive? (PER_LINUX64)

Arch Changes:
=============

o include/asm-parisc/

	compat_rt_sigframe.h (Arch dependant rt signal frame)
	compat_siginfo.h -> #include <asm-generic/compat_siginfo.h>
	compat_signal.h -> #include <asm-generic/signal.h>
	compat_ucontext.h (Arch dependant, passed to signal handlers)
	compat.h (Arch dependant mcontext_t)

o arch/parisc/kernel/signal.c

	Check personality on frame setup path, call code in
	arch/parisc/kernel/signal32.c to setup and restore 32-bit signal
	contexts (ucontext_t), along with calling the kernels
	compat_copy_siginfo_to_user to get the job done.

	Removed old and crufty arch specific copy_siginfo_to_user.

Defining a compat signal frame is not an easy task and requires 
converting all the structure elements into compat types.
A number of arches including parisc use the generic siginfo_t and
benefit immediately from a generic version.

I was *tempted* by trying to define a generic ucontext_t since *most* 
arches use exactly the same setup. However, the subsequent header 
untangling left me unable to do it cleanly. Had I the will It might 
be possible, subsequent to that a generic copy_ucontext_to_user could 
be written, since it's a similar operation to copying the siginfo.

Thoughts:

I ran into a structure padding problem. There is no real ELF32 ABI for 
parisc and I had to pad the compat_ucontext structure. This type of 
massaging might be required for any arch in order to get structures to 
match. In this case the generic functions are usable, but the generic
structures are not.

What's left todo:
=================

Inform other architectures that the framework is in place and let them
cleanup their arch code. Most arches are using the generic siginfo_t and
will thus benefit. I'm tempted to port another arch to show how it works
for two arches.

I keep thinking there has to be a way to do compat, signal handling, and
compat signal handling in some easier way.

What's been done:
=================

Please remember this is an RFC, and a first cut at the code, there might
be mistakes, and I'm sure someone won't like it :}

I've moved parisc over to the new setup, removed our custom
copy_siginfo_to_user. parisc distinguishes between native and non-native
processes during the rt frame setup and restore phases and then branches
into the compat path.

Diff is generated against -rlinus cvs.parisc-linux.org so it applies to 2.6.

---
 include/asm-generic/compat_siginfo.h |  154 +++++++++++++++++++++++++
 include/asm-generic/compat_signal.h  |   28 ++++
 kernel/compat_signal.c               |  126 ++++++++++++++++++++
 kernel/signal.c                      |    8 +
 4 files changed, 316 insertions(+)
---

2003-12-08  Carlos O'Donell  <carlos@baldric.uwo.ca>

	* kernel/signal.c (copy_siginfo_to_user): If process is
	PER_LINUX32 call compat_copy_siginfo_to_user.
	* kernel/compat_signal.c: New file.
	* include/asm-generic/compat_siginfo.h: New file.
	* include/asm-generic/compat_signal.h: New file.

--- kernel/signal.c	24 Nov 2003 03:16:26 -0000	1.8
+++ kernel/signal.c	10 Dec 2003 22:28:47 -0000
@@ -24,9 +24,11 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/personality.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
+#include <asm/compat_siginfo.h>
 
 /*
  * SLAB caches for signal bits.
@@ -2006,6 +2008,12 @@ int copy_siginfo_to_user(siginfo_t __use
 	if (from->si_code < 0)
 		return __copy_to_user(to, from, sizeof(siginfo_t))
 			? -EFAULT : 0;
+
+	/* Use compat_siginfo_t with 32-bit signals */
+	if(personality(current->personality) == PER_LINUX32){
+		return compat_copy_siginfo_to_user((compat_siginfo_t __user *)to,from);
+	}
+	
 	/*
 	 * If you change siginfo_t structure, please be sure
 	 * this code is fixed accordingly.
--- kernel/compat_signal.c.orig	1969-12-31 19:00:00.000000000 -0500
+++ kernel/compat_signal.c	2003-12-02 23:18:13.000000000 -0500
@@ -0,0 +1,126 @@
+/*
+ *  Copyright (C) 2003 Carlos O'Donell
+ * 
+ *  2003-12-20  Carlos O'Donell
+ *              Copied linux/kernel/compat_signal.c (copy_siginfo_to_user)
+ *              and modified to use compat_siginfo_t for thunking down to
+ *              32-bit userspace with an ELF64 kernel.
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
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*#define __KERNEL_SYSCALLS__*/
+
+#include <asm/errno.h>
+#include <asm/compat_siginfo.h>
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
+	 * If you change siginfo_t structure, please be sure
+	 * this code is fixed accordingly.
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
+#ifdef __ARCH_SI_TRAPNO
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
--- include/asm-generic/compat_siginfo.h.orig	1969-12-31 19:00:00.000000000 -0500
+++ include/asm-generic/compat_siginfo.h	2003-11-28 07:49:19.000000000 -0500
@@ -0,0 +1,154 @@
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/compat.h>
+
+#ifndef _ASM_GENERIC_COMPAT_SIGINFO_H
+#define _ASM_GENERIC_COMPAT_SIGINFO_H
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
+/* ELF32 view of si.uid_t */
+#ifndef __ARCH_SI_COMPAT_UID_T
+#define __ARCH_SI_COMPAT_UID_T compat_uid_t
+#endif
+
+/* ELF32 view of si.band_t */
+#ifndef __ARCH_SI_COMPAT_BAND_T
+#define __ARCH_SI_COMPAT_BAND_T compat_int_t
+#endif
+
+#ifndef HAVE_ARCH_COMPAT_SIGINFO_T
+
+/* Compat (ELF32) view of siginfo_t */
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
+#ifdef __ARCH_SI_TRAPNO
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
+/* ELF32 view of sigevent_t */
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
+#endif
+
+#ifdef __KERNEL__
+
+struct compat_siginfo;
+/*void do_schedule_next_timer(struct siginfo *info);*/
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
+#endif
+
+extern int compat_copy_siginfo_to_user(compat_siginfo_t __user *to, struct siginfo *from);
+
+#endif /* __KERNEL__ */
+
+#endif
--- include/asm-generic/compat_signal.h.orig	1969-12-31 19:00:00.000000000 -0500
+++ include/asm-generic/compat_signal.h	2003-12-02 23:01:44.000000000 -0500
@@ -0,0 +1,28 @@
+#ifndef _ASM_GENERIC_COMPAT_SIGNAL_H
+#define _ASM_GENERIC_COMPAT_SIGNAL_H
+
+# ifndef __ASSEMBLY__
+#  include <linux/types.h>
+
+typedef compat_uptr_t compat_sighandler_t;
+
+typedef struct compat_sigaltstack {
+	compat_uptr_t ss_sp;
+	compat_int_t ss_flags;
+	compat_size_t ss_size;
+} compat_stack_t;
+
+#  ifdef __KERNEL__
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
+#  endif /* __KERNEL__ */
+# endif /* !__ASSEMBLY */
+#endif /* _ASM_GENERIC_COMPAT_SIGNAL_H */

----- End forwarded message -----
