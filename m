Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUKOD1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUKOD1X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKOD0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:26:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18695 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261515AbUKODXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:23:32 -0500
Date: Mon, 15 Nov 2004 04:12:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] OSS via82cABC_audio.c: remove unused CONFIG_SOUND_VIA82CABC_PROCFS code
Message-ID: <20041115031221.GI2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Subject changed due to linux-kernel filters.
  Note the two ABC...                          ]


> >How else is this information available?
> 
> lspci.  it's just a verbose dump of PCI config registers.

Sounds reasonable.

Below is a patch to remove the CONFIG_SOUND_VIA82CXXX_PROCFS code.


diffstat output:
 sound/oss/via82cxxx_audio.c |  218 ------------------------------------
 1 files changed, 1 insertion(+), 217 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/sound/oss/via82cxxx_audio.c.old	2004-11-14 03:09:05.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/sound/oss/via82cxxx_audio.c	2004-11-15 03:45:28.000000000 +0100
@@ -62,11 +62,6 @@
         }
 #endif
 
-#if defined(CONFIG_PROC_FS) && \
-    defined(CONFIG_SOUND_VIA82CXXX_PROCFS)
-#define VIA_PROC_FS 1
-#endif
-
 #define VIA_SUPPORT_MMAP 1 /* buggy, for now... */
 
 #define MAX_CARDS	1
@@ -366,18 +361,6 @@
 static void via_chan_pcm_fmt (struct via_channel *chan, int reset);
 static void via_chan_buffer_free (struct via_info *card, struct via_channel *chan);
 
-#ifdef VIA_PROC_FS
-static int via_init_proc (void);
-static void via_cleanup_proc (void);
-static int via_card_init_proc (struct via_info *card);
-static void via_card_cleanup_proc (struct via_info *card);
-#else
-static inline int via_init_proc (void) { return 0; }
-static inline void via_cleanup_proc (void) {}
-static inline int via_card_init_proc (struct via_info *card) { return 0; }
-static inline void via_card_cleanup_proc (struct via_info *card) {}
-#endif
-
 
 /****************************************************************
  *
@@ -3484,21 +3467,12 @@
 	}
 
 	/*
-	 * per-card /proc info
-	 */
-	rc = via_card_init_proc (card);
-	if (rc) {
-		printk (KERN_ERR PFX "card-specific /proc init failed, aborting\n");
-		goto err_out_have_dsp;
-	}
-
-	/*
 	 * init and turn on interrupts, as the last thing we do
 	 */
 	rc = via_interrupt_init (card);
 	if (rc) {
 		printk (KERN_ERR PFX "interrupt init failed, aborting\n");
-		goto err_out_have_proc;
+		goto err_out_have_dsp;
 	}
 
 	printk (KERN_INFO PFX "board #%d at 0x%04lX, IRQ %d\n",
@@ -3538,9 +3512,6 @@
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 
-err_out_have_proc:
-	via_card_cleanup_proc (card);
-
 err_out_have_dsp:
 	via_dsp_cleanup (card);
 
@@ -3582,7 +3553,6 @@
 #endif
 
 	free_irq (card->pdev->irq, card);
-	via_card_cleanup_proc (card);
 	via_dsp_cleanup (card);
 	via_ac97_cleanup (card);
 
@@ -3615,15 +3585,8 @@
 
 	DPRINTK ("ENTER\n");
 
-	rc = via_init_proc ();
-	if (rc) {
-		DPRINTK ("EXIT, returning %d\n", rc);
-		return rc;
-	}
-
 	rc = pci_register_driver (&via_driver);
 	if (rc) {
-		via_cleanup_proc ();
 		DPRINTK ("EXIT, returning %d\n", rc);
 		return rc;
 	}
@@ -3638,7 +3601,6 @@
 	DPRINTK ("ENTER\n");
 
 	pci_unregister_driver (&via_driver);
-	via_cleanup_proc ();
 
 	DPRINTK ("EXIT\n");
 }
@@ -3651,181 +3613,3 @@
 MODULE_DESCRIPTION("DSP audio and mixer driver for Via 82Cxxx audio devices");
 MODULE_LICENSE("GPL");
 
