Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWGGEdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWGGEdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWGGEdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:33:17 -0400
Received: from xenotime.net ([66.160.160.81]:12209 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750874AbWGGEdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:33:17 -0400
Date: Thu, 6 Jul 2006 21:36:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, akpm <akpm@osdl.org>,
       gregkh <greg@kroah.com>
Subject: [PATCH] PCIE: cleanup on probe error
Message-Id: <20060706213601.b3358503.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

If pcie_portdrv_probe() fails but it had already called
pci_enable_device(), then call pci_disable_device() when
returning error.

Is there some reason that this isn't being done?
or was it just missed?

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/pci/pcie/portdrv_pci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2618-rc1.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2618-rc1/drivers/pci/pcie/portdrv_pci.c
@@ -73,8 +73,10 @@ static int __devinit pcie_portdrv_probe 
 		"%s->Dev[%04x:%04x] has invalid IRQ. Check vendor BIOS\n", 
 		__FUNCTION__, dev->device, dev->vendor);
 	}
-	if (pcie_port_device_register(dev)) 
+	if (pcie_port_device_register(dev)) {
+		pci_disable_device(dev);
 		return -ENOMEM;
+	}
 
 	return 0;
 }


---
