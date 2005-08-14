Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVHNWOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVHNWOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 18:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVHNWOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 18:14:11 -0400
Received: from pop.gmx.net ([213.165.64.20]:20642 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932333AbVHNWOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 18:14:09 -0400
X-Authenticated: #20450766
Date: Mon, 15 Aug 2005 00:13:15 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] scsi bug fixes for 2.6.13
In-Reply-To: <1124048890.18802.13.camel@mulgrave>
Message-ID: <Pine.LNX.4.60.0508150010200.26220@poirot.grange>
References: <1123184634.5026.58.camel@mulgrave>  <Pine.LNX.4.60.0508142121000.4594@poirot.grange>
 <1124048890.18802.13.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005, James Bottomley wrote:

> On Sun, 2005-08-14 at 21:33 +0200, Guennadi Liakhovetski wrote:
> > Just to make sure everyone agrees on this - there's currently a know bug 
> > in dc395x with highmem reported by Pierre Ossman in thread "Kernel panic 
> > with dc395x in 2.6.12.2" on linux-scsi. It is also trivial to reproduce on 
> > non-highmem machines. It was there also in 2.6.12. It only was hit by one 
> > person because not many use dc395x controlled cards in highmem machines 
> > today. The fix is known - at least revert my patch to dc395x commited to 
> > 2.6.12-rc5. This will fix this bug, leaving another one, which is much 
> > harder to hit. There was only one person who hit it, but he cannot test 
> > any more patches - the hardware is not there any more. I think I have a 
> > fix for that one too, but that's another story. So, I would say it would 
> > be worth it reverting that patch before 2.6.13, but, that's because I feel 
> > personal responsibility for that bug:-)
> 
> OK, why don't we do this.  Instead of having me trawl through the trees
> looking for the correct patch to reverse, why don't you attach it in an
> email and I'll try to get it in to 2.6.13?

Ok. Below.

Sorry again for the trouble
Guennadi
---
Guennadi Liakhovetski

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

diff -u a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
--- a/drivers/scsi/dc395x.c	17 Nov 2004 21:04:51
+++ b/drivers/scsi/dc395x.c	22 Jan 2005 22:55:45
@@ -182,7 +182,7 @@
  * cross a page boundy.
  */
 #define SEGMENTX_LEN	(sizeof(struct SGentry)*DC395x_MAX_SG_LISTENTRY)
-
+#define VIRTX_LEN	(sizeof(void *) * DC395x_MAX_SG_LISTENTRY)
 
 struct SGentry {
 	u32 address;		/* bus! address */
@@ -234,6 +234,7 @@
 	u8 sg_count;			/* No of HW sg entries for this request */
 	u8 sg_index;			/* Index of HW sg entry for this request */
 	u32 total_xfer_length;		/* Total number of bytes remaining to be transfered */
+	void **virt_map;
 	unsigned char *virt_addr;	/* Virtual address of current transfer position */
 
 	/*
@@ -1020,14 +1021,14 @@
 			reqlen, cmd->request_buffer, cmd->use_sg,
 			srb->sg_count);
 
-		srb->virt_addr = page_address(sl->page);
 		for (i = 0; i < srb->sg_count; i++) {
-			u32 busaddr = (u32)sg_dma_address(&sl[i]);
-			u32 seglen = (u32)sl[i].length;
-			sgp[i].address = busaddr;
+			u32 seglen = (u32)sg_dma_len(sl + i);
+			sgp[i].address = (u32)sg_dma_address(sl + i);
 			sgp[i].length = seglen;
 			srb->total_xfer_length += seglen;
+			srb->virt_map[i] = kmap(sl[i].page);
 		}
+		srb->virt_addr = srb->virt_map[0];
 		sgp += srb->sg_count - 1;
 
 		/*
@@ -1964,6 +1965,7 @@
 	int segment = cmd->use_sg;
 	u32 xferred = srb->total_xfer_length - left; /* bytes transfered */
 	struct SGentry *psge = srb->segment_x + srb->sg_index;
+	void **virt = srb->virt_map;
 
 	dprintkdbg(DBG_0,
 		"sg_update_list: Transfered %i of %i bytes, %i remain\n",
@@ -2003,16 +2005,16 @@
 
 	/* We have to walk the scatterlist to find it */
 	sg = (struct scatterlist *)cmd->request_buffer;
+	idx = 0;
 	while (segment--) {
 		unsigned long mask =
 		    ~((unsigned long)sg->length - 1) & PAGE_MASK;
 		if ((sg_dma_address(sg) & mask) == (psge->address & mask)) {
-			srb->virt_addr = (page_address(sg->page)
-					   + psge->address -
-					   (psge->address & PAGE_MASK));
+			srb->virt_addr = virt[idx] + (psge->address & ~PAGE_MASK);
 			return;
 		}
 		++sg;
+		++idx;
 	}
 
 	dprintkl(KERN_ERR, "sg_update_list: sg_to_virt failed\n");
@@ -2138,7 +2140,7 @@
 				DC395x_read32(acb, TRM_S1040_DMA_CXCNT));
 		}
 		/*
-		 * calculate all the residue data that not yet tranfered
+		 * calculate all the residue data that not yet transfered
 		 * SCSI transfer counter + left in SCSI FIFO data
 		 *
 		 * .....TRM_S1040_SCSI_COUNTER (24bits)
@@ -3256,6 +3258,7 @@
 	struct scsi_cmnd *cmd = srb->cmd;
 	enum dma_data_direction dir = cmd->sc_data_direction;
 	if (cmd->use_sg && dir != PCI_DMA_NONE) {
+		int i;
 		/* unmap DC395x SG list */
 		dprintkdbg(DBG_SG, "pci_unmap_srb: list=%08x(%05x)\n",
 			srb->sg_bus_addr, SEGMENTX_LEN);
