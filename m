Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTJTXyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTJTXyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:54:24 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:49638 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S263056AbTJTXyU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:54:20 -0400
Date: Tue, 21 Oct 2003 01:53:55 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>, Michael Hunold <hunold@convergence.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Proposal to remove workqueue usage from request_firmware_async()
Message-ID: <20031020235355.GA3068@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 How does this look?

 Interested parties please test and comment.

 ChangeLog:
	
	 In it's current form request_firmware sleeps for too long on
	 the system's common workqueue, and using a private workqueue as
	 previously proposed is not optimal. This patch creates one
	 kernel_thread for each request_firmware_async() invocation
	 which dies once the job is done.


 firmware_class.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)


Index: drivers/base/firmware_class.c
===================================================================
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
 

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
