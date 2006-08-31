Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWHaMhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHaMhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWHaMhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:37:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2781 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932138AbWHaMhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:37:22 -0400
Date: Thu, 31 Aug 2006 14:37:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       perex@suse.cz, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, pshou@realtek.com.tw
Subject: sound/pci/hda/intel_hda: small cleanups
Message-ID: <20060831123706.GC3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cleanup whitespace and warn about wrong volatile usage. This code
loves to use deprecated if ((err = foo())), but I did not have enough
strength to fix all of it. Ouch also maintainers item would be handy.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 79d63c9..86064a8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -252,6 +252,7 @@ enum {
 struct azx_dev {
 	u32 *bdl;			/* virtual address of the BDL */
 	dma_addr_t bdl_addr;		/* physical address of the BDL */
+	/* FIXME: volatile does not provide needed locking on SMP systems */
 	volatile u32 *posbuf;			/* position buffer pointer */
 
 	unsigned int bufsize;		/* size of the play buffer in bytes */
@@ -271,8 +272,8 @@ struct azx_dev {
 	/* for sanity check of position buffer */
 	unsigned int period_intr;
 
-	unsigned int opened: 1;
-	unsigned int running: 1;
+	unsigned int opened :1;
+	unsigned int running :1;
 };
 
 /* CORB/RIRB */
@@ -330,8 +331,8 @@ struct azx {
 
 	/* flags */
 	int position_fix;
-	unsigned int initialized: 1;
-	unsigned int single_cmd: 1;
+	unsigned int initialized :1;
+	unsigned int single_cmd :1;
 };
 
 /* driver types */
@@ -642,14 +643,14 @@ static int azx_reset(struct azx *chip)
 	azx_writeb(chip, GCTL, azx_readb(chip, GCTL) | ICH6_GCTL_RESET);
 
 	count = 50;
-	while (! azx_readb(chip, GCTL) && --count)
+	while (!azx_readb(chip, GCTL) && --count)
 		msleep(1);
 
-	/* Brent Chartrand said to wait >= 540us for codecs to intialize */
+	/* Brent Chartrand said to wait >= 540us for codecs to initialize */
 	msleep(1);
 
 	/* check to see if controller is ready */
-	if (! azx_readb(chip, GCTL)) {
+	if (!azx_readb(chip, GCTL)) {
 		snd_printd("azx_reset: controller not ready!\n");
 		return -EBUSY;
 	}
@@ -658,7 +659,7 @@ static int azx_reset(struct azx *chip)
 	azx_writel(chip, GCTL, azx_readl(chip, GCTL) | ICH6_GCTL_UREN);
 
 	/* detect codecs */
-	if (! chip->codec_mask) {
+	if (!chip->codec_mask) {
 		chip->codec_mask = azx_readw(chip, STATESTS);
 		snd_printdd("codec_mask = 0x%x\n", chip->codec_mask);
 	}
@@ -766,7 +767,7 @@ static void azx_init_chip(struct azx *ch
 	azx_int_enable(chip);
 
 	/* initialize the codec command I/O */
-	if (! chip->single_cmd)
+	if (!chip->single_cmd)
 		azx_init_cmd_io(chip);
 
 	/* program the position buffer */
@@ -794,7 +795,7 @@ static void azx_init_chip(struct azx *ch
 /*
  * interrupt handler
  */
-static irqreturn_t azx_interrupt(int irq, void* dev_id, struct pt_regs *regs)
+static irqreturn_t azx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct azx *chip = dev_id;
 	struct azx_dev *azx_dev;
@@ -999,8 +1000,7 @@ static struct snd_pcm_hardware azx_pcm_h
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
-				 SNDRV_PCM_INFO_PAUSE /*|*/
-				 /*SNDRV_PCM_INFO_RESUME*/),
+				 SNDRV_PCM_INFO_PAUSE),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_48000,
 	.rate_min =		48000,
@@ -1322,6 +1322,8 @@ static int __devinit azx_init_stream(str
 	 * assign the starting bdl address to each stream (device) and initialize
 	 */
 	for (i = 0; i < chip->num_streams; i++) {
+		/* FIXME: this should probably use readl or something.
+		   hand-doing volatiles is wrong. */
 		unsigned int off = sizeof(u32) * (i * AZX_MAX_FRAG * 4);
 		struct azx_dev *azx_dev = &chip->azx_dev[i];
 		azx_dev->bdl = (u32 *)(chip->bdl.area + off);
@@ -1399,6 +1401,7 @@ static int azx_free(struct azx *chip)
 		azx_writel(chip, DPUBASE, 0);
 
 		/* wait a little for interrupts to finish */
+		/* FIXME: delay is not right way to wait for interrupts */
 		msleep(1);
 	}
 
@@ -1434,19 +1437,19 @@ static int __devinit azx_create(struct s
 				struct azx **rchip)
 {
 	struct azx *chip;
-	int err = 0;
+	int err;
 	static struct snd_device_ops ops = {
 		.dev_free = azx_dev_free,
 	};
 
 	*rchip = NULL;
 	
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	
-	if (NULL == chip) {
+	if (!chip) {
 		snd_printk(KERN_ERR SFX "cannot allocate chip\n");
 		pci_disable_device(pci);
 		return -ENOMEM;
@@ -1472,13 +1475,14 @@ static int __devinit azx_create(struct s
 	}
 #endif
 
-	if ((err = pci_request_regions(pci, "ICH HD audio")) < 0) {
+	err = pci_request_regions(pci, "ICH HD audio");
+	if (err < 0) {
 		kfree(chip);
 		pci_disable_device(pci);
 		return err;
 	}
 
-	chip->addr = pci_resource_start(pci,0);
+	chip->addr = pci_resource_start(pci, 0);
 	chip->remap_addr = ioremap_nocache(chip->addr, pci_resource_len(pci,0));
 	if (chip->remap_addr == NULL) {
 		snd_printk(KERN_ERR SFX "ioremap error\n");
@@ -1519,7 +1523,7 @@ static int __devinit azx_create(struct s
 	}
 	chip->num_streams = chip->playback_streams + chip->capture_streams;
 	chip->azx_dev = kcalloc(chip->num_streams, sizeof(*chip->azx_dev), GFP_KERNEL);
-	if (! chip->azx_dev) {
+	if (!chip->azx_dev) {
 		snd_printk(KERN_ERR "cannot malloc azx_dev\n");
 		goto errout;
 	}
@@ -1550,7 +1554,7 @@ static int __devinit azx_create(struct s
 	chip->initialized = 1;
 
 	/* codec detection */
-	if (! chip->codec_mask) {
+	if (!chip->codec_mask) {
 		snd_printk(KERN_ERR SFX "no codecs found!\n");
 		err = -ENODEV;
 		goto errout;
@@ -1577,16 +1581,16 @@ static int __devinit azx_probe(struct pc
 {
 	struct snd_card *card;
 	struct azx *chip;
-	int err = 0;
+	int err;
 
 	card = snd_card_new(index, id, THIS_MODULE, 0);
-	if (NULL == card) {
+	if (!card) {
 		snd_printk(KERN_ERR SFX "Error creating card!\n");
 		return -ENOMEM;
 	}
 
-	if ((err = azx_create(card, pci, pci_id->driver_data,
-			      &chip)) < 0) {
+	err = azx_create(card, pci, pci_id->driver_data, &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
