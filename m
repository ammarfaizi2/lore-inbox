Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965468AbWI0JkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965468AbWI0JkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965482AbWI0JkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:40:22 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:56532 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S965468AbWI0JkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:40:22 -0400
Subject: [PATCH] ioremap balanced with iounmap for drivers/sbus
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 15:13:36 +0530
Message-Id: <1159350216.25016.107.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only) with:
- Modifying arch/i386/Kconfig and other Makefiles to make sure that the
changed file is compiling ok.

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 vfc_dev.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/sbus/char/vfc_dev.c linux-2.6.18/drivers/sbus/char/vfc_dev.c
--- linux-2.6.18-orig/drivers/sbus/char/vfc_dev.c	2006-09-21 10:15:38.000000000 +0530
+++ linux-2.6.18/drivers/sbus/char/vfc_dev.c	2006-09-27 14:46:59.000000000 +0530
@@ -678,8 +678,14 @@ static int vfc_probe(void)
 		if (strcmp(sdev->prom_name, "vfc") == 0) {
 			vfc_dev_lst[instance]=(struct vfc_dev *)
 				kmalloc(sizeof(struct vfc_dev), GFP_KERNEL);
-			if (vfc_dev_lst[instance] == NULL)
+			if (vfc_dev_lst[instance] == NULL) {
+				int i;
+				for (i = 0; i < instance; i++) {
+					if (vfc_dev_lst[i]->regs)
+						sbus_iounmap(vfc_dev_lst[i]->regs, sizeof(struct vfc_regs));
+				}
 				return -ENOMEM;
+			}
 			ret = init_vfc_device(sdev,
 					      vfc_dev_lst[instance],
 					      instance);


