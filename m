Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291780AbSBNQkX>; Thu, 14 Feb 2002 11:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291752AbSBNQkO>; Thu, 14 Feb 2002 11:40:14 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:28176 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S291766AbSBNQkI>; Thu, 14 Feb 2002 11:40:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Feb 2002 16:17:30 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] es1370 fix
Message-ID: <20020214161730.A8112@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch fixes the es1370 driver (the virt_to_bus thing).

  Gerd

----------------------------- cut here --------------------------
--- linux-2.5.5-pre1/sound/oss/es1370.c	Thu Feb 14 15:57:34 2002
+++ linux/sound/oss/es1370.c	Thu Feb 14 16:03:43 2002
@@ -374,6 +374,10 @@
 		unsigned subdivision;
 	} dma_dac1, dma_dac2, dma_adc;
 
+	/* The following buffer is used to point the phantom write channel to. */
+	unsigned char *bugbuf_cpu;
+	dma_addr_t bugbuf_dma;
+
 	/* midi stuff */
 	struct {
 		unsigned ird, iwr, icnt;
@@ -392,13 +396,6 @@
 
 static LIST_HEAD(devs);
 
-/*
- * The following buffer is used to point the phantom write channel to,
- * so that it cannot wreak havoc. The attribute makes sure it doesn't
- * cross a page boundary and ensures dword alignment for the DMA engine
- */
-static unsigned char bugbuf[16] __attribute__ ((aligned (16)));
-
 /* --------------------------------------------------------------------- */
 
 static inline unsigned ld2(unsigned int x)
@@ -2653,8 +2650,9 @@
 	outl(s->ctrl, s->io+ES1370_REG_CONTROL);
 	outl(s->sctrl, s->io+ES1370_REG_SERIAL_CONTROL);
 	/* point phantom write channel to "bugbuf" */
+	s->bugbuf_cpu = pci_alloc_consistent(pcidev,16,&s->bugbuf_dma);
 	outl((ES1370_REG_PHANTOM_FRAMEADR >> 8) & 15, s->io+ES1370_REG_MEMPAGE);
-	outl(virt_to_bus(bugbuf), s->io+(ES1370_REG_PHANTOM_FRAMEADR & 0xff));
+	outl(s->bugbuf_dma, s->io+(ES1370_REG_PHANTOM_FRAMEADR & 0xff));
 	outl(0, s->io+(ES1370_REG_PHANTOM_FRAMECNT & 0xff));
 	pci_set_master(pcidev);  /* enable bus mastering */
 	wrcodec(s, 0x16, 3); /* no RST, PD */
@@ -2721,6 +2719,7 @@
 	unregister_sound_mixer(s->dev_mixer);
 	unregister_sound_dsp(s->dev_dac);
 	unregister_sound_midi(s->dev_midi);
+	pci_free_consistent(dev, 16, s->bugbuf_cpu, s->bugbuf_dma);
 	kfree(s);
 	pci_set_drvdata(dev, NULL);
 }
