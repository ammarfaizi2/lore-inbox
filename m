Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310333AbSCBHKf>; Sat, 2 Mar 2002 02:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310339AbSCBHK0>; Sat, 2 Mar 2002 02:10:26 -0500
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:51384 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S310333AbSCBHKS>; Sat, 2 Mar 2002 02:10:18 -0500
Date: Fri, 01 Mar 2002 21:10:56 -0800 (PST)
From: Daniel Bertrand <d.bertrand@ieee.org>
Subject: [PATCH] Emu10k1 HIGHMEM dma bug fix
X-X-Sender: d_bertra@kilrogg
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org,
        emu10k1-devel <emu10k1-devel@lists.sourceforge.net>
Message-id: <Pine.LNX.4.44.0202282245320.4553-200000@kilrogg>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_9HL5wDvfTHQfm7HAorKlSA)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_9HL5wDvfTHQfm7HAorKlSA)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hi,

Attached is a patch against 2.4.18 which fixes bugs handling 64bit dma
handles (i.e. 4G or 64G HIGHMEM enabled kernels) in the emu10k1.o driver.


-- 
Daniel Bertrand


--Boundary_(ID_9HL5wDvfTHQfm7HAorKlSA)
Content-id: <Pine.LNX.4.44.0203012110560.5276@kilrogg>
Content-type: TEXT/PLAIN; charset=US-ASCII; name=emu10k1-highmem.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=emu10k1-highmem.patch
Content-description: 

diff -u linux-2.4.18-orig/drivers/sound/emu10k1/main.c linux-2.4.18/drivers/sound/emu10k1/main.c
--- linux-2.4.18-orig/drivers/sound/emu10k1/main.c	Mon Feb 25 11:38:06 2002
+++ linux-2.4.18/drivers/sound/emu10k1/main.c	Thu Feb 28 22:39:46 2002
@@ -867,19 +867,19 @@
 	}
 
 	for (pagecount = 0; pagecount < MAXPAGES; pagecount++)
-		((u32 *) card->virtualpagetable.addr)[pagecount] = cpu_to_le32((card->silentpage.dma_handle * 2) | pagecount);
+		((u32 *) card->virtualpagetable.addr)[pagecount] = cpu_to_le32(((u32)card->silentpage.dma_handle * 2) | pagecount);
 
 	/* Init page table & tank memory base register */
 	sblive_writeptr_tag(card, 0,
-			    PTB, card->virtualpagetable.dma_handle,
+			    PTB, (u32)card->virtualpagetable.dma_handle,
 			    TCB, 0,
 			    TCBS, 0,
 			    TAGLIST_END);
 
 	for (nCh = 0; nCh < NUM_G; nCh++) {
 		sblive_writeptr_tag(card, nCh,
-				    MAPA, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
-				    MAPB, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
+				    MAPA, MAP_PTI_MASK |( (u32)card->silentpage.dma_handle * 2),
+				    MAPB, MAP_PTI_MASK |( (u32)card->silentpage.dma_handle * 2),
 				    TAGLIST_END);
 	}
 
diff -u linux-2.4.18-orig/drivers/sound/emu10k1/mixer.c linux-2.4.18/drivers/sound/emu10k1/mixer.c
--- linux-2.4.18-orig/drivers/sound/emu10k1/mixer.c	Mon Feb 25 11:38:06 2002
+++ linux-2.4.18/drivers/sound/emu10k1/mixer.c	Thu Feb 28 21:49:36 2002
@@ -558,7 +558,7 @@
 
 				card->tankmem.size = size;
 
-				sblive_writeptr_tag(card, 0, TCB, card->tankmem.dma_handle, TCBS, size_reg, TAGLIST_END);
+				sblive_writeptr_tag(card, 0, TCB,(u32) card->tankmem.dma_handle, TCBS, size_reg, TAGLIST_END);
 
 				emu10k1_writefn0(card, HCFG_LOCKTANKCACHE, 0);
 			}

diff -u linux-2.4.18-orig/drivers/sound/emu10k1/recmgr.c linux-2.4.18/drivers/sound/emu10k1/recmgr.c
--- linux-2.4.18-orig/drivers/sound/emu10k1/recmgr.c	Mon Feb 25 11:38:06 2002
+++ linux-2.4.18/drivers/sound/emu10k1/recmgr.c	Thu Feb 28 22:09:11 2002
@@ -132,7 +132,7 @@
 
 	DPD(2, "bus addx: %#lx\n", (unsigned long) buffer->dma_handle);
 
-	sblive_writeptr(card, buffer->addrreg, 0, buffer->dma_handle);
+	sblive_writeptr(card, buffer->addrreg, 0, (u32)buffer->dma_handle);
 
 	return;
 }

diff -u linux-2.4.18-orig/drivers/sound/emu10k1/voicemgr.c linux-2.4.18/drivers/sound/emu10k1/voicemgr.c
--- linux-2.4.18-orig/drivers/sound/emu10k1/voicemgr.c	Mon Feb 25 11:38:06 2002
+++ linux-2.4.18/drivers/sound/emu10k1/voicemgr.c	Thu Feb 28 21:50:34 2002
@@ -66,7 +66,7 @@
 		DPD(2, "Virtual Addx: %p\n", mem->addr[pagecount]);
 
 		for (i = 0; i < PAGE_SIZE / EMUPAGESIZE; i++) {
-			busaddx = mem->dma_handle[pagecount] + i * EMUPAGESIZE;
+			busaddx = (u32)(mem->dma_handle[pagecount]) + i * EMUPAGESIZE;
 
 			DPD(3, "Bus Addx: %#lx\n", busaddx);
 
@@ -102,7 +102,7 @@
 		for (i = 0; i < PAGE_SIZE / EMUPAGESIZE; i++) {
 			pageindex = mem->emupageindex + pagecount * PAGE_SIZE / EMUPAGESIZE + i;
 			((u32 *) card->virtualpagetable.addr)[pageindex] =
-				cpu_to_le32((card->silentpage.dma_handle * 2) | pageindex);
+				cpu_to_le32(((u32)card->silentpage.dma_handle * 2) | pageindex);
 		}
 	}
 
@@ -231,8 +231,8 @@
 				    Z1, 0,
 				    Z2, 0,
 				    /* Invalidate maps */
-				    MAPA, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
-				    MAPB, MAP_PTI_MASK | (card->silentpage.dma_handle * 2),
+				    MAPA, MAP_PTI_MASK | ((u32)card->silentpage.dma_handle * 2),
+				    MAPB, MAP_PTI_MASK | ((u32)card->silentpage.dma_handle * 2),
 				/* modulation envelope */
 				    CVCF, 0x0000ffff,
 				    VTFT, 0x0000ffff,

--Boundary_(ID_9HL5wDvfTHQfm7HAorKlSA)--
