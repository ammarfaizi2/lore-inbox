Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVCHKwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVCHKwA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCHKwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:52:00 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:13547 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261993AbVCHKpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:45:23 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:43:54 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: IR common update
Message-ID: <20050308104354.GA30665@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
 * add some keytables which are used by both bttv and cx88 driver
   so they can be shared.
 * add IR decoding helper functions.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/common/ir-common.c |  164 ++++++++++++++++++++++++++++++-
 include/media/ir-common.h        |    6 -
 2 files changed, 167 insertions(+), 3 deletions(-)

Index: linux-2.6.11/include/media/ir-common.h
===================================================================
--- linux-2.6.11.orig/include/media/ir-common.h	2005-03-07 10:15:15.000000000 +0100
+++ linux-2.6.11/include/media/ir-common.h	2005-03-07 16:17:34.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.h,v 1.6 2004/09/15 16:15:24 kraxel Exp $
+ * $Id: ir-common.h,v 1.8 2005/02/22 12:28:40 kraxel Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -47,7 +47,9 @@ struct ir_input_state {
 };
 
 extern IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE];
 extern IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE];
+extern IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE];
 
 void ir_input_init(struct input_dev *dev, struct ir_input_state *ir,
 		   int ir_type, IR_KEYTAB_TYPE *ir_codes);
