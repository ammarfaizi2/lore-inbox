Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319365AbSH2Vxt>; Thu, 29 Aug 2002 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319398AbSH2Vx0>; Thu, 29 Aug 2002 17:53:26 -0400
Received: from smtpout.mac.com ([204.179.120.97]:28888 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319365AbSH2VwA>;
	Thu, 29 Aug 2002 17:52:00 -0400
Message-Id: <200208292156.g7TLuO72021588@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 19/41 sound/oss/es1370.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/es1370.c	Sat Aug 10 00:08:54 2002
+++ linux-2.5-cli-oss/sound/oss/es1370.c	Sat Aug 10 16:49:12 2002
@@ -1406,12 +1406,12 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac2(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac2.swptr = s->dma_dac2.hwptr = s->dma_dac2.count = s->dma_dac2.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		return 0;
@@ -1798,7 +1798,7 @@
 	down(&s->open_sem);
 	if (file->f_mode & FMODE_WRITE) {
 		stop_dac2(s);
-		synchronize_irq();
+		synchronize_irq(s->irq);
 		dealloc_dmabuf(s, &s->dma_dac2);
 	}
 	if (file->f_mode & FMODE_READ) {
@@ -1976,7 +1976,7 @@
 		
         case SNDCTL_DSP_RESET:
 		stop_dac1(s);
-		synchronize_irq();
+		synchronize_irq(s->irq);
 		s->dma_dac1.swptr = s->dma_dac1.hwptr = s->dma_dac1.count = s->dma_dac1.total_bytes = 0;
 		return 0;
 
@@ -2704,7 +2704,7 @@
 	list_del(&s->devs);
 	outl(CTRL_SERR_DIS | (1 << CTRL_SH_WTSRSEL), s->io+ES1370_REG_CONTROL); /* switch everything off */
 	outl(0, s->io+ES1370_REG_SERIAL_CONTROL); /* clear serial interrupts */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
 	if (s->gameport.io) {
 		gameport_unregister_port(&s->gameport);

