Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWASHXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWASHXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWASHXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:23:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161076AbWASHXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:23:17 -0500
Date: Wed, 18 Jan 2006 23:22:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] halt_on_oops command line option
Message-Id: <20060118232255.3814001b.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How's this look?



Attempt to fix the problem wherein people's oops reports scroll off the screen
due to repeated oopsing or to oopses on other CPUs.

If this happens the user can reboot with the `halt_on_oops' option.  It will
allow the first oopsing CPU to print an oops record just a single time.  Second
oopsing attempts, or oopses on other CPUs will cause those CPUs to enter a
tight loop.

The patch implements the infrastructure generically in the expectation that
architectures other than x86 will find it useful.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/kernel-parameters.txt |    5 ++
 arch/i386/kernel/traps.c            |    5 +-
 arch/i386/mm/fault.c                |   36 +++++++++------
 include/linux/kernel.h              |    3 +
 kernel/panic.c                      |   60 +++++++++++++++++++++++++-
 5 files changed, 93 insertions(+), 16 deletions(-)

diff -puN kernel/panic.c~halt_on_oops-command-line-option kernel/panic.c
--- devel/kernel/panic.c~halt_on_oops-command-line-option	2006-01-18 22:37:43.000000000 -0800
+++ devel-akpm/kernel/panic.c	2006-01-18 23:20:32.000000000 -0800
@@ -19,12 +19,15 @@
 #include <linux/interrupt.h>
 #include <linux/nmi.h>
 #include <linux/kexec.h>
+#include <asm/atomic.h>
 
-int panic_timeout;
 int panic_on_oops;
 int panic_on_unrecovered_nmi;
 int tainted;
+static int halt_on_oops;
+static atomic_t halt_on_oops_counter = ATOMIC_INIT(0);
 
+int panic_timeout;
 EXPORT_SYMBOL(panic_timeout);
 
 struct notifier_block *panic_notifier_list;
@@ -174,3 +177,58 @@ void add_taint(unsigned flag)
 	tainted |= flag;
 }
 EXPORT_SYMBOL(add_taint);
+
+static int __init halt_on_oops_setup(char *str)
+{
+	halt_on_oops = 1;
+	return 1;
+}
+__setup("halt_on_oops", halt_on_oops_setup);
+
+/*
+ * It just happens that oops_enter() and oops_exit() are identically
+ * implemented...
+ */
+static void do_oops_enter_exit(void)
+{
+	if (halt_on_oops && atomic_add_return(1, &halt_on_oops_counter) == 1) {
+		/*
+		 * Kill this CPU
+		 */
+		local_irq_disable();
+		for ( ; ; )
+			touch_nmi_watchdog();
+	}
+}
+
+/*
+ * Return true if the calling CPU is allowed to print oops-related info.  This
+ * is a bit racy..
+ */
+int oops_may_print(void)
+{
+	return atomic_read(&halt_on_oops_counter) == 0;
+}
+
+/*
+ * Called when the architecture enters its oops handler, before it prints
+ * anything.  If this is the first CPU to oops, and it's oopsing the first time
+ * then let it proceed.
+ *
+ * This is all enabled by the halt_on_oops kernel boot option.  We do all this
+ * to ensure that oopses don't scroll off the screen.  It has the side-effect
+ * of preventing later-oopsing CPUs from mucking up the display, too.
+ */
+void oops_enter(void)
+{
+	do_oops_enter_exit();
+}
+
+/*
+ * Called when the architecture exits its oops handler, after printing
+ * everything.
+ */
+void oops_exit(void)
+{
+	do_oops_enter_exit();
+}
diff -puN arch/i386/kernel/traps.c~halt_on_oops-command-line-option arch/i386/kernel/traps.c
--- devel/arch/i386/kernel/traps.c~halt_on_oops-command-line-option	2006-01-18 22:37:43.000000000 -0800
+++ devel-akpm/arch/i386/kernel/traps.c	2006-01-18 23:03:51.000000000 -0800
@@ -354,6 +354,8 @@ void die(const char * str, struct pt_reg
 	static int die_counter;
 	unsigned long flags;
 
+	oops_enter();
+
 	if (die.lock_owner != raw_smp_processor_id()) {
 		console_verbose();
 		spin_lock_irqsave(&die.lock, flags);
@@ -386,7 +388,7 @@ void die(const char * str, struct pt_reg
 #endif
 		if (nl)
 			printk("\n");
-	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
+		notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 		show_registers(regs);
   	} else
 		printk(KERN_EMERG "Recursive die() failure, output suppressed\n");
@@ -406,6 +408,7 @@ void die(const char * str, struct pt_reg
 		ssleep(5);
 		panic("Fatal exception");
 	}
+	oops_exit();
 	do_exit(SIGSEGV);
 }
 
diff -puN include/linux/kernel.h~halt_on_oops-command-line-option include/linux/kernel.h
--- devel/include/linux/kernel.h~halt_on_oops-command-line-option	2006-01-18 22:37:43.000000000 -0800
+++ devel-akpm/include/linux/kernel.h	2006-01-18 23:08:39.000000000 -0800
@@ -91,6 +91,9 @@ extern struct notifier_block *panic_noti
 extern long (*panic_blink)(long time);
 NORET_TYPE void panic(const char * fmt, ...)
 	__attribute__ ((NORET_AND format (printf, 1, 2)));
+extern void oops_enter(void);
+extern void oops_exit(void);
+extern int oops_may_print(void);
 fastcall NORET_TYPE void do_exit(long error_code)
 	ATTRIB_NORET;
 NORET_TYPE void complete_and_exit(struct completion *, long)
diff -puN Documentation/kernel-parameters.txt~halt_on_oops-command-line-option Documentation/kernel-parameters.txt
--- devel/Documentation/kernel-parameters.txt~halt_on_oops-command-line-option	2006-01-18 22:37:43.000000000 -0800
+++ devel-akpm/Documentation/kernel-parameters.txt	2006-01-18 22:37:43.000000000 -0800
@@ -544,6 +544,11 @@ running once the system is up.
 
 	gvp11=		[HW,SCSI]
 
+	halt_on_oops
+			Halt all CPUs after the first oops has been printed.
+			This is to be used if your oopses keep scrolling off
+			the screen.
+
 	hashdist=	[KNL,NUMA] Large hashes allocated during boot
 			are distributed across NUMA nodes.  Defaults on
 			for IA-64, off otherwise.
diff -puN arch/i386/mm/fault.c~halt_on_oops-command-line-option arch/i386/mm/fault.c
--- devel/arch/i386/mm/fault.c~halt_on_oops-command-line-option	2006-01-18 23:08:48.000000000 -0800
+++ devel-akpm/arch/i386/mm/fault.c	2006-01-18 23:10:47.000000000 -0800
@@ -440,24 +440,32 @@ no_context:
 
 	bust_spinlocks(1);
 
+	if (oops_may_print()) {
 #ifdef CONFIG_X86_PAE
-	if (error_code & 16) {
-		pte_t *pte = lookup_address(address);
+		if (error_code & 16) {
+			pte_t *pte = lookup_address(address);
 
-		if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
-			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
-	}
+			if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
+				printk(KERN_CRIT "kernel tried to execute "
+						"NX-protected page - exploit "
+						"attempt? (uid: %d)\n",
+					current->uid);
+		}
 #endif
-	if (address < PAGE_SIZE)
-		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
-	else
-		printk(KERN_ALERT "Unable to handle kernel paging request");
-	printk(" at virtual address %08lx\n",address);
-	printk(KERN_ALERT " printing eip:\n");
-	printk("%08lx\n", regs->eip);
+		if (address < PAGE_SIZE)
+			printk(KERN_ALERT "Unable to handle kernel NULL "
+					"pointer dereference");
+		else
+			printk(KERN_ALERT "Unable to handle kernel paging "
+					"request");
+		printk(" at virtual address %08lx\n",address);
+		printk(KERN_ALERT " printing eip:\n");
+		printk("%08lx\n", regs->eip);
+	}
 	page = read_cr3();
 	page = ((unsigned long *) __va(page))[address >> 22];
-	printk(KERN_ALERT "*pde = %08lx\n", page);
+	if (oops_may_print())
+		printk(KERN_ALERT "*pde = %08lx\n", page);
 	/*
 	 * We must not directly access the pte in the highpte
 	 * case, the page table might be allocated in highmem.
@@ -465,7 +473,7 @@ no_context:
 	 * it's allocated already.
 	 */
 #ifndef CONFIG_HIGHPTE
-	if (page & 1) {
+	if ((page & 1) && oops_may_print()) {
 		page &= PAGE_MASK;
 		address &= 0x003ff000;
 		page = ((unsigned long *) __va(page))[address >> PAGE_SHIFT];
_

