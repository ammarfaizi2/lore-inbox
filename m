Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265752AbSKOEYO>; Thu, 14 Nov 2002 23:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbSKOEYO>; Thu, 14 Nov 2002 23:24:14 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:4678 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265752AbSKOEXz>;
	Thu, 14 Nov 2002 23:23:55 -0500
Message-ID: <3DD47858.3060404@mvista.com>
Date: Thu, 14 Nov 2002 22:30:16 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       John Levon <levon@movementarian.org>,
       Dipankar Sarma <dipankar@gamebox.net>, linux-kernel@vger.kernel.org
Subject: NMI handling rework for x86
Content-Type: multipart/mixed;
 boundary="------------000809020304030305060105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000809020304030305060105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,

John Levon suggested I send this to you.  It's a cleanup of the NMI 
handling to make it into a request/release mechanism (instead of 
hard-coding everything into traps.c).  It renames "nmi.c" to 
"nmi_watchdog.c" (as it should be named) and moves the real NMI handling 
code from traps.c to nmi.c.  It's been posted and reworked on lkml, and 
it seems to have finally met approval.  The "cc-ed" people have reviewed 
the patch (or at least made helpful suggestions :-).

Since a lot of things are hacking into this code (lkcd, kdb, oprofile, 
nmi watchdog, and now my IPMI watchdog pretimeout), it would be very 
nice to get their junk out of this code and allow them to bind in 
nicely, and allow binding from modules.

(And this time it's a -p1 diff)

Thanks,

-Corey

--------------000809020304030305060105
Content-Type: text/plain;
 name="linux-nmi-v9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-nmi-v9.diff"

diff -urN linux.orig/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux.orig/arch/i386/kernel/Makefile	Thu Nov 14 21:08:35 2002
+++ linux/arch/i386/kernel/Makefile	Thu Nov 14 21:14:27 2002
@@ -8,7 +8,7 @@
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o
+		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o nmi.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
@@ -22,7 +22,7 @@
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
 obj-$(CONFIG_X86_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
-obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
+obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi_watchdog.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
diff -urN linux.orig/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux.orig/arch/i386/kernel/i386_ksyms.c	Thu Nov 14 21:05:52 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Thu Nov 14 21:07:25 2002
@@ -92,6 +92,9 @@
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);
 
+EXPORT_SYMBOL(request_nmi);
+EXPORT_SYMBOL(release_nmi);
+
 #ifdef CONFIG_DEBUG_IOVIRT
 EXPORT_SYMBOL(__io_virt_debug);
 #endif
@@ -185,8 +188,6 @@
 
 EXPORT_SYMBOL_GPL(register_profile_notifier);
 EXPORT_SYMBOL_GPL(unregister_profile_notifier);
-EXPORT_SYMBOL_GPL(set_nmi_callback);
-EXPORT_SYMBOL_GPL(unset_nmi_callback);
  
 #undef memcpy
 #undef memset
diff -urN linux.orig/arch/i386/kernel/irq.c linux/arch/i386/kernel/irq.c
--- linux.orig/arch/i386/kernel/irq.c	Thu Nov 14 21:05:52 2002
+++ linux/arch/i386/kernel/irq.c	Thu Nov 14 21:07:25 2002
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
diff -urN linux.orig/arch/i386/kernel/nmi.c linux/arch/i386/kernel/nmi.c
--- linux.orig/arch/i386/kernel/nmi.c	Mon Oct 21 13:25:45 2002
+++ linux/arch/i386/kernel/nmi.c	Thu Nov 14 21:15:33 2002
@@ -1,404 +1,245 @@
 /*
  *  linux/arch/i386/nmi.c
  *
- *  NMI watchdog support on APIC systems
+ *  NMI support.
  *
- *  Started by Ingo Molnar <mingo@redhat.com>
+ *  Corey Minyard <cminyard@mvista.com>
  *
- *  Fixes:
- *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
- *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
- *  Mikael Pettersson	: Pentium 4 support for local APIC NMI watchdog.
+ *  Moved some of this over from traps.c.
  */
 
 #include <linux/config.h>
-#include <linux/mm.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
-#include <linux/bootmem.h>
-#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/rcupdate.h>
+#include <linux/seq_file.h>
+#include <linux/notifier.h>
 #include <linux/interrupt.h>
-#include <linux/mc146818rtc.h>
-#include <linux/kernel_stat.h>
 
-#include <asm/smp.h>
-#include <asm/mtrr.h>
-#include <asm/mpspec.h>
-
-unsigned int nmi_watchdog = NMI_NONE;
-static unsigned int nmi_hz = HZ;
-unsigned int nmi_perfctr_msr;	/* the MSR to reset in NMI handler */
-extern void show_registers(struct pt_regs *regs);
+#include <asm/io.h>
+#include <asm/nmi.h>
 
-#define K7_EVNTSEL_ENABLE	(1 << 22)
-#define K7_EVNTSEL_INT		(1 << 20)
-#define K7_EVNTSEL_OS		(1 << 17)
-#define K7_EVNTSEL_USR		(1 << 16)
-#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
-#define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
-
-#define P6_EVNTSEL0_ENABLE	(1 << 22)
-#define P6_EVNTSEL_INT		(1 << 20)
-#define P6_EVNTSEL_OS		(1 << 17)
-#define P6_EVNTSEL_USR		(1 << 16)
-#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
-#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
-
-#define MSR_P4_MISC_ENABLE	0x1A0
-#define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
-#define MSR_P4_MISC_ENABLE_PEBS_UNAVAIL	(1<<12)
-#define MSR_P4_PERFCTR0		0x300
-#define MSR_P4_CCCR0		0x360
-#define P4_ESCR_EVENT_SELECT(N)	((N)<<25)
-#define P4_ESCR_OS		(1<<3)
-#define P4_ESCR_USR		(1<<2)
-#define P4_CCCR_OVF_PMI		(1<<26)
-#define P4_CCCR_THRESHOLD(N)	((N)<<20)
-#define P4_CCCR_COMPLEMENT	(1<<19)
-#define P4_CCCR_COMPARE		(1<<18)
-#define P4_CCCR_REQUIRED	(3<<16)
-#define P4_CCCR_ESCR_SELECT(N)	((N)<<13)
-#define P4_CCCR_ENABLE		(1<<12)
-/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
-   CRU_ESCR0 (with any non-null event selector) through a complemented
-   max threshold. [IA32-Vol3, Section 14.9.9] */
-#define MSR_P4_IQ_COUNTER0	0x30C
-#define MSR_P4_IQ_CCCR0		0x36C
-#define MSR_P4_CRU_ESCR0	0x3B8
-#define P4_NMI_CRU_ESCR0	(P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
-#define P4_NMI_IQ_CCCR0	\
-	(P4_CCCR_OVF_PMI|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
-	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
-
-int __init check_nmi_watchdog (void)
-{
-	unsigned int prev_nmi_count[NR_CPUS];
-	int cpu;
-
-	printk(KERN_INFO "testing NMI watchdog ... ");
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
-	local_irq_enable();
-	mdelay((10*1000)/nmi_hz); // wait 10 ticks
-
-	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
-           as they come up. */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
-			continue;
-		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
-			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
-			return -1;
-		}
-	}
-	printk("OK.\n");
-
-	/* now that we know it works we can reduce NMI frequency to
-	   something more reasonable; makes a difference in some configs */
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-		nmi_hz = 1;
+extern void show_registers(struct pt_regs *regs);
 
-	return 0;
-}
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
 
