Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTLSMeB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTLSMcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:32:07 -0500
Received: from mail.convergence.de ([212.84.236.4]:32698 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262888AbTLSM2r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:47 -0500
Subject: [PATCH 11/12] Firmware_class update
In-Reply-To: <10718369253490@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:45 +0100
Message-Id: <1071836925779@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- use a kernel thread instead of schedule_work() when waiting for the firmware upload to happen
--- linux-2.5/drivers/base/firmware_class.c	(revision 14117)
+++ linux-2.5/drivers/base/firmware_class.c	(working copy)
@@ -415,18 +415,22 @@
 	void (*cont)(const struct firmware *fw, void *context);
 };
 
-static void
+static int
 request_firmware_work_func(void *arg)
 {
 	struct firmware_work *fw_work = arg;
 	const struct firmware *fw;
-	if (!arg)
-		return;
+	if (!arg) {
+		WARN_ON(1);
+		return 0;
+	}
+	daemonize("%s/%s", "firmware", fw_work->name);
 	request_firmware(&fw, fw_work->name, fw_work->device);
 	fw_work->cont(fw, fw_work->context);
 	release_firmware(fw);
 	module_put(fw_work->module);
 	kfree(fw_work);
+	return 0;
 }
 
 /**
@@ -451,6 +455,8 @@
 {
 	struct firmware_work *fw_work = kmalloc(sizeof (struct firmware_work),
 						GFP_ATOMIC);
+	int ret;
+
 	if (!fw_work)
 		return -ENOMEM;
 	if (!try_module_get(module)) {
@@ -465,9 +471,14 @@
 		.context = context,
 		.cont = cont,
 	};
-	INIT_WORK(&fw_work->work, request_firmware_work_func, fw_work);
 
-	schedule_work(&fw_work->work);
+	ret = kernel_thread(request_firmware_work_func, fw_work,
+			    CLONE_FS | CLONE_FILES);
+	
+	if (ret < 0) {
+		fw_work->cont(NULL, fw_work->context);
+		return ret;
+	}
 	return 0;
 }
 

