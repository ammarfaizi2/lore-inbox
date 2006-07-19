Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWGSAy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWGSAy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 20:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWGSAy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 20:54:59 -0400
Received: from student.uhasselt.be ([193.190.2.1]:49924 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932223AbWGSAy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 20:54:58 -0400
Date: Wed, 19 Jul 2006 02:54:55 +0200
To: linux-kernel@vger.kernel.org
Cc: kyle@parisc-linux.org, twoller@crystal.cirrus.com,
       James@superbug.demon.co.uk, zab@zabbo.net, sailer@ife.ee.ethz.ch,
       perex@suse.cz, zaitcev@yahoo.com
Subject: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719005455.GB30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

sound: Conversions from kmalloc+memset to k(c|z)alloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Applies to 2.6.18-rc2 (==current GIT). Compile-tested
with allyesconfig.

 sound/core/oss/mixer_oss.c      |    3 +--
 sound/core/seq/seq_device.c     |    3 +--
 sound/core/sgbuf.c              |    9 +++------
 sound/drivers/vx/vx_pcm.c       |    7 ++-----
 sound/oss/ac97_codec.c          |    3 +--
 sound/oss/ad1889.c              |    3 +--
 sound/oss/ali5455.c             |   10 +++-------
 sound/oss/btaudio.c             |    3 +--
 sound/oss/cs4281/cs4281m.c      |    3 +--
 sound/oss/cs46xx.c              |    9 +++------
 sound/oss/dmasound/dac3550a.c   |    3 +--
 sound/oss/dmasound/tas3001c.c   |    3 +--
 sound/oss/dmasound/tas3004.c    |    3 +--
 sound/oss/dmasound/tas_common.c |    3 +--
 sound/oss/emu10k1/main.c        |   11 +++--------
 sound/oss/es1370.c              |    3 +--
 sound/oss/es1371.c              |    3 +--
 sound/oss/esssolo1.c            |    3 +--
 sound/oss/hal2.c                |    3 +--
 sound/oss/i810_audio.c          |   12 ++++--------
 sound/oss/ite8172.c             |    3 +--
 sound/oss/kahlua.c              |    3 +--
 sound/oss/maestro3.c            |    3 +--
 sound/oss/nec_vrc5477.c         |    3 +--
 sound/oss/rme96xx.c             |    3 +--
 sound/oss/sb_card.c             |    6 ++----
 sound/oss/sonicvibes.c          |    3 +--
 sound/oss/swarm_cs4297a.c       |    9 +++------
 sound/oss/trident.c             |    9 +++------
 sound/oss/waveartist.c          |    4 +---
 sound/oss/ymfpci.c              |    6 ++----
 sound/pci/echoaudio/echoaudio.c |    3 +--
 sound/ppc/awacs.c               |    3 +--
 sound/ppc/daca.c                |    3 +--
 sound/ppc/keywest.c             |    3 +--
 sound/ppc/tumbler.c             |    3 +--
 sound/usb/usbaudio.c            |    6 ++----
 37 files changed, 56 insertions(+), 117 deletions(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 71b5080..75a9505 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -988,13 +988,12 @@ static int snd_mixer_oss_build_input(str
 	if (ptr->index == 0 && (kctl = snd_mixer_oss_test_id(mixer, "Capture Source", 0)) != NULL) {
 		struct snd_ctl_elem_info *uinfo;
 
-		uinfo = kmalloc(sizeof(*uinfo), GFP_KERNEL);
+		uinfo = kzalloc(sizeof(*uinfo), GFP_KERNEL);
 		if (! uinfo) {
 			up_read(&mixer->card->controls_rwsem);
 			return -ENOMEM;
 		}
 			
-		memset(uinfo, 0, sizeof(*uinfo));
 		if (kctl->info(kctl, uinfo)) {
 			up_read(&mixer->card->controls_rwsem);
 			return 0;
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 4260de9..102ff54 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -372,10 +372,9 @@ static struct ops_list * create_driver(c
 {
 	struct ops_list *ops;
 
-	ops = kmalloc(sizeof(*ops), GFP_KERNEL);
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 	if (ops == NULL)
 		return ops;
-	memset(ops, 0, sizeof(*ops));
 
 	/* set up driver entry */
 	strlcpy(ops->id, id, sizeof(ops->id));
diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 6e4d4ab..c30669f 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -68,21 +68,18 @@ void *snd_malloc_sgbuf_pages(struct devi
 
 	dmab->area = NULL;
 	dmab->addr = 0;
-	dmab->private_data = sgbuf = kmalloc(sizeof(*sgbuf), GFP_KERNEL);
+	dmab->private_data = sgbuf = kzalloc(sizeof(*sgbuf), GFP_KERNEL);
 	if (! sgbuf)
 		return NULL;
-	memset(sgbuf, 0, sizeof(*sgbuf));
 	sgbuf->dev = device;
 	pages = snd_sgbuf_aligned_pages(size);
 	sgbuf->tblsize = sgbuf_align_table(pages);
-	sgbuf->table = kmalloc(sizeof(*sgbuf->table) * sgbuf->tblsize, GFP_KERNEL);
+	sgbuf->table = kcalloc(sgbuf->tblsize, sizeof(*sgbuf->table), GFP_KERNEL);
 	if (! sgbuf->table)
 		goto _failed;
-	memset(sgbuf->table, 0, sizeof(*sgbuf->table) * sgbuf->tblsize);
-	sgbuf->page_table = kmalloc(sizeof(*sgbuf->page_table) * sgbuf->tblsize, GFP_KERNEL);
+	sgbuf->page_table = kcalloc(sgbuf->tblsize, sizeof(*sgbuf->page_table), GFP_KERNEL);
 	if (! sgbuf->page_table)
 		goto _failed;
-	memset(sgbuf->page_table, 0, sizeof(*sgbuf->page_table) * sgbuf->tblsize);
 
 	/* allocate each page */
 	for (i = 0; i < pages; i++) {
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index c4af849..7e65a10 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1252,18 +1252,15 @@ static int vx_init_audio_io(struct vx_co
 	chip->audio_info = rmh.Stat[1];
 
 	/* allocate pipes */
-	chip->playback_pipes = kmalloc(sizeof(struct vx_pipe *) * chip->audio_outs, GFP_KERNEL);
+	chip->playback_pipes = kcalloc(chip->audio_outs, sizeof(struct vx_pipe *), GFP_KERNEL);
 	if (!chip->playback_pipes)
 		return -ENOMEM;
-	chip->capture_pipes = kmalloc(sizeof(struct vx_pipe *) * chip->audio_ins, GFP_KERNEL);
+	chip->capture_pipes = kcalloc(chip->audio_ins, sizeof(struct vx_pipe *), GFP_KERNEL);
 	if (!chip->capture_pipes) {
 		kfree(chip->playback_pipes);
 		return -ENOMEM;
 	}
 
-	memset(chip->playback_pipes, 0, sizeof(struct vx_pipe *) * chip->audio_outs);
-	memset(chip->capture_pipes, 0, sizeof(struct vx_pipe *) * chip->audio_ins);
-
 	preferred = chip->ibl.size;
 	chip->ibl.size = 0;
 	vx_set_ibl(chip, &chip->ibl); /* query the info */
diff --git a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
index 972327c..a233f0a 100644
--- a/sound/oss/ac97_codec.c
+++ b/sound/oss/ac97_codec.c
@@ -744,11 +744,10 @@ static int ac97_check_modem(struct ac97_
  
 struct ac97_codec *ac97_alloc_codec(void)
 {
-	struct ac97_codec *codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL);
+	struct ac97_codec *codec = kzalloc(sizeof(struct ac97_codec), GFP_KERNEL);
 	if(!codec)
 		return NULL;
 
-	memset(codec, 0, sizeof(*codec));
 	spin_lock_init(&codec->lock);
 	INIT_LIST_HEAD(&codec->list);
 	return codec;
diff --git a/sound/oss/ad1889.c b/sound/oss/ad1889.c
index f56f870..255169d 100644
--- a/sound/oss/ad1889.c
+++ b/sound/oss/ad1889.c
@@ -230,9 +230,8 @@ static ad1889_dev_t *ad1889_alloc_dev(st
 	struct dmabuf *dmabuf;
 	int i;
 
-	if ((dev = kmalloc(sizeof(ad1889_dev_t), GFP_KERNEL)) == NULL) 
+	if ((dev = kzalloc(sizeof(ad1889_dev_t), GFP_KERNEL)) == NULL) 
 		return NULL;
-	memset(dev, 0, sizeof(ad1889_dev_t));
 	spin_lock_init(&dev->lock);
 	dev->pci = pci;
 
diff --git a/sound/oss/ali5455.c b/sound/oss/ali5455.c
index 70dcd70..46bd257 100644
--- a/sound/oss/ali5455.c
+++ b/sound/oss/ali5455.c
@@ -2788,10 +2788,9 @@ static int ali_open(struct inode *inode,
 
 		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = (struct ali_state *) kmalloc(sizeof(struct ali_state), GFP_KERNEL);
+				state = card->states[i] = kzalloc(sizeof(struct ali_state), GFP_KERNEL);
 				if (state == NULL)
 					return -ENOMEM;
-				memset(state, 0, sizeof(struct ali_state));
 				dmabuf = &state->dmabuf;
 				goto found_virt;
 			}
@@ -3350,11 +3349,9 @@ static void __devinit ali_configure_cloc
 	 * is a waste of time.
 	 */
 	if (card != NULL) {
-		state = card->states[0] = (struct ali_state *)
-		    kmalloc(sizeof(struct ali_state), GFP_KERNEL);
+		state = card->states[0] = kzalloc(sizeof(struct ali_state), GFP_KERNEL);
 		if (state == NULL)
 			return;
-		memset(state, 0, sizeof(struct ali_state));
 		dmabuf = &state->dmabuf;
 		dmabuf->write_channel = card->alloc_pcm_channel(card);
 		state->virt = 0;
@@ -3416,11 +3413,10 @@ static int __devinit ali_probe(struct pc
 		return -ENODEV;
 	}
 
-	if ((card = kmalloc(sizeof(struct ali_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct ali_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ali_audio: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));
 	card->initializing = 1;
 	card->iobase = pci_resource_start(pci_dev, 0);
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/btaudio.c b/sound/oss/btaudio.c
index 324a81f..5418934 100644
--- a/sound/oss/btaudio.c
+++ b/sound/oss/btaudio.c
@@ -915,12 +915,11 @@ static int __devinit btaudio_probe(struc
 		return -EBUSY;
 	}
 
-	bta = kmalloc(sizeof(*bta),GFP_ATOMIC);
+	bta = kzalloc(sizeof(*bta),GFP_ATOMIC);
 	if (!bta) {
 		rc = -ENOMEM;
 		goto fail0;
 	}
-	memset(bta,0,sizeof(*bta));
 
 	bta->pci  = pci_dev;
 	bta->irq  = pci_dev->irq;
diff --git a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
index 0400a41..78cd0a7 100644
--- a/sound/oss/cs4281/cs4281m.c
+++ b/sound/oss/cs4281/cs4281m.c
@@ -4287,12 +4287,11 @@ static int __devinit cs4281_probe(struct
 		      "cs4281: probe() architecture does not support 32bit PCI busmaster DMA\n"));
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct cs4281_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct cs4281_state), GFP_KERNEL))) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR
 		      "cs4281: probe() no memory for state struct.\n"));
 		return -1;
 	}
-	memset(s, 0, sizeof(struct cs4281_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
index 5195bf9..69b6f6e 100644
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -3044,10 +3044,9 @@ static int cs_open(struct inode *inode, 
 		CS_DBGOUT(CS_WAVE_READ, 2, printk("cs46xx: cs_open() FMODE_READ\n") );
 		if (card->states[0] == NULL) {
 			state = card->states[0] =
-				kmalloc(sizeof(struct cs_state), GFP_KERNEL);
+				kzalloc(sizeof(struct cs_state), GFP_KERNEL);
 			if (state == NULL)
 				return -ENOMEM;
-			memset(state, 0, sizeof(struct cs_state));
 			mutex_init(&state->sem);
 			dmabuf = &state->dmabuf;
 			dmabuf->pbuf = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
@@ -3110,10 +3109,9 @@ static int cs_open(struct inode *inode, 
 		CS_DBGOUT(CS_OPEN, 2, printk("cs46xx: cs_open() FMODE_WRITE\n") );
 		if (card->states[1] == NULL) {
 			state = card->states[1] =
-				kmalloc(sizeof(struct cs_state), GFP_KERNEL);
+				kzalloc(sizeof(struct cs_state), GFP_KERNEL);
 			if (state == NULL)
 				return -ENOMEM;
-			memset(state, 0, sizeof(struct cs_state));
 			mutex_init(&state->sem);
 			dmabuf = &state->dmabuf;
 			dmabuf->pbuf = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
@@ -5071,11 +5069,10 @@ static int __devinit cs46xx_probe(struct
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &ss_vendor);
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &ss_card);
 
-	if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "cs46xx: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));
 	card->ba0_addr = RSRCADDRESS(pci_dev, 0);
 	card->ba1_addr = RSRCADDRESS(pci_dev, 1);
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/dmasound/dac3550a.c b/sound/oss/dmasound/dac3550a.c
index 7360d89..0f0d03a 100644
--- a/sound/oss/dmasound/dac3550a.c
+++ b/sound/oss/dmasound/dac3550a.c
@@ -163,10 +163,9 @@ static int daca_detect_client(struct i2c
 	struct i2c_client *new_client;
 	int rc = -ENODEV;
 
-	new_client = kmalloc(sizeof(*new_client), GFP_KERNEL);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
 	if (!new_client)
 		return -ENOMEM;
-	memset(new_client, 0, sizeof(*new_client));
 
 	new_client->addr = address;
 	new_client->adapter = adapter;
diff --git a/sound/oss/dmasound/tas3001c.c b/sound/oss/dmasound/tas3001c.c
index f227c9f..4aa25b7 100644
--- a/sound/oss/dmasound/tas3001c.c
+++ b/sound/oss/dmasound/tas3001c.c
@@ -807,10 +807,9 @@ tas3001c_init(struct i2c_client *client)
 	size_t sz = sizeof(*self) + (TAS3001C_REG_MAX*sizeof(tas_shadow_t));
 	int i, j;
 
-	self = kmalloc(sz, GFP_KERNEL);
+	self = kzalloc(sz, GFP_KERNEL);
 	if (!self)
 		return -ENOMEM;
-	memset(self, 0, sz);
 
 	self->super.client = client;
 	self->super.shadow = (tas_shadow_t *)(self+1);
diff --git a/sound/oss/dmasound/tas3004.c b/sound/oss/dmasound/tas3004.c
index 82eaaca..7101a29 100644
--- a/sound/oss/dmasound/tas3004.c
+++ b/sound/oss/dmasound/tas3004.c
@@ -1093,10 +1093,9 @@ tas3004_init(struct i2c_client *client)
 	char mcr2 = 0;
 	int i, j;
 
-	self = kmalloc(sz, GFP_KERNEL);
+	self = kzalloc(sz, GFP_KERNEL);
 	if (!self)
 		return -ENOMEM;
-	memset(self, 0, sz);
 
 	self->super.client = client;
 	self->super.shadow = (tas_shadow_t *)(self+1);
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index 882ae98..665e85b 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -135,10 +135,9 @@ tas_detect_client(struct i2c_adapter *ad
 		return -ENODEV;
 	}
 	
-	new_client = kmalloc(sizeof(*new_client), GFP_KERNEL);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
 	if (!new_client)
 		return -ENOMEM;
-	memset(new_client, 0, sizeof(*new_client));
 
 	new_client->addr = address;
 	new_client->adapter = adapter;
diff --git a/sound/oss/emu10k1/main.c b/sound/oss/emu10k1/main.c
index c4ce94d..b6d2d25 100644
--- a/sound/oss/emu10k1/main.c
+++ b/sound/oss/emu10k1/main.c
@@ -455,15 +455,13 @@ static int __devinit emu10k1_midi_init(s
 {
 	int ret;
 
-	card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL);
+	card->mpuout = kzalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL);
 	if (card->mpuout == NULL) {
 		printk(KERN_WARNING "emu10k1: Unable to allocate emu10k1_mpuout: out of memory\n");
 		ret = -ENOMEM;
 		goto err_out1;
 	}
 
-	memset(card->mpuout, 0, sizeof(struct emu10k1_mpuout));
-
 	card->mpuout->intr = 1;
 	card->mpuout->status = FLAGS_AVAILABLE;
 	card->mpuout->state = CARDMIDIOUT_STATE_DEFAULT;
@@ -472,15 +470,13 @@ static int __devinit emu10k1_midi_init(s
 
 	spin_lock_init(&card->mpuout->lock);
 
-	card->mpuin = kmalloc(sizeof(struct emu10k1_mpuin), GFP_KERNEL);
+	card->mpuin = kzalloc(sizeof(struct emu10k1_mpuin), GFP_KERNEL);
 	if (card->mpuin == NULL) {
 		printk(KERN_WARNING "emu10k1: Unable to allocate emu10k1_mpuin: out of memory\n");
 		ret = -ENOMEM;
                 goto err_out2;
 	}
 
-	memset(card->mpuin, 0, sizeof(struct emu10k1_mpuin));
-
 	card->mpuin->status = FLAGS_AVAILABLE;
 
 	tasklet_init(&card->mpuin->tasklet, emu10k1_mpuin_bh, (unsigned long) card->mpuin);
@@ -1280,11 +1276,10 @@ static int __devinit emu10k1_probe(struc
 
 	pci_set_master(pci_dev);
 
-	if ((card = kmalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
                 printk(KERN_ERR "emu10k1: out of memory\n");
                 return -ENOMEM;
         }
-        memset(card, 0, sizeof(struct emu10k1_card));
 
 	card->iobase = pci_resource_start(pci_dev, 0);
 	card->length = pci_resource_len(pci_dev, 0); 
diff --git a/sound/oss/es1370.c b/sound/oss/es1370.c
index 13f4831..1a984b6 100644
--- a/sound/oss/es1370.c
+++ b/sound/oss/es1370.c
@@ -2628,11 +2628,10 @@ static int __devinit es1370_probe(struct
 		printk(KERN_WARNING "es1370: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct es1370_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct es1370_state), GFP_KERNEL))) {
 		printk(KERN_WARNING "es1370: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct es1370_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac1.wait);
 	init_waitqueue_head(&s->dma_dac2.wait);
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index a2ffe72..19dd1bc 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -2869,11 +2869,10 @@ static int __devinit es1371_probe(struct
 		printk(KERN_WARNING "es1371: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
 		printk(KERN_WARNING PFX "out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct es1371_state));
 	
 	s->codec = ac97_alloc_codec();
 	if(s->codec == NULL)
diff --git a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
index 82f40a0..168f388 100644
--- a/sound/oss/esssolo1.c
+++ b/sound/oss/esssolo1.c
@@ -2354,11 +2354,10 @@ static int __devinit solo1_probe(struct 
 		return -ENODEV;
 	}
 
-	if (!(s = kmalloc(sizeof(struct solo1_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct solo1_state), GFP_KERNEL))) {
 		printk(KERN_WARNING "solo1: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct solo1_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/hal2.c b/sound/oss/hal2.c
index 80ab402..a84ee1d 100644
--- a/sound/oss/hal2.c
+++ b/sound/oss/hal2.c
@@ -1435,10 +1435,9 @@ static int hal2_init_card(struct hal2_ca
 	int ret = 0;
 	struct hal2_card *hal2;
 
-	hal2 = (struct hal2_card *) kmalloc(sizeof(struct hal2_card), GFP_KERNEL);
+	hal2 = kzalloc(sizeof(struct hal2_card), GFP_KERNEL);
 	if (!hal2)
 		return -ENOMEM;
-	memset(hal2, 0, sizeof(struct hal2_card));
 
 	hal2->ctl_regs = (struct hal2_ctl_regs *)hpc3->pbus_extregs[0];
 	hal2->aes_regs = (struct hal2_aes_regs *)hpc3->pbus_extregs[1];
diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
index ddcddc2..5105ed6 100644
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -2578,11 +2578,10 @@ static int i810_open(struct inode *inode
 		}
 		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = (struct i810_state *)
-					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
+				state = card->states[i] = 
+					kzalloc(sizeof(struct i810_state), GFP_KERNEL);
 				if (state == NULL)
 					return -ENOMEM;
-				memset(state, 0, sizeof(struct i810_state));
 				dmabuf = &state->dmabuf;
 				goto found_virt;
 			}
@@ -3203,11 +3202,9 @@ static void __devinit i810_configure_clo
 	 * is a waste of time.
 	 */
 	if(card != NULL) {
-		state = card->states[0] = (struct i810_state *)
-					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
+		state = card->states[0] = kzalloc(sizeof(struct i810_state), GFP_KERNEL);
 		if (state == NULL)
 			return;
-		memset(state, 0, sizeof(struct i810_state));
 		dmabuf = &state->dmabuf;
 
 		dmabuf->write_channel = card->alloc_pcm_channel(card);
@@ -3272,11 +3269,10 @@ static int __devinit i810_probe(struct p
 		return -ENODEV;
 	}
 	
-	if ((card = kmalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "i810_audio: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));
 
 	card->initializing = 1;
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/ite8172.c b/sound/oss/ite8172.c
index 68aab36..45b7a4b 100644
--- a/sound/oss/ite8172.c
+++ b/sound/oss/ite8172.c
@@ -1990,12 +1990,11 @@ static int __devinit it8172_probe(struct
 	if (pcidev->irq == 0) 
 		return -1;
 
-	if (!(s = kmalloc(sizeof(struct it8172_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct it8172_state), GFP_KERNEL))) {
 		err("alloc of device struct failed");
 		return -1;
 	}
 	
-	memset(s, 0, sizeof(struct it8172_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/kahlua.c b/sound/oss/kahlua.c
index 12e7b30..dfe670f 100644
--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -139,13 +139,12 @@ static int __devinit probe_one(struct pc
 	printk(KERN_INFO "kahlua: XpressAudio on IRQ %d, DMA %d, %d\n",
 		irq, dma8, dma16);
 	
-	hw_config = kmalloc(sizeof(struct address_info), GFP_KERNEL);
+	hw_config = kzalloc(sizeof(struct address_info), GFP_KERNEL);
 	if(hw_config == NULL)
 	{
 		printk(KERN_ERR "kahlua: out of memory.\n");
 		return 1;
 	}
-	memset(hw_config, 0, sizeof(*hw_config));
 	
 	pci_set_drvdata(pdev, hw_config);
 	
diff --git a/sound/oss/maestro3.c b/sound/oss/maestro3.c
index 5548e3c..e87cee7 100644
--- a/sound/oss/maestro3.c
+++ b/sound/oss/maestro3.c
@@ -2610,11 +2610,10 @@ static int __devinit m3_probe(struct pci
         
     pci_set_master(pci_dev);
 
-    if( (card = kmalloc(sizeof(struct m3_card), GFP_KERNEL)) == NULL) {
+    if( (card = kzalloc(sizeof(struct m3_card), GFP_KERNEL)) == NULL) {
         printk(KERN_WARNING PFX "out of memory\n");
         return -ENOMEM;
     }
-    memset(card, 0, sizeof(struct m3_card));
     card->pcidev = pci_dev;
     init_waitqueue_head(&card->suspend_queue);
 
diff --git a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
index 6f7f2f0..43834fd 100644
--- a/sound/oss/nec_vrc5477.c
+++ b/sound/oss/nec_vrc5477.c
@@ -1860,11 +1860,10 @@ #endif
 	if (pcidev->irq == 0) 
 		return -1;
 
-	if (!(s = kmalloc(sizeof(struct vrc5477_ac97_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct vrc5477_ac97_state), GFP_KERNEL))) {
 		printk(KERN_ERR PFX "alloc of device struct failed\n");
 		return -1;
 	}
-	memset(s, 0, sizeof(struct vrc5477_ac97_state));
 
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
diff --git a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
index f17d25b..868a05e 100644
--- a/sound/oss/rme96xx.c
+++ b/sound/oss/rme96xx.c
@@ -980,11 +980,10 @@ static int __devinit rme96xx_probe(struc
 		printk(KERN_WARNING RME_MESS" architecture does not support 32bit PCI busmaster DMA\n");
 		return -1;
 	}
-	if (!(s = kmalloc(sizeof(rme96xx_info), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(rme96xx_info), GFP_KERNEL))) {
 		printk(KERN_WARNING RME_MESS" out of memory\n");
 		return -1;
 	}
-	memset(s, 0, sizeof(rme96xx_info));
 
 	s->pcidev = pcidev;
 	s->iobase = ioremap(pci_resource_start(pcidev, 0),RME96xx_IO_EXTENT);
diff --git a/sound/oss/sb_card.c b/sound/oss/sb_card.c
index 8666291..27acd6f 100644
--- a/sound/oss/sb_card.c
+++ b/sound/oss/sb_card.c
@@ -137,11 +137,10 @@ static int __init sb_init_legacy(void)
 {
 	struct sb_module_options sbmo = {0};
 
-	if((legacy = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+	if((legacy = kzalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(legacy, 0, sizeof(struct sb_card_config));
 
 	legacy->conf.io_base      = io;
 	legacy->conf.irq          = irq;
@@ -247,11 +246,10 @@ static int sb_pnp_probe(struct pnp_card_
 		return -EBUSY;
 	}
 
-	if((scc = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+	if((scc = kzalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(scc, 0, sizeof(struct sb_card_config));
 
 	printk(KERN_INFO "sb: PnP: Found Card Named = \"%s\", Card PnP id = " \
 	       "%s, Device PnP id = %s\n", card->card->name, card_id->id,
diff --git a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
index 8ea532d..6258b14 100644
--- a/sound/oss/sonicvibes.c
+++ b/sound/oss/sonicvibes.c
@@ -2557,11 +2557,10 @@ static int __devinit sv_probe(struct pci
 			return -EBUSY;
 		}
 	}
-	if (!(s = kmalloc(sizeof(struct sv_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct sv_state), GFP_KERNEL))) {
 		printk(KERN_WARNING "sv: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct sv_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
index eb5ea32..b257f20 100644
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -615,25 +615,23 @@ static int init_serdma(serdma_t *dma)
 
         /* Descriptors */
         dma->ringsz = DMA_DESCR;
-        dma->descrtab = kmalloc(dma->ringsz * sizeof(serdma_descr_t), GFP_KERNEL);
+        dma->descrtab = kcalloc(dma->ringsz, sizeof(serdma_descr_t), GFP_KERNEL);
         if (!dma->descrtab) {
                 printk(KERN_ERR "cs4297a: kmalloc descrtab failed\n");
                 return -1;
         }
-        memset(dma->descrtab, 0, dma->ringsz * sizeof(serdma_descr_t));
         dma->descrtab_end = dma->descrtab + dma->ringsz;
 	/* XXX bloddy mess, use proper DMA API here ...  */
 	dma->descrtab_phys = CPHYSADDR((long)dma->descrtab);
         dma->descr_add = dma->descr_rem = dma->descrtab;
 
         /* Frame buffer area */
-        dma->dma_buf = kmalloc(DMA_BUF_SIZE, GFP_KERNEL);
+        dma->dma_buf = kzalloc(DMA_BUF_SIZE, GFP_KERNEL);
         if (!dma->dma_buf) {
                 printk(KERN_ERR "cs4297a: kmalloc dma_buf failed\n");
                 kfree(dma->descrtab);
                 return -1;
         }
-        memset(dma->dma_buf, 0, DMA_BUF_SIZE);
         dma->dma_buf_phys = CPHYSADDR((long)dma->dma_buf);
 
         /* Samples buffer area */
@@ -2618,12 +2616,11 @@ #ifndef CONFIG_BCM_CS4297A_CSWARM
         udelay(100);
 #endif
 
-	if (!(s = kmalloc(sizeof(struct cs4297a_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct cs4297a_state), GFP_KERNEL))) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR
 		      "cs4297a: probe() no memory for state struct.\n"));
 		return -1;
 	}
-	memset(s, 0, sizeof(struct cs4297a_state));
         s->magic = CS4297a_MAGIC;
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
diff --git a/sound/oss/trident.c b/sound/oss/trident.c
index 2813e4c..e81ee7a 100644
--- a/sound/oss/trident.c
+++ b/sound/oss/trident.c
@@ -2739,12 +2739,11 @@ trident_open(struct inode *inode, struct
 		}
 		for (i = 0; i < NR_HW_CH; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
+				state = card->states[i] = kzalloc(sizeof(*state), GFP_KERNEL);
 				if (state == NULL) {
 					mutex_unlock(&card->open_mutex);
 					return -ENOMEM;
 				}
-				memset(state, 0, sizeof(*state));
 				mutex_init(&state->sem);
 				dmabuf = &state->dmabuf;
 				goto found_virt;
@@ -3616,7 +3615,7 @@ ali_allocate_other_states_resources(stru
 			}
 			return -EBUSY;
 		}
-		s = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
+		s = card->states[i] = kzalloc(sizeof(*state), GFP_KERNEL);
 		if (!s) {
 			num = ali_multi_channels_5_1[state_count];
 			ali_free_pcm_channel(card, num);
@@ -3628,7 +3627,6 @@ ali_allocate_other_states_resources(stru
 			}
 			return -ENOMEM;
 		}
-		memset(s, 0, sizeof(*state));
 
 		s->dmabuf.channel = channel;
 		s->dmabuf.ossfragshift = s->dmabuf.ossmaxfrags =
@@ -4387,11 +4385,10 @@ trident_probe(struct pci_dev *pci_dev, c
 	}
 
 	rc = -ENOMEM;
-	if ((card = kmalloc(sizeof(*card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(*card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
 		goto out_release_region;
 	}
-	memset(card, 0, sizeof (*card));
 
 	init_timer(&card->timer);
 	card->iobase = iobase;
diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index 22d2662..8cbaa0a 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -1267,12 +1267,10 @@ static int __init waveartist_init(wavnc_
 	conf_printf2(dev_name, devc->hw.io_base, devc->hw.irq,
 		     devc->hw.dma, devc->hw.dma2);
 
-	portc = (wavnc_port_info *)kmalloc(sizeof(wavnc_port_info), GFP_KERNEL);
+	portc = kzalloc(sizeof(wavnc_port_info), GFP_KERNEL);
 	if (portc == NULL)
 		goto nomem;
 
-	memset(portc, 0, sizeof(wavnc_port_info));
-
 	my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION, dev_name,
 			&waveartist_audio_driver, sizeof(struct audio_driver),
 			devc->audio_flags, AFMT_U8 | AFMT_S16_LE | AFMT_S8,
diff --git a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
index 6e22472..4c0704b 100644
--- a/sound/oss/ymfpci.c
+++ b/sound/oss/ymfpci.c
@@ -1091,10 +1091,9 @@ static struct ymf_state *ymf_state_alloc
 	struct ymf_pcm *ypcm;
 	struct ymf_state *state;
 
-	if ((state = kmalloc(sizeof(struct ymf_state), GFP_KERNEL)) == NULL) {
+	if ((state = kzalloc(sizeof(struct ymf_state), GFP_KERNEL)) == NULL) {
 		goto out0;
 	}
-	memset(state, 0, sizeof(struct ymf_state));
 
 	ypcm = &state->wpcm;
 	ypcm->state = state;
@@ -2523,11 +2522,10 @@ static int __devinit ymf_probe_one(struc
 	}
 	base = pci_resource_start(pcidev, 0);
 
-	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
+	if ((codec = kzalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "ymfpci: no core\n");
 		return -ENOMEM;
 	}
-	memset(codec, 0, sizeof(*codec));
 
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 27a8dbe..a1a4d11 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -236,9 +236,8 @@ static int pcm_open(struct snd_pcm_subst
 	chip = snd_pcm_substream_chip(substream);
 	runtime = substream->runtime;
 
-	if (!(pipe = kmalloc(sizeof(struct audiopipe), GFP_KERNEL)))
+	if (!(pipe = kzalloc(sizeof(struct audiopipe), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(pipe, 0, sizeof(struct audiopipe));
 	pipe->index = -1;		/* Not configured yet */
 
 	/* Set up hw capabilities and contraints */
diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 82d791b..05dabe4 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -801,11 +801,10 @@ snd_pmac_awacs_init(struct snd_pmac *chi
 	chip->revision = (in_le32(&chip->awacs->codec_stat) >> 12) & 0xf;
 #ifdef PMAC_AMP_AVAIL
 	if (chip->revision == 3 && chip->has_iic && CHECK_CUDA_AMP()) {
-		struct awacs_amp *amp = kmalloc(sizeof(*amp), GFP_KERNEL);
+		struct awacs_amp *amp = kzalloc(sizeof(*amp), GFP_KERNEL);
 		if (! amp)
 			return -ENOMEM;
 		chip->mixer_data = amp;
-		memset(amp, 0, sizeof(*amp));
 		chip->mixer_free = awacs_amp_free;
 		awacs_amp_set_vol(amp, 0, 63, 63, 0); /* mute and zero vol */
 		awacs_amp_set_vol(amp, 1, 63, 63, 0);
diff --git a/sound/ppc/daca.c b/sound/ppc/daca.c
index 46eebf5..57202b0 100644
--- a/sound/ppc/daca.c
+++ b/sound/ppc/daca.c
@@ -258,10 +258,9 @@ #ifdef CONFIG_KMOD
 		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
-	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
+	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
 	if (! mix)
 		return -ENOMEM;
-	memset(mix, 0, sizeof(*mix));
 	chip->mixer_data = mix;
 	chip->mixer_free = daca_cleanup;
 	mix->amp_on = 1; /* default on */
diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index fb05938..59482a4 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -64,11 +64,10 @@ static int keywest_attach_adapter(struct
 	if (strncmp(i2c_device_name(adapter), "mac-io", 6))
 		return 0; /* ignored */
 
-	new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	new_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (! new_client)
 		return -ENOMEM;
 
-	memset(new_client, 0, sizeof(*new_client));
 	new_client->addr = keywest_ctx->addr;
 	i2c_set_clientdata(new_client, keywest_ctx);
 	new_client->adapter = adapter;
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 692c611..84f6b19 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -1316,10 +1316,9 @@ #ifdef CONFIG_KMOD
 		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
-	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
+	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
 	if (! mix)
 		return -ENOMEM;
-	memset(mix, 0, sizeof(*mix));
 	mix->headphone_irq = -1;
 
 	chip->mixer_data = mix;
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index d32d83d..1b7f499 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -2260,10 +2260,9 @@ static int add_audio_endpoint(struct snd
 	}
 
 	/* create a new pcm */
-	as = kmalloc(sizeof(*as), GFP_KERNEL);
+	as = kzalloc(sizeof(*as), GFP_KERNEL);
 	if (! as)
 		return -ENOMEM;
-	memset(as, 0, sizeof(*as));
 	as->pcm_index = chip->pcm_devs;
 	as->chip = chip;
 	as->fmt_type = fp->fmt_type;
@@ -2633,13 +2632,12 @@ static int parse_audio_endpoints(struct 
 			csep = NULL;
 		}
 
-		fp = kmalloc(sizeof(*fp), GFP_KERNEL);
+		fp = kzalloc(sizeof(*fp), GFP_KERNEL);
 		if (! fp) {
 			snd_printk(KERN_ERR "cannot malloc\n");
 			return -ENOMEM;
 		}
 
-		memset(fp, 0, sizeof(*fp));
 		fp->iface = iface_no;
 		fp->altsetting = altno;
 		fp->altset_idx = i;
-- 
1.4.1.gd3ba6
