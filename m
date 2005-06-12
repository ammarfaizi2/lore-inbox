Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVFLEpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVFLEpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFLEox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:44:53 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:17390 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261876AbVFLEks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:40:48 -0400
Message-ID: <42ABBCDB.3070006@brturbo.com.br>
Date: Sun, 12 Jun 2005 01:40:59 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH2/5] Synchronize patch for tuner cards and some V4L chips
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------080109010602080006040206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109010602080006040206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tuner improvements and additions. TEA5767 FM tuner added. Several small
fixes.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Nickolay V Shmyrev <nshmyrev@yandex.ru>

--------------080109010602080006040206
Content-Type: text/x-patch;
 name="patch02.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch02.patch"

diff -u linux-2.6.12/drivers/media/video/bt832.c linux/drivers/media/video/bt832.c
--- linux-2.6.12/drivers/media/video/bt832.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/bt832.c	2005-06-12 01:20:36.000000000 -0300
@@ -6,7 +6,7 @@
   It outputs an 8-bit 4:2:2 YUV or YCrCb video signal which can be directly
   connected to bt848/bt878 GPIO pins on this purpose.
   (see: VLSI Vision Ltd. www.vvl.co.uk for camera datasheets)
-  
+
   Supported Cards:
   -  Pixelview Rev.4E: 0x8a
 		GPIO 0x400000 toggles Bt832 RESET, and the chip changes to i2c 0x88 !
