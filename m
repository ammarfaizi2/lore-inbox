Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbULAASU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbULAASU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbULAAQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:16:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:38116 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261202AbULAAOR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:14:17 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.10-rc2
User-Agent: Mutt/1.5.6i
In-Reply-To: <11018598042987@kroah.com>
Date: Tue, 30 Nov 2004 16:10:04 -0800
Message-Id: <11018598042649@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2223.2.4, 2004/11/29 11:13:49-08:00, ak@suse.de

[PATCH] PCI: Disable mmconfig on AMD CPUs.

Disable mmconfig on AMD CPUs.

This patch fixes various problems on PCI Express boards, like the
Nforce4. They have a MCFG table in ACPI, but not all devices can be
accessed using MMCONFIG.  e.g. the CPU builtin PCI devices in the A64
Northbridge can't.  Linux happily uses mmconfig for all PCI devices and
that cause failures and memory corruption.

Right solution apparently is to get more information from MCFG which is
supposed to tell for which busses mmconfig is legal and for which ones
not. But that would be a much more complicated patch and I don't have
a specification of this enhanced table.

This patch just disable MMCONFIG on all AMD CPUs. This is a kludge,
but works around the problem for now.

Patch for both i386 and x86-64

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/mmconfig.c   |    7 +++++++
 arch/x86_64/pci/mmconfig.c |    7 +++++++
 2 files changed, 14 insertions(+)


diff -Nru a/arch/i386/pci/mmconfig.c b/arch/i386/pci/mmconfig.c
--- a/arch/i386/pci/mmconfig.c	2004-11-30 15:47:12 -08:00
+++ b/arch/i386/pci/mmconfig.c	2004-11-30 15:47:12 -08:00
@@ -102,6 +102,13 @@
 	if (!pci_mmcfg_base_addr)
 		goto out;
 
+	/* Kludge for now. Don't use mmconfig on AMD systems because
+	   those have some busses where mmconfig doesn't work,
+	   and we don't parse ACPI MCFG well enough to handle that. 
+	   Remove when proper handling is added. */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		goto out; 
+
 	printk(KERN_INFO "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
diff -Nru a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
--- a/arch/x86_64/pci/mmconfig.c	2004-11-30 15:47:12 -08:00
+++ b/arch/x86_64/pci/mmconfig.c	2004-11-30 15:47:12 -08:00
@@ -78,6 +78,13 @@
 	if (!pci_mmcfg_base_addr)
 		return 0;
 
+	/* Kludge for now. Don't use mmconfig on AMD systems because
+	   those have some busses where mmconfig doesn't work,
+	   and we don't parse ACPI MCFG well enough to handle that. 
+	   Remove when proper handling is added. */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return 0; 
+
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = ioremap_nocache(pci_mmcfg_base_addr, MMCONFIG_APER_SIZE);
 	if (!pci_mmcfg_virt) { 

