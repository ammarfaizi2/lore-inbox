Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271313AbUJVNLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbUJVNLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 09:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271321AbUJVNIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 09:08:39 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:2481 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271310AbUJVNAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 09:00:30 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 22 Oct 2004 14:50:29 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv IR input update
Message-ID: <20041022125029.GA5352@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update for the IR input modules for the bttv driver.
It adds IR support to more TV cards and has some some minor
cleanups.

It also removes all trailing whitespaces.  I've a script to remove
them from my sources now, that should kill those no-op whitespace
changes in my patches after merging this initial cleanup.

  Gerd

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/ir-kbd-gpio.c |  107 ++++++++++++++++++++++++++++--
 drivers/media/video/ir-kbd-i2c.c  |   47 ++++++-------
 2 files changed, 125 insertions(+), 29 deletions(-)

diff -up linux-2.6.9-rc2/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.9-rc2/drivers/media/video/ir-kbd-gpio.c	2004-09-14 10:37:16.000000000 +0200
+++ linux/drivers/media/video/ir-kbd-gpio.c	2004-09-17 14:56:37.457852450 +0200
@@ -1,5 +1,6 @@
-
 /*
+ * $Id: ir-kbd-gpio.c,v 1.10 2004/09/15 16:15:24 kraxel Exp $
+ *
  * Copyright (c) 2003 Gerd Knorr
  * Copyright (c) 2003 Pavel Machek
  *
@@ -45,7 +46,7 @@ static IR_KEYTAB_TYPE ir_codes_avermedia
 	[ 60 ] = KEY_KP9,
 
 	[ 48 ] = KEY_EJECTCD,     // Unmarked on my controller
-	[  0 ] = KEY_POWER, 
+	[  0 ] = KEY_POWER,
 	[ 18 ] = BTN_LEFT,        // DISPLAY/L
 	[ 50 ] = BTN_RIGHT,       // LOOP/R
 	[ 10 ] = KEY_MUTE,
@@ -74,6 +75,45 @@ static IR_KEYTAB_TYPE ir_codes_avermedia
 	[  1 ] = KEY_BLUE,        // unmarked
 };
 
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
 static IR_KEYTAB_TYPE winfast_codes[IR_KEYTAB_SIZE] = {
 	[  5 ] = KEY_KP1,
 	[  6 ] = KEY_KP2,
@@ -130,7 +170,7 @@ static IR_KEYTAB_TYPE ir_codes_pixelview
 	[  6 ] = KEY_KP7,
 	[ 10 ] = KEY_KP8,
 	[ 18 ] = KEY_KP9,
-	
+
 	[  3 ] = KEY_TUNER,       // TV/FM
 	[  7 ] = KEY_SEARCH,      // scan
 	[ 28 ] = KEY_ZOOM,        // full screen
@@ -140,7 +180,7 @@ static IR_KEYTAB_TYPE ir_codes_pixelview
 	[ 20 ] = KEY_CHANNELDOWN,
 	[ 22 ] = KEY_CHANNELUP,
 	[ 24 ] = KEY_MUTE,
-	
+
 	[  0 ] = KEY_LIST,        // source
 	[ 19 ] = KEY_INFO,        // loop
 	[ 16 ] = KEY_LAST,        // +100
@@ -151,6 +191,47 @@ static IR_KEYTAB_TYPE ir_codes_pixelview
 	[ 15 ] = KEY_STOP,         // freeze
 };
 
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
 /* ---------------------------------------------------------------------- */
 
 struct IR {
@@ -202,7 +283,7 @@ static void ir_handle_key(struct IR *ir)
 			return;
 		ir->last_gpio = gpio;
 	}
