Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131372AbQKAFnF>; Wed, 1 Nov 2000 00:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQKAFm5>; Wed, 1 Nov 2000 00:42:57 -0500
Received: from smtp3.mail.yahoo.com ([128.11.68.135]:20998 "HELO
	smtp1b.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131358AbQKAFmn>; Wed, 1 Nov 2000 00:42:43 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <39FFAA94.4D389E85@yahoo.com>
Date: Wed, 01 Nov 2000 00:31:00 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.17 i486)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: pavel rabel <pavel@web.sajt.cz>, linux-net@vger.kernel.org,
        netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] NE2000
In-Reply-To: <Pine.LNX.4.21.0010300344130.6792-100000@web.sajt.cz> <39FC83CD.B10BF08D@mandrakesoft.com> <39FD3CB6.2F641BBF@yahoo.com> <39FDCC17.4C8B8074@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Paul Gortmaker wrote:
> > There is no urgency in trying to squeeze a patch like this in the back
> > door of a 2.4.0 release.  For example, there are people out there now
> > who are using the ne.c driver to run both ISA and PCI cards in the same
> > box without having to use 2 different drivers.  We can wait until 2.5.0
> > to break their .config file.
> 
> IMNSHO this is a bug, though...

Maybe I wasn't 100% clear - these are people who have intentionally
chosen to do so. (There is probably a slight icache benefit in sharing
the same driver like this, FWIW....)

> Since ne2k-pci.c supports all boards ne.c does, and includes some fixes
> that ne.c does not, it seems like removing the PCI support in ne.c is a
> bug fix change.

If you want to roll it into the merge (and can get it past Linus) then
please feel free to do so - I'll be glad to cross it off my list sooner
as opposed to later.

In addition to removing all remains of PCI support from ne.c this patch
also has three trivial changes that were also in my queue for ne.c.

	1) Two new ID signatures added to the bad_clone_list

	2) int base_addr promoted to unsigned int base_addr in ne_probe,
	   as required for SuperH CPU systems that have ne2000 cards.

	3) ISA PnP card info printk'd *before* the actual probe, and
	   not after (just in case the probe silently hangs or whatever).

Paul.

--- 2400-t10/linux-g/drivers/net/ne.c~	Tue Jul 11 02:29:10 2000
+++ 2400-t10/linux-g/drivers/net/ne.c	Wed Nov  1 00:02:17 2000
@@ -29,6 +29,7 @@
     occur after memory is allocated for dev->priv. Deallocated memory
     last in cleanup_modue()
     Richard Guenther    : Added support for ISAPnP cards
+    Paul Gortmaker	: Discontinued PCI support - use ne2k-pci.c instead.
     
 */
 
@@ -43,7 +44,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
-#include <linux/pci.h>
 #include <linux/isapnp.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -75,23 +75,6 @@
 };
 #endif
 
