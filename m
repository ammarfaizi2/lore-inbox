Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVLNDQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVLNDQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbVLNDQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:16:37 -0500
Received: from smtp1.brturbo.com.br ([200.199.201.163]:28320 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1030338AbVLNDQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:16:30 -0500
Message-Id: <20051214031500.586904000@localhost>
References: <20051214031344.031534000@localhost>
Date: Wed, 14 Dec 2005 01:13:49 -0200
From: mchehab@brturbo.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, js@linuxtv.org,
       Ricardo Cerqueira <v4l@cerqueira.org>
Subject: [patch-mm 5/6] V4L/DVB (3161): ir-kbd-gpio is now part of bttv
Content-Disposition: inline; filename=v4l_dvb_3161_ir_kbd_gpio_is_now_part_of_bttv.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cerqueira <v4l@cerqueira.org>

- Merged ir-kbd-gpio into bttv as bttv-input, for consistency with other
input modules

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 drivers/media/video/Makefile      |    5 
 drivers/media/video/bttv-cards.c  |    3 
 drivers/media/video/bttv-driver.c |   13 
 drivers/media/video/bttv-gpio.c   |   18 
 drivers/media/video/bttv-input.c  |  688 ++++++++++++++++++++++++++++++++++
 drivers/media/video/bttv.h        |   36 +
 drivers/media/video/bttvp.h       |    6 
 drivers/media/video/ir-kbd-gpio.c |  766 --------------------------------------
 8 files changed, 736 insertions(+), 799 deletions(-)

--- git.orig/drivers/media/video/bttv-cards.c
+++ git/drivers/media/video/bttv-cards.c
@@ -2139,7 +2139,6 @@ struct tvcard bttv_tvcards[] = {
 		.has_remote	= 1,
 		.gpiomask	= 0x1b,
 		.no_gpioirq     = 1,
-		.any_irq		= 1,
 	},
 	[BTTV_BOARD_PV143] = {
 		/* Jorge Boncompte - DTI2 <jorge@dti2.net> */
@@ -3412,8 +3411,6 @@ void __devinit bttv_init_card2(struct bt
 		btv->has_remote=1;
 	if (!bttv_tvcards[btv->c.type].no_gpioirq)
 		btv->gpioirq=1;
-	if (bttv_tvcards[btv->c.type].any_irq)
-		btv->any_irq = 1;
 	if (bttv_tvcards[btv->c.type].audio_hook)
 		btv->audio_hook=bttv_tvcards[btv->c.type].audio_hook;
 
--- git.orig/drivers/media/video/bttv-driver.c
+++ git/drivers/media/video/bttv-driver.c
@@ -3702,8 +3702,8 @@ static irqreturn_t bttv_irq(int irq, voi
 
 	btv=(struct bttv *)dev_id;
 
-	if (btv->any_irq)
-		handled = bttv_any_irq(&btv->c);
+	if (btv->custom_irq)
+		handled = btv->custom_irq(btv);
 
 	count=0;
 	while (1) {
@@ -3739,9 +3739,9 @@ static irqreturn_t bttv_irq(int irq, voi
 		if (astat&BT848_INT_VSYNC)
 			btv->field_count++;
 
-		if (astat & BT848_INT_GPINT) {
+		if ((astat & BT848_INT_GPINT) && btv->remote) {
 			wake_up(&btv->gpioq);
-			bttv_gpio_irq(&btv->c);
+			bttv_input_irq(btv);
 		}
 
 		if (astat & BT848_INT_I2CDONE) {
@@ -4070,6 +4070,8 @@ static int __devinit bttv_probe(struct p
 	if (bttv_tvcards[btv->c.type].has_dvb)
 		bttv_sub_add_device(&btv->c, "dvb");
 
+	bttv_input_init(btv);
+
 	/* everything is fine */
 	bttv_num++;
 	return 0;
@@ -4104,7 +4106,8 @@ static void __devexit bttv_remove(struct
 	/* tell gpio modules we are leaving ... */
 	btv->shutdown=1;
 	wake_up(&btv->gpioq);
-	bttv_sub_del_devices(&btv->c);
+	bttv_input_fini(btv);
+	//bttv_sub_del_devices(&btv->c);
 
 	/* unregister i2c_bus + input */
 	fini_bttv_i2c(btv);
--- git.orig/drivers/media/video/bttv-gpio.c
+++ git/drivers/media/video/bttv-gpio.c
@@ -113,24 +113,6 @@ void bttv_gpio_irq(struct bttv_core *cor
 	}
 }
 
-int bttv_any_irq(struct bttv_core *core)
-{
-	struct bttv_sub_driver *drv;
-	struct bttv_sub_device *dev;
-	struct list_head *item;
-	int handled = 0;
-
-	list_for_each(item,&core->subs) {
-		dev = list_entry(item,struct bttv_sub_device,list);
-		drv = to_bttv_sub_drv(dev->dev.driver);
-		if (drv && drv->any_irq) {
-			if (drv->any_irq(dev))
-				handled = 1;
-		}
-	}
-	return handled;
-}
-
 /* ----------------------------------------------------------------------- */
 /* external: sub-driver register/unregister                                */
 
--- git.orig/drivers/media/video/bttv.h
+++ git/drivers/media/video/bttv.h
@@ -16,6 +16,8 @@
 
 #include <linux/videodev.h>
 #include <linux/i2c.h>
+#include <media/ir-common.h>
+#include <media/ir-kbd-i2c.h>
 
 /* ---------------------------------------------------------- */
 /* exported by bttv-cards.c                                   */
@@ -211,6 +213,34 @@ struct bttv_core {
 
 struct bttv;
 
+
+struct bttv_ir {
+	struct input_dev        *dev;
+	struct ir_input_state   ir;
+	char                    name[32];
+	char                    phys[32];
+
+	/* Usual gpio signalling */
+
+	u32                     mask_keycode;
+	u32                     mask_keydown;
+	u32                     mask_keyup;
+	u32                     polling;
+	u32                     last_gpio;
+	struct work_struct      work;
+	struct timer_list       timer;
+
+	/* RC5 gpio */
+	u32 rc5_gpio;
+	struct timer_list timer_end;	/* timer_end for code completion */
+	struct timer_list timer_keyup;	/* timer_end for key release */
+	u32 last_rc5;			/* last good rc5 code */
+	u32 last_bit;			/* last raw bit seen */
+	u32 code;			/* raw code under construction */
+	struct timeval base_time;	/* time of last seen code */
+	int active;			/* building raw code */
+};
+
 struct tvcard
 {
 	char *name;
@@ -236,7 +266,6 @@ struct tvcard
 	unsigned int has_dvb:1;
 	unsigned int has_remote:1;
 	unsigned int no_gpioirq:1;
-	unsigned int any_irq:1;
 
 	/* other settings */
 	unsigned int pll;
@@ -336,7 +365,6 @@ struct bttv_sub_driver {
 	struct device_driver   drv;
 	char                   wanted[BUS_ID_SIZE];
 	void                   (*gpio_irq)(struct bttv_sub_device *sub);
-	int                    (*any_irq)(struct bttv_sub_device *sub);
 };
 #define to_bttv_sub_drv(x) container_of((x), struct bttv_sub_driver, drv)
 
@@ -364,6 +392,10 @@ extern int bttv_I2CWrite(struct bttv *bt
 			 unsigned char b2, int both);
 extern void bttv_readee(struct bttv *btv, unsigned char *eedata, int addr);
 
+extern int bttv_input_init(struct bttv *dev);
+extern void bttv_input_fini(struct bttv *dev);
+extern void bttv_input_irq(struct bttv *dev);
+
 #endif /* _BTTV_H_ */
 /*
  * Local variables:
--- /dev/null
+++ git/drivers/media/video/bttv-input.c
@@ -0,0 +1,688 @@
+/*
+ *
+ * Copyright (c) 2003 Gerd Knorr
+ * Copyright (c) 2003 Pavel Machek
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+
+#include "bttv.h"
+#include "bttvp.h"
+
+/* ---------------------------------------------------------------------- */
+
+static IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {
+	[ 34 ] = KEY_KP0,
+	[ 40 ] = KEY_KP1,
+	[ 24 ] = KEY_KP2,
+	[ 56 ] = KEY_KP3,
+	[ 36 ] = KEY_KP4,
+	[ 20 ] = KEY_KP5,
+	[ 52 ] = KEY_KP6,
+	[ 44 ] = KEY_KP7,
+	[ 28 ] = KEY_KP8,
+	[ 60 ] = KEY_KP9,
+
+	[ 48 ] = KEY_EJECTCD,     // Unmarked on my controller
+	[  0 ] = KEY_POWER,
+	[ 18 ] = BTN_LEFT,        // DISPLAY/L
+	[ 50 ] = BTN_RIGHT,       // LOOP/R
+	[ 10 ] = KEY_MUTE,
+	[ 38 ] = KEY_RECORD,
+	[ 22 ] = KEY_PAUSE,
+	[ 54 ] = KEY_STOP,
+	[ 30 ] = KEY_VOLUMEDOWN,
+	[ 62 ] = KEY_VOLUMEUP,
+
+	[ 32 ] = KEY_TUNER,       // TV/FM
+	[ 16 ] = KEY_CD,
+	[  8 ] = KEY_VIDEO,
+	[  4 ] = KEY_AUDIO,
+	[ 12 ] = KEY_ZOOM,        // full screen
+	[  2 ] = KEY_INFO,        // preview
+	[ 42 ] = KEY_SEARCH,      // autoscan
+	[ 26 ] = KEY_STOP,        // freeze
+	[ 58 ] = KEY_RECORD,      // capture
+	[  6 ] = KEY_PLAY,        // unmarked
+	[ 46 ] = KEY_RED,         // unmarked
+	[ 14 ] = KEY_GREEN,       // unmarked
+
+	[ 33 ] = KEY_YELLOW,      // unmarked
+	[ 17 ] = KEY_CHANNELDOWN,
+	[ 49 ] = KEY_CHANNELUP,
+	[  1 ] = KEY_BLUE,        // unmarked
+};
+
+/* Matt Jesson <dvb@jesson.eclipse.co.uk */
+static IR_KEYTAB_TYPE ir_codes_avermedia_dvbt[IR_KEYTAB_SIZE] = {
+	[ 0x28 ] = KEY_KP0,         //'0' / 'enter'
+	[ 0x22 ] = KEY_KP1,         //'1'
+	[ 0x12 ] = KEY_KP2,         //'2' / 'up arrow'
+	[ 0x32 ] = KEY_KP3,         //'3'
+	[ 0x24 ] = KEY_KP4,         //'4' / 'left arrow'
+	[ 0x14 ] = KEY_KP5,         //'5'
+	[ 0x34 ] = KEY_KP6,         //'6' / 'right arrow'
+	[ 0x26 ] = KEY_KP7,         //'7'
+	[ 0x16 ] = KEY_KP8,         //'8' / 'down arrow'
+	[ 0x36 ] = KEY_KP9,         //'9'
+
+	[ 0x20 ] = KEY_LIST,        // 'source'
+	[ 0x10 ] = KEY_TEXT,        // 'teletext'
+	[ 0x00 ] = KEY_POWER,       // 'power'
+	[ 0x04 ] = KEY_AUDIO,       // 'audio'
+	[ 0x06 ] = KEY_ZOOM,        // 'full screen'
+	[ 0x18 ] = KEY_VIDEO,       // 'display'
+	[ 0x38 ] = KEY_SEARCH,      // 'loop'
+	[ 0x08 ] = KEY_INFO,        // 'preview'
+	[ 0x2a ] = KEY_REWIND,      // 'backward <<'
+	[ 0x1a ] = KEY_FASTFORWARD, // 'forward >>'
+	[ 0x3a ] = KEY_RECORD,      // 'capture'
+	[ 0x0a ] = KEY_MUTE,        // 'mute'
+	[ 0x2c ] = KEY_RECORD,      // 'record'
+	[ 0x1c ] = KEY_PAUSE,       // 'pause'
+	[ 0x3c ] = KEY_STOP,        // 'stop'
+	[ 0x0c ] = KEY_PLAY,        // 'play'
+	[ 0x2e ] = KEY_RED,         // 'red'
+	[ 0x01 ] = KEY_BLUE,        // 'blue' / 'cancel'
+	[ 0x0e ] = KEY_YELLOW,      // 'yellow' / 'ok'
+	[ 0x21 ] = KEY_GREEN,       // 'green'
+	[ 0x11 ] = KEY_CHANNELDOWN, // 'channel -'
+	[ 0x31 ] = KEY_CHANNELUP,   // 'channel +'
+	[ 0x1e ] = KEY_VOLUMEDOWN,  // 'volume -'
+	[ 0x3e ] = KEY_VOLUMEUP,    // 'volume +'
+};
+
+/* Attila Kondoros <attila.kondoros@chello.hu> */
+static IR_KEYTAB_TYPE ir_codes_apac_viewcomp[IR_KEYTAB_SIZE] = {
+
+	[  1 ] = KEY_KP1,
+	[  2 ] = KEY_KP2,
+	[  3 ] = KEY_KP3,
+	[  4 ] = KEY_KP4,
+	[  5 ] = KEY_KP5,
+	[  6 ] = KEY_KP6,
+	[  7 ] = KEY_KP7,
+	[  8 ] = KEY_KP8,
+	[  9 ] = KEY_KP9,
+	[  0 ] = KEY_KP0,
+	[ 23 ] = KEY_LAST,        // +100
+	[ 10 ] = KEY_LIST,        // recall
+
+
+	[ 28 ] = KEY_TUNER,       // TV/FM
+	[ 21 ] = KEY_SEARCH,      // scan
+	[ 18 ] = KEY_POWER,       // power
+	[ 31 ] = KEY_VOLUMEDOWN,  // vol up
+	[ 27 ] = KEY_VOLUMEUP,    // vol down
+	[ 30 ] = KEY_CHANNELDOWN, // chn up
+	[ 26 ] = KEY_CHANNELUP,   // chn down
+
+	[ 17 ] = KEY_VIDEO,       // video
+	[ 15 ] = KEY_ZOOM,        // full screen
+	[ 19 ] = KEY_MUTE,        // mute/unmute
+	[ 16 ] = KEY_TEXT,        // min
+
+	[ 13 ] = KEY_STOP,        // freeze
+	[ 14 ] = KEY_RECORD,      // record
+	[ 29 ] = KEY_PLAYPAUSE,   // stop
+	[ 25 ] = KEY_PLAY,        // play
+
+	[ 22 ] = KEY_GOTO,        // osd
+	[ 20 ] = KEY_REFRESH,     // default
+	[ 12 ] = KEY_KPPLUS,      // fine tune >>>>
+	[ 24 ] = KEY_KPMINUS      // fine tune <<<<
+};
+
+/* ---------------------------------------------------------------------- */
+
+static IR_KEYTAB_TYPE ir_codes_conceptronic[IR_KEYTAB_SIZE] = {
+
+	[ 30 ] = KEY_POWER,       // power
+	[ 7  ] = KEY_MEDIA,       // source
+	[ 28 ] = KEY_SEARCH,      // scan
+
+/* FIXME: duplicate keycodes?
+ *
+ * These four keys seem to share the same GPIO as CH+, CH-, <<< and >>>
+ * The GPIO values are
+ * 6397fb for both "Scan <" and "CH -",
+ * 639ffb for "Scan >" and "CH+",
+ * 6384fb for "Tune <" and "<<<",
+ * 638cfb for "Tune >" and ">>>", regardless of the mask.
+ *
+ *	[ 23 ] = KEY_BACK,        // fm scan <<
+ *	[ 31 ] = KEY_FORWARD,     // fm scan >>
+ *
+ *	[ 4  ] = KEY_LEFT,        // fm tuning <
+ *	[ 12 ] = KEY_RIGHT,       // fm tuning >
+ *
+ * For now, these four keys are disabled. Pressing them will generate
+ * the CH+/CH-/<<</>>> events
+ */
+
+	[ 3  ] = KEY_TUNER,       // TV/FM
+
+	[ 0  ] = KEY_RECORD,
+	[ 8  ] = KEY_STOP,
+	[ 17 ] = KEY_PLAY,
+
+	[ 26 ] = KEY_PLAYPAUSE,   // freeze
+	[ 25 ] = KEY_ZOOM,        // zoom
+	[ 15 ] = KEY_TEXT,        // min
+
+	[ 1  ] = KEY_KP1,
+	[ 11 ] = KEY_KP2,
+	[ 27 ] = KEY_KP3,
+	[ 5  ] = KEY_KP4,
+	[ 9  ] = KEY_KP5,
+	[ 21 ] = KEY_KP6,
+	[ 6  ] = KEY_KP7,
+	[ 10 ] = KEY_KP8,
+	[ 18 ] = KEY_KP9,
+	[ 2  ] = KEY_KP0,
+	[ 16 ] = KEY_LAST,        // +100
+	[ 19 ] = KEY_LIST,        // recall
+
+	[ 31 ] = KEY_CHANNELUP,   // chn down
+	[ 23 ] = KEY_CHANNELDOWN, // chn up
+	[ 22 ] = KEY_VOLUMEUP,    // vol down
+	[ 20 ] = KEY_VOLUMEDOWN,  // vol up
+
+	[ 4  ] = KEY_KPMINUS,     // <<<
+	[ 14 ] = KEY_SETUP,       // function
+	[ 12 ] = KEY_KPPLUS,      // >>>
+
+	[ 13 ] = KEY_GOTO,        // mts
+	[ 29 ] = KEY_REFRESH,     // reset
+	[ 24 ] = KEY_MUTE         // mute/unmute
+};
+
+static IR_KEYTAB_TYPE ir_codes_nebula[IR_KEYTAB_SIZE] = {
+	[0x00] = KEY_KP0,
+	[0x01] = KEY_KP1,
+	[0x02] = KEY_KP2,
+	[0x03] = KEY_KP3,
+	[0x04] = KEY_KP4,
+	[0x05] = KEY_KP5,
+	[0x06] = KEY_KP6,
+	[0x07] = KEY_KP7,
+	[0x08] = KEY_KP8,
+	[0x09] = KEY_KP9,
+	[0x0a] = KEY_TV,
+	[0x0b] = KEY_AUX,
+	[0x0c] = KEY_DVD,
+	[0x0d] = KEY_POWER,
+	[0x0e] = KEY_MHP,	/* labelled 'Picture' */
+	[0x0f] = KEY_AUDIO,
+	[0x10] = KEY_INFO,
+	[0x11] = KEY_F13,	/* 16:9 */
+	[0x12] = KEY_F14,	/* 14:9 */
+	[0x13] = KEY_EPG,
+	[0x14] = KEY_EXIT,
+	[0x15] = KEY_MENU,
+	[0x16] = KEY_UP,
+	[0x17] = KEY_DOWN,
+	[0x18] = KEY_LEFT,
+	[0x19] = KEY_RIGHT,
+	[0x1a] = KEY_ENTER,
+	[0x1b] = KEY_CHANNELUP,
+	[0x1c] = KEY_CHANNELDOWN,
+	[0x1d] = KEY_VOLUMEUP,
+	[0x1e] = KEY_VOLUMEDOWN,
+	[0x1f] = KEY_RED,
+	[0x20] = KEY_GREEN,
+	[0x21] = KEY_YELLOW,
+	[0x22] = KEY_BLUE,
+	[0x23] = KEY_SUBTITLE,
+	[0x24] = KEY_F15,	/* AD */
+	[0x25] = KEY_TEXT,
+	[0x26] = KEY_MUTE,
+	[0x27] = KEY_REWIND,
+	[0x28] = KEY_STOP,
+	[0x29] = KEY_PLAY,
+	[0x2a] = KEY_FASTFORWARD,
+	[0x2b] = KEY_F16,	/* chapter */
+	[0x2c] = KEY_PAUSE,
+	[0x2d] = KEY_PLAY,
+	[0x2e] = KEY_RECORD,
+	[0x2f] = KEY_F17,	/* picture in picture */
+	[0x30] = KEY_KPPLUS,	/* zoom in */
+	[0x31] = KEY_KPMINUS,	/* zoom out */
+	[0x32] = KEY_F18,	/* capture */
+	[0x33] = KEY_F19,	/* web */
+	[0x34] = KEY_EMAIL,
+	[0x35] = KEY_PHONE,
+	[0x36] = KEY_PC
+};
+
+static int debug;
+module_param(debug, int, 0644);    /* debug level (0,1,2) */
+static int repeat_delay = 500;
+module_param(repeat_delay, int, 0644);
+static int repeat_period = 33;
+module_param(repeat_period, int, 0644);
+
+#define DEVNAME "bttv-input"
+
+/* ---------------------------------------------------------------------- */
+
+static void ir_handle_key(struct bttv *btv)
+{
+	struct bttv_ir *ir = btv->remote;
+	u32 gpio,data;
+
+	/* read gpio value */
+	gpio = bttv_gpio_read(&btv->c);
+	if (ir->polling) {
+		if (ir->last_gpio == gpio)
+			return;
+		ir->last_gpio = gpio;
+	}
+
+	/* extract data */
+	data = ir_extract_bits(gpio, ir->mask_keycode);
+	dprintk(KERN_INFO DEVNAME ": irq gpio=0x%x code=%d | %s%s%s\n",
+		gpio, data,
+		ir->polling               ? "poll"  : "irq",
+		(gpio & ir->mask_keydown) ? " down" : "",
+		(gpio & ir->mask_keyup)   ? " up"   : "");
+
+	if ((ir->mask_keydown  &&  (0 != (gpio & ir->mask_keydown))) ||
+	    (ir->mask_keyup    &&  (0 == (gpio & ir->mask_keyup)))) {
+		ir_input_keydown(ir->dev,&ir->ir,data,data);
+	} else {
+		ir_input_nokey(ir->dev,&ir->ir);
+	}
+
+}
+
+void bttv_input_irq(struct bttv *btv)
+{
+	struct bttv_ir *ir = btv->remote;
+
+	if (!ir->polling)
+		ir_handle_key(btv);
+}
+
+static void bttv_input_timer(unsigned long data)
+{
+	struct bttv *btv = (struct bttv*)data;
+	struct bttv_ir *ir = btv->remote;
+	unsigned long timeout;
+
+	ir_handle_key(btv);
+	timeout = jiffies + (ir->polling * HZ / 1000);
+	mod_timer(&ir->timer, timeout);
+}
+
+/* ---------------------------------------------------------------*/
+
+static int rc5_remote_gap = 885;
+module_param(rc5_remote_gap, int, 0644);
+static int rc5_key_timeout = 200;
+module_param(rc5_key_timeout, int, 0644);
+
+#define RC5_START(x)	(((x)>>12)&3)
+#define RC5_TOGGLE(x)	(((x)>>11)&1)
+#define RC5_ADDR(x)	(((x)>>6)&31)
+#define RC5_INSTR(x)	((x)&63)
+
+/* decode raw bit pattern to RC5 code */
+static u32 rc5_decode(unsigned int code)
+{
+	unsigned int org_code = code;
+	unsigned int pair;
+	unsigned int rc5 = 0;
+	int i;
+
+	code = (code << 1) | 1;
+	for (i = 0; i < 14; ++i) {
+		pair = code & 0x3;
+		code >>= 2;
+
+		rc5 <<= 1;
+		switch (pair) {
+		case 0:
+		case 2:
+			break;
+		case 1:
+			rc5 |= 1;
+			break;
+		case 3:
+			dprintk(KERN_WARNING "bad code: %x\n", org_code);
+			return 0;
+		}
+	}
+	dprintk(KERN_WARNING "code=%x, rc5=%x, start=%x, toggle=%x, address=%x, "
+		"instr=%x\n", rc5, org_code, RC5_START(rc5),
+		RC5_TOGGLE(rc5), RC5_ADDR(rc5), RC5_INSTR(rc5));
+	return rc5;
+}
+
+static int bttv_rc5_irq(struct bttv *btv)
+{
+	struct bttv_ir *ir = btv->remote;
+	struct timeval tv;
+	u32 gpio;
+	u32 gap;
+	unsigned long current_jiffies, timeout;
+
+	/* read gpio port */
+	gpio = bttv_gpio_read(&btv->c);
+
+	/* remote IRQ? */
+	if (!(gpio & 0x20))
+		return 0;
+
+	/* get time of bit */
+	current_jiffies = jiffies;
+	do_gettimeofday(&tv);
+
+	/* avoid overflow with gap >1s */
+	if (tv.tv_sec - ir->base_time.tv_sec > 1) {
+		gap = 200000;
+	} else {
+		gap = 1000000 * (tv.tv_sec - ir->base_time.tv_sec) +
+		    tv.tv_usec - ir->base_time.tv_usec;
+	}
+
+	/* active code => add bit */
+	if (ir->active) {
+		/* only if in the code (otherwise spurious IRQ or timer
+		   late) */
+		if (ir->last_bit < 28) {
+			ir->last_bit = (gap - rc5_remote_gap / 2) /
+			    rc5_remote_gap;
+			ir->code |= 1 << ir->last_bit;
+		}
+		/* starting new code */
+	} else {
+		ir->active = 1;
+		ir->code = 0;
+		ir->base_time = tv;
+		ir->last_bit = 0;
+
+		timeout = current_jiffies + (500 + 30 * HZ) / 1000;
+		mod_timer(&ir->timer_end, timeout);
+	}
+
+	/* toggle GPIO pin 4 to reset the irq */
+	bttv_gpio_write(&btv->c, gpio & ~(1 << 4));
+	bttv_gpio_write(&btv->c, gpio | (1 << 4));
+	return 1;
+}
+
+
+static void bttv_rc5_timer_end(unsigned long data)
+{
+	struct bttv_ir *ir = (struct bttv_ir *)data;
+	struct timeval tv;
+	unsigned long current_jiffies, timeout;
+	u32 gap;
+
+	/* get time */
+	current_jiffies = jiffies;
+	do_gettimeofday(&tv);
+
+	/* avoid overflow with gap >1s */
+	if (tv.tv_sec - ir->base_time.tv_sec > 1) {
+		gap = 200000;
+	} else {
+		gap = 1000000 * (tv.tv_sec - ir->base_time.tv_sec) +
+		    tv.tv_usec - ir->base_time.tv_usec;
+	}
+
+	/* Allow some timmer jitter (RC5 is ~24ms anyway so this is ok) */
+	if (gap < 28000) {
+		dprintk(KERN_WARNING "spurious timer_end\n");
+		return;
+	}
+
+	ir->active = 0;
+	if (ir->last_bit < 20) {
+		/* ignore spurious codes (caused by light/other remotes) */
+		dprintk(KERN_WARNING "short code: %x\n", ir->code);
+	} else {
+		u32 rc5 = rc5_decode(ir->code);
+
+		/* two start bits? */
+		if (RC5_START(rc5) != 3) {
+			dprintk(KERN_WARNING "rc5 start bits invalid: %u\n", RC5_START(rc5));
+
+			/* right address? */
+		} else if (RC5_ADDR(rc5) == 0x0) {
+			u32 toggle = RC5_TOGGLE(rc5);
+			u32 instr = RC5_INSTR(rc5);
+
+			/* Good code, decide if repeat/repress */
+			if (toggle != RC5_TOGGLE(ir->last_rc5) ||
+			    instr != RC5_INSTR(ir->last_rc5)) {
+				dprintk(KERN_WARNING "instruction %x, toggle %x\n", instr,
+					toggle);
+				ir_input_nokey(ir->dev, &ir->ir);
+				ir_input_keydown(ir->dev, &ir->ir, instr,
+						 instr);
+			}
+
+			/* Set/reset key-up timer */
+			timeout = current_jiffies + (500 + rc5_key_timeout
+						     * HZ) / 1000;
+			mod_timer(&ir->timer_keyup, timeout);
+
+			/* Save code for repeat test */
+			ir->last_rc5 = rc5;
+		}
+	}
+}
+
+static void bttv_rc5_timer_keyup(unsigned long data)
+{
+	struct bttv_ir *ir = (struct bttv_ir *)data;
+
+	dprintk(KERN_DEBUG "key released\n");
+	ir_input_nokey(ir->dev, &ir->ir);
+}
+
+/* ---------------------------------------------------------------------- */
+
+int bttv_input_init(struct bttv *btv)
+{
+	struct bttv_ir *ir;
+	IR_KEYTAB_TYPE *ir_codes = NULL;
+	struct input_dev *input_dev;
+	int ir_type = IR_TYPE_OTHER;
+
+	if (!btv->has_remote)
+		return -ENODEV;
+
+	ir = kzalloc(sizeof(*ir),GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ir || !input_dev) {
+		kfree(ir);
+		input_free_device(input_dev);
+		return -ENOMEM;
+	}
+	memset(ir,0,sizeof(*ir));
+
+	/* detect & configure */
+	switch (btv->c.type) {
+	case BTTV_BOARD_AVERMEDIA:
+	case BTTV_BOARD_AVPHONE98:
+	case BTTV_BOARD_AVERMEDIA98:
+		ir_codes         = ir_codes_avermedia;
+		ir->mask_keycode = 0xf88000;
+		ir->mask_keydown = 0x010000;
+		ir->polling      = 50; // ms
+		break;
+
+	case BTTV_BOARD_AVDVBT_761:
+	case BTTV_BOARD_AVDVBT_771:
+		ir_codes         = ir_codes_avermedia_dvbt;
+		ir->mask_keycode = 0x0f00c0;
+		ir->mask_keydown = 0x000020;
+		ir->polling      = 50; // ms
+		break;
+
+	case BTTV_BOARD_PXELVWPLTVPAK:
+		ir_codes         = ir_codes_pixelview;
+		ir->mask_keycode = 0x003e00;
+		ir->mask_keyup   = 0x010000;
+		ir->polling      = 50; // ms
+		break;
+	case BTTV_BOARD_PV_BT878P_9B:
+	case BTTV_BOARD_PV_BT878P_PLUS:
+		ir_codes         = ir_codes_pixelview;
+		ir->mask_keycode = 0x001f00;
+		ir->mask_keyup   = 0x008000;
+		ir->polling      = 50; // ms
+		break;
+
+	case BTTV_BOARD_WINFAST2000:
+		ir_codes         = ir_codes_winfast;
+		ir->mask_keycode = 0x1f8;
+		break;
+	case BTTV_BOARD_MAGICTVIEW061:
+	case BTTV_BOARD_MAGICTVIEW063:
+		ir_codes         = ir_codes_winfast;
+		ir->mask_keycode = 0x0008e000;
+		ir->mask_keydown = 0x00200000;
+		break;
+	case BTTV_BOARD_APAC_VIEWCOMP:
+		ir_codes         = ir_codes_apac_viewcomp;
+		ir->mask_keycode = 0x001f00;
+		ir->mask_keyup   = 0x008000;
+		ir->polling      = 50; // ms
+		break;
+	case BTTV_BOARD_CONCEPTRONIC_CTVFMI2:
+		ir_codes         = ir_codes_conceptronic;
+		ir->mask_keycode = 0x001F00;
+		ir->mask_keyup   = 0x006000;
+		ir->polling      = 50; // ms
+		break;
+	case BTTV_BOARD_NEBULA_DIGITV:
+		ir_codes = ir_codes_nebula;
+		btv->custom_irq = bttv_rc5_irq;
+		ir->rc5_gpio = 1;
+		break;
+	}
+	if (NULL == ir_codes) {
+		dprintk(KERN_INFO "Ooops: IR config error [card=%d]\n",btv->c.type);
+		kfree(ir);
+		input_free_device(input_dev);
+		return -ENODEV;
+	}
+
+	if (ir->rc5_gpio) {
+		u32 gpio;
+	    	/* enable remote irq */
+		bttv_gpio_inout(&btv->c, (1 << 4), 1 << 4);
+		gpio = bttv_gpio_read(&btv->c);
+		bttv_gpio_write(&btv->c, gpio & ~(1 << 4));
+		bttv_gpio_write(&btv->c, gpio | (1 << 4));
+	} else {
+		/* init hardware-specific stuff */
+		bttv_gpio_inout(&btv->c, ir->mask_keycode | ir->mask_keydown, 0);
+	}
+
+	/* init input device */
+	ir->dev = input_dev;
+
+	snprintf(ir->name, sizeof(ir->name), "bttv IR (card=%d)",
+		 btv->c.type);
+	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
+		 pci_name(btv->c.pci));
+
+	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
+	input_dev->name = ir->name;
+	input_dev->phys = ir->phys;
+	input_dev->id.bustype = BUS_PCI;
+	input_dev->id.version = 1;
+	if (btv->c.pci->subsystem_vendor) {
+		input_dev->id.vendor  = btv->c.pci->subsystem_vendor;
+		input_dev->id.product = btv->c.pci->subsystem_device;
+	} else {
+		input_dev->id.vendor  = btv->c.pci->vendor;
+		input_dev->id.product = btv->c.pci->device;
+	}
+	input_dev->cdev.dev = &btv->c.pci->dev;
+
+	btv->remote = ir;
+	if (ir->polling) {
+		init_timer(&ir->timer);
+		ir->timer.function = bttv_input_timer;
+		ir->timer.data     = (unsigned long)btv;
+		ir->timer.expires  = jiffies + HZ;
+		add_timer(&ir->timer);
+	} else if (ir->rc5_gpio) {
+		/* set timer_end for code completion */
+		init_timer(&ir->timer_end);
+		ir->timer_end.function = bttv_rc5_timer_end;
+		ir->timer_end.data = (unsigned long)ir;
+
+		init_timer(&ir->timer_keyup);
+		ir->timer_keyup.function = bttv_rc5_timer_keyup;
+		ir->timer_keyup.data = (unsigned long)ir;
+	}
+
+	/* all done */
+	input_register_device(btv->remote->dev);
+	printk(DEVNAME ": %s detected at %s\n",ir->dev->name,ir->dev->phys);
+
+	/* the remote isn't as bouncy as a keyboard */
+	ir->dev->rep[REP_DELAY] = repeat_delay;
+	ir->dev->rep[REP_PERIOD] = repeat_period;
+
+	return 0;
+}
+
+void bttv_input_fini(struct bttv *btv)
+{
+	if (btv->remote == NULL)
+		return;
+
+	if (btv->remote->polling) {
+		del_timer_sync(&btv->remote->timer);
+		flush_scheduled_work();
+	}
+
+
+	if (btv->remote->rc5_gpio) {
+		u32 gpio;
+
+		del_timer(&btv->remote->timer_end);
+		flush_scheduled_work();
+
+		gpio = bttv_gpio_read(&btv->c);
+		bttv_gpio_write(&btv->c, gpio & ~(1 << 4));
+	}
+
+	input_unregister_device(btv->remote->dev);
+	kfree(btv->remote);
+	btv->remote = NULL;
+}
+
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- git.orig/drivers/media/video/bttvp.h
+++ git/drivers/media/video/bttvp.h
@@ -209,7 +209,6 @@ extern struct bus_type bttv_sub_bus_type
 int bttv_sub_add_device(struct bttv_core *core, char *name);
 int bttv_sub_del_devices(struct bttv_core *core);
 void bttv_gpio_irq(struct bttv_core *core);
-int bttv_any_irq(struct bttv_core *core);
 
 
 /* ---------------------------------------------------------- */
@@ -275,7 +274,8 @@ struct bttv {
 	struct bttv_pll_info pll;
 	int triton1;
 	int gpioirq;
-	int any_irq;
+	int (*custom_irq)(struct bttv *btv);
+
 	int use_i2c_hw;
 
 	/* old gpio interface */
@@ -300,7 +300,7 @@ struct bttv {
 
 	/* infrared remote */
 	int has_remote;
-	struct bttv_input *remote;
+	struct bttv_ir *remote;
 
 	/* locking */
 	spinlock_t s_lock;
--- git.orig/drivers/media/video/ir-kbd-gpio.c
+++ /dev/null
@@ -1,766 +0,0 @@
-/*
- *
- * Copyright (c) 2003 Gerd Knorr
- * Copyright (c) 2003 Pavel Machek
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/input.h>
-#include <linux/pci.h>
-
-#include "bttv.h"
-#include <media/ir-common.h>
-
-/* ---------------------------------------------------------------------- */
-
-static IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {
-	[ 34 ] = KEY_KP0,
-	[ 40 ] = KEY_KP1,
-	[ 24 ] = KEY_KP2,
-	[ 56 ] = KEY_KP3,
-	[ 36 ] = KEY_KP4,
-	[ 20 ] = KEY_KP5,
-	[ 52 ] = KEY_KP6,
-	[ 44 ] = KEY_KP7,
-	[ 28 ] = KEY_KP8,
-	[ 60 ] = KEY_KP9,
-
-	[ 48 ] = KEY_EJECTCD,     // Unmarked on my controller
-	[  0 ] = KEY_POWER,
-	[ 18 ] = BTN_LEFT,        // DISPLAY/L
-	[ 50 ] = BTN_RIGHT,       // LOOP/R
-	[ 10 ] = KEY_MUTE,
-	[ 38 ] = KEY_RECORD,
-	[ 22 ] = KEY_PAUSE,
-	[ 54 ] = KEY_STOP,
-	[ 30 ] = KEY_VOLUMEDOWN,
-	[ 62 ] = KEY_VOLUMEUP,
-
-	[ 32 ] = KEY_TUNER,       // TV/FM
-	[ 16 ] = KEY_CD,
-	[  8 ] = KEY_VIDEO,
-	[  4 ] = KEY_AUDIO,
-	[ 12 ] = KEY_ZOOM,        // full screen
-	[  2 ] = KEY_INFO,        // preview
-	[ 42 ] = KEY_SEARCH,      // autoscan
-	[ 26 ] = KEY_STOP,        // freeze
-	[ 58 ] = KEY_RECORD,      // capture
-	[  6 ] = KEY_PLAY,        // unmarked
-	[ 46 ] = KEY_RED,         // unmarked
-	[ 14 ] = KEY_GREEN,       // unmarked
-
-	[ 33 ] = KEY_YELLOW,      // unmarked
-	[ 17 ] = KEY_CHANNELDOWN,
-	[ 49 ] = KEY_CHANNELUP,
-	[  1 ] = KEY_BLUE,        // unmarked
-};
-
-/* Matt Jesson <dvb@jesson.eclipse.co.uk */
-static IR_KEYTAB_TYPE ir_codes_avermedia_dvbt[IR_KEYTAB_SIZE] = {
-	[ 0x28 ] = KEY_KP0,         //'0' / 'enter'
-	[ 0x22 ] = KEY_KP1,         //'1'
-	[ 0x12 ] = KEY_KP2,         //'2' / 'up arrow'
-	[ 0x32 ] = KEY_KP3,         //'3'
-	[ 0x24 ] = KEY_KP4,         //'4' / 'left arrow'
-	[ 0x14 ] = KEY_KP5,         //'5'
-	[ 0x34 ] = KEY_KP6,         //'6' / 'right arrow'
-	[ 0x26 ] = KEY_KP7,         //'7'
-	[ 0x16 ] = KEY_KP8,         //'8' / 'down arrow'
-	[ 0x36 ] = KEY_KP9,         //'9'
-
-	[ 0x20 ] = KEY_LIST,        // 'source'
-	[ 0x10 ] = KEY_TEXT,        // 'teletext'
-	[ 0x00 ] = KEY_POWER,       // 'power'
-	[ 0x04 ] = KEY_AUDIO,       // 'audio'
-	[ 0x06 ] = KEY_ZOOM,        // 'full screen'
-	[ 0x18 ] = KEY_VIDEO,       // 'display'
-	[ 0x38 ] = KEY_SEARCH,      // 'loop'
-	[ 0x08 ] = KEY_INFO,        // 'preview'
-	[ 0x2a ] = KEY_REWIND,      // 'backward <<'
-	[ 0x1a ] = KEY_FASTFORWARD, // 'forward >>'
-	[ 0x3a ] = KEY_RECORD,      // 'capture'
-	[ 0x0a ] = KEY_MUTE,        // 'mute'
-	[ 0x2c ] = KEY_RECORD,      // 'record'
-	[ 0x1c ] = KEY_PAUSE,       // 'pause'
-	[ 0x3c ] = KEY_STOP,        // 'stop'
-	[ 0x0c ] = KEY_PLAY,        // 'play'
-	[ 0x2e ] = KEY_RED,         // 'red'
-	[ 0x01 ] = KEY_BLUE,        // 'blue' / 'cancel'
-	[ 0x0e ] = KEY_YELLOW,      // 'yellow' / 'ok'
-	[ 0x21 ] = KEY_GREEN,       // 'green'
-	[ 0x11 ] = KEY_CHANNELDOWN, // 'channel -'
-	[ 0x31 ] = KEY_CHANNELUP,   // 'channel +'
-	[ 0x1e ] = KEY_VOLUMEDOWN,  // 'volume -'
-	[ 0x3e ] = KEY_VOLUMEUP,    // 'volume +'
-};
-
-/* Attila Kondoros <attila.kondoros@chello.hu> */
-static IR_KEYTAB_TYPE ir_codes_apac_viewcomp[IR_KEYTAB_SIZE] = {
-
-	[  1 ] = KEY_KP1,
-	[  2 ] = KEY_KP2,
-	[  3 ] = KEY_KP3,
-	[  4 ] = KEY_KP4,
-	[  5 ] = KEY_KP5,
-	[  6 ] = KEY_KP6,
-	[  7 ] = KEY_KP7,
-	[  8 ] = KEY_KP8,
-	[  9 ] = KEY_KP9,
-	[  0 ] = KEY_KP0,
-	[ 23 ] = KEY_LAST,        // +100
-	[ 10 ] = KEY_LIST,        // recall
-
-
-	[ 28 ] = KEY_TUNER,       // TV/FM
-	[ 21 ] = KEY_SEARCH,      // scan
-	[ 18 ] = KEY_POWER,       // power
-	[ 31 ] = KEY_VOLUMEDOWN,  // vol up
-	[ 27 ] = KEY_VOLUMEUP,    // vol down
-	[ 30 ] = KEY_CHANNELDOWN, // chn up
-	[ 26 ] = KEY_CHANNELUP,   // chn down
-
-	[ 17 ] = KEY_VIDEO,       // video
-	[ 15 ] = KEY_ZOOM,        // full screen
-	[ 19 ] = KEY_MUTE,        // mute/unmute
-	[ 16 ] = KEY_TEXT,        // min
-
-	[ 13 ] = KEY_STOP,        // freeze
-	[ 14 ] = KEY_RECORD,      // record
-	[ 29 ] = KEY_PLAYPAUSE,   // stop
-	[ 25 ] = KEY_PLAY,        // play
-
-	[ 22 ] = KEY_GOTO,        // osd
-	[ 20 ] = KEY_REFRESH,     // default
-	[ 12 ] = KEY_KPPLUS,      // fine tune >>>>
-	[ 24 ] = KEY_KPMINUS      // fine tune <<<<
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* Ricardo Cerqueira <v4l@cerqueira.org> */
-/* Weird matching, since the remote has "uncommon" keys */
-
-static IR_KEYTAB_TYPE ir_codes_conceptronic[IR_KEYTAB_SIZE] = {
-
-	[ 30 ] = KEY_POWER,       // power
-	[ 7  ] = KEY_MEDIA,       // source
-	[ 28 ] = KEY_SEARCH,      // scan
-
-/* FIXME: duplicate keycodes?
- *
- * These four keys seem to share the same GPIO as CH+, CH-, <<< and >>>
- * The GPIO values are
- * 6397fb for both "Scan <" and "CH -",
- * 639ffb for "Scan >" and "CH+",
- * 6384fb for "Tune <" and "<<<",
- * 638cfb for "Tune >" and ">>>", regardless of the mask.
- *
- *	[ 23 ] = KEY_BACK,        // fm scan <<
- *	[ 31 ] = KEY_FORWARD,     // fm scan >>
- *
- *	[ 4  ] = KEY_LEFT,        // fm tuning <
- *	[ 12 ] = KEY_RIGHT,       // fm tuning >
- *
- * For now, these four keys are disabled. Pressing them will generate
- * the CH+/CH-/<<</>>> events
- */
-
-	[ 3  ] = KEY_TUNER,       // TV/FM
-
-	[ 0  ] = KEY_RECORD,
-	[ 8  ] = KEY_STOP,
-	[ 17 ] = KEY_PLAY,
-
-	[ 26 ] = KEY_PLAYPAUSE,   // freeze
-	[ 25 ] = KEY_ZOOM,        // zoom
-	[ 15 ] = KEY_TEXT,        // min
-
-	[ 1  ] = KEY_KP1,
-	[ 11 ] = KEY_KP2,
-	[ 27 ] = KEY_KP3,
-	[ 5  ] = KEY_KP4,
-	[ 9  ] = KEY_KP5,
-	[ 21 ] = KEY_KP6,
-	[ 6  ] = KEY_KP7,
-	[ 10 ] = KEY_KP8,
-	[ 18 ] = KEY_KP9,
-	[ 2  ] = KEY_KP0,
-	[ 16 ] = KEY_LAST,        // +100
-	[ 19 ] = KEY_LIST,        // recall
-
-	[ 31 ] = KEY_CHANNELUP,   // chn down
-	[ 23 ] = KEY_CHANNELDOWN, // chn up
-	[ 22 ] = KEY_VOLUMEUP,    // vol down
-	[ 20 ] = KEY_VOLUMEDOWN,  // vol up
-
-	[ 4  ] = KEY_KPMINUS,     // <<<
-	[ 14 ] = KEY_SETUP,       // function
-	[ 12 ] = KEY_KPPLUS,      // >>>
-
-	[ 13 ] = KEY_GOTO,        // mts
-	[ 29 ] = KEY_REFRESH,     // reset
-	[ 24 ] = KEY_MUTE         // mute/unmute
-};
-
-static IR_KEYTAB_TYPE ir_codes_nebula[IR_KEYTAB_SIZE] = {
-	[0x00] = KEY_KP0,
-	[0x01] = KEY_KP1,
-	[0x02] = KEY_KP2,
-	[0x03] = KEY_KP3,
-	[0x04] = KEY_KP4,
-	[0x05] = KEY_KP5,
-	[0x06] = KEY_KP6,
-	[0x07] = KEY_KP7,
-	[0x08] = KEY_KP8,
-	[0x09] = KEY_KP9,
-	[0x0a] = KEY_TV,
-	[0x0b] = KEY_AUX,
-	[0x0c] = KEY_DVD,
-	[0x0d] = KEY_POWER,
-	[0x0e] = KEY_MHP,	/* labelled 'Picture' */
-	[0x0f] = KEY_AUDIO,
-	[0x10] = KEY_INFO,
-	[0x11] = KEY_F13,	/* 16:9 */
-	[0x12] = KEY_F14,	/* 14:9 */
-	[0x13] = KEY_EPG,
-	[0x14] = KEY_EXIT,
-	[0x15] = KEY_MENU,
-	[0x16] = KEY_UP,
-	[0x17] = KEY_DOWN,
-	[0x18] = KEY_LEFT,
-	[0x19] = KEY_RIGHT,
-	[0x1a] = KEY_ENTER,
-	[0x1b] = KEY_CHANNELUP,
-	[0x1c] = KEY_CHANNELDOWN,
-	[0x1d] = KEY_VOLUMEUP,
-	[0x1e] = KEY_VOLUMEDOWN,
-	[0x1f] = KEY_RED,
-	[0x20] = KEY_GREEN,
-	[0x21] = KEY_YELLOW,
-	[0x22] = KEY_BLUE,
-	[0x23] = KEY_SUBTITLE,
-	[0x24] = KEY_F15,	/* AD */
-	[0x25] = KEY_TEXT,
-	[0x26] = KEY_MUTE,
-	[0x27] = KEY_REWIND,
-	[0x28] = KEY_STOP,
-	[0x29] = KEY_PLAY,
-	[0x2a] = KEY_FASTFORWARD,
-	[0x2b] = KEY_F16,	/* chapter */
-	[0x2c] = KEY_PAUSE,
-	[0x2d] = KEY_PLAY,
-	[0x2e] = KEY_RECORD,
-	[0x2f] = KEY_F17,	/* picture in picture */
-	[0x30] = KEY_KPPLUS,	/* zoom in */
-	[0x31] = KEY_KPMINUS,	/* zoom out */
-	[0x32] = KEY_F18,	/* capture */
-	[0x33] = KEY_F19,	/* web */
-	[0x34] = KEY_EMAIL,
-	[0x35] = KEY_PHONE,
-	[0x36] = KEY_PC
-};
-
-struct IR {
-	struct bttv_sub_device  *sub;
-	struct input_dev        *input;
-	struct ir_input_state   ir;
-	char                    name[32];
-	char                    phys[32];
-
-	/* Usual gpio signalling */
-
-	u32                     mask_keycode;
-	u32                     mask_keydown;
-	u32                     mask_keyup;
-	u32                     polling;
-	u32                     last_gpio;
-	struct work_struct      work;
-	struct timer_list       timer;
-
-	/* RC5 gpio */
-	u32 rc5_gpio;
-	struct timer_list timer_end;	/* timer_end for code completion */
-	struct timer_list timer_keyup;	/* timer_end for key release */
-	u32 last_rc5;			/* last good rc5 code */
-	u32 last_bit;			/* last raw bit seen */
-	u32 code;			/* raw code under construction */
-	struct timeval base_time;	/* time of last seen code */
-	int active;			/* building raw code */
-};
-
-static int debug;
-module_param(debug, int, 0644);    /* debug level (0,1,2) */
-static int repeat_delay = 500;
-module_param(repeat_delay, int, 0644);
-static int repeat_period = 33;
-module_param(repeat_period, int, 0644);
-
-#define DEVNAME "ir-kbd-gpio"
-#define dprintk(fmt, arg...)	if (debug) \
-	printk(KERN_DEBUG DEVNAME ": " fmt , ## arg)
-
-static void ir_irq(struct bttv_sub_device *sub);
-static int ir_probe(struct device *dev);
-static int ir_remove(struct device *dev);
-
-static struct bttv_sub_driver driver = {
-	.drv = {
-		.name	= DEVNAME,
-		.probe	= ir_probe,
-		.remove	= ir_remove,
-	},
-	.gpio_irq 	= ir_irq,
-};
-
-/* ---------------------------------------------------------------------- */
-
-static void ir_handle_key(struct IR *ir)
-{
-	u32 gpio,data;
-
-	/* read gpio value */
-	gpio = bttv_gpio_read(ir->sub->core);
-	if (ir->polling) {
-		if (ir->last_gpio == gpio)
-			return;
-		ir->last_gpio = gpio;
-	}
-
-	/* extract data */
-	data = ir_extract_bits(gpio, ir->mask_keycode);
-	dprintk(DEVNAME ": irq gpio=0x%x code=%d | %s%s%s\n",
-		gpio, data,
-		ir->polling               ? "poll"  : "irq",
-		(gpio & ir->mask_keydown) ? " down" : "",
-		(gpio & ir->mask_keyup)   ? " up"   : "");
-
-	if (ir->mask_keydown) {
-		/* bit set on keydown */
-		if (gpio & ir->mask_keydown) {
-			ir_input_keydown(ir->input, &ir->ir, data, data);
-		} else {
-			ir_input_nokey(ir->input, &ir->ir);
-		}
-
-	} else if (ir->mask_keyup) {
-		/* bit cleared on keydown */
-		if (0 == (gpio & ir->mask_keyup)) {
-			ir_input_keydown(ir->input, &ir->ir, data, data);
-		} else {
-			ir_input_nokey(ir->input, &ir->ir);
-		}
-
-	} else {
-		/* can't disturgissh keydown/up :-/ */
-		ir_input_keydown(ir->input, &ir->ir, data, data);
-		ir_input_nokey(ir->input, &ir->ir);
-	}
-}
-
-static void ir_irq(struct bttv_sub_device *sub)
-{
-	struct IR *ir = dev_get_drvdata(&sub->dev);
-
-	if (!ir->polling)
-		ir_handle_key(ir);
-}
-
-static void ir_timer(unsigned long data)
-{
-	struct IR *ir = (struct IR*)data;
-
-	schedule_work(&ir->work);
-}
-
-static void ir_work(void *data)
-{
-	struct IR *ir = data;
-	unsigned long timeout;
-
-	ir_handle_key(ir);
-	timeout = jiffies + (ir->polling * HZ / 1000);
-	mod_timer(&ir->timer, timeout);
-}
-
-/* ---------------------------------------------------------------*/
-
-static int rc5_remote_gap = 885;
-module_param(rc5_remote_gap, int, 0644);
-static int rc5_key_timeout = 200;
-module_param(rc5_key_timeout, int, 0644);
-
-#define RC5_START(x)	(((x)>>12)&3)
-#define RC5_TOGGLE(x)	(((x)>>11)&1)
-#define RC5_ADDR(x)	(((x)>>6)&31)
-#define RC5_INSTR(x)	((x)&63)
-
-/* decode raw bit pattern to RC5 code */
-static u32 rc5_decode(unsigned int code)
-{
-	unsigned int org_code = code;
-	unsigned int pair;
-	unsigned int rc5 = 0;
-	int i;
-
-	code = (code << 1) | 1;
-	for (i = 0; i < 14; ++i) {
-		pair = code & 0x3;
-		code >>= 2;
-
-		rc5 <<= 1;
-		switch (pair) {
-		case 0:
-		case 2:
-			break;
-		case 1:
-			rc5 |= 1;
-			break;
-		case 3:
-			dprintk("bad code: %x\n", org_code);
-			return 0;
-		}
-	}
-	dprintk("code=%x, rc5=%x, start=%x, toggle=%x, address=%x, "
-		"instr=%x\n", rc5, org_code, RC5_START(rc5),
-		RC5_TOGGLE(rc5), RC5_ADDR(rc5), RC5_INSTR(rc5));
-	return rc5;
-}
-
-static int ir_rc5_irq(struct bttv_sub_device *sub)
-{
-	struct IR *ir = dev_get_drvdata(&sub->dev);
-	struct timeval tv;
-	u32 gpio;
-	u32 gap;
-	unsigned long current_jiffies, timeout;
-
-	/* read gpio port */
-	gpio = bttv_gpio_read(ir->sub->core);
-
-	/* remote IRQ? */
-	if (!(gpio & 0x20))
-		return 0;
-
-	/* get time of bit */
-	current_jiffies = jiffies;
-	do_gettimeofday(&tv);
-
-	/* avoid overflow with gap >1s */
-	if (tv.tv_sec - ir->base_time.tv_sec > 1) {
-		gap = 200000;
-	} else {
-		gap = 1000000 * (tv.tv_sec - ir->base_time.tv_sec) +
-		    tv.tv_usec - ir->base_time.tv_usec;
-	}
-
-	/* active code => add bit */
-	if (ir->active) {
-		/* only if in the code (otherwise spurious IRQ or timer
-		   late) */
-		if (ir->last_bit < 28) {
-			ir->last_bit = (gap - rc5_remote_gap / 2) /
-			    rc5_remote_gap;
-			ir->code |= 1 << ir->last_bit;
-		}
-		/* starting new code */
-	} else {
-		ir->active = 1;
-		ir->code = 0;
-		ir->base_time = tv;
-		ir->last_bit = 0;
-
-		timeout = current_jiffies + (500 + 30 * HZ) / 1000;
-		mod_timer(&ir->timer_end, timeout);
-	}
-
-	/* toggle GPIO pin 4 to reset the irq */
-	bttv_gpio_write(ir->sub->core, gpio & ~(1 << 4));
-	bttv_gpio_write(ir->sub->core, gpio | (1 << 4));
-	return 1;
-}
-
-static void ir_rc5_timer_end(unsigned long data)
-{
-	struct IR *ir = (struct IR *)data;
-	struct timeval tv;
-	unsigned long current_jiffies, timeout;
-	u32 gap;
-
-	/* get time */
-	current_jiffies = jiffies;
-	do_gettimeofday(&tv);
-
-	/* avoid overflow with gap >1s */
-	if (tv.tv_sec - ir->base_time.tv_sec > 1) {
-		gap = 200000;
-	} else {
-		gap = 1000000 * (tv.tv_sec - ir->base_time.tv_sec) +
-		    tv.tv_usec - ir->base_time.tv_usec;
-	}
-
-	/* Allow some timmer jitter (RC5 is ~24ms anyway so this is ok) */
-	if (gap < 28000) {
-		dprintk("spurious timer_end\n");
-		return;
-	}
-
-	ir->active = 0;
-	if (ir->last_bit < 20) {
-		/* ignore spurious codes (caused by light/other remotes) */
-		dprintk("short code: %x\n", ir->code);
-	} else {
-		u32 rc5 = rc5_decode(ir->code);
-
-		/* two start bits? */
-		if (RC5_START(rc5) != 3) {
-			dprintk("rc5 start bits invalid: %u\n", RC5_START(rc5));
-
-			/* right address? */
-		} else if (RC5_ADDR(rc5) == 0x0) {
-			u32 toggle = RC5_TOGGLE(rc5);
-			u32 instr = RC5_INSTR(rc5);
-
-			/* Good code, decide if repeat/repress */
-			if (toggle != RC5_TOGGLE(ir->last_rc5) ||
-			    instr != RC5_INSTR(ir->last_rc5)) {
-				dprintk("instruction %x, toggle %x\n", instr,
-					toggle);
-				ir_input_nokey(ir->input, &ir->ir);
-				ir_input_keydown(ir->input, &ir->ir, instr,
-						 instr);
-			}
-
-			/* Set/reset key-up timer */
-			timeout = current_jiffies + (500 + rc5_key_timeout
-						     * HZ) / 1000;
-			mod_timer(&ir->timer_keyup, timeout);
-
-			/* Save code for repeat test */
-			ir->last_rc5 = rc5;
-		}
-	}
-}
-
-static void ir_rc5_timer_keyup(unsigned long data)
-{
-	struct IR *ir = (struct IR *)data;
-
-	dprintk("key released\n");
-	ir_input_nokey(ir->input, &ir->ir);
-}
-
-/* ---------------------------------------------------------------------- */
-
-static int ir_probe(struct device *dev)
-{
-	struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
-	struct IR *ir;
-	struct input_dev *input_dev;
-	IR_KEYTAB_TYPE *ir_codes = NULL;
-	int ir_type = IR_TYPE_OTHER;
-
-	ir = kzalloc(sizeof(*ir), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!ir || !input_dev) {
-		kfree(ir);
-		input_free_device(input_dev);
-		return -ENOMEM;
-	}
-
-	/* detect & configure */
-	switch (sub->core->type) {
-	case BTTV_BOARD_AVERMEDIA:
-	case BTTV_BOARD_AVPHONE98:
-	case BTTV_BOARD_AVERMEDIA98:
-		ir_codes         = ir_codes_avermedia;
-		ir->mask_keycode = 0xf88000;
-		ir->mask_keydown = 0x010000;
-		ir->polling      = 50; // ms
-		break;
-
-	case BTTV_BOARD_AVDVBT_761:
-	case BTTV_BOARD_AVDVBT_771:
-		ir_codes         = ir_codes_avermedia_dvbt;
-		ir->mask_keycode = 0x0f00c0;
-		ir->mask_keydown = 0x000020;
-		ir->polling      = 50; // ms
-		break;
-
-	case BTTV_BOARD_PXELVWPLTVPAK:
-		ir_codes         = ir_codes_pixelview;
-		ir->mask_keycode = 0x003e00;
-		ir->mask_keyup   = 0x010000;
-		ir->polling      = 50; // ms
-		break;
-	case BTTV_BOARD_PV_BT878P_9B:
-	case BTTV_BOARD_PV_BT878P_PLUS:
-		ir_codes         = ir_codes_pixelview;
-		ir->mask_keycode = 0x001f00;
-		ir->mask_keyup   = 0x008000;
-		ir->polling      = 50; // ms
-		break;
-
-	case BTTV_BOARD_WINFAST2000:
-		ir_codes         = ir_codes_winfast;
-		ir->mask_keycode = 0x1f8;
-		break;
-	case BTTV_BOARD_MAGICTVIEW061:
-	case BTTV_BOARD_MAGICTVIEW063:
-		ir_codes         = ir_codes_winfast;
-		ir->mask_keycode = 0x0008e000;
-		ir->mask_keydown = 0x00200000;
-		break;
-	case BTTV_BOARD_APAC_VIEWCOMP:
-		ir_codes         = ir_codes_apac_viewcomp;
-		ir->mask_keycode = 0x001f00;
-		ir->mask_keyup   = 0x008000;
-		ir->polling      = 50; // ms
-		break;
-	case BTTV_BOARD_CONCEPTRONIC_CTVFMI2:
-		ir_codes         = ir_codes_conceptronic;
-		ir->mask_keycode = 0x001F00;
-		ir->mask_keyup   = 0x006000;
-		ir->polling      = 50; // ms
-		break;
-	case BTTV_BOARD_NEBULA_DIGITV:
-		ir_codes = ir_codes_nebula;
-		driver.any_irq = ir_rc5_irq;
-		driver.gpio_irq = NULL;
-		ir->rc5_gpio = 1;
-		break;
-	}
-	if (NULL == ir_codes) {
-		kfree(ir);
-		input_free_device(input_dev);
-		return -ENODEV;
-	}
-
-	if (ir->rc5_gpio) {
-		u32 gpio;
-	    	/* enable remote irq */
-		bttv_gpio_inout(sub->core, (1 << 4), 1 << 4);
-		gpio = bttv_gpio_read(sub->core);
-		bttv_gpio_write(sub->core, gpio & ~(1 << 4));
-		bttv_gpio_write(sub->core, gpio | (1 << 4));
-	} else {
-		/* init hardware-specific stuff */
-		bttv_gpio_inout(sub->core, ir->mask_keycode | ir->mask_keydown, 0);
-	}
-
-	/* init input device */
-	snprintf(ir->name, sizeof(ir->name), "bttv IR (card=%d)",
-		 sub->core->type);
-	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
-		 pci_name(sub->core->pci));
-
-	ir->input = input_dev;
-	ir->sub = sub;
-	ir_input_init(input_dev, &ir->ir, ir_type, ir_codes);
-	input_dev->name = ir->name;
-	input_dev->phys = ir->phys;
-	input_dev->id.bustype = BUS_PCI;
-	input_dev->id.version = 1;
-	if (sub->core->pci->subsystem_vendor) {
-		input_dev->id.vendor  = sub->core->pci->subsystem_vendor;
-		input_dev->id.product = sub->core->pci->subsystem_device;
-	} else {
-		input_dev->id.vendor  = sub->core->pci->vendor;
-		input_dev->id.product = sub->core->pci->device;
-	}
-	input_dev->cdev.dev = &sub->core->pci->dev;
-
-	if (ir->polling) {
-		INIT_WORK(&ir->work, ir_work, ir);
-		init_timer(&ir->timer);
-		ir->timer.function = ir_timer;
-		ir->timer.data     = (unsigned long)ir;
-		schedule_work(&ir->work);
-	} else if (ir->rc5_gpio) {
-		/* set timer_end for code completion */
-		init_timer(&ir->timer_end);
-		ir->timer_end.function = ir_rc5_timer_end;
-		ir->timer_end.data = (unsigned long)ir;
-
-		init_timer(&ir->timer_keyup);
-		ir->timer_keyup.function = ir_rc5_timer_keyup;
-		ir->timer_keyup.data = (unsigned long)ir;
-	}
-
-	/* all done */
-	dev_set_drvdata(dev, ir);
-	input_register_device(ir->input);
-
-	/* the remote isn't as bouncy as a keyboard */
-	ir->input->rep[REP_DELAY] = repeat_delay;
-	ir->input->rep[REP_PERIOD] = repeat_period;
-
-	return 0;
-}
-
-static int ir_remove(struct device *dev)
-{
-	struct IR *ir = dev_get_drvdata(dev);
-
-	if (ir->polling) {
-		del_timer(&ir->timer);
-		flush_scheduled_work();
-	}
-
-	if (ir->rc5_gpio) {
-		u32 gpio;
-
-		del_timer(&ir->timer_end);
-		flush_scheduled_work();
-
-		gpio = bttv_gpio_read(ir->sub->core);
-		bttv_gpio_write(ir->sub->core, gpio & ~(1 << 4));
-	}
-
-	input_unregister_device(ir->input);
-	kfree(ir);
-	return 0;
-}
-
-/* ---------------------------------------------------------------------- */
-
-MODULE_AUTHOR("Gerd Knorr, Pavel Machek");
-MODULE_DESCRIPTION("input driver for bt8x8 gpio IR remote controls");
-MODULE_LICENSE("GPL");
-
-static int ir_init(void)
-{
-	return bttv_sub_register(&driver, "remote");
-}
-
-static void ir_fini(void)
-{
-	bttv_sub_unregister(&driver);
-}
-
-module_init(ir_init);
-module_exit(ir_fini);
-
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
--- git.orig/drivers/media/video/Makefile
+++ git/drivers/media/video/Makefile
@@ -3,7 +3,8 @@
 #
 
 bttv-objs	:=	bttv-driver.o bttv-cards.o bttv-if.o \
-			bttv-risc.o bttv-vbi.o bttv-i2c.o bttv-gpio.o
+			bttv-risc.o bttv-vbi.o bttv-i2c.o bttv-gpio.o \
+			bttv-input.o
 zoran-objs      :=	zr36120.o zr36120_i2c.o zr36120_mem.o
 zr36067-objs	:=	zoran_procfs.o zoran_device.o \
 			zoran_driver.o zoran_card.o
@@ -12,7 +13,7 @@ tuner-objs	:=	tuner-core.o tuner-simple.
 obj-$(CONFIG_VIDEO_DEV) += videodev.o v4l2-common.o v4l1-compat.o compat_ioctl32.o
 
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
-	tda7432.o tda9875.o ir-kbd-i2c.o ir-kbd-gpio.o
+	tda7432.o tda9875.o ir-kbd-i2c.o
 obj-$(CONFIG_SOUND_TVMIXER) += tvmixer.o
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o

--

