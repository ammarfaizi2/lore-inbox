Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWJWRh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWJWRh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWJWRh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:37:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:53583 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932210AbWJWRh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:37:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=XOFo6D1v/msdZ2HFTcl/4TZzsriJn265dfFwv/Ze1gYJFY+bNEfbynOT5IJlqdnfYrJcjrQ83TD3XqwOLhlwFpbm8QJCfdFNXtR2AhNaBNcSl/gtETW1FwrLrPZjM5vCw4dEARWtpnNJRZHJnIgb27PixygCSvRYKdvquKuv0wE=
Date: Mon, 23 Oct 2006 21:37:28 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] Enforce "unsigned long flags;" when spinlocking
Message-ID: <20061023173728.GB18128@martell.zuzino.mipt.ru>
References: <20061020131544.GC17199@martell.zuzino.mipt.ru> <20061020114640.9231b18f.akpm@osdl.org> <20061020233803.GA5344@martell.zuzino.mipt.ru> <20061020173233.ad9fcda8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020173233.ad9fcda8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it break or warn if you pass to spin_lock_irqsave() and friends
something different from "unsigned long flags;". Suprisingly large amount of
these was caught by recent commit c53421b18f205c5f97c604ae55c6a921f034b0f6
and others.

Idea is largely from FRV typechecking. Suggestions from Andrew Morton.
All stupid typos in first version fixed.

Passes allmodconfig on i386, x86_64, alpha, arm as well as my usual config.

Note #1: checking with sparse is still needed, because a driver can save
	 and pass around flags or something. So far patch is very intrusive.
Note #2: techically, we should break only if
		sizeof(flags) < sizeof(unsigned long),
	 however, the more pain for getting suspicious code into kernel,
	 the better.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/irqflags.h |   37 ++++++++++++++++++++++++++++----
 include/linux/spinlock.h |   53 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 14 deletions(-)

--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -11,6 +11,12 @@
 #ifndef _LINUX_TRACE_IRQFLAGS_H
 #define _LINUX_TRACE_IRQFLAGS_H
 
+#define BUILD_CHECK_IRQ_FLAGS(flags)					\
+	do {								\
+		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
+		typecheck(unsigned long, flags);			\
+	} while (0)
+
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
@@ -50,10 +56,15 @@ #define local_irq_enable() \
 #define local_irq_disable() \
 	do { raw_local_irq_disable(); trace_hardirqs_off(); } while (0)
 #define local_irq_save(flags) \
-	do { raw_local_irq_save(flags); trace_hardirqs_off(); } while (0)
+	do {					\
+		BUILD_CHECK_IRQ_FLAGS(flags);	\
+		raw_local_irq_save(flags);	\
+		trace_hardirqs_off();		\
+	} while (0)
 
 #define local_irq_restore(flags)				\
 	do {							\
+		BUILD_CHECK_IRQ_FLAGS(flags);			\
 		if (raw_irqs_disabled_flags(flags)) {		\
 			raw_local_irq_restore(flags);		\
 			trace_hardirqs_off();			\
@@ -69,8 +80,16 @@ #else /* !CONFIG_TRACE_IRQFLAGS_SUPPORT 
  */
 # define raw_local_irq_disable()	local_irq_disable()
 # define raw_local_irq_enable()		local_irq_enable()
-# define raw_local_irq_save(flags)	local_irq_save(flags)
-# define raw_local_irq_restore(flags)	local_irq_restore(flags)
+# define raw_local_irq_save(flags)		\
+	do {					\
+		BUILD_CHECK_IRQ_FLAGS(flags);	\
+		local_irq_save(flags);		\
+	} while (0)
+# define raw_local_irq_restore(flags)		\
+	do {					\
+		BUILD_CHECK_IRQ_FLAGS(flags);	\
+		local_irq_restore(flags);	\
+	} while (0)
 #endif /* CONFIG_TRACE_IRQFLAGS_SUPPORT */
 
 #ifdef CONFIG_TRACE_IRQFLAGS_SUPPORT
@@ -80,7 +99,11 @@ #define safe_halt()						\
 		raw_safe_halt();				\
 	} while (0)
 
-#define local_save_flags(flags)		raw_local_save_flags(flags)
+#define local_save_flags(flags)			\
+	do {					\
+		BUILD_CHECK_IRQ_FLAGS(flags);	\
+		raw_local_save_flags(flags);	\
+	} while (0)
 
 #define irqs_disabled()						\
 ({								\
@@ -90,7 +113,11 @@ ({								\
 	raw_irqs_disabled_flags(flags);				\
 })
 
-#define irqs_disabled_flags(flags)	raw_irqs_disabled_flags(flags)
+#define irqs_disabled_flags(flags)	\
+({					\
+	BUILD_CHECK_IRQ_FLAGS(flags);	\
+	raw_irqs_disabled_flags(flags);	\
+})
 #endif		/* CONFIG_X86 */
 
 #endif
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -52,6 +52,7 @@ #include <linux/compiler.h>
 #include <linux/thread_info.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
+#include <linux/irqflags.h>
 
 #include <asm/system.h>
 
@@ -183,13 +184,37 @@ #define write_lock(lock)		_write_lock(lo
 #define read_lock(lock)			_read_lock(lock)
 
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
-#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
-#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#define spin_lock_irqsave(lock, flags)			\
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		flags = _spin_lock_irqsave(lock);	\
+	} while (0)
+#define read_lock_irqsave(lock, flags)			\
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		flags = _read_lock_irqsave(lock);	\
+	} while (0)
+#define write_lock_irqsave(lock, flags)			\
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		flags = _write_lock_irqsave(lock);	\
+	} while (0)
 #else
-#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
-#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
-#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
+#define spin_lock_irqsave(lock, flags)			\
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		_spin_lock_irqsave(lock, flags);	\
+	} while (0)
+#define read_lock_irqsave(lock, flags)			\
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		_read_lock_irqsave(lock, flags);	\
+	} while (0)
+#define write_lock_irqsave(lock, flags)			\
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		_write_lock_irqsave(lock, flags);	\
+	} while (0)
 #endif
 
 #define spin_lock_irq(lock)		_spin_lock_irq(lock)
@@ -225,15 +250,24 @@ # define write_unlock_irq(lock) \
 #endif
 
 #define spin_unlock_irqrestore(lock, flags) \
-					_spin_unlock_irqrestore(lock, flags)
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		_spin_unlock_irqrestore(lock, flags);	\
+	} while (0)
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
 #define read_unlock_irqrestore(lock, flags) \
-					_read_unlock_irqrestore(lock, flags)
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		_read_unlock_irqrestore(lock, flags);	\
+	} while (0)
 #define read_unlock_bh(lock)		_read_unlock_bh(lock)
 
 #define write_unlock_irqrestore(lock, flags) \
-					_write_unlock_irqrestore(lock, flags)
+	do {						\
+		BUILD_CHECK_IRQ_FLAGS(flags);		\
+		_write_unlock_irqrestore(lock, flags);	\
+	} while (0)
 #define write_unlock_bh(lock)		_write_unlock_bh(lock)
 
 #define spin_trylock_bh(lock)	__cond_lock(lock, _spin_trylock_bh(lock))
@@ -247,6 +281,7 @@ ({ \
 
 #define spin_trylock_irqsave(lock, flags) \
 ({ \
+	BUILD_CHECK_IRQ_FLAGS(flags); \
 	local_irq_save(flags); \
 	spin_trylock(lock) ? \
 	1 : ({ local_irq_restore(flags); 0; }); \

