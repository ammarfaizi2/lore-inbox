Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbUKGRya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUKGRya (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKGRya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:54:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261661AbUKGRu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:50:56 -0500
Date: Sun, 7 Nov 2004 18:50:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] drivers/media/video/ cleanups
Message-ID: <20041107175017.GP14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the patch below contains several cleanups for drivers/media/video/, most 
of them are:
- needlessly global code made static
- currenly unused code removed

Please comment on this, especially if patches for in-kernel users of 
currently unused code are pending.


diffstat output:
 drivers/media/video/bt819.c                 |    2 
 drivers/media/video/bttv-cards.c            |   48 +++++---------------
 drivers/media/video/bttv-driver.c           |   18 +++----
 drivers/media/video/bttv-i2c.c              |   13 +----
 drivers/media/video/bttv-if.c               |   38 ---------------
 drivers/media/video/bttv-risc.c             |    8 +--
 drivers/media/video/bttv.h                  |   23 ---------
 drivers/media/video/bttvp.h                 |   24 ----------
 drivers/media/video/bw-qcam.c               |    8 +--
 drivers/media/video/c-qcam.c                |    4 -
 drivers/media/video/cx88/cx88-core.c        |   25 ----------
 drivers/media/video/cx88/cx88-i2c.c         |    4 -
 drivers/media/video/cx88/cx88-vbi.c         |    6 +-
 drivers/media/video/cx88/cx88-video.c       |   12 ++---
 drivers/media/video/cx88/cx88.h             |    6 --
 drivers/media/video/dpc7146.c               |    7 +-
 drivers/media/video/hexium_orion.c          |    4 -
 drivers/media/video/msp3400.c               |    8 ---
 drivers/media/video/mxb.c                   |    4 -
 drivers/media/video/mxb.h                   |    2 
 drivers/media/video/pms.c                   |    2 
 drivers/media/video/saa7134/saa7134-core.c  |    4 -
 drivers/media/video/saa7134/saa7134-video.c |   14 ++---
 drivers/media/video/saa7134/saa7134.h       |    1 
 drivers/media/video/stradis.c               |    7 --
 drivers/media/video/tuner-3036.c            |    4 -
 drivers/media/video/v4l2-common.c           |   13 -----
 drivers/media/video/zoran_card.c            |    1 
 drivers/media/video/zoran_device.c          |    6 +-
 drivers/media/video/zoran_device.h          |    1 
 drivers/media/video/zoran_driver.c          |    2 
 include/linux/videodev2.h                   |    1 
 32 files changed, 75 insertions(+), 245 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bt819.c.old	2004-11-07 16:33:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bt819.c	2004-11-07 16:33:57.000000000 +0100
@@ -95,7 +95,7 @@
 };
 
 /* for values, see the bt819 datasheet */
-struct timing timing_data[] = {
+static struct timing timing_data[] = {
 	{864 - 24, 20, 625 - 2, 1, 0x0504, 0x0000},
 	{858 - 24, 20, 525 - 2, 1, 0x00f8, 0x0000},
 };
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv.h.old	2004-11-07 17:31:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv.h	2004-11-07 16:45:37.000000000 +0100
@@ -247,13 +247,8 @@
    for possible values see lines below beginning with #define BTTV_UNKNOWN
    returns negative value if error occurred
 */
-extern int bttv_get_cardinfo(unsigned int card, int *type,
-			     unsigned int *cardid);
 extern struct pci_dev* bttv_get_pcidev(unsigned int card);
 
-/* obsolete, use bttv_get_cardinfo instead */
-extern int bttv_get_id(unsigned int card);
-
 /* sets GPOE register (BT848_GPIO_OUT_EN) to new value:
    data | (current_GPOE_value & ~mask)
    returns negative value if error occurred
@@ -273,22 +268,6 @@
 extern int bttv_write_gpio(unsigned int card,
 			   unsigned long mask, unsigned long data);
 
-/* returns pointer to task queue which can be used as parameter to
-   interruptible_sleep_on
-   in interrupt handler if BT848_INT_GPINT bit is set - this queue is activated
-   (wake_up_interruptible) and following call to the function bttv_read_gpio
-   should return new value of GPDATA,
-   returns NULL value if error occurred or queue is not available
-   WARNING: because there is no buffer for GPIO data, one MUST
-   process data ASAP
-*/
-extern wait_queue_head_t* bttv_get_gpio_queue(unsigned int card);
-
-/* call i2c clients
-*/
-extern void bttv_i2c_call(unsigned int card, unsigned int cmd, void *arg);
-
-
 
 /* ---------------------------------------------------------- */
 /* sysfs/driver-moded based gpio access interface             */
@@ -328,8 +307,6 @@
 /* ---------------------------------------------------------- */
 /* i2c                                                        */
 
-extern void bttv_bit_setscl(void *data, int state);
-extern void bttv_bit_setsda(void *data, int state);
 extern void bttv_call_i2c_clients(struct bttv *btv, unsigned int cmd, void *arg);
 extern int bttv_I2CRead(struct bttv *btv, unsigned char addr, char *probe_for);
 extern int bttv_I2CWrite(struct bttv *btv, unsigned char addr, unsigned char b1,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h.old	2004-11-07 16:34:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttvp.h	2004-11-07 16:47:42.000000000 +0100
@@ -89,7 +89,6 @@
 	int   sram;
 };
 extern const struct bttv_tvnorm bttv_tvnorms[];
-extern const unsigned int BTTV_TVNORMS;
 
 struct bttv_format {
 	char *name;
@@ -101,8 +100,6 @@
 	int  flags;
 	int  hshift,vshift;   /* for planar modes   */
 };
-extern const struct bttv_format bttv_formats[];
-extern const unsigned int BTTV_FORMATS;
 
 /* ---------------------------------------------------------- */
 
@@ -173,22 +170,6 @@
 		     struct scatterlist *sglist,
 		     unsigned int offset, unsigned int bpl,
 		     unsigned int pitch, unsigned int lines);
