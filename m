Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVATCNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVATCNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 21:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVATCNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 21:13:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:18571 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261834AbVATCHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 21:07:36 -0500
Date: Wed, 19 Jan 2005 18:07:34 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] consolidate arch specific resource.h headers
Message-ID: <20050119180734.L469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the include/asm-*/resource.h headers are the same as one another.
This patch makes one generic version, include/asm-generic/resource.h,
and uses that when appropriate.  The only vaguely interesting things here
are that the generic version introduces a new _STK_LIM_MAX macro, which can
be populated by an arch (ia64 and parisc needed that).  Also, some arches
hid RLIM_INFINITY under __KERNEL__, while others did not.  The generic
version does not, so the following arches will see that change:
    arm, arm26, mips, ppc, ppc64, sh (and hence sh64)

And, finally, some arches maintain their own order for the resource
numbers.  This is now marked by __ARCH_RLIMIT_ORDER, and is used by the
following arches:
    alpha, mips, sparc, and sparc64.

This actually uncovered a mips bug (fix already sent, this patch is
relative to that fix), where the default RLIMIT_MEMLOCK was set to
RLIM_INFINITY and RLIMIT_NPROC set to MLOCK_LIMIT (the latter is no big
deal because RLIMIT_NPROC default is overwritten dynamically during
bootup in fork_init()).  Also, this change makes alpha's default for
RLIMIT_NPROC change from RLIM_INFINITY to 0, but again...no problem as
it's dynamically overwritten during bootup.

The following arches are left untouched:
    m68knommu: untouched (uses m68k/resource.h)
    sh64: untouched (uses asm-sh/resource.h)
    um: untouched (uses arch code already)

Signed-off-by: Chris Wright <chrisw@osdl.org>

 include/asm-alpha/resource.h   |   22 +--------------
 include/asm-arm/resource.h     |   47 --------------------------------
 include/asm-arm26/resource.h   |   47 --------------------------------
 include/asm-cris/resource.h    |   47 --------------------------------
 include/asm-frv/resource.h     |   48 --------------------------------
 include/asm-generic/resource.h |   60 +++++++++++++++++++++++++++++++++++++++++
 include/asm-h8300/resource.h   |   47 --------------------------------
 include/asm-i386/resource.h    |   48 --------------------------------
 include/asm-ia64/resource.h    |   54 +-----------------------------------
 include/asm-m32r/resource.h    |   51 ----------------------------------
 include/asm-m68k/resource.h    |   47 --------------------------------
 include/asm-mips/resource.h    |   25 ++---------------
 include/asm-parisc/resource.h  |   48 +-------------------------------
 include/asm-ppc/resource.h     |   44 ------------------------------
 include/asm-ppc64/resource.h   |   53 ------------------------------------
 include/asm-s390/resource.h    |   47 --------------------------------
 include/asm-sh/resource.h      |   47 --------------------------------
 include/asm-sparc/resource.h   |   20 +------------
 include/asm-sparc64/resource.h |   26 +----------------
 include/asm-v850/resource.h    |   47 --------------------------------
 include/asm-x86_64/resource.h  |   47 --------------------------------
 21 files changed, 87 insertions(+), 835 deletions(-)

--- /dev/null	2005-01-14 06:27:56.540397616 -0800
+++ edited/include/asm-generic/resource.h	2005-01-19 15:35:51.000000000 -0800
@@ -0,0 +1,60 @@
+#ifndef _ASM_GENERIC_RESOURCE_H
+#define _ASM_GENERIC_RESOURCE_H
+
+/*
+ * Resource limits
+ */
+
+/* Allow arch to control resource order */
+#ifndef __ARCH_RLIMIT_ORDER
+#define RLIMIT_CPU		0	/* CPU time in ms */
+#define RLIMIT_FSIZE		1	/* Maximum filesize */
+#define RLIMIT_DATA		2	/* max data size */
+#define RLIMIT_STACK		3	/* max stack size */
+#define RLIMIT_CORE		4	/* max core file size */
+#define RLIMIT_RSS		5	/* max resident set size */
+#define RLIMIT_NPROC		6	/* max number of processes */
+#define RLIMIT_NOFILE		7	/* max number of open files */
+#define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
+#define RLIMIT_AS		9	/* address space limit */
+#define RLIMIT_LOCKS		10	/* maximum file locks held */
+#define RLIMIT_SIGPENDING	11	/* max number of pending signals */
+#define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
+
+#define RLIM_NLIMITS		13
+#endif
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
+#define INIT_RLIMITS							\
+{									\
+	[RLIMIT_CPU]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_FSIZE]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_DATA]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_STACK]		= {      _STK_LIM, _STK_LIM_MAX  },	\
+	[RLIMIT_CORE]		= {             0, RLIM_INFINITY },	\
+	[RLIMIT_RSS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_NPROC]		= {             0,             0 },	\
+	[RLIMIT_NOFILE]		= {      INR_OPEN,     INR_OPEN  },	\
+	[RLIMIT_MEMLOCK]	= {   MLOCK_LIMIT,   MLOCK_LIMIT },	\
+	[RLIMIT_AS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_LOCKS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
+	[RLIMIT_MSGQUEUE]	= { MQ_BYTES_MAX, MQ_BYTES_MAX },	\
+}
+
+#endif	/* __KERNEL__ */
+
+#endif
===== include/asm-alpha/resource.h 1.5 vs edited =====
--- 1.5/include/asm-alpha/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-alpha/resource.h	2005-01-19 15:26:39 -08:00
@@ -20,6 +20,7 @@
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
 #define RLIM_NLIMITS	13
