Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbULFAUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbULFAUp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULFAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:20:45 -0500
Received: from 4.Red-80-32-108.pooles.rima-tde.net ([80.32.108.4]:7552 "EHLO
	gimli") by vger.kernel.org with ESMTP id S261431AbULFAUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:20:36 -0500
Message-ID: <41B3A683.8060008@sombragris.com>
Date: Mon, 06 Dec 2004 01:23:31 +0100
From: Miguel Angel Flores <maf@sombragris.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: aic7xxx driver large integer warning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list.

As I said yesterday, the 2.6.10rc3 kernel warns compiling the aic7xxxx 
SCSI driver:

---
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c: In function 
`ahc_linux_pci_dev_probe':
drivers/scsi/aic7xxx/aic7xxx_osm_pci.c:229: warning: large integer 
implicitly truncated to unsigned type
---

[aic7xxx_osm_pci.c]
    mask_39bit = 0x7FFFFFFFFFULL;

mask_39bit type is dma_addr_t. However the length of dma_addr_t is 
defined in types.h.

[types.h]
    #ifdef CONFIG_HIGHMEM64G
    typedef u64 dma_addr_t;
    #else
    typedef u32 dma_addr_t;
    #endif
    typedef u64 dma64_addr_t;

I think the correct solution is to make the assignement only if 
CONFIG_HIGHMEM64G is defined:

[aic7xxx_osm_pci.c]
        mask_39bit = 0x7FFFFFFFFFULL;  //assignement
        if (sizeof(dma_addr_t) > 4 //CONFIG_HIGHMEM64G is defined
         && ahc_linux_get_memsize() > 0x80000000
         && pci_set_dma_mask(pdev, mask_39bit) == 0) {

            /* the correct position of the assignement IMHO */

            ahc->flags |= AHC_39BIT_ADDRESSING;
            ahc->platform_data->hw_dma_mask = mask_39bit;
        } else {
            if (pci_set_dma_mask(pdev, 0xFFFFFFFF)) {
                printk(KERN_WARNING "aic7xxx: No suitable DMA 
available.\n");
                        return (-ENODEV);
            }
            ahc->platform_data->hw_dma_mask = 0xFFFFFFFF;

Before I post a new patch, I wish to know your opinion.

Thanks,
MaF

