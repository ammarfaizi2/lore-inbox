Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUJWTnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUJWTnB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbUJWTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 15:43:00 -0400
Received: from mail4.worldserver.net ([217.13.200.24]:37768 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S261285AbUJWTml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 15:42:41 -0400
X-Speedbone-MailScanner-Mail-From: christian@leber.de via mail4.worldserver.net
X-Speedbone-MailScanner: 1.23st (Clear:RC:1(80.140.49.68):. Processed in 0.121201 secs Process 10923)
Date: Sat, 23 Oct 2004 21:42:39 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: [patch] trivial sysrq addon
Message-ID: <20041023194239.GA21432@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my box (2.6.9-final) was yesterday completly stalled (mouse movable and
stupid loadmeter was still working) after starting mutt and was swapping
for half an hour until I sent SIGTERM to all processes.
I suspect it was a 2 GB big galeon process that was the problem.

I think sysrq needs a key to call oom_kill manually.


Christian Leber

---

--- linux-2.6.10-rc1.orig/drivers/char/sysrq.c	2004-10-22 23:40:06.000000000 +0200
+++ linux-2.6.10-rc1/drivers/char/sysrq.c	2004-10-23 18:02:18.000000000 +0200
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 
 #include <asm/ptrace.h>
+extern void oom_kill(void);
 
 extern void reset_vc(unsigned int);
 
@@ -202,6 +203,18 @@
 	.action_msg	= "Terminate All Tasks",
 };
 
+static void sysrq_handle_moom(int key, struct pt_regs *pt_regs,
+			      struct tty_struct *tty) 
+{
+	oom_kill();
+//	console_loglevel = 8;
+}
+static struct sysrq_key_op sysrq_moom_op = {
+	.handler	= sysrq_handle_moom,
+	.help_msg	= "Full",
+	.action_msg	= "Manual OOM execution",
+};
+
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
 			      struct tty_struct *tty) 
 {
@@ -238,7 +251,7 @@
 /* c */ NULL,
 /* d */	NULL,
 /* e */	&sysrq_term_op,
-/* f */	NULL,
+/* f */	&sysrq_moom_op,
 /* g */	NULL,
 /* h */	NULL,
 /* i */	&sysrq_kill_op,
--- linux-2.6.10-rc1.orig/mm/oom_kill.c	2004-10-22 23:39:20.000000000 +0200
+++ linux-2.6.10-rc1/mm/oom_kill.c	2004-10-23 19:16:47.000000000 +0200
@@ -184,7 +184,7 @@
  * OR try to be smart about which process to kill. Note that we
  * don't have to be perfect here, we just have to be good.
  */
-static void oom_kill(void)
+void oom_kill(void)
 {
 	struct mm_struct *mm;
 	struct task_struct *g, *p, *q;
@@ -214,13 +214,6 @@
 		printk(KERN_INFO "Fixed up OOM kill of mm-less task\n");
 	read_unlock(&tasklist_lock);
 	mmput(mm);
-
-	/*
-	 * Make kswapd go out of the way, so "p" has a good chance of
-	 * killing itself before someone else gets the chance to ask
-	 * for more memory.
-	 */
-	yield();
 	return;
 }
 
@@ -284,6 +277,12 @@
 	/* oom_kill() sleeps */
 	spin_unlock(&oom_lock);
 	oom_kill();
+	/*
+	 * Make kswapd go out of the way, so "p" has a good chance of
+	 * killing itself before someone else gets the chance to ask
+	 * for more memory.
+	 */
+	yield();
 	spin_lock(&oom_lock);
 
 reset:
--- linux-2.6.10-rc1.orig/Documentation/sysrq.txt	2004-10-22 23:39:19.000000000 +0200
+++ linux-2.6.10-rc1/Documentation/sysrq.txt	2004-10-23 19:35:37.000000000 +0200
@@ -73,6 +73,8 @@
           it so that only emergency messages like PANICs or OOPSes would
           make it to your console.)
 
+'f'	- Will call oom_kill to kill a memory hog process
+
 'e'     - Send a SIGTERM to all processes, except for init.
 
 'i'     - Send a SIGKILL to all processes, except for init.


