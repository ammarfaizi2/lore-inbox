Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWHAPYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWHAPYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWHAPYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:24:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21991 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751766AbWHAPYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:24:50 -0400
Subject: PATCH: There is no devfs, there has never been a devfs, we have
	always been at war with...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Aug 2006 16:44:03 +0100
Message-Id: <1154447043.15540.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl noted a couple of tty driver functions now are quite
misleadingly named with the death of devfs. A quick grep found another
case in the lp driver.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/vc_screen.c linux-2.6.18-rc2-mm1/drivers/char/vc_screen.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/vc_screen.c	2006-07-27 16:19:02.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/vc_screen.c	2006-07-31 16:09:58.000000000 +0100
@@ -474,14 +474,14 @@
 
 static struct class *vc_class;
 
-void vcs_make_devfs(struct tty_struct *tty)
+void vcs_make_sysfs(struct tty_struct *tty)
 {
 	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 1),
 			NULL, "vcs%u", tty->index + 1);
 	class_device_create(vc_class, NULL, MKDEV(VCS_MAJOR, tty->index + 129),
 			NULL, "vcsa%u", tty->index + 1);
 }
-void vcs_remove_devfs(struct tty_struct *tty)
+void vcs_remove_sysfs(struct tty_struct *tty)
 {
 	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 1));
 	class_device_destroy(vc_class, MKDEV(VCS_MAJOR, tty->index + 129));
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/vt.c linux-2.6.18-rc2-mm1/drivers/char/vt.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/vt.c	2006-07-27 16:19:02.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/vt.c	2006-07-31 16:09:21.000000000 +0100
@@ -128,8 +128,8 @@
 #define DEFAULT_BELL_PITCH	750
 #define DEFAULT_BELL_DURATION	(HZ/8)
 
-extern void vcs_make_devfs(struct tty_struct *tty);
-extern void vcs_remove_devfs(struct tty_struct *tty);
+extern void vcs_make_sysfs(struct tty_struct *tty);
+extern void vcs_remove_sysfs(struct tty_struct *tty);
 
 extern void console_map_init(void);
 #ifdef CONFIG_PROM_CONSOLE
@@ -2498,7 +2498,7 @@
 				tty->winsize.ws_col = vc_cons[currcons].d->vc_cols;
 			}
 			release_console_sem();
-			vcs_make_devfs(tty);
+			vcs_make_sysfs(tty);
 			return ret;
 		}
 	}
@@ -2511,7 +2511,7 @@
  * and taking a ref against the tty while we're in the process of forgetting
  * about it and cleaning things up.
  *
- * This is because vcs_remove_devfs() can sleep and will drop the BKL.
+ * This is because vcs_remove_sysfs() can sleep and will drop the BKL.
  */
 static void con_close(struct tty_struct *tty, struct file *filp)
 {
@@ -2524,7 +2524,7 @@
 			vc->vc_tty = NULL;
 		tty->driver_data = NULL;
 		release_console_sem();
-		vcs_remove_devfs(tty);
+		vcs_remove_sysfs(tty);
 		mutex_unlock(&tty_mutex);
 		/*
 		 * tty_mutex is released, but we still hold BKL, so there is
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/lp.c linux-2.6.18-rc2-mm1/drivers/char/lp.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/lp.c	2006-07-27 16:19:02.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/lp.c	2006-07-31 16:11:42.000000000 +0100
@@ -906,7 +906,7 @@
 	lp_class = class_create(THIS_MODULE, "printer");
 	if (IS_ERR(lp_class)) {
 		err = PTR_ERR(lp_class);
-		goto out_devfs;
+		goto out_reg;
 	}
 
 	if (parport_register_driver (&lp_driver)) {
@@ -927,7 +927,7 @@
 
 out_class:
 	class_destroy(lp_class);
-out_devfs:
+out_reg:
 	unregister_chrdev(LP_MAJOR, "lp");
 	return err;
 }

