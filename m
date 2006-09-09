Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWIIQ1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWIIQ1d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 12:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWIIQ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 12:27:33 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:41292 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S964791AbWIIQ1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 12:27:32 -0400
Message-Id: <20060909162635.746696000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sat, 09 Sep 2006 09:26:35 -0700
From: dwalker@mvista.com
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
CC: James.Bottomley@steeleye.com
Subject: [PATCH -mm] scsi: compile error on module_refcount
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following compile error,

  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x8e1f9): In function `scsi_device_put':
drivers/scsi/scsi.c:887: undefined reference to `module_refcount'
make: *** [.tmp_vmlinux1] Error 1

There are only two users of module_refcount() outside of kernel/module.c
and the other one uses ifdef's similar to this.

---
 drivers/scsi/scsi.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.17/drivers/scsi/scsi.c
===================================================================
--- linux-2.6.17.orig/drivers/scsi/scsi.c
+++ linux-2.6.17/drivers/scsi/scsi.c
@@ -882,10 +882,12 @@ void scsi_device_put(struct scsi_device 
 {
 	struct module *module = sdev->host->hostt->module;
 
+#ifdef CONFIG_MODULE_UNLOAD
 	/* The module refcount will be zero if scsi_device_get()
 	 * was called from a module removal routine */
 	if (module && module_refcount(module) != 0)
 		module_put(module);
+#endif
 	put_device(&sdev->sdev_gendev);
 }
 EXPORT_SYMBOL(scsi_device_put);
--