-static int __init setup_nmi_watchdog(char *str)
+/*
+ * To free the list item, we use an rcu.  The rcu-function will not
+ * run until all processors have done a context switch, gone idle, or
+ * gone to a user process, so it's guaranteed that when this runs, any
+ * NMI handler running at release time has completed and the list item
+ * can be safely freed.
+ */
+static void free_nmi_handler(void *arg)
 {
-	int nmi;
+	struct nmi_handler *handler = arg;
 
-	get_option(&str, &nmi);
-
-	if (nmi >= NMI_INVALID)
-		return 0;
-	if (nmi == NMI_NONE)
-		nmi_watchdog = nmi;
-	/*
-	 * If any other x86 CPU has a local APIC, then
-	 * please test the NMI stuff there and send me the
-	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
-	 */
-	if ((nmi == NMI_LOCAL_APIC) &&
-			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
-		nmi_watchdog = nmi;
-	if ((nmi == NMI_LOCAL_APIC) &&
-			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
-			(boot_cpu_data.x86 == 6))
-		nmi_watchdog = nmi;
-	/*
-	 * We can enable the IO-APIC watchdog
-	 * unconditionally.
-	 */
-	if (nmi == NMI_IO_APIC)
-		nmi_watchdog = nmi;
-	return 1;
+	INIT_LIST_HEAD(&(handler->link));
+	complete(&(handler->complete));
 }
 
-__setup("nmi_watchdog=", setup_nmi_watchdog);
-
-#ifdef CONFIG_PM
+int request_nmi(struct nmi_handler *handler)
+{
+	struct list_head   *curr;
+	struct nmi_handler *curr_h = NULL;
 
-#include <linux/pm.h>
+	if (!list_empty(&(handler->link)))
+		return -EBUSY;
 
-struct pm_dev *nmi_pmdev;
+	spin_lock(&nmi_handler_lock);
 
-static void disable_apic_nmi_watchdog(void)
-{
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_AMD:
-		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
-		break;
-	case X86_VENDOR_INTEL:
-		switch (boot_cpu_data.x86) {
-		case 6:
-			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
-			break;
-		case 15:
-			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
-			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
+	__list_for_each(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		if (curr_h->priority <= handler->priority)
 			break;
-		}
-		break;
 	}
-}
 
-static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	switch (rqst) {
-	case PM_SUSPEND:
-		disable_apic_nmi_watchdog();
-		break;
-	case PM_RESUME:
-		setup_apic_nmi_watchdog();
-		break;
-	}
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
 	return 0;
 }
 
-struct pm_dev * set_nmi_pm_callback(pm_callback callback)
+void release_nmi(struct nmi_handler *handler)
 {
-	apic_pm_unregister(nmi_pmdev);
-	return apic_pm_register(PM_SYS_DEV, 0, callback);
-}
+	spin_lock(&nmi_handler_lock);
+	list_del_rcu(&(handler->link));
+	init_completion(&(handler->complete));
+	call_rcu(&(handler->rcu), free_nmi_handler, handler);
+	spin_unlock(&nmi_handler_lock);
 
-void unset_nmi_pm_callback(struct pm_dev * dev)
-{
-	apic_pm_unregister(dev);
-	nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
-}
- 
-static void nmi_pm_init(void)
-{
-	if (!nmi_pmdev)
-		nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+	/* Wait for handler to finish being freed.  This can't be
+           interrupted, we must wait until it finished. */
+	wait_for_completion(&(handler->complete));
 }
 
-#define __pminit	/*empty*/
-
-#else	/* CONFIG_PM */
-
-static inline void nmi_pm_init(void) { }
-
-#define __pminit	__init
-
-#endif	/* CONFIG_PM */
-
-/*
- * Activate the NMI watchdog via the local APIC.
- * Original code written by Keith Owens.
- */
-
-static void __pminit clear_msr_range(unsigned int base, unsigned int n)
+void nmi_append_user_names(struct seq_file *p)
 {
-	unsigned int i;
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
 
-	for(i = 0; i < n; ++i)
-		wrmsr(base+i, 0, 0);
+	spin_lock(&nmi_handler_lock);
+	__list_for_each(curr, &nmi_handler_list) {
+		curr_h = list_entry(curr, struct nmi_handler, link);
+		if (curr_h->dev_name)
+			p += seq_printf(p, " %s", curr_h->dev_name);
+	}
+	spin_unlock(&nmi_handler_lock);
 }
 
-static void __pminit setup_k7_watchdog(void)
+static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
-	unsigned int evntsel;
-
-	nmi_perfctr_msr = MSR_K7_PERFCTR0;
-
-	clear_msr_range(MSR_K7_EVNTSEL0, 4);
-	clear_msr_range(MSR_K7_PERFCTR0, 4);
+	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
+	printk("You probably have a hardware problem with your RAM chips\n");
 
-	evntsel = K7_EVNTSEL_INT
-		| K7_EVNTSEL_OS
-		| K7_EVNTSEL_USR
-		| K7_NMI_EVENT;
-
-	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
-	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	evntsel |= K7_EVNTSEL_ENABLE;
-	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+	/* Clear and disable the memory parity error line. */
+	reason = (reason & 0xf) | 4;
+	outb(reason, 0x61);
 }
 
