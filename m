Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319048AbSHSVyo>; Mon, 19 Aug 2002 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319050AbSHSVyo>; Mon, 19 Aug 2002 17:54:44 -0400
Received: from calhau.terra.com.br ([200.176.3.20]:57256 "EHLO
	calhau.terra.com.br") by vger.kernel.org with ESMTP
	id <S319048AbSHSVyh>; Mon, 19 Aug 2002 17:54:37 -0400
Subject: [PATCH] OSS - synchronize_irq missing argument 2.5.31...
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Aug 2002 19:01:24 -0300
Message-Id: <1029794484.3319.113.camel@walker>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All calls to synchronize_irq are missing a argument.. 
this patch fix this.... 


diff -uNr /usr/src/linux-2.5.31/sound/oss/cmpci.c sound/oss/cmpci.c
--- /usr/src/linux-2.5.31/sound/oss/cmpci.c	2002-08-10 22:41:16.000000000 -0300
+++ sound/oss/cmpci.c	2002-08-19 14:53:52.000000000 -0300
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
 
diff -uNr /usr/src/linux-2.5.31/sound/oss/es1370.c sound/oss/es1370.c
--- /usr/src/linux-2.5.31/sound/oss/es1370.c	2002-08-10 22:41:28.000000000 -0300
+++ sound/oss/es1370.c	2002-08-19 15:07:41.000000000 -0300
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
diff -uNr /usr/src/linux-2.5.31/sound/oss/es1371.c sound/oss/es1371.c
--- /usr/src/linux-2.5.31/sound/oss/es1371.c	2002-08-10 22:41:23.000000000 -0300
+++ sound/oss/es1371.c	2002-08-19 15:08:04.000000000 -0300
@@ -1597,12 +1597,12 @@
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
@@ -2162,7 +2162,7 @@
 		
         case SNDCTL_DSP_RESET:
 		stop_dac1(s);
-		synchronize_irq();
+		synchronize_irq(s->irq);
 		s->dma_dac1.swptr = s->dma_dac1.hwptr = s->dma_dac1.count = s->dma_dac1.total_bytes = 0;
 		return 0;
 
@@ -3006,7 +3006,7 @@
 #endif /* ES1371_DEBUG */
 	outl(0, s->io+ES1371_REG_CONTROL); /* switch everything off */
 	outl(0, s->io+ES1371_REG_SERIAL_CONTROL); /* clear serial interrupts */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
 	if (s->gameport.io) {
 		gameport_unregister_port(&s->gameport);
diff -uNr /usr/src/linux-2.5.31/sound/oss/esssolo1.c sound/oss/esssolo1.c
--- /usr/src/linux-2.5.31/sound/oss/esssolo1.c	2002-08-10 22:41:21.000000000 -0300
+++ sound/oss/esssolo1.c	2002-08-19 15:08:48.000000000 -0300
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
diff -uNr /usr/src/linux-2.5.31/sound/oss/ite8172.c sound/oss/ite8172.c
--- /usr/src/linux-2.5.31/sound/oss/ite8172.c	2002-08-10 22:41:23.000000000 -0300
+++ sound/oss/ite8172.c	2002-08-19 15:09:28.000000000 -0300
@@ -1196,13 +1196,13 @@
     case SNDCTL_DSP_RESET:
 	if (file->f_mode & FMODE_WRITE) {
 	    stop_dac(s);
-	    synchronize_irq();
+	    synchronize_irq(s->irq);
 	    s->dma_dac.count = s->dma_dac.total_bytes = 0;
 	    s->dma_dac.nextIn = s->dma_dac.nextOut = s->dma_dac.rawbuf;
 	}
 	if (file->f_mode & FMODE_READ) {
 	    stop_adc(s);
-	    synchronize_irq();
+	    synchronize_irq(s->irq);
 	    s->dma_adc.count = s->dma_adc.total_bytes = 0;
 	    s->dma_adc.nextIn = s->dma_adc.nextOut = s->dma_adc.rawbuf;
 	}
@@ -1911,7 +1911,7 @@
     if (s->ps)
 	remove_proc_entry(IT8172_MODULE_NAME, NULL);
 #endif /* IT8172_DEBUG */
-    synchronize_irq();
+    synchronize_irq(s->irq);
     free_irq(s->irq, s);
     release_region(s->io, pci_resource_len(dev,0));
     unregister_sound_dsp(s->dev_audio);
diff -uNr /usr/src/linux-2.5.31/sound/oss/maestro.c sound/oss/maestro.c
--- /usr/src/linux-2.5.31/sound/oss/maestro.c	2002-08-10 22:41:25.000000000 -0300
+++ sound/oss/maestro.c	2002-08-19 15:10:51.000000000 -0300
@@ -2552,12 +2552,12 @@
         case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->card->irq);
 			s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->card->irq);
 			s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
 		}
 		return 0;
