Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSGYNeI>; Thu, 25 Jul 2002 09:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSGYNdP>; Thu, 25 Jul 2002 09:33:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:4605 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314138AbSGYNbk>; Thu, 25 Jul 2002 09:31:40 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251448.g6PEmp45010468@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 fix ALSA PCI compile problems
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:48:51 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/ali5451/ali5451.c linux-2.5.28-ac1/sound/pci/ali5451/ali5451.c
--- linux-2.5.28/sound/pci/ali5451/ali5451.c	Thu Jul 25 10:51:00 2002
+++ linux-2.5.28-ac1/sound/pci/ali5451/ali5451.c	Thu Jul 25 12:57:15 2002
@@ -1968,7 +1968,7 @@
 static int snd_ali_free(ali_t * codec)
 {
 	snd_ali_disable_address_interrupt(codec);
-	synchronize_irq();
+	synchronize_irq(codec->irq);
 	if (codec->irq >=0)
 		free_irq(codec->irq, (void *)codec);
 	if (codec->res_port) {
@@ -2116,7 +2116,7 @@
 		return -EBUSY;
 	}
 
-	synchronize_irq();
+	synchronize_irq(pci->irq);
 
 	codec->synth.chmap = 0;
 	codec->synth.chcnt = 0;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/cmipci.c linux-2.5.28-ac1/sound/pci/cmipci.c
--- linux-2.5.28/sound/pci/cmipci.c	Thu Jul 25 10:51:00 2002
+++ linux-2.5.28-ac1/sound/pci/cmipci.c	Thu Jul 25 12:25:20 2002
@@ -2479,7 +2479,7 @@
 		/* reset mixer */
 		snd_cmipci_mixer_write(cm, 0, 0);
 
-		synchronize_irq();
+		synchronize_irq(cm->irq);
 
 		free_irq(cm->irq, (void *)cm);
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/cs4281.c linux-2.5.28-ac1/sound/pci/cs4281.c
--- linux-2.5.28/sound/pci/cs4281.c	Thu Jul 25 10:51:04 2002
+++ linux-2.5.28-ac1/sound/pci/cs4281.c	Thu Jul 25 13:08:52 2002
@@ -1300,7 +1300,8 @@
 	}
 #endif
 	snd_cs4281_proc_done(chip);
-	synchronize_irq();
+	if(chip->irq >= 0)
+		synchronize_irq(chip->irq);
 
 	/* Mask interrupts */
 	snd_cs4281_pokeBA0(chip, BA0_HIMR, 0x7fffffff);
@@ -1603,7 +1604,7 @@
 					BA0_HISR_DMA(1) |
 					BA0_HISR_DMA(2) |
 					BA0_HISR_DMA(3)));
-	synchronize_irq();
+	synchronize_irq(chip->irq);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_cs4281_free(chip);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/maestro3.c linux-2.5.28-ac1/sound/pci/maestro3.c
--- linux-2.5.28/sound/pci/maestro3.c	Thu Jul 25 10:51:01 2002
+++ linux-2.5.28-ac1/sound/pci/maestro3.c	Thu Jul 25 13:10:03 2002
@@ -2310,7 +2310,8 @@
 		vfree(chip->suspend_mem);
 #endif
 
-	synchronize_irq();
+	if(chip->irq >= 0)
+		synchronize_irq(chip->irq);
 
 	if (chip->iobase_res) {
 		release_resource(chip->iobase_res);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/nm256/nm256.c linux-2.5.28-ac1/sound/pci/nm256/nm256.c
--- linux-2.5.28/sound/pci/nm256/nm256.c	Thu Jul 25 10:51:01 2002
+++ linux-2.5.28-ac1/sound/pci/nm256/nm256.c	Thu Jul 25 12:59:22 2002
@@ -1346,7 +1346,8 @@
 	if (chip->streams[SNDRV_PCM_STREAM_CAPTURE].running)
 		snd_nm256_capture_stop(chip);
 
-	synchronize_irq();
+	if(chip->irq >= 0)
+		synchronize_irq(chip->irq);
 
 	if (chip->cport)
 		iounmap((void *) chip->cport);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/via686.c linux-2.5.28-ac1/sound/pci/via686.c
--- linux-2.5.28/sound/pci/via686.c	Thu Jul 25 10:51:00 2002
+++ linux-2.5.28-ac1/sound/pci/via686.c	Thu Jul 25 13:10:15 2002
@@ -993,7 +993,8 @@
 	snd_via686a_channel_reset(chip, &chip->playback_fm);
 	/* --- */
       __end_hw:
-	synchronize_irq();
+	if(chip->irq >= 0)
+		synchronize_irq(chip->irq);
 	if (chip->tables)
 		snd_free_pci_pages(chip->pci, 3 * sizeof(unsigned int) * VIA_MAX_FRAGS * 2, chip->tables, chip->tables_addr);
 	if (chip->res_port) {
@@ -1055,7 +1056,7 @@
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
 		chip->ac97_clock = ac97_clock;
 	pci_read_config_byte(pci, PCI_REVISION_ID, &chip->revision);
-	synchronize_irq();
+	synchronize_irq(pci->irq);
 
 	/* initialize offsets */
 	chip->playback.reg_offset = VIA_REG_PLAYBACK_STATUS;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/sound/pci/via8233.c linux-2.5.28-ac1/sound/pci/via8233.c
--- linux-2.5.28/sound/pci/via8233.c	Thu Jul 25 10:51:00 2002
+++ linux-2.5.28-ac1/sound/pci/via8233.c	Thu Jul 25 13:10:26 2002
@@ -759,7 +759,8 @@
 	snd_via8233_channel_reset(chip, &chip->capture);
 	/* --- */
       __end_hw:
-	synchronize_irq();
+	if (chip->irq)
+		synchronize_irq(chip->irq);
 	if (chip->tables)
 		snd_free_pci_pages(chip->pci,
 				   VIA_NUM_OF_DMA_CHANNELS * sizeof(unsigned int) * VIA_MAX_FRAGS * 2,
@@ -817,7 +818,7 @@
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
 		chip->ac97_clock = ac97_clock;
 	pci_read_config_byte(pci, PCI_REVISION_ID, &chip->revision);
-	synchronize_irq();
+	synchronize_irq(chip->irq);
 
 	/* initialize offsets */
 #if 0
