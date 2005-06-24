Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263312AbVFXV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbVFXV3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbVFXV1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 17:27:35 -0400
Received: from smtp.wp.pl ([212.77.101.1]:40749 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S263290AbVFXVSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 17:18:03 -0400
From: "Stanislaw W. Gruszka" <stf_xl@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] request_firmware: avoid race conditions
Date: Fri, 24 Jun 2005 22:56:54 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200506242256.54652.stf_xl@wp.pl>
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=1) AS2=NO(0.565083) AS3=NO AS4=NO                          
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid race occurs when some process have open file descriptor for class 
device attributes and already firmware allocated memory are freed.
Don't allow negative loading timeout.

Signed-off-by: Stanislaw W. Gruszka <stf_xl@wp.pl>

diff -up linux-2.6.12/drivers/base/firmware_class.c{-orig,}
--- linux/drivers/base/firmware_class.c-orig	2005-06-23 12:12:04.000000000 +0200
+++ linux/drivers/base/firmware_class.c	2005-06-24 17:01:55.000000000 +0200
@@ -74,6 +74,8 @@ static ssize_t
 firmware_timeout_store(struct class *class, const char *buf, size_t count)
 {
 	loading_timeout = simple_strtol(buf, NULL, 10);
+	if (loading_timeout < 0)
+		loading_timeout = 0;
 	return count;
 }
 
@@ -138,6 +140,10 @@ firmware_loading_store(struct class_devi
 	switch (loading) {
 	case 1:
 		down(&fw_lock);
+		if (!fw_priv->fw) {
+			up(&fw_lock);
+			break;
+		}
 		vfree(fw_priv->fw->data);
 		fw_priv->fw->data = NULL;
 		fw_priv->fw->size = 0;
@@ -178,7 +184,7 @@ firmware_data_read(struct kobject *kobj,
 
 	down(&fw_lock);
 	fw = fw_priv->fw;
-	if (test_bit(FW_STATUS_DONE, &fw_priv->status)) {
+	if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
 		ret_count = -ENODEV;
 		goto out;
 	}
@@ -238,9 +244,10 @@ firmware_data_write(struct kobject *kobj
 
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
+
 	down(&fw_lock);
 	fw = fw_priv->fw;
-	if (test_bit(FW_STATUS_DONE, &fw_priv->status)) {
+	if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
 		retval = -ENODEV;
 		goto out;
 	}
@@ -418,7 +425,7 @@ request_firmware(const struct firmware *
 
 	fw_priv = class_get_devdata(class_dev);
 
-	if (loading_timeout) {
+	if (loading_timeout > 0) {
 		fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
 		add_timer(&fw_priv->timeout);
 	}
