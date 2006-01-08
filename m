Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWAHTiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWAHTiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWAHTiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:38:05 -0500
Received: from cabal.ca ([134.117.69.58]:58806 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1161123AbWAHTiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:38:01 -0500
Date: Sun, 8 Jan 2006 14:37:55 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org,
       carlos@parisc-linux.org, willy@parisc-linux.org
Subject: [PATCH 1/5] Add generic compat_siginfo_t
Message-ID: <20060108193755.GH3782@tachyon.int.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos O'Donell <carlos@parisc-linux.org>

Almost all the linux arches have exactly the same definition
for many of the compat structures. In almost all situations the
compiler can generate code to copy element by element. This
element by element copy is generic enough that it can be 
used in asm-generic. It is generic enough that it can already
be used by many architectures.

This patch creates an is_compat_task macro to check if
the process personality is native and thus allows various
routines to call either a compat copy or a regular copy.
Since is_compat_task evaluates to zero in the non-compat
case the compiler removes the code.

The patch centralizes the signal compat structures into
include/linux/compat_siginfo.h, and creates kernel/compat_signal.c
to place all the generic copy routines for signal related compat.
Code that requires signal compat structures can include them if 
needed.

HAVE_* macros are provided for arches to override the current
macro definitions. This gives arch maintainers the flexibility
of special case processing.

By making compat code more generic we reduce the number 
of arch specific bugs and allow kernel maintainers to 
provide generic tested compat versions of various routines.
While still allowing arch maintainers the ability to override
them with custom fixes.

Signed-off-by: Carlos O'Donell <carlos@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

Andrew,

Please incorporate this patch series in -mm.

This is the last major piece of divergence from the parisc-linux tree. All
parisc64 machines require this change to be usable from mainline, so this
is quite an important series if we ever want to be fully functional from
mainline. I believe there's now sufficient ability for architectures to
override functionality that all previous objections to these changes have
been addressed.

Arch maintainers will likely want to redefine is_compat_task() to
inspect a more correct personality.

 include/asm-generic/compat_signal.h |   25 +++
 include/linux/compat.h              |   39 ++---
 include/linux/compat_siginfo.h      |  182 +++++++++++++++++++++++
 include/linux/signal.h              |    3 
 ipc/compat_mq.c                     |    1 
 kernel/Makefile                     |    2 
 kernel/compat.c                     |   47 ++++++
 kernel/compat_signal.c              |  280 +++++++++++++++++++++++++++++++++++
 kernel/ptrace.c                     |    2 
 kernel/signal.c                     |   21 +++
 10 files changed, 570 insertions(+), 32 deletions(-)
 create mode 100644 include/asm-generic/compat_signal.h
 create mode 100644 include/linux/compat_siginfo.h
 create mode 100644 kernel/compat_signal.c

a0019dc539d22a19c39dcb18e636fbeadfcec759
diff --git a/include/asm-generic/compat_signal.h b/include/asm-generic/compat_signal.h
new file mode 100644
index 0000000..889d57f
--- /dev/null
+++ b/include/asm-generic/compat_signal.h
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
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f9ca534..1638fff 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
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
@@ -18,6 +24,11 @@
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
+/* Non-native task requiring compat */
+#ifndef HAVE_ARCH_IS_COMPAT_TASK
+#define is_compat_task(x) (personality(x->personality) == PER_LINUX32)
+#endif
+
 typedef __compat_uid32_t	compat_uid_t;
 typedef __compat_gid32_t	compat_gid_t;
 
@@ -99,28 +110,6 @@ struct compat_dirent {
 	char		d_name[256];
 };
 
-typedef union compat_sigval {
-	compat_int_t	sival_int;
-	compat_uptr_t	sival_ptr;
-} compat_sigval_t;
-
-#define COMPAT_SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 3)
-
-typedef struct compat_sigevent {
-	compat_sigval_t sigev_value;
-	compat_int_t sigev_signo;
-	compat_int_t sigev_notify;
-	union {
-		compat_int_t _pad[COMPAT_SIGEV_PAD_SIZE];
-		compat_int_t _tid;
-
-		struct {
-			compat_uptr_t _function;
-			compat_uptr_t _attribute;
-		} _sigev_thread;
-	} _sigev_un;
-} compat_sigevent_t;
-
 
 long compat_sys_semctl(int first, int second, int third, void __user *uptr);
 long compat_sys_msgsnd(int first, int second, int third, void __user *uptr);
@@ -156,10 +145,6 @@ long compat_get_bitmap(unsigned long *ma
 		       unsigned long bitmap_size);
 long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size);
