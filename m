Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUCDD6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbUCDD6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:58:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:27567 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbUCDD6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:58:33 -0500
Date: Wed, 3 Mar 2004 19:58:32 -0800
From: Chris Wright <chrisw@osdl.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] class_simple clean up in lp
Message-ID: <20040303195832.T22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Error condition isn't caught on class_simple_create, and
parport_register_driver failure doesn't do proper cleanup.

===== drivers/char/lp.c 1.32 vs edited =====
--- 1.32/drivers/char/lp.c	Wed Mar  3 04:45:18 2004
+++ edited/drivers/char/lp.c	Wed Mar  3 19:32:56 2004
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

