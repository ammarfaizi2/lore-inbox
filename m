Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUFXWhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUFXWhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUFXWfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:35:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:38326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265785AbUFXVrZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:25 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135683559@kroah.com>
Date: Thu, 24 Jun 2004 14:46:08 -0700
Message-Id: <10881135682230@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1823.1.7, 2004/06/22 16:57:06-07:00, roland@topspin.com

[PATCH] PCI: Fix MSI-X setup

msix_capability_init() puts the offset of the MSI-X capability into
pos, then uses pos as a loop index to clear the MSI-X vector table,
and then tries to use pos as the offset again, which results in
writing the MSI-X enable bit off into space.

This patch fixes that by adding a new loop index variable and using
that to clear the vector table.

Signed-off-by: Roland Dreier <roland@tospin.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/msi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	2004-06-24 13:50:17 -07:00
+++ b/drivers/pci/msi.c	2004-06-24 13:50:17 -07:00
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

