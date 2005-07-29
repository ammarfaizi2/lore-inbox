Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVG2X6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVG2X6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVG2X4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:56:44 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:13971 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S262864AbVG2VWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:22:39 -0400
Message-ID: <42EA9E1C.8020202@brturbo.com.br>
Date: Fri, 29 Jul 2005 18:22:36 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.6-1mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH] V4L miscelaneous bug fixes
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/mixed;
 boundary="------------090103070704070409010607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090103070704070409010607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090103070704070409010607
Content-Type: text/x-patch;
 name="v4l_misc_bug_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_misc_bug_fixes.diff"

- Fixed some bttv card numbers.
- BTTV and SAA7134 version numbers incremented to reflect changes.

- pci_dma_supported() is called after pci_set_dma_mask() which
  already did check that for us. This patch removes the unneeded call to 
  pci_dma_supported() at bttv-driver.c

- Ensure a sufficient I2C bus idle time between 2 messages for saa7134-i2c.c

- It is important to write at first to MO_GP3_IO for cx88-tvaudio.c

- Use try_to_freeze() instead of refrigerator at msp3400.c

- Recognizing the MFPE05-2 Tuner at tveeprom.c

- Add new parameter to help identify radio chipsets at tuner module:
  show_i2c=1 will show 16 reading bytes from detected tuners.

- BTTV does generate some Unimplemented IOCTL log at tuner module:
  0x40046d11(dir=1,tp=0x6d,nr=17,sz=4) means that it is sending
  MSP3400 calls to non-msp3400 tuners. Warning eliminated.
  VIDIOSAUDIO is also called, so debug messages updated. It is still
  requiring IOCTL implementation.


Signed-off-by: Graham Bevan <graham.bevan@ntlworld.com>
Signed-off-by: Torsten Seeboth <Torsten.Seeboth@t-online.de>
Signed-off-by: Hartmut Hackmann <hartmut.hackmann@t.online.de>
Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/bttv-driver.c         |    8 +---
 linux/drivers/media/video/bttv.h                |    6 ++-
 linux/drivers/media/video/bttvp.h               |    4 +-
 linux/drivers/media/video/cx88/cx88-video.c     |    4 +-
 linux/drivers/media/video/msp3400.c             |    3 -
 linux/drivers/media/video/saa7134/saa7134-i2c.c |    4 +-
 linux/drivers/media/video/saa7134/saa7134.h     |    4 +-
 linux/drivers/media/video/tea5767.c             |   15 ++++----
 linux/drivers/media/video/tuner-core.c          |   29 +++++++++++++++-
 linux/drivers/media/video/tveeprom.c            |    2 -
 10 files changed, 53 insertions(+), 26 deletions(-)

diff -u linux-2.6.13/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.13/drivers/media/video/bttv.h	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/bttv.h	2005-07-28 18:59:59.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: bttv.h,v 1.18 2005/05/24 23:41:42 nsh Exp $
+ * $Id: bttv.h,v 1.22 2005/07/28 18:41:21 mchehab Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
@@ -135,7 +135,9 @@
 #define BTTV_DVICO_DVBT_LITE  0x80
 #define BTTV_TIBET_CS16  0x83
 #define BTTV_KODICOM_4400R  0x84
-#define BTTV_ADLINK_RTV24   0x85
+#define BTTV_ADLINK_RTV24   0x86
+#define BTTV_DVICO_FUSIONHDTV_5_LITE 0x87
+#define BTTV_ACORP_Y878F   0x88
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
diff -u linux-2.6.13/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.13/drivers/media/video/bttvp.h	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/bttvp.h	2005-07-28 18:59:59.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.19 2005/06/16 21:38:45 nsh Exp $
+    $Id: bttvp.h,v 1.21 2005/07/15 21:44:14 mchehab Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -27,7 +27,7 @@
 #define _BTTVP_H_
 
 #include <linux/utsname.h>
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,15)
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,16)
 
 #include <linux/types.h>
 #include <linux/wait.h>
diff -u linux-2.6.13/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.13/drivers/media/video/bttv-driver.c	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-07-28 18:59:59.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.42 2005/07/05 17:37:35 nsh Exp $
+    $Id: bttv-driver.c,v 1.45 2005/07/20 19:43:24 mkrufky Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -3869,11 +3869,6 @@
         pci_set_master(dev);
 	pci_set_command(dev);
 	pci_set_drvdata(dev,btv);
-	if (!pci_dma_supported(dev,0xffffffff)) {
-		printk("bttv%d: Oops: no 32bit PCI DMA ???\n", btv->c.nr);
-		result = -EIO;
-		goto fail1;
-	}
 
         pci_read_config_byte(dev, PCI_CLASS_REVISION, &btv->revision);
         pci_read_config_byte(dev, PCI_LATENCY_TIMER, &lat);
