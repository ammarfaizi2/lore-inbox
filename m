Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbSJQMfI>; Thu, 17 Oct 2002 08:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbSJQMfI>; Thu, 17 Oct 2002 08:35:08 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:43442 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261681AbSJQMep>;
	Thu, 17 Oct 2002 08:34:45 -0400
Date: Thu, 17 Oct 2002 22:39:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com
Subject: [PATCH][2.5.43-BK] Hopefully last siginfo.h cleanups
Message-Id: <20021017223943.22d3c3c0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is hopefully the last asm*/siginfo.h cleanup.

	The introduction of __ARCH_SI_PREAMBLE_SIZE means that Alpha
		can use the gerneic copy_siginfo
	PPC64 need to change to use __ARCH_SI_PREAMBLE_SIZE and this
		actually fixes a bug in copy_siginfo for PPC64
	S390 and S390X have both been changed to used the generic
		so_code values, so they can be removed from the
		archecture specific files - this means that
		HAVE_ARCH_SI_CODES is not longer needed

diffstat:
 asm-alpha/siginfo.h   |   19 -------------
 asm-generic/siginfo.h |    3 --
 asm-ppc64/siginfo.h   |    4 +-
 asm-s390/siginfo.h    |   72 ------------------------------------------
 asm-s390x/siginfo.h   |   72 ------------------------------------------
 5 files changed, 3 insertions(+), 167 deletions(-)

Please apply.  This patch is against a recent 2.5.43-BK tree.	

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.43-1.793/include/asm-alpha/siginfo.h 2.5.43-1.793-sfr.1/include/asm-alpha/siginfo.h
--- 2.5.43-1.793/include/asm-alpha/siginfo.h	2002-07-17 11:28:20.000000000 +1000
+++ 2.5.43-1.793-sfr.1/include/asm-alpha/siginfo.h	2002-10-17 21:45:27.000000000 +1000
@@ -1,26 +1,9 @@
 #ifndef _ALPHA_SIGINFO_H
 #define _ALPHA_SIGINFO_H
 
-#define SI_PAD_SIZE	((SI_MAX_SIZE/sizeof(int)) - 4)
-
+#define __ARCH_SI_PREAMBLE_SIZE		(4 * sizeof(int))
 #define SIGEV_PAD_SIZE	((SIGEV_MAX_SIZE/sizeof(int)) - 4)
 
-#define HAVE_ARCH_COPY_SIGINFO
-
 #include <asm-generic/siginfo.h>
 
-#ifdef __KERNEL__
-#include <linux/string.h>
-
-extern inline void copy_siginfo(siginfo_t *to, siginfo_t *from)
-{
-	if (from->si_code < 0)
-		memcpy(to, from, sizeof(siginfo_t));
-	else
-		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, 4*sizeof(int) + sizeof(from->_sifields._sigchld));
-}
-
-#endif /* __KERNEL__ */
-
 #endif
diff -ruN 2.5.43-1.793/include/asm-generic/siginfo.h 2.5.43-1.793-sfr.1/include/asm-generic/siginfo.h
--- 2.5.43-1.793/include/asm-generic/siginfo.h	2002-10-17 17:42:29.000000000 +1000
+++ 2.5.43-1.793-sfr.1/include/asm-generic/siginfo.h	2002-10-17 22:15:44.000000000 +1000
@@ -137,7 +137,6 @@
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
 
-#ifndef HAVE_ARCH_SI_CODES
 /*
  * SIGILL si_codes
  */
@@ -208,8 +207,6 @@
 #define POLL_HUP	(__SI_POLL|6)	/* device disconnected */
 #define NSIGPOLL	6
 
