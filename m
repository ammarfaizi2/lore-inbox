Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSFRFun>; Tue, 18 Jun 2002 01:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317335AbSFRFun>; Tue, 18 Jun 2002 01:50:43 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:39409 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317334AbSFRFuY>;
	Tue, 18 Jun 2002 01:50:24 -0400
Date: Tue, 18 Jun 2002 15:47:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: rmk@arm.linux.org.uk, bjornw@axis.com, davidm@hpl.hp.com, paulus@samba.org,
       anton@samba.org, engebret@us.ibm.com, jes@trained-monkey.org,
       ralf@gnu.org, schwidefsky@de.ibm.com, davem@redhat.com, gniibe@m17n.org,
       ak@suse.de
Subject: [PATCH] Consolidate include/asm/signal.h
Message-Id: <20020618154726.1c78f6d1.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Have I gone too far this time? :-)

This patch consolidates most of the common signal.h stuff between
architectures into include/asm-generic/signal.h.  It builds fine
on i386, but may have broken all the other architectures despite
being careful.

Please test (at least a build).

diffstat looks like this:
 asm-alpha/signal.h   |   62 --------------
 asm-arm/signal.h     |  128 ------------------------------
 asm-cris/signal.h    |  126 ------------------------------
 asm-generic/signal.h |  212 +++++++++++++++++++++++++++++++++++++++++++++++++++
 asm-i386/signal.h    |  126 ------------------------------
 asm-ia64/signal.h    |   83 ++-----------------
 asm-m68k/signal.h    |  126 ------------------------------
 asm-mips/signal.h    |   46 +----------
 asm-mips64/signal.h  |   40 +--------
 asm-parisc/signal.h  |   72 ++++-------------
 asm-ppc/signal.h     |  100 ------------------------
 asm-ppc64/signal.h   |   96 -----------------------
 asm-s390/signal.h    |  104 -------------------------
 asm-s390x/signal.h   |  104 -------------------------
 asm-sh/signal.h      |  114 ---------------------------
 asm-sparc/signal.h   |   75 +++++-------------
 asm-sparc64/signal.h |   72 ++++-------------
 asm-x86_64/signal.h  |  108 +------------------------
 18 files changed, 326 insertions(+), 1468 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.22/include/asm-alpha/signal.h 2.5.22-sfr.5/include/asm-alpha/signal.h
--- 2.5.22/include/asm-alpha/signal.h	Thu May 30 05:12:29 2002
+++ 2.5.22-sfr.5/include/asm-alpha/signal.h	Tue Jun 18 15:21:08 2002
@@ -7,71 +7,30 @@
 struct siginfo;
 
 #ifdef __KERNEL__
-/* Digital Unix defines 64 signals.  Most things should be clean enough
-   to redefine this at will, if care is taken to make libc match.  */
-
-#define _NSIG		64
 #define _NSIG_BPW	64
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG		32
-typedef unsigned long sigset_t;
-
 #endif /* __KERNEL__ */
 
-
 /*
  * Linux/AXP has different signal numbers that Linux/i386: I'm trying
  * to make it OSF/1 binary compatible, at least for normal binaries.
  */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
 #define SIGEMT		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
 #define SIGBUS		10
-#define SIGSEGV		11
 #define SIGSYS		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
 #define SIGURG		16
 #define SIGSTOP		17
 #define SIGTSTP		18
 #define SIGCONT		19
 #define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
 #define SIGIO		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
 #define SIGINFO		29
 #define SIGUSR1		30
 #define SIGUSR2		31
 
-#define SIGPOLL	SIGIO
 #define SIGPWR	SIGINFO
-#define SIGIOT	SIGABRT
 
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define __HAVE_ARCH_SIGSTKFLT
+#define __HAVE_ARCH_SIGUNUSED
 
 /*
  * SA_FLAGS values:
@@ -103,13 +62,9 @@
 /* 
  * sigaltstack controls
  */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
 #define MINSIGSTKSZ	4096
 #define SIGSTKSZ	16384
 
