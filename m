Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVCGTIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVCGTIi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCGTIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:08:37 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:52203 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261234AbVCGTFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:05:45 -0500
Message-ID: <422CA606.4070208@mvista.com>
Date: Mon, 07 Mar 2005 13:05:42 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow multiple NMI handlers to register against NMIs
Content-Type: multipart/mixed;
 boundary="------------070802080706050902050408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070802080706050902050408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch has been posted to LKML a few times.  I think it's ready for 
the mm series, but it needs to be looked over.  This requires the 
previous nmicmos patch that I just posted for x86_64 and is in the mm 
kernel right now for i386.

-Corey

--------------070802080706050902050408
Content-Type: text/plain;
 name="nmi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi.diff"

This patch allows multiple NMI handlers to dynamically bind and
unbind to the NMI.  The IPMI watchdog driver has the concept of
a pretimeout where the hardware can issue an NMI a period of
time before the actual watchdog reset.  This lets a panic occur
instead of a blind reset on a watchdog timeout.  If used
carefully, multiple users may use the NMI as long as they can
correctly identify themselves as the watchdog source.  This
is possible with nmi_watchdog=2 and oprofile, but not with
nmi_watchdog=1.

This is for both x86 and x86_64.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-mm1/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/i386/kernel/i386_ksyms.c
+++ linux-2.6.11-mm1/arch/i386/kernel/i386_ksyms.c
@@ -167,9 +167,6 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
-
 #undef memcmp
 extern int memcmp(const void *,const void *,__kernel_size_t);
 EXPORT_SYMBOL(memcmp);
Index: linux-2.6.11-mm1/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/i386/kernel/irq.c
+++ linux-2.6.11-mm1/arch/i386/kernel/irq.c
@@ -204,6 +204,8 @@
  * /proc/interrupts printing:
  */
 
+extern void nmi_append_user_names(struct seq_file *p);
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
@@ -242,6 +244,8 @@
 		seq_printf(p, "NMI: ");
 		for_each_cpu(j)
 			seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "                ");
+		nmi_append_user_names(p);
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
Index: linux-2.6.11-mm1/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.11-mm1/arch/i386/kernel/nmi.c
@@ -26,6 +26,7 @@
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
+#include <linux/notifier.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -45,11 +46,12 @@
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
@@ -65,6 +67,21 @@
 #define LAPIC_NMI_WATCHDOG	(1<<0)
 #define LAPIC_NMI_RESERVED	(1<<1)
 
+/* This is for I/O APIC, until we can figure out how to tell if it's from the
+   I/O APIC.  If the NMI  was not handled before now, we handle it. */
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
@@ -150,6 +167,21 @@
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
@@ -181,6 +213,18 @@
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
 
@@ -257,17 +301,19 @@
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
 
@@ -331,12 +377,24 @@
 		wrmsr(base+i, 0, 0);
 }
 
+static int k7_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_K7_PERFCTR0, low, high);
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
 
@@ -353,12 +411,29 @@
 	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
 }
 
+static int p6_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_P6_PERFCTR0, low, high);
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
 
@@ -375,6 +450,29 @@
 	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
 }
 
+static int p4_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_P4_IQ_COUNTER0, low, high);
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
@@ -383,7 +481,8 @@
 	if (!(misc_enable & MSR_P4_MISC_ENABLE_PERF_AVAIL))
 		return 0;
 
-	nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
+	watchdog_reset = p4_watchdog_reset;
+
 	nmi_p4_cccr_val = P4_NMI_IQ_CCCR0;
 #ifdef CONFIG_SMP
 	if (smp_num_siblings == 2)
@@ -486,15 +585,29 @@
 
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
 
@@ -522,71 +635,10 @@
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
-
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
Index: linux-2.6.11-mm1/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/i386/kernel/traps.c
+++ linux-2.6.11-mm1/arch/i386/kernel/traps.c
@@ -25,6 +25,9 @@
 #include <linux/highmem.h>
 #include <linux/kallsyms.h>
 #include <linux/ptrace.h>
