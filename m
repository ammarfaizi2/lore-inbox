Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265202AbSJWUI2>; Wed, 23 Oct 2002 16:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265206AbSJWUI2>; Wed, 23 Oct 2002 16:08:28 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:6675 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265202AbSJWUIU>;
	Wed, 23 Oct 2002 16:08:20 -0400
Message-ID: <3DB7033C.1090807@mvista.com>
Date: Wed, 23 Oct 2002 15:14:52 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: [PATCH] NMI request/release, version 4
References: <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow>
Content-Type: multipart/mixed;
 boundary="------------020605040606070004030500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020605040606070004030500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, here's try number 4.  This one fixes the race condition that 
Dipankar pointed out, and modifies the release_nmi() call to block until 
the rcu finishes.

I have noticed that the rcu callback can be delayed a long time, 
sometimes up to 3 seconds.  That seems odd.  I have verified that the 
delay happens there.

Also, does the __wait_for_event() code in release_nmi() need any memory 
barriers?

Also, the code in traps.c is pretty generic.  Perhaps it could be moved 
to a common place?  Or is that worth it?

Thanks again,

-Corey

--------------020605040606070004030500
Content-Type: text/plain;
 name="linux-nmi-v4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nmi-v4.diff"

diff -ur linux.orig/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux.orig/arch/i386/kernel/i386_ksyms.c	Mon Oct 21 13:25:58 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Tue Oct 22 12:19:59 2002
@@ -90,6 +90,9 @@
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
 
+EXPORT_SYMBOL(request_nmi);
+EXPORT_SYMBOL(release_nmi);
+
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
 #endif
diff -ur linux.orig/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- linux.orig/arch/i386/kernel/irq.c	Mon Oct 21 13:25:58 2002
+++ linux/arch/i386/kernel/irq.c	Tue Oct 22 12:08:20 2002
@@ -131,6 +131,8 @@
  * Generic, controller-independent functions:
  */
 
+extern void nmi_append_user_names(struct seq_file *p);
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i, j;
@@ -166,6 +168,8 @@
 	for (j = 0; j < NR_CPUS; j++)
 		if (cpu_online(j))
 			p += seq_printf(p, "%10u ", nmi_count(j));
+	seq_printf(p, "                ");
+	nmi_append_user_names(p);
 	seq_putc(p, '\n');
 #if CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
