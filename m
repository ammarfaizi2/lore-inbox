Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVEWM7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVEWM7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVEWM7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:22958 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261451AbVEWM6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:58:54 -0400
Date: Mon, 23 May 2005 14:58:48 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Subject: [PATCH] bug in VIA PCI IRQ routing
Message-ID: <20050523125848.GA15227@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

during certification of some systems with VIA 82C586_0 chipset
we found that the PCI IRQ routing of PIRQD line goes wrong and the system
will get stuck because of unacknowledged IRQs.
It seems that the special case for PIRQD (pirq 4) is not needed for all
VIA versions. With this patch, the IRQ routing on these systems works
again (It did work with older 2.4 kernel versions prior the PIRQD change)

diff -urN linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c linux-2.6.12-rc4-git7/arch/i386/pci/irq.c
--- linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c	2005-05-23 13:35:48.562759583 +0200
+++ linux-2.6.12-rc4-git7/arch/i386/pci/irq.c	2005-05-23 13:41:47.349473060 +0200
@@ -26,6 +26,7 @@
 
 static int broken_hp_bios_irq9;
 static int acer_tm360_irqrouting;
+static int via_pirq_patch_value = 5;
 
 static struct irq_routing_table *pirq_table;
 
@@ -217,12 +218,12 @@
  */
 static int pirq_via_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
-	return read_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq);
+	return read_config_nybble(router, 0x55, pirq == 4 ? via_pirq_patch_value : pirq);
 }
 
 static int pirq_via_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	write_config_nybble(router, 0x55, pirq == 4 ? 5 : pirq, irq);
+	write_config_nybble(router, 0x55, pirq == 4 ? via_pirq_patch_value : pirq, irq);
 	return 1;
 }
 
@@ -512,6 +513,7 @@
 	switch(device)
 	{
 		case PCI_DEVICE_ID_VIA_82C586_0:
+			via_pirq_patch_value = 4;
 		case PCI_DEVICE_ID_VIA_82C596:
 		case PCI_DEVICE_ID_VIA_82C686:
 		case PCI_DEVICE_ID_VIA_8231:

-- 
Karsten Keil
SuSE Labs
ISDN development
