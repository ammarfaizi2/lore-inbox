Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbQKOLiS>; Wed, 15 Nov 2000 06:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130227AbQKOLh5>; Wed, 15 Nov 2000 06:37:57 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:5532 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130127AbQKOLhw>; Wed, 15 Nov 2000 06:37:52 -0500
Message-ID: <3A126E84.B77704FD@uow.edu.au>
Date: Wed, 15 Nov 2000 22:07:48 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A1115C5.4C04CD6A@uow.edu.au> <Pine.LNX.4.21.0011151114130.1253-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 14 Nov 2000, Andrew Morton wrote:
> 
> > It also changes the x86 NMI oopser so that it no longer shuts the
> > console up after the first NMI oops.  Instead, each CPU is allowed
> > to print out NMI diagnostics a single time per reboot.
> 
> this is not how the NMI oopser works. It does *not* shut down the console
> - you can still see everything in 'dmesg'. If you want to see it on the
> console again, you can do 'dmesg -n 8'. Adding a 'once per reboot'
> restriction is unreasonable - there are user-space applications that can
> be terminated via the NMI-oopser safely.

The patch addresses that - it still calls do_exit() for every NMI timeout.

> In 99% of the cases it's the
> first oops that counts, and most people do not have serial console set up,
> so writing the first oops down from screen is important.

Good point.  Problem is, we're getting some reported lockups in which we
need to know what the other CPUs are doing (the other 1%).  If a critical
spinlock is stuck on, we don't get to type `dmesg'.

So...  In this updated patch the console_silent() call remains
as you designed it, but the nmi_watchdog kernel boot parameter has
been overloaded so that

	nmi_watchdog=2

will now cause _all_ NMI oops messages to be displayed on the console.

Is this OK?



--- linux-2.4.0-test11-pre4/include/linux/kernel.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/linux/kernel.h	Wed Nov 15 20:31:29 2000
@@ -62,6 +62,7 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern int oops_in_progress;
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \
--- linux-2.4.0-test11-pre4/include/asm-i386/page.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/asm-i386/page.h	Wed Nov 15 20:31:29 2000
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
+++ linux-akpm/kernel/printk.c	Wed Nov 15 20:31:29 2000
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
+++ linux-akpm/arch/i386/mm/fault.c	Wed Nov 15 20:31:29 2000
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
+++ linux-akpm/arch/i386/kernel/traps.c	Wed Nov 15 21:57:49 2000
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
@@ -414,7 +415,7 @@
 	 *  here too!]
 	 */
 
-	static unsigned int last_irq_sums [NR_CPUS],
+	static unsigned int	last_irq_sums [NR_CPUS],
 				alert_counter [NR_CPUS];
 
 	/*
@@ -437,12 +438,15 @@
 			 * We are in trouble anyway, lets at least try
 			 * to get a message out.
 			 */
-			bust_spinlocks();
+			bust_spinlocks(1);
 			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
 			show_registers(regs);
-			printk("console shuts up ...\n");
-			console_silent();
+			if (nmi_watchdog <= 1) {
+				printk("Console shuts up.  Use `dmesg' or boot with `nmi_watchdog=2' to see more logs.\n");
+				console_silent();
+			}
 			spin_unlock(&nmi_print_lock);
+			bust_spinlocks(0);
 			do_exit(SIGSEGV);
 		}
 	} else {
--- linux-2.4.0-test11-pre4/arch/i386/kernel/i386_ksyms.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Wed Nov 15 20:31:29 2000
@@ -157,3 +157,5 @@
 #ifdef CONFIG_X86_PAE
 EXPORT_SYMBOL(empty_zero_page);
 #endif
+
+EXPORT_SYMBOL(do_BUG);
--- linux-2.4.0-test11-pre4/drivers/char/console.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/drivers/char/console.c	Wed Nov 15 20:31:29 2000
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
 
--- linux-2.4.0-test11-pre4/Documentation/nmi_watchdog.txt	Thu Aug 24 21:07:14 2000
+++ linux-akpm/Documentation/nmi_watchdog.txt	Wed Nov 15 21:51:17 2000
@@ -24,8 +24,21 @@
 cannot even accept NMI interrupts, or the crash has made the kernel
 unable to print messages.
 
-NOTE: currently the NMI-oopser is enabled unconditionally on x86 SMP
-boxes.
+The NMI-oopser defaults to `1' (enabled) on x86 SMP boxes.
+
+The NMI-oopser only displays the first oops message on the console. This
+is to prevent vital information from scrolling off the scren if more
+errors occur.  You can find additional information (such as NMI oops
+information from other CPUs) by looking in your system logs or with
+the `dmesg' command.  
+
+If your system is crashing hard and preventing you from running `dmesg' 
+you can tell the NMI oopser to display all NMI oops messages (not just
+the first one) by setting
+
+	nmi_watchdog=2
+
+on the kernel boot command line or in lilo.conf, as shown above.
 
 [ feel free to send bug reports, suggestions and patches to
   Ingo Molnar <mingo@redhat.com> or the Linux SMP mailing
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
