Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319405AbSH2VzP>; Thu, 29 Aug 2002 17:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319385AbSH2VyI>; Thu, 29 Aug 2002 17:54:08 -0400
Received: from smtpout.mac.com ([204.179.120.89]:12230 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319402AbSH2Vxs>;
	Thu, 29 Aug 2002 17:53:48 -0400
Message-Id: <200208292158.g7TLwB72021808@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 33/41 sound/oss/esssolo1.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/esssolo1.c	Tue Aug 13 12:06:03 2002
+++ linux-2.5-cli-oss/sound/oss/esssolo1.c	Tue Aug 13 11:16:59 2002
@@ -1284,12 +1284,12 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		prog_codec(s);
@@ -2419,7 +2419,7 @@
 	outb(0, s->iobase+6);
 	outb(0, s->ddmabase+0xd); /* DMA master clear */
 	outb(3, s->sbbase+6); /* reset sequencer and FIFO */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	pci_write_config_word(s->dev, 0x60, 0); /* turn off DDMA controller address space */
 	free_irq(s->irq, s);
 	if (s->gameport.io) {