-int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from);
-int copy_siginfo_to_user32(struct compat_siginfo __user *to, siginfo_t *from);
-int get_compat_sigevent(struct sigevent *event,
-		const struct compat_sigevent __user *u_event);
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/include/linux/compat_siginfo.h b/include/linux/compat_siginfo.h
new file mode 100644
index 0000000..38124cf
--- /dev/null
+++ b/include/linux/compat_siginfo.h
@@ -0,0 +1,182 @@
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
+static inline int compat_copy_siginfo_from_user(struct siginfo *to,
+                                                compat_siginfo_t __user *from)
+{
+        return -1;
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
+#define __ARCH_SI_COMPAT_PREAMBLE_SIZE	(3 * sizeof(compat_int_t))
+#endif
+
+#define SI_COMPAT_MAX_SIZE	128
+#ifndef SI_COMPAT_PAD_SIZE
+#define SI_COMPAT_PAD_SIZE \
+  ((SI_COMPAT_MAX_SIZE - __ARCH_SI_COMPAT_PREAMBLE_SIZE) / sizeof(compat_int_t))
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
+			char _pad[sizeof(__ARCH_SI_COMPAT_UID_T) - sizeof(compat_int_t)];
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
+#ifndef __ARCH_SIGEV_COMPAT_PREAMBLE_SIZE
+#define __ARCH_SIGEV_COMPAT_PREAMBLE_SIZE (sizeof(compat_int_t) * 2 + sizeof(compat_sigval_t))
+#endif
+
+#define COMPAT_SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 3)
+
+#ifndef HAVE_ARCH_COMPAT_SIGEVENT_T
+
+/* 32-bit view of sigevent_t */
+typedef struct compat_sigevent {
+	compat_sigval_t sigev_value;
+	compat_int_t sigev_signo;
+	compat_int_t sigev_notify;
+	union {
+		compat_int_t _pad[COMPAT_SIGEV_PAD_SIZE];
+		compat_int_t _tid;
+
+		struct {
+			compat_uptr_t _function;
+			compat_uptr_t _attribute;  /* really pthread_attr_t */
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
+extern int compat_copy_siginfo_from_user(struct siginfo *to, compat_siginfo_t __user *from);
+
+extern int compat_copy_sigevent_from_user(struct sigevent *to, compat_sigevent_t __user *from);
+extern int compat_copy_sigevent_to_user(compat_sigevent_t __user *to, struct sigevent *from);
+
+#endif /* CONFIG_COMPAT */
+#endif /* _ASM_GENERIC_COMPAT_SIGINFO_H */
+
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 5dd5f02..2127cc1 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -233,6 +233,9 @@ extern int sigprocmask(int, sigset_t *, 
 struct pt_regs;
 extern int get_signal_to_deliver(siginfo_t *info, struct k_sigaction *return_ka, struct pt_regs *regs, void *cookie);
 
+int copy_siginfo_from_user(siginfo_t *to, siginfo_t __user *from);
+int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SIGNAL_H */
diff --git a/ipc/compat_mq.c b/ipc/compat_mq.c
index d8d1e9f..41572f3 100644
--- a/ipc/compat_mq.c
+++ b/ipc/compat_mq.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/compat.h>
+#include <linux/compat_siginfo.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/mqueue.h>
diff --git a/kernel/Makefile b/kernel/Makefile
index 4f5a145..cf7357d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
-obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_COMPAT) += compat.o compat_signal.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
diff --git a/kernel/compat.c b/kernel/compat.c
index 102296e..862f821 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -13,6 +13,7 @@
 
 #include <linux/linkage.h>
 #include <linux/compat.h>
+#include <linux/compat_siginfo.h>
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/signal.h>
@@ -439,7 +440,11 @@ asmlinkage long compat_sys_waitid(int wh
 
 	BUG_ON(info.si_code & __SI_MASK);
 	info.si_code |= __SI_CHLD;
-	return copy_siginfo_to_user32(uinfo, &info);
+	
+	if (compat_copy_siginfo_to_user(uinfo, &info) != 0)
+		return -EFAULT;
+
+	return 0;
 }
 
 static int compat_get_user_cpu_mask(compat_ulong_t __user *user_mask_ptr,
@@ -651,6 +656,44 @@ int get_compat_sigevent(struct sigevent 
 
 /* timer_create is architecture specific because it needs sigevent conversion */
 
+long compat_sys_timer_create(clockid_t which_clock,
+			     compat_sigevent_t __user *timer_event_spec,
+			     compat_timer_t __user * created_timer_id)
+{
+	sigevent_t kevent;
+	timer_t ktimer;
+	mm_segment_t old_fs = get_fs();
+	long ret;
+
+	/* sigevent_t needs handling for 32-bit to 64-bit compat */
+	if (timer_event_spec != NULL)
+		if (compat_copy_sigevent_from_user(&kevent, timer_event_spec) != 0)
+			return -EFAULT;
+	
+	/* Timer ID is assumed to be a non-struct simple value */
+	if (created_timer_id != NULL)
+		if (__get_user(ktimer, created_timer_id) != 0)
+		  	return -EFAULT;
+
+	set_fs(KERNEL_DS);
+	ret = sys_timer_create(which_clock, 
+	    			timer_event_spec ? (sigevent_t __user *)&kevent : NULL, 
+	    			created_timer_id ? (timer_t __user *)&ktimer : NULL);
+	set_fs(old_fs);
+	
+	/* Copy back the results to userspace */
+	if (timer_event_spec != NULL)
+	  	if (compat_copy_sigevent_to_user(timer_event_spec, &kevent) != 0)
+			return -EFAULT;
+
+	if (created_timer_id != NULL)
+	  	if (__put_user(ktimer, created_timer_id) != 0)
+		  	return -EFAULT;
+	
+	return ret;
+}
+
+
 long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
 		       unsigned long bitmap_size)
 {
@@ -807,7 +850,7 @@ compat_sys_rt_sigtimedwait (compat_sigse
 	if (sig) {
 		ret = sig;
 		if (uinfo) {
-			if (copy_siginfo_to_user32(uinfo, &info))
+			if (compat_copy_siginfo_to_user(uinfo, &info))
 				ret = -EFAULT;
 		}
 	}else {
diff --git a/kernel/compat_signal.c b/kernel/compat_signal.c
new file mode 100644
index 0000000..20b6f00
--- /dev/null
+++ b/kernel/compat_signal.c
@@ -0,0 +1,280 @@
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
+
+        /* Always copy si_signo, si_errno, and si_code */
+	compat_from.si_signo = (compat_int_t)(from->si_signo);
+	compat_from.si_errno = (compat_int_t)(from->si_errno);
+	/* si_code is only a (short) value, remove kernel bits. */
+	compat_from.si_code = (short)(from->si_code);
+        
+	err = __put_user(compat_from.si_signo, &to->si_signo);
+	err |= __put_user(compat_from.si_errno, &to->si_errno);
+	err |= __put_user(compat_from.si_code, &to->si_code);
+
+        /* siginfo_t came from userspace, so it is the right
+         * size, no need for conversion
+         */        
+	if (from->si_code < 0) {
+		return __copy_to_user(&to->_sifields._pad, 
+                                      &from->_sifields._pad, 
+                                      SI_COMPAT_PAD_SIZE)
+			? -EFAULT : 0;
+        }
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
+		compat_from.si_ptr = (compat_uptr_t)((u64 __force)(from->si_ptr) & 0xffffffffUL);
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
+		compat_from.si_addr = (compat_uptr_t)((u64 __force)(from->si_addr) & 0xffffffffUL);
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
+	case __SI_MESGQ: /* But this is */
+		compat_from.si_pid = (compat_pid_t)(from->si_pid);
+		compat_from.si_uid = (__ARCH_SI_COMPAT_UID_T)(from->si_uid);
+		compat_from.si_int = (compat_int_t)(from->si_int);
+		compat_from.si_ptr = (compat_uptr_t)((u64 __force)(from->si_ptr) & 0xffffffffUL);
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
+#endif
+
+#ifndef HAVE_ARCH_COPY_SIGINFO_FROM_USER
+int compat_copy_siginfo_from_user(siginfo_t *to, compat_siginfo_t __user *from)
+{
+	int err;
+        u64 scratch;
+
+	if (!access_ok (VERIFY_READ, from, sizeof(compat_siginfo_t)))
+		return -EFAULT;
+	
+	/*
+	 * If you change compat_siginfo_t structure *or* siginfo_t, 
+	 * please be sure this code is fixed accordingly.
+	 */
+
+        /* Always copy si_signo, si_errno, and si_code */
+	err = __get_user(to->si_signo, &from->si_signo);
+	err |= __get_user(to->si_errno, &from->si_errno);
+	err |= __get_user(to->si_code, &from->si_code);
+        
+        /* siginfo_t came from userspace, so it is the right
+         * size, no need for conversion
+         */        
+	if (to->si_code < 0) {
+		return __copy_from_user(&to->_sifields._pad, 
+                                        &from->_sifields._pad, 
+                                        SI_COMPAT_PAD_SIZE)
+			? -EFAULT : 0;
+        }
+	
+	switch (to->si_code & __SI_MASK) {
+	case __SI_KILL:
+		err |= __get_user(to->si_pid, &from->si_pid);
+		err |= __get_user(to->si_uid, &from->si_uid);
+		break;
+	case __SI_TIMER:
+		err |= __get_user(to->si_tid, &from->si_tid);
+		err |= __get_user(to->si_overrun, &from->si_overrun);
+		err |= __get_user(scratch, &from->si_ptr);
+                to->si_ptr = (u64 __user*)scratch;                
+		break;
+	case __SI_POLL:
+		err |= __get_user(to->si_band, &from->si_band);
+		err |= __get_user(to->si_fd, &from->si_fd);
+		break;
+	case __SI_FAULT:
+		err |= __get_user(scratch, &from->si_addr);
+                to->si_addr = (u64 __user*)scratch;
+#ifdef __ARCH_SI_COMPAT_TRAPNO
+		err |= __get_user(to->si_trapno, &from->si_trapno);
+#endif
+		break;
+	case __SI_CHLD:
+		err |= __get_user(to->si_pid, &from->si_pid);
+		err |= __get_user(to->si_uid, &from->si_uid);
+		err |= __get_user(to->si_status, &from->si_status);
+		err |= __get_user(to->si_utime, &from->si_utime);
+		err |= __get_user(to->si_stime, &from->si_stime);
+		break;
+	case __SI_RT: /* This is not generated by the kernel as of now. */
+	case __SI_MESGQ: /* But this is */
+		err |= __get_user(to->si_pid, &from->si_pid);
+		err |= __get_user(to->si_uid, &from->si_uid);
+		err |= __get_user(to->si_int, &from->si_int);
+		err |= __get_user(scratch, &from->si_ptr);
+                to->si_ptr = (u64 __user*)scratch;
+		break;
+	default: /* this is just in case for now ... */
+		err |= __get_user(to->si_pid, &from->si_pid);
+		err |= __get_user(to->si_uid, &from->si_uid);
+		break;
+	}
+	return err;
+}
+#endif
+
+#ifndef HAVE_ARCH_COPY_SIGEVENT_FROM_USER
+int compat_copy_sigevent_from_user(sigevent_t *to, compat_sigevent_t __user *from)
+{
+	int err;
+	u64 scratch;
+	
+	/* copy sigval_t sigev_value 
+	 	int_t sival_int		(same)
+	 	uptr_t sival_ptr	(32 vs 64)*/
+	err = __get_user(to->sigev_value.sival_int, 
+	    		 &from->sigev_value.sival_int);
+	err |= __get_user(scratch, &from->sigev_value.sival_ptr);
+	to->sigev_value.sival_ptr = (u64 __user *)scratch;
+	
+	/* copy int_t sigev_signo 	(same)*/
+	err |= __get_user(to->sigev_signo, &from->sigev_signo);
+	
+	/* copy int_t sigev_notify	(same)*/
+	err |= __get_user(to->sigev_notify, &from->sigev_notify);
+
+	/* never copy _sigev_un padding */
+
+	/* copy int_t _tid 		(same),
+	   good_sigevent() uses this value of */
+	err |= __get_user(to->sigev_notify_thread_id, &from->sigev_notify_thread_id);
+	
+	/* XXX: Do not copy these, they aren't used by
+	   anyone. We would need to distinguish the uses of the union.
+	   copy _sigev_thread
+	  	uptr_t _function	(32 vs 64)
+	  	uptr_t _attribute	(32 vs 64)*/
+	
+	return err;
+}
+#endif
+
+#ifndef HAVE_ARCH_COPY_SIGEVENT_TO_USER
+int compat_copy_sigevent_to_user(compat_sigevent_t __user *to, sigevent_t *from)
+{
+	int err;
+	u32 scratch;
+	
+	/* copy sigval_t sigev_value 
+	 	int_t sival_int		(same)
+	 	uptr_t sival_ptr	(32 vs 64)*/
+	err = __put_user(from->sigev_value.sival_int, 
+	    		 &to->sigev_value.sival_int);
+	scratch = (u32)((u64 __force)from->sigev_value.sival_ptr & 0xffffffffUL);
+	err |= __put_user((compat_uptr_t)scratch, &to->sigev_value.sival_ptr);
+	
+	/* copy int_t sigev_signo 	(same)*/
+	err |= __put_user(from->sigev_signo, &to->sigev_signo);
+	
+	/* copy int_t sigev_notify	(same)*/
+	err |= __put_user(from->sigev_notify, &to->sigev_notify);
+
+	/* never copy _sigev_un padding */
+
+	/* copy int_t _tid 		(same),
+	   good_sigevent() uses this value of */
+	err |= __put_user(from->sigev_notify_thread_id, &to->sigev_notify_thread_id);
+	
+	/* XXX: Do not copy these, they aren't used by
+	   anyone. We would need to distinguish the uses of the union.
+	   copy _sigev_thread
+	  	uptr_t _function	(32 vs 64)
+	  	uptr_t _attribute	(32 vs 64)*/
+	
+	return err;
+}
+#endif
+
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 656476e..298ca08 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -363,7 +363,7 @@ static int ptrace_setsiginfo(struct task
 	siginfo_t newinfo;
 	int error = -ESRCH;
 
-	if (copy_from_user(&newinfo, data, sizeof (siginfo_t)))
+	if (copy_siginfo_from_user(&newinfo, data) != 0)
 		return -EFAULT;
 
 	read_lock(&tasklist_lock);
diff --git a/kernel/signal.c b/kernel/signal.c
index d7611f1..8ef54c0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/ptrace.h>
+#include <linux/compat_siginfo.h>
 #include <linux/posix-timers.h>
 #include <linux/signal.h>
 #include <linux/audit.h>
@@ -2095,17 +2096,35 @@ sys_rt_sigpending(sigset_t __user *set, 
 	return do_sigpending(set, sigsetsize);
 }
 
+#ifndef HAVE_ARCH_COPY_SIGINFO_FROM_USER
+
+int copy_siginfo_from_user(siginfo_t *to, siginfo_t __user *from)
+{
+        if(is_compat_task(current))
+                return compat_copy_siginfo_from_user(to,(compat_siginfo_t __user *)from);
+  
+        return copy_from_user(&to, from, sizeof(siginfo_t));
+}
+
+#endif
+
 #ifndef HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
 {
 	int err;
+	
+	/* Use compat_siginfo_t with 32-bit signals */
+	if(is_compat_task(current)){
+		return compat_copy_siginfo_to_user((compat_siginfo_t __user *)to,from);
+	}
 
 	if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t)))
 		return -EFAULT;
 	if (from->si_code < 0)
 		return __copy_to_user(to, from, sizeof(siginfo_t))
 			? -EFAULT : 0;
+	
 	/*
 	 * If you change siginfo_t structure, please be sure
 	 * this code is fixed accordingly.
@@ -2321,7 +2340,7 @@ sys_rt_sigqueueinfo(int pid, int sig, si
 {
 	siginfo_t info;
 
-	if (copy_from_user(&info, uinfo, sizeof(siginfo_t)))
+	if (copy_siginfo_from_user(&info, uinfo))
 		return -EFAULT;
 
 	/* Not even root can pretend to send signals from the kernel.
-- 
1.0.7

