Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318921AbSHMDZ7>; Mon, 12 Aug 2002 23:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318922AbSHMDZ6>; Mon, 12 Aug 2002 23:25:58 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:45206 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318921AbSHMDZ5>; Mon, 12 Aug 2002 23:25:57 -0400
Date: Mon, 12 Aug 2002 20:29:42 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: dhinds <dhinds@sonic.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: New fix for CardBus bridge behind a PCI bridge
Message-ID: <20020812202942.A27362@lucon.org>
References: <20020809160506.A19549@sonic.net> <20020809164835.B21110@lucon.org> <20020809172140.A30911@sonic.net> <20020810222355.A13749@lucon.org> <20020812104902.A18430@lucon.org> <20020812110431.A14125@sonic.net> <20020812112911.A18947@lucon.org> <20020812122158.A27172@sonic.net> <20020812140730.A21710@lucon.org> <20020812154851.A20073@sonic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020812154851.A20073@sonic.net>; from dhinds@sonic.net on Mon, Aug 12, 2002 at 03:48:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2002 at 03:48:51PM -0700, dhinds wrote:
> I guess the advantage of your original patch is that I think it should
> never hurt, and will help in any situation where a PCI bridge actually
> is transparent.
> 

I was told all PCI_CLASS_BRIDGE_PCI bridges were transparent. The non-
transparent ones have class code PCI_CLASS_BRIDGE_OTHER. This new patch
only checks PCI_CLASS_BRIDGE_PCI and works for me.


H.J.

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-yenta-bridge.patch"

--- linux/drivers/pcmcia/yenta.c.bridge	Sat Aug 10 20:30:35 2002
+++ linux/drivers/pcmcia/yenta.c	Mon Aug 12 20:06:16 2002
@@ -706,7 +706,8 @@ static int yenta_suspend(pci_socket_t *s
 
 static void yenta_allocate_res(pci_socket_t *socket, int nr, unsigned type)
 {
-	struct pci_bus *bus;
+	struct pci_bus *bus, *parent;
+	struct pci_dev *bridge;
 	struct resource *root, *res;
 	u32 start, end;
 	u32 align, size, min, max;
@@ -739,17 +740,38 @@ static void yenta_allocate_res(pci_socke
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
+	/* We check if we are behind a transparent PCI bridge. If yes,
+	   we just allocate resources from its parent.  */
+	for (parent = bus->parent; parent != NULL; parent = parent->parent) {
+		bridge = parent->self;
+		if (bridge != NULL
+		    && (bridge->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
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

--0OAP2g/MAC+5xKAE--
