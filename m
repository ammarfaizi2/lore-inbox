Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVBKH1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVBKH1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVBKH1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:27:14 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:54622 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262211AbVBKHFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 7/10] Gameport: convert sound/alsa to dynamic allocation
Date: Fri, 11 Feb 2005 02:03:14 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110202.18242.dtor_core@ameritech.net> <200502110202.48966.dtor_core@ameritech.net>
In-Reply-To: <200502110202.48966.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110203.15425.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2155, 2005-02-11 01:20:30-05:00, dtor_core@ameritech.net
  Input: convert sound/pci to dynamic gameport allocation.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 include/sound/cs46xx.h           |    4 -
 include/sound/trident.h          |    4 -
 include/sound/ymfpci.h           |   14 +--
 sound/pci/als4000.c              |  111 +++++++++++++++++++----------
 sound/pci/au88x0/au88x0.c        |    7 -
 sound/pci/au88x0/au88x0.h        |    2 
 sound/pci/au88x0/au88x0_game.c   |   49 ++++++------
 sound/pci/azt3328.c              |  111 +++++++++++++++++------------
 sound/pci/cmipci.c               |  104 ++++++++++++++++++---------
 sound/pci/cs4281.c               |   91 ++++++++++++-----------
 sound/pci/cs46xx/cs46xx_lib.c    |   81 ++++++++++-----------
 sound/pci/ens1370.c              |  122 +++++++++++++++++++++----------
 sound/pci/es1938.c               |   52 ++++++++++---
 sound/pci/es1968.c               |   76 ++++++++++++++-----
 sound/pci/sonicvibes.c           |   55 +++++++++++---
 sound/pci/trident/trident.c      |    2 
 sound/pci/trident/trident_main.c |   87 ++++++++++------------
 sound/pci/via82xx.c              |   89 +++++++++++++++++------
 sound/pci/ymfpci/ymfpci.c        |  149 ++++++++++++++++++++++++---------------
 sound/pci/ymfpci/ymfpci_main.c   |    9 --
 20 files changed, 761 insertions(+), 458 deletions(-)


===================================================================



diff -Nru a/include/sound/cs46xx.h b/include/sound/cs46xx.h
--- a/include/sound/cs46xx.h	2005-02-11 01:39:33 -05:00
+++ b/include/sound/cs46xx.h	2005-02-11 01:39:33 -05:00
@@ -1720,7 +1720,7 @@
 	snd_kcontrol_t *eapd_switch; /* for amplifier hack */
 	int accept_valid;	/* accept mmap valid (for OSS) */
 
-	struct snd_cs46xx_gameport *gameport;
+	struct gameport *gameport;
 
 #ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
 	int current_gpio;
@@ -1751,6 +1751,6 @@
 int snd_cs46xx_mixer(cs46xx_t *chip);
 int snd_cs46xx_midi(cs46xx_t *chip, int device, snd_rawmidi_t **rmidi);
 int snd_cs46xx_start_dsp(cs46xx_t *chip);
-void snd_cs46xx_gameport(cs46xx_t *chip);
+int snd_cs46xx_gameport(cs46xx_t *chip);
 
 #endif /* __SOUND_CS46XX_H */
diff -Nru a/include/sound/trident.h b/include/sound/trident.h
--- a/include/sound/trident.h	2005-02-11 01:39:33 -05:00
+++ b/include/sound/trident.h	2005-02-11 01:39:33 -05:00
@@ -448,7 +448,7 @@
 
 	spinlock_t reg_lock;
 
-	struct snd_trident_gameport *gameport;
+	struct gameport *gameport;
 };
 
 int snd_trident_create(snd_card_t * card,
@@ -457,7 +457,7 @@
 		       int pcm_spdif_device,
 		       int max_wavetable_size,
 		       trident_t ** rtrident);
-void snd_trident_gameport(trident_t *trident);
+int snd_trident_create_gameport(trident_t *trident);
 
 int snd_trident_pcm(trident_t * trident, int device, snd_pcm_t **rpcm);
 int snd_trident_foldback_pcm(trident_t * trident, int device, snd_pcm_t **rpcm);
diff -Nru a/include/sound/ymfpci.h b/include/sound/ymfpci.h
--- a/include/sound/ymfpci.h	2005-02-11 01:39:33 -05:00
+++ b/include/sound/ymfpci.h	2005-02-11 01:39:33 -05:00
@@ -198,6 +198,10 @@
 #define YMFPCI_LEGACY2_IMOD	(1 << 15)	/* legacy IRQ mode */
 /* SIEN:IMOD 0:0 = legacy irq, 0:1 = INTA, 1:0 = serialized IRQ */
 
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+#define SUPPORT_JOYSTICK
+#endif
+
 /*
  *
  */
@@ -311,9 +315,8 @@
 	struct resource *mpu_res;
 
 	unsigned short old_legacy_ctrl;
-#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
-	struct resource *joystick_res;
-	struct gameport gameport;
+#ifdef SUPPORT_JOYSTICK
+	struct gameport *gameport;
 #endif
 
 	struct snd_dma_buffer work_ptr;
@@ -381,6 +384,7 @@
 		      struct pci_dev *pci,
 		      unsigned short old_legacy_ctrl,
 		      ymfpci_t ** rcodec);
+void snd_ymfpci_free_gameport(ymfpci_t *chip);
 
 int snd_ymfpci_pcm(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_pcm2(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
@@ -388,9 +392,5 @@
 int snd_ymfpci_pcm_4ch(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch);
 int snd_ymfpci_timer(ymfpci_t *chip, int device);
-
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-#define SUPPORT_JOYSTICK
-#endif
 
 #endif /* __SOUND_YMFPCI_H */
diff -Nru a/sound/pci/als4000.c b/sound/pci/als4000.c
--- a/sound/pci/als4000.c	2005-02-11 01:39:34 -05:00
+++ b/sound/pci/als4000.c	2005-02-11 01:39:34 -05:00
@@ -104,8 +104,7 @@
 	struct pci_dev *pci;
 	unsigned long gcr;
 #ifdef SUPPORT_JOYSTICK
-	struct gameport gameport;
-	struct resource *res_joystick;
+	struct gameport *gameport;
 #endif
 } snd_card_als4000_t;
 
@@ -566,21 +565,80 @@
 	spin_unlock_irq(&chip->reg_lock);
 }
 
+#ifdef SUPPORT_JOYSTICK
+static int __devinit snd_als4000_create_gameport(snd_card_als4000_t *acard, int dev)
+{
+	struct gameport *gp;
+	struct resource *r;
+	int io_port;
+
+	if (joystick_port[dev] == 0)
+		return -ENODEV;
+
+	if (joystick_port[dev] == 1) { /* auto-detect */
+		for (io_port = 0x200; io_port <= 0x218; io_port += 8) {
+			r = request_region(io_port, 8, "ALS4000 gameport");
+			if (r)
+				break;
+		}
+	} else {
+		io_port = joystick_port[dev];
+		r = request_region(io_port, 8, "ALS4000 gameport");
+	}
+
+	if (!r) {
+		printk(KERN_WARNING "als4000: cannot reserve joystick ports\n");
+		return -EBUSY;
+	}
+
+	acard->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "als4000: cannot allocate memory for gameport\n");
+		release_resource(r);
+		kfree_nocheck(r);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "ALS4000 Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(acard->pci));
+	gp->dev.parent = &acard->pci->dev;
+	gp->io = io_port;
+	gp->port_data = r;
+
+	/* Enable legacy joystick port */
+	snd_als4000_set_addr(acard->gcr, 0, 0, 0, 1);
+
+	gameport_register_port(acard->gameport);
+
+	return 0;
+}
+
+static void snd_als4000_free_gameport(snd_card_als4000_t *acard)
+{
+	if (acard->gameport) {
+		struct resource *r = acard->gameport->port_data;
+
+		gameport_unregister_port(acard->gameport);
+		acard->gameport = NULL;
+
+		snd_als4000_set_addr(acard->gcr, 0, 0, 0, 0); /* disable joystick */
+		release_resource(r);
+		kfree_nocheck(r);
+	}
+}
+#else
+static inline int snd_als4000_create_gameport(snd_card_als4000_t *acard, int dev) { return -ENOSYS; }
+static inline void snd_als4000_free_gameport(snd_card_als4000_t *acard) { }
+#endif
+
 static void snd_card_als4000_free( snd_card_t *card )
 {
 	snd_card_als4000_t * acard = (snd_card_als4000_t *)card->private_data;
+
 	/* make sure that interrupts are disabled */
 	snd_als4000_gcr_write_addr( acard->gcr, 0x8c, 0);
 	/* free resources */
-#ifdef SUPPORT_JOYSTICK
-	if (acard->res_joystick) {
-		if (acard->gameport.io)
-			gameport_unregister_port(&acard->gameport);
-		snd_als4000_set_addr(acard->gcr, 0, 0, 0, 0); /* disable joystick */
-		release_resource(acard->res_joystick);
-		kfree_nocheck(acard->res_joystick);
-	}
-#endif
+	snd_als4000_free_gameport(acard);
 	pci_release_regions(acard->pci);
 	pci_disable_device(acard->pci);
 }
