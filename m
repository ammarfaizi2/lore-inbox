Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUHSOji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUHSOji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHSOji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:39:38 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:30397 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266289AbUHSOf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:35:58 -0400
Message-ID: <4124BACB.30100@acm.org>
Date: Thu, 19 Aug 2004 09:35:55 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
Content-Type: multipart/mixed;
 boundary="------------020204010906080105000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020204010906080105000003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch modifies the NMI handling to do the following (for 
x86 only):

* Allow multiple handlers to be registered and return if they have 
handled the NMI or not.  oprofile and nmi_watchdog are modified to use this.
* Modifies the NMI watchdog code to use a function pointer instead of 
using if statements depending on CPU type.  This made the change for the
  previous item easier.
* Moved the "unhandled NMI" code from nmi.c to traps.c, since nmi.c is 
really the handling for the nmi watchdog, not general nmi handling.
* Renames include/linux/nmi.h to include/linux/nmi_watchdog.h and 
creates a new include/linux/nmi.h for purely NMI handling.

This patch used to rename nmi.c to nmi_watchdog.c and create a new nmi.c 
file that was actually NMI handling.  That's probably too big for now, 
but might be a useful change in the future.

I need this because the IPMI watchdog can generate NMIs as a pretimeout, 
to say "Hey, I'm about to fire the watchdog, do you want to do anything 
about it?".  That way, the watchdog driver can panic thus generating 
useful information instead of just resetting the processor.  I have seen 
other watchdog timers with this capability, too.  And other 
special-purpose hardware that generates NMIs might find this useful, too.

I needed multiple handlers so the NMI watchdog and IPMI watchdog (and 
other NMI-related things) can peacefully coexist.  It is not perfect 
because the hardware around NMIs sucks so badly, but it does work ok.

This code has been available as a patch as part of the IPMI driver for a 
while, so it has seen some testing.

-Corey

--------------020204010906080105000003
Content-Type: text/plain;
 name="nmi-handlers-2.6.8.1-mm2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi-handlers-2.6.8.1-mm2.diff"

Index: linux-2.6.8.1-mm2/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.8.1-mm2.orig/arch/i386/kernel/i386_ksyms.c	2004-08-19 08:41:33.000000000 -0500
+++ linux-2.6.8.1-mm2/arch/i386/kernel/i386_ksyms.c	2004-08-19 08:42:29.000000000 -0500
@@ -33,6 +33,9 @@
 #include <asm/nmi.h>
 #include <asm/ist.h>
 #include <asm/kdebug.h>
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/apic.h>
+#endif
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -88,6 +91,12 @@
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
 
+EXPORT_SYMBOL(request_nmi);
+EXPORT_SYMBOL(release_nmi);
+#ifdef CONFIG_X86_LOCAL_APIC
+EXPORT_SYMBOL(nmi_watchdog);
+#endif
+
 EXPORT_SYMBOL_NOVERS(__down_failed);
 EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
 EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
@@ -171,9 +180,6 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
-
 #undef memcmp
 extern int memcmp(const void *,const void *,__kernel_size_t);
 EXPORT_SYMBOL_NOVERS(memcmp);
Index: linux-2.6.8.1-mm2/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.8.1-mm2.orig/arch/i386/kernel/irq.c	2004-08-19 08:41:33.000000000 -0500
+++ linux-2.6.8.1-mm2/arch/i386/kernel/irq.c	2004-08-19 08:42:29.000000000 -0500
@@ -143,6 +143,8 @@
  * Generic, controller-independent functions:
  */
 
+extern void nmi_append_user_names(struct seq_file *p);
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
@@ -181,6 +183,8 @@
 		seq_printf(p, "NMI: ");
 		for_each_cpu(j)
 			seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "                ");
+		nmi_append_user_names(p);
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
Index: linux-2.6.8.1-mm2/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.8.1-mm2.orig/arch/i386/kernel/nmi.c	2004-08-19 08:41:33.000000000 -0500
+++ linux-2.6.8.1-mm2/arch/i386/kernel/nmi.c	2004-08-19 09:33:38.000000000 -0500
@@ -25,7 +25,7 @@
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
-#include <linux/sysctl.h>
+#include <linux/notifier.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -45,11 +45,12 @@
 unsigned int nmi_watchdog = NMI_NONE;
 #endif
 
-extern int unknown_nmi_panic;
 static unsigned int nmi_hz = HZ;
