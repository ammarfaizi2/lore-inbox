Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262542AbUKQVg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUKQVg3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKQVfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:35:02 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:22276 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262553AbUKQVb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:31:56 -0500
Date: Wed, 17 Nov 2004 16:28:27 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, alan@redhat.com
Subject: [patch 2.4.28-rc3] oss: AC97 quirk facility
Message-ID: <20041117162827.D31363@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	alan@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk facility for AC97 in OSS, and add a quirk list for the
i810_audio driver.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This allows automatically "correct" behaviour for sound hardware w/
known oddities.  For example, many cards have the headphone and
line-out outputs swapped or headphone outputs only.

The code is stolen shamelessly from ALSA, FWIW...

 drivers/sound/ac97_codec.c |   91 +++++++++++++++++++++++++++++++++
 drivers/sound/i810_audio.c |  124 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ac97_codec.h |   21 +++++++
 3 files changed, 236 insertions(+)

--- oss_ac97_quirk-2.4/drivers/sound/ac97_codec.c.orig
+++ oss_ac97_quirk-2.4/drivers/sound/ac97_codec.c
@@ -56,6 +56,7 @@
 #include <linux/errno.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/ac97_codec.h>
 #include <asm/uaccess.h>
 
@@ -134,6 +135,9 @@ static const struct {
 	{0x41445348, "Analog Devices AD1881A",	&null_ops},
 	{0x41445360, "Analog Devices AD1885",	&default_ops},
 	{0x41445361, "Analog Devices AD1886",	&ad1886_ops},
+	{0x41445370, "Analog Devices AD1981",	&null_ops},
+	{0x41445372, "Analog Devices AD1981A",	&null_ops},
+	{0x41445374, "Analog Devices AD1981B",	&null_ops},
 	{0x41445460, "Analog Devices AD1885",	&default_ops},
 	{0x41445461, "Analog Devices AD1886",	&ad1886_ops},
 	{0x414B4D00, "Asahi Kasei AK4540",	&null_ops},
@@ -1482,5 +1486,92 @@ void ac97_unregister_driver(struct ac97_
 }
 
 EXPORT_SYMBOL_GPL(ac97_unregister_driver);
+
+static int swap_headphone(int remove_master)
+{
+	struct list_head *l;
+	struct ac97_codec *c;
 	
+	if (remove_master) {
+		down(&codec_sem);
+		list_for_each(l, &codecs)
+		{
+			c = list_entry(l, struct ac97_codec, list);
+			if (supported_mixer(c, SOUND_MIXER_PHONEOUT))
+				c->supported_mixers &= ~SOUND_MASK_PHONEOUT;
+		}
+		up(&codec_sem);
+	} else
+		ac97_hw[SOUND_MIXER_PHONEOUT].offset = AC97_MASTER_VOL_STEREO;
+
+	/* Scale values already match */
+	ac97_hw[SOUND_MIXER_VOLUME].offset = AC97_MASTER_VOL_MONO;
+	return 0;
+}
+
+static int apply_quirk(int quirk)
+{
+	switch (quirk) {
+	case AC97_TUNE_NONE:
+		return 0;
+	case AC97_TUNE_HP_ONLY:
+		return swap_headphone(1);
+	case AC97_TUNE_SWAP_HP:
+		return swap_headphone(0);
+	case AC97_TUNE_SWAP_SURROUND:
+		return -ENOSYS; /* not yet implemented */
+	case AC97_TUNE_AD_SHARING:
+		return -ENOSYS; /* not yet implemented */
+	case AC97_TUNE_ALC_JACK:
+		return -ENOSYS; /* not yet implemented */
+	}
+	return -EINVAL;
+}
+
+/**
+ *	ac97_tune_hardware - tune up the hardware
+ *	@pdev: pci_dev pointer
+ *	@quirk: quirk list
+ *	@override: explicit quirk value (overrides if not AC97_TUNE_DEFAULT)
+ *	
+ *	Do some workaround for each pci device, such as renaming of the
+ *	headphone (true line-out) control as "Master".
+ *	The quirk-list must be terminated with a zero-filled entry.
+ *	
+ *	Returns zero if successful, or a negative error code on failure.
+ */
+
+int ac97_tune_hardware(struct pci_dev *pdev, struct ac97_quirk *quirk, int override)
+{
+	int result;
+
+	if (!quirk)
+		return -EINVAL;
+
+	if (override != AC97_TUNE_DEFAULT) {
+		result = apply_quirk(override);
+		if (result < 0)
+			printk(KERN_ERR "applying quirk type %d failed (%d)\n", override, result);
+		return result;
+	}
+
+	for (; quirk->vendor; quirk++) {
+		if (quirk->vendor != pdev->subsystem_vendor)
+			continue;
+		if ((! quirk->mask && quirk->device == pdev->subsystem_device) ||
+		    quirk->device == (quirk->mask & pdev->subsystem_device)) {
+#ifdef DEBUG
+			printk("ac97 quirk for %s (%04x:%04x)\n", quirk->name, ac97->subsystem_vendor, pdev->subsystem_device);
+#endif
+			result = apply_quirk(quirk->type);
+			if (result < 0)
+				printk(KERN_ERR "applying quirk type %d for %s failed (%d)\n", quirk->type, quirk->name, result);
+			return result;
+		}
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(ac97_tune_hardware);
+
 MODULE_LICENSE("GPL");
--- oss_ac97_quirk-2.4/drivers/sound/i810_audio.c.orig
+++ oss_ac97_quirk-2.4/drivers/sound/i810_audio.c
@@ -112,6 +112,7 @@ static int ftsodell;
 static int strict_clocking;
 static unsigned int clocking;
 static int spdif_locked;
+static int ac97_quirk = AC97_TUNE_DEFAULT;
 
 //#define DEBUG
 //#define DEBUG2
@@ -465,6 +466,124 @@ struct i810_card {
 #define CIV_TO_LVI(port, off) \
 	outb(MODULOP2(GET_CIV((port)) + (off), SG_LEN), (port) + OFF_LVI)
 
+static struct ac97_quirk ac97_quirks[] __devinitdata = {
+	{
+		.vendor = 0x0e11,
+		.device = 0x00b8,
+		.name = "Compaq Evo D510C",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x1028,
+		.device = 0x00d8,
+		.name = "Dell Precision 530",   /* AD1885 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x1028,
+		.device = 0x0126,
+		.name = "Dell Optiplex GX260",  /* AD1981A */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x1028,
+		.device = 0x012d,
+		.name = "Dell Precision 450",   /* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{       /* FIXME: which codec? */
+		.vendor = 0x103c,
+		.device = 0x00c3,
+		.name = "Hewlett-Packard onboard",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x12f1,
+		.name = "HP xw8200",    /* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x3008,
+		.name = "HP xw4200",    /* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x10f1,
+		.device = 0x2665,
+		.name = "Fujitsu-Siemens Celsius",      /* AD1981? */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x10f1,
+		.device = 0x2885,
+		.name = "AMD64 Mobo",   /* ALC650 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x110a,
+		.device = 0x0056,
+		.name = "Fujitsu-Siemens Scenic",       /* AD1981? */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x11d4,
+		.device = 0x5375,
+		.name = "ADI AD1985 (discrete)",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x1462,
+		.device = 0x5470,
+		.name = "MSI P4 ATX 645 Ultra",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x1734,
+		.device = 0x0088,
+		.name = "Fujitsu-Siemens D1522",	/* AD1981 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x8086,
+		.device = 0x4856,
+		.name = "Intel D845WN (82801BA)",
+		.type = AC97_TUNE_SWAP_HP
+	},
+	{
+		.vendor = 0x8086,
+		.device = 0x4d44,
+		.name = "Intel D850EMV2",       /* AD1885 */
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x8086,
+		.device = 0x4d56,
+		.name = "Intel ICH/AD1885",
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x1028,
+		.device = 0x012d,
+		.name = "Dell Precision 450",   /* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x3008,
+		.name = "HP xw4200",    /* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{
+		.vendor = 0x103c,
+		.device = 0x12f1,
+		.name = "HP xw8200",    /* AD1981B*/
+		.type = AC97_TUNE_HP_ONLY
+	},
+	{ } /* terminator */
+};
+
 static struct i810_card *devs = NULL;
 
 static int i810_open_mixdev(struct inode *inode, struct file *file);
@@ -3021,6 +3140,9 @@ static int __devinit i810_ac97_init(stru
 		card->ac97_codec[num_ac97] = codec;
 	}
 
+	/* tune up the primary codec */
+	ac97_tune_hardware(card->pci_dev, ac97_quirks, ac97_quirk);
+
 	/* pick the minimum of channels supported by ICHx or codec(s) */
 	card->channels = (card->channels > total_channels)?total_channels:card->channels;
 
@@ -3434,6 +3556,8 @@ MODULE_PARM(ftsodell, "i");
 MODULE_PARM(clocking, "i");
 MODULE_PARM(strict_clocking, "i");
 MODULE_PARM(spdif_locked, "i");
+MODULE_PARM(ac97_quirk, "i");
+MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 
 #define I810_MODULE_NAME "intel810_audio"
 
--- oss_ac97_quirk-2.4/include/linux/ac97_codec.h.orig
+++ oss_ac97_quirk-2.4/include/linux/ac97_codec.h
@@ -316,4 +316,25 @@ struct ac97_driver {
 extern int ac97_register_driver(struct ac97_driver *driver);
 extern void ac97_unregister_driver(struct ac97_driver *driver);
 
+/* quirk types */
+enum {
+	AC97_TUNE_DEFAULT = -1, /* use default from quirk list (not valid in list) */
+	AC97_TUNE_NONE = 0,     /* nothing extra to do */
+	AC97_TUNE_HP_ONLY,      /* headphone (true line-out) control as master only */
+	AC97_TUNE_SWAP_HP,      /* swap headphone and master controls */
+	AC97_TUNE_SWAP_SURROUND, /* swap master and surround controls */
+	AC97_TUNE_AD_SHARING,   /* for AD1985, turn on OMS bit and use headphone */
+	AC97_TUNE_ALC_JACK,     /* for Realtek, enable JACK detection */
+};
+
+struct ac97_quirk {
+	unsigned short vendor;  /* PCI vendor id */
+	unsigned short device;  /* PCI device id */
+	unsigned short mask;    /* device id bit mask, 0 = accept all */
+	const char *name;       /* name shown as info */
+	int type;               /* quirk type above */
+};
+
+extern int ac97_tune_hardware(struct pci_dev *pdev, struct ac97_quirk *quirk, int override);
+
 #endif /* _AC97_CODEC_H_ */
