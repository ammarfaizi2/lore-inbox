Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264866AbSJVRy6>; Tue, 22 Oct 2002 13:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264894AbSJVRy6>; Tue, 22 Oct 2002 13:54:58 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:21008 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264866AbSJVRxg>;
	Tue, 22 Oct 2002 13:53:36 -0400
Message-ID: <3DB59225.4020205@acm.org>
Date: Tue, 22 Oct 2002 13:00:05 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: John Levon <levon@movementarian.org>, Keith Owens <kaos@ocs.com.au>
Subject: [PATCH] NMI request/release, version 2
Content-Type: multipart/mixed;
 boundary="------------030004060807070905090804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030004060807070905090804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Add a request/release mechanism to the kernel (x86 only for now) for NMIs.

This version has a lot of updates, mostly changes for comments from John 
Levon.  I have modified the nmi watchdog to use this interface, and it 
seems to work ok.  Keith Owens is copied to see if he would be 
interested in converting kdb to use this, if it gets put into the kernel.

-Corey

--------------030004060807070905090804
Content-Type: text/plain;
 name="linux-nmi-v2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nmi-v2.diff"

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
+++ linux/arch/i386/kernel/nmi.c	Tue Oct 22 12:43:20 2002
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/mc146818rtc.h>
 #include <linux/kernel_stat.h>
+#include <linux/notifier.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -102,6 +103,16 @@
 	return 0;
 }
 
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs);
+
+static struct nmi_handler nmi_watchdog_handler =
+{
+	.dev_name = "nmi_watchdog",
+	.dev_id   = NULL,
+	.handler  = nmi_watchdog_tick,
+	.priority = 255 /* We want to be relatively high priority. */
+};
+
 static int __init setup_nmi_watchdog(char *str)
 {
 	int nmi;
@@ -131,6 +142,9 @@
 	 */
 	if (nmi == NMI_IO_APIC)
 		nmi_watchdog = nmi;
+
+	request_nmi(&nmi_watchdog_handler);
+
 	return 1;
 }
 
@@ -350,7 +364,7 @@
 		alert_counter[i] = 0;
 }
 
