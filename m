Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSFNUHg>; Fri, 14 Jun 2002 16:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFNUHf>; Fri, 14 Jun 2002 16:07:35 -0400
Received: from maile.telia.com ([194.22.190.16]:16875 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S314082AbSFNUHe>;
	Fri, 14 Jun 2002 16:07:34 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@osdl.org>, Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.44.0206141134210.872-100000@home.transmeta.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jun 2002 22:07:24 +0200
Message-ID: <m2hek5aakj.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> > PCI: Scanning for ghost devices on bus 1
> > Unknown bridge resource 0: assuming transparent
> > Unknown bridge resource 1: assuming transparent
> > Unknown bridge resource 2: assuming transparent
> 
> This is the problem.
> 
> The PCI code thinks that the parent of the network device doesn't have
> resources allocated, so it will allocate the resources from the parent of
> the parent.
> 
> Which is wrong, since it means that it will try to allocate the PCI
> resources from outside the window that the cardbus controller is
> exporting. Resulting in the fffff stuff.
> 
> HOWEVER, I don't see why that happens. yenta_allocate_resources() should
> have made absolutely certain that we have all the necessary bridge
> resources clearly allocated. Can you add debug code to the end of
> "yenta_allocate_res()" that prints out the resource that got allocated?

I added a bunch of printk statements, see patch at the end for
details. Here is the output:


Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
IRQ for 00:0a.0:0 -> PIRQ 60, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=10 -> assigning IRQ 10 -> edge ... OK
PCI: Assigned IRQ 10 for device 00:0a.0
yenta_allocate_res: nr=0 type=0x1200
yenta_allocate_res: root->name=PCI mem
yenta_allocate_res: size=0x400000 min=0x10000000 max=0xffffffff align=0x400000, ret=0
yenta_allocate_res: res=c11e6de4 name=PCI CardBus #01 start=0x10400000 end=0x107fffff flags=0x1200
yenta_allocate_res: parent=c0251e7c sibling=c11e6920 child=00000000
yenta_allocate_res: parent=PCI mem sibling=S3 Inc. ViRGE/MX child=
yenta_allocate_res: nr=1 type=0x200
yenta_allocate_res: root->name=PCI mem
yenta_allocate_res: size=0x400000 min=0x10000000 max=0xffffffff align=0x400000, ret=0
yenta_allocate_res: res=c11e6e00 name=PCI CardBus #01 start=0x10800000 end=0x10bfffff flags=0x200
yenta_allocate_res: parent=c0251e7c sibling=c11e6920 child=00000000
yenta_allocate_res: parent=PCI mem sibling=S3 Inc. ViRGE/MX child=
yenta_allocate_res: nr=2 type=0x100
yenta_allocate_res: root->name=PCI IO
yenta_allocate_res: size=0x100 min=0x4000 max=0xffff align=0x400, ret=0
yenta_allocate_res: res=c11e6e1c name=PCI CardBus #01 start=0x4000 end=0x40ff flags=0x100
yenta_allocate_res: parent=c0251e60 sibling=c11e6190 child=00000000
yenta_allocate_res: parent=PCI IO sibling=Intel Corp. 82371AB PIIX4 USB child=
yenta_allocate_res: nr=3 type=0x100
yenta_allocate_res: root->name=PCI IO
yenta_allocate_res: size=0x100 min=0x4000 max=0xffff align=0x400, ret=0
yenta_allocate_res: res=c11e6e38 name=PCI CardBus #01 start=0x4400 end=0x44ff flags=0x100
yenta_allocate_res: parent=c0251e60 sibling=c11e6190 child=00000000
yenta_allocate_res: parent=PCI IO sibling=Intel Corp. 82371AB PIIX4 USB child=
IRQ for 00:0a.1:1 -> PIRQ 61, mask 0400, excl 0000<4>PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
 -> newirq=10 -> assigning IRQ 10 ... OK
PCI: Assigned IRQ 10 for device 00:0a.1
yenta_allocate_res: nr=0 type=0x1200
yenta_allocate_res: root->name=PCI mem
yenta_allocate_res: size=0x400000 min=0x10000000 max=0xffffffff align=0x400000, ret=0
yenta_allocate_res: res=c11df1e4 name=PCI CardBus #05 start=0x10c00000 end=0x10ffffff flags=0x1200
yenta_allocate_res: parent=c0251e7c sibling=c11e6920 child=00000000
yenta_allocate_res: parent=PCI mem sibling=S3 Inc. ViRGE/MX child=
yenta_allocate_res: nr=1 type=0x200
yenta_allocate_res: root->name=PCI mem
yenta_allocate_res: size=0x400000 min=0x10000000 max=0xffffffff align=0x400000, ret=0
yenta_allocate_res: res=c11df200 name=PCI CardBus #05 start=0x11000000 end=0x113fffff flags=0x200
yenta_allocate_res: parent=c0251e7c sibling=c11e6920 child=00000000
yenta_allocate_res: parent=PCI mem sibling=S3 Inc. ViRGE/MX child=
yenta_allocate_res: nr=2 type=0x100
yenta_allocate_res: root->name=PCI IO
yenta_allocate_res: size=0x100 min=0x4000 max=0xffff align=0x400, ret=0
yenta_allocate_res: res=c11df21c name=PCI CardBus #05 start=0x4800 end=0x48ff flags=0x100
yenta_allocate_res: parent=c0251e60 sibling=c11e6190 child=00000000
yenta_allocate_res: parent=PCI IO sibling=Intel Corp. 82371AB PIIX4 USB child=
yenta_allocate_res: nr=3 type=0x100
yenta_allocate_res: root->name=PCI IO
yenta_allocate_res: size=0x100 min=0x4000 max=0xffff align=0x400, ret=0
yenta_allocate_res: res=c11df238 name=PCI CardBus #05 start=0x4c00 end=0x4cff flags=0x100
yenta_allocate_res: parent=c0251e60 sibling=c11e6190 child=00000000
yenta_allocate_res: parent=PCI IO sibling=Intel Corp. 82371AB PIIX4 USB child=
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.0 (512 buckets, 4096 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000068
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000006
cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
Scanning bus 01
Found 01:00 [13d1/ab02] 000200 00
PCI: Calling quirk c01d57b0 for 01:00.0
Fixups for bus 01
PCI: Scanning for ghost devices on bus 1
pci_read_bridge_bases 0: res=c11e6de4 name=PCI CardBus #01 base=0x0 limit=0x0
Unknown bridge resource 0: assuming transparent
pci_read_bridge_bases 1: res=c11e6e00 name=PCI CardBus #01 base=0xf0000000 limit=0x10700000
Unknown bridge resource 1: assuming transparent
pci_read_bridge_bases 2: res=c11e6e1c name=PCI CardBus #01 base=0x0 limit=0x10800000
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
  got res[1800:18ff] for resource 0 of PCI device 13d1:ab02 (Abocom Systems Inc)
  got res[10002000:100023ff] for resource 1 of PCI device 13d1:ab02 (Abocom Systems Inc)
  got res[10020000:1003ffff] for resource 6 of PCI device 13d1:ab02 (Abocom Systems Inc)
PCI: Enabling device 01:00.0 (0000 -> 0003)
IRQ for 01:00.0:0 -> not found in routing table
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
INIT: version 2.78 booting



--- linux/drivers/pcmcia/yenta.c.old	Fri Jun 14 22:02:08 2002
+++ linux/drivers/pcmcia/yenta.c	Fri Jun 14 21:39:38 2002
@@ -709,6 +709,9 @@
 	u32 align, size, min, max;
 	unsigned offset;
 	unsigned mask;
+	int ret;
+
+	printk("yenta_allocate_res: nr=%d type=0x%x\n", nr, type);
 
 	/* The granularity of the memory limit is 4kB, on IO it's 4 bytes */
 	mask = ~0xfff;
@@ -727,6 +730,8 @@
 	if (!root)
 		return;
 
+	printk("yenta_allocate_res: root->name=%s\n", root->name);
+
 	start = config_readl(socket, offset) & mask;
 	end = config_readl(socket, offset+4) | ~mask;
 	if (start && end > start) {
@@ -745,9 +750,21 @@
 		max = 0xffff;
 	}
 		
-	if (allocate_resource(root, res, size, min, max, align, NULL, NULL) < 0)
+	ret = allocate_resource(root, res, size, min, max, align, NULL, NULL);
+	printk("yenta_allocate_res: size=0x%x min=0x%x max=0x%x align=0x%x, ret=%d\n",
+	       size, min, max, align, ret);
+	if (ret < 0)
 		return;
 
+	printk("yenta_allocate_res: res=%p name=%s start=0x%lx end=0x%lx flags=0x%lx\n",
+	       res, res->name, res->start, res->end, res->flags);
+	printk("yenta_allocate_res: parent=%p sibling=%p child=%p\n",
+	       res->parent, res->sibling, res->child);
+	printk("yenta_allocate_res: parent=%s sibling=%s child=%s\n",
+	       res->parent ? res->parent->name : "",
+	       res->sibling ? res->sibling->name : "",
+	       res->child ? res->child->name : "");
+
 	config_writel(socket, offset, res->start);
 	config_writel(socket, offset+4, res->end);
 }
--- linux/drivers/pci/probe.c.old	Fri Jun 14 22:01:21 2002
+++ linux/drivers/pci/probe.c	Fri Jun 14 21:33:32 2002
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#undef DEBUG
+#define DEBUG
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)
@@ -145,6 +145,8 @@
 		limit |= (io_limit_hi << 16);
 	}
 
+	printk("pci_read_bridge_bases 0: res=%p name=%s base=0x%lx limit=0x%lx\n",
+	       res, res ? res->name : "", base, limit);
 	if (base && base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
@@ -163,6 +165,8 @@
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
 	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
+	printk("pci_read_bridge_bases 1: res=%p name=%s base=0x%lx limit=0x%lx\n",
+	       res, res ? res->name : "", base, limit);
 	if (base && base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
@@ -193,6 +197,8 @@
 		}
 #endif
 	}
+	printk("pci_read_bridge_bases 2: res=%p name=%s base=0x%lx limit=0x%lx\n",
+	       res, res ? res->name : "", base, limit);
 	if (base && base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		res->start = base;

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