@@ -31,16 +31,16 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 
-#include "id.h"
-#include "audiochip.h"
+#include <media/audiochip.h>
+#include <media/id.h>
 #include "bttv.h"
 #include "bt832.h"
 
 MODULE_LICENSE("GPL");
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { I2C_BT832_ALT1>>1, I2C_BT832_ALT2>>1,
-				       I2C_CLIENT_END };
+static unsigned short normal_i2c[] = {I2C_CLIENT_END};
+static unsigned short normal_i2c_range[] = {I2C_BT832_ALT1>>1,I2C_BT832_ALT2>>1,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* ---------------------------------------------------------------------- */
@@ -95,7 +95,7 @@
 
 	buf=kmalloc(65,GFP_KERNEL);
 	bt832_hexdump(i2c_client_s,buf);
-	
+
 	if(buf[0x40] != 0x31) {
 		printk("bt832: this i2c chip is no bt832 (id=%02x). Detaching.\n",buf[0x40]);
 		kfree(buf);
@@ -135,7 +135,7 @@
 	buf[1]= 0x27 & (~0x01); // Default | !skip
 	if (2 != (rc = i2c_master_send(i2c_client_s,buf,2)))
                 printk("bt832: i2c i/o error EO: rc == %d (should be 2)\n",rc);
-	
+
         bt832_hexdump(i2c_client_s,buf);
 
 #if 0
@@ -168,8 +168,7 @@
 
 
 
-static int bt832_attach(struct i2c_adapter *adap, int addr,
-			  unsigned short flags, int kind)
+static int bt832_attach(struct i2c_adapter *adap, int addr, int kind)
 {
 	struct bt832 *t;
 
@@ -184,27 +183,32 @@
                 return -ENOMEM;
 	memset(t,0,sizeof(*t));
 	t->client = client_template;
-        t->client.data = t;
+        i2c_set_clientdata(&t->client, t);
         i2c_attach_client(&t->client);
 
 	if(! bt832_init(&t->client)) {
 		bt832_detach(&t->client);
 		return -1;
 	}
-        
+
 	return 0;
 }
 
 static int bt832_probe(struct i2c_adapter *adap)
 {
+#ifdef I2C_CLASS_TV_ANALOG
 	if (adap->class & I2C_CLASS_TV_ANALOG)
 		return i2c_probe(adap, &addr_data, bt832_attach);
+#else
+	if (adap->id == (I2C_ALGO_BIT | I2C_HW_B_BT848))
+		return i2c_probe(adap, &addr_data, bt832_attach);
+#endif
 	return 0;
 }
 
 static int bt832_detach(struct i2c_client *client)
 {
-	struct bt832 *t = (struct bt832*)client->data;
+	struct bt832 *t = i2c_get_clientdata(client);
 
 	printk("bt832: detach.\n");
 	i2c_detach_client(client);
@@ -215,7 +219,7 @@
 static int
 bt832_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
-	struct bt832 *t = (struct bt832*)client->data;
+	struct bt832 *t = i2c_get_clientdata(client);
 
 	printk("bt832: command %x\n",cmd);
 
@@ -249,19 +253,18 @@
 };
 static struct i2c_client client_template =
 {
-        .name   = "bt832",
-	.flags  = I2C_CLIENT_ALLOW_USE,
-        .driver = &driver,
+	I2C_DEVNAME("bt832"),
+	.flags      = I2C_CLIENT_ALLOW_USE,
+        .driver     = &driver,
 };
 
 
-int bt832_init_module(void)
+static int __init bt832_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void bt832_cleanup_module(void)
+static void __exit bt832_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
@@ -269,3 +272,10 @@
 module_init(bt832_init_module);
 module_exit(bt832_cleanup_module);
 
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
diff -u linux-2.6.12/drivers/media/video/bt832.h linux/drivers/media/video/bt832.h
--- linux-2.6.12/drivers/media/video/bt832.h	2005-05-25 00:31:20.000000000 -0300
+++ linux/drivers/media/video/bt832.h	2005-06-12 01:20:36.000000000 -0300
@@ -1,6 +1,6 @@
 /* Bt832 CMOS Camera Video Processor (VP)
 
- The Bt832 CMOS Camera Video Processor chip connects a Quartsight CMOS 
+ The Bt832 CMOS Camera Video Processor chip connects a Quartsight CMOS
   color digital camera directly to video capture devices via an 8-bit,
   4:2:2 YUV or YCrCb video interface.
 
@@ -85,7 +85,7 @@
 #define BT832_DEVICE_ID		63
 # define BT832_DEVICE_ID__31		0x31 // Bt832 has ID 0x31
 
-/* STMicroelectronivcs VV5404 camera module 
+/* STMicroelectronivcs VV5404 camera module
    i2c: 0x20: sensor address
    i2c: 0xa0: eeprom for ccd defect map
  */
@@ -256,26 +256,26 @@
 //===========================================================================
 // Timing generator SRAM table values for CCIR601 720x480 NTSC
 //===========================================================================
-// For NTSC CCIR656 
+// For NTSC CCIR656
 BYTE BtCard::SRAMTable_NTSC[] =
 {
     // SRAM Timing Table for NTSC
-    0x0c, 0xc0, 0x00, 
-    0x00, 0x90, 0xc2, 
-    0x03, 0x10, 0x03, 
-    0x06, 0x10, 0x34, 
-    0x12, 0x12, 0x65, 
-    0x02, 0x13, 0x24, 
-    0x19, 0x00, 0x24, 
-    0x39, 0x00, 0x96, 
-    0x59, 0x08, 0x93, 
+    0x0c, 0xc0, 0x00,
+    0x00, 0x90, 0xc2,
+    0x03, 0x10, 0x03,
+    0x06, 0x10, 0x34,
+    0x12, 0x12, 0x65,
+    0x02, 0x13, 0x24,
+    0x19, 0x00, 0x24,
+    0x39, 0x00, 0x96,
+    0x59, 0x08, 0x93,
     0x83, 0x08, 0x97,
-    0x03, 0x50, 0x30, 
-    0xc0, 0x40, 0x30, 
-    0x86, 0x01, 0x01, 
-    0xa6, 0x0d, 0x62, 
-    0x03, 0x11, 0x61, 
-    0x05, 0x37, 0x30, 
+    0x03, 0x50, 0x30,
+    0xc0, 0x40, 0x30,
+    0x86, 0x01, 0x01,
+    0xa6, 0x0d, 0x62,
+    0x03, 0x11, 0x61,
+    0x05, 0x37, 0x30,
     0xac, 0x21, 0x50
 };
 
diff -u linux-2.6.12/include/media/ir-common.h linux/include/media/ir-common.h
--- linux-2.6.12/include/media/ir-common.h	2005-06-07 15:40:18.000000000 -0300
+++ linux/include/media/ir-common.h	2005-06-12 01:20:36.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.h,v 1.8 2005/02/22 12:28:40 kraxel Exp $
+ * $Id: ir-common.h,v 1.9 2005/05/15 19:01:26 mchehab Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
diff -u linux-2.6.12/drivers/media/common/ir-common.c linux/drivers/media/common/ir-common.c
--- linux-2.6.12/drivers/media/common/ir-common.c	2005-06-07 15:39:52.000000000 -0300
+++ linux/drivers/media/common/ir-common.c	2005-06-12 01:20:36.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.c,v 1.8 2005/02/22 12:28:40 kraxel Exp $
+ * $Id: ir-common.c,v 1.10 2005/05/22 19:23:39 nsh Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -131,10 +131,10 @@
 	[ 18 ] = KEY_KP0,
 
 	[  0 ] = KEY_POWER,
-	[ 27 ] = KEY_LANGUAGE,  //MTS button
+//      [ 27 ] = MTS button
 	[  2 ] = KEY_TUNER,     // TV/FM
 	[ 30 ] = KEY_VIDEO,
-	[ 22 ] = KEY_INFO,      //display button
+//      [ 22 ] = display button
 	[  4 ] = KEY_VOLUMEUP,
 	[  8 ] = KEY_VOLUMEDOWN,
 	[ 12 ] = KEY_CHANNELUP,
@@ -142,7 +142,7 @@
 	[  3 ] = KEY_ZOOM,      // fullscreen
 	[ 31 ] = KEY_SUBTITLE,  // closed caption/teletext
 	[ 32 ] = KEY_SLEEP,
-	[ 41 ] = KEY_SEARCH,    //boss key
+//      [ 41 ] = boss key
 	[ 20 ] = KEY_MUTE,
 	[ 43 ] = KEY_RED,
 	[ 44 ] = KEY_GREEN,
@@ -150,17 +150,17 @@
 	[ 46 ] = KEY_BLUE,
 	[ 24 ] = KEY_KPPLUS,    //fine tune +
 	[ 25 ] = KEY_KPMINUS,   //fine tune -
-	[ 42 ] = KEY_ANGLE,     //picture in picture
-	[ 33 ] = KEY_KPDOT,
+//      [ 42 ] = picture in picture
+        [ 33 ] = KEY_KPDOT,
 	[ 19 ] = KEY_KPENTER,
-	[ 17 ] = KEY_AGAIN,     //recall
+//      [ 17 ] = recall
 	[ 34 ] = KEY_BACK,
 	[ 35 ] = KEY_PLAYPAUSE,
 	[ 36 ] = KEY_NEXT,
-	[ 37 ] = KEY_T,         //time shifting
+//      [ 37 ] = time shifting
 	[ 38 ] = KEY_STOP,
-	[ 39 ] = KEY_RECORD,
-	[ 40 ] = KEY_SHUFFLE    //snapshot
+	[ 39 ] = KEY_RECORD
+//      [ 40 ] = snapshot
 };
 EXPORT_SYMBOL_GPL(ir_codes_winfast);
 
@@ -184,18 +184,30 @@
 	[ 0x07 ] = KEY_KP7,             // 7
 	[ 0x08 ] = KEY_KP8,             // 8
 	[ 0x09 ] = KEY_KP9,             // 9
+	[ 0x0a ] = KEY_TEXT,      	// keypad asterisk as well
 	[ 0x0b ] = KEY_RED,             // red button
-	[ 0x0c ] = KEY_OPTION,          // black key without text
+	[ 0x0c ] = KEY_RADIO,           // radio
 	[ 0x0d ] = KEY_MENU,            // menu
+	[ 0x0e ] = KEY_SUBTITLE,	// also the # key
 	[ 0x0f ] = KEY_MUTE,            // mute
 	[ 0x10 ] = KEY_VOLUMEUP,        // volume +
 	[ 0x11 ] = KEY_VOLUMEDOWN,      // volume -
-	[ 0x1e ] = KEY_NEXT,            // skip >|
+	[ 0x12 ] = KEY_PREVIOUS,        // previous channel
+	[ 0x14 ] = KEY_UP,              // up
+	[ 0x15 ] = KEY_DOWN,		// down
+	[ 0x16 ] = KEY_LEFT,		// left
+	[ 0x17 ] = KEY_RIGHT,		// right
+	[ 0x18 ] = KEY_VIDEO,		// Videos
+	[ 0x19 ] = KEY_AUDIO,		// Music
+	[ 0x1a ] = KEY_MHP,		// Pictures - presume this means "Multimedia Home Platform"- no "PICTURES" key in input.h
+	[ 0x1b ] = KEY_EPG,		// Guide
+	[ 0x1c ] = KEY_TV,		// TV
+	[ 0x1e ] = KEY_NEXTSONG,        // skip >|
 	[ 0x1f ] = KEY_EXIT,            // back/exit
 	[ 0x20 ] = KEY_CHANNELUP,       // channel / program +
 	[ 0x21 ] = KEY_CHANNELDOWN,     // channel / program -
 	[ 0x22 ] = KEY_CHANNEL,         // source (old black remote)
-	[ 0x24 ] = KEY_PREVIOUS,        // replay |<
+	[ 0x24 ] = KEY_PREVIOUSSONG,    // replay |<
 	[ 0x25 ] = KEY_ENTER,           // OK
 	[ 0x26 ] = KEY_SLEEP,           // minimize (old black remote)
 	[ 0x29 ] = KEY_BLUE,            // blue key
@@ -412,3 +424,4 @@
  * c-basic-offset: 8
  * End:
  */
+
diff -u linux-2.6.12/include/media/audiochip.h linux/include/media/audiochip.h
--- linux-2.6.12/include/media/audiochip.h	2005-05-25 00:31:20.000000000 -0300
+++ linux/include/media/audiochip.h	2005-06-12 01:20:36.000000000 -0300
@@ -1,3 +1,7 @@
+/*
+ * $Id: audiochip.h,v 1.3 2005/06/12 04:19:19 mchehab Exp $
+ */
+
 #ifndef AUDIOCHIP_H
 #define AUDIOCHIP_H
 
diff -u linux-2.6.12/include/media/id.h linux/include/media/id.h
--- linux-2.6.12/include/media/id.h	2005-05-25 00:31:20.000000000 -0300
+++ linux/include/media/id.h	2005-06-12 01:20:36.000000000 -0300
@@ -1,3 +1,7 @@
+/*
+ * $Id: id.h,v 1.4 2005/06/12 04:19:19 mchehab Exp $
+ */
+
 /* FIXME: this temporarely, until these are included in linux/i2c-id.h */
 
 /* drivers */
diff -u linux-2.6.12/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.12/drivers/media/video/msp3400.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/msp3400.c	2005-06-12 01:20:36.000000000 -0300
@@ -147,6 +147,7 @@
 	I2C_MSP3400C_ALT  >> 1,
 	I2C_CLIENT_END
 };
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* ----------------------------------------------------------------------- */
@@ -735,7 +736,6 @@
 {
 	DECLARE_WAITQUEUE(wait, current);
 
-again:
 	add_wait_queue(&msp->wq, &wait);
 	if (!kthread_should_stop()) {
 		if (timeout < 0) {
@@ -751,12 +751,9 @@
 #endif
 		}
 	}
-
+	if (current->flags & PF_FREEZE)
+		refrigerator(PF_FREEZE);
 	remove_wait_queue(&msp->wq, &wait);
-
-	if (try_to_freeze(PF_FREEZE))
-		goto again;
-
 	return msp->restart;
 }
 