-int bttv_risc_planar(struct bttv *btv, struct btcx_riscmem *risc,
-		     struct scatterlist *sglist,
-		     unsigned int yoffset,  unsigned int ybpl,
-		     unsigned int ypadding, unsigned int ylines,
-		     unsigned int uoffset,  unsigned int voffset,
-		     unsigned int hshift,   unsigned int vshift,
-		     unsigned int cpadding);
-int bttv_risc_overlay(struct bttv *btv, struct btcx_riscmem *risc,
-		      const struct bttv_format *fmt,
-		      struct bttv_overlay *ov,
-		      int skip_top, int skip_bottom);
-
-/* calculate / apply geometry settings */
-void bttv_calc_geo(struct bttv *btv, struct bttv_geometry *geo,
-		   int width, int height, int interleaved, int norm);
-void bttv_apply_geo(struct bttv *btv, struct bttv_geometry *geo, int top);
 
 /* control dma register + risc main loop */
 void bttv_set_dma(struct bttv *btv, int override);
@@ -240,11 +221,6 @@
 extern void bttv_gpio_tracking(struct bttv *btv, char *comment);
 extern int init_bttv_i2c(struct bttv *btv);
 extern int fini_bttv_i2c(struct bttv *btv);
-extern int pvr_boot(struct bttv *btv);
-
-extern int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg);
-extern void bttv_reinit_bt848(struct bttv *btv);
-extern void bttv_field_count(struct bttv *btv);
 
 #define vprintk  if (bttv_verbose) printk
 #define dprintk  if (bttv_debug >= 1) printk
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c.old	2004-11-07 16:34:59.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-cards.c	2004-11-07 17:14:25.000000000 +0100
@@ -84,12 +84,13 @@
 static int tea5757_write(struct bttv *btv, int value);
 static void identify_by_eeprom(struct bttv *btv,
 			       unsigned char eeprom_data[256]);
+static int __devinit pvr_boot(struct bttv *btv);
 
 /* config variables */
 static unsigned int triton1=0;
 static unsigned int vsfx=0;
 static unsigned int latency = UNSET;
-unsigned int no_overlay=-1;
+static unsigned int no_overlay=-1;
 
 static unsigned int card[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
 static unsigned int pll[BTTV_MAX]    = { [ 0 ... (BTTV_MAX-1) ] = UNSET };
@@ -2180,7 +2181,7 @@
 	// .has_remote     = 1,
 }};
 
-const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
+static const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
 
 /* ----------------------------------------------------------------------- */
 
@@ -2349,10 +2350,10 @@
 	//todo: if(has_tda9874) btv->audio_hook = fv2000s_audio;
 }
 
