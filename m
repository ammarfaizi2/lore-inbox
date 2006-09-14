Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWINOjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWINOjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWINOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:39:46 -0400
Received: from twin.jikos.cz ([213.151.79.26]:41622 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750808AbWINOjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:39:45 -0400
Date: Thu, 14 Sep 2006 16:39:21 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
In-Reply-To: <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz> 
 <200609132200.51342.dtor@insightbb.com>  <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
 <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Dmitry Torokhov wrote:

> Can we add lock_class_key to the struct psmouse and use it to define
> per-device mutex class regardless of whether it is a child, grandchild
> or a parent?

Hi Dmitry,

what do you think about the patches below? I have used a slightly 
different approach, as we also need to get rid of the spurious lockdep 
warning in case of recursive call of serio_interrupt(), which can't be 
handled well with lock subclass stored in struct psmouse. What do you 
think about this? It shuts up the lockdep, and seems much cleaner to me.

The first patch implements spin_lock_irqsave_nested(), which is needed by 
the second one:

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_smp.h linux-2.6.18-rc6-mm2/include/linux/spinlock_api_smp.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_smp.h	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/spinlock_api_smp.h	2006-09-14 01:24:08.000000000 +0200
@@ -32,6 +32,8 @@ void __lockfunc _read_lock_irq(rwlock_t 
 void __lockfunc _write_lock_irq(rwlock_t *lock)		__acquires(lock);
 unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
 							__acquires(lock);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+							__acquires(spinlock_t);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock)
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_up.h linux-2.6.18-rc6-mm2/include/linux/spinlock_api_up.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/spinlock_api_up.h	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/spinlock_api_up.h	2006-09-14 01:24:05.000000000 +0200
@@ -59,6 +59,7 @@
 #define _read_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _write_lock_irq(lock)			__LOCK_IRQ(lock)
 #define _spin_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
+#define _spin_lock_irqsave_nested(lock, flags, subclass) __LOCK_IRQSAVE(lock, flags, subclass)
 #define _read_lock_irqsave(lock, flags)		__LOCK_IRQSAVE(lock, flags)
 #define _write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
 #define _spin_trylock(lock)			({ __LOCK(lock); 1; })
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/spinlock.h linux-2.6.18-rc6-mm2/include/linux/spinlock.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/spinlock.h	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/spinlock.h	2006-09-14 01:24:12.000000000 +0200
@@ -186,6 +186,11 @@ do {								\
 #define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define spin_lock_irqsave_nested(lock, flags, subclass)	flags = _spin_lock_irqsave_nested(lock, subclass)
+#else
+#define spin_lock_irqsave_nested(lock, flags, subclass)	flags = _spin_lock_irqsave(lock)
+#endif
 #else
 #define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
 #define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
diff -rup linux-2.6.18-rc6-mm2.orig/kernel/spinlock.c linux-2.6.18-rc6-mm2/kernel/spinlock.c
--- linux-2.6.18-rc6-mm2.orig/kernel/spinlock.c	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/kernel/spinlock.c	2006-09-14 01:27:17.000000000 +0200
@@ -304,6 +304,27 @@ void __lockfunc _spin_lock_nested(spinlo
 }
 
 EXPORT_SYMBOL(_spin_lock_nested);
+unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock, int subclass)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	preempt_disable();
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	/*
+	 * On lockdep we dont want the hand-coded irq-enable of
+	 * _raw_spin_lock_flags() code, because lockdep assumes
+	 * that interrupts are not re-enabled during lock-acquire:
+	 */
+#ifdef CONFIG_PROVE_SPIN_LOCKING
+	_raw_spin_lock(lock);
+#else
+	_raw_spin_lock_flags(lock, &flags);
+#endif
+	return flags;
+}
+
+EXPORT_SYMBOL(_spin_lock_irqsave_nested);
 
 #endif

And this second one actually fixes the locking with respect to lockdep 
validator:

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/serio/libps2.c linux-2.6.18-rc6-mm2/drivers/input/serio/libps2.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/serio/libps2.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/serio/libps2.c	2006-09-14 16:16:06.000000000 +0200
@@ -182,7 +182,7 @@ int ps2_command(struct ps2dev *ps2dev, u
 		return -1;
 	}
 
-	mutex_lock_nested(&ps2dev->cmd_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock_nested(&ps2dev->cmd_mutex, ps2dev->serio->depth);
 
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/serio/serio.c linux-2.6.18-rc6-mm2/drivers/input/serio/serio.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/serio/serio.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/serio/serio.c	2006-09-14 16:16:00.000000000 +0200
@@ -553,9 +553,11 @@ static void serio_add_port(struct serio 
 	if (serio->parent) {
 		serio_pause_rx(serio->parent);
 		serio->parent->child = serio;
+		serio->depth = serio->parent->depth + 1;
 		serio_continue_rx(serio->parent);
-	}
-
+	} else
+		serio->depth = 0;
+	
 	list_add_tail(&serio->node, &serio_list);
 	if (serio->start)
 		serio->start(serio);
@@ -916,7 +918,7 @@ irqreturn_t serio_interrupt(struct serio
 	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
-	spin_lock_irqsave(&serio->lock, flags);
+	spin_lock_irqsave_nested(&serio->lock, flags, serio->depth);
 
         if (likely(serio->drv)) {
                 ret = serio->drv->interrupt(serio, data, dfl, regs);
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/serio.h linux-2.6.18-rc6-mm2/include/linux/serio.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/serio.h	2006-09-14 16:20:56.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/serio.h	2006-09-14 15:15:41.000000000 +0200
@@ -41,6 +41,7 @@ struct serio {
 	void (*stop)(struct serio *);
 
 	struct serio *parent, *child;
+	unsigned int depth;		/* level of nesting in parent-child hierarichy of serios */
 
 	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */
 	struct mutex drv_mutex;		/* protects serio->drv so attributes can pin driver */
 

-- 
JiKos.
