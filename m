Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWE0MMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWE0MMP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWE0MMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:12:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:24211 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751485AbWE0MMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:12:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 27 May 2006 14:11:18 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.16.18] ohci1394, sbp2: fix "scsi_add_device failed" with
 PL-3507 based devices
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.5fe8e80b997f7413@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.879) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable posted writes for status FIFO.
Besides bringing back a very minor bandwidth tweak from Linux 2.6.15.x
and older, this also fixes an interoperability regression since 2.6.16:
http://bugzilla.kernel.org/show_bug.cgi?id=6356
(sbp2: scsi_add_device failed. IEEE1394 HD is not working anymore.)

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Tested-by: Vanei Heidemann <linux@javanei.com.br>
Tested-by: Martin Putzlocher <mputzi@gmx.de> (chip type unconfirmed)
---
rediff for -stable, from commit a54c9d30dbb06391ec4422aaf0e1dc2c8c53bd3e

Index: linux-2.6.16.18/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.16.18.orig/drivers/ieee1394/ohci1394.c	2006-05-27 13:23:25.000000000 +0200
+++ linux-2.6.16.18/drivers/ieee1394/ohci1394.c	2006-05-27 13:23:50.000000000 +0200
@@ -2525,7 +2525,7 @@ static irqreturn_t ohci_irq_handler(int 
 			if (phys_dma) {
 				reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0xffffffff);
 				reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0xffffffff);
-				reg_write(ohci,OHCI1394_PhyUpperBound, 0xffff0000);
+				reg_write(ohci,OHCI1394_PhyUpperBound, 0x01000000);
 			} else {
 				reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0x00000000);
 				reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0x00000000);
Index: linux-2.6.16.18/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.16.18.orig/drivers/ieee1394/sbp2.c	2006-05-27 13:23:25.000000000 +0200
+++ linux-2.6.16.18/drivers/ieee1394/sbp2.c	2006-05-27 13:23:50.000000000 +0200
@@ -754,11 +754,16 @@ static struct scsi_id_instance_data *sbp
 
 	/* Register the status FIFO address range. We could use the same FIFO
 	 * for targets at different nodes. However we need different FIFOs per
-	 * target in order to support multi-unit devices. */
+	 * target in order to support multi-unit devices.
+	 * The FIFO is located out of the local host controller's physical range
+	 * but, if possible, within the posted write area. Status writes will
+	 * then be performed as unified transactions. This slightly reduces
+	 * bandwidth usage, and some Prolific based devices seem to require it.
+	 */
 	scsi_id->status_fifo_addr = hpsb_allocate_and_register_addrspace(
 			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
 			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
-			~0ULL, ~0ULL);
+			0x010000000000ULL, CSR1212_ALL_SPACE_END);
 	if (!scsi_id->status_fifo_addr) {
 		SBP2_ERR("failed to allocate status FIFO address range");
 		goto failed_alloc;


