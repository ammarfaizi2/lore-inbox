Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTA0TKh>; Mon, 27 Jan 2003 14:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTA0TKh>; Mon, 27 Jan 2003 14:10:37 -0500
Received: from [217.167.51.129] ([217.167.51.129]:39655 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266926AbTA0TKf>;
	Mon, 27 Jan 2003 14:10:35 -0500
Subject: Re: 2.4.21-pre3 kernel crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <1043694192.2756.55.camel@zion.wanadoo.fr>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
	 <3E356403.9010805@google.com>  <1043694192.2756.55.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043695294.2755.61.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Jan 2003 20:21:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, after a second look, 2.4.20 seem correct. Here's a patch against 2.4.21-pre3
doing it like 2.4.20 did.

Let me know if it helps


===== drivers/ide/ide-dma.c 1.7 vs edited =====
--- 1.7/drivers/ide/ide-dma.c	Tue Dec 10 21:21:57 2002
+++ edited/drivers/ide/ide-dma.c	Mon Jan 27 20:17:35 2003
@@ -249,36 +249,54 @@
 {
 	struct buffer_head *bh;
 	struct scatterlist *sg = hwif->sg_table;
+	unsigned long lastdataend = ~0UL;
 	int nents = 0;
 
 	if (hwif->sg_dma_active)
 		BUG();
 
+	hwif->sg_dma_direction = ddir;
+
 	bh = rq->bh;
 	do {
-		unsigned char *virt_addr = bh->b_data;
-		unsigned int size = bh->b_size;
+		struct scatterlist *sge;
+
+		/*
+		 * continue segment from before?
+		 */
+		if (bh_phys(bh) == lastdataend) {
+			sg[nents - 1].length += bh->b_size;
+			lastdataend += bh->b_size;
+			continue;
+		}
 
+		/*
+		 * start new segment
+		 */
 		if (nents >= PRD_ENTRIES)
 			return 0;
 
-		while ((bh = bh->b_reqnext) != NULL) {
-			if ((virt_addr + size) != (unsigned char *) bh->b_data)
-				break;
-			size += bh->b_size;
+		sge = &sg[nents];
+		memset(sge, 0, sizeof(*sge));
+
+		if (bh->b_page) {
+			sge->page = bh->b_page;
+			sge->offset = bh_offset(bh);
+		} else {
+			if (((unsigned long) bh->b_data) < PAGE_SIZE)
+				BUG();
+
+			sge->address = bh->b_data;
 		}
-		memset(&sg[nents], 0, sizeof(*sg));
-		sg[nents].address = virt_addr;
-		sg[nents].length = size;
-		if(size == 0)
-			BUG();
+
+		sge->length = bh->b_size;
+		lastdataend = bh_phys(bh) + bh->b_size;
 		nents++;
-	} while (bh != NULL);
+	} while ((bh = bh->b_reqnext) != NULL);
 
 	if(nents == 0)
 		BUG();
 		
-	hwif->sg_dma_direction = ddir;
 	return pci_map_sg(hwif->pci_dev, sg, nents, ddir);
 }
 

