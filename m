Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUBEOl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUBEOl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:41:28 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:389 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265191AbUBEOkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:40:55 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 5 Feb 2004 15:22:16 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: saa7134 cleanups and new cards.
Message-ID: <20040205142216.GA23887@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch is a update for the saa7134 driver in the linux kernel.
Changes:

  * kernel thread cleanups (exit/rmmod sync using completions, wait
    queue fixes).
  * add support for more cards.
  * improved infrared remote support.

Please apply,

  Gerd

diff -u linux-2.6.2/drivers/media/video/saa7134/saa7134-cards.c linux/drivers/media/video/saa7134/saa7134-cards.c
--- linux-2.6.2/drivers/media/video/saa7134/saa7134-cards.c	2004-02-05 13:32:30.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-cards.c	2004-02-05 13:44:39.033178456 +0100
@@ -834,7 +834,7 @@
 		}},
 	},
         [SAA7134_BOARD_ECS_TVP3XP] = {
-                .name           = "Elitegroup ECS TVP3XP FM1216 Tuner Card",
+                .name           = "Elitegroup ECS TVP3XP FM1216 Tuner Card(PAL-BG,FM) ",
                 .audio_clock    = 0x187de7,  // xtal 32.1 MHz
                 .tuner_type     = TUNER_PHILIPS_PAL,
                 .inputs         = {{
@@ -865,6 +865,82 @@
                         .amux   = LINE2,
                 },
         },
+        [SAA7134_BOARD_ECS_TVP3XP_4CB5] = {
+                .name           = "Elitegroup ECS TVP3XP FM1236 Tuner Card (NTSC,FM)",
+                .audio_clock    = 0x187de7,
+                .tuner_type     = TUNER_PHILIPS_NTSC,
+                .inputs         = {{
+                        .name   = name_tv,
+                        .vmux   = 1,
+                        .amux   = TV,
+                        .tv     = 1,
+                },{
+                        .name   = name_tv_mono,
+                        .vmux   = 1,
+                        .amux   = LINE2,
+                        .tv     = 1,
+                },{
+                        .name   = name_comp1,
+                        .vmux   = 3,
+                        .amux   = LINE1,
+                },{
+                        .name   = name_svideo,
+                        .vmux   = 8,
+                        .amux   = LINE1,
+                },{
+                        .name   = "CVid over SVid",
+                        .vmux   = 0,
+                        .amux   = LINE1,
+                }},
+                .radio = {
+                        .name   = name_radio,
+                        .amux   = LINE2,
+                },
+        },
+	[SAA7134_BOARD_AVACSSMARTTV] = {
+		/* Roman Pszonczenko <romka@kolos.math.uni.lodz.pl> */
+		.name           = "AVACS SmartTV",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_PHILIPS_PAL,
+		.inputs         = {{
+			.name = name_tv,
+			.vmux = 1,
+			.amux = TV,
+			.tv   = 1,
+                },{
+			.name = name_tv_mono,
+			.vmux = 1,
+			.amux = LINE2,
+			.tv   = 1,
+		},{
+			.name = name_comp1,
+			.vmux = 0,
+			.amux = LINE2,
+		},{
+			.name = name_comp2,
+			.vmux = 3,
+			.amux = LINE2,
+		},{
+			.name = name_svideo,
+			.vmux = 8,
+			.amux = LINE2,
+		}},
+		.radio = {
+			.name = name_radio,
+			.amux = LINE2,
+			.gpio = 0x200000,
+		},
+	},
+	[SAA7134_BOARD_AVERMEDIA_DVD_EZMAKER] = {
+		/* Michael Smith <msmith@cbnco.com> */
+		.name           = "AVerMedia DVD EZMaker",
+		.audio_clock    = 0x00187de7,
+		.tuner_type     = TUNER_ABSENT,
+		.inputs         = {{
+			.name = name_comp1,
+			.vmux = 3,
+		}},
+	},
 };
 const unsigned int saa7134_bcount = ARRAY_SIZE(saa7134_boards);
 
@@ -1023,6 +1099,12 @@
                 .subvendor    = 0x1461, /* Avermedia Technologies Inc */
                 .subdevice    = 0x2115,
 		.driver_data  = SAA7134_BOARD_MD2819,
