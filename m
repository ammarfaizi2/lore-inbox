Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVBKHTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVBKHTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVBKHTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:19:38 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:47454 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262210AbVBKHFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:05:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: InputML <linux-input@atrey.karlin.mff.cuni.cz>
Subject: [PATCH 6/10] Gameport: convert sound/oss to dynamic allocation
Date: Fri, 11 Feb 2005 02:02:48 -0500
User-Agent: KMail/1.7.2
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <200502110158.47872.dtor_core@ameritech.net> <200502110201.31239.dtor_core@ameritech.net> <200502110202.18242.dtor_core@ameritech.net>
In-Reply-To: <200502110202.18242.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502110202.48966.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.2154, 2005-02-11 01:20:08-05:00, dtor_core@ameritech.net
  Input: convert sound/oss to dynamic gameport allocation.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 cmpci.c      |  100 ++++++++++++++++++++++++++++++++++++++---------------------
 es1370.c     |   34 ++++++++++++--------
 es1371.c     |   52 ++++++++++++++++++------------
 esssolo1.c   |   47 ++++++++++++++++++++-------
 mad16.c      |   47 ++++++++++++++++++---------
 sonicvibes.c |   49 +++++++++++++++++++++-------
 trident.c    |   39 +++++++++++++++++------
 7 files changed, 249 insertions(+), 119 deletions(-)


===================================================================



diff -Nru a/sound/oss/cmpci.c b/sound/oss/cmpci.c
--- a/sound/oss/cmpci.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/cmpci.c	2005-02-11 01:38:28 -05:00
@@ -426,7 +426,7 @@
 	struct address_info mpu_data;
 #endif
 #ifdef CONFIG_SOUND_CMPCI_JOYSTICK
-	struct gameport gameport;
+	struct gameport *gameport;
 #endif
 
 	int	chip_version;
@@ -468,17 +468,17 @@
 
 static LIST_HEAD(devs);
 
-static	int	mpuio = 0;
-static	int	fmio = 0;
-static	int	joystick = 0;
-static	int	spdif_inverse = 0;
-static	int	spdif_loop = 0;
-static	int	spdif_out = 0;
-static	int	use_line_as_rear = 0;
-static	int	use_line_as_bass = 0;
-static	int	use_mic_as_bass = 0;
-static	int	mic_boost = 0;
-static	int	hw_copy = 0;
+static	int	mpuio;
+static	int	fmio;
+static	int	joystick;
+static	int	spdif_inverse;
+static	int	spdif_loop;
+static	int	spdif_out;
+static	int	use_line_as_rear;
+static	int	use_line_as_bass;
+static	int	use_mic_as_bass;
+static	int	mic_boost;
+static	int	hw_copy;
 module_param(mpuio, int, 0);
 module_param(fmio, int, 0);
 module_param(joystick, bool, 0);
@@ -2984,6 +2984,51 @@
 	return ChipVersion;
 }
 
+#ifdef CONFIG_SOUND_CMPCI_JOYSTICK
+static int __devinit cm_create_gameport(struct cm_state *s, int io_port)
+{
+	struct gameport *gp;
+
+	if (!request_region(io_port, CM_EXTENT_GAME, "cmpci GAME")) {
+		printk(KERN_ERR "cmpci: gameport io ports 0x%#x in use\n", io_port);
+		return -EBUSY;
+	}
+
+	if (!(s->gameport = gp = gameport_allocate_port())) {
+		printk(KERN_ERR "cmpci: can not allocate memory for gameport\n");
+		release_region(io_port, CM_EXTENT_GAME);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "C-Media GP");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(s->dev));
+	gp->dev.parent = &s->dev->dev;
+	gp->io = io_port;
+
+	/* enable joystick */
+	maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0, 0x02);
+
+	gameport_register_port(gp);
+
+	return 0;
+}
+
+static void __devexit cm_free_gameport(struct cm_state *s)
+{
+	if (s->gameport) {
+		int gpio = s->gameport->io;
+
+		gameport_unregister_port(s->gameport);
+		s->gameport = NULL;
+		maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0x02, 0);
+		release_region(gpio, CM_EXTENT_GAME);
+	}
+}
+#else
+static inline int cm_create_gameport(struct cm_state *s, int io_port) { return -ENOSYS; }
+static inline void cm_free_gameport(struct cm_state *s) { }
+#endif
+
 #define	echo_option(x)\
 if (x) strcat(options, "" #x " ")
 
@@ -3229,22 +3274,11 @@
 	}
 skip_mpu:
 #endif
