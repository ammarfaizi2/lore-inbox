Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbUAEVcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbUAEVcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:32:13 -0500
Received: from ns.suse.de ([195.135.220.2]:7574 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265924AbUAEVcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:32:01 -0500
Date: Mon, 5 Jan 2004 22:31:58 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple 
 map/unmaps
Message-Id: <20040105223158.3364a676.ak@suse.de>
In-Reply-To: <20040105130118.0cb404b8.davem@redhat.com>
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kernel>
	<20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
	<p73brpi1544.fsf@verdi.suse.de>
	<20040105130118.0cb404b8.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004 13:01:18 -0800
"David S. Miller" <davem@redhat.com> wrote:

> On 05 Jan 2004 22:02:19 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > It sets length to zero to terminate the list when entries were merged.
> > It doesn't have a dma_length.
> 
> I understand, and you are defining dma_length to just use the
> normal sg->length field, and I'm trying to explain to you that this
> is not allowed.  If you want to modify the length field to zero terminate
> the DMA chunks, you must have a seperate dma_length field in your
> platforms scatterlist structure.

DMA-mapping.txt does not ever mention a dma_length or that remapping
is legal. 

> Again, for the 3rd time, see what sparc64 is doing here.

Sorry Dave, I'm not going to reverse engineer your cryptic mess.
If you have any more such undocumented requirements you should definitely
add them to the Spec.

For the sake of bug-to-bug compatibility to the SCSI layer this patch may
work. I haven't tested it so no guarantees if it won't eat your file systems.
Feedback welcome anyways.

-Andi

diff -u linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c-o linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c
--- linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c-o	2004-01-01 06:40:28.000000000 +0100
+++ linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c	2004-01-05 22:17:49.000000000 +0100
@@ -384,6 +395,7 @@
 			}
 		}
 		s->dma_address = addr;
+		s->dma_length = s->length;
 	}
 	flush_gart(dev);
 	return nents;
@@ -410,8 +422,9 @@
 			*sout = *s; 
 			sout->dma_address = iommu_bus_base;
 			sout->dma_address += iommu_page*PAGE_SIZE + s->offset;
+			sout->dma_length = s->length;
 		} else { 
-			sout->length += s->length; 
+			sout->dma_length += s->length; 
 		}
 
 		addr = phys_addr;
@@ -538,9 +551,9 @@
 	int i;
 	for (i = 0; i < nents; i++) { 
 		struct scatterlist *s = &sg[i];
-		if (!s->length) 
+		if (!s->dma_length || !s->length) 
 			break;
-		pci_unmap_single(dev, s->dma_address, s->length, dir);
+		pci_unmap_single(dev, s->dma_address, s->dma_length, dir);
 	}
 }
 
diff -u linux-2.6.1rc1-amd64/include/asm-x86_64/scatterlist.h-o linux-2.6.1rc1-amd64/include/asm-x86_64/scatterlist.h
--- linux-2.6.1rc1-amd64/include/asm-x86_64/scatterlist.h-o	2003-07-18 02:40:01.000000000 +0200
+++ linux-2.6.1rc1-amd64/include/asm-x86_64/scatterlist.h	2004-01-05 22:10:15.000000000 +0100
@@ -4,8 +4,9 @@
 struct scatterlist {
     struct page		*page;
     unsigned int	offset;
-    unsigned int	length;
+    unsigned int	length;  
     dma_addr_t		dma_address;
+    unsigned int        dma_length;
 };
 
 #define ISA_DMA_THRESHOLD (0x00ffffff)

