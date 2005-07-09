Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbVGIAgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVGIAgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbVGIAgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:36:33 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:33184 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263031AbVGIAf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:35:56 -0400
Message-ID: <42CF1BE9.9030409@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:35:53 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 2/14 2.6.13-rc2-mm1] V4L BTTV update
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------090809060300000105020109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090809060300000105020109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090809060300000105020109
Content-Type: text/x-patch;
 name="v4l_bttv-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_bttv-update.diff"

- use DMA_32BIT_MASK.
- Rename tuner structures fields.
- Tail spaces removed.
- I2C cleanups and converged to a basic reference structure.
- Removed unused structures.
- Removed BTTV version check.

Signed-off-by: <domen@coderock.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-Off-By: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/bttv-cards.c  |  110 ++----------------------
 linux/drivers/media/video/bttv-driver.c |   19 ----
 linux/drivers/media/video/bttv-i2c.c    |   26 ++++-
 linux/drivers/media/video/bttv-risc.c   |    9 -
 4 files changed, 35 insertions(+), 129 deletions(-)

diff -u linux-2.6.13/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.13/drivers/media/video/bttv-driver.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/bttv-driver.c	2005-07-07 18:25:52.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.40 2005/06/16 21:38:45 nsh Exp $
+    $Id: bttv-driver.c,v 1.42 2005/07/05 17:37:35 nsh Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -35,6 +35,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/kdev_t.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/byteorder.h>
@@ -698,12 +699,10 @@
 static
 void free_btres(struct bttv *btv, struct bttv_fh *fh, int bits)
 {
-#if 1 /* DEBUG */
 	if ((fh->resources & bits) != bits) {
 		/* trying to free ressources not allocated by us ... */
 		printk("bttv: BUG! (btres)\n");
 	}
-#endif
 	down(&btv->reslock);
 	fh->resources  &= ~bits;
 	btv->resources &= ~bits;
@@ -943,11 +942,6 @@
 	i2c_mux = mux = (btv->audio & AUDIO_MUTE) ? AUDIO_OFF : btv->audio;
 	if (btv->opt_automute && !signal && !btv->radio_user)
 		mux = AUDIO_OFF;
-#if 0
-	printk("bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
-	       btv->c.nr, mode, btv->audio, signal ? "yes" : "no",
-	       mux, i2c_mux, in_interrupt() ? "yes" : "no");
-#endif
 
 	val = bttv_tvcards[btv->c.type].audiomux[mux];
 	gpio_bits(bttv_tvcards[btv->c.type].gpiomask,val);
@@ -994,11 +988,6 @@
 	case BTTV_VOODOOTV_FM:
 		bttv_tda9880_setnorm(btv,norm);
 		break;
-#if 0
-	case BTTV_OSPREY540:
-		osprey_540_set_norm(btv,norm);
-		break;
-#endif
 	}
 	return 0;
 }
@@ -1849,7 +1838,7 @@
 
 		if (unlikely(f->tuner != 0))
 			return -EINVAL;
-		if (unlikely(f->type != V4L2_TUNER_ANALOG_TV))
+		if (unlikely (f->type != V4L2_TUNER_ANALOG_TV))
 			return -EINVAL;
 		down(&btv->lock);
 		btv->freq = f->frequency;
@@ -3865,7 +3854,7 @@
 		       btv->c.nr);
 		return -EIO;
 	}
