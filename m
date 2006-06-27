Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWF0Qjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWF0Qjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWF0QjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:39:07 -0400
Received: from ns2.suse.de ([195.135.220.15]:45546 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161185AbWF0Qh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:37:56 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 15/17] [PATCH] 64bit Resource: convert a few remaining drivers to use resource_size_t where needed
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 27 Jun 2006 09:33:51 -0700
Message-Id: <11514260843959-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <115142608072-git-send-email-greg@kroah.com>
References: <20060627163317.GA31073@kroah.com> <11514260331421-git-send-email-greg@kroah.com> <11514260373971-git-send-email-greg@kroah.com> <115142604066-git-send-email-greg@kroah.com> <11514260442539-git-send-email-greg@kroah.com> <11514260483754-git-send-email-greg@kroah.com> <11514260513485-git-send-email-greg@kroah.com> <11514260543854-git-send-email-greg@kroah.com> <11514260583661-git-send-email-greg@kroah.com> <11514260612035-git-send-email-greg@kroah.com> <11514260651070-git-send-email-greg@kroah.com> <11514260692919-git-send-email-greg@kroah.com> <11514260722341-git-send-email-greg@kroah.com> <11514260761750-git-send-email-greg@kroah.com> <115142608072-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Based on a patch series originally from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/ieee1394/ohci1394.c     |    2 +-
 drivers/isdn/hisax/hfc_pci.c    |    2 +-
 drivers/net/8139cp.c            |    2 +-
 drivers/pcmcia/rsrc_nonstatic.c |   14 +++++++-------
 drivers/serial/8250_pci.c       |    4 ++--
 drivers/usb/host/sl811-hcd.c    |   10 +++++++---
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index f0d5f2b..800c8d5 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -3217,7 +3217,7 @@ static int __devinit ohci1394_pci_probe(
 {
 	struct hpsb_host *host;
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
-	unsigned long ohci_base;
+	resource_size_t ohci_base;
 
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 91d25ac..3622720 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -1688,7 +1688,7 @@ #ifdef CONFIG_PCI
 				printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
 				return (0);
 			}
-			cs->hw.hfcpci.pci_io = (char *) dev_hfcpci->resource[ 1].start;
+			cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
 			printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
 		} else {
 			printk(KERN_WARNING "HFC-PCI: No PCI card found\n");
diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
index c1e1dc5..d26dd6a 100644
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -1823,7 +1823,7 @@ static int cp_init_one (struct pci_dev *
 	struct cp_private *cp;
 	int rc;
 	void __iomem *regs;
-	long pciaddr;
+	resource_size_t pciaddr;
 	unsigned int addr_len, i, pci_using_dac;
 	u8 pci_rev;
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index cc03130..c3176b1 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -72,7 +72,7 @@ #define MEM_PROBE_HIGH	(1 << 1)
 ======================================================================*/
 
 static struct resource *
-make_resource(unsigned long b, unsigned long n, int flags, char *name)
+make_resource(resource_size_t b, resource_size_t n, int flags, char *name)
 {
 	struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
 
@@ -86,8 +86,8 @@ make_resource(unsigned long b, unsigned 
 }
 
 static struct resource *
-claim_region(struct pcmcia_socket *s, unsigned long base, unsigned long size,
-	     int type, char *name)
+claim_region(struct pcmcia_socket *s, resource_size_t base,
+		resource_size_t size, int type, char *name)
 {
 	struct resource *res, *parent;
 
@@ -519,10 +519,10 @@ struct pcmcia_align_data {
 
 static void
 pcmcia_common_align(void *align_data, struct resource *res,
-		    unsigned long size, unsigned long align)
+			resource_size_t size, resource_size_t align)
 {
 	struct pcmcia_align_data *data = align_data;
-	unsigned long start;
+	resource_size_t start;
 	/*
 	 * Ensure that we have the correct start address
 	 */
@@ -533,8 +533,8 @@ pcmcia_common_align(void *align_data, st
 }
 
 static void
-pcmcia_align(void *align_data, struct resource *res,
-	     unsigned long size, unsigned long align)
+pcmcia_align(void *align_data, struct resource *res, resource_size_t size,
+		resource_size_t align)
 {
 	struct pcmcia_align_data *data = align_data;
 	struct resource_map *m;
diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 94886c0..864ef85 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -594,8 +594,8 @@ pci_default_setup(struct serial_private 
 	else
 		offset += idx * board->uart_offset;
 
-	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) /
-		(8 << board->reg_shift);
+	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
 
 	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
 		return 1;
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 6b4bc3f..89bcda5 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1684,9 +1684,13 @@ sl811h_probe(struct platform_device *dev
 		if (!addr || !data)
 			return -ENODEV;
 		ioaddr = 1;
-
-		addr_reg = (void __iomem *) addr->start;
-		data_reg = (void __iomem *) data->start;
+		/*
+		 * NOTE: 64-bit resource->start is getting truncated
+		 * to avoid compiler warning, assuming that ->start
+		 * is always 32-bit for this case
+		 */
+		addr_reg = (void __iomem *) (unsigned long) addr->start;
+		data_reg = (void __iomem *) (unsigned long) data->start;
 	} else {
 		addr_reg = ioremap(addr->start, 1);
 		if (addr_reg == NULL) {
-- 
1.4.0

