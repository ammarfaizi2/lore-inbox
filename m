Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbSJJFiS>; Thu, 10 Oct 2002 01:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262049AbSJJFiS>; Thu, 10 Oct 2002 01:38:18 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:31677 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262045AbSJJFiN>;
	Thu, 10 Oct 2002 01:38:13 -0400
Date: Thu, 10 Oct 2002 15:43:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org
Subject: [PATCH] bring sparc{64} into the generic siginfo fold
Message-Id: <20021010154332.578e1ead.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

This patch (uncompiled, untested) enables sparc and sparc64 to use
the gerneic siginfo structure.  Hope you like it :-)

diffstat:
 asm-generic/siginfo.h |   28 +++++++++++++++----
 asm-sparc/siginfo.h   |   71 +------------------------------------------------
 asm-sparc64/siginfo.h |   72 +-------------------------------------------------
3 files changed, 27 insertions(+), 144 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.41-1.747/include/asm-generic/siginfo.h 2.5.41-1.747-si.1/include/asm-generic/siginfo.h
--- 2.5.41-1.747/include/asm-generic/siginfo.h	2002-10-10 14:31:49.000000000 +1000
+++ 2.5.41-1.747-si.1/include/asm-generic/siginfo.h	2002-10-10 15:27:26.000000000 +1000
@@ -8,9 +8,21 @@
 	void *sival_ptr;
 } sigval_t;
 
+/*
+ * This is the size (including padding) of the part of the
+ * struct siginfo that is before the union.
+ */
+#ifndef __ARCH_SI_PREAMBLE_SIZE
+#define __ARCH_SI_PREAMBLE_SIZE	(3 * sizeof(int))
+#endif
+
 #define SI_MAX_SIZE	128
 #ifndef SI_PAD_SIZE
-#define SI_PAD_SIZE	((SI_MAX_SIZE/sizeof(int)) - 3)
+#define SI_PAD_SIZE	((SI_MAX_SIZE - __ARCH_SI_PREAMBLE_SIZE) / sizeof(int))
+#endif
+
+#ifndef __ARCH_SI_UID_T
+#define __ARCH_SI_UID_T	uid_t
 #endif
 
 #ifndef HAVE_ARCH_SIGINFO_T
@@ -26,7 +38,7 @@
 		/* kill() */
 		struct {
 			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
 		} _kill;
 
 		/* POSIX.1b timers */
@@ -38,14 +50,14 @@
 		/* POSIX.1b signals */
 		struct {
 			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
 			sigval_t _sigval;
 		} _rt;
 
 		/* SIGCHLD */
 		struct {
 			pid_t _pid;		/* which child */
-			uid_t _uid;		/* sender's uid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
 			int _status;		/* exit code */
 			clock_t _utime;
 			clock_t _stime;
@@ -54,6 +66,9 @@
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
 		struct {
 			void *_addr; /* faulting insn/memory ref. */
+#ifdef __ARCH_SI_TRAPNO
+			int _trapno;	/* TRAP # which caused the signal */
+#endif
 		} _sigfault;
 
 		/* SIGPOLL */
@@ -80,6 +95,9 @@
 #define si_int		_sifields._rt._sigval.sival_int
 #define si_ptr		_sifields._rt._sigval.sival_ptr
 #define si_addr		_sifields._sigfault._addr
+#ifdef __ARCH_SI_TRAPNO
+#define si_trapno	_sifields._sigfault._trapno
+#endif
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 
@@ -244,7 +262,7 @@
 		memcpy(to, from, sizeof(*to));
 	else
 		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
+		memcpy(to, from, __ARCH_SI_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
 }
 
 #endif
diff -ruN 2.5.41-1.747/include/asm-sparc/siginfo.h 2.5.41-1.747-si.1/include/asm-sparc/siginfo.h
--- 2.5.41-1.747/include/asm-sparc/siginfo.h	2002-06-03 12:13:01.000000000 +1000
+++ 2.5.41-1.747-si.1/include/asm-sparc/siginfo.h	2002-10-10 15:17:50.000000000 +1000
@@ -5,64 +5,12 @@
 #ifndef _SPARC_SIGINFO_H
 #define _SPARC_SIGINFO_H
 
-#define HAVE_ARCH_SIGINFO_T
-#define HAVE_ARCH_COPY_SIGINFO
+#define __ARCH_SI_UID_T		unsigned int
+#define __ARCH_SI_TRAPNO
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
 
-typedef struct siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE];
-
-		/* kill() */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			unsigned int _uid;	/* sender's uid */
-			sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			pid_t _pid;		/* which child */
-			unsigned int _uid;	/* sender's uid */
-			int _status;		/* exit code */
-			clock_t _utime;
-			clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			void *_addr;	/* faulting insn/memory ref. */
-			int  _trapno;	/* TRAP # which caused the signal */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} siginfo_t;
-
-#define si_trapno	_sifields._sigfault._trapno
-
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
 /*
@@ -71,19 +19,4 @@
 #define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
 #define NSIGEMT		1
 
-#ifdef __KERNEL__
-
-#include <linux/string.h>
-
-extern inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
-{
-	if (from->si_code < 0)
-		*to = *from;
-	else
-		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, 3*sizeof(int) + sizeof(from->_sifields._sigchld));
-}
-
-#endif /* __KERNEL__ */
-
 #endif /* !(_SPARC_SIGINFO_H) */
