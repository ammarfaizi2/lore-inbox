Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266364AbUFVEfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266364AbUFVEfe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 00:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266411AbUFVEfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 00:35:33 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:26587 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266364AbUFVEfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 00:35:25 -0400
To: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] Fix MSI-X setup
X-Message-Flag: Warning: May contain useful information
References: <52lligqqlc.fsf@topspin.com> <521xk8qlx1.fsf@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 21 Jun 2004 21:35:24 -0700
In-Reply-To: <521xk8qlx1.fsf@topspin.com> (Roland Dreier's message of "Mon,
 21 Jun 2004 21:03:22 -0700")
Message-ID: <52smcop5v7.fsf_-_@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 04:35:24.0596 (UTC) FILETIME=[55D5FF40:01C45812]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

msix_capability_init() puts the offset of the MSI-X capability into
pos, then uses pos as a loop index to clear the MSI-X vector table,
and then tries to use pos as the offset again, which results in
writing the MSI-X enable bit off into space.

This patch fixes that by adding a new loop index variable and using
that to clear the vector table.

 - Roland

Signed-off-by: Roland Dreier <roland@tospin.com>

Index: linux-2.6.7/drivers/pci/msi.c
===================================================================
--- linux-2.6.7.orig/drivers/pci/msi.c	2004-06-21 20:51:33.000000000 -0700
+++ linux-2.6.7/drivers/pci/msi.c	2004-06-21 21:30:05.000000000 -0700
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
 	writel(address.hi_address, base + PCI_MSIX_ENTRY_UPPER_ADDR_OFFSET);
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