@@ -3265,6 +3268,8 @@
 		dprintkdbg(DBG_SG, "pci_unmap_srb: segs=%i buffer=%p\n",
 			cmd->use_sg, cmd->request_buffer);
 		/* unmap the sg segments */
+		for (i = 0; i < srb->sg_count; i++)
+			kunmap(virt_to_page(srb->virt_map[i]));
 		pci_unmap_sg(acb->dev,
 			     (struct scatterlist *)cmd->request_buffer,
 			     cmd->use_sg, dir);
@@ -3311,7 +3316,7 @@
 
 	if (cmd->use_sg) {
 		struct scatterlist* sg = (struct scatterlist *)cmd->request_buffer;
-		ptr = (struct ScsiInqData *)(page_address(sg->page) + sg->offset);
+		ptr = (struct ScsiInqData *)(srb->virt_map[0] + sg->offset);
 	} else {
 		ptr = (struct ScsiInqData *)(cmd->request_buffer);
 	}
@@ -4246,8 +4251,9 @@
 	const unsigned srbs_per_page = PAGE_SIZE/SEGMENTX_LEN;
 
 	for (i = 0; i < DC395x_MAX_SRB_CNT; i += srbs_per_page)
-		if (acb->srb_array[i].segment_x)
-			kfree(acb->srb_array[i].segment_x);
+		kfree(acb->srb_array[i].segment_x);
+
+	vfree(acb->srb_array[0].virt_map);
 }
 
 
@@ -4263,9 +4269,12 @@
 	int srb_idx = 0;
 	unsigned i = 0;
 	struct SGentry *ptr;
+	void **virt_array;
 
-	for (i = 0; i < DC395x_MAX_SRB_CNT; i++)
+	for (i = 0; i < DC395x_MAX_SRB_CNT; i++) {
 		acb->srb_array[i].segment_x = NULL;
+		acb->srb_array[i].virt_map = NULL;
+	}
 
 	dprintkdbg(DBG_1, "Allocate %i pages for SG tables\n", pages);
 	while (pages--) {
@@ -4286,6 +4295,19 @@
 		    ptr + (i * DC395x_MAX_SG_LISTENTRY);
 	else
 		dprintkl(KERN_DEBUG, "No space for tmsrb SG table reserved?!\n");
+
+	virt_array = vmalloc((DC395x_MAX_SRB_CNT + 1) * DC395x_MAX_SG_LISTENTRY * sizeof(void*));
+
+	if (!virt_array) {
+		adapter_sg_tables_free(acb);
+		return 1;
+	}
+
+	for (i = 0; i < DC395x_MAX_SRB_CNT + 1; i++) {
+		acb->srb_array[i].virt_map = virt_array;
+		virt_array += DC395x_MAX_SG_LISTENTRY;
+	}
+
 	return 0;
 }
 
