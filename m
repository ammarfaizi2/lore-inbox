Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbQKKVvs>; Sat, 11 Nov 2000 16:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129105AbQKKVvi>; Sat, 11 Nov 2000 16:51:38 -0500
Received: from [62.172.234.2] ([62.172.234.2]:34356 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129165AbQKKVvW>;
	Sat, 11 Nov 2000 16:51:22 -0500
Date: Sat, 11 Nov 2000 21:52:56 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "reiser.angus" <reiser.angus@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0-test11-pre2 compilation error:  undefined reference
 to `bust_spinlocks'
In-Reply-To: <3A0DBD06.3070409@wanadoo.fr>
Message-ID: <Pine.LNX.4.21.0011112151480.2229-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, reiser.angus wrote:

> cannot make a success compilation of 2.4.0-test11pre2 with the same 
> .config than for a successfull 2.4.0-test10 compilation.
> Same problem when apply patch-2.4.0test11pre2-ac1 from alan cox
> 
> arch/i386/mm/mm.o: In function `do_page_fault':
> arch/i386/mm/mm.o(.text+0x821): undefined reference to `bust_spinlocks'
> make: *** [vmlinux] Erreur 1
> 
> bash-2.04$
> 
> use egcs 1.1.2

This has been introduced and fixed by Andrew Morton ages ago -- here his
email and patch with the fix:

>From morton@nortelnetworks.com Fri Nov 10 09:11:36 2000
Date: Fri, 10 Nov 2000 05:18:09 +0000
From: Andrew Morton <morton@nortelnetworks.com>
To: John Kacur <jkacur@home.com>, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Re: test11-pre2 compile error undefined reference to      
       `bust_spinlocks'

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
