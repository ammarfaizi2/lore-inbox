Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUBYBfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbUBYBfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:35:25 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:44750 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262358AbUBYBew convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:52 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <10776728882704@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <10776728892888@kroah.com>
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
	- use vfree to free vmalloc memory.
	- Make sure fw_setup_class_device sets *class_dev_p to NULL in all case
	  of error.
	- Fix error handling in firmware_class_init.

Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-02 20:42:03.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-02 21:43:17.000000000 +0100
@@ -119,7 +119,7 @@
 		complete(&fw_priv->completion);
 		break;
 	case 1:
-		kfree(fw_priv->fw->data);
+		vfree(fw_priv->fw->data);
 		fw_priv->fw->data = NULL;
 		fw_priv->fw->size = 0;
 		fw_priv->alloc_size = 0;
@@ -297,6 +297,7 @@
 	}
 	memset(fw_priv->fw, 0, sizeof (*fw_priv->fw));
 
+	*class_dev_p = class_dev;
 	goto out;
 
 error_remove_loading:
@@ -310,7 +311,6 @@
 	kfree(class_dev);
 	*class_dev_p = NULL;
 out:
-	*class_dev_p = class_dev;
 	return retval;
 }
 static void
@@ -489,6 +489,7 @@
 	error = class_register(&firmware_class);
 	if (error) {
 		printk(KERN_ERR "%s: class_register failed\n", __FUNCTION__);
+		return error;
 	}
 	error = class_create_file(&firmware_class, &class_attr_timeout);
 	if (error) {