+#include <linux/seq_file.h>
+#include <linux/notifier.h>
+#include <linux/sysctl.h>
 #include <linux/utsname.h>
 #include <linux/kprobes.h>
 
@@ -57,6 +60,7 @@
 #include "mach_traps.h"
 
 asmlinkage int system_call(void);
+void init_nmi(void);
 
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
@@ -94,6 +98,7 @@
 static int kstack_depth_to_print = 24;
 struct notifier_block *i386die_chain;
 static DEFINE_SPINLOCK(die_notifier_lock);
+extern int unknown_nmi_panic;
 
 int register_die_notifier(struct notifier_block *nb)
 {
@@ -555,6 +560,97 @@
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
+EXPORT_SYMBOL(request_nmi);
+EXPORT_SYMBOL(release_nmi);
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
+			seq_printf(p, " %s", curr_h->dev_name);
+	}
+	spin_unlock(&nmi_handler_lock);
+}
+
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
@@ -580,21 +676,7 @@
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
+static unsigned char last_nmi_reason[NR_CPUS];
 
 static DEFINE_SPINLOCK(nmi_print_lock);
 
@@ -617,55 +699,74 @@
 	do_exit(SIGSEGV);
 }
 
-static void default_do_nmi(struct pt_regs * regs)
+static void unknown_nmi_error(struct pt_regs * regs, int cpu)
+{
+#ifdef CONFIG_MCA
+	/* Might actually be able to figure out what the guilty party
+	* is. */
+	if( MCA_bus ) {
+		mca_handle_nmi();
+		return;
+	}
+#endif
+	if (unknown_nmi_panic) {
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs,
+			       last_nmi_reason[cpu], 0, SIGINT)
+		    == NOTIFY_STOP)
+			return;
+		return;
+	}
+	if (notify_die(DIE_NMI, "nmi", regs, last_nmi_reason[cpu], 0, SIGINT)
+	    == NOTIFY_STOP)
+		return;
+
+	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+		last_nmi_reason[cpu], cpu);
+	printk("Dazed and confused, but trying to continue\n");
+	printk("Do you have a strange power saving mode enabled?\n");
+}
+
+/* Check "normal" sources of NMI. */
+static int nmi_std (void * dev_id, struct pt_regs * regs, int cpu, int handled)
 {
 	unsigned char reason = 0;
+	int rv = NOTIFY_DONE;
 
 	/* Only the BSP gets external NMIs from the system.  */
 	if (!smp_processor_id())
 		reason = get_nmi_reason();
  
-	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
-							== NOTIFY_STOP)
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
-		return;
-	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
-		return;
-	if (reason & 0x80)
+	last_nmi_reason[cpu] = reason;
+
+	if (reason & 0x80) {
 		mem_parity_error(reason, regs);
-	if (reason & 0x40)
+		rv = NOTIFY_OK;
+	}
+	if (reason & 0x40) {
 		io_check_error(reason, regs);
-	/*
-	 * Reassert NMI in case it became active meanwhile
-	 * as it's edge-triggered.
-	 */
-	reassert_nmi();
-}
+		rv = NOTIFY_OK;
+	}
 
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
+	return rv;
 }
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
-fastcall void do_nmi(struct pt_regs * regs, long error_code)
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
 
+asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
+	int                val;
+	int                cpu;
+	int                handled = 0;
+ 
 	nmi_enter();
 
 	cpu = smp_processor_id();
@@ -679,20 +780,42 @@
 
 	++nmi_count(cpu);
 
-	if (!nmi_callback(regs, cpu))
-		default_do_nmi(regs);
+	/*
+	 * Since NMIs are edge-triggered, we could possibly miss one
+	 * if we don't call them all, so we call them all.  We do let
+	 * them know if a previous caller thinks it has handled the
+	 * NMI.
+	 */
 
-	nmi_exit();
-}
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
 