-#ifdef CONFIG_SOUND_CMPCI_JOYSTICK
-	/* enable joystick */
-	if (joystick) {
-		s->gameport.io = 0x200;
-		if (!request_region(s->gameport.io, CM_EXTENT_GAME, "cmpci GAME")) {
-			printk(KERN_ERR "cmpci: gameport io ports in use\n");
-			s->gameport.io = 0;
-	       	} else {
-			maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0, 0x02);
-			gameport_register_port(&s->gameport);
-		}
-	} else {
-		maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0x02, 0);
-		s->gameport.io = 0;
-	}
-#endif
+	/* disable joystick port */
+	maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0x02, 0);
+	if (joystick)
+		cm_create_gameport(s, 0x200);
+
 	/* store it in the driver field */
 	pci_set_drvdata(pcidev, s);
 	/* put it into driver list */
@@ -3278,13 +3312,9 @@
 
 	if (!s)
 		return;
-#ifdef CONFIG_SOUND_CMPCI_JOYSTICK
-	if (s->gameport.io) {
-		gameport_unregister_port(&s->gameport);
-		release_region(s->gameport.io, CM_EXTENT_GAME);
-		maskb(s->iobase + CODEC_CMI_FUNCTRL1, ~0x02, 0);
-	}
-#endif
+
+	cm_free_gameport(s);
+
 #ifdef CONFIG_SOUND_CMPCI_FM
 	if (s->iosynth) {
 		/* disable FM */
diff -Nru a/sound/oss/es1370.c b/sound/oss/es1370.c
--- a/sound/oss/es1370.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/es1370.c	2005-02-11 01:38:28 -05:00
@@ -384,7 +384,7 @@
 		unsigned char obuf[MIDIOUTBUF];
 	} midi;
 
-	struct gameport gameport;
+	struct gameport *gameport;
 	struct semaphore sem;
 };
 
@@ -2556,6 +2556,7 @@
 static int __devinit es1370_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct es1370_state *s;
+	struct gameport *gp = NULL;
 	mm_segment_t fs;
 	int i, val, ret;
 
@@ -2604,12 +2605,17 @@
 	/* note: setting CTRL_SERR_DIS is reported to break
 	 * mic bias setting (by Kim.Berts@fisub.mail.abb.com) */
 	s->ctrl = CTRL_CDC_EN | (DAC2_SRTODIV(8000) << CTRL_SH_PCLKDIV) | (1 << CTRL_SH_WTSRSEL);
-	s->gameport.io = 0;
-	if (!request_region(0x200, JOY_EXTENT, "es1370"))
+	if (!request_region(0x200, JOY_EXTENT, "es1370")) {
 		printk(KERN_ERR "es1370: joystick io port 0x200 in use\n");
-	else {
+	} else if (!(s->gameport = gp = gameport_allocate_port())) {
+		printk(KERN_ERR "es1370: can not allocate memory for gameport\n");
+		release_region(0x200, JOY_EXTENT);
+	} else {
+		gameport_set_name(gp, "ESS1370");
+		gameport_set_phys(gp, "pci%s/gameport0", pci_name(s->dev));
+		gp->dev.parent = &s->dev->dev;
+		gp->io = 0x200;
 		s->ctrl |= CTRL_JYSTK_EN;
-		s->gameport.io = 0x200;
 	}
 	if (lineout[devindex])
 		s->ctrl |= CTRL_XCTL0;
@@ -2665,9 +2671,10 @@
 		mixer_ioctl(s, initvol[i].mixch, (unsigned long)&val);
 	}
 	set_fs(fs);
