Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbRBUQsQ>; Wed, 21 Feb 2001 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbRBUQsF>; Wed, 21 Feb 2001 11:48:05 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:24416 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129184AbRBUQrx>; Wed, 21 Feb 2001 11:47:53 -0500
Date: Wed, 21 Feb 2001 10:47:51 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
cc: Zeljko Stevanovic <zsteva@kernel.net>,
        root <Andrew.Price@pricea.madasafish.com>,
        Martin Braun <braun@itwm.fhg.de>, Martin Greco <msgreco@sinectis.com>,
        Jon Noble <jon.noble@euskalnet.net>,
        Gerriet Backer <backer@informatik.uni-hamburg.de>,
        kgroombr@users.sourceforge.net, Rick Kennell <kennell@ecn.purdue.edu>
Subject: PATCH: Via audio rate lock, for testing
Message-ID: <Pine.LNX.3.96.1010221104452.13788P-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you guys test this patch, and let me know if it fixes Via audio
problems on your kernel?

It should apply against 2.4.1 or 2.4.1-acXX kernels.  Note that it
should be applied with "patch -p0" while in the linux kernel source
directory, not applied with "patch -p1".

Regards,

	Jeff




Index: drivers/sound/via82cxxx_audio.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/sound/via82cxxx_audio.c,v
retrieving revision 1.1.1.13.22.1
diff -u -r1.1.1.13.22.1 via82cxxx_audio.c
--- drivers/sound/via82cxxx_audio.c	2001/02/18 23:58:28	1.1.1.13.22.1
+++ drivers/sound/via82cxxx_audio.c	2001/02/21 16:36:23
@@ -281,6 +281,8 @@
 
 	int dev_dsp;		/* /dev/dsp index from register_sound_dsp() */
 
+	int locked_rate : 1;
+
 	struct semaphore syscall_sem;
 	struct semaphore open_sem;
 
@@ -503,10 +505,16 @@
 static int via_set_rate (struct ac97_codec *ac97,
 			 struct via_channel *chan, unsigned rate)
 {
+	struct via_info *card = ac97->private_data;
 	int rate_reg;
 
 	DPRINTK ("ENTER, rate = %d\n", rate);
 
+	if (card->locked_rate) {
+		chan->rate = 48000;
+		goto out;
+	}
+
 	if (rate > 48000)		rate = 48000;
 	if (rate < 4000) 		rate = 4000;
 
@@ -530,6 +538,13 @@
 	 */
 	chan->rate = via_ac97_read_reg (ac97, rate_reg);
 
+	if (chan->rate == 0) {
+		card->locked_rate = 1;
+		chan->rate = 48000;
+		printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
+	}
+
+out:
 	DPRINTK ("EXIT, returning rate %d Hz\n", chan->rate);
 	return chan->rate;
 }
@@ -1438,7 +1453,7 @@
  *	via_ac97_reset - Reset Via AC97 hardware
  *	@card: Private info for specified board
  *
- *	Reset Via AC97 hardware.
+ *	Reset Via AC97 codec, controller, and hardware.
  */
 
 static int __init via_ac97_reset (struct via_info *card)
@@ -1512,8 +1527,8 @@
 	 */
 
 	/* enable variable rate, variable rate MIC ADC */
-	tmp16 = via_ac97_read_reg (&card->ac97, 0x2A);
-	via_ac97_write_reg (&card->ac97, 0x2A, tmp16 | (1<<0));
+	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+	via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
 
 	pci_read_config_byte (pdev, VIA_ACLINK_CTRL, &tmp8);
 	if ((tmp8 & (VIA_CR41_AC97_ENABLE | VIA_CR41_AC97_RESET)) == 0) {
@@ -1588,8 +1603,22 @@
 	}
 
 	/* enable variable rate, variable rate MIC ADC */
-	tmp16 = via_ac97_read_reg (&card->ac97, 0x2A);
-	via_ac97_write_reg (&card->ac97, 0x2A, tmp16 | (1<<0));
+	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+	via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+
+	/*
+	 * If we cannot enable VRA, we have a locked-rate codec.
+	 * We try again to enable VRA before assuming so, however.
+	 */
+	tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+	if ((tmp16 & 1) == 0) {
+		via_ac97_write_reg (&card->ac97, AC97_EXTENDED_STATUS, tmp16 | 1);
+		tmp16 = via_ac97_read_reg (&card->ac97, AC97_EXTENDED_STATUS);
+		if ((tmp16 & 1) == 0) {
+			card->locked_rate = 1;
+			printk (KERN_WARNING PFX "Codec rate locked at 48Khz\n");
+		}
+	}
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;

