Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKONxu>; Wed, 15 Nov 2000 08:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129588AbQKONx3>; Wed, 15 Nov 2000 08:53:29 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:61340 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129097AbQKONxV>; Wed, 15 Nov 2000 08:53:21 -0500
Message-ID: <3A128E4D.32D81784@uow.edu.au>
Date: Thu, 16 Nov 2000 00:23:25 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A126E84.B77704FD@uow.edu.au> <Pine.LNX.4.21.0011151318060.2374-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> > So...  In this updated patch the console_silent() call remains
> > as you designed it, but the nmi_watchdog kernel boot parameter has
> > been overloaded so that
> >
> >       nmi_watchdog=2
> >
> > will now cause _all_ NMI oops messages to be displayed on the console.
> >
> > Is this OK?
> 
> this collides with the UP-IOAPIC path's use of nmi_watchdog == 2 ...
>
> i'd rather suggest a cleaner, "nmi_watchdog=2,verbose" (default: silent)
> type of boot parameter, it looks like the NMI watchdog needs more
> parameters.


OK, so the options are now:

	nmi_watchdog=0
	nmi_watchdog=1
	nmi_watchdog=1,verbose


Third time lucky?



--- linux-2.4.0-test11-pre5/include/linux/kernel.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/linux/kernel.h	Wed Nov 15 23:25:48 2000
@@ -62,6 +62,7 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern int oops_in_progress;
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \
--- linux-2.4.0-test11-pre5/include/asm-i386/page.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/asm-i386/page.h	Wed Nov 15 23:27:32 2000
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
 
--- linux-2.4.0-test11-pre5/kernel/printk.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/kernel/printk.c	Wed Nov 15 23:25:48 2000
@@ -51,6 +51,7 @@
 static unsigned long logged_chars;
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
+int oops_in_progress;
 
 /*
  *	Setup a list of consoles. Called from init/main.c
@@ -251,6 +252,9 @@
 	return do_syslog(type, buf, len);
 }
 
+/*
+ * printk("") may be used to wake up klogd
+ */
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
@@ -260,6 +264,8 @@
 	static signed char msg_level = -1;
 	long flags;
 
+	if (oops_in_progress)
+		spin_lock_init(&console_lock);
 	spin_lock_irqsave(&console_lock, flags);
 	va_start(args, fmt);
 	i = vsprintf(buf + 3, fmt, args); /* hopefully i < sizeof(buf)-4 */
@@ -308,7 +314,8 @@
 			msg_level = -1;
 	}
 	spin_unlock_irqrestore(&console_lock, flags);
-	wake_up_interruptible(&log_wait);
+	if (!oops_in_progress)
+		wake_up_interruptible(&log_wait);
 	return i;
 }
 
--- linux-2.4.0-test11-pre5/arch/i386/mm/fault.c	Wed Nov 15 23:00:16 2000
+++ linux-akpm/arch/i386/mm/fault.c	Thu Nov 16 00:14:37 2000
@@ -77,17 +77,37 @@
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
  */
-void bust_spinlocks(void)
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
+		 * without oops_in_progress set so that printk will give klogd
+		 * a poke.  Hold onto your hats...
+		 */
+		printk("");
+	}		
+}
+
+void do_BUG(const char *file, int line)
 {
-	spin_lock_init(&console_lock);
-	spin_lock_init(&timerlist_lock);
+	bust_spinlocks(1);
+	printk("kernel BUG at %s:%d!\n", file, line);
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
@@ -264,8 +284,7 @@
  * terminate things with extreme prejudice.
  */
 
-	bust_spinlocks();
-
+	bust_spinlocks(1);
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
@@ -283,6 +302,7 @@
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 	die("Oops", regs, error_code);
+	bust_spinlocks(0);
 	do_exit(SIGKILL);
 
 /*
--- linux-2.4.0-test11-pre5/arch/i386/kernel/traps.c	Wed Nov 15 23:00:16 2000
+++ linux-akpm/arch/i386/kernel/traps.c	Wed Nov 15 23:49:00 2000
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
@@ -386,10 +387,14 @@
 #if CONFIG_X86_IO_APIC
 
 int nmi_watchdog = 1;
+static int nmi_watchdog_verbose;
 
 static int __init setup_nmi_watchdog(char *str)
 {
-        get_option(&str, &nmi_watchdog);
+ 	if (get_option(&str, &nmi_watchdog) == 2) {
+		if (strcmp(str, "verbose") == 0)
+			nmi_watchdog_verbose = 1;
+	}
         return 1;
 }
 
@@ -414,7 +419,7 @@
 	 *  here too!]
 	 */
 
-	static unsigned int last_irq_sums [NR_CPUS],
+	static unsigned int	last_irq_sums [NR_CPUS],
 				alert_counter [NR_CPUS];
 
 	/*
@@ -437,12 +442,15 @@
 			 * We are in trouble anyway, lets at least try
 			 * to get a message out.
 			 */
-			bust_spinlocks();
+			bust_spinlocks(1);
 			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
 			show_registers(regs);
-			printk("console shuts up ...\n");
-			console_silent();
+			if (nmi_watchdog_verbose == 0) {
+				printk("Console shuts up. Run dmesg or boot with `nmi_watchdog=1,verbose' for more logs\n");
+				console_silent();
+			}
 			spin_unlock(&nmi_print_lock);
+			bust_spinlocks(0);
 			do_exit(SIGSEGV);
 		}
 	} else {
--- linux-2.4.0-test11-pre5/arch/i386/kernel/i386_ksyms.c	Wed Nov 15 23:00:16 2000
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Wed Nov 15 23:25:48 2000
@@ -157,3 +157,5 @@
 #ifdef CONFIG_X86_PAE
 EXPORT_SYMBOL(empty_zero_page);
 #endif
+
+EXPORT_SYMBOL(do_BUG);
--- linux-2.4.0-test11-pre5/drivers/char/console.c	Wed Nov 15 23:00:16 2000
+++ linux-akpm/drivers/char/console.c	Wed Nov 15 23:25:48 2000
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
 
--- linux-2.4.0-test11-pre5/Documentation/nmi_watchdog.txt	Thu Aug 24 21:07:14 2000
+++ linux-akpm/Documentation/nmi_watchdog.txt	Wed Nov 15 23:25:48 2000
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
+	nmi_watchdog=1,verbose
+
+on the kernel boot command line or in lilo.conf, as shown above.
 
 [ feel free to send bug reports, suggestions and patches to
   Ingo Molnar <mingo@redhat.com> or the Linux SMP mailing
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