-#endif
-
 /*
  * sigevent definitions
  * 
diff -ruN 2.5.43-1.793/include/asm-ppc64/siginfo.h 2.5.43-1.793-sfr.1/include/asm-ppc64/siginfo.h
--- 2.5.43-1.793/include/asm-ppc64/siginfo.h	2002-10-17 17:42:32.000000000 +1000
+++ 2.5.43-1.793-sfr.1/include/asm-ppc64/siginfo.h	2002-10-17 21:59:48.000000000 +1000
@@ -8,8 +8,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define SI_PAD_SIZE    ((SI_MAX_SIZE/sizeof(int)) - 4)
-#define SI_PAD_SIZE32  ((SI_MAX_SIZE/sizeof(int)) - 3)
+#define __ARCH_SI_PREAMBLE_SIZE		(4 * sizeof(int))
+#define SI_PAD_SIZE32			((SI_MAX_SIZE/sizeof(int)) - 3)
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.5.43-1.793/include/asm-s390/siginfo.h 2.5.43-1.793-sfr.1/include/asm-s390/siginfo.h
--- 2.5.43-1.793/include/asm-s390/siginfo.h	2002-06-09 16:12:33.000000000 +1000
+++ 2.5.43-1.793-sfr.1/include/asm-s390/siginfo.h	2002-10-17 22:12:20.000000000 +1000
@@ -9,78 +9,6 @@
 #ifndef _S390_SIGINFO_H
 #define _S390_SIGINFO_H
 
-#define HAVE_ARCH_SI_CODES
-
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGILL si_codes
- */
-#define ILL_ILLOPC	(__SI_FAULT|1)	/* illegal opcode */
-#define ILL_ILLOPN	(__SI_FAULT|2)	/* illegal operand */
-#define ILL_ILLADR	(__SI_FAULT|3)	/* illegal addressing mode */
-#define ILL_ILLTRP	(__SI_FAULT|4)	/* illegal trap */
-#define ILL_PRVOPC	(__SI_FAULT|5)	/* privileged opcode */
-#define ILL_PRVREG	(__SI_FAULT|6)	/* privileged register */
-#define ILL_COPROC	(__SI_FAULT|7)	/* coprocessor error */
-#define ILL_BADSTK	(__SI_FAULT|8)	/* internal stack error */
-#define NSIGILL		8
-
-/*
- * SIGFPE si_codes
- */
-#define FPE_INTDIV	(__SI_FAULT|1)	/* integer divide by zero */
-#define FPE_INTOVF	(__SI_FAULT|2)	/* integer overflow */
-#define FPE_FLTDIV	(__SI_FAULT|3)	/* floating point divide by zero */
-#define FPE_FLTOVF	(__SI_FAULT|4)	/* floating point overflow */
-#define FPE_FLTUND	(__SI_FAULT|5)	/* floating point underflow */
-#define FPE_FLTRES	(__SI_FAULT|6)	/* floating point inexact result */
-#define FPE_FLTINV	(__SI_FAULT|7)	/* floating point invalid operation */
-#define FPE_FLTSUB	(__SI_FAULT|8)	/* subscript out of range */
-#define NSIGFPE		8
-
-/*
- * SIGSEGV si_codes
- */
-#define SEGV_MAPERR	(__SI_FAULT|1)	/* address not mapped to object */
-#define SEGV_ACCERR	(__SI_FAULT|2)	/* invalid permissions for mapped object */
-#define NSIGSEGV	2
-
-/*
- * SIGBUS si_codes
- */
-#define BUS_ADRALN	(__SI_FAULT|1)	/* invalid address alignment */
-#define BUS_ADRERR	(__SI_FAULT|2)	/* non-existant physical address */
-#define BUS_OBJERR	(__SI_FAULT|3)	/* object specific hardware error */
-#define NSIGBUS		3
-
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_BRKPT	(__SI_FAULT|1)	/* process breakpoint */
-#define TRAP_TRACE	(__SI_FAULT|2)	/* process trace trap */
-#define NSIGTRAP	2
-
-/*
- * SIGCHLD si_codes
- */
-#define CLD_EXITED	(__SI_CHLD|1)	/* child has exited */
-#define CLD_KILLED	(__SI_CHLD|2)	/* child was killed */
-#define CLD_DUMPED	(__SI_CHLD|3)	/* child terminated abnormally */
-#define CLD_TRAPPED	(__SI_CHLD|4)	/* traced child has trapped */
-#define CLD_STOPPED	(__SI_CHLD|5)	/* child has stopped */
-#define CLD_CONTINUED	(__SI_CHLD|6)	/* stopped child has continued */
-#define NSIGCHLD	6
-
-/*
- * SIGPOLL si_codes
- */
-#define POLL_IN		(__SI_POLL|1)	/* data input available */
-#define POLL_OUT	(__SI_POLL|2)	/* output buffers available */
-#define POLL_MSG	(__SI_POLL|3)	/* input message available */
-#define POLL_ERR	(__SI_POLL|4)	/* i/o error */
-#define POLL_PRI	(__SI_POLL|5)	/* high priority input available */
-#define POLL_HUP	(__SI_POLL|6)	/* device disconnected */
-#define NSIGPOLL	6
-
 #endif
