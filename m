Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSKRMzO>; Mon, 18 Nov 2002 07:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSKRMzN>; Mon, 18 Nov 2002 07:55:13 -0500
Received: from 2-023.ctame701-2.telepar.net.br ([200.181.170.23]:38404 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262449AbSKRMxd>; Mon, 18 Nov 2002 07:53:33 -0500
Date: Mon, 18 Nov 2002 11:00:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound: more fixups for header cleanup: add include <linux/interrupt.h>
Message-ID: <20021118130029.GE2093@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

	Please pull from:

master.kernel.org:/home/acme/BK/includes-2.5

	Now there is three outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.892, 2002-11-18 10:41:00-02:00, acme@conectiva.com.br
  o sound: more fixups for header cleanup: add include <linux/interrupt.h>
  
  Also some cleanups wrt struct member initialization style.


 oss/cs4281/cs4281_wrapper-24.c |    3 
 oss/cs4281/cs4281m.c           |   70 +++++++++++---------
 oss/cs4281/cs4281pm-24.c       |    8 +-
 oss/cs46xx.c                   |  143 ++++++++++++++++++++++++++++++++---------
 oss/maestro.c                  |   20 +++--
 oss/maestro3.c                 |   72 ++++++++++----------
 oss/rme96xx.c                  |   51 ++++++++------
 pci/cs46xx/cs46xx_lib.c        |    8 +-
 pci/emu10k1/emu10k1_main.c     |    2 
 pci/es1938.c                   |    4 -
 pci/fm801.c                    |    4 -
 pci/korg1212/korg1212.c        |   21 ++++--
 pci/rme32.c                    |    5 +
 pci/rme96.c                    |    5 +
 pci/rme9652/hdsp.c             |   26 ++++---
 pci/rme9652/rme9652.c          |   21 ++++--
 pci/sonicvibes.c               |    5 +
 pci/trident/trident_main.c     |    5 +
 pci/ymfpci/ymfpci_main.c       |    6 +
 19 files changed, 318 insertions(+), 161 deletions(-)


diff -Nru a/sound/oss/cs4281/cs4281_wrapper-24.c b/sound/oss/cs4281/cs4281_wrapper-24.c
--- a/sound/oss/cs4281/cs4281_wrapper-24.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/cs4281/cs4281_wrapper-24.c	Mon Nov 18 10:56:31 2002
@@ -26,7 +26,8 @@
 
 #include <linux/spinlock.h>
 
-void cs4281_null(struct pci_dev *pcidev) { return; }
+int cs4281_resume_null(struct pci_dev *pcidev) { return 0; }
+int cs4281_suspend_null(struct pci_dev *pcidev, u32 state) { return 0; }
 #define cs4x_mem_map_reserve(page) mem_map_reserve(page)
 #define cs4x_mem_map_unreserve(page) mem_map_unreserve(page)
 
diff -Nru a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/cs4281/cs4281m.c	Mon Nov 18 10:56:31 2002
@@ -69,15 +69,19 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 #include <linux/wrapper.h>
 #include <linux/fs.h>
+#include <linux/wait.h>
+
+#include <asm/current.h>
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/page.h>
 #include <asm/uaccess.h>
-#include <asm/hardirq.h>
+
 //#include "cs_dm.h"
 #include "cs4281_hwdefs.h"
 #include "cs4281pm.h"
@@ -2622,10 +2626,10 @@
 //   Mixer file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_mixer_fops = {
-	llseek:no_llseek,
-	ioctl:cs4281_ioctl_mixdev,
-	open:cs4281_open_mixdev,
-	release:cs4281_release_mixdev,
+	.llseek	 = no_llseek,
+	.ioctl	 = cs4281_ioctl_mixdev,
+	.open	 = cs4281_open_mixdev,
+	.release = cs4281_release_mixdev,
 };
 
 // --------------------------------------------------------------------- 
@@ -3743,14 +3747,14 @@
 //   Wave (audio) file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_audio_fops = {
-	llseek:no_llseek,
-	read:cs4281_read,
-	write:cs4281_write,
-	poll:cs4281_poll,
-	ioctl:cs4281_ioctl,
-	mmap:cs4281_mmap,
-	open:cs4281_open,
-	release:cs4281_release,
+	.llseek	 = no_llseek,
+	.read	 = cs4281_read,
+	.write	 = cs4281_write,
+	.poll	 = cs4281_poll,
+	.ioctl	 = cs4281_ioctl,
+	.mmap	 = cs4281_mmap,
+	.open	 = cs4281_open,
+	.release = cs4281_release,
 };
 
 // --------------------------------------------------------------------- 
@@ -4092,12 +4096,12 @@
 //   Midi file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_midi_fops = {
-	llseek:no_llseek,
-	read:cs4281_midi_read,
-	write:cs4281_midi_write,
-	poll:cs4281_midi_poll,
-	open:cs4281_midi_open,
-	release:cs4281_midi_release,
+	.llseek	 = no_llseek,
+	.read	 = cs4281_midi_read,
+	.write	 = cs4281_midi_write,
+	.poll	 = cs4281_midi_poll,
+	.open	 = cs4281_midi_open,
+	.release = cs4281_midi_release,
 };
 
 