-static unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
-static unsigned int nmi_p4_cccr_val;
 extern void show_registers(struct pt_regs *regs);
+void touch_nmi_watchdog (void);
+
+/* Special P4 register. */
+static unsigned int nmi_p4_cccr_val;
 
 /*
  * lapic_nmi_owner tracks the ownership of the lapic NMI hardware:
@@ -65,6 +66,21 @@
 #define LAPIC_NMI_WATCHDOG	(1<<0)
 #define LAPIC_NMI_RESERVED	(1<<1)
 
+/* This is for I/O APIC, until we can figure out how to tell if it's from the
+   I/O APIC.  If the NMI was not handled before now, we handle it. */
+static int dummy_watchdog_reset(int handled)
+{
+	if (!handled)
+		return 1;
+	return 0;
+}
+
+/* 
+ * Returns 1 if it is a source of the NMI, and resets the NMI to go
+ * off again.
+ */
+static int (*watchdog_reset)(int handled) = dummy_watchdog_reset;
+
 /* nmi_active:
  * +1: the lapic NMI watchdog is active, but can be disabled
  *  0: the lapic NMI watchdog has not been set up, and cannot
@@ -146,6 +162,21 @@
 	return 0;
 }
 
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs, int cpu,
+	int handled);
+
+static struct nmi_handler nmi_watchdog_handler =
+{
+	.link     = LIST_HEAD_INIT(nmi_watchdog_handler.link),
+	.dev_name = "nmi_watchdog",
+	.dev_id   = NULL,
+	.handler  = nmi_watchdog_tick,
+
+	/* One less than oprofile's priority.  We must be immediately after
+	   oprofile, and higher than everything else. */
+	.priority = NMI_HANDLER_MAX_PRIORITY-1
+};
+
 static int __init setup_nmi_watchdog(char *str)
 {
 	int nmi;
@@ -177,6 +208,18 @@
 		nmi_active = 1;
 		nmi_watchdog = nmi;
 	}
+ 
+ 	if (nmi_watchdog != NMI_NONE) {
+ 		if (request_nmi(&nmi_watchdog_handler) != 0) {
+ 			/* Couldn't add a watchdog handler, give up. */
+ 			printk(KERN_WARNING
+ 			       "nmi_watchdog: Couldn't request nmi\n");
+ 			nmi_watchdog = NMI_NONE;
+			nmi_active = 0;
+ 			return 0;
+ 		}
+ 	}
+ 
 	return 1;
 }
 
@@ -253,17 +296,19 @@
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
 		return;
 
-	unset_nmi_callback();
 	nmi_active = -1;
+	release_nmi(&nmi_watchdog_handler);
 	nmi_watchdog = NMI_NONE;
 }
 
 void enable_timer_nmi_watchdog(void)
 {
 	if (nmi_active < 0) {
-		nmi_watchdog = NMI_IO_APIC;
-		touch_nmi_watchdog();
-		nmi_active = 1;
+		if (request_nmi(&nmi_watchdog_handler) == 0) {
+			nmi_watchdog = NMI_IO_APIC;
+			nmi_active = 1;
+			touch_nmi_watchdog();
+		}
 	}
 }
 
@@ -327,12 +372,28 @@
 		wrmsr(base+i, 0, 0);
 }
 
+static int k7_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_K7_PERFCTR0, low, high);
+	/* 
+	 * If the timer has overflowed, this is certainly a watchdog
+	 * source
+	 */
+	source = (low & (1 << 31)) == 0;
+	if (source)
+		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	return source;
+}
+
 static void setup_k7_watchdog(void)
 {
 	unsigned int evntsel;
 
-	nmi_perfctr_msr = MSR_K7_PERFCTR0;
-
+	watchdog_reset = k7_watchdog_reset;
+  
 	clear_msr_range(MSR_K7_EVNTSEL0, 4);
 	clear_msr_range(MSR_K7_PERFCTR0, 4);
 
@@ -349,12 +410,33 @@
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 }
 