diff -ur linux.orig/arch/i386/kernel/nmi.c linux/arch/i386/kernel/nmi.c
--- linux.orig/arch/i386/kernel/nmi.c	Mon Oct 21 13:25:45 2002
+++ linux/arch/i386/kernel/nmi.c	Wed Oct 23 13:57:55 2002
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/notifier.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -102,6 +103,17 @@
 	return 0;
 }
 
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs);
+
+static struct nmi_handler nmi_watchdog_handler =
+{
+	.link     = LIST_HEAD_INIT(nmi_watchdog_handler.link),
+	.dev_name = "nmi_watchdog",
+	.dev_id   = NULL,
+	.handler  = nmi_watchdog_tick,
+	.priority = 255, /* We want to be relatively high priority. */
+};
+
 static int __init setup_nmi_watchdog(char *str)
 {
 	int nmi;
@@ -110,6 +122,12 @@
 
 	if (nmi >= NMI_INVALID)
 		return 0;
+
+	if (request_nmi(&nmi_watchdog_handler) != 0) {
+		/* Couldn't add a watchdog handler, give up. */
+		return 0;
+	}
+
 	if (nmi == NMI_NONE)
 		nmi_watchdog = nmi;
 	/*
@@ -350,7 +368,7 @@
 		alert_counter[i] = 0;
 }
 
-void nmi_watchdog_tick (struct pt_regs * regs)
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs)
 {
 
 	/*
@@ -401,4 +419,6 @@
 		}
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
 	}
+
+	return NOTIFY_OK;
 }
diff -ur linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux.orig/arch/i386/kernel/traps.c	Mon Oct 21 13:25:45 2002
+++ linux/arch/i386/kernel/traps.c	Wed Oct 23 14:58:09 2002
@@ -23,6 +23,10 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
+#include <linux/notifier.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/rcupdate.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -485,21 +489,139 @@
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
+/* 
+ * A list of handlers for NMIs.  This list will be called in order
+ * when an NMI from an otherwise unidentifiable source somes in.  If
+ * one of these handles the NMI, it should return NOTIFY_OK, otherwise
+ * it should return NOTIFY_DONE.  NMI handlers cannot claim spinlocks,
+ * so we have to handle freeing these in a different manner.  A
+ * spinlock protects the list from multiple writers.  When something
+ * is removed from the list, it is thrown into another list (with
+ * another link, so the "next" element stays valid) and scheduled to
+ * run as an rcu.  When the rcu runs, it is guaranteed that nothing in
+ * the NMI code will be using it.
+ */
+static struct list_head nmi_handler_list = LIST_HEAD_INIT(nmi_handler_list);
+static spinlock_t       nmi_handler_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * To free the list item, we use an rcu.  The rcu-function will not
+ * run until all processors have done a context switch, gone idle, or
+ * gone to a user process, so it's guaranteed that when this runs, any
+ * NMI handler running at release time has completed and the list item
+ * can be safely freed.
+ */
+static void free_nmi_handler(void *arg)
+{
+	struct nmi_handler *handler = arg;
+
+	INIT_LIST_HEAD(&(handler->link));
+	wmb();
+	wake_up(&(handler->wait));
+}
+
+int request_nmi(struct nmi_handler *handler)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h = NULL;
+
+	if (!list_empty(&(handler->link)))
+		return EBUSY;
+
+	spin_lock(&nmi_handler_lock);
+
+	__list_for_each(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		if (curr_h->priority <= handler->priority)
+			break;
+	}
+
+	if (curr_h)
+		/* list_add_rcu takes care of memory barrier */
+		list_add_rcu(&(handler->link), curr_h->link.prev);
+	else
+		list_add_rcu(&(handler->link), &nmi_handler_list);
+
+	spin_unlock(&nmi_handler_lock);
+	return 0;
+}
+
+void release_nmi(struct nmi_handler *handler)
+{
+	wait_queue_t  q_ent;
+	unsigned long flags;
+
+	spin_lock_irqsave(&nmi_handler_lock, flags);
+	list_del_rcu(&(handler->link));
+
+	/* Wait for handler to finish being freed.  This can't be
+           interrupted, we must wait until it finished. */
+	init_waitqueue_head(&(handler->wait));
+	init_waitqueue_entry(&q_ent, current);
+	add_wait_queue(&(handler->wait), &q_ent);
+	call_rcu(&(handler->rcu), free_nmi_handler, handler);
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (list_empty(&(handler->link)))
+			break;
+		spin_unlock_irqrestore(&nmi_handler_lock, flags);
+		schedule();
+		spin_lock_irqsave(&nmi_handler_lock, flags);
+	}
+	remove_wait_queue(&(handler->wait), &q_ent);
+	spin_unlock_irqrestore(&nmi_handler_lock, flags);
+}
+
+static int call_nmi_handlers(struct pt_regs * regs)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
+	int                handled = 0;
+	int                val;
+
+	__list_for_each_rcu(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		val = curr_h->handler(curr_h->dev_id, regs);
+		switch (val & ~NOTIFY_STOP_MASK) {
+		case NOTIFY_OK:
+			handled = 1;
+			break;
+
+		case NOTIFY_DONE:
+		default:
+		}
+		if (val & NOTIFY_STOP_MASK)
+			break;
+	}
+	return handled;
+}
+
+void nmi_append_user_names(struct seq_file *p)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
+
+	spin_lock(&nmi_handler_lock);
+	__list_for_each(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		if (curr_h->dev_name)
+			p += seq_printf(p, " %s", curr_h->dev_name);
+	}
+	spin_unlock(&nmi_handler_lock);
+}
+
 static void default_do_nmi(struct pt_regs * regs)
 {
 	unsigned char reason = inb(0x61);
  
 	if (!(reason & 0xc0)) {
-#if CONFIG_X86_LOCAL_APIC
 		/*
-		 * Ok, so this is none of the documented NMI sources,
-		 * so it must be the NMI watchdog.
+		 * Check the handler list to see if anyone can handle this
+		 * nmi.
 		 */
-		if (nmi_watchdog) {
-			nmi_watchdog_tick(regs);
+		if (call_nmi_handlers(regs))
 			return;
-		}
-#endif
+
 		unknown_nmi_error(reason, regs);
 		return;
 	}
diff -ur linux.orig/include/asm-i386/apic.h linux/include/asm-i386/apic.h
--- linux.orig/include/asm-i386/apic.h	Mon Oct 21 13:26:04 2002
+++ linux/include/asm-i386/apic.h	Tue Oct 22 12:40:16 2002
@@ -79,7 +79,6 @@
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
-extern inline void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
diff -ur linux.orig/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- linux.orig/include/asm-i386/irq.h	Mon Oct 21 13:24:41 2002
+++ linux/include/asm-i386/irq.h	Wed Oct 23 14:15:59 2002
@@ -12,6 +12,7 @@
 
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/rcupdate.h>
 /* include comes from machine specific directory */
 #include "irq_vectors.h"
 
@@ -27,5 +28,36 @@
 #ifdef CONFIG_X86_LOCAL_APIC
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
+
+
+/**
+ * Register a handler to get called when an NMI occurs.  If the
+ * handler actually handles the NMI, it should return NOTIFY_OK.  If
+ * it did not handle the NMI, it should return NOTIFY_DONE.  It may "or"
+ * on NOTIFY_STOP_MASK to the return value if it does not want other
+ * handlers after it to be notified.  Note that this is a slow-path
+ * handler, if you have a fast-path handler there's another tie-in
+ * for you.  See the oprofile code.
+ */
+#define HAVE_NMI_HANDLER	1
+struct nmi_handler
+{
+	struct list_head link; /* You must init this before use. */
+
+	char *dev_name;
+	void *dev_id;
+	int  (*handler)(void *dev_id, struct pt_regs *regs);
+	int  priority; /* Handlers called in priority order. */
+
+	/* Don't mess with anything below here. */
+
+	struct rcu_head    rcu;
+	wait_queue_head_t  wait;
+};
+
+int request_nmi(struct nmi_handler *handler);
+
+/* Release will block until the handler is completely free. */
+void release_nmi(struct nmi_handler *handler);
 
 #endif /* _ASM_IRQ_H */

--------------020605040606070004030500--

