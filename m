Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271557AbRHPLtu>; Thu, 16 Aug 2001 07:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271559AbRHPLtj>; Thu, 16 Aug 2001 07:49:39 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:53252 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S271557AbRHPLt0>; Thu, 16 Aug 2001 07:49:26 -0400
Date: Thu, 16 Aug 2001 13:51:50 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010816135150.X4352@suse.de>
In-Reply-To: <20010815.053524.48804759.davem@redhat.com> <20010815151052.C4352@suse.de> <20010815.070204.39155321.davem@redhat.com> <20010815.072548.48531893.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010815.072548.48531893.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15 2001, David S. Miller wrote:
>    From: "David S. Miller" <davem@redhat.com>
>    Date: Wed, 15 Aug 2001 07:02:04 -0700 (PDT)
>    
>       >    Yep. Want me to add in the x86 parts of your patch?
>       > 
>       > Please let me finish up my prototype with sparc64 building and
>       > working, then I'll send you what I have ok?
>       
>       Fine
>       
>    This is forthcoming.
> 
> As promised.  I actually got bored during the build and tried to

Looks good! And works here too, even... ->

> quickly cook up the ix86 bits myself :-)

the boring x86 parts :-)

The only difference between your and my tree now is the PCI_MAX_DMA32
flag. Would you consider this? I already use this flag in the block
stuff, I just updated the two references you had. Maybe
PCI_MAX_DMA32_MASK is a better name.

I'll update the block-highmem patch later today -- and with this in
place, there's nothing stopping zero-bounce from going beyond 4GB on the
right hw. Yippi.

--- linux/include/linux/pci.h~	Thu Aug 16 13:40:32 2001
+++ linux/include/linux/pci.h	Thu Aug 16 13:41:11 2001
@@ -314,6 +314,8 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define PCI_MAX_DMA32		0xffffffff
+
 /* These are the boolean attributes stored in pci_dev->dma_flags. */
 #define PCI_DMA_FLAG_HUGE_MAPS	0x00000001 /* Device may hold an enormous number
 					    * of mappings at once?
--- linux/drivers/scsi/sym53c8xx.c~	Thu Aug 16 13:42:27 2001
+++ linux/drivers/scsi/sym53c8xx.c	Thu Aug 16 13:42:50 2001
@@ -13101,7 +13101,7 @@
 		(int) (PciDeviceFn(pdev) & 7));
 
 #ifdef SCSI_NCR_DYNAMIC_DMA_MAPPING
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(pdev, PCI_MAX_DMA32)) {
 		printk(KERN_WARNING NAME53C8XX
 		       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
 		return -1;
--- linux/drivers/scsi/sym53c8xx_comm.h~	Thu Aug 16 13:43:09 2001
+++ linux/drivers/scsi/sym53c8xx_comm.h	Thu Aug 16 13:43:32 2001
@@ -2186,7 +2186,7 @@
 		(int) (PciDeviceFn(pdev) & 7));
 
 #ifdef SCSI_NCR_DYNAMIC_DMA_MAPPING
-	if (!pci_dma_supported(pdev, 0xffffffff)) {
+	if (!pci_dma_supported(pdev, PCI_MAX_DMA32)) {
 		printk(KERN_WARNING NAME53C8XX
 		       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
 		return -1;

-- 
Jens Axboe

