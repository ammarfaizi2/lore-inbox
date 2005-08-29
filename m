Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVH2W1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVH2W1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVH2W1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:27:19 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:17032 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751371AbVH2W0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:26:47 -0400
Date: Tue, 30 Aug 2005 00:26:32 +0200
Message-Id: <200508292226.j7TMQWo2019990@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 5/7] arch: pci_find_device remove (ppc/kernel/pci.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, paulus@samba.org,
       linuxppc-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 pci.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c
+++ b/arch/ppc/kernel/pci.c
@@ -517,7 +517,7 @@ pcibios_allocate_resources(int pass)
 	u16 command;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for (idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -554,7 +554,7 @@ pcibios_assign_resources(void)
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */
@@ -880,14 +880,15 @@ pci_device_from_OF_node(struct device_no
 	 */
 	if (!pci_to_OF_bus_map)
 		return 0;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		if (pci_to_OF_bus_map[dev->bus->number] != *bus)
-			continue;
-		if (dev->devfn != *devfn)
-			continue;
-		*bus = dev->bus->number;
-		return 0;
-	}
+
+	for_each_pci_dev(dev)
+		if (pci_to_OF_bus_map[dev->bus->number] == *bus &&
+				dev->devfn == *devfn) {
+			*bus = dev->bus->number;
+			pci_dev_put(dev);
+			return 0;
+		}
+
 	return -ENODEV;
 }
 
