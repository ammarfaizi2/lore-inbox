Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130248AbQKAN3s>; Wed, 1 Nov 2000 08:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130296AbQKAN3i>; Wed, 1 Nov 2000 08:29:38 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37133 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129148AbQKAN32>;
	Wed, 1 Nov 2000 08:29:28 -0500
Message-ID: <3A001A53.1A5BB6E0@mandrakesoft.com>
Date: Wed, 01 Nov 2000 08:27:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: pavel rabel <pavel@web.sajt.cz>, linux-net@vger.kernel.org,
        netdev@oss.sgi.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Becker <becker@scyld.com>
Subject: Re: [patch] NE2000
In-Reply-To: <Pine.LNX.4.21.0010300344130.6792-100000@web.sajt.cz> <39FC83CD.B10BF08D@mandrakesoft.com> <39FD3CB6.2F641BBF@yahoo.com> <39FDCC17.4C8B8074@mandrakesoft.com> <39FFAA94.4D389E85@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------63C6B08DCC457D46D72A79F1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------63C6B08DCC457D46D72A79F1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul,

Ok, here's what I have.  Included are your changes, as well as

drivers/net/ne.c:
* use probe_irq_on/off instead of autoirq_xxx (autoirq is going away)
* request_region first thing in ne_probe1, before any hardware
interaction takes place.  Eliminates any potential resource races.  Also
eliminates a call to check_region.
* Trim trailing whitespace

drivers/net/ne2k-pci.c:
* Merge Becker version 1.02 ne2k-pci.c, which adds forced full duplex
support, and also several cosmetic changes where merely serve to bring
the kernel's ne2k-pci.c closer to Becker's version (ie. makes the diff
smaller).
* Just call BUG() if we don't have a net_device in ne2k_pci_remove_one
* Correct pci_module_init return code handling

As an aside, for 2.5.x, would it be possible to merge all the common
ne2000 code (block_input/output, etc.) from the various ne2k drivers? 
As it stands there exists ne.c, ne2.c, ne2k-pci.c, and pcnet_cs.c, all
of which do pretty much the same thing at their core.  [and AFAICS, all
but pcnet_cs might easily call a common ne2k library]

Regards,

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
--------------63C6B08DCC457D46D72A79F1
Content-Type: text/plain; charset=us-ascii;
 name="ne.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ne.patch"

Index: drivers/net/ne.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/ne.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 ne.c
--- drivers/net/ne.c	2000/10/31 21:21:49	1.1.1.4
+++ drivers/net/ne.c	2000/11/01 13:24:36
@@ -29,21 +29,22 @@
     occur after memory is allocated for dev->priv. Deallocated memory
     last in cleanup_modue()
     Richard Guenther    : Added support for ISAPnP cards
-    
+    Paul Gortmaker	: Discontinued PCI support - use ne2k-pci.c instead.
+
 */
 
 /* Routines for the NatSemi-based designs (NE[12]000). */
 
-static const char *version =
-    "ne.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)\n";
+static const char version1[] =
+"ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)\n";
+static const char version2[] =
+"Last modified Nov 1, 2000 by Paul Gortmaker\n";
 
 
 #include <linux/module.h>
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
-#include <linux/pci.h>
 #include <linux/isapnp.h>
 #include <linux/init.h>
 #include <linux/delay.h>
@@ -70,28 +71,11 @@
 
 /* A zero-terminated list of I/O addresses to be probed at boot. */
 #ifndef MODULE
