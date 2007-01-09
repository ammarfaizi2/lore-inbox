Return-Path: <linux-kernel-owner+w=401wt.eu-S932415AbXAITAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbXAITAt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbXAITAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:00:48 -0500
Received: from mail.parknet.jp ([210.171.160.80]:4221 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932459AbXAITAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:00:46 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH 3/4] MMCONFIG: fix unreachable_devices()
References: <878xgc58nc.fsf@duaron.myhome.or.jp>
	<871wm458lj.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 10 Jan 2007 04:00:43 +0900
In-Reply-To: <871wm458lj.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Wed\, 10 Jan 2007 04\:00\:08 +0900")
Message-ID: <87wt3w3u04.fsf_-_@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, unreachable_devices() compares value of mmconfig and value
of conf1. But it doesn't check the device is reachable or not.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/pci/mmconfig-shared.c |   12 +++++++-----
 arch/i386/pci/mmconfig.c        |    6 ++++++
 arch/i386/pci/pci.h             |    2 ++
 arch/x86_64/pci/mmconfig.c      |    6 ++++++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff -puN arch/i386/pci/mmconfig-shared.c~pci-mmconfig-fix-unreachable_devices arch/i386/pci/mmconfig-shared.c
--- linux-2.6/arch/i386/pci/mmconfig-shared.c~pci-mmconfig-fix-unreachable_devices	2007-01-06 00:47:39.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig-shared.c	2007-01-06 04:47:21.000000000 +0900
@@ -43,12 +43,14 @@ static void __init unreachable_devices(v
 			if (val1 == 0xffffffff)
 				continue;
 
-			raw_pci_ops->read(0, bus, devfn, 0, 4, &val2);
-			if (val1 != val2) {
-				set_bit(i + 32 * bus, pci_mmcfg_fallback_slots);
-				printk(KERN_NOTICE "PCI: No mmconfig possible"
-				       " on device %02x:%02x\n", bus, i);
+			if (pci_mmcfg_arch_reachable(0, bus, devfn)) {
+				raw_pci_ops->read(0, bus, devfn, 0, 4, &val2);
+				if (val1 == val2)
+					continue;
 			}
+			set_bit(i + 32 * bus, pci_mmcfg_fallback_slots);
+			printk(KERN_NOTICE "PCI: No mmconfig possible on device"
+			       " %02x:%02x\n", bus, i);
 		}
 	}
 }
diff -puN arch/i386/pci/mmconfig.c~pci-mmconfig-fix-unreachable_devices arch/i386/pci/mmconfig.c
--- linux-2.6/arch/i386/pci/mmconfig.c~pci-mmconfig-fix-unreachable_devices	2007-01-06 00:47:39.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/mmconfig.c	2007-01-06 04:47:14.000000000 +0900
@@ -136,6 +136,12 @@ static struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
+int __init pci_mmcfg_arch_reachable(unsigned int seg, unsigned int bus,
+				    unsigned int devfn)
+{
+	return get_base_addr(seg, bus, devfn) != 0;
+}
+
 int __init pci_mmcfg_arch_init(void)
 {
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
diff -puN arch/x86_64/pci/mmconfig.c~pci-mmconfig-fix-unreachable_devices arch/x86_64/pci/mmconfig.c
--- linux-2.6/arch/x86_64/pci/mmconfig.c~pci-mmconfig-fix-unreachable_devices	2007-01-06 00:47:39.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/pci/mmconfig.c	2007-01-06 04:47:14.000000000 +0900
@@ -112,6 +112,12 @@ static struct pci_raw_ops pci_mmcfg = {
 	.write =	pci_mmcfg_write,
 };
 
+int __init pci_mmcfg_arch_reachable(unsigned int seg, unsigned int bus,
+				    unsigned int devfn)
+{
+	return pci_dev_base(seg, bus, devfn) != NULL;
+}
+
 int __init pci_mmcfg_arch_init(void)
 {
 	int i;
diff -puN arch/i386/pci/pci.h~pci-mmconfig-fix-unreachable_devices arch/i386/pci/pci.h
--- linux-2.6/arch/i386/pci/pci.h~pci-mmconfig-fix-unreachable_devices	2007-01-06 00:47:39.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/pci.h	2007-01-06 00:47:39.000000000 +0900
@@ -101,4 +101,6 @@ extern void pcibios_sort(void);
 #define PCI_MMCFG_MAX_CHECK_BUS 16
 extern DECLARE_BITMAP(pci_mmcfg_fallback_slots, 32*PCI_MMCFG_MAX_CHECK_BUS);
 
+extern int __init pci_mmcfg_arch_reachable(unsigned int seg, unsigned int bus,
+					   unsigned int devfn);
 extern int __init pci_mmcfg_arch_init(void);
_