-static void __pminit setup_p6_watchdog(void)
+static void io_check_error(unsigned char reason, struct pt_regs * regs)
 {
-	unsigned int evntsel;
-
-	nmi_perfctr_msr = MSR_P6_PERFCTR0;
-
-	clear_msr_range(MSR_P6_EVNTSEL0, 2);
-	clear_msr_range(MSR_P6_PERFCTR0, 2);
+	unsigned long i;
 
-	evntsel = P6_EVNTSEL_INT
-		| P6_EVNTSEL_OS
-		| P6_EVNTSEL_USR
-		| P6_NMI_EVENT;
-
-	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	evntsel |= P6_EVNTSEL0_ENABLE;
-	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
-}
-
-static int __pminit setup_p4_watchdog(void)
-{
-	unsigned int misc_enable, dummy;
+	printk("NMI: IOCK error (debug interrupt?)\n");
+	show_registers(regs);
 
-	rdmsr(MSR_P4_MISC_ENABLE, misc_enable, dummy);
-	if (!(misc_enable & MSR_P4_MISC_ENABLE_PERF_AVAIL))
-		return 0;
-
-	nmi_perfctr_msr = MSR_P4_IQ_COUNTER0;
-
-	if (!(misc_enable & MSR_P4_MISC_ENABLE_PEBS_UNAVAIL))
-		clear_msr_range(0x3F1, 2);
-	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
-	   docs doesn't fully define it, so leave it alone for now. */
-	clear_msr_range(0x3A0, 31);
-	clear_msr_range(0x3C0, 6);
-	clear_msr_range(0x3C8, 6);
-	clear_msr_range(0x3E0, 2);
-	clear_msr_range(MSR_P4_CCCR0, 18);
-	clear_msr_range(MSR_P4_PERFCTR0, 18);
-
-	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
-	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
-	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
-	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
-	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
-	return 1;
+	/* Re-enable the IOCK line, wait for a few seconds */
+	reason = (reason & 0xf) | 8;
+	outb(reason, 0x61);
+	i = 2000;
+	while (--i) udelay(1000);
+	reason &= ~8;
+	outb(reason, 0x61);
 }
 
-void __pminit setup_apic_nmi_watchdog (void)
+static void unknown_nmi_error(struct pt_regs * regs, int cpu)
 {
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_AMD:
-		if (boot_cpu_data.x86 != 6)
-			return;
-		setup_k7_watchdog();
-		break;
-	case X86_VENDOR_INTEL:
-		switch (boot_cpu_data.x86) {
-		case 6:
-			setup_p6_watchdog();
-			break;
-		case 15:
-			if (!setup_p4_watchdog())
-				return;
-			break;
-		default:
-			return;
-		}
-		break;
-	default:
+#ifdef CONFIG_MCA
+	/* Might actually be able to figure out what the guilty party
+	 * is. */
+	if( MCA_bus ) {
+		mca_handle_nmi();
 		return;
 	}
-	nmi_pm_init();
+#endif
+	printk("Uhhuh. Received NMI for unknown reason on CPU %d.\n", cpu);
+	printk("Dazed and confused, but trying to continue\n");
+	printk("Do you have a strange power saving mode enabled?\n");
 }
 
