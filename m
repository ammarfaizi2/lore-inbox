Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSHNMLg>; Wed, 14 Aug 2002 08:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSHNMLg>; Wed, 14 Aug 2002 08:11:36 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39946 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317054AbSHNMLe>;
	Wed, 14 Aug 2002 08:11:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.20-pre2 RTFM Documentation/oops-tracing.txt
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Aug 2002 22:15:14 +1000
Message-ID: <6089.1029327314@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the hope that this will reduce the number of "what does this oops
mean?" and "what do I need to report?" questions on l-k.  Hits all
architectures, only tested on i386 but "obviously correct" (yeah,
right!).

Print "Read Documentation/oops-tracing.txt before reporting this
problem" before oops, nmi lockup etc.  If somebody is maintaining a bug
database, I don't mind if the message is modified to also point to the
bug database.

There is no consistency between architectures.  Call read_oops_text()
in the die() routine if the arch has one, otherwise in the
die_if_kernel() routine.  For some awkward architectures, even call
read_oops_text() from open code.

diff 20-pre2.1/include/linux/kernel.h
--- 20-pre2.1/include/linux/kernel.h
+++ 20-pre2.1/include/linux/kernel.h
@@ -110,6 +110,12 @@ extern const char *print_tainted(void);
 
 extern void dump_stack(void);
 
