Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130649AbQKREV7>; Fri, 17 Nov 2000 23:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130657AbQKREVu>; Fri, 17 Nov 2000 23:21:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:24218 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130649AbQKREVa>; Fri, 17 Nov 2000 23:21:30 -0500
Message-ID: <3A15FCCF.C2666BAD@uow.edu.au>
Date: Sat, 18 Nov 2000 14:51:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] remove oops->printk deadlock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

patch removes the last deadlock opportunity in the x86 oops and
NMI oopser path, namely the call to wake_up_interruptible()
within printk itself.  (Apart from vga_lock, which isn't
worth the fuss).

bust_spinlocks() disappears again in favour of a global integer
`oops_in_progress'.

I've only reviewed the vt_console device talking to vgacon.  Other
console devices almost certainly have deadlock opportunities.  They're
easy to fix:

+	if (oops_in_progress)
+		spin_lock_init(&some_lock);	/* Sorry, George */
	spin_lock(&some_lock);

Other SMP-capable architectures may simply set and clear
oops_in_progress at the appropriate times.

poke_blanked_console() can come back if we want.  Just don't
call it if oops_in_progress is true.




--- linux-2.4.0-test11-pre4/include/linux/kernel.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/linux/kernel.h	Mon Nov 13 19:44:58 2000
@@ -62,6 +62,7 @@
 
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+extern int oops_in_progress;
 
 #if DEBUG
 #define pr_debug(fmt,arg...) \
--- linux-2.4.0-test11-pre4/kernel/printk.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/kernel/printk.c	Mon Nov 13 19:58:36 2000
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
+++ linux-akpm/arch/i386/mm/fault.c	Mon Nov 13 19:44:58 2000
@@ -77,19 +77,6 @@
 	return 0;
 }
 
-extern spinlock_t console_lock, timerlist_lock;
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is aquired through the
- * console unblank code)
- */
-void bust_spinlocks(void)
-{
-	spin_lock_init(&console_lock);
-	spin_lock_init(&timerlist_lock);
-}
-
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 extern unsigned long idt;
 
@@ -264,8 +251,7 @@
  * terminate things with extreme prejudice.
  */
 
-	bust_spinlocks();
-
+	oops_in_progress = 1;
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
@@ -283,6 +269,7 @@
 		printk(KERN_ALERT "*pte = %08lx\n", page);
 	}
 	die("Oops", regs, error_code);
+	oops_in_progress = 0;
 	do_exit(SIGKILL);
 
 /*
--- linux-2.4.0-test11-pre4/arch/i386/kernel/traps.c	Mon Nov 13 18:23:49 2000
+++ linux-akpm/arch/i386/kernel/traps.c	Mon Nov 13 19:44:58 2000
@@ -63,7 +63,6 @@
 struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
 
 extern int console_loglevel;
-extern void bust_spinlocks(void);
 
 static inline void console_silent(void)
 {
@@ -437,12 +436,13 @@
 			 * We are in trouble anyway, lets at least try
 			 * to get a message out.
 			 */
-			bust_spinlocks();
+			oops_in_progress = 1;
 			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
 			show_registers(regs);
 			printk("console shuts up ...\n");
 			console_silent();
 			spin_unlock(&nmi_print_lock);
+			oops_in_progress = 0;
 			do_exit(SIGSEGV);
 		}
 	} else {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