-
-#ifdef VIA_PROC_FS
-
-/****************************************************************
- *
- * /proc/driver/via/info
- *
- *
- */
-
-static int via_info_read_proc (char *page, char **start, off_t off,
-			       int count, int *eof, void *data)
-{
-#define YN(val,bit) (((val) & (bit)) ? "yes" : "no")
-#define ED(val,bit) (((val) & (bit)) ? "enable" : "disable")
-
-	int len = 0;
-	u8 r40, r41, r42, r44;
-	struct via_info *card = data;
-
-	DPRINTK ("ENTER\n");
-
-	assert (card != NULL);
-
-	len += sprintf (page+len, VIA_CARD_NAME "\n\n");
-
-	pci_read_config_byte (card->pdev, 0x40, &r40);
-	pci_read_config_byte (card->pdev, 0x41, &r41);
-	pci_read_config_byte (card->pdev, 0x42, &r42);
-	pci_read_config_byte (card->pdev, 0x44, &r44);
-
-	len += sprintf (page+len,
-		"Via 82Cxxx PCI registers:\n"
-		"\n"
-		"40  Codec Ready: %s\n"
-		"    Codec Low-power: %s\n"
-		"    Secondary Codec Ready: %s\n"
-		"\n"
-		"41  Interface Enable: %s\n"
-		"    De-Assert Reset: %s\n"
-		"    Force SYNC high: %s\n"
-		"    Force SDO high: %s\n"
-		"    Variable Sample Rate On-Demand Mode: %s\n"
-		"    SGD Read Channel PCM Data Out: %s\n"
-		"    FM Channel PCM Data Out: %s\n"
-		"    SB PCM Data Out: %s\n"
-		"\n"
-		"42  Game port enabled: %s\n"
-		"    SoundBlaster enabled: %s\n"
-		"    FM enabled: %s\n"
-		"    MIDI enabled: %s\n"
-		"\n"
-		"44  AC-Link Interface Access: %s\n"
-		"    Secondary Codec Support: %s\n"
-
-		"\n",
-
-		YN (r40, VIA_CR40_AC97_READY),
-		YN (r40, VIA_CR40_AC97_LOW_POWER),
-		YN (r40, VIA_CR40_SECONDARY_READY),
-
-		ED (r41, VIA_CR41_AC97_ENABLE),
-		YN (r41, (1 << 6)),
-		YN (r41, (1 << 5)),
-		YN (r41, (1 << 4)),
-		ED (r41, (1 << 3)),
-		ED (r41, (1 << 2)),
-		ED (r41, (1 << 1)),
-		ED (r41, (1 << 0)),
-
-		YN (r42, VIA_CR42_GAME_ENABLE),
-		YN (r42, VIA_CR42_SB_ENABLE),
-		YN (r42, VIA_CR42_FM_ENABLE),
-		YN (r42, VIA_CR42_MIDI_ENABLE),
-
-		YN (r44, VIA_CR44_AC_LINK_ACCESS),
-		YN (r44, VIA_CR44_SECOND_CODEC_SUPPORT)
-
-		);
-
-	DPRINTK ("EXIT, returning %d\n", len);
-	return len;
-
-#undef YN
-#undef ED
-}
-
-
-/****************************************************************
- *
- * /proc/driver/via/... setup and cleanup
- *
- *
- */
-
-static int __init via_init_proc (void)
-{
-	DPRINTK ("ENTER\n");
-
-	if (!proc_mkdir ("driver/via", 0))
-		return -EIO;
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-}
-
-
-static void via_cleanup_proc (void)
-{
-	DPRINTK ("ENTER\n");
-
-	remove_proc_entry ("driver/via", NULL);
-
-	DPRINTK ("EXIT\n");
-}
-
-
-static int __devinit via_card_init_proc (struct via_info *card)
-{
-	char s[32];
-	int rc;
-
-	DPRINTK ("ENTER\n");
-
-	sprintf (s, "driver/via/%d", card->card_num);
-	if (!proc_mkdir (s, 0)) {
-		rc = -EIO;
-		goto err_out_none;
-	}
-
-	sprintf (s, "driver/via/%d/info", card->card_num);
-	if (!create_proc_read_entry (s, 0, 0, via_info_read_proc, card)) {
-		rc = -EIO;
-		goto err_out_dir;
-	}
-
-	sprintf (s, "driver/via/%d/ac97", card->card_num);
-	if (!create_proc_read_entry (s, 0, 0, ac97_read_proc, card->ac97)) {
-		rc = -EIO;
-		goto err_out_info;
-	}
-
-	DPRINTK ("EXIT, returning 0\n");
-	return 0;
-
-err_out_info:
-	sprintf (s, "driver/via/%d/info", card->card_num);
-	remove_proc_entry (s, NULL);
-
-err_out_dir:
-	sprintf (s, "driver/via/%d", card->card_num);
-	remove_proc_entry (s, NULL);
-
-err_out_none:
-	DPRINTK ("EXIT, returning %d\n", rc);
-	return rc;
-}
-
-
-static void via_card_cleanup_proc (struct via_info *card)
-{
-	char s[32];
-
-	DPRINTK ("ENTER\n");
-
-	sprintf (s, "driver/via/%d/ac97", card->card_num);
-	remove_proc_entry (s, NULL);
-
-	sprintf (s, "driver/via/%d/info", card->card_num);
-	remove_proc_entry (s, NULL);
-
-	sprintf (s, "driver/via/%d", card->card_num);
-	remove_proc_entry (s, NULL);
-
-	DPRINTK ("EXIT\n");
-}
-
-#endif /* VIA_PROC_FS */


