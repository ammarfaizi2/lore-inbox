Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263489AbTC2T3x>; Sat, 29 Mar 2003 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263493AbTC2T3x>; Sat, 29 Mar 2003 14:29:53 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:62473 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S263489AbTC2T3j> convert rfc822-to-8bit;
	Sat, 29 Mar 2003 14:29:39 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 2.5] OSS opl3sa2: bring in sync with 2.4
Date: Sat, 29 Mar 2003 20:40:15 +0100
User-Agent: KMail/1.4.3
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303292040.15091.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi adam

for your oss-2.5 tree. this patch brings sound/oss/opl3sa2.c in sync with 2.4.
compiles and works (testes on my toshiba tecra 8000). against 2.5.66-bk

rgds
-daniel



===== sound/oss/opl3sa2.c 1.19 vs edited =====
--- 1.19/sound/oss/opl3sa2.c	Sat Mar 22 21:43:27 2003
+++ edited/sound/oss/opl3sa2.c	Sat Mar 29 18:49:37 2003
@@ -58,6 +58,10 @@
  * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
  *
  * Adam Belay              Converted driver to new PnP Layer (Oct 12, 2002)
+ * Zwane Mwaikambo	   Code, data structure cleanups. (Feb 15 2002)
+ * Zwane Mwaikambo	   Free resources during auxiliary device probe
+ * 			   failures (Apr 29 2002)
+ *   
  */
 
 #include <linux/config.h>
@@ -71,6 +75,9 @@
 #include "ad1848.h"
 #include "mpu401.h"
 
+#define OPL3SA2_MODULE_NAME	"opl3sa2"
+#define PFX			OPL3SA2_MODULE_NAME ": "
+
 /* Useful control port indexes: */
 #define OPL3SA2_PM	     0x01
 #define OPL3SA2_SYS_CTRL     0x02
@@ -91,9 +98,11 @@
 #define DEFAULT_TIMBRE 0
 
 /* Power saving modes */
-#define OPL3SA2_PM_MODE1	0x05
-#define OPL3SA2_PM_MODE2	0x04
-#define OPL3SA2_PM_MODE3	0x03
+#define OPL3SA2_PM_MODE0	0x00
+#define OPL3SA2_PM_MODE1	0x04	/* PSV */
+#define OPL3SA2_PM_MODE2	0x05	/* PSV | PDX */
+#define OPL3SA2_PM_MODE3	0x27	/* ADOWN | PSV | PDN | PDX */
+
 
 /* For checking against what the card returns: */
 #define VERSION_UNKNOWN 0
@@ -107,6 +116,7 @@
 #define CHIPSET_UNKNOWN -1
 #define CHIPSET_OPL3SA2 0
 #define CHIPSET_OPL3SA3 1
+static const char *CHIPSET_TABLE[] = {"OPL3-SA2", "OPL3-SA3"};
 
 #ifdef CONFIG_PNP
 #define OPL3SA2_CARDS_MAX 4
@@ -117,40 +127,41 @@
 /* This should be pretty obvious */
 static int opl3sa2_cards_num; /* = 0 */
 
-/* What's my version(s)? */
-static int chipset[OPL3SA2_CARDS_MAX] = { CHIPSET_UNKNOWN };
-
-/* Oh well, let's just cache the name(s) */
-static char chipset_name[OPL3SA2_CARDS_MAX][12];
-
-/* Where's my mixer(s)? */
-static int opl3sa2_mixer[OPL3SA2_CARDS_MAX] = { -1 };
-
-/* Bag o' mixer data */
-typedef struct opl3sa2_mixerdata_tag {
+typedef struct {
+	/* device resources */
 	unsigned short cfg_port;
-	unsigned short padding;
-	unsigned char  reg;
-	unsigned int   in_suspend;
-	struct pm_dev  *pmdev;
-	unsigned int   card;
-	unsigned int   volume_l;
-	unsigned int   volume_r;
-	unsigned int   mic;
-	unsigned int   bass_l;
-	unsigned int   bass_r;
-	unsigned int   treble_l;
-	unsigned int   treble_r;
-	unsigned int   wide_l;
-	unsigned int   wide_r;
-} opl3sa2_mixerdata;
-static opl3sa2_mixerdata opl3sa2_data[OPL3SA2_CARDS_MAX];
-
-static struct address_info cfg[OPL3SA2_CARDS_MAX];
-static struct address_info cfg_mss[OPL3SA2_CARDS_MAX];
-static struct address_info cfg_mpu[OPL3SA2_CARDS_MAX];
+	struct address_info cfg;
+	struct address_info cfg_mss;
+	struct address_info cfg_mpu;
+#ifdef CONFIG_PNP
+	/* PnP Stuff */
+	struct pnp_dev* pdev;
+	int activated;			/* Whether said devices have been activated */
+#endif
+#ifdef CONFIG_PM
+	unsigned int	in_suspend;
+	struct pm_dev	*pmdev;
+#endif
+	unsigned int	card;
+	int		chipset;	/* What's my version(s)? */
+	char		*chipset_name;
+
+	/* mixer data */
+	int		mixer;
+	unsigned int	volume_l;
+	unsigned int	volume_r;
+	unsigned int	mic;
+	unsigned int	bass_l;
+	unsigned int	bass_r;
+	unsigned int	treble_l;
+	unsigned int	treble_r;
+	unsigned int	wide_l;
+	unsigned int	wide_r;
+} opl3sa2_state_t;
+static opl3sa2_state_t opl3sa2_state[OPL3SA2_CARDS_MAX];
 
