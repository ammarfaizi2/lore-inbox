Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966239AbWCTPON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966239AbWCTPON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966278AbWCTPOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:14:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966276AbWCTPOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:01 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Ricardo Cerqueira <v4l@cerqueira.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 003/141] V4L/DVB (3393): Move all IR keymaps to ir-common
	module
Date: Mon, 20 Mar 2006 12:08:37 -0300
Message-id: <20060320150837.PS573290000003@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Cerqueira <v4l@cerqueira.org>
Date: 1138016526 -0200

- All the keymaps have the same structure, and can be shared between different
chips, so it makes no sense having them scattered between the input files.
This aggregates them all at ir-common module.
- Added new Hauppauge remote (Hauppauge grey), contributed by J.O. Aho
  <trizt@iname.com> (with some small changes)
  Changed KEY_KPx (keypad numerals) references to KEY_x, to avoid problems
  when NumLock is off (suggested by Peter Missel <peter.missel@onlinehome.de>)
- Some cleanups at IR code

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/common/Makefile b/drivers/media/common/Makefile
diff --git a/drivers/media/common/Makefile b/drivers/media/common/Makefile
index bd458cb..61b8961 100644
--- a/drivers/media/common/Makefile
+++ b/drivers/media/common/Makefile
@@ -1,5 +1,6 @@
 saa7146-objs    := saa7146_i2c.o saa7146_core.o
 saa7146_vv-objs := saa7146_vv_ksyms.o saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o
+ir-common-objs  := ir-functions.o ir-keymaps.o
 
 obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o
 obj-$(CONFIG_VIDEO_SAA7146_VV) += saa7146_vv.o
