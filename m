Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUG0RH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUG0RH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266436AbUG0RH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:07:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266434AbUG0RHU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:07:20 -0400
Message-ID: <41068BBB.3090000@pobox.com>
Date: Tue, 27 Jul 2004 13:07:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.8-rc2] sata_nv.c
References: <DBFABB80F7FD3143A911F9E6CFD477B03F95E1@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B03F95E1@hqemmail02.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
> This patch updates the NVIDIA libata-based SATA driver to support the
> CK804 SATA controller.

Please fix and resubmit:

1) [style] no need to explicitly init first enum to zero:

+typedef enum
+{
+       NFORCE2 = 0,
+       NFORCE3,
+       CK804
+} nv_host_type_t;


2) in Linux (and POSIX), 'struct foo' is preferred over 'foo_t':

+{
+       nv_host_type_t          host_type;
+       unsigned long           host_flags;
+       void                    (*enable_hotplug)(struct ata_probe_ent 
*probe_en
t);
+       void                    (*disable_hotplug)(struct ata_host_set 
*host_set
);
+       void                    (*check_hotplug)(struct ata_host_set 
*host_set);
+
+} nv_host_desc_t;


3) [style] single statements should not be enclosed by braces

+       if (host->host_desc->check_hotplug) {
+               host->host_desc->check_hotplug(host_set);
         }
...
+       if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+               return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+       } else {
+               return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+       }
...
+       // Enable hotplug event interrupts.
+       if (host->host_desc->enable_hotplug) {
+               host->host_desc->enable_hotplug(probe_ent);
+       }

etc.


4) [leak] driver appears to be missing a ->host_free hook, to free your 
nv_host_t structure.

+       host = kmalloc(sizeof(nv_host_t), GFP_KERNEL);


5) [bug] check ioremap return value for failure (==NULL)

+               mmio_base = ioremap(pci_resource_start(pdev, 5),
+                               pci_resource_len(pdev, 5));


6) [leak] probe_ent->mmio_base is not set for the MMIO case, therefore, 
iounmap() is never called for you by ata_pci_remove_one() [libata-core.c].


7) don't use host->scr_addr as a sly way to obtain your base address. 
Use host_set->mmio_base directly (casting from unsigned long if it's PIO 
rather than MMIO).


8) "avoid magic numbers".  Avoid decimal or hexidecimal constants in 
actual code.  Prefer to use macros/enums instead.

+       pci_read_config_byte(probe_ent->pdev, 0x50, &regval);
+       regval |= 0x04;
+       pci_write_config_byte(probe_ent->pdev, 0x50, regval);