-void set_nmi_callback(nmi_callback_t callback)
-{
-	nmi_callback = callback;
+	if (!handled)
+		unknown_nmi_error(regs, cpu);
+	else
+		/*
+		 * Reassert NMI in case it became active meanwhile
+		 * as it's edge-triggered.
+		 */
+		reassert_nmi();
+ 
+ 	nmi_exit();
 }
 
-void unset_nmi_callback(void)
+void __init init_nmi(void)
 {
-	nmi_callback = dummy_nmi_callback;
+	request_nmi(&nmi_std_handler);
 }
 
 #ifdef CONFIG_KPROBES
@@ -1124,4 +1247,23 @@
 	cpu_init();
 
 	trap_init_hook();
+
+	init_nmi();
 }
+
+#ifdef CONFIG_SYSCTL
+
+/*
+ * proc handler for /proc/sys/kernel/unknown_nmi_panic
+ */
+int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int old_state;
+
+	old_state = unknown_nmi_panic;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	return 0;
+}
+
+#endif
Index: linux-2.6.11-mm1/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/i386/oprofile/nmi_int.c
+++ linux-2.6.11-mm1/arch/i386/oprofile/nmi_int.c
@@ -82,11 +82,23 @@
 #endif /* CONFIG_PM */
 
 
-static int nmi_callback(struct pt_regs * regs, int cpu)
+static int nmi_callback(void * dev_id, struct pt_regs * regs, int cpu, int handled)
 {
-	return model->check_ctrs(regs, &cpu_msrs[cpu]);
+	if (model->check_ctrs(regs, &cpu_msrs[cpu]))
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
@@ -173,8 +185,12 @@
 }
 
 
+static void nmi_cpu_shutdown(void * dummy);
+
 static int nmi_setup(void)
 {
+	int rv;
+
 	if (!allocate_msrs())
 		return -ENOMEM;
 
@@ -192,7 +208,13 @@
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
@@ -243,7 +265,7 @@
 {
 	nmi_enabled = 0;
 	on_each_cpu(nmi_cpu_shutdown, NULL, 0, 1);
-	unset_nmi_callback();
+	release_nmi(&nmi_handler);
 	release_lapic_nmi();
 	free_msrs();
 }
Index: linux-2.6.11-mm1/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.11-mm1/arch/x86_64/kernel/nmi.c
@@ -23,8 +23,9 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/sysdev.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <linux/sysctl.h>
+#include <linux/notifier.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
@@ -48,6 +49,21 @@
 #define LAPIC_NMI_WATCHDOG	(1<<0)
 #define LAPIC_NMI_RESERVED	(1<<1)
 
+/* This is for I/O APIC, until we can figure out how to tell if it's from the
+   I/O APIC.  If the NMI  was not handled before now, we handle it. */
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
@@ -59,7 +75,6 @@
 
 unsigned int nmi_watchdog = NMI_DEFAULT;
 static unsigned int nmi_hz = HZ;
-unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
 
 /* Note that these events don't tick when the CPU idles. This means
    the frequency varies with CPU load. */
@@ -78,9 +93,36 @@
 #define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
 #define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
 
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
+static int nmi_watchdog_handler_setup;
+
 /* Run after command line and cpu_init init, but before all other checks */
 void __init nmi_watchdog_default(void)
 {
+	if ((nmi_watchdog != NMI_NONE) && !nmi_watchdog_handler_setup) {
+		nmi_watchdog_handler_setup = 1;
+		if (request_nmi(&nmi_watchdog_handler) != 0) {
+			/* Couldn't add a watchdog handler, give up. */
+			printk(KERN_WARNING
+			       "nmi_watchdog: Couldn't request nmi\n");
+			nmi_watchdog = NMI_NONE;
+			nmi_active = 0;
+		}
+	}
+
 	if (nmi_watchdog != NMI_DEFAULT)
 		return;
 
@@ -171,7 +213,9 @@
 
 	if (nmi >= NMI_INVALID)
 		return 0;
-		nmi_watchdog = nmi;
+
+	nmi_watchdog = nmi;
+ 
 	return 1;
 }
 
@@ -235,18 +279,20 @@
 		return;
 
 	disable_irq(0);
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
-		enable_irq(0);
+		if (request_nmi(&nmi_watchdog_handler) == 0) {
+			nmi_watchdog = NMI_IO_APIC;
+			nmi_active = 1;
+			touch_nmi_watchdog();
+			enable_irq(0);
+		}
 	}
 }
 
