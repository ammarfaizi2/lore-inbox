Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUILLit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUILLit (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUILLeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:34:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:10493 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268688AbUILL32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:29:28 -0400
Date: Sun, 12 Sep 2004 13:29:05 +0200 (MEST)
Message-Id: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: alan@lxorguk.ukuu.org.uk, drivers@neukum.org, marcelo.tosatti@cyclades.com,
       sailer@ife.ee.ethz.ch, zaitcev@redhat.com
Subject: [PATCH][2.4.28-pre3] USB drivers gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's USB drivers. The audio.c and uss720.c changes are backports
from the 2.6 kernel. The hpusbscsi.c and microtek.c changes are new,
since the 2.6 code is different.

/Mikael

--- linux-2.4.28-pre3/drivers/usb/audio.c.~1~	2004-08-08 10:56:31.000000000 +0200
+++ linux-2.4.28-pre3/drivers/usb/audio.c	2004-09-12 01:56:20.000000000 +0200
@@ -609,7 +609,7 @@
 			pgrem = rem;
 		memcpy((db->sgbuf[db->wrptr >> PAGE_SHIFT]) + (db->wrptr & (PAGE_SIZE-1)), buffer, pgrem);
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		db->wrptr += pgrem;
 		if (db->wrptr >= db->dmasize)
 			db->wrptr = 0;
@@ -632,7 +632,7 @@
 			pgrem = rem;
 		memcpy(buffer, (db->sgbuf[db->rdptr >> PAGE_SHIFT]) + (db->rdptr & (PAGE_SIZE-1)), pgrem);
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		db->rdptr += pgrem;
 		if (db->rdptr >= db->dmasize)
 			db->rdptr = 0;
@@ -657,7 +657,7 @@
 		if (copy_from_user((db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & (PAGE_SIZE-1)), buffer, pgrem))
 			return -EFAULT;
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		ptr += pgrem;
 		if (ptr >= db->dmasize)
 			ptr = 0;
@@ -682,7 +682,7 @@
 		if (copy_to_user(buffer, (db->sgbuf[ptr >> PAGE_SHIFT]) + (ptr & (PAGE_SIZE-1)), pgrem))
 			return -EFAULT;
 		size -= pgrem;
-		(char *)buffer += pgrem;
+		buffer += pgrem;
 		ptr += pgrem;
 		if (ptr >= db->dmasize)
 			ptr = 0;
--- linux-2.4.28-pre3/drivers/usb/hpusbscsi.c.~1~	2003-06-14 13:30:26.000000000 +0200
+++ linux-2.4.28-pre3/drivers/usb/hpusbscsi.c	2004-09-12 01:56:20.000000000 +0200
@@ -182,7 +182,7 @@
 
 	memcpy (&(new->ctempl), &hpusbscsi_scsi_host_template,
 		sizeof (hpusbscsi_scsi_host_template));
-	(struct hpusbscsi *) new->ctempl.proc_dir = new;
+	new->ctempl.proc_dir = (void *) new;
 	new->ctempl.module = THIS_MODULE;
 
 	if (scsi_register_module (MODULE_SCSI_HA, &(new->ctempl)))
--- linux-2.4.28-pre3/drivers/usb/microtek.c.~1~	2002-11-30 17:12:27.000000000 +0100
+++ linux-2.4.28-pre3/drivers/usb/microtek.c	2004-09-12 01:56:20.000000000 +0200
@@ -987,7 +987,7 @@
 	/* Initialize the host template based on the default one */
 	memcpy(&(new_desc->ctempl), &mts_scsi_host_template, sizeof(mts_scsi_host_template));
 	/* HACK from usb-storage - this is needed for scsi detection */
-	(struct mts_desc *)new_desc->ctempl.proc_dir = new_desc; /* FIXME */
+	new_desc->ctempl.proc_dir = (void *)new_desc; /* FIXME */
 
 	MTS_DEBUG("registering SCSI module\n");
 
--- linux-2.4.28-pre3/drivers/usb/uss720.c.~1~	2001-10-24 11:59:14.000000000 +0200
+++ linux-2.4.28-pre3/drivers/usb/uss720.c	2004-09-12 01:56:20.000000000 +0200
@@ -333,7 +333,7 @@
 	for (; got < length; got++) {
 		if (get_1284_register(pp, 4, (char *)buf))
 			break;
-		((char*)buf)++;
+		buf++;
 		if (priv->reg[0] & 0x01) {
 			clear_epp_timeout(pp);
 			break;
@@ -392,7 +392,7 @@
 	for (; got < length; got++) {
 		if (get_1284_register(pp, 3, (char *)buf))
 			break;
-		((char*)buf)++;
+		buf++;
 		if (priv->reg[0] & 0x01) {
 			clear_epp_timeout(pp);
 			break;
@@ -412,7 +412,7 @@
 	for (; written < length; written++) {
 		if (set_1284_register(pp, 3, *(char *)buf))
 			break;
-		((char*)buf)++;
+		buf++;
 		if (get_1284_register(pp, 1, NULL))
 			break;
 		if (priv->reg[0] & 0x01) {
@@ -469,7 +469,7 @@
 	for (; written < len; written++) {
 		if (set_1284_register(pp, 5, *(char *)buffer))
 			break;
-		((char*)buffer)++;
+		buffer++;
 	}
 	change_mode(pp, ECR_PS2);
 	return written;
