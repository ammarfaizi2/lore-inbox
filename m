Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262388AbSJDUvY>; Fri, 4 Oct 2002 16:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSJDUvY>; Fri, 4 Oct 2002 16:51:24 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:42767 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262707AbSJDUub>;
	Fri, 4 Oct 2002 16:50:31 -0400
Date: Fri, 4 Oct 2002 13:53:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004205305.GC8346@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004205222.GB8346@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.674.3.4 -> 1.674.3.5
#	drivers/net/wan/lmc/lmc_main.c	1.8     -> 1.9    
#	drivers/net/aironet4500_card.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	greg@kroah.com	1.674.3.5
# PCI: remove usages of pcibios_find_class()
# --------------------------------------------
#
diff -Nru a/drivers/net/aironet4500_card.c b/drivers/net/aironet4500_card.c
--- a/drivers/net/aironet4500_card.c	Fri Oct  4 13:47:26 2002
+++ b/drivers/net/aironet4500_card.c	Fri Oct  4 13:47:26 2002
@@ -70,9 +70,6 @@
 MODULE_LICENSE("GPL");
 
 
-static int reverse_probe;
-
-
 static int awc_pci_init(struct net_device * dev, struct pci_dev *pdev,
  			int ioaddr, int cis_addr, int mem_addr,u8 pci_irq_line) ;
 
@@ -80,38 +77,29 @@
 int awc4500_pci_probe(struct net_device *dev)
 {
 	int cards_found = 0;
-	static int pci_index;	/* Static, for multiple probe calls. */
 	u8 pci_irq_line = 0;
 //	int p;
-
-	unsigned char awc_pci_dev, awc_pci_bus;
-
+	struct pci_dev *pdev = NULL;
+		
 	if (!pci_present()) 
 		return -1;
 
-	for (;pci_index < 0xff; pci_index++) {
-		u16 vendor, device, pci_command, new_command;
+	while ((pdev = pci_find_class (PCI_CLASS_NETWORK_OTHER << 8, pdev))) {
+		u16 pci_command, new_command;
 		u32 pci_memaddr;
 		u32 pci_ioaddr;
 		u32 pci_cisaddr;
-		struct pci_dev *pdev;
 
-		if (pcibios_find_class	(PCI_CLASS_NETWORK_OTHER << 8,
-			 reverse_probe ? 0xfe - pci_index : pci_index,
-				 &awc_pci_bus, &awc_pci_dev) != PCIBIOS_SUCCESSFUL){
-				if (reverse_probe){
-					continue;
-				} else {
-					break;
-				}
-		}
-		pdev = pci_find_slot(awc_pci_bus, awc_pci_dev);
-		if (!pdev)
+		if (pdev->vendor != PCI_VENDOR_ID_AIRONET)
+			continue;
+		if ((pdev->device != PCI_DEVICE_AIRONET_4800_1) &&
+		    (pdev->device != PCI_DEVICE_AIRONET_4800) &&
+		    (pdev->device != PCI_DEVICE_AIRONET_4500))
 			continue;
+
 		if (pci_enable_device(pdev))
 			continue;
-		vendor = pdev->vendor;
-		device = pdev->device;
+
 	        pci_irq_line = pdev->irq;
 		pci_memaddr = pci_resource_start (pdev, 0);
                 pci_cisaddr = pci_resource_start (pdev, 1);
@@ -120,13 +108,6 @@
 //		printk("\n pci capabilities %x and ptr %x \n",pci_caps,pci_caps_ptr);
 		/* Remove I/O space marker in bit 0. */
 
-		if (vendor != PCI_VENDOR_ID_AIRONET)
-			continue;
-		if (device != PCI_DEVICE_AIRONET_4800_1 && 
-				device != PCI_DEVICE_AIRONET_4800 &&
-				device != PCI_DEVICE_AIRONET_4500 )
-                        continue;
-
 //		if (check_region(pci_ioaddr, AIRONET4X00_IO_SIZE) ||
 //			check_region(pci_cisaddr, AIRONET4X00_CIS_SIZE) ||
 //			check_region(pci_memaddr, AIRONET4X00_MEM_SIZE)) {
@@ -151,7 +132,7 @@
 
 		udelay(1000);
 */
-		if (device == PCI_DEVICE_AIRONET_4800)
+		if (pdev->device == PCI_DEVICE_AIRONET_4800)
 			pci_write_config_dword(pdev, 0x40, 0x40000000);
 
 		if (awc_pci_init(dev, pdev, pci_ioaddr,pci_cisaddr,pci_memaddr,pci_irq_line)){
diff -Nru a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
--- a/drivers/net/wan/lmc/lmc_main.c	Fri Oct  4 13:47:26 2002
+++ b/drivers/net/wan/lmc/lmc_main.c	Fri Oct  4 13:47:26 2002
@@ -1045,8 +1045,8 @@
     unsigned int pci_irq_line;
     u16 vendor, subvendor, device, subdevice;
     u32 foundaddr = 0;
-    unsigned char pci_bus, pci_device_fn;
     u8 intcf = 0;
+    struct pci_dev *pdev = NULL;
 
     /* The card is only available on PCI, so if we don't have a
      * PCI bus, we are in trouble.
@@ -1057,21 +1057,7 @@
         return -1;
     }
     /* Loop basically until we don't find anymore. */
-    while (pci_index < 0xff){
-    	struct pci_dev *pdev;
-        /* The tulip is considered an ethernet class of card... */
-        if (pcibios_find_class (PCI_CLASS_NETWORK_ETHERNET << 8,
-                                pci_index, &pci_bus,
-                                &pci_device_fn) != PCIBIOS_SUCCESSFUL) {
-            /* No card found on this pass */
-            break;
-        }
-        /* Read the info we need to determine if this is
-         * our card or not
-         */
-	pdev = pci_find_slot (pci_bus, pci_device_fn);
-	if (!pdev) break;
-
+    while ((pdev = pci_find_class (PCI_CLASS_NETWORK_ETHERNET << 8, pdev))) {
 	if (pci_enable_device(pdev))
 		break;
 
