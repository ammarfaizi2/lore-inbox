Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVBISDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVBISDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVBISD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:03:27 -0500
Received: from mx1.elte.hu ([157.181.1.137]:65495 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261868AbVBISC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:02:29 -0500
Date: Wed, 9 Feb 2005 19:02:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davem@redhat.com,
       chrisw@osdl.org
Subject: Re: [patch, BK] clean up and unify asm-*/resource.h files
Message-ID: <20050209180219.GC23554@elte.hu>
References: <20050209093927.GA9726@elte.hu> <20050210020333.7941fa6e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210020333.7941fa6e.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Wed, 9 Feb 2005 10:39:27 +0100 Ingo Molnar <mingo@elte.hu> wrote:
> >
> > --- linux/include/asm-sparc/resource.h.orig
> > +++ linux/include/asm-sparc/resource.h
> 	.
> 	.
> > -#define RLIMIT_NOFILE	6		/* max number of open files */
> > -#define RLIMIT_NPROC	7		/* max number of processes */
> 	.
> 	.
> > +#define RLIMIT_NPROC		6	/* max number of processes */
> > +#define RLIMIT_NOFILE		7	/* max number of open files */
> 
> Is it too late at night, or should those be reversed to match the ones
> you are removing (and the sparc64 ones)?

you are right - the sparc32 ones i got mixed up. (sigh.) The sparc64
ones (and mips and alpha) seem correct though. New patch below.

	Ingo

--
this patch does the final consolidation of asm-*/resource.h file,
without changing any of the rlimit definitions on any architecture.
Primarily it removes the __ARCH_RLIMIT_ORDER method and replaces it with
a more compact and isolated one that allows architectures to define only
the offending rlimits.

This method has the positive effect that adding a new rlimit can now be
purely done via changing asm-generic/resource.h alone. Previously one
would have to patch 4 other (sparc, sparc64, alpha and mips) resource.h
files.

the patch also does style unification, whitespace cleanups and
simplification of resource.h files and cleans up the
asm-generic/resource.h file as well. I've added more comments too.

this patch should have no effect on any code on any architecture. (i.e. 
it's a pure identity patch.)

Tested on x86 and reviewed to make sure that Sparc, Sparc64, MIPS and
Alpha rlimits are still the same as required by the ABI.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/asm-sparc/resource.h.orig
+++ linux/include/asm-sparc/resource.h
@@ -8,32 +8,18 @@
 #define _SPARC_RESOURCE_H
 
 /*
- * Resource limits
+ * These two resource limit IDs have a Sparc/Linux-specific ordering,
+ * the rest comes from the generic header:
  */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NOFILE	6		/* max number of open files */
-#define RLIMIT_NPROC	7		/* max number of processes */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-#define __ARCH_RLIMIT_ORDER
+#define RLIMIT_NOFILE		6	/* max number of open files */
+#define RLIMIT_NPROC		7	/* max number of processes */
 
 /*
  * SuS says limits have to be unsigned.
  * We make this unsigned, but keep the
- * old value.
+ * old value for compatibility:
  */
-#define RLIM_INFINITY	0x7fffffff
+#define RLIM_INFINITY		0x7fffffff
 
 #include <asm-generic/resource.h>
 
--- linux/include/asm-alpha/resource.h.orig
+++ linux/include/asm-alpha/resource.h
@@ -2,32 +2,20 @@
 #define _ALPHA_RESOURCE_H
 
 /*
- * Resource limits
+ * Alpha/Linux-specific ordering of these four resource limit IDs,
+ * the rest comes from the generic header:
  */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NOFILE	6		/* max number of open files */
-#define RLIMIT_AS	7		/* address space limit(?) */
-#define RLIMIT_NPROC	8		/* max number of processes */
-#define RLIMIT_MEMLOCK	9		/* max locked-in-memory address space */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-#define __ARCH_RLIMIT_ORDER
+#define RLIMIT_NOFILE		6	/* max number of open files */
+#define RLIMIT_AS		7	/* address space limit */
+#define RLIMIT_NPROC		8	/* max number of processes */
+#define RLIMIT_MEMLOCK		9	/* max locked-in-memory address space */
 
 /*
  * SuS says limits have to be unsigned.  Fine, it's unsigned, but
  * we retain the old value for compatibility, especially with DU. 
  * When you run into the 2^63 barrier, you call me.
  */
-#define RLIM_INFINITY	0x7ffffffffffffffful
+#define RLIM_INFINITY		0x7ffffffffffffffful
 
 #include <asm-generic/resource.h>
 
--- linux/include/asm-generic/resource.h.orig
+++ linux/include/asm-generic/resource.h
@@ -2,57 +2,85 @@
 #define _ASM_GENERIC_RESOURCE_H
 
 /*
- * Resource limits
+ * Resource limit IDs
+ *
+ * ( Compatibility detail: there are architectures that have
+ *   a different rlimit ID order in the 5-9 range and want
+ *   to keep that order for binary compatibility. The reasons
+ *   are historic and all new rlimits are identical across all
+ *   arches. If an arch has such special order for some rlimits
+ *   then it defines them prior including asm-generic/resource.h. )
  */
 
-/* Allow arch to control resource order */
-#ifndef __ARCH_RLIMIT_ORDER
 #define RLIMIT_CPU		0	/* CPU time in ms */
 #define RLIMIT_FSIZE		1	/* Maximum filesize */
 #define RLIMIT_DATA		2	/* max data size */
 #define RLIMIT_STACK		3	/* max stack size */
 #define RLIMIT_CORE		4	/* max core file size */
-#define RLIMIT_RSS		5	/* max resident set size */
-#define RLIMIT_NPROC		6	/* max number of processes */
-#define RLIMIT_NOFILE		7	/* max number of open files */
-#define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
-#define RLIMIT_AS		9	/* address space limit */
+
+#ifndef RLIMIT_RSS
+# define RLIMIT_RSS		5	/* max resident set size */
+#endif
+
+#ifndef RLIMIT_NPROC
+# define RLIMIT_NPROC		6	/* max number of processes */
+#endif
+
+#ifndef RLIMIT_NOFILE
+# define RLIMIT_NOFILE		7	/* max number of open files */
+#endif
+
+#ifndef RLIMIT_MEMLOCK
+# define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
+#endif
+
+#ifndef RLIMIT_AS
+# define RLIMIT_AS		9	/* address space limit */
+#endif
+
 #define RLIMIT_LOCKS		10	/* maximum file locks held */
 #define RLIMIT_SIGPENDING	11	/* max number of pending signals */
 #define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
 
 #define RLIM_NLIMITS		13
-#endif
 
 /*
  * SuS says limits have to be unsigned.
  * Which makes a ton more sense anyway.
+ *
+ * Some architectures override this (for compatibility reasons):
  */
 #ifndef RLIM_INFINITY
-#define RLIM_INFINITY	(~0UL)
+# define RLIM_INFINITY		(~0UL)
 #endif
 
+/*
+ * RLIMIT_STACK default maximum - some architectures override it:
+ */
 #ifndef _STK_LIM_MAX
-#define _STK_LIM_MAX	RLIM_INFINITY
+# define _STK_LIM_MAX		RLIM_INFINITY
 #endif
 
 #ifdef __KERNEL__
 
+/*
+ * boot-time rlimit defaults for the init task:
+ */
 #define INIT_RLIMITS							\
 {									\
-	[RLIMIT_CPU]		= { RLIM_INFINITY, RLIM_INFINITY },	\
-	[RLIMIT_FSIZE]		= { RLIM_INFINITY, RLIM_INFINITY },	\
-	[RLIMIT_DATA]		= { RLIM_INFINITY, RLIM_INFINITY },	\
-	[RLIMIT_STACK]		= {      _STK_LIM, _STK_LIM_MAX  },	\
-	[RLIMIT_CORE]		= {             0, RLIM_INFINITY },	\
-	[RLIMIT_RSS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
-	[RLIMIT_NPROC]		= {             0,             0 },	\
-	[RLIMIT_NOFILE]		= {      INR_OPEN,     INR_OPEN  },	\
-	[RLIMIT_MEMLOCK]	= {   MLOCK_LIMIT,   MLOCK_LIMIT },	\
-	[RLIMIT_AS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
-	[RLIMIT_LOCKS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
+	[RLIMIT_CPU]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_FSIZE]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_DATA]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_STACK]		= {       _STK_LIM,   _STK_LIM_MAX },	\
+	[RLIMIT_CORE]		= {              0,  RLIM_INFINITY },	\
+	[RLIMIT_RSS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_NPROC]		= {              0,              0 },	\
+	[RLIMIT_NOFILE]		= {       INR_OPEN,       INR_OPEN },	\
+	[RLIMIT_MEMLOCK]	= {    MLOCK_LIMIT,    MLOCK_LIMIT },	\
+	[RLIMIT_AS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
+	[RLIMIT_LOCKS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
-	[RLIMIT_MSGQUEUE]	= { MQ_BYTES_MAX, MQ_BYTES_MAX },	\
+	[RLIMIT_MSGQUEUE]	= {   MQ_BYTES_MAX,   MQ_BYTES_MAX },	\
 }
 
 #endif	/* __KERNEL__ */
--- linux/include/asm-sparc64/resource.h.orig
+++ linux/include/asm-sparc64/resource.h
@@ -8,25 +8,11 @@
 #define _SPARC64_RESOURCE_H
 
 /*
- * Resource limits
+ * These two resource limit IDs have a Sparc/Linux-specific ordering,
+ * the rest comes from the generic header:
  */
-
-#define RLIMIT_CPU	0		/* CPU time in ms */
-#define RLIMIT_FSIZE	1		/* Maximum filesize */
-#define RLIMIT_DATA	2		/* max data size */
-#define RLIMIT_STACK	3		/* max stack size */
-#define RLIMIT_CORE	4		/* max core file size */
-#define RLIMIT_RSS	5		/* max resident set size */
-#define RLIMIT_NOFILE	6		/* max number of open files */
-#define RLIMIT_NPROC	7		/* max number of processes */
-#define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
-#define RLIMIT_AS	9		/* address space limit */
-#define RLIMIT_LOCKS	10		/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS	13
-#define __ARCH_RLIMIT_ORDER
+#define RLIMIT_NOFILE		6	/* max number of open files */
+#define RLIMIT_NPROC		7	/* max number of processes */
 
 #include <asm-generic/resource.h>
 
--- linux/include/asm-mips/resource.h.orig
+++ linux/include/asm-mips/resource.h
@@ -9,36 +9,26 @@
 #ifndef _ASM_RESOURCE_H
 #define _ASM_RESOURCE_H
 
+#include <linux/config.h>
+
 /*
- * Resource limits
+ * These five resource limit IDs have a MIPS/Linux-specific ordering,
+ * the rest comes from the generic header:
  */
-#define RLIMIT_CPU 0			/* CPU time in ms */
-#define RLIMIT_FSIZE 1			/* Maximum filesize */
-#define RLIMIT_DATA 2			/* max data size */
-#define RLIMIT_STACK 3			/* max stack size */
-#define RLIMIT_CORE 4			/* max core file size */
-#define RLIMIT_NOFILE 5			/* max number of open files */
-#define RLIMIT_AS 6			/* mapped memory */
-#define RLIMIT_RSS 7			/* max resident set size */
-#define RLIMIT_NPROC 8			/* max number of processes */
-#define RLIMIT_MEMLOCK 9		/* max locked-in-memory address space */
-#define RLIMIT_LOCKS 10			/* maximum file locks held */
-#define RLIMIT_SIGPENDING 11		/* max number of pending signals */
-#define RLIMIT_MSGQUEUE 12		/* maximum bytes in POSIX mqueues */
-
-#define RLIM_NLIMITS 13			/* Number of limit flavors.  */
-#define __ARCH_RLIMIT_ORDER
+#define RLIMIT_NOFILE		5	/* max number of open files */
+#define RLIMIT_AS		6	/* address space limit */
+#define RLIMIT_RSS		7	/* max resident set size */
+#define RLIMIT_NPROC		8	/* max number of processes */
+#define RLIMIT_MEMLOCK		9	/* max locked-in-memory address space */
 
 /*
  * SuS says limits have to be unsigned.
- * Which makes a ton more sense anyway.
+ * Which makes a ton more sense anyway,
+ * but we keep the old value on MIPS32,
+ * for compatibility:
  */
-#include <linux/config.h>
 #ifdef CONFIG_MIPS32
-#define RLIM_INFINITY	0x7fffffffUL
-#endif
-#ifdef CONFIG_MIPS64
-#define RLIM_INFINITY	(~0UL)
+# define RLIM_INFINITY		0x7fffffffUL
 #endif
 
 #include <asm-generic/resource.h>

