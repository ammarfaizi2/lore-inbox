Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbQKMMLY>; Mon, 13 Nov 2000 07:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKMMLO>; Mon, 13 Nov 2000 07:11:14 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:45514 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129050AbQKMMLH>; Mon, 13 Nov 2000 07:11:07 -0500
Message-ID: <3A0FDA5D.FB2968C7@uow.edu.au>
Date: Mon, 13 Nov 2000 23:11:09 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jasper Spaans <jasper@spaans.ds9a.nl>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem
In-Reply-To: <3A0DF347.43807CB5@uow.edu.au> <3204.973996033@ocs3.ocs-net>,
		<3204.973996033@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Nov 12, 2000 at 01:27:13PM +1100 <20001113095816.A29077@spaans.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper Spaans wrote:
> 
> On Sun, Nov 12, 2000 at 01:27:13PM +1100, Keith Owens wrote:
> 
> > >That's a pretty wierd trace.  You seem to have addresses related
> > >to the `apm' kernel thread on mysqld's stack.
> >
> > Normal unfortunately.  Firstly the ix86 oops code just scans the stack
> > and prints anything that looks like it might be a kernel address.  It
> > makes no attempt to confirm that these really are return addresses, so
> > an ix86 oops trace gets lots of false positives.  Secondly that trace
> > was converted by klogd (symbols in call trace line instead of numbers)
> > not by ksymoops, I do not trust the klogd algorithm at all.
> 
> All right, here's another one, this time using the oops directly from the
> console -- this seems to give better symbols.. The 'console shuts up ...'
> works, the oops from the other CPU didn't get put out.

OK this should show us the backtrace on both CPUs.  Please back out
the previous patchlet (if you applied it) and apply this one.

Thanks.


--- linux-2.4.0-test11-pre4/include/linux/kernel.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/linux/kernel.h	Mon Nov 13 22:22:50 2000
@@ -62,6 +62,7 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern int oops_in_progress;
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \
--- linux-2.4.0-test11-pre4/kernel/printk.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/kernel/printk.c	Mon Nov 13 22:23:33 2000
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
+++ linux-akpm/arch/i386/mm/fault.c	Mon Nov 13 22:37:37 2000
@@ -77,17 +77,31 @@
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
 {
-	spin_lock_init(&console_lock);
-	spin_lock_init(&timerlist_lock);
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
+		printk("\n");
+	}		
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
@@ -264,8 +278,7 @@
  * terminate things with extreme prejudice.
  */
 
-	bust_spinlocks();
-
+	bust_spinlocks(1);
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
@@ -283,6 +296,7 @@
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 	die("Oops", regs, error_code);
+	bust_spinlocks(0);
 	do_exit(SIGKILL);
 
 /*
--- linux-2.4.0-test11-pre4/arch/i386/kernel/traps.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/arch/i386/kernel/traps.c	Mon Nov 13 22:27:13 2000
@@ -63,7 +63,7 @@
 struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
 
 extern int console_loglevel;
-extern void bust_spinlocks(void);
+extern void bust_spinlocks(int yes);
 
 static inline void console_silent(void)
 {
@@ -414,8 +414,9 @@
 	 *  here too!]
 	 */
 
-	static unsigned int last_irq_sums [NR_CPUS],
-				alert_counter [NR_CPUS];
+	static unsigned int	last_irq_sums [NR_CPUS],
+				alert_counter [NR_CPUS],
+				printed_message [NR_CPUS];
 
 	/*
 	 * Since current-> is always on the stack, and we always switch
@@ -432,17 +433,19 @@
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
