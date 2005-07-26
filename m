Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVGZQi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVGZQi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVGZQg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:36:26 -0400
Received: from dvhart.com ([64.146.134.43]:29369 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261944AbVGZQem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:34:42 -0400
Date: Tue, 26 Jul 2005 09:34:15 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andi Kleen <ak@muc.de>
Cc: James Washer <washer@trlp.com>, marcelo.tosatti@cyclades.com,
       linux-mm@kvack.org, James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about OOM-Killer
Message-ID: <19000000.1122395655@[10.10.2.4]>
In-Reply-To: <20050726151754.GA9691@muc.de>
References: <20050725173514.107aaa1b.washer@trlp.com> <733170000.1122384572@[10.10.2.4]> <20050726151754.GA9691@muc.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Andi Kleen <ak@muc.de> wrote (on Tuesday, July 26, 2005 17:17:54 +0200):

>> But that's really for ISA DMA, which nobody uses any more apart from the
>> floppy disk, and the stone-tablet adaptor. For now, I'm guessing that if
>> you remove that __GFP_DMA, your machine will be happier, but it's not
>> the right fix. 
> 
> iirc the reason for that was that someone could load an old ISA SCSI controller
> later as a module and it needs to handle that. Perhaps make it dependent
> on CONFIG_ISA ? But even that would not help on distribution kernels.
> Another way would be to check in PCI systems if there is a ISA 
> bridge and for others assume ISA is there.

Yeah, the CONFIG_ISA thing makes a lot of sense to me ... however, would
be even better if we can work out (easily) what the disk is attatched to.
Pah, ISA is so shit. Generically, might be useful if we had a 
__GFP_DMA_IF_ISA or something defined in the header files, rather than
just shoving ifdef's all over the place.

OTOH, Jim is right ... the OOM killer is being somewhat psycopathic. Seems
we need 2 fixes ;-)

M.

PS. Warning, this is wholly untested, and generally a bit shit.
PPS. jejb ... your mail bounces.

diff -aurpN -X /home/fletch/.diff.exclude virgin/drivers/scsi/sd.c isa_dma/drivers/scsi/sd.c
--- virgin/drivers/scsi/sd.c	2005-07-26 09:25:40.000000000 -0700
+++ isa_dma/drivers/scsi/sd.c	2005-07-26 09:32:05.000000000 -0700
@@ -1468,7 +1468,7 @@ static int sd_revalidate_disk(struct gen
 		goto out;
 	}
 
-	buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA);
+	buffer = kmalloc(512, GFP_KERNEL | __GFP_DMA_IF_ISA);
 	if (!buffer) {
 		printk(KERN_WARNING "(sd_revalidate_disk:) Memory allocation "
 		       "failure.\n");
diff -aurpN -X /home/fletch/.diff.exclude virgin/include/linux/gfp.h isa_dma/include/linux/gfp.h
--- virgin/include/linux/gfp.h	2005-07-26 09:26:02.000000000 -0700
+++ isa_dma/include/linux/gfp.h	2005-07-26 09:29:38.000000000 -0700
@@ -13,6 +13,11 @@ struct vm_area_struct;
  */
 /* Zone modifiers in GFP_ZONEMASK (see linux/mmzone.h - low two bits) */
 #define __GFP_DMA	0x01
+#ifdef CONFIG_ISA
+  #define __GFP_DMA_IF_ISA	__GFP_DMA
+#else
+  #define __GFP_DMA_IF_ISA	0
+#endif
 #define __GFP_HIGHMEM	0x02
 
 /*