-        if (pci_set_dma_mask(dev, 0xffffffff)) {
+        if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
                 printk(KERN_WARNING "bttv%d: No suitable DMA available.\n",
 		       btv->c.nr);
 		return -EIO;
diff -u linux-2.6.13/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.13/drivers/media/video/bttv-cards.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/bttv-cards.c	2005-07-07 18:25:52.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.49 2005/06/10 17:20:24 mchehab Exp $
+    $Id: bttv-cards.c,v 1.53 2005/07/05 17:37:35 nsh Exp $
 
     bttv-cards.c
 
@@ -39,9 +39,6 @@
 #include <asm/io.h>
 
 #include "bttvp.h"
-#if 0 /* not working yet */
-#include "bt832.h"
-#endif
 
 /* fwd decl */
 static void boot_msp34xx(struct bttv *btv, int pin);
@@ -513,13 +510,8 @@
 	.svhs		= 2,
 	.gpiomask	= 0x01fe00,
 	.muxsel		= { 2, 3, 1, 1},
-#if 0
-	// old
-	.audiomux	= { 0x01c000, 0, 0x018000, 0x014000, 0x002000, 0 },
-#else
 	// 2003-10-20 by "Anton A. Arapov" <arapov@mail.ru>
 	.audiomux       = { 0x001e00, 0, 0x018000, 0x014000, 0x002000, 0 },
-#endif
 	.needs_tvaudio	= 1,
 	.pll		= PLL_28,
 	.tuner_type	= -1,
@@ -766,14 +758,9 @@
 	.tuner		= 0,
 	.svhs		= 2,
 	.muxsel		= { 2, 3, 1, 1, 0}, // TV, CVid, SVid, CVid over SVid connector
-#if 0
-	.gpiomask	= 0xc33000,
-	.audiomux	= { 0x422000,0x1000,0x0000,0x620000,0x800000 },
-#else
 	/* Alexander Varakin <avarakin@hotmail.com> [stereo version] */
 	.gpiomask	= 0xb33000,
 	.audiomux	= { 0x122000,0x1000,0x0000,0x620000,0x800000 },
-#endif
 	/* Audio Routing for "WinFast 2000 XP" (no tv stereo !)
 		gpio23 -- hef4052:nEnable (0x800000)
 		gpio12 -- hef4052:A1
@@ -1603,20 +1590,11 @@
        .video_inputs   = 4,
        .audio_inputs   = 1,
        .tuner          = -1,
-#if 0 /* TODO ... */
-       .svhs           = OSPREY540_SVID_ANALOG,
-       .muxsel         = {       [OSPREY540_COMP_ANALOG] = 2,
-                               [OSPREY540_SVID_ANALOG] = 3, },
-#endif
        .pll            = PLL_28,
        .tuner_type     = -1,
        .no_msp34xx     = 1,
        .no_tda9875     = 1,
        .no_tda7432     = 1,
-#if 0 /* TODO ... */
-       .muxsel_hook    = osprey_540_muxsel,
-       .picture_hook   = osprey_540_set_picture,
-#endif
 },{
 
 	/* ---- card 0x5C ---------------------------------- */
@@ -2546,21 +2524,12 @@
 	btaor((2)<<5, ~(3<<5), BT848_IFORM);
 	gpio_bits(3,bttv_tvcards[btv->c.type].muxsel[input&7]);
 
-#if 0
-       /* svhs */
-       /* wake chroma ADC */
-       btand(~BT848_ADC_C_SLEEP, BT848_ADC);
-       /* set to YC video */
-       btor(BT848_CONTROL_COMP, BT848_E_CONTROL);
-       btor(BT848_CONTROL_COMP, BT848_O_CONTROL);
-#else
        /* composite */
        /* set chroma ADC to sleep */
        btor(BT848_ADC_C_SLEEP, BT848_ADC);
        /* set to composite video */
        btand(~BT848_CONTROL_COMP, BT848_E_CONTROL);
        btand(~BT848_CONTROL_COMP, BT848_O_CONTROL);
-#endif
 
        /* switch sync drive off */
        gpio_bits(LM1882_SYNC_DRIVE,LM1882_SYNC_DRIVE);
@@ -2813,10 +2782,18 @@
 		btv->tuner_type = tuner[btv->c.nr];
 	printk("bttv%d: using tuner=%d\n",btv->c.nr,btv->tuner_type);
 	if (btv->pinnacle_id != UNSET)
-		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,
+		bttv_call_i2c_clients(btv, AUDC_CONFIG_PINNACLE,
 				      &btv->pinnacle_id);
-	if (btv->tuner_type != UNSET)
-		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
+	if (btv->tuner_type != UNSET) {
+	        struct tuner_setup tun_setup;
+
+	        tun_setup.mode_mask = T_RADIO | T_ANALOG_TV | T_DIGITAL_TV;
+		tun_setup.type = btv->tuner_type;
+		tun_setup.addr = ADDR_UNSET;
+
+		bttv_call_i2c_clients(btv, TUNER_SET_TYPE_ADDR, &tun_setup);
+	}
+
 	btv->svhs = bttv_tvcards[btv->c.type].svhs;
 	if (svhs[btv->c.nr] != UNSET)
 		btv->svhs = svhs[btv->c.nr];
@@ -3125,14 +3102,6 @@
         TUNER_PHILIPS_SECAM, TUNER_PHILIPS_SECAM,
         TUNER_PHILIPS_SECAM, TUNER_PHILIPS_PAL,
 	TUNER_PHILIPS_FM1216ME_MK3 };