+
 	/* register gameport */
-	if (s->gameport.io)
-		gameport_register_port(&s->gameport);
+	if (gp)
+		gameport_register_port(gp);
 
 	/* store it in the driver field */
 	pci_set_drvdata(pcidev, s);
@@ -2689,8 +2696,10 @@
  err_dev1:
 	printk(KERN_ERR "es1370: cannot register misc device\n");
 	free_irq(s->irq, s);
-	if (s->gameport.io)
-		release_region(s->gameport.io, JOY_EXTENT);
+	if (s->gameport) {
+		release_region(s->gameport->io, JOY_EXTENT);
+		gameport_free_port(s->gameport);
+	}
  err_irq:
 	release_region(s->io, ES1370_EXTENT);
  err_region:
@@ -2709,9 +2718,10 @@
 	outl(0, s->io+ES1370_REG_SERIAL_CONTROL); /* clear serial interrupts */
 	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
-	if (s->gameport.io) {
-		gameport_unregister_port(&s->gameport);
-		release_region(s->gameport.io, JOY_EXTENT);
+	if (s->gameport) {
+		int gpio = s->gameport->io;
+		gameport_unregister_port(s->gameport);
+		release_region(gpio, JOY_EXTENT);
 	}
 	release_region(s->io, ES1370_EXTENT);
 	unregister_sound_dsp(s->dev_audio);
diff -Nru a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/es1371.c	2005-02-11 01:38:28 -05:00
@@ -453,7 +453,7 @@
 		unsigned char obuf[MIDIOUTBUF];
 	} midi;
 
-	struct gameport gameport;
+	struct gameport *gameport;
 	struct semaphore sem;
 };
 
@@ -2786,12 +2786,12 @@
 	{ PCI_ANY_ID, PCI_ANY_ID }
 };
 
-
 static int __devinit es1371_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct es1371_state *s;
+	struct gameport *gp;
 	mm_segment_t fs;
-	int i, val, res = -1;
+	int i, gpio, val, res = -1;
 	int idx;
 	unsigned long tmo;
 	signed long tmo2;
@@ -2849,8 +2849,8 @@
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
 	}
-	printk(KERN_INFO PFX "found es1371 rev %d at io %#lx irq %u joystick %#x\n",
-	       s->rev, s->io, s->irq, s->gameport.io);
+	printk(KERN_INFO PFX "found es1371 rev %d at io %#lx irq %u\n",
+	       s->rev, s->io, s->irq);
 	/* register devices */
 	if ((res=(s->dev_audio = register_sound_dsp(&es1371_audio_fops,-1)))<0)
 		goto err_dev1;
@@ -2881,16 +2881,23 @@
                     	printk(KERN_INFO PFX "Enabling internal amplifier.\n");
 		}
 	}
-	s->gameport.io = 0;
-	for (i = 0x218; i >= 0x200; i -= 0x08) {
-		if (request_region(i, JOY_EXTENT, "es1371")) {
-			s->ctrl |= CTRL_JYSTK_EN | (((i >> 3) & CTRL_JOY_MASK) << CTRL_JOY_SHIFT);
-			s->gameport.io = i;
+
+	for (gpio = 0x218; gpio >= 0x200; gpio -= 0x08)
+		if (request_region(gpio, JOY_EXTENT, "es1371"))
 			break;
-		}
-	}
-	if (!s->gameport.io)
+
+	if (gpio < 0x200) {
 		printk(KERN_ERR PFX "no free joystick address found\n");
+	} else if (!(s->gameport = gp = gameport_allocate_port())) {
+		printk(KERN_ERR PFX "can not allocate memory for gameport\n");
+		release_region(gpio, JOY_EXTENT);
+	} else {
+		gameport_set_name(gp, "ESS1371 Gameport");
+		gameport_set_phys(gp, "isa%04x/gameport0", gpio);
+		gp->dev.parent = &s->dev->dev;
+		gp->io = gpio;
+		s->ctrl |= CTRL_JYSTK_EN | (((gpio >> 3) & CTRL_JOY_MASK) << CTRL_JOY_SHIFT);
+	}
 
 	s->sctrl = 0;
 	cssr = 0;
