Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVASAOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVASAOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVASAOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:14:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:11490 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261495AbVASALD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:11:03 -0500
Date: Tue, 18 Jan 2005 16:10:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] consolidate arch specific resource.h headers
Message-ID: <20050118161056.H469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the include/asm-*/resource.h headers are the same as one another.
This patch makes one generic version, include/asm-generic/resource.h,
and uses that when appropriate.  The only vaguely interesting thing here
is that the generic version introduces a new _STK_LIM_MAX macro, which can
be populated by an arch (ia64 and parisc needed that).  Also, some arches
hid RLIM_INFINITY under __KERNEL__, while others did not.  The generic
version does not, so the following arches will see that change:
    arm, arm26, ppc, ppc64, sh (and hence sh64)

The following arches are left untouched:
    alpha: untouched (arch specific resource numbers)
    m68knommu: untouched (uses m68k/resource.h)
    mips: untouched (arch specific resource numbers)
    sh64: untouched (uses asm-sh/resource.h)
    sparc: untouched (arch specific resource numbers)
    sparc64: untouched (arch specific resource numbers)
    um: unoutched (uses arch code already)

Thoughts?

 asm-arm/resource.h     |   47 ----------------------------------------
 asm-arm26/resource.h   |   47 ----------------------------------------
 asm-cris/resource.h    |   47 ----------------------------------------
 asm-frv/resource.h     |   48 -----------------------------------------
 asm-generic/resource.h |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 asm-h8300/resource.h   |   47 ----------------------------------------
 asm-i386/resource.h    |   48 -----------------------------------------
 asm-ia64/resource.h    |   54 +---------------------------------------------
 asm-m32r/resource.h    |   51 -------------------------------------------
 asm-m68k/resource.h    |   47 ----------------------------------------
 asm-parisc/resource.h  |   48 +----------------------------------------
 asm-ppc/resource.h     |   44 -------------------------------------
 asm-ppc64/resource.h   |   53 ---------------------------------------------
 asm-s390/resource.h    |   47 ----------------------------------------
 asm-sh/resource.h      |   47 ----------------------------------------
 asm-v850/resource.h    |   47 ----------------------------------------
 asm-x86_64/resource.h  |   47 ----------------------------------------
 17 files changed, 75 insertions(+), 751 deletions(-)

