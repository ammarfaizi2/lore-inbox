Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUHEPsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUHEPsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUHEPrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:47:10 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:10375 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267756AbUHEPpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:45:50 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.8-rc3-mm1: ip2mainc-add-missing-pci_enable_device breaks compilation
Date: Thu, 5 Aug 2004 09:45:40 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040805031918.08790a82.akpm@osdl.org> <20040805123809.GF2746@fs.tum.de>
In-Reply-To: <20040805123809.GF2746@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050945.40470.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 6:38 am, Adrian Bunk wrote:
> This causes the following compile error:
> drivers/char/ip2main.c:445: request for member `pci_dev' in something not a structure or union

Thanks for finding this.  Andrew, if you replace that patch with the
following, it should fix it.  The error occurs when CONFIG_COMPUTONE=m,
so I've now built it as both built-in and a module.


I don't have this hardware, so this has been compiled but not tested.

Add pci_enable_device()/pci_disable_device().  In the past, drivers
often worked without this, but it is now required in order to route
PCI interrupts correctly.  In addition, this driver incorrectly used
the IRQ value from PCI config space rather than the one in the struct
pci_dev.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/char/ip2main.c 1.44 vs edited =====
--- 1.44/drivers/char/ip2main.c	2004-04-14 11:08:00 -06:00
+++ edited/drivers/char/ip2main.c	2004-08-05 09:37:22 -06:00
@@ -440,6 +440,12 @@
 	// free memory
 	for (i = 0; i < IP2_MAX_BOARDS; i++) {
 		void *pB;
+#ifdef CONFIG_PCI
+		if (ip2config.type[i] == PCI && ip2config.pci_dev[i]) {
+			pci_disable_device(ip2config.pci_dev[i]);
+			ip2config.pci_dev[i] = NULL;
+		}
+#endif
 		if ((pB = i2BoardPtrTable[i]) != 0 ) {
 			kfree ( pB );
 			i2BoardPtrTable[i] = NULL;
@@ -594,9 +600,14 @@
 							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
 				if (pci_dev_i != NULL) {
 					unsigned int addr;
-					unsigned char pci_irq;
 
+					if (pci_enable_device(pci_dev_i)) {
+						printk( KERN_ERR "IP2: can't enable PCI device at %s\n",
+							pci_name(pci_dev_i));
+						break;
+					}
 					ip2config.type[i] = PCI;
+					ip2config.pci_dev[i] = pci_dev_i;
 					status =
 					pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
 					if ( addr & 1 ) {
@@ -604,8 +615,6 @@
 					} else {
 						printk( KERN_ERR "IP2: PCI I/O address error\n");
 					}
-					status =
-					pci_read_config_byte(pci_dev_i, PCI_INTERRUPT_LINE, &pci_irq);
 
 //		If the PCI BIOS assigned it, lets try and use it.  If we
 //		can't acquire it or it screws up, deal with it then.
@@ -614,7 +623,7 @@
 //						printk( KERN_ERR "IP2: Bad PCI BIOS IRQ(%d)\n",pci_irq);
 //						pci_irq = 0;
 //					}
-					ip2config.irq[i] = pci_irq;
+					ip2config.irq[i] = pci_dev_i->irq;
 				} else {	// ann error
 					ip2config.addr[i] = 0;
 					if (status == PCIBIOS_DEVICE_NOT_FOUND) {
===== drivers/char/ip2/ip2types.h 1.1 vs edited =====
--- 1.1/drivers/char/ip2/ip2types.h	2002-02-05 10:40:06 -07:00
+++ edited/drivers/char/ip2/ip2types.h	2004-08-04 12:20:02 -06:00
@@ -49,6 +49,9 @@
 	short irq[IP2_MAX_BOARDS]; 
 	unsigned short addr[IP2_MAX_BOARDS];
 	int type[IP2_MAX_BOARDS];
+#ifdef CONFIG_PCI
+	struct pci_dev *pci_dev[IP2_MAX_BOARDS];
+#endif
 } ip2config_t;
 
 #endif