@@ -301,6 +347,18 @@
  * Original code written by Keith Owens.
  */
 
+static int k7_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_K7_PERFCTR0, low, high);
+	source = (low & (1 << 31)) == 0;
+	if (source)
+		wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	return source;
+}
+
 static void setup_k7_watchdog(void)
 {
 	int i;
@@ -311,8 +369,8 @@
 
 	/* XXX should check these in EFER */
 
-	nmi_perfctr_msr = MSR_K7_PERFCTR0;
-
+	watchdog_reset = k7_watchdog_reset;
+  
 	for(i = 0; i < 4; ++i) {
 		/* Simulator may not support it */
 		if (checking_wrmsrl(MSR_K7_EVNTSEL0+i, 0UL))
@@ -380,11 +438,25 @@
 		alert_counter[i] = 0;
 }
 
-void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason)
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs, int cpu,
+	int handled)
 {
-	int sum, cpu;
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
 
-	cpu = safe_smp_processor_id();
 	sum = read_pda(apic_timer_irqs);
 	if (last_irq_sums[cpu] == sum) {
 		/*
@@ -393,10 +465,10 @@
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*nmi_hz) {
-			if (notify_die(DIE_NMI, "nmi", regs, reason, 2, SIGINT)
+			if (notify_die(DIE_NMI, "nmi", regs, handled, 2, SIGINT)
 							== NOTIFY_STOP) {
 				alert_counter[cpu] = 0; 
-				return;
+				return NOTIFY_OK;
 			} 
 			die_nmi("NMI Watchdog detected LOCKUP on CPU%d", regs);
 		}
@@ -404,80 +476,8 @@
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
-	if (nmi_perfctr_msr)
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
-}
-
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
+	return NOTIFY_OK;
 }
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
-asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
-{
-	int cpu = safe_smp_processor_id();
-
-	nmi_enter();
-	add_pda(__nmi_count,1);
-	if (!nmi_callback(regs, cpu))
-		default_do_nmi(regs);
-	nmi_exit();
-}
-
-void set_nmi_callback(nmi_callback_t callback)
-{
-	nmi_callback = callback;
-}
-
-void unset_nmi_callback(void)
-{
-	nmi_callback = dummy_nmi_callback;
-}
-
-#ifdef CONFIG_SYSCTL
-
-static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
-{
-	unsigned char reason = get_nmi_reason();
-	char buf[64];
-
-	if (!(reason & 0xc0)) {
-		sprintf(buf, "NMI received for unknown reason %02x\n", reason);
-		die_nmi(buf,regs);
-	}
-	return 0;
-}
-
-/*
- * proc handler for /proc/sys/kernel/unknown_nmi_panic
- */
-int proc_unknown_nmi_panic(struct ctl_table *table, int write, struct file *file,
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
-}
-
-#endif
 
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
Index: linux-2.6.11-mm1/drivers/acpi/osl.c
===================================================================
--- linux-2.6.11-mm1.orig/drivers/acpi/osl.c
+++ linux-2.6.11-mm1/drivers/acpi/osl.c
@@ -36,7 +36,7 @@
 #include <linux/kmod.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <acpi/acpi.h>
 #include <asm/io.h>
 #include <acpi/acpi_bus.h>
Index: linux-2.6.11-mm1/include/asm-i386/apic.h
===================================================================
--- linux-2.6.11-mm1.orig/include/asm-i386/apic.h
+++ linux-2.6.11-mm1/include/asm-i386/apic.h
@@ -117,7 +117,6 @@
 extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
Index: linux-2.6.11-mm1/include/asm-i386/nmi.h
===================================================================
--- linux-2.6.11-mm1.orig/include/asm-i386/nmi.h
+++ linux-2.6.11-mm1/include/asm-i386/nmi.h
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
Index: linux-2.6.11-mm1/include/linux/nmi.h
===================================================================
--- linux-2.6.11-mm1.orig/include/linux/nmi.h
+++ linux-2.6.11-mm1/include/linux/nmi.h
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
Index: linux-2.6.11-mm1/include/linux/nmi_watchdog.h
===================================================================
--- /dev/null
+++ linux-2.6.11-mm1/include/linux/nmi_watchdog.h
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
Index: linux-2.6.11-mm1/kernel/panic.c
===================================================================
--- linux-2.6.11-mm1.orig/kernel/panic.c
+++ linux-2.6.11-mm1/kernel/panic.c
@@ -17,7 +17,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <linux/kexec.h>
 
 int panic_timeout;
Index: linux-2.6.11-mm1/kernel/sched.c
===================================================================
--- linux-2.6.11-mm1.orig/kernel/sched.c
+++ linux-2.6.11-mm1/kernel/sched.c
@@ -20,7 +20,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/highmem.h>
Index: linux-2.6.11-mm1/kernel/sysctl.c
===================================================================
--- linux-2.6.11-mm1.orig/kernel/sysctl.c
+++ linux-2.6.11-mm1/kernel/sysctl.c
@@ -68,8 +68,6 @@
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
-extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
-				  void __user *, size_t *, loff_t *);
 #endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
@@ -621,7 +619,7 @@
 		.data           = &unknown_nmi_panic,
 		.maxlen         = sizeof (int),
 		.mode           = 0644,
-		.proc_handler   = &proc_unknown_nmi_panic,
+		.proc_handler   = &proc_dointvec,
 	},
 #endif
 #if defined(CONFIG_X86)