-static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+/* Check "normal" sources of NMI. */
+static int nmi_std (void * dev_id, struct pt_regs * regs, int cpu, int handled)
+{
+	unsigned char reason;
 
-/*
- * the best way to detect whether a CPU has a 'hard lockup' problem
- * is to check it's local APIC timer IRQ counts. If they are not
- * changing then that CPU has some problem.
- *
- * as these watchdog NMI IRQs are generated on every CPU, we only
- * have to check the current processor.
- *
- * since NMIs dont listen to _any_ locks, we have to be extremely
- * careful not to rely on unsafe variables. The printk might lock
- * up though, so we have to break up any console locks first ...
- * [when there will be more tty-related locks, break them up
- *  here too!]
- */
+	reason = inb(0x61);
+	if (reason & 0xc0) {
+		if (reason & 0x80)
+			mem_parity_error(reason, regs);
+		if (reason & 0x40)
+			io_check_error(reason, regs);
+		return NOTIFY_OK;
+	}
 
-static unsigned int
-	last_irq_sums [NR_CPUS],
-	alert_counter [NR_CPUS];
+	return NOTIFY_DONE;
+}
 
-void touch_nmi_watchdog (void)
+static struct nmi_handler nmi_std_handler =
 {
-	int i;
+	.link     = LIST_HEAD_INIT(nmi_std_handler.link),
+	.dev_name = "nmi_std",
+	.dev_id   = NULL,
+	.handler  = nmi_std,
+	.priority = 128, /* mid-level priority. */
+};
 
-	/*
-	 * Just reset the alert counters, (other CPUs might be
-	 * spinning on locks we hold):
-	 */
-	for (i = 0; i < NR_CPUS; i++)
-		alert_counter[i] = 0;
-}
-
-void nmi_watchdog_tick (struct pt_regs * regs)
+asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
 {
+	struct list_head   *curr;
+	struct nmi_handler *curr_h;
+	int                val;
+	int                cpu;
+	int                handled = 0;
+ 
+
+ 	nmi_enter();
+ 
+ 	cpu = smp_processor_id();
+	++nmi_count(cpu);
 
 	/*
-	 * Since current_thread_info()-> is always on the stack, and we
-	 * always switch the stack NMI-atomically, it's safe to use
-	 * smp_processor_id().
+	 * Since NMIs are edge-triggered, we could possibly miss one
+	 * if we don't call them all, so we call them all.
 	 */
-	int sum, cpu = smp_processor_id();
 
-	sum = irq_stat[cpu].apic_timer_irqs;
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
 
-	if (last_irq_sums[cpu] == sum) {
+	if (!handled)
+		unknown_nmi_error(regs, cpu);
+	else {
 		/*
-		 * Ayiee, looks like this CPU is stuck ...
-		 * wait a few IRQs (5 seconds) before doing the oops ...
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
 		 */
-		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz) {
-			spin_lock(&nmi_print_lock);
-			/*
-			 * We are in trouble anyway, lets at least try
-			 * to get a message out.
-			 */
-			bust_spinlocks(1);
-			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, registers:\n", cpu, regs->eip);
-			show_registers(regs);
-			printk("console shuts up ...\n");
-			console_silent();
-			spin_unlock(&nmi_print_lock);
-			bust_spinlocks(0);
-			do_exit(SIGSEGV);
-		}
-	} else {
-		last_irq_sums[cpu] = sum;
-		alert_counter[cpu] = 0;
-	}
-	if (nmi_perfctr_msr) {
-		if (nmi_perfctr_msr == MSR_P4_IQ_COUNTER0) {
-			/*
-			 * P4 quirks:
-			 * - An overflown perfctr will assert its interrupt
-			 *   until the OVF flag in its CCCR is cleared.
-			 * - LVTPC is masked on interrupt and must be
-			 *   unmasked by the LVTPC handler.
-			 */
-			wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
-			apic_write(APIC_LVTPC, APIC_DM_NMI);
-		}
-		wrmsr(nmi_perfctr_msr, -(cpu_khz/nmi_hz*1000), -1);
+		outb(0x8f, 0x70);
+		inb(0x71);		/* dummy */
+		outb(0x0f, 0x70);
+		inb(0x71);		/* dummy */
 	}
+ 
+ 	nmi_exit();
+}
+
+void __init init_nmi(void)
+{
+	request_nmi(&nmi_std_handler);
 }