@@ -1436,7 +1433,7 @@
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
+static int msp_suspend(struct device * dev, u32 state, u32 level);
 static int msp_resume(struct device * dev, u32 level);
 
 static void msp_wake_thread(struct i2c_client *client);
@@ -1841,7 +1838,7 @@
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
+static int msp_suspend(struct device * dev, u32 state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
diff -u linux-2.6.12/drivers/media/video/msp3400.h linux/drivers/media/video/msp3400.h
--- linux-2.6.12/drivers/media/video/msp3400.h	2005-05-25 00:31:20.000000000 -0300
+++ linux/drivers/media/video/msp3400.h	2005-06-12 01:20:36.000000000 -0300
@@ -1,3 +1,7 @@
+/*
+ * $Id: msp3400.h,v 1.3 2005/06/12 04:19:19 mchehab Exp $
+ */
+
 #ifndef MSP3400_H
 #define MSP3400_H
 
diff -u linux-2.6.12/drivers/media/video/tda7432.c linux/drivers/media/video/tda7432.c
--- linux-2.6.12/drivers/media/video/tda7432.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tda7432.c	2005-06-12 01:20:36.000000000 -0300
@@ -74,6 +74,7 @@
 	I2C_TDA7432 >> 1,
 	I2C_CLIENT_END,
 };
+static unsigned short normal_i2c_range[] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 /* Structure of address and subaddresses for the tda7432 */
diff -u linux-2.6.12/drivers/media/video/tda9875.c linux/drivers/media/video/tda9875.c
--- linux-2.6.12/drivers/media/video/tda9875.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tda9875.c	2005-06-12 01:20:36.000000000 -0300
@@ -44,6 +44,7 @@
     I2C_TDA9875 >> 1,
     I2C_CLIENT_END
 };
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* This is a superset of the TDA9875 */
diff -u linux-2.6.12/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.12/drivers/media/video/tvaudio.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tvaudio.c	2005-06-12 01:20:37.000000000 -0300
@@ -148,6 +148,7 @@
 	I2C_TDA9874   >> 1,
 	I2C_PIC16C54  >> 1,
 	I2C_CLIENT_END };