-
 #ifdef __KERNEL__
 /*
  * These values of sa_flags are used only by the kernel as part of the
@@ -127,12 +82,9 @@
 #define SIG_UNBLOCK        2	/* for unblocking signals */
 #define SIG_SETMASK        3	/* for setting the signal mask */
 
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH_SIGACTION
 
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 struct osf_sigaction {
@@ -167,12 +119,6 @@
 #define sa_sigaction	_u._sa_sigaction
 
 #endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
 
 /* sigstack(2) is deprecated, and will be withdrawn in a future version
    of the X/Open CAE Specification.  Use sigaltstack instead.  It is only
diff -ruN 2.5.22/include/asm-arm/signal.h 2.5.22-sfr.5/include/asm-arm/signal.h
--- 2.5.22/include/asm-arm/signal.h	Thu May 30 05:12:29 2002
+++ 2.5.22-sfr.5/include/asm-arm/signal.h	Tue Jun 18 14:38:27 2002
@@ -6,70 +6,6 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-#ifdef __KERNEL__
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-#define _NSIG		64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG		32
-typedef unsigned long sigset_t;
-
-#endif /* __KERNEL__ */
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 #define SIGSWI		32
 
 /*
@@ -103,16 +39,6 @@
 #define SA_ONESHOT	SA_RESETHAND
 #define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
-
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 
 /*
@@ -128,59 +54,7 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-#ifdef __KERNEL__
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-struct sigaction {
-	union {
-	  __sighandler_t _sa_handler;
-	  void (*_sa_sigaction)(int, struct siginfo *, void *);
-	} _u;
-	sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-#define sa_handler	_u._sa_handler
-#define sa_sigaction	_u._sa_sigaction
-
-#endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
diff -ruN 2.5.22/include/asm-cris/signal.h 2.5.22-sfr.5/include/asm-cris/signal.h
--- 2.5.22/include/asm-cris/signal.h	Fri Feb  9 11:32:44 2001
+++ 2.5.22-sfr.5/include/asm-cris/signal.h	Tue Jun 18 14:40:04 2002
@@ -6,70 +6,6 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-#ifdef __KERNEL__
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-#define _NSIG		64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG		32
-typedef unsigned long sigset_t;
-
-#endif /* __KERNEL__ */
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS          31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
@@ -99,15 +35,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 
 /*
@@ -122,58 +49,7 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-#ifdef __KERNEL__
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-struct sigaction {
-	union {
-	  __sighandler_t _sa_handler;
-	  void (*_sa_sigaction)(int, struct siginfo *, void *);
-	} _u;
-	sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-#define sa_handler	_u._sa_handler
-#define sa_sigaction	_u._sa_sigaction
-
-#endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
diff -ruN 2.5.22/include/asm-generic/signal.h 2.5.22-sfr.5/include/asm-generic/signal.h
--- 2.5.22/include/asm-generic/signal.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.5/include/asm-generic/signal.h	Tue Jun 18 15:08:28 2002
@@ -0,0 +1,212 @@
+#ifndef _ASM_GENERIC_SIGNAL_H
+#define _ASM_GENERIC_SIGNAL_H
+
+#ifdef __KERNEL__
+/* Most things should be clean enough to redefine this at will, if care
+   is taken to make libc match.  */
+
+#ifndef _NSIG
+#define _NSIG		64
+#endif
+#ifndef _NSIG_BPW
+#define _NSIG_BPW	32
+#endif
+#ifndef _NSIG_WORDS
+#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+#endif
+
+#ifndef __ASSEMBLY__
+
+#ifndef __HAVE_ARCH_OLD_SIGSET_T
+typedef unsigned long	old_sigset_t;		/* at least 32 bits */
+#endif
+
+#ifndef __HAVE_ARCH_SIGSET_T
+typedef struct {
+	unsigned long	sig[_NSIG_WORDS];
+} sigset_t;
+#endif /* __HAVE_ARCH_SIGSET_T */
+
+#endif /* __ASSEMBLY__ */
+#else /* __KERNEL__ */
+#ifndef __ASSEMBLY__
+#ifndef __HAVE_ARCH_USER_SIGSET_T
+/* Here we must cater to libcs that poke about in kernel headers.  */
+
+#define NSIG		32
+typedef unsigned long	sigset_t;
+
+#endif /* __HAVE_ARCH_USER_SIGSET_T */
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+
+#define SIGHUP		 1
+#define SIGINT		 2
+#define SIGQUIT		 3
+#define SIGILL		 4
+#define SIGTRAP		 5
+#define SIGABRT		 6
+#ifndef SIGBUS
+#define SIGBUS		 7
+#endif
+#define SIGFPE		 8
+#define SIGKILL		 9
+#ifndef SIGUSR1
+#define SIGUSR1		10
+#endif
+#define SIGSEGV		11
+#ifndef SIGUSR2
+#define SIGUSR2		12
+#endif
+#define SIGPIPE		13
+#define SIGALRM		14
+#define SIGTERM		15
+#ifndef __HAVE_ARCH_SIGSTKFLT
+#define SIGSTKFLT	16
+#endif
+#ifndef SIGCHLD
+#define SIGCHLD		17
+#endif
+#ifndef SIGCONT
+#define SIGCONT		18
+#endif
+#ifndef SIGSTOP
+#define SIGSTOP		19
+#endif
+#ifndef SIGTSTP
+#define SIGTSTP		20
+#endif
+#ifndef SIGTTIN
+#define SIGTTIN		21
+#endif
+#ifndef SIGTTOU
+#define SIGTTOU		22
+#endif
+#ifndef SIGURG
+#define SIGURG		23
+#endif
+#ifndef SIGXCPU
+#define SIGXCPU		24
+#endif
+#ifndef SIGXFSZ
+#define SIGXFSZ		25
+#endif
+#ifndef SIGVTARLM
+#define SIGVTALRM	26
+#endif
+#ifndef SIGPROF
+#define SIGPROF		27
+#endif
+#ifndef SIGWINCH
+#define SIGWINCH	28
+#endif
+#ifndef SIGIO
+#define SIGIO		29
+#endif
+/*
+#define SIGLOST		29
+*/
+#ifndef SIGPWR
+#define SIGPWR		30
+#endif
+#ifndef SIGSYS
+#define SIGSYS		31
+#endif
+#ifndef __HAVE_ARCH_SIGUNUSED
+#define	SIGUNUSED	31
+#endif
+
+#define SIGPOLL		SIGIO
+#define SIGIOT		SIGABRT
+
+/* These should not be considered constants from userland.  */
+#define SIGRTMIN	32
+#define SIGRTMAX	(_NSIG-1)
+
+/*
+ * signalstack controls
+ */
+#define SS_ONSTACK	1
+#define SS_DISABLE	2
+
+#ifndef MINSIGSTKSZ
+#define MINSIGSTKSZ	2048
+#endif
+#ifndef SIGSTKSZ
+#define SIGSTKSZ	8192
+#endif
+
+#ifndef SIG_BLOCK
+#define SIG_BLOCK          0	/* for blocking signals */
+#endif
+#ifndef SIG_UNBLOCK
+#define SIG_UNBLOCK        1	/* for unblocking signals */
+#endif
+#ifndef SIG_SETMASK
+#define SIG_SETMASK        2	/* for setting the signal mask */
+#endif
+
+#ifndef __ASSEMBLY__
+#ifndef __HAVE_ARCH___SIGHANDLER_T
+/* Type of a signal handler.  */
+typedef void (*__sighandler_t)(int);
+#endif /* __HAVE_ARCH___SIGHANDLER_T */
+#endif /* __ASSEMBLY__ */
+
+#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
+#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
+#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+
+#ifndef __ASSEMBLY__
+#ifndef __HAVE_ARCH_SIGACTION
+#ifdef __KERNEL__
+#ifndef __HAVE_ARCH_OLD_SIGACTION
+struct old_sigaction {
+	__sighandler_t sa_handler;
+	old_sigset_t sa_mask;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+};
+#endif
+
+struct sigaction {
+	__sighandler_t sa_handler;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+	sigset_t sa_mask;		/* mask last for extensibility */
+};
+
+struct k_sigaction {
+	struct sigaction sa;
+};
+#else /* __KERNEL__ */
+#ifndef __HAVE_ARCH_USER_SIGACTION
+/* Here we must cater to libcs that poke about in kernel headers.  */
+
+struct sigaction {
+	union {
+	  __sighandler_t _sa_handler;
+	  void (*_sa_sigaction)(int, struct siginfo *, void *);
+	} _u;
+	sigset_t sa_mask;
+	unsigned long sa_flags;
+	void (*sa_restorer)(void);
+};
+
+#define sa_handler	_u._sa_handler
+#define sa_sigaction	_u._sa_sigaction
+
+#endif /* _HAVE_ARCH_USER_SIGACTION */
+#endif /* __KERNEL__ */
+#endif /* __HAVE_ARCH_SIGACTION */
+
+#ifndef __HAVE_ARCH_SIGNALSTACK
+typedef struct sigaltstack {
+	void *ss_sp;
+	int ss_flags;
+	size_t ss_size;
+} stack_t;
+#endif
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_GENERIC_SIGNAL_H */
diff -ruN 2.5.22/include/asm-i386/signal.h 2.5.22-sfr.5/include/asm-i386/signal.h
--- 2.5.22/include/asm-i386/signal.h	Thu Jan 31 07:12:46 2002
+++ 2.5.22-sfr.5/include/asm-i386/signal.h	Tue Jun 18 14:42:06 2002
@@ -7,70 +7,6 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-#ifdef __KERNEL__
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-#define _NSIG		64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG		32
-typedef unsigned long sigset_t;
-
-#endif /* __KERNEL__ */
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
@@ -99,15 +35,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 
 /*
@@ -122,58 +49,7 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-#ifdef __KERNEL__
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-struct sigaction {
-	union {
-	  __sighandler_t _sa_handler;
-	  void (*_sa_sigaction)(int, struct siginfo *, void *);
-	} _u;
-	sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-#define sa_handler	_u._sa_handler
-#define sa_sigaction	_u._sa_sigaction
-
-#endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
diff -ruN 2.5.22/include/asm-ia64/signal.h 2.5.22-sfr.5/include/asm-ia64/signal.h
--- 2.5.22/include/asm-ia64/signal.h	Thu May 30 05:12:29 2002
+++ 2.5.22-sfr.5/include/asm-ia64/signal.h	Tue Jun 18 15:24:27 2002
@@ -9,48 +9,11 @@
  * glibc-2.x.  Hence the #ifdef __KERNEL__ ugliness.
  */
 
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-/* signal 31 is no longer "unused", but the SIGUNUSED macro remains for backwards compatibility */
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#ifdef __KERNEL__
+#define _NSIG_BPW	64
+#else
+#define __HAVE_USER_SIGSET_T
+#endif
 
 /*
  * SA_FLAGS values:
@@ -83,9 +46,6 @@
 /*
  * sigaltstack controls
  */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
 /*
  * The minimum stack size needs to be fairly large because we want to
  * be sure that an app compiled for today's CPUs will continue to run
@@ -101,10 +61,6 @@
 
 #ifdef __KERNEL__
 
-#define _NSIG		64
-#define _NSIG_BPW	64
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
 /*
  * These values of sa_flags are used only by the kernel as part of the
  * irq handling routines.
@@ -119,13 +75,9 @@
 
 #endif /* __KERNEL__ */
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#define __HAVE_ARCH_SIGACTION
+
+#include <asm-generic/signal.h>
 
 # ifndef __ASSEMBLY__
 
@@ -134,26 +86,8 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
-
 #ifdef __KERNEL__
 
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-typedef unsigned long old_sigset_t;
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
 struct sigaction {
 	__sighandler_t sa_handler;
 	unsigned long sa_flags;
@@ -171,4 +105,5 @@
 #endif /* __KERNEL__ */
 
 # endif /* !__ASSEMBLY__ */
+
 #endif /* _ASM_IA64_SIGNAL_H */
diff -ruN 2.5.22/include/asm-m68k/signal.h 2.5.22-sfr.5/include/asm-m68k/signal.h
--- 2.5.22/include/asm-m68k/signal.h	Thu May 30 05:12:29 2002
+++ 2.5.22-sfr.5/include/asm-m68k/signal.h	Tue Jun 18 14:45:11 2002
@@ -6,70 +6,6 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-#ifdef __KERNEL__
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-#define _NSIG		64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG		32
-typedef unsigned long sigset_t;
-
-#endif /* __KERNEL__ */
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
@@ -96,15 +32,6 @@
 #define SA_ONESHOT	SA_RESETHAND
 #define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 /*
  * These values of sa_flags are used only by the kernel as part of the
@@ -118,58 +45,7 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-#ifdef __KERNEL__
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-struct sigaction {
-	union {
-	  __sighandler_t _sa_handler;
-	  void (*_sa_sigaction)(int, struct siginfo *, void *);
-	} _u;
-	sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-#define sa_handler	_u._sa_handler
-#define sa_sigaction	_u._sa_sigaction
-
-#endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
diff -ruN 2.5.22/include/asm-mips/signal.h 2.5.22-sfr.5/include/asm-mips/signal.h
--- 2.5.22/include/asm-mips/signal.h	Mon Jul 10 15:18:15 2000
+++ 2.5.22-sfr.5/include/asm-mips/signal.h	Tue Jun 18 15:25:53 2002
@@ -13,31 +13,11 @@
 #include <linux/types.h>
 
 #define _NSIG		128
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+#define __HAVE_ARCH_USER_SIGSET_T
 
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-#define SIGHUP		 1	/* Hangup (POSIX).  */
-#define SIGINT		 2	/* Interrupt (ANSI).  */
-#define SIGQUIT		 3	/* Quit (POSIX).  */
-#define SIGILL		 4	/* Illegal instruction (ANSI).  */
-#define SIGTRAP		 5	/* Trace trap (POSIX).  */
-#define SIGIOT		 6	/* IOT trap (4.2 BSD).  */
-#define SIGABRT		 SIGIOT	/* Abort (ANSI).  */
 #define SIGEMT		 7
-#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
-#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
 #define SIGBUS		10	/* BUS error (4.2 BSD).  */
-#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
 #define SIGSYS		12
-#define SIGPIPE		13	/* Broken pipe (POSIX).  */
-#define SIGALRM		14	/* Alarm clock (POSIX).  */
-#define SIGTERM		15	/* Termination (ANSI).  */
 #define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
 #define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
 #define SIGCHLD		18	/* Child status has changed (POSIX).  */
@@ -46,7 +26,6 @@
 #define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
 #define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
 #define SIGIO		22	/* I/O now possible (4.2 BSD).  */
-#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).  */
 #define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
 #define SIGTSTP		24	/* Keyboard stop (POSIX).  */
 #define SIGCONT		25	/* Continue (POSIX).  */
@@ -57,9 +36,8 @@
 #define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
 #define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
 
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define __HAVE_ARCH_SIGSTKFLT
+#define __HAVE_ARCH_SIGUNUSED
 
 /*
  * SA_FLAGS values:
@@ -89,15 +67,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK     1
-#define SS_DISABLE     2
-
-#define MINSIGSTKSZ    2048
-#define SIGSTKSZ       8192
-
 #ifdef __KERNEL__
 
 /*
@@ -119,13 +88,10 @@
 #define SIG_SETMASK32	256	/* Goodie from SGI for BSD compatibility:
 				   set only the low 32 bit of the sigset.  */
 
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH_SIGACTION
+#define __HAVE_ARCH_SIGNALSTACK
 
-/* Fake signal functions */
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal.h>
 
 struct sigaction {
 	unsigned int	sa_flags;
diff -ruN 2.5.22/include/asm-mips64/signal.h 2.5.22-sfr.5/include/asm-mips64/signal.h
--- 2.5.22/include/asm-mips64/signal.h	Mon Sep 10 03:43:02 2001
+++ 2.5.22-sfr.5/include/asm-mips64/signal.h	Tue Jun 18 15:26:10 2002
@@ -14,30 +14,18 @@
 #define _NSIG		128
 #define _NSIG_BPW	64
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
+#define __HAVE_ARCH_SIGSET_T
+#define __HAVE_ARCH_USER_SIGSET_T
 
 typedef struct {
 	long sig[_NSIG_WORDS];
 } sigset_t;
 
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
 typedef unsigned int old_sigset_t32;
 
-#define SIGHUP		 1	/* Hangup (POSIX).  */
-#define SIGINT		 2	/* Interrupt (ANSI).  */
-#define SIGQUIT		 3	/* Quit (POSIX).  */
-#define SIGILL		 4	/* Illegal instruction (ANSI).  */
-#define SIGTRAP		 5	/* Trace trap (POSIX).  */
-#define SIGIOT		 6	/* IOT trap (4.2 BSD).  */
-#define SIGABRT		 SIGIOT	/* Abort (ANSI).  */
 #define SIGEMT		 7
-#define SIGFPE		 8	/* Floating-point exception (ANSI).  */
-#define SIGKILL		 9	/* Kill, unblockable (POSIX).  */
 #define SIGBUS		10	/* BUS error (4.2 BSD).  */
-#define SIGSEGV		11	/* Segmentation violation (ANSI).  */
 #define SIGSYS		12
-#define SIGPIPE		13	/* Broken pipe (POSIX).  */
-#define SIGALRM		14	/* Alarm clock (POSIX).  */
-#define SIGTERM		15	/* Termination (ANSI).  */
 #define SIGUSR1		16	/* User-defined signal 1 (POSIX).  */
 #define SIGUSR2		17	/* User-defined signal 2 (POSIX).  */
 #define SIGCHLD		18	/* Child status has changed (POSIX).  */
@@ -46,7 +34,6 @@
 #define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
 #define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
 #define SIGIO		22	/* I/O now possible (4.2 BSD).  */
-#define SIGPOLL		SIGIO	/* Pollable event occurred (System V).  */
 #define SIGSTOP		23	/* Stop, unblockable (POSIX).  */
 #define SIGTSTP		24	/* Keyboard stop (POSIX).  */
 #define SIGCONT		25	/* Continue (POSIX).  */
@@ -57,9 +44,8 @@
 #define SIGXCPU		30	/* CPU limit exceeded (4.2 BSD).  */
 #define SIGXFSZ		31	/* File size limit exceeded (4.2 BSD).  */
 
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define __HAVE_ARCH_SIGSTKFLT
+#define __HAVE_ARCH_SIGUNUSED
 
 /*
  * SA_FLAGS values:
@@ -89,15 +75,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK     1
-#define SS_DISABLE     2
-
-#define MINSIGSTKSZ    2048
-#define SIGSTKSZ       8192
-
 #ifdef __KERNEL__
 
 /*
@@ -119,13 +96,10 @@
 #define SIG_SETMASK32	256	/* Goodie from SGI for BSD compatibility:
 				   set only the low 32 bit of the sigset.  */
 
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH_SIGACTION
+#define __HAVE_ARCH_SIGNALSTACK
 
-/* Fake signal functions */
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal.h>
 
 struct sigaction {
 	unsigned int	sa_flags;
diff -ruN 2.5.22/include/asm-parisc/signal.h 2.5.22-sfr.5/include/asm-parisc/signal.h
--- 2.5.22/include/asm-parisc/signal.h	Wed Dec  6 07:29:39 2000
+++ 2.5.22-sfr.5/include/asm-parisc/signal.h	Tue Jun 18 15:27:38 2002
@@ -1,22 +1,17 @@
 #ifndef _ASM_PARISC_SIGNAL_H
 #define _ASM_PARISC_SIGNAL_H
 
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
+#ifdef __KERNEL__
+#define _NSIG		64
+/* bits-per-word, where word apparently means 'long' not 'int' */
+#define _NSIG_BPW	BITS_PER_LONG
+#else
+#define __HAVE_ARCH_USER_SIGSET_T
+#endif
+
 #define SIGEMT		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
 #define SIGBUS		10
-#define SIGSEGV		11
 #define SIGSYS		12 /* Linux doesn't use this */
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
 #define SIGUSR1		16
 #define SIGUSR2		17
 #define SIGCHLD		18
@@ -24,7 +19,6 @@
 #define SIGVTALRM	20
 #define SIGPROF		21
 #define SIGIO		22
-#define SIGPOLL		SIGIO
 #define SIGWINCH	23
 #define SIGSTOP		24
 #define SIGTSTP		25
@@ -73,22 +67,8 @@
 
 #define SA_RESTORER	0x04000000 /* obsolete -- ignored */
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 
-#define _NSIG		64
-/* bits-per-word, where word apparently means 'long' not 'int' */
-#define _NSIG_BPW	BITS_PER_LONG
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
 /*
  * These values of sa_flags are used only by the kernel as part of the
  * irq handling routines.
@@ -102,17 +82,9 @@
 
 #endif /* __KERNEL__ */
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#ifndef __ASSEMBLY__
 
-# ifndef __ASSEMBLY__
-
-#  include <linux/types.h>
+#include <linux/types.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
@@ -124,27 +96,16 @@
  * the function in the little struct.  This is really ugly -PB
  */
 typedef __kernel_caddr_t __sighandler_t;
-#else
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH___SIGHANDLER_T
 #endif
+#endif /* !__ASSEMBLY */
 
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
-
-#ifdef __KERNEL__
-
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
+#define __HAVE_ARCH_SIGACTION
 
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
+#include <asm-generic/signal.h>
 
-typedef struct {
-	/* next_signal() assumes this is a long - no choice */
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
+#ifndef __ASSEMBLY__
+#ifdef __KERNEL__
 
 struct sigaction {
 	__sighandler_t sa_handler;
@@ -160,4 +121,5 @@
 
 #endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY */
+
 #endif /* _ASM_PARISC_SIGNAL_H */
diff -ruN 2.5.22/include/asm-ppc/signal.h 2.5.22-sfr.5/include/asm-ppc/signal.h
--- 2.5.22/include/asm-ppc/signal.h	Tue May 22 08:02:06 2001
+++ 2.5.22-sfr.5/include/asm-ppc/signal.h	Tue Jun 18 14:53:01 2002
@@ -11,60 +11,7 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
-
-#define _NSIG		64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define __HAVE_ARCH_USER_SIGSET_T
 
 /*
  * SA_FLAGS values:
@@ -94,14 +41,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
 #ifdef __KERNEL__
 
 /*
@@ -116,40 +55,9 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#define __HAVE_ARCH_USER_SIGACTION
+
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
diff -ruN 2.5.22/include/asm-ppc64/signal.h 2.5.22-sfr.5/include/asm-ppc64/signal.h
--- 2.5.22/include/asm-ppc64/signal.h	Fri May  3 11:12:23 2002
+++ 2.5.22-sfr.5/include/asm-ppc64/signal.h	Tue Jun 18 14:54:13 2002
@@ -6,57 +6,8 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-#define _NSIG		64
 #define _NSIG_BPW	64
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define __HAVE_ARCH_USER_SIGSET_T
 
 /*
  * SA_FLAGS values:
@@ -86,14 +37,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
 #ifdef __KERNEL__
 
 /*
@@ -108,39 +51,8 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#define __HAVE_ARCH_USER_SIGACTION
+
+#include <asm-generic/signal.h>
 
 #endif /* _ASMPPC64_SIGNAL_H */
diff -ruN 2.5.22/include/asm-s390/signal.h 2.5.22-sfr.5/include/asm-s390/signal.h
--- 2.5.22/include/asm-s390/signal.h	Sun Jun  9 16:12:33 2002
+++ 2.5.22-sfr.5/include/asm-s390/signal.h	Tue Jun 18 15:28:50 2002
@@ -22,63 +22,8 @@
 #define _NSIG           _SIGCONTEXT_NSIG
 #define _NSIG_BPW       _SIGCONTEXT_NSIG_BPW
 #define _NSIG_WORDS     _SIGCONTEXT_NSIG_WORDS
-
-typedef unsigned long old_sigset_t;             /* at least 32 bits */
-
-typedef struct {
-        unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG            32
-typedef unsigned long sigset_t;
-
 #endif /* __KERNEL__ */
 
-#define SIGHUP           1
-#define SIGINT           2
-#define SIGQUIT          3
-#define SIGILL           4
-#define SIGTRAP          5
-#define SIGABRT          6
-#define SIGIOT           6
-#define SIGBUS           7
-#define SIGFPE           8
-#define SIGKILL          9
-#define SIGUSR1         10
-#define SIGSEGV         11
-#define SIGUSR2         12
-#define SIGPIPE         13
-#define SIGALRM         14
-#define SIGTERM         15
-#define SIGSTKFLT       16
-#define SIGCHLD         17
-#define SIGCONT         18
-#define SIGSTOP         19
-#define SIGTSTP         20
-#define SIGTTIN         21
-#define SIGTTOU         22
-#define SIGURG          23
-#define SIGXCPU         24
-#define SIGXFSZ         25
-#define SIGVTALRM       26
-#define SIGPROF         27
-#define SIGWINCH        28
-#define SIGIO           29
-#define SIGPOLL         SIGIO
-/*
-#define SIGLOST         29
-*/
-#define SIGPWR          30
-#define SIGSYS		31
-#define SIGUNUSED       31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
@@ -107,15 +52,6 @@
 
 #define SA_RESTORER     0x04000000
 
-/*
- * sigaltstack controls
- */
-#define SS_ONSTACK      1
-#define SS_DISABLE      2
-
-#define MINSIGSTKSZ     2048
-#define SIGSTKSZ        8192
-
 #ifdef __KERNEL__
 
 /*
@@ -130,36 +66,11 @@
 #define SA_SHIRQ                0x04000000
 #endif
 
-#define SIG_BLOCK          0    /* for blocking signals */
-#define SIG_UNBLOCK        1    /* for unblocking signals */
-#define SIG_SETMASK        2    /* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL ((__sighandler_t)0)     /* default signal handling */
-#define SIG_IGN ((__sighandler_t)1)     /* ignore signal */
-#define SIG_ERR ((__sighandler_t)-1)    /* error return from signal */
+#define __HAVE_ARCH_USER_SIGACTION
 
-#ifdef __KERNEL__
-struct old_sigaction {
-        __sighandler_t sa_handler;
-        old_sigset_t sa_mask;
-        unsigned long sa_flags;
-        void (*sa_restorer)(void);
-};
-
-struct sigaction {
-        __sighandler_t sa_handler;
-        unsigned long sa_flags;
-        void (*sa_restorer)(void);
-        sigset_t sa_mask;               /* mask last for extensibility */
-};
+#include <asm-generic/signal.h>
 
-struct k_sigaction {
-        struct sigaction sa;
-};
-#else
+#ifndef __KERNEL__
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
@@ -167,21 +78,14 @@
           __sighandler_t _sa_handler;
           void (*_sa_sigaction)(int, struct siginfo *, void *);
         } _u;
-        sigset_t sa_mask;
         unsigned long sa_flags;
         void (*sa_restorer)(void);
+	sigset_t sa_mask;
 };
 
 #define sa_handler      _u._sa_handler
 #define sa_sigaction    _u._sa_sigaction
 
 #endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-        void *ss_sp;
-        int ss_flags;
-        size_t ss_size;
-} stack_t;
-
 
 #endif
diff -ruN 2.5.22/include/asm-s390x/signal.h 2.5.22-sfr.5/include/asm-s390x/signal.h
--- 2.5.22/include/asm-s390x/signal.h	Sun Jun  9 16:12:33 2002
+++ 2.5.22-sfr.5/include/asm-s390x/signal.h	Tue Jun 18 15:29:38 2002
@@ -16,69 +16,12 @@
 struct pt_regs;
 
 #ifdef __KERNEL__
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
 #include <asm/sigcontext.h>
 #define _NSIG           _SIGCONTEXT_NSIG
 #define _NSIG_BPW       _SIGCONTEXT_NSIG_BPW
 #define _NSIG_WORDS     _SIGCONTEXT_NSIG_WORDS
-
-typedef unsigned long old_sigset_t;             /* at least 32 bits */
-
-typedef struct {
-        unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG            32
-typedef unsigned long sigset_t;
-
 #endif /* __KERNEL__ */
 
-#define SIGHUP           1
-#define SIGINT           2
-#define SIGQUIT          3
-#define SIGILL           4
-#define SIGTRAP          5
-#define SIGABRT          6
-#define SIGIOT           6
-#define SIGBUS           7
-#define SIGFPE           8
-#define SIGKILL          9
-#define SIGUSR1         10
-#define SIGSEGV         11
-#define SIGUSR2         12
-#define SIGPIPE         13
-#define SIGALRM         14
-#define SIGTERM         15
-#define SIGSTKFLT       16
-#define SIGCHLD         17
-#define SIGCONT         18
-#define SIGSTOP         19
-#define SIGTSTP         20
-#define SIGTTIN         21
-#define SIGTTOU         22
-#define SIGURG          23
-#define SIGXCPU         24
-#define SIGXFSZ         25
-#define SIGVTALRM       26
-#define SIGPROF         27
-#define SIGWINCH        28
-#define SIGIO           29
-#define SIGPOLL         SIGIO
-/*
-#define SIGLOST         29
-*/
-#define SIGPWR          30
-#define SIGSYS		31
-#define SIGUNUSED       31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN        32
-#define SIGRTMAX        (_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
@@ -107,15 +50,6 @@
 
 #define SA_RESTORER     0x04000000
 
-/*
- * sigaltstack controls
- */
-#define SS_ONSTACK      1
-#define SS_DISABLE      2
-
-#define MINSIGSTKSZ     2048
-#define SIGSTKSZ        8192
-
 #ifdef __KERNEL__
 
 /*
@@ -130,36 +64,11 @@
 #define SA_SHIRQ                0x04000000
 #endif
 
-#define SIG_BLOCK          0    /* for blocking signals */
-#define SIG_UNBLOCK        1    /* for unblocking signals */
-#define SIG_SETMASK        2    /* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL ((__sighandler_t)0)     /* default signal handling */
-#define SIG_IGN ((__sighandler_t)1)     /* ignore signal */
-#define SIG_ERR ((__sighandler_t)-1)    /* error return from signal */
+#define __HAVE_ARCH_USER_SIGACTION
 
-#ifdef __KERNEL__
-struct old_sigaction {
-        __sighandler_t sa_handler;
-        old_sigset_t sa_mask;
-        unsigned long sa_flags;
-        void (*sa_restorer)(void);
-};
-
-struct sigaction {
-        __sighandler_t sa_handler;
-        unsigned long sa_flags;
-        void (*sa_restorer)(void);
-        sigset_t sa_mask;               /* mask last for extensibility */
-};
+#include <asm-generic/signal.h>
 
-struct k_sigaction {
-        struct sigaction sa;
-};
-#else
+#ifndef __KERNEL__
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
@@ -176,12 +85,5 @@
 #define sa_sigaction    _u._sa_sigaction
 
 #endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-        void *ss_sp;
-        int ss_flags;
-        size_t ss_size;
-} stack_t;
-
 
 #endif
diff -ruN 2.5.22/include/asm-sh/signal.h 2.5.22-sfr.5/include/asm-sh/signal.h
--- 2.5.22/include/asm-sh/signal.h	Fri Nov 19 14:37:03 1999
+++ 2.5.22-sfr.5/include/asm-sh/signal.h	Tue Jun 18 15:01:36 2002
@@ -6,57 +6,7 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-#define _NSIG		64
-#define _NSIG_BPW	32
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
+#define __HAVE_ARCH_USER_SIGSET_T
 
 /*
  * SA_FLAGS values:
@@ -86,15 +36,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 
 /*
@@ -109,58 +50,7 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-#ifdef __KERNEL__
-struct old_sigaction {
-	__sighandler_t sa_handler;
-	old_sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-struct sigaction {
-	union {
-	  __sighandler_t _sa_handler;
-	  void (*_sa_sigaction)(int, struct siginfo *, void *);
-	} _u;
-	sigset_t sa_mask;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-};
-
-#define sa_handler	_u._sa_handler
-#define sa_sigaction	_u._sa_sigaction
-
-#endif /* __KERNEL__ */
-
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#include <asm-generic/signal.h>
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
diff -ruN 2.5.22/include/asm-sparc/signal.h 2.5.22-sfr.5/include/asm-sparc/signal.h
--- 2.5.22/include/asm-sparc/signal.h	Thu May 30 05:12:30 2002
+++ 2.5.22-sfr.5/include/asm-sparc/signal.h	Tue Jun 18 15:31:39 2002
@@ -14,23 +14,14 @@
 /* On the Sparc the signal handlers get passed a 'sub-signal' code
  * for certain signal types, which we document here.
  */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
+/* SIGILL */
 #define    SUBSIG_STACK       0
 #define    SUBSIG_ILLINST     2
 #define    SUBSIG_PRIVINST    3
 #define    SUBSIG_BADTRAP(t)  (0x80 + (t))
-
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-
 #define SIGEMT           7
 #define    SUBSIG_TAG    10
-
-#define SIGFPE		 8
+/* SIGFPE */
 #define    SUBSIG_FPDISABLED     0x400
 #define    SUBSIG_FPERROR        0x404
 #define    SUBSIG_FPINTOVFL      0x001
@@ -41,44 +32,30 @@
 #define    SUBSIG_FPUNFLOW       0x0cc
 #define    SUBSIG_FPOPERROR      0x0d0
 #define    SUBSIG_FPOVFLOW       0x0d4
-
-#define SIGKILL		 9
 #define SIGBUS          10
 #define    SUBSIG_BUSTIMEOUT    1
 #define    SUBSIG_ALIGNMENT     2
 #define    SUBSIG_MISCERROR     5
-
-#define SIGSEGV		11
+/* SIGSEGV */
 #define    SUBSIG_NOMAPPING     3
 #define    SUBSIG_PROTECTION    4
 #define    SUBSIG_SEGERROR      5
-
 #define SIGSYS		12
-
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
 #define SIGURG          16
-
 /* SunOS values which deviate from the Linux/i386 ones */
 #define SIGSTOP		17
 #define SIGTSTP		18
 #define SIGCONT		19
 #define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
 #define SIGIO		23
-#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
 #define SIGLOST		29
 #define SIGPWR		SIGLOST
 #define SIGUSR1		30
 #define SIGUSR2		31
 
+#define __HAVE_ARCH_SIGSTKFLT
+#define __HAVE_ARCH_SIGUNUSED
+
 /* Most things should be clean enough to redefine this at will, if care
  * is taken to make libc match.
  */
@@ -88,9 +65,6 @@
 #define _NSIG_BPW	32
 #define _NSIG_WORDS	(__NEW_NSIG / _NSIG_BPW)
 
-#define SIGRTMIN	32
-#define SIGRTMAX	(__NEW_NSIG - 1)
-
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define	_NSIG		__NEW_NSIG
 #define __new_sigset_t	sigset_t
@@ -103,6 +77,16 @@
 #define __old_sigaction	sigaction
 #endif
 
+#define __HAVE_ARCH_SIGSET_T
+#define __HAVE_ARCH_OLD_SIGSET_T
+#define __HAVE_ARCH_USER_SIGSET_T
+
+/* 
+ * sigaltstack controls
+ */
+#define MINSIGSTKSZ	4096
+#define SIGSTKSZ	16384
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned long __old_sigset_t;
@@ -147,15 +131,6 @@
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
 #define SIG_SETMASK        0x04	/* for setting the signal mask */
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	4096
-#define SIGSTKSZ	16384
-
 #ifdef __KERNEL__
 /*
  * These values of sa_flags are used only by the kernel as part of the
@@ -181,13 +156,15 @@
 /* Type of a signal handler.  */
 #ifdef __KERNEL__
 typedef void (*__sighandler_t)(int, int, struct sigcontext *, char *);
-#else
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH___SIGHANDLER_T
 #endif
+#endif /* !(__ASSEMBLY__) */
+
+#define __HAVE_ARCH_SIGACTION
 
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal.h>
+
+#ifndef __ASSEMBLY__
 
 struct __new_sigaction {
 	__sighandler_t	sa_handler;
@@ -209,12 +186,6 @@
 	unsigned long	sa_flags;
 	void		(*sa_restorer) (void);	/* not used by Linux/SPARC */
 };
-
-typedef struct sigaltstack {
-	void		*ss_sp;
-	int		ss_flags;
-	size_t		ss_size;
-} stack_t;
 
 #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 
diff -ruN 2.5.22/include/asm-sparc64/signal.h 2.5.22-sfr.5/include/asm-sparc64/signal.h
--- 2.5.22/include/asm-sparc64/signal.h	Thu May 30 05:12:30 2002
+++ 2.5.22-sfr.5/include/asm-sparc64/signal.h	Tue Jun 18 15:33:02 2002
@@ -14,23 +14,14 @@
 /* On the Sparc the signal handlers get passed a 'sub-signal' code
  * for certain signal types, which we document here.
  */
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
+/* SIGILL */
 #define    SUBSIG_STACK       0
 #define    SUBSIG_ILLINST     2
 #define    SUBSIG_PRIVINST    3
 #define    SUBSIG_BADTRAP(t)  (0x80 + (t))
-
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-
 #define SIGEMT           7
 #define    SUBSIG_TAG    10
-
-#define SIGFPE		 8
+/* SIGFPE */
 #define    SUBSIG_FPDISABLED     0x400
 #define    SUBSIG_FPERROR        0x404
 #define    SUBSIG_FPINTOVFL      0x001
@@ -41,39 +32,22 @@
 #define    SUBSIG_FPUNFLOW       0x0cc
 #define    SUBSIG_FPOPERROR      0x0d0
 #define    SUBSIG_FPOVFLOW       0x0d4
-
-#define SIGKILL		 9
 #define SIGBUS          10
 #define    SUBSIG_BUSTIMEOUT    1
 #define    SUBSIG_ALIGNMENT     2
 #define    SUBSIG_MISCERROR     5
-
-#define SIGSEGV		11
+/* SIGSEGV */
 #define    SUBSIG_NOMAPPING     3
 #define    SUBSIG_PROTECTION    4
 #define    SUBSIG_SEGERROR      5
-
 #define SIGSYS		12
-
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
 #define SIGURG          16
-
 /* SunOS values which deviate from the Linux/i386 ones */
 #define SIGSTOP		17
 #define SIGTSTP		18
 #define SIGCONT		19
 #define SIGCHLD		20
-#define SIGTTIN		21
-#define SIGTTOU		22
 #define SIGIO		23
-#define SIGPOLL		SIGIO   /* SysV name for SIGIO */
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
 #define SIGLOST		29
 #define SIGPWR		SIGLOST
 #define SIGUSR1		30
@@ -90,9 +64,6 @@
 #define _NSIG_BPW32   	32
 #define _NSIG_WORDS32 	(__NEW_NSIG / _NSIG_BPW32)
 
-#define SIGRTMIN       32
-#define SIGRTMAX       (__NEW_NSIG - 1)
-
 #if defined(__KERNEL__) || defined(__WANT_POSIX1B_SIGNALS__)
 #define _NSIG			__NEW_NSIG
 #define __new_sigset_t		sigset_t
@@ -112,6 +83,16 @@
 #define __old_sigaction32	sigaction32
 #endif
 
+#define __HAVE_ARCH_SIGSET_T
+#define __HAVE_ARCH_OLD_SIGSET_T
+#define __HAVE_ARCH_USER_SIGSET_T
+
+/* 
+ * sigaltstack controls
+ */
+#define MINSIGSTKSZ	4096
+#define SIGSTKSZ	16384
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned long __old_sigset_t;            /* at least 32 bits */
@@ -163,15 +144,6 @@
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
 #define SIG_SETMASK        0x04	/* for setting the signal mask */
 
-/* 
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	4096
-#define SIGSTKSZ	16384
-
 #ifdef __KERNEL__
 /*
  * These values of sa_flags are used only by the kernel as part of the
@@ -197,13 +169,15 @@
 /* Type of a signal handler.  */
 #ifdef __KERNEL__
 typedef void (*__sighandler_t)(int, struct sigcontext *);
-#else
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH___SIGHANDLER_T
 #endif
+#endif /* !(__ASSEMBLY__) */
+
+#define __HAVE_ARCH_SIGACTION
 
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal.h>
+
+#ifndef __ASSEMBLY__
 
 struct __new_sigaction {
 	__sighandler_t		sa_handler;
@@ -239,12 +213,6 @@
 	unsigned int    	sa_flags;
 	unsigned		sa_restorer;     /* not used by Linux/SPARC yet */
 };
-
-typedef struct sigaltstack {
-	void			*ss_sp;
-	int			ss_flags;
-	size_t			ss_size;
-} stack_t;
 
 #ifdef __KERNEL__
 typedef struct sigaltstack32 {
diff -ruN 2.5.22/include/asm-x86_64/signal.h 2.5.22-sfr.5/include/asm-x86_64/signal.h
--- 2.5.22/include/asm-x86_64/signal.h	Mon Jun 17 13:12:30 2002
+++ 2.5.22-sfr.5/include/asm-x86_64/signal.h	Tue Jun 18 15:10:10 2002
@@ -9,75 +9,12 @@
 struct siginfo;
 
 #ifdef __KERNEL__
-/* Most things should be clean enough to redefine this at will, if care
-   is taken to make libc match.  */
 
-#define _NSIG		64
 #define _NSIG_BPW	64
-#define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
-
-typedef unsigned long old_sigset_t;		/* at least 32 bits */
-
-typedef struct {
-	unsigned long sig[_NSIG_WORDS];
-} sigset_t;
-
-
-struct pt_regs; 
-asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
-
-
-#else
-/* Here we must cater to libcs that poke about in kernel headers.  */
-
-#define NSIG		32
-typedef unsigned long sigset_t;
 
 #endif /* __KERNEL__ */
 #endif
 
-#define SIGHUP		 1
-#define SIGINT		 2
-#define SIGQUIT		 3
-#define SIGILL		 4
-#define SIGTRAP		 5
-#define SIGABRT		 6
-#define SIGIOT		 6
-#define SIGBUS		 7
-#define SIGFPE		 8
-#define SIGKILL		 9
-#define SIGUSR1		10
-#define SIGSEGV		11
-#define SIGUSR2		12
-#define SIGPIPE		13
-#define SIGALRM		14
-#define SIGTERM		15
-#define SIGSTKFLT	16
-#define SIGCHLD		17
-#define SIGCONT		18
-#define SIGSTOP		19
-#define SIGTSTP		20
-#define SIGTTIN		21
-#define SIGTTOU		22
-#define SIGURG		23
-#define SIGXCPU		24
-#define SIGXFSZ		25
-#define SIGVTALRM	26
-#define SIGPROF		27
-#define SIGWINCH	28
-#define SIGIO		29
-#define SIGPOLL		SIGIO
-/*
-#define SIGLOST		29
-*/
-#define SIGPWR		30
-#define SIGSYS		31
-#define	SIGUNUSED	31
-
-/* These should not be considered constants from userland.  */
-#define SIGRTMIN	32
-#define SIGRTMAX	(_NSIG-1)
-
 /*
  * SA_FLAGS values:
  *
@@ -106,15 +43,6 @@
 
 #define SA_RESTORER	0x04000000
 
-/*
- * sigaltstack controls
- */
-#define SS_ONSTACK	1
-#define SS_DISABLE	2
-
-#define MINSIGSTKSZ	2048
-#define SIGSTKSZ	8192
-
 #ifdef __KERNEL__
 
 /*
@@ -129,40 +57,18 @@
 #define SA_SHIRQ		0x04000000
 #endif
 
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-#ifndef __ASSEMBLY__
-/* Type of a signal handler.  */
-typedef void (*__sighandler_t)(int);
+#define __HAVE_ARCH_OLD_SIGACTION
 
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
-
-#ifdef __KERNEL__
-struct sigaction {
-	__sighandler_t sa_handler;
-	unsigned long sa_flags;
-	void (*sa_restorer)(void);
-	sigset_t sa_mask;		/* mask last for extensibility */
-};
-
-struct k_sigaction {
-	struct sigaction sa;
-};
-#endif /* __KERNEL__ */
+#include <asm-generic/signal.h>
 
-typedef struct sigaltstack {
-	void *ss_sp;
-	int ss_flags;
-	size_t ss_size;
-} stack_t;
+#ifndef __ASSEMBLY__
 
 #ifdef __KERNEL__
 #include <asm/sigcontext.h>
 
+struct pt_regs; 
+asmlinkage int do_signal(struct pt_regs *regs, sigset_t *oldset);
+
 #undef __HAVE_ARCH_SIG_BITOPS
 #if 0
 
@@ -203,7 +109,7 @@
 	return word;
 }
 #endif
-#endif
 #endif /* __KERNEL__ */
+#endif
 
 #endif