+	},{
+		.vendor       = PCI_VENDOR_ID_PHILIPS,
+		.device       = PCI_DEVICE_ID_PHILIPS_SAA7130,
+                .subvendor    = 0x1461, /* Avermedia Technologies Inc */
+                .subdevice    = 0x10ff,
+		.driver_data  = SAA7134_BOARD_AVERMEDIA_DVD_EZMAKER,
         },{
 		/* TransGear 3000TV */
 		.vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -1043,6 +1125,12 @@
                 .subdevice    = 0x4cb4,
                 .driver_data  = SAA7134_BOARD_ECS_TVP3XP,
         },{
+                .vendor       = PCI_VENDOR_ID_PHILIPS,
+                .device       = PCI_DEVICE_ID_PHILIPS_SAA7133,
+                .subvendor    = 0x1019,
+                .subdevice    = 0x4cb5,
+                .driver_data  = SAA7134_BOARD_ECS_TVP3XP_4CB5,
+        },{
 		
 		/* --- boards without eeprom + subsystem ID --- */
                 .vendor       = PCI_VENDOR_ID_PHILIPS,
@@ -1149,6 +1237,8 @@
 		break;
 	case SAA7134_BOARD_CINERGY400:
 	case SAA7134_BOARD_CINERGY600:
+	case SAA7134_BOARD_ECS_TVP3XP:
+	case SAA7134_BOARD_ECS_TVP3XP_4CB5:
 		dev->has_remote = 1;
 		break;
 	}
diff -u linux-2.6.2/drivers/media/video/saa7134/saa7134-input.c linux/drivers/media/video/saa7134/saa7134-input.c
--- linux-2.6.2/drivers/media/video/saa7134/saa7134-input.c	2004-02-05 13:32:03.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-input.c	2004-02-05 13:44:39.036177903 +0100
@@ -1,4 +1,6 @@
 /*
+ * handle saa7134 IR remotes via linux kernel input layer.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -13,9 +15,6 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/module.h>
@@ -101,6 +100,63 @@
 	[ 0x23 ] = KEY_STOP,
 };
 
+/* Alfons Geser <a.geser@cox.net> */
+static IR_KEYTAB_TYPE eztv_codes[IR_KEYTAB_SIZE] = {
+        [ 18 ] = KEY_POWER,
+        [  1 ] = KEY_TV,             // DVR
+        [ 21 ] = KEY_VIDEO,          // DVD
+        [ 23 ] = KEY_AUDIO,          // music
+
+                                     // DVR mode / DVD mode / music mode
+
+        [ 27 ] = KEY_MUTE,           // mute
+        [  2 ] = KEY_RESERVED,       // MTS/SAP / audio /autoseek
+        [ 30 ] = KEY_RESERVED,       // closed captioning / subtitle / seek
+        [ 22 ] = KEY_ZOOM,           // full screen
+        [ 28 ] = KEY_RESERVED,       // video source / eject /delall
+        [ 29 ] = KEY_RESERVED,       // playback / angle /del
+        [ 47 ] = KEY_SEARCH,         // scan / menu / playlist
+        [ 48 ] = KEY_RESERVED,       // CH surfing / bookmark / memo
+
+        [ 49 ] = KEY_HELP,           // help
+        [ 50 ] = KEY_RESERVED,       // num/memo
+        [ 51 ] = KEY_ESC,            // cancel
+
+	[ 12 ] = KEY_UP,             // up
+	[ 16 ] = KEY_DOWN,           // down
+	[  8 ] = KEY_LEFT,           // left
+	[  4 ] = KEY_RIGHT,          // right
+	[  3 ] = KEY_ENTER,          // select
+
+	[ 31 ] = KEY_REWIND,         // rewind
+	[ 32 ] = KEY_PLAYPAUSE,      // play/pause
+	[ 41 ] = KEY_FORWARD,        // forward
+	[ 20 ] = KEY_RESERVED,       // repeat
+	[ 43 ] = KEY_RECORD,         // recording
+	[ 44 ] = KEY_STOP,           // stop
+	[ 45 ] = KEY_PLAY,           // play
+	[ 46 ] = KEY_RESERVED,       // snapshot
+
+        [  0 ] = KEY_KP0,
+        [  5 ] = KEY_KP1,
+        [  6 ] = KEY_KP2,
+        [  7 ] = KEY_KP3,
+        [  9 ] = KEY_KP4,
+        [ 10 ] = KEY_KP5,
+        [ 11 ] = KEY_KP6,
+        [ 13 ] = KEY_KP7,
+        [ 14 ] = KEY_KP8,
+        [ 15 ] = KEY_KP9,
+ 
+        [ 42 ] = KEY_VOLUMEUP,
+        [ 17 ] = KEY_VOLUMEDOWN,
+        [ 24 ] = KEY_CHANNELUP,      // CH.tracking up
+        [ 25 ] = KEY_CHANNELDOWN,    // CH.tracking down
+
+        [ 19 ] = KEY_KPENTER,        // enter
+        [ 33 ] = KEY_KPDOT,          // . (decimal dot)
+};
+
 /* ---------------------------------------------------------------------- */
 
 static int build_key(struct saa7134_dev *dev)