diff -urN linux.orig/arch/i386/kernel/nmi_watchdog.c linux/arch/i386/kernel/nmi_watchdog.c
--- linux.orig/arch/i386/kernel/nmi_watchdog.c	Thu Oct 24 19:56:54 2002
+++ linux/arch/i386/kernel/nmi_watchdog.c	Thu Oct 24 20:54:19 2002
@@ -0,0 +1,481 @@
+/*
+ *  linux/arch/i386/nmi_watchdog.c
+ *
+ *  NMI watchdog support on APIC systems
+ *
+ *  Started by Ingo Molnar <mingo@redhat.com>
+ *
+ *  Fixes:
+ *  Mikael Pettersson	: AMD K7 support for local APIC NMI watchdog.
+ *  Mikael Pettersson	: Power Management for local APIC NMI watchdog.
+ *  Mikael Pettersson	: Pentium 4 support for local APIC NMI watchdog.
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/bootmem.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/mc146818rtc.h>
+#include <linux/kernel_stat.h>
+#include <linux/notifier.h>
+
+#include <asm/smp.h>
+#include <asm/mtrr.h>
+#include <asm/mpspec.h>
+#include <asm/nmi.h>
+
+unsigned int nmi_watchdog = NMI_NONE;
+static unsigned int nmi_hz = HZ;
+
+/* This is for I/O APIC, until we can figure out how to tell if it's from the
+   I/O APIC.  If the NMI  was not handled before now, we handle it. */
+static int dummy_watchdog_reset(int handled)
+{
+	return !handled;
+}
+
+/* 
+ * Returns 1 if it is a source of the NMI, and resets the NMI to go
+ * off again.
+ */
+static int (*watchdog_reset)(int handled) = dummy_watchdog_reset;
+
+extern void show_registers(struct pt_regs *regs);
+
+#define K7_EVNTSEL_ENABLE	(1 << 22)
+#define K7_EVNTSEL_INT		(1 << 20)
+#define K7_EVNTSEL_OS		(1 << 17)
+#define K7_EVNTSEL_USR		(1 << 16)
+#define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
+#define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
+
+#define P6_EVNTSEL0_ENABLE	(1 << 22)
+#define P6_EVNTSEL_INT		(1 << 20)
+#define P6_EVNTSEL_OS		(1 << 17)
+#define P6_EVNTSEL_USR		(1 << 16)
+#define P6_EVENT_CPU_CLOCKS_NOT_HALTED	0x79
+#define P6_NMI_EVENT		P6_EVENT_CPU_CLOCKS_NOT_HALTED
+
+#define MSR_P4_MISC_ENABLE	0x1A0
+#define MSR_P4_MISC_ENABLE_PERF_AVAIL	(1<<7)
+#define MSR_P4_MISC_ENABLE_PEBS_UNAVAIL	(1<<12)
+#define MSR_P4_PERFCTR0		0x300
+#define MSR_P4_CCCR0		0x360
+#define P4_ESCR_EVENT_SELECT(N)	((N)<<25)
+#define P4_ESCR_OS		(1<<3)
+#define P4_ESCR_USR		(1<<2)
+#define P4_CCCR_OVF_PMI		(1<<26)
+#define P4_CCCR_THRESHOLD(N)	((N)<<20)
+#define P4_CCCR_COMPLEMENT	(1<<19)
+#define P4_CCCR_COMPARE		(1<<18)
+#define P4_CCCR_REQUIRED	(3<<16)
+#define P4_CCCR_ESCR_SELECT(N)	((N)<<13)
+#define P4_CCCR_ENABLE		(1<<12)
+/* Set up IQ_COUNTER0 to behave like a clock, by having IQ_CCCR0 filter
+   CRU_ESCR0 (with any non-null event selector) through a complemented
+   max threshold. [IA32-Vol3, Section 14.9.9] */
+#define MSR_P4_IQ_COUNTER0	0x30C
+#define MSR_P4_IQ_CCCR0		0x36C
+#define MSR_P4_CRU_ESCR0	0x3B8
+#define P4_NMI_CRU_ESCR0	(P4_ESCR_EVENT_SELECT(0x3F)|P4_ESCR_OS|P4_ESCR_USR)
+#define P4_NMI_IQ_CCCR0	\
+	(P4_CCCR_OVF_PMI|P4_CCCR_THRESHOLD(15)|P4_CCCR_COMPLEMENT|	\
+	 P4_CCCR_COMPARE|P4_CCCR_REQUIRED|P4_CCCR_ESCR_SELECT(4)|P4_CCCR_ENABLE)
+
+int __init check_nmi_watchdog (void)
+{
+	unsigned int prev_nmi_count[NR_CPUS];
+	int cpu;
+
+	printk(KERN_INFO "testing NMI watchdog ... ");
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
+		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
+	local_irq_enable();
+	mdelay((10*1000)/nmi_hz); // wait 10 ticks
+
+	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
+           as they come up. */
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
+		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
+			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
+			return -1;
+		}
+	}
+	printk("OK.\n");
+
+	/* now that we know it works we can reduce NMI frequency to
+	   something more reasonable; makes a difference in some configs */
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		nmi_hz = 1;
+
+	return 0;
+}
+
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs, int cpu,
+	int handled);
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
+static int __init setup_nmi_watchdog(char *str)
+{
+	int nmi;
+
+	get_option(&str, &nmi);
+
+	if (nmi >= NMI_INVALID)
+		return 0;
+
+	if (nmi == NMI_NONE)
+		nmi_watchdog = nmi;
+	/*
+	 * If any other x86 CPU has a local APIC, then
+	 * please test the NMI stuff there and send me the
+	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
+	 */
+	if ((nmi == NMI_LOCAL_APIC) &&
+			(boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
+			(boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15))
+		nmi_watchdog = nmi;
+	if ((nmi == NMI_LOCAL_APIC) &&
+			(boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
+			(boot_cpu_data.x86 == 6))
+		nmi_watchdog = nmi;
+	/*
+	 * We can enable the IO-APIC watchdog
+	 * unconditionally.
+	 */
+	if (nmi == NMI_IO_APIC)
+		nmi_watchdog = nmi;
+
+	if (nmi_watchdog != NMI_NONE) {
+		if (request_nmi(&nmi_watchdog_handler) != 0) {
+			/* Couldn't add a watchdog handler, give up. */
+			printk(KERN_WARNING
+			       "nmi_watchdog: Couldn't request nmi\n");
+			nmi_watchdog = NMI_NONE;
+			return 0;
+		}
+	}
+
+	return 1;
+}
+
+__setup("nmi_watchdog=", setup_nmi_watchdog);
+
+#ifdef CONFIG_PM
+
+#include <linux/pm.h>
+
+struct pm_dev *nmi_pmdev;
+
+static void disable_apic_nmi_watchdog(void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		wrmsr(MSR_K7_EVNTSEL0, 0, 0);
+		break;
+	case X86_VENDOR_INTEL:
+		switch (boot_cpu_data.x86) {
+		case 6:
+			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
+			break;
+		case 15:
+			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
+			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
+			break;
+		}
+		break;
+	}
+}
+
+static int nmi_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	switch (rqst) {
+	case PM_SUSPEND:
+		disable_apic_nmi_watchdog();
+		break;
+	case PM_RESUME:
+		setup_apic_nmi_watchdog();
+		break;
+	}
+	return 0;
+}
+
+struct pm_dev * set_nmi_pm_callback(pm_callback callback)
+{
+	apic_pm_unregister(nmi_pmdev);
+	return apic_pm_register(PM_SYS_DEV, 0, callback);
+}
+
+void unset_nmi_pm_callback(struct pm_dev * dev)
+{
+	apic_pm_unregister(dev);
+	nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+}
+ 
+static void nmi_pm_init(void)
+{
+	if (!nmi_pmdev)
+		nmi_pmdev = apic_pm_register(PM_SYS_DEV, 0, nmi_pm_callback);
+}
+
+#define __pminit	/*empty*/
+
+#else	/* CONFIG_PM */
+
+static inline void nmi_pm_init(void) { }
+
+#define __pminit	__init
+
+#endif	/* CONFIG_PM */
+
+/*
+ * Activate the NMI watchdog via the local APIC.
+ * Original code written by Keith Owens.
+ */
+
+static void __pminit clear_msr_range(unsigned int base, unsigned int n)
+{
+	unsigned int i;
+
+	for(i = 0; i < n; ++i)
+		wrmsr(base+i, 0, 0);
+}
+
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
+static void __pminit setup_k7_watchdog(void)
+{
+	unsigned int evntsel;
+
+	watchdog_reset = k7_watchdog_reset;
+
+	clear_msr_range(MSR_K7_EVNTSEL0, 4);
+	clear_msr_range(MSR_K7_PERFCTR0, 4);
+
+	evntsel = K7_EVNTSEL_INT
+		| K7_EVNTSEL_OS
+		| K7_EVNTSEL_USR
+		| K7_NMI_EVENT;
+
+	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+	Dprintk("setting K7_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_K7_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= K7_EVNTSEL_ENABLE;
+	wrmsr(MSR_K7_EVNTSEL0, evntsel, 0);
+}
+
+static int p6_watchdog_reset(int handled)
+{
+	unsigned int low, high;
+	int          source;
+
+	rdmsr(MSR_P6_PERFCTR0, low, high);
+	source = (low & (1 << 31)) == 0;
+	if (source)
+		wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), -1);
+	return source;
+}
+
+static void __pminit setup_p6_watchdog(void)
+{
+	unsigned int evntsel;
+
+	watchdog_reset = p6_watchdog_reset;
+
+	clear_msr_range(MSR_P6_EVNTSEL0, 2);
+	clear_msr_range(MSR_P6_PERFCTR0, 2);
+
+	evntsel = P6_EVNTSEL_INT
+		| P6_EVNTSEL_OS
+		| P6_EVNTSEL_USR
+		| P6_NMI_EVENT;
+
+	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+	Dprintk("setting P6_PERFCTR0 to %08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_P6_PERFCTR0, -(cpu_khz/nmi_hz*1000), 0);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	evntsel |= P6_EVNTSEL0_ENABLE;
+	wrmsr(MSR_P6_EVNTSEL0, evntsel, 0);
+}
+
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
+		wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+
+		wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	}
+	return source;
+}
+
+static int __pminit setup_p4_watchdog(void)
+{
+	unsigned int misc_enable, dummy;
+
+	rdmsr(MSR_P4_MISC_ENABLE, misc_enable, dummy);
+	if (!(misc_enable & MSR_P4_MISC_ENABLE_PERF_AVAIL))
+		return 0;
+
+	watchdog_reset = p4_watchdog_reset;
+
+	if (!(misc_enable & MSR_P4_MISC_ENABLE_PEBS_UNAVAIL))
+		clear_msr_range(0x3F1, 2);
+	/* MSR 0x3F0 seems to have a default value of 0xFC00, but current
+	   docs doesn't fully define it, so leave it alone for now. */
+	clear_msr_range(0x3A0, 31);
+	clear_msr_range(0x3C0, 6);
+	clear_msr_range(0x3C8, 6);
+	clear_msr_range(0x3E0, 2);
+	clear_msr_range(MSR_P4_CCCR0, 18);
+	clear_msr_range(MSR_P4_PERFCTR0, 18);
+
+	wrmsr(MSR_P4_CRU_ESCR0, P4_NMI_CRU_ESCR0, 0);
+	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0 & ~P4_CCCR_ENABLE, 0);
+	Dprintk("setting P4_IQ_COUNTER0 to 0x%08lx\n", -(cpu_khz/nmi_hz*1000));
+	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	wrmsr(MSR_P4_IQ_CCCR0, P4_NMI_IQ_CCCR0, 0);
+	return 1;
+}
+
+void __pminit setup_apic_nmi_watchdog (void)
+{
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (boot_cpu_data.x86 != 6)
+			return;
+		setup_k7_watchdog();
+		break;
+	case X86_VENDOR_INTEL:
+		switch (boot_cpu_data.x86) {
+		case 6:
+			setup_p6_watchdog();
+			break;
+		case 15:
+			if (!setup_p4_watchdog())
+				return;
+			break;
+		default:
+			return;
+		}
+		break;
+	default:
+		return;
+	}
+	nmi_pm_init();
+}
+
+static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * the best way to detect whether a CPU has a 'hard lockup' problem
+ * is to check it's local APIC timer IRQ counts. If they are not
+ * changing then that CPU has some problem.
+ *
+ * as these watchdog NMI IRQs are generated on every CPU, we only
+ * have to check the current processor.
+ *
+ * since NMIs dont listen to _any_ locks, we have to be extremely
+ * careful not to rely on unsafe variables. The printk might lock
+ * up though, so we have to break up any console locks first ...
+ * [when there will be more tty-related locks, break them up
+ *  here too!]
+ */
+
+static unsigned int
+	last_irq_sums [NR_CPUS],
+	alert_counter [NR_CPUS];
+
+void touch_nmi_watchdog (void)
+{
+	int i;
+
+	/*
+	 * Just reset the alert counters, (other CPUs might be
+	 * spinning on locks we hold):
+	 */
+	for (i = 0; i < NR_CPUS; i++)
+		alert_counter[i] = 0;
+}
+
+static int nmi_watchdog_tick (void * dev_id, struct pt_regs * regs, int cpu,
+	int handled)
+{
+	/*
+	 * Since current_thread_info()-> is always on the stack, and we
+	 * always switch the stack NMI-atomically, it's safe to use
+	 * smp_processor_id().
+	 */
+	int sum;
+
+	if (! watchdog_reset(handled))
+		return NOTIFY_DONE; /* We are not an NMI source. */
+
+	sum = irq_stat[cpu].apic_timer_irqs;
+
+	if (last_irq_sums[cpu] == sum) {
+		/*
+		 * Ayiee, looks like this CPU is stuck ...
+		 * wait a few IRQs (5 seconds) before doing the oops ...
+		 */
+		alert_counter[cpu]++;
+		if (alert_counter[cpu] == 5*nmi_hz) {
+			spin_lock(&nmi_print_lock);
+			/*
+			 * We are in trouble anyway, lets at least try
+			 * to get a message out.
+			 */
+			bust_spinlocks(1);
+			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, registers:\n", cpu, regs->eip);
+			show_registers(regs);
+			printk("console shuts up ...\n");
+			console_silent();
+			spin_unlock(&nmi_print_lock);
+			bust_spinlocks(0);
+			do_exit(SIGSEGV);
+		}
+	} else {
+		last_irq_sums[cpu] = sum;
+		alert_counter[cpu] = 0;
+	}
+
+	return NOTIFY_OK;
+}
diff -urN linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux.orig/arch/i386/kernel/traps.c	Thu Nov 14 21:08:35 2002
+++ linux/arch/i386/kernel/traps.c	Thu Nov 14 21:12:47 2002
@@ -40,7 +40,6 @@
 #include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/i387.h>
