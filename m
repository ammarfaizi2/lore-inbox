Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVC1ULN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVC1ULN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVC1ULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:11:12 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:13255 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262057AbVC1UKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:10:39 -0500
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH libata-2.6] libata: flush COMRESET set and clear
References: <20050325231907.E1D11BADC@lns1032.lss.emc.com>
In-Reply-To: <20050325231907.E1D11BADC@lns1032.lss.emc.com>
Message-Id: <20050328201027.3A50529917@lns1032.lss.emc.com>
Date: Mon, 28 Mar 2005 15:10:27 -0500 (EST)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.28.11
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated patch to fix erroneous flush of COMRESET set and missing flush
of COMRESET clear.  Created a new routine scr_write_flush() to try to
prevent this in the future.  Also, this patch is based on libata-2.6
instead of the previous libata-dev-2.6 based patch.

Signed-off-by: Brett Russ <russb@emc.com>

Index: libata-2.6/drivers/scsi/libata-core.c
===================================================================
--- libata-2.6.orig/drivers/scsi/libata-core.c	2005-03-28 15:06:41.000000000 -0500
+++ libata-2.6/drivers/scsi/libata-core.c	2005-03-28 15:06:41.000000000 -0500
@@ -1253,11 +1253,11 @@
 	unsigned long timeout = jiffies + (HZ * 5);
 
 	if (ap->flags & ATA_FLAG_SATA_RESET) {
-		scr_write(ap, SCR_CONTROL, 0x301); /* issue phy wake/reset */
-		scr_read(ap, SCR_STATUS);	/* dummy read; flush */
+		/* issue phy wake/reset */
+		scr_write_flush(ap, SCR_CONTROL, 0x301);
 		udelay(400);			/* FIXME: a guess */
 	}
-	scr_write(ap, SCR_CONTROL, 0x300);	/* issue phy wake/clear reset */
+	scr_write_flush(ap, SCR_CONTROL, 0x300); /* phy wake/clear reset */
 
 	/* wait for phy to become ready, if necessary */
 	do {
Index: libata-2.6/include/linux/libata.h
===================================================================
--- libata-2.6.orig/include/linux/libata.h	2005-03-28 15:06:42.000000000 -0500
+++ libata-2.6/include/linux/libata.h	2005-03-28 15:06:42.000000000 -0500
@@ -584,6 +584,13 @@
 	ap->ops->scr_write(ap, reg, val);
 }
 
+static inline void scr_write_flush(struct ata_port *ap, unsigned int reg, 
+				   u32 val)
+{
+	ap->ops->scr_write(ap, reg, val);
+	(void) ap->ops->scr_read(ap, reg);
+}
+
 static inline unsigned int sata_dev_present(struct ata_port *ap)
 {
 	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;