+static int p6_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_P6_PERFCTR0, low, high);
+	/* 
+	 * If the timer has overflowed, this is certainly a watchdog
+	 * source
+	 */
+	source = (low & (1 << 31)) == 0;
+	if (source) {
+		/* Only P6 based Pentium M need to re-unmask
+		 * the apic vector but it doesn't hurt
+		 * other P6 variant */
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	}
+	return source;
+}
+
 static void setup_p6_watchdog(void)
 {
 	unsigned int evntsel;
 
-	nmi_perfctr_msr = MSR_P6_PERFCTR0;
-
+	watchdog_reset = p6_watchdog_reset;
+  
 	clear_msr_range(MSR_P6_EVNTSEL0, 2);
 	clear_msr_range(MSR_P6_PERFCTR0, 2);
 
@@ -371,6 +453,33 @@
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
 }
 
+static int p4_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_P4_IQ_COUNTER0, low, high);
+	/* 
+	 * If the timer has overflowed, this is certainly a watchdog
+	 * source
+	 */
+	source = (low & (1 << 31)) == 0;
+	if (source) {
+		/*
+		 * P4 quirks:
+		 * - An overflown perfctr will assert its interrupt
+		 *   until the OVF flag in its CCCR is cleared.
+		 * - LVTPC is masked on interrupt and must be
+		 *   unmasked by the LVTPC handler.
+		 */
+		wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+
+		wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	}
+	return source;
+}
+
 static int setup_p4_watchdog(void)
 {
 	unsigned int misc_enable, dummy;
@@ -379,7 +488,8 @@
 	if (!(misc_enable & MSR_P4_MISC_ENABLE_PERF_AVAIL))
 		return 0;
 
-	nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
+	watchdog_reset = p4_watchdog_reset;
+
 	nmi_p4_cccr_val = P4_NMI_IQ_CCCR0;
 #ifdef CONFIG_SMP
 	if (smp_num_siblings == 2)
@@ -476,15 +586,29 @@
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
-void nmi_watchdog_tick (struct pt_regs * regs)
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs, int cpu,
+	int handled)
 {
-
 	/*
 	 * Since current_thread_info()-> is always on the stack, and we
 	 * always switch the stack NMI-atomically, it's safe to use
 	 * smp_processor_id().
 	 */
-	int sum, cpu = smp_processor_id();
+	int sum;
+
+	/*
+	 * The only thing that SHOULD be before us is the oprofile
+	 * code.  If it has handled an NMI, then we shouldn't.  This
+	 * is a rather unnatural relationship, it would much better to
+	 * build a perf-counter handler and then tie both the
+	 * watchdog and oprofile code to it.  Then this ugliness
+	 * could go away.
+	 */
+	if (handled)
+		return NOTIFY_DONE;
+
+	if (! watchdog_reset(handled))
+		return NOTIFY_DONE; /* We are not an NMI source. */
 
 	sum = irq_stat[cpu].apic_timer_irqs;
 
@@ -512,74 +636,12 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (nmi_perfctr_msr) {
-		if (nmi_perfctr_msr == MSR_P4_IQ_COUNTER0) {
-			/*
-			 * P4 quirks:
-			 * - An overflown perfctr will assert its interrupt
-			 *   until the OVF flag in its CCCR is cleared.
-			 * - LVTPC is masked on interrupt and must be
-			 *   unmasked by the LVTPC handler.
-			 */
-			wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
-			apic_write(APIC_LVTPC, APIC_DM_NMI);
-		}
-		else if (nmi_perfctr_msr == MSR_P6_PERFCTR0) {
-			/* Only P6 based Pentium M need to re-unmask
-			 * the apic vector but it doesn't hurt
-			 * other P6 variant */
-			apic_write(APIC_LVTPC, APIC_DM_NMI);
-		}
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
-	}
-}
-
-#ifdef CONFIG_SYSCTL
-
-static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
-{
-	unsigned char reason = get_nmi_reason();
-	char buf[64];
 
-	if (!(reason & 0xc0)) {
-		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
-		die_nmi(regs, buf);
-	}
-	return 0;
-}
-
-/*
- * proc handler for /proc/sys/kernel/unknown_nmi_panic
- */
-int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
-			void __user *buffer, size_t *length, loff_t *ppos)
-{
-	int old_state;
-
-	old_state = unknown_nmi_panic;
-	proc_dointvec(table, write, file, buffer, length, ppos);
-	if (!!old_state == !!unknown_nmi_panic)
-		return 0;
-
-	if (unknown_nmi_panic) {
-		if (reserve_lapic_nmi() < 0) {
-			unknown_nmi_panic = 0;
-			return -EBUSY;
-		} else {
-			set_nmi_callback(unknown_nmi_panic_callback);
-		}
-	} else {
-		release_lapic_nmi();
-		unset_nmi_callback();
-	}
-	return 0;
+	return NOTIFY_OK;
 }
 
