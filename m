Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWEWVWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWEWVWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWEWVWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:22:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60441 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751168AbWEWVWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:22:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b+BcaLnhVMGsKl7goIVssaG+OpGM46q/3T6A69wCcmAE3lrug8n6Rx3j6N3QdEv6RVSEQg5WphazovvSZLox02IPDM4i4wDGOU9fTWbsvveA7lrwIpWpNNLHV7n0OKih0sCWSkdotl9rngWMjz1EdnAtOIKyoEHlqWvRuBy5YqM=
Message-ID: <4a192fd60605231422i76361d3ag5ee650d012e8720c@mail.gmail.com>
Date: Tue, 23 May 2006 23:22:38 +0200
From: "Laura Garcia" <nevola@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_class: s/semaphores/mutexes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this patch converts semaphores to mutexes for Randy's firmware_class.

Signed-off-by: Laura Garcia Liebana <nevola@gmail.com>

diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c  2006-05-23 21:58:39.000000000 +0200
+++ b/drivers/base/firmware_class.c       2006-05-23 22:15:27.000000000 +0200
@@ -15,7 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>

 #include <linux/firmware.h>
 #include "base.h"
@@ -36,7 +36,7 @@

 /* fw_lock could be moved to 'struct firmware_priv' but since it is just
  * guarding for corner cases a global lock should be OK */
-static DECLARE_MUTEX(fw_lock);
+static DEFINE_MUTEX(fw_lock);

 struct firmware_priv {
        char fw_id[FIRMWARE_NAME_MAX];
@@ -142,9 +142,9 @@

        switch (loading) {
        case 1:
-               down(&fw_lock);
+               mutex_lock(&fw_lock);
                if (!fw_priv->fw) {
-                       up(&fw_lock);
+                       mutex_unlock(&fw_lock);
                        break;
                }
                vfree(fw_priv->fw->data);
@@ -152,7 +152,7 @@
                fw_priv->fw->size = 0;
                fw_priv->alloc_size = 0;
                set_bit(FW_STATUS_LOADING, &fw_priv->status);
-               up(&fw_lock);
+               mutex_unlock(&fw_lock);
                break;
        case 0:
                if (test_bit(FW_STATUS_LOADING, &fw_priv->status)) {
@@ -185,7 +185,7 @@
        struct firmware *fw;
        ssize_t ret_count = count;

-       down(&fw_lock);
+       mutex_lock(&fw_lock);
        fw = fw_priv->fw;
        if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
                ret_count = -ENODEV;
@@ -200,7 +200,7 @@

        memcpy(buffer, fw->data + offset, ret_count);
 out:
-       up(&fw_lock);
+       mutex_unlock(&fw_lock);
        return ret_count;
 }

@@ -253,7 +253,7 @@
        if (!capable(CAP_SYS_RAWIO))
                return -EPERM;

-       down(&fw_lock);
+       mutex_lock(&fw_lock);
        fw = fw_priv->fw;
        if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
                retval = -ENODEV;
@@ -268,7 +268,7 @@
        fw->size = max_t(size_t, offset + count, fw->size);
        retval = count;
 out:
-       up(&fw_lock);
+       mutex_unlock(&fw_lock);
        return retval;
 }

@@ -436,14 +436,14 @@
        } else
                wait_for_completion(&fw_priv->completion);

-       down(&fw_lock);
+       mutex_lock(&fw_lock);
        if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
                retval = -ENOENT;
                release_firmware(fw_priv->fw);
                *firmware_p = NULL;
        }
        fw_priv->fw = NULL;
-       up(&fw_lock);
+       mutex_unlock(&fw_lock);
        class_device_unregister(class_dev);
        goto out;