-void nmi_watchdog_tick (struct pt_regs * regs)
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs)
 {
 
 	/*
@@ -401,4 +415,6 @@
 		}
 		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
 	}
+
+	return NOTIFY_OK;
 }
diff -ur linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux.orig/arch/i386/kernel/traps.c	Mon Oct 21 13:25:45 2002
+++ linux/arch/i386/kernel/traps.c	Tue Oct 22 12:41:07 2002
@@ -23,6 +23,8 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
+#include <linux/notifier.h>
+#include <linux/seq_file.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -485,21 +487,149 @@
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
+/* A list of handlers for NMIs.  This list will be called in order
+   when an NMI from an otherwise unidentifiable source somes in.  If
+   one of these handles the NMI, it should return 1.  NMI handlers
+   cannot claim spinlocks, so we have to handle mutex in a different
+   manner.  A spinlock protects the list from multiple writers.  When
+   something is removed from the list, it will check to see that
+   calling_nmi_handlers is 0 before returning.  If it is not zero,
+   another processor is handling an NMI, and it should wait until it
+   goes to zero to return and allow the user to free that data. */
+static volatile struct nmi_handler *nmi_handler_list = NULL;
+static spinlock_t                  nmi_handler_lock = SPIN_LOCK_UNLOCKED;
+static atomic_t                    calling_nmi_handlers = ATOMIC_INIT(0);
+
+static inline volatile struct nmi_handler *find_nmi_handler(
+	volatile struct nmi_handler *handler,
+	struct nmi_handler volatile **rprev)
+{
+	volatile struct nmi_handler *curr, *prev;
+
+	curr = nmi_handler_list;
+	prev = NULL;
+	while (curr) {
+		if (curr == handler) {
+			break;
+		}
+		prev = curr;
+		curr = curr->next;
+	}
+
+	if (rprev)
+		*rprev = prev;
+
+	return curr;
+}
+
+int request_nmi(struct nmi_handler *handler)
+{
+	volatile struct nmi_handler *curr;
+
+	spin_lock(&nmi_handler_lock);
+
+	/* Make sure the thing is not already in the list. */
+	curr = find_nmi_handler(handler, NULL);
+	if (curr)
+		return EBUSY;
+
+	/* Add it into the list in priority order. */
+	curr = nmi_handler_list;
+	if ((!curr) || (curr->priority < handler->priority)) {
+		handler->next = nmi_handler_list;
+		xchg(&nmi_handler_list, handler);
+	} else {
+		while (curr->next && (curr->next->priority > handler->priority))
+			curr = curr->next;
+		handler->next = curr->next;
+		xchg(&(curr->next), handler);
+	}
+
+	spin_unlock(&nmi_handler_lock);
+	return 0;
+}
+
+void release_nmi(struct nmi_handler *handler)
+{
+	volatile struct nmi_handler *curr, *prev;
+
+	spin_lock(&nmi_handler_lock);
+
+	/* Find it in the list. */
+	curr = find_nmi_handler(handler, &prev);
+
+	if (curr) {
+		/* If it was found, remove it from the list.  We
+                   assume the write operation here is atomic. */
+		if (prev)
+			xchg(&(prev->next), curr->next);
+		else
+			xchg(&nmi_handler_list, curr->next);
+
+		/* If some other part of the kernel is handling an
+		   NMI, we make sure that we don't release the handler
+		   (or really, allow the user to release the handler)
+		   until it has finished handling the NMI. */
+		while (atomic_read(&calling_nmi_handlers))
+			;
+	}
+	spin_unlock(&nmi_handler_lock);
+}
+
+static int call_nmi_handlers(struct pt_regs * regs)
+{
+	volatile struct nmi_handler *curr, *next;
+	int                         handled = 0;
+	int                         val;
+
+	atomic_inc(&calling_nmi_handlers);
+	smp_mb();
+	curr = nmi_handler_list;
+	while (curr) {
+		next = curr->next;
+		val = curr->handler(curr->dev_id, regs);
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
+		curr = next;
+	}
+	smp_mb();
+	atomic_dec(&calling_nmi_handlers);
+	return handled;
+}
+
+void nmi_append_user_names(struct seq_file *p)
+{
+	volatile struct nmi_handler *curr;
+	spin_lock(&nmi_handler_lock);
+	curr = nmi_handler_list;
+	while (curr) {
+		if (curr->dev_name)
+			p += seq_printf(p, " %s", curr->dev_name);
+		curr = curr->next;
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
+		 * Check our handler list to see if anyone can handle this
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
+++ linux/include/asm-i386/irq.h	Tue Oct 22 12:13:10 2002
@@ -28,4 +28,30 @@
 #define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
+
+/* Structure for handling NMIs */
+#define HAVE_NMI_HANDLER	1
+struct nmi_handler
+{
+	char *dev_name;
+	void *dev_id;
+	int  (*handler)(void *dev_id, struct pt_regs *regs);
+	int  priority; /* Handlers called in priority order. */
+
+	volatile struct nmi_handler *next;
+};
+
+/**
+ * Register a handler to get called when an NMI occurs.  If the
+ * handler actually handles the NMI, it should return NOTIFY_OK.  If
+ * it did not handle the NMI, it should return NOTIFY_DONE.  It may or
+ * on NOTIFY_STOP_MASK to the return value if it does not want other
+ * handlers after it to be notified.  Note that this is a slow-path
+ * handler, if you have a fast-path handler there's another tie-in
+ * for you.  See the oprofile code.
+ */
+int request_nmi(struct nmi_handler *handler);
+void release_nmi(struct nmi_handler *handler);
+
+
 #endif /* _ASM_IRQ_H */

--------------030004060807070905090804--

