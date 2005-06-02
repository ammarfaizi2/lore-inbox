Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVFBTQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVFBTQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFBTQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:16:52 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33692 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261250AbVFBTQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:16:41 -0400
Date: Thu, 2 Jun 2005 21:16:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [rfc] [patch] consolidate/clean up spinlock.h files
In-Reply-To: <20050602144004.GA31807@elte.hu>
Message-ID: <Pine.LNX.4.61.0506021817390.3743@scrub.home>
References: <20050602144004.GA31807@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2 Jun 2005, Ingo Molnar wrote:

>  - consolidates and enhances the spinlock/rwlock debugging code
> 
>  - simplifies the asm/spinlock.h files
> 
>  - encapsulates the raw spinlock types and moves generic spinlock
>    features (such as ->break_lock) into the generic code.
> 
>  - cleans up the spinlock code hierarchy to get rid of spaghetti.

That nicely splits the headers into several separate files, but the 
problem is that all these new header files are only of limited value 
outside the spinlock code.
What I'd really to see is a split of definitions and implementation. That 
means the definitions would be available via <linux/spinlock_types.h> and 
could be used in other core headers and would pull in a lot less header 
files. Header dependencies got worse especially since preempt got 
included.
The patch below does the minimum to provide spinlock_types.h. We could 
also include initializers.

>  *  linux/spinlock_smp.h: contains the prototypes for the _spin_*() APIs.
>  *  linux/spinlock_up.h:  builds the _spin_*() APIs.

These are rather small files. Is it really worth it to separate them?

> +#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while (0)
> +#define rwlock_init(x)		do { *(x) = RW_LOCK_UNLOCKED; } while (0)

We should fix these initializers at some point. I usually see gcc produce 
code that creates first the structure on the stack and then does a memcpy.

bye, Roman

Index: linux-2.6-mm/include/asm-generic/spinlock_types_up.h
===================================================================
--- linux-2.6-mm.orig/include/asm-generic/spinlock_types_up.h	2005-06-02 18:31:40.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,29 +0,0 @@
-#ifndef __ASM_GENERIC_SPINLOCK_TYPES_UP_H
-#define __ASM_GENERIC_SPINLOCK_TYPES_UP_H
-
-/*
- * include/linux/spinlock_types_up.h - spinlock type definitions for UP:
- *
- * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
- * Released under the General Public License (GPL).
- */
-
-typedef struct {
-#ifdef CONFIG_DEBUG_SPINLOCK
-	volatile unsigned int slock;
-#endif
-} raw_spinlock_t;
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-# define __RAW_SPIN_LOCK_UNLOCKED { 1 }
-#else
-# define __RAW_SPIN_LOCK_UNLOCKED { }
-#endif
-
-typedef struct {
-	/* no debug version on UP */
-} raw_rwlock_t;
-
-#define __RAW_RWLOCK_UNLOCKED { }
-
-#endif
Index: linux-2.6-mm/include/linux/spinlock.h
===================================================================
--- linux-2.6-mm.orig/include/linux/spinlock.h	2005-06-02 18:31:40.000000000 +0200
+++ linux-2.6-mm/include/linux/spinlock.h	2005-06-02 18:57:49.000000000 +0200
@@ -67,46 +67,13 @@
 #define __lockfunc fastcall __attribute__((section(".spinlock.text")))
 
 /*
- * Pull the raw_spinlock_t and raw_rwlock_t definitions:
- */
-#if defined(CONFIG_SMP)
-# include <asm/spinlock_types.h>
-#else
-# include <asm-generic/spinlock_types_up.h>
-#endif
-
-typedef struct {
-	raw_spinlock_t raw_lock;
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
-	unsigned int break_lock;
-#endif
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_pid, owner_cpu;
-#endif
-} spinlock_t;
-
-#define SPINLOCK_MAGIC  0xdead4ead
-
-typedef struct {
-	raw_rwlock_t raw_lock;
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
-	unsigned int break_lock;
-#endif
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_pid, owner_cpu;
-#endif
-} rwlock_t;
-
-#define RWLOCK_MAGIC	0xdeaf1eed
-
-/*
  * Pull the __raw*() functions/declarations (UP-nondebug doesnt need them):
  */
-#if defined(CONFIG_SMP)
+#ifdef CONFIG_SMP
 # include <asm/spinlock.h>
 #else
-# include <asm-generic/spinlock_up.h>
-#endif
+
+#endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_SPINLOCK
 # define SPIN_LOCK_UNLOCKED						\
Index: linux-2.6-mm/include/linux/spinlock_types.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-mm/include/linux/spinlock_types.h	2005-06-02 20:35:44.000000000 +0200
@@ -0,0 +1,59 @@
+#ifndef __LINUX_SPINLOCK_TYPES_H
+#define __LINUX_SPINLOCK_TYPES_H
+
+#include <linux/config.h>
+
+/*
+ * Pull the raw_spinlock_t and raw_rwlock_t definitions:
+ */
+#ifdef CONFIG_SMP
+
+# include <asm/spinlock_types.h>
+
+#else
+
+typedef struct {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	volatile unsigned int slock;
+#endif
+} raw_spinlock_t;
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define __RAW_SPIN_LOCK_UNLOCKED { 1 }
+#else
+# define __RAW_SPIN_LOCK_UNLOCKED { }
+#endif
+
+typedef struct {
+	/* no debug version on UP */
+} raw_rwlock_t;
+
+#define __RAW_RWLOCK_UNLOCKED { }
+
+#endif /* CONFIG_SMP */
+
+typedef struct {
+	raw_spinlock_t raw_lock;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	unsigned int break_lock;
+#endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_pid, owner_cpu;
+#endif
+} spinlock_t;
+
+#define SPINLOCK_MAGIC  0xdead4ead
+
+typedef struct {
+	raw_rwlock_t raw_lock;
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
+	unsigned int break_lock;
+#endif
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_pid, owner_cpu;
+#endif
+} rwlock_t;
+
+#define RWLOCK_MAGIC	0xdeaf1eed
+
+#endif /* __LINUX_SPINLOCK_TYPES_H */
