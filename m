Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSKVWbS>; Fri, 22 Nov 2002 17:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSKVWbS>; Fri, 22 Nov 2002 17:31:18 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:61117 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265333AbSKVWbF>;
	Fri, 22 Nov 2002 17:31:05 -0500
Message-ID: <3DDEB193.1000706@us.ibm.com>
Date: Fri, 22 Nov 2002 14:37:07 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export e820 table on x86
References: <Pine.LNX.4.44.0211212355060.7728-100000@home.transmeta.com> <m17kf5zfqj.fsf@frodo.biederman.org>
Content-Type: multipart/mixed;
 boundary="------------030802030504010903030202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030802030504010903030202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's take one of the 64-bit resources.  resource->flags seems to be 
used often to mask out things in resource->start/end, so I think it 
needs to be u64 too.  But, Is it all right to let things like 
pcibios_update_resource() truncate the resource addresses like they do?

With my config, it has no more warnings than it did before.

Here's /proc/iomem from a 16-gig ia32 box with the patch:

0000000000000000-000000000009c7ff : System RAM
000000000009c800-000000000009ffff : reserved
00000000000a0000-00000000000bffff : Video RAM area
00000000000c0000-00000000000c7fff : Video ROM
00000000000c8000-00000000000cc7ff : Extension ROM
00000000000cc800-00000000000d47ff : Extension ROM
00000000000d4800-00000000000d5fff : Extension ROM
00000000000f0000-00000000000fffff : System ROM
0000000000100000-00000000efff64ff : System RAM
   0000000000100000-000000000029fe78 : Kernel code
   000000000029fe79-0000000000395d7f : Kernel data