--- /dev/null	2005-01-14 06:27:56.540397616 -0800
+++ edited/include/asm-generic/resource.h	2005-01-18 14:19:33.000000000 -0800
@@ -0,0 +1,57 @@
+#ifndef _ASM_GENERIC_RESOURCE_H
+#define _ASM_GENERIC_RESOURCE_H
+
+/*
+ * Resource limits
+ */
+
+#define RLIMIT_CPU	0		/* CPU time in ms */
+#define RLIMIT_FSIZE	1		/* Maximum filesize */
+#define RLIMIT_DATA	2		/* max data size */
+#define RLIMIT_STACK	3		/* max stack size */
+#define RLIMIT_CORE	4		/* max core file size */
+#define RLIMIT_RSS	5		/* max resident set size */
+#define RLIMIT_NPROC	6		/* max number of processes */
+#define RLIMIT_NOFILE	7		/* max number of open files */
+#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
+#define RLIMIT_AS	9		/* address space limit */
+#define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
+#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
+
+#define RLIM_NLIMITS	13
+
+/*
+ * SuS says limits have to be unsigned.
+ * Which makes a ton more sense anyway.
+ */
+#ifndef RLIM_INFINITY
+#define RLIM_INFINITY	(~0UL)
+#endif
+
+#ifndef _STK_LIM_MAX
+#define _STK_LIM_MAX	RLIM_INFINITY
+#endif
+
+#ifdef __KERNEL__
+
+#define INIT_RLIMITS					\
+{							\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{      _STK_LIM, _STK_LIM_MAX  },		\
+	{             0, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{             0,             0 },		\
+	{      INR_OPEN,     INR_OPEN  },		\
+	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
+	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
+}
+
+#endif /* __KERNEL__ */
+
+#endif
===== include/asm-arm26/resource.h 1.5 vs edited =====
--- 1.5/include/asm-arm26/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-arm26/resource.h	2005-01-18 13:58:55 -08:00
@@ -1,51 +1,6 @@
 #ifndef _ARM_RESOURCE_H
 #define _ARM_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-#ifdef __KERNEL__
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#define INIT_RLIMITS				\
-{						\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ _STK_LIM,      RLIM_INFINITY },	\
-	{ 0,             RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ 0,             0             },	\
-	{ INR_OPEN,      INR_OPEN      },	\
-	{ MLOCK_LIMIT,	 MLOCK_LIMIT   },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX},		\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif
===== include/asm-arm/resource.h 1.5 vs edited =====
--- 1.5/include/asm-arm/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-arm/resource.h	2005-01-18 14:00:36 -08:00
@@ -1,51 +1,6 @@
 #ifndef _ARM_RESOURCE_H
 #define _ARM_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-#ifdef __KERNEL__
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#define INIT_RLIMITS				\
-{						\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ _STK_LIM,      RLIM_INFINITY },	\
-	{ 0,             RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ 0,             0             },	\
-	{ INR_OPEN,      INR_OPEN      },	\
-	{ MLOCK_LIMIT,	 MLOCK_LIMIT   },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
-	{ MAX_SIGPENDING, MAX_SIGPENDING},	\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX},		\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif
===== include/asm-cris/resource.h 1.5 vs edited =====
--- 1.5/include/asm-cris/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-cris/resource.h	2005-01-18 14:01:04 -08:00
@@ -1,51 +1,6 @@
 #ifndef _CRIS_RESOURCE_H
 #define _CRIS_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },               \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif
===== include/asm-frv/resource.h 1.1 vs edited =====
--- 1.1/include/asm-frv/resource.h	2005-01-04 18:48:06 -08:00
+++ edited/include/asm-frv/resource.h	2005-01-18 14:07:48 -08:00
@@ -1,53 +1,7 @@
 #ifndef _ASM_RESOURCE_H
 #define _ASM_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-        { RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* _ASM_RESOURCE_H */
 
===== include/asm-h8300/resource.h 1.5 vs edited =====
--- 1.5/include/asm-h8300/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-h8300/resource.h	2005-01-18 14:08:55 -08:00
@@ -1,51 +1,6 @@
 #ifndef _H8300_RESOURCE_H
 #define _H8300_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* _H8300_RESOURCE_H */
===== include/asm-i386/resource.h 1.5 vs edited =====
--- 1.5/include/asm-i386/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-i386/resource.h	2005-01-18 13:54:06 -08:00
@@ -1,52 +1,6 @@
 #ifndef _I386_RESOURCE_H
 #define _I386_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif
===== include/asm-ia64/resource.h 1.7 vs edited =====
--- 1.7/include/asm-ia64/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-ia64/resource.h	2005-01-18 14:22:04 -08:00
@@ -1,58 +1,8 @@
 #ifndef _ASM_IA64_RESOURCE_H
 #define _ASM_IA64_RESOURCE_H
 
-/*
- * Resource limits
- *
- * Based on <asm-i386/resource.h>.
- *
- * Modified 1998, 1999
- *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
- */
-
 #include <asm/ustack.h>
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY  (~0UL)
-
-# ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, DEFAULT_USER_STACK_SIZE },	\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-# endif /* __KERNEL__ */
+#define _STK_LIM_MAX	DEFAULT_USER_STACK_SIZE
+#include <asm-generic/resource.h>
 
 #endif /* _ASM_IA64_RESOURCE_H */
===== include/asm-m32r/resource.h 1.3 vs edited =====
--- 1.3/include/asm-m32r/resource.h	2004-09-24 01:27:50 -07:00
+++ edited/include/asm-m32r/resource.h	2005-01-18 14:23:07 -08:00
@@ -1,55 +1,6 @@
 #ifndef _ASM_M32R_RESOURCE_H
 #define _ASM_M32R_RESOURCE_H
 
