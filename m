Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265160AbUETPvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265160AbUETPvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 11:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUETPvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 11:51:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39625 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265160AbUETPvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 11:51:40 -0400
Date: Thu, 20 May 2004 17:53:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: overlaping printk
Message-ID: <20040520155323.GA4750@elte.hu>
References: <1XBEP-Mc-49@gated-at.bofh.it> <1XBXw-13D-3@gated-at.bofh.it> <1XWpp-zy-9@gated-at.bofh.it> <m3lljnnoa0.fsf@averell.firstfloor.org> <20040520151939.GA3562@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20040520151939.GA3562@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> another solution would be to break the lock only once during the
> kernel's lifetime. The system is messed up anyway if it needs multiple
> lock breaks to get an oops out to the console. We dont care about
> followup oopses - the first oops is that matters.

i.e. something like the attached patch, against BK-curr. (i've also
attached a cleanup patch that gets rid of the many instances of
bust_spinlocks() - we now have a generic one in lib/bust_spinlocks.c)

i consider any secondary lockup after the first oops has been printed a
feature - sometimes the first oops gets washed away by the many followup
oopses.

i've tested the patch with parallel SMP oopses - they seem to be
serialized now. (but it's hard to time the oopses right.)

	Ingo

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bust-spinlocks-fix-2.6.6-A0"

--- linux/kernel/printk.c.orig	
+++ linux/kernel/printk.c	
@@ -55,6 +55,9 @@ EXPORT_SYMBOL(console_printk);
 
 int oops_in_progress;
 
+/* zap spinlocks only once: */
+unsigned long zap_spinlocks = 1;
+
 /*
  * console_sem protects the console_drivers list, and also
  * provides serialisation for access to the entire console
@@ -493,7 +496,7 @@ asmlinkage int printk(const char *fmt, .
 	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (oops_in_progress) {
+	if (oops_in_progress && test_and_clear_bit(0, &zap_spinlocks)) {
 		/* If a crash is occurring, make sure we can't deadlock */
 		spin_lock_init(&logbuf_lock);
 		/* And make sure that we print immediately */

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bust-spinlocks-cleanup-2.6.6-A0"

--- linux/arch/i386/mm/fault.c.orig	
+++ linux/arch/i386/mm/fault.c	
@@ -31,32 +31,6 @@
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
--- linux/arch/ia64/kernel/traps.c.orig	
+++ linux/arch/ia64/kernel/traps.c	
@@ -58,34 +58,6 @@ trap_init (void)
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
--- linux/arch/x86_64/mm/fault.c.orig	
+++ linux/arch/x86_64/mm/fault.c	
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
--- linux/arch/s390/mm/fault.c.orig	
+++ linux/arch/s390/mm/fault.c	
@@ -49,32 +49,6 @@ extern int sysctl_userprocess_debug;
 
 extern void die(const char *,struct pt_regs *,long);
 
-extern spinlock_t timerlist_lock;
-
-/*
- * Unlock any spinlocks which will prevent us from getting the
- * message out (timerlist_lock is acquired through the
- * console unblank code)
- */
-void bust_spinlocks(int yes)
-{
-	if (yes) {
-		oops_in_progress = 1;
-	} else {
-		int loglevel_save = console_loglevel;
-		oops_in_progress = 0;
-		console_unblank();
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
-}
-
 /*
  * Check which address space is addressed by the access
  * register in S390_lowcore.exc_access_id.
--- linux/lib/bust_spinlocks.c.orig	
+++ linux/lib/bust_spinlocks.c	
@@ -17,23 +17,24 @@
 
 void bust_spinlocks(int yes)
 {
+	int loglevel_save = console_loglevel;
+
 	if (yes) {
 		oops_in_progress = 1;
-	} else {
-		int loglevel_save = console_loglevel;
+		return;
+	}
 #ifdef CONFIG_VT
-		unblank_screen();
+	unblank_screen();
 #endif
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk() will give klogd
-		 * and the blanked console a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;		/* NMI oopser may have shut the console up */
-		printk(" ");
-		console_loglevel = loglevel_save;
-	}
+	oops_in_progress = 0;
+	/*
+	 * OK, the message is on the console.  Now we call printk()
+	 * without oops_in_progress set so that printk() will give klogd
+	 * and the blanked console a poke.  Hold onto your hats...
+	 */
+	console_loglevel = 15;	/* NMI oopser may have shut the console up */
+	printk(" ");
+	console_loglevel = loglevel_save;
 }
 
 

--Dxnq1zWXvFF0Q93v--
