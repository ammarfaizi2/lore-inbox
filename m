Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWCXLNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWCXLNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWCXLNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:13:38 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:49670 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751639AbWCXLNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:13:38 -0500
Date: Fri, 24 Mar 2006 12:14:18 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Nigel Cunningham <ncunningham@cyclades.com>, Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 92c05fc1a32e5ccef5e0e8201f32dcdab041524c breaks x86_64 compile.
Message-Id: <20060324121418.c4c03e1d.khali@linux-fr.org>
In-Reply-To: <200603241529.28811.ncunningham@cyclades.com>
References: <200603241529.28811.ncunningham@cyclades.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel, Andi, all,

> It looks to me like the above commit from Andi causes a compilation failure on 
> x86_64, because it makes pci_mmcfg_init non static:
> 
> arch/x86_64/pci/mmconfig.c:152: error: conflicting types for ‘pci_mmcfg_init’
> arch/i386/pci/pci.h:85: error: previous declaration of ‘pci_mmcfg_init’ was 
> here
> make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
> make: *** [arch/x86_64/pci] Error 2

I just hit the same compilation failure. Here's a fix which works for
me.

Fix the x86_64 compilation breakage introduced by commit
92c05fc1a32e5ccef5e0e8201f32dcdab041524c

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Andi Kleen <ak@suse.de>
---
 arch/x86_64/pci/mmconfig.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- linux-2.6.16-git.orig/arch/x86_64/pci/mmconfig.c	2006-03-21 20:15:49.000000000 +0100
+++ linux-2.6.16-git/arch/x86_64/pci/mmconfig.c	2006-03-24 11:54:01.000000000 +0100
@@ -148,24 +148,24 @@
 	}
 }
 
-static int __init pci_mmcfg_init(void)
+void __init pci_mmcfg_init(void)
 {
 	int i;
 
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
-		return 0;
+		return;
 
 	acpi_table_parse(ACPI_MCFG, acpi_parse_mcfg);
 	if ((pci_mmcfg_config_num == 0) ||
 	    (pci_mmcfg_config == NULL) ||
 	    (pci_mmcfg_config[0].base_address == 0))
-		return 0;
+		return;
 
 	/* RED-PEN i386 doesn't do _nocache right now */
 	pci_mmcfg_virt = kmalloc(sizeof(*pci_mmcfg_virt) * pci_mmcfg_config_num, GFP_KERNEL);
 	if (pci_mmcfg_virt == NULL) {
 		printk("PCI: Can not allocate memory for mmconfig structures\n");
-		return 0;
+		return;
 	}
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
 		pci_mmcfg_virt[i].cfg = &pci_mmcfg_config[i];
@@ -173,7 +173,7 @@
 		if (!pci_mmcfg_virt[i].virt) {
 			printk("PCI: Cannot map mmconfig aperture for segment %d\n",
 			       pci_mmcfg_config[i].pci_segment_group_number);
-			return 0;
+			return;
 		}
 		printk(KERN_INFO "PCI: Using MMCONFIG at %x\n", pci_mmcfg_config[i].base_address);
 	}
@@ -183,7 +183,5 @@
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 
-	return 0;
+	return;
 }
-
-arch_initcall(pci_mmcfg_init);


-- 
Jean Delvare