@@ -4467,20 +4471,24 @@
 }
 
 static struct pci_device_id cs4281_pci_tbl[] __devinitdata = {
-	{PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CRYSTAL_CS4281,
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0},
-	{0,}
+	{
+		.vendor    = PCI_VENDOR_ID_CIRRUS,
+		.device    = PCI_DEVICE_ID_CRYSTAL_CS4281,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+	},
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE(pci, cs4281_pci_tbl);
 
 struct pci_driver cs4281_pci_driver = {
-	name:"cs4281",
-	id_table:cs4281_pci_tbl,
-	probe:cs4281_probe,
-	remove:cs4281_remove,
-	suspend:CS4281_SUSPEND_TBL,
-	resume:CS4281_RESUME_TBL,
+	.name	  = "cs4281",
+	.id_table = cs4281_pci_tbl,
+	.probe	  = cs4281_probe,
+	.remove	  = cs4281_remove,
+	.suspend  = CS4281_SUSPEND_TBL,
+	.resume	  = CS4281_RESUME_TBL,
 };
 
 int __init cs4281_init_module(void)
diff -Nru a/sound/oss/cs4281/cs4281pm-24.c b/sound/oss/cs4281/cs4281pm-24.c
--- a/sound/oss/cs4281/cs4281pm-24.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/cs4281/cs4281pm-24.c	Mon Nov 18 10:56:31 2002
@@ -38,8 +38,8 @@
 #define CS4281_SUSPEND_TBL cs4281_suspend_tbl
 #define CS4281_RESUME_TBL cs4281_resume_tbl
 */
-#define CS4281_SUSPEND_TBL cs4281_null
-#define CS4281_RESUME_TBL cs4281_null
+#define CS4281_SUSPEND_TBL cs4281_suspend_null
+#define CS4281_RESUME_TBL cs4281_resume_null
 
 int cs4281_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
@@ -78,7 +78,7 @@
 }
 
 #else /* CS4281_PM */
-#define CS4281_SUSPEND_TBL cs4281_null
-#define CS4281_RESUME_TBL cs4281_null
+#define CS4281_SUSPEND_TBL cs4281_suspend_null
+#define CS4281_RESUME_TBL cs4281_resume_null
 #endif /* CS4281_PM */
 
diff -Nru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/cs46xx.c	Mon Nov 18 10:56:31 2002
@@ -75,6 +75,7 @@
  *	turned on.
  */
  
+#include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/version.h>
 #include <linux/module.h>
@@ -87,18 +88,18 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/poll.h>
-#include <linux/smp_lock.h>
 #include <linux/wrapper.h>
+#include <linux/ac97_codec.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
-#include <linux/ac97_codec.h>
+
 #include "cs46xxpm-24.h"
 #include "cs46xx_wrapper-24.h"
-
 #include "cs461x.h"
 
 /* MIDI buffer sizes */
@@ -5243,22 +5244,85 @@
 	void (*active)(struct cs_card *, int);
 };
 
