Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWHDFnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWHDFnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWHDFnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33711 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030268AbWHDFnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:20 -0400
Date: Thu, 3 Aug 2006 22:38:22 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Chris Wright <chrisw@sous-sol.org>
Subject: [patch 01/23] PCI: fix issues with extended conf space when MMCONFIG disabled because of e820
Message-ID: <20060804053822.GB769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-fix-issues-with-extended-conf-space-when-mmconfig-disabled-because-of-e820.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Chuck Ebbert <76306.1226@compuserve.com>

On 15 Jun 2006 03:45:10 +0200, Andi Kleen wrote:
> Anyways I would say that if the BIOS can't get MCFG right then
> it's likely not been validated on that board and shouldn't be used.

According to Petr Vandrovec:

 ... "What is important (and checked) is address of MMCONFIG reported by MCFG
 table...  Unfortunately code does not bother with printing that address :-(

 "Another problem is that code has hardcoded that MMCONFIG area is 256MB large.
 Unfortunately for the code PCI specification allows any power of two between 2MB
 and 256MB if vendor knows that such amount of busses (from 2 to 128) will be
 sufficient for system.  With notebook it is quite possible that not full 8 bits
 are implemented for MMCONFIG bus number."

So here is a patch.  Unfortunately my system still fails the test because
it doesn't reserve any part of the MMCONFIG area, but this may fix others.

Booted on x86_64, only compiled on i386.  x86_64 still remaps the max area
(256MB) even though only 2MB is checked... but 2.6.16 had no check at all
so it is still better.

PCI: reduce size of x86 MMCONFIG reserved area check

1.  Print the address of the MMCONFIG area when the test for that area
    being reserved fails.

2.  Only check if the first 2MB is reserved, as that is the minimum.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/pci/mmconfig.c   |    9 ++++++---
 arch/x86_64/pci/mmconfig.c |   13 +++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

--- linux-2.6.17.7.orig/arch/i386/pci/mmconfig.c
+++ linux-2.6.17.7/arch/i386/pci/mmconfig.c
@@ -15,7 +15,9 @@
 #include <asm/e820.h>
 #include "pci.h"
 
-#define MMCONFIG_APER_SIZE (256*1024*1024)
+/* aperture is up to 256MB but BIOS may reserve less */
+#define MMCONFIG_APER_MIN	(2 * 1024*1024)
+#define MMCONFIG_APER_MAX	(256 * 1024*1024)
 
 /* Assume systems with more busses have correct MCFG */
 #define MAX_CHECK_BUS 16
@@ -197,9 +199,10 @@ void __init pci_mmcfg_init(void)
 		return;
 
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+				pci_mmcfg_config[0].base_address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
 		return;
 	}
--- linux-2.6.17.7.orig/arch/x86_64/pci/mmconfig.c
+++ linux-2.6.17.7/arch/x86_64/pci/mmconfig.c
@@ -13,7 +13,10 @@
 
 #include "pci.h"
 
-#define MMCONFIG_APER_SIZE (256*1024*1024)
+/* aperture is up to 256MB but BIOS may reserve less */
+#define MMCONFIG_APER_MIN	(2 * 1024*1024)
+#define MMCONFIG_APER_MAX	(256 * 1024*1024)
+
 /* Verify the first 16 busses. We assume that systems with more busses
    get MCFG right. */
 #define MAX_CHECK_BUS 16
@@ -175,9 +178,10 @@ void __init pci_mmcfg_init(void)
 		return;
 
 	if (!e820_all_mapped(pci_mmcfg_config[0].base_address,
-			pci_mmcfg_config[0].base_address + MMCONFIG_APER_SIZE,
+			pci_mmcfg_config[0].base_address + MMCONFIG_APER_MIN,
 			E820_RESERVED)) {
-		printk(KERN_ERR "PCI: BIOS Bug: MCFG area is not E820-reserved\n");
+		printk(KERN_ERR "PCI: BIOS Bug: MCFG area at %x is not E820-reserved\n",
+				pci_mmcfg_config[0].base_address);
 		printk(KERN_ERR "PCI: Not using MMCONFIG.\n");
 		return;
 	}
@@ -190,7 +194,8 @@ void __init pci_mmcfg_init(void)
 	}
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
-		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address, MMCONFIG_APER_SIZE);
+		pci_mmcfg_virt[i].virt = ioremap_nocache(pci_mmcfg_config[i].base_address,
+							 MMCONFIG_APER_MAX);
 		if (!pci_mmcfg_virt[i].virt) {
 			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);

--