@@ -596,7 +654,6 @@
 	opl3_t *opl3;
 	unsigned short word;
 	int err;
-	int joystick = 0;
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
@@ -640,26 +697,9 @@
 	acard->gcr = gcr;
 	card->private_free = snd_card_als4000_free;
 
-	/* disable all legacy ISA stuff except for joystick */
-#ifdef SUPPORT_JOYSTICK
-	if (joystick_port[dev] == 1) {
-		/* auto-detect */
-		long p;
-		for (p = 0x200; p <= 0x218; p += 8) {
-			if ((acard->res_joystick = request_region(p, 8, "ALS4000 gameport")) != NULL) {
-				joystick_port[dev] = p;
-				break;
-			}
-		}
-	} else if (joystick_port[dev] > 0)
-		acard->res_joystick = request_region(joystick_port[dev], 8, "ALS4000 gameport");
-	if (acard->res_joystick)
-		joystick = joystick_port[dev];
-	else
-		joystick = 0;
-#endif
-	snd_als4000_set_addr(gcr, 0, 0, 0, joystick);
-	
+	/* disable all legacy ISA stuff */
+	snd_als4000_set_addr(acard->gcr, 0, 0, 0, 0);
+
 	if ((err = snd_sbdsp_create(card,
 				    gcr + 0x10,
 				    pci->irq,
@@ -711,12 +751,7 @@
 		}
 	}
 
-#ifdef SUPPORT_JOYSTICK
-	if (acard->res_joystick) {
-		acard->gameport.io = joystick;
-		gameport_register_port(&acard->gameport);
-	}
-#endif
+	snd_als4000_create_gameport(acard, dev);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
diff -Nru a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
--- a/sound/pci/au88x0/au88x0.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/au88x0/au88x0.c	2005-02-11 01:39:33 -05:00
@@ -290,10 +290,9 @@
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = vortex_gameport_register(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+
+	vortex_gameport_register(chip);
+
 #if 0
 	if (snd_seq_device_new(card, 1, SNDRV_SEQ_DEV_ID_VORTEX_SYNTH,
 			       sizeof(snd_vortex_synth_arg_t), &wave) < 0
diff -Nru a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
--- a/sound/pci/au88x0/au88x0.h	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/au88x0/au88x0.h	2005-02-11 01:39:33 -05:00
@@ -272,7 +272,7 @@
 
 /* Driver stuff. */
 static int __devinit vortex_gameport_register(vortex_t * card);
-static int __devexit vortex_gameport_unregister(vortex_t * card);
+static void vortex_gameport_unregister(vortex_t * card);
 #ifndef CHIP_AU8820
 static int __devinit vortex_eq_init(vortex_t * vortex);
 static int __devexit vortex_eq_free(vortex_t * vortex);
diff -Nru a/sound/pci/au88x0/au88x0_game.c b/sound/pci/au88x0/au88x0_game.c
--- a/sound/pci/au88x0/au88x0_game.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/au88x0/au88x0_game.c	2005-02-11 01:39:33 -05:00
@@ -94,39 +94,42 @@
 	return 0;
 }
 
-static int vortex_gameport_register(vortex_t * vortex)
+static int __devinit vortex_gameport_register(vortex_t * vortex)
 {
-	if ((vortex->gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL)) == NULL)
-		return -1;
+	struct gameport *gp;
 
-	vortex->gameport->port_data = vortex;
-	vortex->gameport->fuzz = 64;
+	vortex->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "vortex: cannot allocate memory for gameport\n");
+		return -ENOMEM;
+	};
+
+	gameport_set_name(gp, "AU88x0 Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(vortex->pci_dev));
+	gp->dev.parent = &vortex->pci_dev->dev;
+
+	gp->read = vortex_game_read;
+	gp->trigger = vortex_game_trigger;
+	gp->cooked_read = vortex_game_cooked_read;
+	gp->open = vortex_game_open;
+
+	gp->port_data = vortex;
+	gp->fuzz = 64;
+
+	gameport_register_port(gp);
 
-	vortex->gameport->read = vortex_game_read;
-	vortex->gameport->trigger = vortex_game_trigger;
-	vortex->gameport->cooked_read = vortex_game_cooked_read;
-	vortex->gameport->open = vortex_game_open;
-
-	gameport_register_port((struct gameport *)vortex->gameport);
-
-/*	printk(KERN_INFO "gameport%d: %s at speed %d kHz\n",
-		vortex->gameport->number, vortex->pci_dev->name, vortex->gameport->speed);
-*/
 	return 0;
 }
 
-static int vortex_gameport_unregister(vortex_t * vortex)
+static void vortex_gameport_unregister(vortex_t * vortex)
 {
-	if (vortex->gameport != NULL) {
+	if (vortex->gameport) {
 		gameport_unregister_port(vortex->gameport);
-		kfree(vortex->gameport);
+		vortex->gameport = NULL;
 	}
-	return 0;
 }
 
 #else
-
-static inline int vortex_gameport_register(vortex_t * vortex) { return 0; }
-static inline int vortex_gameport_unregister(vortex_t * vortex) { return 0; }
-
+static inline int vortex_gameport_register(vortex_t * vortex) { return -ENOSYS; }
+static inline void vortex_gameport_unregister(vortex_t * vortex) { }
 #endif
diff -Nru a/sound/pci/azt3328.c b/sound/pci/azt3328.c
--- a/sound/pci/azt3328.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/azt3328.c	2005-02-11 01:39:33 -05:00
@@ -160,19 +160,19 @@
 #endif
 	    
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
-#ifdef SUPPORT_JOYSTICK
-static int joystick[SNDRV_CARDS];
-#endif
-
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for AZF3328 soundcard.");
+
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for AZF3328 soundcard.");
+
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable AZF3328 soundcard.");
+
 #ifdef SUPPORT_JOYSTICK
+static int joystick[SNDRV_CARDS];
 module_param_array(joystick, bool, NULL, 0444);
 MODULE_PARM_DESC(joystick, "Enable joystick for AZF3328 soundcard.");
 #endif
@@ -189,8 +189,7 @@
 	unsigned long mixer_port;
 
 #ifdef SUPPORT_JOYSTICK
-	struct gameport gameport;
-	struct resource *res_joystick;
+	struct gameport *gameport;
 #endif
 
 	struct pci_dev *pci;
@@ -1222,6 +1221,63 @@
 
 /******************************************************************/
 
+#ifdef SUPPORT_JOYSTICK
+static int __devinit snd_azf3328_config_joystick(azf3328_t *chip, int dev)
+{
+	struct gameport *gp;
+	struct resource *r;
+
+	if (!joystick[dev])
+		return -ENODEV;
+
+	if (!(r = request_region(0x200, 8, "AZF3328 gameport"))) {
+		printk(KERN_WARNING "azt3328: cannot reserve joystick ports\n");
+		return -EBUSY;
+	}
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "azt3328: cannot allocate memory for gameport\n");
+		release_resource(r);
+		kfree_nocheck(r);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "AZF3328 Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->io = 0x200;
+	gp->port_data = r;
+
+	snd_azf3328_io2_write(chip, IDX_IO2_LEGACY_ADDR,
+			      snd_azf3328_io2_read(chip, IDX_IO2_LEGACY_ADDR) | LEGACY_JOY);
+
+	gameport_register_port(chip->gameport);
+
+	return 0;
+}
+
+static void snd_azf3328_free_joystick(azf3328_t *chip)
+{
+	if (chip->gameport) {
+		struct resource *r = chip->gameport->port_data;
+
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+		/* disable gameport */
+		snd_azf3328_io2_write(chip, IDX_IO2_LEGACY_ADDR,
+				      snd_azf3328_io2_read(chip, IDX_IO2_LEGACY_ADDR) & ~LEGACY_JOY);
+		release_resource(r);
+		kfree_nocheck(r);
+	}
+}
+#else
+static inline int snd_azf3328_config_joystick(azf3328_t *chip, int dev) { return -ENOSYS; }
+static inline void snd_azf3328_free_joystick(azf3328_t *chip) { }
+#endif
+
+/******************************************************************/
+
 static int snd_azf3328_free(azf3328_t *chip)
 {
         if (chip->irq < 0)
@@ -1236,16 +1292,7 @@
 
         synchronize_irq(chip->irq);
       __end_hw:
-#ifdef SUPPORT_JOYSTICK
-	if (chip->res_joystick) {
-		gameport_unregister_port(&chip->gameport);
-		/* disable gameport */
-		snd_azf3328_io2_write(chip, IDX_IO2_LEGACY_ADDR,
-				      snd_azf3328_io2_read(chip, IDX_IO2_LEGACY_ADDR) & ~LEGACY_JOY);
-		release_resource(chip->res_joystick);
-		kfree_nocheck(chip->res_joystick);
-	}
-#endif
+	snd_azf3328_free_joystick(chip);
         if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
 	pci_release_regions(chip->pci);
@@ -1373,28 +1420,6 @@
 	return 0;
 }
 
