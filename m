Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSKLVog>; Tue, 12 Nov 2002 16:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbSKLVod>; Tue, 12 Nov 2002 16:44:33 -0500
Received: from holomorphy.com ([66.224.33.161]:1469 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266968AbSKLVoa>;
	Tue, 12 Nov 2002 16:44:30 -0500
Date: Tue, 12 Nov 2002 13:48:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
       Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112214839.GY23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, linux-kernel@vger.kernel.org,
	Martin.Bligh@us.ibm.com, hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy> <20021112205241.GS23425@holomorphy.com> <3DD172B8.8040802@us.ibm.com> <20021112213504.GV23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021112213504.GV23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:35:04PM -0800, William Lee Irwin III wrote:
> I'll remove the bus number mangling from it so it uses ->sysdata
> instead, make it an additional stage of the patch series and convert 
> arch/i386/pci/numa.c to use it instead.
> Bus number mangling has been vetoed numerous times; the agreed-upon
> method of dealing with this is stuffing arch-private information in
> ->sysdata and dispatching on that within PCI config access routines.

[8/4] NUMA-Q: use __pcibus_to_node() in arch/i386/pci/numa.c


This uses the __pcibus_to_node() macro within arch/i386/pci/numa.c

 numa.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)


diff -urpN pci-2.5.47-7/arch/i386/pci/numa.c pci-2.5.47-8/arch/i386/pci/numa.c
--- pci-2.5.47-7/arch/i386/pci/numa.c	2002-11-12 12:10:25.000000000 -0800
+++ pci-2.5.47-8/arch/i386/pci/numa.c	2002-11-12 13:07:27.000000000 -0800
@@ -9,11 +9,6 @@
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
 	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
-static int bus2node(struct pci_bus *bus)
-{
-	return (int)bus->sysdata;
-}
-
 static int __pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
@@ -72,13 +67,13 @@ static int __pci_conf1_mq_write (int seg
 
 static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_conf1_mq_read(bus2node(bus), bus->number, PCI_SLOT(devfn), 
+	return __pci_conf1_mq_read(__pcibus_to_node(bus), bus->number, PCI_SLOT(devfn), 
 		PCI_FUNC(devfn), where, size, value);
 }
 
 static int pci_conf1_mq_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_conf1_mq_write(bus2node(bus), bus->number, PCI_SLOT(devfn), 
+	return __pci_conf1_mq_write(__pcibus_to_node(bus), bus->number, PCI_SLOT(devfn), 
 		PCI_FUNC(devfn), where, size, value);
 }
 
@@ -95,7 +90,7 @@ static void __devinit pci_fixup_i450nx(s
 	 */
 	int pxb, reg;
 	u8 busno, suba, subb;
-	int node = bus2node(d->bus);
+	int node = __pcibus_to_node(d->bus);
 
 	printk("PCI: Searching for i450NX host bridges on %s\n", d->slot_name);
 	reg = 0xd0;
