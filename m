Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319413AbSH2V4W>; Thu, 29 Aug 2002 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319354AbSH2Vzr>; Thu, 29 Aug 2002 17:55:47 -0400
Received: from smtpout.mac.com ([204.179.120.85]:32224 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319400AbSH2Vxz>;
	Thu, 29 Aug 2002 17:53:55 -0400
Message-Id: <200208292158.g7TLwJKN026691@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 34/41 sound/oss/sonicvibes.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/sonicvibes.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/sonicvibes.c	Sat Aug 10 17:05:19 2002
@@ -1589,12 +1589,12 @@
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
 		return 0;
@@ -2683,7 +2683,7 @@
 		return;
 	list_del(&s->devs);
 	outb(~0, s->ioenh + SV_CODEC_INTMASK);  /* disable ints */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	inb(s->ioenh + SV_CODEC_STATUS); /* ack interrupts */
 	wrindir(s, SV_CIENABLE, 0);     /* disable DMAA and DMAC */
 	/*outb(0, s->iodmaa + SV_DMA_RESET);*/