-#ifdef CONFIG_PCI
-/* Ack! People are making PCI ne2000 clones! Oh the horror, the horror... */
-static struct { unsigned short vendor, dev_id; char *name; }
-pci_clone_list[] __initdata = {
-	{PCI_VENDOR_ID_REALTEK,		PCI_DEVICE_ID_REALTEK_8029,		"Realtek 8029" },
-	{PCI_VENDOR_ID_WINBOND2,	PCI_DEVICE_ID_WINBOND2_89C940,		"Winbond 89C940" },
-	{PCI_VENDOR_ID_COMPEX,		PCI_DEVICE_ID_COMPEX_RL2000,		"Compex ReadyLink 2000" },
-	{PCI_VENDOR_ID_KTI,		PCI_DEVICE_ID_KTI_ET32P2,		"KTI ET32P2" },
-	{PCI_VENDOR_ID_NETVIN,		PCI_DEVICE_ID_NETVIN_NV5000SC,		"NetVin NV5000" },
-	{PCI_VENDOR_ID_VIA,		PCI_DEVICE_ID_VIA_82C926,		"VIA 82C926 Amazon" },
-	{PCI_VENDOR_ID_SURECOM,		PCI_DEVICE_ID_SURECOM_NE34,		"SureCom NE34"},
-	{0,}
-};
-
-static int probe_pci = 1;
-#endif
-
 static struct { unsigned short vendor, function; char *name; }
 isapnp_clone_list[] __initdata = {
 	{ISAPNP_VENDOR('E','D','I'), ISAPNP_FUNCTION(0x0216),		"NN NE2000" },
@@ -114,7 +97,9 @@
     {"ET-100","ET-200", {0x00, 0x45, 0x54}}, /* YANG and YA clone */
     {"COMPEX","COMPEX16",{0x00,0x80,0x48}}, /* Broken ISA Compex cards */
     {"E-LAN100", "E-LAN200", {0x00, 0x00, 0x5d}}, /* Broken ne1000 clones */
-    {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */    
+    {"PCM-4823", "PCM-4823", {0x00, 0xc0, 0x6c}}, /* Broken Advantech MoBo */
+    {"REALTEK", "RTL8019", {0x00, 0x00, 0xe8}}, /* no-name with Realtek chip */
+    {"LCS-8834", "LCS-8836", {0x04, 0x04, 0x37}}, /* ShinyNet (SET) */
     {0,}
 };
 #endif
@@ -132,15 +117,9 @@
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
-/* Non-zero only if the current card is a PCI with BIOS-set IRQ. */
-static unsigned int pci_irq_line = 0;
-
 int ne_probe(struct net_device *dev);
 static int ne_probe1(struct net_device *dev, int ioaddr);
 static int ne_probe_isapnp(struct net_device *dev);
-#ifdef CONFIG_PCI
-static int ne_probe_pci(struct net_device *dev);
-#endif
 
 static int ne_open(struct net_device *dev);
 static int ne_close(struct net_device *dev);
@@ -180,16 +159,9 @@
 {"ne", ne_probe1, NE_IO_EXTENT, netcard_portlist};
 #else
 
-/*
- * Note that at boot, this probe only picks up one card at a time, even for
- * multiple PCI ne2k cards. Use "ether=0,0,eth1" if you have a second PCI
- * ne2k card.  This keeps things consistent regardless of the bus type of
- * the card.
- */
-
 int __init ne_probe(struct net_device *dev)
 {
-	int base_addr = dev ? dev->base_addr : 0;
+	unsigned int base_addr = dev ? dev->base_addr : 0;
 
 	/* First check any supplied i/o locations. User knows best. <cough> */
 	if (base_addr > 0x1ff)	/* Check a single specified location. */
@@ -197,12 +169,6 @@
 	else if (base_addr != 0)	/* Don't probe at all. */
 		return -ENXIO;
 
-#ifdef CONFIG_PCI
-	/* Then look for any installed PCI clones */
-	if (probe_pci && pci_present() && (ne_probe_pci(dev) == 0))
-		return 0;
-#endif
-
 	/* Then look for any installed ISAPnP clones */
 	if (isapnp_present() && (ne_probe_isapnp(dev) == 0))
 		return 0;
@@ -222,43 +188,6 @@
 }
 #endif
 
-#ifdef CONFIG_PCI
-static int __init ne_probe_pci(struct net_device *dev)
-{
-	int i;
-
-	for (i = 0; pci_clone_list[i].vendor != 0; i++) {
-		struct pci_dev *pdev = NULL;
-		unsigned int pci_ioaddr = 0;
-
-		while ((pdev = pci_find_device(pci_clone_list[i].vendor, pci_clone_list[i].dev_id, pdev))) {
-			if (pci_enable_device(pdev))
-				continue;
-			pci_ioaddr = pci_resource_start (pdev, 0);
-			/* Avoid already found cards from previous calls */
-			if (check_region(pci_ioaddr, NE_IO_EXTENT))
-				continue;
-			pci_irq_line = pdev->irq;
-			if (pci_irq_line) break;	/* Found it */
-		}
-		if (!pdev)
-			continue;
-		printk(KERN_INFO "ne.c: PCI BIOS reports %s at i/o %#x, irq %d.\n",
-				pci_clone_list[i].name,
-				pci_ioaddr, pci_irq_line);
-		printk("*\n* Use of the PCI-NE2000 driver with this card is recommended!\n*\n");
-		if (ne_probe1(dev, pci_ioaddr) != 0) {	/* Shouldn't happen. */
-			printk(KERN_ERR "ne.c: Probe of PCI card at %#x failed.\n", pci_ioaddr);
-			pci_irq_line = 0;
-			return -ENXIO;
-		}
-		pci_irq_line = 0;
-		return 0;
-	}
-	return -ENODEV;
-}
-#endif  /* CONFIG_PCI */
-
 static int __init ne_probe_isapnp(struct net_device *dev)
 {
 	int i;
@@ -275,14 +204,18 @@
 				continue;
 			if (idev->activate(idev))
 				continue;
-			pci_irq_line = idev->irq_resource[0].start;
 			/* if no irq, search for next */
-			if (!pci_irq_line)
+			if (idev->irq_resource[0].start == 0)
 				continue;
 			/* found it */
-			if (ne_probe1(dev, idev->resource[0].start) != 0) {	/* Shouldn't happen. */
-				printk(KERN_ERR "ne.c: Probe of ISAPnP card at %#lx failed.\n",
-				       idev->resource[0].start);
+			dev->base_addr = idev->resource[0].start;
+			dev->irq = idev->irq_resource[0].start;
+			printk(KERN_INFO "ne.c: ISAPnP reports %s at i/o %#lx, irq %d.\n",
+				isapnp_clone_list[i].name,
+				
+				dev->base_addr, dev->irq);
+			if (ne_probe1(dev, dev->base_addr) != 0) {	/* Shouldn't happen. */
+				printk(KERN_ERR "ne.c: Probe of ISAPnP card at %#lx failed.\n", dev->base_addr);
 				return -ENXIO;
 			}
 			ei_status.priv = (unsigned long)idev;
@@ -290,9 +223,6 @@
 		}
 		if (!idev)
 			continue;
-		printk(KERN_INFO "ne.c: ISAPnP reports %s at i/o %#lx, irq %d.\n",
-				isapnp_clone_list[i].name,
-				dev->base_addr, dev->irq);
 		return 0;
 	}
 
@@ -403,20 +333,10 @@
 			wordlength = 1;
 	}
 
