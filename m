Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283379AbRLIMcj>; Sun, 9 Dec 2001 07:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283380AbRLIMca>; Sun, 9 Dec 2001 07:32:30 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:31665 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283379AbRLIMcP>; Sun, 9 Dec 2001 07:32:15 -0500
Date: Sun, 9 Dec 2001 14:34:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <marcelo@conectiva.com.br>
Cc: <torvalds@transmeta.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
        <scott@spiteful.org>
Subject: [PATCH] Power Management support for opl3sa2
Message-ID: <Pine.LNX.4.33.0112091427410.17944-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enables the power management features of the opl3sa2 and according to the
databooks it should work for all the chipsets supported by opl3sa2. I've
tested it on a YMF715 with positive results.

I can't push this to the driver maintainer first and then from there to
Linus and Marcelo because the maintainer isn't responding to mail.

Regards,
	Zwane Mwaikambo

Diffed against 2.4.17-pre6 Please apply, however it applies on 2.5.1-pre
as well.

diff -urN linux-2.4.17-pre6.orig/drivers/sound/opl3sa2.c linux-2.4.17-pre6.test/drivers/sound/opl3sa2.c
--- linux-2.4.17-pre6.orig/drivers/sound/opl3sa2.c	Thu Oct 11 18:43:30 2001
+++ linux-2.4.17-pre6.test/drivers/sound/opl3sa2.c	Sun Dec  9 11:41:26 2001
@@ -55,6 +55,7 @@
  *                         sb_card.c and awe_wave.c. (Dec 12, 2000)
  * Scott Murray            Some small cleanups to the init code output.
  *                         (Jan 7, 2001)
+ * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
  *
  */

@@ -62,13 +63,14 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/isapnp.h>
-
+#include <linux/pm.h>
 #include "sound_config.h"

 #include "ad1848.h"
 #include "mpu401.h"

 /* Useful control port indexes: */
+#define OPL3SA2_PM	     0x01
 #define OPL3SA2_SYS_CTRL     0x02
 #define OPL3SA2_IRQ_CONFIG   0x03
 #define OPL3SA2_DMA_CONFIG   0x06
@@ -86,6 +88,11 @@
 #define DEFAULT_MIC    50
 #define DEFAULT_TIMBRE 0

+/* Power saving modes */
+#define OPL3SA2_PM_MODE1	0x05
+#define OPL3SA2_PM_MODE2	0x04
+#define OPL3SA2_PM_MODE3	0x03
+
 /* For checking against what the card returns: */
 #define VERSION_UNKNOWN 0
 #define VERSION_YMF711  1
@@ -121,6 +128,10 @@
 typedef struct opl3sa2_mixerdata_tag {
 	unsigned short cfg_port;
 	unsigned short padding;
+	unsigned char  reg;
+	unsigned int   in_suspend;
+	struct pm_dev  *pmdev;
+	unsigned int   card;
 	unsigned int   volume_l;
 	unsigned int   volume_r;
 	unsigned int   mic;
@@ -328,6 +339,20 @@
 }


+static void opl3sa2_mixer_restore(opl3sa2_mixerdata* devc, int card)
+{
+	if (devc) {
+		opl3sa2_set_volume(devc, devc->volume_l, devc->volume_r);
+		opl3sa2_set_mic(devc, devc->mic);
+
+		if (chipset[card] == CHIPSET_OPL3SA3) {
+			opl3sa3_set_bass(devc, devc->bass_l, devc->bass_r);
+			opl3sa3_set_treble(devc, devc->treble_l, devc->treble_r);
+		}
+	}
+}
+
+
 static inline void arg_to_vol_mono(unsigned int vol, int* value)
 {
 	int left;
@@ -892,6 +917,77 @@

 /* End of component functions */

+/* Power Management support functions */
+static int opl3sa2_suspend(struct pm_dev *pdev, unsigned char pm_mode)
+{
+	unsigned long flags;
+	opl3sa2_mixerdata *p;
+
+	if (!pdev)
+		return -EINVAL;
+
+	save_flags(flags);
+	cli();
+
+	p = (opl3sa2_mixerdata *) pdev->data;
+	p->in_suspend = 1;
+	switch (pm_mode) {
+	case 1:
+		pm_mode = OPL3SA2_PM_MODE1;
+		break;
+	case 2:
+		pm_mode = OPL3SA2_PM_MODE2;
+		break;
+	case 3:
+		pm_mode = OPL3SA2_PM_MODE3;
+		break;
+	default:
+		pm_mode = OPL3SA2_PM_MODE3;
+		break;
+	}
+
+	/* its supposed to automute before suspending, so we wont bother */
+	opl3sa2_read(p->cfg_port, OPL3SA2_PM, &p->reg);
+	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg | pm_mode);
+
+	restore_flags(flags);
+	return 0;
+}
+
+static int opl3sa2_resume(struct pm_dev *pdev)
+{
+	unsigned long flags;
+	opl3sa2_mixerdata *p;
+
+	if (!pdev)
+		return -EINVAL;
+
+	p = (opl3sa2_mixerdata *) pdev->data;
+	save_flags(flags);
+	cli();
+
+	/* I don't think this is necessary */
+	opl3sa2_write(p->cfg_port, OPL3SA2_PM, p->reg);
+	opl3sa2_mixer_restore(p, p->card);
+	p->in_suspend = 0;
+
+	restore_flags(flags);
+	return 0;
+}
+
+static int opl3sa2_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
+{
+	unsigned char mode = (unsigned  char)data;
+
+	switch (rqst) {
+		case PM_SUSPEND:
+			return opl3sa2_suspend(pdev, mode);
+
+		case PM_RESUME:
+			return opl3sa2_resume(pdev);
+	}
+	return 0;
+}

 /*
  * Install OPL3-SA2 based card(s).
@@ -980,7 +1076,7 @@
 				       " of the ISA PNP cards, continuing\n");
 				opl3sa2_cards_num--;
 				continue;
-			} else
+			} else
 				return -ENODEV;
 		}

@@ -988,7 +1084,13 @@
 		conf_printf(chipset_name[card], &cfg[card]);
 		attach_opl3sa2_mss(&cfg_mss[card]);
 		attach_opl3sa2_mixer(&cfg[card], card);
-
+
+		opl3sa2_data[card].card = card;
+		/* register our power management capabilities */
+		opl3sa2_data[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
+		if (opl3sa2_data[card].pmdev)
+			opl3sa2_data[card].pmdev->data = &opl3sa2_data[card];
+
 		/*
 		 * Set the Yamaha 3D enhancement mode (aka Ymersion) if asked to and
 		 * it's supported.
@@ -1033,6 +1135,9 @@
 	int card;

 	for(card = 0; card < opl3sa2_cards_num; card++) {
+		if (opl3sa2_data[card].pmdev)
+			pm_unregister(opl3sa2_data[card].pmdev);
+
 	        if(cfg_mpu[card].slots[1] != -1) {
 			unload_opl3sa2_mpu(&cfg_mpu[card]);
 		}