+static unsigned short normal_i2c_range[2] = { I2C_CLIENT_END, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
 static struct i2c_driver driver;
@@ -285,7 +286,6 @@
 			schedule();
 		}
 		remove_wait_queue(&chip->wq, &wait);
-		try_to_freeze(PF_FREEZE);
 		if (chip->done || signal_pending(current))
 			break;
 		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
diff -u linux-2.6.12/drivers/media/video/tvmixer.c linux/drivers/media/video/tvmixer.c
--- linux-2.6.12/drivers/media/video/tvmixer.c	2005-05-25 00:31:20.000000000 -0300
+++ linux/drivers/media/video/tvmixer.c	2005-06-12 01:20:37.000000000 -0300
@@ -1,3 +1,7 @@
+/*
+ * $Id: tvmixer.c,v 1.8 2005/06/12 04:19:19 mchehab Exp $
+ */
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
diff -u linux-2.6.12/include/media/tuner.h linux/include/media/tuner.h
--- linux-2.6.12/include/media/tuner.h	2005-06-07 15:40:18.000000000 -0300
+++ linux/include/media/tuner.h	2005-06-12 01:20:37.000000000 -0300
@@ -25,6 +25,8 @@
 
 #include "id.h"
 
+#define ADDR_UNSET (255)
+
 #define TUNER_TEMIC_PAL     0        /* 4002 FH5 (3X 7756, 9483) */
 #define TUNER_PHILIPS_PAL_I 1
 #define TUNER_PHILIPS_NTSC  2
@@ -100,6 +102,11 @@
 
 #define TUNER_YMEC_TVF_8531MF 58
 #define TUNER_YMEC_TVF_5533MF 59	/* Pixelview Pro Ultra NTSC */
+#define TUNER_THOMSON_DTT7611 60
+#define TUNER_TENA_9533_DI    61
+#define TUNER_TEA5767         62	/* Only FM Radio Tuner */
+
+#define TEA5767_TUNER_NAME "Philips TEA5767HN FM Radio"
 
 #define NOTUNER 0
 #define PAL     1	/* PAL_BG */
@@ -107,6 +114,7 @@
 #define NTSC    3
 #define SECAM   4
 #define ATSC    5
+#define RADIO	6
 
 #define NoTuner 0
 #define Philips 1
@@ -122,9 +130,17 @@
 #define TCL     11
 #define THOMSON 12
 
+enum v4l_radio_tuner {
+        TEA5767_LOW_LO_32768    = 0,
+        TEA5767_HIGH_LO_32768   = 1,
+        TEA5767_LOW_LO_13MHz    = 2,
+        TEA5767_HIGH_LO_13MHz   = 3,
+};
+
+
 #define TUNER_SET_TYPE               _IOW('t',1,int)    /* set tuner type */
 #define TUNER_SET_TVFREQ             _IOW('t',2,int)    /* set tv freq */
-#define TUNER_SET_ADDR               _IOW('T',3,int)	/* Chooses tuner I2C address */
+#define TUNER_SET_TYPE_ADDR          _IOW('T',3,int)	/* set tuner type and I2C addr */
 
 #define  TDA9887_SET_CONFIG          _IOW('t',5,int)
 
