Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWJFQfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWJFQfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbWJFQfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:35:46 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:11702 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422701AbWJFQfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:35:45 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Fix vivi compile on parisc
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Fri, 06 Oct 2006 10:35:45 -0600
Message-Id: <11601525451073-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parisc (and several other architectures) don't have a dma_address in their
sg list.  Use the macro instead.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 drivers/media/video/vivi.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/video/vivi.c b/drivers/media/video/vivi.c
index 841884a..a2ef093 100644
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
-- 
1.4.1.1

