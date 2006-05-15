Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965216AbWEOUMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965216AbWEOUMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWEOUM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:12:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47762 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965214AbWEOUM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:12:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 May 2006 22:09:46 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 4/4 resend] ohci1394, sbp2: fix "scsi_add_device failed" with
 PL-3507 based devices
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.621eda7433bd0a08@s5r6.in-berlin.de>
Message-ID: <tkrat.5d7ad5dbf48e0f08@s5r6.in-berlin.de>
References: <tkrat.7fdbc058e06f117a@s5r6.in-berlin.de>
 <tkrat.c18c8124a53a8d1d@s5r6.in-berlin.de>
 <tkrat.7e87b6d07dda409e@s5r6.in-berlin.de>
 <tkrat.621eda7433bd0a08@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.877) AWL,BAYES_50
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
The ugly hardwired PhyUpperBound which this patch (re-)introduces into
sbp2 will be eliminated by a subsequent patchset which has already been
sent to linux1394-devel.

First posted on 2006-04-23.

Index: linux-2.6.17-rc4/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/ohci1394.c	2006-05-15 21:27:04.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/ohci1394.c	2006-05-15 21:52:42.000000000 +0200
@@ -553,7 +553,7 @@ static void ohci_initialize(struct ti_oh
 	 * register content.
 	 * To actually enable physical responses is the job of our interrupt
 	 * handler which programs the physical request filter. */
-	reg_write(ohci, OHCI1394_PhyUpperBound, 0xffff0000);
+	reg_write(ohci, OHCI1394_PhyUpperBound, 0x01000000);
 
 	DBGMSG("physUpperBoundOffset=%08x",
 	       reg_read(ohci, OHCI1394_PhyUpperBound));
Index: linux-2.6.17-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/ieee1394/sbp2.c	2006-05-15 21:52:18.000000000 +0200
+++ linux-2.6.17-rc4/drivers/ieee1394/sbp2.c	2006-05-15 21:52:42.000000000 +0200
@@ -835,11 +835,16 @@ static struct scsi_id_instance_data *sbp
 
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