-#endif
-
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(reserve_lapic_nmi);
 EXPORT_SYMBOL(release_lapic_nmi);
-EXPORT_SYMBOL(disable_timer_nmi_watchdog);
 EXPORT_SYMBOL(enable_timer_nmi_watchdog);
Index: linux-2.6.8.1-mm2/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.8.1-mm2.orig/arch/i386/kernel/traps.c	2004-08-19 08:41:33.000000000 -0500
+++ linux-2.6.8.1-mm2/arch/i386/kernel/traps.c	2004-08-19 08:42:29.000000000 -0500
@@ -25,6 +25,9 @@
 #include <linux/highmem.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/seq_file.h>
+#include <linux/notifier.h>
+#include <linux/sysctl.h>
 #include <linux/version.h>
 #include <linux/kprobes.h>
 
@@ -59,6 +62,9 @@
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
+void init_nmi(void);
+
+extern int unknown_nmi_panic;
 
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
@@ -549,6 +555,95 @@
 	}
 }
 
+extern void show_registers(struct pt_regs *regs);
+
+/* 
+ * A list of handlers for NMIs.  This list will be called in order
+ * when an NMI from an otherwise unidentifiable source comes in.  If
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
+static void free_nmi_handler(struct rcu_head *head)
+{
+	struct nmi_handler *handler = container_of(head, struct nmi_handler,
+						   rcu);
+
+	INIT_LIST_HEAD(&(handler->link));
+	complete(&(handler->complete));
+}
+
+int request_nmi(struct nmi_handler *handler)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h = NULL;
+
+	if (!list_empty(&(handler->link)))
+		return -EBUSY;
+
+	spin_lock(&nmi_handler_lock);
+
+	__list_for_each(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		if (curr_h->priority <= handler->priority)
+			break;
+	}
+
+	/* list_add_rcu takes care of memory barrier */
+	if (curr_h)
+		if (curr_h->priority <= handler->priority)
+			list_add_rcu(&(handler->link), curr_h->link.prev);
+		else
+			list_add_rcu(&(handler->link), &(curr_h->link));
+	else
+		list_add_rcu(&(handler->link), &nmi_handler_list);
+
+	spin_unlock(&nmi_handler_lock);
+	return 0;
+}
+
+void release_nmi(struct nmi_handler *handler)
+{
+	spin_lock(&nmi_handler_lock);
+	list_del_rcu(&(handler->link));
+	init_completion(&(handler->complete));
+	call_rcu(&(handler->rcu), free_nmi_handler);
+	spin_unlock(&nmi_handler_lock);
+
+	/* Wait for handler to finish being freed.  This can't be
+           interrupted, we must wait until it finished. */
+	wait_for_completion(&(handler->complete));
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
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
@@ -574,22 +669,6 @@
 	outb(reason, 0x61);
 }
 
-static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
-{
-#ifdef CONFIG_MCA
-	/* Might actually be able to figure out what the guilty party
-	* is. */
-	if( MCA_bus ) {
-		mca_handle_nmi();
-		return;
-	}
-#endif
-	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
-		reason, smp_processor_id());
-	printk("Dazed and confused, but trying to continue\n");
-	printk("Do you have a strange power saving mode enabled?\n");
-}
-
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
 
 void die_nmi (struct pt_regs *regs, const char *msg)
@@ -611,53 +690,67 @@
 	do_exit(SIGSEGV);
 }
 
-static void default_do_nmi(struct pt_regs * regs)
+static void unknown_nmi_error(struct pt_regs * regs, int cpu)
 {
 	unsigned char reason = get_nmi_reason();
- 
-	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
-							== NOTIFY_BAD)
-			return;
-#ifdef CONFIG_X86_LOCAL_APIC
-		/*
-		 * Ok, so this is none of the documented NMI sources,
-		 * so it must be the NMI watchdog.
-		 */
-		if (nmi_watchdog) {
-			nmi_watchdog_tick(regs);
-			return;
-		}
-#endif
-		unknown_nmi_error(reason, regs);
+	char buf[64];
+
+#ifdef CONFIG_MCA
+	/* Might actually be able to figure out what the guilty party
+	* is. */
+	if( MCA_bus ) {
+		mca_handle_nmi();
 		return;
 	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_BAD)
