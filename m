Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290249AbSBNGpl>; Thu, 14 Feb 2002 01:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290423AbSBNGpd>; Thu, 14 Feb 2002 01:45:33 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:33697 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290249AbSBNGp0>; Thu, 14 Feb 2002 01:45:26 -0500
Date: Thu, 14 Feb 2002 08:36:21 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] opl3sa2 size reduction (yes i'm back)
Message-ID: <Pine.LNX.4.44.0202140832440.19317-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces the binary size without losing any functionality. Its 
mostly a cleanup patch. Admittedly there is a bit of variable renaming, 
mainly because the previous names weren't relevant anymore.

2.4.18-pre8 Non-PnP
 text    data     bss     dec     hex filename
   6514     384     384    7282    1c72 drivers/sound/opl3sa2.o

2.4.18-pre8 + patch Non-PnP
  text    data     bss     dec     hex filename
   5594     420     320    6334    18be drivers/sound/opl3sa2.o

2.4.18-pre8 PnP
  text    data     bss     dec     hex filename
   7746     448    1216    9410    24c2 drivers/sound/opl3sa2.o

2.4.18-pre8 + patch PnP
 text    data     bss     dec     hex filename
   6602     448    1152    8202    200a drivers/sound/opl3sa2.o


--- linux-2.4.18-pre8/drivers/sound/opl3sa2.c.orig	Wed Feb 13 22:46:15 2002
+++ linux-2.4.18-pre8/drivers/sound/opl3sa2.c	Thu Feb 14 07:06:07 2002
@@ -56,6 +56,7 @@
  * Scott Murray            Some small cleanups to the init code output.
  *                         (Jan 7, 2001)
  * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
+ * Zwane Mwaikambo	   Code, data structure cleanups. (Feb 13 2002)
  *
  */
 
@@ -70,6 +71,7 @@
 #include "mpu401.h"
 
 #define OPL3SA2_MODULE_NAME	"opl3sa2"
+#define PFX			OPL3SA2_MODULE_NAME ": "
 
 /* Useful control port indexes: */
 #define OPL3SA2_PM	     0x01
@@ -107,6 +109,7 @@
 #define CHIPSET_UNKNOWN -1
 #define CHIPSET_OPL3SA2 0
 #define CHIPSET_OPL3SA3 1
+static const char *CHIPSET_TABLE[] = {"OPL3-SA2", "OPL3-SA3"};
 
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
 #define OPL3SA2_CARDS_MAX 4
@@ -117,38 +120,38 @@
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
-	unsigned char  pm_reg;
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
+
+#if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
+	/* PnP Stuff */
+	struct pci_dev* pdev;
+	int activated;			/* Whether said devices have been activated */
+#endif
+	unsigned char	pm_reg;
+	unsigned int	in_suspend;
+	struct pm_dev	*pmdev;
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
 
 /* Our parameters */
 static int __initdata io	= -1;
@@ -165,11 +168,6 @@
 static int __initdata isapnp = 1;
 static int __initdata multiple = 1;
 
-/* PnP devices */
-struct pci_dev* opl3sa2_dev[OPL3SA2_CARDS_MAX];
-
-/* Whether said devices have been activated */
-static int opl3sa2_activated[OPL3SA2_CARDS_MAX];
 #else
 static int __initdata isapnp; /* = 0 */
 static int __initdata multiple; /* = 0 */
@@ -239,7 +237,7 @@
  * All of the mixer functions...
  */
 
-static void opl3sa2_set_volume(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa2_set_volume(opl3sa2_state_t* devc, int left, int right)
 {
 	static unsigned char scale[101] = {
 		0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0e, 0x0e, 0x0e,
@@ -274,7 +272,7 @@
 }
 
 
-static void opl3sa2_set_mic(opl3sa2_mixerdata* devc, int level)
+static void opl3sa2_set_mic(opl3sa2_state_t* devc, int level)
 {
 	unsigned char vol = 0x1F;
 
@@ -289,7 +287,7 @@
 }
 
 
-static void opl3sa3_set_bass(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa3_set_bass(opl3sa2_state_t* devc, int left, int right)
 {
 	unsigned char bass;
 
@@ -300,7 +298,7 @@
 }
 
 
-static void opl3sa3_set_treble(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa3_set_treble(opl3sa2_state_t* devc, int left, int right)
 {	
 	unsigned char treble;
 
@@ -311,7 +309,7 @@
 }
 
 
-static void opl3sa3_set_wide(opl3sa2_mixerdata* devc, int left, int right)
+static void opl3sa3_set_wide(opl3sa2_state_t* devc, int left, int right)
 {	
 	unsigned char wide;
 
@@ -322,7 +320,7 @@
 }
 
 
-static void opl3sa2_mixer_reset(opl3sa2_mixerdata* devc, int card)
+static void opl3sa2_mixer_reset(opl3sa2_state_t* devc, int card)
 {
 	if(devc) {
 		opl3sa2_set_volume(devc, DEFAULT_VOLUME, DEFAULT_VOLUME);
@@ -331,7 +329,7 @@
 		opl3sa2_set_mic(devc, DEFAULT_MIC);
 		devc->mic = DEFAULT_MIC;
 
-		if(chipset[card] == CHIPSET_OPL3SA3) {
+		if(devc->chipset == CHIPSET_OPL3SA3) {
 			opl3sa3_set_bass(devc, DEFAULT_TIMBRE, DEFAULT_TIMBRE);
 			devc->bass_l = devc->bass_r = DEFAULT_TIMBRE;
 			opl3sa3_set_treble(devc, DEFAULT_TIMBRE, DEFAULT_TIMBRE);
@@ -341,13 +339,13 @@
 }
 
 
-static void opl3sa2_mixer_restore(opl3sa2_mixerdata* devc, int card)
+static void opl3sa2_mixer_restore(opl3sa2_state_t* devc, int card)
 {
 	if (devc) {
 		opl3sa2_set_volume(devc, devc->volume_l, devc->volume_r);
 		opl3sa2_set_mic(devc, devc->mic);
 
-		if (chipset[card] == CHIPSET_OPL3SA3) {
+		if (devc->chipset == CHIPSET_OPL3SA3) {
 			opl3sa3_set_bass(devc, devc->bass_l, devc->bass_r);
 			opl3sa3_set_treble(devc, devc->treble_l, devc->treble_r);
 		}
@@ -389,7 +387,7 @@
 {
 	int cmdf = cmd & 0xff;
 
-	opl3sa2_mixerdata* devc = (opl3sa2_mixerdata*) mixer_devs[dev]->devc;
+	opl3sa2_state_t* devc = (opl3sa2_state_t *) mixer_devs[dev]->devc;
 	
 	switch(cmdf) {
 		case SOUND_MIXER_VOLUME:
@@ -472,7 +470,7 @@
 {
 	int cmdf = cmd & 0xff;
 
-	opl3sa2_mixerdata* devc = (opl3sa2_mixerdata*) mixer_devs[dev]->devc;
+	opl3sa2_state_t* devc = (opl3sa2_state_t *) mixer_devs[dev]->devc;
 
 	switch(cmdf) {
 		case SOUND_MIXER_BASS:
@@ -615,7 +613,7 @@
 			AD1848_REROUTE(SOUND_MIXER_LINE3, SOUND_MIXER_LINE);
 		}
 		else {
-			printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
+			printk(KERN_ERR PFX "MSS mixer not installed?\n");
 		}
 	}
 }
@@ -632,13 +630,12 @@
 	unsigned char misc;
 	unsigned char tmp;
 	unsigned char version;
-	char tag;
 
 	/*
 	 * Try and allocate our I/O port range.
 	 */
 	if(!request_region(hw_config->io_base, 2, OPL3SA2_MODULE_NAME)) {
-		printk(KERN_ERR "opl3sa2: Control I/O port %#x not free\n",
+		printk(KERN_ERR PFX "Control I/O port %#x not free\n",
 		       hw_config->io_base);
 		return 0;
 	}
@@ -651,7 +648,7 @@
 	opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc ^ 0x07);
 	opl3sa2_read(hw_config->io_base, OPL3SA2_MISC, &tmp);
 	if(tmp != misc) {
-		printk(KERN_ERR "opl3sa2: Control I/O port %#x is not a YMF7xx chipset!\n",
+		printk(KERN_ERR PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
 		return 0;
 	}
@@ -664,7 +661,7 @@
 	opl3sa2_read(hw_config->io_base, OPL3SA2_MIC, &tmp);
 	if((tmp & 0x9f) != 0x8a) {
 		printk(KERN_ERR
-		       "opl3sa2: Control I/O port %#x is not a YMF7xx chipset!\n",
+		       PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
 		return 0;
 	}
@@ -677,47 +674,43 @@
 	 * of the miscellaneous register.
 	 */
 	version = misc & 0x07;
-	printk(KERN_DEBUG "opl3sa2: chipset version = %#x\n", version);
+	printk(KERN_DEBUG PFX "chipset version = %#x\n", version);
 	switch(version) {
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
+	if(opl3sa2_state[card].chipset != CHIPSET_UNKNOWN) {
 		/* Generate a pretty name */
-		sprintf(chipset_name[card], "OPL3-SA%c", tag);
+		opl3sa2_state[card].chipset_name = 
+			(char *)CHIPSET_TABLE[opl3sa2_state[card].chipset];
 		return 1;
 	}
 	return 0;
@@ -745,29 +738,27 @@
 static void __init attach_opl3sa2_mixer(struct address_info *hw_config, int card)
 {
 	struct mixer_operations* mixer_operations;
-	opl3sa2_mixerdata* devc;
+	opl3sa2_state_t* devc = &opl3sa2_state[card];
 
 	/* Install master mixer */
-	if(chipset[card] == CHIPSET_OPL3SA3) {
+	if(devc->chipset == CHIPSET_OPL3SA3) {
 		mixer_operations = &opl3sa3_mixer_operations;
 	}
 	else {
 		mixer_operations = &opl3sa2_mixer_operations;
 	}
 
-	if((devc = &opl3sa2_data[card])) {
-		devc->cfg_port = hw_config->io_base;
-
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
 			opl3sa2_mixer_reset(devc, card);
 	}
 }
@@ -802,7 +793,7 @@
 		opl3sa2_write(hw_config->io_base, OPL3SA2_SYS_CTRL, sys_ctrl);
 	}
 	else {
-		printk(KERN_ERR "opl3sa2: not setting ymode, it must be one of 0,1,2,3\n");
+		printk(KERN_ERR PFX "not setting ymode, it must be one of 0,1,2,3\n");
 	}
 }
 
@@ -817,7 +808,7 @@
 		opl3sa2_write(hw_config->io_base, OPL3SA2_MISC, misc);
 	}
 	else {
-		printk(KERN_ERR "opl3sa2: not setting loopback, it must be either 0 or 1\n");
+		printk(KERN_ERR PFX "not setting loopback, it must be either 0 or 1\n");
 	}
 }
 
@@ -828,8 +819,8 @@
 	release_region(hw_config->io_base, 2);
 
 	/* Unload mixer */
-	if(opl3sa2_mixer[card] >= 0)
-		sound_unload_mixerdev(opl3sa2_mixer[card]);
+	if(opl3sa2_state[card].mixer >= 0)
+		sound_unload_mixerdev(opl3sa2_state[card].mixer);
 }
 
 
@@ -867,21 +858,21 @@
 	 */
 	ret = dev->prepare(dev);
 	if(ret && ret != -EBUSY) {
-		printk(KERN_ERR "opl3sa2: ISA PnP found device that could not be autoconfigured.\n");
+		printk(KERN_ERR PFX "ISA PnP found device that could not be autoconfigured.\n");
 		return -ENODEV;
 	}
 	if(ret == -EBUSY) {
-		opl3sa2_activated[card] = 1;
+		opl3sa2_state[card].activated = 1;
 	}
 	else {
 		if(dev->activate(dev) < 0) {
-			printk(KERN_WARNING "opl3sa2: ISA PnP activate failed\n");
-			opl3sa2_activated[card] = 0;
+			printk(KERN_WARNING PFX "ISA PnP activate failed\n");
+			opl3sa2_state[card].activated = 0;
 			return -ENODEV;
 		}
 
 		printk(KERN_DEBUG
-		       "opl3sa2: Activated ISA PnP card %d (active=%d)\n",
+		       PFX "Activated ISA PnP card %d (active=%d)\n",
 		       card, dev->active);
 
 	}
@@ -910,7 +901,7 @@
 	opl3sa2_clear_slots(mss_cfg);
 	opl3sa2_clear_slots(mpu_cfg);
 
-	opl3sa2_dev[card] = dev;
+	opl3sa2_state[card].pdev = dev;
 
 	return 0;
 }
@@ -922,7 +913,7 @@
 static int opl3sa2_suspend(struct pm_dev *pdev, unsigned char pm_mode)
 {
 	unsigned long flags;
-	opl3sa2_mixerdata *p;
+	opl3sa2_state_t *p;
 
 	if (!pdev)
 		return -EINVAL;
@@ -930,7 +921,7 @@
 	save_flags(flags);
 	cli();
 
-	p = (opl3sa2_mixerdata *) pdev->data;
+	p = (opl3sa2_state_t *) pdev->data;
 
 	switch (pm_mode) {
 	case 1:
@@ -962,12 +953,12 @@
 static int opl3sa2_resume(struct pm_dev *pdev)
 {
 	unsigned long flags;
-	opl3sa2_mixerdata *p;
+	opl3sa2_state_t *p;
 
 	if (!pdev)
 		return -EINVAL;
 
-	p = (opl3sa2_mixerdata *) pdev->data;
+	p = (opl3sa2_state_t *) pdev->data;
 	save_flags(flags);
 	cli();
 
@@ -1016,16 +1007,14 @@
 		 * should still be able to disable PNP support for this 
 		 * single driver!
 		 */
-		if(isapnp && opl3sa2_isapnp_probe(&cfg[card],
-						  &cfg_mss[card],
-						  &cfg_mpu[card],
+		if(isapnp && opl3sa2_isapnp_probe(&opl3sa2_state[card].cfg,
+						  &opl3sa2_state[card].cfg_mss,
+						  &opl3sa2_state[card].cfg_mpu,
 						  card) < 0) {
-			if(!opl3sa2_cards_num)
-				printk(KERN_INFO "opl3sa2: No PnP cards found\n");
 			if(io == -1)
 				break;
 			isapnp=0;
-			printk(KERN_INFO "opl3sa2: Search for a card at 0x%d.\n", io);
+			printk(KERN_INFO PFX "Search for a card at 0x%d.\n", io);
 			/* Fall through */
 		}
 #endif
@@ -1035,7 +1024,7 @@
 			if(io == -1 || irq == -1 || dma == -1 ||
 			   dma2 == -1 || mss_io == -1) {
 				printk(KERN_ERR
-				       "opl3sa2: io, mss_io, irq, dma, and dma2 must be set\n");
+				       PFX "io, mss_io, irq, dma, and dma2 must be set\n");
 				return -EINVAL;
 			}
 
@@ -1044,31 +1033,31 @@
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
+		if(!probe_opl3sa2(&opl3sa2_state[card].cfg, card) ||
+		   !probe_opl3sa2_mss(&opl3sa2_state[card].cfg_mss)) {
 			/*
 			 * If one or more cards are already registered, don't
 			 * return an error but print a warning.  Note, this
@@ -1077,7 +1066,7 @@
 			 */
 			if(opl3sa2_cards_num) {
 				printk(KERN_WARNING
-				       "opl3sa2: There was a problem probing one "
+				       PFX "There was a problem probing one "
 				       " of the ISA PNP cards, continuing\n");
 				opl3sa2_cards_num--;
 				continue;
@@ -1085,47 +1074,48 @@
 				return -ENODEV;
 		}
 
-		attach_opl3sa2(&cfg[card], card);
-		conf_printf(chipset_name[card], &cfg[card]);
-		attach_opl3sa2_mss(&cfg_mss[card]);
-		attach_opl3sa2_mixer(&cfg[card], card);
+		attach_opl3sa2(&opl3sa2_state[card].cfg, card);
+		conf_printf(opl3sa2_state[card].chipset_name, &opl3sa2_state[card].cfg);
+		attach_opl3sa2_mss(&opl3sa2_state[card].cfg_mss);
+		attach_opl3sa2_mixer(&opl3sa2_state[card].cfg, card);
 
-		opl3sa2_data[card].card = card;
+		/* ewww =) */
+		opl3sa2_state[card].card = card;
 		/* register our power management capabilities */
-		opl3sa2_data[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
-		if (opl3sa2_data[card].pmdev)
-			opl3sa2_data[card].pmdev->data = &opl3sa2_data[card];
+		opl3sa2_state[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
+		if (opl3sa2_state[card].pmdev)
+			opl3sa2_state[card].pmdev->data = &opl3sa2_state[card];
 
 		/*
 		 * Set the Yamaha 3D enhancement mode (aka Ymersion) if asked to and
 		 * it's supported.
 		 */
 		if(ymode != -1) {
-			if(chipset[card] == CHIPSET_OPL3SA2) {
+			if(opl3sa2_state[card].chipset == CHIPSET_OPL3SA2) {
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
 		if(loopback != -1) {
-			opl3sa2_set_loopback(&cfg[card], loopback);
+			opl3sa2_set_loopback(&opl3sa2_state[card].cfg, loopback);
 		}
 		
 		/* Attach MPU if we've been asked to do so */
-		if(cfg_mpu[card].io_base != -1) {
-			if(probe_opl3sa2_mpu(&cfg_mpu[card])) {
-				attach_opl3sa2_mpu(&cfg_mpu[card]);
+		if(opl3sa2_state[card].cfg_mpu.io_base != -1) {
+			if(probe_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu)) {
+				attach_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
 			}
 		}
 	}
 
 	if(isapnp) {
-		printk(KERN_NOTICE "opl3sa2: %d PnP card(s) found.\n", opl3sa2_cards_num);
+		printk(KERN_NOTICE PFX "%d PnP card(s) found.\n", opl3sa2_cards_num);
 	}
 
 	return 0;
@@ -1140,22 +1130,22 @@
 	int card;
 
 	for(card = 0; card < opl3sa2_cards_num; card++) {
-		if (opl3sa2_data[card].pmdev)
-			pm_unregister(opl3sa2_data[card].pmdev);
+		if (opl3sa2_state[card].pmdev)
+			pm_unregister(opl3sa2_state[card].pmdev);
 
-	        if(cfg_mpu[card].slots[1] != -1) {
-			unload_opl3sa2_mpu(&cfg_mpu[card]);
+	        if(opl3sa2_state[card].cfg_mpu.slots[1] != -1) {
+			unload_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
 		}
-		unload_opl3sa2_mss(&cfg_mss[card]);
-		unload_opl3sa2(&cfg[card], card);
+		unload_opl3sa2_mss(&opl3sa2_state[card].cfg_mss);
+		unload_opl3sa2(&opl3sa2_state[card].cfg, card);
 
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
-		if(opl3sa2_activated[card] && opl3sa2_dev[card]) {
-			opl3sa2_dev[card]->deactivate(opl3sa2_dev[card]);
+		if(opl3sa2_state[card].activated && opl3sa2_state[card].pdev) {
+			opl3sa2_state[card].pdev->deactivate(opl3sa2_state[card].pdev);
 
 			printk(KERN_DEBUG
-			       "opl3sa2: Deactivated ISA PnP card %d (active=%d)\n",
-			       card, opl3sa2_dev[card]->active);
+			       PFX "Deactivated ISA PnP card %d (active=%d)\n",
+			       card, opl3sa2_state[card].pdev->active);
 		}
 #endif
 	}

