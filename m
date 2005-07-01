Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVGAU5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVGAU5t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVGAU4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:56:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:50401 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262601AbVGAUti convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:38 -0400
Cc: ink@jurassic.park.msu.ru
Subject: [PATCH] PCI: handle subtractive decode pci-pci bridge better
In-Reply-To: <11202509111375@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:32 -0700
Message-Id: <11202509121295@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: handle subtractive decode pci-pci bridge better

With the number of PCI bus resources increased to 8, we can
handle the subtractive decode PCI-PCI bridge like a normal
bridge, taking into account standard PCI-PCI bridge windows
(resources 0-2). This helps to avoid problems with peer-to-peer DMA
behind such bridges, poor performance for MMIO ranges outside bridge
windows and prefetchable vs. non-prefetchable memory issues.

To reflect the fact that such bridges do forward all addresses to
the secondary bus (transparency), remaining bus resources 3-7 are
linked to resources 0-4 of the primary bus. These resources will be
used as fallback by resource management code if allocation from
standard bridge windows fails for some reason.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 90b54929b626c80056262d9d99b3f48522e404d0
tree d5cb91ff7bd0ac9ffeab5f7bf68235e8b35d050c
parent a03fa955576af50df80bec9127b46ef57e0877c0
author Ivan Kokshaysky <ink@jurassic.park.msu.ru> Tue, 07 Jun 2005 04:07:02 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:50 -0700

 drivers/pci/probe.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -239,9 +239,8 @@ void __devinit pci_read_bridge_bases(str
 
 	if (dev->transparent) {
 		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
-		return;
+		for(i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
+			child->resource[i] = child->parent->resource[i - 3];
 	}
 
 	for(i=0; i<3; i++)