-#include <asm/nmi.h>
 
 #include <asm/smp.h>
 #include <asm/pgalloc.h>
@@ -52,6 +51,7 @@
 asmlinkage int system_call(void);
 asmlinkage void lcall7(void);
 asmlinkage void lcall27(void);
+void init_nmi(void);
 
 struct desc_struct default_ldt[] = { { 0, 0 }, { 0, 0 }, { 0, 0 },
 		{ 0, 0 }, { 0, 0 } };
@@ -443,112 +443,6 @@
 	}
 }
 
-static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
-{
-	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
-	printk("You probably have a hardware problem with your RAM chips\n");
-
-	/* Clear and disable the memory parity error line. */
-	reason = (reason & 0xf) | 4;
-	outb(reason, 0x61);
-}
-
-static void io_check_error(unsigned char reason, struct pt_regs * regs)
-{
-	unsigned long i;
-
-	printk("NMI: IOCK error (debug interrupt?)\n");
-	show_registers(regs);
-
-	/* Re-enable the IOCK line, wait for a few seconds */
-	reason = (reason & 0xf) | 8;
-	outb(reason, 0x61);
-	i = 2000;
-	while (--i) udelay(1000);
-	reason &= ~8;
-	outb(reason, 0x61);
-}
-
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
-static void default_do_nmi(struct pt_regs * regs)
-{
-	unsigned char reason = inb(0x61);
- 
-	if (!(reason & 0xc0)) {
-#if CONFIG_X86_LOCAL_APIC
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
-	if (reason & 0x80)
-		mem_parity_error(reason, regs);
-	if (reason & 0x40)
-		io_check_error(reason, regs);
-	/*
-	 * Reassert NMI in case it became active meanwhile
-	 * as it's edge-triggered.
-	 */
-	outb(0x8f, 0x70);
-	inb(0x71);		/* dummy */
-	outb(0x0f, 0x70);
-	inb(0x71);		/* dummy */
-}
-
-static int dummy_nmi_callback(struct pt_regs * regs, int cpu)
-{
-	return 0;
-}
- 
-static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
-asmlinkage void do_nmi(struct pt_regs * regs, long error_code)
-{
-	int cpu;
-
-	nmi_enter();
-
-	cpu = smp_processor_id();
-	++nmi_count(cpu);
-
-	if (!nmi_callback(regs, cpu))
-		default_do_nmi(regs);
-
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
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -931,4 +825,6 @@
 	cpu_init();
 
 	trap_init_hook();
+
+	init_nmi();
 }
diff -urN linux.orig/arch/i386/oprofile/nmi_int.c linux/arch/i386/oprofile/nmi_int.c
--- linux.orig/arch/i386/oprofile/nmi_int.c	Thu Nov 14 21:05:52 2002
+++ linux/arch/i386/oprofile/nmi_int.c	Thu Nov 14 21:07:25 2002
@@ -54,12 +54,24 @@
  
  
 // FIXME: kernel_only
-static int nmi_callback(struct pt_regs * regs, int cpu)
+static int nmi_callback(void *dev_id, struct pt_regs *regs, int cpu, int handled)
 {
-	return (model->check_ctrs(cpu, &cpu_msrs[cpu], regs));
+	if (model->check_ctrs(cpu, &cpu_msrs[cpu], regs))
+		return NOTIFY_OK;
+
+	return NOTIFY_DONE;
 }
  
- 
+static struct nmi_handler nmi_handler =
+{
+	.link     = LIST_HEAD_INIT(nmi_handler.link),
+	.dev_name = "oprofile",
+	.dev_id   = NULL,
+	.handler  = nmi_callback,
+	.priority = 1023, /* Very high priority. */
+};
+
+
 static void nmi_save_registers(struct op_msrs * msrs)
 {
 	unsigned int const nr_ctrs = model->num_counters;
@@ -96,8 +108,12 @@
 }
  
 
+static void nmi_cpu_shutdown(void * dummy);
+
 static int nmi_setup(void)
 {
+	int rv;
+
 	/* We walk a thin line between law and rape here.
 	 * We need to be careful to install our NMI handler
 	 * without actually triggering any NMIs as this will
@@ -105,7 +121,13 @@
 	 */
 	smp_call_function(nmi_cpu_setup, NULL, 0, 1);
 	nmi_cpu_setup(0);
-	set_nmi_callback(nmi_callback);
+	rv = request_nmi(&nmi_handler);
+	if (rv) {
+		smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
+		nmi_cpu_shutdown(0);
+		return rv;
+	}
+
 	oprofile_pmdev = set_nmi_pm_callback(oprofile_pm_callback);
 	return 0;
 }
@@ -155,7 +177,7 @@
 static void nmi_shutdown(void)
 {
 	unset_nmi_pm_callback(oprofile_pmdev);
-	unset_nmi_callback();
+	release_nmi(&nmi_handler);
 	smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
 	nmi_cpu_shutdown(0);
 }
diff -urN linux.orig/kernel/sched.c linux/kernel/sched.c
--- linux.orig/kernel/sched.c	Thu Nov 14 21:08:50 2002
+++ linux/kernel/sched.c	Thu Nov 14 21:13:12 2002
@@ -17,7 +17,7 @@
  */
 
 #include <linux/mm.h>
-#include <linux/nmi.h>
+#include <linux/nmi_watchdog.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 #include <linux/highmem.h>
diff -urN linux.orig/include/linux/nmi_watchdog.h linux/include/linux/nmi_watchdog.h
--- linux.orig/include/linux/nmi_watchdog.h	Thu Oct 24 19:56:54 2002
+++ linux/include/linux/nmi_watchdog.h	Thu Oct 24 12:50:30 2002
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
diff -urN linux.orig/include/linux/nmi.h linux/include/linux/nmi.h
--- linux.orig/include/linux/nmi.h	Thu Jun 20 17:53:40 2002
+++ linux/include/linux/nmi.h	Thu Oct 24 16:28:53 2002
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
diff -urN linux.orig/include/asm-i386/apic.h linux/include/asm-i386/apic.h
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
diff -urN linux.orig/include/asm-i386/nmi.h linux/include/asm-i386/nmi.h
--- linux.orig/include/asm-i386/nmi.h	Mon Oct 21 13:25:52 2002
+++ linux/include/asm-i386/nmi.h	Thu Oct 24 20:50:22 2002
@@ -5,26 +5,11 @@
 #define ASM_NMI_H
 
 #include <linux/pm.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
  
 struct pt_regs;
  
-typedef int (*nmi_callback_t)(struct pt_regs * regs, int cpu);
- 
-/** 
- * set_nmi_callback
- *
- * Set a handler for an NMI. Only one handler may be
- * set. Return 1 if the NMI was handled.
- */
-void set_nmi_callback(nmi_callback_t callback);
- 
-/** 
- * unset_nmi_callback
- *
- * Remove the handler previously set.
- */
-void unset_nmi_callback(void);
- 
 #ifdef CONFIG_PM
  
 /** Replace the PM callback routine for NMI. */
@@ -45,5 +30,34 @@
 }
 
 #endif /* CONFIG_PM */
+
+
+/**
+ * Register a handler to get called when an NMI occurs.  If the
+ * handler actually handles the NMI, it should return NOTIFY_OK.  If
+ * it did not handle the NMI, it should return NOTIFY_DONE.  It may "or"
+ * on NOTIFY_STOP_MASK to the return value if it does not want other
+ * handlers after it to be notified.
+ */
+#define HAVE_NMI_HANDLER	1
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
+int request_nmi(struct nmi_handler *handler);
+
+/* Release will block until the handler is completely free. */
+void release_nmi(struct nmi_handler *handler);
  
 #endif /* ASM_NMI_H */

--------------000809020304030305060105--

