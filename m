Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRI3WiA>; Sun, 30 Sep 2001 18:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273888AbRI3Whv>; Sun, 30 Sep 2001 18:37:51 -0400
Received: from bart.one-2-one.net ([195.94.80.12]:21264 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S273881AbRI3Whh>; Sun, 30 Sep 2001 18:37:37 -0400
Date: Mon, 1 Oct 2001 00:40:10 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] yet another yenta resource allocation fix
Message-ID: <Pine.LNX.4.21.0110010001520.746-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

I'm asking for application of a patch I'm using since 2.4.0. Issue was the
BIOS of my OB-800 mapped the memory regions of the cardbus bridges into
legacy 1M-area (0xe6000 e.g.). Despite being pretty bogus this used to
work after a reboot just until the first pm-suspend/resume, where the
hostbridge somehow looses access to this area.

Following your suggestion, I've modified pci_socket.c to detect and fix
the wrong mapping. However, I'm not sure whether there is some general
rule if such fixes should be considered cardbus-specific or general
pci-quirks.

Anyway, the patch vs. 2.4.10 below intercepts the cardbus_probe() path to
detect and fix this before any yenta socket gets opened - which would call
pci_enable_device(). Works for me for months now, so I'd like to suggest
to have it included.

Regards
Martin

----------------------

--- linux-2.4.10/drivers/pcmcia/pci_socket.c	Sat Aug  4 13:20:45 2001
+++ v2.4.10-md/drivers/pcmcia/pci_socket.c	Sun Sep 30 19:11:18 2001
@@ -169,6 +169,72 @@
 	pci_proc_setup
 };
 
+/* BIOS might have mapped the cardbus memory resource to a bogus location
+ * in legacy memory area and the hostbridge somehow looses this window
+ * after pm-suspend (seen on OB800).
+ * We try to detect and fix this by re-assigning the resource if we
+ * find it mapped to legacy area <1M. But we don't try, if the obsolete
+ * MEM_TYPE_1M flag is set, just in case...
+ * Question remains, whether this quirk is cardbus-specific or general PCI.
+ */
+
+static void __devinit cardbus_validate_bar(struct pci_dev *dev)
+{
+	unsigned long	oldstart;
+	u32		temp, extend;
+	struct resource	*res;
+
+	if (!(dev->resource[0].flags&IORESOURCE_MEM))	/* not cardbus memory BAR */
+		return;
+
+	oldstart = dev->resource[0].start;
+	if (oldstart >= 0x00100000UL)		/* not 1MB legacy area - fine! */
+		return;
+
+	/* we need the device powered but not yet enabled */
+
+	pci_set_power_state(dev,0);
+
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	if (temp & PCI_BASE_ADDRESS_MEM_TYPE_1M) {
+		printk(KERN_DEBUG "%s: cardbus memory has obsolete 1M flag set?\n",
+			__FUNCTION__);
+		return;
+	}
+
+	/* re-read required size and flags from device */
+
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0xffffffff);
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	if (temp & PCI_BASE_ADDRESS_SPACE_IO) {	/* paranoia */
+		pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, oldstart);
+		printk(KERN_WARNING "%s: cardbus memory mutated to io?\n",
+			__FUNCTION__);
+		return;
+	}
+	extend = ~(u32)(temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* Old values lost in case of failure (pretty unlikely anyway).
+	 * Could we simply save & restore the content without acquiring the
+	 * resource list lock (which is private in kernel/resource.c)?
+	 */
+
+	res = &dev->resource[0];
+	release_resource(res);
+
+	res->name = dev->name;
+	res->start = 0;
+	res->end = res->start + extend;
+	res->flags = IORESOURCE_MEM;
+	if (temp & PCI_BASE_ADDRESS_MEM_PREFETCH)
+		res->flags |= IORESOURCE_PREFETCH;
+	res->parent = res->child = res->sibling = NULL;
+	pci_assign_resource(dev,0);
+
+	printk(KERN_INFO "%s: cardbus memory mapping fixed: %08lx --> %08lx\n",
+		__FUNCTION__, oldstart, dev->resource[0].start);
+}
+
 static int __devinit add_pci_socket(int nr, struct pci_dev *dev, struct pci_socket_ops *ops)
 {
 	pci_socket_t *socket = nr + pci_socket_array;
@@ -179,6 +245,10 @@
 	socket->op = ops;
 	dev->driver_data = socket;
 	spin_lock_init(&socket->event_lock);
+
+	/* make sure the resource mapping is right, before it gets opened */
+	cardbus_validate_bar(dev);
+
 	err = socket->op->open(socket);
 	if(err)
 	{

