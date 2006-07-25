Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWGYQ5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWGYQ5e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWGYQ53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:29 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:2197 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932470AbWGYQ5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:57:00 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 7] [x86-64] Calgary IOMMU: fix reference counting of
	Calgary PCI devices
X-Mercurial-Node: a42c3826807abbeacc40649127afb5103aabdbd4
Message-Id: <a42c3826807abbeacc40.1153846595@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:35 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 6 insertions(+), 4 deletions(-)
arch/x86_64/kernel/pci-calgary.c |   10 ++++++----


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153737943 -10800
# Node ID a42c3826807abbeacc40649127afb5103aabdbd4
# Parent  7b1cdbc92f2c618cb59feaf472c8b76df875743d
[x86-64] Calgary IOMMU: fix reference counting of Calgary PCI devices

The pci_get_device() API decrements the reference count on the 'from'
parameter when it continues searching. Therefore, take a ref count on
Calgary bus when we initialize them in either translated or
non-translated mode.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 7b1cdbc92f2c -r a42c3826807a arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:36:48 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:45:43 2006 +0300
@@ -786,6 +786,7 @@ static inline unsigned int __init locate
 
 static int __init calgary_init_one_nontraslated(struct pci_dev *dev)
 {
+	pci_dev_get(dev);
 	dev->sysdata = NULL;
 	dev->bus->self = dev;
 
@@ -810,6 +811,7 @@ static int __init calgary_init_one(struc
 	if (ret)
 		goto iounmap;
 
+	pci_dev_get(dev);
 	dev->bus->self = dev;
 	calgary_enable_translation(dev);
 
@@ -836,10 +838,9 @@ static int __init calgary_init(void)
 			calgary_init_one_nontraslated(dev);
 			continue;
 		}
-		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots) {
-			pci_dev_put(dev);
+		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots)
 			continue;
-		}
+
 		ret = calgary_init_one(dev);
 		if (ret)
 			goto error;
@@ -860,9 +861,10 @@ error:
 		}
 		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots)
 			continue;
+
 		calgary_disable_translation(dev);
 		calgary_free_bus(dev);
-		pci_dev_put(dev);
+		pci_dev_put(dev); /* Undo calgary_init_one()'s pci_dev_get() */
 	}
 
 	return ret;
