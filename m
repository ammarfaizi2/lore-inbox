Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267755AbTATDnV>; Sun, 19 Jan 2003 22:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267756AbTATDnV>; Sun, 19 Jan 2003 22:43:21 -0500
Received: from holomorphy.com ([66.224.33.161]:55432 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267755AbTATDnT>;
	Sun, 19 Jan 2003 22:43:19 -0500
Date: Sun, 19 Jan 2003 19:52:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: ink@jurassic.park.msu.ru
Cc: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, akpm@zip.com.au
Subject: pci_child_fixup()
Message-ID: <20030120035217.GE770@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
	Martin.Bligh@us.ibm.com, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a fresh pci_fixup_child() hook for physical bus numbers in bus
number registers that don't match the bus numbers in the MP tables.
It basically allows for arbitrary bus number twiddling for children.

vs. 2.5.59-mm1

 arch/i386/pci/numa.c   |    9 +++++++++
 drivers/pci/probe.c    |    5 +----
 include/asm-i386/pci.h |   11 +++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)


diff -urpN mpc-2.5.59-1/arch/i386/pci/numa.c mpc-2.5.59-2/arch/i386/pci/numa.c
--- mpc-2.5.59-1/arch/i386/pci/numa.c	2003-01-19 19:01:38.000000000 -0800
+++ mpc-2.5.59-2/arch/i386/pci/numa.c	2003-01-19 19:42:30.000000000 -0800
@@ -88,6 +88,15 @@ static struct pci_ops pci_direct_conf1_m
 	.write	= pci_conf1_mq_write
 };
 
+void pci_child_fixup(struct pci_bus *parent, struct pci_bus *child, int buses)
+{
+	int quad = BUS2QUAD(parent->number);
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
+++ mpc-2.5.59-2/drivers/pci/probe.c	2003-01-19 19:43:24.000000000 -0800
@@ -271,10 +271,7 @@ int __devinit pci_scan_bridge(struct pci
 		if (pass)
 			return max;
 		child = pci_add_new_bus(bus, dev, 0);
-		child->primary = buses & 0xFF;
-		child->secondary = (buses >> 8) & 0xFF;
-		child->subordinate = (buses >> 16) & 0xFF;
-		child->number = child->secondary;
+		pci_child_fixup(bus, child, buses);
 		cmax = pci_do_scan_bus(child);
 		if (cmax > max) max = cmax;
 	} else {
diff -urpN mpc-2.5.59-1/include/asm-i386/pci.h mpc-2.5.59-2/include/asm-i386/pci.h
--- mpc-2.5.59-1/include/asm-i386/pci.h	2003-01-16 18:22:04.000000000 -0800
+++ mpc-2.5.59-2/include/asm-i386/pci.h	2003-01-19 19:39:07.000000000 -0800
@@ -100,6 +100,17 @@ static inline int pci_controller_num(str
 extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			       enum pci_mmap_state mmap_state, int write_combine);
 
+#ifdef CONFIG_X86_NUMAQ
+void pci_child_fixup(struct pci_bus *, struct pci_bus *, int);
+#else
+static inline void pci_child_fixup(struct pci_bus *parent, struct pci_bus *child, int buses)
+{
+	child->primary		= buses & 0xFF;
+	child->secondary	= (buses >> 8) & 0xFF;
+	child->subordinate	= (buses >> 16) & 0xFF;
+	child->number		= child->secondary;
+}
+#endif
 #endif /* __KERNEL__ */
 
 /* implement the pci_ DMA API in terms of the generic device dma_ one */