diff --git a/drivers/media/common/ir-common.c b/drivers/media/common/ir-common.c
diff --git a/drivers/media/common/ir-common.c b/drivers/media/common/ir-common.c
deleted file mode 100644
index 97fa3fc..0000000
--- a/drivers/media/common/ir-common.c
+++ /dev/null
@@ -1,519 +0,0 @@
-/*
- *
- * some common structs and functions to handle infrared remotes via
- * input layer ...
- *
- * (c) 2003 Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/string.h>
-#include <media/ir-common.h>
-
-/* -------------------------------------------------------------------------- */
-
-MODULE_AUTHOR("Gerd Knorr <kraxel@bytesex.org> [SuSE Labs]");
-MODULE_LICENSE("GPL");
-
-static int repeat = 1;
-module_param(repeat, int, 0444);
-MODULE_PARM_DESC(repeat,"auto-repeat for IR keys (default: on)");
-
-static int debug = 0;    /* debug level (0,1,2) */
-module_param(debug, int, 0644);
-
-#define dprintk(level, fmt, arg...)	if (debug >= level) \
-	printk(KERN_DEBUG fmt , ## arg)
-
-/* -------------------------------------------------------------------------- */
-
-/* generic RC5 keytable                                          */
-/* see http://users.pandora.be/nenya/electronics/rc5/codes00.htm */
-/* used by old (black) Hauppauge remotes                         */
-IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE] = {
-	/* Keys 0 to 9 */
-	[ 0x00 ] = KEY_KP0,
-	[ 0x01 ] = KEY_KP1,
-	[ 0x02 ] = KEY_KP2,
-	[ 0x03 ] = KEY_KP3,
-	[ 0x04 ] = KEY_KP4,
-	[ 0x05 ] = KEY_KP5,
-	[ 0x06 ] = KEY_KP6,
-	[ 0x07 ] = KEY_KP7,
-	[ 0x08 ] = KEY_KP8,
-	[ 0x09 ] = KEY_KP9,
-
-	[ 0x0b ] = KEY_CHANNEL,		/* channel / program (japan: 11) */
-	[ 0x0c ] = KEY_POWER,		/* standby */
-	[ 0x0d ] = KEY_MUTE,		/* mute / demute */
-	[ 0x0f ] = KEY_TV,		/* display */
-	[ 0x10 ] = KEY_VOLUMEUP,
-	[ 0x11 ] = KEY_VOLUMEDOWN,
-	[ 0x12 ] = KEY_BRIGHTNESSUP,
-	[ 0x13 ] = KEY_BRIGHTNESSDOWN,
-	[ 0x1e ] = KEY_SEARCH,		/* search + */
-	[ 0x20 ] = KEY_CHANNELUP,	/* channel / program + */
-	[ 0x21 ] = KEY_CHANNELDOWN,	/* channel / program - */
-	[ 0x22 ] = KEY_CHANNEL,		/* alt / channel */
-	[ 0x23 ] = KEY_LANGUAGE,	/* 1st / 2nd language */
-	[ 0x26 ] = KEY_SLEEP,		/* sleeptimer */
-	[ 0x2e ] = KEY_MENU,		/* 2nd controls (USA: menu) */
-	[ 0x30 ] = KEY_PAUSE,
-	[ 0x32 ] = KEY_REWIND,
-	[ 0x33 ] = KEY_GOTO,
-	[ 0x35 ] = KEY_PLAY,
-	[ 0x36 ] = KEY_STOP,
-	[ 0x37 ] = KEY_RECORD,		/* recording */
-	[ 0x3c ] = KEY_TEXT,    	/* teletext submode (Japan: 12) */
-	[ 0x3d ] = KEY_SUSPEND,		/* system standby */
-
-};
-EXPORT_SYMBOL_GPL(ir_codes_rc5_tv);
-
-/* Table for Leadtek Winfast Remote Controls - used by both bttv and cx88 */
-IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE] = {
-	/* Keys 0 to 9 */
-	[ 18 ] = KEY_KP0,
-	[  5 ] = KEY_KP1,
-	[  6 ] = KEY_KP2,
-	[  7 ] = KEY_KP3,
-	[  9 ] = KEY_KP4,
-	[ 10 ] = KEY_KP5,
-	[ 11 ] = KEY_KP6,
-	[ 13 ] = KEY_KP7,
-	[ 14 ] = KEY_KP8,
-	[ 15 ] = KEY_KP9,
-
-	[  0 ] = KEY_POWER,
-	[  2 ] = KEY_TUNER,		/* TV/FM */
-	[ 30 ] = KEY_VIDEO,
-	[  4 ] = KEY_VOLUMEUP,
-	[  8 ] = KEY_VOLUMEDOWN,
-	[ 12 ] = KEY_CHANNELUP,
-	[ 16 ] = KEY_CHANNELDOWN,
-	[  3 ] = KEY_ZOOM,		/* fullscreen */
-	[ 31 ] = KEY_SUBTITLE,		/* closed caption/teletext */
-	[ 32 ] = KEY_SLEEP,
-	[ 20 ] = KEY_MUTE,
-	[ 43 ] = KEY_RED,
-	[ 44 ] = KEY_GREEN,
-	[ 45 ] = KEY_YELLOW,
-	[ 46 ] = KEY_BLUE,
-	[ 24 ] = KEY_KPPLUS,		/* fine tune + */
-	[ 25 ] = KEY_KPMINUS,		/* fine tune - */
-	[ 33 ] = KEY_KPDOT,
-	[ 19 ] = KEY_KPENTER,
-	[ 34 ] = KEY_BACK,
-	[ 35 ] = KEY_PLAYPAUSE,
-	[ 36 ] = KEY_NEXT,
-	[ 38 ] = KEY_STOP,
-	[ 39 ] = KEY_RECORD
-};
-EXPORT_SYMBOL_GPL(ir_codes_winfast);
-
-IR_KEYTAB_TYPE ir_codes_pinnacle[IR_KEYTAB_SIZE] = {
-	[ 0x59 ] = KEY_MUTE,
-	[ 0x4a ] = KEY_POWER,
-
-	[ 0x18 ] = KEY_TEXT,
-	[ 0x26 ] = KEY_TV,
-	[ 0x3d ] = KEY_PRINT,
-
-	[ 0x48 ] = KEY_RED,
-	[ 0x04 ] = KEY_GREEN,
-	[ 0x11 ] = KEY_YELLOW,
-	[ 0x00 ] = KEY_BLUE,
-
-	[ 0x2d ] = KEY_VOLUMEUP,
-	[ 0x1e ] = KEY_VOLUMEDOWN,
-
-	[ 0x49 ] = KEY_MENU,
-
-	[ 0x16 ] = KEY_CHANNELUP,
-	[ 0x17 ] = KEY_CHANNELDOWN,
-
-	[ 0x20 ] = KEY_UP,
-	[ 0x21 ] = KEY_DOWN,
-	[ 0x22 ] = KEY_LEFT,
-	[ 0x23 ] = KEY_RIGHT,
-	[ 0x0d ] = KEY_SELECT,
-
-
-
-	[ 0x08 ] = KEY_BACK,
-	[ 0x07 ] = KEY_REFRESH,
-
-	[ 0x2f ] = KEY_ZOOM,
-	[ 0x29 ] = KEY_RECORD,
-
-	[ 0x4b ] = KEY_PAUSE,
-	[ 0x4d ] = KEY_REWIND,
-	[ 0x2e ] = KEY_PLAY,
-	[ 0x4e ] = KEY_FORWARD,
-	[ 0x53 ] = KEY_PREVIOUS,
-	[ 0x4c ] = KEY_STOP,
-	[ 0x54 ] = KEY_NEXT,
-
-	[ 0x69 ] = KEY_KP0,
-	[ 0x6a ] = KEY_KP1,
-	[ 0x6b ] = KEY_KP2,
-	[ 0x6c ] = KEY_KP3,
-	[ 0x6d ] = KEY_KP4,
-	[ 0x6e ] = KEY_KP5,
-	[ 0x6f ] = KEY_KP6,
-	[ 0x70 ] = KEY_KP7,
-	[ 0x71 ] = KEY_KP8,
-	[ 0x72 ] = KEY_KP9,
-
-	[ 0x74 ] = KEY_CHANNEL,
-	[ 0x0a ] = KEY_BACKSPACE,
-};
-
-EXPORT_SYMBOL_GPL(ir_codes_pinnacle);
-
-/* empty keytable, can be used as placeholder for not-yet created keytables */
-IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE] = {
-	[ 42 ] = KEY_COFFEE,
-};
-EXPORT_SYMBOL_GPL(ir_codes_empty);
-
-/* Hauppauge: the newer, gray remotes (seems there are multiple
- * slightly different versions), shipped with cx88+ivtv cards.
- * almost rc5 coding, but some non-standard keys */
-IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE] = {
-	/* Keys 0 to 9 */
-	[ 0x00 ] = KEY_KP0,
-	[ 0x01 ] = KEY_KP1,
-	[ 0x02 ] = KEY_KP2,
-	[ 0x03 ] = KEY_KP3,
-	[ 0x04 ] = KEY_KP4,
-	[ 0x05 ] = KEY_KP5,
-	[ 0x06 ] = KEY_KP6,
-	[ 0x07 ] = KEY_KP7,
-	[ 0x08 ] = KEY_KP8,
-	[ 0x09 ] = KEY_KP9,
-
-	[ 0x0a ] = KEY_TEXT,      	/* keypad asterisk as well */
-	[ 0x0b ] = KEY_RED,		/* red button */
-	[ 0x0c ] = KEY_RADIO,
-	[ 0x0d ] = KEY_MENU,
-	[ 0x0e ] = KEY_SUBTITLE,	/* also the # key */
-	[ 0x0f ] = KEY_MUTE,
-	[ 0x10 ] = KEY_VOLUMEUP,
-	[ 0x11 ] = KEY_VOLUMEDOWN,
-	[ 0x12 ] = KEY_PREVIOUS,	/* previous channel */
-	[ 0x14 ] = KEY_UP,
-	[ 0x15 ] = KEY_DOWN,
-	[ 0x16 ] = KEY_LEFT,
-	[ 0x17 ] = KEY_RIGHT,
-	[ 0x18 ] = KEY_VIDEO,		/* Videos */
-	[ 0x19 ] = KEY_AUDIO,		/* Music */
-	/* 0x1a: Pictures - presume this means
-	   "Multimedia Home Platform" -
-	   no "PICTURES" key in input.h
-	 */
-	[ 0x1a ] = KEY_MHP,
-
-	[ 0x1b ] = KEY_EPG,		/* Guide */
-	[ 0x1c ] = KEY_TV,
-	[ 0x1e ] = KEY_NEXTSONG,	/* skip >| */
-	[ 0x1f ] = KEY_EXIT,		/* back/exit */
-	[ 0x20 ] = KEY_CHANNELUP,	/* channel / program + */
-	[ 0x21 ] = KEY_CHANNELDOWN,	/* channel / program - */
-	[ 0x22 ] = KEY_CHANNEL,		/* source (old black remote) */
-	[ 0x24 ] = KEY_PREVIOUSSONG,	/* replay |< */
-	[ 0x25 ] = KEY_ENTER,		/* OK */
-	[ 0x26 ] = KEY_SLEEP,		/* minimize (old black remote) */
-	[ 0x29 ] = KEY_BLUE,		/* blue key */
-	[ 0x2e ] = KEY_GREEN,		/* green button */
-	[ 0x30 ] = KEY_PAUSE,		/* pause */
-	[ 0x32 ] = KEY_REWIND,		/* backward << */
-	[ 0x34 ] = KEY_FASTFORWARD,	/* forward >> */
-	[ 0x35 ] = KEY_PLAY,
-	[ 0x36 ] = KEY_STOP,
-	[ 0x37 ] = KEY_RECORD,		/* recording */
-	[ 0x38 ] = KEY_YELLOW,		/* yellow key */
-	[ 0x3b ] = KEY_SELECT,		/* top right button */
-	[ 0x3c ] = KEY_ZOOM,		/* full */
-	[ 0x3d ] = KEY_POWER,		/* system power (green button) */
-};
-EXPORT_SYMBOL(ir_codes_hauppauge_new);
-
-IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE] = {
-	[  2 ] = KEY_KP0,
-	[  1 ] = KEY_KP1,
-	[ 11 ] = KEY_KP2,
-	[ 27 ] = KEY_KP3,
-	[  5 ] = KEY_KP4,
-	[  9 ] = KEY_KP5,
-	[ 21 ] = KEY_KP6,
-	[  6 ] = KEY_KP7,
-	[ 10 ] = KEY_KP8,
-	[ 18 ] = KEY_KP9,
-
-	[  3 ] = KEY_TUNER,		/* TV/FM */
-	[  7 ] = KEY_SEARCH,		/* scan */
-	[ 28 ] = KEY_ZOOM,		/* full screen */
-	[ 30 ] = KEY_POWER,
-	[ 23 ] = KEY_VOLUMEDOWN,
-	[ 31 ] = KEY_VOLUMEUP,
-	[ 20 ] = KEY_CHANNELDOWN,
-	[ 22 ] = KEY_CHANNELUP,
-	[ 24 ] = KEY_MUTE,
-
-	[  0 ] = KEY_LIST,		/* source */
-	[ 19 ] = KEY_INFO,		/* loop */
-	[ 16 ] = KEY_LAST,		/* +100 */
-	[ 13 ] = KEY_CLEAR,		/* reset */
-	[ 12 ] = BTN_RIGHT,		/* fun++ */
-	[  4 ] = BTN_LEFT,		/* fun-- */
-	[ 14 ] = KEY_GOTO,		/* function */
-	[ 15 ] = KEY_STOP,		/* freeze */
-};
-EXPORT_SYMBOL(ir_codes_pixelview);
-
-/* -------------------------------------------------------------------------- */
-
-static void ir_input_key_event(struct input_dev *dev, struct ir_input_state *ir)
-{
-	if (KEY_RESERVED == ir->keycode) {
-		printk(KERN_INFO "%s: unknown key: key=0x%02x raw=0x%02x down=%d\n",
-		       dev->name,ir->ir_key,ir->ir_raw,ir->keypressed);
-		return;
-	}
-	dprintk(1,"%s: key event code=%d down=%d\n",
-		dev->name,ir->keycode,ir->keypressed);
-	input_report_key(dev,ir->keycode,ir->keypressed);
-	input_sync(dev);
-}
-
-/* -------------------------------------------------------------------------- */
-
-void ir_input_init(struct input_dev *dev, struct ir_input_state *ir,
-		   int ir_type, IR_KEYTAB_TYPE *ir_codes)
-{
-	int i;
-
-	ir->ir_type = ir_type;
-	if (ir_codes)
-		memcpy(ir->ir_codes, ir_codes, sizeof(ir->ir_codes));
-
-
-	dev->keycode     = ir->ir_codes;
-	dev->keycodesize = sizeof(IR_KEYTAB_TYPE);
-	dev->keycodemax  = IR_KEYTAB_SIZE;
-	for (i = 0; i < IR_KEYTAB_SIZE; i++)
-		set_bit(ir->ir_codes[i], dev->keybit);
-	clear_bit(0, dev->keybit);
-
-	set_bit(EV_KEY, dev->evbit);
-	if (repeat)
-		set_bit(EV_REP, dev->evbit);
-}
-
-void ir_input_nokey(struct input_dev *dev, struct ir_input_state *ir)
-{
-	if (ir->keypressed) {
-		ir->keypressed = 0;
-		ir_input_key_event(dev,ir);
-	}
-}
-
-void ir_input_keydown(struct input_dev *dev, struct ir_input_state *ir,
-		      u32 ir_key, u32 ir_raw)
-{
-	u32 keycode = IR_KEYCODE(ir->ir_codes, ir_key);
-
-	if (ir->keypressed && ir->keycode != keycode) {
-		ir->keypressed = 0;
-		ir_input_key_event(dev,ir);
-	}
-	if (!ir->keypressed) {
-		ir->ir_key  = ir_key;
-		ir->ir_raw  = ir_raw;
-		ir->keycode = keycode;
-		ir->keypressed = 1;
-		ir_input_key_event(dev,ir);
-	}
-}
-
-/* -------------------------------------------------------------------------- */
-
-u32 ir_extract_bits(u32 data, u32 mask)
-{
-	int mbit, vbit;
-	u32 value;
-
-	value = 0;
-	vbit  = 0;
-	for (mbit = 0; mbit < 32; mbit++) {
-		if (!(mask & ((u32)1 << mbit)))
-			continue;
-		if (data & ((u32)1 << mbit))
-			value |= (1 << vbit);
-		vbit++;
-	}
-	return value;
-}
-
-static int inline getbit(u32 *samples, int bit)
-{
-	return (samples[bit/32] & (1 << (31-(bit%32)))) ? 1 : 0;
-}
-
-/* sump raw samples for visual debugging ;) */
-int ir_dump_samples(u32 *samples, int count)
-{
-	int i, bit, start;
-
-	printk(KERN_DEBUG "ir samples: ");
-	start = 0;
-	for (i = 0; i < count * 32; i++) {
-		bit = getbit(samples,i);
-		if (bit)
-			start = 1;
-		if (0 == start)
-			continue;
-		printk("%s", bit ? "#" : "_");
-	}
-	printk("\n");
-	return 0;
-}
-
-/* decode raw samples, pulse distance coding used by NEC remotes */
-int ir_decode_pulsedistance(u32 *samples, int count, int low, int high)
-{
-	int i,last,bit,len;
-	u32 curBit;
-	u32 value;
-
-	/* find start burst */
-	for (i = len = 0; i < count * 32; i++) {
-		bit = getbit(samples,i);
-		if (bit) {
-			len++;
-		} else {
-			if (len >= 29)
-				break;
-			len = 0;
-		}
-	}
-
-	/* start burst to short */
-	if (len < 29)
-		return 0xffffffff;
-
-	/* find start silence */
-	for (len = 0; i < count * 32; i++) {
-		bit = getbit(samples,i);
-		if (bit) {
-			break;
-		} else {
-			len++;
-		}
-	}
-
-	/* silence to short */
-	if (len < 7)
-		return 0xffffffff;
-
-	/* go decoding */
-	len   = 0;
-	last = 1;
-	value = 0; curBit = 1;
-	for (; i < count * 32; i++) {
-		bit  = getbit(samples,i);
-		if (last) {
-			if(bit) {
-				continue;
-			} else {
-				len = 1;
-			}
-		} else {
-			if (bit) {
-				if (len > (low + high) /2)
-					value |= curBit;
-				curBit <<= 1;
-				if (curBit == 1)
-					break;
-			} else {
-				len++;
-			}
-		}
-		last = bit;
-	}
-
-	return value;
-}
-
-/* decode raw samples, biphase coding, used by rc5 for example */
-int ir_decode_biphase(u32 *samples, int count, int low, int high)
-{
-	int i,last,bit,len,flips;
-	u32 value;
-
-	/* find start bit (1) */
-	for (i = 0; i < 32; i++) {
-		bit = getbit(samples,i);
-		if (bit)
-			break;
-	}
-
-	/* go decoding */
-	len   = 0;
-	flips = 0;
-	value = 1;
-	for (; i < count * 32; i++) {
-		if (len > high)
-			break;
-		if (flips > 1)
-			break;
-		last = bit;
-		bit  = getbit(samples,i);
-		if (last == bit) {
-			len++;
-			continue;
-		}
-		if (len < low) {
-			len++;
-			flips++;
-			continue;
-		}
-		value <<= 1;
-		value |= bit;
-		flips = 0;
-		len   = 1;
-	}
-	return value;
-}
-
-EXPORT_SYMBOL_GPL(ir_input_init);
-EXPORT_SYMBOL_GPL(ir_input_nokey);
-EXPORT_SYMBOL_GPL(ir_input_keydown);
-
-EXPORT_SYMBOL_GPL(ir_extract_bits);
-EXPORT_SYMBOL_GPL(ir_dump_samples);
-EXPORT_SYMBOL_GPL(ir_decode_biphase);
-EXPORT_SYMBOL_GPL(ir_decode_pulsedistance);
-
-/*
- * Local variables:
- * c-basic-offset: 8
- * End:
- */
-
diff --git a/drivers/media/common/ir-keymaps.c b/drivers/media/common/ir-keymaps.c
diff --git a/drivers/media/common/ir-keymaps.c b/drivers/media/common/ir-keymaps.c
new file mode 100644
index 0000000..468f660
--- /dev/null
+++ b/drivers/media/common/ir-keymaps.c
@@ -0,0 +1,1537 @@
+/*
+
+
+    Keytables for supported remote controls. This file is part of
+    video4linux.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+ */
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+
+#include <linux/input.h>
+#include <media/ir-common.h>
+
+/* empty keytable, can be used as placeholder for not-yet created keytables */
+IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE] = {
+	[ 0x2a ] = KEY_COFFEE,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_empty);
+
+IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {
+	[ 0x22 ] = KEY_0,
+	[ 0x28 ] = KEY_1,
+	[ 0x18 ] = KEY_2,
+	[ 0x38 ] = KEY_3,
+	[ 0x24 ] = KEY_4,
+	[ 0x14 ] = KEY_5,
+	[ 0x34 ] = KEY_6,
+	[ 0x2c ] = KEY_7,
+	[ 0x1c ] = KEY_8,
+	[ 0x3c ] = KEY_9,
+
+	[ 0x30 ] = KEY_EJECTCD,     // Unmarked on my controller
+	[ 0x00 ] = KEY_POWER,
+	[ 0x12 ] = BTN_LEFT,        // DISPLAY/L
+	[ 0x32 ] = BTN_RIGHT,       // LOOP/R
+	[ 0x0a ] = KEY_MUTE,
+	[ 0x26 ] = KEY_RECORD,
+	[ 0x16 ] = KEY_PAUSE,
+	[ 0x36 ] = KEY_STOP,
+	[ 0x1e ] = KEY_VOLUMEDOWN,
+	[ 0x3e ] = KEY_VOLUMEUP,
+
+	[ 0x20 ] = KEY_TUNER,       // TV/FM
+	[ 0x10 ] = KEY_CD,
+	[ 0x08 ] = KEY_VIDEO,
+	[ 0x04 ] = KEY_AUDIO,
+	[ 0x0c ] = KEY_ZOOM,        // full screen
+	[ 0x02 ] = KEY_INFO,        // preview
+	[ 0x2a ] = KEY_SEARCH,      // autoscan
+	[ 0x1a ] = KEY_STOP,        // freeze
+	[ 0x3a ] = KEY_RECORD,      // capture
+	[ 0x06 ] = KEY_PLAY,        // unmarked
+	[ 0x2e ] = KEY_RED,         // unmarked
+	[ 0x0e ] = KEY_GREEN,       // unmarked
+
+	[ 0x21 ] = KEY_YELLOW,      // unmarked
+	[ 0x11 ] = KEY_CHANNELDOWN,
+	[ 0x31 ] = KEY_CHANNELUP,
+	[ 0x01 ] = KEY_BLUE,        // unmarked
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_avermedia);
+
+/* Matt Jesson <dvb@jesson.eclipse.co.uk */
+IR_KEYTAB_TYPE ir_codes_avermedia_dvbt[IR_KEYTAB_SIZE] = {
+	[ 0x28 ] = KEY_0,         //'0' / 'enter'
+	[ 0x22 ] = KEY_1,         //'1'
+	[ 0x12 ] = KEY_2,         //'2' / 'up arrow'
+	[ 0x32 ] = KEY_3,         //'3'
+	[ 0x24 ] = KEY_4,         //'4' / 'left arrow'
+	[ 0x14 ] = KEY_5,         //'5'
+	[ 0x34 ] = KEY_6,         //'6' / 'right arrow'
+	[ 0x26 ] = KEY_7,         //'7'
+	[ 0x16 ] = KEY_8,         //'8' / 'down arrow'
+	[ 0x36 ] = KEY_9,         //'9'
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
+EXPORT_SYMBOL_GPL(ir_codes_avermedia_dvbt);
+
+/* Attila Kondoros <attila.kondoros@chello.hu> */
+IR_KEYTAB_TYPE ir_codes_apac_viewcomp[IR_KEYTAB_SIZE] = {
+
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+	[ 0x00 ] = KEY_0,
+	[ 0x17 ] = KEY_LAST,        // +100
+	[ 0x0a ] = KEY_LIST,        // recall
+
+
+	[ 0x1c ] = KEY_TUNER,       // TV/FM
+	[ 0x15 ] = KEY_SEARCH,      // scan
+	[ 0x12 ] = KEY_POWER,       // power
+	[ 0x1f ] = KEY_VOLUMEDOWN,  // vol up
+	[ 0x1b ] = KEY_VOLUMEUP,    // vol down
+	[ 0x1e ] = KEY_CHANNELDOWN, // chn up
+	[ 0x1a ] = KEY_CHANNELUP,   // chn down
+
+	[ 0x11 ] = KEY_VIDEO,       // video
+	[ 0x0f ] = KEY_ZOOM,        // full screen
+	[ 0x13 ] = KEY_MUTE,        // mute/unmute
+	[ 0x10 ] = KEY_TEXT,        // min
+
+	[ 0x0d ] = KEY_STOP,        // freeze
+	[ 0x0e ] = KEY_RECORD,      // record
+	[ 0x1d ] = KEY_PLAYPAUSE,   // stop
+	[ 0x19 ] = KEY_PLAY,        // play
+
+	[ 0x16 ] = KEY_GOTO,        // osd
+	[ 0x14 ] = KEY_REFRESH,     // default
+	[ 0x0c ] = KEY_KPPLUS,      // fine tune >>>>
+	[ 0x18 ] = KEY_KPMINUS      // fine tune <<<<
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_apac_viewcomp);
+
+/* ---------------------------------------------------------------------- */
+
+IR_KEYTAB_TYPE ir_codes_conceptronic[IR_KEYTAB_SIZE] = {
+
+	[ 0x1e ] = KEY_POWER,       // power
+	[ 0x07 ] = KEY_MEDIA,       // source
+	[ 0x1c ] = KEY_SEARCH,      // scan
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
+ *	[ 0x17 ] = KEY_BACK,        // fm scan <<
+ *	[ 0x1f ] = KEY_FORWARD,     // fm scan >>
+ *
+ *	[ 0x04 ] = KEY_LEFT,        // fm tuning <
+ *	[ 0x0c ] = KEY_RIGHT,       // fm tuning >
+ *
+ * For now, these four keys are disabled. Pressing them will generate
+ * the CH+/CH-/<<</>>> events
+ */
+
+	[ 0x03 ] = KEY_TUNER,       // TV/FM
+
+	[ 0x00 ] = KEY_RECORD,
+	[ 0x08 ] = KEY_STOP,
+	[ 0x11 ] = KEY_PLAY,
+
+	[ 0x1a ] = KEY_PLAYPAUSE,   // freeze
+	[ 0x19 ] = KEY_ZOOM,        // zoom
+	[ 0x0f ] = KEY_TEXT,        // min
+
+	[ 0x01 ] = KEY_1,
+	[ 0x0b ] = KEY_2,
+	[ 0x1b ] = KEY_3,
+	[ 0x05 ] = KEY_4,
+	[ 0x09 ] = KEY_5,
+	[ 0x15 ] = KEY_6,
+	[ 0x06 ] = KEY_7,
+	[ 0x0a ] = KEY_8,
+	[ 0x12 ] = KEY_9,
+	[ 0x02 ] = KEY_0,
+	[ 0x10 ] = KEY_LAST,        // +100
+	[ 0x13 ] = KEY_LIST,        // recall
+
+	[ 0x1f ] = KEY_CHANNELUP,   // chn down
+	[ 0x17 ] = KEY_CHANNELDOWN, // chn up
+	[ 0x16 ] = KEY_VOLUMEUP,    // vol down
+	[ 0x14 ] = KEY_VOLUMEDOWN,  // vol up
+
+	[ 0x04 ] = KEY_KPMINUS,     // <<<
+	[ 0x0e ] = KEY_SETUP,       // function
+	[ 0x0c ] = KEY_KPPLUS,      // >>>
+
+	[ 0x0d ] = KEY_GOTO,        // mts
+	[ 0x1d ] = KEY_REFRESH,     // reset
+	[ 0x18 ] = KEY_MUTE         // mute/unmute
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_conceptronic);
+
+IR_KEYTAB_TYPE ir_codes_nebula[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+	[ 0x0a ] = KEY_TV,
+	[ 0x0b ] = KEY_AUX,
+	[ 0x0c ] = KEY_DVD,
+	[ 0x0d ] = KEY_POWER,
+	[ 0x0e ] = KEY_MHP,	/* labelled 'Picture' */
+	[ 0x0f ] = KEY_AUDIO,
+	[ 0x10 ] = KEY_INFO,
+	[ 0x11 ] = KEY_F13,	/* 16:9 */
+	[ 0x12 ] = KEY_F14,	/* 14:9 */
+	[ 0x13 ] = KEY_EPG,
+	[ 0x14 ] = KEY_EXIT,
+	[ 0x15 ] = KEY_MENU,
+	[ 0x16 ] = KEY_UP,
+	[ 0x17 ] = KEY_DOWN,
+	[ 0x18 ] = KEY_LEFT,
+	[ 0x19 ] = KEY_RIGHT,
+	[ 0x1a ] = KEY_ENTER,
+	[ 0x1b ] = KEY_CHANNELUP,
+	[ 0x1c ] = KEY_CHANNELDOWN,
+	[ 0x1d ] = KEY_VOLUMEUP,
+	[ 0x1e ] = KEY_VOLUMEDOWN,
+	[ 0x1f ] = KEY_RED,
+	[ 0x20 ] = KEY_GREEN,
+	[ 0x21 ] = KEY_YELLOW,
+	[ 0x22 ] = KEY_BLUE,
+	[ 0x23 ] = KEY_SUBTITLE,
+	[ 0x24 ] = KEY_F15,	/* AD */
+	[ 0x25 ] = KEY_TEXT,
+	[ 0x26 ] = KEY_MUTE,
+	[ 0x27 ] = KEY_REWIND,
+	[ 0x28 ] = KEY_STOP,
+	[ 0x29 ] = KEY_PLAY,
+	[ 0x2a ] = KEY_FASTFORWARD,
+	[ 0x2b ] = KEY_F16,	/* chapter */
+	[ 0x2c ] = KEY_PAUSE,
+	[ 0x2d ] = KEY_PLAY,
+	[ 0x2e ] = KEY_RECORD,
+	[ 0x2f ] = KEY_F17,	/* picture in picture */
+	[ 0x30 ] = KEY_KPPLUS,	/* zoom in */
+	[ 0x31 ] = KEY_KPMINUS,	/* zoom out */
+	[ 0x32 ] = KEY_F18,	/* capture */
+	[ 0x33 ] = KEY_F19,	/* web */
+	[ 0x34 ] = KEY_EMAIL,
+	[ 0x35 ] = KEY_PHONE,
+	[ 0x36 ] = KEY_PC
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_nebula);
+
+/* DigitalNow DNTV Live DVB-T Remote */
+IR_KEYTAB_TYPE ir_codes_dntv_live_dvb_t[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_ESC,		/* 'go up a level?' */
+	/* Keys 0 to 9 */
+	[ 0x0a ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x0b ] = KEY_TUNER,		/* tv/fm */
+	[ 0x0c ] = KEY_SEARCH,		/* scan */
+	[ 0x0d ] = KEY_STOP,
+	[ 0x0e ] = KEY_PAUSE,
+	[ 0x0f ] = KEY_LIST,		/* source */
+
+	[ 0x10 ] = KEY_MUTE,
+	[ 0x11 ] = KEY_REWIND,		/* backward << */
+	[ 0x12 ] = KEY_POWER,
+	[ 0x13 ] = KEY_S,			/* snap */
+	[ 0x14 ] = KEY_AUDIO,		/* stereo */
+	[ 0x15 ] = KEY_CLEAR,		/* reset */
+	[ 0x16 ] = KEY_PLAY,
+	[ 0x17 ] = KEY_ENTER,
+	[ 0x18 ] = KEY_ZOOM,		/* full screen */
+	[ 0x19 ] = KEY_FASTFORWARD,	/* forward >> */
+	[ 0x1a ] = KEY_CHANNELUP,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x1c ] = KEY_INFO,		/* preview */
+	[ 0x1d ] = KEY_RECORD,		/* record */
+	[ 0x1e ] = KEY_CHANNELDOWN,
+	[ 0x1f ] = KEY_VOLUMEDOWN,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_dntv_live_dvb_t);
+
+/* ---------------------------------------------------------------------- */
+
+/* IO-DATA BCTV7E Remote */
+IR_KEYTAB_TYPE ir_codes_iodata_bctv7e[IR_KEYTAB_SIZE] = {
+	[ 0x40 ] = KEY_TV,
+	[ 0x20 ] = KEY_RADIO,		/* FM */
+	[ 0x60 ] = KEY_EPG,
+	[ 0x00 ] = KEY_POWER,
+
+	/* Keys 0 to 9 */
+	[ 0x44 ] = KEY_0,		/* 10 */
+	[ 0x50 ] = KEY_1,
+	[ 0x30 ] = KEY_2,
+	[ 0x70 ] = KEY_3,
+	[ 0x48 ] = KEY_4,
+	[ 0x28 ] = KEY_5,
+	[ 0x68 ] = KEY_6,
+	[ 0x58 ] = KEY_7,
+	[ 0x38 ] = KEY_8,
+	[ 0x78 ] = KEY_9,
+
+	[ 0x10 ] = KEY_L,			/* Live */
+	[ 0x08 ] = KEY_T,			/* Time Shift */
+
+	[ 0x18 ] = KEY_PLAYPAUSE,		/* Play */
+
+	[ 0x24 ] = KEY_ENTER,		/* 11 */
+	[ 0x64 ] = KEY_ESC,		/* 12 */
+	[ 0x04 ] = KEY_M,			/* Multi */
+
+	[ 0x54 ] = KEY_VIDEO,
+	[ 0x34 ] = KEY_CHANNELUP,
+	[ 0x74 ] = KEY_VOLUMEUP,
+	[ 0x14 ] = KEY_MUTE,
+
+	[ 0x4c ] = KEY_S,			/* SVIDEO */
+	[ 0x2c ] = KEY_CHANNELDOWN,
+	[ 0x6c ] = KEY_VOLUMEDOWN,
+	[ 0x0c ] = KEY_ZOOM,
+
+	[ 0x5c ] = KEY_PAUSE,
+	[ 0x3c ] = KEY_C,			/* || (red) */
+	[ 0x7c ] = KEY_RECORD,		/* recording */
+	[ 0x1c ] = KEY_STOP,
+
+	[ 0x41 ] = KEY_REWIND,		/* backward << */
+	[ 0x21 ] = KEY_PLAY,
+	[ 0x61 ] = KEY_FASTFORWARD,	/* forward >> */
+	[ 0x01 ] = KEY_NEXT,		/* skip >| */
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_iodata_bctv7e);
+
+/* ---------------------------------------------------------------------- */
+
+/* ADS Tech Instant TV DVB-T PCI Remote */
+IR_KEYTAB_TYPE ir_codes_adstech_dvb_t_pci[IR_KEYTAB_SIZE] = {
+	/* Keys 0 to 9 */
+	[ 0x4d ] = KEY_0,
+	[ 0x57 ] = KEY_1,
+	[ 0x4f ] = KEY_2,
+	[ 0x53 ] = KEY_3,
+	[ 0x56 ] = KEY_4,
+	[ 0x4e ] = KEY_5,
+	[ 0x5e ] = KEY_6,
+	[ 0x54 ] = KEY_7,
+	[ 0x4c ] = KEY_8,
+	[ 0x5c ] = KEY_9,
+
+	[ 0x5b ] = KEY_POWER,
+	[ 0x5f ] = KEY_MUTE,
+	[ 0x55 ] = KEY_GOTO,
+	[ 0x5d ] = KEY_SEARCH,
+	[ 0x17 ] = KEY_EPG,		/* Guide */
+	[ 0x1f ] = KEY_MENU,
+	[ 0x0f ] = KEY_UP,
+	[ 0x46 ] = KEY_DOWN,
+	[ 0x16 ] = KEY_LEFT,
+	[ 0x1e ] = KEY_RIGHT,
+	[ 0x0e ] = KEY_SELECT,		/* Enter */
+	[ 0x5a ] = KEY_INFO,
+	[ 0x52 ] = KEY_EXIT,
+	[ 0x59 ] = KEY_PREVIOUS,
+	[ 0x51 ] = KEY_NEXT,
+	[ 0x58 ] = KEY_REWIND,
+	[ 0x50 ] = KEY_FORWARD,
+	[ 0x44 ] = KEY_PLAYPAUSE,
+	[ 0x07 ] = KEY_STOP,
+	[ 0x1b ] = KEY_RECORD,
+	[ 0x13 ] = KEY_TUNER,		/* Live */
+	[ 0x0a ] = KEY_A,
+	[ 0x12 ] = KEY_B,
+	[ 0x03 ] = KEY_PROG1,		/* 1 */
+	[ 0x01 ] = KEY_PROG2,		/* 2 */
+	[ 0x00 ] = KEY_PROG3,		/* 3 */
+	[ 0x06 ] = KEY_DVD,
+	[ 0x48 ] = KEY_AUX,		/* Photo */
+	[ 0x40 ] = KEY_VIDEO,
+	[ 0x19 ] = KEY_AUDIO,		/* Music */
+	[ 0x0b ] = KEY_CHANNELUP,
+	[ 0x08 ] = KEY_CHANNELDOWN,
+	[ 0x15 ] = KEY_VOLUMEUP,
+	[ 0x1c ] = KEY_VOLUMEDOWN,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_adstech_dvb_t_pci);
+
+/* ---------------------------------------------------------------------- */
+
+/* MSI TV@nywhere remote */
+IR_KEYTAB_TYPE ir_codes_msi_tvanywhere[IR_KEYTAB_SIZE] = {
+	/* Keys 0 to 9 */
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x0c ] = KEY_MUTE,
+	[ 0x0f ] = KEY_SCREEN,		/* Full Screen */
+	[ 0x10 ] = KEY_F,			/* Funtion */
+	[ 0x11 ] = KEY_T,			/* Time shift */
+	[ 0x12 ] = KEY_POWER,
+	[ 0x13 ] = KEY_MEDIA,		/* MTS */
+	[ 0x14 ] = KEY_SLOW,
+	[ 0x16 ] = KEY_REWIND,		/* backward << */
+	[ 0x17 ] = KEY_ENTER,		/* Return */
+	[ 0x18 ] = KEY_FASTFORWARD,	/* forward >> */
+	[ 0x1a ] = KEY_CHANNELUP,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x1e ] = KEY_CHANNELDOWN,
+	[ 0x1f ] = KEY_VOLUMEDOWN,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_msi_tvanywhere);
+
+/* ---------------------------------------------------------------------- */
+
+/* Cinergy 1400 DVB-T */
+IR_KEYTAB_TYPE ir_codes_cinergy_1400[IR_KEYTAB_SIZE] = {
+	[ 0x01 ] = KEY_POWER,
+	[ 0x02 ] = KEY_1,
+	[ 0x03 ] = KEY_2,
+	[ 0x04 ] = KEY_3,
+	[ 0x05 ] = KEY_4,
+	[ 0x06 ] = KEY_5,
+	[ 0x07 ] = KEY_6,
+	[ 0x08 ] = KEY_7,
+	[ 0x09 ] = KEY_8,
+	[ 0x0a ] = KEY_9,
+	[ 0x0c ] = KEY_0,
+
+	[ 0x0b ] = KEY_VIDEO,
+	[ 0x0d ] = KEY_REFRESH,
+	[ 0x0e ] = KEY_SELECT,
+	[ 0x0f ] = KEY_EPG,
+	[ 0x10 ] = KEY_UP,
+	[ 0x11 ] = KEY_LEFT,
+	[ 0x12 ] = KEY_OK,
+	[ 0x13 ] = KEY_RIGHT,
+	[ 0x14 ] = KEY_DOWN,
+	[ 0x15 ] = KEY_TEXT,
+	[ 0x16 ] = KEY_INFO,
+
+	[ 0x17 ] = KEY_RED,
+	[ 0x18 ] = KEY_GREEN,
+	[ 0x19 ] = KEY_YELLOW,
+	[ 0x1a ] = KEY_BLUE,
+
+	[ 0x1b ] = KEY_CHANNELUP,
+	[ 0x1c ] = KEY_VOLUMEUP,
+	[ 0x1d ] = KEY_MUTE,
+	[ 0x1e ] = KEY_VOLUMEDOWN,
+	[ 0x1f ] = KEY_CHANNELDOWN,
+
+	[ 0x40 ] = KEY_PAUSE,
+	[ 0x4c ] = KEY_PLAY,
+	[ 0x58 ] = KEY_RECORD,
+	[ 0x54 ] = KEY_PREVIOUS,
+	[ 0x48 ] = KEY_STOP,
+	[ 0x5c ] = KEY_NEXT,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_cinergy_1400);
+
+/* ---------------------------------------------------------------------- */
+
+/* AVERTV STUDIO 303 Remote */
+IR_KEYTAB_TYPE ir_codes_avertv_303[IR_KEYTAB_SIZE] = {
+	[ 0x2a ] = KEY_1,
+	[ 0x32 ] = KEY_2,
+	[ 0x3a ] = KEY_3,
+	[ 0x4a ] = KEY_4,
+	[ 0x52 ] = KEY_5,
+	[ 0x5a ] = KEY_6,
+	[ 0x6a ] = KEY_7,
+	[ 0x72 ] = KEY_8,
+	[ 0x7a ] = KEY_9,
+	[ 0x0e ] = KEY_0,
+
+	[ 0x02 ] = KEY_POWER,
+	[ 0x22 ] = KEY_VIDEO,
+	[ 0x42 ] = KEY_AUDIO,
+	[ 0x62 ] = KEY_ZOOM,
+	[ 0x0a ] = KEY_TV,
+	[ 0x12 ] = KEY_CD,
+	[ 0x1a ] = KEY_TEXT,
+
+	[ 0x16 ] = KEY_SUBTITLE,
+	[ 0x1e ] = KEY_REWIND,
+	[ 0x06 ] = KEY_PRINT,
+
+	[ 0x2e ] = KEY_SEARCH,
+	[ 0x36 ] = KEY_SLEEP,
+	[ 0x3e ] = KEY_SHUFFLE,
+	[ 0x26 ] = KEY_MUTE,
+
+	[ 0x4e ] = KEY_RECORD,
+	[ 0x56 ] = KEY_PAUSE,
+	[ 0x5e ] = KEY_STOP,
+	[ 0x46 ] = KEY_PLAY,
+
+	[ 0x6e ] = KEY_RED,
+	[ 0x0b ] = KEY_GREEN,
+	[ 0x66 ] = KEY_YELLOW,
+	[ 0x03 ] = KEY_BLUE,
+
+	[ 0x76 ] = KEY_LEFT,
+	[ 0x7e ] = KEY_RIGHT,
+	[ 0x13 ] = KEY_DOWN,
+	[ 0x1b ] = KEY_UP,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_avertv_303);
+
+/* ---------------------------------------------------------------------- */
+
+/* DigitalNow DNTV Live! DVB-T Pro Remote */
+IR_KEYTAB_TYPE ir_codes_dntv_live_dvbt_pro[IR_KEYTAB_SIZE] = {
+	[ 0x16 ] = KEY_POWER,
+	[ 0x5b ] = KEY_HOME,
+
+	[ 0x55 ] = KEY_TV,		/* live tv */
+	[ 0x58 ] = KEY_TUNER,		/* digital Radio */
+	[ 0x5a ] = KEY_RADIO,		/* FM radio */
+	[ 0x59 ] = KEY_DVD,		/* dvd menu */
+	[ 0x03 ] = KEY_1,
+	[ 0x01 ] = KEY_2,
+	[ 0x06 ] = KEY_3,
+	[ 0x09 ] = KEY_4,
+	[ 0x1d ] = KEY_5,
+	[ 0x1f ] = KEY_6,
+	[ 0x0d ] = KEY_7,
+	[ 0x19 ] = KEY_8,
+	[ 0x1b ] = KEY_9,
+	[ 0x0c ] = KEY_CANCEL,
+	[ 0x15 ] = KEY_0,
+	[ 0x4a ] = KEY_CLEAR,
+	[ 0x13 ] = KEY_BACK,
+	[ 0x00 ] = KEY_TAB,
+	[ 0x4b ] = KEY_UP,
+	[ 0x4e ] = KEY_LEFT,
+	[ 0x4f ] = KEY_OK,
+	[ 0x52 ] = KEY_RIGHT,
+	[ 0x51 ] = KEY_DOWN,
+	[ 0x1e ] = KEY_VOLUMEUP,
+	[ 0x0a ] = KEY_VOLUMEDOWN,
+	[ 0x02 ] = KEY_CHANNELDOWN,
+	[ 0x05 ] = KEY_CHANNELUP,
+	[ 0x11 ] = KEY_RECORD,
+	[ 0x14 ] = KEY_PLAY,
+	[ 0x4c ] = KEY_PAUSE,
+	[ 0x1a ] = KEY_STOP,
+	[ 0x40 ] = KEY_REWIND,
+	[ 0x12 ] = KEY_FASTFORWARD,
+	[ 0x41 ] = KEY_PREVIOUSSONG,	/* replay |< */
+	[ 0x42 ] = KEY_NEXTSONG,	/* skip >| */
+	[ 0x54 ] = KEY_CAMERA,		/* capture */
+	[ 0x50 ] = KEY_LANGUAGE,	/* sap */
+	[ 0x47 ] = KEY_TV2,		/* pip */
+	[ 0x4d ] = KEY_SCREEN,
+	[ 0x43 ] = KEY_SUBTITLE,
+	[ 0x10 ] = KEY_MUTE,
+	[ 0x49 ] = KEY_AUDIO,		/* l/r */
+	[ 0x07 ] = KEY_SLEEP,
+	[ 0x08 ] = KEY_VIDEO,		/* a/v */
+	[ 0x0e ] = KEY_PREVIOUS,	/* recall */
+	[ 0x45 ] = KEY_ZOOM,		/* zoom + */
+	[ 0x46 ] = KEY_ANGLE,		/* zoom - */
+	[ 0x56 ] = KEY_RED,
+	[ 0x57 ] = KEY_GREEN,
+	[ 0x5c ] = KEY_YELLOW,
+	[ 0x5d ] = KEY_BLUE,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_dntv_live_dvbt_pro);
+
+IR_KEYTAB_TYPE ir_codes_em_terratec[IR_KEYTAB_SIZE] = {
+	[ 0x01 ] = KEY_CHANNEL,
+	[ 0x02 ] = KEY_SELECT,
+	[ 0x03 ] = KEY_MUTE,
+	[ 0x04 ] = KEY_POWER,
+	[ 0x05 ] = KEY_1,
+	[ 0x06 ] = KEY_2,
+	[ 0x07 ] = KEY_3,
+	[ 0x08 ] = KEY_CHANNELUP,
+	[ 0x09 ] = KEY_4,
+	[ 0x0a ] = KEY_5,
+	[ 0x0b ] = KEY_6,
+	[ 0x0c ] = KEY_CHANNELDOWN,
+	[ 0x0d ] = KEY_7,
+	[ 0x0e ] = KEY_8,
+	[ 0x0f ] = KEY_9,
+	[ 0x10 ] = KEY_VOLUMEUP,
+	[ 0x11 ] = KEY_0,
+	[ 0x12 ] = KEY_MENU,
+	[ 0x13 ] = KEY_PRINT,
+	[ 0x14 ] = KEY_VOLUMEDOWN,
+	[ 0x16 ] = KEY_PAUSE,
+	[ 0x18 ] = KEY_RECORD,
+	[ 0x19 ] = KEY_REWIND,
+	[ 0x1a ] = KEY_PLAY,
+	[ 0x1b ] = KEY_FORWARD,
+	[ 0x1c ] = KEY_BACKSPACE,
+	[ 0x1e ] = KEY_STOP,
+	[ 0x40 ] = KEY_ZOOM,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_em_terratec);
+
+IR_KEYTAB_TYPE ir_codes_em_pinnacle_usb[IR_KEYTAB_SIZE] = {
+	[ 0x3a ] = KEY_0,
+	[ 0x31 ] = KEY_1,
+	[ 0x32 ] = KEY_2,
+	[ 0x33 ] = KEY_3,
+	[ 0x34 ] = KEY_4,
+	[ 0x35 ] = KEY_5,
+	[ 0x36 ] = KEY_6,
+	[ 0x37 ] = KEY_7,
+	[ 0x38 ] = KEY_8,
+	[ 0x39 ] = KEY_9,
+
+	[ 0x2f ] = KEY_POWER,
+
+	[ 0x2e ] = KEY_P,
+	[ 0x1f ] = KEY_L,
+	[ 0x2b ] = KEY_I,
+
+	[ 0x2d ] = KEY_ZOOM,
+	[ 0x1e ] = KEY_ZOOM,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x0f ] = KEY_VOLUMEDOWN,
+	[ 0x17 ] = KEY_CHANNELUP,
+	[ 0x1c ] = KEY_CHANNELDOWN,
+	[ 0x25 ] = KEY_INFO,
+
+	[ 0x3c ] = KEY_MUTE,
+
+	[ 0x3d ] = KEY_LEFT,
+	[ 0x3b ] = KEY_RIGHT,
+
+	[ 0x3f ] = KEY_UP,
+	[ 0x3e ] = KEY_DOWN,
+	[ 0x1a ] = KEY_PAUSE,
+
+	[ 0x1d ] = KEY_MENU,
+	[ 0x19 ] = KEY_PLAY,
+	[ 0x16 ] = KEY_REWIND,
+	[ 0x13 ] = KEY_FORWARD,
+	[ 0x15 ] = KEY_PAUSE,
+	[ 0x0e ] = KEY_REWIND,
+	[ 0x0d ] = KEY_PLAY,
+	[ 0x0b ] = KEY_STOP,
+	[ 0x07 ] = KEY_FORWARD,
+	[ 0x27 ] = KEY_RECORD,
+	[ 0x26 ] = KEY_TUNER,
+	[ 0x29 ] = KEY_TEXT,
+	[ 0x2a ] = KEY_MEDIA,
+	[ 0x18 ] = KEY_EPG,
+	[ 0x27 ] = KEY_RECORD,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_em_pinnacle_usb);
+
+IR_KEYTAB_TYPE ir_codes_flyvideo[IR_KEYTAB_SIZE] = {
+	[ 0x0f ] = KEY_0,
+	[ 0x03 ] = KEY_1,
+	[ 0x04 ] = KEY_2,
+	[ 0x05 ] = KEY_3,
+	[ 0x07 ] = KEY_4,
+	[ 0x08 ] = KEY_5,
+	[ 0x09 ] = KEY_6,
+	[ 0x0b ] = KEY_7,
+	[ 0x0c ] = KEY_8,
+	[ 0x0d ] = KEY_9,
+
+	[ 0x0e ] = KEY_MODE,         // Air/Cable
+	[ 0x11 ] = KEY_VIDEO,        // Video
+	[ 0x15 ] = KEY_AUDIO,        // Audio
+	[ 0x00 ] = KEY_POWER,        // Power
+	[ 0x18 ] = KEY_TUNER,        // AV Source
+	[ 0x02 ] = KEY_ZOOM,         // Fullscreen
+	[ 0x1a ] = KEY_LANGUAGE,     // Stereo
+	[ 0x1b ] = KEY_MUTE,         // Mute
+	[ 0x14 ] = KEY_VOLUMEUP,     // Volume +
+	[ 0x17 ] = KEY_VOLUMEDOWN,   // Volume -
+	[ 0x12 ] = KEY_CHANNELUP,    // Channel +
+	[ 0x13 ] = KEY_CHANNELDOWN,  // Channel -
+	[ 0x06 ] = KEY_AGAIN,        // Recall
+	[ 0x10 ] = KEY_ENTER,      // Enter
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_flyvideo);
+
+IR_KEYTAB_TYPE ir_codes_flydvb[IR_KEYTAB_SIZE] = {
+	[ 0x01 ] = KEY_ZOOM,		// Full Screen
+	[ 0x00 ] = KEY_POWER,		// Power
+
+	[ 0x03 ] = KEY_1,
+	[ 0x04 ] = KEY_2,
+	[ 0x05 ] = KEY_3,
+	[ 0x07 ] = KEY_4,
+	[ 0x08 ] = KEY_5,
+	[ 0x09 ] = KEY_6,
+	[ 0x0b ] = KEY_7,
+	[ 0x0c ] = KEY_8,
+	[ 0x0d ] = KEY_9,
+	[ 0x06 ] = KEY_AGAIN,		// Recall
+	[ 0x0f ] = KEY_0,
+	[ 0x10 ] = KEY_MUTE,		// Mute
+	[ 0x02 ] = KEY_RADIO,		// TV/Radio
+	[ 0x1b ] = KEY_LANGUAGE,		// SAP (Second Audio Program)
+
+	[ 0x14 ] = KEY_VOLUMEUP,		// VOL+
+	[ 0x17 ] = KEY_VOLUMEDOWN,	// VOL-
+	[ 0x12 ] = KEY_CHANNELUP,		// CH+
+	[ 0x13 ] = KEY_CHANNELDOWN,	// CH-
+	[ 0x1d ] = KEY_ENTER,		// Enter
+
+	[ 0x1a ] = KEY_MODE,		// PIP
+	[ 0x18 ] = KEY_TUNER,		// Source
+
+	[ 0x1e ] = KEY_RECORD,		// Record/Pause
+	[ 0x15 ] = KEY_ANGLE,		// Swap (no label on key)
+	[ 0x1c ] = KEY_PAUSE,		// Timeshift/Pause
+	[ 0x19 ] = KEY_BACK,		// Rewind <<
+	[ 0x0a ] = KEY_PLAYPAUSE,		// Play/Pause
+	[ 0x1f ] = KEY_FORWARD,		// Forward >>
+	[ 0x16 ] = KEY_PREVIOUS,		// Back |<<
+	[ 0x11 ] = KEY_STOP,		// Stop
+	[ 0x0e ] = KEY_NEXT,		// End >>|
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_flydvb);
+
+IR_KEYTAB_TYPE ir_codes_cinergy[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x0a ] = KEY_POWER,
+	[ 0x0b ] = KEY_PROG1,           // app
+	[ 0x0c ] = KEY_ZOOM,            // zoom/fullscreen
+	[ 0x0d ] = KEY_CHANNELUP,       // channel
+	[ 0x0e ] = KEY_CHANNELDOWN,     // channel-
+	[ 0x0f ] = KEY_VOLUMEUP,
+	[ 0x10 ] = KEY_VOLUMEDOWN,
+	[ 0x11 ] = KEY_TUNER,           // AV
+	[ 0x12 ] = KEY_NUMLOCK,         // -/--
+	[ 0x13 ] = KEY_AUDIO,           // audio
+	[ 0x14 ] = KEY_MUTE,
+	[ 0x15 ] = KEY_UP,
+	[ 0x16 ] = KEY_DOWN,
+	[ 0x17 ] = KEY_LEFT,
+	[ 0x18 ] = KEY_RIGHT,
+	[ 0x19 ] = BTN_LEFT,
+	[ 0x1a ] = BTN_RIGHT,
+	[ 0x1b ] = KEY_WWW,             // text
+	[ 0x1c ] = KEY_REWIND,
+	[ 0x1d ] = KEY_FORWARD,
+	[ 0x1e ] = KEY_RECORD,
+	[ 0x1f ] = KEY_PLAY,
+	[ 0x20 ] = KEY_PREVIOUSSONG,
+	[ 0x21 ] = KEY_NEXTSONG,
+	[ 0x22 ] = KEY_PAUSE,
+	[ 0x23 ] = KEY_STOP,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_cinergy);
+
+/* Alfons Geser <a.geser@cox.net>
+ * updates from Job D. R. Borges <jobdrb@ig.com.br> */
+IR_KEYTAB_TYPE ir_codes_eztv[IR_KEYTAB_SIZE] = {
+	[ 0x12 ] = KEY_POWER,
+	[ 0x01 ] = KEY_TV,             // DVR
+	[ 0x15 ] = KEY_DVD,            // DVD
+	[ 0x17 ] = KEY_AUDIO,          // music
+				     // DVR mode / DVD mode / music mode
+
+	[ 0x1b ] = KEY_MUTE,           // mute
+	[ 0x02 ] = KEY_LANGUAGE,       // MTS/SAP / audio / autoseek
+	[ 0x1e ] = KEY_SUBTITLE,       // closed captioning / subtitle / seek
+	[ 0x16 ] = KEY_ZOOM,           // full screen
+	[ 0x1c ] = KEY_VIDEO,          // video source / eject / delall
+	[ 0x1d ] = KEY_RESTART,        // playback / angle / del
+	[ 0x2f ] = KEY_SEARCH,         // scan / menu / playlist
+	[ 0x30 ] = KEY_CHANNEL,        // CH surfing / bookmark / memo
+
+	[ 0x31 ] = KEY_HELP,           // help
+	[ 0x32 ] = KEY_MODE,           // num/memo
+	[ 0x33 ] = KEY_ESC,            // cancel
+
+	[ 0x0c ] = KEY_UP,             // up
+	[ 0x10 ] = KEY_DOWN,           // down
+	[ 0x08 ] = KEY_LEFT,           // left
+	[ 0x04 ] = KEY_RIGHT,          // right
+	[ 0x03 ] = KEY_SELECT,         // select
+
+	[ 0x1f ] = KEY_REWIND,         // rewind
+	[ 0x20 ] = KEY_PLAYPAUSE,      // play/pause
+	[ 0x29 ] = KEY_FORWARD,        // forward
+	[ 0x14 ] = KEY_AGAIN,          // repeat
+	[ 0x2b ] = KEY_RECORD,         // recording
+	[ 0x2c ] = KEY_STOP,           // stop
+	[ 0x2d ] = KEY_PLAY,           // play
+	[ 0x2e ] = KEY_SHUFFLE,        // snapshot / shuffle
+
+	[ 0x00 ] = KEY_0,
+	[ 0x05 ] = KEY_1,
+	[ 0x06 ] = KEY_2,
+	[ 0x07 ] = KEY_3,
+	[ 0x09 ] = KEY_4,
+	[ 0x0a ] = KEY_5,
+	[ 0x0b ] = KEY_6,
+	[ 0x0d ] = KEY_7,
+	[ 0x0e ] = KEY_8,
+	[ 0x0f ] = KEY_9,
+
+	[ 0x2a ] = KEY_VOLUMEUP,
+	[ 0x11 ] = KEY_VOLUMEDOWN,
+	[ 0x18 ] = KEY_CHANNELUP,      // CH.tracking up
+	[ 0x19 ] = KEY_CHANNELDOWN,    // CH.tracking down
+
+	[ 0x13 ] = KEY_ENTER,        // enter
+	[ 0x21 ] = KEY_DOT,          // . (decimal dot)
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_eztv);
+
+IR_KEYTAB_TYPE ir_codes_avacssmart[IR_KEYTAB_SIZE] = {
+	[ 0x1e ] = KEY_POWER,		// power
+	[ 0x1c ] = KEY_SEARCH,		// scan
+	[ 0x07 ] = KEY_SELECT,		// source
+
+	[ 0x16 ] = KEY_VOLUMEUP,
+	[ 0x14 ] = KEY_VOLUMEDOWN,
+	[ 0x1f ] = KEY_CHANNELUP,
+	[ 0x17 ] = KEY_CHANNELDOWN,
+	[ 0x18 ] = KEY_MUTE,
+
+	[ 0x02 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x0b ] = KEY_2,
+	[ 0x1b ] = KEY_3,
+	[ 0x05 ] = KEY_4,
+	[ 0x09 ] = KEY_5,
+	[ 0x15 ] = KEY_6,
+	[ 0x06 ] = KEY_7,
+	[ 0x0a ] = KEY_8,
+	[ 0x12 ] = KEY_9,
+	[ 0x10 ] = KEY_DOT,
+
+	[ 0x03 ] = KEY_TUNER,		// tv/fm
+	[ 0x04 ] = KEY_REWIND,		// fm tuning left or function left
+	[ 0x0c ] = KEY_FORWARD,		// fm tuning right or function right
+
+	[ 0x00 ] = KEY_RECORD,
+	[ 0x08 ] = KEY_STOP,
+	[ 0x11 ] = KEY_PLAY,
+
+	[ 0x19 ] = KEY_ZOOM,
+	[ 0x0e ] = KEY_MENU,		// function
+	[ 0x13 ] = KEY_AGAIN,		// recall
+	[ 0x1d ] = KEY_RESTART,		// reset
+	[ 0x1a ] = KEY_SHUFFLE,		// snapshot/shuffle
+
+// FIXME
+	[ 0x0d ] = KEY_F21,		// mts
+	[ 0x0f ] = KEY_F22,		// min
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_avacssmart);
+
+/* Alex Hermann <gaaf@gmx.net> */
+IR_KEYTAB_TYPE ir_codes_md2819[IR_KEYTAB_SIZE] = {
+	[ 0x28 ] = KEY_1,
+	[ 0x18 ] = KEY_2,
+	[ 0x38 ] = KEY_3,
+	[ 0x24 ] = KEY_4,
+	[ 0x14 ] = KEY_5,
+	[ 0x34 ] = KEY_6,
+	[ 0x2c ] = KEY_7,
+	[ 0x1c ] = KEY_8,
+	[ 0x3c ] = KEY_9,
+	[ 0x22 ] = KEY_0,
+
+	[ 0x20 ] = KEY_TV,		// TV/FM
+	[ 0x10 ] = KEY_CD,		// CD
+	[ 0x30 ] = KEY_TEXT,		// TELETEXT
+	[ 0x00 ] = KEY_POWER,		// POWER
+
+	[ 0x08 ] = KEY_VIDEO,		// VIDEO
+	[ 0x04 ] = KEY_AUDIO,		// AUDIO
+	[ 0x0c ] = KEY_ZOOM,		// FULL SCREEN
+
+	[ 0x12 ] = KEY_SUBTITLE,		// DISPLAY	- ???
+	[ 0x32 ] = KEY_REWIND,		// LOOP		- ???
+	[ 0x02 ] = KEY_PRINT,		// PREVIEW	- ???
+
+	[ 0x2a ] = KEY_SEARCH,		// AUTOSCAN
+	[ 0x1a ] = KEY_SLEEP,		// FREEZE	- ???
+	[ 0x3a ] = KEY_SHUFFLE,		// SNAPSHOT	- ???
+	[ 0x0a ] = KEY_MUTE,		// MUTE
+
+	[ 0x26 ] = KEY_RECORD,		// RECORD
+	[ 0x16 ] = KEY_PAUSE,		// PAUSE
+	[ 0x36 ] = KEY_STOP,		// STOP
+	[ 0x06 ] = KEY_PLAY,		// PLAY
+
+	[ 0x2e ] = KEY_RED,		// <RED>
+	[ 0x21 ] = KEY_GREEN,		// <GREEN>
+	[ 0x0e ] = KEY_YELLOW,		// <YELLOW>
+	[ 0x01 ] = KEY_BLUE,		// <BLUE>
+
+	[ 0x1e ] = KEY_VOLUMEDOWN,	// VOLUME-
+	[ 0x3e ] = KEY_VOLUMEUP,		// VOLUME+
+	[ 0x11 ] = KEY_CHANNELDOWN,	// CHANNEL/PAGE-
+	[ 0x31 ] = KEY_CHANNELUP		// CHANNEL/PAGE+
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_md2819);
+
+IR_KEYTAB_TYPE ir_codes_videomate_tv_pvr[IR_KEYTAB_SIZE] = {
+	[ 0x14 ] = KEY_MUTE,
+	[ 0x24 ] = KEY_ZOOM,
+
+	[ 0x01 ] = KEY_DVD,
+	[ 0x23 ] = KEY_RADIO,
+	[ 0x00 ] = KEY_TV,
+
+	[ 0x0a ] = KEY_REWIND,
+	[ 0x08 ] = KEY_PLAYPAUSE,
+	[ 0x0f ] = KEY_FORWARD,
+
+	[ 0x02 ] = KEY_PREVIOUS,
+	[ 0x07 ] = KEY_STOP,
+	[ 0x06 ] = KEY_NEXT,
+
+	[ 0x0c ] = KEY_UP,
+	[ 0x0e ] = KEY_DOWN,
+	[ 0x0b ] = KEY_LEFT,
+	[ 0x0d ] = KEY_RIGHT,
+	[ 0x11 ] = KEY_OK,
+
+	[ 0x03 ] = KEY_MENU,
+	[ 0x09 ] = KEY_SETUP,
+	[ 0x05 ] = KEY_VIDEO,
+	[ 0x22 ] = KEY_CHANNEL,
+
+	[ 0x12 ] = KEY_VOLUMEUP,
+	[ 0x15 ] = KEY_VOLUMEDOWN,
+	[ 0x10 ] = KEY_CHANNELUP,
+	[ 0x13 ] = KEY_CHANNELDOWN,
+
+	[ 0x04 ] = KEY_RECORD,
+
+	[ 0x16 ] = KEY_1,
+	[ 0x17 ] = KEY_2,
+	[ 0x18 ] = KEY_3,
+	[ 0x19 ] = KEY_4,
+	[ 0x1a ] = KEY_5,
+	[ 0x1b ] = KEY_6,
+	[ 0x1c ] = KEY_7,
+	[ 0x1d ] = KEY_8,
+	[ 0x1e ] = KEY_9,
+	[ 0x1f ] = KEY_0,
+
+	[ 0x20 ] = KEY_LANGUAGE,
+	[ 0x21 ] = KEY_SLEEP,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_videomate_tv_pvr);
+
+/* Michael Tokarev <mjt@tls.msk.ru>
+   http://www.corpit.ru/mjt/beholdTV/remote_control.jpg
+   keytable is used by MANLI MTV00[ 0x0c ] and BeholdTV 40[13] at
+   least, and probably other cards too.
+   The "ascii-art picture" below (in comments, first row
+   is the keycode in hex, and subsequent row(s) shows
+   the button labels (several variants when appropriate)
+   helps to descide which keycodes to assign to the buttons.
+ */
+IR_KEYTAB_TYPE ir_codes_manli[IR_KEYTAB_SIZE] = {
+
+	/*  0x1c            0x12  *
+	 * FUNCTION         POWER *
+	 *   FM              (|)  *
+	 *                        */
+	[ 0x1c ] = KEY_RADIO,	/*XXX*/
+	[ 0x12 ] = KEY_POWER,
+
+	/*  0x01    0x02    0x03  *
+	 *   1       2       3    *
+	 *                        *
+	 *  0x04    0x05    0x06  *
+	 *   4       5       6    *
+	 *                        *
+	 *  0x07    0x08    0x09  *
+	 *   7       8       9    *
+	 *                        */
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	/*  0x0a    0x00    0x17  *
+	 * RECALL    0      +100  *
+	 *                  PLUS  *
+	 *                        */
+	[ 0x0a ] = KEY_AGAIN,	/*XXX KEY_REWIND? */
+	[ 0x00 ] = KEY_0,
+	[ 0x17 ] = KEY_DIGITS,	/*XXX*/
+
+	/*  0x14            0x10  *
+	 *  MENU            INFO  *
+	 *  OSD                   */
+	[ 0x14 ] = KEY_MENU,
+	[ 0x10 ] = KEY_INFO,
+
+	/*          0x0b          *
+	 *           Up           *
+	 *                        *
+	 *  0x18    0x16    0x0c  *
+	 *  Left     Ok     Right *
+	 *                        *
+	 *         0x015          *
+	 *         Down           *
+	 *                        */
+	[ 0x0b ] = KEY_UP,	/*XXX KEY_SCROLLUP? */
+	[ 0x18 ] = KEY_LEFT,	/*XXX KEY_BACK? */
+	[ 0x16 ] = KEY_OK,	/*XXX KEY_SELECT? KEY_ENTER? */
+	[ 0x0c ] = KEY_RIGHT,	/*XXX KEY_FORWARD? */
+	[ 0x15 ] = KEY_DOWN,	/*XXX KEY_SCROLLDOWN? */
+
+	/*  0x11            0x0d  *
+	 *  TV/AV           MODE  *
+	 *  SOURCE         STEREO *
+	 *                        */
+	[ 0x11 ] = KEY_TV,	/*XXX*/
+	[ 0x0d ] = KEY_MODE,	/*XXX there's no KEY_STEREO */
+
+	/*  0x0f    0x1b    0x1a  *
+	 *  AUDIO   Vol+    Chan+ *
+	 *        TIMESHIFT???    *
+	 *                        *
+	 *  0x0e    0x1f    0x1e  *
+	 *  SLEEP   Vol-    Chan- *
+	 *                        */
+	[ 0x0f ] = KEY_AUDIO,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x1a ] = KEY_CHANNELUP,
+	[ 0x0e ] = KEY_SLEEP,	/*XXX maybe KEY_PAUSE */
+	[ 0x1f ] = KEY_VOLUMEDOWN,
+	[ 0x1e ] = KEY_CHANNELDOWN,
+
+	/*         0x13     0x19  *
+	 *         MUTE   SNAPSHOT*
+	 *                        */
+	[ 0x13 ] = KEY_MUTE,
+	[ 0x19 ] = KEY_RECORD,	/*XXX*/
+
+	// 0x1d unused ?
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_manli);
+
+/* Mike Baikov <mike@baikov.com> */
+IR_KEYTAB_TYPE ir_codes_gotview7135[IR_KEYTAB_SIZE] = {
+
+	[ 0x21 ] = KEY_POWER,
+	[ 0x69 ] = KEY_TV,
+	[ 0x33 ] = KEY_0,
+	[ 0x51 ] = KEY_1,
+	[ 0x31 ] = KEY_2,
+	[ 0x71 ] = KEY_3,
+	[ 0x3b ] = KEY_4,
+	[ 0x58 ] = KEY_5,
+	[ 0x41 ] = KEY_6,
+	[ 0x48 ] = KEY_7,
+	[ 0x30 ] = KEY_8,
+	[ 0x53 ] = KEY_9,
+	[ 0x73 ] = KEY_AGAIN, /* LOOP */
+	[ 0x0a ] = KEY_AUDIO,
+	[ 0x61 ] = KEY_PRINT, /* PREVIEW */
+	[ 0x7a ] = KEY_VIDEO,
+	[ 0x20 ] = KEY_CHANNELUP,
+	[ 0x40 ] = KEY_CHANNELDOWN,
+	[ 0x18 ] = KEY_VOLUMEDOWN,
+	[ 0x50 ] = KEY_VOLUMEUP,
+	[ 0x10 ] = KEY_MUTE,
+	[ 0x4a ] = KEY_SEARCH,
+	[ 0x7b ] = KEY_SHUFFLE, /* SNAPSHOT */
+	[ 0x22 ] = KEY_RECORD,
+	[ 0x62 ] = KEY_STOP,
+	[ 0x78 ] = KEY_PLAY,
+	[ 0x39 ] = KEY_REWIND,
+	[ 0x59 ] = KEY_PAUSE,
+	[ 0x19 ] = KEY_FORWARD,
+	[ 0x09 ] = KEY_ZOOM,
+
+	[ 0x52 ] = KEY_F21, /* LIVE TIMESHIFT */
+	[ 0x1a ] = KEY_F22, /* MIN TIMESHIFT */
+	[ 0x3a ] = KEY_F23, /* TIMESHIFT */
+	[ 0x70 ] = KEY_F24, /* NORMAL TIMESHIFT */
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_gotview7135);
+
+IR_KEYTAB_TYPE ir_codes_purpletv[IR_KEYTAB_SIZE] = {
+	[ 0x03 ] = KEY_POWER,
+	[ 0x6f ] = KEY_MUTE,
+	[ 0x10 ] = KEY_BACKSPACE,       /* Recall */
+
+	[ 0x11 ] = KEY_0,
+	[ 0x04 ] = KEY_1,
+	[ 0x05 ] = KEY_2,
+	[ 0x06 ] = KEY_3,
+	[ 0x08 ] = KEY_4,
+	[ 0x09 ] = KEY_5,
+	[ 0x0a ] = KEY_6,
+	[ 0x0c ] = KEY_7,
+	[ 0x0d ] = KEY_8,
+	[ 0x0e ] = KEY_9,
+	[ 0x12 ] = KEY_DOT,           /* 100+ */
+
+	[ 0x07 ] = KEY_VOLUMEUP,
+	[ 0x0b ] = KEY_VOLUMEDOWN,
+	[ 0x1a ] = KEY_KPPLUS,
+	[ 0x18 ] = KEY_KPMINUS,
+	[ 0x15 ] = KEY_UP,
+	[ 0x1d ] = KEY_DOWN,
+	[ 0x0f ] = KEY_CHANNELUP,
+	[ 0x13 ] = KEY_CHANNELDOWN,
+	[ 0x48 ] = KEY_ZOOM,
+
+	[ 0x1b ] = KEY_VIDEO,           /* Video source */
+	[ 0x49 ] = KEY_LANGUAGE,        /* MTS Select */
+	[ 0x19 ] = KEY_SEARCH,          /* Auto Scan */
+
+	[ 0x4b ] = KEY_RECORD,
+	[ 0x46 ] = KEY_PLAY,
+	[ 0x45 ] = KEY_PAUSE,           /* Pause */
+	[ 0x44 ] = KEY_STOP,
+	[ 0x40 ] = KEY_FORWARD,         /* Forward ? */
+	[ 0x42 ] = KEY_REWIND,          /* Backward ? */
+
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_purpletv);
+
+/* Mapping for the 28 key remote control as seen at
+   http://www.sednacomputer.com/photo/cardbus-tv.jpg
+   Pavel Mihaylov <bin@bash.info> */
+IR_KEYTAB_TYPE ir_codes_pctv_sedna[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x0a ] = KEY_AGAIN,          /* Recall */
+	[ 0x0b ] = KEY_CHANNELUP,
+	[ 0x0c ] = KEY_VOLUMEUP,
+	[ 0x0d ] = KEY_MODE,           /* Stereo */
+	[ 0x0e ] = KEY_STOP,
+	[ 0x0f ] = KEY_PREVIOUSSONG,
+	[ 0x10 ] = KEY_ZOOM,
+	[ 0x11 ] = KEY_TUNER,          /* Source */
+	[ 0x12 ] = KEY_POWER,
+	[ 0x13 ] = KEY_MUTE,
+	[ 0x15 ] = KEY_CHANNELDOWN,
+	[ 0x18 ] = KEY_VOLUMEDOWN,
+	[ 0x19 ] = KEY_SHUFFLE,        /* Snapshot */
+	[ 0x1a ] = KEY_NEXTSONG,
+	[ 0x1b ] = KEY_TEXT,           /* Time Shift */
+	[ 0x1c ] = KEY_RADIO,          /* FM Radio */
+	[ 0x1d ] = KEY_RECORD,
+	[ 0x1e ] = KEY_PAUSE,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_pctv_sedna);
+
+/* Mark Phalan <phalanm@o2.ie> */
+IR_KEYTAB_TYPE ir_codes_pv951[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x12 ] = KEY_POWER,
+	[ 0x10 ] = KEY_MUTE,
+	[ 0x1f ] = KEY_VOLUMEDOWN,
+	[ 0x1b ] = KEY_VOLUMEUP,
+	[ 0x1a ] = KEY_CHANNELUP,
+	[ 0x1e ] = KEY_CHANNELDOWN,
+	[ 0x0e ] = KEY_PAGEUP,
+	[ 0x1d ] = KEY_PAGEDOWN,
+	[ 0x13 ] = KEY_SOUND,
+
+	[ 0x18 ] = KEY_KPPLUSMINUS,	/* CH +/- */
+	[ 0x16 ] = KEY_SUBTITLE,		/* CC */
+	[ 0x0d ] = KEY_TEXT,		/* TTX */
+	[ 0x0b ] = KEY_TV,		/* AIR/CBL */
+	[ 0x11 ] = KEY_PC,		/* PC/TV */
+	[ 0x17 ] = KEY_OK,		/* CH RTN */
+	[ 0x19 ] = KEY_MODE, 		/* FUNC */
+	[ 0x0c ] = KEY_SEARCH, 		/* AUTOSCAN */
+
+	/* Not sure what to do with these ones! */
+	[ 0x0f ] = KEY_SELECT, 		/* SOURCE */
+	[ 0x0a ] = KEY_KPPLUS,		/* +100 */
+	[ 0x14 ] = KEY_EQUAL,		/* SYNC */
+	[ 0x1c ] = KEY_MEDIA,             /* PC/TV */
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_pv951);
+
+/* generic RC5 keytable                                          */
+/* see http://users.pandora.be/nenya/electronics/rc5/codes00.htm */
+/* used by old (black) Hauppauge remotes                         */
+IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE] = {
+	/* Keys 0 to 9 */
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x0b ] = KEY_CHANNEL,		/* channel / program (japan: 11) */
+	[ 0x0c ] = KEY_POWER,		/* standby */
+	[ 0x0d ] = KEY_MUTE,		/* mute / demute */
+	[ 0x0f ] = KEY_TV,		/* display */
+	[ 0x10 ] = KEY_VOLUMEUP,
+	[ 0x11 ] = KEY_VOLUMEDOWN,
+	[ 0x12 ] = KEY_BRIGHTNESSUP,
+	[ 0x13 ] = KEY_BRIGHTNESSDOWN,
+	[ 0x1e ] = KEY_SEARCH,		/* search + */
+	[ 0x20 ] = KEY_CHANNELUP,	/* channel / program + */
+	[ 0x21 ] = KEY_CHANNELDOWN,	/* channel / program - */
+	[ 0x22 ] = KEY_CHANNEL,		/* alt / channel */
+	[ 0x23 ] = KEY_LANGUAGE,	/* 1st / 2nd language */
+	[ 0x26 ] = KEY_SLEEP,		/* sleeptimer */
+	[ 0x2e ] = KEY_MENU,		/* 2nd controls (USA: menu) */
+	[ 0x30 ] = KEY_PAUSE,
+	[ 0x32 ] = KEY_REWIND,
+	[ 0x33 ] = KEY_GOTO,
+	[ 0x35 ] = KEY_PLAY,
+	[ 0x36 ] = KEY_STOP,
+	[ 0x37 ] = KEY_RECORD,		/* recording */
+	[ 0x3c ] = KEY_TEXT,    	/* teletext submode (Japan: 12) */
+	[ 0x3d ] = KEY_SUSPEND,		/* system standby */
+
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_rc5_tv);
+
+/* Table for Leadtek Winfast Remote Controls - used by both bttv and cx88 */
+IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE] = {
+	/* Keys 0 to 9 */
+	[ 0x12 ] = KEY_0,
+	[ 0x05 ] = KEY_1,
+	[ 0x06 ] = KEY_2,
+	[ 0x07 ] = KEY_3,
+	[ 0x09 ] = KEY_4,
+	[ 0x0a ] = KEY_5,
+	[ 0x0b ] = KEY_6,
+	[ 0x0d ] = KEY_7,
+	[ 0x0e ] = KEY_8,
+	[ 0x0f ] = KEY_9,
+
+	[ 0x00 ] = KEY_POWER,
+	[ 0x02 ] = KEY_TUNER,		/* TV/FM */
+	[ 0x1e ] = KEY_VIDEO,
+	[ 0x04 ] = KEY_VOLUMEUP,
+	[ 0x08 ] = KEY_VOLUMEDOWN,
+	[ 0x0c ] = KEY_CHANNELUP,
+	[ 0x10 ] = KEY_CHANNELDOWN,
+	[ 0x03 ] = KEY_ZOOM,		/* fullscreen */
+	[ 0x1f ] = KEY_SUBTITLE,		/* closed caption/teletext */
+	[ 0x20 ] = KEY_SLEEP,
+	[ 0x14 ] = KEY_MUTE,
+	[ 0x2b ] = KEY_RED,
+	[ 0x2c ] = KEY_GREEN,
+	[ 0x2d ] = KEY_YELLOW,
+	[ 0x2e ] = KEY_BLUE,
+	[ 0x18 ] = KEY_KPPLUS,		/* fine tune + */
+	[ 0x19 ] = KEY_KPMINUS,		/* fine tune - */
+	[ 0x21 ] = KEY_DOT,
+	[ 0x13 ] = KEY_ENTER,
+	[ 0x22 ] = KEY_BACK,
+	[ 0x23 ] = KEY_PLAYPAUSE,
+	[ 0x24 ] = KEY_NEXT,
+	[ 0x26 ] = KEY_STOP,
+	[ 0x27 ] = KEY_RECORD
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_winfast);
+
+IR_KEYTAB_TYPE ir_codes_pinnacle[IR_KEYTAB_SIZE] = {
+	[ 0x59 ] = KEY_MUTE,
+	[ 0x4a ] = KEY_POWER,
+
+	[ 0x18 ] = KEY_TEXT,
+	[ 0x26 ] = KEY_TV,
+	[ 0x3d ] = KEY_PRINT,
+
+	[ 0x48 ] = KEY_RED,
+	[ 0x04 ] = KEY_GREEN,
+	[ 0x11 ] = KEY_YELLOW,
+	[ 0x00 ] = KEY_BLUE,
+
+	[ 0x2d ] = KEY_VOLUMEUP,
+	[ 0x1e ] = KEY_VOLUMEDOWN,
+
+	[ 0x49 ] = KEY_MENU,
+
+	[ 0x16 ] = KEY_CHANNELUP,
+	[ 0x17 ] = KEY_CHANNELDOWN,
+
+	[ 0x20 ] = KEY_UP,
+	[ 0x21 ] = KEY_DOWN,
+	[ 0x22 ] = KEY_LEFT,
+	[ 0x23 ] = KEY_RIGHT,
+	[ 0x0d ] = KEY_SELECT,
+
+
+
+	[ 0x08 ] = KEY_BACK,
+	[ 0x07 ] = KEY_REFRESH,
+
+	[ 0x2f ] = KEY_ZOOM,
+	[ 0x29 ] = KEY_RECORD,
+
+	[ 0x4b ] = KEY_PAUSE,
+	[ 0x4d ] = KEY_REWIND,
+	[ 0x2e ] = KEY_PLAY,
+	[ 0x4e ] = KEY_FORWARD,
+	[ 0x53 ] = KEY_PREVIOUS,
+	[ 0x4c ] = KEY_STOP,
+	[ 0x54 ] = KEY_NEXT,
+
+	[ 0x69 ] = KEY_0,
+	[ 0x6a ] = KEY_1,
+	[ 0x6b ] = KEY_2,
+	[ 0x6c ] = KEY_3,
+	[ 0x6d ] = KEY_4,
+	[ 0x6e ] = KEY_5,
+	[ 0x6f ] = KEY_6,
+	[ 0x70 ] = KEY_7,
+	[ 0x71 ] = KEY_8,
+	[ 0x72 ] = KEY_9,
+
+	[ 0x74 ] = KEY_CHANNEL,
+	[ 0x0a ] = KEY_BACKSPACE,
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_pinnacle);
+
+/* Hauppauge: the newer, gray remotes (seems there are multiple
+ * slightly different versions), shipped with cx88+ivtv cards.
+ * almost rc5 coding, but some non-standard keys */
+IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE] = {
+	/* Keys 0 to 9 */
+	[ 0x00 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x02 ] = KEY_2,
+	[ 0x03 ] = KEY_3,
+	[ 0x04 ] = KEY_4,
+	[ 0x05 ] = KEY_5,
+	[ 0x06 ] = KEY_6,
+	[ 0x07 ] = KEY_7,
+	[ 0x08 ] = KEY_8,
+	[ 0x09 ] = KEY_9,
+
+	[ 0x0a ] = KEY_TEXT,      	/* keypad asterisk as well */
+	[ 0x0b ] = KEY_RED,		/* red button */
+	[ 0x0c ] = KEY_RADIO,
+	[ 0x0d ] = KEY_MENU,
+	[ 0x0e ] = KEY_SUBTITLE,	/* also the # key */
+	[ 0x0f ] = KEY_MUTE,
+	[ 0x10 ] = KEY_VOLUMEUP,
+	[ 0x11 ] = KEY_VOLUMEDOWN,
+	[ 0x12 ] = KEY_PREVIOUS,	/* previous channel */
+	[ 0x14 ] = KEY_UP,
+	[ 0x15 ] = KEY_DOWN,
+	[ 0x16 ] = KEY_LEFT,
+	[ 0x17 ] = KEY_RIGHT,
+	[ 0x18 ] = KEY_VIDEO,		/* Videos */
+	[ 0x19 ] = KEY_AUDIO,		/* Music */
+	/* 0x1a: Pictures - presume this means
+	   "Multimedia Home Platform" -
+	   no "PICTURES" key in input.h
+	 */
+	[ 0x1a ] = KEY_MHP,
+
+	[ 0x1b ] = KEY_EPG,		/* Guide */
+	[ 0x1c ] = KEY_TV,
+	[ 0x1e ] = KEY_NEXTSONG,	/* skip >| */
+	[ 0x1f ] = KEY_EXIT,		/* back/exit */
+	[ 0x20 ] = KEY_CHANNELUP,	/* channel / program + */
+	[ 0x21 ] = KEY_CHANNELDOWN,	/* channel / program - */
+	[ 0x22 ] = KEY_CHANNEL,		/* source (old black remote) */
+	[ 0x24 ] = KEY_PREVIOUSSONG,	/* replay |< */
+	[ 0x25 ] = KEY_ENTER,		/* OK */
+	[ 0x26 ] = KEY_SLEEP,		/* minimize (old black remote) */
+	[ 0x29 ] = KEY_BLUE,		/* blue key */
+	[ 0x2e ] = KEY_GREEN,		/* green button */
+	[ 0x30 ] = KEY_PAUSE,		/* pause */
+	[ 0x32 ] = KEY_REWIND,		/* backward << */
+	[ 0x34 ] = KEY_FASTFORWARD,	/* forward >> */
+	[ 0x35 ] = KEY_PLAY,
+	[ 0x36 ] = KEY_STOP,
+	[ 0x37 ] = KEY_RECORD,		/* recording */
+	[ 0x38 ] = KEY_YELLOW,		/* yellow key */
+	[ 0x3b ] = KEY_SELECT,		/* top right button */
+	[ 0x3c ] = KEY_ZOOM,		/* full */
+	[ 0x3d ] = KEY_POWER,		/* system power (green button) */
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_hauppauge_new);
+
+IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE] = {
+	[ 0x02 ] = KEY_0,
+	[ 0x01 ] = KEY_1,
+	[ 0x0b ] = KEY_2,
+	[ 0x1b ] = KEY_3,
+	[ 0x05 ] = KEY_4,
+	[ 0x09 ] = KEY_5,
+	[ 0x15 ] = KEY_6,
+	[ 0x06 ] = KEY_7,
+	[ 0x0a ] = KEY_8,
+	[ 0x12 ] = KEY_9,
+
+	[ 0x03 ] = KEY_TUNER,		/* TV/FM */
+	[ 0x07 ] = KEY_SEARCH,		/* scan */
+	[ 0x1c ] = KEY_ZOOM,		/* full screen */
+	[ 0x1e ] = KEY_POWER,
+	[ 0x17 ] = KEY_VOLUMEDOWN,
+	[ 0x1f ] = KEY_VOLUMEUP,
+	[ 0x14 ] = KEY_CHANNELDOWN,
+	[ 0x16 ] = KEY_CHANNELUP,
+	[ 0x18 ] = KEY_MUTE,
+
+	[ 0x00 ] = KEY_LIST,		/* source */
+	[ 0x13 ] = KEY_INFO,		/* loop */
+	[ 0x10 ] = KEY_LAST,		/* +100 */
+	[ 0x0d ] = KEY_CLEAR,		/* reset */
+	[ 0x0c ] = BTN_RIGHT,		/* fun++ */
+	[ 0x04 ] = BTN_LEFT,		/* fun-- */
+	[ 0x0e ] = KEY_GOTO,		/* function */
+	[ 0x0f ] = KEY_STOP,		/* freeze */
+};
+
+EXPORT_SYMBOL_GPL(ir_codes_pixelview);
+
diff --git a/drivers/media/video/bttv-input.c b/drivers/media/video/bttv-input.c
diff --git a/drivers/media/video/bttv-input.c b/drivers/media/video/bttv-input.c
index 221b36e..42760ae 100644
--- a/drivers/media/video/bttv-input.c
+++ b/drivers/media/video/bttv-input.c
@@ -28,251 +28,6 @@
 #include "bttv.h"
 #include "bttvp.h"
 
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
 
 static int debug;
 module_param(debug, int, 0644);    /* debug level (0,1,2) */
diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
index da2ad5c..a4fa92c 100644
--- a/drivers/media/video/cx88/cx88-input.c
+++ b/drivers/media/video/cx88/cx88-input.c
@@ -34,337 +34,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-/* DigitalNow DNTV Live DVB-T Remote */
-static IR_KEYTAB_TYPE ir_codes_dntv_live_dvb_t[IR_KEYTAB_SIZE] = {
-	[0x00] = KEY_ESC,		/* 'go up a level?' */
-	/* Keys 0 to 9 */
-	[0x0a] = KEY_KP0,
-	[0x01] = KEY_KP1,
-	[0x02] = KEY_KP2,
-	[0x03] = KEY_KP3,
-	[0x04] = KEY_KP4,
-	[0x05] = KEY_KP5,
-	[0x06] = KEY_KP6,
-	[0x07] = KEY_KP7,
-	[0x08] = KEY_KP8,
-	[0x09] = KEY_KP9,
-
-	[0x0b] = KEY_TUNER,		/* tv/fm */
-	[0x0c] = KEY_SEARCH,		/* scan */
-	[0x0d] = KEY_STOP,
-	[0x0e] = KEY_PAUSE,
-	[0x0f] = KEY_LIST,		/* source */
-
-	[0x10] = KEY_MUTE,
-	[0x11] = KEY_REWIND,		/* backward << */
-	[0x12] = KEY_POWER,
-	[0x13] = KEY_S,			/* snap */
-	[0x14] = KEY_AUDIO,		/* stereo */
-	[0x15] = KEY_CLEAR,		/* reset */
-	[0x16] = KEY_PLAY,
-	[0x17] = KEY_ENTER,
-	[0x18] = KEY_ZOOM,		/* full screen */
-	[0x19] = KEY_FASTFORWARD,	/* forward >> */
-	[0x1a] = KEY_CHANNELUP,
-	[0x1b] = KEY_VOLUMEUP,
-	[0x1c] = KEY_INFO,		/* preview */
-	[0x1d] = KEY_RECORD,		/* record */
-	[0x1e] = KEY_CHANNELDOWN,
-	[0x1f] = KEY_VOLUMEDOWN,
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* IO-DATA BCTV7E Remote */
-static IR_KEYTAB_TYPE ir_codes_iodata_bctv7e[IR_KEYTAB_SIZE] = {
-	[0x40] = KEY_TV,
-	[0x20] = KEY_RADIO,		/* FM */
-	[0x60] = KEY_EPG,
-	[0x00] = KEY_POWER,
-
-	/* Keys 0 to 9 */
-	[0x44] = KEY_KP0,		/* 10 */
-	[0x50] = KEY_KP1,
-	[0x30] = KEY_KP2,
-	[0x70] = KEY_KP3,
-	[0x48] = KEY_KP4,
-	[0x28] = KEY_KP5,
-	[0x68] = KEY_KP6,
-	[0x58] = KEY_KP7,
-	[0x38] = KEY_KP8,
-	[0x78] = KEY_KP9,
-
-	[0x10] = KEY_L,			/* Live */
-	[0x08] = KEY_T,			/* Time Shift */
-
-	[0x18] = KEY_PLAYPAUSE,		/* Play */
-
-	[0x24] = KEY_ENTER,		/* 11 */
-	[0x64] = KEY_ESC,		/* 12 */
-	[0x04] = KEY_M,			/* Multi */
-
-	[0x54] = KEY_VIDEO,
-	[0x34] = KEY_CHANNELUP,
-	[0x74] = KEY_VOLUMEUP,
-	[0x14] = KEY_MUTE,
-
-	[0x4c] = KEY_S,			/* SVIDEO */
-	[0x2c] = KEY_CHANNELDOWN,
-	[0x6c] = KEY_VOLUMEDOWN,
-	[0x0c] = KEY_ZOOM,
-
-	[0x5c] = KEY_PAUSE,
-	[0x3c] = KEY_C,			/* || (red) */
-	[0x7c] = KEY_RECORD,		/* recording */
-	[0x1c] = KEY_STOP,
-
-	[0x41] = KEY_REWIND,		/* backward << */
-	[0x21] = KEY_PLAY,
-	[0x61] = KEY_FASTFORWARD,	/* forward >> */
-	[0x01] = KEY_NEXT,		/* skip >| */
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* ADS Tech Instant TV DVB-T PCI Remote */
-static IR_KEYTAB_TYPE ir_codes_adstech_dvb_t_pci[IR_KEYTAB_SIZE] = {
-	/* Keys 0 to 9 */
-	[0x4d] = KEY_0,
-	[0x57] = KEY_1,
-	[0x4f] = KEY_2,
-	[0x53] = KEY_3,
-	[0x56] = KEY_4,
-	[0x4e] = KEY_5,
-	[0x5e] = KEY_6,
-	[0x54] = KEY_7,
-	[0x4c] = KEY_8,
-	[0x5c] = KEY_9,
-
-	[0x5b] = KEY_POWER,
-	[0x5f] = KEY_MUTE,
-	[0x55] = KEY_GOTO,
-	[0x5d] = KEY_SEARCH,
-	[0x17] = KEY_EPG,		/* Guide */
-	[0x1f] = KEY_MENU,
-	[0x0f] = KEY_UP,
-	[0x46] = KEY_DOWN,
-	[0x16] = KEY_LEFT,
-	[0x1e] = KEY_RIGHT,
-	[0x0e] = KEY_SELECT,		/* Enter */
-	[0x5a] = KEY_INFO,
-	[0x52] = KEY_EXIT,
-	[0x59] = KEY_PREVIOUS,
-	[0x51] = KEY_NEXT,
-	[0x58] = KEY_REWIND,
-	[0x50] = KEY_FORWARD,
-	[0x44] = KEY_PLAYPAUSE,
-	[0x07] = KEY_STOP,
-	[0x1b] = KEY_RECORD,
-	[0x13] = KEY_TUNER,		/* Live */
-	[0x0a] = KEY_A,
-	[0x12] = KEY_B,
-	[0x03] = KEY_PROG1,		/* 1 */
-	[0x01] = KEY_PROG2,		/* 2 */
-	[0x00] = KEY_PROG3,		/* 3 */
-	[0x06] = KEY_DVD,
-	[0x48] = KEY_AUX,		/* Photo */
-	[0x40] = KEY_VIDEO,
-	[0x19] = KEY_AUDIO,		/* Music */
-	[0x0b] = KEY_CHANNELUP,
-	[0x08] = KEY_CHANNELDOWN,
-	[0x15] = KEY_VOLUMEUP,
-	[0x1c] = KEY_VOLUMEDOWN,
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* MSI TV@nywhere remote */
-static IR_KEYTAB_TYPE ir_codes_msi_tvanywhere[IR_KEYTAB_SIZE] = {
-	/* Keys 0 to 9 */
-	[0x00] = KEY_0,
-	[0x01] = KEY_1,
-	[0x02] = KEY_2,
-	[0x03] = KEY_3,
-	[0x04] = KEY_4,
-	[0x05] = KEY_5,
-	[0x06] = KEY_6,
-	[0x07] = KEY_7,
-	[0x08] = KEY_8,
-	[0x09] = KEY_9,
-
-	[0x0c] = KEY_MUTE,
-	[0x0f] = KEY_SCREEN,		/* Full Screen */
-	[0x10] = KEY_F,			/* Funtion */
-	[0x11] = KEY_T,			/* Time shift */
-	[0x12] = KEY_POWER,
-	[0x13] = KEY_MEDIA,		/* MTS */
-	[0x14] = KEY_SLOW,
-	[0x16] = KEY_REWIND,		/* backward << */
-	[0x17] = KEY_ENTER,		/* Return */
-	[0x18] = KEY_FASTFORWARD,	/* forward >> */
-	[0x1a] = KEY_CHANNELUP,
-	[0x1b] = KEY_VOLUMEUP,
-	[0x1e] = KEY_CHANNELDOWN,
-	[0x1f] = KEY_VOLUMEDOWN,
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* Cinergy 1400 DVB-T */
-static IR_KEYTAB_TYPE ir_codes_cinergy_1400[IR_KEYTAB_SIZE] = {
-	[0x01] = KEY_POWER,
-	[0x02] = KEY_1,
-	[0x03] = KEY_2,
-	[0x04] = KEY_3,
-	[0x05] = KEY_4,
-	[0x06] = KEY_5,
-	[0x07] = KEY_6,
-	[0x08] = KEY_7,
-	[0x09] = KEY_8,
-	[0x0a] = KEY_9,
-	[0x0c] = KEY_0,
-
-	[0x0b] = KEY_VIDEO,
-	[0x0d] = KEY_REFRESH,
-	[0x0e] = KEY_SELECT,
-	[0x0f] = KEY_EPG,
-	[0x10] = KEY_UP,
-	[0x11] = KEY_LEFT,
-	[0x12] = KEY_OK,
-	[0x13] = KEY_RIGHT,
-	[0x14] = KEY_DOWN,
-	[0x15] = KEY_TEXT,
-	[0x16] = KEY_INFO,
-
-	[0x17] = KEY_RED,
-	[0x18] = KEY_GREEN,
-	[0x19] = KEY_YELLOW,
-	[0x1a] = KEY_BLUE,
-
-	[0x1b] = KEY_CHANNELUP,
-	[0x1c] = KEY_VOLUMEUP,
-	[0x1d] = KEY_MUTE,
-	[0x1e] = KEY_VOLUMEDOWN,
-	[0x1f] = KEY_CHANNELDOWN,
-
-	[0x40] = KEY_PAUSE,
-	[0x4c] = KEY_PLAY,
-	[0x58] = KEY_RECORD,
-	[0x54] = KEY_PREVIOUS,
-	[0x48] = KEY_STOP,
-	[0x5c] = KEY_NEXT,
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* AVERTV STUDIO 303 Remote */
-static IR_KEYTAB_TYPE ir_codes_avertv_303[IR_KEYTAB_SIZE] = {
-	[ 0x2a ] = KEY_KP1,
-	[ 0x32 ] = KEY_KP2,
-	[ 0x3a ] = KEY_KP3,
-	[ 0x4a ] = KEY_KP4,
-	[ 0x52 ] = KEY_KP5,
-	[ 0x5a ] = KEY_KP6,
-	[ 0x6a ] = KEY_KP7,
-	[ 0x72 ] = KEY_KP8,
-	[ 0x7a ] = KEY_KP9,
-	[ 0x0e ] = KEY_KP0,
-
-	[ 0x02 ] = KEY_POWER,
-	[ 0x22 ] = KEY_VIDEO,
-	[ 0x42 ] = KEY_AUDIO,
-	[ 0x62 ] = KEY_ZOOM,
-	[ 0x0a ] = KEY_TV,
-	[ 0x12 ] = KEY_CD,
-	[ 0x1a ] = KEY_TEXT,
-
-	[ 0x16 ] = KEY_SUBTITLE,
-	[ 0x1e ] = KEY_REWIND,
-	[ 0x06 ] = KEY_PRINT,
-
-	[ 0x2e ] = KEY_SEARCH,
-	[ 0x36 ] = KEY_SLEEP,
-	[ 0x3e ] = KEY_SHUFFLE,
-	[ 0x26 ] = KEY_MUTE,
-
-	[ 0x4e ] = KEY_RECORD,
-	[ 0x56 ] = KEY_PAUSE,
-	[ 0x5e ] = KEY_STOP,
-	[ 0x46 ] = KEY_PLAY,
-
-	[ 0x6e ] = KEY_RED,
-	[ 0x0b ] = KEY_GREEN,
-	[ 0x66 ] = KEY_YELLOW,
-	[ 0x03 ] = KEY_BLUE,
-
-	[ 0x76 ] = KEY_LEFT,
-	[ 0x7e ] = KEY_RIGHT,
-	[ 0x13 ] = KEY_DOWN,
-	[ 0x1b ] = KEY_UP,
-};
-
-/* ---------------------------------------------------------------------- */
-
-/* DigitalNow DNTV Live! DVB-T Pro Remote */
-static IR_KEYTAB_TYPE ir_codes_dntv_live_dvbt_pro[IR_KEYTAB_SIZE] = {
-	[ 0x16 ] = KEY_POWER,
-	[ 0x5b ] = KEY_HOME,
-
-	[ 0x55 ] = KEY_TV,		/* live tv */
-	[ 0x58 ] = KEY_TUNER,		/* digital Radio */
-	[ 0x5a ] = KEY_RADIO,		/* FM radio */
-	[ 0x59 ] = KEY_DVD,		/* dvd menu */
-	[ 0x03 ] = KEY_1,
-	[ 0x01 ] = KEY_2,
-	[ 0x06 ] = KEY_3,
-	[ 0x09 ] = KEY_4,
-	[ 0x1d ] = KEY_5,
-	[ 0x1f ] = KEY_6,
-	[ 0x0d ] = KEY_7,
-	[ 0x19 ] = KEY_8,
-	[ 0x1b ] = KEY_9,
-	[ 0x0c ] = KEY_CANCEL,
-	[ 0x15 ] = KEY_0,
-	[ 0x4a ] = KEY_CLEAR,
-	[ 0x13 ] = KEY_BACK,
-	[ 0x00 ] = KEY_TAB,
-	[ 0x4b ] = KEY_UP,
-	[ 0x4e ] = KEY_LEFT,
-	[ 0x4f ] = KEY_OK,
-	[ 0x52 ] = KEY_RIGHT,
-	[ 0x51 ] = KEY_DOWN,
-	[ 0x1e ] = KEY_VOLUMEUP,
-	[ 0x0a ] = KEY_VOLUMEDOWN,
-	[ 0x02 ] = KEY_CHANNELDOWN,
-	[ 0x05 ] = KEY_CHANNELUP,
-	[ 0x11 ] = KEY_RECORD,
-	[ 0x14 ] = KEY_PLAY,
-	[ 0x4c ] = KEY_PAUSE,
-	[ 0x1a ] = KEY_STOP,
-	[ 0x40 ] = KEY_REWIND,
-	[ 0x12 ] = KEY_FASTFORWARD,
-	[ 0x41 ] = KEY_PREVIOUSSONG,	/* replay |< */
-	[ 0x42 ] = KEY_NEXTSONG,	/* skip >| */
-	[ 0x54 ] = KEY_CAMERA,		/* capture */
-	[ 0x50 ] = KEY_LANGUAGE,	/* sap */
-	[ 0x47 ] = KEY_TV2,		/* pip */
-	[ 0x4d ] = KEY_SCREEN,
-	[ 0x43 ] = KEY_SUBTITLE,
-	[ 0x10 ] = KEY_MUTE,
-	[ 0x49 ] = KEY_AUDIO,		/* l/r */
-	[ 0x07 ] = KEY_SLEEP,
-	[ 0x08 ] = KEY_VIDEO,		/* a/v */
-	[ 0x0e ] = KEY_PREVIOUS,	/* recall */
-	[ 0x45 ] = KEY_ZOOM,		/* zoom + */
-	[ 0x46 ] = KEY_ANGLE,		/* zoom - */
-	[ 0x56 ] = KEY_RED,
-	[ 0x57 ] = KEY_GREEN,
-	[ 0x5c ] = KEY_YELLOW,
-	[ 0x5d ] = KEY_BLUE,
-};
-
-/* ---------------------------------------------------------------------- */
-
 struct cx88_IR {
 	struct cx88_core *core;
 	struct input_dev *input;
diff --git a/drivers/media/video/em28xx/em28xx-input.c b/drivers/media/video/em28xx/em28xx-input.c
diff --git a/drivers/media/video/em28xx/em28xx-input.c b/drivers/media/video/em28xx/em28xx-input.c
index 30dfa53..31e89e4 100644
--- a/drivers/media/video/em28xx/em28xx-input.c
+++ b/drivers/media/video/em28xx/em28xx-input.c
@@ -43,91 +43,6 @@ MODULE_PARM_DESC(ir_debug,"enable debug 
 #define dprintk(fmt, arg...)	if (ir_debug) \
 	printk(KERN_DEBUG "%s/ir: " fmt, ir->c.name , ## arg)
 
-/* ---------------------------------------------------------------------- */
-
-static IR_KEYTAB_TYPE ir_codes_em_terratec[IR_KEYTAB_SIZE] = {
-	[ 0x01 ] = KEY_CHANNEL,
-	[ 0x02 ] = KEY_SELECT,
-	[ 0x03 ] = KEY_MUTE,
-	[ 0x04 ] = KEY_POWER,
-	[ 0x05 ] = KEY_KP1,
-	[ 0x06 ] = KEY_KP2,
-	[ 0x07 ] = KEY_KP3,
-	[ 0x08 ] = KEY_CHANNELUP,
-	[ 0x09 ] = KEY_KP4,
-	[ 0x0a ] = KEY_KP5,
-	[ 0x0b ] = KEY_KP6,
-	[ 0x0c ] = KEY_CHANNELDOWN,
-	[ 0x0d ] = KEY_KP7,
-	[ 0x0e ] = KEY_KP8,
-	[ 0x0f ] = KEY_KP9,
-	[ 0x10 ] = KEY_VOLUMEUP,
-	[ 0x11 ] = KEY_KP0,
-	[ 0x12 ] = KEY_MENU,
-	[ 0x13 ] = KEY_PRINT,
-	[ 0x14 ] = KEY_VOLUMEDOWN,
-	[ 0x16 ] = KEY_PAUSE,
-	[ 0x18 ] = KEY_RECORD,
-	[ 0x19 ] = KEY_REWIND,
-	[ 0x1a ] = KEY_PLAY,
-	[ 0x1b ] = KEY_FORWARD,
-	[ 0x1c ] = KEY_BACKSPACE,
-	[ 0x1e ] = KEY_STOP,
-	[ 0x40 ] = KEY_ZOOM,
-};
-
-static IR_KEYTAB_TYPE ir_codes_em_pinnacle_usb[IR_KEYTAB_SIZE] = {
-	[ 0x3a ] = KEY_KP0,
-	[ 0x31 ] = KEY_KP1,
-	[ 0x32 ] = KEY_KP2,
-	[ 0x33 ] = KEY_KP3,
-	[ 0x34 ] = KEY_KP4,
-	[ 0x35 ] = KEY_KP5,
-	[ 0x36 ] = KEY_KP6,
-	[ 0x37 ] = KEY_KP7,
-	[ 0x38 ] = KEY_KP8,
-	[ 0x39 ] = KEY_KP9,
-
-	[ 0x2f ] = KEY_POWER,
-
-	[ 0x2e ] = KEY_P,
-	[ 0x1f ] = KEY_L,
-	[ 0x2b ] = KEY_I,
-
-	[ 0x2d ] = KEY_ZOOM,
-	[ 0x1e ] = KEY_ZOOM,
-	[ 0x1b ] = KEY_VOLUMEUP,
-	[ 0x0f ] = KEY_VOLUMEDOWN,
-	[ 0x17 ] = KEY_CHANNELUP,
-	[ 0x1c ] = KEY_CHANNELDOWN,
-	[ 0x25 ] = KEY_INFO,
-
-	[ 0x3c ] = KEY_MUTE,
-
-	[ 0x3d ] = KEY_LEFT,
-	[ 0x3b ] = KEY_RIGHT,
-
-	[ 0x3f ] = KEY_UP,
-	[ 0x3e ] = KEY_DOWN,
-	[ 0x1a ] = KEY_PAUSE,
-
-	[ 0x1d ] = KEY_MENU,
-	[ 0x19 ] = KEY_PLAY,
-	[ 0x16 ] = KEY_REWIND,
-	[ 0x13 ] = KEY_FORWARD,
-	[ 0x15 ] = KEY_PAUSE,
-	[ 0x0e ] = KEY_REWIND,
-	[ 0x0d ] = KEY_PLAY,
-	[ 0x0b ] = KEY_STOP,
-	[ 0x07 ] = KEY_FORWARD,
-	[ 0x27 ] = KEY_RECORD,
-	[ 0x26 ] = KEY_TUNER,
-	[ 0x29 ] = KEY_TEXT,
-	[ 0x2a ] = KEY_MEDIA,
-	[ 0x18 ] = KEY_EPG,
-	[ 0x27 ] = KEY_RECORD,
-};
-
 /* ----------------------------------------------------------------------- */
 
 static int get_key_terratec(struct IR_i2c *ir, u32 *ir_key, u32 *ir_raw)
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
diff --git a/drivers/media/video/ir-kbd-i2c.c b/drivers/media/video/ir-kbd-i2c.c
index 3963481..95bacf4 100644
--- a/drivers/media/video/ir-kbd-i2c.c
+++ b/drivers/media/video/ir-kbd-i2c.c
@@ -44,45 +44,6 @@
 #include <media/ir-common.h>
 #include <media/ir-kbd-i2c.h>
 
-/* Mark Phalan <phalanm@o2.ie> */
-static IR_KEYTAB_TYPE ir_codes_pv951[IR_KEYTAB_SIZE] = {
-	[  0 ] = KEY_KP0,
-	[  1 ] = KEY_KP1,
-	[  2 ] = KEY_KP2,
-	[  3 ] = KEY_KP3,
-	[  4 ] = KEY_KP4,
-	[  5 ] = KEY_KP5,
-	[  6 ] = KEY_KP6,
-	[  7 ] = KEY_KP7,
-	[  8 ] = KEY_KP8,
-	[  9 ] = KEY_KP9,
-
-	[ 18 ] = KEY_POWER,
-	[ 16 ] = KEY_MUTE,
-	[ 31 ] = KEY_VOLUMEDOWN,
-	[ 27 ] = KEY_VOLUMEUP,
-	[ 26 ] = KEY_CHANNELUP,
-	[ 30 ] = KEY_CHANNELDOWN,
-	[ 14 ] = KEY_PAGEUP,
-	[ 29 ] = KEY_PAGEDOWN,
-	[ 19 ] = KEY_SOUND,
-
-	[ 24 ] = KEY_KPPLUSMINUS,	/* CH +/- */
-	[ 22 ] = KEY_SUBTITLE,		/* CC */
-	[ 13 ] = KEY_TEXT,		/* TTX */
-	[ 11 ] = KEY_TV,		/* AIR/CBL */
-	[ 17 ] = KEY_PC,		/* PC/TV */
-	[ 23 ] = KEY_OK,		/* CH RTN */
-	[ 25 ] = KEY_MODE, 		/* FUNC */
-	[ 12 ] = KEY_SEARCH, 		/* AUTOSCAN */
-
-	/* Not sure what to do with these ones! */
-	[ 15 ] = KEY_SELECT, 		/* SOURCE */
-	[ 10 ] = KEY_KPPLUS,		/* +100 */
-	[ 20 ] = KEY_KPEQUAL,		/* SYNC */
-	[ 28 ] = KEY_MEDIA,             /* PC/TV */
-};
-
 /* ----------------------------------------------------------------------- */
 /* insmod parameters                                                       */
 
@@ -342,7 +303,7 @@ static int ir_attach(struct i2c_adapter 
 		ir->get_key = get_key_haup;
 		ir_type     = IR_TYPE_RC5;
 		if (hauppauge == 1) {
-			ir_codes    = ir_codes_rc5_tv_grey;
+			ir_codes    = ir_codes_hauppauge_new;
 		} else {
 			ir_codes    = ir_codes_rc5_tv;
 		}
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
index 82d28cb..342568c 100644
--- a/drivers/media/video/saa7134/saa7134-input.c
+++ b/drivers/media/video/saa7134/saa7134-input.c
@@ -42,485 +42,6 @@ MODULE_PARM_DESC(ir_debug,"enable debug 
 #define i2cdprintk(fmt, arg...)    if (ir_debug) \
 	printk(KERN_DEBUG "%s/ir: " fmt, ir->c.name , ## arg)
 
-/* ---------------------------------------------------------------------- */
-
-static IR_KEYTAB_TYPE flyvideo_codes[IR_KEYTAB_SIZE] = {
-	[   15 ] = KEY_KP0,
-	[    3 ] = KEY_KP1,
-	[    4 ] = KEY_KP2,
-	[    5 ] = KEY_KP3,
-	[    7 ] = KEY_KP4,
-	[    8 ] = KEY_KP5,
-	[    9 ] = KEY_KP6,
-	[   11 ] = KEY_KP7,
-	[   12 ] = KEY_KP8,
-	[   13 ] = KEY_KP9,
-
-	[   14 ] = KEY_MODE,         // Air/Cable
-	[   17 ] = KEY_VIDEO,        // Video
-	[   21 ] = KEY_AUDIO,        // Audio
-	[    0 ] = KEY_POWER,        // Power
-	[   24 ] = KEY_TUNER,        // AV Source
-	[    2 ] = KEY_ZOOM,         // Fullscreen
-	[   26 ] = KEY_LANGUAGE,     // Stereo
-	[   27 ] = KEY_MUTE,         // Mute
-	[   20 ] = KEY_VOLUMEUP,     // Volume +
-	[   23 ] = KEY_VOLUMEDOWN,   // Volume -
-	[   18 ] = KEY_CHANNELUP,    // Channel +
-	[   19 ] = KEY_CHANNELDOWN,  // Channel -
-	[    6 ] = KEY_AGAIN,        // Recall
-	[   16 ] = KEY_ENTER,      // Enter
-};
-
-
-static IR_KEYTAB_TYPE cinergy_codes[IR_KEYTAB_SIZE] = {
-	[    0 ] = KEY_KP0,
-	[    1 ] = KEY_KP1,
-	[    2 ] = KEY_KP2,
-	[    3 ] = KEY_KP3,
-	[    4 ] = KEY_KP4,
-	[    5 ] = KEY_KP5,
-	[    6 ] = KEY_KP6,
-	[    7 ] = KEY_KP7,
-	[    8 ] = KEY_KP8,
-	[    9 ] = KEY_KP9,
-
-	[ 0x0a ] = KEY_POWER,
-	[ 0x0b ] = KEY_PROG1,           // app
-	[ 0x0c ] = KEY_ZOOM,            // zoom/fullscreen
-	[ 0x0d ] = KEY_CHANNELUP,       // channel
-	[ 0x0e ] = KEY_CHANNELDOWN,     // channel-
-	[ 0x0f ] = KEY_VOLUMEUP,
-	[ 0x10 ] = KEY_VOLUMEDOWN,
-	[ 0x11 ] = KEY_TUNER,           // AV
-	[ 0x12 ] = KEY_NUMLOCK,         // -/--
-	[ 0x13 ] = KEY_AUDIO,           // audio
-	[ 0x14 ] = KEY_MUTE,
-	[ 0x15 ] = KEY_UP,
-	[ 0x16 ] = KEY_DOWN,
-	[ 0x17 ] = KEY_LEFT,
-	[ 0x18 ] = KEY_RIGHT,
-	[ 0x19 ] = BTN_LEFT,
-	[ 0x1a ] = BTN_RIGHT,
-	[ 0x1b ] = KEY_WWW,             // text
-	[ 0x1c ] = KEY_REWIND,
-	[ 0x1d ] = KEY_FORWARD,
-	[ 0x1e ] = KEY_RECORD,
-	[ 0x1f ] = KEY_PLAY,
-	[ 0x20 ] = KEY_PREVIOUSSONG,
-	[ 0x21 ] = KEY_NEXTSONG,
-	[ 0x22 ] = KEY_PAUSE,
-	[ 0x23 ] = KEY_STOP,
-};
-
-/* Alfons Geser <a.geser@cox.net>
- * updates from Job D. R. Borges <jobdrb@ig.com.br> */
-static IR_KEYTAB_TYPE eztv_codes[IR_KEYTAB_SIZE] = {
-	[ 18 ] = KEY_POWER,
-	[  1 ] = KEY_TV,             // DVR
-	[ 21 ] = KEY_DVD,            // DVD
-	[ 23 ] = KEY_AUDIO,          // music
-				     // DVR mode / DVD mode / music mode
-
-	[ 27 ] = KEY_MUTE,           // mute
-	[  2 ] = KEY_LANGUAGE,       // MTS/SAP / audio / autoseek
-	[ 30 ] = KEY_SUBTITLE,       // closed captioning / subtitle / seek
-	[ 22 ] = KEY_ZOOM,           // full screen
-	[ 28 ] = KEY_VIDEO,          // video source / eject / delall
-	[ 29 ] = KEY_RESTART,        // playback / angle / del
-	[ 47 ] = KEY_SEARCH,         // scan / menu / playlist
-	[ 48 ] = KEY_CHANNEL,        // CH surfing / bookmark / memo
-
-	[ 49 ] = KEY_HELP,           // help
-	[ 50 ] = KEY_MODE,           // num/memo
-	[ 51 ] = KEY_ESC,            // cancel
-
-	[ 12 ] = KEY_UP,             // up
-	[ 16 ] = KEY_DOWN,           // down
-	[  8 ] = KEY_LEFT,           // left
-	[  4 ] = KEY_RIGHT,          // right
-	[  3 ] = KEY_SELECT,         // select
-
-	[ 31 ] = KEY_REWIND,         // rewind
-	[ 32 ] = KEY_PLAYPAUSE,      // play/pause
-	[ 41 ] = KEY_FORWARD,        // forward
-	[ 20 ] = KEY_AGAIN,          // repeat
-	[ 43 ] = KEY_RECORD,         // recording
-	[ 44 ] = KEY_STOP,           // stop
-	[ 45 ] = KEY_PLAY,           // play
-	[ 46 ] = KEY_SHUFFLE,        // snapshot / shuffle
-
-	[  0 ] = KEY_KP0,
-	[  5 ] = KEY_KP1,
-	[  6 ] = KEY_KP2,
-	[  7 ] = KEY_KP3,
-	[  9 ] = KEY_KP4,
-	[ 10 ] = KEY_KP5,
-	[ 11 ] = KEY_KP6,
-	[ 13 ] = KEY_KP7,
-	[ 14 ] = KEY_KP8,
-	[ 15 ] = KEY_KP9,
-
-	[ 42 ] = KEY_VOLUMEUP,
-	[ 17 ] = KEY_VOLUMEDOWN,
-	[ 24 ] = KEY_CHANNELUP,      // CH.tracking up
-	[ 25 ] = KEY_CHANNELDOWN,    // CH.tracking down
-
-	[ 19 ] = KEY_KPENTER,        // enter
-	[ 33 ] = KEY_KPDOT,          // . (decimal dot)
-};
-
-static IR_KEYTAB_TYPE avacssmart_codes[IR_KEYTAB_SIZE] = {
-	[ 30 ] = KEY_POWER,		// power
-	[ 28 ] = KEY_SEARCH,		// scan
-	[  7 ] = KEY_SELECT,		// source
-
-	[ 22 ] = KEY_VOLUMEUP,
-	[ 20 ] = KEY_VOLUMEDOWN,
-	[ 31 ] = KEY_CHANNELUP,
-	[ 23 ] = KEY_CHANNELDOWN,
-	[ 24 ] = KEY_MUTE,
-
-	[  2 ] = KEY_KP0,
-	[  1 ] = KEY_KP1,
-	[ 11 ] = KEY_KP2,
-	[ 27 ] = KEY_KP3,
-	[  5 ] = KEY_KP4,
-	[  9 ] = KEY_KP5,
-	[ 21 ] = KEY_KP6,
-	[  6 ] = KEY_KP7,
-	[ 10 ] = KEY_KP8,
-	[ 18 ] = KEY_KP9,
-	[ 16 ] = KEY_KPDOT,
-
-	[  3 ] = KEY_TUNER,		// tv/fm
-	[  4 ] = KEY_REWIND,		// fm tuning left or function left
-	[ 12 ] = KEY_FORWARD,		// fm tuning right or function right
-
-	[  0 ] = KEY_RECORD,
-	[  8 ] = KEY_STOP,
-	[ 17 ] = KEY_PLAY,
-
-	[ 25 ] = KEY_ZOOM,
-	[ 14 ] = KEY_MENU,		// function
-	[ 19 ] = KEY_AGAIN,		// recall
-	[ 29 ] = KEY_RESTART,		// reset
-	[ 26 ] = KEY_SHUFFLE,		// snapshot/shuffle
-
-// FIXME
-	[ 13 ] = KEY_F21,		// mts
-	[ 15 ] = KEY_F22,		// min
-};
-
-/* Alex Hermann <gaaf@gmx.net> */
-static IR_KEYTAB_TYPE md2819_codes[IR_KEYTAB_SIZE] = {
-	[ 40 ] = KEY_KP1,
-	[ 24 ] = KEY_KP2,
-	[ 56 ] = KEY_KP3,
-	[ 36 ] = KEY_KP4,
-	[ 20 ] = KEY_KP5,
-	[ 52 ] = KEY_KP6,
-	[ 44 ] = KEY_KP7,
-	[ 28 ] = KEY_KP8,
-	[ 60 ] = KEY_KP9,
-	[ 34 ] = KEY_KP0,
-
-	[ 32 ] = KEY_TV,		// TV/FM
-	[ 16 ] = KEY_CD,		// CD
-	[ 48 ] = KEY_TEXT,		// TELETEXT
-	[  0 ] = KEY_POWER,		// POWER
-
-	[  8 ] = KEY_VIDEO,		// VIDEO
-	[  4 ] = KEY_AUDIO,		// AUDIO
-	[ 12 ] = KEY_ZOOM,		// FULL SCREEN
-
-	[ 18 ] = KEY_SUBTITLE,		// DISPLAY	- ???
-	[ 50 ] = KEY_REWIND,		// LOOP		- ???
-	[  2 ] = KEY_PRINT,		// PREVIEW	- ???
-
-	[ 42 ] = KEY_SEARCH,		// AUTOSCAN
-	[ 26 ] = KEY_SLEEP,		// FREEZE	- ???
-	[ 58 ] = KEY_SHUFFLE,		// SNAPSHOT	- ???
-	[ 10 ] = KEY_MUTE,		// MUTE
-
-	[ 38 ] = KEY_RECORD,		// RECORD
-	[ 22 ] = KEY_PAUSE,		// PAUSE
-	[ 54 ] = KEY_STOP,		// STOP
-	[  6 ] = KEY_PLAY,		// PLAY
-
-	[ 46 ] = KEY_RED,		// <RED>
-	[ 33 ] = KEY_GREEN,		// <GREEN>
-	[ 14 ] = KEY_YELLOW,		// <YELLOW>
-	[  1 ] = KEY_BLUE,		// <BLUE>
-
-	[ 30 ] = KEY_VOLUMEDOWN,	// VOLUME-
-	[ 62 ] = KEY_VOLUMEUP,		// VOLUME+
-	[ 17 ] = KEY_CHANNELDOWN,	// CHANNEL/PAGE-
-	[ 49 ] = KEY_CHANNELUP		// CHANNEL/PAGE+
-};
-
-static IR_KEYTAB_TYPE videomate_tv_pvr_codes[IR_KEYTAB_SIZE] = {
-	[ 20 ] = KEY_MUTE,
-	[ 36 ] = KEY_ZOOM,
-
-	[  1 ] = KEY_DVD,
-	[ 35 ] = KEY_RADIO,
-	[  0 ] = KEY_TV,
-
-	[ 10 ] = KEY_REWIND,
-	[  8 ] = KEY_PLAYPAUSE,
-	[ 15 ] = KEY_FORWARD,
-
-	[  2 ] = KEY_PREVIOUS,
-	[  7 ] = KEY_STOP,
-	[  6 ] = KEY_NEXT,
-
-	[ 12 ] = KEY_UP,
-	[ 14 ] = KEY_DOWN,
-	[ 11 ] = KEY_LEFT,
-	[ 13 ] = KEY_RIGHT,
-	[ 17 ] = KEY_OK,
-
-	[  3 ] = KEY_MENU,
-	[  9 ] = KEY_SETUP,
-	[  5 ] = KEY_VIDEO,
-	[ 34 ] = KEY_CHANNEL,
-
-	[ 18 ] = KEY_VOLUMEUP,
-	[ 21 ] = KEY_VOLUMEDOWN,
-	[ 16 ] = KEY_CHANNELUP,
-	[ 19 ] = KEY_CHANNELDOWN,
-
-	[  4 ] = KEY_RECORD,
-
-	[ 22 ] = KEY_KP1,
-	[ 23 ] = KEY_KP2,
-	[ 24 ] = KEY_KP3,
-	[ 25 ] = KEY_KP4,
-	[ 26 ] = KEY_KP5,
-	[ 27 ] = KEY_KP6,
-	[ 28 ] = KEY_KP7,
-	[ 29 ] = KEY_KP8,
-	[ 30 ] = KEY_KP9,
-	[ 31 ] = KEY_KP0,
-
-	[ 32 ] = KEY_LANGUAGE,
-	[ 33 ] = KEY_SLEEP,
-};
-
-/* Michael Tokarev <mjt@tls.msk.ru>
-   http://www.corpit.ru/mjt/beholdTV/remote_control.jpg
-   keytable is used by MANLI MTV00[12] and BeholdTV 40[13] at
-   least, and probably other cards too.
-   The "ascii-art picture" below (in comments, first row
-   is the keycode in hex, and subsequent row(s) shows
-   the button labels (several variants when appropriate)
-   helps to descide which keycodes to assign to the buttons.
- */
-static IR_KEYTAB_TYPE manli_codes[IR_KEYTAB_SIZE] = {
-
-	/*  0x1c            0x12  *
-	 * FUNCTION         POWER *
-	 *   FM              (|)  *
-	 *                        */
-	[ 0x1c ] = KEY_RADIO,	/*XXX*/
-	[ 0x12 ] = KEY_POWER,
-
-	/*  0x01    0x02    0x03  *
-	 *   1       2       3    *
-	 *                        *
-	 *  0x04    0x05    0x06  *
-	 *   4       5       6    *
-	 *                        *
-	 *  0x07    0x08    0x09  *
-	 *   7       8       9    *
-	 *                        */
-	[ 0x01 ] = KEY_KP1,
-	[ 0x02 ] = KEY_KP2,
-	[ 0x03 ] = KEY_KP3,
-	[ 0x04 ] = KEY_KP4,
-	[ 0x05 ] = KEY_KP5,
-	[ 0x06 ] = KEY_KP6,
-	[ 0x07 ] = KEY_KP7,
-	[ 0x08 ] = KEY_KP8,
-	[ 0x09 ] = KEY_KP9,
-
-	/*  0x0a    0x00    0x17  *
-	 * RECALL    0      +100  *
-	 *                  PLUS  *
-	 *                        */
-	[ 0x0a ] = KEY_AGAIN,	/*XXX KEY_REWIND? */
-	[ 0x00 ] = KEY_KP0,
-	[ 0x17 ] = KEY_DIGITS,	/*XXX*/
-
-	/*  0x14            0x10  *
-	 *  MENU            INFO  *
-	 *  OSD                   */
-	[ 0x14 ] = KEY_MENU,
-	[ 0x10 ] = KEY_INFO,
-
-	/*          0x0b          *
-	 *           Up           *
-	 *                        *
-	 *  0x18    0x16    0x0c  *
-	 *  Left     Ok     Right *
-	 *                        *
-	 *         0x015          *
-	 *         Down           *
-	 *                        */
-	[ 0x0b ] = KEY_UP,	/*XXX KEY_SCROLLUP? */
-	[ 0x18 ] = KEY_LEFT,	/*XXX KEY_BACK? */
-	[ 0x16 ] = KEY_OK,	/*XXX KEY_SELECT? KEY_ENTER? */
-	[ 0x0c ] = KEY_RIGHT,	/*XXX KEY_FORWARD? */
-	[ 0x15 ] = KEY_DOWN,	/*XXX KEY_SCROLLDOWN? */
-
-	/*  0x11            0x0d  *
-	 *  TV/AV           MODE  *
-	 *  SOURCE         STEREO *
-	 *                        */
-	[ 0x11 ] = KEY_TV,	/*XXX*/
-	[ 0x0d ] = KEY_MODE,	/*XXX there's no KEY_STEREO */
-
-	/*  0x0f    0x1b    0x1a  *
-	 *  AUDIO   Vol+    Chan+ *
-	 *        TIMESHIFT???    *
-	 *                        *
-	 *  0x0e    0x1f    0x1e  *
-	 *  SLEEP   Vol-    Chan- *
-	 *                        */
-	[ 0x0f ] = KEY_AUDIO,
-	[ 0x1b ] = KEY_VOLUMEUP,
-	[ 0x1a ] = KEY_CHANNELUP,
-	[ 0x0e ] = KEY_SLEEP,	/*XXX maybe KEY_PAUSE */
-	[ 0x1f ] = KEY_VOLUMEDOWN,
-	[ 0x1e ] = KEY_CHANNELDOWN,
-
-	/*         0x13     0x19  *
-	 *         MUTE   SNAPSHOT*
-	 *                        */
-	[ 0x13 ] = KEY_MUTE,
-	[ 0x19 ] = KEY_RECORD,	/*XXX*/
-
-	// 0x1d unused ?
-};
-
-
-/* Mike Baikov <mike@baikov.com> */
-static IR_KEYTAB_TYPE gotview7135_codes[IR_KEYTAB_SIZE] = {
-
-	[ 33 ] = KEY_POWER,
-	[ 105] = KEY_TV,
-	[ 51 ] = KEY_KP0,
-	[ 81 ] = KEY_KP1,
-	[ 49 ] = KEY_KP2,
-	[ 113] = KEY_KP3,
-	[ 59 ] = KEY_KP4,
-	[ 88 ] = KEY_KP5,
-	[ 65 ] = KEY_KP6,
-	[ 72 ] = KEY_KP7,
-	[ 48 ] = KEY_KP8,
-	[ 83 ] = KEY_KP9,
-	[ 115] = KEY_AGAIN, /* LOOP */
-	[ 10 ] = KEY_AUDIO,
-	[ 97 ] = KEY_PRINT, /* PREVIEW */
-	[ 122] = KEY_VIDEO,
-	[ 32 ] = KEY_CHANNELUP,
-	[ 64 ] = KEY_CHANNELDOWN,
-	[ 24 ] = KEY_VOLUMEDOWN,
-	[ 80 ] = KEY_VOLUMEUP,
-	[ 16 ] = KEY_MUTE,
-	[ 74 ] = KEY_SEARCH,
-	[ 123] = KEY_SHUFFLE, /* SNAPSHOT */
-	[ 34 ] = KEY_RECORD,
-	[ 98 ] = KEY_STOP,
-	[ 120] = KEY_PLAY,
-	[ 57 ] = KEY_REWIND,
-	[ 89 ] = KEY_PAUSE,
-	[ 25 ] = KEY_FORWARD,
-	[  9 ] = KEY_ZOOM,
-
-	[ 82 ] = KEY_F21, /* LIVE TIMESHIFT */
-	[ 26 ] = KEY_F22, /* MIN TIMESHIFT */
-	[ 58 ] = KEY_F23, /* TIMESHIFT */
-	[ 112] = KEY_F24, /* NORMAL TIMESHIFT */
-};
-
-static IR_KEYTAB_TYPE ir_codes_purpletv[IR_KEYTAB_SIZE] = {
-	[ 0x3  ] = KEY_POWER,
-	[ 0x6f ] = KEY_MUTE,
-	[ 0x10 ] = KEY_BACKSPACE,       /* Recall */
-
-	[ 0x11 ] = KEY_KP0,
-	[ 0x4  ] = KEY_KP1,
-	[ 0x5  ] = KEY_KP2,
-	[ 0x6  ] = KEY_KP3,
-	[ 0x8  ] = KEY_KP4,
-	[ 0x9  ] = KEY_KP5,
-	[ 0xa  ] = KEY_KP6,
-	[ 0xc  ] = KEY_KP7,
-	[ 0xd  ] = KEY_KP8,
-	[ 0xe  ] = KEY_KP9,
-	[ 0x12 ] = KEY_KPDOT,           /* 100+ */
-
-	[ 0x7  ] = KEY_VOLUMEUP,
-	[ 0xb  ] = KEY_VOLUMEDOWN,
-	[ 0x1a ] = KEY_KPPLUS,
-	[ 0x18 ] = KEY_KPMINUS,
-	[ 0x15 ] = KEY_UP,
-	[ 0x1d ] = KEY_DOWN,
-	[ 0xf  ] = KEY_CHANNELUP,
-	[ 0x13 ] = KEY_CHANNELDOWN,
-	[ 0x48 ] = KEY_ZOOM,
-
-	[ 0x1b ] = KEY_VIDEO,           /* Video source */
-	[ 0x49 ] = KEY_LANGUAGE,        /* MTS Select */
-	[ 0x19 ] = KEY_SEARCH,          /* Auto Scan */
-
-	[ 0x4b ] = KEY_RECORD,
-	[ 0x46 ] = KEY_PLAY,
-	[ 0x45 ] = KEY_PAUSE,           /* Pause */
-	[ 0x44 ] = KEY_STOP,
-	[ 0x40 ] = KEY_FORWARD,         /* Forward ? */
-	[ 0x42 ] = KEY_REWIND,          /* Backward ? */
-
-};
-
-/* Mapping for the 28 key remote control as seen at
-   http://www.sednacomputer.com/photo/cardbus-tv.jpg
-   Pavel Mihaylov <bin@bash.info> */
-static IR_KEYTAB_TYPE pctv_sedna_codes[IR_KEYTAB_SIZE] = {
-	[    0 ] = KEY_KP0,
-	[    1 ] = KEY_KP1,
-	[    2 ] = KEY_KP2,
-	[    3 ] = KEY_KP3,
-	[    4 ] = KEY_KP4,
-	[    5 ] = KEY_KP5,
-	[    6 ] = KEY_KP6,
-	[    7 ] = KEY_KP7,
-	[    8 ] = KEY_KP8,
-	[    9 ] = KEY_KP9,
-
-	[ 0x0a ] = KEY_AGAIN,          /* Recall */
-	[ 0x0b ] = KEY_CHANNELUP,
-	[ 0x0c ] = KEY_VOLUMEUP,
-	[ 0x0d ] = KEY_MODE,           /* Stereo */
-	[ 0x0e ] = KEY_STOP,
-	[ 0x0f ] = KEY_PREVIOUSSONG,
-	[ 0x10 ] = KEY_ZOOM,
-	[ 0x11 ] = KEY_TUNER,          /* Source */
-	[ 0x12 ] = KEY_POWER,
-	[ 0x13 ] = KEY_MUTE,
-	[ 0x15 ] = KEY_CHANNELDOWN,
-	[ 0x18 ] = KEY_VOLUMEDOWN,
-	[ 0x19 ] = KEY_SHUFFLE,        /* Snapshot */
-	[ 0x1a ] = KEY_NEXTSONG,
-	[ 0x1b ] = KEY_TEXT,           /* Time Shift */
-	[ 0x1c ] = KEY_RADIO,          /* FM Radio */
-	[ 0x1d ] = KEY_RECORD,
-	[ 0x1e ] = KEY_PAUSE,
-};
-
-
 /* -------------------- GPIO generic keycode builder -------------------- */
 
 static int build_key(struct saa7134_dev *dev)
@@ -628,27 +149,27 @@ int saa7134_input_init1(struct saa7134_d
 	case SAA7134_BOARD_FLYVIDEO3000:
 	case SAA7134_BOARD_FLYTVPLATINUM_FM:
 	case SAA7134_BOARD_FLYTVPLATINUM_MINI2:
-		ir_codes     = flyvideo_codes;
+		ir_codes     = ir_codes_flyvideo;
 		mask_keycode = 0xEC00000;
 		mask_keydown = 0x0040000;
 		break;
 	case SAA7134_BOARD_CINERGY400:
 	case SAA7134_BOARD_CINERGY600:
 	case SAA7134_BOARD_CINERGY600_MK3:
-		ir_codes     = cinergy_codes;
+		ir_codes     = ir_codes_cinergy;
 		mask_keycode = 0x00003f;
 		mask_keyup   = 0x040000;
 		break;
 	case SAA7134_BOARD_ECS_TVP3XP:
 	case SAA7134_BOARD_ECS_TVP3XP_4CB5:
-		ir_codes     = eztv_codes;
+		ir_codes     = ir_codes_eztv;
 		mask_keycode = 0x00017c;
 		mask_keyup   = 0x000002;
 		polling      = 50; // ms
 		break;
 	case SAA7134_BOARD_KWORLD_XPERT:
 	case SAA7134_BOARD_AVACSSMARTTV:
-		ir_codes     = avacssmart_codes;
+		ir_codes     = ir_codes_avacssmart;
 		mask_keycode = 0x00001F;
 		mask_keyup   = 0x000020;
 		polling      = 50; // ms
@@ -660,7 +181,7 @@ int saa7134_input_init1(struct saa7134_d
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_305:
 	case SAA7134_BOARD_AVERMEDIA_STUDIO_307:
 	case SAA7134_BOARD_AVERMEDIA_GO_007_FM:
-		ir_codes     = md2819_codes;
+		ir_codes     = ir_codes_md2819;
 		mask_keycode = 0x0007C8;
 		mask_keydown = 0x000010;
 		polling      = 50; // ms
@@ -669,7 +190,7 @@ int saa7134_input_init1(struct saa7134_d
 		saa_setb(SAA7134_GPIO_GPSTATUS0, 0x4);
 		break;
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
-		ir_codes     = avacssmart_codes;
+		ir_codes     = ir_codes_avacssmart;
 		mask_keycode = 0x00001f;
 		mask_keyup   = 0x000060;
 		polling      = 50; // ms
@@ -677,19 +198,19 @@ int saa7134_input_init1(struct saa7134_d
 	case SAA7134_BOARD_MANLI_MTV001:
 	case SAA7134_BOARD_MANLI_MTV002:
 	case SAA7134_BOARD_BEHOLD_409FM:
-		ir_codes     = manli_codes;
+		ir_codes     = ir_codes_manli;
 		mask_keycode = 0x001f00;
 		mask_keyup   = 0x004000;
 		polling      = 50; // ms
 		break;
 	case SAA7134_BOARD_SEDNA_PC_TV_CARDBUS:
-		ir_codes     = pctv_sedna_codes;
+		ir_codes     = ir_codes_pctv_sedna;
 		mask_keycode = 0x001f00;
 		mask_keyup   = 0x004000;
 		polling      = 50; // ms
 		break;
 	case SAA7134_BOARD_GOTVIEW_7135:
-		ir_codes     = gotview7135_codes;
+		ir_codes     = ir_codes_gotview7135;
 		mask_keycode = 0x0003EC;
 		mask_keyup   = 0x008000;
 		mask_keydown = 0x000010;
@@ -698,14 +219,14 @@ int saa7134_input_init1(struct saa7134_d
 	case SAA7134_BOARD_VIDEOMATE_TV_PVR:
 	case SAA7134_BOARD_VIDEOMATE_GOLD_PLUS:
 	case SAA7134_BOARD_VIDEOMATE_TV_GOLD_PLUSII:
-		ir_codes     = videomate_tv_pvr_codes;
+		ir_codes     = ir_codes_videomate_tv_pvr;
 		mask_keycode = 0x00003F;
 		mask_keyup   = 0x400000;
 		polling      = 50; // ms
 		break;
 	case SAA7134_BOARD_VIDEOMATE_DVBT_300:
 	case SAA7134_BOARD_VIDEOMATE_DVBT_200:
-		ir_codes     = videomate_tv_pvr_codes;
+		ir_codes     = ir_codes_videomate_tv_pvr;
 		mask_keycode = 0x003F00;
 		mask_keyup   = 0x040000;
 		break;
diff --git a/include/media/ir-common.h b/include/media/ir-common.h
diff --git a/include/media/ir-common.h b/include/media/ir-common.h
index ad3e9bb..50fe522 100644
--- a/include/media/ir-common.h
+++ b/include/media/ir-common.h
@@ -47,13 +47,6 @@ struct ir_input_state {
 	int                keypressed;  /* current state */
 };
 
-extern IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE];
-extern IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE];
-extern IR_KEYTAB_TYPE ir_codes_pinnacle[IR_KEYTAB_SIZE];
-extern IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE];
-extern IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE];
-extern IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE];
-
 void ir_input_init(struct input_dev *dev, struct ir_input_state *ir,
 		   int ir_type, IR_KEYTAB_TYPE *ir_codes);
 void ir_input_nokey(struct input_dev *dev, struct ir_input_state *ir);
@@ -64,6 +57,41 @@ int  ir_dump_samples(u32 *samples, int c
 int  ir_decode_biphase(u32 *samples, int count, int low, int high);
 int  ir_decode_pulsedistance(u32 *samples, int count, int low, int high);
 
+/* Keymaps to be used by other modules */
+
+extern IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_avermedia_dvbt[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_apac_viewcomp[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_conceptronic[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_nebula[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_dntv_live_dvb_t[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_iodata_bctv7e[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_adstech_dvb_t_pci[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_msi_tvanywhere[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_cinergy_1400[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_avertv_303[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_dntv_live_dvbt_pro[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_em_terratec[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_em_pinnacle_usb[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_flyvideo[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_flydvb[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_cinergy[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_eztv[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_avacssmart[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_md2819[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_videomate_tv_pvr[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_manli[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_gotview7135[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_purpletv[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_pctv_sedna[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_pv951[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_pinnacle[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE];
+
 #endif
 
 /*

