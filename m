Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVCHKtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVCHKtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVCHKtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:49:11 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:11243 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261988AbVCHKpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:45:16 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:44:18 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv driver update
Message-ID: <20050308104418.GA30681@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bttv driver update, changes:
  * add support for a new card.
  * add some debug code (bt878 risc disassembler).
  * drop some obsolete i2c code.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/btcx-risc.c   |   12 +-
 drivers/media/video/bttv-cards.c  |  175 +++++++++++++++++++++++++++++-
 drivers/media/video/bttv-driver.c |   93 +++++++++++++--
 drivers/media/video/bttv-gpio.c   |   17 --
 drivers/media/video/bttv-i2c.c    |   15 --
 drivers/media/video/bttv.h        |    5 
 drivers/media/video/bttvp.h       |    3 
 7 files changed, 263 insertions(+), 57 deletions(-)

Index: linux-2.6.11/drivers/media/video/bttv.h
===================================================================
--- linux-2.6.11.orig/drivers/media/video/bttv.h	2005-03-07 15:25:35.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttv.h	2005-03-07 16:23:11.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: bttv.h,v 1.15 2005/01/24 17:37:23 kraxel Exp $
+ * $Id: bttv.h,v 1.17 2005/02/22 14:06:32 kraxel Exp $
  *
  *  bttv - Bt848 frame grabber driver
  *
@@ -134,6 +134,7 @@
 #define BTTV_APAC_VIEWCOMP  0x7f
 #define BTTV_DVICO_DVBT_LITE  0x80
 #define BTTV_TIBET_CS16  0x83
+#define BTTV_KODICOM_4400R  0x84
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
@@ -302,8 +303,6 @@ struct bttv_sub_driver {
 	struct device_driver   drv;
 	char                   wanted[BUS_ID_SIZE];
 	void                   (*gpio_irq)(struct bttv_sub_device *sub);
-	void                   (*i2c_info)(struct bttv_sub_device *sub,
-					   struct i2c_client *client, int attach);
 };
 #define to_bttv_sub_drv(x) container_of((x), struct bttv_sub_driver, drv)
 
Index: linux-2.6.11/drivers/media/video/bttvp.h
===================================================================
--- linux-2.6.11.orig/drivers/media/video/bttvp.h	2005-03-07 15:25:35.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttvp.h	2005-03-07 16:23:03.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttvp.h,v 1.16 2005/01/24 17:37:23 kraxel Exp $
+    $Id: bttvp.h,v 1.17 2005/02/16 12:14:10 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -209,7 +209,6 @@ extern struct bus_type bttv_sub_bus_type
 int bttv_sub_add_device(struct bttv_core *core, char *name);
 int bttv_sub_del_devices(struct bttv_core *core);
 void bttv_gpio_irq(struct bttv_core *core);
-void bttv_i2c_info(struct bttv_core *core, struct i2c_client *client, int attach);
 
 
 /* ---------------------------------------------------------- */
Index: linux-2.6.11/drivers/media/video/bttv-cards.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/bttv-cards.c	2005-03-07 15:25:35.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttv-cards.c	2005-03-07 16:23:11.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-cards.c,v 1.44 2005/01/31 11:35:05 kraxel Exp $
+    $Id: bttv-cards.c,v 1.47 2005/02/22 14:06:32 kraxel Exp $
 
     bttv-cards.c
 