-	
+
 	/* extract data */
 	data = ir_extract_bits(gpio, ir->mask_keycode);
 	dprintk(DEVNAME ": irq gpio=0x%x code=%d | %s%s%s\n",
@@ -284,6 +365,14 @@ static int ir_probe(struct device *dev)
 		ir->polling      = 50; // ms
 		break;
 
+	case BTTV_AVDVBT_761:
+	/* case BTTV_AVDVBT_771: */
+		ir_codes         = ir_codes_avermedia_dvbt;
+		ir->mask_keycode = 0x0f00c0;
+		ir->mask_keydown = 0x000020;
+		ir->polling      = 50; // ms
+		break;
+
 	case BTTV_PXELVWPLTVPAK:
 		ir_codes         = ir_codes_pixelview;
 		ir->mask_keycode = 0x003e00;
@@ -308,6 +397,12 @@ static int ir_probe(struct device *dev)
 		ir->mask_keycode = 0x0008e000;
 		ir->mask_keydown = 0x00200000;
 		break;
+	case BTTV_APAC_VIEWCOMP:
+		ir_codes         = ir_codes_apac_viewcomp;
+		ir->mask_keycode = 0x001f00;
+		ir->mask_keyup   = 0x008000;
+		ir->polling      = 50; // ms
+		break;
 	}
 	if (NULL == ir_codes) {
 		kfree(ir);
@@ -317,7 +412,7 @@ static int ir_probe(struct device *dev)
 	/* init hardware-specific stuff */
 	bttv_gpio_inout(sub->core, ir->mask_keycode | ir->mask_keydown, 0);
 	ir->sub = sub;
-	
+
 	/* init input device */
 	snprintf(ir->name, sizeof(ir->name), "bttv IR (card=%d)",
 		 sub->core->type);
diff -up linux-2.6.9-rc2/drivers/media/video/ir-kbd-i2c.c linux/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.9-rc2/drivers/media/video/ir-kbd-i2c.c	2004-09-14 10:34:32.000000000 +0200
+++ linux/drivers/media/video/ir-kbd-i2c.c	2004-09-17 14:56:37.460851888 +0200
@@ -1,4 +1,6 @@
 /*
+ * $Id: ir-kbd-i2c.c,v 1.8 2004/09/15 16:15:24 kraxel Exp $
+ *
  * keyboard input driver for i2c IR remote controls
  *
  * Copyright (c) 2000-2003 Gerd Knorr <kraxel@bytesex.org>
@@ -156,7 +158,7 @@ module_param(debug, int, 0644);    /* de
 static inline int reverse(int data, int bits)
 {
 	int i,c;
-	
+
 	for (c=0,i=0; i<bits; i++) {
 		c |= (((data & (1<<i)) ? 1:0)) << (bits-1-i);
 	}
@@ -193,7 +195,7 @@ static int get_key_haup(struct IR *ir, u
 static int get_key_pixelview(struct IR *ir, u32 *ir_key, u32 *ir_raw)
 {
         unsigned char b;
-	
+
 	/* poll IR chip */
 	if (1 != i2c_master_recv(&ir->c,&b,1)) {
 		dprintk(1,"read error\n");
@@ -207,7 +209,7 @@ static int get_key_pixelview(struct IR *
 static int get_key_pv951(struct IR *ir, u32 *ir_key, u32 *ir_raw)
 {
         unsigned char b;
-	
+
 	/* poll IR chip */
 	if (1 != i2c_master_recv(&ir->c,&b,1)) {
 		dprintk(1,"read error\n");
@@ -218,7 +220,7 @@ static int get_key_pv951(struct IR *ir, 
 	if (b==0xaa)
 		return 0;
 	dprintk(2,"key %02x\n", b);
-	
+
 	*ir_key = b;
 	*ir_raw = b;
 	return 1;
@@ -227,26 +229,26 @@ static int get_key_pv951(struct IR *ir, 
 static int get_key_knc1(struct IR *ir, u32 *ir_key, u32 *ir_raw)
 {
 	unsigned char b;
-	
+
 	/* poll IR chip */
 	if (1 != i2c_master_recv(&ir->c,&b,1)) {
 		dprintk(1,"read error\n");
 		return -EIO;
 	}
-	
+
 	/* it seems that 0xFE indicates that a button is still hold
 	   down, while 0xFF indicates that no button is hold
 	   down. 0xFE sequences are sometimes interrupted by 0xFF */
-	
+
 	dprintk(2,"key %02x\n", b);
-	
+
 	if (b == 0xFF)
 		return 0;
-	
+
 	if (b == 0xFE)
 		/* keep old data */
 		return 1;
-	
+
 	*ir_key = b;
 	*ir_raw = b;
 	return 1;
@@ -323,7 +325,7 @@ static struct i2c_driver driver = {
         .detach_client  = ir_detach,
 };
 
-static struct i2c_client client_template = 
+static struct i2c_client client_template =
 {
         I2C_DEVNAME("unset"),
         .driver = &driver
@@ -336,7 +338,7 @@ static int ir_attach(struct i2c_adapter 
 	char *name;
 	int ir_type;
         struct IR *ir;
-		
+
         if (NULL == (ir = kmalloc(sizeof(struct IR),GFP_KERNEL)))
                 return -ENOMEM;
 	memset(ir,0,sizeof(*ir));
@@ -400,14 +402,14 @@ static int ir_attach(struct i2c_adapter 
 	input_register_device(&ir->input);
 	printk(DEVNAME ": %s detected at %s [%s]\n",
 	       ir->input.name,ir->input.phys,adap->name);
-	       
+
 	/* start polling via eventd */
 	INIT_WORK(&ir->work, ir_work, ir);
 	init_timer(&ir->timer);
 	ir->timer.function = ir_timer;
 	ir->timer.data     = (unsigned long)ir;
 	schedule_work(&ir->work);
-	
+
 	return 0;
 }
 
@@ -430,16 +432,16 @@ static int ir_detach(struct i2c_client *
 
 static int ir_probe(struct i2c_adapter *adap)
 {
-	
+
 	/* The external IR receiver is at i2c address 0x34 (0x35 for
 	   reads).  Future Hauppauge cards will have an internal
 	   receiver at 0x30 (0x31 for reads).  In theory, both can be
 	   fitted, and Hauppauge suggest an external overrides an
-	   internal. 
-	   
-	   That's why we probe 0x1a (~0x34) first. CB 
+	   internal.
+
+	   That's why we probe 0x1a (~0x34) first. CB
 	*/
-	
+
 	static const int probe_bttv[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, -1};
 	static const int probe_saa7134[] = { 0x7a, -1};
 	const int *probe = NULL;
@@ -478,13 +480,12 @@ MODULE_AUTHOR("Gerd Knorr, Michal Kochan
 MODULE_DESCRIPTION("input driver for i2c IR remote controls");
 MODULE_LICENSE("GPL");
 
-static int ir_init(void)
+static int __init ir_init(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void ir_fini(void)
+static void __exit ir_fini(void)
 {
 	i2c_del_driver(&driver);
 }

-- 
return -ENOSIG;
