Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSCONQ4>; Fri, 15 Mar 2002 08:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292291AbSCONQh>; Fri, 15 Mar 2002 08:16:37 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:56332 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S292289AbSCONQT>; Fri, 15 Mar 2002 08:16:19 -0500
Date: Fri, 15 Mar 2002 13:16:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, davej@suse.de
Subject: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
Message-ID: <20020315131612.C24984@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Marcelo, Dave,

The following patch removes Alt-Sysrq-L and its associated hack to kill
of PID1, the init process.  This is a mis-feature.

If PID1 is killed, the kernel immediately enters an infinite loop in the
depths of do_exit() with interrupts disabled, completely locking the
machine.  Obviously you can only reach for the reset button or power
switch after this, leaving you with dirty filesystems.

This patch has appeared on LKML a couple of months ago.

--- orig/drivers/char/sysrq.c	Fri Mar 15 10:13:07 2002
+++ linux/drivers/char/sysrq.c	Mon Mar 11 11:44:18 2002
@@ -284,24 +284,20 @@
 
 /* signal sysrq helper function
  * Sends a signal to all user processes */
-static void send_sig_all(int sig, int even_init)
+static void send_sig_all(int sig)
 {
 	struct task_struct *p;
 
 	for_each_task(p) {
-		if (p->mm) { /* Not swapper nor kernel thread */
-			if (p->pid == 1 && even_init)
-				/* Ugly hack to kill init */
-				p->pid = 0x8000;
-			if (p->pid != 1)
-				force_sig(sig, p);
-		}
+		if (p->mm && p->pid != 1)
+			/* Not swapper, init nor kernel thread */
+			force_sig(sig, p);
 	}
 }
 
 static void sysrq_handle_term(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
-	send_sig_all(SIGTERM, 0);
+	send_sig_all(SIGTERM);
 	console_loglevel = 8;
 }
 static struct sysrq_key_op sysrq_term_op = {
@@ -312,7 +308,7 @@
 
 static void sysrq_handle_kill(int key, struct pt_regs *pt_regs,
 		struct kbd_struct *kbd, struct tty_struct *tty) {
-	send_sig_all(SIGKILL, 0);
+	send_sig_all(SIGKILL);
 	console_loglevel = 8;
 }
 static struct sysrq_key_op sysrq_kill_op = {
@@ -321,17 +317,6 @@
 	action_msg:	"Kill All Tasks",
 };
 
-static void sysrq_handle_killall(int key, struct pt_regs *pt_regs,
-		struct kbd_struct *kbd, struct tty_struct *tty) {
-	send_sig_all(SIGKILL, 1);
-	console_loglevel = 8;
-}
-static struct sysrq_key_op sysrq_killall_op = {
-	handler:	sysrq_handle_killall,
-	help_msg:	"killalL",
-	action_msg:	"Kill All Tasks (even init)",
-};
-
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
 
 
@@ -366,7 +351,7 @@
 #else
 /* k */	NULL,
 #endif
-/* l */	&sysrq_killall_op,
+/* l */	NULL,
 /* m */	&sysrq_showmem_op,
 /* n */	NULL,
 /* o */	NULL, /* This will often be registered

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