@@ -149,8 +165,9 @@
 #define I2C_ADDR_TDA8275        0x61
 
 struct tuner_addr {
-	enum v4l2_tuner_type type;
-	unsigned short addr;
+	enum v4l2_tuner_type	v4l2_tuner;
+	unsigned int		type;
+	unsigned short		addr;
 };
 
 struct tuner {
@@ -187,6 +204,7 @@
 
 extern int microtune_init(struct i2c_client *c);
 extern int tda8290_init(struct i2c_client *c);
+extern int tea5767_tuner_init(struct i2c_client *c);
 extern int default_tuner_init(struct i2c_client *c);
 
 #define tuner_warn(fmt, arg...) \
diff -u linux-2.6.12/drivers/media/video/tuner-core.c linux/drivers/media/video/tuner-core.c
--- linux-2.6.12/drivers/media/video/tuner-core.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tuner-core.c	2005-06-12 01:20:37.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-core.c,v 1.7 2005/05/30 02:02:47 mchehab Exp $
+ * $Id: tuner-core.c,v 1.15 2005/06/12 01:36:14 mchehab Exp $
  *
  * i2c tv tuner chip device driver
  * core core, i.e. kernel interfaces, registering and so on
@@ -26,15 +26,17 @@
 /*
  * comment line bellow to return to old behavor, where only one I2C device is supported
  */
-/* #define CONFIG_TUNER_MULTI_I2C */
+#define CONFIG_TUNER_MULTI_I2C /**/
 
 #define UNSET (-1U)
 
 /* standard i2c insmod options */
 static unsigned short normal_i2c[] = {
 	0x4b, /* tda8290 */
-	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
-	0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
+	I2C_CLIENT_END
+};
+static unsigned short normal_i2c_range[] = {
+	0x60, 0x6f,
 	I2C_CLIENT_END
 };
 I2C_CLIENT_INSMOD;
@@ -59,7 +61,7 @@
 
 static int this_adap;
 #ifdef CONFIG_TUNER_MULTI_I2C
-static unsigned short tv_tuner, radio_tuner;
+static unsigned short first_tuner, tv_tuner, radio_tuner;
 #endif
 
 static struct i2c_driver driver;
@@ -67,7 +69,7 @@
 
 /* ---------------------------------------------------------------------- */
 
-// Set tuner frequency,  freq in Units of 62.5kHz = 1/16MHz
+/* Set tuner frequency,  freq in Units of 62.5kHz = 1/16MHz */
 static void set_tv_freq(struct i2c_client *c, unsigned int freq)
 {
 	struct tuner *t = i2c_get_clientdata(c);
@@ -81,14 +83,26 @@
 		return;
 	}
 	if (freq < tv_range[0]*16 || freq > tv_range[1]*16) {
-		/* FIXME: better do that chip-specific, but
-		   right now we don't have that in the config
-		   struct and this way is still better than no
-		   check at all */
-		tuner_info("TV freq (%d.%02d) out of range (%d-%d)\n",
-			   freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
-		return;
+
+		if (freq >= tv_range[0]*16364 && freq <= tv_range[1]*16384) {
+			/* V4L2_TUNER_CAP_LOW frequency */
+
+			tuner_dbg("V4L2_TUNER_CAP_LOW freq selected for TV. Tuners yet doesn't support converting it to valid freq.\n");
+
+			t->tv_freq(c,freq>>10);
+
+			return;
+                } else {
+			/* FIXME: better do that chip-specific, but
+			   right now we don't have that in the config
+			   struct and this way is still better than no
+			   check at all */
+			tuner_info("TV freq (%d.%02d) out of range (%d-%d)\n",
+				   freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
+			return;
+		}
 	}
+	tuner_dbg("62.5 Khz freq step selected for TV.\n");
 	t->tv_freq(c,freq);
 }
 
@@ -105,11 +119,29 @@
 		return;
 	}
 	if (freq < radio_range[0]*16 || freq > radio_range[1]*16) {
-		tuner_info("radio freq (%d.%02d) out of range (%d-%d)\n",
+		if (freq >= tv_range[0]*16364 && freq <= tv_range[1]*16384) {
+			/* V4L2_TUNER_CAP_LOW frequency */
+			if (t->type == TUNER_TEA5767) {
+				tuner_info("radio freq step 62.5Hz (%d.%06d)\n",(freq>>14),freq%(1<<14)*10000);
+				t->radio_freq(c,freq>>10);
+				return;
+			}
+
+			tuner_dbg("V4L2_TUNER_CAP_LOW freq selected for Radio. Tuners yet doesn't support converting it to valid freq.\n");
+
+			tuner_info("radio freq (%d.%06d)\n",(freq>>14),freq%(1<<14)*10000);
+
+			t->radio_freq(c,freq>>10);
+			return;
+
+                } else {
+			tuner_info("radio freq (%d.%02d) out of range (%d-%d)\n",
 			   freq/16,freq%16*100/16,
-			   radio_range[0],radio_range[1]);
-		return;
+				   radio_range[0],radio_range[1]);
+			return;
+		}
 	}
+	tuner_dbg("62.5 Khz freq step selected for Radio.\n");
 	t->radio_freq(c,freq);
 }
 
@@ -133,34 +165,13 @@
 	t->freq = freq;
 }
 
-#ifdef CONFIG_TUNER_MULTI_I2C
-static void set_addr(struct i2c_client *c, struct tuner_addr *tun_addr)
-{
-	struct tuner *t = i2c_get_clientdata(c);
-
-	switch (tun_addr->type) {
-	case V4L2_TUNER_RADIO:
- 		radio_tuner=tun_addr->addr;
-		tuner_dbg("radio tuner set to I2C address 0x%02x\n",radio_tuner<<1);
-
-		break;
-	default:
-		tv_tuner=tun_addr->addr;
-		tuner_dbg("TV tuner set to I2C address 0x%02x\n",tv_tuner<<1);
-		break;
-	}
-}
-#else
-#define set_addr(c,tun_addr) \
-		tuner_warn("It is recommended to enable CONFIG_TUNER_MULTI_I2C for this card.\n");
-#endif
-
 static void set_type(struct i2c_client *c, unsigned int type)
 {
 	struct tuner *t = i2c_get_clientdata(c);
 
+	tuner_dbg ("I2C addr 0x%02x with type %d\n",c->addr<<1,type);
 	/* sanity check */
-	if (type == UNSET  ||  type == TUNER_ABSENT)
+	if (type == UNSET || type == TUNER_ABSENT)
 		return;
 	if (type >= tuner_count)
 		return;
@@ -175,6 +186,7 @@
 		return;
 
 	t->initialized = 1;
+
 	t->type = type;
 	switch (t->type) {
 	case TUNER_MT2032:
@@ -183,12 +195,62 @@
 	case TUNER_PHILIPS_TDA8290:
 		tda8290_init(c);
 		break;
+	case TUNER_TEA5767:
+		tea5767_tuner_init(c);
+		break;
 	default:
 		default_tuner_init(c);
 		break;
 	}
 }
 
+#ifdef CONFIG_TUNER_MULTI_I2C
+#define CHECK_ADDR(tp,cmd,tun)	if (client->addr!=tp) { \
+			  return 0; } else \
+			  tuner_info ("Cmd %s accepted to "tun"\n",cmd);
+#define CHECK_MODE(cmd)	if (t->mode == V4L2_TUNER_RADIO) { \
+		 	CHECK_ADDR(radio_tuner,cmd,"radio") } else \
+			{ CHECK_ADDR(tv_tuner,cmd,"TV"); }
+#else
+#define CHECK_ADDR(tp,cmd,tun) tuner_info ("Cmd %s accepted to "tun"\n",cmd);
+#define CHECK_MODE(cmd) tuner_info ("Cmd %s accepted\n",cmd);
+#endif
+
+#ifdef CONFIG_TUNER_MULTI_I2C
+
+static void set_addr(struct i2c_client *c, struct tuner_addr *tun_addr)
+{
+	/* ADDR_UNSET defaults to first available tuner */
+	if ( tun_addr->addr == ADDR_UNSET ) {
+		if (first_tuner != c->addr)
+			return;
+		switch (tun_addr->v4l2_tuner) {
+		case V4L2_TUNER_RADIO:
+	 		radio_tuner=c->addr;
+			break;
+		default:
+			tv_tuner=c->addr;
+			break;
+		}
+	} else {
+		/* Sets tuner to its configured value */
+		switch (tun_addr->v4l2_tuner) {
+		case V4L2_TUNER_RADIO:
+ 			radio_tuner=tun_addr->addr;
+			if ( tun_addr->addr == c->addr ) set_type(c,tun_addr->type);
+			return;
+		default:
+			tv_tuner=tun_addr->addr;
+			if ( tun_addr->addr == c->addr ) set_type(c,tun_addr->type);
+			return;
+		}
+	}
+	set_type(c,tun_addr->type);
+}
+#else
+#define set_addr(c,tun_addr) set_type(c,(tun_addr)->type)
+#endif
+
 static char pal[] = "-";
 module_param_string(pal, pal, sizeof(pal), 0644);
 
