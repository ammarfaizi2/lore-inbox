Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbUBYBma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUBYBfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:35:50 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:45262 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262572AbUBYBew convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:52 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <1077672889471@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <10776728892832@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, jt@hpl.hp.com,
       Simon Kelley <simon@thekelleys.org.uk>
Content-Transfer-Encoding: 7BIT
From: Manuel Estrada Sainz <ranty@ranty.pantax.net>
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on patch and suggestions from Dmitry Torokhov

Changelog:
	- release 'struct firmware_priv' from class_dev->release.

Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-06 13:30:48.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-06 13:31:38.000000000 +0100
@@ -232,6 +232,9 @@
 static void
 fw_class_dev_release(struct class_device *class_dev)
 {
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	kfree(fw_priv);
 	kfree(class_dev);
 }
 
@@ -258,6 +261,8 @@
 	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
 						 GFP_KERNEL);
 
+	*class_dev_p = NULL;
+
 	if (!fw_priv || !class_dev) {
 		printk(KERN_ERR "%s: kmalloc failed\n", __FUNCTION__);
 		retval = -ENOMEM;
@@ -318,10 +323,11 @@
 	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 error_unreg_class_dev:
 	class_device_unregister(class_dev);
+	goto out;
+
 error_kfree:
 	kfree(fw_priv);
 	kfree(class_dev);
-	*class_dev_p = NULL;
 out:
 	return retval;
 }
@@ -374,7 +380,6 @@
 	wait_for_completion(&fw_priv->completion);
 
 	del_timer_sync(&fw_priv->timeout);
-	fw_remove_class_device(class_dev);
 
 	if (fw_priv->fw->size && !test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
 		*firmware = fw_priv->fw;
@@ -383,7 +388,7 @@
 		vfree(fw_priv->fw->data);
 		kfree(fw_priv->fw);
 	}
-	kfree(fw_priv);
+	fw_remove_class_device(class_dev);
 out:
 	return retval;
 }

