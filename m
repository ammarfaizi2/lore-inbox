Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWGHNDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWGHNDn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWGHNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:03:43 -0400
Received: from mail.gmx.de ([213.165.64.21]:58001 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964810AbWGHNDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:03:42 -0400
X-Authenticated: #2769515
Date: Sat, 8 Jul 2006 15:09:04 +0200
From: Martin Langer <martin-langer@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: bcm43xx-dev@lists.berlios.de
Subject: [RFC][PATCH 1/2] firmware version management: add firmware_version() 
Message-ID: <20060708130904.GA3819@tuba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Public-Key-URL: http://www.langerland.de/martin/martinlanger.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be good if a driver knows which firmware version will be 
written to the hardware. I'm talking about external firmware files 
claimed by request_firmware(). 

We know so many different firmware files for bcm43xx and it becomes 
more and more complicated without some firmware version management.

This patch can create the md5sum of a firmware file. Then it looks into 
a table to figure out which version number is assigned to the hashcode.
That table is placed in the driver code and an example for bcm43xx comes 
in my next mail. Any comments?


Signed-off-by: Martin Langer <martin-langer@gmx.de>


--- ../linux-2.6.18rc1/drivers/base/firmware_class.c	2006-07-07 13:41:01.000000000 +0200
+++ drivers/base/firmware_class.c	2006-07-07 14:39:15.000000000 +0200
@@ -16,6 +16,8 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/scatterlist.h>
+#include <linux/crypto.h>
 
 #include <linux/firmware.h>
 #include "base.h"
@@ -48,6 +50,32 @@
 	struct timer_list timeout;
 };
 
+u32 firmware_version(const struct firmware *fw, struct firmware_files *elmnt)
+{
+	struct scatterlist sg;
+	struct crypto_tfm *tfm;
+	char sig[16];
+
+	tfm = crypto_alloc_tfm("md5", 0);
+	if (tfm == NULL)
+		return 0;
+
+	sg_init_one(&sg, fw->data, fw->size);
+
+	crypto_digest_init(tfm);
+	crypto_digest_update(tfm, &sg, 1);
+	crypto_digest_final(tfm, sig);
+	crypto_free_tfm(tfm);
+
+	while (elmnt->version) {
+		if (memcmp(sig, elmnt->signature, sizeof(sig)) == 0)
+			return elmnt->version;
+		elmnt++;
+	}
+
+	return 0;
+}
+
 static void
 fw_load_abort(struct firmware_priv *fw_priv)
 {
@@ -605,6 +633,7 @@
 module_init(firmware_class_init);
 module_exit(firmware_class_exit);
 
+EXPORT_SYMBOL(firmware_version);
 EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
--- ../linux-2.6.18rc1/include/linux/firmware.h	2006-06-18 03:49:35.000000000 +0200
+++ include/linux/firmware.h	2006-07-08 13:36:36.000000000 +0200
@@ -10,7 +10,12 @@
 	size_t size;
 	u8 *data;
 };
+struct firmware_files {
+	u8 signature[16];
+	u32 version;
+};
 struct device;
+u32 firmware_version(const struct firmware *fw, struct firmware_files *elmnt);
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int request_firmware_nowait(
--- ../linux-2.6.18rc1/drivers/base/Kconfig	2006-07-07 13:41:01.000000000 +0200
+++ drivers/base/Kconfig	2006-07-07 14:34:23.000000000 +0200
@@ -21,6 +21,7 @@
 config FW_LOADER
 	tristate "Userspace firmware loading support"
 	select HOTPLUG
+	select CRYPTO_MD5
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
 	  require userspace firmware loading support, but a module built outside
