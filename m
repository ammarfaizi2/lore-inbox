Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVBIJm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVBIJm3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVBIJm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:42:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20637 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261776AbVBIJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:42:18 -0500
Date: Wed, 9 Feb 2005 10:42:18 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix partial sysrq setting
Message-ID: <20050209094216.GD27328@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

  Attached patch fixes a regression introduced by my patch allowing
separate enabling of magic-sysrq functions. The problem is that
originally it was always possible to use /proc/sysrq-trigger regardless
the value of /proc/sys/kernel/sysrq (which actually I didn't know ;)
and my original patch disallowed it. As I think the original behaviour
is more useful and has no security problems (only root can access
sysrq-trigger) the patch implementing the old behaviour is attached.
Please apply (it applies well also to 2.6.11-rc3-mm1).

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-sysrq-2.6.11-rc2.diff"

Allow again to use /proc/sysrq-trigger regardless the setting of
/proc/sys/kernel/sysrq.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.11-rc2-sysrq-enable/Documentation/sysrq.txt linux-2.6.11-rc2-sysrq-additional/Documentation/sysrq.txt
--- linux-2.6.11-rc2-sysrq-enable/Documentation/sysrq.txt	2005-02-01 14:54:39.000000000 +0100
+++ linux-2.6.11-rc2-sysrq-additional/Documentation/sysrq.txt	2005-02-01 15:27:15.000000000 +0100
@@ -33,6 +33,10 @@ in /proc/sys/kernel/sysrq:
 You can set the value in the file by the following command:
     echo "number" >/proc/sys/kernel/sysrq
 
+Note that the value of /proc/sys/kernel/sysrq influences only the invocation
+via a keyboard. Invocation of any operation via /proc/sysrq-trigger is always
+allowed.
+
 *  How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note - Some
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11-rc2-sysrq-enable/drivers/char/sysrq.c linux-2.6.11-rc2-sysrq-additional/drivers/char/sysrq.c
--- linux-2.6.11-rc2-sysrq-enable/drivers/char/sysrq.c	2005-02-01 14:54:40.000000000 +0100
+++ linux-2.6.11-rc2-sysrq-additional/drivers/char/sysrq.c	2005-02-01 15:22:40.000000000 +0100
@@ -333,7 +333,7 @@ void __sysrq_put_key_op (int key, struct
  * as they are inside of the lock
  */
 
-void __handle_sysrq(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+void __handle_sysrq(int key, struct pt_regs *pt_regs, struct tty_struct *tty, int check_mask)
 {
 	struct sysrq_key_op *op_p;
 	int orig_log_level;
@@ -347,7 +347,10 @@ void __handle_sysrq(int key, struct pt_r
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
-		if (sysrq_enabled == 1 || sysrq_enabled & op_p->enable_mask) {
+		/* Should we check for enabled operations (/proc/sysrq-trigger should not)
+		 * and is the invoked operation enabled? */
+		if (!check_mask || sysrq_enabled == 1 ||
+		    sysrq_enabled & op_p->enable_mask) {
 			printk ("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key, pt_regs, tty);
@@ -378,7 +381,7 @@ void handle_sysrq(int key, struct pt_reg
 {
 	if (!sysrq_enabled)
 		return;
-	__handle_sysrq(key, pt_regs, tty);
+	__handle_sysrq(key, pt_regs, tty, 1);
 }
 
 int __sysrq_swap_key_ops(int key, struct sysrq_key_op *insert_op_p,
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11-rc2-sysrq-enable/fs/proc/proc_misc.c linux-2.6.11-rc2-sysrq-additional/fs/proc/proc_misc.c
--- linux-2.6.11-rc2-sysrq-enable/fs/proc/proc_misc.c	2005-02-01 16:27:03.000000000 +0100
+++ linux-2.6.11-rc2-sysrq-additional/fs/proc/proc_misc.c	2005-02-01 16:25:44.000000000 +0100
@@ -524,7 +524,7 @@ static ssize_t write_sysrq_trigger(struc
 
 		if (get_user(c, buf))
 			return -EFAULT;
-		__handle_sysrq(c, NULL, NULL);
+		__handle_sysrq(c, NULL, NULL, 0);
 	}
 	return count;
 }
diff -rupX /home/jack/.kerndiffexclude linux-2.6.11-rc2-sysrq-enable/include/linux/sysrq.h linux-2.6.11-rc2-sysrq-additional/include/linux/sysrq.h
--- linux-2.6.11-rc2-sysrq-enable/include/linux/sysrq.h	2005-02-01 14:54:40.000000000 +0100
+++ linux-2.6.11-rc2-sysrq-additional/include/linux/sysrq.h	2005-02-01 15:30:22.000000000 +0100
@@ -42,7 +42,7 @@ struct sysrq_key_op {
  */
 
 void handle_sysrq(int, struct pt_regs *, struct tty_struct *);
-void __handle_sysrq(int, struct pt_regs *, struct tty_struct *);
+void __handle_sysrq(int, struct pt_regs *, struct tty_struct *, int check_mask);
 int register_sysrq_key(int, struct sysrq_key_op *);
 int unregister_sysrq_key(int, struct sysrq_key_op *);
 struct sysrq_key_op *__sysrq_get_key_op(int key);

--MAH+hnPXVZWQ5cD/--
