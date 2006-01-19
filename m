Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWASXQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWASXQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161381AbWASXQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:16:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4765 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161372AbWASXQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:16:32 -0500
Date: Thu, 19 Jan 2006 15:18:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] halt_on_oops command line option
Message-Id: <20060119151805.1c4dc2af.akpm@osdl.org>
In-Reply-To: <20060119192654.GL21663@redhat.com>
References: <20060118232255.3814001b.akpm@osdl.org>
	<20060119073951.GC21663@redhat.com>
	<20060118235958.6b466a86.akpm@osdl.org>
	<20060119192654.GL21663@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> > Well I'm assuming people would only enable the option if they are
>  > experiencing persistently-scrolling-off oopses.
> 
> For this to be useful for me, I'd want it always on.  The majority of
> oopses our users hit are one offs, and they don't usually know when
> they're going to get an oops ;-)

aww, that was hard.

Untested, hard to test, not quite perfect:


From: Andrew Morton <akpm@osdl.org>

Attempt to fix the problem wherein people's oops reports scroll off the screen
due to repeated oopsing or to oopses on other CPUs.

If this happens the user can reboot with the `pause_on_oops=<seconds>' option.
It will allow the first oopsing CPU to print an oops record just a single
time.  Second oopsing attempts, or oopses on other CPUs will cause those CPUs
to enter a tight loop until the specified number of seconds have elapsed.

The patch implements the infrastructure generically in the expectation that
architectures other than x86 will find it useful.

Cc: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/kernel-parameters.txt |    5 +
 arch/i386/kernel/traps.c            |    5 +
 arch/i386/mm/fault.c                |   37 +++++----
 include/linux/kernel.h              |    3 
 kernel/panic.c                      |   98 +++++++++++++++++++++++++-
 5 files changed, 131 insertions(+), 17 deletions(-)

diff -puN kernel/panic.c~pause_on_oops-command-line-option kernel/panic.c
--- 25/kernel/panic.c~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
+++ 25-akpm/kernel/panic.c	Thu Jan 19 15:17:34 2006
@@ -19,12 +19,16 @@
 #include <linux/interrupt.h>
 #include <linux/nmi.h>
 #include <linux/kexec.h>
+#include <asm/atomic.h>
 
-int panic_timeout;
 int panic_on_oops;
 int panic_on_unrecovered_nmi;
 int tainted;
+static int pause_on_oops;
+static int pause_on_oops_flag;
+static DEFINE_SPINLOCK(pause_on_oops_lock);
 
+int panic_timeout;
 EXPORT_SYMBOL(panic_timeout);
 
 struct notifier_block *panic_notifier_list;
@@ -174,3 +178,95 @@ void add_taint(unsigned flag)
 	tainted |= flag;
 }
 EXPORT_SYMBOL(add_taint);
+
+static int __init pause_on_oops_setup(char *str)
+{
+	pause_on_oops = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("pause_on_oops=", pause_on_oops_setup);
+
+static void spin_msec(int msecs)
+{
+	int i;
+
+	for (i = 0; i < msecs; i++) {
+		touch_nmi_watchdog();
+		mdelay(1);
+	}
+}
+
+/*
+ * It just happens that oops_enter() and oops_exit() are identically
+ * implemented...
+ */
+static void do_oops_enter_exit(void)
+{
+	unsigned long flags;
+	static int spin_counter;
+
+	if (!pause_on_oops)
+		return;
+
+	spin_lock_irqsave(&pause_on_oops_lock, flags);
+	if (pause_on_oops_flag == 0) {
+		/* This CPU may now print the oops message */
+		pause_on_oops_flag = 1;
+	} else {
+		/* We need to stall this CPU */
+		if (!spin_counter) {
+			/* This CPU gets to do the counting */
+			spin_counter = pause_on_oops;
+			do {
+				spin_unlock(&pause_on_oops_lock);
+				spin_msec(MSEC_PER_SEC);
+				spin_lock(&pause_on_oops_lock);
+			} while (--spin_counter);
+			pause_on_oops_flag = 0;
+		} else {
+			/* This CPU waits for a different one */
+			while (spin_counter) {
+				spin_unlock(&pause_on_oops_lock);
+				spin_msec(1);
+				spin_lock(&pause_on_oops_lock);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&pause_on_oops_lock, flags);
+}
+
+/*
+ * Return true if the calling CPU is allowed to print oops-related info.  This
+ * is a bit racy..
+ */
+int oops_may_print(void)
+{
+	return pause_on_oops_flag == 0;
+}
+
+/*
+ * Called when the architecture enters its oops handler, before it prints
+ * anything.  If this is the first CPU to oops, and it's oopsing the first time
+ * then let it proceed.
+ *
+ * This is all enabled by the pause_on_oops kernel boot option.  We do all this
+ * to ensure that oopses don't scroll off the screen.  It has the side-effect
+ * of preventing later-oopsing CPUs from mucking up the display, too.
+ *
+ * It turns out that the CPU which is allowed to print ends up pausing for the
+ * right duration, whereas all the other CPUs pause for twice as long: once in
+ * oops_enter(), once in oops_exit().
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
diff -puN arch/i386/kernel/traps.c~pause_on_oops-command-line-option arch/i386/kernel/traps.c
--- 25/arch/i386/kernel/traps.c~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
+++ 25-akpm/arch/i386/kernel/traps.c	Thu Jan 19 14:42:25 2006
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
 
diff -puN include/linux/kernel.h~pause_on_oops-command-line-option include/linux/kernel.h
--- 25/include/linux/kernel.h~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
+++ 25-akpm/include/linux/kernel.h	Thu Jan 19 14:42:25 2006
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
diff -puN Documentation/kernel-parameters.txt~pause_on_oops-command-line-option Documentation/kernel-parameters.txt
--- 25/Documentation/kernel-parameters.txt~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
+++ 25-akpm/Documentation/kernel-parameters.txt	Thu Jan 19 14:51:35 2006
@@ -544,6 +544,11 @@ running once the system is up.
 
 	gvp11=		[HW,SCSI]
 
+	pause_on_oops=
+			Halt all CPUs after the first oops has been printed for
+			the specified number of seconds.  This is to be used if
+			your oopses keep scrolling off the screen.
+
 	hashdist=	[KNL,NUMA] Large hashes allocated during boot
 			are distributed across NUMA nodes.  Defaults on
 			for IA-64, off otherwise.
diff -puN arch/i386/mm/fault.c~pause_on_oops-command-line-option arch/i386/mm/fault.c
--- 25/arch/i386/mm/fault.c~pause_on_oops-command-line-option	Thu Jan 19 14:42:25 2006
+++ 25-akpm/arch/i386/mm/fault.c	Thu Jan 19 14:42:25 2006
@@ -440,24 +440,31 @@ no_context:
 
 	bust_spinlocks(1);
 
-#ifdef CONFIG_X86_PAE
-	if (error_code & 16) {
-		pte_t *pte = lookup_address(address);
+	if (oops_may_print()) {
+	#ifdef CONFIG_X86_PAE
+		if (error_code & 16) {
+			pte_t *pte = lookup_address(address);
 
-		if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
-			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
+			if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
+				printk(KERN_CRIT "kernel tried to execute "
+					"NX-protected page - exploit attempt? "
+					"(uid: %d)\n", current->uid);
+		}
+	#endif
+		if (address < PAGE_SIZE)
+			printk(KERN_ALERT "BUG: unable to handle kernel NULL "
+					"pointer dereference");
+		else
+			printk(KERN_ALERT "BUG: unable to handle kernel paging"
+					" request");
+		printk(" at virtual address %08lx\n",address);
+		printk(KERN_ALERT " printing eip:\n");
+		printk("%08lx\n", regs->eip);
 	}
-#endif
-	if (address < PAGE_SIZE)
-		printk(KERN_ALERT "BUG: unable to handle kernel NULL pointer dereference");
-	else
-		printk(KERN_ALERT "BUG: unable to handle kernel paging request");
-	printk(" at virtual address %08lx\n",address);
-	printk(KERN_ALERT " printing eip:\n");
-	printk("%08lx\n", regs->eip);
 	page = read_cr3();
 	page = ((unsigned long *) __va(page))[address >> 22];
-	printk(KERN_ALERT "*pde = %08lx\n", page);
+	if (oops_may_print())
+		printk(KERN_ALERT "*pde = %08lx\n", page);
 	/*
 	 * We must not directly access the pte in the highpte
 	 * case, the page table might be allocated in highmem.
@@ -465,7 +472,7 @@ no_context:
 	 * it's allocated already.
 	 */
 #ifndef CONFIG_HIGHPTE
-	if (page & 1) {
+	if ((page & 1) && oops_may_print()) {
 		page &= PAGE_MASK;
 		address &= 0x003ff000;
 		page = ((unsigned long *) __va(page))[address >> PAGE_SHIFT];
_



