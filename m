Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318773AbSHLRpU>; Mon, 12 Aug 2002 13:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318775AbSHLRpU>; Mon, 12 Aug 2002 13:45:20 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:57025 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318773AbSHLRpS>; Mon, 12 Aug 2002 13:45:18 -0400
Date: Mon, 12 Aug 2002 10:49:02 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: dhinds <dhinds@sonic.net>, bombe@informatik.tu-muenchen.de
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Fix CardBus bridge behind a PCI bridge
Message-ID: <20020812104902.A18430@lucon.org>
References: <20020806105023.A17451@lucon.org> <20020806112636.A29360@sonic.net> <20020806130420.A19613@lucon.org> <20020809160506.A19549@sonic.net> <20020809164835.B21110@lucon.org> <20020809172140.A30911@sonic.net> <20020810222355.A13749@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020810222355.A13749@lucon.org>; from hjl@lucon.org on Sat, Aug 10, 2002 at 10:23:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 10, 2002 at 10:23:55PM -0700, H. J. Lu wrote:
> On Fri, Aug 09, 2002 at 05:21:40PM -0700, dhinds wrote:
> > On Fri, Aug 09, 2002 at 04:48:35PM -0700, H. J. Lu wrote:
> > > On Fri, Aug 09, 2002 at 04:05:06PM -0700, dhinds wrote:
> > > > There's a current thread on linux-kernel about "PCI hotplug resource
> > > > reservation" that is relevant, and there's a patch that claims to
> > > > provide a workable solution to the problem for cPCI.
> > > 
> > > Thanks. Do you think if the "PCI<->PCI bridges, transparent resource
> > > fix" thread is related to it?
> > 
> > I glanced at that and didn't think so, but I didn't read much.
> > 
> 
> I think they are relevant. Your pcmcia-cs 3.20 works fine on Sony. Here
> is the output of "lspci -v". PCI bride has
> 
> 	I/O behind bridge: 00004000-00004fff
> 	Memory behind bridge: e8200000-e82fffff
> 
> The kernel cardbus code tries to allocate memory and I/O from them. It
> doesn't work. BTW, I checked another notebook. That code is not reached
> at all since slot has been initialized by BIOS. Your pcmcia-cs doesn't
> follow the PCI brigde:
> 
> 	I/O ports at 0200
> 	Memory at 60040000 (32-bit, non-prefetchable)
> 
> and works. Any ides why?
> 

Here is a patch against 2.4.18 to fix CardBus bridge behind a PCI
bridge with positive decode. I checked Windows XP. It is how it
allocates resources for the CardBus slots, that is outside of
the memory and I/O windows on the PCI bridge.

Let me know if it works for you. 


H.J.

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.18-yenta-bridge.patch"

--- linux/drivers/pcmcia/yenta.c.bridge	Sat Aug 10 20:30:35 2002
+++ linux/drivers/pcmcia/yenta.c	Mon Aug 12 10:41:56 2002
@@ -712,6 +712,7 @@ static void yenta_allocate_res(pci_socke
 	u32 align, size, min, max;
 	unsigned offset;
 	unsigned mask;
+	int failed;
 
 	/* The granularity of the memory limit is 4kB, on IO it's 4 bytes */
 	mask = ~0xfff;
@@ -739,17 +740,39 @@ static void yenta_allocate_res(pci_socke
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
-		return;
+
+	do {
+		failed = allocate_resource(root, res, size, min, max,
+					   align, NULL, NULL);
+		if (failed) {
+			/* If we failed to allocate the resources here, we
+			   try its parent if we are on a bridge with
+			   positive decode.  */
+			struct pci_dev *bridge;
+			bus = bus->parent;
+			if (bus == NULL)
+				return;
+			bridge = bus->self;
+			if (bridge == NULL
+			    || (bridge->class >> 16) != PCI_BASE_CLASS_BRIDGE
+			    || (bridge->class & 0xff) != 0)
+				return;
+			res->name = bridge->subordinate->name;
+			root = pci_find_parent_resource(bridge, res);
+		}
+	} while (failed);
 
 	config_writel(socket, offset, res->start);
 	config_writel(socket, offset+4, res->end);

--pWyiEgJYm5f9v55/--
