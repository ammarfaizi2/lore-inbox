Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271704AbTG2WgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272134AbTG2WgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:36:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58385 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S271704AbTG2WgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:36:15 -0400
Date: Wed, 30 Jul 2003 00:29:59 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test2 wanXL driver
Message-ID: <20030730002959.A23749@electric-eye.fr.zoreil.com>
References: <m3lluhnj6e.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3lluhnj6e.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Tue, Jul 29, 2003 at 10:59:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> :
[...]
--- linux-2.6.orig/drivers/net/wan/wanxl.c	2003-07-29 19:21:04.000000000 +0200
+++ linux-2.6/drivers/net/wan/wanxl.c	2003-07-23 15:12:31.000000000 +0200
[...]
+static int wanxl_open(struct net_device *dev)
+{
+	hdlc_device *hdlc = dev_to_hdlc(dev);
+	port_t *port = hdlc_to_port(hdlc);
+	u8 *dbr = port->card->plx + PLX_DOORBELL_TO_CARD;
+	long start;
[...]
+	start = jiffies;
+	do
+		if (port->status.open)
+			return 0;
+	while (jiffies - start < HZ);

What about:

unsigned long timeout = jiffies + HZ;

do {
...
} while (time_after(timeout, jiffies));

[...]
+static int __devinit wanxl_pci_init_one(struct pci_dev *pdev,
+					const struct pci_device_id *ent)
+{
+	card_t *card;
+	u32 ramsize, stat;
+	long start;
+	u32 plx_phy;		/* PLX PCI base address */
+	u32 mem_phy;		/* memory PCI base addr */
+	u8 *mem;		/* memory virtual base addr */
+	int i, ports, alloc_size;
+
+	i = pci_enable_device(pdev);
+	if (i)
+		return i;
+
+	i = pci_request_regions(pdev, "wanXL");
+	if (i)
+		return i;
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_SBE_WANXL100: ports = 1; break;
+	case PCI_DEVICE_ID_SBE_WANXL200: ports = 2; break;
+	default: ports = 4;
+	}

You can do it this way:
static struct pci_device_id wanxl_pci_tbl[] __devinitdata = {
	{ PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL100, PCI_ANY_ID,
	  PCI_ANY_ID, 0, 0, 1 },
        { PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL200, PCI_ANY_ID,
          PCI_ANY_ID, 0, 0, 2 },
        { PCI_VENDOR_ID_SBE, PCI_DEVICE_ID_SBE_WANXL400, PCI_ANY_ID,
          PCI_ANY_ID, 0, 0, 4 },
        { 0, }
};

ports = ent->driver_data;

(imho turning 1, 2, 4 into #define wouldn't be bad then)

+
+	alloc_size = sizeof(card_t) + ports * sizeof(port_t);
+	card = kmalloc(alloc_size, GFP_KERNEL);
+	if (virt_to_bus(card) + alloc_size > 256 * 1024 * 1024) {
+		/* wanXL can only access first 256 MB */
+		kfree(card);
+		card = kmalloc(alloc_size, GFP_KERNEL | GFP_DMA);
+	}
+	if (card == NULL) {
+		pci_release_regions(pdev);
+		printk(KERN_ERR "wanXL %s: unable to allocate memory\n",
+		       card_name(pdev));
+		return -ENOBUFS;
+	}
+	memset(card, 0, alloc_size);
+
+	pci_set_drvdata(pdev, card);
+	card->pdev = pdev;
+	card->n_ports = ports;
+
+	/* set up PLX mapping */
+	plx_phy = pci_resource_start(pdev, 0);
+	card->plx = ioremap_nocache(plx_phy, 0x70);
+
+#if RESET_WHILE_LOADING
+	wanxl_reset(card);
+#endif
+
+	start = jiffies;
+	while ((stat = readl(card->plx + PLX_MAILBOX_0)) != 0) {
+		if (jiffies - start >= 20 * HZ) {
+			printk(KERN_WARNING "wanXL %s: timeout waiting for"
+			       " PUTS to complete\n", card_name(pdev));
+			return -ENODEV;

This return leaks kmalloced card_t *card, pci_requested_regions and
ioremaped area (same thing for the return a few lines below in the
same function).

[...]
+	for (i = 0; i < RX_QUEUE_LENGTH; i++) {
+		struct sk_buff *skb = dev_alloc_skb(BUFFER_LENGTH);
+		card->rx_skbs[i] = skb;
+		if (skb)
+			card->rx_descs[i].address = virt_to_bus(skb->data);

dma_map_single() is probably preferred over virt_to_bus().

Btw, you can use torvalds@osdl.org now.

Regards

--
Ueimor