@@ -80,6 +80,9 @@ static void picolo_tetra_init(struct btt
 static void tibetCS16_muxsel(struct bttv *btv, unsigned int input);
 static void tibetCS16_init(struct bttv *btv);
 
+static void kodicom4400r_muxsel(struct bttv *btv, unsigned int input);
+static void kodicom4400r_init(struct bttv *btv);
+
 static void sigmaSLC_muxsel(struct bttv *btv, unsigned int input);
 static void sigmaSQ_muxsel(struct bttv *btv, unsigned int input);
 
@@ -101,6 +104,7 @@ static unsigned int pll[BTTV_MAX]    = {
 static unsigned int tuner[BTTV_MAX]  = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
 static unsigned int svhs[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
 static unsigned int remote[BTTV_MAX] = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
+static struct bttv  *master[BTTV_MAX] = { [ 0 ... (BTTV_MAX-1) ] = NULL };
 #ifdef MODULE
 static unsigned int autoload = 1;
 #else
@@ -293,7 +297,7 @@ static struct CARD {
 	{ 0x07611461, BTTV_AVDVBT_761,    "AverMedia AverTV DVB-T 761" },
 	{ 0x001c11bd, BTTV_PINNACLESAT,   "Pinnacle PCTV Sat" },
 	{ 0x002611bd, BTTV_TWINHAN_DST,   "Pinnacle PCTV SAT CI" },
-	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB-T" },
+	{ 0x00011822, BTTV_TWINHAN_DST,   "Twinhan VisionPlus DVB" },
 	{ 0xfc00270f, BTTV_TWINHAN_DST,   "ChainTech digitop DST-1000 DVB-S" },
 	{ 0x07711461, BTTV_AVDVBT_771,    "AVermedia AverTV DVB-T 771" },
 	{ 0xdb1018ac, BTTV_DVICO_DVBT_LITE,    "DVICO FusionHDTV DVB-T Lite" },
@@ -1922,6 +1926,7 @@ struct tvcard bttv_tvcards[] = {
 	.svhs           = 2,
 	.muxsel         = { 2, 3, 1, 0},
 	.tuner_type     = TUNER_PHILIPS_ATSC,
+	.has_dvb        = 1,
 },{
 	.name           = "Twinhan DST + clones",
 	.no_msp34xx     = 1,
@@ -2190,6 +2195,63 @@ struct tvcard bttv_tvcards[] = {
 		.no_tda7432	= 1,
 		.tuner_type     = -1,
 		.muxsel_hook    = tibetCS16_muxsel,
+},
+{
+	/* Bill Brack <wbrack@mmm.com.hk> */
+	/*
+	 * Note that, because of the card's wiring, the "master"
+	 * BT878A chip (i.e. the one which controls the analog switch
+	 * and must use this card type) is the 2nd one detected.  The
+	 * other 3 chips should use card type 0x85, whose description
+	 * follows this one.  There is a EEPROM on the card (which is
+	 * connected to the I2C of one of those other chips), but is
+	 * not currently handled.  There is also a facility for a
+	 * "monitor", which is also not currently implemented.
+	 */
+	.name		= "Kodicom 4400R (master)",
+	.video_inputs	= 16,
+	.audio_inputs	= 0,
+	.tuner		= -1,
+	.tuner_type	= -1,
+	.svhs		= -1,
+	/* GPIO bits 0-9 used for analog switch:
+	 *   00 - 03:	camera selector
+	 *   04 - 06:	channel (controller) selector
+	 *   07:	data (1->on, 0->off)
+	 *   08:	strobe
+	 *   09:	reset
+	 * bit 16 is input from sync separator for the channel
+	 */
+	.gpiomask	= 0x0003ff,
+	.no_gpioirq     = 1,
+	.muxsel		= { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
+	.pll		= PLL_28,
+	.no_msp34xx	= 1,
+	.no_tda7432	= 1,
+	.no_tda9875	= 1,
+	.muxsel_hook	= kodicom4400r_muxsel,
+},
+{
+	/* Bill Brack <wbrack@mmm.com.hk> */
+	/* Note that, for reasons unknown, the "master" BT878A chip (i.e. the
+	 * one which controls the analog switch, and must use the card type)
+	 * is the 2nd one detected.  The other 3 chips should use this card
+	 * type
+	 */
+	.name		= "Kodicom 4400R (slave)",
+	.video_inputs	= 16,
+	.audio_inputs	= 0,
+	.tuner		= -1,
+	.tuner_type	= -1,
+	.svhs		= -1,
+	.gpiomask	= 0x010000,
+	.no_gpioirq     = 1,
+	.muxsel		= { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
+	.pll		= PLL_28,
+	.no_msp34xx	= 1,
+	.no_tda7432	= 1,
+	.no_tda9875	= 1,
+	.muxsel_hook	= kodicom4400r_muxsel,
 }};
 
 static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -2684,6 +2746,9 @@ void __devinit bttv_init_card2(struct bt
 	case BTTV_TIBET_CS16:
 		tibetCS16_init(btv);
 		break;
+	case BTTV_KODICOM_4400R:
+		kodicom4400r_init(btv);
+		break;
 	}
 
 	/* pll configuration */
@@ -3896,6 +3961,112 @@ static void tibetCS16_init(struct bttv *
 	gpio_write(0x0f7fff);
 }
 
+/*
+ * The following routines for the Kodicom-4400r get a little mind-twisting.
+ * There is a "master" controller and three "slave" controllers, together
+ * an analog switch which connects any of 16 cameras to any of the BT87A's.
+ * The analog switch is controlled by the "master", but the detection order
+ * of the four BT878A chips is in an order which I just don't understand.
+ * The "master" is actually the second controller to be detected.  The
+ * logic on the board uses logical numbers for the 4 controlers, but
+ * those numbers are different from the detection sequence.  When working
+ * with the analog switch, we need to "map" from the detection sequence
+ * over to the board's logical controller number.  This mapping sequence
+ * is {3, 0, 2, 1}, i.e. the first controller to be detected is logical
+ * unit 3, the second (which is the master) is logical unit 0, etc.
+ * We need to maintain the status of the analog switch (which of the 16
+ * cameras is connected to which of the 4 controllers).  Rather than
+ * add to the bttv structure for this, we use the data reserved for
+ * the mbox (unused for this card type).
+ */
+
+/*
+ * First a routine to set the analog switch, which controls which camera
+ * is routed to which controller.  The switch comprises an X-address
+ * (gpio bits 0-3, representing the camera, ranging from 0-15), and a
+ * Y-address (gpio bits 4-6, representing the controller, ranging from 0-3).
+ * A data value (gpio bit 7) of '1' enables the switch, and '0' disables
+ * the switch.  A STROBE bit (gpio bit 8) latches the data value into the
+ * specified address.  The idea is to set the address and data, then bring
+ * STROBE high, and finally bring STROBE back to low.
+ */
+static void kodicom4400r_write(struct bttv *btv,
+			       unsigned char xaddr,
+			       unsigned char yaddr,
+			       unsigned char data) {
+	unsigned int udata;
+	
+	udata = (data << 7) | ((yaddr&3) << 4) | (xaddr&0xf);
+	gpio_bits(0x1ff, udata);		/* write ADDR and DAT */
+	gpio_bits(0x1ff, udata | (1 << 8));	/* strobe high */
+	gpio_bits(0x1ff, udata);		/* strobe low */
+}
+
+/*
+ * Next the mux select.  Both the "master" and "slave" 'cards' (controllers)
+ * use this routine.  The routine finds the "master" for the card, maps
+ * the controller number from the detected position over to the logical
+ * number, writes the appropriate data to the analog switch, and housekeeps
+ * the local copy of the switch information.  The parameter 'input' is the
+ * requested camera number (0 - 15).
+ */
+static void kodicom4400r_muxsel(struct bttv *btv, unsigned int input)
+{
+	char *sw_status;
+	int xaddr, yaddr;
+	struct bttv *mctlr;
+	static unsigned char map[4] = {3, 0, 2, 1};
+	
+	mctlr = master[btv->c.nr];
+	if (mctlr == NULL) {	/* ignore if master not yet detected */
+		return;
+	}
+	yaddr = (btv->c.nr - mctlr->c.nr + 1) & 3; /* the '&' is for safety */
+	yaddr = map[yaddr];
+	sw_status = (char *)(&mctlr->mbox_we);
+	xaddr = input & 0xf;
+	/* Check if the controller/camera pair has changed, else ignore */
+	if (sw_status[yaddr] != xaddr)
+	{
+		/* "open" the old switch, "close" the new one, save the new */
+		kodicom4400r_write(mctlr, sw_status[yaddr], yaddr, 0);
+		sw_status[yaddr] = xaddr;
+		kodicom4400r_write(mctlr, xaddr, yaddr, 1);
+	}
+}
+
+/*
+ * During initialisation, we need to reset the analog switch.  We
+ * also preset the switch to map the 4 connectors on the card to the
+ * *user's* (see above description of kodicom4400r_muxsel) channels
+ * 0 through 3
+ */
+static void kodicom4400r_init(struct bttv *btv)
+{
+	char *sw_status = (char *)(&btv->mbox_we);
+	int ix;
+
+	gpio_inout(0x0003ff, 0x0003ff);
+	gpio_write(1 << 9);	/* reset MUX */
+	gpio_write(0);
+	/* Preset camera 0 to the 4 controllers */
+	for (ix=0; ix<4; ix++) {
+		sw_status[ix] = ix;
+		kodicom4400r_write(btv, ix, ix, 1);
+	}
+	/*
+	 * Since this is the "master", we need to set up the
+	 * other three controller chips' pointers to this structure
+	 * for later use in the muxsel routine.
+	 */
+	if ((btv->c.nr<1) || (btv->c.nr>BTTV_MAX-3))
+	    return;
+	master[btv->c.nr-1] = btv;
+	master[btv->c.nr]   = btv;
+	master[btv->c.nr+1] = btv;
+	master[btv->c.nr+2] = btv;
+}
+
 // The Grandtec X-Guard framegrabber card uses two Dual 4-channel
 // video multiplexers to provide up to 16 video inputs. These
 // multiplexers are controlled by the lower 8 GPIO pins of the
Index: linux-2.6.11/drivers/media/video/bttv-gpio.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/bttv-gpio.c	2005-03-07 10:14:52.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttv-gpio.c	2005-03-07 16:23:03.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-gpio.c,v 1.6 2004/11/03 09:04:50 kraxel Exp $
+    $Id: bttv-gpio.c,v 1.7 2005/02/16 12:14:10 kraxel Exp $
 
     bttv-gpio.c  --  gpio sub drivers
 
@@ -94,6 +94,7 @@ int bttv_sub_del_devices(struct bttv_cor
 
 	list_for_each_safe(item,save,&core->subs) {
 		sub = list_entry(item,struct bttv_sub_device,list);
+		list_del(&sub->list);
 		device_unregister(&sub->dev);
 	}
 	return 0;
@@ -113,20 +114,6 @@ void bttv_gpio_irq(struct bttv_core *cor
 	}
 }
 
-void bttv_i2c_info(struct bttv_core *core, struct i2c_client *client, int attach)
-{
-	struct bttv_sub_driver *drv;
-	struct bttv_sub_device *dev;
-	struct list_head *item;
-
-	list_for_each(item,&core->subs) {
-		dev = list_entry(item,struct bttv_sub_device,list);
-		drv = to_bttv_sub_drv(dev->dev.driver);
-		if (drv && drv->i2c_info)
-			drv->i2c_info(dev,client,attach);
-	}
-}
-
 /* ----------------------------------------------------------------------- */
 /* external: sub-driver register/unregister                                */
 
Index: linux-2.6.11/drivers/media/video/bttv-i2c.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/bttv-i2c.c	2005-03-07 10:12:39.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttv-i2c.c	2005-03-07 16:23:03.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-i2c.c,v 1.17 2004/12/14 15:33:30 kraxel Exp $
+    $Id: bttv-i2c.c,v 1.18 2005/02/16 12:14:10 kraxel Exp $
 
     bttv-i2c.c  --  all the i2c code is here
 
@@ -39,7 +39,6 @@ static struct i2c_adapter bttv_i2c_adap_
 static struct i2c_client bttv_i2c_client_template;
 
 static int attach_inform(struct i2c_client *client);
-static int detach_inform(struct i2c_client *client);
 
 static int i2c_debug = 0;
 static int i2c_hw = 0;
@@ -112,7 +111,6 @@ static struct i2c_adapter bttv_i2c_adap_
 	I2C_DEVNAME("bt848"),
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
-	.client_unregister = detach_inform,
 };
 
 /* ----------------------------------------------------------------------- */
@@ -290,7 +288,6 @@ static struct i2c_adapter bttv_i2c_adap_
 	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
 	.algo          = &bttv_algo,
 	.client_register = attach_inform,
-	.client_unregister = detach_inform,
 };
 
 /* ----------------------------------------------------------------------- */
@@ -305,22 +302,12 @@ static int attach_inform(struct i2c_clie
 	if (btv->pinnacle_id != UNSET)
 		bttv_call_i2c_clients(btv,AUDC_CONFIG_PINNACLE,
 				      &btv->pinnacle_id);
-	bttv_i2c_info(&btv->c, client, 1);
-
         if (bttv_debug)
 		printk("bttv%d: i2c attach [client=%s]\n",
 		       btv->c.nr, i2c_clientname(client));
         return 0;
 }
 
-static int detach_inform(struct i2c_client *client)
-{
-        struct bttv *btv = i2c_get_adapdata(client->adapter);
-
-	bttv_i2c_info(&btv->c, client, 0);
-	return 0;
-}
-
 void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg)
 {
 	if (0 != btv->i2c_rc)
Index: linux-2.6.11/drivers/media/video/btcx-risc.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/btcx-risc.c	2005-03-07 10:12:26.000000000 +0100
+++ linux-2.6.11/drivers/media/video/btcx-risc.c	2005-03-07 16:23:11.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: btcx-risc.c,v 1.5 2004/12/10 12:33:39 kraxel Exp $
+    $Id: btcx-risc.c,v 1.6 2005/02/21 13:57:59 kraxel Exp $
 
     btcx-risc.c
 
@@ -52,12 +52,13 @@ void btcx_riscmem_free(struct pci_dev *p
 {
 	if (NULL == risc->cpu)
 		return;
-	pci_free_consistent(pci, risc->size, risc->cpu, risc->dma);
-	memset(risc,0,sizeof(*risc));
 	if (debug) {
 		memcnt--;
-		printk("btcx: riscmem free [%d]\n",memcnt);
+		printk("btcx: riscmem free [%d] dma=%lx\n",
+		       memcnt, (unsigned long)risc->dma);
 	}
+	pci_free_consistent(pci, risc->size, risc->cpu, risc->dma);
+	memset(risc,0,sizeof(*risc));
 }
 
 int btcx_riscmem_alloc(struct pci_dev *pci,
@@ -78,7 +79,8 @@ int btcx_riscmem_alloc(struct pci_dev *p
 		risc->size = size;
 		if (debug) {
 			memcnt++;
-			printk("btcx: riscmem alloc size=%d [%d]\n",size,memcnt);
+			printk("btcx: riscmem alloc [%d] dma=%lx cpu=%p size=%d\n",
+			       memcnt, (unsigned long)dma, cpu, size);
 		}
 	}
 	memset(risc->cpu,0,risc->size);
Index: linux-2.6.11/drivers/media/video/bttv-driver.c
===================================================================
--- linux-2.6.11.orig/drivers/media/video/bttv-driver.c	2005-03-07 15:25:35.000000000 +0100
+++ linux-2.6.11/drivers/media/video/bttv-driver.c	2005-03-07 16:23:11.000000000 +0100
@@ -1,5 +1,5 @@
 /*
-    $Id: bttv-driver.c,v 1.36 2005/02/15 10:51:53 kraxel Exp $
+    $Id: bttv-driver.c,v 1.37 2005/02/21 13:57:59 kraxel Exp $
 
     bttv - Bt848 frame grabber driver
 
@@ -3167,6 +3167,82 @@ static struct video_device radio_templat
 };
 
 /* ----------------------------------------------------------------------- */
+/* some debug code                                                         */
+
+int bttv_risc_decode(u32 risc)
+{
+	static char *instr[16] = {
+		[ BT848_RISC_WRITE     >> 28 ] = "write",
+		[ BT848_RISC_SKIP      >> 28 ] = "skip",
+		[ BT848_RISC_WRITEC    >> 28 ] = "writec",
+		[ BT848_RISC_JUMP      >> 28 ] = "jump",
+		[ BT848_RISC_SYNC      >> 28 ] = "sync",
+		[ BT848_RISC_WRITE123  >> 28 ] = "write123",
+		[ BT848_RISC_SKIP123   >> 28 ] = "skip123",
+		[ BT848_RISC_WRITE1S23 >> 28 ] = "write1s23",
+	};
+	static int incr[16] = {
+		[ BT848_RISC_WRITE     >> 28 ] = 2,
+		[ BT848_RISC_JUMP      >> 28 ] = 2,
+		[ BT848_RISC_SYNC      >> 28 ] = 2,
+		[ BT848_RISC_WRITE123  >> 28 ] = 5,
+		[ BT848_RISC_SKIP123   >> 28 ] = 2,
+		[ BT848_RISC_WRITE1S23 >> 28 ] = 3,
+	};
+	static char *bits[] = {
+		"be0",  "be1",  "be2",  "be3/resync",
+		"set0", "set1", "set2", "set3",
+		"clr0", "clr1", "clr2", "clr3",
+		"irq",  "res",  "eol",  "sol",
+	};
+	int i;
+
+	printk("0x%08x [ %s", risc,
+	       instr[risc >> 28] ? instr[risc >> 28] : "INVALID");
+	for (i = ARRAY_SIZE(bits)-1; i >= 0; i--)
+		if (risc & (1 << (i + 12)))
+			printk(" %s",bits[i]);
+	printk(" count=%d ]\n", risc & 0xfff);
+	return incr[risc >> 28] ? incr[risc >> 28] : 1;
+}
+
+void bttv_risc_disasm(struct bttv *btv,
+		      struct btcx_riscmem *risc)
+{
+	unsigned int i,j,n;
+
+	printk("%s: risc disasm: %p [dma=0x%08lx]\n",
+	       btv->c.name, risc->cpu, (unsigned long)risc->dma);
+	for (i = 0; i < (risc->size >> 2); i += n) {
+		printk("%s:   0x%lx: ", btv->c.name,
+		       (unsigned long)(risc->dma + (i<<2)));
+		n = bttv_risc_decode(risc->cpu[i]);
+		for (j = 1; j < n; j++)
+			printk("%s:   0x%lx: 0x%08x [ arg #%d ]\n",
+			       btv->c.name, (unsigned long)(risc->dma + ((i+j)<<2)),
+			       risc->cpu[i+j], j);
+		if (0 == risc->cpu[i])
+			break;
+	}
+}
+
+static void bttv_print_riscaddr(struct bttv *btv)
+{
+	printk("  main: %08Lx\n",
+	       (unsigned long long)btv->main.dma);
+	printk("  vbi : o=%08Lx e=%08Lx\n",
+	       btv->cvbi ? (unsigned long long)btv->cvbi->top.dma : 0,
+	       btv->cvbi ? (unsigned long long)btv->cvbi->bottom.dma : 0);
+	printk("  cap : o=%08Lx e=%08Lx\n",
+	       btv->curr.top    ? (unsigned long long)btv->curr.top->top.dma : 0,
+	       btv->curr.bottom ? (unsigned long long)btv->curr.bottom->bottom.dma : 0);
+	printk("  scr : o=%08Lx e=%08Lx\n",
+	       btv->screen ? (unsigned long long)btv->screen->top.dma : 0,
+	       btv->screen ? (unsigned long long)btv->screen->bottom.dma : 0);
+	bttv_risc_disasm(btv, &btv->main);
+}
+
+/* ----------------------------------------------------------------------- */
 /* irq handler                                                             */
 
 static char *irq_name[] = {
@@ -3204,21 +3280,6 @@ static void bttv_print_irqbits(u32 print
 	}
 }
 
-static void bttv_print_riscaddr(struct bttv *btv)
-{
-	printk("  main: %08Lx\n",
-	       (unsigned long long)btv->main.dma);
-	printk("  vbi : o=%08Lx e=%08Lx\n",
-	       btv->cvbi ? (unsigned long long)btv->cvbi->top.dma : 0,
-	       btv->cvbi ? (unsigned long long)btv->cvbi->bottom.dma : 0);
-	printk("  cap : o=%08Lx e=%08Lx\n",
-	       btv->curr.top    ? (unsigned long long)btv->curr.top->top.dma : 0,
-	       btv->curr.bottom ? (unsigned long long)btv->curr.bottom->bottom.dma : 0);
-	printk("  scr : o=%08Lx e=%08Lx\n",
-	       btv->screen ? (unsigned long long)btv->screen->top.dma  : 0,
-	       btv->screen ? (unsigned long long)btv->screen->bottom.dma : 0);
-}
-
 static void bttv_irq_debug_low_latency(struct bttv *btv, u32 rc)
 {
 	printk("bttv%d: irq: skipped frame [main=%lx,o_vbi=%lx,o_field=%lx,rc=%lx]\n",

-- 
#define printk(args...) fprintf(stderr, ## args)