@@ -2960,9 +2967,11 @@
 	set_fs(fs);
 	/* turn on S/PDIF output driver if requested */
 	outl(cssr, s->io+ES1371_REG_STATUS);
+
 	/* register gameport */
-	if (s->gameport.io)
-		gameport_register_port(&s->gameport);
+	if (s->gameport)
+		gameport_register_port(s->gameport);
+
 	/* store it in the driver field */
 	pci_set_drvdata(pcidev, s);
 	/* put it into driver list */
@@ -2973,8 +2982,10 @@
        	return 0;
 
  err_gp:
-	if (s->gameport.io)
-		release_region(s->gameport.io, JOY_EXTENT);
+	if (s->gameport) {
+		release_region(s->gameport->io, JOY_EXTENT);
+		gameport_free_port(s->gameport);
+	}
 #ifdef ES1371_DEBUG
 	if (s->ps)
 		remove_proc_entry("es1371", NULL);
@@ -3013,9 +3024,10 @@
 	outl(0, s->io+ES1371_REG_SERIAL_CONTROL); /* clear serial interrupts */
 	synchronize_irq(s->irq);
 	free_irq(s->irq, s);
-	if (s->gameport.io) {
-		gameport_unregister_port(&s->gameport);
-		release_region(s->gameport.io, JOY_EXTENT);
+	if (s->gameport) {
+		int gpio = s->gameport->io;
+		gameport_unregister_port(s->gameport);
+		release_region(gpio, JOY_EXTENT);
 	}
 	release_region(s->io, ES1371_EXTENT);
 	unregister_sound_dsp(s->dev_audio);
diff -Nru a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
--- a/sound/oss/esssolo1.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/esssolo1.c	2005-02-11 01:38:28 -05:00
@@ -226,7 +226,7 @@
 		unsigned char obuf[MIDIOUTBUF];
 	} midi;
 
-	struct gameport gameport;
+	struct gameport *gameport;
 };
 
 /* --------------------------------------------------------------------- */
@@ -2280,9 +2280,36 @@
 	return 0;
 }
 
+static int __devinit solo1_register_gameport(struct solo1_state *s, int io_port)
+{
+	struct gameport *gp;
+
+	if (!request_region(io_port, GAMEPORT_EXTENT, "ESS Solo1")) {
+		printk(KERN_ERR "solo1: gameport io ports are in use\n");
+		return -EBUSY;
+	}
+
+	s->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "solo1: can not allocate memory for gameport\n");
+		release_region(io_port, GAMEPORT_EXTENT);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "ESS Solo1 Gameport");
+	gameport_set_phys(gp, "isa%04x/gameport0", io_port);
+	gp->dev.parent = &s->dev->dev;
+	gp->io = io_port;
+
+	gameport_register_port(gp);
+
+	return 0;
+}
+
 static int __devinit solo1_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	struct solo1_state *s;
+	int gpio;
 	int ret;
 
  	if ((ret=pci_enable_device(pcidev)))
@@ -2323,7 +2350,7 @@
 	s->vcbase = pci_resource_start(pcidev, 2);
 	s->ddmabase = s->vcbase + DDMABASE_OFFSET;
 	s->mpubase = pci_resource_start(pcidev, 3);
-	s->gameport.io = pci_resource_start(pcidev, 4);
+	gpio = pci_resource_start(pcidev, 4);
 	s->irq = pcidev->irq;
 	ret = -EBUSY;
 	if (!request_region(s->iobase, IOBASE_EXTENT, "ESS Solo1")) {
@@ -2342,15 +2369,10 @@
 		printk(KERN_ERR "solo1: io ports in use\n");
 		goto err_region4;
 	}
