Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965678AbWCTQCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965678AbWCTQCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966485AbWCTPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:17:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45208 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966478AbWCTPQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:49 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Duncan Sands <duncan.sands@math.u-psud.fr>,
       Duncan Sands <baldrick@free.fr>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 122/141] V4L/DVB (3394): Bttv: correct bttv_risc_packed
	buffer size
Date: Mon, 20 Mar 2006 12:08:57 -0300
Message-id: <20060320150857.PS418714000122@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Sands <duncan.sands@math.u-psud.fr>
Date: 1141009788 -0300

This patch fixes the strange crashes I was seeing after using
bttv card, caused by a buffer overflow in bttv_risc_packed.
The instruction buffer size calculation contains two errors:
(a) a non-zero padding value can push the start of the next bpl
section to just before a page border, leading to more scanline
splits and thus additional instructions.
(b) the first DMA region can be smaller than one page, so there can
be a scanline split even if bpl*lines is smaller than PAGE_SIZE.
For example, consider the case where offset is 0, bpl is 2, padding
is 4094, lines is smaller than 2048, the first DMA region has size 1
and all others have size PAGE_SIZE, assumed to equal 4096.  Then
all bpl regions cross page borders and the number of instructions
written is 2*lines+2, rather than lines+2 (the current estimate).
With this patch the number of instructions for this example is
estimated to be 2*lines+3.
Also, the BUG_ON that was supposed to catch buffer overflows contained
a thinko causing it fire only if the buffer was overrun by a factor of
16 or more, so it fixes the the BUG_ON's (using sizeof rather than "4").

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/bttv-risc.c b/drivers/media/video/bttv-risc.c
diff --git a/drivers/media/video/bttv-risc.c b/drivers/media/video/bttv-risc.c
index b40e973..a60c211 100644
--- a/drivers/media/video/bttv-risc.c
+++ b/drivers/media/video/bttv-risc.c
@@ -51,8 +51,10 @@ bttv_risc_packed(struct bttv *btv, struc
 	int rc;
 
 	/* estimate risc mem: worst case is one write per page border +
-	   one write per scan line + sync + jump (all 2 dwords) */
-	instructions  = (bpl * lines) / PAGE_SIZE + lines;
+	   one write per scan line + sync + jump (all 2 dwords).  padding
+	   can cause next bpl to start close to a page border.  First DMA
+	   region may be smaller than PAGE_SIZE */
+	instructions  = 1 + ((bpl + padding) * lines) / PAGE_SIZE + lines;
 	instructions += 2;
 	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
 		return rc;
@@ -104,7 +106,7 @@ bttv_risc_packed(struct bttv *btv, struc
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
+	BUG_ON((risc->jmp - risc->cpu + 2) * sizeof(*risc->cpu) > risc->size);
 	return 0;
 }
 
@@ -222,7 +224,7 @@ bttv_risc_planar(struct bttv *btv, struc
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
+	BUG_ON((risc->jmp - risc->cpu + 2) * sizeof(*risc->cpu) > risc->size);
 	return 0;
 }
 
@@ -307,7 +309,7 @@ bttv_risc_overlay(struct bttv *btv, stru
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
+	BUG_ON((risc->jmp - risc->cpu + 2) * sizeof(*risc->cpu) > risc->size);
 	kfree(skips);
 	return 0;
 }
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
diff --git a/drivers/media/video/cx88/cx88-core.c b/drivers/media/video/cx88/cx88-core.c
index eda7cd8..25be3a9 100644
--- a/drivers/media/video/cx88/cx88-core.c
+++ b/drivers/media/video/cx88/cx88-core.c
@@ -163,7 +163,7 @@ int cx88_risc_buffer(struct pci_dev *pci
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
+	BUG_ON((risc->jmp - risc->cpu + 2) * sizeof (*risc->cpu) > risc->size);
 	return 0;
 }
 
@@ -188,7 +188,7 @@ int cx88_risc_databuffer(struct pci_dev 
 
 	/* save pointer to jmp instruction address */
 	risc->jmp = rp;
-	BUG_ON((risc->jmp - risc->cpu + 2) / 4 > risc->size);
+	BUG_ON((risc->jmp - risc->cpu + 2) * sizeof (*risc->cpu) > risc->size);
 	return 0;
 }
 

