Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbRECTzG>; Thu, 3 May 2001 15:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133097AbRECTyt>; Thu, 3 May 2001 15:54:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24271 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S133040AbRECTye>;
	Thu, 3 May 2001 15:54:34 -0400
Message-ID: <3AF1B76C.409D8F3E@mandrakesoft.com>
Date: Thu, 03 May 2001 15:54:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Mathieu Arnold <arn_mat@club-internet.fr>,
        Marcus Meissner <Marcus.Meissner@caldera.de>,
        Danny ter Haar <dth@trinity.hoho.nl>
Subject: PATCH 2.4.4: nm256 audio use ac97_codec
Content-Type: multipart/mixed;
 boundary="------------DBDFF5F8B9C26835CB7DAB1C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DBDFF5F8B9C26835CB7DAB1C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a patch against 2.4.4 which updates nm256_audio driver to
use the newer, and maintained, ac97 codec driver.

I'm interested in feedback and testing on this patch -- there should be
_no_ change in behavior.  If nm256 worked before, it should work now. 
If nm256 didn't work before, it probably will remain broken after this
patch.  [there is a slight chance this patch fixes problems, though....]

Note this patch includes changes found in the 'ac' tree, notably Marcus'
update to the new PCI API.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
--------------DBDFF5F8B9C26835CB7DAB1C
Content-Type: text/plain; charset=us-ascii;
 name="nm1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nm1.patch"

diff -urN linux-2.4.4/drivers/sound/Makefile linux-nm/drivers/sound/Makefile
--- linux-2.4.4/drivers/sound/Makefile	Fri Apr 13 23:26:07 2001
+++ linux-nm/drivers/sound/Makefile	Thu May  3 15:25:10 2001
@@ -54,7 +54,7 @@
 obj-$(CONFIG_SOUND_MSNDCLAS)	+= msnd.o msnd_classic.o
 obj-$(CONFIG_SOUND_MSNDPIN)	+= msnd.o msnd_pinnacle.o
 obj-$(CONFIG_SOUND_VWSND)	+= vwsnd.o
-obj-$(CONFIG_SOUND_NM256)	+= nm256_audio.o ac97.o
+obj-$(CONFIG_SOUND_NM256)	+= nm256_audio.o ac97_codec.o
 obj-$(CONFIG_SOUND_ICH)		+= i810_audio.o ac97_codec.o
 obj-$(CONFIG_SOUND_SONICVIBES)	+= sonicvibes.o
 obj-$(CONFIG_SOUND_CMPCI)	+= cmpci.o
diff -urN linux-2.4.4/drivers/sound/nm256.h linux-nm/drivers/sound/nm256.h
--- linux-2.4.4/drivers/sound/nm256.h	Mon Dec 11 16:02:32 2000
+++ linux-nm/drivers/sound/nm256.h	Thu May  3 15:22:42 2001
@@ -1,7 +1,6 @@
 #ifndef _NM256_H_
 #define _NM256_H_
 
