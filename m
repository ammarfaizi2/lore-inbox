Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292311AbSBPIY3>; Sat, 16 Feb 2002 03:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292320AbSBPIYU>; Sat, 16 Feb 2002 03:24:20 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:43398 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292311AbSBPIYJ>; Sat, 16 Feb 2002 03:24:09 -0500
Date: Sat, 16 Feb 2002 10:14:40 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: abramo@alsa-project.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH][2.5-ALSA] Power Management for es18xx
Message-ID: <Pine.LNX.4.44.0202161009310.18770-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	Patch to get PM working for es18xx, i tried to use all the 
supported cards data sheets as a reference, the common denominator is 
suspend mode only, 1879 (perhaps others i dont have sheets for) doesn't 
support power down via register 7.

Cheers,
	Zwane Mwaikambo

--- linux-2.5-test/sound/isa/es18xx.c.orig	Sat Feb 16 06:36:13 2002
+++ linux-2.5-test/sound/isa/es18xx.c	Sat Feb 16 09:17:54 2002
@@ -68,6 +68,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>
+#include <linux/pm.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -116,6 +117,10 @@
 	spinlock_t reg_lock;
 	spinlock_t mixer_lock;
 	spinlock_t ctrl_lock;
+#ifdef CONFIG_PM
+	struct pm_dev *pm_dev;
+	unsigned char pm_reg;
+#endif
 };
 
 #define AUDIO1_IRQ	0x01
@@ -136,6 +141,15 @@
 #define ES18XX_MUTEREC	0x0400	/* Record source can be muted */
 #define ES18XX_CONTROL	0x0800	/* Has control ports */
 
+/* Power Management */
+#define ES18XX_PM	0x07
+#define ES18XX_PM_GPO0	0x01
+#define ES18XX_PM_GPO1	0x02
+#define ES18XX_PM_PDR	0x03
+#define ES18XX_PM_ANA	0x04
+#define ES18XX_PM_FM	0x06
+#define ES18XX_PM_SUS	0x08
+
 typedef struct _snd_es18xx es18xx_t;
 
 #define chip_t es18xx_t
@@ -1587,8 +1601,87 @@
 	return 0;
 }
 
+/* Power Management support functions */
+#ifdef CONFIG_PM
+static void snd_es18xx_suspend(es18xx_t *chip, int can_schedule)
+{
+	snd_card_t *card = chip->card;
+
+	snd_power_lock(card, can_schedule);
+	if (card->power_state == SNDRV_CTL_POWER_D3hot)
+		goto __skip;
+
+	snd_pcm_suspend_all(chip->pcm);
+
+	/* power down */
+	chip->pm_reg = (unsigned char)snd_es18xx_read(chip, ES18XX_PM);
+	chip->pm_reg |= (ES18XX_PM_FM | ES18XX_PM_SUS);
+	snd_es18xx_write(chip, ES18XX_PM, chip->pm_reg);
+	snd_es18xx_write(chip, ES18XX_PM, chip->pm_reg ^= ES18XX_PM_SUS);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+      __skip:
+      	snd_power_unlock(card);
+}
+
+static void snd_es18xx_resume(es18xx_t *chip, int can_schedule)
+{
+	snd_card_t *card = chip->card;
+
+	snd_power_lock(card, can_schedule);
+	if (card->power_state == SNDRV_CTL_POWER_D0)
+		goto __skip;
+
+	/* restore PM register, we won't wake till (not 0x07) i/o activity though */
+	snd_es18xx_write(chip, ES18XX_PM, chip->pm_reg ^= ES18XX_PM_FM);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+      __skip:
+      	snd_power_unlock(card);
+}
+
+/* callback for control API */
+static int snd_es18xx_set_power_state(snd_card_t *card, unsigned int power_state)
+{
+	es18xx_t *chip = (es18xx_t *) card->power_state_private_data;
+	switch (power_state) {
+	case SNDRV_CTL_POWER_D0:
+	case SNDRV_CTL_POWER_D1:
+	case SNDRV_CTL_POWER_D2:
+		snd_es18xx_resume(chip, 1);
+		break;
+	case SNDRV_CTL_POWER_D3hot:
+	case SNDRV_CTL_POWER_D3cold:
+		snd_es18xx_suspend(chip, 1);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int snd_es18xx_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+{
+	es18xx_t *chip = snd_magic_cast(es18xx_t, dev->data, return 0);
+
+	switch (rqst) {
+	case PM_SUSPEND:
+		snd_es18xx_suspend(chip, 0);
+		break;
+	case PM_RESUME:
+		snd_es18xx_resume(chip, 0);
+		break;
+	}
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static int snd_es18xx_free(es18xx_t *chip)
 {
+#ifdef CONFIG_PM
+	if (chip->pm_dev)
+		pm_unregister(chip->pm_dev);
+#endif
 	if (chip->res_port) {
 		release_resource(chip->res_port);
 		kfree(chip->res_port);
@@ -2066,6 +2159,17 @@
 		}
 		chip->rmidi = rmidi;
 	}
+
+#ifdef CONFIG_PM
+	/* Power Management */
+	chip->pm_dev = pm_register(PM_ISA_DEV, 0, snd_es18xx_pm_callback);
+	if (chip->pm_dev) {
+		chip->pm_dev->data = chip;
+		/* set control api callback */
+		card->set_power_state = snd_es18xx_set_power_state;
+		card->power_state_private_data = chip;
+	}
+#endif
 	sprintf(card->driver, "ES%x", chip->version);
 	sprintf(card->shortname, "ESS AudioDrive ES%x", chip->version);
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma1 %d, dma2 %d",

