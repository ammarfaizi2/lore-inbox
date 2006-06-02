Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWFBTvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWFBTvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWFBTqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:13184 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751450AbWFBTqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:08 -0400
Message-Id: <20060602194741.722684000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:06 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/11] ohci1394, sbp2: fix "scsi_add_device failed" with PL-3507 based devices
Content-Disposition: inline; filename=ohci1394-sbp2-fix-scsi_add_device-failed-with-pl-3507-based-devices.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stefan Richter <stefanr@s5r6.in-berlin.de>

Re-enable posted writes for status FIFO.
Besides bringing back a very minor bandwidth tweak from Linux 2.6.15.x
and older, this also fixes an interoperability regression since 2.6.16:
http://bugzilla.kernel.org/show_bug.cgi?id=6356
(sbp2: scsi_add_device failed. IEEE1394 HD is not working anymore.)

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Tested-by: Vanei Heidemann <linux@javanei.com.br>
Tested-by: Martin Putzlocher <mputzi@gmx.de> (chip type unconfirmed)
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/ieee1394/ohci1394.c |    2 +-
 drivers/ieee1394/sbp2.c     |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.16.19.orig/drivers/ieee1394/ohci1394.c
+++ linux-2.6.16.19/drivers/ieee1394/ohci1394.c
@@ -2525,7 +2525,7 @@ static irqreturn_t ohci_irq_handler(int 
 			if (phys_dma) {
 				reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0xffffffff);
 				reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0xffffffff);
-				reg_write(ohci,OHCI1394_PhyUpperBound, 0xffff0000);
+				reg_write(ohci,OHCI1394_PhyUpperBound, 0x01000000);
 			} else {
 				reg_write(ohci,OHCI1394_PhyReqFilterHiSet, 0x00000000);
 				reg_write(ohci,OHCI1394_PhyReqFilterLoSet, 0x00000000);
--- linux-2.6.16.19.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.16.19/drivers/ieee1394/sbp2.c
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

--
