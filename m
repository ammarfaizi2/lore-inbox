Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133025AbRANSxs>; Sun, 14 Jan 2001 13:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133020AbRANSxi>; Sun, 14 Jan 2001 13:53:38 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:51064
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S133000AbRANSxa>; Sun, 14 Jan 2001 13:53:30 -0500
Date: Sun, 14 Jan 2001 19:53:23 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Roman.Hodek@informatik.uni-erlangen.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make drivers/scsi/atari_scsi.c check request_irq (240p3)
Message-ID: <20010114195323.B602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/atari_scsi.c check request_irq's
return code. It applies cleanly against 240p3 and ac9.

Comments?


--- linux-ac9/drivers/scsi/atari_scsi.c~	Tue Nov 28 02:57:34 2000
+++ linux-ac9/drivers/scsi/atari_scsi.c	Sun Jan 14 19:28:00 2001
@@ -690,19 +690,27 @@
 		/* This int is actually "pseudo-slow", i.e. it acts like a slow
 		 * interrupt after having cleared the pending flag for the DMA
 		 * interrupt. */
-		request_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr, IRQ_TYPE_SLOW,
-		            "SCSI NCR5380", scsi_tt_intr);
+		if (!request_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr, IRQ_TYPE_SLOW,
+				 "SCSI NCR5380", scsi_tt_intr)) {
+			printk(KERN_ERR "atari_scsi_detect: cannot allocate irq %d, aborting",IRQ_TT_MFP_SCSI);
+			atari_stram_free(atari_dma_buffer);
+			atari_dma_buffer = 0;
+			return 0;
+		}
 		tt_mfp.active_edge |= 0x80;		/* SCSI int on L->H */
 #ifdef REAL_DMA
 		tt_scsi_dma.dma_ctrl = 0;
 		atari_dma_residual = 0;
-#endif /* REAL_DMA */
-#ifdef REAL_DMA
 #ifdef CONFIG_TT_DMA_EMUL
 		if (MACH_IS_HADES) {
-			request_irq(IRQ_AUTO_2, hades_dma_emulator,
-				    IRQ_TYPE_PRIO, "Hades DMA emulator",
-				    hades_dma_emulator);
+			if (!request_irq(IRQ_AUTO_2, hades_dma_emulator,
+					 IRQ_TYPE_PRIO, "Hades DMA emulator",
+					 hades_dma_emulator)) {
+				printk(KERN_ERR "atari_scsi_detect: cannot allocate irq %d, aborting (MACH_IS_HADES)",IRQ_AUTO_2);
+				atari_stram_free(atari_dma_buffer);
+				atari_dma_buffer = 0;
+				return 0;
+			}
 		}
 #endif
 		if (MACH_IS_MEDUSA || MACH_IS_HADES) {
@@ -719,9 +727,8 @@
 			 * the rest data bug is fixed, this can be lowered to 1.
 			 */
 			atari_read_overruns = 4;
-		}
-#endif
-		
+		}		
+#endif /*REAL_DMA*/
 	}
 	else { /* ! IS_A_TT */
 		

-- 
        Rasmus(rasmus@jaquet.dk)

Are they taking DDT?
                -- Vice President Dan Quayle asking doctors at a Manhattan
                   AIDS clinic about their treatments of choice, 4/30/92
                   (reported in Esquire, 8/92, and NY Post early May 92)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
