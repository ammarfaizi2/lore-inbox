Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266130AbUGJDre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUGJDre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 23:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUGJDre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 23:47:34 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:21914 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266126AbUGJDrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 23:47:10 -0400
To: davem@redhat.com, ultralinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix sparc64 build with CONFIG_COMPAT=n
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Fri, 09 Jul 2004 20:47:09 -0700
Message-ID: <52fz808qwy.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-OriginalArrivalTime: 10 Jul 2004 03:47:09.0142 (UTC) FILETIME=[93724760:01C46630]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Right now sparc64 has achieved the impressive feat of not compiling
with allnoconfig (in fact the very first source file, init/main.c,
won't build).

This is because various structures and so on use types that are only
defined if CONFIG_COMPAT is on, but allnoconfig sets
CONFIG_SPARC32_COMPAT and therefore CONFIG_COMPAT to n.  I'm including
two possible solutions: one trivial one that forces
CONFIG_SPARC32_COMPAT to y, and one that actually tries to make the
CONFIG_COMPAT=n case work.

I don't actually have any hardware to try this on since I only
discovered the problem testing my driver for portability by
cross-compiling (I use allnoconfig to make my build as quick as
possible).  In fact I'm not sure if anyone has a full 64-bit userspace
for sparc64.  Therefore the first patch is probably the best fix, but
I leave it up to the experts.

I'm including the simple fix inline and attaching the big fix.

Thanks,
  Roland

Index: linux-2.6.7-sparc64/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.7-sparc64.orig/arch/sparc64/Kconfig	2004-07-08 20:07:28.000000000 -0700
+++ linux-2.6.7-sparc64/arch/sparc64/Kconfig	2004-07-09 20:43:11.000000000 -0700
@@ -348,7 +348,8 @@
 	  module will be called openpromfs.  If unsure, choose M.
 
 config SPARC32_COMPAT
-	bool "Kernel support for Linux/Sparc 32bit binary compatibility"
+	bool "Kernel support for Linux/Sparc 32bit binary compatibility" if BROKEN
+	default y
 	help
 	  This allows you to run 32-bit binaries on your Ultra.
 	  Everybody wants this; say Y.



--=-=-=
Content-Disposition: inline; filename=sparc64-compat.diff

Index: linux-2.6.7-sparc64/arch/sparc64/Kconfig
===================================================================
--- linux-2.6.7-sparc64.orig/arch/sparc64/Kconfig	2004-07-08 20:07:28.000000000 -0700
+++ linux-2.6.7-sparc64/arch/sparc64/Kconfig	2004-07-09 20:00:34.000000000 -0700
@@ -382,6 +382,7 @@
 
 config SUNOS_EMUL
 	bool "SunOS binary emulation"
+	depends on BINFMT_AOUT32
 	help
 	  This allows you to run most SunOS binaries.  If you want to do this,
 	  say Y here and place appropriate files in /usr/gnemul/sunos. See
@@ -391,7 +392,7 @@
 
 config SOLARIS_EMUL
 	tristate "Solaris binary emulation (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	depends on SPARC32_COMPAT && EXPERIMENTAL
 	help
 	  This is experimental code which will enable you to run (many)
 	  Solaris binaries on your SPARC Linux machine.
Index: linux-2.6.7-sparc64/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6.7-sparc64.orig/arch/sparc64/kernel/process.c	2004-06-15 22:19:22.000000000 -0700
+++ linux-2.6.7-sparc64/arch/sparc64/kernel/process.c	2004-07-09 19:55:23.000000000 -0700
@@ -588,10 +588,14 @@
 
 	clone_flags &= ~CLONE_IDLETASK;
 
+
+#ifdef CONFIG_SPARC32_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
 		parent_tid_ptr = compat_ptr(regs->u_regs[UREG_I2]);
 		child_tid_ptr = compat_ptr(regs->u_regs[UREG_I4]);
-	} else {
+	} else
+#endif /* CONFIG_SPARC32_COMPAT */
+	{
 		parent_tid_ptr = (int __user *) regs->u_regs[UREG_I2];
 		child_tid_ptr = (int __user *) regs->u_regs[UREG_I4];
 	}
Index: linux-2.6.7-sparc64/include/asm-sparc64/compat.h
===================================================================
--- linux-2.6.7-sparc64.orig/include/asm-sparc64/compat.h	2004-06-15 22:19:37.000000000 -0700
+++ linux-2.6.7-sparc64/include/asm-sparc64/compat.h	2004-07-09 19:50:39.000000000 -0700
@@ -96,6 +96,78 @@
 	int		f_spare[5];
 };
 