Index: linux-2.6.11-mm1/arch/i386/oprofile/nmi_timer_int.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/i386/oprofile/nmi_timer_int.c
+++ linux-2.6.11-mm1/arch/i386/oprofile/nmi_timer_int.c
@@ -18,16 +18,31 @@
 #include <asm/apic.h>
 #include <asm/ptrace.h>
  
-static int nmi_timer_callback(struct pt_regs * regs, int cpu)
+static int nmi_timer_callback(void *dev_id, struct pt_regs * regs, int cpu, int handled)
 {
 	oprofile_add_sample(regs, 0);
 	return 1;
 }
 
+static struct nmi_handler nmi_timer_handler =
+{
+	.link     = LIST_HEAD_INIT(nmi_timer_handler.link),
+	.dev_name = "oprofile_timer",
+	.dev_id   = NULL,
+	.handler  = nmi_timer_callback,
+	.priority = NMI_HANDLER_MAX_PRIORITY /* Highest possible priority */
+};
+ 
 static int timer_start(void)
 {
+	int rv;
+
 	disable_timer_nmi_watchdog();
-	set_nmi_callback(nmi_timer_callback);
+	rv = request_nmi(&nmi_timer_handler);
+	if (rv) {
+		enable_timer_nmi_watchdog();
+		return rv;
+	}
 	return 0;
 }
 
@@ -35,7 +50,7 @@
 static void timer_stop(void)
 {
 	enable_timer_nmi_watchdog();
-	unset_nmi_callback();
+	release_nmi(&nmi_timer_handler);
 	synchronize_kernel();
 }
 
Index: linux-2.6.11-mm1/include/asm-x86_64/apic.h
===================================================================
--- linux-2.6.11-mm1.orig/include/asm-x86_64/apic.h
+++ linux-2.6.11-mm1/include/asm-x86_64/apic.h
@@ -93,7 +93,6 @@
 extern void release_lapic_nmi(void);
 extern void disable_timer_nmi_watchdog(void);
 extern void enable_timer_nmi_watchdog(void);
