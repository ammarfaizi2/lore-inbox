Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131854AbQKKAZV>; Fri, 10 Nov 2000 19:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132010AbQKKAZM>; Fri, 10 Nov 2000 19:25:12 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:58536 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131854AbQKKAZB>; Fri, 10 Nov 2000 19:25:01 -0500
Message-ID: <3A0C91DC.97693969@uow.edu.au>
Date: Sat, 11 Nov 2000 11:25:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pawe³ Kot <pkot@linuxnews.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem
In-Reply-To: <Pine.LNX.4.30.0011101806140.29502-100000@tfuj.ahoj.pl>
Content-Type: multipart/mixed;
 boundary="------------9D2E373944F38EB323DFEF95"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9D2E373944F38EB323DFEF95
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

"Pawe³ Kot" wrote:
> 
> Hello,
> 
> I've following error with 2.4.0-test{9|10|pre11pre1-ac1|pre11pre2-ac1}:
> 
> NMI Watchdog detected LOCKUP on CPU3, registers:
> 
> And then the machine hangs. No response at all.
> Always CPU3 is mentioned.
> The machine is:
> The latest Intel motherboard for 4xCPU (ISP4040)
> 4xPentium III 700 (Xeon)
> 4GB RAM
> mylex raid array (the newest controller)
> eepro100 ethernet card
> 
> This machine is running only MySQL database.
> 
> What can be wrong?

Oh no.  Another one.  Could you please try this attached
patch (against test11-pre2) and see if the diagnostics
come out?
--------------9D2E373944F38EB323DFEF95
Content-Type: text/plain; charset=us-ascii;
 name="kumon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kumon.patch"

--- linux-2.4.0-test11-pre2/arch/i386/kernel/traps.c	Fri Nov 10 20:24:02 2000
+++ linux-akpm/arch/i386/kernel/traps.c	Sat Nov 11 02:35:25 2000
@@ -382,20 +382,10 @@
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
-#if CONFIG_X86_IO_APIC
-
-int nmi_watchdog = 1;
-
-static int __init setup_nmi_watchdog(char *str)
-{
-        get_option(&str, &nmi_watchdog);
-        return 1;
-}
-
-__setup("nmi_watchdog=", setup_nmi_watchdog);
-
-extern spinlock_t console_lock, timerlist_lock;
+extern spinlock_t console_lock, timerlist_lock, runqueue_lock;
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+extern wait_queue_head_t log_wait;
+static int ignore_spinlocks = -1;
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
@@ -404,9 +394,30 @@
  */
 void bust_spinlocks(void)
 {
+	ignore_spinlocks = smp_processor_id();
+	global_irq_lock = 0;
 	spin_lock_init(&console_lock);
 	spin_lock_init(&timerlist_lock);
+	spin_lock_init(&runqueue_lock);
+	log_wait.lock = WAITQUEUE_RW_LOCK_UNLOCKED;
 }
+
+int no_spinlocks()
+{
+	return smp_processor_id() == ignore_spinlocks;
+}
+
+#if CONFIG_X86_IO_APIC
+
+int nmi_watchdog = 1;
+
+static int __init setup_nmi_watchdog(char *str)
+{
+        get_option(&str, &nmi_watchdog);
+        return 1;
+}
+
+__setup("nmi_watchdog=", setup_nmi_watchdog);
 
 inline void nmi_watchdog_tick(struct pt_regs * regs)
 {
--- linux-2.4.0-test11-pre2/include/asm-i386/spinlock.h	Sun Oct 15 01:27:46 2000
+++ linux-akpm/include/asm-i386/spinlock.h	Sat Nov 11 02:17:46 2000
@@ -8,6 +8,8 @@
 extern int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
+extern int no_spinlocks(void);
+
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
  * Remember to turn this off in 2.4. -ben
@@ -68,6 +70,8 @@
 static inline int spin_trylock(spinlock_t *lock)
 {
 	char oldval;
+	if (no_spinlocks())
+		return 0;
 	__asm__ __volatile__(
 		"xchgb %b0,%1"
 		:"=q" (oldval), "=m" (lock->lock)
@@ -85,6 +89,8 @@
 		BUG();
 	}
 #endif
+	if (no_spinlocks())
+		return;
 	__asm__ __volatile__(
 		spin_lock_string
 		:"=m" (lock->lock) : : "memory");
@@ -149,6 +155,9 @@
 	if (rw->magic != RWLOCK_MAGIC)
 		BUG();
 #endif
+	if (no_spinlocks())
+		return;
+
 	__build_read_lock(rw, "__read_lock_failed");
 }
 
@@ -158,6 +167,8 @@
 	if (rw->magic != RWLOCK_MAGIC)
 		BUG();
 #endif
+	if (no_spinlocks())
+		return;
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
--- linux-2.4.0-test11-pre2/arch/i386/kernel/i386_ksyms.c	Fri Aug 11 19:06:11 2000
+++ linux-akpm/arch/i386/kernel/i386_ksyms.c	Sat Nov 11 02:24:32 2000
@@ -155,3 +155,6 @@
 #ifdef CONFIG_X86_PAE
 EXPORT_SYMBOL(empty_zero_page);
 #endif
+
+EXPORT_SYMBOL(no_spinlocks);
+

--------------9D2E373944F38EB323DFEF95--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
