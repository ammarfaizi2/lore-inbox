Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUAEVkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUAEVku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:40:50 -0500
Received: from ns.suse.de ([195.135.220.2]:39577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265955AbUAEVkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:40:20 -0500
Date: Mon, 5 Jan 2004 22:40:18 +0100
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple 
 map/unmaps II
Message-Id: <20040105224018.43c8cde1.ak@suse.de>
In-Reply-To: <20040105223158.3364a676.ak@suse.de>
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kernel>
	<20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
	<p73brpi1544.fsf@verdi.suse.de>
	<20040105130118.0cb404b8.davem@redhat.com>
	<20040105223158.3364a676.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004 22:31:58 +0100
Andi Kleen <ak@suse.de> wrote:

> For the sake of bug-to-bug compatibility to the SCSI layer this patch may
> work. I haven't tested it so no guarantees if it won't eat your file systems.
> Feedback welcome anyways.

[...]

This version will likely work better (original still set ->length to zero) 

-Andi

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
diff -u linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c-o linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c
--- linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c-o	2004-01-01 06:40:28.000000000 +0100
+++ linux-2.6.1rc1-amd64/arch/x86_64/kernel/pci-gart.c	2004-01-05 22:37:59.000000000 +0100
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
@@ -490,8 +503,8 @@
 		goto error;
 	out++;
 	flush_gart(dev);
-	if (out < nents) 
-		sg[out].length = 0; 
+	if (out < nents)
+		sg[out].dma_length = 0; 
 	return out;
 
 error:
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
 
