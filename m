Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbSKLUti>; Tue, 12 Nov 2002 15:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbSKLUth>; Tue, 12 Nov 2002 15:49:37 -0500
Received: from holomorphy.com ([66.224.33.161]:48828 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266952AbSKLUtf>;
	Tue, 12 Nov 2002 15:49:35 -0500
Date: Tue, 12 Nov 2002 12:53:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com, colpatch@us.ibm.com, hohnbaum@us.ibm.com
Subject: Re: [0/4] NUMA-Q: remove PCI bus number mangling
Message-ID: <20021112205350.GT23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com,
	colpatch@us.ibm.com, hohnbaum@us.ibm.com
References: <E18BaIc-0006Zs-00@holomorphy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18BaIc-0006Zs-00@holomorphy>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:37:46AM -0800, William Lee Irwin III wrote:
> This fixes a longstanding bug with respect to bridge handling as well as
> a Linux PCI faux pas, namely an attempt to support PCI domains with bus
> number mangling.
> The end result is that bridges off of quad 0 now work, and the code now
> follows Linux PCI conventions.
> [1/4] NUMA-Q: use sysdata as quad numbers in pci_scan_bus()"
> [2/4] NUMA-Q: fetch quad numbers from struct pci_bus"
> [3/4] NUMA-Q: use quad numbers passed to low-level config cycles"
> [4/4] NUMA-Q: remove last traces of bus number mangling"

Follow-on #2:

[6/4] NUMA-Q: remove unused bus number conversion functions


This removes unused detritus left over from the conversion to the
standard PCI arch-private data mechanisms.

 numa.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)


diff -urpN pci-2.5.47-5/arch/i386/pci/numa.c pci-2.5.47-6/arch/i386/pci/numa.c
--- pci-2.5.47-5/arch/i386/pci/numa.c	2002-11-12 12:06:22.000000000 -0800
+++ pci-2.5.47-6/arch/i386/pci/numa.c	2002-11-12 12:10:25.000000000 -0800
@@ -6,15 +6,8 @@
 #include <linux/init.h>
 #include "pci.h"
 
-#define BUS2NODE(global) (mp_bus_id_to_node[global])
-#define BUS2LOCAL(global) (mp_bus_id_to_local[global])
-#define NODELOCAL2BUS(node,local) (quad_local_to_mp_bus_id[node][local])
-
-#define __PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
-
 #define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	__PCI_CONF1_MQ_ADDRESS(BUS2LOCAL(bus), dev, fn, reg)
+	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
 
 static int bus2node(struct pci_bus *bus)
 {
@@ -30,7 +23,7 @@ static int __pci_conf1_mq_read (int seg,
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(__PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
 
 	switch (len) {
 	case 1:
@@ -58,7 +51,7 @@ static int __pci_conf1_mq_write (int seg
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(__PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, seg);
 
 	switch (len) {
 	case 1:
@@ -77,8 +70,6 @@ static int __pci_conf1_mq_write (int seg
 	return 0;
 }
 
-#undef PCI_CONF1_MQ_ADDRESS
-
 static int pci_conf1_mq_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
 	return __pci_conf1_mq_read(bus2node(bus), bus->number, PCI_SLOT(devfn), 