-static struct cs_card_type cards[]={
-	{0x1489, 0x7001, "Genius Soundmaker 128 value", amp_none, NULL, NULL},
-	{0x5053, 0x3357, "Voyetra", amp_voyetra, NULL, NULL},
-	{0x1071, 0x6003, "Mitac MI6020/21", amp_voyetra, NULL, NULL},
-	{0x14AF, 0x0050, "Hercules Game Theatre XP", amp_hercules, NULL, NULL},
-	{0x1681, 0x0050, "Hercules Game Theatre XP", amp_hercules, NULL, NULL},
-	{0x1681, 0x0051, "Hercules Game Theatre XP", amp_hercules, NULL, NULL},
-	{0x1681, 0x0052, "Hercules Game Theatre XP", amp_hercules, NULL, NULL},
-	{0x1681, 0x0053, "Hercules Game Theatre XP", amp_hercules, NULL, NULL},
-	{0x1681, 0x0054, "Hercules Game Theatre XP", amp_hercules, NULL, NULL},
+static struct cs_card_type cards[] = {
+	{
+		.vendor	= 0x1489,
+		.id	= 0x7001,
+		.name	= "Genius Soundmaker 128 value",
+		.amp	= amp_none,
+	},
+	{
+		.vendor	= 0x5053,
+		.id	= 0x3357,
+		.name	= "Voyetra",
+		.amp	= amp_voyetra,
+	},
+	{
+		.vendor	= 0x1071,
+		.id	= 0x6003,
+		.name	= "Mitac MI6020/21",
+		.amp	= amp_voyetra,
+	},
+	{
+		.vendor	= 0x14AF,
+		.id	= 0x0050,
+		.name	= "Hercules Game Theatre XP",
+		.amp	= amp_hercules,
+	},
+	{
+		.vendor	= 0x1681,
+		.id	= 0x0050,
+		.name	= "Hercules Game Theatre XP",
+		.amp	= amp_hercules,
+	},
+	{
+		.vendor	= 0x1681,
+		.id	= 0x0051,
+		.name	= "Hercules Game Theatre XP",
+		.amp	= amp_hercules,
+	},
+	{
+		.vendor	= 0x1681,
+		.id	= 0x0052,
+		.name	= "Hercules Game Theatre XP",
+		.amp	= amp_hercules,
+	},
+	{
+		.vendor	= 0x1681,
+		.id	= 0x0053,
+		.name	= "Hercules Game Theatre XP",
+		.amp	= amp_hercules,
+	},
+	{
+		.vendor	= 0x1681,
+		.id	= 0x0054,
+		.name	= "Hercules Game Theatre XP",
+		.amp	= amp_hercules,
+	},
 	/* Not sure if the 570 needs the clkrun hack */
-	{PCI_VENDOR_ID_IBM, 0x0132, "Thinkpad 570", amp_none, NULL, clkrun_hack},
-	{PCI_VENDOR_ID_IBM, 0x0153, "Thinkpad 600X/A20/T20", amp_none, NULL, clkrun_hack},
-	{PCI_VENDOR_ID_IBM, 0x1010, "Thinkpad 600E (unsupported)", NULL, NULL, NULL},
-	{0, 0, "Card without SSID set", NULL, NULL, NULL },
-	{0, 0, NULL, NULL, NULL}
+	{
+		.vendor	= PCI_VENDOR_ID_IBM,
+		.id	= 0x0132,
+		.name	= "Thinkpad 570",
+		.amp	= amp_none,
+		.active	= clkrun_hack,
+	},
+	{
+		.vendor	= PCI_VENDOR_ID_IBM,
+		.id	= 0x0153,
+		.name	= "Thinkpad 600X/A20/T20",
+		.amp	= amp_none,
+		.active	= clkrun_hack,
+	},
+	{
+		.vendor	= PCI_VENDOR_ID_IBM,
+		.id	= 0x1010,
+		.name	= "Thinkpad 600E (unsupported)",
+	},
+	{
+		.name	= "Card without SSID set",
+	},
+	{ 0, },
 };
 
 MODULE_AUTHOR("Alan Cox <alan@redhat.com>, Jaroslav Kysela, <pcaudio@crystal.cirrus.com>");
@@ -5622,22 +5686,39 @@
 };
 
 static struct pci_device_id cs46xx_pci_tbl[] __devinitdata = {
-	
-	{PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_4610, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CS46XX_4610},
-	{PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_4612, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CS46XX_4612},
-	{PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_4615, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CS46XX_4615},
-	{0,}
+	{
+		.vendor	     = PCI_VENDOR_ID_CIRRUS,
+		.device	     = PCI_DEVICE_ID_CIRRUS_4610,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = CS46XX_4610,
+	},
+	{
+		.vendor	     = PCI_VENDOR_ID_CIRRUS,
+		.device	     = PCI_DEVICE_ID_CIRRUS_4612,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = CS46XX_4612,
+	},
+	{
+		.vendor	     = PCI_VENDOR_ID_CIRRUS,
+		.device	     = PCI_DEVICE_ID_CIRRUS_4615,
+		.subvendor   = PCI_ANY_ID,
+		.subdevice   = PCI_ANY_ID,
+		.driver_data = CS46XX_4615,
+	},
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE(pci, cs46xx_pci_tbl);
 
 struct pci_driver cs46xx_pci_driver = {
-	.name= "cs46xx",
-	.id_table= cs46xx_pci_tbl,
-	.probe= cs46xx_probe,
-	.remove= cs46xx_remove,
-	.suspend= CS46XX_SUSPEND_TBL,
-	.resume= CS46XX_RESUME_TBL,
+	.name	  = "cs46xx",
+	.id_table = cs46xx_pci_tbl,
+	.probe	  = cs46xx_probe,
+	.remove	  = cs46xx_remove,
+	.suspend  = CS46XX_SUSPEND_TBL,
+	.resume	  = CS46XX_RESUME_TBL,
 };
 
 int __init cs46xx_init_module(void)
diff -Nru a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/maestro.c	Mon Nov 18 10:56:31 2002
@@ -219,14 +219,18 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/reboot.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/bitops.h>
+#include <linux/wait.h>
+
+#include <asm/current.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/uaccess.h>
 
 #include <linux/pm.h>
 static int maestro_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *d);
@@ -3609,10 +3613,10 @@
 MODULE_DEVICE_TABLE(pci, maestro_pci_tbl);
 
 static struct pci_driver maestro_pci_driver = {
-	name:"maestro",
-	id_table:maestro_pci_tbl,
-	probe:maestro_probe,
-	remove:maestro_remove,
+	.name	  = "maestro",
+	.id_table = maestro_pci_tbl,
+	.probe	  = maestro_probe,
+	.remove	  = maestro_remove,
 };
 
 int __init init_maestro(void)
diff -Nru a/sound/oss/maestro3.c b/sound/oss/maestro3.c
--- a/sound/oss/maestro3.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/maestro3.c	Mon Nov 18 10:56:31 2002
@@ -137,15 +137,17 @@
 #include <linux/soundcard.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#include <asm/io.h>
-#include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/poll.h>
 #include <linux/reboot.h>
-#include <asm/uaccess.h>
-#include <asm/hardirq.h>
 #include <linux/spinlock.h>
 #include <linux/ac97_codec.h>
