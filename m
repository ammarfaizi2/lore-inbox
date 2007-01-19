Return-Path: <linux-kernel-owner+w=401wt.eu-S965171AbXASPC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbXASPC7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbXASPC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:02:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:43526 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965171AbXASPC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:02:58 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GznUMksPvQbG9o1cloRYCKa3dH6tyjjjx+3sunm9V1WXsirLZoQ435wdMgI1n/jTyQciFSFUki03nmXd5Djz430oEeqoF8lAFIWXRs9KyFeJBMuLTsLCJt7S0WlQ5WQxQm+pu/WrF797x15h1xNBVms4DN9nlbV26SykAVb+sxg=
Message-ID: <7ac1e90c0701190702l1ff833f6y141de58d9c0fb084@mail.gmail.com>
Date: Fri, 19 Jan 2007 15:02:56 +0000
From: "Bahadir Balban" <bahadir.balban@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Enabling IO/MEM through pci bridge
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On some ARM platform with multiple pci bridges, I had to add the below
patch in order to enable transactions through the bridges to devices
behind. I'm sure there are other platforms with similar pci setup so
why wouldn't it work without it?

Thanks,
Bahadir

Enable bus transactions behind bridges.

From: Bahadir Balban <bahadir.balban@arm.com>

When transactions (MEM/IO) are enabled for a device, this patch ensures
also the same transactions are enabled for the bridge that they sit behind.
---

 drivers/pci/setup-bus.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8f7bcf5..a5c400e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -150,0 +151 @@ EXPORT_SYMBOL(pci_setup_cardbus);
+	int i;
@@ -158,0 +160 @@ pci_setup_bridge(struct pci_bus *bus)
+	int i;
@@ -224,0 +227,15 @@ pci_setup_bridge(struct pci_bus *bus)
+
+	for (i = 0; i < 3; i++) {
+		u16 csr;
+		if ((bus->resource[i]->flags & IORESOURCE_MEM) ||
+		    (bus->resource[i]->flags & IORESOURCE_PREFETCH)) {
+			pci_read_config_word(bridge, PCI_COMMAND, &csr);
+			csr |= (1 << 1) | (1 << 2);
+			pci_write_config_word(bridge, PCI_COMMAND, csr);
+		}
+		if (bus->resource[i]->flags & IORESOURCE_IO) {
+			pci_read_config_word(bridge, PCI_COMMAND, &csr);
+			csr |= (1 << 0) | (1 << 2);
+			pci_write_config_word(bridge, PCI_COMMAND, csr);
+		}
+	}
