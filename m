Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWCMW0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWCMW0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWCMW0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:26:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44815 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964786AbWCMW0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:26:49 -0500
Date: Mon, 13 Mar 2006 23:26:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/: fix some memory leaks
Message-ID: <20060313222647.GP13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two memory leaks spotted by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/drivers/serial-u16550.c |    1 +
 sound/isa/es18xx.c            |    1 +
 sound/pci/cs46xx/dsp_spos.c   |   10 +++++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc6-mm1-full/sound/drivers/serial-u16550.c.old	2006-03-13 22:52:25.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/sound/drivers/serial-u16550.c	2006-03-13 22:52:59.000000000 +0100
@@ -789,6 +789,7 @@ static int __init snd_uart16550_create(s
 
 	if ((err = snd_uart16550_detect(uart)) <= 0) {
 		printk(KERN_ERR "no UART detected at 0x%lx\n", iobase);
+		kfree(uart);
 		return -ENODEV;
 	}
 
--- linux-2.6.16-rc6-mm1-full/sound/isa/es18xx.c.old	2006-03-13 22:53:43.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/sound/isa/es18xx.c	2006-03-13 22:54:03.000000000 +0100
@@ -2083,6 +2083,7 @@ static int __devinit snd_audiodrive_pnp(
 	err = pnp_activate_dev(acard->devc);
 	if (err < 0) {
 		snd_printk(KERN_ERR PFX "PnP control configure failure (out of resources?)\n");
+		kfree(cfg);
 		return -EAGAIN;
 	}
 	snd_printdd("pnp: port=0x%lx\n", pnp_port_start(acard->devc, 0));
--- linux-2.6.16-rc6-mm1-full/sound/pci/cs46xx/dsp_spos.c.old	2006-03-13 22:55:23.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/sound/pci/cs46xx/dsp_spos.c	2006-03-13 22:56:30.000000000 +0100
@@ -237,7 +237,7 @@ struct dsp_spos_instance *cs46xx_dsp_spo
 
 	if (ins->symbol_table.symbols == NULL) {
 		cs46xx_dsp_spos_destroy(chip);
-		return NULL;
+		goto error;
 	}
 
 	ins->code.offset = 0;
@@ -246,7 +246,7 @@ struct dsp_spos_instance *cs46xx_dsp_spo
 
 	if (ins->code.data == NULL) {
 		cs46xx_dsp_spos_destroy(chip);
-		return NULL;
+		goto error;
 	}
 
 	ins->nscb = 0;
@@ -257,7 +257,7 @@ struct dsp_spos_instance *cs46xx_dsp_spo
 
 	if (ins->modules == NULL) {
 		cs46xx_dsp_spos_destroy(chip);
-		return NULL;
+		goto error;
 	}
 
 	/* default SPDIF input sample rate
@@ -280,6 +280,10 @@ struct dsp_spos_instance *cs46xx_dsp_spo
 	 /* left and right validity bits */ (1 << 13) | (1 << 12);
 
 	return ins;
+
+error:
+	kfree(ins);
+	return NULL;
 }
 
 void  cs46xx_dsp_spos_destroy (struct snd_cs46xx * chip)