-#ifdef SUPPORT_JOYSTICK
-static void __devinit snd_azf3328_config_joystick(azf3328_t *chip, int joystick)
-{
-	unsigned char val;
-
-	if (joystick == 1) {
-		if ((chip->res_joystick = request_region(0x200, 8, "AZF3328 gameport")) != NULL)
-			chip->gameport.io = 0x200;
-	}
-
-	val = inb(chip->io2_port + IDX_IO2_LEGACY_ADDR);
-	if (chip->res_joystick)
-		val |= LEGACY_JOY;
-	else
-		val &= ~LEGACY_JOY;
-
-	outb(val, chip->io2_port + IDX_IO2_LEGACY_ADDR);
-	if (chip->res_joystick)
-		gameport_register_port(&chip->gameport);
-}
-#endif
-
 static int __devinit snd_azf3328_probe(struct pci_dev *pci,
 					  const struct pci_device_id *pci_id)
 {
@@ -1465,9 +1490,9 @@
 "azt3328: Feel free to contact hw7oshyuv3001@sneakemail.com for bug reports etc.!\n");
 #endif
 
-#ifdef SUPPORT_JOYSTICK
-	snd_azf3328_config_joystick(chip, joystick[dev]);
-#endif
+	if (snd_azf3328_config_joystick(chip, dev) < 0)
+		snd_azf3328_io2_write(chip, IDX_IO2_LEGACY_ADDR,
+			      snd_azf3328_io2_read(chip, IDX_IO2_LEGACY_ADDR) & ~LEGACY_JOY);
 
 	pci_set_drvdata(pci, card);
 	dev++;
diff -Nru a/sound/pci/cmipci.c b/sound/pci/cmipci.c
--- a/sound/pci/cmipci.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/cmipci.c	2005-02-11 01:39:33 -05:00
@@ -471,8 +471,7 @@
 	snd_rawmidi_t *rmidi;
 
 #ifdef SUPPORT_JOYSTICK
-	struct gameport gameport;
-	struct resource *res_joystick;
+	struct gameport *gameport;
 #endif
 
 	spinlock_t reg_lock;
@@ -2522,6 +2521,71 @@
 		strcpy(cm->card->driver + strlen(cm->card->driver), "-SWIEC");
 }
 
+#ifdef SUPPORT_JOYSTICK
+static int __devinit snd_cmipci_create_gameport(cmipci_t *cm, int dev)
+{
+	static int ports[] = { 0x201, 0x200, 0 }; /* FIXME: majority is 0x201? */
+	struct gameport *gp;
+	struct resource *r = NULL;
+	int i, io_port = 0;
+
+	if (joystick_port[dev] == 0)
+		return -ENODEV;
+
+	if (joystick_port[dev] == 1) { /* auto-detect */
+		for (i = 0; ports[i]; i++) {
+			io_port = ports[i];
+			r = request_region(io_port, 1, "CMIPCI gameport");
+			if (r)
+				break;
+		}
+	} else {
+		io_port = joystick_port[dev];
+		r = request_region(io_port, 1, "CMIPCI gameport");
+	}
+
+	if (!r) {
+		printk(KERN_WARNING "cmipci: cannot reserve joystick ports\n");
+		return -EBUSY;
+	}
+
+	cm->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "cmipci: cannot allocate memory for gameport\n");
+		release_resource(r);
+		kfree_nocheck(r);
+		return -ENOMEM;
+	}
+	gameport_set_name(gp, "C-Media Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(cm->pci));
+	gp->dev.parent = &cm->pci->dev;
+	gp->io = io_port;
+	gp->port_data = r;
+
+	snd_cmipci_set_bit(cm, CM_REG_FUNCTRL1, CM_JYSTK_EN);
+
+	gameport_register_port(cm->gameport);
+
+	return 0;
+}
+
+static void snd_cmipci_free_gameport(cmipci_t *cm)
+{
+	if (cm->gameport) {
+		struct resource *r = cm->gameport->port_data;
+
+		gameport_unregister_port(cm->gameport);
+		cm->gameport = NULL;
+
+		snd_cmipci_clear_bit(cm, CM_REG_FUNCTRL1, CM_JYSTK_EN);
+		release_resource(r);
+		kfree_nocheck(r);
+	}
+}
+#else
+static inline int snd_cmipci_create_gameport(cmipci_t *cm, int dev) { return -ENOSYS; }
+static inline void snd_cmipci_free_gameport(cmipci_t *cm) { }
+#endif
 
 static int snd_cmipci_free(cmipci_t *cm)
 {
@@ -2541,14 +2605,8 @@
 
 		free_irq(cm->irq, (void *)cm);
 	}
-#ifdef SUPPORT_JOYSTICK
-	if (cm->res_joystick) {
-		gameport_unregister_port(&cm->gameport);
-		snd_cmipci_clear_bit(cm, CM_REG_FUNCTRL1, CM_JYSTK_EN);
-		release_resource(cm->res_joystick);
-		kfree_nocheck(cm->res_joystick);
-	}
-#endif
+
+	snd_cmipci_free_gameport(cm);
 	pci_release_regions(cm->pci);
 	pci_disable_device(cm->pci);
 	kfree(cm);
@@ -2757,31 +2815,9 @@
 	snd_cmipci_set_bit(cm, CM_REG_MISC_CTRL, CM_SPDIF48K|CM_SPDF_AC97);
 #endif /* USE_VAR48KRATE */
 
-#ifdef SUPPORT_JOYSTICK
-	if (joystick_port[dev] > 0) {
-		if (joystick_port[dev] == 1) { /* auto-detect */
-			static int ports[] = { 0x201, 0x200, 0 }; /* FIXME: majority is 0x201? */
-			int i;
-			for (i = 0; ports[i]; i++) {
-				joystick_port[dev] = ports[i];
-				cm->res_joystick = request_region(ports[i], 1, "CMIPCI gameport");
-				if (cm->res_joystick)
-					break;
-			}
-		} else {
-			cm->res_joystick = request_region(joystick_port[dev], 1, "CMIPCI gameport");
-		}
-	}
-	if (cm->res_joystick) {
-		cm->gameport.io = joystick_port[dev];
-		snd_cmipci_set_bit(cm, CM_REG_FUNCTRL1, CM_JYSTK_EN);
-		gameport_register_port(&cm->gameport);
-	} else {
-		if (joystick_port[dev] > 0)
-			printk(KERN_WARNING "cmipci: cannot reserve joystick ports\n");
+	if (snd_cmipci_create_gameport(cm, dev) < 0)
 		snd_cmipci_clear_bit(cm, CM_REG_FUNCTRL1, CM_JYSTK_EN);
-	}
-#endif
+
 	snd_card_set_dev(card, &pci->dev);
 
 	*rcmipci = cm;
diff -Nru a/sound/pci/cs4281.c b/sound/pci/cs4281.c
--- a/sound/pci/cs4281.c	2005-02-11 01:39:34 -05:00
+++ b/sound/pci/cs4281.c	2005-02-11 01:39:34 -05:00
@@ -495,7 +495,7 @@
 	unsigned int midcr;
 	unsigned int uartm;
 
-	struct snd_cs4281_gameport *gameport;
+	struct gameport *gameport;
 
 #ifdef CONFIG_PM
 	u32 suspend_regs[SUSPEND_REGISTERS];
