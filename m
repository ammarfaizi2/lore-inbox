Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTFOS7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFOS7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:59:24 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:34653 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S262645AbTFOS7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:59:22 -0400
Date: Sun, 15 Jun 2003 21:10:00 +0200
Message-Id: <200306151910.h5FJA0DE008513@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       macro@ds2.pg.gda.pl, Ralf Baechle <ralf@linux-mips.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] NCR53C9x unused SCp.have_data_in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NCR53C9x: Remove unused initialization of SCp.have_data_in (from Maciej W.
Rozycki). This affects the following drivers:
  - DECstation SCSI
  - Amiga Oktagon SCSI

--- linux-2.5.x/drivers/scsi/NCR53C9x.c	2002-09-12 03:20:28.000000000 +0000
+++ linux-m68k-2.5.x/drivers/scsi/NCR53C9x.c	2002-10-22 23:02:09.000000000 +0000
@@ -917,7 +917,7 @@ static void esp_get_dmabufs(struct NCR_E
 		if (esp->dma_mmu_get_scsi_one)
 			esp->dma_mmu_get_scsi_one(esp, sp);
 		else
-			sp->SCp.have_data_in = (int) sp->SCp.ptr =
+			sp->SCp.ptr =
 				(char *) virt_to_phys(sp->request_buffer);
 	} else {
 		sp->SCp.buffer = (struct scatterlist *) sp->buffer;
--- linux-2.5.x/drivers/scsi/dec_esp.c	2002-10-02 17:22:42.000000000 +0000
+++ linux-m68k-2.5.x/drivers/scsi/dec_esp.c	2002-10-22 23:49:24.000000000 +0000
@@ -323,7 +323,7 @@ static int dma_bytes_sent(struct NCR_ESP
 static void dma_drain(struct NCR_ESP *esp)
 {
 	unsigned long nw = *scsi_scr;
-	unsigned short *p = KSEG1ADDR((unsigned short *) ((*scsi_dma_ptr) >> 3));
+	unsigned short *p = (unsigned short *)KSEG1ADDR((*scsi_dma_ptr) >> 3);
 
     /*
 	 * Is there something in the dma buffers left?
@@ -437,8 +437,7 @@ static void dma_setup(struct NCR_ESP *es
  */
 static void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	sp->SCp.have_data_in = PHYSADDR(sp->SCp.buffer);
-	sp->SCp.ptr = (char *) ((unsigned long) sp->SCp.have_data_in);
+	sp->SCp.ptr = (char *)PHYSADDR(sp->SCp.buffer);
 }
 
 static void dma_mmu_get_scsi_sgl(struct NCR_ESP *esp, Scsi_Cmnd * sp)
@@ -484,8 +483,8 @@ static void pmaz_dma_init_write(struct N
 {
 	volatile int *dmareg = (volatile int *) ( esp->slot + DEC_SCSI_DMAREG );
 
-	memcpy((void *) (esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
-			KSEG0ADDR((void *) vaddress), length);
+	memcpy((void *)(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE),
+	       (void *)KSEG0ADDR(vaddress), length);
 
 	*dmareg = TC_ESP_DMAR_WRITE |
 		TC_ESP_DMA_ADDR(esp->slot + DEC_SCSI_SRAM + ESP_TGT_DMA_SIZE);
@@ -516,7 +515,5 @@ static void pmaz_dma_setup(struct NCR_ES
 
 static void pmaz_dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd * sp)
 {
-	sp->SCp.have_data_in = (int) sp->SCp.ptr =
-	    (char *) KSEG0ADDR((sp->request_buffer));
+	sp->SCp.ptr = (char *)KSEG0ADDR((sp->request_buffer));
 }
-
--- linux-2.5.x/drivers/scsi/oktagon_esp.c	Thu Jun 27 02:59:32 2002
+++ linux-m68k-2.5.x/drivers/scsi/oktagon_esp.c	Mon Nov 25 12:11:43 2002
@@ -548,7 +548,7 @@ static void dma_invalidate(struct NCR_ES
 
 void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd *sp)
 {
-        sp->SCp.have_data_in = (int) sp->SCp.ptr =
+        sp->SCp.ptr =
                 sp->request_buffer;
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
