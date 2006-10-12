Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbWJLPFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWJLPFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWJLPFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:05:39 -0400
Received: from twin.jikos.cz ([213.151.79.26]:31117 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932578AbWJLPFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:05:37 -0400
Date: Thu, 12 Oct 2006 17:05:10 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Jaroslav Kysela <perex@suse.cz>
cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix PCI sound drivers, ignoring return value from
 pci_enable_device()
Message-ID: <Pine.LNX.4.64.0610121703420.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] fix PCI drivers in alsa, ignoring return value from pci_enable_device()

This patch adds checks to _resume methods of PCI sound drivers in which it 
was missing.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 13a8cef..2685894 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2042,14 +2042,18 @@ static int ali_resume(struct pci_dev *pc
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_ali *chip = card->private_data;
 	struct snd_ali_image *im;
-	int i, j;
+	int i, j, err;
 
 	im = chip->image;
 	if (! im)
 		return 0;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "ali: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 
 	spin_lock_irq(&chip->reg_lock);
 	
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 9b16c29..8d4bbd4 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -778,9 +778,13 @@ static int snd_als300_resume(struct pci_
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_als300 *chip = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "als300: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 15fc392..22d378a 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -815,9 +815,13 @@ static int snd_als4000_resume(struct pci
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_card_als4000 *acard = card->private_data;
 	struct snd_sb *chip = acard->chip;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "als4000: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 3e8fc5a..1628ec5 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1452,10 +1452,14 @@ static int snd_atiixp_resume(struct pci_
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct atiixp *chip = card->private_data;
-	int i;
+	int i, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "atiixp: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index c5dda1b..02b1792 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1138,10 +1138,13 @@ static int snd_atiixp_resume(struct pci_
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct atiixp_modem *chip = card->private_data;
-	int i;
+	int i, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "atiixp: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 692f203..521d0ef 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -1914,10 +1914,13 @@ snd_azf3328_resume(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_azf3328 *chip = card->private_data;
-	int reg;
+	int reg, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "azf3328: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 1f7e710..79c8fee 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3132,10 +3132,14 @@ static int snd_cmipci_resume(struct pci_
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct cmipci *cm = card->private_data;
-	int i;
+	int i, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "cmi: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index d54924e..24c5c73 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -2058,10 +2058,15 @@ static int cs4281_resume(struct pci_dev 
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct cs4281 *chip = card->private_data;
 	unsigned int i;
+	int err;
 	u32 ulCLK;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "cs4281: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_master(pci);
 
 	ulCLK = snd_cs4281_peekBA0(chip, BA0_CLKCR1);
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 16d4ebf..b451b7b 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3696,10 +3696,14 @@ int snd_cs46xx_resume(struct pci_dev *pc
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_cs46xx *chip = card->private_data;
-	int amp_saved;
+	int amp_saved, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "cs46xx: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_master(pci);
 	amp_saved = chip->amplifier;
 	chip->amplifier = 0;
diff --git a/sound/pci/cs5535audio/cs5535audio_pm.c b/sound/pci/cs5535audio/cs5535audio_pm.c
index aad0e69..b3fcbc6 100644
--- a/sound/pci/cs5535audio/cs5535audio_pm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pm.c
@@ -85,10 +85,13 @@ int snd_cs5535audio_resume(struct pci_de
 	struct cs5535audio *cs5535au = card->private_data;
 	u32 tmp;
 	int timeout;
-	int i;
+	int i, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "cs5535audio: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_master(pci);
 
 	/* set LNK_WRM_RST to reset AC link */
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 493ec08..43823eb 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -236,9 +236,14 @@ static int snd_emu10k1_resume(struct pci
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_emu10k1 *emu = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "emu10k1: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 	
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 8cb4fb2..8f015ea 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2082,9 +2082,13 @@ static int snd_ensoniq_resume(struct pci
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct ensoniq *ensoniq = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "ensoniq: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 2da988f..d0eb1a3 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1493,9 +1493,13 @@ static int es1938_resume(struct pci_dev 
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct es1938 *chip = card->private_data;
 	unsigned char *s, *d;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "es1938: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	request_irq(pci->irq, snd_es1938_interrupt,
 		    IRQF_DISABLED|IRQF_SHARED, "ES1938", chip);
 	chip->irq = pci->irq;
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index b9d723c..6691eaa 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2408,13 +2408,17 @@ static int es1968_resume(struct pci_dev 
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct es1968 *chip = card->private_data;
 	struct list_head *p;
+	int err;
 
 	if (! chip->do_pm)
 		return 0;
 
 	/* restore all our config */
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "es1968: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_master(pci);
 	snd_es1968_chip_init(chip);
 
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 3ec7d7e..68d2ca3 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1542,9 +1542,13 @@ static int snd_fm801_resume(struct pci_d
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct fm801 *chip = card->private_data;
 	int i;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "fm801: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index feeed12..deea3e0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1392,9 +1392,14 @@ static int azx_resume(struct pci_dev *pc
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct azx *chip = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "azx: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	if (!disable_msi)
 		pci_enable_msi(pci);
 	/* FIXME: need proper error handling */
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index f4319b8..6693e9d 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2488,9 +2488,14 @@ static int intel8x0_resume(struct pci_de
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct intel8x0 *chip = card->private_data;
 	int i;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "intel8x0: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_master(pci);
 	request_irq(pci->irq, snd_intel8x0_interrupt, IRQF_DISABLED|IRQF_SHARED,
 		    card->shortname, chip);
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 6703f5c..080d072 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1056,9 +1056,14 @@ static int intel8x0m_resume(struct pci_d
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct intel8x0m *chip = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "intel8x0m: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_master(pci);
 	request_irq(pci->irq, snd_intel8x0_interrupt, IRQF_DISABLED|IRQF_SHARED,
 		    card->shortname, chip);
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 05605f4..35077b7 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2602,13 +2602,17 @@ static int m3_resume(struct pci_dev *pci
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_m3 *chip = card->private_data;
-	int i, index;
+	int i, index, err;
 
 	if (chip->suspend_mem == NULL)
 		return 0;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "m3: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_master(pci);
 
 	/* first lets just bring everything back. .*/
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index b1bbdb9..7990103 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1397,12 +1397,16 @@ static int nm256_resume(struct pci_dev *
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct nm256 *chip = card->private_data;
-	int i;
+	int i, err;
 
 	/* Perform a full reset on the hardware */
 	chip->in_resume = 1;
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "nm256: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	snd_nm256_init_chip(chip);
 
 	/* restore ac97 */
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index ec48991..3a17a71 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1188,9 +1188,13 @@ static int riptide_resume(struct pci_dev
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_riptide *chip = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "riptide: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 	snd_riptide_initialize(chip);
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 0d47887..fbd8629 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3982,9 +3982,13 @@ int snd_trident_resume(struct pci_dev *p
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_trident *trident = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "trident: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_master(pci); /* to be sure */
 
 	switch (trident->device) {
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index e6990e0..8daea32 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2195,10 +2195,13 @@ static int snd_via82xx_resume(struct pci
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct via82xx *chip = card->private_data;
-	int i;
+	int i, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "via82xx: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 
 	snd_via82xx_chip_init(chip);
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 5ab1cf3..09c4afd 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1042,10 +1042,13 @@ static int snd_via82xx_resume(struct pci
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct via82xx_modem *chip = card->private_data;
-	int i;
+	int i, err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "via82xx: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index e7cd8ac..64086b2 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -276,9 +276,14 @@ static int snd_vx222_resume(struct pci_d
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_vx222 *vx = card->private_data;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "vx222: Cannot enable PCI device during resume\n");
+		return err;
+	}
+
 	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 	return snd_vx_resume(&vx->core);
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index ebc6da8..f647d01 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2226,9 +2226,13 @@ int snd_ymfpci_resume(struct pci_dev *pc
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_ymfpci *chip = card->private_data;
 	unsigned int i;
+	int err;
 
 	pci_restore_state(pci);
-	pci_enable_device(pci);
+	if ((err = pci_enable_device(pci))) {
+		printk(KERN_ERR "ymf: Cannot enable PCI device during resume\n");
+		return err;
+	}
 	pci_set_master(pci);
 	snd_ymfpci_aclink_reset(pci);
 	snd_ymfpci_codec_ready(chip, 0);

-- 
Jiri Kosina