-#include "ac97.h"
 
 /* The revisions that we currently handle.  */
 enum nm256rev {
@@ -18,7 +17,7 @@
     /* Revision number */
     enum nm256rev rev;
 
-    struct ac97_hwint mdev;
+    struct ac97_codec ac97;
 
     /* Our audio device numbers. */
     int dev[2];
@@ -32,9 +31,6 @@
        these are the actual device numbers. */
     int dev_for_play;
     int dev_for_record;
-
-    /* The mixer device. */
-    int mixer_oss_dev;
 
     /* 
      * Can only be opened once for each operation.  These aren't set
diff -urN linux-2.4.4/drivers/sound/nm256_audio.c linux-nm/drivers/sound/nm256_audio.c
--- linux-2.4.4/drivers/sound/nm256_audio.c	Sat Nov 11 21:33:14 2000
+++ linux-nm/drivers/sound/nm256_audio.c	Thu May  3 15:22:42 2001
@@ -15,6 +15,8 @@
  * Changes:
  * 11-10-2000	Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
  *		Added some __init
+ * 19-04-2001	Marcus Meissner <mm@caldera.de>
+ *		Ported to 2.4 PCI API.
  */
 
 #define __NO_VERSION__
@@ -23,6 +25,8 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
+#include <linux/soundcard.h>
+#include <linux/ac97_codec.h>
 #include "sound_config.h"
 #include "nm256.h"
 #include "nm256_coeff.h"
@@ -49,8 +53,6 @@
 #define PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO 0x8005
 #define PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO 0x8006
 
-#define RSRCADDRESS(dev,num) ((dev)->resource[(num)].start)
-
 /* List of cards.  */
 static struct nm256_info *nmcard_list;
 
@@ -125,7 +127,7 @@
     struct nm256_info *card;
 
     for (card = nmcard_list; card != NULL; card = card->next_card)
-	if (card->mixer_oss_dev == dev)
+	if (card->ac97.dev_mixer == dev)
 	    return card;
 
     return NULL;
@@ -753,9 +755,9 @@
  */
 
 static int
-nm256_isReady (struct ac97_hwint *dev)
+nm256_isReady (struct ac97_codec *ac97)
 {
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
     int t2 = 10;
     u32 testaddr;
     u16 testb;
@@ -783,48 +785,46 @@
 
 /*
  * Return the contents of the AC97 mixer register REG.  Returns a positive
- * value if successful, or a negative error code.
+ * value if successful, or zero.
  */
-static int
-nm256_readAC97Reg (struct ac97_hwint *dev, u8 reg)
+static u16
+nm256_readAC97Reg (struct ac97_codec *ac97, u8 reg)
 {
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
 
     if (card->magsig != NM_MAGIC_SIG) {
 	printk (KERN_ERR "NM256: Bad magic signature in readAC97Reg!\n");
-	return -EINVAL;
+	return 0;
     }
 
     if (reg < 128) {
 	int res;
 
-	nm256_isReady (dev);
+	nm256_isReady (ac97);
 	res = nm256_readPort16 (card, 2, card->mixer + reg);
 	/* Magic delay.  Bleah yucky.  */
         udelay (1000);
 	return res;
     }
-    else
-	return -EINVAL;
+    return 0;
 }
 
 /* 
  * Writes VALUE to AC97 mixer register REG.  Returns 0 if successful, or
  * a negative error code. 
  */
-static int
-nm256_writeAC97Reg (struct ac97_hwint *dev, u8 reg, u16 value)
+static void
+nm256_writeAC97Reg (struct ac97_codec *ac97, u8 reg, u16 value)
 {
     unsigned long flags;
     int tries = 2;
     int done = 0;
     u32 base;
-
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
 
     if (card->magsig != NM_MAGIC_SIG) {
 	printk (KERN_ERR "NM256: Bad magic signature in writeAC97Reg!\n");
-	return -EINVAL;
+	return;
     }
 
     base = card->mixer;
@@ -832,12 +832,12 @@
     save_flags (flags);
     cli ();
 
-    nm256_isReady (dev);
+    nm256_isReady (ac97);
 
     /* Wait for the write to take, too. */
     while ((tries-- > 0) && !done) {
 	nm256_writePort16 (card, 2, base + reg, value);
-	if (nm256_isReady (dev)) {
+	if (nm256_isReady (ac97)) {
 	    done = 1;
 	    break;
 	}
@@ -846,8 +846,6 @@
 
     restore_flags (flags);
     udelay (1000);
-
-    return ! done;
 }
 
 /* 
@@ -884,9 +882,9 @@
 
 /* Initialize the AC97 into a known state.  */
 static int
-nm256_resetAC97 (struct ac97_hwint *dev)
+nm256_resetAC97 (struct ac97_codec *ac97)
 {
-    struct nm256_info *card = (struct nm256_info *)dev->driver_private;
+    struct nm256_info *card = (struct nm256_info *)ac97->private_data;
     int x;
 
     if (card->magsig != NM_MAGIC_SIG) {
@@ -902,7 +900,7 @@
 
     if (! card->mixer_values_init) {
 	for (x = 0; nm256_ac97_initial_values[x].port != 0xffff; x++) {
-	    ac97_put_register (dev,
+	    nm256_writeAC97Reg (ac97,
 			       nm256_ac97_initial_values[x].port,
 			       nm256_ac97_initial_values[x].value);
 	    card->mixer_values_init = 1;
@@ -912,41 +910,50 @@
     return 0;
 }
 
-/*
- * We don't do anything particularly special here; it just passes the
- * mixer ioctl to the AC97 driver.
- */
-static int
-nm256_default_mixer_ioctl (int dev, unsigned int cmd, caddr_t arg)
+static int nm256_mixer_open (struct inode *inode, struct file *file)
 {
-    struct nm256_info *card = nm256_find_card_for_mixer (dev);
-    if (card != NULL)
-	return ac97_mixer_ioctl (&(card->mdev), cmd, arg);
-    else
+	int minor = MINOR(inode->i_rdev);
+	struct nm256_info *card;
+	
+	MOD_INC_USE_COUNT;
+
+	card = nm256_find_card_for_mixer (minor);
+	if (card)
+		goto match;
+
+	MOD_DEC_USE_COUNT;
 	return -ENODEV;
+
+match:
+	file->private_data = &card->ac97;
+	return 0;
 }
 
-static struct mixer_operations nm256_mixer_operations = {
-    owner:	THIS_MODULE,
-    id:		"NeoMagic",
-    name:	"NM256AC97Mixer",
-    ioctl:	nm256_default_mixer_ioctl
-};
+static int nm256_mixer_release (struct inode *inode, struct file *file)
+{
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
 
-/*
- * Default settings for the OSS mixer.  These are set last, after the
- * mixer is initialized.
- *
- * I "love" C sometimes.  Got braces?
- */
-static struct ac97_mixer_value_list mixer_defaults[] = {
-    { SOUND_MIXER_VOLUME,  { { 85, 85 } } },
-    { SOUND_MIXER_SPEAKER, { { 100 } } },
-    { SOUND_MIXER_PCM,     { { 65, 65 } } },
-    { SOUND_MIXER_CD,      { { 65, 65 } } },
-    { -1,                  {  { 0,  0 } } }
-};
+static int nm256_mixer_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct ac97_codec *codec = file->private_data;
+
+	return codec->mixer_ioctl(codec, cmd, arg);
+}
+
+static loff_t nm256_llseek(struct file *file, loff_t offset, int origin)
+{
+	return -ESPIPE;
+}
 
+static struct file_operations nm256_mixer_fops = {
+	open:		nm256_mixer_open,
+	release:	nm256_mixer_release,
+	llseek:		nm256_llseek,
+	ioctl:		nm256_mixer_ioctl,
+};
 
 /* Installs the AC97 mixer into CARD.  */
 static int __init
@@ -954,28 +961,36 @@
 {
     int mixer;
 
-    card->mdev.reset_device = nm256_resetAC97;
-    card->mdev.read_reg = nm256_readAC97Reg;
-    card->mdev.write_reg = nm256_writeAC97Reg;
-    card->mdev.driver_private = (void *)card;
-
-    if (ac97_init (&(card->mdev)))
-	return -1;
-
-    mixer = sound_alloc_mixerdev();
-    if (num_mixers >= MAX_MIXER_DEV) {
-	printk ("NM256 mixer: Unable to alloc mixerdev\n");
-	return -1;
+    memset (&card->ac97, 0, sizeof (card->ac97));
+    card->ac97.private_data = (void *)card;
+    card->ac97.codec_read = nm256_readAC97Reg;
+    card->ac97.codec_write = nm256_writeAC97Reg;
+    
+    mixer = register_sound_mixer (&nm256_mixer_fops, -1);
+    if (mixer < 0) {
+	printk (KERN_ERR "NM256 mixer: Unable to alloc mixerdev\n");
+	goto err_out;
+    }
+    
+    card->ac97.dev_mixer = mixer;
+    
+    if (nm256_resetAC97 (&card->ac97)) {
+	printk (KERN_ERR "NM256 mixer: Unable to reset AC97 codec\n");
+    	goto err_out_mixer;
+    }
+
+    if (!ac97_probe_codec(&card->ac97)) {
+	printk (KERN_ERR "NM256 mixer: Unable to probe AC97 codec\n");
+	goto err_out_mixer;
     }
 
-    mixer_devs[mixer] = &nm256_mixer_operations;
-    card->mixer_oss_dev = mixer;
-
-    /* Some reasonable default values.  */
-    ac97_set_values (&(card->mdev), mixer_defaults);
-
     printk(KERN_INFO "Initialized AC97 mixer\n");
     return 0;
+
+err_out_mixer:
+    unregister_sound_mixer (mixer);
+err_out:
+    return -1;
 }
 
 /* Perform a full reset on the hardware; this is invoked when an APM
@@ -984,7 +999,10 @@
 nm256_full_reset (struct nm256_info *card)
 {
     nm256_initHw (card);
-    ac97_reset (&(card->mdev));
+    
+    /* note! this depends on ac97_probe_codec not allocating
+     * or registering anything... */
+    ac97_probe_codec (&card->ac97);
 }
 
 /* 
@@ -1042,6 +1060,9 @@
     struct pm_dev *pmdev;
     int x;
 
+    if (pci_enable_device(pcidev))
+	    return 0;
+
     card = kmalloc (sizeof (struct nm256_info), GFP_KERNEL);
     if (card == NULL) {
 	printk (KERN_ERR "NM256: out of memory!\n");
@@ -1055,7 +1076,7 @@
 
     /* Init the memory port info.  */
     for (x = 0; x < 2; x++) {
-	card->port[x].physaddr = RSRCADDRESS (pcidev, x);
+	card->port[x].physaddr = pci_resource_start (pcidev, x);
 	card->port[x].ptr = NULL;
 	card->port[x].start_offset = 0;
 	card->port[x].end_offset = 0;
@@ -1201,6 +1222,8 @@
 	}
     }
 
+    pci_set_drvdata(pcidev,card);
+
     /* Insert the card in the list.  */
     card->next_card = nmcard_list;
     nmcard_list = card;
@@ -1212,7 +1235,7 @@
      * And our mixer.  (We should allow support for other mixers, maybe.)
      */
 
-    nm256_install_mixer (card);
+    nm256_install_mixer (card); /* XXX check return value */
 
     pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev), handle_pm_event);
     if (pmdev)
@@ -1251,37 +1274,38 @@
     return 0;
 }
 
-/*
- * 	This loop walks the PCI configuration database and finds where
- *	the sound cards are.
- */
- 
-int __init
-init_nm256(void)
+static int __devinit
+nm256_probe(struct pci_dev *pcidev,const struct pci_device_id *pciid)
 {
-    struct pci_dev *pcidev = NULL;
-    int count = 0;
-
-    if(! pci_present())
-	return -ENODEV;
-
-    while((pcidev = pci_find_device(PCI_VENDOR_ID_NEOMAGIC,
-				    PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
-				    pcidev)) != NULL) {
-	count += nm256_install(pcidev, REV_NM256AV, "256AV");
-    }
-
-    while((pcidev = pci_find_device(PCI_VENDOR_ID_NEOMAGIC,
-				    PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
-				    pcidev)) != NULL) {
-	count += nm256_install(pcidev, REV_NM256ZX, "256ZX");
+    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO)
+	return nm256_install(pcidev, REV_NM256AV, "256AV");
+    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO)
+	return nm256_install(pcidev, REV_NM256ZX, "256ZX");
+    return -1; /* should not come here ... */
+}
+
+static void __devinit
+nm256_remove(struct pci_dev *pcidev) {
+    struct nm256_info *xcard = pci_get_drvdata(pcidev);
+    struct nm256_info *card,*next_card = NULL;
+
+    for (card = nmcard_list; card != NULL; card = next_card) {
+	next_card = card->next_card;
+	if (card == xcard) {
+	    stopPlay (card);
+	    stopRecord (card);
+	    if (card->has_irq)
+		free_irq (card->irq, card);
+	    nm256_release_ports (card);
+	    unregister_sound_mixer (card->ac97.dev_mixer);
+	    sound_unload_audiodev (card->dev[0]);
+	    sound_unload_audiodev (card->dev[1]);
+	    kfree (card);
+	    break;
+	}
     }
-
-    if (count == 0)
-	return -ENODEV;
-
-    printk (KERN_INFO "Done installing NM256 audio driver.\n");
-    return 0;
+    if (nmcard_list == card)
+    	nmcard_list = next_card;
 }
 
 /*
@@ -1639,9 +1663,21 @@
     local_qlen:		nm256_audio_local_qlen,
 };
 
-EXPORT_SYMBOL(init_nm256);
+static struct pci_device_id nm256_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO,
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{PCI_VENDOR_ID_NEOMAGIC, PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO,
+	PCI_ANY_ID, PCI_ANY_ID, 0, 0},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, nm256_pci_tbl);
 
-static int loaded = 0;
+struct pci_driver nm256_pci_driver = {
+	name:"nm256_audio",
+	id_table:nm256_pci_tbl,
+	probe:nm256_probe,
+	remove:nm256_remove,
+};
 
 MODULE_PARM (usecache, "i");
 MODULE_PARM (buffertop, "i");
@@ -1650,37 +1686,13 @@
 
 static int __init do_init_nm256(void)
 {
-    nmcard_list = NULL;
-    printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1\n");
-
-    if (init_nm256 () == 0) {
-	loaded = 1;
-	return 0;
-    }
-    else
-	return -ENODEV;
+    printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1p\n");
+    return pci_module_init(&nm256_pci_driver);
 }
 
 static void __exit cleanup_nm256 (void)
 {
-    if (loaded) {
-	struct nm256_info *card;
-	struct nm256_info *next_card;
-
-	for (card = nmcard_list; card != NULL; card = next_card) {
-	    stopPlay (card);
-	    stopRecord (card);
-	    if (card->has_irq)
-		free_irq (card->irq, card);
-	    nm256_release_ports (card);
-	    sound_unload_mixerdev (card->mixer_oss_dev);
-	    sound_unload_audiodev (card->dev[0]);
-	    sound_unload_audiodev (card->dev[1]);
-	    next_card = card->next_card;
-	    kfree (card);
-	}
-	nmcard_list = NULL;
-    }
+    pci_unregister_driver(&nm256_pci_driver);
     pm_unregister_all (&handle_pm_event);
 }
 

--------------DBDFF5F8B9C26835CB7DAB1C--