+#include <linux/wait.h>
+
+#include <asm/io.h>
+#include <asm/dma.h>
+#include <asm/uaccess.h>
 
  /*
   * for crizappy mmap()
@@ -320,15 +322,15 @@
 #define PCI_VENDOR_ESS      0x125D
 #endif
 
-#define M3_DEVICE(DEV, TYPE)                \
-{                                           \
-vendor: PCI_VENDOR_ESS,                     \
-device: DEV,                                \
-subvendor: PCI_ANY_ID,                      \
-subdevice: PCI_ANY_ID,                      \
-class:  PCI_CLASS_MULTIMEDIA_AUDIO << 8,    \
-class_mask: 0xffff << 8,                    \
-driver_data: TYPE,                          \
+#define M3_DEVICE(DEV, TYPE)			\
+{						\
+.vendor	     = PCI_VENDOR_ESS,			\
+.device	     = DEV,				\
+.subvendor   = PCI_ANY_ID,			\
+.subdevice   = PCI_ANY_ID,			\
+.class	     = PCI_CLASS_MULTIMEDIA_AUDIO << 8,	\
+.class_mask  = 0xffff << 8,			\
+.driver_data = TYPE,				\
 }
 
 static struct pci_device_id m3_id_table[] __initdata = {
@@ -381,7 +383,9 @@
 static int m3_suspend(struct pci_dev *pci_dev, u32 state);
 static void check_suspend(struct m3_card *card);
 
-struct notifier_block m3_reboot_nb = {m3_notifier, NULL, 0};
+struct notifier_block m3_reboot_nb = {
+	.notifier_call = m3_notifier,
+};
 
 static void m3_outw(struct m3_card *card,
         u16 value, unsigned long reg)
@@ -2179,11 +2183,11 @@
 }
 
 static struct file_operations m3_mixer_fops = {
-    owner:          THIS_MODULE,
-    llseek:         no_llseek,
-    ioctl:          m3_ioctl_mixdev,
-    open:           m3_open_mixdev,
-    release:        m3_release_mixdev,
+	.owner	 = THIS_MODULE,
+	.llseek  = no_llseek,
+	.ioctl	 = m3_ioctl_mixdev,
+	.open	 = m3_open_mixdev,
+	.release = m3_release_mixdev,
 };
 
 void remote_codec_config(int io, int isremote)
@@ -2559,15 +2563,15 @@
 }
 
 static struct file_operations m3_audio_fops = {
-    owner:      THIS_MODULE,
-    llseek:     &no_llseek,
-    read:       &m3_read,
-    write:      &m3_write,
-    poll:       &m3_poll,
-    ioctl:      &m3_ioctl,
-    mmap:       &m3_mmap,
-    open:       &m3_open,
-    release:    &m3_release,
+	.owner	 = THIS_MODULE,
+	.llseek	 = no_llseek,
+	.read	 = m3_read,
+	.write	 = m3_write,
+	.poll	 = m3_poll,
+	.ioctl	 = m3_ioctl,
+	.mmap	 = m3_mmap,
+	.open	 = m3_open,
+	.release = m3_release,
 };
 
 #ifdef CONFIG_PM
@@ -2925,12 +2929,12 @@
 MODULE_PARM(gpio_pin, "i");
 
 static struct pci_driver m3_pci_driver = {
-    name:       "ess_m3_audio",
-    id_table:   m3_id_table,
-    probe:      m3_probe,
-    remove:     m3_remove,
-    suspend:    m3_suspend,
-    resume:     m3_resume,
+	.name	  = "ess_m3_audio",
+	.id_table = m3_id_table,
+	.probe	  = m3_probe,
+	.remove	  = m3_remove,
+	.suspend  = m3_suspend,
+	.resume	  = m3_resume,
 };
 
 static int __init m3_init_module(void)
diff -Nru a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
--- a/sound/oss/rme96xx.c	Mon Nov 18 10:56:31 2002
+++ b/sound/oss/rme96xx.c	Mon Nov 18 10:56:31 2002
@@ -41,10 +41,14 @@
 #include <linux/smp_lock.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <asm/dma.h>
-#include <asm/hardirq.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/poll.h>
+#include <linux/wait.h>
+
+#include <asm/dma.h>
+#include <asm/page.h>
+
 #include "rme96xx.h"
 
 #define NR_DEVICE 2
@@ -808,17 +812,22 @@
 #endif
 
 static struct pci_device_id id_table[] __devinitdata = {
-	{ PCI_VENDOR_ID_RME, PCI_DEVICE_ID_RME9652, PCI_ANY_ID, PCI_ANY_ID, 0, 0 },
-	{ 0, }
+	{
+		.vendor	   = PCI_VENDOR_ID_RME,
+		.device	   = PCI_DEVICE_ID_RME9652,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+	},
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver rme96xx_driver = {
-	name: "rme96xx",
-	id_table: id_table,
-	probe: rme96xx_probe,
-	remove: rme96xx_remove
+	.name	  =  "rme96xx",
+	.id_table = id_table,
+	.probe	  = rme96xx_probe,
+	.remove	  = rme96xx_remove,
 };
 
 static int __init init_rme96xx(void)
@@ -1223,7 +1232,7 @@
 static int rme96xx_release(struct inode *in, struct file *file)
 {
 	struct dmabuf * dma = (struct dmabuf*) file->private_data;
-	int hwp;
+	/* int hwp; */
 	DBG(printk(__FUNCTION__"\n"));
 
 	COMM          ("draining")
@@ -1483,15 +1492,15 @@
 
 static struct file_operations rme96xx_audio_fops = {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-	owner: THIS_MODULE,
+	.owner	 = THIS_MODULE,
 #endif
-	read: rme96xx_read,
-	write: rme96xx_write,
-	poll: rme96xx_poll,
-	ioctl: rme96xx_ioctl,  
-	mmap: rm96xx_mmap,
-	open: rme96xx_open,  
-	release: rme96xx_release 
+	.read	 = rme96xx_read,
+	.write	 = rme96xx_write,
+	.poll	 = rme96xx_poll,
+	.ioctl	 = rme96xx_ioctl,  
+	.mmap	 = rm96xx_mmap,
+	.open	 = rme96xx_open,  
+	.release = rme96xx_release 
 };
 
 static int rme96xx_mixer_open(struct inode *inode, struct file *file)
@@ -1565,9 +1574,9 @@
 
 static /*const*/ struct file_operations rme96xx_mixer_fops = {
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
-	owner: THIS_MODULE,
+	.owner	 = THIS_MODULE,
 #endif
-	ioctl:		rme96xx_mixer_ioctl,
-	open:		rme96xx_mixer_open,
-	release:	rme96xx_mixer_release,
+	.ioctl	 = rme96xx_mixer_ioctl,
+	.open	 = rme96xx_mixer_open,
+	.release = rme96xx_mixer_release,
 };
