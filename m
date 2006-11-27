Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755617AbWK0A34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbWK0A34 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbWK0A34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:29:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:31435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755604AbWK0A3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:29:55 -0500
Date: Sun, 26 Nov 2006 16:29:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Kyle McMartin <kyle@parisc-linux.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
In-Reply-To: <20061126232128.GC30767@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0611261627260.30076@woody.osdl.org>
References: <20061126224928.GA22285@linux-mips.org>
 <Pine.LNX.4.64.0611261459010.3483@woody.osdl.org>
 <Pine.LNX.4.64.0611261509330.3483@woody.osdl.org> <20061126232128.GC30767@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2006, Russell King wrote:
> > 
> > Ralf, Russell, does this work for you guys?
> 
> Not at all.  It creates even more problems for me, with this circular
> dependency:

Ok. I just reverted it then. 

Pls verify that this is all good, and I didn't mess anything up due to the 
manual conflict resolution.

		Linus

---
commit b8e6ec865fd1d8838b6ce9516977b65e9f08f876
Author: Linus Torvalds <torvalds@woody.osdl.org>
Date:   Sun Nov 26 16:27:17 2006 -0800

    Revert "[PATCH] Enforce "unsigned long flags;" when spinlocking"
    
    This reverts commit ee3ce191e8eaa4cc15c51a28b34143b36404c4f5, since it
    broke on at least ARM, MIPS and PA-RISC due to complicated header file
    dependencies.
    
    Conflicts in include/linux/spinlock.h (due to the "nested" variety
    fixes) fixed up by hand.
    
    Cc: Alexey Dobriyan <adobriyan@gmail.com>
    Cc: Ralf Baechle <ralf@linux-mips.org>
    Cc: Kyle McMartin <kyle@parisc-linux.org>
    Cc: Russell King <rmk+lkml@arm.linux.org.uk>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 4fe740b..412e025 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -11,12 +11,6 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
-#define BUILD_CHECK_IRQ_FLAGS(flags)					\
-	do {								\
-		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
-		typecheck(unsigned long, flags);			\
-	} while (0)
-
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
@@ -56,15 +50,10 @@
 #define local_irq_disable() \
 	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
 #define local_irq_save(flags) \
-	do {					\
-		BUILD_CHECK_IRQ_FLAGS(flags);	\
-		raw_local_irq_save(flags);	\
-		trace_hardirqs_off();		\
-	} while (0)
+	do { raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
 
 #define local_irq_restore(flags)				\
 	do {							\
-		BUILD_CHECK_IRQ_FLAGS(flags);			\
 		if (raw_irqs_disabled_flags(flags)) {		\
 			raw_local_irq_restore(flags);		\
 			trace_hardirqs_off();			\
@@ -80,16 +69,8 @@
  */
 # define raw_local_irq_disable()	local_irq_disable()
 # define raw_local_irq_enable()		local_irq_enable()
-# define raw_local_irq_save(flags)		\
-	do {					\
-		BUILD_CHECK_IRQ_FLAGS(flags);	\
-		local_irq_save(flags);		\
-	} while (0)
-# define raw_local_irq_restore(flags)		\
-	do {					\
-		BUILD_CHECK_IRQ_FLAGS(flags);	\
-		local_irq_restore(flags);	\
-	} while (0)
+# define raw_local_irq_save(flags)	local_irq_save(flags)
+# define raw_local_irq_restore(flags)	local_irq_restore(flags)
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
@@ -99,11 +80,7 @@
 		raw_safe_halt();				\
 	} while (0)
 
-#define local_save_flags(flags)			\
-	do {					\
-		BUILD_CHECK_IRQ_FLAGS(flags);	\
-		raw_local_save_flags(flags);	\
-	} while (0)
+#define local_save_flags(flags)		raw_local_save_flags(flags)
 
 #define irqs_disabled()						\
 ({								\
@@ -113,11 +90,7 @@
 	raw_irqs_disabled_flags(flags);				\
 })
 
-#define irqs_disabled_flags(flags)	\
-({					\
-	BUILD_CHECK_IRQ_FLAGS(flags);	\
-	raw_irqs_disabled_flags(flags);	\
-})
+#define irqs_disabled_flags(flags)	raw_irqs_disabled_flags(flags)
 #endif		/* CONFIG_X86 */
 
 #endif
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 57f670d..8451052 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -52,7 +52,6 @@
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
-#include <linux/irqflags.h>
 
 #include <asm/system.h>
 
@@ -184,52 +183,24 @@ do {								\
 #define read_lock(lock)			_read_lock(lock)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-#define spin_lock_irqsave(lock, flags)			\
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		flags = _spin_lock_irqsave(lock);	\
-	} while (0)
-#define read_lock_irqsave(lock, flags)			\
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		flags = _read_lock_irqsave(lock);	\
-	} while (0)
-#define write_lock_irqsave(lock, flags)			\
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		flags = _write_lock_irqsave(lock);	\
-	} while (0)
+
+#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
+#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
+#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define spin_lock_irqsave_nested(lock, flags, subclass)			\
-	do {								\
-		BUILD_CHECK_IRQ_FLAGS(flags);				\
-		flags = _spin_lock_irqsave_nested(lock, subclass);	\
-	} while (0)
+#define spin_lock_irqsave_nested(lock, flags, subclass) \
+	flags = _spin_lock_irqsave_nested(lock, subclass)
 #else
-#define spin_lock_irqsave_nested(lock, flags, subclass)			\
-	do {								\
-		BUILD_CHECK_IRQ_FLAGS(flags);				\
-		flags = _spin_lock_irqsave(lock);			\
-	} while (0)
+#define spin_lock_irqsave_nested(lock, flags, subclass) \
+	flags = _spin_lock_irqsave(lock)
 #endif
 
 #else
-#define spin_lock_irqsave(lock, flags)			\
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		_spin_lock_irqsave(lock, flags);	\
-	} while (0)
-#define read_lock_irqsave(lock, flags)			\
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		_read_lock_irqsave(lock, flags);	\
-	} while (0)
-#define write_lock_irqsave(lock, flags)			\
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		_write_lock_irqsave(lock, flags);	\
-	} while (0)
+
+#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
+#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
+#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
 #define spin_lock_irqsave_nested(lock, flags, subclass)	\
 	spin_lock_irqsave(lock, flags)
 
@@ -268,24 +239,15 @@ do {								\
 #endif
 
 #define spin_unlock_irqrestore(lock, flags) \
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		_spin_unlock_irqrestore(lock, flags);	\
-	} while (0)
+					_spin_unlock_irqrestore(lock, flags)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
 #define read_unlock_irqrestore(lock, flags) \
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		_read_unlock_irqrestore(lock, flags);	\
-	} while (0)
+					_read_unlock_irqrestore(lock, flags)
 #define read_unlock_bh(lock)		_read_unlock_bh(lock)
 
 #define write_unlock_irqrestore(lock, flags) \
-	do {						\
-		BUILD_CHECK_IRQ_FLAGS(flags);		\
-		_write_unlock_irqrestore(lock, flags);	\
-	} while (0)
+					_write_unlock_irqrestore(lock, flags)
 #define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
 #define spin_trylock_bh(lock)	__cond_lock(lock, _spin_trylock_bh(lock))
@@ -299,7 +261,6 @@ do {								\
 
 #define spin_trylock_irqsave(lock, flags) \
 ({ \
-	BUILD_CHECK_IRQ_FLAGS(flags); \
 	local_irq_save(flags); \
 	spin_trylock(lock) ? \
 	1 : ({ local_irq_restore(flags); 0; }); \