@@ -233,6 +295,7 @@
 #else
 	/* by default, first I2C card is both tv and radio tuner */
 	if (this_adap == 0) {
+		first_tuner = addr;
 		tv_tuner = addr;
 		radio_tuner = addr;
 	}
@@ -249,11 +312,12 @@
         memcpy(&t->i2c,&client_template,sizeof(struct i2c_client));
 	i2c_set_clientdata(&t->i2c, t);
 	t->type       = UNSET;
-	t->radio_if2  = 10700*1000; // 10.7MHz - FM radio
+	t->radio_if2  = 10700*1000; /* 10.7MHz - FM radio */
 
         i2c_attach_client(&t->i2c);
 	tuner_info("chip found @ 0x%x (%s)\n",
 		   addr << 1, adap->name);
+	
 	set_type(&t->i2c, t->type);
 	return 0;
 }
@@ -261,12 +325,14 @@
 static int tuner_probe(struct i2c_adapter *adap)
 {
 	if (0 != addr) {
-		normal_i2c[0] = addr;
-		normal_i2c[1] = I2C_CLIENT_END;
+		normal_i2c[0]       = addr;
+		normal_i2c_range[0] = addr;
+		normal_i2c_range[1] = addr;
 	}
 	this_adap = 0;
 
 #ifdef CONFIG_TUNER_MULTI_I2C
+	first_tuner = 0;
 	tv_tuner = 0;
 	radio_tuner = 0;
 #endif
@@ -286,7 +352,7 @@
 		tuner_warn ("Client deregistration failed, client not detached.\n");
 		return err;
 	}
-
+	
 	kfree(t);
 	return 0;
 }
@@ -297,18 +363,7 @@
 #define CHECK_V4L2	if (t->using_v4l2) { if (tuner_debug) \
 			  tuner_info("ignore v4l1 call\n"); \
 		          return 0; }
-
-#ifdef CONFIG_TUNER_MULTI_I2C
-#define CHECK_ADDR(tp,cmd)	if (client->addr!=tp) { \
-			  tuner_info ("Cmd %s to addr 0x%02x rejected.\n",cmd,client->addr<<1); \
-			  return 0; }
-#define CHECK_MODE(cmd)	if (t->mode == V4L2_TUNER_RADIO) { \
-			  CHECK_ADDR(radio_tuner,cmd) } else { CHECK_ADDR(tv_tuner,cmd); }
-#else
-#define CHECK_ADDR(tp,cmd)
-#define CHECK_MODE(cmd)
-#endif
-
+			  
 static int
 tuner_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
@@ -320,19 +375,19 @@
 	case TUNER_SET_TYPE:
 		set_type(client,*iarg);
 		break;
-	case TUNER_SET_ADDR:
+	case TUNER_SET_TYPE_ADDR:
 		set_addr(client,(struct tuner_addr *)arg);
 		break;
 	case AUDC_SET_RADIO:
-		CHECK_ADDR(radio_tuner,"AUDC_SET_RADIO");
-
+		t->mode = V4L2_TUNER_RADIO;
+		CHECK_ADDR(tv_tuner,"AUDC_SET_RADIO","TV");
+		
 		if (V4L2_TUNER_RADIO != t->mode) {
 			set_tv_freq(client,400 * 16);
-			t->mode = V4L2_TUNER_RADIO;
 		}
 		break;
 	case AUDC_CONFIG_PINNACLE:
-		CHECK_ADDR(tv_tuner,"AUDC_CONFIG_PINNACLE");
+		CHECK_ADDR(tv_tuner,"AUDC_CONFIG_PINNACLE","TV");
 		switch (*iarg) {
 		case 2:
 			tuner_dbg("pinnacle pal\n");
@@ -360,9 +415,10 @@
 		};
 		struct video_channel *vc = arg;
 
-		CHECK_ADDR(tv_tuner,"VIDIOCSCHAN");
 		CHECK_V4L2;
 		t->mode = V4L2_TUNER_ANALOG_TV;
+		CHECK_ADDR(tv_tuner,"VIDIOCSCHAN","TV");
+
 		if (vc->norm < ARRAY_SIZE(map))
 			t->std = map[vc->norm];
 		tuner_fixup_std(t);
