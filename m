Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282343AbRLDIzH>; Tue, 4 Dec 2001 03:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282646AbRLDIzB>; Tue, 4 Dec 2001 03:55:01 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:10678 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S279814AbRLDIyp>; Tue, 4 Dec 2001 03:54:45 -0500
Date: Tue, 4 Dec 2001 10:57:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: <linux-sound@vger.kernel.org>, <scott@spiteful.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [TESTING-PATCH] PM support for opl3sa2.c
Message-ID: <Pine.LNX.4.33.0112041036540.22291-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add power management support for the YMF7XX cards handled by
opl3sa2.c I've tested with a YMF715 but checked the data sheets for YMF711
and verified that it "should" work. It passed the compile and no "oops"
tests ;) and i can safely rmmod and modprobe after apm -s. Test results
and comments are very welcome, especially on my usage of (void *data) in
pm_callback and the additions to the mixerdata struct (its not quite mixer
data anymore ;)

One thing to note with this patch is that its supposed to disable the
whole device, which includes ad1848 hardware, opl3 fm chip etc...
Currently ad1848 has its own PM management as well and does restoring of
mixer levels so thats not handled in our resume function. I would also
like to know if it would be possible to test power consumption of the
device during suspend, i couldnt test this as i have a desktop machine.

Again, comments/suggestions/tests would be greatly appreciated.

Cheers,
	Zwane Mwaikambo

diffed against 2.4.17-pre2 but applies clean on 2.5.1-pre5 and probably a
lot of older kernels.

--- linux-2.4.17-pre2-orig/drivers/sound/opl3sa2.c	Thu Oct 11 18:43:30 2001
+++ linux-2.4.17-pre2/drivers/sound/opl3sa2.c	Tue Dec  4 10:51:22 2001
@@ -55,6 +55,7 @@
  *                         sb_card.c and awe_wave.c. (Dec 12, 2000)
  * Scott Murray            Some small cleanups to the init code output.
  *                         (Jan 7, 2001)
+ * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
  *
  */

@@ -62,7 +63,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/isapnp.h>
-
+#include <linux/pm.h>
 #include "sound_config.h"

 #include "ad1848.h"
@@ -86,6 +87,11 @@
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
@@ -121,6 +127,9 @@
 typedef struct opl3sa2_mixerdata_tag {
 	unsigned short cfg_port;
 	unsigned short padding;
+	unsigned char  reg;
+	unsigned int   in_suspend;
+	struct pm_dev  *pmdev;
 	unsigned int   volume_l;
 	unsigned int   volume_r;
 	unsigned int   mic;
@@ -892,6 +901,79 @@

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
+	opl3sa2_read(p->cfg_port, OPL3SA2_SYS_CTRL, &p->reg);
+	opl3sa2_write(p->cfg_port, OPL3SA2_SYS_CTRL, p->reg | pm_mode);
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
+	opl3sa2_write(p->cfg_port, OPL3SA2_SYS_CTRL, p->reg);
+	p->in_suspend = 0;
+
+	/* The volume is muted on suspend, but ad1848 seems to handle the
+	 * restoring of mixer levels.
+	 */
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
@@ -980,7 +1062,7 @@
 				       " of the ISA PNP cards, continuing\n");
 				opl3sa2_cards_num--;
 				continue;
-			} else
+			} else
 				return -ENODEV;
 		}

@@ -989,6 +1071,13 @@
 		attach_opl3sa2_mss(&cfg_mss[card]);
 		attach_opl3sa2_mixer(&cfg[card], card);

+		/* register our power management capabilities */
+		opl3sa2_data[card].pmdev = pm_register(PM_ISA_DEV, card, opl3sa2_pm_callback);
+		if (opl3sa2_data[card].pmdev) {
+			opl3sa2_data[card].pmdev->data = &opl3sa2_data[card];
+			opl3sa2_data[card].in_suspend = 0;
+		}
+
 		/*
 		 * Set the Yamaha 3D enhancement mode (aka Ymersion) if asked to and
 		 * it's supported.
@@ -1033,6 +1122,7 @@
 	int card;

 	for(card = 0; card < opl3sa2_cards_num; card++) {
+		pm_unregister(opl3sa2_data[card].pmdev);
 	        if(cfg_mpu[card].slots[1] != -1) {
 			unload_opl3sa2_mpu(&cfg_mpu[card]);
 		}