-		return;
-	if (reason & 0x80)
-		mem_parity_error(reason, regs);
-	if (reason & 0x40)
-		io_check_error(reason, regs);
-	/*
-	 * Reassert NMI in case it became active meanwhile
-	 * as it's edge-triggered.
-	 */
-	reassert_nmi();
+#endif
+
+	if (unknown_nmi_panic && (!(reason & 0xc0))) {
+		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
+		die_nmi(regs, buf);
+	}
+
+	printk("Uhhuh. Received NMI for unknown reason on CPU %d.\n", cpu);
+	printk("Dazed and confused, but trying to continue\n");
+	printk("Do you have a strange power saving mode enabled?\n");
 }
 
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
+/* Check "normal" sources of NMI. */
+static int nmi_std (void * dev_id, struct pt_regs * regs, int cpu, int handled)
 {
-	return 0;
+	unsigned char reason;
+
+	reason = inb(0x61);
+	if (reason & 0xc0) {
+		if (reason & 0x80)
+			mem_parity_error(reason, regs);
+		if (reason & 0x40)
+			io_check_error(reason, regs);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
 }
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
-asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+
+static struct nmi_handler nmi_std_handler =
 {
-	int cpu;
+	.link     = LIST_HEAD_INIT(nmi_std_handler.link),
+	.dev_name = "nmi_std",
+	.dev_id   = NULL,
+	.handler  = nmi_std,
+	.priority = 128, /* mid-level priority. */
+};
 
-	nmi_enter();
+asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
+	int                val;
+	int                cpu;
+	int                handled = 0;
+ 
 
+ 	nmi_enter();
+ 
 	cpu = smp_processor_id();
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -669,20 +762,85 @@
 
 	++nmi_count(cpu);
 
-	if (!nmi_callback(regs, cpu))
-		default_do_nmi(regs);
+	/*
+	 * Since NMIs are edge-triggered, we could possibly miss one
+	 * if we don't call them all, so we call them all.
+	 */
 
-	nmi_exit();
+	__list_for_each_rcu(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		val = curr_h->handler(curr_h->dev_id, regs, cpu, handled);
+		switch (val) {
+		case NOTIFY_OK:
+			handled = 1;
+			break;
+			
+		case NOTIFY_DONE:
+		default:
+			;
+		}
+	}
+
+	if (!handled)
+		unknown_nmi_error(regs, cpu);
+	else {
+		/*
+		 * Reassert NMI in case it became active meanwhile
+		 * as it's edge-triggered.    Don't do this if the NMI
+		 * wasn't handled to avoid an infinite NMI loop.
+		 *
+		 * This is necessary in case we have another external
+		 * NMI while processing this one.  The external NMIs
+		 * are level-generated, into the processor NMIs are
+		 * edge-triggered, so if you have one NMI source
+		 * come in while another is already there, the level
+		 * will never go down to cause another edge, and
+		 * no more NMIs will happen.  This does NOT apply
+		 * to internally generated NMIs, though, so you
+		 * can't use the same trick to only call one handler
+		 * at a time.  Otherwise, if two internal NMIs came
+		 * in at the same time you might miss one.
+		 */
+		outb(0x8f, 0x70);
+		inb(0x71);		/* dummy */
+		outb(0x0f, 0x70);
+		inb(0x71);		/* dummy */
+	}
+ 
+ 	nmi_exit();
 }
 
-void set_nmi_callback(nmi_callback_t callback)
+#ifdef CONFIG_SYSCTL
+
+/*
+ * proc handler for /proc/sys/kernel/unknown_nmi_panic
+ */
+int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
+			   void __user *buffer, size_t *length, loff_t *ppos)
 {
-	nmi_callback = callback;
+	int old_state;
+
+	old_state = unknown_nmi_panic;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	if (!!old_state == !!unknown_nmi_panic)
+		return 0;
+
+	if (unknown_nmi_panic) {
+		if (reserve_lapic_nmi() < 0) {
+			unknown_nmi_panic = 0;
+			return -EBUSY;
+		}
+	} else {
+		release_lapic_nmi();
+	}
+	return 0;
 }
 
-void unset_nmi_callback(void)
+#endif
+
+void __init init_nmi(void)
 {
-	nmi_callback = dummy_nmi_callback;
+	request_nmi(&nmi_std_handler);
 }
 
 #ifdef CONFIG_KPROBES