-	if (s->gameport.io && !request_region(s->gameport.io, GAMEPORT_EXTENT, "ESS Solo1")) {
-		printk(KERN_ERR "solo1: gameport io ports in use\n");
-		s->gameport.io = 0;
-	}
 	if ((ret=request_irq(s->irq,solo1_interrupt,SA_SHIRQ,"ESS Solo1",s))) {
 		printk(KERN_ERR "solo1: irq %u in use\n", s->irq);
 		goto err_irq;
 	}
-	printk(KERN_INFO "solo1: joystick port at %#x\n", s->gameport.io+1);
 	/* register devices */
 	if ((s->dev_audio = register_sound_dsp(&solo1_audio_fops, -1)) < 0) {
 		ret = s->dev_audio;
@@ -2373,7 +2395,7 @@
 		goto err;
 	}
 	/* register gameport */
-	gameport_register_port(&s->gameport);
+	solo1_register_gameport(s, gpio);
 	/* store it in the driver field */
 	pci_set_drvdata(pcidev, s);
 	return 0;
@@ -2390,8 +2412,6 @@
 	printk(KERN_ERR "solo1: initialisation error\n");
 	free_irq(s->irq, s);
  err_irq:
-	if (s->gameport.io)
-		release_region(s->gameport.io, GAMEPORT_EXTENT);
 	release_region(s->mpubase, MPUBASE_EXTENT);
  err_region4:
 	release_region(s->ddmabase, DDMABASE_EXTENT);
@@ -2417,9 +2437,10 @@
 	synchronize_irq(s->irq);
 	pci_write_config_word(s->dev, 0x60, 0); /* turn off DDMA controller address space */
 	free_irq(s->irq, s);
-	if (s->gameport.io) {
-		gameport_unregister_port(&s->gameport);
-		release_region(s->gameport.io, GAMEPORT_EXTENT);
+	if (s->gameport) {
+		int gpio = s->gameport->io;
+		gameport_unregister_port(s->gameport);
+		release_region(gpio, GAMEPORT_EXTENT);
 	}
 	release_region(s->iobase, IOBASE_EXTENT);
 	release_region(s->sbbase+FMSYNTH_EXTENT, SBBASE_EXTENT-FMSYNTH_EXTENT);
diff -Nru a/sound/oss/mad16.c b/sound/oss/mad16.c
--- a/sound/oss/mad16.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/mad16.c	2005-02-11 01:38:28 -05:00
@@ -52,7 +52,7 @@
 
 static int      mad16_conf;
 static int      mad16_cdsel;
-static struct gameport gameport;
+static struct gameport *gameport;
 static DEFINE_SPINLOCK(lock);
 
 #define C928	1
@@ -902,7 +902,30 @@
 	-1, -1, -1, -1
 };
 
-static int __init init_mad16(void)
+static int __devinit mad16_register_gameport(int io_port)
+{
+	if (!request_region(io_port, 1, "mad16 gameport")) {
+		printk(KERN_ERR "mad16: gameport address 0x%#x already in use\n", io_port);
+		return -EBUSY;
+	}
+
+	gameport = gameport_allocate_port();
+	if (!gameport) {
+		printk(KERN_ERR "mad16: can not allocate memory for gameport\n");
+		release_region(io_port, 1);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gameport, "MAD16 Gameport");
+	gameport_set_phys(gameport, "isa%04x/gameport0", io_port);
+	gameport->io = io_port;
+
+	gameport_register_port(gameport);
+
+	return 0;
+}
+
+static int __devinit init_mad16(void)
 {
 	int dmatype = 0;
 
@@ -1027,17 +1050,9 @@
 
 	found_mpu = probe_mad16_mpu(&cfg_mpu);
 
-	if (joystick == 1) {
-		/* register gameport */
-		if (!request_region(0x201, 1, "mad16 gameport"))
-			printk(KERN_ERR "mad16: gameport address 0x201 already in use\n");
-		else {
-			printk(KERN_ERR "mad16: gameport enabled at 0x201\n");
-			gameport.io = 0x201;
-			gameport_register_port(&gameport);
-		}
-	}
-	else printk(KERN_ERR "mad16: gameport disabled.\n");
+	if (joystick)
+		mad16_register_gameport(0x201);
+
 	return 0;
 }
 
