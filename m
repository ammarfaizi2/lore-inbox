Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUIAQuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUIAQuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUIAP4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:56:55 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:60850 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267341AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:21 +0100
Message-Id: <200409011551.i81FpLJO000620@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] More PNP leaks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/pnp/pnpbios/proc.c linux-2.6/drivers/pnp/pnpbios/proc.c
--- bk-linus/drivers/pnp/pnpbios/proc.c	2004-06-04 12:08:32.000000000 +0100
+++ linux-2.6/drivers/pnp/pnpbios/proc.c	2004-06-07 11:07:05.000000000 +0100
@@ -90,8 +90,10 @@ static int proc_read_escd(char *buf, cha
 	tmpbuf = pnpbios_kmalloc(escd.escd_size, GFP_KERNEL);
 	if (!tmpbuf) return -ENOMEM;
 
-	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base))
+	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base)) {
+		kfree(tmpbuf);
 		return -EIO;
+	}
 
 	escd_size = (unsigned char)(tmpbuf[0]) + (unsigned char)(tmpbuf[1])*256;
 
@@ -168,8 +170,10 @@ static int proc_read_node(char *buf, cha
 
 	node = pnpbios_kmalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
-	if (pnp_bios_get_dev_node(&nodenum, boot, node))
+	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
+		kfree(node);
 		return -EIO;
+	}
 	len = node->size - sizeof(struct pnp_bios_node);
 	memcpy(buf, node->data, len);
 	kfree(node);
