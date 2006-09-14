Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWINAqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWINAqA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 20:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWINAp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 20:45:59 -0400
Received: from twin.jikos.cz ([213.151.79.26]:63362 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751279AbWINApt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 20:45:49 -0400
Date: Thu, 14 Sep 2006 02:44:34 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [PATCH 3/3] Synaptics - fix lockdep warnings 
In-Reply-To: <Pine.LNX.4.64.0609140240490.22181@twin.jikos.cz>
Message-ID: <Pine.LNX.4.64.0609140242050.22181@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
 <Pine.LNX.4.64.0609140239000.22181@twin.jikos.cz>
 <Pine.LNX.4.64.0609140240490.22181@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 =============================================
 [ INFO: possible recursive locking detected ]
 2.6.18-rc6-mm2-dirty #7
 ---------------------------------------------
 swapper/0 is trying to acquire lock:
  (&serio->lock){++..}, at: [<c02b7a20>] serio_interrupt+0x20/0x60

 but task is already holding lock:
  (&serio->lock){++..}, at: [<c02b7a20>] serio_interrupt+0x20/0x60

 other info that might help us debug this:
 1 lock held by swapper/0:
  #0:  (&serio->lock){++..}, at: [<c02b7a20>] serio_interrupt+0x20/0x60

 stack backtrace:
  [<c01039e5>] dump_trace+0x225/0x240
  [<c0103af0>] show_trace_log_lvl+0x30/0x50
  [<c0103b38>] show_trace+0x28/0x30
  [<c0103c72>] dump_stack+0x22/0x30
  [<c0135130>] print_deadlock_bug+0xc0/0xd0
  [<c01351b2>] check_deadlock+0x72/0x80
  [<c0136a4d>] __lock_acquire+0x43d/0x990
  [<c0137468>] lock_acquire+0x68/0x80
  [<c036947d>] _spin_lock_irqsave+0x4d/0x70
  [<c02b7a20>] serio_interrupt+0x20/0x60
  [<c02c3f84>] synaptics_pass_pt_packet+0x44/0xd0
  [<c02c4a9a>] synaptics_process_byte+0xba/0xd0
  [<c02c017a>] psmouse_handle_byte+0x1a/0x110
  [<c02c031a>] psmouse_interrupt+0xaa/0x2e0
  [<c02b79ca>] __serio_interrupt+0x3a/0x70
  [<c02b7a42>] serio_interrupt+0x42/0x60
  [<c02b841e>] i8042_interrupt+0x10e/0x240
  [<c014cab1>] handle_IRQ_event+0x31/0x80
  [<c014dc5e>] handle_level_irq+0x8e/0x120
  [<c010570a>] do_IRQ+0x5a/0xb0
  [<c01035a2>] common_interrupt+0x2e/0x34
  [<c024e964>] acpi_processor_idle+0x1e8/0x31b
  [<c0101195>] cpu_idle+0x95/0xa0
  [<c0100334>] rest_init+0x44/0x50
  [<c04ca8cd>] start_kernel+0x1cd/0x220
  =======================

This is caused by synaptics driver, in pass-through port situation, 
recursively calling serio_interrupt(), which acquires the device lock 
recursively. This is however OK in the synaptics pass-through port case, 
as the per-device lock is acquired exactly twice - first for child, then 
for parent device, so no deadlock occurs.

The patch splits serio_interrupt() function into nested and non-nested 
versions, and changes calls from synaptics pass-through packet handler 
accordingly.

This patch depends on the existence of spin_lock_irqsave_nested(), which 
is provided by the previous patch.

Please apply, if applicable, to get rid of spurious lockdep warnings. This patch
was generated against 2.6.18-rc6-mm2.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/synaptics.c linux-2.6.18-rc6-mm2/drivers/input/mouse/synaptics.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/mouse/synaptics.c	2006-09-14 01:05:30.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/mouse/synaptics.c	2006-09-14 02:03:38.000000000 +0200
@@ -216,13 +216,13 @@ static void synaptics_pass_pt_packet(str
 	struct psmouse *child = serio_get_drvdata(ptport);
 
 	if (child && child->state == PSMOUSE_ACTIVATED) {
-		serio_interrupt(ptport, packet[1], 0, NULL);
-		serio_interrupt(ptport, packet[4], 0, NULL);
-		serio_interrupt(ptport, packet[5], 0, NULL);
+		serio_interrupt_nested(ptport, packet[1], 0, NULL);
+		serio_interrupt_nested(ptport, packet[4], 0, NULL);
+		serio_interrupt_nested(ptport, packet[5], 0, NULL);
 		if (child->pktsize == 4)
-			serio_interrupt(ptport, packet[2], 0, NULL);
+			serio_interrupt_nested(ptport, packet[2], 0, NULL);
 	} else
-		serio_interrupt(ptport, packet[1], 0, NULL);
+		serio_interrupt_nested(ptport, packet[1], 0, NULL);
 }
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
diff -rup linux-2.6.18-rc6-mm2.orig/drivers/input/serio/serio.c linux-2.6.18-rc6-mm2/drivers/input/serio/serio.c
--- linux-2.6.18-rc6-mm2.orig/drivers/input/serio/serio.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/serio/serio.c	2006-09-14 01:51:00.000000000 +0200
@@ -41,6 +41,7 @@ MODULE_DESCRIPTION("Serio abstraction co
 MODULE_LICENSE("GPL");
 
 EXPORT_SYMBOL(serio_interrupt);
+EXPORT_SYMBOL(serio_interrupt_nested);
 EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
 EXPORT_SYMBOL(serio_unregister_child_port);
@@ -910,14 +911,11 @@ void serio_close(struct serio *serio)
 	serio_set_drv(serio, NULL);
 }
 
-irqreturn_t serio_interrupt(struct serio *serio,
+irqreturn_t __serio_interrupt(struct serio *serio,
 		unsigned char data, unsigned int dfl, struct pt_regs *regs)
 {
-	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
-	spin_lock_irqsave(&serio->lock, flags);
-
         if (likely(serio->drv)) {
                 ret = serio->drv->interrupt(serio, data, dfl, regs);
 	} else if (!dfl && serio->registered) {
@@ -925,8 +923,30 @@ irqreturn_t serio_interrupt(struct serio
 		ret = IRQ_HANDLED;
 	}
 
+	return ret;
+}
+
+irqreturn_t serio_interrupt(struct serio *serio,
+		unsigned char data, unsigned int dfl, struct pt_regs *regs)
+{
+	unsigned long flags;
+	irqreturn_t ret;
+	
+	spin_lock_irqsave(&serio->lock, flags);
+	ret = __serio_interrupt(serio, data, dfl, regs);
 	spin_unlock_irqrestore(&serio->lock, flags);
+	return ret;
+}
 
+irqreturn_t serio_interrupt_nested(struct serio *serio,
+		unsigned char data, unsigned int dfl, struct pt_regs *regs)
+{
+	unsigned long flags;
+	irqreturn_t ret;
+	
+	spin_lock_irqsave_nested(&serio->lock, flags, SINGLE_DEPTH_NESTING);
+	ret = __serio_interrupt(serio, data, dfl, regs);
+	spin_unlock_irqrestore(&serio->lock, flags);
 	return ret;
 }
 
diff -rup linux-2.6.18-rc6-mm2.orig/include/linux/serio.h linux-2.6.18-rc6-mm2/include/linux/serio.h
--- linux-2.6.18-rc6-mm2.orig/include/linux/serio.h	2006-09-14 00:49:35.000000000 +0200
+++ linux-2.6.18-rc6-mm2/include/linux/serio.h	2006-09-14 01:39:57.000000000 +0200
@@ -76,6 +76,7 @@ void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
 void serio_reconnect(struct serio *serio);
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
+irqreturn_t serio_interrupt_nested(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
 void __serio_register_port(struct serio *serio, struct module *owner);
 static inline void serio_register_port(struct serio *serio)
diff -rup linux-2.6.18-rc6-mm2.orig/kernel/spinlock.c linux-2.6.18-rc6-mm2/kernel/spinlock.c
--- linux-2.6.18-rc6-mm2.orig/kernel/spinlock.c	2006-09-14 01:35:00.000000000 +0200
+++ linux-2.6.18-rc6-mm2/kernel/spinlock.c	2006-09-14 01:42:40.000000000 +0200
@@ -310,7 +310,7 @@ unsigned long __lockfunc _spin_lock_irqs
 
 	local_irq_save(flags);
 	preempt_disable();
-	spin_acquire(&lock->dep_map, subtype, 0, _RET_IP_);
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	/*
 	 * On lockdep we dont want the hand-coded irq-enable of
 	 * _raw_spin_lock_flags() code, because lockdep assumes