diff -Nru a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/cs46xx/cs46xx_lib.c	Mon Nov 18 10:56:31 2002
@@ -46,12 +46,13 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
+
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
@@ -59,6 +60,9 @@
 #ifndef LINUX_2_2
 #include <linux/gameport.h>
 #endif
+
+#include <asm/io.h>
+
 #include "cs46xx_lib.h"
 #include "dsp_spos.h"
 
@@ -447,7 +451,7 @@
 
 static int cs46xx_wait_for_fifo(cs46xx_t * chip,int retry_timeout) 
 {
-	u32 i, status;
+	u32 i, status = 0;
 	/*
 	 * Make sure the previous FIFO write operation has completed.
 	 */
diff -Nru a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
--- a/sound/pci/emu10k1/emu10k1_main.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/emu10k1/emu10k1_main.c	Mon Nov 18 10:56:31 2002
@@ -28,9 +28,11 @@
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
diff -Nru a/sound/pci/es1938.c b/sound/pci/es1938.c
--- a/sound/pci/es1938.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/es1938.c	Mon Nov 18 10:56:31 2002
@@ -48,8 +48,8 @@
 
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -62,6 +62,8 @@
 #ifndef LINUX_2_2
 #include <linux/gameport.h>
 #endif
+
+#include <asm/io.h>
 
 #define chip_t es1938_t
 
diff -Nru a/sound/pci/fm801.c b/sound/pci/fm801.c
--- a/sound/pci/fm801.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/fm801.c	Mon Nov 18 10:56:31 2002
@@ -20,9 +20,9 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -32,6 +32,8 @@
 #include <sound/opl3.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
+
+#include <asm/io.h>
 
 #define chip_t fm801_t
 
diff -Nru a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
--- a/sound/pci/korg1212/korg1212.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/korg1212/korg1212.c	Mon Nov 18 10:56:31 2002
@@ -20,11 +20,13 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/wait.h>
+
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -33,6 +35,8 @@
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
+#include <asm/io.h>
+
 // ----------------------------------------------------------------------------
 // Debug Stuff
 // ----------------------------------------------------------------------------
@@ -403,8 +407,13 @@
 MODULE_AUTHOR("Haroldo Gamal <gamal@alternex.com.br>");
 
 static struct pci_device_id snd_korg1212_ids[] __devinitdata = {
-	{ 0x10b5, 0x906d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
-	{ 0, }
+	{
+		.vendor	   = 0x10b5,
+		.device	   = 0x906d,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+	},
+	{ 0, },
 };
 
 static char* stateName[] = {
@@ -2305,10 +2314,10 @@
 }
 
 static struct pci_driver driver = {
-	.name = "korg1212",
+	.name	  = "korg1212",
 	.id_table = snd_korg1212_ids,
-	.probe = snd_korg1212_probe,
-	.remove = __devexit_p(snd_korg1212_remove),
+	.probe	  = snd_korg1212_probe,
+	.remove	  = __devexit_p(snd_korg1212_remove),
 };
 
 static int __init alsa_card_korg1212_init(void)
diff -Nru a/sound/pci/rme32.c b/sound/pci/rme32.c
--- a/sound/pci/rme32.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/rme32.c	Mon Nov 18 10:56:31 2002
@@ -27,11 +27,12 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -40,6 +41,8 @@
 #include <sound/asoundef.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
+
+#include <asm/io.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff -Nru a/sound/pci/rme96.c b/sound/pci/rme96.c
--- a/sound/pci/rme96.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/rme96.c	Mon Nov 18 10:56:31 2002
@@ -24,11 +24,12 @@
  */      
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -37,6 +38,8 @@
 #include <sound/asoundef.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
+
+#include <asm/io.h>
 
 /* note, two last pcis should be equal, it is not a bug */
 
diff -Nru a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
--- a/sound/pci/rme9652/hdsp.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/rme9652/hdsp.c	Mon Nov 18 10:56:31 2002
@@ -20,12 +20,11 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
-#include <asm/byteorder.h>
 #include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -35,6 +34,10 @@
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
+#include <asm/byteorder.h>
+#include <asm/current.h>
+#include <asm/io.h>
+
 #include "multiface_firmware.dat"
 #include "digiface_firmware.dat"
 
@@ -409,10 +412,13 @@
 #endif
 
 static struct pci_device_id snd_hdsp_ids[] __devinitdata = {
-	{PCI_VENDOR_ID_XILINX,
-	 PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
-	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,}, /* RME Hammerfall-DSP */
-	{0,}
+	{
+		.vendor	   = PCI_VENDOR_ID_XILINX,
+		.device	   = PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP, 
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+	}, /* RME Hammerfall-DSP */
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE(pci, snd_hdsp_ids);
@@ -3116,10 +3122,10 @@
 }
 
 static struct pci_driver driver = {
-	.name = "RME Hammerfall DSP",
+	.name	  = "RME Hammerfall DSP",
 	.id_table = snd_hdsp_ids,
-	.probe = snd_hdsp_probe,
-	.remove = __devexit_p(snd_hdsp_remove),
+	.probe	  = snd_hdsp_probe,
+	.remove	  = __devexit_p(snd_hdsp_remove),
 };
 
 static int __init alsa_card_hdsp_init(void)
diff -Nru a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
--- a/sound/pci/rme9652/rme9652.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/rme9652/rme9652.c	Mon Nov 18 10:56:31 2002
@@ -21,11 +21,12 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -34,6 +35,9 @@
 #define SNDRV_GET_ID
 #include <sound/initval.h>
 
+#include <asm/current.h>
+#include <asm/io.h>
+
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
@@ -311,8 +315,13 @@
 #endif
 
 static struct pci_device_id snd_rme9652_ids[] __devinitdata = {
-	{0x10ee, 0x3fc4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0,},	/* RME Digi9652 */
-	{0,}
+	{
+		.vendor	   = 0x10ee,
+		.device	   = 0x3fc4,
+		.subvendor = PCI_ANY_ID,
+		.subdevice = PCI_ANY_ID,
+	},	/* RME Digi9652 */
+	{ 0, },
 };
 
 MODULE_DEVICE_TABLE(pci, snd_rme9652_ids);
@@ -2733,10 +2742,10 @@
 }
 
 static struct pci_driver driver = {
-	.name ="RME Digi9652 (Hammerfall)",
+	.name	  = "RME Digi9652 (Hammerfall)",
 	.id_table = snd_rme9652_ids,
-	.probe = snd_rme9652_probe,
-	.remove = __devexit_p(snd_rme9652_remove),
+	.probe	  = snd_rme9652_probe,
+	.remove	  = __devexit_p(snd_rme9652_remove),
 };
 
 static int __init alsa_card_hammerfall_init(void)
diff -Nru a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
--- a/sound/pci/sonicvibes.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/sonicvibes.c	Mon Nov 18 10:56:31 2002
@@ -23,11 +23,12 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
@@ -39,6 +40,8 @@
 #ifndef LINUX_2_2
 #include <linux/gameport.h>
 #endif
+
+#include <asm/io.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("S3 SonicVibes PCI");
diff -Nru a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
--- a/sound/pci/trident/trident_main.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/trident/trident_main.c	Mon Nov 18 10:56:31 2002
@@ -26,12 +26,13 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -40,6 +41,8 @@
 #ifndef LINUX_2_2
 #include <linux/gameport.h>
 #endif
+
+#include <asm/io.h>
 
 #define chip_t trident_t
 
diff -Nru a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
--- a/sound/pci/ymfpci/ymfpci_main.c	Mon Nov 18 10:56:31 2002
+++ b/sound/pci/ymfpci/ymfpci_main.c	Mon Nov 18 10:56:31 2002
@@ -25,18 +25,22 @@
  */
 
 #include <sound/driver.h>
-#include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
 #include <sound/ymfpci.h>
 #include <sound/asoundef.h>
 #include <sound/mpu401.h>
+
+#include <asm/io.h>
 
 #define chip_t ymfpci_t
 

===================================================================


This BitKeeper patch contains the following changesets:
1.892
## Wrapped with gzip_uu ##


begin 664 bkpatch15262
M'XL(`'_CV#T``^U<ZV_;MA;_;/T51/>EV\V#3SVR=6@69ZNQ9"N2=NBP#88L
MT8UN+,N0Y";=O/_]'E*R(LEZV&Z["Z3+.E,6J<-#ZG=>Y*&_0*\3&9\,7"^4
MQA?H192D)P,OFDLO#=ZY1UX4'DUBJ+B*(J@XOHE">?S=C\?!W)LM?9D<TB-A
M0/5+-_5NT#L9)R<#<L2*.^G[A3P97)W_\/KB],HPGCU#9S?N_*V\EBEZ]LQ(
MH_B=._.3YVYZ,XOF1VGLSI-0IKKC5=%T13&F\)\@%L/"7!$3<VOE$9\0EQ/I
M8\IMDQMJ#,_KO->H$$)L0IE#^`IS3DQCB,B1[5"$Z3$AQ\1&!)]P<H+Q(:;P
MB1J)HO\0!QUBXSOT<4=P9G@H0DFTG/LG*(QBB:;!_7*1H&D4HQOI^C)&WDRZ
M\^7B!+F^C_+W@+Z9!?/E/;R65,;Q<I$>W7P+I.#?Z2Q1!$.Y?BY!=W&*DC1>
M>BD*93@!DL$\2`-W%OSIID$TA\KW,WED_(@(,P4W7CZ\,^-PQS_#P"XVOD4+
MA8;F.?+C0.'F6(_Z.`ZE8][?'WG%C$'I,&>%B<V=%?4DFPKI,'=B$7<R:7X]
MJXQ6E"0U>MG;YUB(E8D%-A5G,I;WS_7GD?=G_N3""X"?>>"]"R8R*9@AC#@,
MRA5\V,[*H98]I9;/)U1.)J[3R4PCR1(_V"+8ZN)')M"YO<D+)13`+.243CU/
MS0OW&.[GI4*NQ`?'A(DN/M(X\.4\79?CT`WF#3/$+,96GN5-*)Y0DV.;$"IZ
MN>H@7N81I(<#C]W"5P66EW!JDQ*NB`5#Q2O@T[16-L#)MK#O^I9K.Q/6BZN,
M7%Z$#:\34]/<!?BA*T$H(U;A4)B<K8BPJ;5R3%]Z!$OAFD)(;/5R6"-8YHV"
M1!6O.%DFLOJ&M<P(>GSC)XLU.Z;B"#-BKZAM.W@U<1@7#F!/NIA83O>$M1`M
ML<0$87N\T:JFR-\H!S;ATZ3`K30=[..),/OGJT*NQ!JE)NU4%._#Z4/1*`YL
MA9DC^$HI"^)*Z4GNN6XW2YV4R[)@,P=WL:<GOD%M.!91V(+9\AT^P:[P&!B2
MK5YCD];@HG.29+@D^):LRQ:M01@ESLJ4U/4X]ASA>[8_[5=E[;3++$(/3A>+
MT]#&I&&BJ+#,E;"9]&S.*9WBR<3Q>IDJ4RMQ04S'L7<$>B[)FT@'F6%X15V)
MI]"%M!P",]?BLFQJA@;FJ&62KBG*9"0OQK-@TO`*"38QZ%-I2NE8GHVG+O.[
M[707Y8J.<*B]BTJMZ.CQ7>PN8$B'E#>I6&;#1%*;V8YMVU/L6A/9[UST=%"9
M66[:W2J7T35?G#H8'F#F"KP?2ZRD;[J^!SRZDZF-77\;(2VHE9@0U"2\Z_7>
M1O%;\"9H<=$@#<*&^:(.95/?9,3D9&).^M5&&^6R57(88WN_WD78\F+!L*PL
MTP>GT>:46]R:NKN]US+EBK\FS'Z]"P8O+QM<)*P,J63<%_:$3^34DL3O9JZ=
M;MFSI;9)=:RU#5)5&/:/2931.%M;B%(Q;4J#"DITV,:K01L^$:([:*/HD#SZ
MF$UKFI_187RG_T$,]G(K(.P1VPVI@X@Q@D]JP#!03C66R3*4X_ER-GN:,ZW\
M%U^^0U_!!91?HK]0+--E/$?X:_1W^6'0C0LY][N>/D!+1F'$;BKKA#I0G\OQ
M_GC?1<5L"?0JR0+B$-`Y&<39KA#GZ)`_=HAKS;L=PO,)W@?;G`"J1YS"YQ>^
MG`9SB<ZN-42O7U^_//]I.'[UW443:NO-K\ZO7U^>EUN7!,08VKH?^U/W4Y6,
MA^!P)WG8-4@UW)D[?SZ[!Z._O#U:WBZ71W`)%QUQ*L8V!6H$O!_+H52+`26[
MR@&ST2%[])*@`_E627B8V7WP3SA6P"0@`<3XHFL<T%1D36TD-IK>N8%N]7NI
MQDW"XR!2=ZOW_-#=O+ET/4\FB>Z)488<8\08@6*-_TLV'I[_,CH[?PK%`7KU
MZ\OS+P>#P>_&7P/]][MQ]`Z$)HH'2/T]0R_/1N-?0+)^OAJ?7U\?9$W`L`2>
M7#=1E/)GD^4D>[QX]O2G7\>CX4%1G3W:7.W-W"0I=WQV<7I]/;Y\??%J='D^
M')V.3U\/1S^C;[Y!]D'Q`,2PR:UZ`M]/X2^OS?C4$CGVW=2%>C78G-$AL[DR
MQZI@1@Z@>90&TP#:3V:1=XM"!DIA$D7I>#Z!I_\R!D=%"\^=S>`>-%G?.C#^
M_AJ,/`'E),#,$]N$<G`4W<TES"5T_F($(_EY^/KB_`#NSV:)E)KK>33.OJC;
M0>2ELT%&65^/P^!>F7%%"K197J4N2S6Q!'%(9%:7?RFJAU285`$!8G,,91]/
M@SI/,8CJ8$W;]=6MNSA(97Y/7ZN;BVBV9EU=-@Y'W0Q#=Y'?4Y<-0VL;DQH,
MQ+7(5'X48U#"*W%#!<1GZ(E44&!C=^D'T1/=NS].W<DLI['^IEF-HTGVE&)6
M?<FZ#*-WQ>WLF[J?&Y+\?OXM>T#9C(<'U+>#FO4H%M5W,AX[+NT;BSM7>C?I
M3,;/0]?3!-O6];'-,*4,<[X2F(K,=W)VMAD8'=)''R!D&Q^M1J.8V+U\)JY]
M)K//8HRXM8.E:+0*"_>MS!J#!Y6Y4(0BRQB`3AN4]'U%VX^&XZM+I1<&)76?
MM<@L2-Y"!=:ZU8/NKZCVO"K7^[6JO^'_OQ`^0'`!O-F(*_>.0%&2;/0DG^BZ
M5#>+=-ZX4:[7=6OA'A)*U1L8Y>7@^"ND`JR;N\77Z*MC9:[MK#XKVY2G:F?#
MC$([AZN9+;3F0X\UU;FNV-"?!?]U);JNR#0I0B5=&H>ZIJY/UT]HI:H?>%"K
M#XQE=V`,PK3U6+.R?:S*D##5SJ)0-G`(M@>,9*'QZ^QDU9N:OEI?*/T'A=JR
M^JE5ZT=?AS7:%B`[UE\Q<<`=9RL&.I9KS4K$KJK5!,WZV!5KMC[=J%A;9G@O
M%:N77`3K5;%".8._&R.3`)Z;G6_0G5Q@12\K!FI=)3C02RO+1'F?7]>`VKS5
MTHG5#]CY:45KUXX/Q@0\`8LRM2GEV/NY`O0SR.[(-L1:\=H\QWM`=L1P+U@9
MTV"M@2U/4>B&UTYI$>V(JJ1#8.I@AUJ"KYC%UTIO]S6(SV"Y.4L7:0=1/JW[
M:#I!M*;K77X8F<KK;-9P54#E>[*=>-II%[@53I7=7PA-",0FF*P(I[:U9W#R
M&8`IVQQO!5,^J7MM5#"]42'Z%=&V6&K8T>S$U=Y[JZT8:]U3?<`;QJ:9X8W0
M70$'3MZA^=@1I_><6P'7,,.?%'S44IL`K5'QB(E*?=61PZ:.O;'5&`3C>X(G
M8B/RQ?<.-OV/$^J"UZ5#K;PL+V.MY^^);D;TPC*4*FPO1[G)W!^OFS:&NF.U
M#2CO@W2\>%IIG+7YLAY7Y=E*G8*Y4WY4JS!6\J(>!)!9%IC'_020?P8:/\L;
M:Q7`?%;W$CHKWYKNU?@DBY.8LZ7FWTC`Z(?7[FD@W4#;3/]X@)Q@#B?_ZOR.
M!5"='].-N?($[X4^O1-#^Q="J9VCSX0HO8H];QG'<IYN+GT6.I\1O=[*X+6U
MZ7PI&W0^FWK\`W2^6E"\NCQ'P^!MH*9(+2J6S(#%].IB7I;-0.6AIR_<,)3Q
MU)W-OGR2/6=KNV!I2:S;A?QU;&46UFU;K$(Y#;]3=G<_`M`JMINI_VN)I2O,
MF6WN%Q5\#C9"'XQH%=?RQ.XEJ1E8[7X[@3-)U7DAV]B)YK,,G8#[D+,5K=#K
M.E-16BQCC++L--2_(&QP5/21DU84-L_Q_BEUVBGIC50S/-(M\=ATFJ`3C7L?
M;&B%8ON!!@P4.;<X!2!RL>^*F_@<D*@/?+0BL6F*]\*ACN6V6;IM@FKBW4B_
MO+*[DWO-*D[U!V;+;T6EY#]SQW;8O]:X#7[9(8(N[YGMZ3-KK(U8_WKOSIJO
M>O:L!UD['WTSW-M%^-P/WLI(O>#?UJ__C[[3;X!7H((=H,N)V,_V$A,P]^BW
MJK+C@;TA6S:[>R[1T<(7W"%JLQ"OX6_R/I51#/.S&;?U!W0<0G:N7,SF@*Z:
MR?)F=#'ZZ4U/,DO6:/SB]/+R_.K[TXN+\?#ZY0':/_A#>?#W$+T=`L5J",@(
MR;T87=9#P(='$3SZ1#]`21;)4MH0^ZGWNE7@IQLV1'U-)W;[?W_@0PX0&_]]
MZ\9_!K?/0W?NQ^ZM3*)I6LMA:SQ#C!UB@VZPJ;D27.2I;,3:>;O(08?LT1LC
M=<9ZNX,`X7YZP5)P'%F\-P7:TJK#4GF<VZ:U]:B#'7+@AK8VG786H8(:HT*I
M$2AMG776D@1;I#CEQP7:DG/SZM8$W>*T02U)EUG<1+;2DH)!V9N,6]"I9945
MAY5J267Y_8V<LO)PRLFY^?UZ0EEI>%WC.E![+(Y0B;H<XF:=J+O=@,+`#UI'
MI2O;AJ8KU^.K\:OK6IG.^RPXYUEZ&Y3U),F-E'BP&F>CJZO7UR73@AI,R]G5
MK]>O3B_&V?&3C[.'!/SI5&@.44XM%3H;6#U=<HT!B'72R:R:-+FN:S`<Q:MM
MR(?>/'U3RXO>.&_38&J*].A/]XL&-;^S]:<,,+9!J=M";0U8/$N(HKMO#8!K
M\CE8%/UK#UTV9=_DZ)%E]5H11^V,#AV]>>"(BF^9-7<]QQI[D2^]'8_4#!T=
MSSN9XSHD6$7M0T%5KC96639"("$,E?D7>.NY\I*QY\8@;.\7,)EPE?SV1W9J
MI.R:ZHT&;CM:S`-??[<PSC2"EE^0WA_D/%@FZ%K-9`CN4(P(&"?`T5(^T0W=
M<`'MX',\!^RM]4*M&X$%*W?#F+`JW?P2O9>`QSK)=]GM%JH$6Z1,U81HKT+U
M,DA=#UV.3(#S,24[4N>GWY>I8RQPA?H+&7O+F4S0#W`#O0+,IR`%;U[6N[G)
MV[7U8]KD_]0/^8?ZH?]0/^P?ZH=_A'Y`AH4Z3#%2"S.(LGK'5<,^^NZRP@-A
MU3E]=1/,;Q>NCX2%6^02;BG+H)I[L]MX.1_?N-YMXZ![^J[-<]$WR-^;XU,0
MM5?T4S,!>A"W,G&.GB[GR7*QB.)4^FJ3\H'\NOT9:$5T%Z0WT3)%U]>C(4ID
M6K1<NS5">>3J'9GJK#S=".VW\,#*S4H^F&XVYF8^C-:SBE47K*&R>JP07!SS
MS9LUW?JD?AR.ZR=L/A;'])-Q+#X1QV(3+TP'&L+D>-,-;C@UE)\J:'.#VXX.
MY55M;K!BK],-5@W:W>#B=X9V]8-W_,&C[I."-6+ZI"#5QPX%S[UALO,OB2AG
MV'[LOG#V<U!]Q\OW7'#5"WTC2ON75JA.BX2F#D2N'[RXTKB0TN0XKQ=7.@ZC
MF]ER+92B>KKO23XW&T=VL]O-<EI4-IW=S>O6DEK\P*IW([U;$,EGS+2G%@,0
*_0\PPP[ZTE4`````
`
end