-static unsigned int netcard_portlist[] __initdata = { 
+static unsigned int netcard_portlist[] __initdata = {
 	0x300, 0x280, 0x320, 0x340, 0x360, 0x380, 0
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
@@ -114,7 +98,9 @@
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
@@ -132,15 +118,9 @@
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
@@ -175,16 +155,9 @@
 	E2010	 starts at 0x100 and ends at 0x4000.
 	E2010-x starts at 0x100 and ends at 0xffff.  */
 
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
@@ -192,12 +165,6 @@
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
@@ -206,8 +173,6 @@
 	/* Last resort. The semi-risky ISA auto-probe. */
 	for (base_addr = 0; netcard_portlist[base_addr] != 0; base_addr++) {
 		int ioaddr = netcard_portlist[base_addr];
-		if (check_region(ioaddr, NE_IO_EXTENT))
-			continue;
 		if (ne_probe1(dev, ioaddr) == 0)
 			return 0;
 	}
@@ -216,47 +181,10 @@
 	return -ENODEV;
 }
 
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
-	
+
 	for (i = 0; isapnp_clone_list[i].vendor != 0; i++) {
 		struct pci_dev *idev = NULL;
 
@@ -269,14 +197,18 @@
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
@@ -284,9 +216,6 @@
 		}
 		if (!idev)
 			continue;
-		printk(KERN_INFO "ne.c: ISAPnP reports %s at i/o %#lx, irq %d.\n",
-				isapnp_clone_list[i].name,
-				dev->base_addr, dev->irq);
 		return 0;
 	}
 
@@ -301,11 +230,17 @@
 	const char *name = NULL;
 	int start_page, stop_page;
 	int neX000, ctron, copam, bad_card;
-	int reg0 = inb_p(ioaddr);
+	int reg0, ret;
 	static unsigned version_printed = 0;
+
+	if (!request_region(ioaddr, NE_IO_EXTENT, dev->name))
+		return -EBUSY;
 
-	if (reg0 == 0xFF)
-		return -ENODEV;
+	reg0 = inb_p(ioaddr);
+	if (reg0 == 0xFF) {
+		ret = -ENODEV;
+		goto err_out;
+	}
 
 	/* Do a preliminary verification that we have a 8390. */
 	{
@@ -318,12 +253,13 @@
 		if (inb_p(ioaddr + EN0_COUNTER0) != 0) {
 			outb_p(reg0, ioaddr);
 			outb_p(regd, ioaddr + 0x0d);	/* Restore the old values. */
-			return -ENODEV;
+			ret = -ENODEV;
+			goto err_out;
 		}
 	}
 
 	if (ei_debug  &&  version_printed++ == 0)
-		printk(version);
+		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 
 	printk(KERN_INFO "NE*000 ethercard probe at %#3x:", ioaddr);
 
@@ -350,10 +286,11 @@
 				break;
 			} else {
 				printk(" not found (no reset ack).\n");
-				return -ENODEV;
+				ret = -ENODEV;
+				goto err_out;
 			}
 		}
-	
+
 		outb_p(0xff, ioaddr + EN0_ISR);		/* Ack all intr. */
 	}
 
