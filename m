Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318847AbSHLVDs>; Mon, 12 Aug 2002 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318848AbSHLVDs>; Mon, 12 Aug 2002 17:03:48 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:57014 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318847AbSHLVDq>; Mon, 12 Aug 2002 17:03:46 -0400
Date: Mon, 12 Aug 2002 14:07:30 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: dhinds <dhinds@sonic.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Fix CardBus bridge behind a PCI bridge
Message-ID: <20020812140730.A21710@lucon.org>
References: <20020806112636.A29360@sonic.net> <20020806130420.A19613@lucon.org> <20020809160506.A19549@sonic.net> <20020809164835.B21110@lucon.org> <20020809172140.A30911@sonic.net> <20020810222355.A13749@lucon.org> <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020812122158.A27172@sonic.net>; from dhinds@sonic.net on Mon, Aug 12, 2002 at 12:21:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2002 at 12:21:58PM -0700, dhinds wrote:
> On Mon, Aug 12, 2002 at 11:29:11AM -0700, H. J. Lu wrote:
> > 
> > > what does "positive decode" mean in this context?  Does the bridge
> > > somehow figure out that if no other device claims a transaction, that
> > > it should do so?
> > 
> > I am not a PCI expert. As I understand, if a PCI bridge does negative
> > decode, you don't need to do it for the CardBus bride behind it. I
> > guess it is only needed for positive decode. For some reason, a PCI
> > bridge with positive decode may pass address to the CardBus bridge
> > behind it or the CardBus bridge has some back door to the PCI bus.
> 
> I pulled up the datasheet for this chip and now I think maybe I
> understand what's going on.
> 
> It says that the PCI-to-PCI bridge function in this chip forwards all
> transactions to the external PCI bus.  The bridge windows determine
> ranges of addresses which it may claim back as a target, in this case
> I guess just for the LAN function, which is the only integrated device
> on bus 2.
> 
> So this actually seems to be effectively a transparent bridge.
> 

How about this pacth? It works for me.


H.J.

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-yenta-bridge.patch"

--- linux/drivers/pcmcia/yenta.c.bridge	Sat Aug 10 20:30:35 2002
+++ linux/drivers/pcmcia/yenta.c	Mon Aug 12 14:00:38 2002
@@ -706,7 +706,8 @@ static int yenta_suspend(pci_socket_t *s
 
 static void yenta_allocate_res(pci_socket_t *socket, int nr, unsigned type)
 {
-	struct pci_bus *bus;
+	struct pci_bus *bus, *parent;
+	struct pci_dev *bridge;
 	struct resource *root, *res;
 	u32 start, end;
 	u32 align, size, min, max;
@@ -739,17 +740,43 @@ static void yenta_allocate_res(pci_socke
 		return;
 	}
 
-	align = size = 4*1024*1024;
-	min = PCIBIOS_MIN_MEM; max = ~0U;
 	if (type & IORESOURCE_IO) {
 		align = 1024;
 		size = 256;
 		min = 0x4000;
 		max = 0xffff;
 	}
+	else {
+		align = size = 4*1024*1024;
+		min = PCIBIOS_MIN_MEM;
+		max = ~0U;
+	}
 		
-	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0)
+
+	/* We check if we are behind an Intel 82801BAM/CAM PCI bridge
+	   which is a transparent bridge for us. We just allocate
+	   resources from its parent.  */
+	parent = bus->parent;
+	if (parent != NULL) {
+		bridge = parent->self;
+		if (bridge != NULL
+		    && (bridge->class >> 8) == PCI_CLASS_BRIDGE_PCI
+		    && bridge->vendor == PCI_VENDOR_ID_INTEL
+		    && bridge->device >= PCI_DEVICE_ID_INTEL_82801BA_0
+		    && bridge->device <= PCI_DEVICE_ID_INTEL_82801BA_11) {
+			res->name = bridge->subordinate->name;
+			root = pci_find_parent_resource(bridge, res);
+		}
+	}
+
+	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0) {
+		printk (KERN_NOTICE "PCI: CardBus bridge (%04x:%04x, %04x:%04x): Failed to allocate %s resource: %d bytes!\n",
+			socket->dev->vendor, socket->dev->device,
+			socket->dev->subsystem_vendor,
+			socket->dev->subsystem_device,
+			(type & IORESOURCE_IO) ? "I/O" : "memory", size);
 		return;
+	}
 
 	config_writel(socket, offset, res->start);
 	config_writel(socket, offset+4, res->end);

--vkogqOf2sHV7VnPd--