@@ -383,17 +439,27 @@
 	{
 		struct video_tuner *vt = arg;
 
-		CHECK_ADDR(radio_tuner,"VIDIOCGTUNER:");
+		CHECK_ADDR(radio_tuner,"VIDIOCGTUNER","radio");
 		CHECK_V4L2;
-		if (V4L2_TUNER_RADIO == t->mode  &&  t->has_signal)
-			vt->signal = t->has_signal(client);
+		if (V4L2_TUNER_RADIO == t->mode) {
+			if (t->has_signal)
+				vt->signal = t->has_signal(client);
+			if (t->is_stereo) {
+				if (t->is_stereo(client))
+					vt-> flags |= VIDEO_TUNER_STEREO_ON;
+				else
+					vt-> flags &= 0xffff ^ VIDEO_TUNER_STEREO_ON;
+			}
+			vt->flags |= V4L2_TUNER_CAP_LOW; /* Allow freqs at 62.5 Hz */
+		}
+			
 		return 0;
 	}
 	case VIDIOCGAUDIO:
 	{
 		struct video_audio *va = arg;
 
-		CHECK_ADDR(radio_tuner,"VIDIOCGAUDIO");
+		CHECK_ADDR(radio_tuner,"VIDIOCGAUDIO","radio");
 		CHECK_V4L2;
 		if (V4L2_TUNER_RADIO == t->mode  &&  t->is_stereo)
 			va->mode = t->is_stereo(client)
@@ -406,9 +472,10 @@
 	{
 		v4l2_std_id *id = arg;
 
-		CHECK_ADDR(tv_tuner,"VIDIOC_S_STD");
 		SWITCH_V4L2;
 		t->mode = V4L2_TUNER_ANALOG_TV;
+		CHECK_ADDR(tv_tuner,"VIDIOC_S_STD","TV");
+
 		t->std = *id;
 		tuner_fixup_std(t);
 		if (t->freq)
@@ -444,13 +511,27 @@
 
 		CHECK_MODE("VIDIOC_G_TUNER");
 		SWITCH_V4L2;
-		if (V4L2_TUNER_RADIO == t->mode  &&  t->has_signal)
-			tuner->signal = t->has_signal(client);
+		if (V4L2_TUNER_RADIO == t->mode) {
+			if (t->has_signal)
+				tuner -> signal = t->has_signal(client);
+			if (t->is_stereo) {
+				if (t->is_stereo(client)) {
+					tuner -> capability |= V4L2_TUNER_CAP_STEREO;
+					tuner -> rxsubchans |= V4L2_TUNER_SUB_STEREO;
+				} else {
+					tuner -> rxsubchans &= 0xffff ^ V4L2_TUNER_SUB_STEREO;
+				}
+			}
+		}
+		/* Wow to deal with V4L2_TUNER_CAP_LOW ? For now, it accepts from low at 62.5KHz step  to high at 62.5 Hz */
 		tuner->rangelow = tv_range[0] * 16;
-		tuner->rangehigh = tv_range[1] * 16;
+//		tuner->rangehigh = tv_range[1] * 16;
+//		tuner->rangelow = tv_range[0] * 16384;
+		tuner->rangehigh = tv_range[1] * 16384;
 		break;
 	}
 	default:
+		tuner_dbg ("Unimplemented IOCTL 0x%08x called to tuner.\n", cmd);
 		/* nothing */
 		break;
 	}
@@ -458,7 +539,7 @@
 	return 0;
 }
 
-static int tuner_suspend(struct device * dev, pm_message_t state, u32 level)
+static int tuner_suspend(struct device * dev, u32 state, u32 level)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 	struct tuner *t = i2c_get_clientdata(c);
diff -u linux-2.6.12/drivers/media/video/tuner-simple.c linux/drivers/media/video/tuner-simple.c
--- linux-2.6.12/drivers/media/video/tuner-simple.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tuner-simple.c	2005-06-12 01:20:37.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: tuner-simple.c,v 1.14 2005/05/30 02:02:47 mchehab Exp $
+ * $Id: tuner-simple.c,v 1.21 2005/06/10 19:53:26 nsh Exp $
  *
  * i2c tv tuner chip device driver
  * controls all those simple 4-control-bytes style tuners.
@@ -217,7 +217,16 @@
 	  16*160.00,16*454.00,0xa0,0x90,0x30,0x8e,732},
 	{ "Ymec TVision TVF-5533MF", Philips, NTSC,
 	  16*160.00,16*454.00,0x01,0x02,0x04,0x8e,732},
+	{ "Thomson DDT 7611 (ATSC/NTSC)", THOMSON, ATSC,
+	  16*157.25,16*454.00,0x39,0x3a,0x3c,0x8e,732},
+	{ "Tena TNF9533-D/IF", LGINNOTEK, PAL,
+          16*160.25, 16*464.25, 0x01,0x02,0x08,0x8e,623},	
+
+	/* This entry is for TEA5767 FM radio only chip used on several boards w/TV tuner */
+	{ TEA5767_TUNER_NAME, Philips, RADIO,
+          -1, -1, 0, 0, 0, TEA5767_LOW_LO_32768,0},	
 };
+
 unsigned const int tuner_count = ARRAY_SIZE(tuners);
 
 /* ---------------------------------------------------------------------- */
@@ -228,6 +237,7 @@
 
 	if (1 != i2c_master_recv(c,&byte,1))
 		return 0;
+
 	return byte;
 }
 
@@ -236,17 +246,33 @@
 #define TUNER_MODE      0x38
 #define TUNER_AFC       0x07
 
-#define TUNER_STEREO    0x10 /* radio mode */
-#define TUNER_SIGNAL    0x07 /* radio mode */
+#define TUNER_STEREO       0x10 /* radio mode */
+#define TUNER_STEREO_MK3   0x04 /* radio mode */
+#define TUNER_SIGNAL       0x07 /* radio mode */
 
 static int tuner_signal(struct i2c_client *c)
 {
-	return (tuner_getstatus(c) & TUNER_SIGNAL)<<13;
+	return (tuner_getstatus(c) & TUNER_SIGNAL) << 13;
 }
 
 static int tuner_stereo(struct i2c_client *c)
 {
-	return (tuner_getstatus (c) & TUNER_STEREO);
+	int stereo, status;
+	struct tuner *t = i2c_get_clientdata(c);
+	
+	status = tuner_getstatus (c);
+	
+	switch (t->type) {
+        	case TUNER_PHILIPS_FM1216ME_MK3:
+    		case TUNER_PHILIPS_FM1236_MK3:
+		case TUNER_PHILIPS_FM1256_IH3:
+			stereo = ((status & TUNER_SIGNAL) == TUNER_STEREO_MK3);
+			break;
+		default:
+			stereo = status & TUNER_STEREO;
+	}
+	
+	return stereo;
 }
 
 #if 0 /* unused */