-/* $Id$ */
-
-/* orig : i386 2.4.18 */
-
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE	12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{ MLOCK_LIMIT,   MLOCK_LIMIT   },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif  /* _ASM_M32R_RESOURCE_H */
===== include/asm-m68k/resource.h 1.6 vs edited =====
--- 1.6/include/asm-m68k/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-m68k/resource.h	2005-01-18 14:25:21 -08:00
@@ -1,51 +1,6 @@
 #ifndef _M68K_RESOURCE_H
 #define _M68K_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* _M68K_RESOURCE_H */
===== include/asm-parisc/resource.h 1.5 vs edited =====
--- 1.5/include/asm-parisc/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-parisc/resource.h	2005-01-18 14:32:15 -08:00
@@ -1,51 +1,7 @@
 #ifndef _ASM_PARISC_RESOURCE_H
 #define _ASM_PARISC_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY   (~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, 10 * _STK_LIM },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#define _STK_LIM_MAX	10 * _STK_LIM
+#include <asm-generic/resource.h>
 
 #endif
===== include/asm-ppc64/resource.h 1.5 vs edited =====
--- 1.5/include/asm-ppc64/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-ppc64/resource.h	2005-01-18 14:40:03 -08:00
@@ -1,57 +1,6 @@
 #ifndef _PPC64_RESOURCE_H
 #define _PPC64_RESOURCE_H
 
-/*
- * Copyright (C) 2001 PPC 64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit(?) */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-#ifdef __KERNEL__
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-
-#define INIT_RLIMITS							\
-{									\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* _PPC64_RESOURCE_H */
===== include/asm-ppc/resource.h 1.7 vs edited =====
--- 1.7/include/asm-ppc/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-ppc/resource.h	2005-01-18 14:43:46 -08:00
@@ -1,48 +1,6 @@
 #ifndef _PPC_RESOURCE_H
 #define _PPC_RESOURCE_H
 
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit(?) */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-#ifdef __KERNEL__
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-
-#define INIT_RLIMITS							\
-{									\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif
===== include/asm-s390/resource.h 1.6 vs edited =====
--- 1.6/include/asm-s390/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-s390/resource.h	2005-01-18 14:53:21 -08:00
@@ -9,52 +9,7 @@
 #ifndef _S390_RESOURCE_H
 #define _S390_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY   (~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{ INR_OPEN, INR_OPEN },                         \
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif
 
===== include/asm-sh/resource.h 1.5 vs edited =====
--- 1.5/include/asm-sh/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-sh/resource.h	2005-01-18 14:57:37 -08:00
@@ -1,51 +1,6 @@
 #ifndef __ASM_SH_RESOURCE_H
 #define __ASM_SH_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-#ifdef __KERNEL__
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* __ASM_SH_RESOURCE_H */
===== include/asm-v850/resource.h 1.5 vs edited =====
--- 1.5/include/asm-v850/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-v850/resource.h	2005-01-18 15:15:49 -08:00
@@ -1,51 +1,6 @@
 #ifndef __V850_RESOURCE_H__
 #define __V850_RESOURCE_H__
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* __V850_RESOURCE_H__ */
===== include/asm-x86_64/resource.h 1.5 vs edited =====
--- 1.5/include/asm-x86_64/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-x86_64/resource.h	2005-01-18 15:17:50 -08:00
@@ -1,51 +1,6 @@
 #ifndef _X8664_RESOURCE_H
 #define _X8664_RESOURCE_H
 
-/*
- * Resource limits
- */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NPROC	6		/* max number of processes */
-#define RLIMIT_NOFILE	7		/* max number of open files */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{      _STK_LIM, RLIM_INFINITY },		\
-	{             0, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{             0,             0 },		\
-	{      INR_OPEN,     INR_OPEN  },		\
-	{   MLOCK_LIMIT,   MLOCK_LIMIT },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif

