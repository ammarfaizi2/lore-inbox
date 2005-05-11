Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVEKVKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVEKVKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVEKVKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:10:52 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:48515 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262046AbVEKVKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:10:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XA21nMrMafy1G+wDQiMJTCInjdVUPCEUXv4tFJnjSQLmppNEUchl8D1REcjsf2s92kUD4z4T3jH/PiZWEwg7TP04qi/97MxZXSZxwG12nv8P1RE4hXc2JrG00ccRP2svUjZNriqRhCNELEoiWzTg+56jUGi8tjh1tsWY/ReLWPQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [patch] v4l: saa7134 byteorder fix
Date: Thu, 12 May 2005 01:13:43 +0400
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
References: <20050511195910.GA23126@bytesex>
In-Reply-To: <20050511195910.GA23126@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505120113.44082.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 May 2005 23:59, Gerd Knorr wrote:
> Fix byteorder bug in the saa7134 driver.  With that ObviouslyCorrect[tm]
> patch applied the driver reportly works on powerpc.

> --- linux-2.6.12-rc3.orig/drivers/media/video/saa7134/saa7134-core.c
> +++ linux-2.6.12-rc3/drivers/media/video/saa7134/saa7134-core.c

> -			*ptr = sg_dma_address(list) - list->offset;
> +			*ptr = cpu_to_le32(sg_dma_address(list) - list->offset);

Clearly mark pointers to little-endian things.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

diff -uprN linux-vanilla/drivers/media/video/saa7134/saa7134-core.c linux-saa/drivers/media/video/saa7134/saa7134-core.c
--- linux-vanilla/drivers/media/video/saa7134/saa7134-core.c	2005-05-10 03:13:22.000000000 +0400
+++ linux-saa/drivers/media/video/saa7134/saa7134-core.c	2005-05-12 00:27:23.000000000 +0400
@@ -316,7 +316,7 @@ unsigned long saa7134_buffer_base(struct
 
 int saa7134_pgtable_alloc(struct pci_dev *pci, struct saa7134_pgtable *pt)
 {
-        u32          *cpu;
+        __le32       *cpu;
         dma_addr_t   dma_addr;
 
 	cpu = pci_alloc_consistent(pci, SAA7134_PGTABLE_SIZE, &dma_addr);
@@ -332,7 +332,7 @@ int saa7134_pgtable_build(struct pci_dev
 			  struct scatterlist *list, unsigned int length,
 			  unsigned int startpage)
 {
-	u32           *ptr;
+	__le32        *ptr;
 	unsigned int  i,p;
 
 	BUG_ON(NULL == pt || NULL == pt->cpu);
diff -uprN linux-vanilla/drivers/media/video/saa7134/saa7134.h linux-saa/drivers/media/video/saa7134/saa7134.h
--- linux-vanilla/drivers/media/video/saa7134/saa7134.h	2005-05-10 03:13:22.000000000 +0400
+++ linux-saa/drivers/media/video/saa7134/saa7134.h	2005-05-12 00:26:20.000000000 +0400
@@ -241,7 +241,7 @@ struct saa7134_dma;
 /* saa7134 page table */
 struct saa7134_pgtable {
 	unsigned int               size;
-	u32                        *cpu;
+	__le32                     *cpu;
 	dma_addr_t                 dma;
 };
 