+struct __new_sigaction32 {
+	unsigned		sa_handler;
+	unsigned int    	sa_flags;
+	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+	compat_sigset_t 	sa_mask;
+};
+
+struct __old_sigaction32 {
+	unsigned		sa_handler;
+	compat_old_sigset_t  	sa_mask;
+	unsigned int    	sa_flags;
+	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
+};
+
+typedef struct sigaltstack32 {
+	u32			ss_sp;
+	int			ss_flags;
+	compat_size_t		ss_size;
+} stack_t32;
+
+typedef struct siginfo32 {
+	int si_signo;
+	int si_errno;
+	int si_code;
+
+	union {
+		int _pad[SI_PAD_SIZE32];
+
+		/* kill() */
+		struct {
+			compat_pid_t _pid;		/* sender's pid */
+			unsigned int _uid;		/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			timer_t _tid;			/* timer id */
+			int _overrun;			/* overrun count */
+			sigval_t32 _sigval;		/* same as below */
+			int _sys_private;		/* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			compat_pid_t _pid;		/* sender's pid */
+			unsigned int _uid;		/* sender's uid */
+			sigval_t32 _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			compat_pid_t _pid;		/* which child */
+			unsigned int _uid;		/* sender's uid */
+			int _status;			/* exit code */
+			compat_clock_t _utime;
+			compat_clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
+		struct {
+			u32 _addr; /* faulting insn/memory ref. */
+			int _trapno;
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+	} _sifields;
+} siginfo_t32;
+
 #define COMPAT_RLIM_INFINITY 0x7fffffff
 
 typedef u32		compat_old_sigset_t;
Index: linux-2.6.7-sparc64/include/asm-sparc64/siginfo.h
===================================================================
--- linux-2.6.7-sparc64.orig/include/asm-sparc64/siginfo.h	2004-06-15 22:19:43.000000000 -0700
+++ linux-2.6.7-sparc64/include/asm-sparc64/siginfo.h	2004-07-09 19:54:12.000000000 -0700
@@ -21,58 +21,6 @@
 	u32 sival_ptr;
 } sigval_t32;
 
-typedef struct siginfo32 {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			timer_t _tid;			/* timer id */
-			int _overrun;			/* overrun count */
-			sigval_t32 _sigval;		/* same as below */
-			int _sys_private;		/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			unsigned int _uid;		/* sender's uid */
-			sigval_t32 _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			unsigned int _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			u32 _addr; /* faulting insn/memory ref. */
-			int _trapno;
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} siginfo_t32;
-
 #endif /* __KERNEL__ */
 
 #define SI_NOINFO	32767		/* no information in siginfo_t */
@@ -85,6 +33,7 @@
 
 #ifdef __KERNEL__
 
+#ifdef CONFIG_SPARC32_COMPAT
 typedef struct sigevent32 {
 	sigval_t32 sigev_value;
 	int sigev_signo;
@@ -100,6 +49,7 @@
 } sigevent_t32;
 
 extern int copy_siginfo_to_user32(siginfo_t32 __user *to, siginfo_t *from);
+#endif /* CONFIG_SPARC32_COMPAT */
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6.7-sparc64/include/asm-sparc64/signal.h
===================================================================
--- linux-2.6.7-sparc64.orig/include/asm-sparc64/signal.h	2004-06-15 22:19:02.000000000 -0700
+++ linux-2.6.7-sparc64/include/asm-sparc64/signal.h	2004-07-09 20:24:15.000000000 -0700
@@ -9,6 +9,7 @@
 #include <linux/personality.h>
 #include <linux/types.h>
 #include <linux/compat.h>
+#include <linux/compiler.h> /* For __user */
 #endif
 #endif
 
@@ -203,13 +204,6 @@
 };
 
 #ifdef __KERNEL__
-struct __new_sigaction32 {
-	unsigned		sa_handler;
-	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-	compat_sigset_t 	sa_mask;
-};
-
 struct k_sigaction {
 	struct __new_sigaction 	sa;
 	void __user		*ka_restorer;
@@ -223,15 +217,6 @@
 	void 			(*sa_restorer)(void);     /* not used by Linux/SPARC yet */
 };
 
-#ifdef __KERNEL__
-struct __old_sigaction32 {
-	unsigned		sa_handler;
-	compat_old_sigset_t  	sa_mask;
-	unsigned int    	sa_flags;
-	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
-};
-#endif
-
 typedef struct sigaltstack {
 	void			*ss_sp;
 	int			ss_flags;
@@ -239,12 +224,6 @@
 } stack_t;
 
 #ifdef __KERNEL__
-typedef struct sigaltstack32 {
-	u32			ss_sp;
-	int			ss_flags;
-	compat_size_t		ss_size;
-} stack_t32;
-
 struct signal_deliver_cookie {
 	int restart_syscall;
 	unsigned long orig_i0;

--=-=-=--