+static inline
+void read_oops_text(void)
+{
+	printk(KERN_ERR "Read Documentation/oops-tracing.txt before reporting this problem\n");
+}
+
 #if DEBUG
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
diff 20-pre2.1/arch/alpha/kernel/traps.c
--- 20-pre2.1/arch/alpha/kernel/traps.c
+++ 20-pre2.1/arch/alpha/kernel/traps.c
@@ -177,6 +177,7 @@ die_if_kernel(char * str, struct pt_regs
 {
 	if (regs->ps & 8)
 		return;
+	read_oops_text();
 #ifdef CONFIG_SMP
 	printk("CPU %d ", hard_smp_processor_id());
 #endif
@@ -581,6 +582,7 @@ got_exception:
  	 */
 	lock_kernel();
 
+	read_oops_text();
 	printk("%s(%d): unhandled unaligned exception\n",
 	       current->comm, current->pid);
 
diff 20-pre2.1/arch/arm/kernel/traps.c
--- 20-pre2.1/arch/arm/kernel/traps.c
+++ 20-pre2.1/arch/arm/kernel/traps.c
@@ -160,6 +160,7 @@ NORET_TYPE void die(const char *str, str
 	console_verbose();
 	spin_lock_irq(&die_lock);
 
+	read_oops_text();
 	printk("Internal error: %s: %x\n", str, err);
 	printk("CPU: %d\n", smp_processor_id());
 	show_regs(regs);
diff 20-pre2.1/arch/cris/kernel/traps.c
--- 20-pre2.1/arch/cris/kernel/traps.c
+++ 20-pre2.1/arch/cris/kernel/traps.c
@@ -253,6 +253,7 @@ die_if_kernel(const char * str, struct p
 	stop_watchdog();
 #endif
 
+	read_oops_text();
 	printk("%s: %04lx\n", str, err & 0xffff);
 
 	show_registers(regs);
diff 20-pre2.1/arch/i386/kernel/nmi.c
--- 20-pre2.1/arch/i386/kernel/nmi.c
+++ 20-pre2.1/arch/i386/kernel/nmi.c
@@ -358,6 +358,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			 * to get a message out.
 			 */
 			bust_spinlocks(1);
+			read_oops_text();
 			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %08lx, registers:\n", cpu, regs->eip);
 			show_registers(regs);
 			printk("console shuts up ...\n");
diff 20-pre2.1/arch/i386/kernel/traps.c
--- 20-pre2.1/arch/i386/kernel/traps.c
+++ 20-pre2.1/arch/i386/kernel/traps.c
@@ -287,6 +287,7 @@ void die(const char * str, struct pt_reg
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
+	read_oops_text();
 	handle_BUG(regs);
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
diff 20-pre2.1/arch/ia64/kernel/traps.c
--- 20-pre2.1/arch/ia64/kernel/traps.c
+++ 20-pre2.1/arch/ia64/kernel/traps.c
@@ -103,6 +103,7 @@ die (const char *str, struct pt_regs *re
 		die.lock_owner = smp_processor_id();
 		die.lock_owner_depth = 0;
 		bust_spinlocks(1);
+		read_oops_text();
 	}
 
 	if (++die.lock_owner_depth < 3) {
diff 20-pre2.1/arch/m68k/kernel/traps.c
--- 20-pre2.1/arch/m68k/kernel/traps.c
+++ 20-pre2.1/arch/m68k/kernel/traps.c
@@ -1112,6 +1112,7 @@ void die_if_kernel (char *str, struct pt
 		return;
 
 	console_verbose();
+	read_oops_text();
 	printk("%s: %08x\n",str,nr);
 	printk("PC: [<%08lx>]\nSR: %04x  SP: %p  a2: %08lx\n",
 	       fp->pc, fp->sr, fp, fp->a2);
diff 20-pre2.1/arch/mips/kernel/traps.c
--- 20-pre2.1/arch/mips/kernel/traps.c
+++ 20-pre2.1/arch/mips/kernel/traps.c
@@ -333,6 +333,7 @@ void __die(const char * str, struct pt_r
 {
 	console_verbose();
 	spin_lock_irq(&die_lock);
+	read_oops_text();
 	printk("%s", str);
 	if (where)
 		printk(" in %s, line %ld", where, line);
diff 20-pre2.1/arch/mips64/kernel/traps.c
--- 20-pre2.1/arch/mips64/kernel/traps.c
+++ 20-pre2.1/arch/mips64/kernel/traps.c
@@ -225,6 +225,7 @@ void die(const char * str, struct pt_reg
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
+	read_oops_text();
 	printk("%s\n", str);
 	show_regs(regs);
 	printk("Process %s (pid: %d, stackpage=%08lx)\n",
diff 20-pre2.1/arch/parisc/kernel/traps.c
--- 20-pre2.1/arch/parisc/kernel/traps.c
+++ 20-pre2.1/arch/parisc/kernel/traps.c
@@ -224,6 +224,7 @@ void die_if_kernel(char *str, struct pt_
 	if (!console_drivers)
 		pdc_console_restart();
 	
+	read_oops_text();
 	printk(KERN_CRIT "%s (pid %d): %s (code %ld)\n",
 		current->comm, current->pid, str, err);
 	show_regs(regs);
diff 20-pre2.1/arch/s390/kernel/traps.c
--- 20-pre2.1/arch/s390/kernel/traps.c
+++ 20-pre2.1/arch/s390/kernel/traps.c
@@ -265,6 +265,7 @@ void die(const char * str, struct pt_reg
         console_verbose();
         spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
+	read_oops_text();
         printk("%s: %04lx\n", str, err & 0xffff);
         show_regs(regs);
 	bust_spinlocks(0);
diff 20-pre2.1/arch/s390x/kernel/traps.c
--- 20-pre2.1/arch/s390x/kernel/traps.c
+++ 20-pre2.1/arch/s390x/kernel/traps.c
@@ -267,6 +267,7 @@ void die(const char * str, struct pt_reg
         console_verbose();
         spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
+	read_oops_text();
         printk("%s: %04lx\n", str, err & 0xffff);
         show_regs(regs);
 	bust_spinlocks(0);
diff 20-pre2.1/arch/sh/kernel/traps.c
--- 20-pre2.1/arch/sh/kernel/traps.c
+++ 20-pre2.1/arch/sh/kernel/traps.c
@@ -60,6 +60,7 @@ void die(const char * str, struct pt_reg
 {
 	console_verbose();
 	spin_lock_irq(&die_lock);
+	read_oops_text();
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_regs(regs);
 	spin_unlock_irq(&die_lock);
diff 20-pre2.1/arch/sparc/kernel/traps.c
--- 20-pre2.1/arch/sparc/kernel/traps.c
+++ 20-pre2.1/arch/sparc/kernel/traps.c
@@ -91,6 +91,7 @@ void die_if_kernel(char *str, struct pt_
 {
 	int count = 0;
 
+	read_oops_text();
 	/* Amuse the user. */
 	printk(
 "              \\|/ ____ \\|/\n"
diff 20-pre2.1/arch/sparc64/kernel/traps.c
--- 20-pre2.1/arch/sparc64/kernel/traps.c
+++ 20-pre2.1/arch/sparc64/kernel/traps.c
@@ -1446,6 +1446,7 @@ void die_if_kernel(char *str, struct pt_
 	int count = 0;
 	struct reg_window *lastrw;
 	
+	read_oops_text();
 	/* Amuse the user. */
 	printk(
 "              \\|/ ____ \\|/\n"
diff 20-pre2.1/arch/x86_64/kernel/nmi.c
--- 20-pre2.1/arch/x86_64/kernel/nmi.c
+++ 20-pre2.1/arch/x86_64/kernel/nmi.c
@@ -361,6 +361,7 @@ void nmi_watchdog_tick (struct pt_regs *
 			 * to get a message out.
 			 */
 			bust_spinlocks(1);
+			read_oops_text();
 			printk("NMI Watchdog detected LOCKUP on CPU%d, eip %16lx, registers:\n", cpu, regs->rip);
 			show_registers(regs);
 			printk("console shuts up ...\n");
diff 20-pre2.1/arch/x86_64/kernel/traps.c
--- 20-pre2.1/arch/x86_64/kernel/traps.c
+++ 20-pre2.1/arch/x86_64/kernel/traps.c
@@ -349,6 +349,7 @@ void die(const char * str, struct pt_reg
 	console_verbose();
 	notifier_call_chain(&die_chain,  DIE_DIE, &args); 
 	bust_spinlocks(1);
+	read_oops_text();
 	handle_BUG(regs);		
 	printk(KERN_EMERG "%s: %04lx\n", str, err & 0xffff);
 	cpu = smp_processor_id(); 