@@ -1238,38 +1238,29 @@
 
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 
-typedef struct snd_cs4281_gameport {
-	struct gameport info;
-	cs4281_t *chip;
-} cs4281_gameport_t;
-
 static void snd_cs4281_gameport_trigger(struct gameport *gameport)
 {
-	cs4281_gameport_t *gp = (cs4281_gameport_t *)gameport;
-	cs4281_t *chip;
-	snd_assert(gp, return);
-	chip = gp->chip;
+	cs4281_t *chip = gameport->port_data;
+
+	snd_assert(chip, return);
 	snd_cs4281_pokeBA0(chip, BA0_JSPT, 0xff);
 }
 
 static unsigned char snd_cs4281_gameport_read(struct gameport *gameport)
 {
-	cs4281_gameport_t *gp = (cs4281_gameport_t *)gameport;
-	cs4281_t *chip;
-	snd_assert(gp, return 0);
-	chip = gp->chip;
+	cs4281_t *chip = gameport->port_data;
+
+	snd_assert(chip, return 0);
 	return snd_cs4281_peekBA0(chip, BA0_JSPT);
 }
 
 #ifdef COOKED_MODE
 static int snd_cs4281_gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	cs4281_gameport_t *gp = (cs4281_gameport_t *)gameport;
-	cs4281_t *chip;
+	cs4281_t *chip = gameport->port_data;
 	unsigned js1, js2, jst;
 	
-	snd_assert(gp, return 0);
-	chip = gp->chip;
+	snd_assert(chip, return 0);
 
 	js1 = snd_cs4281_peekBA0(chip, BA0_JSC1);
 	js2 = snd_cs4281_peekBA0(chip, BA0_JSC2);
@@ -1282,10 +1273,12 @@
 	axes[2] = ((js2 & JSC2_Y2V_MASK) >> JSC2_Y2V_SHIFT) & 0xFFFF;
 	axes[3] = ((js2 & JSC2_X2V_MASK) >> JSC2_X2V_SHIFT) & 0xFFFF;
 
-	for(jst=0;jst<4;++jst)
-		if(axes[jst]==0xFFFF) axes[jst] = -1;
+	for (jst = 0; jst < 4; ++jst)
+		if (axes[jst] == 0xFFFF) axes[jst] = -1;
 	return 0;
 }
+#else
+#define snd_cs4281_gameport_cooked_read	NULL
 #endif
 
 static int snd_cs4281_gameport_open(struct gameport *gameport, int mode)
@@ -1303,31 +1296,43 @@
 	return 0;
 }
 
-static void __devinit snd_cs4281_gameport(cs4281_t *chip)
+static int __devinit snd_cs4281_create_gameport(cs4281_t *chip)
 {
-	cs4281_gameport_t *gp;
-	gp = kmalloc(sizeof(*gp), GFP_KERNEL);
-	if (! gp) {
-		snd_printk(KERN_ERR "cannot allocate gameport area\n");
-		return;
-	}
-	memset(gp, 0, sizeof(*gp));
-	gp->info.open = snd_cs4281_gameport_open;
-	gp->info.read = snd_cs4281_gameport_read;
-	gp->info.trigger = snd_cs4281_gameport_trigger;
-#ifdef COOKED_MODE
-	gp->info.cooked_read = snd_cs4281_gameport_cooked_read;
-#endif
-	gp->chip = chip;
-	chip->gameport = gp;
+	struct gameport *gp;
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "cs4281: cannot allocate memory for gameport\n");
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "CS4281 Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->open = snd_cs4281_gameport_open;
+	gp->read = snd_cs4281_gameport_read;
+	gp->trigger = snd_cs4281_gameport_trigger;
+	gp->cooked_read = snd_cs4281_gameport_cooked_read;
+	gp->port_data = chip;
 
 	snd_cs4281_pokeBA0(chip, BA0_JSIO, 0xFF); // ?
 	snd_cs4281_pokeBA0(chip, BA0_JSCTL, JSCTL_SP_MEDIUM_SLOW);
-	gameport_register_port(&gp->info);
+
+	gameport_register_port(gp);
+
+	return 0;
 }
 
+static void snd_cs4281_free_gameport(cs4281_t *chip)
+{
+	if (chip->gameport) {
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+	}
+}
 #else
-#define snd_cs4281_gameport(chip) /*NOP*/
+static inline int snd_cs4281_gameport(cs4281_t *chip) { return -ENOSYS; }
+static inline void snd_cs4281_gameport_free(cs4281_t *chip) { }
 #endif /* CONFIG_GAMEPORT || (MODULE && CONFIG_GAMEPORT_MODULE) */
 
 
@@ -1337,12 +1342,8 @@
 
 static int snd_cs4281_free(cs4281_t *chip)
 {
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if (chip->gameport) {
-		gameport_unregister_port(&chip->gameport->info);
-		kfree(chip->gameport);
-	}
-#endif
+	snd_cs4281_free_gameport(chip);
+
 	if (chip->irq >= 0)
 		synchronize_irq(chip->irq);
 
@@ -1990,7 +1991,7 @@
 		snd_card_free(card);
 		return err;
 	}
-	snd_cs4281_gameport(chip);
+	snd_cs4281_create_gameport(chip);
 	strcpy(card->driver, "CS4281");
 	strcpy(card->shortname, "Cirrus Logic CS4281");
 	sprintf(card->longname, "%s at 0x%lx, irq %d",
diff -Nru a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/cs46xx/cs46xx_lib.c	2005-02-11 01:39:33 -05:00
@@ -2690,37 +2690,28 @@
 
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 
-typedef struct snd_cs46xx_gameport {
-	struct gameport info;
-	cs46xx_t *chip;
-} cs46xx_gameport_t;
-
 static void snd_cs46xx_gameport_trigger(struct gameport *gameport)
 {
-	cs46xx_gameport_t *gp = (cs46xx_gameport_t *)gameport;
-	cs46xx_t *chip;
-	snd_assert(gp, return);
-	chip = gp->chip;
+	cs46xx_t *chip = gameport->port_data;
+
+	snd_assert(chip, return);
 	snd_cs46xx_pokeBA0(chip, BA0_JSPT, 0xFF);  //outb(gameport->io, 0xFF);
 }
 
 static unsigned char snd_cs46xx_gameport_read(struct gameport *gameport)
 {
-	cs46xx_gameport_t *gp = (cs46xx_gameport_t *)gameport;
-	cs46xx_t *chip;
-	snd_assert(gp, return 0);
-	chip = gp->chip;
+	cs46xx_t *chip = gameport->port_data;
+
+	snd_assert(chip, return 0);
 	return snd_cs46xx_peekBA0(chip, BA0_JSPT); //inb(gameport->io);
 }
 
 static int snd_cs46xx_gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	cs46xx_gameport_t *gp = (cs46xx_gameport_t *)gameport;
-	cs46xx_t *chip;
+	cs46xx_t *chip = gameport->port_data;
 	unsigned js1, js2, jst;
-	
-	snd_assert(gp, return 0);
-	chip = gp->chip;
+
+	snd_assert(chip, return 0);
 
 	js1 = snd_cs46xx_peekBA0(chip, BA0_JSC1);
 	js2 = snd_cs46xx_peekBA0(chip, BA0_JSC2);
@@ -2751,33 +2742,44 @@
 	return 0;
 }
 
-void __devinit snd_cs46xx_gameport(cs46xx_t *chip)
+int __devinit snd_cs46xx_gameport(cs46xx_t *chip)
 {
-	cs46xx_gameport_t *gp;
-	gp = kmalloc(sizeof(*gp), GFP_KERNEL);
-	if (! gp) {
-		snd_printk("cannot allocate gameport area\n");
-		return;
+	struct gameport *gp;
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "cs46xx: cannot allocate memory for gameport\n");
+		return -ENOMEM;
 	}
-	memset(gp, 0, sizeof(*gp));
-	gp->info.open = snd_cs46xx_gameport_open;
-	gp->info.read = snd_cs46xx_gameport_read;
-	gp->info.trigger = snd_cs46xx_gameport_trigger;
-	gp->info.cooked_read = snd_cs46xx_gameport_cooked_read;
-	gp->chip = chip;
-	chip->gameport = gp;
+
+	gameport_set_name(gp, "CS46xx Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->port_data = chip;
+
+	gp->open = snd_cs46xx_gameport_open;
+	gp->read = snd_cs46xx_gameport_read;
+	gp->trigger = snd_cs46xx_gameport_trigger;
+	gp->cooked_read = snd_cs46xx_gameport_cooked_read;
 
 	snd_cs46xx_pokeBA0(chip, BA0_JSIO, 0xFF); // ?
 	snd_cs46xx_pokeBA0(chip, BA0_JSCTL, JSCTL_SP_MEDIUM_SLOW);
-	gameport_register_port(&gp->info);
-}
 
