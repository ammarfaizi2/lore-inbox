Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUFVRmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUFVRmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFVREn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:04:43 -0400
Received: from fmr12.intel.com ([134.134.136.15]:14487 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S265035AbUFVQWy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:22:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Fix MSI-X setup
Date: Tue, 22 Jun 2004 09:21:27 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024057E4FA4@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix MSI-X setup
Thread-Index: AcRYEleb9NDxzVu/R7SMC/d8qhAPrAAYZNzQ
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Roland Dreier" <roland@topspin.com>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <akpm@osdl.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 22 Jun 2004 16:21:28.0552 (UTC) FILETIME=[F8B8AE80:01C45874]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, June 21, 2004 Roland Dreier wrote: 

>msix_capability_init() puts the offset of the MSI-X capability into
>pos, then uses pos as a loop index to clear the MSI-X vector table,
>and then tries to use pos as the offset again, which results in
>writing the MSI-X enable bit off into space.
>
>This patch fixes that by adding a new loop index variable and using
>that to clear the vector table.

Thanks for detecting this bug and providing a fix with your patch below.

Thanks,
Long

Index: linux-2.6.7/drivers/pci/msi.c
===================================================================
--- linux-2.6.7.orig/drivers/pci/msi.c	2004-06-21 20:51:33.000000000
-0700
+++ linux-2.6.7/drivers/pci/msi.c	2004-06-21 21:30:05.000000000
-0700
@@ -569,7 +569,7 @@
 	struct msi_desc *entry;
 	struct msg_address address;
 	struct msg_data data;
-	int vector = 0, pos, dev_msi_cap;
+	int vector = 0, pos, dev_msi_cap, i;
 	u32 phys_addr, table_offset;
 	u32 control;
 	u8 bir;
@@ -629,12 +629,12 @@
 	writel(address.hi_address, base +
PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
 	writel(*(u32*)&data, base + PCI_MSIX_ENTRY_DATA_OFFSET);
 	/* Initialize all entries from 1 up to 0 */
-	for (pos = 1; pos < dev_msi_cap; pos++) {
-		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+	for (i = 1; i < dev_msi_cap; i++) {
+		writel(0, base + i * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_LOWER_ADDR_OFFSET);
-		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+		writel(0, base + i * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
-		writel(0, base + pos * PCI_MSIX_ENTRY_SIZE +
+		writel(0, base + i * PCI_MSIX_ENTRY_SIZE +
 			PCI_MSIX_ENTRY_DATA_OFFSET);
 	}
 	attach_msi_entry(entry, vector);

