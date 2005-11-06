Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVKFPvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVKFPvB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 10:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVKFPvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 10:51:01 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:12616 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S932098AbVKFPvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 10:51:00 -0500
Date: Sun, 06 Nov 2005 17:50:42 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] x86-64: dma_ops for DMA mapping - K3
In-reply-to: <20051106145947.GH3423@mea-ext.zmailer.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Andi Kleen <ak@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@ScaleMP.com)" <shai@scalemp.com>, niv@us.ibm.com,
       Jon Mason <jdmason@us.ibm.com>, Jimi Xenidis <jimix@watson.ibm.com>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Message-id: <20051106155042.GC26442@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051106131112.GE24739@granada.merseine.nu>
 <20051106145947.GH3423@mea-ext.zmailer.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 04:59:47PM +0200, Matti Aarnio wrote:
> On Sun, Nov 06, 2005 at 03:11:12PM +0200, Muli Ben-Yehuda wrote:
> > Hi Andi,
> > 
> > Here's the latest version of the dma_ops patch, updated to address
> > your comments. The patch is against Linus's tree as of a few minutes
> > ago and applies cleanly to 2.6.14-git9. Tested on AMD64 with gart,
> > swiotlb, nommu and iommu=off. There are still a few cleanups left, but
> > I'd appreciate it if this could see wider testing at this
> > stage. Please apply...
> 
>   Works mostly.
> There is some problem which I am not sure of is it related
> to this at all or not.  BUG report attached below.

I think this is the same problem as the one referenced in this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113063216900541&w=2 
which predates my changes. The error message looks different
because the "no IOMMU" code path now goes through nommu, rather than
gart with no_iommu set, but it appears to be the same underlying
problem. Can you please send me your vmlinux and / or apply this debug
patch and post the results to verify?

Thanks,
Muli

Exporting patch:
# HG changeset patch
# User Muli Ben-Yehuda <mulix@mulix.org>
# Node ID 64c901d4194adab05d2401208bb24e69d9993dba
# Parent  d75ad581e6f925a389f7f69bf3ec725459c77f9f
debug patch for Matti Aarnio

diff -r d75ad581e6f925a389f7f69bf3ec725459c77f9f -r 64c901d4194adab05d2401208bb24e69d9993dba drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c	Sun Nov  6 10:08:10 2005
+++ b/drivers/usb/core/hcd.c	Sun Nov  6 15:48:07 2005
@@ -1183,14 +1183,32 @@
 	 */
 	if (hcd->self.controller->dma_mask) {
 		if (usb_pipecontrol (urb->pipe)
-			&& !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP))
+		    && !(urb->transfer_flags & URB_NO_SETUP_DMA_MAP)) {
+			printk("%s: calling dma_map_single(direction = %d, "
+			       "ptr = %p, virt_to_bus(ptr) = 0x%lx, "
+			       "size = %d, hwdev->dma_mask = 0x%Lx)\n",
+			       __func__, DMA_TO_DEVICE,
+			       urb->setup_packet, 
+			       virt_to_bus(urb->setup_packet),
+			       (int)sizeof(struct usb_ctrlrequest),
+			       *hcd->self.controller->dma_mask);
 			urb->setup_dma = dma_map_single (
 					hcd->self.controller,
 					urb->setup_packet,
 					sizeof (struct usb_ctrlrequest),
 					DMA_TO_DEVICE);
+		}
 		if (urb->transfer_buffer_length != 0
 			&& !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP))
+			printk("%s: calling dma_map_single(direction = %d, "
+			       "ptr = %p, virt_to_bus(ptr) = 0x%lx, "
+			       "size = %d, hwdev->dma_mask = 0x%Lx)\n",
+			       __func__, (usb_pipein (urb->pipe) ? 
+                               DMA_FROM_DEVICE : DMA_TO_DEVICE),
+			       urb->transfer_buffer,
+			       virt_to_bus(urb->transfer_buffer),
+			       urb->transfer_buffer_length,
+			       *hcd->self.controller->dma_mask);
 			urb->transfer_dma = dma_map_single (
 					hcd->self.controller,
 					urb->transfer_buffer,
diff -r d75ad581e6f925a389f7f69bf3ec725459c77f9f -r 64c901d4194adab05d2401208bb24e69d9993dba include/asm-x86_64/nommu-mapping.h
--- a/include/asm-x86_64/nommu-mapping.h	Sun Nov  6 10:08:10 2005
+++ b/include/asm-x86_64/nommu-mapping.h	Sun Nov  6 15:48:07 2005
@@ -21,8 +21,13 @@
 		out_of_line_bug();
 	addr = virt_to_bus(ptr);
 
-	if ((addr+size) & ~*hwdev->dma_mask)
+	if ((addr+size) & ~*hwdev->dma_mask) {
+		printk("%s: addr 0x%Lx, size %d, ~mask 0x%Lx, "
+		       "(addr+size) & ~*hwdev->dma_mask = 0x%lx\n",
+		       __func__, addr, (int)size, ~*hwdev->dma_mask,
+		       (addr+size) & ~*hwdev->dma_mask);
 		out_of_line_bug();
+	}
 	return addr;
 }
 

-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

