Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWDWMI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWDWMI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 08:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWDWMI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 08:08:58 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:62110 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751387AbWDWMI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 08:08:57 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Apr 2006 14:06:54 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc2] ohci1394, sbp2: fix "scsi_add_device failed" with
 PL-3507 based devices
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Message-ID: <tkrat.2c541162432ec304@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.866) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-enable posted writes for status FIFO.
Besides bringing back a very minor bandwidth tweak from Linux 2.6.15.x
and older, this also fixes an interoperability regression since 2.6.16:
http://bugzilla.kernel.org/show_bug.cgi?id=6356
(sbp2: scsi_add_device failed. IEEE1394 HD is not working anymore.)

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
The ugly hardwired PhyUpperBound which this patch (re-)introduces into
sbp2 will be eliminated by a subsequent patchset (which has already been
sent to linux1394-devel).

Index: linux-2.6.17-rc2/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.17-rc2.orig/drivers/ieee1394/ohci1394.c	2006-04-22 19:23:46.000000000 +0200
+++ linux-2.6.17-rc2/drivers/ieee1394/ohci1394.c	2006-04-22 19:24:49.000000000 +0200
@@ -553,7 +553,7 @@ static void ohci_initialize(struct ti_oh
 	 * register content.
 	 * To actually enable physical responses is the job of our interrupt
 	 * handler which programs the physical request filter. */
-	reg_write(ohci, OHCI1394_PhyUpperBound, 0xffff0000);
+	reg_write(ohci, OHCI1394_PhyUpperBound, 0x01000000);
 
 	DBGMSG("physUpperBoundOffset=%08x",
 	       reg_read(ohci, OHCI1394_PhyUpperBound));
Index: linux-2.6.17-rc2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc2.orig/drivers/ieee1394/sbp2.c	2006-04-22 19:23:46.000000000 +0200
+++ linux-2.6.17-rc2/drivers/ieee1394/sbp2.c	2006-04-22 19:24:50.000000000 +0200
@@ -765,11 +765,16 @@ static struct scsi_id_instance_data *sbp
 
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