-extern void nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 extern int APIC_init_uniprocessor (void);
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
Index: linux-2.6.11-mm1/arch/x86_64/kernel/x8664_ksyms.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/x86_64/kernel/x8664_ksyms.c
+++ linux-2.6.11-mm1/arch/x86_64/kernel/x8664_ksyms.c
@@ -129,9 +129,6 @@
 
 EXPORT_SYMBOL(rtc_lock);
 
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
-
 /* Export string functions. We normally rely on gcc builtin for most of these,
    but gcc sometimes decides not to inline them. */    
 #undef memcpy
Index: linux-2.6.11-mm1/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.11-mm1/arch/x86_64/kernel/traps.c
@@ -20,6 +20,9 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
+#include <linux/seq_file.h>
+#include <linux/notifier.h>
+#include <linux/sysctl.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -79,6 +82,7 @@
 
 struct notifier_block *die_chain;
 static DEFINE_SPINLOCK(die_notifier_lock);
+extern int unknown_nmi_panic;
 
 int register_die_notifier(struct notifier_block *nb)
 {
@@ -558,6 +562,97 @@
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
+EXPORT_SYMBOL(request_nmi);
+EXPORT_SYMBOL(release_nmi);
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
+			seq_printf(p, " %s", curr_h->dev_name);
+	}
+	spin_unlock(&nmi_handler_lock);
+}
+
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
@@ -581,66 +676,141 @@
 	outb(reason, 0x61);
 }
 
-static void unknown_nmi_error(unsigned char reason, struct pt_regs * regs)
-{	printk("Uhhuh. NMI received for unknown reason %02x.\n", reason);
+static unsigned char last_nmi_reason[NR_CPUS];
+
+static void unknown_nmi_error(struct pt_regs * regs, int cpu)
+{
+	if (unknown_nmi_panic) {
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs,
+			       last_nmi_reason[cpu], 0, SIGINT)
+		    == NOTIFY_STOP)
+			return;
+		return;
+	}
+	if (notify_die(DIE_NMI, "nmi", regs, last_nmi_reason[cpu], 0, SIGINT)
+	    == NOTIFY_STOP)
+		return;
+
+	printk("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
+		last_nmi_reason[cpu], cpu);
 	printk("Dazed and confused, but trying to continue\n");
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
-asmlinkage void default_do_nmi(struct pt_regs *regs)
+/* Check "normal" sources of NMI. */
+static int nmi_std (void * dev_id, struct pt_regs * regs, int cpu, int handled)
 {
 	unsigned char reason = 0;
-	int old_reg = -1;
+	int rv = NOTIFY_DONE;
 
 	/* Only the BSP gets external NMIs from the system.  */
 	if (!smp_processor_id())
 		reason = get_nmi_reason();
 
-	if (!(reason & 0xc0)) {
-		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
-								== NOTIFY_STOP)
-			return;
-#ifdef CONFIG_X86_LOCAL_APIC
-		/*
-		 * Ok, so this is none of the documented NMI sources,
-		 * so it must be the NMI watchdog.
-		 */
-		if (nmi_watchdog > 0) {
-			nmi_watchdog_tick(regs,reason);
-			return;
-		}
-#endif
-		unknown_nmi_error(reason, regs);
-		return;
-	}
-	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_STOP)
-		return; 
-
-	/* AK: following checks seem to be broken on modern chipsets. FIXME */
+	last_nmi_reason[cpu] = reason;
 
-	if (reason & 0x80)
+	if (reason & 0x80) {
 		mem_parity_error(reason, regs);
-	if (reason & 0x40)
+		rv = NOTIFY_OK;
+	}
+	if (reason & 0x40) {
 		io_check_error(reason, regs);
+		rv = NOTIFY_OK;
+	}
+
+	return rv;
+}
+
+static struct nmi_handler nmi_std_handler =
+{
+	.link     = LIST_HEAD_INIT(nmi_std_handler.link),
+	.dev_name = "nmi_std",
+	.dev_id   = NULL,
+	.handler  = nmi_std,
+	.priority = 128, /* mid-level priority. */
+};
+
+asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
+	int                val;
+	int                cpu;
+	int                handled = 0;
+	int                old_reg = -1;
+
+	cpu = safe_smp_processor_id();
+
+	nmi_enter();
+	add_pda(__nmi_count,1);
 
 	/*
-	 * Reassert NMI in case it became active meanwhile
-	 * as it's edge-triggered.
+	 * Since NMIs are edge-triggered, we could possibly miss one
+	 * if we don't call them all, so we call them all.  We do let
+	 * them know if a previous caller thinks it has handled the
+	 * NMI.
 	 */
