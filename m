Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWFUTz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWFUTz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFUTzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:55:38 -0400
Received: from mail.suse.de ([195.135.220.2]:35761 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030249AbWFUTuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:00 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Laura Garcia <nevola@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/22] [PATCH] firmware_class: s/semaphores/mutexes
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:45:59 -0700
Message-Id: <1150919214366-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11509192111668-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com> <11509192111668-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Garcia <nevola@gmail.com>

Hi, this patch converts semaphores to mutexes for Randy's firmware_class.

Signed-off-by: Laura Garcia Liebana <nevola@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/firmware_class.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 0c99ae6..5d6c011 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -15,7 +15,7 @@ #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #include <linux/firmware.h>
 #include "base.h"
@@ -36,7 +36,7 @@ static int loading_timeout = 10;	/* In s
 
 /* fw_lock could be moved to 'struct firmware_priv' but since it is just
  * guarding for corner cases a global lock should be OK */
-static DECLARE_MUTEX(fw_lock);
+static DEFINE_MUTEX(fw_lock);
 
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
@@ -142,9 +142,9 @@ firmware_loading_store(struct class_devi
 
 	switch (loading) {
 	case 1:
-		down(&fw_lock);
+		mutex_lock(&fw_lock);
 		if (!fw_priv->fw) {
-			up(&fw_lock);
+			mutex_unlock(&fw_lock);
 			break;
 		}
 		vfree(fw_priv->fw->data);
@@ -152,7 +152,7 @@ firmware_loading_store(struct class_devi
 		fw_priv->fw->size = 0;
 		fw_priv->alloc_size = 0;
 		set_bit(FW_STATUS_LOADING, &fw_priv->status);
-		up(&fw_lock);
+		mutex_unlock(&fw_lock);
 		break;
 	case 0:
 		if (test_bit(FW_STATUS_LOADING, &fw_priv->status)) {
@@ -185,7 +185,7 @@ firmware_data_read(struct kobject *kobj,
 	struct firmware *fw;
 	ssize_t ret_count = count;
 
-	down(&fw_lock);
+	mutex_lock(&fw_lock);
 	fw = fw_priv->fw;
 	if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
 		ret_count = -ENODEV;
@@ -200,7 +200,7 @@ firmware_data_read(struct kobject *kobj,
 
 	memcpy(buffer, fw->data + offset, ret_count);
 out:
-	up(&fw_lock);
+	mutex_unlock(&fw_lock);
 	return ret_count;
 }
 
@@ -253,7 +253,7 @@ firmware_data_write(struct kobject *kobj
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	down(&fw_lock);
+	mutex_lock(&fw_lock);
 	fw = fw_priv->fw;
 	if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
 		retval = -ENODEV;
@@ -268,7 +268,7 @@ firmware_data_write(struct kobject *kobj
 	fw->size = max_t(size_t, offset + count, fw->size);
 	retval = count;
 out:
-	up(&fw_lock);
+	mutex_unlock(&fw_lock);
 	return retval;
 }
 
@@ -436,14 +436,14 @@ _request_firmware(const struct firmware 
 	} else
 		wait_for_completion(&fw_priv->completion);
 
-	down(&fw_lock);
+	mutex_lock(&fw_lock);
 	if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
 		retval = -ENOENT;
 		release_firmware(fw_priv->fw);
 		*firmware_p = NULL;
 	}
 	fw_priv->fw = NULL;
-	up(&fw_lock);
+	mutex_unlock(&fw_lock);
 	class_device_unregister(class_dev);
 	goto out;
 
-- 
1.4.0