-int miro_tunermap[] = { 0,6,2,3,   4,5,6,0,  3,0,4,5,  5,2,16,1,
-			14,2,17,1, 4,1,4,3,  1,2,16,1, 4,4,4,4 };
-int miro_fmtuner[]  = { 0,0,0,0,   0,0,0,0,  0,0,0,0,  0,0,0,1,
-			1,1,1,1,   1,1,1,0,  0,0,0,0,  0,1,0,0 };
+static int miro_tunermap[] = { 0,6,2,3,   4,5,6,0,  3,0,4,5,  5,2,16,1,
+			       14,2,17,1, 4,1,4,3,  1,2,16,1, 4,4,4,4 };
+static int miro_fmtuner[]  = { 0,0,0,0,   0,0,0,0,  0,0,0,0,  0,0,0,1,
+			       1,1,1,1,   1,1,1,0,  0,0,0,0,  0,1,0,0 };
 
 static void miro_pinnacle_gpio(struct bttv *btv)
 {
@@ -2521,27 +2522,6 @@
 
 /* ----------------------------------------------------------------------- */
 
-void bttv_reset_audio(struct bttv *btv)
-{
-	/*
-	 * BT878A has a audio-reset register.
-	 * 1. This register is an audio reset function but it is in
-	 *    function-0 (video capture) address space.
-	 * 2. It is enough to do this once per power-up of the card.
-	 * 3. There is a typo in the Conexant doc -- it is not at
-	 *    0x5B, but at 0x058. (B is an odd-number, obviously a typo!).
-	 * --//Shrikumar 030609
-	 */
-	if (btv->id != 878)
-		return;
-
-	if (bttv_debug)
-		printk("bttv%d: BT878A ARESET\n",btv->c.nr);
-	btwrite((1<<7), 0x058);
-	udelay(10);
-	btwrite(     0, 0x058);
-}
-
 /* initialization part one -- before registering i2c bus */
 void __devinit bttv_init_card1(struct bttv *btv)
 {
@@ -2979,7 +2959,7 @@
 
 extern int mod_firmware_load(const char *fn, char **fp);
 
-int __devinit pvr_boot(struct bttv *btv)
+static int __devinit pvr_boot(struct bttv *btv)
 {
 	u32 microlen;
 	u8 *micro;
@@ -3003,7 +2983,7 @@
 #else
 /* new 2.5.x way -- via hotplug firmware loader */
 
-int __devinit pvr_boot(struct bttv *btv)
+static int __devinit pvr_boot(struct bttv *btv)
 {
         const struct firmware *fw_entry;
 	int rc;
@@ -3129,7 +3109,7 @@
 /* ----------------------------------------------------------------------- */
 /* AVermedia specific stuff, from  bktr_card.c                             */
 
-int tuner_0_table[] = {
+static int tuner_0_table[] = {
         TUNER_PHILIPS_NTSC,  TUNER_PHILIPS_PAL /* PAL-BG*/,
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL /* PAL-I*/,
         TUNER_PHILIPS_PAL,   TUNER_PHILIPS_PAL,
@@ -3144,7 +3124,7 @@
         PHILIPS_FR1236_SECAM, PHILIPS_FR1216_PAL};
 #endif
 
-int tuner_1_table[] = {
+static int tuner_1_table[] = {
         TUNER_TEMIC_NTSC,  TUNER_TEMIC_PAL,
 	TUNER_TEMIC_PAL,   TUNER_TEMIC_PAL,
 	TUNER_TEMIC_PAL,   TUNER_TEMIC_PAL,
@@ -3338,7 +3318,7 @@
  * Brutally hacked by Dan Sheridan <dan.sheridan@contact.org.uk> djs52 8/3/00
  */
 
-void bus_low(struct bttv *btv, int bit)
+static void bus_low(struct bttv *btv, int bit)
 {
 	if (btv->mbox_ior) {
 		gpio_bits(btv->mbox_ior | btv->mbox_iow | btv->mbox_csel,
@@ -3355,7 +3335,7 @@
 	}
 }
 
-void bus_high(struct bttv *btv, int bit)
+static void bus_high(struct bttv *btv, int bit)
 {
 	if (btv->mbox_ior) {
 		gpio_bits(btv->mbox_ior | btv->mbox_iow | btv->mbox_csel,
@@ -3372,7 +3352,7 @@
 	}
 }
 
-int bus_in(struct bttv *btv, int bit)
+static int bus_in(struct bttv *btv, int bit)
 {
 	if (btv->mbox_ior) {
 		gpio_bits(btv->mbox_ior | btv->mbox_iow | btv->mbox_csel,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c.old	2004-11-07 16:40:15.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-driver.c	2004-11-07 16:41:55.000000000 +0100
@@ -321,12 +321,12 @@
 		.sram           = -1,
 	}
 };
-const unsigned int BTTV_TVNORMS = ARRAY_SIZE(bttv_tvnorms);
+static const unsigned int BTTV_TVNORMS = ARRAY_SIZE(bttv_tvnorms);
 
 /* ----------------------------------------------------------------------- */
 /* bttv format list
    packed pixel formats must come first */
-const struct bttv_format bttv_formats[] = {
+static const struct bttv_format bttv_formats[] = {
 	{
 		.name     = "8 bpp, gray",
 		.palette  = VIDEO_PALETTE_GREY,
@@ -478,7 +478,7 @@
 		.flags    = FORMAT_FLAGS_RAW,
 	}
 };
-const unsigned int BTTV_FORMATS = ARRAY_SIZE(bttv_formats);
+static const unsigned int BTTV_FORMATS = ARRAY_SIZE(bttv_formats);
 
 /* ----------------------------------------------------------------------- */
 
@@ -627,7 +627,7 @@
 	}
 
 };
-const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
+static const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
 
 /* ----------------------------------------------------------------------- */
 /* resource management                                                     */
@@ -763,7 +763,7 @@
 }
 
 /* used to switch between the bt848's analog/digital video capture modes */
-void bt848A_set_timing(struct bttv *btv)
+static void bt848A_set_timing(struct bttv *btv)
 {
 	int i, len;
 	int table_idx = bttv_tvnorms[btv->tvnorm].sram;
@@ -1071,7 +1071,7 @@
 	init_irqreg(btv);
 }
 
-void bttv_reinit_bt848(struct bttv *btv)
+static void bttv_reinit_bt848(struct bttv *btv)
 {
 	unsigned long flags;
 
@@ -1275,7 +1275,7 @@
 	       btv->c.nr,outbits,data & outbits, data & ~outbits, comment);
 }
 
-void bttv_field_count(struct bttv *btv)
+static void bttv_field_count(struct bttv *btv)
 {
 	int need_count = 0;
 
@@ -1475,7 +1475,7 @@
 	"SMICROCODE", "GVBIFMT", "SVBIFMT" };
 #define V4L1_IOCTLS ARRAY_SIZE(v4l1_ioctls)
 
-int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
+static int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg)
 {
 	switch (cmd) {
         case BTTV_VERSION:
@@ -3048,7 +3048,7 @@
 	.minor    = -1,
 };
 
-struct video_device bttv_vbi_template =
+static struct video_device bttv_vbi_template =
 {
 	.name     = "bt848/878 vbi",
 	.type     = VID_TYPE_TUNER|VID_TYPE_TELETEXT,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-if.c.old	2004-11-07 16:43:07.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-if.c	2004-11-07 16:46:51.000000000 +0100
@@ -34,30 +34,16 @@
 
 #include "bttvp.h"
 
-EXPORT_SYMBOL(bttv_get_cardinfo);
 EXPORT_SYMBOL(bttv_get_pcidev);
-EXPORT_SYMBOL(bttv_get_id);
 EXPORT_SYMBOL(bttv_gpio_enable);
 EXPORT_SYMBOL(bttv_read_gpio);
 EXPORT_SYMBOL(bttv_write_gpio);
-EXPORT_SYMBOL(bttv_get_gpio_queue);
-EXPORT_SYMBOL(bttv_i2c_call);
 
 /* ----------------------------------------------------------------------- */
 /* Exported functions - for other modules which want to access the         */
 /*                      gpio ports (IR for example)                        */
 /*                      see bttv.h for comments                            */
 
-int bttv_get_cardinfo(unsigned int card, int *type, unsigned *cardid)
-{
-	if (card >= bttv_num) {
-		return -1;
-	}
-	*type   = bttvs[card].c.type;
-	*cardid = bttvs[card].cardid;
-	return 0;
-}
-
 struct pci_dev* bttv_get_pcidev(unsigned int card)
 {
 	if (card >= bttv_num)
@@ -65,16 +51,6 @@
 	return bttvs[card].c.pci;
 }
 
-int bttv_get_id(unsigned int card)
-{
-	printk("bttv_get_id is obsolete, use bttv_get_cardinfo instead\n");
-	if (card >= bttv_num) {
-		return -1;
-	}
-	return bttvs[card].c.type;
-}
-
-
 int bttv_gpio_enable(unsigned int card, unsigned long mask, unsigned long data)
 {
 	struct bttv *btv;
@@ -128,20 +104,6 @@
 	return 0;
 }
 
-wait_queue_head_t* bttv_get_gpio_queue(unsigned int card)
-{
-	struct bttv *btv;
-
-	if (card >= bttv_num) {
-		return NULL;
-	}
-
-	btv = &bttvs[card];
-	if (bttvs[card].shutdown) {
-		return NULL;
-	}
-	return &btv->gpioq;
-}
 
 /*
  * Local variables:
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-i2c.c.old	2004-11-07 16:43:56.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-i2c.c	2004-11-07 16:44:33.000000000 +0100
@@ -55,7 +55,7 @@
 /* ----------------------------------------------------------------------- */
 /* I2C functions - bitbanging adapter (software i2c)                       */
 
-void bttv_bit_setscl(void *data, int state)
+static void bttv_bit_setscl(void *data, int state)
 {
 	struct bttv *btv = (struct bttv*)data;
 
@@ -67,7 +67,7 @@
 	btread(BT848_I2C);
 }
 
-void bttv_bit_setsda(void *data, int state)
+static void bttv_bit_setsda(void *data, int state)
 {
 	struct bttv *btv = (struct bttv*)data;
 
@@ -253,7 +253,7 @@
        	return retval;
 }
 
-int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+static int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
 {
 	struct bttv *btv = i2c_get_adapdata(i2c_adap);
 	int retval = 0;
@@ -338,13 +338,6 @@
 	i2c_clients_command(&btv->c.i2c_adap, cmd, arg);
 }
 
-void bttv_i2c_call(unsigned int card, unsigned int cmd, void *arg)
-{
-	if (card >= bttv_num)
-		return;
-	bttv_call_i2c_clients(&bttvs[card], cmd, arg);
-}
-
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
         .id       = -1,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-risc.c.old	2004-11-07 16:47:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bttv-risc.c	2004-11-07 16:48:22.000000000 +0100
@@ -109,7 +109,7 @@
 	return 0;
 }
 
-int
+static int
 bttv_risc_planar(struct bttv *btv, struct btcx_riscmem *risc,
 		 struct scatterlist *sglist,
 		 unsigned int yoffset,  unsigned int ybpl,
@@ -227,7 +227,7 @@
 	return 0;
 }
 
-int
+static int
 bttv_risc_overlay(struct bttv *btv, struct btcx_riscmem *risc,
 		  const struct bttv_format *fmt, struct bttv_overlay *ov,
 		  int skip_even, int skip_odd)
@@ -315,7 +315,7 @@
 
 /* ---------------------------------------------------------- */
 
-void
+static void
 bttv_calc_geo(struct bttv *btv, struct bttv_geometry *geo,
 	      int width, int height, int interleaved, int norm)
 {
@@ -363,7 +363,7 @@
         }
 }
 
-void
+static void
 bttv_apply_geo(struct bttv *btv, struct bttv_geometry *geo, int odd)
 {
         int off = odd ? 0x80 : 0x00;
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/bw-qcam.c.old	2004-11-07 16:50:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/bw-qcam.c	2004-11-07 16:51:57.000000000 +0100
@@ -446,7 +446,7 @@
 /* Reset the QuickCam and program for brightness, contrast,
  * white-balance, and resolution. */
 
-void qc_set(struct qcam_device *q)
+static void qc_set(struct qcam_device *q)
 {
 	int val;
 	int val2;
@@ -596,7 +596,7 @@
  * n=2^(bit depth)-1.  Ask me for more details if you don't understand
  * this. */
 
-long qc_capture(struct qcam_device * q, char __user *buf, unsigned long len)
+static long qc_capture(struct qcam_device * q, char __user *buf, unsigned long len)
 {
 	int i, j, k, yield;
 	int bytes;
@@ -896,7 +896,7 @@
 static struct qcam_device *qcams[MAX_CAMS];
 static unsigned int num_cams = 0;
 
-int init_bwqcam(struct parport *port)
+static int init_bwqcam(struct parport *port)
 {
 	struct qcam_device *qcam;
 
@@ -939,7 +939,7 @@
 	return 0;
 }
 
-void close_bwqcam(struct qcam_device *qcam)
+static void close_bwqcam(struct qcam_device *qcam)
 {
 	video_unregister_device(&qcam->vdev);
 	parport_unregister_device(qcam->pdev);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/c-qcam.c.old	2004-11-07 16:52:23.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/c-qcam.c	2004-11-07 16:52:39.000000000 +0100
@@ -741,7 +741,7 @@
 static struct qcam_device *qcams[MAX_CAMS];
 static unsigned int num_cams = 0;
 
-int init_cqcam(struct parport *port)
+static int init_cqcam(struct parport *port)
 {
 	struct qcam_device *qcam;
 
@@ -798,7 +798,7 @@
 	return 0;
 }
 
-void close_cqcam(struct qcam_device *qcam)
+static void close_cqcam(struct qcam_device *qcam)
 {
 	video_unregister_device(&qcam->vdev);
 	parport_unregister_device(qcam->pdev);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88.h.old	2004-11-07 16:53:11.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88.h	2004-11-07 16:57:25.000000000 +0100
@@ -422,7 +422,6 @@
 /* ----------------------------------------------------------- */
 /* cx88-core.c                                                 */
 
-extern char *cx88_pci_irqs[32];
 extern char *cx88_vid_irqs[32];
 extern char *cx88_mpeg_irqs[32];
 extern void cx88_print_irqbits(char *name, char *tag, char **strings,
@@ -450,8 +449,6 @@
 extern void
 cx88_free_buffer(struct pci_dev *pci, struct cx88_buffer *buf);
 
-extern void cx88_risc_disasm(struct cx88_core *core,
-			     struct btcx_riscmem *risc);
 extern int cx88_sram_channel_setup(struct cx88_core *core,
 				   struct sram_channel *ch,
 				   unsigned int bpl, u32 risc);
@@ -474,9 +471,6 @@
 /* cx88-vbi.c                                                  */
 
 void cx8800_vbi_fmt(struct cx8800_dev *dev, struct v4l2_format *f);
-int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
-			 struct cx88_dmaqueue *q,
-			 struct cx88_buffer   *buf);
 int cx8800_stop_vbi_dma(struct cx8800_dev *dev);
 int cx8800_restart_vbi_queue(struct cx8800_dev    *dev,
 			     struct cx88_dmaqueue *q);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-core.c.old	2004-11-07 16:53:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-core.c	2004-11-07 16:54:37.000000000 +0100
@@ -425,7 +425,7 @@
 /* ------------------------------------------------------------------ */
 /* debug helper code                                                  */
 
-int cx88_risc_decode(u32 risc)
+static int cx88_risc_decode(u32 risc)
 {
 	static char *instr[16] = {
 		[ RISC_SYNC    >> 28 ] = "sync",
@@ -463,24 +463,6 @@
 	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
-void cx88_risc_disasm(struct cx88_core *core,
-		      struct btcx_riscmem *risc)
-{
-	unsigned int i,j,n;
-	
-	printk("%s: risc disasm: %p [dma=0x%08lx]\n",
-	       core->name, risc->cpu, (unsigned long)risc->dma);
-	for (i = 0; i < (risc->size >> 2); i += n) {
-		printk("%s:   %04d: ", core->name, i);
-		n = cx88_risc_decode(risc->cpu[i]);
-		for (j = 1; j < n; j++)
-			printk("%s:   %04d: 0x%08x [ arg #%d ]\n",
-			       core->name, i+j, risc->cpu[i+j], j);
-		if (risc->cpu[i] == RISC_JUMP)
-			break;
-	}
-}
-
 void cx88_sram_channel_dump(struct cx88_core *core,
 			    struct sram_channel *ch)
 {
@@ -536,7 +518,7 @@
 	       core->name,cx_read(ch->cnt2_reg));
 }
 
-char *cx88_pci_irqs[32] = {
+static char *cx88_pci_irqs[32] = {
 	"vid", "aud", "ts", "vip", "hst", "5", "6", "tm1", 
 	"src_dma", "dst_dma", "risc_rd_err", "risc_wr_err",
 	"brdg_err", "src_dma_err", "dst_dma_err", "ipb_dma_err",
@@ -1183,7 +1165,6 @@
 /* ------------------------------------------------------------------ */
 
 EXPORT_SYMBOL(cx88_print_ioctl);
-EXPORT_SYMBOL(cx88_pci_irqs);
 EXPORT_SYMBOL(cx88_vid_irqs);
 EXPORT_SYMBOL(cx88_mpeg_irqs);
 EXPORT_SYMBOL(cx88_print_irqbits);
@@ -1198,8 +1179,6 @@
 EXPORT_SYMBOL(cx88_risc_stopper);
 EXPORT_SYMBOL(cx88_free_buffer);
 
-EXPORT_SYMBOL(cx88_risc_disasm);
-
 EXPORT_SYMBOL(cx88_sram_channels);
 EXPORT_SYMBOL(cx88_sram_channel_setup);
 EXPORT_SYMBOL(cx88_sram_channel_dump);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-i2c.c.old	2004-11-07 16:55:02.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-i2c.c	2004-11-07 16:55:14.000000000 +0100
@@ -44,7 +44,7 @@
 
 /* ----------------------------------------------------------------------- */
 
-void cx8800_bit_setscl(void *data, int state)
+static void cx8800_bit_setscl(void *data, int state)
 {
 	struct cx88_core *core = data;
 
@@ -56,7 +56,7 @@
 	cx_read(MO_I2C);
 }
 
-void cx8800_bit_setsda(void *data, int state)
+static void cx8800_bit_setsda(void *data, int state)
 {
 	struct cx88_core *core = data;
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-vbi.c.old	2004-11-07 16:57:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-vbi.c	2004-11-07 16:57:53.000000000 +0100
@@ -45,9 +45,9 @@
 	}
 }
 
-int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
-			 struct cx88_dmaqueue *q,
-			 struct cx88_buffer   *buf)
+static int cx8800_start_vbi_dma(struct cx8800_dev    *dev,
+				struct cx88_dmaqueue *q,
+				struct cx88_buffer   *buf)
 {
 	struct cx88_core *core = dev->core;
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-video.c.old	2004-11-07 16:59:10.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/cx88/cx88-video.c	2004-11-07 17:00:02.000000000 +0100
@@ -327,7 +327,7 @@
 		.shift                 = 0,
 	}
 };
-const int CX8800_CTLS = ARRAY_SIZE(cx8800_ctls);
+static const int CX8800_CTLS = ARRAY_SIZE(cx8800_ctls);
 
 /* ------------------------------------------------------------------- */
 /* resource management                                                 */
@@ -667,7 +667,7 @@
 	cx88_free_buffer(fh->dev->pci,buf);
 }
 
-struct videobuf_queue_ops cx8800_video_qops = {
+static struct videobuf_queue_ops cx8800_video_qops = {
 	.buf_setup    = buffer_setup,
 	.buf_prepare  = buffer_prepare,
 	.buf_queue    = buffer_queue,
@@ -1912,7 +1912,7 @@
 	.llseek        = no_llseek,
 };
 
-struct video_device cx8800_video_template =
+static struct video_device cx8800_video_template =
 {
 	.name          = "cx8800-video",
 	.type          = VID_TYPE_CAPTURE|VID_TYPE_TUNER|VID_TYPE_SCALES,
@@ -1921,7 +1921,7 @@
 	.minor         = -1,
 };
 
-struct video_device cx8800_vbi_template =
+static struct video_device cx8800_vbi_template =
 {
 	.name          = "cx8800-vbi",
 	.type          = VID_TYPE_TELETEXT|VID_TYPE_TUNER,
@@ -1939,7 +1939,7 @@
 	.llseek        = no_llseek,
 };
 
-struct video_device cx8800_radio_template =
+static struct video_device cx8800_radio_template =
 {
 	.name          = "cx8800-radio",
 	.type          = VID_TYPE_TUNER,
@@ -2213,7 +2213,7 @@
 
 /* ----------------------------------------------------------- */
 
-struct pci_device_id cx8800_pci_tbl[] = {
+static struct pci_device_id cx8800_pci_tbl[] = {
 	{
 		.vendor       = 0x14f1,
 		.device       = 0x8800,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/dpc7146.c.old	2004-11-07 17:00:31.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/dpc7146.c	2004-11-07 17:00:54.000000000 +0100
@@ -58,8 +58,7 @@
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "debug verbosity");
 
-/* global variables */
-int dpc_num = 0;
+static int dpc_num = 0;
 
 #define DPC_INPUTS	2
 static struct v4l2_input dpc_inputs[DPC_INPUTS] = {
@@ -379,7 +378,7 @@
 	.irq_func	= NULL,
 };	
 
-int __init dpc_init_module(void) 
+static int __init dpc_init_module(void) 
 {
 	if( 0 != saa7146_register_extension(&extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -389,7 +388,7 @@
 	return 0;
 }
 
-void __exit dpc_cleanup_module(void) 
+static void __exit dpc_cleanup_module(void) 
 {
 	saa7146_unregister_extension(&extension);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/hexium_orion.c.old	2004-11-07 17:01:06.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/hexium_orion.c	2004-11-07 17:01:19.000000000 +0100
@@ -499,7 +499,7 @@
 	.irq_func = NULL,
 };
 
-int __init hexium_init_module(void)
+static int __init hexium_init_module(void)
 {
 	if (0 != saa7146_register_extension(&extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -509,7 +509,7 @@
 	return 0;
 }
 
-void __exit hexium_cleanup_module(void)
+static void __exit hexium_cleanup_module(void)
 {
 	saa7146_unregister_extension(&extension);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/msp3400.c.old	2004-11-07 17:01:28.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/msp3400.c	2004-11-07 17:01:57.000000000 +0100
@@ -633,14 +633,6 @@
 	char *name;
 };
 
-struct REGISTER_DUMP d1[] = {
-	{ 0x007e, "autodetect" },
-	{ 0x0023, "C_AD_BITS " },
-	{ 0x0038, "ADD_BITS  " },
-	{ 0x003e, "CIB_BITS  " },
-	{ 0x0057, "ERROR_RATE" },
-};
-
 static int
 autodetect_stereo(struct i2c_client *client)
 {
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.h.old	2004-11-07 17:02:18.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.h	2004-11-07 17:02:57.000000000 +0100
@@ -12,7 +12,7 @@
 
 /* these are the available audio sources, which can switched
    to the line- and cd-output individually */
-struct v4l2_audio mxb_audios[MXB_AUDIOS] = {
+static struct v4l2_audio mxb_audios[MXB_AUDIOS] = {
 	    {
 		.index	= 0,
 		.name	= "Tuner",
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.c.old	2004-11-07 17:03:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/mxb.c	2004-11-07 17:03:22.000000000 +0100
@@ -1012,7 +1012,7 @@
 	.irq_func	= NULL,
 };	
 
-int __init mxb_init_module(void) 
+static int __init mxb_init_module(void) 
 {
 	if( 0 != saa7146_register_extension(&extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -1022,7 +1022,7 @@
 	return 0;
 }
 
-void __exit mxb_cleanup_module(void) 
+static void __exit mxb_cleanup_module(void) 
 {
 	saa7146_unregister_extension(&extension);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/pms.c.old	2004-11-07 17:03:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/pms.c	2004-11-07 17:04:01.000000000 +0100
@@ -896,7 +896,7 @@
 	.fops           = &pms_fops,
 };
 
-struct pms_device pms_device;
+static struct pms_device pms_device;
 
 
 /*
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134.h.old	2004-11-07 17:04:35.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134.h	2004-11-07 17:04:42.000000000 +0100
@@ -446,7 +446,6 @@
 /* saa7134-core.c                                              */
 
 extern struct list_head  saa7134_devlist;
-extern unsigned int      saa7134_devcount;
 
 void saa7134_print_ioctl(char *name, unsigned int cmd);
 void saa7134_track_gpio(struct saa7134_dev *dev, char *msg);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-core.c.old	2004-11-07 17:04:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-core.c	2004-11-07 17:05:24.000000000 +0100
@@ -95,7 +95,7 @@
 MODULE_PARM_DESC(latency,"pci latency timer");
 
 struct list_head  saa7134_devlist;
-unsigned int      saa7134_devcount;
+static unsigned int      saa7134_devcount;
 
 #define dprintk(fmt, arg...)	if (core_debug) \
 	printk(KERN_DEBUG "%s/core: " fmt, dev->name , ## arg)
@@ -233,7 +233,7 @@
 /* ------------------------------------------------------------------ */
 
 /* nr of (saa7134-)pages for the given buffer size */
-int saa7134_buffer_pages(int size)
+static int saa7134_buffer_pages(int size)
 {
 	size  = PAGE_ALIGN(size);
 	size += PAGE_SIZE; /* for non-page-aligned buffers */
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-video.c.old	2004-11-07 17:05:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/saa7134/saa7134-video.c	2004-11-07 17:06:39.000000000 +0100
@@ -1383,7 +1383,7 @@
 
 /* ------------------------------------------------------------------ */
 
-void saa7134_vbi_fmt(struct saa7134_dev *dev, struct v4l2_format *f)
+static void saa7134_vbi_fmt(struct saa7134_dev *dev, struct v4l2_format *f)
 {
 	struct saa7134_tvnorm *norm = dev->tvnorm;
 
@@ -1406,8 +1406,8 @@
 #endif
 }
 
-int saa7134_g_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
-		  struct v4l2_format *f)
+static int saa7134_g_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
+			 struct v4l2_format *f)
 {
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
@@ -1432,8 +1432,8 @@
 	}
 }
 
-int saa7134_try_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
-		    struct v4l2_format *f)
+static int saa7134_try_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
+			   struct v4l2_format *f)
 {
 	int err;
 	
@@ -1497,8 +1497,8 @@
 	}
 }
 
-int saa7134_s_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
-		  struct v4l2_format *f)
+static int saa7134_s_fmt(struct saa7134_dev *dev, struct saa7134_fh *fh,
+			 struct v4l2_format *f)
 {
 	unsigned long flags;
 	int err;
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/stradis.c.old	2004-11-07 17:06:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/stradis.c	2004-11-07 17:07:17.000000000 +0100
@@ -97,13 +97,6 @@
 #define debAudio	(NewCard ? nDebAudio : oDebAudio)
 #define debDMA		(NewCard ? nDebDMA : oDebDMA)
 
-#ifdef DEBUG
-int stradis_driver(void)	/* for the benefit of ksymoops */
-{
-	return 1;
-}
-#endif
-
 #ifdef USE_RESCUE_EEPROM_SDM275
 static unsigned char rescue_eeprom[64] = {
 0x00,0x01,0x04,0x13,0x26,0x0f,0x10,0x00,0x00,0x00,0x43,0x63,0x22,0x01,0x29,0x15,0x73,0x00,0x1f, 'd', 'e', 'c', 'x', 'l', 'd', 'v', 'a',0x02,0x00,0x01,0x00,0xcc,0xa4,0x63,0x09,0xe2,0x10,0x00,0x0a,0x00,0x02,0x02, 'd', 'e', 'c', 'x', 'l', 'a',0x00,0x00,0x42,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/tuner-3036.c.old	2004-11-07 17:07:29.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/tuner-3036.c	2004-11-07 17:07:41.000000000 +0100
@@ -197,14 +197,14 @@
 	.name		= "SAB3036",
 };
 
-int __init
+static int __init
 tuner3036_init(void)
 {
 	i2c_add_driver(&i2c_driver_tuner);
 	return 0;
 }
 
-void __exit
+static void __exit
 tuner3036_exit(void)
 {
 	i2c_del_driver(&i2c_driver_tuner);
--- linux-2.6.10-rc1-mm3-full/include/linux/videodev2.h.old	2004-11-07 17:09:48.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/videodev2.h	2004-11-07 17:09:55.000000000 +0100
@@ -910,7 +910,6 @@
 #include <linux/fs.h>
 
 /*  Video standard functions  */
-extern unsigned int v4l2_video_std_fps(struct v4l2_standard *vs);
 extern int v4l2_video_std_construct(struct v4l2_standard *vs,
 				    int id, char *name);
 
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/v4l2-common.c.old	2004-11-07 17:10:03.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/v4l2-common.c	2004-11-07 17:10:23.000000000 +0100
@@ -84,18 +84,6 @@
  *  Video Standard Operations (contributed by Michael Schimek)
  */
 
-/* This is the recommended method to deal with the framerate fields. More
-   sophisticated drivers will access the fields directly. */
-unsigned int
-v4l2_video_std_fps(struct v4l2_standard *vs)
-{
-	if (vs->frameperiod.numerator > 0)
-		return (((vs->frameperiod.denominator << 8) /
-			 vs->frameperiod.numerator) +
-			(1 << 7)) / (1 << 8);
-	return 0;
-}
-
 /* Fill in the fields of a v4l2_standard structure according to the
    'id' and 'transmission' parameters.  Returns negative on error.  */
 int v4l2_video_std_construct(struct v4l2_standard *vs,
@@ -259,7 +247,6 @@
 
 /* ----------------------------------------------------------------- */
 
-EXPORT_SYMBOL(v4l2_video_std_fps);
 EXPORT_SYMBOL(v4l2_video_std_construct);
 
 EXPORT_SYMBOL(v4l2_prio_init);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.h.old	2004-11-07 17:11:04.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.h	2004-11-07 17:11:12.000000000 +0100
@@ -79,7 +79,6 @@
 				 int set_master);
 extern void zoran_init_hardware(struct zoran *zr);
 extern void zr36057_restart(struct zoran *zr);
-extern void zr36057_init_vfe(struct zoran *zr);
 
 /* i2c */
 extern int decoder_command(struct zoran *zr,
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.c.old	2004-11-07 17:11:20.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_device.c	2004-11-07 17:12:25.000000000 +0100
@@ -57,7 +57,6 @@
 		   ZR36057_ISR_JPEGRepIRQ )
 
 extern const struct zoran_format zoran_formats[];
-extern const int zoran_num_formats;
 
 extern int *zr_debug;
 
@@ -80,6 +79,9 @@
 MODULE_PARM_DESC(lml33dpath,
 		 "Use digital path capture mode (on LML33 cards)");
 
+static void
+zr36057_init_vfe (struct zoran *zr);
+
 /*
  * General Purpose I/O and Guest bus access
  */
@@ -1701,7 +1703,7 @@
  * initialize video front end
  */
 
-void
+static void
 zr36057_init_vfe (struct zoran *zr)
 {
 	u32 reg;
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_card.c.old	2004-11-07 17:12:33.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_card.c	2004-11-07 17:12:38.000000000 +0100
@@ -58,7 +58,6 @@
 #define I2C_NAME(x) (x)->name
 
 extern const struct zoran_format zoran_formats[];
-extern const int zoran_num_formats;
 
 static int card[BUZ_MAX] = { -1, -1, -1, -1 };
 module_param_array(card, int, NULL, 0);
--- linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_driver.c.old	2004-11-07 17:12:46.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/video/zoran_driver.c	2004-11-07 17:12:55.000000000 +0100
@@ -176,7 +176,7 @@
 			 ZORAN_FORMAT_COMPRESSED,
 	}
 };
-const int zoran_num_formats =
+static const int zoran_num_formats =
     (sizeof(zoran_formats) / sizeof(struct zoran_format));
 
 // RJ: Test only - want to test BUZ_USE_HIMEM even when CONFIG_BIGPHYS_AREA is defined