-#else
+	gameport_register_port(gp);
 
-void __devinit snd_cs46xx_gameport(cs46xx_t *chip)
-{
+	return 0;
 }
 
+static inline void snd_cs46xx_remove_gameport(cs46xx_t *chip)
+{
+	if (chip->gameport) {
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+	}
+}
+#else
+int __devinit snd_cs46xx_gameport(cs46xx_t *chip) { return -ENOSYS; }
+static inline void snd_cs46xx_remove_gameport(cs46xx_t *chip) { }
 #endif /* CONFIG_GAMEPORT */
 
 /*
@@ -2893,12 +2895,7 @@
 	if (chip->active_ctrl)
 		chip->active_ctrl(chip, 1);
 
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if (chip->gameport) {
-		gameport_unregister_port(&chip->gameport->info);
-		kfree(chip->gameport);
-	}
-#endif
+	snd_cs46xx_remove_gameport(chip);
 
 	if (chip->amplifier_ctrl)
 		chip->amplifier_ctrl(chip, -chip->amplifier); /* force to off */
diff -Nru a/sound/pci/ens1370.c b/sound/pci/ens1370.c
--- a/sound/pci/ens1370.c	2005-02-11 01:39:34 -05:00
+++ b/sound/pci/ens1370.c	2005-02-11 01:39:34 -05:00
@@ -430,7 +430,7 @@
 #endif
 
 #ifdef SUPPORT_JOYSTICK
-	struct gameport gameport;
+	struct gameport *gameport;
 #endif
 };
 
@@ -1734,43 +1734,99 @@
 #endif /* CHIP1370 */
 
 #ifdef SUPPORT_JOYSTICK
-static int snd_ensoniq_joystick(ensoniq_t *ensoniq, long port)
-{
+
 #ifdef CHIP1371
-	if (port == 1) { /* auto-detect */
-		for (port = 0x200; port <= 0x218; port += 8)
-			if (request_region(port, 8, "ens137x: gameport"))
+static int __devinit snd_ensoniq_get_joystick_port(int dev)
+{
+	switch (joystick_port[dev]) {
+	case 0: /* disabled */
+	case 1: /* auto-detect */
+	case 0x200:
+	case 0x208:
+	case 0x210:
+	case 0x218:
+		return joystick_port[dev];
+
+	default:
+		printk(KERN_ERR "ens1371: invalid joystick port %#x", joystick_port[dev]);
+		return 0;
+	}
+}
+#else
+static inline int snd_ensoniq_get_joystick_port(int dev)
+{
+	return joystick[dev] ? 0x200 : 0;
+}
+#endif
+
+static int __devinit snd_ensoniq_create_gameport(ensoniq_t *ensoniq, int dev)
+{
+	struct gameport *gp;
+	int io_port;
+
+	io_port = snd_ensoniq_get_joystick_port(dev);
+
+	switch (io_port) {
+	case 0:
+		return -ENOSYS;
+
+	case 1: /* auto_detect */
+		for (io_port = 0x200; io_port <= 0x218; io_port += 8)
+			if (request_region(io_port, 8, "ens137x: gameport"))
 				break;
-		if (port > 0x218) {
-			snd_printk("no gameport available\n");
+		if (io_port > 0x218) {
+			printk(KERN_WARNING "ens137x: no gameport ports available\n");
 			return -EBUSY;
 		}
-	} else
-#endif
-	{
-		if (!request_region(port, 8, "ens137x: gameport")) {
-			snd_printk("gameport io port 0x%03x in use", ensoniq->gameport.io);
+		break;
+
+	default:
+		if (!request_region(io_port, 8, "ens137x: gameport")) {
+			printk(KERN_WARNING "ens137x: gameport io port 0x%#x in use\n", io_port);
 			return -EBUSY;
 		}
+		break;
 	}
-	ensoniq->gameport.io = port;
+
+	ensoniq->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "ens137x: cannot allocate memory for gameport\n");
+		release_region(io_port, 8);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "ES137x");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(ensoniq->pci));
+	gp->dev.parent = &ensoniq->pci->dev;
+	gp->io = io_port;
+
 	ensoniq->ctrl |= ES_JYSTK_EN;
 #ifdef CHIP1371
 	ensoniq->ctrl &= ~ES_1371_JOY_ASELM;
-	ensoniq->ctrl |= ES_1371_JOY_ASEL((ensoniq->gameport.io - 0x200) / 8);
+	ensoniq->ctrl |= ES_1371_JOY_ASEL((io_port - 0x200) / 8);
 #endif
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	gameport_register_port(&ensoniq->gameport);
+
+	gameport_register_port(ensoniq->gameport);
+
 	return 0;
 }
 
-static void snd_ensoniq_joystick_free(ensoniq_t *ensoniq)
+static void snd_ensoniq_free_gameport(ensoniq_t *ensoniq)
 {
-	gameport_unregister_port(&ensoniq->gameport);
-	ensoniq->ctrl &= ~ES_JYSTK_EN;
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	release_region(ensoniq->gameport.io, 8);
+	if (ensoniq->gameport) {
+		int port = ensoniq->gameport->io;
+
+		gameport_unregister_port(ensoniq->gameport);
+		ensoniq->gameport = NULL;
+		ensoniq->ctrl &= ~ES_JYSTK_EN;
+		outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+		release_region(port, 8);
+	}
 }
+#else
+static inline int snd_ensoniq_create_gameport(ensoniq_t *ensoniq, long port) { return -ENOSYS; }
+static inline void snd_ensoniq_free_gameport(ensoniq_t *ensoniq) { }
 #endif /* SUPPORT_JOYSTICK */
 
 /*
@@ -1810,10 +1866,7 @@
 
 static int snd_ensoniq_free(ensoniq_t *ensoniq)
 {
-#ifdef SUPPORT_JOYSTICK
-	if (ensoniq->ctrl & ES_JYSTK_EN)
-		snd_ensoniq_joystick_free(ensoniq);
-#endif
+	snd_ensoniq_free_gameport(ensoniq);
 	if (ensoniq->irq < 0)
 		goto __hw_end;
 #ifdef CHIP1370
@@ -2313,22 +2366,9 @@
 		snd_card_free(card);
 		return err;
 	}
-#ifdef SUPPORT_JOYSTICK
-#ifdef CHIP1371
-	switch (joystick_port[dev]) {
-	case 1: /* auto-detect */
-	case 0x200:
-	case 0x208:
-	case 0x210:
-	case 0x218:
-		snd_ensoniq_joystick(ensoniq, joystick_port[dev]);
-		break;
-	}
-#else
-	if (joystick[dev])
-		snd_ensoniq_joystick(ensoniq, 0x200);
-#endif
-#endif /* SUPPORT_JOYSTICK */
+
+	snd_ensoniq_create_gameport(ensoniq, dev);
+
 	strcpy(card->driver, DRIVER_NAME);
 
 	strcpy(card->shortname, "Ensoniq AudioPCI");
diff -Nru a/sound/pci/es1938.c b/sound/pci/es1938.c
--- a/sound/pci/es1938.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/es1938.c	2005-02-11 01:39:33 -05:00
@@ -72,6 +72,10 @@
                 "{ESS,ES1969},"
 		"{TerraTec,128i PCI}}");
 
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+#define SUPPORT_JOYSTICK 1
+#endif
+
 #ifndef PCI_VENDOR_ID_ESS
 #define PCI_VENDOR_ID_ESS		0x125d
 #endif
@@ -237,8 +241,8 @@
 	spinlock_t mixer_lock;
         snd_info_entry_t *proc_entry;
 
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	struct gameport gameport;
+#ifdef SUPPORT_JOYSTICK
+	struct gameport *gameport;
 #endif
 #ifdef CONFIG_PM
 	unsigned char saved_regs[SAVED_REG_SIZE];
@@ -1418,6 +1422,39 @@
 }
 #endif /* CONFIG_PM */
 