diff -ruN 2.5.41-1.747/include/asm-sparc64/siginfo.h 2.5.41-1.747-si.1/include/asm-sparc64/siginfo.h
--- 2.5.41-1.747/include/asm-sparc64/siginfo.h	2002-10-08 12:02:59.000000000 +1000
+++ 2.5.41-1.747-si.1/include/asm-sparc64/siginfo.h	2002-10-10 15:29:34.000000000 +1000
@@ -1,14 +1,13 @@
 #ifndef _SPARC64_SIGINFO_H
 #define _SPARC64_SIGINFO_H
 
-#define SI_PAD_SIZE	((SI_MAX_SIZE/sizeof(int)) - 4)
 #define SI_PAD_SIZE32	((SI_MAX_SIZE/sizeof(int)) - 3)
 
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
 #define SIGEV_PAD_SIZE32 ((SIGEV_MAX_SIZE/sizeof(int)) - 3)
 
-#define HAVE_ARCH_SIGINFO_T
-#define HAVE_ARCH_COPY_SIGINFO
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#define __ARCH_SI_TRAPNO
 #define HAVE_ARCH_COPY_SIGINFO_TO_USER
 
 #include <asm-generic/siginfo.h>
@@ -20,60 +19,6 @@
 	u32 sival_ptr;
 } sigval_t32;
 
-#endif /* __KERNEL__ */
-
-typedef struct siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE];
-
-		/* kill() */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			unsigned int _timer1;
-			unsigned int _timer2;
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
-			sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			pid_t _pid;		/* which child */
-			uid_t _uid;		/* sender's uid */
-			int _status;		/* exit code */
-			clock_t _utime;
-			clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			void *_addr; /* faulting insn/memory ref. */
-			int  _trapno; /* TRAP # which caused the signal */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			long _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-	} _sifields;
-} siginfo_t;
-
-#ifdef __KERNEL__
-
 typedef struct siginfo32 {
 	int si_signo;
 	int si_errno;
@@ -126,8 +71,6 @@
 
 #endif /* __KERNEL__ */
 
-#define si_trapno	_sifields._sigfault._trapno
-
 #define SI_NOINFO	32767		/* no information in siginfo_t */
 
 /*
@@ -152,17 +95,6 @@
 	} _sigev_un;
 } sigevent_t32;
 
-#include <linux/string.h>
-
-static inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
-{
-	if (from->si_code < 0)
-		*to = *from;
-	else
-		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, 4*sizeof(int) + sizeof(from->_sifields._sigchld));
-}
-
 extern int copy_siginfo_to_user32(siginfo_t32 *to, siginfo_t *from);
 
 #endif /* __KERNEL__ */