@@ -111,9 +167,15 @@
 	/* rising SAA7134_GPIO_GPRESCAN reads the status */
 	saa_clearb(SAA7134_GPIO_GPMODE3,SAA7134_GPIO_GPRESCAN);
 	saa_setb(SAA7134_GPIO_GPMODE3,SAA7134_GPIO_GPRESCAN);
+
 	gpio = saa_readl(SAA7134_GPIO_GPSTATUS0 >> 2);
-	data = ir_extract_bits(gpio, ir->mask_keycode);
+        if (ir->polling) {
+                if (ir->last_gpio == gpio)
+                        return 0;
+                ir->last_gpio = gpio;
+        }
 
+ 	data = ir_extract_bits(gpio, ir->mask_keycode);
 	printk("%s: build_key gpio=0x%x mask=0x%x data=%d\n",
 	       dev->name, gpio, ir->mask_keycode, data);
 
@@ -130,7 +192,21 @@
 
 void saa7134_input_irq(struct saa7134_dev *dev)
 {
+        struct saa7134_ir *ir = dev->remote;
+
+        if (!ir->polling)
+		build_key(dev);
+}
+
+static void saa7134_input_timer(unsigned long data)
+{
+	struct saa7134_dev *dev = (struct saa7134_dev*)data;
+	struct saa7134_ir *ir = dev->remote;
+	unsigned long timeout;
+
 	build_key(dev);
+	timeout = jiffies + (ir->polling * HZ / 1000);
+	mod_timer(&ir->timer, timeout);
 }
 
 int saa7134_input_init1(struct saa7134_dev *dev)
@@ -140,6 +216,7 @@
 	u32 mask_keycode = 0;
 	u32 mask_keydown = 0;
 	u32 mask_keyup   = 0;
+	int polling      = 0;
 	int ir_type      = IR_TYPE_OTHER;
 
 	/* detect & configure */
@@ -158,6 +235,13 @@
 		mask_keycode = 0x00003f;
 		mask_keyup   = 0x040000;
 		break;