@@ -4032,6 +4027,7 @@
 	struct bttv_buffer_set idle;
 	unsigned long flags;
 
+	dprintk("bttv%d: suspend %d\n", btv->c.nr, state.event);
 
 	/* stop dma + irqs */
 	spin_lock_irqsave(&btv->s_lock,flags);

diff -u linux-2.6.13/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-video.c	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-07-28 18:59:59.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.80 2005/07/13 08:49:08 mchehab Exp $
+ * $Id: cx88-video.c,v 1.82 2005/07/22 05:13:34 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -758,10 +758,10 @@
 		struct cx88_core *core = dev->core;
 		int board = core->board;
 		dprintk(1,"video_open: setting radio device\n");
+		cx_write(MO_GP3_IO, cx88_boards[board].radio.gpio3);
 		cx_write(MO_GP0_IO, cx88_boards[board].radio.gpio0);
 		cx_write(MO_GP1_IO, cx88_boards[board].radio.gpio1);
 		cx_write(MO_GP2_IO, cx88_boards[board].radio.gpio2);
-		cx_write(MO_GP3_IO, cx88_boards[board].radio.gpio3);
 		dev->core->tvaudio = WW_FM;
 		cx88_set_tvaudio(core);
 		cx88_set_stereo(core,V4L2_TUNER_MODE_STEREO,1);
diff -u linux-2.6.13/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.13/drivers/media/video/msp3400.c	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/msp3400.c	2005-07-28 18:59:59.000000000 -0300
@@ -741,10 +741,9 @@
 			schedule_timeout(msecs_to_jiffies(timeout));
 		}
 	}
-	if (freezing(current))
-		refrigerator();
 
 	remove_wait_queue(&msp->wq, &wait);
+	try_to_freeze();
 	return msp->restart;
 }
 
diff -u linux-2.6.13/drivers/media/video/tuner-core.c linux/drivers/media/video/tuner-core.c
--- linux-2.6.13/drivers/media/video/tuner-core.c	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-07-28 18:59:59.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.58 2005/07/14 03:06:43 mchehab Exp $
+ * $Id: tuner-core.c,v 1.63 2005/07/28 18:19:55 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -23,6 +23,8 @@
 #include <media/tuner.h>
 #include <media/audiochip.h>
 
+#include "msp3400.h"
+
 #define UNSET (-1U)
 
 /* standard i2c insmod options */
@@ -42,6 +44,9 @@
 static unsigned int no_autodetect = 0;
 module_param(no_autodetect, int, 0444);
 
+static unsigned int show_i2c = 0;
+module_param(show_i2c, int, 0444);
+
 /* insmod options used at runtime => read/write */
 unsigned int tuner_debug = 0;
 module_param(tuner_debug, int, 0644);
@@ -320,6 +325,17 @@
 
 	tuner_info("chip found @ 0x%x (%s)\n", addr << 1, adap->name);
 
