Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWJNMJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWJNMJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWJNMIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:08:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12493 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932204AbWJNMIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:14 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Matthew Wilcox <matthew@wil.cx>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 02/18] V4L/DVB (4725): Fix vivi compile on parisc
Date: Sat, 14 Oct 2006 09:00:50 -0300
Message-id: <20061014120050.PS14686200002@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Matthew Wilcox <matthew@wil.cx>

parisc (and several other architectures) don't have a dma_address in their
sg list.  Use the macro instead.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/vivi.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index e7c01d5..3c8dc72 100644
--- a/drivers/media/video/vivi.c
+++ b/drivers/media/video/vivi.c
@@ -272,7 +272,7 @@ static void gen_line(struct sg_to_addr t
 
 	/* Get first addr pointed to pixel position */
 	oldpg=get_addr_pos(pos,pages,to_addr);
-	pg=pfn_to_page(to_addr[oldpg].sg->dma_address >> PAGE_SHIFT);
+	pg=pfn_to_page(sg_dma_address(to_addr[oldpg].sg) >> PAGE_SHIFT);
 	basep = kmap_atomic(pg, KM_BOUNCE_READ)+to_addr[oldpg].sg->offset;
 
 	/* We will just duplicate the second pixel at the packet */
@@ -287,7 +287,7 @@ static void gen_line(struct sg_to_addr t
 		for (color=0;color<4;color++) {
 			pgpos=get_addr_pos(pos,pages,to_addr);
 			if (pgpos!=oldpg) {
-				pg=pfn_to_page(to_addr[pgpos].sg->dma_address >> PAGE_SHIFT);
+				pg=pfn_to_page(sg_dma_address(to_addr[pgpos].sg) >> PAGE_SHIFT);
 				kunmap_atomic(basep, KM_BOUNCE_READ);
 				basep= kmap_atomic(pg, KM_BOUNCE_READ)+to_addr[pgpos].sg->offset;
 				oldpg=pgpos;
@@ -339,8 +339,8 @@ static void gen_line(struct sg_to_addr t
 				for (color=0;color<4;color++) {
 					pgpos=get_addr_pos(pos,pages,to_addr);
 					if (pgpos!=oldpg) {
-						pg=pfn_to_page(to_addr[pgpos].
-								sg->dma_address
+						pg=pfn_to_page(sg_dma_address(
+								to_addr[pgpos].sg)
 								>> PAGE_SHIFT);
 						kunmap_atomic(basep,
 								KM_BOUNCE_READ);
@@ -386,7 +386,7 @@ static void vivi_fillbuff(struct vivi_de
 	struct timeval ts;
 
 	/* Test if DMA mapping is ready */
-	if (!vb->dma.sglist[0].dma_address)
+	if (!sg_dma_address(&vb->dma.sglist[0]))
 		return;
 
 	prep_to_addr(to_addr,vb);
@@ -783,7 +783,7 @@ static int vivi_map_sg(void *dev, struct
 	for (i = 0; i < nents; i++ ) {
 		BUG_ON(!sg[i].page);
 
-		sg[i].dma_address = page_to_phys(sg[i].page) + sg[i].offset;
+		sg_dma_address(&sg[i]) = page_to_phys(sg[i].page) + sg[i].offset;
 	}
 
 	return nents;