+#ifdef SUPPORT_JOYSTICK
+static int __devinit snd_es1938_create_gameport(es1938_t *chip)
+{
+	struct gameport *gp;
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "es1938: cannot allocate memory for gameport\n");
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "ES1938");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->io = chip->game_port;
+
+	gameport_register_port(gp);
+
+	return 0;
+}
+
+static void snd_es1938_free_gameport(es1938_t *chip)
+{
+	if (chip->gameport) {
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+	}
+}
+#else
+static inline int snd_es1938_create_gameport(es1938_t *chip) { return -ENOSYS; }
+static inline void snd_es1938_free_gameport(es1938_t *chip) { }
+#endif /* SUPPORT_JOYSTICK */
+
 static int snd_es1938_free(es1938_t *chip)
 {
 	/* disable irqs */
@@ -1425,10 +1462,8 @@
 	if (chip->rmidi)
 		snd_es1938_mixer_bits(chip, ESSSB_IREG_MPU401CONTROL, 0x40, 0);
 
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if (chip->gameport.io)
-		gameport_unregister_port(&chip->gameport);
-#endif
+	snd_es1938_free_gameport(chip);
+
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
 	pci_release_regions(chip->pci);
@@ -1698,10 +1733,7 @@
 		snd_es1938_mixer_bits(chip, ESSSB_IREG_MPU401CONTROL, 0x40, 0x40);
 	}
 
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	chip->gameport.io = chip->game_port;
-	gameport_register_port(&chip->gameport);
-#endif
+	snd_es1938_create_gameport(chip);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
diff -Nru a/sound/pci/es1968.c b/sound/pci/es1968.c
--- a/sound/pci/es1968.c	2005-02-11 01:39:34 -05:00
+++ b/sound/pci/es1968.c	2005-02-11 01:39:34 -05:00
@@ -605,8 +605,7 @@
 #endif
 
 #ifdef SUPPORT_JOYSTICK
-	struct gameport gameport;
-	struct resource *res_joystick;
+	struct gameport *gameport;
 #endif
 };
 
@@ -2450,6 +2449,59 @@
 }
 #endif /* CONFIG_PM */
 
+#ifdef SUPPORT_JOYSTICK
+#define JOYSTICK_ADDR	0x200
+static int __devinit snd_es1968_create_gameport(es1968_t *chip, int dev)
+{
+	struct gameport *gp;
+	struct resource *r;
+	u16 val;
+
+	if (!joystick[dev])
+		return -ENODEV;
+
+	r = request_region(JOYSTICK_ADDR, 8, "ES1968 gameport");
+	if (!r)
+		return -EBUSY;
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "es1968: cannot allocate memory for gameport\n");
+		release_resource(r);
+		kfree_nocheck(r);
+		return -ENOMEM;
+	}
+
+	pci_read_config_word(chip->pci, ESM_LEGACY_AUDIO_CONTROL, &val);
+	pci_write_config_word(chip->pci, ESM_LEGACY_AUDIO_CONTROL, val | 0x04);
+
+	gameport_set_name(gp, "ES1968 Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->io = JOYSTICK_ADDR;
+
+	gameport_register_port(gp);
+
+	return 0;
+}
+
+static void snd_es1968_free_gameport(es1968_t *chip)
+{
+	if (chip->gameport) {
+		struct resource *r = chip->gameport->port_data;
+
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+
+		release_resource(r);
+		kfree_nocheck(r);
+	}
+}
+#else
+static inline int snd_es1968_create_gameport(es1968_t *chip, int dev) { return -ENOSYS; }
+static inline void snd_es1968_free_gameport(es1968_t *chip) { }
+#endif
+
 static int snd_es1968_free(es1968_t *chip)
 {
 	if (chip->io_port) {
@@ -2460,13 +2512,7 @@
 
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
-#ifdef SUPPORT_JOYSTICK
-	if (chip->res_joystick) {
-		gameport_unregister_port(&chip->gameport);
-		release_resource(chip->res_joystick);
-		kfree_nocheck(chip->res_joystick);
-	}
-#endif
+	snd_es1968_free_gameport(chip);
 	snd_es1968_set_acpi(chip, ACPI_D3);
 	chip->master_switch = NULL;
 	chip->master_volume = NULL;
@@ -2693,17 +2739,7 @@
 		}
 	}
 
-#ifdef SUPPORT_JOYSTICK
-#define JOYSTICK_ADDR	0x200
-	if (joystick[dev] &&
-	    (chip->res_joystick = request_region(JOYSTICK_ADDR, 8, "ES1968 gameport")) != NULL) {
-		u16 val;
-		pci_read_config_word(pci, ESM_LEGACY_AUDIO_CONTROL, &val);
-		pci_write_config_word(pci, ESM_LEGACY_AUDIO_CONTROL, val | 0x04);
-		chip->gameport.io = JOYSTICK_ADDR;
-		gameport_register_port(&chip->gameport);
-	}
-#endif
+	snd_es1968_create_gameport(chip, dev);
 
 	snd_es1968_start_irq(chip);
 
diff -Nru a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
--- a/sound/pci/sonicvibes.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/sonicvibes.c	2005-02-11 01:39:33 -05:00
@@ -46,6 +46,10 @@
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{S3,SonicVibes PCI}}");
 
+#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
+#define SUPPORT_JOYSTICK 1
+#endif
+
 #ifndef PCI_VENDOR_ID_S3
 #define PCI_VENDOR_ID_S3             0x5333
 #endif
@@ -242,8 +246,8 @@
 	snd_kcontrol_t *master_mute;
 	snd_kcontrol_t *master_volume;
 
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	struct gameport gameport;
+#ifdef SUPPORT_JOYSTICK
+	struct gameport *gameport;
 #endif
 };
 
@@ -1163,15 +1167,47 @@
 
  */
 
+#ifdef SUPPORT_JOYSTICK
 static snd_kcontrol_new_t snd_sonicvibes_game_control __devinitdata =
 SONICVIBES_SINGLE("Joystick Speed", 0, SV_IREG_GAME_PORT, 1, 15, 0);
 
-static int snd_sonicvibes_free(sonicvibes_t *sonic)
+static int __devinit snd_sonicvibes_create_gameport(sonicvibes_t *sonic)
 {
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if (sonic->gameport.io)
-		gameport_unregister_port(&sonic->gameport);
+	struct gameport *gp;
+
+	sonic->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "sonicvibes: cannot allocate memory for gameport\n");
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "SonicVibes Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(sonic->pci));
+	gp->dev.parent = &sonic->pci->dev;
+	gp->io = sonic->game_port;
+
+	gameport_register_port(gp);
+
+	snd_ctl_add(sonic->card, snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
+
+	return 0;
+}
+
+static void snd_sonicvibes_free_gameport(sonicvibes_t *sonic)
+{
+	if (sonic->gameport) {
+		gameport_unregister_port(sonic->gameport);
+		sonic->gameport = NULL;
+	}
+}
+#else
+static inline int snd_sonicvibes_create_gameport(sonicvibes_t *sonic) { return -ENOSYS; }
+static inline void snd_sonicvibes_free_gameport(sonicvibes_t *sonic) { }
 #endif
+
+static int snd_sonicvibes_free(sonicvibes_t *sonic)
+{
+	snd_sonicvibes_free_gameport(sonic);
 	pci_write_config_dword(sonic->pci, 0x40, sonic->dmaa_port);
 	pci_write_config_dword(sonic->pci, 0x48, sonic->dmac_port);
 	if (sonic->irq >= 0)
@@ -1332,7 +1368,6 @@
 	snd_sonicvibes_debug(sonic);
 #endif
 	sonic->revision = snd_sonicvibes_in(sonic, SV_IREG_REVISION);
-	snd_ctl_add(card, snd_ctl_new1(&snd_sonicvibes_game_control, sonic));
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, sonic, &ops)) < 0) {
 		snd_sonicvibes_free(sonic);
@@ -1459,10 +1494,8 @@
 		snd_card_free(card);
 		return err;
 	}
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	sonic->gameport.io = sonic->game_port;
-	gameport_register_port(&sonic->gameport);
-#endif
+
+	snd_sonicvibes_create_gameport(sonic);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
diff -Nru a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
--- a/sound/pci/trident/trident.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/trident/trident.c	2005-02-11 01:39:33 -05:00
@@ -157,7 +157,7 @@
 	}
 #endif
 
-	snd_trident_gameport(trident);
+	snd_trident_create_gameport(trident);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
diff -Nru a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
--- a/sound/pci/trident/trident_main.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/trident/trident_main.c	2005-02-11 01:39:33 -05:00
@@ -3110,37 +3110,28 @@
 
 #if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
 