@@ -1131,4 +1289,6 @@
 	cpu_init();
 
 	trap_init_hook();
+
+	init_nmi();
 }
Index: linux-2.6.8.1-mm2/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux-2.6.8.1-mm2.orig/arch/i386/oprofile/nmi_int.c	2004-08-19 08:36:46.000000000 -0500
+++ linux-2.6.8.1-mm2/arch/i386/oprofile/nmi_int.c	2004-08-19 08:42:29.000000000 -0500
@@ -82,11 +82,24 @@
 #endif /* CONFIG_PM */
 
 
-static int nmi_callback(struct pt_regs * regs, int cpu)
+// FIXME: kernel_only
+static int nmi_callback(void * dev_id, struct pt_regs * regs, int cpu, int handled)
 {
-	return model->check_ctrs(cpu, &cpu_msrs[cpu], regs);
+	if (model->check_ctrs(cpu, &cpu_msrs[cpu], regs))
+		return NOTIFY_OK;
+
+	return NOTIFY_DONE;
 }
  
+static struct nmi_handler nmi_handler =
+{
+	.link     = LIST_HEAD_INIT(nmi_handler.link),
+	.dev_name = "oprofile",
+	.dev_id   = NULL,
+	.handler  = nmi_callback,
+	.priority = NMI_HANDLER_MAX_PRIORITY /* Highest possible priority */
+};
+
  
 static void nmi_cpu_save_registers(struct op_msrs * msrs)
 {
@@ -173,8 +186,12 @@
 }
 
 
+static void nmi_cpu_shutdown(void * dummy);
+
 static int nmi_setup(void)
 {
+	int rv;
+
 	if (!allocate_msrs())
 		return -ENOMEM;
 
@@ -192,7 +209,13 @@
 	 */
 	on_each_cpu(nmi_save_registers, NULL, 0, 1);
 	on_each_cpu(nmi_cpu_setup, NULL, 0, 1);
-	set_nmi_callback(nmi_callback);
+	rv = request_nmi(&nmi_handler);
+	if (rv) {
+		smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
+		nmi_cpu_shutdown(0);
+		return rv;
+	}
+
 	nmi_enabled = 1;
 	return 0;
 }
@@ -243,7 +266,7 @@
 {
 	nmi_enabled = 0;
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
-	unset_nmi_callback();
+	release_nmi(&nmi_handler);
 	release_lapic_nmi();
 	free_msrs();
 }
Index: linux-2.6.8.1-mm2/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.8.1-mm2.orig/arch/x86_64/kernel/nmi.c	2004-08-19 08:36:46.000000000 -0500
+++ linux-2.6.8.1-mm2/arch/x86_64/kernel/nmi.c	2004-08-19 08:42:29.000000000 -0500
@@ -23,7 +23,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
Index: linux-2.6.8.1-mm2/drivers/acpi/osl.c
===================================================================
--- linux-2.6.8.1-mm2.orig/drivers/acpi/osl.c	2004-08-19 08:41:42.000000000 -0500
+++ linux-2.6.8.1-mm2/drivers/acpi/osl.c	2004-08-19 08:42:29.000000000 -0500
@@ -35,7 +35,7 @@
 #include <linux/kmod.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
Index: linux-2.6.8.1-mm2/include/asm-i386/apic.h
===================================================================
--- linux-2.6.8.1-mm2.orig/include/asm-i386/apic.h	2004-08-19 08:42:07.000000000 -0500
+++ linux-2.6.8.1-mm2/include/asm-i386/apic.h	2004-08-19 08:42:29.000000000 -0500
@@ -102,7 +102,6 @@
 extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
Index: linux-2.6.8.1-mm2/include/asm-i386/nmi.h
===================================================================
--- linux-2.6.8.1-mm2.orig/include/asm-i386/nmi.h	2004-08-19 08:36:46.000000000 -0500
+++ linux-2.6.8.1-mm2/include/asm-i386/nmi.h	2004-08-19 08:42:29.000000000 -0500
@@ -5,24 +5,40 @@
 #define ASM_NMI_H
 
 #include <linux/pm.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
  
 struct pt_regs;
  
 typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
  