diff -uNr /usr/src/linux-2.5.31/sound/oss/maestro3.c sound/oss/maestro3.c
--- /usr/src/linux-2.5.31/sound/oss/maestro3.c	2002-08-10 22:41:53.000000000 -0300
+++ sound/oss/maestro3.c	2002-08-19 15:11:38.000000000 -0300
@@ -1605,12 +1605,12 @@
         spin_lock_irqsave(&s->lock, flags);
         if (file->f_mode & FMODE_WRITE) {
             stop_dac(s);
-            synchronize_irq();
+            synchronize_irq(s->card->irq);
             s->dma_dac.swptr = s->dma_dac.hwptr = s->dma_dac.count = s->dma_dac.total_bytes = 0;
         }
         if (file->f_mode & FMODE_READ) {
             stop_adc(s);
-            synchronize_irq();
+            synchronize_irq(s->card->irq);
             s->dma_adc.swptr = s->dma_adc.hwptr = s->dma_adc.count = s->dma_adc.total_bytes = 0;
         }
         spin_unlock_irqrestore(&s->lock, flags);
diff -uNr /usr/src/linux-2.5.31/sound/oss/nec_vrc5477.c sound/oss/nec_vrc5477.c
--- /usr/src/linux-2.5.31/sound/oss/nec_vrc5477.c	2002-08-10 22:41:46.000000000 -0300
+++ sound/oss/nec_vrc5477.c	2002-08-19 15:12:22.000000000 -0300
@@ -1331,13 +1331,13 @@
 	case SNDCTL_DSP_RESET:
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_dac.count = 0;
 			s->dma_dac.nextIn = s->dma_dac.nextOut = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(s);
-			synchronize_irq();
+			synchronize_irq(s->irq);
 			s->dma_adc.count = 0;
 			s->dma_adc.nextIn = s->dma_adc.nextOut = 0;
 		}
@@ -1993,7 +1993,7 @@
 	if (s->ps)
 		remove_proc_entry(VRC5477_AC97_MODULE_NAME, NULL);
 #endif /* CONFIG_LL_DEBUG */
-	synchronize_irq();
+	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
 	release_region(s->io, pci_resource_len(dev,0));
 	unregister_sound_dsp(s->dev_audio);
diff -uNr /usr/src/linux-2.5.31/sound/oss/sonicvibes.c sound/oss/sonicvibes.c
--- /usr/src/linux-2.5.31/sound/oss/sonicvibes.c	2002-08-10 22:41:28.000000000 -0300
+++ sound/oss/sonicvibes.c	2002-08-19 15:13:06.000000000 -0300
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
diff -uNr /usr/src/linux-2.5.31/sound/oss/trident.c sound/oss/trident.c
--- /usr/src/linux-2.5.31/sound/oss/trident.c	2002-08-10 22:41:46.000000000 -0300
+++ sound/oss/trident.c	2002-08-19 15:14:43.000000000 -0300
@@ -2150,14 +2150,14 @@
 		/* FIXME: spin_lock ? */
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(state);
-			synchronize_irq();
+			synchronize_irq(s->card->irq);
 			dmabuf->ready = 0;
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(state);
-			synchronize_irq();
+			synchronize_irq(s->card->irq);
 			dmabuf->ready = 0;
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;
At.
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net