-typedef struct snd_trident_gameport {
-	struct gameport info;
-	trident_t *chip;
-} trident_gameport_t;
-
 static unsigned char snd_trident_gameport_read(struct gameport *gameport)
 {
-	trident_gameport_t *gp = (trident_gameport_t *)gameport;
-	trident_t *chip;
-	snd_assert(gp, return 0);
-	chip = gp->chip;
+	trident_t *chip = gameport->port_data;
+
+	snd_assert(chip, return 0);
 	return inb(TRID_REG(chip, GAMEPORT_LEGACY));
 }
 
 static void snd_trident_gameport_trigger(struct gameport *gameport)
 {
-	trident_gameport_t *gp = (trident_gameport_t *)gameport;
-	trident_t *chip;
-	snd_assert(gp, return);
-	chip = gp->chip;
+	trident_t *chip = gameport->port_data;
+
+	snd_assert(chip, return 0);
 	outb(0xff, TRID_REG(chip, GAMEPORT_LEGACY));
 }
 
 static int snd_trident_gameport_cooked_read(struct gameport *gameport, int *axes, int *buttons)
 {
-	trident_gameport_t *gp = (trident_gameport_t *)gameport;
-	trident_t *chip;
+	trident_t *chip = gameport->port_data;
 	int i;
 
-	snd_assert(gp, return 0);
-	chip = gp->chip;
+	snd_assert(chip, return 0);
 
 	*buttons = (~inb(TRID_REG(chip, GAMEPORT_LEGACY)) >> 4) & 0xf;
 
@@ -3154,10 +3145,9 @@
 
 static int snd_trident_gameport_open(struct gameport *gameport, int mode)
 {
-	trident_gameport_t *gp = (trident_gameport_t *)gameport;
-	trident_t *chip;
-	snd_assert(gp, return -1);
-	chip = gp->chip;
+	trident_t *chip = gameport->port_data;
+
+	snd_assert(chip, return 0);
 
 	switch (mode) {
 		case GAMEPORT_MODE_COOKED:
@@ -3173,30 +3163,42 @@
 	}
 }
 
-void __devinit snd_trident_gameport(trident_t *chip)
+int __devinit snd_trident_create_gameport(trident_t *chip)
 {
-	trident_gameport_t *gp;
-	gp = kmalloc(sizeof(*gp), GFP_KERNEL);
-	if (! gp) {
-		snd_printk("cannot allocate gameport area\n");
-		return;
-	}
-	memset(gp, 0, sizeof(*gp));
-	gp->chip = chip;
-	gp->info.fuzz = 64;
-	gp->info.read = snd_trident_gameport_read;
-	gp->info.trigger = snd_trident_gameport_trigger;
-	gp->info.cooked_read = snd_trident_gameport_cooked_read;
-	gp->info.open = snd_trident_gameport_open;
-	chip->gameport = gp;
+	struct gameport *gp;
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "trident: cannot allocate memory for gameport\n");
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "Trident 4DWave");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+
+	gp->port_data = chip;
+	gp->fuzz = 64;
+	gp->read = snd_trident_gameport_read;
+	gp->trigger = snd_trident_gameport_trigger;
+	gp->cooked_read = snd_trident_gameport_cooked_read;
+	gp->open = snd_trident_gameport_open;
 
-	gameport_register_port(&gp->info);
+	gameport_register_port(gp);
+
+	return 0;
 }
 
-#else
-void __devinit snd_trident_gameport(trident_t *chip)
+static inline void snd_trident_free_gameport(trident_t *chip)
 {
+	if (chip->gameport) {
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+	}
 }
+#else
+int __devinit snd_trident_create_gameport(trident_t *chip) { return -ENOSYS; }
+static inline void snd_trident_free_gameport(trident_t *chip) { }
 #endif /* CONFIG_GAMEPORT */
 
 /*
@@ -3661,12 +3663,7 @@
 
 static int snd_trident_free(trident_t *trident)
 {
-#if defined(CONFIG_GAMEPORT) || (defined(MODULE) && defined(CONFIG_GAMEPORT_MODULE))
-	if (trident->gameport) {
-		gameport_unregister_port(&trident->gameport->info);
-		kfree(trident->gameport);
-	}
-#endif
+	snd_trident_free_gameport(trident);
 	snd_trident_disable_eso(trident);
 	// Disable S/PDIF out
 	if (trident->device == TRIDENT_DEVICE_ID_NX)
diff -Nru a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c	2005-02-11 01:39:34 -05:00
+++ b/sound/pci/via82xx.c	2005-02-11 01:39:34 -05:00
@@ -394,8 +394,7 @@
 	snd_info_entry_t *proc_entry;
 
 #ifdef SUPPORT_JOYSTICK
-	struct gameport gameport;
-	struct resource *res_joystick;
+	struct gameport *gameport;
 #endif
 };
 
@@ -1635,11 +1634,70 @@
 	return 0;
 }
 
+#ifdef SUPPORT_JOYSTICK
+#define JOYSTICK_ADDR	0x200
+static int __devinit snd_via686_create_gameport(via82xx_t *chip, int dev, unsigned char *legacy)
+{
+	struct gameport *gp;
+	struct resource *r;
+
+	if (!joystick[dev])
+		return -ENODEV;
+
+	r = request_region(JOYSTICK_ADDR, 8, "VIA686 gameport");
+	if (!r) {
+		printk(KERN_WARNING "via82xx: cannot reserve joystick port 0x%#x\n", JOYSTICK_ADDR);
+		return -EBUSY;
+	}
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "via82xx: cannot allocate memory for gameport\n");
+		release_resource(r);
+		kfree_nocheck(r);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "VIA686 Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->io = JOYSTICK_ADDR;
+	gp->port_data = r;
+
+	/* Enable legacy joystick port */
+	*legacy |= VIA_FUNC_ENABLE_GAME;
+	pci_write_config_byte(chip->pci, VIA_FUNC_ENABLE, *legacy);
+
+	gameport_register_port(chip->gameport);
+
+	return 0;
+}
+
+static void snd_via686_free_gameport(via82xx_t *chip)
+{
+	if (chip->gameport) {
+		struct resource *r = chip->gameport->port_data;
+
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+		release_resource(r);
+		kfree_nocheck(r);
+	}
+}
+#else
+static inline int snd_via686_create_gameport(via82xx_t *chip, int dev, unsigned char *legacy)
+{
+	return -ENOSYS;
+}
+static inline void snd_via686_free_gameport(via82xx_t *chip) { }
+#endif
+
+
 /*
  *
  */
 
-static int snd_via8233_init_misc(via82xx_t *chip, int dev)
+static int __devinit snd_via8233_init_misc(via82xx_t *chip, int dev)
 {
 	int i, err, caps;
 	unsigned char val;
@@ -1671,7 +1729,7 @@
 	return 0;
 }
 
-static int snd_via686_init_misc(via82xx_t *chip, int dev)
+static int __devinit snd_via686_init_misc(via82xx_t *chip, int dev)
 {
 	unsigned char legacy, legacy_cfg;
 	int rev_h = 0;
@@ -1718,15 +1776,6 @@
 		mpu_port[dev] = 0;
 	}
 
-#ifdef SUPPORT_JOYSTICK
-#define JOYSTICK_ADDR	0x200
-	if (joystick[dev] &&
-	    (chip->res_joystick = request_region(JOYSTICK_ADDR, 8, "VIA686 gameport")) != NULL) {
-		legacy |= VIA_FUNC_ENABLE_GAME;
-		chip->gameport.io = JOYSTICK_ADDR;
-	}
-#endif
-
 	pci_write_config_byte(chip->pci, VIA_FUNC_ENABLE, legacy);
 	pci_write_config_byte(chip->pci, VIA_PNP_CONTROL, legacy_cfg);
 	if (chip->mpu_res) {
@@ -1741,10 +1790,7 @@
 		pci_write_config_byte(chip->pci, VIA_FUNC_ENABLE, legacy);
 	}
 
-#ifdef SUPPORT_JOYSTICK
-	if (chip->res_joystick)
-		gameport_register_port(&chip->gameport);
-#endif
+	snd_via686_create_gameport(chip, dev, &legacy);
 
 #ifdef CONFIG_PM
 	chip->legacy_saved = legacy;
@@ -1973,14 +2019,9 @@
 		kfree_nocheck(chip->mpu_res);
 	}
 	pci_release_regions(chip->pci);
+
 	if (chip->chip_type == TYPE_VIA686) {
-#ifdef SUPPORT_JOYSTICK
-		if (chip->res_joystick) {
-			gameport_unregister_port(&chip->gameport);
-			release_resource(chip->res_joystick);
-			kfree_nocheck(chip->res_joystick);
-		}
-#endif
+		snd_via686_free_gameport(chip);
 		pci_write_config_byte(chip->pci, VIA_FUNC_ENABLE, chip->old_legacy);
 		pci_write_config_byte(chip->pci, VIA_PNP_CONTROL, chip->old_legacy_cfg);
 	}
