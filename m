Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbUBYBma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbUBYBgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:36:24 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:43214 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262359AbUBYBey convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:54 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <1077672889385@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <1077672889471@kroah.com>
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
	- Make an status bitmap instead of using independent boolean variables.
	  It will make things nicer later when new issues need to be tracked.
	
Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-06 14:29:01.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-06 21:29:09.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <asm/hardirq.h>
+#include <linux/bitops.h>
 
 #include <linux/firmware.h>
 #include "base.h"
@@ -21,6 +22,11 @@
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
 MODULE_LICENSE("GPL");
 
+enum {
+	FW_STATUS_LOADING,
+	FW_STATUS_ABORT,
+};
+
 static int loading_timeout = 10;	/* In seconds */
 
 struct firmware_priv {
@@ -28,8 +34,7 @@
 	struct completion completion;
 	struct bin_attribute attr_data;
 	struct firmware *fw;
-	int loading;
-	int abort;
+	unsigned long status;
 	int alloc_size;
 	struct timer_list timeout;
 };
@@ -37,7 +42,7 @@
 static inline void
 fw_load_abort(struct firmware_priv *fw_priv)
 {
-	fw_priv->abort = 1;
+	set_bit(FW_STATUS_ABORT, &fw_priv->status);
 	wmb();
 	complete(&fw_priv->completion);
 }
@@ -99,7 +104,8 @@
 firmware_loading_show(struct class_device *class_dev, char *buf)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	return sprintf(buf, "%d\n", fw_priv->loading);
+	int loading = test_bit(FW_STATUS_LOADING, &fw_priv->status);
+	return sprintf(buf, "%d\n", loading);
 }
 
 /**
@@ -116,26 +122,26 @@
 		       const char *buf, size_t count)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	int prev_loading = fw_priv->loading;
-
-	fw_priv->loading = simple_strtol(buf, NULL, 10);
+	int loading = simple_strtol(buf, NULL, 10);
 
-	switch (fw_priv->loading) {
+	switch (loading) {
 	case 1:
 		vfree(fw_priv->fw->data);
 		fw_priv->fw->data = NULL;
 		fw_priv->fw->size = 0;
 		fw_priv->alloc_size = 0;
+		set_bit(FW_STATUS_LOADING, &fw_priv->status);
 		break;
 	case 0:
-		if (prev_loading == 1) {
+		if (test_bit(FW_STATUS_LOADING, &fw_priv->status)) {
 			complete(&fw_priv->completion);
+			clear_bit(FW_STATUS_LOADING, &fw_priv->status);
 			break;
 		}
 		/* fallthrough */
 	default:
 		printk(KERN_ERR "%s: unexpected value (%d)\n", __FUNCTION__,
-		       fw_priv->loading);
+		       loading);
 		/* fallthrough */
 	case -1:
 		fw_load_abort(fw_priv);
@@ -370,7 +376,7 @@
 	del_timer_sync(&fw_priv->timeout);
 	fw_remove_class_device(class_dev);
 
-	if (fw_priv->fw->size && !fw_priv->abort) {
+	if (fw_priv->fw->size && !test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
 		*firmware = fw_priv->fw;
 	} else {
 		retval = -ENOENT;

