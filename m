Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQKKVws>; Sat, 11 Nov 2000 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQKKVwi>; Sat, 11 Nov 2000 16:52:38 -0500
Received: from albatross.prod.itd.earthlink.net ([207.217.120.120]:5298 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129105AbQKKVwb>; Sat, 11 Nov 2000 16:52:31 -0500
To: "reiser.angus" <reiser.angus@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.0-test11-pre2 compilation error:  undefined reference to `bust_spinlocks'
In-Reply-To: <3A0DBD06.3070409@wanadoo.fr>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 11 Nov 2000 13:52:23 -0800
In-Reply-To: <3A0DBD06.3070409@wanadoo.fr>
Message-ID: <m3y9yq5g88.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"reiser.angus" <reiser.angus@wanadoo.fr> writes:

> cannot make a success compilation of 2.4.0-test11pre2 with the same
> .config than for a successfull 2.4.0-test10 compilation.
> Same problem when apply patch-2.4.0test11pre2-ac1 from alan cox
> 
> arch/i386/mm/mm.o: In function `do_page_fault':
> arch/i386/mm/mm.o(.text+0x821): undefined reference to `bust_spinlocks'
> make: *** [vmlinux] Erreur 1

apply this patch (if you look in the archive of lkml you'll see it was
posted a day ago by Keith Owens :

Index: 0-test11-pre2.1/arch/i386/kernel/traps.c
--- 0-test11-pre2.1/arch/i386/kernel/traps.c Fri, 10 Nov 2000 13:10:37 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
+++ 0-test11-pre2.1(w)/arch/i386/kernel/traps.c Fri, 10 Nov 2000 16:06:48 +1100 kaos (linux-2.4/A/c/1_traps.c 1.1.2.2.1.1.2.1.2.3.1.2.3.1.1.2 644)
@@ -382,6 +382,18 @@ static void unknown_nmi_error(unsigned c
 	printk("Do you have a strange power saving mode enabled?\n");
 }
 
+extern spinlock_t console_lock, timerlist_lock;
+/*
+ * Unlock any spinlocks which will prevent us from getting the
+ * message out (timerlist_lock is acquired through the
+ * console unblank code)
+ */
+void bust_spinlocks(void)
+{
+	spin_lock_init(&console_lock);
+	spin_lock_init(&timerlist_lock);
+}
+
 #if CONFIG_X86_IO_APIC
 
 int nmi_watchdog = 1;
@@ -394,19 +406,7 @@ static int __init setup_nmi_watchdog(cha
 
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

-


-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