diff -Nru a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
--- a/sound/pci/ymfpci/ymfpci.c	2005-02-11 01:39:33 -05:00
+++ b/sound/pci/ymfpci/ymfpci.c	2005-02-11 01:39:33 -05:00
@@ -79,6 +79,96 @@
 
 MODULE_DEVICE_TABLE(pci, snd_ymfpci_ids);
 
+#ifdef SUPPORT_JOYSTICK
+static int __devinit snd_ymfpci_create_gameport(ymfpci_t *chip, int dev,
+						int legacy_ctrl, int legacy_ctrl2)
+{
+	struct gameport *gp;
+	struct resource *r = NULL;
+	int io_port = joystick_port[dev];
+
+	if (!io_port)
+		return -ENODEV;
+
+	if (chip->pci->device >= 0x0010) { /* YMF 744/754 */
+
+		if (io_port == 1) {
+			/* auto-detect */
+			if (!(io_port = pci_resource_start(chip->pci, 2)))
+				return -ENODEV;
+		}
+	} else {
+		if (io_port == 1) {
+			/* auto-detect */
+			for (io_port = 0x201; io_port <= 0x205; io_port++) {
+				if (io_port == 0x203)
+					continue;
+				if ((r = request_region(io_port, 1, "YMFPCI gameport")) != NULL)
+					break;
+			}
+			if (!r) {
+				printk(KERN_ERR "ymfpci: no gameport ports available\n");
+				return -EBUSY;
+			}
+		}
+		switch (io_port) {
+		case 0x201: legacy_ctrl2 |= 0 << 6; break;
+		case 0x202: legacy_ctrl2 |= 1 << 6; break;
+		case 0x204: legacy_ctrl2 |= 2 << 6; break;
+		case 0x205: legacy_ctrl2 |= 3 << 6; break;
+		default:
+			printk(KERN_ERR "ymfpci: invalid joystick port %#x", io_port);
+			return -EINVAL;
+		}
+	}
+
+	if (!r && !(r = request_region(io_port, 1, "YMFPCI gameport"))) {
+		printk(KERN_ERR "ymfpci: joystick port %#x is in use.\n", io_port);
+		return -EBUSY;
+	}
+
+	chip->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "ymfpci: cannot allocate memory for gameport\n");
+		release_resource(r);
+		kfree_nocheck(r);
+		return -ENOMEM;
+	}
+
+
+	gameport_set_name(gp, "Yamaha YMF Gameport");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
+	gp->dev.parent = &chip->pci->dev;
+	gp->io = io_port;
+
+	if (chip->pci->device >= 0x0010) /* YMF 744/754 */
+		pci_write_config_word(chip->pci, PCIR_DSXG_JOYBASE, io_port);
+
+	pci_write_config_word(chip->pci, PCIR_DSXG_LEGACY, legacy_ctrl | YMFPCI_LEGACY_JPEN);
+	pci_write_config_word(chip->pci, PCIR_DSXG_ELEGACY, legacy_ctrl2);
+
+	gameport_register_port(chip->gameport);
+
+	return 0;
+}
+
+void snd_ymfpci_free_gameport(ymfpci_t *chip)
+{
+	if (chip->gameport) {
+		struct resource *r = chip->gameport->port_data;
+
+		gameport_unregister_port(chip->gameport);
+		chip->gameport = NULL;
+
+		release_resource(r);
+		kfree_nocheck(r);
+	}
+}
+#else
+static inline int snc_ymfpci_create_gameport(ymfpci_t *chip, int dev, int l, int l2) { return -ENOSYS; }
+void snd_ymfpci_free_gameport(ymfpci_t *chip) { }
+#endif /* SUPPORT_JOYSTICK */
+
 static int __devinit snd_card_ymfpci_probe(struct pci_dev *pci,
 					   const struct pci_device_id *pci_id)
 {
@@ -86,9 +176,6 @@
 	snd_card_t *card;
 	struct resource *fm_res = NULL;
 	struct resource *mpu_res = NULL;
-#ifdef SUPPORT_JOYSTICK
-	struct resource *joystick_res = NULL;
-#endif
 	ymfpci_t *chip;
 	opl3_t *opl3;
 	char *str;
@@ -138,17 +225,6 @@
 			legacy_ctrl |= YMFPCI_LEGACY_MEN;
 			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
 		}
-#ifdef SUPPORT_JOYSTICK
-		if (joystick_port[dev] == 1) {
-			/* auto-detect */
-			joystick_port[dev] = pci_resource_start(pci, 2);
-		}
-		if (joystick_port[dev] > 0 &&
-		    (joystick_res = request_region(joystick_port[dev], 1, "YMFPCI gameport")) != NULL) {
-			legacy_ctrl |= YMFPCI_LEGACY_JPEN;
-			pci_write_config_word(pci, PCIR_DSXG_JOYBASE, joystick_port[dev]);
-		}
-#endif
 	} else {
 		switch (fm_port[dev]) {
 		case 0x388: legacy_ctrl2 |= 0; break;
@@ -178,34 +254,6 @@
 			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;
 			mpu_port[dev] = 0;
 		}
-#ifdef SUPPORT_JOYSTICK
-		if (joystick_port[dev] == 1) {
-			/* auto-detect */
-			long p;
-			for (p = 0x201; p <= 0x205; p++) {
-				if (p == 0x203) continue;
-				if ((joystick_res = request_region(p, 1, "YMFPCI gameport")) != NULL)
-					break;
-			}
-			if (joystick_res)
-				joystick_port[dev] = p;
-		}
-		switch (joystick_port[dev]) {
-		case 0x201: legacy_ctrl2 |= 0 << 6; break;
-		case 0x202: legacy_ctrl2 |= 1 << 6; break;
-		case 0x204: legacy_ctrl2 |= 2 << 6; break;
-		case 0x205: legacy_ctrl2 |= 3 << 6; break;
-		default: joystick_port[dev] = 0; break;
-		}
-		if (! joystick_res && joystick_port[dev] > 0)
-			joystick_res = request_region(joystick_port[dev], 1, "YMFPCI gameport");
-		if (joystick_res) {
-			legacy_ctrl |= YMFPCI_LEGACY_JPEN;
-		} else {
-			legacy_ctrl2 &= ~YMFPCI_LEGACY2_JSIO;
-			joystick_port[dev] = 0;
-		}
-#endif
 	}
 	if (mpu_res) {
 		legacy_ctrl |= YMFPCI_LEGACY_MIEN;
@@ -226,19 +274,10 @@
 			release_resource(fm_res);
 			kfree_nocheck(fm_res);
 		}
-#ifdef SUPPORT_JOYSTICK
-		if (joystick_res) {
-			release_resource(joystick_res);
-			kfree_nocheck(joystick_res);
-		}
-#endif
 		return err;
 	}
 	chip->fm_res = fm_res;
 	chip->mpu_res = mpu_res;
-#ifdef SUPPORT_JOYSTICK
-	chip->joystick_res = joystick_res;
-#endif
 	strcpy(card->driver, str);
 	sprintf(card->shortname, "Yamaha DS-XG (%s)", str);
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
@@ -292,12 +331,8 @@
 			return err;
 		}
 	}
-#ifdef SUPPORT_JOYSTICK
-	if (chip->joystick_res) {
-		chip->gameport.io = joystick_port[dev];
-		gameport_register_port(&chip->gameport);
-	}
-#endif
+
+	snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
diff -Nru a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
--- a/sound/pci/ymfpci/ymfpci_main.c	2005-02-11 01:39:34 -05:00
+++ b/sound/pci/ymfpci/ymfpci_main.c	2005-02-11 01:39:34 -05:00
@@ -2079,14 +2079,7 @@
 		release_resource(chip->fm_res);
 		kfree_nocheck(chip->fm_res);
 	}
-#ifdef SUPPORT_JOYSTICK
-	if (chip->joystick_res) {
-		if (chip->gameport.io)
-			gameport_unregister_port(&chip->gameport);
-		release_resource(chip->joystick_res);
-		kfree_nocheck(chip->joystick_res);
-	}
-#endif
+	snd_ymfpci_free_gameport(chip);
 	if (chip->reg_area_virt)
 		iounmap(chip->reg_area_virt);
 	if (chip->work_ptr.area)