@@ -429,8 +455,9 @@
 	buffer[2] = tun->config;
 
 	switch (t->type) {
+	case TUNER_TENA_9533_DI:
 	case TUNER_YMEC_TVF_5533MF:
-
+		
 		/*These values are empirically determinated */
 		div = (freq*122)/16 - 20;
 		buffer[2] = 0x88; /* could be also 0x80 */
@@ -469,21 +496,7 @@
 	tuner_info("type set to %d (%s)\n",
 		   t->type, tuners[t->type].name);
 	strlcpy(c->name, tuners[t->type].name, sizeof(c->name));
-
-	switch (t->type) {
-	case TUNER_YMEC_TVF_5533MF:
-		{
-			struct tuner_addr tun_addr = { V4L2_TUNER_ANALOG_TV, 0xc2>>1 };
-
-			if (c->driver->command) {
-				c->driver->command(c, TUNER_SET_ADDR, &tun_addr);
-			} else {
-				tuner_warn("Couldn't set TV tuner I2C address to 0x%02x\n",tun_addr.addr<<1);
-			}
-			break;
-		}
-	}
-
+	
 	t->tv_freq    = default_set_tv_freq;
 	t->radio_freq = default_set_radio_freq;
 	t->has_signal = tuner_signal;
diff -u linux-2.6.12/drivers/media/video/tda8290.c linux/drivers/media/video/tda8290.c
--- linux-2.6.12/drivers/media/video/tda8290.c	2005-06-07 15:38:10.000000000 -0300
+++ linux/drivers/media/video/tda8290.c	2005-06-12 01:20:37.000000000 -0300
@@ -194,12 +194,12 @@
 {
 	unsigned char i2c_get_afc[1] = { 0x1B };
 	unsigned char afc = 0;
-
+	
 	i2c_master_send(c, i2c_get_afc, ARRAY_SIZE(i2c_get_afc));
 	i2c_master_recv(c, &afc, 1);
 	return (afc & 0x80)? 65535:0;
 }
-
+	
 int tda8290_init(struct i2c_client *c)
 {
 	struct tuner *t = i2c_get_clientdata(c);
diff -u linux-2.6.12/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
--- linux-2.6.12/drivers/media/video/tda9887.c	2005-06-07 15:39:55.000000000 -0300
+++ linux/drivers/media/video/tda9887.c	2005-06-12 01:20:37.000000000 -0300
@@ -33,6 +33,7 @@
 	0x96 >>1,
 	I2C_CLIENT_END,
 };
+static unsigned short normal_i2c_range[] = {I2C_CLIENT_END,I2C_CLIENT_END};
 I2C_CLIENT_INSMOD;
 
 /* insmod options */
@@ -53,6 +54,7 @@
 	unsigned int       config;
 	unsigned int       pinnacle_id;
 	unsigned int       using_v4l2;
+	unsigned int 	   radio_mode;
 };
 
 struct tvnorm {
@@ -212,12 +214,22 @@
 	}
 };
 
-static struct tvnorm radio = {
-	.name = "radio",
+static struct tvnorm radio_stereo = {
+	.name = "Radio Stereo",
+	.b    = ( cFmRadio       |
+		  cQSS           ),
+	.c    = ( cDeemphasisOFF |
+		  cAudioGain6 ),
+	.e    = ( cAudioIF_5_5   |
+		  cRadioIF_38_90 ),
+};
+
+static struct tvnorm radio_mono = {
+	.name = "Radio Mono",
 	.b    = ( cFmRadio       |
 		  cQSS           ),
 	.c    = ( cDeemphasisON  |
-		  cDeemphasis50  ),
+		  cDeemphasis50),
 	.e    = ( cAudioIF_5_5   |
 		  cRadioIF_38_90 ),
 };
@@ -354,7 +366,10 @@
 	int i;
 
 	if (t->radio) {
-		norm = &radio;
+		if (t->radio_mode == V4L2_TUNER_MODE_MONO)
+			norm = &radio_mono;
+		else
+		        norm = &radio_stereo;
 	} else {
 		for (i = 0; i < ARRAY_SIZE(tvnorms); i++) {
 			if (tvnorms[i].std & t->std) {
@@ -545,11 +560,14 @@
 
 	memset(buf,0,sizeof(buf));
 	tda9887_set_tvnorm(t,buf);
+
 	buf[1] |= cOutputPort1Inactive;
 	buf[1] |= cOutputPort2Inactive;
+
 	if (UNSET != t->pinnacle_id) {
 		tda9887_set_pinnacle(t,buf);
 	}
+
 	tda9887_set_config(t,buf);
 	tda9887_set_insmod(t,buf);
 
@@ -592,9 +610,12 @@
         if (NULL == (t = kmalloc(sizeof(*t), GFP_KERNEL)))
                 return -ENOMEM;
 	memset(t,0,sizeof(*t));
+
 	t->client      = client_template;
 	t->std         = 0;
 	t->pinnacle_id = UNSET;
+	t->radio_mode = V4L2_TUNER_MODE_STEREO;
+	
         i2c_set_clientdata(&t->client, t);
         i2c_attach_client(&t->client);
 
@@ -733,6 +754,16 @@
 		}
 		break;
 	}
+	case VIDIOC_S_TUNER:
+	{
+		struct v4l2_tuner* tuner = arg;
+
+		if (t->radio) {
+			t->radio_mode = tuner->audmode;
+			tda9887_configure (t);
+		}
+		break;
+	}
 	default:
 		/* nothing */
 		break;
@@ -740,7 +771,7 @@
 	return 0;
 }
 
-static int tda9887_suspend(struct device * dev, pm_message_t state, u32 level)
+static int tda9887_suspend(struct device * dev, u32 state, u32 level)
 {
 	dprintk("tda9887: suspend\n");
 	return 0;

--------------080109010602080006040206--