00000000efff6500-00000000efffffff : ACPI Tables
00000000f8000000-00000000fbffffff : S3 Inc. Trio 64 3D
00000000fc1e0000-00000000fc1effff : PCI device 1014:00dc (IBM)
00000000fc1fd000-00000000fc1fdfff : Adaptec AIC-7896U2/7897U2 (#2)
   00000000fc1fd000-00000000fc1fdfff : aic7xxx
00000000fc1fe000-00000000fc1fefff : Adaptec AIC-7896U2/7897U2
   00000000fc1fe000-00000000fc1fefff : aic7xxx
00000000fc1ffc00-00000000fc1ffcff : PCI device 1014:00dc (IBM)
00000000fd7c0000-00000000fd7dffff : Intel Corp. 82557/8/9 [Ethernet
00000000fd7fcc00-00000000fd7fcc7f : Digital Equipment Co DECchip 21140
   00000000fd7fcc00-00000000fd7fcc7f : tulip
00000000fd7fd000-00000000fd7fdfff : Intel Corp. 82557/8/9 [Ethernet
   00000000fd7fd000-00000000fd7fdfff : eepro100
00000000fd7fe000-00000000fd7fffff : IBM Netfinity ServeRAID
   00000000fd7fe000-00000000fd7fffff : ips
00000000fe1c0000-00000000fe1dffff : Intel Corp. 82546EB Gigabit Ethe
   00000000fe1c0000-00000000fe1dffff : e1000
00000000fe1e0000-00000000fe1fffff : Intel Corp. 82546EB Gigabit Ethe
   00000000fe1e0000-00000000fe1fffff : e1000
00000000fffb0000-00000000ffffffff : reserved
0000000100000000-00000003ffffffff : System RAM



-- 
Dave Hansen
haveblue@us.ibm.com

--------------030802030504010903030202
Content-Type: text/plain;
 name="64-bit-resource-2.5.49-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="64-bit-resource-2.5.49-0.patch"

diff -Nru a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
--- a/arch/alpha/kernel/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/alpha/kernel/pci.c	Fri Nov 22 14:32:09 2002
@@ -149,12 +149,12 @@
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	struct pci_dev *dev = data;
 	struct pci_controller *hose = dev->sysdata;
-	unsigned long alignto;
-	unsigned long start = res->start;
+	u64 alignto;
+	u64 start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
 		/* Make sure we start at our min on all hoses */
diff -Nru a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
--- a/arch/arm/kernel/bios32.c	Fri Nov 22 14:32:09 2002
+++ b/arch/arm/kernel/bios32.c	Fri Nov 22 14:32:09 2002
@@ -268,7 +268,7 @@
 	int reg;
 
 	if (debug_pci)
-		printk("PCI: Assigning %3s %08lx to %s\n",
+		printk("PCI: Assigning %3s %016Lx to %s\n",
 			res->flags & IORESOURCE_IO ? "IO" : "MEM",
 			res->start, dev->dev.name);
 
@@ -585,9 +585,9 @@
  * which might be mirrored at 0x0100-0x03ff..
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
-	unsigned long start = res->start;
+	u64 start = res->start;
 
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Fri Nov 22 14:32:10 2002
+++ b/arch/i386/kernel/setup.c	Fri Nov 22 14:32:10 2002
@@ -798,15 +798,18 @@
 	probe_roms();
 	for (i = 0; i < e820.nr_map; i++) {
 		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
+		
+		//if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
+		//	continue;
+	
 		res = alloc_bootmem_low(sizeof(struct resource));
 		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
+		case E820_RAM:	res->name = "System RAM e820"; break;
+		case E820_ACPI:	res->name = "ACPI Tables e820"; break;
+		case E820_NVS:	res->name = "ACPI Non-volatile Storage e820"; break;
+		default:	res->name = "reserved e820";
 		}
+		res->type = e820.map[i].type;
 		res->start = e820.map[i].addr;
 		res->end = res->start + e820.map[i].size - 1;
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
diff -Nru a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c	Fri Nov 22 14:32:09 2002
+++ b/arch/i386/pci/i386.c	Fri Nov 22 14:32:09 2002
@@ -76,10 +76,10 @@
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
@@ -167,7 +167,7 @@
 			else
 				disabled = !(command & PCI_COMMAND_MEMORY);
 			if (pass == disabled) {
-				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
+				DBG("PCI: Resource %016Lx-%016Lx (f=%Lx, d=%d, p=%d)\n",
 				    r->start, r->end, r->flags, disabled, pass);
 				pr = pci_find_parent_resource(dev, r);
 				if (!pr || request_resource(pr, r) < 0) {
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/ia64/pci/pci.c	Fri Nov 22 14:32:09 2002
@@ -151,7 +151,8 @@
 pcibios_update_resource (struct pci_dev *dev, struct resource *root,
 			 struct resource *res, int resource)
 {
-	unsigned long where, size;
+	unsigned long where
+	u64 size;
 	u32 reg;
 
 	where = PCI_BASE_ADDRESS_0 + (resource * 4);
@@ -229,7 +230,7 @@
 
 void
 pcibios_align_resource (void *data, struct resource *res,
-		        unsigned long size, unsigned long align)
+		        u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/mips/ddb5074/pci.c b/arch/mips/ddb5074/pci.c
--- a/arch/mips/ddb5074/pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips/ddb5074/pci.c	Fri Nov 22 14:32:10 2002
@@ -373,12 +373,12 @@
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		/* We need to avoid collisions with `mirrored' VGA ports
 		   and other strange ISA hardware, so we always want the
diff -Nru a/arch/mips/ddb5476/pci.c b/arch/mips/ddb5476/pci.c
--- a/arch/mips/ddb5476/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/mips/ddb5476/pci.c	Fri Nov 22 14:32:09 2002
@@ -431,12 +431,12 @@
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		/* We need to avoid collisions with `mirrored' VGA ports
 		   and other strange ISA hardware, so we always want the
diff -Nru a/arch/mips/ddb5xxx/common/pci.c b/arch/mips/ddb5xxx/common/pci.c
--- a/arch/mips/ddb5xxx/common/pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips/ddb5xxx/common/pci.c	Fri Nov 22 14:32:10 2002
@@ -165,7 +165,7 @@
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	/* this should not be called */
 	MIPS_ASSERT(1 == 0);
diff -Nru a/arch/mips/gt64120/common/pci.c b/arch/mips/gt64120/common/pci.c
--- a/arch/mips/gt64120/common/pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips/gt64120/common/pci.c	Fri Nov 22 14:32:10 2002
@@ -819,12 +819,12 @@
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		/* We need to avoid collisions with `mirrored' VGA ports
 		   and other strange ISA hardware, so we always want the
diff -Nru a/arch/mips/ite-boards/generic/it8172_pci.c b/arch/mips/ite-boards/generic/it8172_pci.c
--- a/arch/mips/ite-boards/generic/it8172_pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips/ite-boards/generic/it8172_pci.c	Fri Nov 22 14:32:10 2002
@@ -183,7 +183,7 @@
 
 void __init
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
     printk("pcibios_align_resource\n");
 }
diff -Nru a/arch/mips/kernel/pci.c b/arch/mips/kernel/pci.c
--- a/arch/mips/kernel/pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips/kernel/pci.c	Fri Nov 22 14:32:10 2002
@@ -162,7 +162,7 @@
 
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	/* this should not be called */
 }
diff -Nru a/arch/mips/mips-boards/generic/pci.c b/arch/mips/mips-boards/generic/pci.c
--- a/arch/mips/mips-boards/generic/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/mips/mips-boards/generic/pci.c	Fri Nov 22 14:32:09 2002
@@ -232,7 +232,7 @@
 
 void __init
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/mips/sni/pci.c b/arch/mips/sni/pci.c
--- a/arch/mips/sni/pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips/sni/pci.c	Fri Nov 22 14:32:10 2002
@@ -180,7 +180,7 @@
 
 void __init
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/mips64/mips-boards/generic/pci.c b/arch/mips64/mips-boards/generic/pci.c
--- a/arch/mips64/mips-boards/generic/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/mips64/mips-boards/generic/pci.c	Fri Nov 22 14:32:09 2002
@@ -291,7 +291,7 @@
 
 void __init
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/mips64/sgi-ip27/ip27-pci.c b/arch/mips64/sgi-ip27/ip27-pci.c
--- a/arch/mips64/sgi-ip27/ip27-pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips64/sgi-ip27/ip27-pci.c	Fri Nov 22 14:32:10 2002
@@ -249,7 +249,7 @@
 
 void __init
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/mips64/sgi-ip32/ip32-pci.c b/arch/mips64/sgi-ip32/ip32-pci.c
--- a/arch/mips64/sgi-ip32/ip32-pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/mips64/sgi-ip32/ip32-pci.c	Fri Nov 22 14:32:10 2002
@@ -329,7 +329,7 @@
 }
 
 void __init pcibios_align_resource (void *data, struct resource *res,
-				    unsigned long size, unsigned long align)
+				    u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
--- a/arch/parisc/kernel/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/parisc/kernel/pci.c	Fri Nov 22 14:32:09 2002
@@ -392,11 +392,11 @@
 */
 void __devinit
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long alignment)
+		       u64 size, u64 alignment)
 {
-	unsigned long mask, align;
+	u64 mask, align;
 
-	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
+	DBG_RES("pcibios_align_resource(%s, (%p) [%Lx,%Lx]/%Lx, 0x%Lx, 0x%Lx)\n",
 		((struct pci_dev *) data)->slot_name,
 		res->parent, res->start, res->end,
 		(int) res->flags, size, alignment);
diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/ppc/kernel/pci.c	Fri Nov 22 14:32:09 2002
@@ -128,7 +128,7 @@
 		       "%s/%d (%08x != %08x)\n", dev->slot_name, resource,
 		       new, check);
 	}
-	printk(KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
+	printk(KERN_INFO "PCI: moved device %s resource %d (%Lx) to %x\n",
 	       dev->slot_name, resource, res->flags,
 	       new & ~PCI_REGION_FLAG_MASK);
 }
@@ -149,7 +149,7 @@
 		if (!res->flags)
 			continue;
 		if (!res->start || res->end == 0xffffffff) {
-			DBG("PCI:%s Resource %d [%08lx-%08lx] is unassigned\n",
+			DBG("PCI:%s Resource %d [%016Lx-%016Lx] is unassigned\n",
 			    dev->slot_name, i, res->start, res->end);
 			res->end -= res->start;
 			res->start = 0;
@@ -167,7 +167,7 @@
 			res->start += offset;
 			res->end += offset;
 #ifdef DEBUG
-			printk("Fixup res %d (%lx) of dev %s: %lx -> %lx\n",
+			printk("Fixup res %d (%Lx) of dev %s: %Lx -> %Lx\n",
 			       i, res->flags, dev->slot_name,
 			       res->start - offset, res->start);
 #endif
@@ -230,17 +230,17 @@
  * which might have be mirrored at 0x0100-0x03ff..
  */
 void
-pcibios_align_resource(void *data, struct resource *res, unsigned long size,
-		       unsigned long align)
+pcibios_align_resource(void *data, struct resource *res, u64 size,
+		       u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (size > 0x100) {
-			printk(KERN_ERR "PCI: I/O Region %s/%d too large"
-			       " (%ld bytes)\n", dev->slot_name,
+			printk(KERN_ERR "PCI: I/O Region %s/%Ld too large"
+			       " (%Ld bytes)\n", dev->slot_name,
 			       dev->resource - res, size);
 		}
 
@@ -314,7 +314,7 @@
 				}
 			}
 
-			DBG("PCI: bridge rsrc %lx..%lx (%lx), parent %p\n",
+			DBG("PCI: bridge rsrc %Lx..%Lx (%Lx), parent %p\n",
 			    res->start, res->end, res->flags, pr);
 			if (pr) {
 				if (request_resource(pr, res) == 0)
@@ -419,12 +419,12 @@
 		try = conflict->start - 1;
 	}
 	if (request_resource(pr, res)) {
-		DBG(KERN_ERR "PCI: huh? couldn't move to %lx..%lx\n",
+		DBG(KERN_ERR "PCI: huh? couldn't move to %Lx..%Lx\n",
 		    res->start, res->end);
 		return -1;		/* "can't happen" */
 	}
 	update_bridge_base(bus, i);
-	printk(KERN_INFO "PCI: bridge %d resource %d moved to %lx..%lx\n",
+	printk(KERN_INFO "PCI: bridge %d resource %d moved to %Lx..%Lx\n",
 	       bus->number, i, res->start, res->end);
 	return 0;
 }
@@ -485,7 +485,8 @@
 	u8 io_base_lo, io_limit_lo;
 	u16 mem_base, mem_limit;
 	u16 cmd;
-	unsigned long start, end, off;
+	u64 start, end;
+	unsigned long off;
 	struct pci_dev *dev = bus->self;
 	struct pci_controller *hose = dev->sysdata;
 
@@ -530,7 +531,7 @@
 		pci_write_config_word(dev, PCI_PREF_MEMORY_LIMIT, mem_limit);
 
 	} else {
-		DBG(KERN_ERR "PCI: ugh, bridge %s res %d has flags=%lx\n",
+		DBG(KERN_ERR "PCI: ugh, bridge %s res %d has flags=%Lx\n",
 		    dev->slot_name, i, res->flags);
 	}
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
@@ -540,14 +541,14 @@
 {
 	struct resource *pr, *r = &dev->resource[idx];
 
-	DBG("PCI:%s: Resource %d: %08lx-%08lx (f=%lx)\n",
+	DBG("PCI:%s: Resource %d: %016Lx-%016Lx (f=%Lx)\n",
 	    dev->slot_name, idx, r->start, r->end, r->flags);
 	pr = pci_find_parent_resource(dev, r);
 	if (!pr || request_resource(pr, r) < 0) {
 		printk(KERN_ERR "PCI: Cannot allocate resource region %d"
 		       " of device %s\n", idx, dev->slot_name);
 		if (pr)
-			DBG("PCI:  parent is %p: %08lx-%08lx (f=%lx)\n",
+			DBG("PCI:  parent is %p: %016Lx-%016Lx (f=%Lx)\n",
 			    pr, pr->start, pr->end, pr->flags);
 		/* We'll assign a new address later */
 		r->flags |= IORESOURCE_UNSET;
diff -Nru a/arch/ppc64/kernel/pci.c b/arch/ppc64/kernel/pci.c
--- a/arch/ppc64/kernel/pci.c	Fri Nov 22 14:32:10 2002
+++ b/arch/ppc64/kernel/pci.c	Fri Nov 22 14:32:10 2002
@@ -178,15 +178,15 @@
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	struct pci_dev *dev = data;
 
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (size > 0x100) {
-			printk(KERN_ERR "PCI: Can not align I/O Region %s %s because size %ld is too large.\n",
+			printk(KERN_ERR "PCI: Can not align I/O Region %s %s because size %Ld is too large.\n",
                                         dev->slot_name, res->name, size);
 		}
 
diff -Nru a/arch/sh/kernel/pcibios.c b/arch/sh/kernel/pcibios.c
--- a/arch/sh/kernel/pcibios.c	Fri Nov 22 14:32:09 2002
+++ b/arch/sh/kernel/pcibios.c	Fri Nov 22 14:32:09 2002
@@ -61,10 +61,10 @@
  * modulo 0x400.
  */
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
diff -Nru a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c	Fri Nov 22 14:32:10 2002
+++ b/arch/sparc/kernel/pcic.c	Fri Nov 22 14:32:10 2002
@@ -861,7 +861,7 @@
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
--- a/arch/sparc64/kernel/pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/sparc64/kernel/pci.c	Fri Nov 22 14:32:09 2002
@@ -485,7 +485,7 @@
 }
 
 void pcibios_align_resource(void *data, struct resource *res,
-			    unsigned long size, unsigned long align)
+			    u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/sparc64/kernel/pci_common.c b/arch/sparc64/kernel/pci_common.c
--- a/arch/sparc64/kernel/pci_common.c	Fri Nov 22 14:32:09 2002
+++ b/arch/sparc64/kernel/pci_common.c	Fri Nov 22 14:32:09 2002
@@ -270,7 +270,7 @@
 			    ap->phys_hi, ap->phys_mid, ap->phys_lo,
 			    ap->size_hi, ap->size_lo);
 	if (res)
-		prom_printf("PCI: RES[%016lx-->%016lx:(%lx)]\n",
+		prom_printf("PCI: RES[%016lx-->%016lx:(%Lx)]\n",
 			    res->start, res->end, res->flags);
 	prom_printf("Please email this information to davem@redhat.com\n");
 	if (do_prom_halt)
@@ -403,7 +403,7 @@
 			 */
 			if ((res->start >> 32) != 0UL) {
 				printk(KERN_ERR "PCI: OBP assigns out of range MEM address "
-				       "%016lx for region %ld on device %s\n",
+				       "%016Lx for region %ld on device %s\n",
 				       res->start, (res - &pdev->resource[0]), pdev->dev.name);
 				continue;
 			}
diff -Nru a/arch/v850/kernel/rte_mb_a_pci.c b/arch/v850/kernel/rte_mb_a_pci.c
--- a/arch/v850/kernel/rte_mb_a_pci.c	Fri Nov 22 14:32:09 2002
+++ b/arch/v850/kernel/rte_mb_a_pci.c	Fri Nov 22 14:32:09 2002
@@ -339,7 +339,7 @@
 
 void
 pcibios_align_resource (void *data, struct resource *res,
-			unsigned long size, unsigned long align)
+			u64 size, u64 align)
 {
 }
 
diff -Nru a/arch/x86_64/pci/x86-64.c b/arch/x86_64/pci/x86-64.c
--- a/arch/x86_64/pci/x86-64.c	Fri Nov 22 14:32:10 2002
+++ b/arch/x86_64/pci/x86-64.c	Fri Nov 22 14:32:10 2002
@@ -76,10 +76,10 @@
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	if (res->flags & IORESOURCE_IO) {
-		unsigned long start = res->start;
+		u64 start = res->start;
 
 		if (start & 0x300) {
 			start = (start + 0x3ff) & ~0x3ff;
@@ -167,7 +167,7 @@
 			else
 				disabled = !(command & PCI_COMMAND_MEMORY);
 			if (pass == disabled) {
-				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
+				DBG("PCI: Resource %016Lx-%016Lx (f=%Lx, d=%d, p=%d)\n",
 				    r->start, r->end, r->flags, disabled, pass);
 				pr = pci_find_parent_resource(dev, r);
 				if (!pr || request_resource(pr, r) < 0) {
diff -Nru a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
--- a/drivers/ide/pci/aec62xx.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/ide/pci/aec62xx.c	Fri Nov 22 14:32:10 2002
@@ -413,7 +413,7 @@
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk("%s: ROM enabled at 0x%016Lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 #if defined(DISPLAY_AEC62XX_TIMINGS) && defined(CONFIG_PROC_FS)
diff -Nru a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
--- a/drivers/ide/pci/cmd64x.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/ide/pci/cmd64x.c	Fri Nov 22 14:32:10 2002
@@ -606,7 +606,7 @@
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_byte(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk("%s: ROM enabled at 0x%016Lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
diff -Nru a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
--- a/drivers/ide/pci/hpt34x.c	Fri Nov 22 14:32:09 2002
+++ b/drivers/ide/pci/hpt34x.c	Fri Nov 22 14:32:09 2002
@@ -249,7 +249,7 @@
 		if (pci_resource_start(dev, PCI_ROM_RESOURCE)) {
 			pci_write_config_byte(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
+			printk(KERN_INFO "HPT345: ROM enabled at 0x%016Lx\n",
 				dev->resource[PCI_ROM_RESOURCE].start);
 		}
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
diff -Nru a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
--- a/drivers/ide/pci/pdc202xx_new.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/ide/pci/pdc202xx_new.c	Fri Nov 22 14:32:10 2002
@@ -538,7 +538,7 @@
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n",
+		printk("%s: ROM enabled at 0x%016Lx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
diff -Nru a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
--- a/drivers/ide/pci/pdc202xx_old.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/ide/pci/pdc202xx_old.c	Fri Nov 22 14:32:10 2002
@@ -718,7 +718,7 @@
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk("%s: ROM enabled at 0x%08lx\n",
+		printk("%s: ROM enabled at 0x%016Lx\n",
 			name, dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
diff -Nru a/drivers/net/e100/e100_main.c b/drivers/net/e100/e100_main.c
--- a/drivers/net/e100/e100_main.c	Fri Nov 22 14:32:09 2002
+++ b/drivers/net/e100/e100_main.c	Fri Nov 22 14:32:09 2002
@@ -2986,7 +2986,7 @@
 	bdp->scb = (scb_t *) ioremap_nocache(dev->mem_start, sizeof (scb_t));
 
 	if (!bdp->scb) {
-		printk(KERN_ERR "e100: %s: Failed to map PCI address 0x%lX\n",
+		printk(KERN_ERR "e100: %s: Failed to map PCI address 0x%LX\n",
 		       dev->name, pci_resource_start(pcid, 0));
 		rc = -ENOMEM;
 		goto err_region;
diff -Nru a/drivers/net/eepro100.c b/drivers/net/eepro100.c
--- a/drivers/net/eepro100.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/net/eepro100.c	Fri Nov 22 14:32:10 2002
@@ -621,12 +621,12 @@
 	ioaddr = (unsigned long)ioremap(pci_resource_start(pdev, 0),
 									pci_resource_len(pdev, 0));
 	if (!ioaddr) {
-		printk (KERN_ERR "eepro100: cannot remap MMIO region %lx @ %lx\n",
+		printk (KERN_ERR "eepro100: cannot remap MMIO region %Lx @ %Lx\n",
 				pci_resource_len(pdev, 0), pci_resource_start(pdev, 0));
 		goto err_out_free_mmio_region;
 	}
 	if (DEBUG & NETIF_MSG_PROBE)
-		printk("Found Intel i82557 PCI Speedo, MMIO at %#lx, IRQ %d.\n",
+		printk("Found Intel i82557 PCI Speedo, MMIO at %#Lx, IRQ %d.\n",
 			   pci_resource_start(pdev, 0), irq);
 #endif
 
diff -Nru a/drivers/net/tc35815.c b/drivers/net/tc35815.c
--- a/drivers/net/tc35815.c	Fri Nov 22 14:32:09 2002
+++ b/drivers/net/tc35815.c	Fri Nov 22 14:32:09 2002
@@ -499,7 +499,7 @@
 
 	        pci_memaddr = pci_resource_start (pdev, 1);
 
-	        printk(KERN_INFO "    pci_memaddr=%#08lx  resource_flags=%#08lx\n", pci_memaddr, pci_resource_flags (pdev, 0));
+	        printk(KERN_INFO "    pci_memaddr=%#016Lx  resource_flags=%#016Lx\n", pci_memaddr, pci_resource_flags (pdev, 0));
 
 		if (!pci_memaddr) {
 			printk(KERN_WARNING "no PCI MEM resources, aborting\n");
diff -Nru a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
--- a/drivers/net/tulip/tulip_core.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/net/tulip/tulip_core.c	Fri Nov 22 14:32:10 2002
@@ -1361,7 +1361,7 @@
 	}
 
 	if (pci_resource_len (pdev, 0) < tulip_tbl[chip_idx].io_size) {
-		printk (KERN_ERR PFX "%s: I/O region (0x%lx@0x%lx) too small, "
+		printk (KERN_ERR PFX "%s: I/O region (0x%Lx@0x%Lx) too small, "
 			"aborting\n", pdev->slot_name,
 			pci_resource_len (pdev, 0),
 			pci_resource_start (pdev, 0));
diff -Nru a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
--- a/drivers/parisc/ccio-dma.c	Fri Nov 22 14:32:09 2002
+++ b/drivers/parisc/ccio-dma.c	Fri Nov 22 14:32:09 2002
@@ -1438,7 +1438,7 @@
 	res->name = name;
 	result = request_resource(&iomem_resource, res);
 	if (result < 0) {
-		printk(KERN_ERR "%s: failed to claim CCIO bus address space (%08lx,%08lx)\n", 
+		printk(KERN_ERR "%s: failed to claim CCIO bus address space (%016Lx,%016Lx)\n", 
 		       __FILE__, res->start, res->end);
 	}
 }
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri Nov 22 14:32:09 2002
+++ b/drivers/pci/pci.c	Fri Nov 22 14:32:09 2002
@@ -500,7 +500,7 @@
 	return 0;
 
 err_out:
-	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%lx@%lx for device %s\n",
+	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%Lx@%Lx for device %s\n",
 		pci_resource_flags(pdev, bar) & IORESOURCE_IO ? "I/O" : "mem",
 		bar + 1, /* PCI BAR # */
 		pci_resource_len(pdev, bar), pci_resource_start(pdev, bar),
@@ -549,7 +549,7 @@
 	return 0;
 
 err_out:
-	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%lx@%lx for device %s\n",
+	printk (KERN_WARNING "PCI: Unable to reserve %s region #%d:%Lx@%Lx for device %s\n",
 		pci_resource_flags(pdev, i) & IORESOURCE_IO ? "I/O" : "mem",
 		i + 1, /* PCI BAR # */
 		pci_resource_len(pdev, i), pci_resource_start(pdev, i),
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/pci/proc.c	Fri Nov 22 14:32:10 2002
@@ -299,11 +299,7 @@
 #endif /* HAVE_PCI_MMAP */
 };
 
-#if BITS_PER_LONG == 32
-#define LONG_FORMAT "\t%08lx"
-#else
-#define LONG_FORMAT "\t%16lx"
-#endif
+#define LONG_FORMAT "\t%016Lx"
 
 /* iterator */
 static void *pci_seq_start(struct seq_file *m, loff_t *pos)
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/pci/setup-res.c	Fri Nov 22 14:32:10 2002
@@ -46,7 +46,7 @@
 		err = request_resource(root, res);
 
 	if (err) {
-		printk(KERN_ERR "PCI: %s region %d of %s %s [%lx:%lx]\n",
+		printk(KERN_ERR "PCI: %s region %d of %s %s [%Lx:%Lx]\n",
 		       root ? "Address space collision on" :
 			      "No parent found for",
 		       resource, dtype, dev->slot_name, res->start, res->end);
@@ -63,12 +63,12 @@
 static int pci_assign_bus_resource(const struct pci_bus *bus,
 	struct pci_dev *dev,
 	struct resource *res,
-	unsigned long size,
-	unsigned long min,
-	unsigned int type_mask,
+	u64 size,
+	u64 min,
+	u64 type_mask,
 	int resno)
 {
-	unsigned long align;
+	u64 align;
 	int i;
 
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
@@ -123,13 +123,13 @@
 		 * window (it will just not perform as well).
 		 */
 		if (!(res->flags & IORESOURCE_PREFETCH) || pci_assign_bus_resource(bus, dev, res, size, min, 0, i) < 0) {
-			printk(KERN_ERR "PCI: Failed to allocate resource %d(%lx-%lx) for %s\n",
+			printk(KERN_ERR "PCI: Failed to allocate resource %d(%Lx-%Lx) for %s\n",
 			       i, res->start, res->end, dev->slot_name);
 			return -EBUSY;
 		}
 	}
 
-	DBGC((KERN_ERR "  got res[%lx:%lx] for resource %d of %s\n", res->start,
+	DBGC((KERN_ERR "  got res[%Lx:%Lx] for resource %d of %s\n", res->start,
 						res->end, i, dev->dev.name));
 
 	return 0;
@@ -153,7 +153,7 @@
 			continue;
 		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
-					    "[%lx:%lx] of %s\n",
+					    "[%Lx:%Lx] of %s\n",
 					    i, r->start, r->end, dev->dev.name);
 			continue;
 		}
diff -Nru a/drivers/video/clgenfb.c b/drivers/video/clgenfb.c
--- a/drivers/video/clgenfb.c	Fri Nov 22 14:32:10 2002
+++ b/drivers/video/clgenfb.c	Fri Nov 22 14:32:10 2002
@@ -2690,7 +2690,7 @@
 		info->fbmem_phys = board_addr + 16777216;
 		info->fbmem = ioremap (info->fbmem_phys, 16777216);
 	} else {
-		printk (" REG at $%lx\n", (unsigned long) z2->resource.start);
+		printk (" REG at $%Lx\n", (unsigned long) z2->resource.start);
 
 		info->fbmem_phys = board_addr;
 		if (board_addr > 0x01000000)
diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	Fri Nov 22 14:32:09 2002
+++ b/include/linux/ioport.h	Fri Nov 22 14:32:09 2002
@@ -5,6 +5,8 @@
  * Authors:	Linus Torvalds
  */
 
+#include <asm/types.h>
+
 #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H
 
@@ -14,8 +16,9 @@
  */
 struct resource {
 	const char *name;
-	unsigned long start, end;
-	unsigned long flags;
+	u64 start, end;
+	u64 flags;
+	unsigned long type;
 	struct resource *parent, *sibling, *child;
 };
 
@@ -28,23 +31,23 @@
 /*
  * IO resources have these defined flags.
  */
-#define IORESOURCE_BITS		0x000000ff	/* Bus-specific bits */
+#define IORESOURCE_BITS		0x00000000000000ff	/* Bus-specific bits */
 
-#define IORESOURCE_IO		0x00000100	/* Resource type */
-#define IORESOURCE_MEM		0x00000200
-#define IORESOURCE_IRQ		0x00000400
-#define IORESOURCE_DMA		0x00000800
-
-#define IORESOURCE_PREFETCH	0x00001000	/* No side effects */
-#define IORESOURCE_READONLY	0x00002000
-#define IORESOURCE_CACHEABLE	0x00004000
-#define IORESOURCE_RANGELENGTH	0x00008000
-#define IORESOURCE_SHADOWABLE	0x00010000
-#define IORESOURCE_BUS_HAS_VGA	0x00080000
-
-#define IORESOURCE_UNSET	0x20000000
-#define IORESOURCE_AUTO		0x40000000
-#define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
+#define IORESOURCE_IO		0x0000000000000100	/* Resource type */
+#define IORESOURCE_MEM		0x0000000000000200
+#define IORESOURCE_IRQ		0x0000000000000400
+#define IORESOURCE_DMA		0x0000000000000800
+
+#define IORESOURCE_PREFETCH	0x0000000000001000	/* No side effects */
+#define IORESOURCE_READONLY	0x0000000000002000
+#define IORESOURCE_CACHEABLE	0x0000000000004000
+#define IORESOURCE_RANGELENGTH	0x0000000000008000
+#define IORESOURCE_SHADOWABLE	0x0000000000010000
+#define IORESOURCE_BUS_HAS_VGA	0x0000000000080000
+
+#define IORESOURCE_UNSET	0x0000000020000000
+#define IORESOURCE_AUTO		0x0000000040000000
+#define IORESOURCE_BUSY		0x0000000080000000	/* Driver has marked this resource busy */
 
 /* ISA PnP IRQ specific bits (IORESOURCE_BITS) */
 #define IORESOURCE_IRQ_HIGHEDGE		(1<<0)
@@ -88,18 +91,18 @@
 extern int request_resource(struct resource *root, struct resource *new);
 extern int release_resource(struct resource *new);
 extern int allocate_resource(struct resource *root, struct resource *new,
-			     unsigned long size,
-			     unsigned long min, unsigned long max,
-			     unsigned long align,
+			     u64 size,
+			     u64 min, u64 max,
+			     u64 align,
 			     void (*alignf)(void *, struct resource *,
-					    unsigned long, unsigned long),
+					    u64, u64),
 			     void *alignf_data);
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
 #define request_mem_region(start,n,name) __request_region(&iomem_resource, (start), (n), (name))
 
-extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
+extern struct resource * __request_region(struct resource *, u64 start, u64 n, const char *name);
 
 /* Compatibility cruft */
 #define check_region(start,n)	__check_region(&ioport_resource, (start), (n))
@@ -107,8 +110,8 @@
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
 
-extern int __check_region(struct resource *, unsigned long, unsigned long);
-extern void __release_region(struct resource *, unsigned long, unsigned long);
+extern int __check_region(struct resource *, u64, u64);
+extern void __release_region(struct resource *, u64, u64);
 
 #define get_ioport_list(buf)	get_resource_list(&ioport_resource, buf, PAGE_SIZE)
 #define get_mem_list(buf)	get_resource_list(&iomem_resource, buf, PAGE_SIZE)
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Nov 22 14:32:09 2002
+++ b/include/linux/pci.h	Fri Nov 22 14:32:09 2002
@@ -511,7 +511,7 @@
 
 /* Used only when drivers/pci/setup.c is used */
 void pcibios_align_resource(void *, struct resource *,
-			    unsigned long, unsigned long);
+			    u64, u64);
 void pcibios_update_resource(struct pci_dev *, struct resource *,
 			     struct resource *, int);
 void pcibios_update_irq(struct pci_dev *, int irq);
diff -Nru a/kernel/resource.c b/kernel/resource.c
--- a/kernel/resource.c	Fri Nov 22 14:32:10 2002
+++ b/kernel/resource.c	Fri Nov 22 14:32:10 2002
@@ -16,7 +16,7 @@
 #include <asm/io.h>
 
 struct resource ioport_resource = { "PCI IO", 0x0000, IO_SPACE_LIMIT, IORESOURCE_IO };
-struct resource iomem_resource = { "PCI mem", 0x00000000, 0xffffffff, IORESOURCE_MEM };
+struct resource iomem_resource = { "PCI mem", 0x0000000000000000, 0xffffffffffffffff, IORESOURCE_MEM };
 
 static rwlock_t resource_lock = RW_LOCK_UNLOCKED;
 
@@ -30,7 +30,7 @@
 
 	while (entry) {
 		const char *name = entry->name;
-		unsigned long from, to;
+		u64 from, to;
 
 		if ((int) (end-buf) < 80)
 			return buf;
@@ -39,7 +39,7 @@
 		to = entry->end;
 		if (!name)
 			name = "<BAD>";
-
+		
 		buf += sprintf(buf, fmt + offset, from, to, name);
 		if (entry->child)
 			buf = do_resource_list(entry->child, fmt, offset-2, buf, end);
@@ -54,9 +54,9 @@
 	char *fmt;
 	int retval;
 
-	fmt = "        %08lx-%08lx : %s\n";
+	fmt = "        %016Lx-%016Lx : %s\n";
 	if (root->end < 0x10000)
-		fmt = "        %04lx-%04lx : %s\n";
+		fmt = "        %04Lx-%04Lx : %s\n";
 	read_lock(&resource_lock);
 	retval = do_resource_list(root->child, fmt, 8, buf, buf + size) - buf;
 	read_unlock(&resource_lock);
@@ -66,8 +66,8 @@
 /* Return the conflict entry if you can't request it */
 static struct resource * __request_resource(struct resource *root, struct resource *new)
 {
-	unsigned long start = new->start;
-	unsigned long end = new->end;
+	u64 start = new->start;
+	u64 end = new->end;
 	struct resource *tmp, **p;
 
 	if (end < start)
@@ -135,11 +135,11 @@
  * Find empty slot in the resource tree given range and alignment.
  */
 static int find_resource(struct resource *root, struct resource *new,
-			 unsigned long size,
-			 unsigned long min, unsigned long max,
-			 unsigned long align,
+			 u64 size,
+			 u64 min, u64 max,
+			 u64 align,
 			 void (*alignf)(void *, struct resource *,
-					unsigned long, unsigned long),
+					u64, u64),
 			 void *alignf_data)
 {
 	struct resource *this = root->child;
@@ -173,11 +173,11 @@
  * Allocate empty slot in the resource tree given range and alignment.
  */
 int allocate_resource(struct resource *root, struct resource *new,
-		      unsigned long size,
-		      unsigned long min, unsigned long max,
-		      unsigned long align,
+		      u64 size,
+		      u64 min, u64 max,
+		      u64 align,
 		      void (*alignf)(void *, struct resource *,
-				     unsigned long, unsigned long),
+				     u64, u64),
 		      void *alignf_data)
 {
 	int err;
@@ -202,7 +202,7 @@
  *
  * Release-region releases a matching busy region.
  */
-struct resource * __request_region(struct resource *parent, unsigned long start, unsigned long n, const char *name)
+struct resource * __request_region(struct resource *parent, u64 start, u64 n, const char *name)
 {
 	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
 
@@ -237,7 +237,7 @@
 	return res;
 }
 
-int __check_region(struct resource *parent, unsigned long start, unsigned long n)
+int __check_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource * res;
 
@@ -250,10 +250,10 @@
 	return 0;
 }
 
-void __release_region(struct resource *parent, unsigned long start, unsigned long n)
+void __release_region(struct resource *parent, u64 start, u64 n)
 {
 	struct resource **p;
-	unsigned long end;
+	u64 end;
 
 	p = &parent->child;
 	end = start + n - 1;
@@ -276,7 +276,7 @@
 		}
 		p = &res->sibling;
 	}
-	printk(KERN_WARNING "Trying to free nonexistent resource <%08lx-%08lx>\n", start, end);
+	printk(KERN_WARNING "Trying to free nonexistent resource <%016Lx-%016Lx>\n", start, end);
 }
 
 /*

--------------030802030504010903030202--