-/** 
- * set_nmi_callback
- *
- * Set a handler for an NMI. Only one handler may be
- * set. Return 1 if the NMI was handled.
+/**
+ * Register a handler to get called when an NMI occurs.  If the
+ * handler actually handles the NMI, it should return NOTIFY_OK.  If
+ * it did not handle the NMI, it should return NOTIFY_DONE.
  */
-void set_nmi_callback(nmi_callback_t callback);
- 
-/** 
- * unset_nmi_callback
- *
- * Remove the handler previously set.
- */
-void unset_nmi_callback(void);
- 
+#define HAVE_NMI_HANDLER		1
+struct nmi_handler
+{
+	struct list_head link; /* You must init this before use. */
+
+	char *dev_name;
+	void *dev_id;
+	int (*handler)(void *dev_id, struct pt_regs *regs, int cpu, int handled);
+	int  priority; /* Handlers called in priority order. */
+
+	/* Don't mess with anything below here. */
+
+	struct rcu_head    rcu;
+	struct completion  complete;
+};
+
+/* Highest possible priority for the handler. */
+#define NMI_HANDLER_MAX_PRIORITY	INT_MAX
+
+int request_nmi(struct nmi_handler *handler);
+
+/* Release will block until the handler is completely free. */
+void release_nmi(struct nmi_handler *handler);
+
 #endif /* ASM_NMI_H */
Index: linux-2.6.8.1-mm2/include/linux/nmi.h
===================================================================
--- linux-2.6.8.1-mm2.orig/include/linux/nmi.h	2004-08-19 08:36:46.000000000 -0500
+++ linux-2.6.8.1-mm2/include/linux/nmi.h	2004-08-19 08:42:29.000000000 -0500
@@ -1,22 +1,11 @@
 /*
- *  linux/include/linux/nmi.h
+ *	linux/include/linux/nmi.h
+ *
+ *	(C) 2002 Corey Minyard <cminyard@mvista.com>
+ *
+ *	Include file for NMI handling.
  */
-#ifndef LINUX_NMI_H
-#define LINUX_NMI_H
-
-#include <asm/irq.h>
-
-/**
- * touch_nmi_watchdog - restart NMI watchdog timeout.
- * 
- * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
- * may be used to reset the timeout - for code which intentionally
- * disables interrupts for a long time. This call is stateless.
- */
-#ifdef ARCH_HAS_NMI_WATCHDOG
-extern void touch_nmi_watchdog(void);
-#else
-# define touch_nmi_watchdog() do { } while(0)
-#endif
 
+#if defined(__i386__)
+#include <asm/nmi.h>
 #endif
Index: linux-2.6.8.1-mm2/include/linux/nmi_watchdog.h
===================================================================
--- linux-2.6.8.1-mm2.orig/include/linux/nmi_watchdog.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.8.1-mm2/include/linux/nmi_watchdog.h	2004-08-19 08:42:29.000000000 -0500
@@ -0,0 +1,22 @@
+/*
+ *  linux/include/linux/nmi.h
+ */
+#ifndef LINUX_NMI_WATCHDOG_H
+#define LINUX_NMI_WATCHDOG_H
+
+#include <asm/irq.h>
+
+/**
+ * touch_nmi_watchdog - restart NMI watchdog timeout.
+ * 
+ * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
+ * may be used to reset the timeout - for code which intentionally
+ * disables interrupts for a long time. This call is stateless.
+ */
+#ifdef ARCH_HAS_NMI_WATCHDOG
+extern void touch_nmi_watchdog(void);
+#else
+# define touch_nmi_watchdog() do { } while(0)
+#endif
+
+#endif
Index: linux-2.6.8.1-mm2/kernel/panic.c
===================================================================
--- linux-2.6.8.1-mm2.orig/kernel/panic.c	2004-08-19 08:42:13.000000000 -0500
+++ linux-2.6.8.1-mm2/kernel/panic.c	2004-08-19 08:42:29.000000000 -0500
@@ -18,7 +18,7 @@
 #include <linux/sysrq.h>
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 
 int panic_timeout;
 int panic_on_oops;
Index: linux-2.6.8.1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.8.1-mm2.orig/kernel/sched.c	2004-08-19 08:42:13.000000000 -0500
+++ linux-2.6.8.1-mm2/kernel/sched.c	2004-08-19 08:42:29.000000000 -0500
@@ -20,7 +20,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/highmem.h>

--------------020204010906080105000003--
