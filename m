Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQKGHZM>; Tue, 7 Nov 2000 02:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbQKGHZA>; Tue, 7 Nov 2000 02:25:00 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:54946 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129655AbQKGHYp>; Tue, 7 Nov 2000 02:24:45 -0500
Message-ID: <3A07AE2B.6E30DC01@uow.edu.au>
Date: Tue, 07 Nov 2000 18:24:27 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kumon@flab.fujitsu.co.jp
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: locks.c: removal of semaphores
In-Reply-To: <3A053B05.2AE5D4EB@uow.edu.au>,
		<3A053B05.2AE5D4EB@uow.edu.au> <200011070315.MAA15183@asami.proc.flab.fujitsu.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kumon@flab.fujitsu.co.jp wrote:
> 
> Andrew,
> I got 5250 Req/s with your locks-sem.patch on normal Apache.
> It is good performance on normal Apache.

Great.  Thanks again.  Trond has this patch now for ongoing
NFS locking stuff.  Hopefully 2.4 will now work OK with "legacy"
Apache configurations.

As long as the "new style" Apache configurations work OK.
Which leads us to...

> ...
> We also did durability test of 2.4.0-test10-pre5.  Unfortunately
> enough, we didn't successfully complete the test of Apache w/o
> serialization (-DSINGLE_LISTEN_UNSERIALIZED_ACCEPT), it couldn't
> continue to run for a night.  The kernel got complete deadlock.
> 
> The message is:
> "Unable to handle kernel NULL pointer dereference NMI watchdog detected LOCKUP on CPU1."
> 
> Yes, obviously it's not Andrew's problem, that is genuine test10-pre5.
> 
> Hidden bugs are awakened by removing serialization.
> 

   (Places fingertips lightly upon spinning disk drive.
    Closes eyes.  Quietly hums low monotone.  Time passes...)



I sense a corrupted struct timer_list!

Your kernel was traversing the tvecs[] array and took a fault.
The fault handler called printk() which called the console code
which called mod_timer() which deadlocked on timerlist_lock.
The NMI handler broke the deadlock and called the console code.
The NMI handler also deadlocked on timerlist_lock.

If this theory is correct the below patch should remove the
deadlock and thus allow you to get the usual diagnostics.

But I suspect the diagnostics will just show a trace up
into cascade_timers() or run_timer_list() which doesn't
tell us much.

If that is the case I'm afraid you will have to identify the
_exact_ statement where the error occured,  put some diagnostic
code just prior to it and run the tests a second time.

The interesting piece of information will be the timer's
function pointer.  So you'll need to add something like:

	struct timer_list *some_timer;	/* The timer which causes the fault */
	...
	if (some_timer->list.next == 0 || some_timer->list.prev == 0)
		printk("Corrupted timer! function=0x%p\n", some_timer->function);
	/* The next statement is where the oops occurs */
	<some statement which uses *some_timer>

Then if you can look the function pointer up in System.map or gdb
we will have our culprit.




--- linux-2.4.0-test10/arch/i386/kernel/traps.c	Sat Nov  4 16:22:47 2000
+++ linux-akpm/arch/i386/kernel/traps.c	Tue Nov  7 17:56:15 2000
@@ -396,9 +396,22 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-extern spinlock_t console_lock;
+extern spinlock_t console_lock, timerlist_lock;
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
 
+/*
+ * Unlock any spinlocks which will prevent us from getting the
+ * message out
+ */
+
+void bust_spinlocks(void)
+{
+	spin_trylock(&console_lock);
+	spin_unlock(&console_lock);
+	spin_trylock(&timerlist_lock);
+	spin_unlock(&timerlist_lock);
+}
+
 inline void nmi_watchdog_tick(struct pt_regs * regs)
 {
 	/*
@@ -439,8 +452,7 @@
 			 * We are in trouble anyway, lets at least try
 			 * to get a message out.
 			 */
-			spin_trylock(&console_lock);
-			spin_unlock(&console_lock);
+			bust_spinlocks();
 			printk("NMI Watchdog detected LOCKUP on CPU%d, registers:\n", cpu);
 			show_registers(regs);
 			printk("console shuts up ...\n");
--- linux-2.4.0-test10/arch/i386/mm/fault.c	Sat Nov  4 16:22:47 2000
+++ linux-akpm/arch/i386/mm/fault.c	Tue Nov  7 17:57:15 2000
@@ -24,6 +24,7 @@
 #include <asm/hardirq.h>
 
 extern void die(const char *,struct pt_regs *,long);
+extern void bust_spinlocks(void);
 
 /*
  * Ugly, ugly, but the goto's result in better assembly..
@@ -250,6 +251,8 @@
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
  */
+
+	bust_spinlocks();
 
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