+	case SAA7134_BOARD_ECS_TVP3XP:
+	case SAA7134_BOARD_ECS_TVP3XP_4CB5:
+                ir_codes     = eztv_codes;
+                mask_keycode = 0x00017c;
+                mask_keyup   = 0x000002;
+		polling      = 50; // ms
+                break;
 	}
 	if (NULL == ir_codes) {
 		printk("%s: Oops: IR config error [card=%d]\n",
@@ -174,6 +258,7 @@
 	ir->mask_keycode = mask_keycode;
 	ir->mask_keydown = mask_keydown;
 	ir->mask_keyup   = mask_keyup;
+        ir->polling      = polling;
 	
 	/* init input device */
 	snprintf(ir->name, sizeof(ir->name), "saa7134 IR (%s)",
@@ -196,6 +281,14 @@
 
 	/* all done */
 	dev->remote = ir;
+	if (ir->polling) {
+		init_timer(&ir->timer);
+		ir->timer.function = saa7134_input_timer;
+		ir->timer.data     = (unsigned long)dev;
+		ir->timer.expires  = jiffies + HZ;
+		add_timer(&ir->timer);
+	}
+
 	input_register_device(&dev->remote->dev);
 	printk("%s: registered input device for IR\n",dev->name);
 	return 0;
@@ -207,6 +300,8 @@
 		return;
 	
 	input_unregister_device(&dev->remote->dev);
+	if (dev->remote->polling)
+		del_timer_sync(&dev->remote->timer);
 	kfree(dev->remote);
 	dev->remote = NULL;
 }
diff -u linux-2.6.2/drivers/media/video/saa7134/saa7134-tvaudio.c linux/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.6.2/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-02-05 13:29:18.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134-tvaudio.c	2004-02-05 13:44:39.038177534 +0100
@@ -45,6 +45,9 @@
 MODULE_PARM(audio_ddep,"i");
 MODULE_PARM_DESC(audio_ddep,"audio ddep overwrite");
 
+static int audio_clock_override = UNSET;
+MODULE_PARM(audio_clock_override, "i");
+
 static int audio_clock_tweak = 0;
 MODULE_PARM(audio_clock_tweak, "i");
 MODULE_PARM_DESC(audio_clock_tweak, "Audio clock tick fine tuning for cards with audio crystal that's slightly off (range [-1024 .. 1024])");
@@ -140,6 +143,9 @@
 {
 	int clock = saa7134_boards[dev->board].audio_clock;
 
+	if (UNSET != audio_clock_override)
+	        clock = audio_clock_override;
+	
 	/* init all audio registers */
 	saa_writeb(SAA7134_AUDIO_PLL_CTRL,   0x00);
 	if (need_resched())
@@ -296,8 +302,13 @@
 	DECLARE_WAITQUEUE(wait, current);
 	
 	add_wait_queue(&dev->thread.wq, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(timeout);
+	if (dev->thread.scan1 == dev->thread.scan2 && !dev->thread.shutdown) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (timeout < 0)
+			schedule();
+		else
+			schedule_timeout(timeout);
+	}
 	remove_wait_queue(&dev->thread.wq, &wait);
 	return dev->thread.scan1 != dev->thread.scan2;
 }
@@ -457,18 +468,11 @@
 	unsigned int i, audio;
 	int max1,max2,carrier,rx,mode,lastmode;
 
-	lock_kernel();
 	daemonize("%s", dev->name);
-	dev->thread.task = current;
-	unlock_kernel();
-	if (dev->thread.notify != NULL)
-		up(dev->thread.notify);
-
+	allow_signal(SIGTERM);
 	for (;;) {
-		if (dev->thread.exit || signal_pending(current))
-			goto done;
-		interruptible_sleep_on(&dev->thread.wq);
-		if (dev->thread.exit || signal_pending(current))
+		tvaudio_sleep(dev,-1);
+		if (dev->thread.shutdown || signal_pending(current))
 			goto done;
 
 	restart:
@@ -571,7 +575,7 @@
 		for (;;) {
 			if (tvaudio_sleep(dev,5*HZ))
 				goto restart;
-			if (dev->thread.exit || signal_pending(current))
+			if (dev->thread.shutdown || signal_pending(current))
 				break;
 			if (UNSET == dev->thread.mode) {
 				rx = tvaudio_getstereo(dev,&tvaudio[i]);
@@ -587,9 +591,7 @@
 	}
 
  done:
-	dev->thread.task = NULL;
-	if(dev->thread.notify != NULL)
-		up(dev->thread.notify);
+	complete_and_exit(&dev->thread.exit, 0);
 	return 0;
 }
 
@@ -721,22 +723,16 @@
 	struct saa7134_dev *dev = data;
 	u32 value, norms;
 
-	lock_kernel();
 	daemonize("%s", dev->name);
-	dev->thread.task = current;
-	unlock_kernel();
-	if (dev->thread.notify != NULL)
-		up(dev->thread.notify);
+	allow_signal(SIGTERM);
 
 	/* unmute */
 	saa_dsp_writel(dev, 0x474 >> 2, 0x00);
 	saa_dsp_writel(dev, 0x450 >> 2, 0x00);
 
 	for (;;) {
-		if (dev->thread.exit || signal_pending(current))
-			goto done;
-		interruptible_sleep_on(&dev->thread.wq);
-		if (dev->thread.exit || signal_pending(current))
+		tvaudio_sleep(dev,-1);
+		if (dev->thread.shutdown || signal_pending(current))
 			goto done;
 
 	restart:
@@ -808,9 +804,7 @@
 	}
 
  done:
-	dev->thread.task = NULL;
-	if(dev->thread.notify != NULL)
-		up(dev->thread.notify);
+	complete_and_exit(&dev->thread.exit, 0);
 	return 0;
 }
 
@@ -893,7 +887,6 @@
 {
 	DECLARE_MUTEX_LOCKED(sem);
 	int (*my_thread)(void *data) = NULL;
-	int rc;
 
 	/* enable I2S audio output */
 	if (saa7134_boards[dev->board].i2s_rate) {
@@ -915,17 +908,16 @@
 		my_thread = tvaudio_thread_ddep;
 		break;
 	}
+
+	dev->thread.pid = -1;
 	if (my_thread) {
 		/* start tvaudio thread */
 		init_waitqueue_head(&dev->thread.wq);
-		dev->thread.notify = &sem;
-		rc = kernel_thread(my_thread,dev,0);
-		if (rc < 0)
+		init_completion(&dev->thread.exit);
+		dev->thread.pid = kernel_thread(my_thread,dev,0);
+		if (dev->thread.pid < 0)
 			printk(KERN_WARNING "%s: kernel_thread() failed\n",
 			       dev->name);
-		else
-			down(&sem);
-		dev->thread.notify = NULL;
 		wake_up_interruptible(&dev->thread.wq);
 	}
 
@@ -934,15 +926,11 @@
 
 int saa7134_tvaudio_fini(struct saa7134_dev *dev)
 {
-	DECLARE_MUTEX_LOCKED(sem);
-
 	/* shutdown tvaudio thread */
-	if (dev->thread.task) {
-		dev->thread.notify = &sem;
-		dev->thread.exit = 1;
+	if (dev->thread.pid >= 0) {
+		dev->thread.shutdown = 1;
 		wake_up_interruptible(&dev->thread.wq);
-		down(&sem);
-		dev->thread.notify = NULL;
+		wait_for_completion(&dev->thread.exit);
 	}
 	saa_andorb(SAA7134_ANALOG_IO_SELECT, 0x07, 0x00); /* LINE1 */
 	return 0;
@@ -950,7 +938,7 @@
 
 int saa7134_tvaudio_do_scan(struct saa7134_dev *dev)
 {
-	if (dev->thread.task) {
+	if (dev->thread.pid >= 0) {
 		dev->thread.mode = UNSET;
 		dev->thread.scan2++;
 		wake_up_interruptible(&dev->thread.wq);
diff -u linux-2.6.2/drivers/media/video/saa7134/saa7134.h linux/drivers/media/video/saa7134/saa7134.h
--- linux-2.6.2/drivers/media/video/saa7134/saa7134.h	2004-02-05 13:31:56.000000000 +0100
+++ linux/drivers/media/video/saa7134/saa7134.h	2004-02-05 13:44:39.041176981 +0100
@@ -151,6 +151,9 @@
 #define SAA7134_BOARD_MANLI_MTV001     28
 #define SAA7134_BOARD_TG3000TV         29
 #define SAA7134_BOARD_ECS_TVP3XP       30
+#define SAA7134_BOARD_ECS_TVP3XP_4CB5  31
+#define SAA7134_BOARD_AVACSSMARTTV     32
+#define SAA7134_BOARD_AVERMEDIA_DVD_EZMAKER 33
 
 #define SAA7134_INPUT_MAX 8
 
@@ -212,10 +215,10 @@
 
 /* tvaudio thread status */
 struct saa7134_thread {
-	struct task_struct         *task;
+	pid_t                      pid;
+	struct completion          exit;
 	wait_queue_head_t          wq;
-	struct semaphore           *notify;
-	unsigned int               exit;
+	unsigned int               shutdown;
 	unsigned int               scan1;
 	unsigned int               scan2;
 	unsigned int               mode;
@@ -319,6 +322,9 @@
 	u32                        mask_keycode;
 	u32                        mask_keydown;
 	u32                        mask_keyup;
+        int                        polling;
+        u32                        last_gpio;
+        struct timer_list          timer;
 };
 
 /* global device status */

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
