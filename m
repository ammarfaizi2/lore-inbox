Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263216AbVCKFl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbVCKFl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbVCKFjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:39:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:61145 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263190AbVCKFh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:37:28 -0500
Subject: [PATCH] don't call unblank at irq time
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 16:37:14 +1100
Message-Id: <1110519434.5810.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch removes the call to unblank() from printk, and avoids calling
unblank at irq() time _unless_ oops_in_progress is 1. I also export
oops_in_progress() so drivers who care like radeonfb can test it and
know what to do. I audited call sites of unblank_screen(),
console_unblank(), etc... and I _hope_ I got them all, the patch
includes a small patch to the s390 bust_spinlocks code that sets
oops_in_progress back to 0 _after_ unblanking for example.

I added a few might_sleep() to help us catch possible remaining callers.

I'll soon write a document explaining fbdev locking. The current
situation after this patch is that:

 - All callbacks have console_semaphore held (fbdev's are fully
serialised).

 - Everything is called in schedule'able context, except the cfb_*
rendering operations and cursor operations, with the special case of
unblank who can be called at any time when "oops_in_progress" is true. A
driver that needs to sleep in it's unblank implementation is welcome to
test that variable and use a fallback path (or just do nothing if it's
not simple).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/printk.c
===================================================================
--- linux-work.orig/kernel/printk.c	2005-03-10 11:37:34.000000000 +1100
+++ linux-work/kernel/printk.c	2005-03-11 14:51:42.000000000 +1100
@@ -54,7 +54,12 @@
 
 EXPORT_SYMBOL(console_printk);
 
+/*
+ * Low lever drivers may need that to know if they can schedule in
+ * their unblank() callback or not. So let's export it.
+ */
 int oops_in_progress;
+EXPORT_SYMBOL(oops_in_progress);
 
 /*
  * console_sem protects the console_drivers list, and also
@@ -744,12 +749,15 @@
 	struct console *c;
 
 	/*
-	 * Try to get the console semaphore. If someone else owns it
-	 * we have to return without unblanking because console_unblank
-	 * may be called in interrupt context.
+	 * console_unblank can no longer be called in interrupt context unless
+	 * oops_in_progress is set to 1..
 	 */
-	if (down_trylock(&console_sem) != 0)
-		return;
+	if (oops_in_progress) {
+		if (down_trylock(&console_sem) != 0)
+			return;
+	} else
+		acquire_console_sem();
+
 	console_locked = 1;
 	console_may_schedule = 0;
 	for (c = console_drivers; c != NULL; c = c->next)
Index: linux-work/arch/s390/mm/fault.c
===================================================================
--- linux-work.orig/arch/s390/mm/fault.c	2005-01-24 17:09:26.000000000 +1100
+++ linux-work/arch/s390/mm/fault.c	2005-03-11 14:46:21.000000000 +1100
@@ -62,8 +62,8 @@
 		oops_in_progress = 1;
 	} else {
 		int loglevel_save = console_loglevel;
-		oops_in_progress = 0;
 		console_unblank();
+		oops_in_progress = 0;
 		/*
 		 * OK, the message is on the console.  Now we call printk()
 		 * without oops_in_progress set so that printk will give klogd
Index: linux-work/drivers/char/vt.c
===================================================================
--- linux-work.orig/drivers/char/vt.c	2005-03-10 11:37:24.000000000 +1100
+++ linux-work/drivers/char/vt.c	2005-03-11 14:54:05.000000000 +1100
@@ -2220,9 +2220,6 @@
 	}
 	set_cursor(vc);
 
-	if (!oops_in_progress)
-		poke_blanked_console();
-
 quit:
 	clear_bit(0, &printing);
 }
@@ -2823,6 +2820,13 @@
 {
 	struct vc_data *vc;
 
+	/* This should now always be called from a "sane" (read: can schedule)
+	 * context for the sake of the low level drivers, except in the special
+	 * case of oops_in_progress
+	 */
+	if (!oops_in_progress)
+		might_sleep();
+
 	WARN_CONSOLE_UNLOCKED();
 
 	ignore_poke = 0;
@@ -2879,6 +2883,14 @@
 {
 	WARN_CONSOLE_UNLOCKED();
 
+	/* Add this so we quickly catch whoever might call us in a non
+	 * safe context. Nowadays, unblank_screen() isn't to be called in
+	 * atomic contexts and is allowed to schedule (with the special case
+	 * of oops_in_progress, but that isn't of any concern for this
+	 * function. --BenH.
+	 */
+	might_sleep();
+
 	/* This isn't perfectly race free, but a race here would be mostly harmless,
 	 * at worse, we'll do a spurrious blank and it's unlikely
 	 */


