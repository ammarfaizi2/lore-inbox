Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKJFU7>; Fri, 10 Nov 2000 00:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQKJFUt>; Fri, 10 Nov 2000 00:20:49 -0500
Received: from [203.126.247.144] ([203.126.247.144]:41396 "EHLO
	esngs144.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S129152AbQKJFUb>; Fri, 10 Nov 2000 00:20:31 -0500
Message-ID: <3A0B8511.5A0BEC8@asiapacificm01.nt.com>
Date: Fri, 10 Nov 2000 05:18:09 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.0-test4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Kacur <jkacur@home.com>, Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Re: test11-pre2 compile error undefined reference to 
         `bust_spinlocks'
In-Reply-To: <3A0B8881.F444DF5@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kacur wrote:
> 
> When attempting to compile test11-pre2, I get the following compile
> error.
> 
> arch/i386/mm/mm.o: In function `do_page_fault':
> arch/i386/mm/mm.o(.text+0x781): undefined reference to `bust_spinlocks'
> make: *** [vmlinux] Error 1

It was inside an ifdef.  Apologies.

This patch against test11-pre2 moves it to fault.c.


--- linux-2.4.0-test11-pre2/arch/i386/kernel/traps.c	Fri Nov 10 15:59:15 2000
+++ linux/arch/i386/kernel/traps.c	Fri Nov 10 15:52:40 2000
@@ -63,6 +63,7 @@
 struct desc_struct idt_table[256] __attribute__((__section__(".data.idt"))) = { {0, 0}, };
 
 extern int console_loglevel;
+extern void bust_spinlocks(void);
 
 static inline void console_silent(void)
 {
@@ -394,19 +395,7 @@
 
 __setup("nmi_watchdog=", setup_nmi_watchdog);
 
-extern spinlock_t console_lock, timerlist_lock;
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
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
 
 inline void nmi_watchdog_tick(struct pt_regs * regs)
 {
--- linux-2.4.0-test11-pre2/arch/i386/mm/fault.c	Fri Nov 10 15:59:15 2000
+++ linux/arch/i386/mm/fault.c	Fri Nov 10 16:02:03 2000
@@ -24,7 +24,6 @@
 #include <asm/hardirq.h>
 
 extern void die(const char *,struct pt_regs *,long);
-extern void bust_spinlocks(void);
 
 /*
  * Ugly, ugly, but the goto's result in better assembly..
@@ -76,6 +75,19 @@
 
 bad_area:
 	return 0;
+}
+
+extern spinlock_t console_lock, timerlist_lock;
+
+/*
+ * Unlock any spinlocks which will prevent us from getting the
+ * message out (timerlist_lock is aquired through the
+ * console unblank code)
+ */
+void bust_spinlocks(void)
+{
+	spin_lock_init(&console_lock);
+	spin_lock_init(&timerlist_lock);
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
