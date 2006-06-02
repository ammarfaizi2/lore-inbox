Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbWFBUTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbWFBUTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWFBUTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:19:36 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:35026 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964770AbWFBUTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:19:35 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:17:48 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 12/18] ohci1394: set address range properties
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
Message-ID: <tkrat.39c0a660f27b4e91@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
 <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
 <tkrat.5222feb4e2593ac0@s5r6.in-berlin.de>
 <tkrat.5fcbbb70f827a5c2@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.886) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supplies the API extension introduced by patch
"ieee1394: extend lowlevel API for address range properties"
with proper addresses.

Like in patch ''ohci1394, sbp2: fix "scsi_add_device failed"
with PL-3507 based devices'', 1 TeraByte is chosen as physical
upper bound.  This leaves a window for the middle address range.
This choice is only relevant for adapters which actually have a
programmable pysical upper bound register.  (Only ALi and
Fujitsu adapters are known for this.  Most adapters have a fixed
bound at 4 GB.)  The middle address range is suitable for posted
writes.

AFAICS, PCILynx does not support physical DMA nor posted writes,
at least as programmed under Linux.  Therefore no equivalent
change in the pcilynx driver is necessary.  There is also a an
out-of-tree driver for GP2Lynx.  I assume this hardware does not
support these OHCI features either.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/ohci1394.h	2006-06-01 20:55:04.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.h	2006-06-01 20:55:45.000000000 +0200
@@ -443,6 +443,16 @@ static inline u32 reg_read(const struct 
 
 #define OHCI1394_TCODE_PHY               0xE
 
+/* Node offset map (phys DMA area, posted write area).
+ * The value of OHCI1394_PHYS_UPPER_BOUND_PROGRAMMED may be modified but must
+ * be lower than OHCI1394_MIDDLE_ADDRESS_SPACE.
+ * OHCI1394_PHYS_UPPER_BOUND_FIXED and OHCI1394_MIDDLE_ADDRESS_SPACE are
+ * constants given by the OHCI spec.
+ */
+#define OHCI1394_PHYS_UPPER_BOUND_FIXED		0x000100000000ULL /* 4 GB */
+#define OHCI1394_PHYS_UPPER_BOUND_PROGRAMMED	0x010000000000ULL /* 1 TB */
+#define OHCI1394_MIDDLE_ADDRESS_SPACE		0xffff00000000ULL
+
 void ohci1394_init_iso_tasklet(struct ohci1394_iso_tasklet *tasklet,
 			       int type,
 			       void (*func)(unsigned long),
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/ohci1394.c	2006-06-01 20:55:41.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/ohci1394.c	2006-06-01 20:55:45.000000000 +0200
@@ -553,7 +553,8 @@ static void ohci_initialize(struct ti_oh
 	 * register content.
 	 * To actually enable physical responses is the job of our interrupt
 	 * handler which programs the physical request filter. */
-	reg_write(ohci, OHCI1394_PhyUpperBound, 0x01000000);
+	reg_write(ohci, OHCI1394_PhyUpperBound,
+		  OHCI1394_PHYS_UPPER_BOUND_PROGRAMMED >> 16);
 
 	DBGMSG("physUpperBoundOffset=%08x",
 	       reg_read(ohci, OHCI1394_PhyUpperBound));
@@ -3415,6 +3416,14 @@ static int __devinit ohci1394_pci_probe(
 	host->csr.max_rec = (reg_read(ohci, OHCI1394_BusOptions) >> 12) & 0xf;
 	host->csr.lnk_spd = reg_read(ohci, OHCI1394_BusOptions) & 0x7;
 
+	if (phys_dma) {
+		host->low_addr_space =
+			(u64) reg_read(ohci, OHCI1394_PhyUpperBound) << 16;
+		if (!host->low_addr_space)
+			host->low_addr_space = OHCI1394_PHYS_UPPER_BOUND_FIXED;
+	}
+	host->middle_addr_space = OHCI1394_MIDDLE_ADDRESS_SPACE;
+
 	/* Tell the highlevel this host is ready */
 	if (hpsb_add_host(host))
 		FAIL(-ENOMEM, "Failed to register host with highlevel");


