Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbSKTFRf>; Wed, 20 Nov 2002 00:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbSKTFRf>; Wed, 20 Nov 2002 00:17:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:1810 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267619AbSKTFRa>;
	Wed, 20 Nov 2002 00:17:30 -0500
Date: Tue, 19 Nov 2002 21:17:52 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] pcibios removal changes for 2.5.48
Message-ID: <20021120051751.GC21953@kroah.com>
References: <20021120051702.GB21953@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120051702.GB21953@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.872.3.1, 2002/11/19 20:23:31-08:00, greg@kroah.com

ISDN: Convert usages of pcibios_* functions to pci_*


diff -Nru a/drivers/isdn/hisax/bkm_a8.c b/drivers/isdn/hisax/bkm_a8.c
--- a/drivers/isdn/hisax/bkm_a8.c	Tue Nov 19 21:07:10 2002
+++ b/drivers/isdn/hisax/bkm_a8.c	Tue Nov 19 21:07:10 2002
@@ -278,8 +278,6 @@
 static struct pci_dev *dev_a8 __initdata = NULL;
 static u16  sub_vendor_id __initdata = 0;
 static u16  sub_sys_id __initdata = 0;
-static u_char pci_bus __initdata = 0;
-static u_char pci_device_fn __initdata = 0;
 static u_char pci_irq __initdata = 0;
 
 #endif /* CONFIG_PCI */
@@ -328,8 +326,6 @@
 					return(0);
 				pci_ioaddr1 = pci_resource_start(dev_a8, 1);
 				pci_irq = dev_a8->irq;
-				pci_bus = dev_a8->bus->number;
-				pci_device_fn = dev_a8->devfn;
 				found = 1;
 				break;
 			}
@@ -342,20 +338,17 @@
 		}
 #ifdef ATTEMPT_PCI_REMAPPING
 /* HACK: PLX revision 1 bug: PLX address bit 7 must not be set */
-		pcibios_read_config_byte(pci_bus, pci_device_fn,
-			PCI_REVISION_ID, &pci_rev_id);
+		pci_read_config_byte(dev_a8, PCI_REVISION_ID, &pci_rev_id);
 		if ((pci_ioaddr1 & 0x80) && (pci_rev_id == 1)) {
 			printk(KERN_WARNING "HiSax: %s (%s): PLX rev 1, remapping required!\n",
 				CardType[card->typ],
 				sct_quadro_subtypes[cs->subtyp]);
 			/* Restart PCI negotiation */
-			pcibios_write_config_dword(pci_bus, pci_device_fn,
-				PCI_BASE_ADDRESS_1, (u_int) - 1);
+			pci_write_config_dword(dev_a8, PCI_BASE_ADDRESS_1, (u_int) - 1);
 			/* Move up by 0x80 byte */
 			pci_ioaddr1 += 0x80;
 			pci_ioaddr1 &= PCI_BASE_ADDRESS_IO_MASK;
-			pcibios_write_config_dword(pci_bus, pci_device_fn,
-				PCI_BASE_ADDRESS_1, pci_ioaddr1);
+			pci_write_config_dword(dev_a8, PCI_BASE_ADDRESS_1, pci_ioaddr1);
 			dev_a8->resource[ 1].start = pci_ioaddr1;
 		}
 #endif /* End HACK */
@@ -366,11 +359,11 @@
 		       sct_quadro_subtypes[cs->subtyp]);
 		return (0);
 	}
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_1, &pci_ioaddr1);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_2, &pci_ioaddr2);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_3, &pci_ioaddr3);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_4, &pci_ioaddr4);
-	pcibios_read_config_dword(pci_bus, pci_device_fn, PCI_BASE_ADDRESS_5, &pci_ioaddr5);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_1, &pci_ioaddr1);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_2, &pci_ioaddr2);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_3, &pci_ioaddr3);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_4, &pci_ioaddr4);
+	pci_read_config_dword(dev_a8, PCI_BASE_ADDRESS_5, &pci_ioaddr5);
 	if (!pci_ioaddr1 || !pci_ioaddr2 || !pci_ioaddr3 || !pci_ioaddr4 || !pci_ioaddr5) {
 		printk(KERN_WARNING "HiSax: %s (%s): No IO base address(es)\n",
 		       CardType[card->typ],
