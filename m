Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284775AbRLXM02>; Mon, 24 Dec 2001 07:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284793AbRLXM0S>; Mon, 24 Dec 2001 07:26:18 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:63237 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284775AbRLXM0M>; Mon, 24 Dec 2001 07:26:12 -0500
Date: Mon, 24 Dec 2001 12:26:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Total system lockup with Alt-SysRQ-L
Message-ID: <20011224122605.A2110@flint.arm.linux.org.uk>
In-Reply-To: <20011223175846.B27993@flint.arm.linux.org.uk> <E16IKwX-0002U3-00@the-village.bc.nu> <20011224083752.A1181@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011224083752.A1181@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Dec 24, 2001 at 08:37:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 08:37:52AM +0000, Russell King wrote:
> The problem was definitely in the exit_notify code, where it manipulated
> the task links indefinitely.  (I think it was cptr never becomes null,
> so the loop never terminates).
> 
> However, if we're saying that "pid1 must not die" then maybe we should get
> rid of the 'killall' sysrq option since it serves no useful purpose, and
> add a suitable panic in the do_exit path?

Ok, can someone explain *why* it is desirable to attempt to kill pid1
given that doing so will completely lockup the machine?  (should we
rename it to "Lockup" instead of "killalL"? 8)

We do have some tests in the do_exit() path to panic if/when init dies,
which rely on the init PID being '1'.  Unfortunately, these don't trigger
because of the following bogosity in drivers/char/sysrq.c:

                        if (p->pid == 1 && even_init)
                                /* Ugly hack to kill init */
                                p->pid = 0x8000;

So, I propose we get rid of this "ugly hack", and the alt-sysrq-l
option altogether - it would appear to serve no useful purpose.

Here is a patch that does just this.  It should apply to 2.4.17 and 2.5.1
kernels fine (generated on 2.5.1).

--- orig/drivers/char/sysrq.c	Wed Dec 12 11:37:40 2001
+++ linux/drivers/char/sysrq.c	Mon Dec 24 12:19:58 2001
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