-#if 0
-int tuner_0_fm_table[] = {
-        PHILIPS_FR1236_NTSC,  PHILIPS_FR1216_PAL,
-        PHILIPS_FR1216_PAL,   PHILIPS_FR1216_PAL,
-        PHILIPS_FR1216_PAL,   PHILIPS_FR1216_PAL,
-        PHILIPS_FR1236_SECAM, PHILIPS_FR1236_SECAM,
-        PHILIPS_FR1236_SECAM, PHILIPS_FR1216_PAL};
-#endif
 
 static int tuner_1_table[] = {
         TUNER_TEMIC_NTSC,  TUNER_TEMIC_PAL,
@@ -3218,36 +3187,6 @@
 
 static void __devinit boot_bt832(struct bttv *btv)
 {
-#if 0 /* not working yet */
-	int resetbit=0;
-
-	switch (btv->c.type) {
-	case BTTV_PXELVWPLTVPAK:
-		resetbit = 0x400000;
-		break;
-	case BTTV_MODTEC_205:
-		resetbit = 1<<9;
-		break;
-	default:
-		BUG();
-	}
-
-	request_module("bt832");
-	bttv_call_i2c_clients(btv, BT832_HEXDUMP, NULL);
-
-	printk("bttv%d: Reset Bt832 [line=0x%x]\n",btv->c.nr,resetbit);
-	gpio_write(0);
-	gpio_inout(resetbit, resetbit);
-	udelay(5);
-	gpio_bits(resetbit, resetbit);
-	udelay(5);
-	gpio_bits(resetbit, 0);
-	udelay(5);
-
-	// bt832 on pixelview changes from i2c 0x8a to 0x88 after
-	// being reset as above. So we must follow by this:
-	bttv_call_i2c_clients(btv, BT832_REATTACH, NULL);
-#endif
 }
 
 /* ----------------------------------------------------------------------- */
@@ -3572,11 +3511,6 @@
 {
 	dprintk("tea5757_set_freq %d\n",freq);
 	tea5757_write(btv, 5 * freq + 0x358); /* add 10.7MHz (see docs) */
-#if 0
-	/* breaks Miro PCTV */
-	value = tea5757_read(btv);
-	dprintk("bttv%d: tea5757 readback=0x%x\n",btv->c.nr,value);
-#endif
 }
 
 
@@ -3656,13 +3590,8 @@
 {
 	unsigned int val, con;
 
-#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
 	if (btv->radio_user)
 		return;
-#else
-	if (btv->radio)
-		return;
-#endif
 
 	val = gpio_read();
 	if (set) {
@@ -3851,13 +3780,8 @@
 {
 	unsigned int val = 0;
 
-#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
 	if (btv->radio_user)
 		return;
-#else
-	if (btv->radio)
-		return;
-#endif
 
 	if (set) {
 		if (v->mode & VIDEO_SOUND_MONO)	{
@@ -3888,13 +3812,8 @@
 {
 	unsigned int val = 0xffff;
 
-#if BTTV_VERSION_CODE > KERNEL_VERSION(0,8,0)
 	if (btv->radio_user)
 		return;
-#else
-	if (btv->radio)
-		return;
-#endif
 	if (set) {
 		if (v->mode & VIDEO_SOUND_MONO)	{
 			val = 0x0000;
@@ -4371,11 +4290,6 @@
 		latency = 0x0A;
 #endif
 
-#if 0
-	/* print which chipset we have */
-	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
-		printk(KERN_INFO "bttv: Host bridge is %s\n",pci_name(dev));
-#endif
 
 	/* print warnings about any quirks found */
 	if (triton1)
diff -u linux-2.6.13/drivers/media/video/bttv-risc.c linux/drivers/media/video/bttv-risc.c
--- linux-2.6.13/drivers/media/video/bttv-risc.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/bttv-risc.c	2005-07-07 18:25:52.000000000 -0300
@@ -334,10 +334,6 @@
 	}
 
 	vdelay = tvnorm->vdelay;
-#if 0 /* FIXME */
-	if (vdelay < btv->vbi.lines*2)
-		vdelay = btv->vbi.lines*2;
-#endif
 
         xsf = (width*scaledtwidth)/swidth;
         geo->hscale =  ((totalwidth*4096UL)/xsf-4096);
@@ -776,13 +772,8 @@
 		bttv_risc_overlay(btv, &buf->bottom, fmt, ov, 0, 0);
 		break;
 	case V4L2_FIELD_INTERLACED:
-#if 0
-		bttv_risc_overlay(btv, &buf->top,    fmt, ov, 1, 0);
-		bttv_risc_overlay(btv, &buf->bottom, fmt, ov, 0, 1);
-#else
 		bttv_risc_overlay(btv, &buf->top,    fmt, ov, 0, 1);
 		bttv_risc_overlay(btv, &buf->bottom, fmt, ov, 1, 0);
-#endif
 		break;
 	default:
 		BUG();
diff -u linux-2.6.13/drivers/media/video/bttv-i2c.c linux/drivers/media/video/bttv-i2c.c
--- linux-2.6.13/drivers/media/video/bttv-i2c.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/bttv-i2c.c	2005-07-07 18:25:52.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-i2c.c,v 1.21 2005/06/10 17:20:24 mchehab Exp $
+    $Id: bttv-i2c.c,v 1.25 2005/07/05 17:37:35 nsh Exp $
 
     bttv-i2c.c  --  all the i2c code is here
 
@@ -295,14 +295,26 @@
 {
         struct bttv *btv = i2c_get_adapdata(client->adapter);
 
-	if (btv->tuner_type != UNSET)
-		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
+	if (bttv_debug)
+		printk(KERN_DEBUG "bttv%d: %s i2c attach [addr=0x%x,client=%s]\n",
+			btv->c.nr,client->driver->name,client->addr,
+			i2c_clientname(client));
+	if (!client->driver->command)
+		return 0;
+
+	if (btv->tuner_type != UNSET) {
+	        struct tuner_setup tun_setup;
+
+	        tun_setup.mode_mask = T_RADIO | T_ANALOG_TV | T_DIGITAL_TV;
+		tun_setup.type = btv->tuner_type;
+		tun_setup.addr = ADDR_UNSET;
+
+		client->driver->command (client, TUNER_SET_TYPE_ADDR, &tun_setup);
+	}
+
 	if (btv->pinnacle_id != UNSET)
-		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,
+		client->driver->command(client,AUDC_CONFIG_PINNACLE,
 				      &btv->pinnacle_id);
-        if (bttv_debug)
-		printk("bttv%d: i2c attach [client=%s]\n",
-		       btv->c.nr, i2c_clientname(client));
         return 0;
 }
 

--------------090809060300000105020109--
