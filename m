Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbTATMoM>; Mon, 20 Jan 2003 07:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTATMoL>; Mon, 20 Jan 2003 07:44:11 -0500
Received: from holomorphy.com ([66.224.33.161]:50057 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265705AbTATMoK>;
	Mon, 20 Jan 2003 07:44:10 -0500
Date: Mon, 20 Jan 2003 04:53:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, akpm@zip.com.au,
       greg@kroah.com
Subject: Re: pci_child_fixup()
Message-ID: <20030120125309.GB15315@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	akpm@zip.com.au, greg@kroah.com
References: <20030120035217.GE770@holomorphy.com> <20030120145754.A912@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120145754.A912@jurassic.park.msu.ru>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 07:52:17PM -0800, William Lee Irwin III wrote:
>>  		child = pci_add_new_bus(bus, dev, 0);
>> -		child->primary = buses & 0xFF;
>> -		child->secondary = (buses >> 8) & 0xFF;
>> -		child->subordinate = (buses >> 16) & 0xFF;
>> -		child->number = child->secondary;
>> +		pci_child_fixup(bus, child, buses);

On Mon, Jan 20, 2003 at 02:57:54PM +0300, Ivan Kokshaysky wrote:
> The "bus" argument seems to be redundant. Why not use "child->parent"
> just filled in by pci_add_new_bus() instead?
> Ivan.

Good point. Here's an adjusted patch. I added gregkh to the cc: list
in case he's interested (he generally seems to be wrt. PCI).


Thanks,
Bill


The NUMA-Q BIOS reports bus numbers different from the physical ones
programmed into PCI-PCI bridges etc. PCI config cycles (and almost
everything else) are meant to use translation tables handed to us by
the BIOS. No other extant i386 port has such a beast, and there's
currently no way to override bus numbers gotten from bus number
registers in a meaningful way; bus number conflicts error out prior to
any call into arch code. All of the IRQ routing, interrupt assignment,
IO-APIC, PCI bus, etc. etc. MP table entries use these numbers, so we're
stuck with them.

This provides a fixup hook so it's possible to override the standard
interpretation of the bus number registers in PCI-PCI bridges.

 arch/i386/pci/numa.c   |    9 +++++++++
 drivers/pci/probe.c    |    5 +----
 include/asm-i386/pci.h |   11 +++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)


diff -urpN mpc-2.5.59-1/arch/i386/pci/numa.c mpc-2.5.59-2/arch/i386/pci/numa.c
--- mpc-2.5.59-1/arch/i386/pci/numa.c	2003-01-19 19:01:38.000000000 -0800
+++ mpc-2.5.59-2/arch/i386/pci/numa.c	2003-01-20 04:37:02.000000000 -0800
@@ -88,6 +88,15 @@ static struct pci_ops pci_direct_conf1_m
 	.write	= pci_conf1_mq_write
 };
 
+void pci_child_fixup(struct pci_bus *child, int buses)
+{
+	int quad = BUS2QUAD(child->parent->number);
+	child->primary		= QUADLOCAL2BUS(quad, buses         & 0xFF);
+	child->secondary	= QUADLOCAL2BUS(quad, (buses >> 8)  & 0xFF);
+	child->subordinate	= QUADLOCAL2BUS(quad, (buses >> 16) & 0xFF);
+	child->number		= child->secondary;
+}
+
 
 static void __devinit pci_fixup_i450nx(struct pci_dev *d)
 {
diff -urpN mpc-2.5.59-1/drivers/pci/probe.c mpc-2.5.59-2/drivers/pci/probe.c
--- mpc-2.5.59-1/drivers/pci/probe.c	2003-01-16 18:22:24.000000000 -0800
+++ mpc-2.5.59-2/drivers/pci/probe.c	2003-01-20 04:37:32.000000000 -0800
@@ -271,10 +271,7 @@ int __devinit pci_scan_bridge(struct pci
 		if (pass)
 			return max;
 		child = pci_add_new_bus(bus, dev, 0);
-		child->primary = buses & 0xFF;
-		child->secondary = (buses >> 8) & 0xFF;
-		child->subordinate = (buses >> 16) & 0xFF;
-		child->number = child->secondary;
+		pci_child_fixup(child, buses);
 		cmax = pci_do_scan_bus(child);
 		if (cmax > max) max = cmax;
 	} else {
diff -urpN mpc-2.5.59-1/include/asm-i386/pci.h mpc-2.5.59-2/include/asm-i386/pci.h
--- mpc-2.5.59-1/include/asm-i386/pci.h	2003-01-16 18:22:04.000000000 -0800
+++ mpc-2.5.59-2/include/asm-i386/pci.h	2003-01-20 04:39:12.000000000 -0800
@@ -100,6 +100,17 @@ static inline int pci_controller_num(str
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
 
+#ifdef CONFIG_X86_NUMAQ
+void pci_child_fixup(struct pci_bus *, int);
+#else
+static inline void pci_child_fixup(struct pci_bus *child, int buses)
+{
+	child->primary		= buses & 0xFF;
+	child->secondary	= (buses >> 8) & 0xFF;
+	child->subordinate	= (buses >> 16) & 0xFF;
+	child->number		= child->secondary;
+}
+#endif
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
