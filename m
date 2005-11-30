Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVK3Ujd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVK3Ujd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 15:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVK3Ujd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 15:39:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750730AbVK3Ujc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 15:39:32 -0500
Date: Wed, 30 Nov 2005 12:39:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Carlos =?ISO-8859-1?B?TWFydO1u?= <carlosmn@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc3-mm1
Message-Id: <20051130123920.35193b6a.akpm@osdl.org>
In-Reply-To: <fe726f4e0511300932l2ee9eabdg@mail.gmail.com>
References: <20051129203134.13b93f48.akpm@osdl.org>
	<fe726f4e0511300932l2ee9eabdg@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Martín <carlosmn@gmail.com> wrote:
>
>  I get this when I try to compile on a x86_64.
> 
>  carlos@kiopa:~/kernel/linux-2.6.15-rc2-mm1$
>  CROSS_COMPILE=/cross-tools/bin/x86_64-gnu-linux- make bzImage modules
>    CHK     include/linux/version.h
>    CHK     include/linux/compile.h
>    CHK     usr/initramfs_list
>    LD      arch/x86_64/kernel/bootflag.o
>    CC      arch/x86_64/kernel/pci-dma.o
>  arch/x86_64/kernel/pci-dma.c:29: error: conflicting types for 'dma_map_sg'
>  include/asm/dma-mapping.h:149: error: previous declaration of
>  'dma_map_sg' was here
>  arch/x86_64/kernel/pci-dma.c:50: error: conflicting types for 'dma_unmap_sg'
>  include/asm/dma-mapping.h:151: error: previous declaration of
>  'dma_unmap_sg' was here

--- devel/arch/x86_64/kernel/pci-dma.c~move-swiotlb-header-file-into-common-code-fix-2	2005-11-30 12:38:52.000000000 -0800
+++ devel-akpm/arch/x86_64/kernel/pci-dma.c	2005-11-30 12:38:52.000000000 -0800
@@ -25,11 +25,11 @@
  * the same here.
  */
 int dma_map_sg(struct device *hwdev, struct scatterlist *sg,
-	       int nents, int direction)
+	       int nents, enum dma_data_direction dir)
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(dir == DMA_NONE);
  	for (i = 0; i < nents; i++ ) {
 		struct scatterlist *s = &sg[i];
 		BUG_ON(!s->page); 
@@ -38,7 +38,6 @@ int dma_map_sg(struct device *hwdev, str
 	}
 	return nents;
 }
-
 EXPORT_SYMBOL(dma_map_sg);
 
 /* Unmap a set of streaming mode DMA translations.
@@ -46,7 +45,7 @@ EXPORT_SYMBOL(dma_map_sg);
  * pci_unmap_single() above.
  */
 void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		  int nents, int dir)
+		  int nents, enum dma_data_direction dir)
 {
 	int i;
 	for (i = 0; i < nents; i++) { 
@@ -56,5 +55,4 @@ void dma_unmap_sg(struct device *dev, st
 		dma_unmap_single(dev, s->dma_address, s->dma_length, dir);
 	} 
 }
-
 EXPORT_SYMBOL(dma_unmap_sg);
_