@@ -362,7 +299,7 @@
 	   We can't reliably read the SAPROM address without this.
 	   (I learned the hard way!). */
 	{
-		struct {unsigned char value, offset; } program_seq[] = 
+		struct {unsigned char value, offset; } program_seq[] =
 		{
 			{E8390_NODMA+E8390_PAGE0+E8390_STOP, E8390_CMD}, /* Select page 0*/
 			{0x48,	EN0_DCFG},	/* Set byte-wide (0x48) access. */
@@ -390,20 +327,10 @@
 			wordlength = 1;
 	}
 
-	/* At this point, wordlength *only* tells us if the SA_prom is doubled
-	   up or not because some broken PCI cards don't respect the byte-wide
-	   request in program_seq above, and hence don't have doubled up values.
-	   These broken cards would otherwise be detected as an ne1000.  */
-
 	if (wordlength == 2)
+	{
 		for (i = 0; i < 16; i++)
 			SA_prom[i] = SA_prom[i+i];
-
-	if (pci_irq_line || ioaddr >= 0x400)
-		wordlength = 2;		/* Catch broken PCI cards mentioned above. */
-
-	if (wordlength == 2) 
-	{
 		/* We must set the 8390 for word mode. */
 		outb_p(0x49, ioaddr + EN0_DCFG);
 		start_page = NESM_START_PG;
@@ -416,13 +343,12 @@
 	neX000 = (SA_prom[14] == 0x57  &&  SA_prom[15] == 0x57);
 	ctron =  (SA_prom[0] == 0x00 && SA_prom[1] == 0x00 && SA_prom[2] == 0x1d);
 	copam =  (SA_prom[14] == 0x49 && SA_prom[15] == 0x00);
-	
 
 	/* Set up the rest of the parameters. */
 	if (neX000 || bad_card || copam) {
 		name = (wordlength == 2) ? "NE2000" : "NE1000";
 	}
-	else if (ctron) 
+	else if (ctron)
 	{
 		name = (wordlength == 2) ? "Ctron-8" : "Ctron-16";
 		start_page = 0x01;
@@ -433,13 +359,13 @@
 #ifdef SUPPORT_NE_BAD_CLONES
 		/* Ack!  Well, there might be a *bad* NE*000 clone there.
 		   Check for total bogus addresses. */
-		for (i = 0; bad_clone_list[i].name8; i++) 
+		for (i = 0; bad_clone_list[i].name8; i++)
 		{
 			if (SA_prom[0] == bad_clone_list[i].SAprefix[0] &&
 				SA_prom[1] == bad_clone_list[i].SAprefix[1] &&
-				SA_prom[2] == bad_clone_list[i].SAprefix[2]) 
+				SA_prom[2] == bad_clone_list[i].SAprefix[2])
 			{
-				if (wordlength == 2) 
+				if (wordlength == 2)
 				{
 					name = bad_clone_list[i].name16;
 				} else {
@@ -448,31 +374,30 @@
 				break;
 			}
 		}
-		if (bad_clone_list[i].name8 == NULL) 
+		if (bad_clone_list[i].name8 == NULL)
 		{
 			printk(" not found (invalid signature %2.2x %2.2x).\n",
 				SA_prom[14], SA_prom[15]);
-			return -ENXIO;
+			ret = -ENXIO;
+			goto err_out;
 		}
 #else
 		printk(" not found.\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto err_out;
 #endif
 	}
-
-	if (pci_irq_line)
-		dev->irq = pci_irq_line;
 
-	if (dev->irq < 2) 
+	if (dev->irq < 2)
 	{
-		autoirq_setup(0);
+		unsigned long cookie = probe_irq_on();
 		outb_p(0x50, ioaddr + EN0_IMR);	/* Enable one interrupt. */
 		outb_p(0x00, ioaddr + EN0_RCNTLO);
 		outb_p(0x00, ioaddr + EN0_RCNTHI);
 		outb_p(E8390_RREAD+E8390_START, ioaddr); /* Trigger it... */
 		mdelay(10);		/* wait 10ms for interrupt to propagate */
 		outb_p(0x00, ioaddr + EN0_IMR); 		/* Mask it again. */
-		dev->irq = autoirq_report(0);
+		dev->irq = probe_irq_off(cookie);
 		if (ei_debug > 2)
 			printk(" autoirq is %d\n", dev->irq);
 	} else if (dev->irq == 2)
@@ -482,31 +407,27 @@
 
 	if (! dev->irq) {
 		printk(" failed to detect IRQ line.\n");
-		return -EAGAIN;
+		ret = -EAGAIN;
+		goto err_out;
 	}
 
 	/* Allocate dev->priv and fill in 8390 specific dev fields. */
-	if (ethdev_init(dev)) 
+	if (ethdev_init(dev))
 	{
         	printk (" unable to get memory for dev->priv.\n");
-        	return -ENOMEM;
+        	ret = -ENOMEM;
+		goto err_out;
 	}
-   
+
 	/* Snarf the interrupt now.  There's no point in waiting since we cannot
 	   share and the board will usually be enabled. */
-
-	{
-		int irqval = request_irq(dev->irq, ei_interrupt,
-				 pci_irq_line ? SA_SHIRQ : 0, name, dev);
-		if (irqval) {
-			printk (" unable to get IRQ %d (irqval=%d).\n", dev->irq, irqval);
-			kfree(dev->priv);
-			dev->priv = NULL;
-			return -EAGAIN;
-		}
+	ret = request_irq(dev->irq, ei_interrupt, 0, name, dev);
+	if (ret) {
+		printk (" unable to get IRQ %d (errno=%d).\n", dev->irq, ret);
+		goto err_out_kfree;
 	}
+
 	dev->base_addr = ioaddr;
-	request_region(ioaddr, NE_IO_EXTENT, name);
 
 	for(i = 0; i < ETHER_ADDR_LEN; i++) {
 		printk(" %2.2x", SA_prom[i]);
@@ -536,6 +457,13 @@
 	dev->stop = &ne_close;
 	NS8390_init(dev, 0);
 	return 0;
+
+err_out_kfree:
+	kfree(dev->priv);
+	dev->priv = NULL;
+err_out:
+	release_region(ioaddr, NE_IO_EXTENT);
+	return ret;
 }
 
 static int ne_open(struct net_device *dev)
@@ -589,7 +517,7 @@
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
 
-	if (ei_status.dmaing) 
+	if (ei_status.dmaing)
 	{
 		printk(KERN_EMERG "%s: DMAing conflict in ne_get_8390_hdr "
 			"[DMAstat:%d][irqlock:%d].\n",
@@ -628,7 +556,7 @@
 	char *buf = skb->data;
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
-	if (ei_status.dmaing) 
+	if (ei_status.dmaing)
 	{
 		printk(KERN_EMERG "%s: DMAing conflict in ne_block_input "
 			"[DMAstat:%d][irqlock:%d].\n",
@@ -642,10 +570,10 @@
 	outb_p(ring_offset & 0xff, nic_base + EN0_RSARLO);
 	outb_p(ring_offset >> 8, nic_base + EN0_RSARHI);
 	outb_p(E8390_RREAD+E8390_START, nic_base + NE_CMD);
-	if (ei_status.word16) 
+	if (ei_status.word16)
 	{
 		insw(NE_BASE + NE_DATAPORT,buf,count>>1);
-		if (count & 0x01) 
+		if (count & 0x01)
 		{
 			buf[count-1] = inb(NE_BASE + NE_DATAPORT);
 #ifdef NE_SANITY_CHECK
@@ -662,7 +590,7 @@
 	   this message you either 1) have a slightly incompatible clone
 	   or 2) have noise/speed problems with your bus. */
 
-	if (ei_debug > 1) 
+	if (ei_debug > 1)
 	{
 		/* DMA termination address check... */
 		int addr, tries = 20;
@@ -697,12 +625,12 @@
 	/* Round the count up for word writes.  Do we need to do this?
 	   What effect will an odd byte count have on the 8390?
 	   I should check someday. */
-	   
+
 	if (ei_status.word16 && (count & 0x01))
 		count++;
 
 	/* This *shouldn't* happen. If it does, it's the last thing you'll see */
-	if (ei_status.dmaing) 
+	if (ei_status.dmaing)
 	{
 		printk(KERN_EMERG "%s: DMAing conflict in ne_block_output."
 			"[DMAstat:%d][irqlock:%d]\n",
@@ -722,7 +650,7 @@
 	   Crynwr packet driver -- the NatSemi method doesn't work.
 	   Actually this doesn't always work either, but if you have
 	   problems with your NEx000 this is better than nothing! */
-	   
+
 	outb_p(0x42, nic_base + EN0_RCNTLO);
 	outb_p(0x00,   nic_base + EN0_RCNTHI);
 	outb_p(0x42, nic_base + EN0_RSARLO);
@@ -752,8 +680,8 @@
 #ifdef NE_SANITY_CHECK
 	/* This was for the ALPHA version only, but enough people have
 	   been encountering problems so it is still here. */
-	
-	if (ei_debug > 1) 
+
+	if (ei_debug > 1)
 	{
 		/* DMA termination address check... */
 		int addr, tries = 20;
@@ -765,7 +693,7 @@
 				break;
 		} while (--tries > 0);
 
-		if (tries <= 0) 
+		if (tries <= 0)
 		{
 			printk(KERN_WARNING "%s: Tx packet transfer address mismatch,"
 				"%#4.4x (expected) vs. %#4.4x (actual).\n",
@@ -801,10 +729,6 @@
 MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
 
-#ifdef CONFIG_PCI
-MODULE_PARM(probe_pci, "i");
-#endif
-
 /* This is set up so that no ISA autoprobe takes place. We can't guarantee
 that the ne2k probe is the last 8390 based probe to take place (as it
 is at boot) and so the probe will get confused by any other 8390 cards.
@@ -833,7 +757,7 @@
 		if (io[this_dev] != 0)
 			printk(KERN_WARNING "ne.c: No NE*000 card found at i/o = %#x\n", io[this_dev]);
 		else
-			printk(KERN_NOTICE "ne.c: No PCI cards found. Use \"io=0xNNN\" value(s) for ISA cards.\n");
+			printk(KERN_NOTICE "ne.c: You must supply \"io=0xNNN\" value(s) for ISA cards.\n");
 		unload_8390_module();
 		return -ENXIO;
 	}
Index: drivers/net/ne2k-pci.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/ne2k-pci.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 ne2k-pci.c
--- drivers/net/ne2k-pci.c	2000/10/22 21:55:54	1.1.1.3
+++ drivers/net/ne2k-pci.c	2000/11/01 13:24:36
@@ -2,30 +2,49 @@
 /*
 	A Linux device driver for PCI NE2000 clones.
 
-	Authorship and other copyrights:
-	1992-1998 by Donald Becker, NE2000 core and various modifications.
+	Authors and other copyright holders:
+	1992-2000 by Donald Becker, NE2000 core and various modifications.
 	1995-1998 by Paul Gortmaker, core modifications and PCI support.
-
 	Copyright 1993 assigned to the United States Government as represented
 	by the Director, National Security Agency.
-
-	This software may be used and distributed according to the terms
-	of the GNU Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	This software may be used and distributed according to the terms of
+	the GNU General Public License (GPL), incorporated herein by reference.
+	Drivers based on or derived from this code fall under the GPL and must
+	retain the authorship, copyright and license notice.  This file is not
+	a complete program and may only be used when the entire operating
+	system is licensed under the GPL.
+
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
-	People are making PCI ne2000 clones! Oh the horror, the horror...
-
 	Issues remaining:
-	No full-duplex support.
+	People are making PCI ne2000 clones! Oh the horror, the horror...
+	Limited full-duplex support.
 */
 
-/* Our copyright info must remain in the binary. */
-static const char *version =
-"ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P. Gortmaker http://cesdis.gsfc.nasa.gov/linux/drivers/ne2k-pci.html\n";
+/* These identify the driver base version and may not be removed. */
+static const char version1[] =
+"ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker\n";
+static const char version2[] =
+"  http://www.scyld.com/network/ne2k-pci.html\n";
+
+/* The user-configurable values.
+   These may be modified when a driver module is loaded.*/
+
+static int debug = 1;			/* 1 normal messages, 0 quiet .. 7 verbose. */
+
+#define MAX_UNITS 8				/* More are supported, limit only on options */
+/* Used to pass the full-duplex flag, etc. */
+static int full_duplex[MAX_UNITS];
+static int options[MAX_UNITS];
 
+/* Force a non std. amount of memory.  Units are 256 byte pages. */
+/* #define PACKETBUF_MEMSIZE	0x40 */
+
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -48,8 +67,11 @@
 #define outsl outsl_ns
 #endif
 
-/* Set statically or when loading the driver module. */
-static int debug = 1;
+MODULE_AUTHOR("Donald Becker / Paul Gortmaker");
+MODULE_DESCRIPTION("PCI NE2000 clone driver");
+MODULE_PARM(debug, "i");
+MODULE_PARM(options, "1-" __MODULE_STRING(MAX_UNITS) "i");
+MODULE_PARM(full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
 
 /* Some defines that people can play with if so inclined. */
 
@@ -59,19 +81,16 @@
 /* Do we implement the read before write bugfix ? */
 /* #define NE_RW_BUGFIX */
 
-/* Do we have a non std. amount of memory? (in units of 256 byte pages) */
-/* #define PACKETBUF_MEMSIZE	0x40 */
-
-#define ne2k_flags reg0			/* Rename an existing field to store flags! */
-
-/* Only the low 8 bits are usable for non-init-time flags! */
+/* Flags.  We rename an existing ei_status field to store flags! */
+/* Thus only the low 8 bits are usable for non-init-time flags. */
+#define ne2k_flags reg0
 enum {
-	HOLTEK_FDX=1, 		/* Full duplex -> set 0x80 at offset 0x20. */
-	ONLY_16BIT_IO=2, ONLY_32BIT_IO=4,	/* Chip can do only 16/32-bit xfers. */
+	ONLY_16BIT_IO=8, ONLY_32BIT_IO=4,	/* Chip can do only 16/32-bit xfers. */
+	FORCE_FDX=0x20,						/* User override. */
+	REALTEK_FDX=0x40, HOLTEK_FDX=0x80,
 	STOP_PG_0x60=0x100,
 };
 
-
 enum ne2k_pci_chipsets {
 	CH_RealTek_RTL_8029 = 0,
 	CH_Winbond_89C940,
@@ -90,7 +109,7 @@
 	char *name;
 	int flags;
 } pci_clone_list[] __devinitdata = {
-	{"RealTek RTL-8029", 0},
+	{"RealTek RTL-8029", REALTEK_FDX},
 	{"Winbond 89C940", 0},
 	{"Compex RL2000", 0},
 	{"KTI ET32P2", 0},
@@ -145,7 +164,8 @@
 
 
 
-/* No room in the standard 8390 structure for extra info we need. */
+/* There is no room in the standard 8390 structure for extra info we need,
+   so we build a meta/outer-wrapper structure.. */
 struct ne2k_pci_card {
 	struct net_device *dev;
 	struct pci_dev *pci_dev;
@@ -171,33 +191,35 @@
 				     const struct pci_device_id *ent)
 {
 	struct net_device *dev;
-	int i, irq, reg0, start_page, stop_page;
+	int i;
 	unsigned char SA_prom[32];
-	int chip_idx = ent->driver_data;
-	static unsigned version_printed = 0;
+	int start_page, stop_page;
+	int irq, reg0, chip_idx = ent->driver_data;
+	static unsigned int fnd_cnt;
 	long ioaddr;
-	
-	if (version_printed++ == 0)
-		printk(KERN_INFO "%s", version);
+	int flags = pci_clone_list[chip_idx].flags;
+
+	if (fnd_cnt++ == 0)
+		printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 
 	ioaddr = pci_resource_start (pdev, 0);
 	irq = pdev->irq;
-	
+
 	if (!ioaddr || ((pci_resource_flags (pdev, 0) & IORESOURCE_IO) == 0)) {
 		printk (KERN_ERR "ne2k-pci: no I/O resource at PCI BAR #0\n");
 		return -ENODEV;
 	}
-	
+
 	i = pci_enable_device (pdev);
 	if (i)
 		return i;
-	
+
 	if (request_region (ioaddr, NE_IO_EXTENT, "ne2k-pci") == NULL) {
 		printk (KERN_ERR "ne2k-pci: I/O resource 0x%x @ 0x%lx busy\n",
 			NE_IO_EXTENT, ioaddr);
 		return -EBUSY;
 	}
-	
+
 	reg0 = inb(ioaddr);
 	if (reg0 == 0xFF)
 		goto err_out_free_res;
@@ -222,7 +244,7 @@
 		printk (KERN_ERR "ne2k-pci: cannot allocate ethernet device\n");
 		goto err_out_free_res;
 	}
-	
+
 	/* Reset card. Who knows what dain-bramaged state it was left in. */
 	{
 		unsigned long reset_start_time = jiffies;
@@ -238,7 +260,7 @@
 				printk("ne2k-pci: Card failure (no reset ack).\n");
 				goto err_out_free_netdev;
 			}
-		
+
 		outb(0xff, ioaddr + EN0_ISR);		/* Ack all intr. */
 	}
 
@@ -269,7 +291,7 @@
 
 	/* Note: all PCI cards have at least 16 bit access, so we don't have
 	   to check for 8 bit cards.  Most cards permit 32 bit access. */
-	if (pci_clone_list[chip_idx].flags & ONLY_32BIT_IO) {
+	if (flags & ONLY_32BIT_IO) {
 		for (i = 0; i < 4 ; i++)
 			((u32 *)SA_prom)[i] = le32_to_cpu(inl(ioaddr + NE_DATAPORT));
 	} else
@@ -280,8 +302,7 @@
 	outb(0x49, ioaddr + EN0_DCFG);
 	start_page = NESM_START_PG;
 
-	stop_page =
-		pci_clone_list[chip_idx].flags&STOP_PG_0x60 ? 0x60 : NESM_STOP_PG;
+	stop_page = flags & STOP_PG_0x60 ? 0x60 : NESM_STOP_PG;
 
 	/* Set up the rest of the parameters. */
 	dev->irq = irq;
@@ -305,7 +326,11 @@
 	ei_status.tx_start_page = start_page;
 	ei_status.stop_page = stop_page;
 	ei_status.word16 = 1;
-	ei_status.ne2k_flags = pci_clone_list[chip_idx].flags;
+	ei_status.ne2k_flags = flags;
+	if (fnd_cnt < MAX_UNITS) {
+		if (full_duplex[fnd_cnt] > 0  ||  (options[fnd_cnt] & FORCE_FDX))
+			ei_status.ne2k_flags |= FORCE_FDX;
+	}
 
 	ei_status.rx_start_page = start_page + TX_PAGES;
 #ifdef PACKETBUF_MEMSIZE
@@ -331,20 +356,27 @@
 
 }
 
-static int
-ne2k_pci_open(struct net_device *dev)
+static int ne2k_pci_open(struct net_device *dev)
 {
 	MOD_INC_USE_COUNT;
 	if (request_irq(dev->irq, ei_interrupt, SA_SHIRQ, dev->name, dev)) {
 		MOD_DEC_USE_COUNT;
 		return -EAGAIN;
 	}
+	/* Set full duplex for the chips that we know about. */
+	if (ei_status.ne2k_flags & FORCE_FDX) {
+		long ioaddr = dev->base_addr;
+		if (ei_status.ne2k_flags & REALTEK_FDX) {
+			outb(0xC0 + E8390_NODMA, ioaddr + NE_CMD); /* Page 3 */
+			outb(inb(ioaddr + 0x20) | 0x80, ioaddr + 0x20);
+		} else if (ei_status.ne2k_flags & HOLTEK_FDX)
+			outb(inb(ioaddr + 0x20) | 0x80, ioaddr + 0x20);
+	}
 	ei_open(dev);
 	return 0;
 }
 
-static int
-ne2k_pci_close(struct net_device *dev)
+static int ne2k_pci_close(struct net_device *dev)
 {
 	ei_close(dev);
 	free_irq(dev->irq, dev);
@@ -354,8 +386,7 @@
 
 /* Hard reset the card.  This used to pause for the same period that a
    8390 reset command required, but that shouldn't be necessary. */
-static void
-ne2k_pci_reset_8390(struct net_device *dev)
+static void ne2k_pci_reset_8390(struct net_device *dev)
 {
 	unsigned long reset_start_time = jiffies;
 
@@ -380,8 +411,7 @@
    we don't need to be concerned with ring wrap as the header will be at
    the start of a page, so we optimize accordingly. */
 
-static void
-ne2k_pci_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr, int ring_page)
+static void ne2k_pci_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr, int ring_page)
 {
 
 	long nic_base = dev->base_addr;
@@ -418,8 +448,8 @@
    The NEx000 doesn't share the on-board packet memory -- you have to put
    the packet out through the "remote DMA" dataport using outb. */
 
-static void
-ne2k_pci_block_input(struct net_device *dev, int count, struct sk_buff *skb, int ring_offset)
+static void ne2k_pci_block_input(struct net_device *dev, int count,
+				 struct sk_buff *skb, int ring_offset)
 {
 	long nic_base = dev->base_addr;
 	char *buf = skb->data;
@@ -461,9 +491,8 @@
 	ei_status.dmaing &= ~0x01;
 }
 
-static void
-ne2k_pci_block_output(struct net_device *dev, int count,
-		const unsigned char *buf, const int start_page)
+static void ne2k_pci_block_output(struct net_device *dev, int count,
+				  const unsigned char *buf, const int start_page)
 {
 	long nic_base = NE_BASE;
 	unsigned long dma_start;
@@ -520,8 +549,8 @@
 	dma_start = jiffies;
 
 	while ((inb(nic_base + EN0_ISR) & ENISR_RDC) == 0)
-		if (jiffies - dma_start > 2) { 			/* Avoid clock roll-over. */
-			printk("%s: timeout waiting for Tx RDC.\n", dev->name);
+		if (jiffies - dma_start > 2) {			/* Avoid clock roll-over. */
+			printk(KERN_WARNING "%s: timeout waiting for Tx RDC.\n", dev->name);
 			ne2k_pci_reset_8390(dev);
 			NS8390_init(dev,1);
 			break;
@@ -536,12 +565,10 @@
 static void __devexit ne2k_pci_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
-	
-	if (!dev) {
-		printk (KERN_ERR "bug! ne2k_pci_remove_one called w/o net_device\n");
-		return;
-	}
-	
+
+	if (!dev)
+		BUG();
+
 	unregister_netdev(dev);
 	release_region(dev->base_addr, NE_IO_EXTENT);
 	kfree(dev);
@@ -560,18 +587,12 @@
 static int __init ne2k_pci_init(void)
 {
 	int rc;
-	
+
 	if (load_8390_module("ne2k-pci.c"))
 		return -ENOSYS;
-	
-	rc = pci_module_init (&ne2k_driver);
-	
-	/* XXX should this test CONFIG_HOTPLUG like pci_module_init? */
 
-	/* YYY No. If we're returning non-zero, we're being unloaded
-	 * 	   immediately. dwmw2 
-	 */
-	if (rc <= 0)
+	rc = pci_module_init (&ne2k_driver);
+	if (rc)
 		unload_8390_module();
 
 	return rc;
@@ -586,16 +607,3 @@
 
 module_init(ne2k_pci_init);
 module_exit(ne2k_pci_cleanup);
-
-
-/*
- * Local variables:
- *  compile-command: "gcc -DMODVERSIONS  -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/ -c ne2k-pci.c"
- *  alt-compile-command: "gcc -DMODULE -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer -I/usr/src/linux/drivers/net/ -c ne2k-pci.c"
- *  c-indent-level: 4
- *  c-basic-offset: 4
- *  tab-width: 4
- *  version-control: t
- *  kept-new-versions: 5
- * End:
- */

--------------63C6B08DCC457D46D72A79F1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
