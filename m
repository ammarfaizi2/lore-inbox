Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUCPDEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 22:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUCPDCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 22:02:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:22703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262897AbUCPACZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:02:25 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951451334@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:06 -0800
Message-Id: <10793951462388@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.3, 2004/03/10 16:05:00-08:00, chrisw@osdl.org

[PATCH] class_simple clean up in lp

Error condition isn't caught on class_simple_create, and
parport_register_driver failure doesn't do proper cleanup.


 drivers/char/lp.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c	Mon Mar 15 15:30:05 2004
+++ b/drivers/char/lp.c	Mon Mar 15 15:30:05 2004
@@ -869,7 +869,7 @@
 
 int __init lp_init (void)
 {
-	int i;
+	int i, err = 0;
 
 	if (parport_nr[0] == LP_PARPORT_OFF)
 		return 0;
@@ -900,10 +900,15 @@
 
 	devfs_mk_dir("printers");
 	lp_class = class_simple_create(THIS_MODULE, "printer");
+	if (IS_ERR(lp_class)) {
+		err = PTR_ERR(lp_class);
+		goto out_devfs;
+	}
 
 	if (parport_register_driver (&lp_driver)) {
 		printk (KERN_ERR "lp: unable to register with parport\n");
-		return -EIO;
+		err = -EIO;
+		goto out_class;
 	}
 
 	if (!lp_count) {
@@ -915,6 +920,13 @@
 	}
 
 	return 0;
+
+out_class:
+	class_simple_destroy(lp_class);
+out_devfs:
+	devfs_remove("printers");
+	unregister_chrdev(LP_MAJOR, "lp");
+	return err;
 }
 
 static int __init lp_init_module (void)

