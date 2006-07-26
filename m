Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWGZX7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWGZX7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 19:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbWGZX7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 19:59:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:35726 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751823AbWGZX7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 19:59:03 -0400
Date: Wed, 26 Jul 2006 16:59:02 -0700
From: Sukadev Bhattiprolu <sukadev@us.ibm.com>
To: ranty@debian.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: clg@fr.ibm.com, serue@us.ibm.com, haveblue@us.ibm.com, sukadev@us.ibm.com
Subject: [PATCH] kthread: drivers/base/firmware_class.c
Message-ID: <20060726235902.GB9645@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces kernel_thread() call in drivers/base/firmware_class.c
with kthread_create() since kernel_thread() is deprecated in drivers.

Signed-off-by: Sukadev Bhattiprolu (sukadev@us.ibm.com)
CC: Cedric Le Goater <clg@fr.ibm.com>
CC: Serge E. Hallyn <serue@us.ibm.com>
CC: Dave Hansen <haveblue@us.ibm.com>
CC: Manuel Estrada Sainz <ranty@debian.org>

 drivers/base/firmware_class.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.18-rc2/drivers/base/firmware_class.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/base/firmware_class.c	2006-07-20 17:41:56.000000000 -0700
+++ linux-2.6.18-rc2/drivers/base/firmware_class.c	2006-07-20 17:44:43.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
+#include <linux/kthread.h>
 
 #include <linux/firmware.h>
 #include "base.h"
@@ -511,7 +512,6 @@ request_firmware_work_func(void *arg)
 		WARN_ON(1);
 		return 0;
 	}
-	daemonize("%s/%s", "firmware", fw_work->name);
 	ret = _request_firmware(&fw, fw_work->name, fw_work->device,
 		fw_work->uevent);
 	if (ret < 0)
@@ -546,9 +546,9 @@ request_firmware_nowait(
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
+	struct task_struct *task;
 	struct firmware_work *fw_work = kmalloc(sizeof (struct firmware_work),
 						GFP_ATOMIC);
-	int ret;
 
 	if (!fw_work)
 		return -ENOMEM;
@@ -566,14 +566,14 @@ request_firmware_nowait(
 		.uevent = uevent,
 	};
 
-	ret = kernel_thread(request_firmware_work_func, fw_work,
-			    CLONE_FS | CLONE_FILES);
+	task = kthread_run(request_firmware_work_func, fw_work,
+			    "firmware/%s", name);
 
-	if (ret < 0) {
+	if (IS_ERR(task)) {
 		fw_work->cont(NULL, fw_work->context);
 		module_put(fw_work->module);
 		kfree(fw_work);
-		return ret;
+		return PTR_ERR(task);
 	}
 	return 0;
 }
