Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132072AbRAPU5x>; Tue, 16 Jan 2001 15:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132807AbRAPU5n>; Tue, 16 Jan 2001 15:57:43 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:65075
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132072AbRAPU5f>; Tue, 16 Jan 2001 15:57:35 -0500
Date: Tue, 16 Jan 2001 21:57:24 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Roman.Hodek@informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make drivers/scsi/atari_scsi.c check request_irq (240p3)
Message-ID: <20010116215724.A612@jaquet.dk>
In-Reply-To: <20010114195323.B602@jaquet.dk> <3A621A27.685B985E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A621A27.685B985E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Jan 14, 2001 at 04:29:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

The following patch should correct the request_irq mistake. (The zero return
on failure seems to be required by scsi/scsi.c and is what everybody else
does.)

Other comments? :)


--- linux-ac9/drivers/scsi/atari_scsi.c.org	Sun Jan 14 19:41:56 2001
+++ linux-ac9/drivers/scsi/atari_scsi.c	Sun Jan 14 22:47:31 2001
@@ -690,19 +690,30 @@
 		/* This int is actually "pseudo-slow", i.e. it acts like a slow
 		 * interrupt after having cleared the pending flag for the DMA
 		 * interrupt. */
-		request_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr, IRQ_TYPE_SLOW,
-		            "SCSI NCR5380", scsi_tt_intr);
+		if (request_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr, IRQ_TYPE_SLOW,
+				 "SCSI NCR5380", scsi_tt_intr)) {
+			printk(KERN_ERR "atari_scsi_detect: cannot allocate irq %d, aborting",IRQ_TT_MFP_SCSI);
+			scsi_unregister(atari_scsi_host);
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
+			if (request_irq(IRQ_AUTO_2, hades_dma_emulator,
+					 IRQ_TYPE_PRIO, "Hades DMA emulator",
+					 hades_dma_emulator)) {
+				printk(KERN_ERR "atari_scsi_detect: cannot allocate irq %d, aborting (MACH_IS_HADES)",IRQ_AUTO_2);
+				free_irq(IRQ_TT_MFP_SCSI, scsi_tt_intr);
+				scsi_unregister(atari_scsi_host);
+				atari_stram_free(atari_dma_buffer);
+				atari_dma_buffer = 0;
+				return 0;
+			}
 		}
 #endif
 		if (MACH_IS_MEDUSA || MACH_IS_HADES) {
@@ -719,9 +730,8 @@
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
Regards,
        Rasmus(rasmus@jaquet.dk)

After all, it is only the mediocre who are always at their best. 
   -- Jean Giraudoux 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
