Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVIZEn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVIZEn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 00:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVIZEn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 00:43:58 -0400
Received: from xenotime.net ([66.160.160.81]:31127 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932372AbVIZEn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 00:43:57 -0400
Date: Sun, 25 Sep 2005 21:43:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: cfriesen@nortel.com, sonny@burdell.org, dipankar@in.ibm.com,
       viro@ftp.linux.org.uk, rolandd@cisco.com, linux-kernel@vger.kernel.org,
       tytso@mit.edu, bharata@in.ibm.com, trond.myklebust@fys.uio.no
Subject: [PATCH/RFC] sysrq: updating console_loglevel
Message-Id: <20050925214354.722d139d.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0509221501490.20059@shark.he.net>
References: <4331CFAD.6020805@nortel.com>
	<52ll1qkrii.fsf@cisco.com>
	<20050922031136.GE7992@ftp.linux.org.uk>
	<43322AE6.1080408@nortel.com>
	<20050922041733.GF7992@ftp.linux.org.uk>
	<4332CAEA.1010509@nortel.com>
	<20050922182719.GA4729@in.ibm.com>
	<4332FFF5.5060207@nortel.com>
	<20050922191805.GB4729@in.ibm.com>
	<43332400.2070606@nortel.com>
	<20050922214435.GA31911@kevlar.burdell.org>
	<43332854.1070108@nortel.com>
	<Pine.LNX.4.58.0509221501490.20059@shark.he.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,
Here's a patch for you to try.  It creates a safe method for
sysrq handlers to modify console_loglevel, which I suspect is
why you were not seeing messages on the serial console.

Please report back on your testing.
Thanks.
---

From: Randy Dunlap <rdunlap@xenotime.net>

Some sysrq handlers modify the console_loglevel variable,
but when they do so, some of their own messages may be lost
(not logged, esp. on serial console).

This patch introduces a way for console_loglevel to be
modified safely by the sysrq handlers.  The new value is not
set until the sysrq handler complets and returns.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/char/sysrq.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -Naurp linux-2613-rc2/drivers/char/sysrq.c~fix_loglevel linux-2613-rc2/drivers/char/sysrq.c
--- linux-2613-rc2/drivers/char/sysrq.c~fix_loglevel	2005-07-09 13:55:01.000000000 -0700
+++ linux-2613-rc2/drivers/char/sysrq.c	2005-09-25 21:31:12.000000000 -0700
@@ -41,6 +41,7 @@
 
 /* Whether we react on sysrq keys or just ignore them */
 int sysrq_enabled = 1;
+static int next_log_level;
 
 /* Loglevel sysrq handler */
 static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
@@ -50,7 +51,7 @@ static void sysrq_handle_loglevel(int ke
 	i = key - '0';
 	console_loglevel = 7;
 	printk("Loglevel set to %d\n", i);
-	console_loglevel = i;
+	next_log_level = i;
 }	
 static struct sysrq_key_op sysrq_loglevel_op = {
 	.handler	= sysrq_handle_loglevel,
@@ -217,7 +218,7 @@ static void sysrq_handle_term(int key, s
 			      struct tty_struct *tty) 
 {
 	send_sig_all(SIGTERM);
-	console_loglevel = 8;
+	next_log_level = 8;
 }
 static struct sysrq_key_op sysrq_term_op = {
 	.handler	= sysrq_handle_term,
@@ -248,7 +249,7 @@ static void sysrq_handle_kill(int key, s
 			      struct tty_struct *tty) 
 {
 	send_sig_all(SIGKILL);
-	console_loglevel = 8;
+	next_log_level = 8;
 }
 static struct sysrq_key_op sysrq_kill_op = {
 	.handler	= sysrq_handle_kill,
@@ -371,12 +372,11 @@ void __sysrq_put_key_op (int key, struct
 void __handle_sysrq(int key, struct pt_regs *pt_regs, struct tty_struct *tty, int check_mask)
 {
 	struct sysrq_key_op *op_p;
-	int orig_log_level;
 	int i, j;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sysrq_key_table_lock, flags);
-	orig_log_level = console_loglevel;
+	next_log_level = console_loglevel;
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq : ");
 
@@ -387,8 +387,10 @@ void __handle_sysrq(int key, struct pt_r
 		if (!check_mask || sysrq_enabled == 1 ||
 		    (sysrq_enabled & op_p->enable_mask)) {
 			printk ("%s\n", op_p->action_msg);
-			console_loglevel = orig_log_level;
+			/* handlers may change console_loglevel,
+			 * but now they do this by setting <next_log_level> */
 			op_p->handler(key, pt_regs, tty);
+			console_loglevel = next_log_level;
 		}
 		else
 			printk("This sysrq operation is disabled.\n");
@@ -402,7 +404,7 @@ void __handle_sysrq(int key, struct pt_r
 				printk ("%s ", sysrq_key_table[i]->help_msg);
 		}
 		printk ("\n");
-		console_loglevel = orig_log_level;
+		console_loglevel = next_log_level;
 	}
 	spin_unlock_irqrestore(&sysrq_key_table_lock, flags);
 }