+	if (show_i2c) {
+		unsigned char buffer[16];
+		int i,rc;
+
+		memset(buffer, 0, sizeof(buffer));
+		rc = i2c_master_recv(&t->i2c, buffer, sizeof(buffer));
+		printk("tuner-%04x I2C RECV = ",addr);
+		for (i=0;i<rc;i++)
+			printk("%02x ",buffer[i]);
+		printk("\n");
+	}
 	/* TEA5767 autodetection code - only for addr = 0xc0 */
 	if (!no_autodetect) {
 		if (addr == 0x60) {
@@ -451,6 +467,17 @@
 			break;
 		}
 		break;
+	case VIDIOCSAUDIO:
+		if (check_mode(t, "VIDIOCSAUDIO") == EINVAL)
+			return 0;
+		if (check_v4l2(t) == EINVAL)
+			return 0;
+
+		/* Should be implemented, since bttv calls it */
+		tuner_dbg("VIDIOCSAUDIO not implemented.\n");
+
+		break;
+	case MSP_SET_MATRIX:
 	case TDA9887_SET_CONFIG:
 		break;
 	/* --- v4l ioctls --- */
diff -u linux-2.6.13/drivers/media/video/tea5767.c linux/drivers/media/video/tea5767.c
--- linux-2.6.13/drivers/media/video/tea5767.c	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/tea5767.c	2005-07-28 19:00:00.000000000 -0300
@@ -2,7 +2,7 @@
  * For Philips TEA5767 FM Chip used on some TV Cards like Prolink Pixelview
  * I2C address is allways 0xC0.
  *
- * $Id: tea5767.c,v 1.21 2005/07/14 03:06:43 mchehab Exp $
+ * $Id: tea5767.c,v 1.26 2005/07/27 12:00:36 mkrufky Exp $
  *
  * Copyright (c) 2005 Mauro Carvalho Chehab (mchehab@brturbo.com.br)
  * This code is placed under the terms of the GNU General Public License
@@ -15,7 +15,6 @@
 #include <linux/videodev.h>
 #include <linux/delay.h>
 #include <media/tuner.h>
-#include <media/tuner.h>
 
 #define PREFIX "TEA5767 "
 
@@ -293,7 +292,7 @@
 
 int tea5767_autodetection(struct i2c_client *c)
 {
-	unsigned char buffer[5] = { 0xff, 0xff, 0xff, 0xff, 0xff };
+	unsigned char buffer[7] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 	int rc;
 	struct tuner *t = i2c_get_clientdata(c);
 
@@ -302,7 +301,7 @@
 		return EINVAL;
 	}
 
-	/* If all bytes are the same then it's a TV tuner and not a tea5767 chip. */
+	/* If all bytes are the same then it's a TV tuner and not a tea5767 */
 	if (buffer[0] == buffer[1] && buffer[0] == buffer[2] &&
 	    buffer[0] == buffer[3] && buffer[0] == buffer[4]) {
 		tuner_warn("All bytes are equal. It is not a TEA5767\n");
@@ -318,6 +317,11 @@
 		tuner_warn("Chip ID is not zero. It is not a TEA5767\n");
 		return EINVAL;
 	}
+	/* It seems that tea5767 returns 0xff after the 5th byte */
+	if ((buffer[5] != 0xff) || (buffer[6] != 0xff)) {
+		tuner_warn("Returned more than 5 bytes. It is not a TEA5767\n");
+		return EINVAL;
+	}
 
 	tuner_warn("TEA5767 detected.\n");
 	return 0;
@@ -327,9 +331,6 @@
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
-	if (tea5767_autodetection(c) == EINVAL)
-		return EINVAL;
-
 	tuner_info("type set to %d (%s)\n", t->type, "Philips TEA5767HN FM Radio");
 	strlcpy(c->name, "tea5767", sizeof(c->name));
 
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.13/drivers/media/video/saa7134/saa7134.h	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134.h	2005-07-28 19:00:00.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134.h,v 1.48 2005/07/01 08:22:24 nsh Exp $
+ * $Id: saa7134.h,v 1.49 2005/07/13 17:25:25 mchehab Exp $
  *
  * v4l2 device driver for philips saa7134 based TV cards
  *
@@ -21,7 +21,7 @@
  */
 
 #include <linux/utsname.h>
-#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,13)
+#define SAA7134_VERSION_CODE KERNEL_VERSION(0,2,14)
 
 #include <linux/pci.h>
 #include <linux/i2c.h>
diff -u linux-2.6.13/drivers/media/video/saa7134/saa7134-i2c.c linux/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.6.13/drivers/media/video/saa7134/saa7134-i2c.c	2005-07-13 11:07:25.000000000 -0300
+++ linux/drivers/media/video/saa7134/saa7134-i2c.c	2005-07-28 19:00:00.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: saa7134-i2c.c,v 1.19 2005/07/07 01:49:30 mkrufky Exp $
+ * $Id: saa7134-i2c.c,v 1.22 2005/07/22 04:09:41 mkrufky Exp $
  *
  * device driver for philips saa7134 based TV cards
  * i2c interface support
@@ -300,6 +300,8 @@
   	status = i2c_get_status(dev);
 	if (i2c_is_error(status))
 		goto err;
+	/* ensure that the bus is idle for at least one bit slot */
+	msleep(1);
 
 	d1printk("\n");
 	return num;
diff -u linux-2.6.13/drivers/media/video/tveeprom.c linux/drivers/media/video/tveeprom.c
--- linux-2.6.13/drivers/media/video/tveeprom.c	2005-07-28 18:45:58.000000000 -0300
+++ linux/drivers/media/video/tveeprom.c	2005-07-28 19:00:00.000000000 -0300
@@ -189,7 +189,7 @@
 	{ TUNER_ABSENT,        "Philips FQ1236 MK3"},
 	{ TUNER_ABSENT,        "Samsung TCPN 2121P30A"},
 	{ TUNER_ABSENT,        "Samsung TCPE 4121P30A"},
-	{ TUNER_ABSENT,        "TCL MFPE05 2"},
+	{ TUNER_PHILIPS_FM1216ME_MK3, "TCL MFPE05 2"},
 	/* 90-99 */
 	{ TUNER_ABSENT,        "LG TALN H202T"},
 	{ TUNER_PHILIPS_FQ1216AME_MK4, "Philips FQ1216AME MK4"},

--------------090103070704070409010607--
