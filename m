Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbTGNQno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270604AbTGNQno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:43:44 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:23486 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S270650AbTGNQkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:40:46 -0400
Date: Tue, 15 Jul 2003 02:52:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@napali.hpl.hp.com>,
       anton@samba.org, ak@muc.de, schwidefsky@de.ibm.com, matthew@wil.cx
Subject: Re: sizeof (siginfo_t) problem
Message-Id: <20030715025252.17ec8d6f.sfr@canb.auug.org.au>
In-Reply-To: <20030714084000.J15481@devserv.devel.redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 08:40:00 -0400 Jakub Jelinek <jakub@redhat.com> wrote:
>
> The kernel unfortunately does this right on sparc64 and alpha from 64-bit
> arches only; ia64, s390x, ppc64 etc. got it wrong.

David Mosberger is correct that ia64 is OK (because it basically uses its
own siginfo.h as does mips64).  The following is an update of a patch that
was lost a while ago (when __ARCH_SI_PREAMBLE_SIZE was invented).

I am not sure if the s390 fix is correct (since s390x has been merged) or
if x86_64 needs this (as I cannot remember the alignment needs of the
x86_64 compiler - though I suspect it is needed).

I have no idea if parisc is correct on 64 bit platforms (probably not).

This has been neither compiled or tested, but should be close.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff -ruN 2.6.0-test1/include/asm-generic/siginfo.h 2.6.0-test1-sfr.1/include/asm-generic/siginfo.h
--- 2.6.0-test1/include/asm-generic/siginfo.h	2003-04-20 14:12:49.000000000 +1000
+++ 2.6.0-test1-sfr.1/include/asm-generic/siginfo.h	2003-07-15 02:41:47.000000000 +1000
@@ -142,7 +142,6 @@
 #define SI_FROMUSER(siptr)	((siptr)->si_code <= 0)
 #define SI_FROMKERNEL(siptr)	((siptr)->si_code > 0)
 
-#ifndef HAVE_ARCH_SI_CODES
 /*
  * SIGILL si_codes
  */
@@ -213,8 +212,6 @@
 #define POLL_HUP	(__SI_POLL|6)	/* device disconnected */
 #define NSIGPOLL	6
 
-#endif
-
 /*
  * sigevent definitions
  * 
diff -ruN 2.6.0-test1/include/asm-ppc64/siginfo.h 2.6.0-test1-sfr.1/include/asm-ppc64/siginfo.h
--- 2.6.0-test1/include/asm-ppc64/siginfo.h	2002-11-05 17:00:34.000000000 +1100
+++ 2.6.0-test1-sfr.1/include/asm-ppc64/siginfo.h	2003-07-15 02:28:22.000000000 +1000
@@ -8,8 +8,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#define SI_PAD_SIZE    ((SI_MAX_SIZE/sizeof(int)) - 4)
-#define SI_PAD_SIZE32  ((SI_MAX_SIZE/sizeof(int)) - 3)
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#define SI_PAD_SIZE32		((SI_MAX_SIZE/sizeof(int)) - 3)
 
 #include <asm-generic/siginfo.h>
 
diff -ruN 2.6.0-test1/include/asm-s390/siginfo.h 2.6.0-test1-sfr.1/include/asm-s390/siginfo.h
--- 2.6.0-test1/include/asm-s390/siginfo.h	2002-11-05 16:58:19.000000000 +1100
+++ 2.6.0-test1-sfr.1/include/asm-s390/siginfo.h	2003-07-15 02:34:55.000000000 +1000
@@ -9,78 +9,12 @@
 #ifndef _S390_SIGINFO_H
 #define _S390_SIGINFO_H
 
-#define HAVE_ARCH_SI_CODES
+#include <linux/config.h>
 
-#include <asm-generic/siginfo.h>
-
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
+#ifdef CONFIG_ARCH_S390X
+#define	__ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#endif
 
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
+#include <asm-generic/siginfo.h>
 
 #endif
diff -ruN 2.6.0-test1/include/asm-x86_64/siginfo.h 2.6.0-test1-sfr.1/include/asm-x86_64/siginfo.h
--- 2.6.0-test1/include/asm-x86_64/siginfo.h	2002-11-05 16:58:09.000000000 +1100
+++ 2.6.0-test1-sfr.1/include/asm-x86_64/siginfo.h	2003-07-15 02:38:49.000000000 +1000
@@ -1,6 +1,9 @@
 #ifndef _X8664_SIGINFO_H
 #define _X8664_SIGINFO_H
 
+#define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
+#define SIGEV_PAD_SIZE		((SIGEV_MAX_SIZE/sizeof(int)) - 4)
+
 #include <asm-generic/siginfo.h>
 
 #endif