-static spinlock_t	lock=SPIN_LOCK_UNLOCKED;
+static spinlock_t opl3sa2_lock = SPIN_LOCK_UNLOCKED;
+	
 
 /* Our parameters */
 static int __initdata io	= -1;
@@ -241,7 +252,7 @@
  * All of the mixer functions...
  */
 
-static void opl3sa2_set_volume(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa2_set_volume(opl3sa2_state_t* devc, int left, int right)
 {
 	static unsigned char scale[101] = {
 		0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0e, 0x0e, 0x0e,
@@ -276,7 +287,7 @@
 }
 
 
-static void opl3sa2_set_mic(opl3sa2_mixerdata* devc, int level)
+static void opl3sa2_set_mic(opl3sa2_state_t* devc, int level)
 {
 	unsigned char vol = 0x1F;
 
@@ -291,7 +302,7 @@
 }
 
 
-static void opl3sa3_set_bass(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa3_set_bass(opl3sa2_state_t* devc, int left, int right)
 {
 	unsigned char bass;
 
@@ -302,7 +313,7 @@
 }
 
 
-static void opl3sa3_set_treble(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa3_set_treble(opl3sa2_state_t* devc, int left, int right)
 {	
 	unsigned char treble;
 
@@ -313,7 +324,7 @@
 }
 
 
-static void opl3sa3_set_wide(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa3_set_wide(opl3sa2_state_t* devc, int left, int right)
 {	
 	unsigned char wide;
 
@@ -324,16 +335,16 @@
 }
 
 
-static void opl3sa2_mixer_reset(opl3sa2_mixerdata* devc, int card)
+static void opl3sa2_mixer_reset(opl3sa2_state_t* devc)
 {
-	if(devc) {
+	if (devc) {
 		opl3sa2_set_volume(devc, DEFAULT_VOLUME, DEFAULT_VOLUME);
 		devc->volume_l = devc->volume_r = DEFAULT_VOLUME;
 
 		opl3sa2_set_mic(devc, DEFAULT_MIC);
 		devc->mic = DEFAULT_MIC;
 
-		if(chipset[card] == CHIPSET_OPL3SA3) {
+		if (devc->chipset == CHIPSET_OPL3SA3) {
 			opl3sa3_set_bass(devc, DEFAULT_TIMBRE, DEFAULT_TIMBRE);
 			devc->bass_l = devc->bass_r = DEFAULT_TIMBRE;
 			opl3sa3_set_treble(devc, DEFAULT_TIMBRE, DEFAULT_TIMBRE);
@@ -343,13 +354,13 @@
 }
 
 
-static void opl3sa2_mixer_restore(opl3sa2_mixerdata* devc, int card)
+static void opl3sa2_mixer_restore(opl3sa2_state_t* devc)
 {
 	if (devc) {
 		opl3sa2_set_volume(devc, devc->volume_l, devc->volume_r);
 		opl3sa2_set_mic(devc, devc->mic);
 
-		if (chipset[card] == CHIPSET_OPL3SA3) {
+		if (devc->chipset == CHIPSET_OPL3SA3) {
 			opl3sa3_set_bass(devc, devc->bass_l, devc->bass_r);
 			opl3sa3_set_treble(devc, devc->treble_l, devc->treble_r);
 		}
@@ -391,9 +402,9 @@
 {
 	int cmdf = cmd & 0xff;
 
-	opl3sa2_mixerdata* devc = (opl3sa2_mixerdata*) mixer_devs[dev]->devc;
+	opl3sa2_state_t* devc = &opl3sa2_state[dev];
 	
-	switch(cmdf) {
+	switch (cmdf) {
 		case SOUND_MIXER_VOLUME:
 		case SOUND_MIXER_MIC:
 		case SOUND_MIXER_DEVMASK:
@@ -407,10 +418,10 @@
 			return -EINVAL;
 	}
 	
-	if(((cmd >> 8) & 0xff) != 'M')
+	if (((cmd >> 8) & 0xff) != 'M')
 		return -EINVAL;
 		
-	if(_SIOC_DIR (cmd) & _SIOC_WRITE) {
+	if (_SIOC_DIR (cmd) & _SIOC_WRITE) {
 		switch (cmdf) {
 			case SOUND_MIXER_VOLUME:
 				arg_to_vol_stereo(*(unsigned int*)arg,
@@ -474,9 +485,9 @@
 {
 	int cmdf = cmd & 0xff;
 
-	opl3sa2_mixerdata* devc = (opl3sa2_mixerdata*) mixer_devs[dev]->devc;
+	opl3sa2_state_t* devc = &opl3sa2_state[dev];
 
-	switch(cmdf) {
+	switch (cmdf) {
 		case SOUND_MIXER_BASS:
 		case SOUND_MIXER_TREBLE:
 		case SOUND_MIXER_DIGITAL1:
@@ -488,10 +499,10 @@
 			return opl3sa2_mixer_ioctl(dev, cmd, arg);
 	}
 
-	if(((cmd >> 8) & 0xff) != 'M')
+	if (((cmd >> 8) & 0xff) != 'M')
 		return -EINVAL;
 		
-	if(_SIOC_DIR (cmd) & _SIOC_WRITE) {
+	if (_SIOC_DIR (cmd) & _SIOC_WRITE) {
 		switch (cmdf) {
 			case SOUND_MIXER_BASS:
 				arg_to_vol_stereo(*(unsigned int*)arg,
@@ -584,9 +595,9 @@
 }
 
 
-static inline void __init attach_opl3sa2_mpu(struct address_info* hw_config)
+static inline int __init attach_opl3sa2_mpu(struct address_info* hw_config)
 {
-	attach_mpu401(hw_config, THIS_MODULE);
+	return attach_mpu401(hw_config, THIS_MODULE);
 }
 
 
@@ -608,7 +619,7 @@
 
 	initial_mixers = num_mixers;
 	attach_ms_sound(hw_config, THIS_MODULE);	/* Slot 0 */
-	if(hw_config->slots[0] != -1) {
+	if (hw_config->slots[0] != -1) {
 		/* Did the MSS driver install? */
 		if(num_mixers == (initial_mixers + 1)) {
 			/* The MSS mixer is installed, reroute mixers appropiately */
@@ -617,7 +628,7 @@
 			AD1848_REROUTE(SOUND_MIXER_LINE3, SOUND_MIXER_LINE);
 		}
 		else {
-			printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
+			printk(KERN_ERR PFX "MSS mixer not installed?\n");
 		}
 	}
 }
@@ -634,15 +645,14 @@
 	unsigned char misc;
 	unsigned char tmp;
 	unsigned char version;
-	char tag;
 
 	/*
-	 * Verify that the I/O port range is free.
+	 * Try and allocate our I/O port range.
 	 */
-	if(check_region(hw_config->io_base, 2)) {
-		printk(KERN_ERR "opl3sa2: Control I/O port %#x not free\n",
+	if (!request_region(hw_config->io_base, 2, OPL3SA2_MODULE_NAME)) {
+		printk(KERN_ERR PFX "Control I/O port %#x not free\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_nodev;
 	}
 
 	/*
@@ -653,9 +663,9 @@
 	opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc ^ 0x07);
 	opl3sa2_read(hw_config->io_base, OPL3SA2_MISC, &tmp);
 	if(tmp != misc) {
-		printk(KERN_ERR "opl3sa2: Control I/O port %#x is not a YMF7xx chipset!\n",
+		printk(KERN_ERR PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_region;
 	}
 
 	/*
@@ -666,9 +676,9 @@
 	opl3sa2_read(hw_config->io_base, OPL3SA2_MIC, &tmp);
 	if((tmp & 0x9f) != 0x8a) {
 		printk(KERN_ERR
-		       "opl3sa2: Control I/O port %#x is not a YMF7xx chipset!\n",
+		       PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_region;
 	}
 	opl3sa2_write(hw_config->io_base, OPL3SA2_MIC, tmp);
 
@@ -679,57 +689,54 @@
 	 * of the miscellaneous register.
 	 */
 	version = misc & 0x07;
-	printk(KERN_DEBUG "opl3sa2: chipset version = %#x\n", version);
-	switch(version) {
+	printk(KERN_DEBUG PFX "Chipset version = %#x\n", version);
+	switch (version) {
 		case 0:
-			chipset[card] = CHIPSET_UNKNOWN;
-			tag = '?'; /* silence compiler warning */
+			opl3sa2_state[card].chipset = CHIPSET_UNKNOWN;
 			printk(KERN_ERR
-			       "opl3sa2: Unknown Yamaha audio controller version\n");
+			       PFX "Unknown Yamaha audio controller version\n");
 			break;
 
 		case VERSION_YMF711:
-			chipset[card] = CHIPSET_OPL3SA2;
-			tag = '2';
-			printk(KERN_INFO "opl3sa2: Found OPL3-SA2 (YMF711)\n");
+			opl3sa2_state[card].chipset = CHIPSET_OPL3SA2;
+			printk(KERN_INFO PFX "Found OPL3-SA2 (YMF711)\n");
 			break;
 
 		case VERSION_YMF715:
-			chipset[card] = CHIPSET_OPL3SA3;
-			tag = '3';
+			opl3sa2_state[card].chipset = CHIPSET_OPL3SA3;
 			printk(KERN_INFO
-			       "opl3sa2: Found OPL3-SA3 (YMF715 or YMF719)\n");
+			       PFX "Found OPL3-SA3 (YMF715 or YMF719)\n");
 			break;
 
 		case VERSION_YMF715B:
-			chipset[card] = CHIPSET_OPL3SA3;
-			tag = '3';
+			opl3sa2_state[card].chipset = CHIPSET_OPL3SA3;
 			printk(KERN_INFO
-			       "opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)\n");
+			       PFX "Found OPL3-SA3 (YMF715B or YMF719B)\n");
 			break;
 
 		case VERSION_YMF715E:
 		default:
-			chipset[card] = CHIPSET_OPL3SA3;
-			tag = '3';
+			opl3sa2_state[card].chipset = CHIPSET_OPL3SA3;
 			printk(KERN_INFO
-			       "opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)\n");
+			       PFX "Found OPL3-SA3 (YMF715E or YMF719E)\n");
 			break;
 	}
 
-	if(chipset[card] != CHIPSET_UNKNOWN) {
+	if (opl3sa2_state[card].chipset != CHIPSET_UNKNOWN) {
 		/* Generate a pretty name */
-		sprintf(chipset_name[card], "OPL3-SA%c", tag);
-		return 1;
+		opl3sa2_state[card].chipset_name = (char *)CHIPSET_TABLE[opl3sa2_state[card].chipset];
+		return 0;
 	}
-	return 0;
+
+out_region:
+	release_region(hw_config->io_base, 2);
+out_nodev:
+	return -ENODEV;
 }
 
 
 static void __init attach_opl3sa2(struct address_info* hw_config, int card)
 {
-   	request_region(hw_config->io_base, 2, chipset_name[card]);
-
 	/* Initialize IRQ configuration to IRQ-B: -, IRQ-A: WSS+MPU+OPL3 */
 	opl3sa2_write(hw_config->io_base, OPL3SA2_IRQ_CONFIG, 0x0d);
 
@@ -748,30 +755,29 @@
 static void __init attach_opl3sa2_mixer(struct address_info *hw_config, int card)
 {
 	struct mixer_operations* mixer_operations;
-	opl3sa2_mixerdata* devc;
+	opl3sa2_state_t* devc = &opl3sa2_state[card];
 
 	/* Install master mixer */
-	if(chipset[card] == CHIPSET_OPL3SA3) {
+	if (devc->chipset == CHIPSET_OPL3SA3) {
 		mixer_operations = &opl3sa3_mixer_operations;
 	}
 	else {
 		mixer_operations = &opl3sa2_mixer_operations;
 	}
 
-	if((devc = &opl3sa2_data[card])) {
-		devc->cfg_port = hw_config->io_base;
+	devc->cfg_port = hw_config->io_base;
+	devc->mixer = sound_install_mixer(MIXER_DRIVER_VERSION,
+					  mixer_operations->name,
+					  mixer_operations,
+					  sizeof(struct mixer_operations),
+					  devc);
+	if(devc->mixer < 0) {
+		printk(KERN_ERR PFX "Could not install %s master mixer\n",
+			 mixer_operations->name);
+	}
+	else {
+			opl3sa2_mixer_reset(devc);
 
-		opl3sa2_mixer[card] = sound_install_mixer(MIXER_DRIVER_VERSION,
-							  mixer_operations->name,
-							  mixer_operations,
-							  sizeof(struct mixer_operations),
-							  devc);
-		if(opl3sa2_mixer[card] < 0) {
-			printk(KERN_ERR "opl3sa2: Could not install %s master mixer\n",
-				 mixer_operations->name);
-		}
-		else
-			opl3sa2_mixer_reset(devc, card);
 	}
 }
 
@@ -805,7 +811,7 @@
 		opl3sa2_write(hw_config->io_base, OPL3SA2_SYS_CTRL, sys_ctrl);
 	}
 	else {
-		printk(KERN_ERR "opl3sa2: not setting ymode, it must be one of 0,1,2,3\n");
+		printk(KERN_ERR PFX "not setting ymode, it must be one of 0,1,2,3\n");
 	}
 }
 
@@ -820,7 +826,7 @@
 		opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc);
 	}
 	else {
-		printk(KERN_ERR "opl3sa2: not setting loopback, it must be either 0 or 1\n");
+		printk(KERN_ERR PFX "not setting loopback, it must be either 0 or 1\n");
 	}
 }
 
@@ -831,8 +837,9 @@
 	release_region(hw_config->io_base, 2);
 
 	/* Unload mixer */
-	if(opl3sa2_mixer[card] >= 0)
-		sound_unload_mixerdev(opl3sa2_mixer[card]);
+	if(opl3sa2_state[card].mixer >= 0)
+		sound_unload_mixerdev(opl3sa2_state[card].mixer);
+
 }
 
 #ifdef CONFIG_PNP
@@ -846,35 +853,40 @@
 static int opl3sa2_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	int card = opl3sa2_cards_num;
+
+	/* we don't actually want to return an error as the user may have specified
+	 * no multiple card search
+	 */
+
 	if (opl3sa2_cards_num == OPL3SA2_CARDS_MAX)
 		return 0;
 	opl3sa2_activated[card] = 1;
 
 	/* Our own config: */
-	cfg[card].io_base = pnp_port_start(dev, 4);
-	cfg[card].irq     = pnp_irq(dev, 0);
-	cfg[card].dma     = pnp_dma(dev, 0);
-	cfg[card].dma2    = pnp_dma(dev, 1);
+	opl3sa2_state[card].cfg.io_base = pnp_port_start(dev, 4);
+	opl3sa2_state[card].cfg.irq     = pnp_irq(dev, 0);
+	opl3sa2_state[card].cfg.dma     = pnp_dma(dev, 0);
+	opl3sa2_state[card].cfg.dma2    = pnp_dma(dev, 1);
 
 	/* The MSS config: */
-	cfg_mss[card].io_base      = pnp_port_start(dev, 1);
-	cfg_mss[card].irq          = pnp_irq(dev, 0);
-	cfg_mss[card].dma          = pnp_dma(dev, 0);
-	cfg_mss[card].dma2         = pnp_dma(dev, 1);
-	cfg_mss[card].card_subtype = 1; /* No IRQ or DMA setup */
-
-	cfg_mpu[card].io_base       = pnp_port_start(dev, 3);
-	cfg_mpu[card].irq           = pnp_irq(dev, 0);
-	cfg_mpu[card].dma           = -1;
-	cfg_mpu[card].dma2          = -1;
-	cfg_mpu[card].always_detect = 1; /* It's there, so use shared IRQs */
+	opl3sa2_state[card].cfg_mss.io_base      = pnp_port_start(dev, 1);
+	opl3sa2_state[card].cfg_mss.irq          = pnp_irq(dev, 0);
+	opl3sa2_state[card].cfg_mss.dma          = pnp_dma(dev, 0);
+	opl3sa2_state[card].cfg_mss.dma2         = pnp_dma(dev, 1);
+	opl3sa2_state[card].cfg_mss.card_subtype = 1; /* No IRQ or DMA setup */
+
+	opl3sa2_state[card].cfg_mpu.io_base       = pnp_port_start(dev, 3);
+	opl3sa2_state[card].cfg_mpu.irq           = pnp_irq(dev, 0);
+	opl3sa2_state[card].cfg_mpu.dma           = -1;
+	opl3sa2_state[card].cfg_mpu.dma2          = -1;
+	opl3sa2_state[card].cfg_mpu.always_detect = 1; /* It's there, so use shared IRQs */
 
 	/* Call me paranoid: */
-	opl3sa2_clear_slots(&cfg[card]);
-	opl3sa2_clear_slots(&cfg_mss[card]);
-	opl3sa2_clear_slots(&cfg_mpu[card]);
+	opl3sa2_clear_slots(&opl3sa2_state[card].cfg);
+	opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mss);
+	opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mpu);
 
-	opl3sa2_dev[card] = dev;
+	opl3sa2_state[card].pdev = dev;
 	opl3sa2_cards_num++;
 
 	return 0;
@@ -890,19 +902,19 @@
 
 /* End of component functions */
 
+#ifdef CONFIG_PM
 /* Power Management support functions */
-static int opl3sa2_suspend(struct pm_dev *pdev, unsigned char pm_mode)
+static int opl3sa2_suspend(struct pm_dev *pdev, unsigned int pm_mode)
 {
 	unsigned long flags;
-	opl3sa2_mixerdata *p;
+	opl3sa2_state_t *p;
 
 	if (!pdev)
 		return -EINVAL;
 
-	spin_lock_irqsave(&lock,flags);
+	spin_lock_irqsave(&opl3sa2_lock,flags);
 
-	p = (opl3sa2_mixerdata *) pdev->data;
-	p->in_suspend = 1;
+	p = (opl3sa2_state_t *) pdev->data;
 	switch (pm_mode) {
 	case 1:
 		pm_mode = OPL3SA2_PM_MODE1;
@@ -914,37 +926,42 @@
 		pm_mode = OPL3SA2_PM_MODE3;
 		break;
 	default:
-		pm_mode = OPL3SA2_PM_MODE3;
-		break;
+		/* we don't know howto handle this... */
+		spin_unlock_irqrestore(&opl3sa2_lock, flags);
+		return -EBUSY;
 	}
 
+	p->in_suspend = 1;
+
 	/* its supposed to automute before suspending, so we won't bother */
-	opl3sa2_read(p->cfg_port, OPL3SA2_PM, &p->reg);
-	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg | pm_mode);
+	opl3sa2_write(p->cfg_port, OPL3SA2_PM, pm_mode);
+	/* wait a while for the clock oscillator to stabilise */
+	mdelay(10);
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&opl3sa2_lock,flags);
 	return 0;
 }
 
 static int opl3sa2_resume(struct pm_dev *pdev)
 {
 	unsigned long flags;
-	opl3sa2_mixerdata *p;
+	opl3sa2_state_t *p;
 
-	if (!pdev)
-		return -EINVAL;
+ 	if (!pdev)
+ 		return -EINVAL;
 
-	p = (opl3sa2_mixerdata *) pdev->data;
-	spin_lock_irqsave(&lock,flags);	
+	p = (opl3sa2_state_t *) pdev->data;
+	spin_lock_irqsave(&opl3sa2_lock,flags);
 
-	/* I don't think this is necessary */
-	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg);
-	opl3sa2_mixer_restore(p, p->card);
-	p->in_suspend = 0;
+ 	/* I don't think this is necessary */
+	opl3sa2_write(p->cfg_port, OPL3SA2_PM, OPL3SA2_PM_MODE0);
+	opl3sa2_mixer_restore(p);
+ 	p->in_suspend = 0;
 
-	spin_unlock_irqrestore(&lock,flags);
+	spin_unlock_irqrestore(&opl3sa2_lock,flags);
 	return 0;
 }
+#endif /* CONFIG_PM */
 
 static int opl3sa2_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
 {
@@ -967,8 +984,7 @@
  */
 static int __init init_opl3sa2(void)
 {
-        int card;
-	int max;
+	int card, max;
 
 	/* Sanitize isapnp and multiple settings */
 	isapnp = isapnp != 0 ? 1 : 0;
@@ -980,64 +996,69 @@
 	if (isapnp){
 		pnp_register_driver(&opl3sa2_driver);
 		if(!opl3sa2_cards_num){
-			printk(KERN_INFO "opl3sa2: No PnP cards found\n");
+			printk(KERN_INFO PFX "No PnP cards found\n");
 			isapnp = 0;
 		}
 		max = opl3sa2_cards_num;
 	}
 #endif
 
-	for(card = 0; card < max; card++) {
+	for (card = 0; card < max; card++) {
 		/* If a user wants an I/O then assume they meant it */
 		
-		if(!isapnp) {
-			if(io == -1 || irq == -1 || dma == -1 ||
-			   dma2 == -1 || mss_io == -1) {
+		if (!isapnp) {
+			if (io == -1 || irq == -1 || dma == -1 ||
+			    dma2 == -1 || mss_io == -1) {
 				printk(KERN_ERR
-				       "opl3sa2: io, mss_io, irq, dma, and dma2 must be set\n");
+				       PFX "io, mss_io, irq, dma, and dma2 must be set\n");
 				return -EINVAL;
-				opl3sa2_cards_num++;
 			}
+			opl3sa2_cards_num++;
 
 			/*
 			 * Our own config:
 			 * (NOTE: IRQ and DMA aren't used, so they're set to
 			 *  give pretty output from conf_printf. :)
 			 */
-			cfg[card].io_base = io;
-			cfg[card].irq     = irq;
-			cfg[card].dma     = dma;
-			cfg[card].dma2    = dma2;
+			opl3sa2_state[card].cfg.io_base = io;
+			opl3sa2_state[card].cfg.irq     = irq;
+			opl3sa2_state[card].cfg.dma     = dma;
+			opl3sa2_state[card].cfg.dma2    = dma2;
 	
 			/* The MSS config: */
-			cfg_mss[card].io_base      = mss_io;
-			cfg_mss[card].irq          = irq;
-			cfg_mss[card].dma          = dma;
-			cfg_mss[card].dma2         = dma2;
-			cfg_mss[card].card_subtype = 1; /* No IRQ or DMA setup */
-
-			cfg_mpu[card].io_base       = mpu_io;
-			cfg_mpu[card].irq           = irq;
-			cfg_mpu[card].dma           = -1;
-			cfg_mpu[card].always_detect = 1; /* Use shared IRQs */
+			opl3sa2_state[card].cfg_mss.io_base      = mss_io;
+			opl3sa2_state[card].cfg_mss.irq          = irq;
+			opl3sa2_state[card].cfg_mss.dma          = dma;
+			opl3sa2_state[card].cfg_mss.dma2         = dma2;
+			opl3sa2_state[card].cfg_mss.card_subtype = 1; /* No IRQ or DMA setup */
+
+			opl3sa2_state[card].cfg_mpu.io_base       = mpu_io;
+			opl3sa2_state[card].cfg_mpu.irq           = irq;
+			opl3sa2_state[card].cfg_mpu.dma           = -1;
+			opl3sa2_state[card].cfg_mpu.always_detect = 1; /* Use shared IRQs */
 
 			/* Call me paranoid: */
-			opl3sa2_clear_slots(&cfg[card]);
-			opl3sa2_clear_slots(&cfg_mss[card]);
-			opl3sa2_clear_slots(&cfg_mpu[card]);
+			opl3sa2_clear_slots(&opl3sa2_state[card].cfg);
+			opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mss);
+			opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mpu);
 		}
 
-		if(!probe_opl3sa2(&cfg[card], card) ||
-		   !probe_opl3sa2_mss(&cfg_mss[card])) {
+		if (probe_opl3sa2(&opl3sa2_state[card].cfg, card))
+			return -ENODEV;
+
+
+		if (!probe_opl3sa2_mss(&opl3sa2_state[card].cfg_mss)) {
 			/*
 			 * If one or more cards are already registered, don't
 			 * return an error but print a warning.  Note, this
 			 * should never really happen unless the hardware or
 			 * ISA PnP screwed up.
 			 */
-			if(opl3sa2_cards_num) {
+			release_region(opl3sa2_state[card].cfg.io_base, 2);
+
+			if (opl3sa2_cards_num) {
 				printk(KERN_WARNING
-				       "opl3sa2: There was a problem probing one "
+				       PFX "There was a problem probing one "
 				       " of the ISA PNP cards, continuing\n");
 				opl3sa2_cards_num--;
 				continue;
@@ -1045,47 +1066,53 @@
 				return -ENODEV;
 		}
 
-		attach_opl3sa2(&cfg[card], card);
-		conf_printf(chipset_name[card], &cfg[card]);
-		attach_opl3sa2_mss(&cfg_mss[card]);
-		attach_opl3sa2_mixer(&cfg[card], card);
-
-		opl3sa2_data[card].card = card;
+		attach_opl3sa2(&opl3sa2_state[card].cfg, card);
+		conf_printf(opl3sa2_state[card].chipset_name, &opl3sa2_state[card].cfg);
+		attach_opl3sa2_mixer(&opl3sa2_state[card].cfg, card);
+		attach_opl3sa2_mss(&opl3sa2_state[card].cfg_mss);
+
+		/* ewww =) */
+		opl3sa2_state[card].card = card;
+#ifdef CONFIG_PM
 		/* register our power management capabilities */
-		opl3sa2_data[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
-		if (opl3sa2_data[card].pmdev)
-			opl3sa2_data[card].pmdev->data = &opl3sa2_data[card];
+		opl3sa2_state[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
+		if (opl3sa2_state[card].pmdev)
+			opl3sa2_state[card].pmdev->data = &opl3sa2_state[card];
+#endif /* CONFIG_PM */
 
 		/*
 		 * Set the Yamaha 3D enhancement mode (aka Ymersion) if asked to and
 		 * it's supported.
 		 */
-		if(ymode != -1) {
-			if(chipset[card] == CHIPSET_OPL3SA2) {
+		if (ymode != -1) {
+			if (opl3sa2_state[card].chipset == CHIPSET_OPL3SA2) {
 				printk(KERN_ERR
-				       "opl3sa2: ymode not supported on OPL3-SA2\n");
+				       PFX "ymode not supported on OPL3-SA2\n");
 			}
 			else {
-				opl3sa2_set_ymode(&cfg[card], ymode);
+				opl3sa2_set_ymode(&opl3sa2_state[card].cfg, ymode);
 			}
 		}
 
 
 		/* Set A/D input to Mono loopback if asked to. */
-		if(loopback != -1) {
-			opl3sa2_set_loopback(&cfg[card], loopback);
+		if (loopback != -1) {
+			opl3sa2_set_loopback(&opl3sa2_state[card].cfg, loopback);
 		}
 		
-		/* Attach MPU if we've been asked to do so */
-		if(cfg_mpu[card].io_base != -1) {
-			if(probe_opl3sa2_mpu(&cfg_mpu[card])) {
-				attach_opl3sa2_mpu(&cfg_mpu[card]);
+		/* Attach MPU if we've been asked to do so, failure isn't fatal */
+		if (opl3sa2_state[card].cfg_mpu.io_base != -1) {
+			if (probe_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu)) {
+				if (attach_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu)) {
+					printk(KERN_ERR PFX "failed to attach MPU401\n");
+					opl3sa2_state[card].cfg_mpu.slots[1] = -1;
+				}
 			}
 		}
 	}
 
-	if(isapnp) {
-		printk(KERN_NOTICE "opl3sa2: %d PnP card(s) found.\n", opl3sa2_cards_num);
+	if (isapnp) {
+		printk(KERN_NOTICE PFX "%d PnP card(s) found.\n", opl3sa2_cards_num);
 	}
 
 	return 0;
@@ -1100,15 +1127,14 @@
 	int card;
 
 	for(card = 0; card < opl3sa2_cards_num; card++) {
-		if (opl3sa2_data[card].pmdev)
-			pm_unregister(opl3sa2_data[card].pmdev);
-
-	        if(cfg_mpu[card].slots[1] != -1) {
-			unload_opl3sa2_mpu(&cfg_mpu[card]);
-		}
-		unload_opl3sa2_mss(&cfg_mss[card]);
-		unload_opl3sa2(&cfg[card], card);
+		if (opl3sa2_state[card].pmdev)
+			pm_unregister(opl3sa2_state[card].pmdev);
 
+	        if(opl3sa2_state[card].cfg_mpu.slots[1] != -1) {
+			unload_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
+ 		}
+		unload_opl3sa2_mss(&opl3sa2_state[card].cfg_mss);
+		unload_opl3sa2(&opl3sa2_state[card].cfg, card);
 #ifdef CONFIG_PNP
 		pnp_unregister_driver(&opl3sa2_driver);
 #endif

