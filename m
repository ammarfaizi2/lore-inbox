Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319412AbSH2VzS>; Thu, 29 Aug 2002 17:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319403AbSH2VyA>; Thu, 29 Aug 2002 17:54:00 -0400
Received: from smtpout.mac.com ([204.179.120.97]:20697 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319354AbSH2Vxe>;
	Thu, 29 Aug 2002 17:53:34 -0400
Message-Id: <200208292157.g7TLvvKN026639@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 31/41 sound/oss/cmpci.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/cmpci.c	Sat Aug 10 00:04:14 2002
+++ linux-2.5-cli-oss/sound/oss/cmpci.c	Sat Aug 10 17:08:56 2002
@@ -1791,14 +1791,14 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
 			if (s->status & DO_DUAL_DAC)
 				s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		return 0;
@@ -3166,7 +3166,7 @@
 	while ((s = devs)) {
 		devs = devs->next;
 		outb(0, s->iobase + CODEC_CMI_INT_HLDCLR + 2);  /* disable ints */
-		synchronize_irq();
+		synchronize_irq(s->irq);
 		outb(0, s->iobase + CODEC_CMI_FUNCTRL0 + 2); /* disable channels */
 		free_irq(s->irq, s);
 

