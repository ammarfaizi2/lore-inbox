Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030766AbWFOQIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030766AbWFOQIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030762AbWFOQIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:08:34 -0400
Received: from andromeda.dapyr.net ([69.45.6.104]:57011 "EHLO
	andromeda.dapyr.net") by vger.kernel.org with ESMTP
	id S1030761AbWFOQId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:08:33 -0400
Date: Thu, 15 Jun 2006 12:08:30 -0400
From: Konrad Rzeszutek <konradr@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: re: [PATCH] PCI: add proper MCFG table parsing to ACPI core.
Message-ID: <20060615160830.GD3242@andromeda.dapyr.net>
References: <m3lkrzq3zj.fsf@lx-ltd.ru> <20060615072854.GA29713@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615072854.GA29713@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg,

This a bit late (yours patch was posted about a year ago), but
a co-worker of spotted part of the code that looks like a memory
leak. Looking at the code it seems that pci_mmcfg_config should
be free-ed if MMCONFIG is above 4GB.

> +/* The physical address of the MMCONFIG aperture.  Set from ACPI
> tables. */
> +     config_size = pci_mmcfg_config_num * sizeof(*pci_mmcfg_config);
> +     pci_mmcfg_config = kmalloc(config_size, GFP_KERNEL);
> +     memcpy(pci_mmcfg_config, &mcfg->config, config_size);
> +     for (i = 0; i < pci_mmcfg_config_num; ++i) {
> +             if (mcfg->config[i].base_reserved) {
> +                     printk(KERN_ERR PREFIX
> +                            "MMCONFIG not in low 4GB of memory\n");
> +                     return -ENODEV;

Here is a proposed patch. What are your thoughts?

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 40e5aba..fbe9308 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -202,6 +202,8 @@ int __init acpi_parse_mcfg(unsigned long
 		if (mcfg->config[i].base_reserved) {
 			printk(KERN_ERR PREFIX
 			       "MMCONFIG not in low 4GB of memory\n");
+			kfree(pci_mmcfg_config);
+			pci_mmcfg_config_num = 0;
 			return -ENODEV;
 		}
 	}