@@ -55,6 +57,8 @@ void ir_input_nokey(struct input_dev *de
 void ir_input_keydown(struct input_dev *dev, struct ir_input_state *ir,
 		      u32 ir_key, u32 ir_raw);
 u32  ir_extract_bits(u32 data, u32 mask);
+int  ir_dump_samples(u32 *samples, int count);
+int  ir_decode_biphase(u32 *samples, int count, int low, int high);
 
 /*
  * Local variables:
Index: linux-2.6.11/drivers/media/common/ir-common.c
===================================================================
--- linux-2.6.11.orig/drivers/media/common/ir-common.c	2005-03-07 10:14:43.000000000 +0100
+++ linux-2.6.11/drivers/media/common/ir-common.c	2005-03-07 16:17:34.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-common.c,v 1.6 2004/12/10 12:33:39 kraxel Exp $
+ * $Id: ir-common.c,v 1.8 2005/02/22 12:28:40 kraxel Exp $
  *
  * some common structs and functions to handle infrared remotes via
  * input layer ...
@@ -23,7 +23,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-
 #include <media/ir-common.h>
 
 /* -------------------------------------------------------------------------- */
@@ -45,6 +44,7 @@ module_param(debug, int, 0644);
 
 /* generic RC5 keytable                                          */
 /* see http://users.pandora.be/nenya/electronics/rc5/codes00.htm */
+/* used by old (black) Hauppauge remotes                         */
 IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB_SIZE] = {
 	[ 0x00 ] = KEY_KP0,             // 0
 	[ 0x01 ] = KEY_KP1,             // 1
@@ -117,12 +117,102 @@ IR_KEYTAB_TYPE ir_codes_rc5_tv[IR_KEYTAB
 };
 EXPORT_SYMBOL_GPL(ir_codes_rc5_tv);
 
+/* Table for Leadtek Winfast Remote Controls - used by both bttv and cx88 */
+IR_KEYTAB_TYPE ir_codes_winfast[IR_KEYTAB_SIZE] = {
+	[  5 ] = KEY_KP1,
+	[  6 ] = KEY_KP2,
+	[  7 ] = KEY_KP3,
+	[  9 ] = KEY_KP4,
+	[ 10 ] = KEY_KP5,
+	[ 11 ] = KEY_KP6,
+	[ 13 ] = KEY_KP7,
+	[ 14 ] = KEY_KP8,
+	[ 15 ] = KEY_KP9,
+	[ 18 ] = KEY_KP0,
+
+	[  0 ] = KEY_POWER,
+//      [ 27 ] = MTS button
+	[  2 ] = KEY_TUNER,     // TV/FM
+	[ 30 ] = KEY_VIDEO,
+//      [ 22 ] = display button
+	[  4 ] = KEY_VOLUMEUP,
+	[  8 ] = KEY_VOLUMEDOWN,
+	[ 12 ] = KEY_CHANNELUP,
+	[ 16 ] = KEY_CHANNELDOWN,
+	[  3 ] = KEY_ZOOM,      // fullscreen
+	[ 31 ] = KEY_SUBTITLE,  // closed caption/teletext
+	[ 32 ] = KEY_SLEEP,
+//      [ 41 ] = boss key
+	[ 20 ] = KEY_MUTE,
+	[ 43 ] = KEY_RED,
+	[ 44 ] = KEY_GREEN,
+	[ 45 ] = KEY_YELLOW,
+	[ 46 ] = KEY_BLUE,
+	[ 24 ] = KEY_KPPLUS,    //fine tune +
+	[ 25 ] = KEY_KPMINUS,   //fine tune -
+//      [ 42 ] = picture in picture
+        [ 33 ] = KEY_KPDOT,
+	[ 19 ] = KEY_KPENTER,
+//      [ 17 ] = recall
+	[ 34 ] = KEY_BACK,
+	[ 35 ] = KEY_PLAYPAUSE,
+	[ 36 ] = KEY_NEXT,
+//      [ 37 ] = time shifting
+	[ 38 ] = KEY_STOP,
+	[ 39 ] = KEY_RECORD
+//      [ 40 ] = snapshot
+};
+EXPORT_SYMBOL_GPL(ir_codes_winfast);
+
 /* empty keytable, can be used as placeholder for not-yet created keytables */
 IR_KEYTAB_TYPE ir_codes_empty[IR_KEYTAB_SIZE] = {
 	[ 42 ] = KEY_COFFEE,
 };
 EXPORT_SYMBOL_GPL(ir_codes_empty);
 
+/* Hauppauge: the newer, gray remotes (seems there are multiple
+ * slightly different versions), shipped with cx88+ivtv cards.
+ * almost rc5 coding, but some non-standard keys */
+IR_KEYTAB_TYPE ir_codes_hauppauge_new[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_KP0,             // 0
+	[ 0x01 ] = KEY_KP1,             // 1
+	[ 0x02 ] = KEY_KP2,             // 2
+	[ 0x03 ] = KEY_KP3,             // 3
+	[ 0x04 ] = KEY_KP4,             // 4
+	[ 0x05 ] = KEY_KP5,             // 5
+	[ 0x06 ] = KEY_KP6,             // 6
+	[ 0x07 ] = KEY_KP7,             // 7
+	[ 0x08 ] = KEY_KP8,             // 8
+	[ 0x09 ] = KEY_KP9,             // 9
+	[ 0x0b ] = KEY_RED,             // red button
+	[ 0x0c ] = KEY_OPTION,          // black key without text
+	[ 0x0d ] = KEY_MENU,            // menu
+	[ 0x0f ] = KEY_MUTE,            // mute
+	[ 0x10 ] = KEY_VOLUMEUP,        // volume +
+	[ 0x11 ] = KEY_VOLUMEDOWN,      // volume -
+	[ 0x1e ] = KEY_NEXT,            // skip >|
+	[ 0x1f ] = KEY_EXIT,            // back/exit
+	[ 0x20 ] = KEY_CHANNELUP,       // channel / program +
+	[ 0x21 ] = KEY_CHANNELDOWN,     // channel / program -
+	[ 0x22 ] = KEY_CHANNEL,         // source (old black remote)
+	[ 0x24 ] = KEY_PREVIOUS,        // replay |<
+	[ 0x25 ] = KEY_ENTER,           // OK
+	[ 0x26 ] = KEY_SLEEP,           // minimize (old black remote)
+	[ 0x29 ] = KEY_BLUE,            // blue key
+	[ 0x2e ] = KEY_GREEN,           // green button
+	[ 0x30 ] = KEY_PAUSE,           // pause
+	[ 0x32 ] = KEY_REWIND,          // backward <<
+	[ 0x34 ] = KEY_FASTFORWARD,     // forward >>
+	[ 0x35 ] = KEY_PLAY,            // play
+	[ 0x36 ] = KEY_STOP,            // stop
+	[ 0x37 ] = KEY_RECORD,          // recording
+	[ 0x38 ] = KEY_YELLOW,          // yellow key
+	[ 0x3b ] = KEY_SELECT,          // top right button
+	[ 0x3c ] = KEY_ZOOM,            // full
+	[ 0x3d ] = KEY_POWER,           // system power (green button)
+};
+EXPORT_SYMBOL(ir_codes_hauppauge_new);
+
 /* -------------------------------------------------------------------------- */
 
 static void ir_input_key_event(struct input_dev *dev, struct ir_input_state *ir)
@@ -192,6 +282,8 @@ void ir_input_keydown(struct input_dev *
 #endif
 }
 
+/* -------------------------------------------------------------------------- */
+
 u32 ir_extract_bits(u32 data, u32 mask)
 {
 	int mbit, vbit;
@@ -209,10 +301,78 @@ u32 ir_extract_bits(u32 data, u32 mask)
 	return value;
 }
 
+static int inline getbit(u32 *samples, int bit)
+{
+	return (samples[bit/32] & (1 << (31-(bit%32)))) ? 1 : 0;
+}
+
+/* sump raw samples for visual debugging ;) */
+int ir_dump_samples(u32 *samples, int count)
+{
+	int i, bit, start;
+
+	printk(KERN_DEBUG "ir samples: ");
+	start = 0;
+	for (i = 0; i < count * 32; i++) {
+		bit = getbit(samples,i);
+		if (bit)
+			start = 1;
+		if (0 == start)
+			continue;
+		printk("%s", bit ? "#" : "_");
+	}
+	printk("\n");
+	return 0;
+}
+
+/* decode raw samples, biphase coding, used by rc5 for example */
+int ir_decode_biphase(u32 *samples, int count, int low, int high)
+{
+	int i,last,bit,len,flips;
+	u32 value;
+
+	/* find start bit (1) */
+	for (i = 0; i < 32; i++) {
+		bit = getbit(samples,i);
+		if (bit)
+			break;
+	}
+
+	/* go decoding */
+	len   = 0;
+	flips = 0;
+	value = 1;
+	for (; i < count * 32; i++) {
+		if (len > high)
+			break;
+		if (flips > 1)
+			break;
+		last = bit;
+		bit  = getbit(samples,i);
+		if (last == bit) {
+			len++;
+			continue;
+		}
+		if (len < low) {
+			len++;
+			flips++;
+			continue;
+		}
+		value <<= 1;
+		value |= bit;
+		flips = 0;
+		len   = 1;
+	}
+	return value;
+}
+
 EXPORT_SYMBOL_GPL(ir_input_init);
 EXPORT_SYMBOL_GPL(ir_input_nokey);
 EXPORT_SYMBOL_GPL(ir_input_keydown);
+
 EXPORT_SYMBOL_GPL(ir_extract_bits);
+EXPORT_SYMBOL_GPL(ir_dump_samples);
+EXPORT_SYMBOL_GPL(ir_decode_biphase);
 
 /*
  * Local variables:

-- 
#define printk(args...) fprintf(stderr, ## args)
