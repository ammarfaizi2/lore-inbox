Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUFRKGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUFRKGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 06:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbUFRKGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 06:06:19 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:9667 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265091AbUFRKEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 06:04:09 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 18 Jun 2004 11:50:15 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv driver update
Message-ID: <20040618095015.GA24361@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This is a update of the bttv driver.  Changes:

  * some card-specific fixes + new cards.
  * separate buffer switching for video frames and vbi data,
    that should make bttv less sensitive to high irq latencies.

Please apply,

  Gerd

diff -up linux-2.6.7/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.7/drivers/media/video/bttv-cards.c	2004-06-17 10:29:05.000000000 +0200
+++ linux/drivers/media/video/bttv-cards.c	2004-06-17 13:47:59.425340155 +0200
@@ -71,6 +71,9 @@ static void gvc1100_muxsel(struct bttv *
 
 static void PXC200_muxsel(struct bttv *btv, unsigned int input);
 
+static void picolo_tetra_muxsel(struct bttv *btv, unsigned int input);
+static void picolo_tetra_init(struct bttv *btv);
+
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
 static int tea5757_write(struct bttv *btv, int value);
@@ -181,6 +184,7 @@ static struct CARD {
 	{ 0xff00bd11, BTTV_PINNACLE,      "Pinnacle PCTV [bswap]" },
 
 	{ 0x3000121a, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },
+	{ 0x263710b4, BTTV_VOODOOTV_FM,   "3Dfx VoodooTV FM/ VoodooTV 200" },
 	{ 0x3060121a, BTTV_STB2,	  "3Dfx VoodooTV 100/ STB OEM" },
 	
 	{ 0x3000144f, BTTV_MAGICTVIEW063, "(Askey Magic/others) TView99 CPH06x" },
@@ -260,12 +264,15 @@ static struct CARD {
 	{ 0x41424344, BTTV_GRANDTEC,      "GrandTec Multi Capture" },
 	{ 0x01020304, BTTV_XGUARD,        "Grandtec Grand X-Guard" },
 	
-    	{ 0x010115cb, BTTV_GMV1,          "AG GMV1" },
-	{ 0x010114c7, BTTV_MODTEC_205,    "Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV" },
 	{ 0x18501851, BTTV_CHRONOS_VS2,   "FlyVideo 98 (LR50)/ Chronos Video Shuttle II" },
 	{ 0x18511851, BTTV_FLYVIDEO98EZ,  "FlyVideo 98EZ (LR51)/ CyberMail AV" },
 	{ 0x18521852, BTTV_TYPHOON_TVIEW, "FlyVideo 98FM (LR50)/ Typhoon TView TV/FM Tuner" },
 	{ 0x41a0a051, BTTV_FLYVIDEO_98FM, "Lifeview FlyVideo 98 LR50 Rev Q" },
+	{ 0x18501f7f, BTTV_FLYVIDEO_98,   "Lifeview Flyvideo 98" },
+
+    	{ 0x010115cb, BTTV_GMV1,          "AG GMV1" },
+	{ 0x010114c7, BTTV_MODTEC_205,    "Modular Technology MM201/MM202/MM205/MM210/MM215 PCTV" },
+
 	{ 0x10b42636, BTTV_HAUPPAUGE878,  "STB ???" },
 	{ 0x217d6606, BTTV_WINFAST2000,   "Leadtek WinFast TV 2000" },
 	{ 0xfff6f6ff, BTTV_WINFAST2000,   "Leadtek WinFast TV 2000" },
@@ -280,14 +287,21 @@ static struct CARD {
 	{ 0x40111554, BTTV_PV_BT878P_9B,  "Prolink Pixelview PV-BT" },
 	{ 0x17de0a01, BTTV_KWORLD,        "Mecer TV/FM/Video Tuner" },
 
+	{ 0x01051805, BTTV_PICOLO_TETRA_CHIP, "Picolo Tetra Chip #1" },
+	{ 0x01061805, BTTV_PICOLO_TETRA_CHIP, "Picolo Tetra Chip #2" },
+	{ 0x01071805, BTTV_PICOLO_TETRA_CHIP, "Picolo Tetra Chip #3" },
+	{ 0x01081805, BTTV_PICOLO_TETRA_CHIP, "Picolo Tetra Chip #4" },
+
 	// likely broken, vendor id doesn't match the other magic views ...
 	//{ 0xa0fca04f, BTTV_MAGICTVIEW063, "Guillemot Maxi TV Video 3" },
 	
 	// DVB cards (using pci function .1 for mpeg data xfer)
 	{ 0x01010071, BTTV_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
+	{ 0x07611461, BTTV_NEBULA_DIGITV, "AverMedia AverTV DVB-T" },
 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
 	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
+	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia DVB-T 771" },
 	
 	{ 0, -1, NULL }
 };
@@ -835,7 +849,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs		= 2,
 	.gpiomask	= 0x03000F,
 	.muxsel		= { 2, 3, 1, 1},
-	.audiomux	= { 2, 0, 0, 0, 1},
+	.audiomux	= { 2, 0xd0001, 0, 0, 1},
 	.needs_tvaudio	= 0,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
@@ -1646,6 +1660,7 @@ struct tvcard bttv_tvcards[] = {
 	.muxsel         = { 3, 0, 1, 2},
 	.needs_tvaudio  = 0, 
 	.pll            = PLL_28,
+	.no_gpioirq     = 1,
 },{
         .name           = "Formac ProTV II (bt878)",
         .video_inputs   = 4,
@@ -2012,6 +2027,57 @@ struct tvcard bttv_tvcards[] = {
 	.tuner_type     = TUNER_PHILIPS_PAL,
 	.has_remote     = 1,
 	.has_radio      = 1,
+},{
+	/*Eric DEBIEF <debief@telemsa.com>*/
+	/*EURESYS Picolo Tetra : 4 Conexant Fusion 878A, no audio, video input set with analog multiplexers GPIO controled*/
+	/* adds picolo_tetra_muxsel(), picolo_tetra_init(), the folowing declaration strucure, and #define BTTV_PICOLO_TETRA_CHIP*/
+	/*0x79 in bttv.h*/
+	.name           = "Euresys Picolo Tetra",
+	.video_inputs   = 4,
+	.audio_inputs   = 0,
+	.tuner          = -1,
+	.svhs           = -1,
+	.gpiomask       = 0,
+	.gpiomask2      = 0x3C<<16,/*Set the GPIO[18]->GPIO[21] as output pin.==> drive the video inputs through analog multiplexers*/
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.muxsel         = {2,2,2,2},/*878A input is always MUX0, see above.*/
+	.audiomux       = { 0, 0, 0, 0, 0, 0 }, /* card has no audio */
+	.pll            = PLL_28,
+	.needs_tvaudio  = 0,
+	.muxsel_hook    = picolo_tetra_muxsel,/*Required as it doesn't follow the classic input selection policy*/
+},{
+	/* Spirit TV Tuner from http://spiritmodems.com.au */
+	/* Stafford Goodsell <surge@goliath.homeunix.org> */
+	.name           = "Spirit TV Tuner",
+	.video_inputs   = 3,
+	.audio_inputs   = 1,
+	.tuner          = 0,
+	.svhs           = 2,
+	.gpiomask       = 0x0000000f,
+	.muxsel         = { 2, 1, 1 },
+	.audiomux       = { 0x02, 0x00, 0x00, 0x00, 0x00},
+	.tuner_type     = TUNER_TEMIC_PAL,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+},{
+	/* Wolfram Joost <wojo@frokaschwei.de> */
+        .name           = "AVerMedia AVerTV DVB-T 771",
+        .video_inputs   = 2,
+        .svhs           = 1,
+        .tuner          = -1,
+        .tuner_type     = TUNER_ABSENT,
+        .muxsel         = { 3 , 3 },
+        .no_msp34xx     = 1,
+        .no_tda9875     = 1,
+        .no_tda7432     = 1,
+        .pll            = PLL_28,
+        .has_dvb        = 1,
+        .no_gpioirq     = 1,
+#if 0 /* untested */
+        .has_remote     = 1,
+#endif
 }};
 
 const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2381,6 +2447,7 @@ void __devinit bttv_init_card1(struct bt
 		pvr_boot(btv);
 		break;
 	case BTTV_TWINHAN_DST:
+	case BTTV_AVDVBT_771:
 		btv->use_i2c_hw = 1;
 		break;
 	}
@@ -2432,6 +2499,9 @@ void __devinit bttv_init_card2(struct bt
 	case BTTV_PXC200:
 		init_PXC200(btv);
 		break;
+	case BTTV_PICOLO_TETRA_CHIP:
+		picolo_tetra_init(btv);
+		break;
 	case BTTV_VHX:
 		btv->has_radio    = 1;
 		btv->has_matchbox = 1;
@@ -2668,6 +2738,10 @@ static void modtec_eeprom(struct bttv *b
 		btv->tuner_type=TUNER_ALPS_TSBB5_PAL_I;
 		printk("bttv%d: Modtec: Tuner autodetected by eeprom: %s\n",
                        btv->c.nr,&eeprom_data[0x1e]);
+        } else if (strncmp(&(eeprom_data[0x1e]),"Philips FM1246",14) ==0) {
+                btv->tuner_type=TUNER_PHILIPS_NTSC;
+                printk("bttv%d: Modtec: Tuner autodetected by eeprom: %s\n",
+                       btv->c.nr,&eeprom_data[0x1e]);
 	} else {
 		printk("bttv%d: Modtec: Unknown TunerString: %s\n",
 		       btv->c.nr,&eeprom_data[0x1e]);
@@ -3786,6 +3860,21 @@ static void xguard_muxsel(struct bttv *b
 	};
 	gpio_write(masks[input%16]);
 }
+static void picolo_tetra_init(struct bttv *btv)
+{
+	/*This is the video input redirection fonctionality : I DID NOT USED IT. */
+	btwrite (0x08<<16,BT848_GPIO_DATA);/*GPIO[19] [==> 4053 B+C] set to 1 */
+	btwrite (0x04<<16,BT848_GPIO_DATA);/*GPIO[18] [==> 4053 A]  set to 1*/
+}
+static void picolo_tetra_muxsel (struct bttv* btv, unsigned int input)
+{
+
+	dprintk (KERN_DEBUG "bttv%d : picolo_tetra_muxsel =>  input = %d\n",btv->c.nr,input);
+	/*Just set the right path in the analog multiplexers : channel 1 -> 4 ==> Analog Mux ==> MUX0*/
+	/*GPIO[20]&GPIO[21] used to choose the right input*/
+	btwrite (input<<20,BT848_GPIO_DATA);
+
+}
 
 /*
  * ivc120_muxsel [Added by Alan Garfield <alan@fromorbit.com>]
@@ -3939,15 +4028,15 @@ int __devinit bttv_handle_chipset(struct
 }
 
 
-/* PXC200 muxsel helper
+/* PXC200 muxsel helper 
  * luke@syseng.anu.edu.au
- * another transplant
+ * another transplant 
  * from Alessandro Rubini (rubini@linux.it)
  *
  * There are 4 kinds of cards:
- * PXC200L which is bt848
+ * PXC200L which is bt848 
  * PXC200F which is bt848 with PIC controlling mux
- * PXC200AL which is bt878
+ * PXC200AL which is bt878 
  * PXC200AF which is bt878 with PIC controlling mux
  */
 #define PX_CFG_PXC200F 0x01
@@ -3986,10 +4075,10 @@ static void PXC200_muxsel(struct bttv *b
 	/*  mux = bttv_tvcards[btv->type].muxsel[input] & 3; */
 	/* ** not needed!?   */
 	mux = input;
-
+  
 	/* make sure output pins are enabled */
 	/* bitmask=0x30f; */
-	bitmask=0x302;
+	bitmask=0x302; 
 	/* check whether we have a PXC200A */
  	if (btv->cardid == PX_PXC200A_CARDID)  {
 	   bitmask ^= 0x180; /* use 7 and 9, not 8 and 9 */
@@ -3998,7 +4087,7 @@ static void PXC200_muxsel(struct bttv *b
 	btwrite(bitmask, BT848_GPIO_OUT_EN);
 
 	bitmask = btread(BT848_GPIO_DATA);
- 	if (btv->cardid == PX_PXC200A_CARDID)
+ 	if (btv->cardid == PX_PXC200A_CARDID) 
 	  bitmask = (bitmask & ~0x280) | ((mux & 2) << 8) | ((mux & 1) << 7);
 	else /* older device */
 	  bitmask = (bitmask & ~0x300) | ((mux & 3) << 8);
@@ -4008,10 +4097,10 @@ static void PXC200_muxsel(struct bttv *b
 	 * Was "to be safe, set the bt848 to input 0"
 	 * Actually, since it's ok at load time, better not messing
 	 * with these bits (on PXC200AF you need to set mux 2 here)
-	 *
+	 * 
 	 * needed because bttv-driver sets mux before calling this function
 	 */
- 	if (btv->cardid == PX_PXC200A_CARDID)
+ 	if (btv->cardid == PX_PXC200A_CARDID) 
 	  btaor(2<<5, ~BT848_IFORM_MUXSEL, BT848_IFORM);
 	else /* older device */
 	  btand(~BT848_IFORM_MUXSEL,BT848_IFORM);
diff -up linux-2.6.7/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.7/drivers/media/video/bttv-driver.c	2004-06-17 10:30:19.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-06-17 13:47:59.432338838 +0200
@@ -1334,7 +1334,8 @@ bttv_switch_overlay(struct bttv *btv, st
 	spin_lock_irqsave(&btv->s_lock,flags);
 	old = btv->screen;
 	btv->screen = new;
-	bttv_set_dma(btv, 0x03, 1);
+	btv->curr.irqflags |= 1;
+	bttv_set_dma(btv, 0x03, btv->curr.irqflags);
 	spin_unlock_irqrestore(&btv->s_lock,flags);
 	if (NULL == new)
 		free_btres(btv,fh,RESOURCE_OVERLAY);
@@ -1441,7 +1442,8 @@ buffer_queue(struct file *file, struct v
 
 	buf->vb.state = STATE_QUEUED;
 	list_add_tail(&buf->vb.queue,&fh->btv->capture);
-	bttv_set_dma(fh->btv, 0x03, 1);
+	fh->btv->curr.irqflags |= 1;
+	bttv_set_dma(fh->btv, 0x03, fh->btv->curr.irqflags);
 }
 
 static void buffer_release(struct file *file, struct videobuf_buffer *vb)
@@ -3203,8 +3205,8 @@ static void bttv_print_riscaddr(struct b
 	printk("  main: %08Lx\n",
 	       (unsigned long long)btv->main.dma);
 	printk("  vbi : o=%08Lx e=%08Lx\n",
-	       btv->curr.vbi ? (unsigned long long)btv->curr.vbi->top.dma : 0,
-	       btv->curr.vbi ? (unsigned long long)btv->curr.vbi->bottom.dma : 0);
+	       btv->cvbi ? (unsigned long long)btv->cvbi->top.dma : 0,
+	       btv->cvbi ? (unsigned long long)btv->cvbi->bottom.dma : 0);
 	printk("  cap : o=%08Lx e=%08Lx\n",
 	       btv->curr.top    ? (unsigned long long)btv->curr.top->top.dma : 0,
 	       btv->curr.bottom ? (unsigned long long)btv->curr.bottom->bottom.dma : 0);
@@ -3224,7 +3226,7 @@ static void bttv_irq_debug_low_latency(s
 
 	if (0 == (btread(BT848_DSTATUS) & BT848_DSTATUS_HLOC)) {
 		printk("bttv%d: Oh, there (temporarely?) is no input signal. "
-		       "Ok, then this is harmless, don't worry ;)",
+		       "Ok, then this is harmless, don't worry ;)\n",
 		       btv->c.nr);
 		return;
 	}
@@ -3236,18 +3238,12 @@ static void bttv_irq_debug_low_latency(s
 }
 
 static int
-bttv_irq_next_set(struct bttv *btv, struct bttv_buffer_set *set)
+bttv_irq_next_video(struct bttv *btv, struct bttv_buffer_set *set)
 {
 	struct bttv_buffer *item;
 
 	memset(set,0,sizeof(*set));
 
-	/* vbi request ? */
-	if (!list_empty(&btv->vcapture)) {
-		set->irqflags = 1;
-		set->vbi = list_entry(btv->vcapture.next, struct bttv_buffer, vb.queue);
-	}
-
 	/* capture request ? */
 	if (!list_empty(&btv->capture)) {
 		set->irqflags = 1;
@@ -3295,27 +3291,20 @@ bttv_irq_next_set(struct bttv *btv, stru
 		}
 	}
 
-	dprintk("bttv%d: next set: top=%p bottom=%p vbi=%p "
-		"[screen=%p,irq=%d,%d]\n",
-		btv->c.nr,set->top, set->bottom, set->vbi,
+	dprintk("bttv%d: next set: top=%p bottom=%p [screen=%p,irq=%d,%d]\n",
+		btv->c.nr,set->top, set->bottom,
 		btv->screen,set->irqflags,set->topirq);
 	return 0;
 }
 
 static void
-bttv_irq_wakeup_set(struct bttv *btv, struct bttv_buffer_set *wakeup,
-		    struct bttv_buffer_set *curr, unsigned int state)
+bttv_irq_wakeup_video(struct bttv *btv, struct bttv_buffer_set *wakeup,
+		      struct bttv_buffer_set *curr, unsigned int state)
 {
 	struct timeval ts;
 
 	do_gettimeofday(&ts);
 
-	if (NULL != wakeup->vbi) {
-		wakeup->vbi->vb.ts = ts;
-		wakeup->vbi->vb.field_count = btv->field_count;
-		wakeup->vbi->vb.state = state;
-		wake_up(&wakeup->vbi->vb.done);
-	}
 	if (wakeup->top == wakeup->bottom) {
 		if (NULL != wakeup->top && curr->top != wakeup->top) {
 			if (irq_debug > 1)
@@ -3345,10 +3334,27 @@ bttv_irq_wakeup_set(struct bttv *btv, st
 	}
 }
 
+static void
+bttv_irq_wakeup_vbi(struct bttv *btv, struct bttv_buffer *wakeup,
+		    unsigned int state)
+{
+	struct timeval ts;
+
+	if (NULL == wakeup)
+		return;
+
+	do_gettimeofday(&ts);
+	wakeup->vb.ts = ts;
+	wakeup->vb.field_count = btv->field_count;
+	wakeup->vb.state = state;
+	wake_up(&wakeup->vb.done);
+}
+
 static void bttv_irq_timeout(unsigned long data)
 {
 	struct bttv *btv = (struct bttv *)data;
 	struct bttv_buffer_set old,new;
+	struct bttv_buffer *ovbi;
 	struct bttv_buffer *item;
 	unsigned long flags;
 	
@@ -3364,13 +3370,17 @@ static void bttv_irq_timeout(unsigned lo
 	
 	/* deactivate stuff */
 	memset(&new,0,sizeof(new));
-	old = btv->curr;
+	old  = btv->curr;
+	ovbi = btv->cvbi;
 	btv->curr = new;
-	bttv_buffer_set_activate(btv, &new);
+	btv->cvbi = NULL;
+	bttv_buffer_activate_video(btv, &new);
+	bttv_buffer_activate_vbi(btv,   NULL);
 	bttv_set_dma(btv, 0, 0);
 
 	/* wake up */
-	bttv_irq_wakeup_set(btv, &old, &new, STATE_ERROR);
+	bttv_irq_wakeup_video(btv, &old, &new, STATE_ERROR);
+	bttv_irq_wakeup_vbi(btv, ovbi, STATE_ERROR);
 
 	/* cancel all outstanding capture / vbi requests */
 	while (!list_empty(&btv->capture)) {
@@ -3410,8 +3420,17 @@ bttv_irq_wakeup_top(struct bttv *btv)
 	spin_unlock(&btv->s_lock);
 }
 
+static inline int is_active(struct btcx_riscmem *risc, u32 rc)
+{
+	if (rc < risc->dma)
+		return 0;
+	if (rc > risc->dma + risc->size)
+		return 0;
+	return 1;
+}
+
 static void
-bttv_irq_switch_fields(struct bttv *btv)
+bttv_irq_switch_video(struct bttv *btv)
 {
 	struct bttv_buffer_set new;
 	struct bttv_buffer_set old;
@@ -3420,9 +3439,10 @@ bttv_irq_switch_fields(struct bttv *btv)
 	spin_lock(&btv->s_lock);
 
 	/* new buffer set */
-	bttv_irq_next_set(btv, &new);
+	bttv_irq_next_video(btv, &new);
 	rc = btread(BT848_RISC_COUNT);
-	if (rc < btv->main.dma || rc > btv->main.dma + 0x100) {
+	if ((btv->curr.top    && is_active(&btv->curr.top->top,       rc)) ||
+	    (btv->curr.bottom && is_active(&btv->curr.bottom->bottom, rc))) {
 		btv->framedrop++;
 		if (debug_latency)
 			bttv_irq_debug_low_latency(btv, rc);
@@ -3433,7 +3453,7 @@ bttv_irq_switch_fields(struct bttv *btv)
 	/* switch over */
 	old = btv->curr;
 	btv->curr = new;
-	bttv_buffer_set_activate(btv, &new);
+	bttv_buffer_activate_video(btv, &new);
 	bttv_set_dma(btv, 0, new.irqflags);
 
 	/* switch input */
@@ -3443,7 +3463,39 @@ bttv_irq_switch_fields(struct bttv *btv)
 	}
 
 	/* wake up finished buffers */
-	bttv_irq_wakeup_set(btv, &old, &new, STATE_DONE);
+	bttv_irq_wakeup_video(btv, &old, &new, STATE_DONE);
+	spin_unlock(&btv->s_lock);
+}
+
+static void
+bttv_irq_switch_vbi(struct bttv *btv)
+{
+	struct bttv_buffer *new = NULL;
+	struct bttv_buffer *old;
+	u32 rc;
+
+	spin_lock(&btv->s_lock);
+
+	if (!list_empty(&btv->vcapture))
+		new = list_entry(btv->vcapture.next, struct bttv_buffer, vb.queue);
+	old = btv->cvbi;
+	
+	rc = btread(BT848_RISC_COUNT);
+	if (NULL != old && (is_active(&old->top,    rc) ||
+			    is_active(&old->bottom, rc))) {
+		btv->framedrop++;
+		if (debug_latency)
+			bttv_irq_debug_low_latency(btv, rc);
+		spin_unlock(&btv->s_lock);
+		return;
+	}
+	
+	/* switch */
+	btv->cvbi = new;
+	bttv_buffer_activate_vbi(btv, new);
+	bttv_set_dma(btv, 0, btv->curr.irqflags);
+	
+	bttv_irq_wakeup_vbi(btv, old, STATE_DONE);
 	spin_unlock(&btv->s_lock);
 }
 
@@ -3500,11 +3552,14 @@ static irqreturn_t bttv_irq(int irq, voi
 			wake_up(&btv->i2c_queue);
 		}
 
+                if ((astat & BT848_INT_RISCI)  &&  (stat & (4<<28)))
+			bttv_irq_switch_vbi(btv);
+
                 if ((astat & BT848_INT_RISCI)  &&  (stat & (2<<28)))
 			bttv_irq_wakeup_top(btv);
 
                 if ((astat & BT848_INT_RISCI)  &&  (stat & (1<<28)))
-			bttv_irq_switch_fields(btv);
+			bttv_irq_switch_video(btv);
 
 		if ((astat & BT848_INT_HLOCK)  &&  btv->opt_automute)
 			audio_mux(btv, -1);
@@ -3872,9 +3927,11 @@ static int bttv_suspend(struct pci_dev *
 	/* stop dma + irqs */
 	spin_lock_irqsave(&btv->s_lock,flags);
 	memset(&idle, 0, sizeof(idle));
-	btv->state.set = btv->curr;
+	btv->state.video = btv->curr;
+	btv->state.vbi   = btv->cvbi;
 	btv->curr = idle;
-	bttv_buffer_set_activate(btv, &idle);
+	bttv_buffer_activate_video(btv, &idle);
+	bttv_buffer_activate_vbi(btv, NULL);
 	bttv_set_dma(btv, 0, 0);
 	btwrite(0, BT848_INT_MASK);
 	spin_unlock_irqrestore(&btv->s_lock,flags);
@@ -3914,8 +3971,10 @@ static int bttv_resume(struct pci_dev *p
 
 	/* restart dma */
 	spin_lock_irqsave(&btv->s_lock,flags);
-	btv->curr = btv->state.set;
-	bttv_buffer_set_activate(btv, &btv->curr);
+	btv->curr = btv->state.video;
+	btv->cvbi = btv->state.vbi;
+	bttv_buffer_activate_video(btv, &btv->curr);
+	bttv_buffer_activate_vbi(btv, btv->cvbi);
 	bttv_set_dma(btv, 0, btv->curr.irqflags);
 	spin_unlock_irqrestore(&btv->s_lock,flags);
 	return 0;
diff -up linux-2.6.7/drivers/media/video/bttv-risc.c linux/drivers/media/video/bttv-risc.c
--- linux-2.6.7/drivers/media/video/bttv-risc.c	2004-06-17 10:29:10.000000000 +0200
+++ linux/drivers/media/video/bttv-risc.c	2004-06-17 13:47:59.435338273 +0200
@@ -379,7 +379,7 @@ bttv_set_dma(struct bttv *btv, int overr
 	btv->cap_ctl = 0;
 	if (NULL != btv->curr.top)      btv->cap_ctl |= 0x02;
 	if (NULL != btv->curr.bottom)   btv->cap_ctl |= 0x01;
-	if (NULL != btv->curr.vbi)      btv->cap_ctl |= 0x0c;
+	if (NULL != btv->cvbi)          btv->cap_ctl |= 0x0c;
 
 	capctl  = 0;
 	capctl |= (btv->cap_ctl & 0x03) ? 0x03 : 0x00;  /* capture  */
@@ -389,9 +389,9 @@ bttv_set_dma(struct bttv *btv, int overr
 	d2printk(KERN_DEBUG
 		 "bttv%d: capctl=%x irq=%d top=%08Lx/%08Lx even=%08Lx/%08Lx\n",
 		 btv->c.nr,capctl,irqflags,
-		 btv->curr.vbi     ? (unsigned long long)btv->curr.vbi->top.dma        : 0,
+		 btv->cvbi         ? (unsigned long long)btv->cvbi->top.dma            : 0,
 		 btv->curr.top     ? (unsigned long long)btv->curr.top->top.dma        : 0,
-		 btv->curr.vbi     ? (unsigned long long)btv->curr.vbi->bottom.dma     : 0,
+		 btv->cvbi         ? (unsigned long long)btv->cvbi->bottom.dma         : 0,
 		 btv->curr.bottom  ? (unsigned long long)btv->curr.bottom->bottom.dma  : 0);
 	
 	cmd = BT848_RISC_JUMP;
@@ -399,6 +399,8 @@ bttv_set_dma(struct bttv *btv, int overr
 		cmd |= BT848_RISC_IRQ;
 		cmd |= (irqflags  & 0x0f) << 16;
 		cmd |= (~irqflags & 0x0f) << 20;
+	}
+	if (irqflags || btv->cvbi) {
 		mod_timer(&btv->timeout, jiffies+BTTV_TIMEOUT);
 	} else {
 		del_timer(&btv->timeout);
@@ -501,20 +503,26 @@ bttv_dma_free(struct bttv *btv, struct b
 }
 
 int
-bttv_buffer_set_activate(struct bttv *btv,
-			 struct bttv_buffer_set *set)
+bttv_buffer_activate_vbi(struct bttv *btv,
+			 struct bttv_buffer *vbi)
 {
 	/* vbi capture */
-	if (set->vbi) {
-		set->vbi->vb.state = STATE_ACTIVE;
-		list_del(&set->vbi->vb.queue);
-		bttv_risc_hook(btv, RISC_SLOT_O_VBI, &set->vbi->top,    0);
-		bttv_risc_hook(btv, RISC_SLOT_E_VBI, &set->vbi->bottom, 0);
+	if (vbi) {
+		vbi->vb.state = STATE_ACTIVE;
+		list_del(&vbi->vb.queue);
+		bttv_risc_hook(btv, RISC_SLOT_O_VBI, &vbi->top,    0);
+		bttv_risc_hook(btv, RISC_SLOT_E_VBI, &vbi->bottom, 4);
 	} else {
 		bttv_risc_hook(btv, RISC_SLOT_O_VBI, NULL, 0);
 		bttv_risc_hook(btv, RISC_SLOT_E_VBI, NULL, 0);
 	}
+	return 0;
+}
 
+int
+bttv_buffer_activate_video(struct bttv *btv,
+			   struct bttv_buffer_set *set)
+{
 	/* video capture */
 	if (NULL != set->top  &&  NULL != set->bottom) {
 		if (set->top == set->bottom) {
diff -up linux-2.6.7/drivers/media/video/bttv-vbi.c linux/drivers/media/video/bttv-vbi.c
--- linux-2.6.7/drivers/media/video/bttv-vbi.c	2004-06-17 10:29:53.000000000 +0200
+++ linux/drivers/media/video/bttv-vbi.c	2004-06-17 13:47:59.438337709 +0200
@@ -114,7 +114,10 @@ vbi_buffer_queue(struct file *file, stru
 	dprintk("queue %p\n",vb);
 	buf->vb.state = STATE_QUEUED;
 	list_add_tail(&buf->vb.queue,&btv->vcapture);
-	bttv_set_dma(btv,0x0c,1);
+	if (NULL == btv->cvbi) {
+		fh->btv->curr.irqflags |= 4;
+		bttv_set_dma(btv,0x0c,fh->btv->curr.irqflags);
+	}
 }
 
 static void vbi_buffer_release(struct file *file, struct videobuf_buffer *vb)
diff -up linux-2.6.7/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.7/drivers/media/video/bttv.h	2004-06-17 10:27:56.000000000 +0200
+++ linux/drivers/media/video/bttv.h	2004-06-17 13:47:59.440337332 +0200
@@ -124,6 +124,8 @@
 #define BTTV_SIMUS_GVC1100  0x74
 #define BTTV_NGSTV_PLUS     0x75
 #define BTTV_LMLBT4         0x76
+#define BTTV_PICOLO_TETRA_CHIP 0x79
+#define BTTV_AVDVBT_771     0x7b
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
diff -up linux-2.6.7/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.7/drivers/media/video/bttvp.h	2004-06-17 10:28:42.000000000 +0200
+++ linux/drivers/media/video/bttvp.h	2004-06-17 13:47:59.442336956 +0200
@@ -25,7 +25,7 @@
 #define _BTTVP_H_
 
 #include <linux/version.h>
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,14)
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,15)
 
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -127,7 +127,6 @@ struct bttv_buffer {
 struct bttv_buffer_set {
 	struct bttv_buffer     *top;       /* top field buffer    */
 	struct bttv_buffer     *bottom;    /* bottom field buffer */
-	struct bttv_buffer     *vbi;       /* vbi buffer */
 	unsigned int           irqflags;
 	unsigned int           topirq;
 };
@@ -197,8 +196,10 @@ int bttv_risc_hook(struct bttv *btv, int
 
 /* capture buffer handling */
 int bttv_buffer_risc(struct bttv *btv, struct bttv_buffer *buf);
-int bttv_buffer_set_activate(struct bttv *btv,
-			     struct bttv_buffer_set *set);
+int bttv_buffer_activate_video(struct bttv *btv,
+			       struct bttv_buffer_set *set);
+int bttv_buffer_activate_vbi(struct bttv *btv,
+			     struct bttv_buffer *vbi);
 void bttv_dma_free(struct bttv *btv, struct bttv_buffer *buf);
 
 /* overlay handling */
@@ -279,7 +280,8 @@ struct bttv_suspend_state {
 	u32  gpio_enable;
 	u32  gpio_data;
 	int  disabled;
-	struct bttv_buffer_set set;
+	struct bttv_buffer_set video;
+	struct bttv_buffer     *vbi;
 };
 
 struct bttv {
@@ -377,6 +379,7 @@ struct bttv {
 	struct list_head        capture;    /* video capture queue */
 	struct list_head        vcapture;   /* vbi capture queue   */
 	struct bttv_buffer_set  curr;       /* active buffers      */
+	struct bttv_buffer      *cvbi;      /* active vbi buffer   */
 	int                     new_input;
 
 	unsigned long cap_ctl;

-- 
Smoking Crack Organization