@@ -1045,10 +1060,10 @@
 {
 	if (found_mpu)
 		unload_mad16_mpu(&cfg_mpu);
-	if (gameport.io) {
+	if (gameport) {
 		/* the gameport was initialized so we must free it up */
-		gameport_unregister_port(&gameport);
-		gameport.io = 0;
+		gameport_unregister_port(gameport);
+		gameport = NULL;
 		release_region(0x201, 1);
 	}
 	unload_mad16(&cfg);
diff -Nru a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
--- a/sound/oss/sonicvibes.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/sonicvibes.c	2005-02-11 01:38:28 -05:00
@@ -365,7 +365,7 @@
 		unsigned char obuf[MIDIOUTBUF];
 	} midi;
 
-	struct gameport gameport;
+	struct gameport *gameport;
 };
 
 /* --------------------------------------------------------------------- */
@@ -2485,12 +2485,39 @@
 #define RSRCISIOREGION(dev,num) (pci_resource_start((dev), (num)) != 0 && \
 				 (pci_resource_flags((dev), (num)) & IORESOURCE_IO))
 
+static int __devinit sv_register_gameport(struct sv_state *s, int io_port)
+{
+	struct gameport *gp;
+
+	if (!request_region(io_port, SV_EXTENT_GAME, "S3 SonicVibes Gameport")) {
+		printk(KERN_ERR "sv: gameport io ports are in use\n");
+		return -EBUSY;
+	}
+
+	s->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "sv: can not allocate memory for gameport\n");
+		release_region(io_port, SV_EXTENT_GAME);
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "S3 SonicVibes Gameport");
+	gameport_set_phys(gp, "isa%04x/gameport0", io_port);
+	gp->dev.parent = &s->dev->dev;
+	gp->io = io_port;
+
+	gameport_register_port(gp);
+
+	return 0;
+}
+
 static int __devinit sv_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
 	static char __initdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
        	struct sv_state *s;
 	mm_segment_t fs;
 	int i, val, ret;
+	int gpio;
 	char *ddmaname;
 	unsigned ddmanamelen;
 
@@ -2546,11 +2573,11 @@
 	s->iomidi = pci_resource_start(pcidev, RESOURCE_MIDI);
 	s->iodmaa = pci_resource_start(pcidev, RESOURCE_DDMA);
 	s->iodmac = pci_resource_start(pcidev, RESOURCE_DDMA) + SV_EXTENT_DMA;
-	s->gameport.io = pci_resource_start(pcidev, RESOURCE_GAME);
+	gpio = pci_resource_start(pcidev, RESOURCE_GAME);
 	pci_write_config_dword(pcidev, 0x40, s->iodmaa | 9);  /* enable and use extended mode */
 	pci_write_config_dword(pcidev, 0x48, s->iodmac | 9);  /* enable */
 	printk(KERN_DEBUG "sv: io ports: %#lx %#lx %#lx %#lx %#x %#x %#x\n",
-	       s->iosb, s->ioenh, s->iosynth, s->iomidi, s->gameport.io, s->iodmaa, s->iodmac);
+	       s->iosb, s->ioenh, s->iosynth, s->iomidi, gpio, s->iodmaa, s->iodmac);
 	s->irq = pcidev->irq;
 	
 	/* hack */
@@ -2577,10 +2604,7 @@
 		printk(KERN_ERR "sv: io ports %#lx-%#lx in use\n", s->iosynth, s->iosynth+SV_EXTENT_SYNTH-1);
 		goto err_region1;
 	}
-	if (s->gameport.io && !request_region(s->gameport.io, SV_EXTENT_GAME, "ESS Solo1")) {
-		printk(KERN_ERR "sv: gameport io ports in use\n");
-		s->gameport.io = 0;
-	}
+
 	/* initialize codec registers */
 	outb(0x80, s->ioenh + SV_CODEC_CONTROL); /* assert reset */
 	udelay(50);
@@ -2639,7 +2663,7 @@
 	}
 	set_fs(fs);
 	/* register gameport */
