Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbQKNLHJ>; Tue, 14 Nov 2000 06:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQKNLG7>; Tue, 14 Nov 2000 06:06:59 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:2525 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129706AbQKNLGs>; Tue, 14 Nov 2000 06:06:48 -0500
Message-ID: <3A1115C5.4C04CD6A@uow.edu.au>
Date: Tue, 14 Nov 2000 21:36:53 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, James Simmons <jsimmons@suse.com>
Subject: [prepatch] removal of oops->printk deadlocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is designed to remove the things which can cause loss
of oops information due to the SMP deadlocks which can occur during
the oops processing itself.  It's fairly x86-specific, but the
infrastructure is in place for other SMP-capable architectures
to use.

It also changes the x86 NMI oopser so that it no longer shuts the
console up after the first NMI oops.  Instead, each CPU is allowed
to print out NMI diagnostics a single time per reboot.

This patch only addresses console-on-vgacon.  If the console is
on a serial device then there may still be deadlocks.  The serial
drivers can individually test `oops_in_progress' to avoid this.

The call to poke_blanked_console() is resurrected, but it's no
longer deadlocky.  This is fairly important - without this change
a machine could be wedged with oops diagnostics on its screen,
but the screen would remain blanked.

The patch addresses oopses, die(), NMI oopses and BUG().  The changes
to BUG() result in 3 kbytes less .rodata.

There's a tiny kernel module at
http://www.uow.edu.au/~andrewm/linux/ddeadlock.c which may be
used to test the NMI oopser changes.

Comments are welcome!


--- linux-2.4.0-test11-pre4/include/linux/kernel.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/linux/kernel.h	Tue Nov 14 21:02:18 2000
@@ -62,6 +62,7 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern int oops_in_progress;
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \
--- linux-2.4.0-test11-pre4/include/asm-i386/page.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/asm-i386/page.h	Tue Nov 14 21:02:18 2000
@@ -88,8 +88,9 @@
  * Tell the user there is some problem. Beep too, so we can
  * see^H^H^Hhear bugs in early bootup as well!
  */
+extern void do_BUG(const char *file, int line);
 #define BUG() do { \
-	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	do_BUG(__FILE__, __LINE__); \
 	__asm__ __volatile__(".byte 0x0f,0x0b"); \
 } while (0)
 
--- linux-2.4.0-test11-pre4/kernel/printk.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/kernel/printk.c	Tue Nov 14 21:02:18 2000
@@ -51,6 +51,7 @@
 static unsigned long logged_chars;
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
+int oops_in_progress;
 
 /*
  *	Setup a list of consoles. Called from init/main.c
@@ -260,6 +261,8 @@
 	static signed char msg_level = -1;
 	long flags;
 
+	if (oops_in_progress)
+		spin_lock_init(&console_lock);
 	spin_lock_irqsave(&console_lock, flags);
 	va_start(args, fmt);
 	i = vsprintf(buf + 3, fmt, args); /* hopefully i < sizeof(buf)-4 */
@@ -308,7 +311,8 @@
 			msg_level = -1;
 	}
 	spin_unlock_irqrestore(&console_lock, flags);
-	wake_up_interruptible(&log_wait);
+	if (!oops_in_progress)
+		wake_up_interruptible(&log_wait);
 	return i;
 }
 
--- linux-2.4.0-test11-pre4/arch/i386/mm/fault.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/arch/i386/mm/fault.c	Tue Nov 14 21:02:18 2000
@@ -77,17 +77,40 @@
 	return 0;
 }
 
-extern spinlock_t console_lock, timerlist_lock;
+#ifdef CONFIG_SMP
+extern unsigned volatile int global_irq_lock;
+#endif
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is aquired through the
- * console unblank code)
+ * message out and tell the printk/console paths that an emergency
+ * message is coming through
+ */
+void bust_spinlocks(int yes)
+{
+	if (yes) {
+		oops_in_progress = 1;
+#ifdef CONFIG_SMP
+		global_irq_lock = 0;	/* Many serial drivers do __global_cli() */
+#endif
+	} else {
+		oops_in_progress = 0;
+		/*
+		 * OK, the message is on the console.  Now we call printk()
+		 * without oops_in_progress set so that printk will give syslogd
+		 * a poke.  Hold onto your hats...
+		 */
+		printk("");
+	}		
+}
+
+/*
+ * Called from the BUG() macro.
  */
-void bust_spinlocks(void)
+void do_BUG(const char *file, int line)
 {
-	spin_lock_init(&console_lock);
-	spin_lock_init(&timerlist_lock);
+	bust_spinlocks(1);
+	printk("kernel BUG at %s:%d!\n", file, line);
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
@@ -264,8 +287,7 @@
  * terminate things with extreme prejudice.
  */
 
-	bust_spinlocks();
-
+	bust_spinlocks(1);
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
@@ -283,6 +305,7 @@
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 	die("Oops", regs, error_code);
+	bust_spinlocks(0);
 	do_exit(SIGKILL);
 
 /*
--- linux-2.4.0-test11-pre4/arch/i386/kernel/traps.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/arch/i386/kernel/traps.c	Tue Nov 14 21:11:10 2000
@@ -63,7 +63,7 @@
 struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
 
 extern int console_loglevel;
-extern void bust_spinlocks(void);
+extern void bust_spinlocks(int yes);
 
 static inline void console_silent(void)
 {
@@ -209,9 +209,10 @@
 {
 	console_verbose();
 	spin_lock_irq(&die_lock);
+	bust_spinlocks(1);
 	printk("%s: %04lx\n", str, err & 0xffff);
 	show_registers(regs);
-
+	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
 	do_exit(SIGSEGV);
 }
@@ -414,8 +415,9 @@
 	 *  here too!]
 	 */
 
-	static unsigned int last_irq_sums [NR_CPUS],
+	static unsigned int	last_irq_sums [NR_CPUS],
 				alert_counter [NR_CPUS];
+	static unsigned char	printed_message [NR_CPUS];
 
 	/*
 	 * Since current-> is always on the stack, and we always switch
@@ -432,17 +434,19 @@
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*HZ) {
-			spin_lock(&nmi_print_lock);
-			/*
-			 * We are in trouble anyway, lets at least try
-			 * to get a message out.
-			 */
-			bust_spinlocks();
-			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
-			show_registers(regs);
-			printk("console shuts up ...\n");
-			console_silent();
-			spin_unlock(&nmi_print_lock);
+			if (printed_message[cpu] == 0) {
+				printed_message[cpu] = 1;
+				spin_lock(&nmi_print_lock);
+				/*
+				 * We are in trouble anyway, lets at least try
+				 * to get a message out.
+				 */
+				bust_spinlocks(1);
+				printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
+				show_registers(regs);
+				spin_unlock(&nmi_print_lock);
+				bust_spinlocks(0);
+			}
 			do_exit(SIGSEGV);
 		}
 	} else {
--- linux-2.4.0-test11-pre4/arch/i386/kernel/i386_ksyms.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Tue Nov 14 21:02:18 2000
@@ -157,3 +157,5 @@
 #ifdef CONFIG_X86_PAE
 EXPORT_SYMBOL(empty_zero_page);
 #endif
+
+EXPORT_SYMBOL(do_BUG);
--- linux-2.4.0-test11-pre4/drivers/char/console.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/drivers/char/console.c	Tue Nov 14 21:02:18 2000
@@ -2135,6 +2135,7 @@
 		}
 	}
 	set_cursor(currcons);
+	poke_blanked_console();
 
 quit:
 	clear_bit(0, &printing);
@@ -2661,7 +2662,7 @@
 		return;
 	}
 	console_timer.function = blank_screen;
-	if (blankinterval) {
+	if (blankinterval && !oops_in_progress) {
 		mod_timer(&console_timer, jiffies + blankinterval);
 	}
 
@@ -2683,14 +2684,18 @@
 
 void poke_blanked_console(void)
 {
-	del_timer(&console_timer);	/* Can't use _sync here: called from tasklet */
-	if (vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
-		return;
-	if (console_blanked) {
-		console_timer.function = unblank_screen_t;
-		mod_timer(&console_timer, jiffies);	/* Now */
-	} else if (blankinterval) {
-		mod_timer(&console_timer, jiffies + blankinterval);
+	if (oops_in_progress) {
+		unblank_screen();	/* Just do it */
+	} else {
+		del_timer(&console_timer);	/* Can't use _sync here: called from tasklet */
+		if (vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
+			return;
+		if (console_blanked) {
+			console_timer.function = unblank_screen_t;
+			mod_timer(&console_timer, jiffies);	/* Now */
+		} else if (blankinterval) {
+			mod_timer(&console_timer, jiffies + blankinterval);
+		}
 	}
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