-	if (do_i_have_lock_cmos())
-		old_reg = current_lock_cmos_reg();
-	else
-		lock_cmos(0); /* register doesn't matter here */
-	outb(0x8f, 0x70);
-	inb(0x71);		/* dummy */
-	outb(0x0f, 0x70);
-	inb(0x71);		/* dummy */
-	if (old_reg >= 0)
-		outb(old_reg, 0x70);
-	else
-		unlock_cmos();
+
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
+		 * as it's edge-triggered.
+		 */
+		if (do_i_have_lock_cmos())
+			old_reg = current_lock_cmos_reg();
+		else
+			lock_cmos(0); /* register doesn't matter here */
+		outb(0x8f, 0x70);
+		inb(0x71);		/* dummy */
+		outb(0x0f, 0x70);
+		inb(0x71);		/* dummy */
+		if (old_reg >= 0)
+			outb(old_reg, 0x70);
+		else
+			unlock_cmos();
+	}
+
+	nmi_exit();
+}
+
+void __init init_nmi(void)
+{
+	request_nmi(&nmi_std_handler);
+}
+
+#ifdef CONFIG_SYSCTL
+
+/*
+ * proc handler for /proc/sys/kernel/unknown_nmi_panic
+ */
+int proc_unknown_nmi_panic(ctl_table *table, int write, struct file *file,
+			void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int old_state;
+
+	old_state = unknown_nmi_panic;
+	proc_dointvec(table, write, file, buffer, length, ppos);
+	return 0;
 }
 
+#endif
+
 asmlinkage void do_int3(struct pt_regs * regs, long error_code)
 {
 	if (notify_die(DIE_INT3, "int3", regs, error_code, 3, SIGTRAP) == NOTIFY_STOP) {
@@ -951,6 +1121,8 @@
 	 * Should be a barrier for any external CPU state.
 	 */
 	cpu_init();
+
+	init_nmi();
 }
 
 
Index: linux-2.6.11-mm1/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/x86_64/kernel/io_apic.c
+++ linux-2.6.11-mm1/arch/x86_64/kernel/io_apic.c
@@ -1670,7 +1670,7 @@
 	}
 	printk(" failed.\n");
 
-	if (nmi_watchdog) {
+	if (nmi_watchdog == NMI_IO_APIC) {
 		printk(KERN_WARNING "timer doesn't work through the IO-APIC - disabling NMI Watchdog!\n");
 		nmi_watchdog = 0;
 	}
Index: linux-2.6.11-mm1/arch/x86_64/kernel/irq.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/x86_64/kernel/irq.c
+++ linux-2.6.11-mm1/arch/x86_64/kernel/irq.c
@@ -28,6 +28,8 @@
  * Generic, controller-independent functions:
  */
 
+extern void nmi_append_user_names(struct seq_file *p);
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, j;
@@ -69,6 +71,8 @@
 		for (j = 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
 				seq_printf(p, "%10u ", cpu_pda[j].__nmi_count);
+		seq_printf(p, "                ");
+		nmi_append_user_names(p);
 		seq_putc(p, '\n');
 #ifdef CONFIG_X86_LOCAL_APIC
 		seq_printf(p, "LOC: ");
Index: linux-2.6.11-mm1/include/asm-x86_64/nmi.h
===================================================================
--- linux-2.6.11-mm1.orig/include/asm-x86_64/nmi.h
+++ linux-2.6.11-mm1/include/asm-x86_64/nmi.h
@@ -5,26 +5,42 @@
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
 #ifdef CONFIG_PM
  
 /** Replace the PM callback routine for NMI. */

--------------070802080706050902050408--