-	gameport_register_port(&s->gameport);
+	sv_register_gameport(s, gpio);
 	/* store it in the driver field */
 	pci_set_drvdata(pcidev, s);
 	/* put it into driver list */
@@ -2659,8 +2683,6 @@
 	printk(KERN_ERR "sv: cannot register misc device\n");
 	free_irq(s->irq, s);
  err_irq:
-	if (s->gameport.io)
-		release_region(s->gameport.io, SV_EXTENT_GAME);
 	release_region(s->iosynth, SV_EXTENT_SYNTH);
  err_region1:
 	release_region(s->iomidi, SV_EXTENT_MIDI);
@@ -2689,9 +2711,10 @@
 	/*outb(0, s->iodmaa + SV_DMA_RESET);*/
 	/*outb(0, s->iodmac + SV_DMA_RESET);*/
 	free_irq(s->irq, s);
-	if (s->gameport.io) {
-		gameport_unregister_port(&s->gameport);
-		release_region(s->gameport.io, SV_EXTENT_GAME);
+	if (s->gameport) {
+		int gpio = s->gameport->io;
+		gameport_unregister_port(s->gameport);
+		release_region(gpio, SV_EXTENT_GAME);
 	}
 	release_region(s->iodmac, SV_EXTENT_DMA);
 	release_region(s->iodmaa, SV_EXTENT_DMA);
diff -Nru a/sound/oss/trident.c b/sound/oss/trident.c
--- a/sound/oss/trident.c	2005-02-11 01:38:28 -05:00
+++ b/sound/oss/trident.c	2005-02-11 01:38:28 -05:00
@@ -441,7 +441,7 @@
 	struct timer_list timer;
 
 	/* Game port support */
-	struct gameport gameport;
+	struct gameport *gameport;
 };
 
 enum dmabuf_mode {
@@ -4305,6 +4305,31 @@
 	return 0;
 }
 
+static int __devinit
+trident_register_gameport(struct trident_card *card)
+{
+	struct gameport *gp;
+
+	card->gameport = gp = gameport_allocate_port();
+	if (!gp) {
+		printk(KERN_ERR "trident: can not allocate memory for gameport\n");
+		return -ENOMEM;
+	}
+
+	gameport_set_name(gp, "Trident 4DWave");
+	gameport_set_phys(gp, "pci%s/gameport0", pci_name(card->pci_dev));
+	gp->read = trident_game_read;
+	gp->trigger = trident_game_trigger;
+	gp->cooked_read = trident_game_cooked_read;
+	gp->open = trident_game_open;
+	gp->fuzz = 64;
+	gp->port_data = card;
+
+	gameport_register_port(gp);
+
+	return 0;
+}
+
 /* install the driver, we do not allocate hardware channel nor DMA buffer */ 
 /* now, they are defered until "ACCESS" time (in prog_dmabuf called by */ 
 /* open/read/write/ioctl/mmap) */
@@ -4368,13 +4393,6 @@
 	card->banks[BANK_B].addresses = &bank_b_addrs;
 	card->banks[BANK_B].bitmap = 0UL;
 
-	card->gameport.port_data = card;
-	card->gameport.fuzz = 64;
-	card->gameport.read = trident_game_read;
-	card->gameport.trigger = trident_game_trigger;
-	card->gameport.cooked_read = trident_game_cooked_read;
-	card->gameport.open = trident_game_open;
-
 	init_MUTEX(&card->open_sem);
 	spin_lock_init(&card->lock);
 	init_timer(&card->timer);
@@ -4508,7 +4526,7 @@
 	trident_enable_loop_interrupts(card);
 
 	/* Register gameport */
-	gameport_register_port(&card->gameport);
+	trident_register_gameport(card);
 
 out:
 	return rc;
@@ -4551,7 +4569,8 @@
 	}
 
 	/* Unregister gameport */
-	gameport_unregister_port(&card->gameport);
+	if (card->gameport)
+		gameport_unregister_port(card->gameport);
 
 	/* Kill interrupts, and SP/DIF */
 	trident_disable_loop_interrupts(card);
