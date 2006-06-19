Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWFSBJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWFSBJi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWFSBJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:09:38 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:17566 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932342AbWFSBJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:09:37 -0400
Date: Sun, 18 Jun 2006 21:09:34 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] Disable MSI by default on non-PCI-E chipset
Message-ID: <20060619010933.GG29950@myri.com>
References: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619010544.GA29950@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 6/8] Disable MSI by default on non-PCI-E chipset

Most PCI-E chipsets support MSI while several non-PCI-E don't.
Disable MSI when the associated root chipset is not a PCI-E one
and does not have the PCI_BUS_FLAGS_MSI flag.
On PCI-E chipset, MSI are enabled unless PCI_BUS_FLAGS_NO_MSI
is not set.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-06-17 23:07:43.000000000 -0400
+++ linux-mm/drivers/pci/msi.c	2006-06-17 23:11:00.000000000 -0400
@@ -921,11 +921,17 @@
 	while (pdev->bus && pdev->bus->self)
 		pdev = pdev->bus->self;
 
-	/* check its bus flags */
-	if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+	if (pci_find_capability(pdev, PCI_CAP_ID_EXP)) {
+		/* PCI Express bridge, enable MSI, except when blacklisted */
+		if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			return -1;
+		return 0;
+	} else {
+		/* non PCI Express, disable MSI, except when whitelisted */
+		if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_MSI)
+			return 0;
 		return -1;
-
-	return 0;
+	}
 }
 
 /**
