Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUIFJ5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUIFJ5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 05:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUIFJ5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 05:57:44 -0400
Received: from asplinux.ru ([195.133.213.194]:65286 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267528AbUIFJ50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 05:57:26 -0400
Message-ID: <413C3749.3010207@sw.ru>
Date: Mon, 06 Sep 2004 14:09:13 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] removes unnessary print of space v2, wakeup_klogd()
Content-Type: multipart/mixed;
 boundary="------------050104080604070705040702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050104080604070705040702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes unnessary print of space in bust_spinlocks()
instead wake_up_klogd() is called.
Also it removes exact copies of lib/bust_spinlocks.c:bust_spinlocks()
from 3 architectures.

Kirill

--------------050104080604070705040702
Content-Type: text/plain;
 name="diff-oops-printk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-oops-printk"

--- ./include/linux/kernel.h.printk	2004-09-04 18:23:32.000000000 +0400
+++ ./include/linux/kernel.h	2004-09-06 12:57:32.504625256 +0400
@@ -131,6 +131,7 @@ static inline void console_verbose(void)
 }
 
 extern void bust_spinlocks(int yes);
+extern void wake_up_klogd(void);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_on_oops;
 extern int tainted;
--- ./arch/i386/mm/fault.c.printk	2004-08-14 14:54:46.000000000 +0400
+++ ./arch/i386/mm/fault.c	2004-09-06 12:40:45.573702024 +0400
@@ -30,32 +30,6 @@
 extern void die(const char *,struct pt_regs *,long);
 
 /*
- * Unlock any spinlocks which will prevent us from getting the
- * message out 
- */
-void bust_spinlocks(int yes)
-{
-	int loglevel_save = console_loglevel;
-
-	if (yes) {
-		oops_in_progress = 1;
-		return;
-	}
-#ifdef CONFIG_VT
-	unblank_screen();
-#endif
-	oops_in_progress = 0;
-	/*
-	 * OK, the message is on the console.  Now we call printk()
-	 * without oops_in_progress set so that printk will give klogd
-	 * a poke.  Hold onto your hats...
-	 */
-	console_loglevel = 15;		/* NMI oopser may have shut the console up */
-	printk(" ");
-	console_loglevel = loglevel_save;
-}
-
-/*
  * Return EIP plus the CS segment base.  The segment limit is also
  * adjusted, clamped to the kernel/user address space (whichever is
  * appropriate), and returned in *eip_limit.
--- ./arch/ia64/kernel/traps.c.printk	2004-08-14 14:56:23.000000000 +0400
+++ ./arch/ia64/kernel/traps.c	2004-09-06 12:41:18.811649088 +0400
@@ -35,34 +35,6 @@ trap_init (void)
 		fpswa_interface = __va(ia64_boot_param->fpswa);
 }
 
-/*
- * Unlock any spinlocks which will prevent us from getting the message out (timerlist_lock
- * is acquired through the console unblank code)
- */
-void
-bust_spinlocks (int yes)
-{
-	int loglevel_save = console_loglevel;
-
-	if (yes) {
-		oops_in_progress = 1;
-		return;
-	}
-
-#ifdef CONFIG_VT
-	unblank_screen();
-#endif
-	oops_in_progress = 0;
-	/*
-	 * OK, the message is on the console.  Now we call printk() without
-	 * oops_in_progress set so that printk will give klogd a poke.  Hold onto
-	 * your hats...
-	 */
-	console_loglevel = 15;		/* NMI oopser may have shut the console up */
-	printk(" ");
-	console_loglevel = loglevel_save;
-}
-
 void
 die (const char *str, struct pt_regs *regs, long err)
 {
--- ./arch/x86_64/mm/fault.c.printk	2004-08-14 14:54:47.000000000 +0400
+++ ./arch/x86_64/mm/fault.c	2004-09-06 12:42:00.060378328 +0400
@@ -34,27 +34,6 @@
 #include <asm/kdebug.h>
 #include <asm-generic/sections.h>
 
-void bust_spinlocks(int yes)
-{
-	int loglevel_save = console_loglevel;
-	if (yes) {
-		oops_in_progress = 1;
-	} else {
-#ifdef CONFIG_VT
-		unblank_screen();
-#endif
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;		/* NMI oopser may have shut the console up */
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
-}
-
 /* Sometimes the CPU reports invalid exceptions on prefetch.
    Check that here and ignore.
    Opcode checker based on code by Richard Brunner */
--- ./arch/s390/mm/fault.c.printk	2004-08-14 14:56:26.000000000 +0400
+++ ./arch/s390/mm/fault.c	2004-09-06 13:00:46.355155496 +0400
@@ -61,17 +61,9 @@ void bust_spinlocks(int yes)
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
-		int loglevel_save = console_loglevel;
 		oops_in_progress = 0;
 		console_unblank();
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
-		console_loglevel = loglevel_save;
+		wake_up_klogd();
 	}
 }
 
--- ./kernel/printk.c.printk	2004-09-04 18:27:07.000000000 +0400
+++ ./kernel/printk.c	2004-09-06 12:52:28.847788112 +0400
@@ -614,6 +614,12 @@ int is_console_locked(void)
 }
 EXPORT_SYMBOL(is_console_locked);
 
+void wake_up_klogd(void)
+{
+	if (!oops_in_progress && waitqueue_active(&log_wait))
+		wake_up_interruptible(&log_wait);
+}
+
 /**
  * release_console_sem - unlock the console system
  *
@@ -649,8 +655,8 @@ void release_console_sem(void)
 	console_may_schedule = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
-	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
-		wake_up_interruptible(&log_wait);
+	if (wake_klogd)
+		wake_up_klogd();
 }
 EXPORT_SYMBOL(release_console_sem);
 
--- ./lib/bust_spinlocks.c.printk	2004-08-14 14:54:51.000000000 +0400
+++ ./lib/bust_spinlocks.c	2004-09-06 12:57:35.367190080 +0400
@@ -14,26 +14,15 @@
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
 
-
 void bust_spinlocks(int yes)
 {
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
-		int loglevel_save = console_loglevel;
 #ifdef CONFIG_VT
 		unblank_screen();
 #endif
 		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk() will give klogd
-		 * and the blanked console a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;		/* NMI oopser may have shut the console up */
-		printk(" ");
-		console_loglevel = loglevel_save;
+		wake_up_klogd();
 	}
 }
-
-

--------------050104080604070705040702--