diff -ruN 2.5.43-1.793/include/asm-s390x/siginfo.h 2.5.43-1.793-sfr.1/include/asm-s390x/siginfo.h
--- 2.5.43-1.793/include/asm-s390x/siginfo.h	2002-06-09 16:12:33.000000000 +1000
+++ 2.5.43-1.793-sfr.1/include/asm-s390x/siginfo.h	2002-10-17 22:13:47.000000000 +1000
@@ -9,78 +9,6 @@
 #ifndef _S390_SIGINFO_H
 #define _S390_SIGINFO_H
 
-#define HAVE_ARCH_SI_CODES
-
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGILL si_codes
- */
-#define ILL_ILLOPC	(__SI_FAULT|1)	/* illegal opcode */
-#define ILL_ILLOPN	(__SI_FAULT|2)	/* illegal operand */
-#define ILL_ILLADR	(__SI_FAULT|3)	/* illegal addressing mode */
-#define ILL_ILLTRP	(__SI_FAULT|4)	/* illegal trap */
-#define ILL_PRVOPC	(__SI_FAULT|5)	/* privileged opcode */
-#define ILL_PRVREG	(__SI_FAULT|6)	/* privileged register */
-#define ILL_COPROC	(__SI_FAULT|7)	/* coprocessor error */
-#define ILL_BADSTK	(__SI_FAULT|8)	/* internal stack error */
-#define NSIGILL		8
-
-/*
- * SIGFPE si_codes
- */
-#define FPE_INTDIV	(__SI_FAULT|1)	/* integer divide by zero */
-#define FPE_INTOVF	(__SI_FAULT|2)	/* integer overflow */
-#define FPE_FLTDIV	(__SI_FAULT|3)	/* floating point divide by zero */
-#define FPE_FLTOVF	(__SI_FAULT|4)	/* floating point overflow */
-#define FPE_FLTUND	(__SI_FAULT|5)	/* floating point underflow */
-#define FPE_FLTRES	(__SI_FAULT|6)	/* floating point inexact result */
-#define FPE_FLTINV	(__SI_FAULT|7)	/* floating point invalid operation */
-#define FPE_FLTSUB	(__SI_FAULT|8)	/* subscript out of range */
-#define NSIGFPE		8
-
-/*
- * SIGSEGV si_codes
- */
-#define SEGV_MAPERR	(__SI_FAULT|1)	/* address not mapped to object */
-#define SEGV_ACCERR	(__SI_FAULT|2)	/* invalid permissions for mapped object */
-#define NSIGSEGV	2
-
-/*
- * SIGBUS si_codes
- */
-#define BUS_ADRALN	(__SI_FAULT|1)	/* invalid address alignment */
-#define BUS_ADRERR	(__SI_FAULT|2)	/* non-existant physical address */
-#define BUS_OBJERR	(__SI_FAULT|3)	/* object specific hardware error */
-#define NSIGBUS		3
-
-/*
- * SIGTRAP si_codes
- */
-#define TRAP_BRKPT	(__SI_FAULT|1)	/* process breakpoint */
-#define TRAP_TRACE	(__SI_FAULT|2)	/* process trace trap */
-#define NSIGTRAP	2
-
-/*
- * SIGCHLD si_codes
- */
-#define CLD_EXITED	(__SI_CHLD|1)	/* child has exited */
-#define CLD_KILLED	(__SI_CHLD|2)	/* child was killed */
-#define CLD_DUMPED	(__SI_CHLD|3)	/* child terminated abnormally */
-#define CLD_TRAPPED	(__SI_CHLD|4)	/* traced child has trapped */
-#define CLD_STOPPED	(__SI_CHLD|5)	/* child has stopped */
-#define CLD_CONTINUED	(__SI_CHLD|6)	/* stopped child has continued */
-#define NSIGCHLD	6
-
-/*
- * SIGPOLL si_codes
- */
-#define POLL_IN		(__SI_POLL|1)	/* data input available */
-#define POLL_OUT	(__SI_POLL|2)	/* output buffers available */
-#define POLL_MSG	(__SI_POLL|3)	/* input message available */
-#define POLL_ERR	(__SI_POLL|4)	/* i/o error */
-#define POLL_PRI	(__SI_POLL|5)	/* high priority input available */
-#define POLL_HUP	(__SI_POLL|6)	/* device disconnected */
-#define NSIGPOLL	6
-
 #endif