+#define __ARCH_RLIMIT_ORDER
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
@@ -28,25 +29,6 @@
  */
 #define RLIM_INFINITY	0x7ffffffffffffffful
 
-#ifdef __KERNEL__
-
-#define INIT_RLIMITS							\
-{									\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_CPU */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_FSIZE */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_DATA */	\
-    {_STK_LIM, LONG_MAX},			/* RLIMIT_STACK */	\
-    {       0, LONG_MAX},			/* RLIMIT_CORE */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_RSS */	\
-    {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {MLOCK_LIMIT, MLOCK_LIMIT },		/* RLIMIT_MEMLOCK */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_LOCKS */	\
-    {MAX_SIGPENDING, MAX_SIGPENDING},		/* RLIMIT_SIGPENDING */ \
-    {MQ_BYTES_MAX, MQ_BYTES_MAX},		/* RLIMIT_MSGQUEUE */	\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* _ALPHA_RESOURCE_H */
===== include/asm-arm/resource.h 1.5 vs edited =====
--- 1.5/include/asm-arm/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-arm/resource.h	2005-01-18 16:08:40 -08:00
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
===== include/asm-arm26/resource.h 1.5 vs edited =====
--- 1.5/include/asm-arm26/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-arm26/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-cris/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-frv/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-h8300/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-i386/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-ia64/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-m32r/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-m68k/resource.h	2005-01-18 16:08:40 -08:00
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
===== include/asm-mips/resource.h 1.7 vs edited =====
--- 1.7/include/asm-mips/resource.h	2005-01-19 17:40:06 -08:00
+++ edited/include/asm-mips/resource.h	2005-01-19 17:42:39 -08:00
@@ -27,15 +27,13 @@
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
 #define RLIM_NLIMITS 13			/* Number of limit flavors.  */
-
-#ifdef __KERNEL__
-
-#include <linux/config.h>
+#define __ARCH_RLIMIT_ORDER
 
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
  */
+#include <linux/config.h>
 #ifdef CONFIG_MIPS32
 #define RLIM_INFINITY	0x7fffffffUL
 #endif
@@ -43,23 +41,6 @@
 #define RLIM_INFINITY	(~0UL)
 #endif
 
-#define INIT_RLIMITS					\
-{							\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ _STK_LIM,      RLIM_INFINITY },		\
-	{        0,      RLIM_INFINITY },		\
-	{ INR_OPEN,      INR_OPEN      },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ 0,             0             },		\
-	{ MLOCK_LIMIT,   MLOCK_LIMIT   },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
-	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
-	{ MQ_BYTES_MAX, MQ_BYTES_MAX },			\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* _ASM_RESOURCE_H */
===== include/asm-parisc/resource.h 1.5 vs edited =====
--- 1.5/include/asm-parisc/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-parisc/resource.h	2005-01-18 16:08:40 -08:00
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
===== include/asm-ppc/resource.h 1.7 vs edited =====
--- 1.7/include/asm-ppc/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-ppc/resource.h	2005-01-18 16:08:40 -08:00
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
===== include/asm-ppc64/resource.h 1.5 vs edited =====
--- 1.5/include/asm-ppc64/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-ppc64/resource.h	2005-01-18 16:08:40 -08:00
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
===== include/asm-s390/resource.h 1.6 vs edited =====
--- 1.6/include/asm-s390/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-s390/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-sh/resource.h	2005-01-18 16:08:40 -08:00
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
===== include/asm-sparc/resource.h 1.5 vs edited =====
--- 1.5/include/asm-sparc/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-sparc/resource.h	2005-01-19 15:29:01 -08:00
@@ -26,6 +26,7 @@
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
 #define RLIM_NLIMITS	13
+#define __ARCH_RLIMIT_ORDER
 
 /*
  * SuS says limits have to be unsigned.
@@ -34,23 +35,6 @@
  */
 #define RLIM_INFINITY	0x7fffffff
 
-#ifdef __KERNEL__
-#define INIT_RLIMITS			\
-{					\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {_STK_LIM, RLIM_INFINITY},		\
-    {       0, RLIM_INFINITY},		\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {MLOCK_LIMIT,   MLOCK_LIMIT},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {MAX_SIGPENDING, MAX_SIGPENDING},	\
-    {MQ_BYTES_MAX, MQ_BYTES_MAX},	\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* !(_SPARC_RESOURCE_H) */
===== include/asm-sparc64/resource.h 1.5 vs edited =====
--- 1.5/include/asm-sparc64/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-sparc64/resource.h	2005-01-19 15:29:46 -08:00
@@ -26,30 +26,8 @@
 #define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
 
 #define RLIM_NLIMITS	13
+#define __ARCH_RLIMIT_ORDER
 
-/*
- * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
- */
-#define RLIM_INFINITY	(~0UL)
-
-#ifdef __KERNEL__
-#define INIT_RLIMITS			\
-{					\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {_STK_LIM, RLIM_INFINITY},		\
-    {       0, RLIM_INFINITY},		\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {  MLOCK_LIMIT,   MLOCK_LIMIT},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
-    {MAX_SIGPENDING, MAX_SIGPENDING},	\
-    {MQ_BYTES_MAX, MQ_BYTES_MAX},	\
-}
-
-#endif /* __KERNEL__ */
+#include <asm-generic/resource.h>
 
 #endif /* !(_SPARC64_RESOURCE_H) */
===== include/asm-v850/resource.h 1.5 vs edited =====
--- 1.5/include/asm-v850/resource.h	2004-08-23 01:15:26 -07:00
+++ edited/include/asm-v850/resource.h	2005-01-18 16:08:40 -08:00
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
+++ edited/include/asm-x86_64/resource.h	2005-01-18 16:08:40 -08:00
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
