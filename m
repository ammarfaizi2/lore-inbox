Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVHBXAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVHBXAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 19:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVHBXAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 19:00:21 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22765 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261892AbVHBXAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 19:00:19 -0400
Date: Wed, 3 Aug 2005 02:59:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Erik Waling <erikw@acc.umu.se>,
       Mikael Pettersson <mikpe@csd.uu.se>
Subject: [patch 1/2] increase PCIBIOS_MIN_IO on x86
Message-ID: <20050803025947.D18001@jurassic.park.msu.ru>
References: <1122976168.4656.3.camel@localhost.localdomain> <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru> <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org> <20050803011337.A18001@jurassic.park.msu.ru> <20050802212143.GA8738@kroah.com> <20050803014757.B18001@jurassic.park.msu.ru> <Pine.LNX.4.58.0508021456070.3341@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0508021456070.3341@g5.osdl.org>; from torvalds@osdl.org on Tue, Aug 02, 2005 at 02:57:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 02:57:19PM -0700, Linus Torvalds wrote:
> But you don't need to split up any patches you've already prepared: I can 
> easily just edit away the part I already committed.

OK, I keep your change here - mostly for Mikael, so he can try that ASAP.


There is a number of x86 laptops that have some non-PCI IO ports
in the 0x1000-0x1fff range, and it's quite hard to control the correct
order of resource allocation between PCI and other subsystems controlling
these ports. Especially with modular kernel. So just increase
PCIBIOS_MIN_IO to 0x4000 to prevent any new PCI resource allocations
in the problematic range (this limitation must apply _only_ to the
root bus resources - see Linus' change in pci_bus_alloc_resource).
As PCIBIOS_MIN_IO and PCIBIOS_MIN_CARDBUS_IO are the same now on i386
and x86-64, we can remove the latter.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

--- 2.6.13-rc5/drivers/pci/bus.c	Wed Aug  3 00:11:42 2005
+++ linux/drivers/pci/bus.c	Wed Aug  3 00:19:41 2005
@@ -60,7 +60,9 @@ pci_bus_alloc_resource(struct pci_bus *b
 			continue;
 
 		/* Ok, try it out.. */
-		ret = allocate_resource(r, res, size, min, -1, align,
+		ret = allocate_resource(r, res, size,
+					r->start ? : min,
+					-1, align,
 					alignf, alignf_data);
 		if (ret == 0)
 			break;
--- 2.6.13-rc5/include/asm-i386/pci.h	Wed Aug  3 00:11:55 2005
+++ linux/include/asm-i386/pci.h	Wed Aug  3 02:51:00 2005
@@ -18,10 +18,8 @@ extern unsigned int pcibios_assign_all_b
 #define pcibios_scan_all_fns(a, b)	0
 
 extern unsigned long pci_mem_start;
-#define PCIBIOS_MIN_IO		0x1000
+#define PCIBIOS_MIN_IO		0x4000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
-
-#define PCIBIOS_MIN_CARDBUS_IO	0x4000
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
--- 2.6.13-rc5/include/asm-x86_64/pci.h	Wed Aug  3 00:11:58 2005
+++ linux/include/asm-x86_64/pci.h	Wed Aug  3 02:51:33 2005
@@ -22,10 +22,8 @@ extern unsigned int pcibios_assign_all_b
 extern int no_iommu, force_iommu;
 
 extern unsigned long pci_mem_start;
-#define PCIBIOS_MIN_IO		0x1000
+#define PCIBIOS_MIN_IO		0x4000
 #define PCIBIOS_MIN_MEM		(pci_mem_start)
-
-#define PCIBIOS_MIN_CARDBUS_IO	0x4000
 
 void pcibios_config_init(void);
 struct pci_bus * pcibios_scan_root(int bus);