-	/* At this point, wordlength *only* tells us if the SA_prom is doubled
-	   up or not because some broken PCI cards don't respect the byte-wide
-	   request in program_seq above, and hence don't have doubled up values.
-	   These broken cards would otherwise be detected as an ne1000.  */
-
-	if (wordlength == 2)
-		for (i = 0; i < 16; i++)
-			SA_prom[i] = SA_prom[i+i];
-
-	if (pci_irq_line || ioaddr >= 0x400)
-		wordlength = 2;		/* Catch broken PCI cards mentioned above. */
-
 	if (wordlength == 2) 
 	{
+		for (i = 0; i < 16; i++)
+			SA_prom[i] = SA_prom[i+i];
 		/* We must set the 8390 for word mode. */
 		outb_p(0x49, ioaddr + EN0_DCFG);
 		start_page = NESM_START_PG;
@@ -473,9 +393,6 @@
 #endif
 	}
 
-	if (pci_irq_line)
-		dev->irq = pci_irq_line;
-
 	if (dev->irq < 2) 
 	{
 		autoirq_setup(0);
@@ -509,8 +426,7 @@
 	   share and the board will usually be enabled. */
 
 	{
-		int irqval = request_irq(dev->irq, ei_interrupt,
-				 pci_irq_line ? SA_SHIRQ : 0, name, dev);
+		int irqval = request_irq(dev->irq, ei_interrupt, 0, name, dev);
 		if (irqval) {
 			printk (" unable to get IRQ %d (irqval=%d).\n", dev->irq, irqval);
 			kfree(dev->priv);
@@ -823,10 +739,6 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 
-#ifdef CONFIG_PCI
-MODULE_PARM(probe_pci, "i");
-#endif
-
 /* This is set up so that no ISA autoprobe takes place. We can't guarantee
 that the ne2k probe is the last 8390 based probe to take place (as it
 is at boot) and so the probe will get confused by any other 8390 cards.
@@ -855,7 +767,7 @@
 		if (io[this_dev] != 0)
 			printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[this_dev]);
 		else
-			printk(KERN_NOTICE "ne.c: No PCI cards found. Use \"io=0xNNN\" value(s) for ISA cards.\n");
+			printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
 		unload_8390_module();
 		return -ENXIO;
 	}



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
