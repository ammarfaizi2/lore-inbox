Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTJGKqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 06:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTJGKqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 06:46:42 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:43410 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262130AbTJGKoP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 06:44:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Oct 2003 12:58:46 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv driver update
Message-ID: <20031007105846.GA3426@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This patch updates the bttv driver.  It depends on the videobuf patch.
Changes:

  * usual tv card list updates.
  * sysfs adaptions.
  * new, experimental i2c adapter code for bt878 chips
    (not used by default yet).
  * various minor fixes.

Please apply,

  Gerd

diff -u linux-2.6.0-test6/drivers/media/video/bt848.h linux/drivers/media/video/bt848.h
--- linux-2.6.0-test6/drivers/media/video/bt848.h	2003-10-06 17:44:53.000000000 +0200
+++ linux/drivers/media/video/bt848.h	2003-10-06 17:59:00.000000000 +0200
@@ -282,13 +282,16 @@
 #define BT848_GPIO_DMA_CTL_FIFO_ENABLE (1<<0)
 
 #define BT848_I2C              0x110
+#define BT878_I2C_MODE         (1<<7)
+#define BT878_I2C_RATE         (1<<6)
+#define BT878_I2C_NOSTOP       (1<<5)
+#define BT878_I2C_NOSTART      (1<<4)
 #define BT848_I2C_DIV          (0xf<<4)
 #define BT848_I2C_SYNC         (1<<3)
 #define BT848_I2C_W3B	       (1<<2)
 #define BT848_I2C_SCL          (1<<1)
 #define BT848_I2C_SDA          (1<<0)
 
-
 #define BT848_RISC_STRT_ADD    0x114
 #define BT848_GPIO_OUT_EN      0x118
 #define BT848_GPIO_REG_INP     0x11C
diff -u linux-2.6.0-test6/drivers/media/video/btcx-risc.c linux/drivers/media/video/btcx-risc.c
--- linux-2.6.0-test6/drivers/media/video/btcx-risc.c	2003-10-06 17:44:30.000000000 +0200
+++ linux/drivers/media/video/btcx-risc.c	2003-10-06 17:48:02.000000000 +0200
@@ -44,39 +44,6 @@
 
 static int memcnt;
 
-int btcx_riscmem_alloc(struct pci_dev *pci,
-		       struct btcx_riscmem *risc,
-		       unsigned int size)
-{
-	u32 *cpu;
-	dma_addr_t dma;
-	
-	cpu = pci_alloc_consistent(pci, size, &dma);
-	if (NULL == cpu)
-		return -ENOMEM;
-	memset(cpu,0,size);
-
-#if 0
-	if (risc->cpu && risc->size < size) {
-		/* realloc (enlarge buffer) -- copy old stuff */
-		memcpy(cpu,risc->cpu,risc->size);
-		btcx_riscmem_free(pci,risc);
-	}
-#else
-	BUG_ON(NULL != risc->cpu);
-#endif
-	risc->cpu  = cpu;
-	risc->dma  = dma;
-	risc->size = size;
-
-	if (debug) {
-		memcnt++;
-		printk("btcx: riscmem alloc size=%d [%d]\n",size,memcnt);
-	}
-
-	return 0;
-}
-
 void btcx_riscmem_free(struct pci_dev *pci,
 		       struct btcx_riscmem *risc)
 {
@@ -90,6 +57,31 @@
 	}
 }
 
+int btcx_riscmem_alloc(struct pci_dev *pci,
+		       struct btcx_riscmem *risc,
+		       unsigned int size)
+{
+	u32 *cpu;
+	dma_addr_t dma;
+
+	if (NULL != risc->cpu && risc->size < size)
+		btcx_riscmem_free(pci,risc);
+	if (NULL == risc->cpu) {
+		cpu = pci_alloc_consistent(pci, size, &dma);
+		if (NULL == cpu)
+			return -ENOMEM;
+		risc->cpu  = cpu;
+		risc->dma  = dma;
+		risc->size = size;
+		if (debug) {
+			memcnt++;
+			printk("btcx: riscmem alloc size=%d [%d]\n",size,memcnt);
+		}
+	}
+	memset(risc->cpu,0,risc->size);
+	return 0;
+}
+
 /* ---------------------------------------------------------- */
 /* screen overlay helpers                                     */
 
diff -u linux-2.6.0-test6/drivers/media/video/bttv-cards.c linux/drivers/media/video/bttv-cards.c
--- linux-2.6.0-test6/drivers/media/video/bttv-cards.c	2003-10-06 17:45:22.000000000 +0200
+++ linux/drivers/media/video/bttv-cards.c	2003-10-06 17:48:02.000000000 +0200
@@ -21,10 +21,9 @@
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-    
+
 */
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -32,7 +31,9 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
-#include <linux/firmware.h>
+#ifdef CONFIG_FW_LOADER
+# include <linux/firmware.h>
+#endif
 
 #include <asm/io.h>
 
@@ -62,6 +63,7 @@
 static void rv605_muxsel(struct bttv *btv, unsigned int input);
 static void eagle_muxsel(struct bttv *btv, unsigned int input);
 static void xguard_muxsel(struct bttv *btv, unsigned int input);
+static void ivc120_muxsel(struct bttv *btv, unsigned int input);
 
 static int terratec_active_radio_upgrade(struct bttv *btv);
 static int tea5757_read(struct bttv *btv);
@@ -78,6 +80,7 @@
 static unsigned int card[BTTV_MAX]  = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
 static unsigned int pll[BTTV_MAX]   = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
 static unsigned int tuner[BTTV_MAX] = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
+static unsigned int svhs[BTTV_MAX]  = { [ 0 ... (BTTV_MAX-1) ] = UNSET};
 #ifdef MODULE
 static unsigned int autoload = 1;
 #else
@@ -216,12 +219,32 @@
 	{ 0x1466aa06, BTTV_PV150,         "Provideo PV150B-3" },
 	{ 0x1467aa07, BTTV_PV150,         "Provideo PV150B-4" },
 
-
-	{ 0xa1550000, BTTV_IVC200,        "IVC-200" },
-	{ 0xa1550001, BTTV_IVC200,        "IVC-200" },
-	{ 0xa1550002, BTTV_IVC200,        "IVC-200" },
-	{ 0xa1550003, BTTV_IVC200,        "IVC-200" },	
-
+	{ 0xa132ff00, BTTV_IVC100,        "IVC-100"  },
+	{ 0xa1550000, BTTV_IVC200,        "IVC-200"  },
+	{ 0xa1550001, BTTV_IVC200,        "IVC-200"  },
+	{ 0xa1550002, BTTV_IVC200,        "IVC-200"  },
+	{ 0xa1550003, BTTV_IVC200,        "IVC-200"  },	
+	{ 0xa1550100, BTTV_IVC200,        "IVC-200G" },
+	{ 0xa1550101, BTTV_IVC200,        "IVC-200G" },
+	{ 0xa1550102, BTTV_IVC200,        "IVC-200G" },
+	{ 0xa1550103, BTTV_IVC200,        "IVC-200G" },
+	{ 0xa182ff00, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff01, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff02, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff03, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff04, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff05, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff06, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff07, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff08, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff09, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff0a, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff0b, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff0c, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff0d, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff0e, BTTV_IVC120,        "IVC-120G" },
+	{ 0xa182ff0f, BTTV_IVC120,        "IVC-120G" },
+	
 	{ 0x41424344, BTTV_GRANDTEC,      "GrandTec Multi Capture" },
 	{ 0x01020304, BTTV_XGUARD,        "Grandtec Grand X-Guard" },
 	
@@ -1338,7 +1361,7 @@
 },{
         .name           = "Jetway TV/Capture JW-TV878-FBK, Kworld KW-TV878RF",
         .video_inputs   = 4,
-        .audio_inputs   = 3, 
+        .audio_inputs   = 3,
         .tuner          = 0,
         .svhs           = 2,
         .gpiomask       = 7,
@@ -1388,18 +1411,19 @@
 	.gpiomask       = 7,
 	.audiomux       = {7},
 },{
-	.name           = "GV-BCTV5/PCI",
+	.name           = "IODATA GV-BCTV5/PCI",
 	.video_inputs   = 3,
 	.audio_inputs   = 1,
 	.tuner          = 0,
 	.svhs           = 2,
-	.gpiomask       = 0x010f00,
+	.gpiomask       = 0x0f0f80,
 	.muxsel         = {2, 3, 1, 0},
-	.audiomux       = {0x10000, 0, 0x10000, 0, 0, 0},
+	.audiomux       = {0x030000, 0x010000, 0x030000, 0, 0x020000, 0},
 	.no_msp34xx     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = TUNER_PHILIPS_NTSC_M,
 	.audio_hook     = gvbctv3pci_audio,
+	.has_radio      = 1,
 },{
 	.name           = "Osprey 100/150 (878)", /* 0x1(2|3)-45C6-C1 */
 	.video_inputs   = 4,                  /* id-inputs-clock */
@@ -1720,16 +1744,14 @@
 
 	/* ---- card 0x68 ---------------------------------- */
 	.name           = "Nebula Electronics DigiTV",
-	.video_inputs   = 0,
-	.audio_inputs   = 0,
 	.svhs           = -1,
 	.muxsel         = { 2, 3, 1, 0},
-	.needs_tvaudio  = 0,
 	.no_msp34xx     = 1,
 	.no_tda9875     = 1,
 	.no_tda7432     = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+	.no_video       = 1,
 },{
 	/* Jorge Boncompte - DTI2 <jorge@dti2.net> */
 	.name           = "ProVideo PV143",
@@ -1801,6 +1823,33 @@
 	.needs_tvaudio  = 1,
 	.pll            = PLL_28,
 	.tuner_type     = -1,
+},{
+        .name           = "IVC-100",
+        .video_inputs   = 4,
+        .audio_inputs   = 0,
+        .tuner          = -1,
+        .tuner_type     = -1,
+        .svhs           = -1,
+        .gpiomask       = 0xdf,
+        .muxsel         = { 2, 3, 1, 0 },
+        .pll            = PLL_28,
+},{
+	/* IVC-120G - Alan Garfield <alan@fromorbit.com> */
+	.name           = "IVC-120G",
+	.video_inputs   = 16,
+	.audio_inputs   = 0,    /* card has no audio */
+	.tuner          = -1,   /* card has no tuner */
+	.tuner_type     = -1,
+	.svhs           = -1,   /* card has no svhs */
+	.needs_tvaudio  = 0,
+	.no_msp34xx     = 1,
+	.no_tda9875     = 1,
+	.no_tda7432     = 1,
+	.gpiomask       = 0x00,
+	.muxsel         = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 
+			    0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10 },
+	.muxsel_hook    = ivc120_muxsel,
+	.pll            = PLL_28,
 }};
 
 const unsigned int bttv_num_tvcards = ARRAY_SIZE(bttv_tvcards);
@@ -1853,12 +1902,8 @@
 		btv->type=card[btv->nr];
 	
 	/* print which card config we are using */
-	sprintf(btv->video_dev.name,"BT%d%s(%.23s)",
-		btv->id,
-		(btv->id==848 && btv->revision==0x12) ? "A" : "",
-		bttv_tvcards[btv->type].name);
 	printk(KERN_INFO "bttv%d: using: %s [card=%d,%s]\n",btv->nr,
-	       btv->video_dev.name,btv->type,
+	       bttv_tvcards[btv->type].name, btv->type,
 	       card[btv->nr] < bttv_num_tvcards
 	       ? "insmod option" : "autodetected");
 
@@ -2107,6 +2152,27 @@
 
 /* ----------------------------------------------------------------------- */
 
+void bttv_reset_audio(struct bttv *btv)
+{
+	/*
+	 * BT878A has a audio-reset register.
+	 * 1. This register is an audio reset function but it is in
+	 *    function-0 (video capture) address space.
+	 * 2. It is enough to do this once per power-up of the card.
+	 * 3. There is a typo in the Conexant doc -- it is not at
+	 *    0x5B, but at 0x058. (B is an odd-number, obviously a typo!).
+	 * --//Shrikumar 030609
+	 */
+	if (btv->id != 878)
+		return;
+	
+	if (bttv_debug)
+		printk("bttv%d: BT878A ARESET\n",btv->nr);
+	btwrite((1<<7), 0x058);
+	udelay(10);
+	btwrite(     0, 0x058);
+}
+
 /* initialization part one -- before registering i2c bus */
 void __devinit bttv_init_card1(struct bttv *btv)
 {
@@ -2269,6 +2335,9 @@
 				      &btv->pinnacle_id);
 	if (btv->tuner_type != UNSET)
 		bttv_call_i2c_clients(btv,TUNER_SET_TYPE,&btv->tuner_type);
+	btv->svhs = bttv_tvcards[btv->type].svhs;
+	if (svhs[btv->nr] != UNSET)
+		btv->svhs = svhs[btv->nr];
 
 	if (bttv_tvcards[btv->type].has_radio)
 		btv->has_radio=1;
@@ -2548,10 +2617,9 @@
 int __devinit pvr_boot(struct bttv *btv)
 {
         const struct firmware *fw_entry;
-	struct device *dev = &btv->dev->dev;
 	int rc;
 
-	rc = request_firmware(&fw_entry, "hcwamc.rbf", dev);
+	rc = request_firmware(&fw_entry, "hcwamc.rbf", &btv->dev->dev);
 	if (rc != 0) {
 		printk(KERN_WARNING "bttv%d: no altera firmware [via hotplug]\n",
 		       btv->nr);
@@ -2696,12 +2764,12 @@
 
 static void __devinit avermedia_eeprom(struct bttv *btv)
 {
-        int tuner_make,tuner_tv_fm,tuner_format,tuner=0,remote;
+        int tuner_make,tuner_tv_fm,tuner_format,tuner=0;
 
-	tuner_make   = (eeprom_data[0x41] & 0x7);
-        tuner_tv_fm  = (eeprom_data[0x41] & 0x18) >> 3;
-        tuner_format = (eeprom_data[0x42] & 0xf0) >> 4;
-	remote       = (eeprom_data[0x42] & 0x01);
+	tuner_make      = (eeprom_data[0x41] & 0x7);
+        tuner_tv_fm     = (eeprom_data[0x41] & 0x18) >> 3;
+        tuner_format    = (eeprom_data[0x42] & 0xf0) >> 4;
+	btv->has_remote = (eeprom_data[0x42] & 0x01);
 
 	if (tuner_make == 0 || tuner_make == 2)
 		if(tuner_format <=9)
@@ -2718,8 +2786,8 @@
 	} else
 		printk("Unknown type");
 	printk(" radio:%s remote control:%s\n",
-		tuner_tv_fm?"yes":"no",
-		remote?"yes":"no");
+	       tuner_tv_fm     ? "yes" : "no",
+	       btv->has_remote ? "yes" : "no");
 }
 
 /* used on Voodoo TV/FM (Voodoo 200), S0 wired to 0x10000 */
@@ -3448,6 +3516,72 @@
         btwrite(masks[input%16], BT848_GPIO_DATA);
 }
 
+/*
+ * ivc120_muxsel [Added by Alan Garfield <alan@fromorbit.com>]
+ *
+ * The IVC120G security card has 4 i2c controlled TDA8540 matrix
+ * swichers to provide 16 channels to MUX0. The TDA8540's have 
+ * 4 indepedant outputs and as such the IVC120G also has the 
+ * optional "Monitor Out" bus. This allows the card to be looking 
+ * at one input while the monitor is looking at another.
+ *
+ * Since I've couldn't be bothered figuring out how to add an
+ * independant muxsel for the monitor bus, I've just set it to 
+ * whatever the card is looking at.
+ *
+ *  OUT0 of the TDA8540's is connected to MUX0         (0x03)
+ *  OUT1 of the TDA8540's is connected to "Monitor Out"        (0x0C)
+ *
+ *  TDA8540_ALT3 IN0-3 = Channel 13 - 16       (0x03)
+ *  TDA8540_ALT4 IN0-3 = Channel 1 - 4         (0x03)
+ *  TDA8540_ALT5 IN0-3 = Channel 5 - 8         (0x03)
+ *  TDA8540_ALT6 IN0-3 = Channel 9 - 12                (0x03)
+ *
+ */
+
+/* All 7 possible sub-ids for the TDA8540 Matrix Switcher */
+#define I2C_TDA8540        0x90
+#define I2C_TDA8540_ALT1   0x92
+#define I2C_TDA8540_ALT2   0x94
+#define I2C_TDA8540_ALT3   0x96
+#define I2C_TDA8540_ALT4   0x98
+#define I2C_TDA8540_ALT5   0x9a
+#define I2C_TDA8540_ALT6   0x9c
+
+static void ivc120_muxsel(struct bttv *btv, unsigned int input)
+{
+	// Simple maths
+	int key = input % 4;    
+	int matrix = input / 4;
+	
+	dprintk("bttv%d: ivc120_muxsel: Input - %02d | TDA - %02d | In - %02d\n",
+		btv->nr, input, matrix, key);
+	
+	// Handles the input selection on the TDA8540's
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT3, 0x00,
+		      ((matrix == 3) ? (key | key << 2) : 0x00), 1);
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT4, 0x00,
+		      ((matrix == 0) ? (key | key << 2) : 0x00), 1);
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT5, 0x00,
+		      ((matrix == 1) ? (key | key << 2) : 0x00), 1);
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT6, 0x00,
+		      ((matrix == 2) ? (key | key << 2) : 0x00), 1);
+	
+	// Handles the output enables on the TDA8540's
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT3, 0x02,
+		      ((matrix == 3) ? 0x03 : 0x00), 1);  // 13 - 16
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT4, 0x02,
+		      ((matrix == 0) ? 0x03 : 0x00), 1);  // 1-4
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT5, 0x02,
+		      ((matrix == 1) ? 0x03 : 0x00), 1);  // 5-8 
+	bttv_I2CWrite(btv, I2C_TDA8540_ALT6, 0x02,
+		      ((matrix == 2) ? 0x03 : 0x00), 1);  // 9-12
+	
+	// Selects MUX0 for input on the 878
+	btaor((0)<<5, ~(3<<5), BT848_IFORM);
+}
+
+
 /* ----------------------------------------------------------------------- */
 /* motherboard chipset specific stuff                                      */
 
@@ -3467,9 +3601,11 @@
 		latency = 0x0A;
 #endif
 
+#if 0
 	/* print which chipset we have */
 	while ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
 		printk(KERN_INFO "bttv: Host bridge is %s\n",pci_name(dev));
+#endif
 
 	/* print warnings about any quirks found */
 	if (triton1)
diff -u linux-2.6.0-test6/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.0-test6/drivers/media/video/bttv-driver.c	2003-10-06 17:45:59.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2003-10-06 17:48:02.000000000 +0200
@@ -61,14 +61,15 @@
 static int vbi_nr = -1;
 
 static unsigned int fdsr = 0;
-static unsigned int gpint = 1;
 
 /* options */
-static unsigned int combfilter = 0;
-static unsigned int lumafilter = 0;
-static unsigned int automute   = 1;
-static unsigned int chroma_agc = 0;
-static unsigned int adc_crush  = 1;
+static unsigned int combfilter  = 0;
+static unsigned int lumafilter  = 0;
+static unsigned int automute    = 1;
+static unsigned int chroma_agc  = 0;
+static unsigned int adc_crush   = 1;
+static unsigned int vcr_hack    = 0;
+static unsigned int irq_iswitch = 0;
 
 /* API features (turn on/off stuff for testing) */
 static unsigned int sloppy     = 0;
@@ -98,7 +99,6 @@
 MODULE_PARM(vbi_nr,"i");
 
 MODULE_PARM(fdsr,"i");
-MODULE_PARM(gpint,"i");
 
 MODULE_PARM(combfilter,"i");
 MODULE_PARM(lumafilter,"i");
@@ -108,6 +108,10 @@
 MODULE_PARM_DESC(chroma_agc,"enables the AGC of chroma signal, default is 0 (no)");
 MODULE_PARM(adc_crush,"i");
 MODULE_PARM_DESC(adc_crush,"enables the luminance ADC crush, default is 1 (yes)");
+MODULE_PARM(vcr_hack,"i");
+MODULE_PARM_DESC(vcr_hack,"enables the VCR hack (improves synch on poor VCR tapes), default is 0 (no)");
+MODULE_PARM(irq_iswitch,"i");
+MODULE_PARM_DESC(irq_iswitch,"switch inputs in irq handler");
 
 MODULE_PARM(sloppy,"i");
 MODULE_PARM(v4l2,"i");
@@ -115,7 +119,6 @@
 MODULE_DESCRIPTION("bttv - v4l/v4l2 driver module for bt848/878 based cards");
 MODULE_AUTHOR("Ralph Metzler & Marcus Metzler & Gerd Knorr");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_CHARDEV_MAJOR(VIDEO_MAJOR);
 
 /* kernel args */
 #ifndef MODULE
@@ -124,6 +127,17 @@
 #endif
 
 /* ----------------------------------------------------------------------- */
+/* sysfs                                                                   */
+
+static ssize_t show_card(struct class_device *cd, char *buf)
+{
+	struct video_device *vfd = to_video_device(cd);
+	struct bttv *btv = dev_get_drvdata(vfd->dev);
+	return sprintf(buf, "%d\n", btv ? btv->type : UNSET);
+}
+static CLASS_DEVICE_ATTR(card, S_IRUGO, show_card, NULL);
+
+/* ----------------------------------------------------------------------- */
 /* static data                                                             */
 
 /* special timing tables from conexant... */
@@ -464,7 +478,8 @@
 #define V4L2_CID_PRIVATE_AUTOMUTE    (V4L2_CID_PRIVATE_BASE + 2)
 #define V4L2_CID_PRIVATE_LUMAFILTER  (V4L2_CID_PRIVATE_BASE + 3)
 #define V4L2_CID_PRIVATE_AGC_CRUSH   (V4L2_CID_PRIVATE_BASE + 4)
-#define V4L2_CID_PRIVATE_LASTP1      (V4L2_CID_PRIVATE_BASE + 5)
+#define V4L2_CID_PRIVATE_VCR_HACK    (V4L2_CID_PRIVATE_BASE + 5)
+#define V4L2_CID_PRIVATE_LASTP1      (V4L2_CID_PRIVATE_BASE + 6)
 
 static const struct v4l2_queryctrl no_ctl = {
 	.name  = "42",
@@ -576,6 +591,12 @@
 		.minimum       = 0,
 		.maximum       = 1,
 		.type          = V4L2_CTRL_TYPE_BOOLEAN,
+	},{
+		.id            = V4L2_CID_PRIVATE_VCR_HACK,
+		.name          = "vcr hack",
+		.minimum       = 0,
+		.maximum       = 1,
+		.type          = V4L2_CTRL_TYPE_BOOLEAN,
 	}
 };
 const int BTTV_CTLS = ARRAY_SIZE(bttv_ctls);
@@ -721,7 +742,7 @@
 	int table_idx = bttv_tvnorms[btv->tvnorm].sram;
 	int fsc       = bttv_tvnorms[btv->tvnorm].Fsc;
 
-	if (bttv_tvcards[btv->type].muxsel[btv->input] < 0) {
+	if (UNSET == bttv_tvcards[btv->type].muxsel[btv->input]) {
 		dprintk("bttv%d: load digital timing table (table_idx=%d)\n",
 			btv->nr,table_idx);
 
@@ -815,13 +836,7 @@
 	if (mask2)
 		btaor(mask2,~mask2,BT848_GPIO_OUT_EN);
 
-#if 0
-	/* This seems to get rid of some synchronization problems */
-	btand(~(3<<5), BT848_IFORM);
-	schedule_timeout(HZ/10);
-#endif
-
-	if (input==bttv_tvcards[btv->type].svhs)  {
+	if (input == btv->svhs)  {
 		btor(BT848_CONTROL_COMP, BT848_E_CONTROL);
 		btor(BT848_CONTROL_COMP, BT848_O_CONTROL);
 	} else {
@@ -933,8 +948,21 @@
 static void
 set_input(struct bttv *btv, unsigned int input)
 {
+	unsigned long flags;
+	
 	btv->input = input;
-	video_mux(btv,input);
+	if (irq_iswitch) {
+		spin_lock_irqsave(&btv->s_lock,flags);
+		if (btv->curr.irqflags) {
+			/* active capture -> delayed input switch */
+			btv->new_input = input;
+		} else {
+			video_mux(btv,input);
+		}
+		spin_unlock_irqrestore(&btv->s_lock,flags);
+	} else {
+		video_mux(btv,input);
+	}
 	audio_mux(btv,(input == bttv_tvcards[btv->type].tuner ?
 		       AUDIO_TUNER : AUDIO_EXTERN));
 	set_tvnorm(btv,btv->tvnorm);
@@ -974,6 +1002,16 @@
 		btwrite(BT848_CONTROL_LDEC, BT848_E_CONTROL);
 		btwrite(BT848_CONTROL_LDEC, BT848_O_CONTROL);
 	}
+
+        /* interrupt */
+        btwrite(0xfffffUL, BT848_INT_STAT);
+        btwrite((btv->triton1)  |
+                BT848_INT_GPINT |
+                BT848_INT_SCERR |
+                (fdsr ? BT848_INT_FDSR : 0) |
+                BT848_INT_RISCI|BT848_INT_OCERR|BT848_INT_VPRES|
+                BT848_INT_FMTCHG|BT848_INT_HLOCK,
+                BT848_INT_MASK);
 }
 
 extern void bttv_reinit_bt848(struct bttv *btv)
@@ -1053,6 +1091,9 @@
 	case V4L2_CID_PRIVATE_AGC_CRUSH:
 		c->value = btv->opt_adc_crush;
 		break;
+	case V4L2_CID_PRIVATE_VCR_HACK:
+		c->value = btv->opt_vcr_hack;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1138,6 +1179,9 @@
 		btwrite(BT848_ADC_RESERVED | (btv->opt_adc_crush ? BT848_ADC_CRUSH : 0),
 			BT848_ADC);
 		break;
+	case V4L2_CID_PRIVATE_VCR_HACK:
+		btv->opt_vcr_hack = c->value;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1281,7 +1325,7 @@
 	/* alloc risc memory */
 	if (STATE_NEEDS_INIT == buf->vb.state) {
 		redo_dma_risc = 1;
-		if (0 != (rc = videobuf_iolock(btv->dev,&buf->vb)))
+		if (0 != (rc = videobuf_iolock(btv->dev,&buf->vb,&btv->fbuf)))
 			goto fail;
 	}
 
@@ -1429,7 +1473,7 @@
                         v->flags|=VIDEO_VC_TUNER;
                         v->type=VIDEO_TYPE_TV;
                         v->tuners=1;
-                } else if (channel == bttv_tvcards[btv->type].svhs) {
+                } else if (channel == btv->svhs) {
                         strcpy(v->name,"S-Video");
                 } else {
                         sprintf(v->name,"Composite%d",channel);
@@ -1562,7 +1606,7 @@
 			sprintf(i->name, "Television");
 			i->type  = V4L2_INPUT_TYPE_TUNER;
 			i->tuner = 0;
-		} else if (i->index==bttv_tvcards[btv->type].svhs) {
+		} else if (i->index == btv->svhs) {
 			sprintf(i->name, "S-Video");
 		} else {
                         sprintf(i->name,"Composite%d",i->index);
@@ -1766,7 +1810,7 @@
 	}
 	/* clip against screen */
 	if (NULL != btv->fbuf.base)
-		n = btcx_screen_clips(btv->fbuf.width, btv->fbuf.width,
+		n = btcx_screen_clips(btv->fbuf.fmt.width, btv->fbuf.fmt.height,
 				      &win->w, clips, n);
 	btcx_sort_clips(clips,n);
 
@@ -2032,6 +2076,21 @@
 	if (btv->errors)
 		bttv_reinit_bt848(btv);
 
+#ifdef VIDIOC_G_PRIORITY
+	switch (cmd) {
+        case VIDIOCSFREQ:
+        case VIDIOCSTUNER:
+        case VIDIOCSCHAN:
+	case VIDIOC_S_CTRL:
+	case VIDIOC_S_STD:
+	case VIDIOC_S_INPUT:
+	case VIDIOC_S_TUNER:
+	case VIDIOC_S_FREQUENCY:
+		retval = v4l2_prio_check(&btv->prio,&fh->prio);
+		if (0 != retval)
+			return retval;
+	};
+#endif
 	switch (cmd) {
 
 	/* ***  v4l1  *** ************************************************ */
@@ -2040,7 +2099,7 @@
                 struct video_capability *cap = arg;
 
 		memset(cap,0,sizeof(*cap));
-                strcpy(cap->name,btv->video_dev.name);
+                strcpy(cap->name,btv->video_dev->name);
 		if (V4L2_BUF_TYPE_VBI_CAPTURE == fh->type) {
 			/* vbi */
 			cap->type = VID_TYPE_TUNER|VID_TYPE_TELETEXT;
@@ -2147,7 +2206,13 @@
 	case VIDIOCGFBUF:
 	{
 		struct video_buffer *fbuf = arg;
-		*fbuf = btv->fbuf;
+
+		fbuf->base          = btv->fbuf.base;
+		fbuf->width         = btv->fbuf.fmt.width;
+		fbuf->height        = btv->fbuf.fmt.height;
+		fbuf->bytesperline  = btv->fbuf.fmt.bytesperline;
+		if (fh->ovfmt)
+			fbuf->depth = fh->ovfmt->depth;
 		return 0;
 	}
 	case VIDIOCSFBUF:
@@ -2200,7 +2265,13 @@
 			    fbuf->depth != 24 && fbuf->depth != 32)
 				goto fh_unlock_and_return;
 		}
-		btv->fbuf = *fbuf;
+		btv->fbuf.base             = fbuf->base;
+		btv->fbuf.fmt.width        = fbuf->width;
+		btv->fbuf.fmt.height       = fbuf->height;
+		if (fbuf->bytesperline)
+			btv->fbuf.fmt.bytesperline = fbuf->bytesperline;
+		else
+			btv->fbuf.fmt.bytesperline = btv->fbuf.fmt.width*fbuf->depth/8;
 		up(&fh->cap.lock);
 		return 0;
 	}
@@ -2245,7 +2316,8 @@
 		unsigned int i;
 
 		down(&fh->cap.lock);
-		retval = videobuf_mmap_setup(file,&fh->cap,gbuffers,gbufsize);
+		retval = videobuf_mmap_setup(file,&fh->cap,gbuffers,gbufsize,
+					     V4L2_MEMORY_MMAP);
 		if (retval < 0)
 			goto fh_unlock_and_return;
 		memset(mbuf,0,sizeof(*mbuf));
@@ -2391,7 +2463,7 @@
 		if (0 == v4l2)
 			return -EINVAL;
                 strcpy(cap->driver,"bttv");
-                strlcpy(cap->card,btv->video_dev.name,sizeof(cap->card));
+                strlcpy(cap->card,btv->video_dev->name,sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",pci_name(btv->dev));
 		cap->version = BTTV_VERSION_CODE;
 		cap->capabilities =
@@ -2474,11 +2546,7 @@
 	{
 		struct v4l2_framebuffer *fb = arg;
 
-		memset(fb,0,sizeof(*fb));
-		fb->base       = btv->fbuf.base;
-		fb->fmt.width  = btv->fbuf.width;
-		fb->fmt.height = btv->fbuf.height;
-		fb->fmt.bytesperline = btv->fbuf.bytesperline;
+		*fb = btv->fbuf;
 		fb->capability = V4L2_FBUF_CAP_LIST_CLIPPING;
 		if (fh->ovfmt)
 			fb->fmt.pixelformat  = fh->ovfmt->fourcc;
@@ -2488,16 +2556,12 @@
 	{
 		struct v4l2_framebuffer *fb = arg;
 		const struct bttv_format *fmt;
-		unsigned long end;
 		
 		if(!capable(CAP_SYS_ADMIN) &&
 		   !capable(CAP_SYS_RAWIO))
 			return -EPERM;
 
 		/* check args */
-		end = (unsigned long)fb->base +
-			fb->fmt.height * fb->fmt.bytesperline;
-		
 		fmt = format_by_fourcc(fb->fmt.pixelformat);
 		if (NULL == fmt)
 			return -EINVAL;
@@ -2514,14 +2578,13 @@
 		}
 
 		/* ok, accept it */
-		btv->fbuf.base   = fb->base;
-		btv->fbuf.width  = fb->fmt.width;
-		btv->fbuf.height = fb->fmt.height;
-		btv->fbuf.depth  = fmt->depth;
+		btv->fbuf.base       = fb->base;
+		btv->fbuf.fmt.width  = fb->fmt.width;
+		btv->fbuf.fmt.height = fb->fmt.height;
 		if (0 != fb->fmt.bytesperline)
-			btv->fbuf.bytesperline = fb->fmt.bytesperline;
+			btv->fbuf.fmt.bytesperline = fb->fmt.bytesperline;
 		else
-			btv->fbuf.bytesperline = btv->fbuf.width*fmt->depth/8;
+			btv->fbuf.fmt.bytesperline = btv->fbuf.fmt.width*fmt->depth/8;
 		
 		retval = 0;
 		fh->ovfmt = fmt;
@@ -2642,6 +2705,23 @@
 		parm->parm.capture.timeperframe = s.frameperiod;
 		return 0;
 	}
+
+#ifdef VIDIOC_G_PRIORITY
+	case VIDIOC_G_PRIORITY:
+	{
+		enum v4l2_priority *p = arg;
+
+		*p = v4l2_prio_max(&btv->prio);
+		return 0;
+	}
+	case VIDIOC_S_PRIORITY:
+	{
+		enum v4l2_priority *prio = arg;
+
+		return v4l2_prio_change(&btv->prio, &fh->prio, *prio);
+	}
+#endif
+
 	
 	case VIDIOC_ENUMSTD:
 	case VIDIOC_G_STD:
@@ -2768,12 +2848,12 @@
 	dprintk(KERN_DEBUG "bttv: open minor=%d\n",minor);
 
 	for (i = 0; i < bttv_num; i++) {
-		if (bttvs[i].video_dev.minor == minor) {
+		if (bttvs[i].video_dev->minor == minor) {
 			btv = &bttvs[i];
 			type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 			break;
 		}
-		if (bttvs[i].vbi_dev.minor == minor) {
+		if (bttvs[i].vbi_dev->minor == minor) {
 			btv = &bttvs[i];
 			type = V4L2_BUF_TYPE_VBI_CAPTURE;
 			break;
@@ -2793,6 +2873,10 @@
 	*fh = btv->init;
 	fh->type = type;
 	fh->ov.setup_ok = 0;
+#ifdef VIDIOC_G_PRIORITY
+	v4l2_prio_open(&btv->prio,&fh->prio);
+#endif
+
 	videobuf_queue_init(&fh->cap, &bttv_video_qops,
 			    btv->dev, &btv->s_lock,
 			    V4L2_BUF_TYPE_VIDEO_CAPTURE,
@@ -2840,6 +2924,9 @@
 		free_btres(btv,fh,RESOURCE_VBI);
 	}
 
+#ifdef VIDIOC_G_PRIORITY
+	v4l2_prio_close(&btv->prio,&fh->prio);
+#endif
 	file->private_data = NULL;
 	kfree(fh);
 
@@ -2897,13 +2984,12 @@
 {
 	int minor = iminor(inode);
 	struct bttv *btv = NULL;
-	u32 v = 400*16;
 	unsigned int i;
 
 	dprintk("bttv: open minor=%d\n",minor);
 
 	for (i = 0; i < bttv_num; i++) {
-		if (bttvs[i].radio_dev.minor == minor) {
+		if (bttvs[i].radio_dev->minor == minor) {
 			btv = &bttvs[i];
 			break;
 		}
@@ -2921,7 +3007,6 @@
 	file->private_data = btv;
 
 	i2c_vidiocschan(btv);
-	bttv_call_i2c_clients(btv,VIDIOCSFREQ,&v);
         bttv_call_i2c_clients(btv,AUDC_SET_RADIO,&btv->tuner_type);
 	audio_mux(btv,AUDIO_RADIO);
 
@@ -2948,7 +3033,7 @@
                 struct video_capability *cap = arg;
 
 		memset(cap,0,sizeof(*cap));
-                strcpy(cap->name,btv->radio_dev.name);
+                strcpy(cap->name,btv->radio_dev->name);
                 cap->type = VID_TYPE_TUNER;
 		cap->channels = 1;
 		cap->audios = 1;
@@ -3131,7 +3216,7 @@
 	}
 	if (wakeup->top == wakeup->bottom) {
 		if (NULL != wakeup->top && curr->top != wakeup->top) {
-			if (irq_debug)
+			if (irq_debug > 1)
 				printk("bttv%d: wakeup: both=%p\n",btv->nr,wakeup->top);
 			wakeup->top->vb.ts = ts;
 			wakeup->top->vb.field_count = btv->field_count;
@@ -3140,7 +3225,7 @@
 		}
 	} else {
 		if (NULL != wakeup->top && curr->top != wakeup->top) {
-			if (irq_debug)
+			if (irq_debug > 1)
 				printk("bttv%d: wakeup: top=%p\n",btv->nr,wakeup->top);
 			wakeup->top->vb.ts = ts;
 			wakeup->top->vb.field_count = btv->field_count;
@@ -3148,7 +3233,7 @@
 			wake_up(&wakeup->top->vb.done);
 		}
 		if (NULL != wakeup->bottom && curr->bottom != wakeup->bottom) {
-			if (irq_debug)
+			if (irq_debug > 1)
 				printk("bttv%d: wakeup: bottom=%p\n",btv->nr,wakeup->bottom);
 			wakeup->bottom->vb.ts = ts;
 			wakeup->bottom->vb.field_count = btv->field_count;
@@ -3247,6 +3332,12 @@
 	bttv_buffer_set_activate(btv, &new);
 	bttv_set_dma(btv, 0, new.irqflags);
 
+	/* switch input */
+	if (UNSET != btv->new_input) {
+		video_mux(btv,btv->new_input);
+		btv->new_input = UNSET;
+	}
+
 	/* wake up finished buffers */
 	bttv_irq_wakeup_set(btv, &old, &new, STATE_DONE);
 	spin_unlock(&btv->s_lock);
@@ -3274,7 +3365,7 @@
 		/* get device status bits */
 		dstat=btread(BT848_DSTATUS);
 
-		if (0 /*irq_debug*/) {
+		if (irq_debug) {
 			printk(KERN_DEBUG "bttv%d: irq loop=%d fc=%d "
 			       "riscs=%x, riscc=%08x, ",
 			       btv->nr, count, btv->field_count,
@@ -3295,8 +3386,13 @@
 		if (astat&BT848_INT_VSYNC) 
                         btv->field_count++;
 
-		if (astat & BT848_INT_GPINT)
+		if (astat & BT848_INT_GPINT) {
+#ifdef CONFIG_VIDEO_IR
+			if (btv->remote)
+				bttv_input_irq(btv);
+#endif
 			wake_up(&btv->gpioq);
+		}
 
                 if ((astat & BT848_INT_RISCI)  &&  (stat & (2<<28)))
 			bttv_irq_wakeup_top(btv);
@@ -3325,10 +3421,12 @@
 		}
 
 		count++;
-		if (count > 20) {
+		if (count > 4) {
 			btwrite(0, BT848_INT_MASK);
 			printk(KERN_ERR 
-			       "bttv%d: IRQ lockup, cleared int mask\n", btv->nr);
+			       "bttv%d: IRQ lockup, cleared int mask [", btv->nr);
+			bttv_print_irqbits(stat,astat);
+			printk("]\n");
 		}
 	}
 	return IRQ_RETVAL(handled);
@@ -3338,31 +3436,89 @@
 /* ----------------------------------------------------------------------- */
 /* initialitation                                                          */
 
+static struct video_device *vdev_init(struct bttv *btv,
+				      struct video_device *template,
+				      char *type)
+{
+	struct video_device *vfd;
+
+	vfd = video_device_alloc();
+	if (NULL == vfd)
+		return NULL;
+	*vfd = *template;
+	vfd->minor   = -1;
+	vfd->dev     = &btv->dev->dev;
+	vfd->release = video_device_release;
+	snprintf(vfd->name, sizeof(vfd->name), "BT%d%s %s (%s)",
+		 btv->id, (btv->id==848 && btv->revision==0x12) ? "A" : "",
+		 type, bttv_tvcards[btv->type].name);
+	return vfd;
+}
+
+static void bttv_unregister_video(struct bttv *btv)
+{
+	if (btv->video_dev) {
+		if (-1 != btv->video_dev->minor)
+			video_unregister_device(btv->video_dev);
+		else
+			video_device_release(btv->video_dev);
+		btv->video_dev = NULL;
+	}
+	if (btv->vbi_dev) {
+		if (-1 != btv->vbi_dev->minor)
+			video_unregister_device(btv->vbi_dev);
+		else
+			video_device_release(btv->vbi_dev);
+		btv->vbi_dev = NULL;
+	}
+	if (btv->radio_dev) {
+		if (-1 != btv->radio_dev->minor)
+			video_unregister_device(btv->radio_dev);
+		else
+			video_device_release(btv->radio_dev);
+		btv->radio_dev = NULL;
+	}
+}
+
 /* register video4linux devices */
 static int __devinit bttv_register_video(struct bttv *btv)
 {
-        if(video_register_device(&btv->video_dev,VFL_TYPE_GRABBER,video_nr)<0)
-                return -1;
+	/* video */
+	btv->video_dev = vdev_init(btv, &bttv_video_template, "video");
+        if (NULL == btv->video_dev)
+		goto err;
+	if (video_register_device(btv->video_dev,VFL_TYPE_GRABBER,video_nr)<0)
+		goto err;
 	printk(KERN_INFO "bttv%d: registered device video%d\n",
-	       btv->nr,btv->video_dev.minor & 0x1f);
+	       btv->nr,btv->video_dev->minor & 0x1f);
+	video_device_create_file(btv->video_dev, &class_device_attr_card);
 
-        if(video_register_device(&btv->vbi_dev,VFL_TYPE_VBI,vbi_nr)<0) {
-                video_unregister_device(&btv->video_dev);
-                return -1;
-        }
+	/* vbi */
+	btv->vbi_dev = vdev_init(btv, &bttv_vbi_template, "vbi");
+        if (NULL == btv->vbi_dev)
+		goto err;
+        if (video_register_device(btv->vbi_dev,VFL_TYPE_VBI,vbi_nr)<0)
+		goto err;
 	printk(KERN_INFO "bttv%d: registered device vbi%d\n",
-	       btv->nr,btv->vbi_dev.minor & 0x1f);
+	       btv->nr,btv->vbi_dev->minor & 0x1f);
 
         if (!btv->has_radio)
 		return 0;
-	if (video_register_device(&btv->radio_dev, VFL_TYPE_RADIO,radio_nr)<0) {
-		video_unregister_device(&btv->vbi_dev);
-		video_unregister_device(&btv->video_dev);
-		return -1;
-        }
+	/* radio */
+	btv->radio_dev = vdev_init(btv, &radio_template, "radio");
+        if (NULL == btv->radio_dev)
+		goto err;
+	if (video_register_device(btv->radio_dev, VFL_TYPE_RADIO,radio_nr)<0)
+		goto err;
 	printk(KERN_INFO "bttv%d: registered device radio%d\n",
-	       btv->nr,btv->radio_dev.minor & 0x1f);
-        return 0;
+	       btv->nr,btv->radio_dev->minor & 0x1f);
+
+	/* all done */
+	return 0;
+
+ err:
+	bttv_unregister_video(btv);
+	return -1;
 }
 
 
@@ -3401,6 +3557,9 @@
         init_waitqueue_head(&btv->gpioq);
         INIT_LIST_HEAD(&btv->capture);
         INIT_LIST_HEAD(&btv->vcapture);
+#ifdef VIDIOC_G_PRIORITY
+	v4l2_prio_init(&btv->prio);
+#endif
 
 	init_timer(&btv->timeout);
 	btv->timeout.function = bttv_irq_timeout;
@@ -3409,19 +3568,10 @@
         btv->i2c_rc = -1;
         btv->tuner_type  = UNSET;
         btv->pinnacle_id = UNSET;
-
-	memcpy(&btv->video_dev, &bttv_video_template, sizeof(bttv_video_template));
-	memcpy(&btv->radio_dev, &radio_template,      sizeof(radio_template));
-	memcpy(&btv->vbi_dev,   &bttv_vbi_template,   sizeof(bttv_vbi_template));
-        btv->video_dev.minor = -1;
-	btv->video_dev.priv = btv;
-        btv->radio_dev.minor = -1;
-	btv->radio_dev.priv = btv;
-        btv->vbi_dev.minor = -1;
-	btv->vbi_dev.priv = btv;
+	btv->new_input   = UNSET;
 	btv->has_radio=radio[btv->nr];
 	
-	/* pci stuff (init, get irq/mmip, ... */
+	/* pci stuff (init, get irq/mmio, ... */
 	btv->dev = dev;
         btv->id  = dev->device;
 	if (pci_enable_device(dev)) {
@@ -3437,13 +3587,15 @@
 	if (!request_mem_region(pci_resource_start(dev,0),
 				pci_resource_len(dev,0),
 				btv->name)) {
+                printk(KERN_WARNING "bttv%d: can't request iomem (0x%lx).\n",
+		       btv->nr, pci_resource_start(dev,0));
 		return -EBUSY;
 	}
         pci_set_master(dev);
 	pci_set_command(dev);
 	pci_set_drvdata(dev,btv);
 	if (!pci_dma_supported(dev,0xffffffff)) {
-		printk("bttv: Oops: no 32bit PCI DMA ???\n");
+		printk("bttv%d: Oops: no 32bit PCI DMA ???\n", btv->nr);
 		result = -EIO;
 		goto fail1;
 	}
@@ -3454,13 +3606,14 @@
                bttv_num,btv->id, btv->revision, pci_name(dev));
         printk("irq: %d, latency: %d, mmio: 0x%lx\n",
 	       btv->dev->irq, lat, pci_resource_start(dev,0));
+	schedule();
 	
-#ifdef __sparc__
-	/* why no ioremap for sparc? */
-	btv->bt848_mmio=(unsigned char *)pci_resource_start(dev,0);
-#else
 	btv->bt848_mmio=ioremap(pci_resource_start(dev,0), 0x1000);
-#endif
+	if (NULL == ioremap(pci_resource_start(dev,0), 0x1000)) {
+		printk("bttv%d: ioremap() failed\n", btv->nr);
+		result = -EIO;
+		goto fail1;
+	}
 
         /* identify card */
 	bttv_idcard(btv);
@@ -3486,6 +3639,7 @@
 	btv->opt_automute   = automute;
 	btv->opt_chroma_agc = chroma_agc;
 	btv->opt_adc_crush  = adc_crush;
+	btv->opt_vcr_hack   = vcr_hack;
 	
 	/* fill struct bttv with some useful defaults */
 	btv->init.btv         = btv;
@@ -3502,7 +3656,8 @@
                 bttv_gpio_tracking(btv,"pre-init");
 
 	bttv_risc_init_main(btv);
-	init_bt848(btv);
+	if (!bttv_tvcards[btv->type].no_video)
+		init_bt848(btv);
 
 	/* gpio */
         btwrite(0x00, BT848_GPIO_REG_INP);
@@ -3510,16 +3665,6 @@
         if (bttv_gpio)
                 bttv_gpio_tracking(btv,"init");
 
-        /* interrupt */
-        btwrite(0xfffffUL, BT848_INT_STAT);
-        btwrite((btv->triton1) |
-                (gpint ? BT848_INT_GPINT : 0) |
-                BT848_INT_SCERR|
-                (fdsr ? BT848_INT_FDSR : 0) |
-                BT848_INT_RISCI|BT848_INT_OCERR|BT848_INT_VPRES|
-                BT848_INT_FMTCHG|BT848_INT_HLOCK,
-                BT848_INT_MASK);
-	
         /* needs to be done before i2c is registered */
         bttv_init_card1(btv);
 
@@ -3529,15 +3674,20 @@
         /* some card-specific stuff (needs working i2c) */
         bttv_init_card2(btv);
 
-        /* register video4linux */
-        bttv_register_video(btv);
+        /* register video4linux + input */
+	if (!bttv_tvcards[btv->type].no_video) {
+		bttv_register_video(btv);
+#ifdef CONFIG_VIDEO_IR
+		bttv_input_init(btv);
+#endif
 
-	bt848_bright(btv,32768);
-	bt848_contrast(btv,32768);
-	bt848_hue(btv,32768);
-	bt848_sat(btv,32768);
-	audio_mux(btv,AUDIO_MUTE);
-	set_input(btv,0);
+		bt848_bright(btv,32768);
+		bt848_contrast(btv,32768);
+		bt848_hue(btv,32768);
+		bt848_sat(btv,32768);
+		audio_mux(btv,AUDIO_MUTE);
+		set_input(btv,0);
+	}
 
 	/* everything is fine */
 	bttv_num++;
@@ -3547,6 +3697,8 @@
         free_irq(btv->dev->irq,btv);
 	
  fail1:
+	if (btv->bt848_mmio)
+		iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->dev,0),
 			   pci_resource_len(btv->dev,0));
 	pci_set_drvdata(dev,NULL);
@@ -3572,23 +3724,21 @@
 	btv->shutdown=1;
 	wake_up(&btv->gpioq);
 
-        /* unregister i2c_bus */
-	if (0 == btv->i2c_rc)
-		i2c_bit_del_bus(&btv->i2c_adap);
+        /* unregister i2c_bus + input */
+	fini_bttv_i2c(btv);
+#ifdef CONFIG_VIDEO_IR
+	bttv_input_fini(btv);
+#endif
 
 	/* unregister video4linux */
-        if (btv->video_dev.minor!=-1)
-                video_unregister_device(&btv->video_dev);
-        if (btv->radio_dev.minor!=-1)
-                video_unregister_device(&btv->radio_dev);
-	if (btv->vbi_dev.minor!=-1)
-                video_unregister_device(&btv->vbi_dev);
+	bttv_unregister_video(btv);
 
 	/* free allocated memory */
 	btcx_riscmem_free(btv->dev,&btv->main);
 
 	/* free ressources */
         free_irq(btv->dev->irq,btv);
+	iounmap(btv->bt848_mmio);
         release_mem_region(pci_resource_start(btv->dev,0),
                            pci_resource_len(btv->dev,0));
 
diff -u linux-2.6.0-test6/drivers/media/video/bttv-if.c linux/drivers/media/video/bttv-if.c
--- linux-2.6.0-test6/drivers/media/video/bttv-if.c	2003-10-06 17:44:44.000000000 +0200
+++ linux/drivers/media/video/bttv-if.c	2003-10-06 17:48:02.000000000 +0200
@@ -27,15 +27,23 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 
 #include "bttvp.h"
 
-static struct i2c_algo_bit_data bttv_i2c_algo_template;
-static struct i2c_adapter bttv_i2c_adap_template;
+static struct i2c_algo_bit_data bttv_i2c_algo_bit_template;
+static struct i2c_adapter bttv_i2c_adap_sw_template;
+static struct i2c_adapter bttv_i2c_adap_hw_template;
 static struct i2c_client bttv_i2c_client_template;
 
+#ifndef I2C_PEC
+static void bttv_inc_use(struct i2c_adapter *adap);
+static void bttv_dec_use(struct i2c_adapter *adap);
+#endif
+static int attach_inform(struct i2c_client *client);
+
 EXPORT_SYMBOL(bttv_get_cardinfo);
 EXPORT_SYMBOL(bttv_get_pcidev);
 EXPORT_SYMBOL(bttv_get_id);
@@ -45,6 +53,11 @@
 EXPORT_SYMBOL(bttv_get_gpio_queue);
 EXPORT_SYMBOL(bttv_i2c_call);
 
+static int i2c_debug = 0;
+static int i2c_hw = 0;
+MODULE_PARM(i2c_debug,"i");
+MODULE_PARM(i2c_hw,"i");
+
 /* ----------------------------------------------------------------------- */
 /* Exported functions - for other modules which want to access the         */
 /*                      gpio ports (IR for example)                        */
@@ -76,6 +89,7 @@
 	return bttvs[card].type;
 }
 
+
 int bttv_gpio_enable(unsigned int card, unsigned long mask, unsigned long data)
 {
 	struct bttv *btv;
@@ -146,7 +160,7 @@
 
 
 /* ----------------------------------------------------------------------- */
-/* I2C functions                                                           */
+/* I2C functions - bitbanging adapter (software i2c)                       */
 
 void bttv_bit_setscl(void *data, int state)
 {
@@ -190,6 +204,222 @@
 	return state;
 }
 
+static struct i2c_algo_bit_data bttv_i2c_algo_bit_template = {
+	.setsda  = bttv_bit_setsda,
+	.setscl  = bttv_bit_setscl,
+	.getsda  = bttv_bit_getsda,
+	.getscl  = bttv_bit_getscl,
+	.udelay  = 16,
+	.mdelay  = 10,
+	.timeout = 200,
+};
+
+static struct i2c_adapter bttv_i2c_adap_sw_template = {
+#ifdef I2C_PEC
+	.owner             = THIS_MODULE,
+#else
+	.inc_use           = bttv_inc_use,
+	.dec_use           = bttv_dec_use,
+#endif
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
+	.class             = I2C_ADAP_CLASS_TV_ANALOG,
+#endif
+	I2C_DEVNAME("bt848"),
+	.id                = I2C_HW_B_BT848,
+	.client_register   = attach_inform,
+};
+
+/* ----------------------------------------------------------------------- */
+/* I2C functions - hardware i2c                                            */
+
+static int algo_control(struct i2c_adapter *adapter, 
+			unsigned int cmd, unsigned long arg)
+{
+	return 0;
+}
+
+static u32 functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL;
+}
+
+static int
+bttv_i2c_wait_done(struct bttv *btv)
+{
+	u32 stat;
+	int timeout;
+
+	timeout = jiffies + HZ/100 + 1; /* 10ms */
+	for (;;) {
+		stat = btread(BT848_INT_STAT);
+		if (stat & BT848_INT_I2CDONE)
+			break;
+		if (time_after(jiffies,timeout))
+			return -EIO;
+		udelay(10);
+	}
+	btwrite(BT848_INT_I2CDONE|BT848_INT_RACK, BT848_INT_STAT);
+	return ((stat & BT848_INT_RACK) ? 1 : 0);
+}
+
+#define I2C_HW (BT878_I2C_MODE  | BT848_I2C_SYNC |\
+		BT848_I2C_SCL | BT848_I2C_SDA)
+
+static int
+bttv_i2c_sendbytes(struct bttv *btv, const struct i2c_msg *msg, int last)
+{
+	u32 xmit;
+	int retval,cnt;
+
+	/* start, address + first byte */
+	xmit = (msg->addr << 25) | (msg->buf[0] << 16) | I2C_HW;
+	if (msg->len > 1 || !last)
+		xmit |= BT878_I2C_NOSTOP;
+	btwrite(xmit, BT848_I2C);
+	retval = bttv_i2c_wait_done(btv);
+	if (retval < 0)
+		goto err;
+	if (retval == 0)
+		goto eio;
+	if (i2c_debug) {
+		printk(" <W %02x %02x", msg->addr << 1, msg->buf[0]);
+		if (!(xmit & BT878_I2C_NOSTOP))
+			printk(" >\n");
+	}
+
+	for (cnt = 1; cnt < msg->len; cnt++ ) {
+		/* following bytes */
+		xmit = (msg->buf[cnt] << 24) | I2C_HW | BT878_I2C_NOSTART;
+		if (cnt < msg->len-1 || !last)
+			xmit |= BT878_I2C_NOSTOP;
+		btwrite(xmit, BT848_I2C);
+		retval = bttv_i2c_wait_done(btv);
+		if (retval < 0)
+			goto err;
+		if (retval == 0)
+			goto eio;
+		if (i2c_debug) {
+			printk(" %02x", msg->buf[cnt]);
+			if (!(xmit & BT878_I2C_NOSTOP))
+				printk(" >\n");
+		}
+	}
+	return msg->len;
+
+ eio:
+	retval = -EIO;
+ err:
+	if (i2c_debug)
+		printk(" ERR: %d\n",retval);
+	return retval;
+}
+
+static int
+bttv_i2c_readbytes(struct bttv *btv, const struct i2c_msg *msg, int last)
+{
+	u32 xmit;
+	u32 cnt;
+	int retval;
+
+	for(cnt = 0; cnt < msg->len; cnt++) {
+		xmit = (msg->addr << 25) | (1 << 24) | I2C_HW;
+		if (cnt < msg->len-1)
+			xmit |= BT848_I2C_W3B;
+		if (cnt < msg->len-1 || !last)
+			xmit |= BT878_I2C_NOSTOP;
+		if (cnt)
+			xmit |= BT878_I2C_NOSTART;
+		btwrite(xmit, BT848_I2C);
+		retval = bttv_i2c_wait_done(btv);
+		if (retval < 0)
+			goto err;
+		if (retval == 0)
+			goto eio;
+		msg->buf[cnt] = ((u32)btread(BT848_I2C) >> 8) & 0xff;
+		if (i2c_debug) {
+			if (!(xmit & BT878_I2C_NOSTART))
+				printk(" <R %02x", (msg->addr << 1) +1);
+			printk(" =%02x", msg->buf[cnt]);
+			if (!(xmit & BT878_I2C_NOSTOP))
+				printk(" >\n");
+		}
+	}
+	return msg->len;
+
+ eio:
+	retval = -EIO;
+ err:
+	if (i2c_debug)
+		printk(" ERR: %d\n",retval);
+       	return retval;
+}
+
+int bttv_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num)
+{
+	struct bttv *btv = i2c_get_adapdata(i2c_adap);
+	int retval = 0;
+	int i;
+
+	if (i2c_debug)
+		printk("bt-i2c:");
+	btwrite(BT848_INT_I2CDONE|BT848_INT_RACK, BT848_INT_STAT);
+	for (i = 0 ; i < num; i++) {
+		if (msgs[i].flags & I2C_M_RD) {
+			/* read */
+			retval = bttv_i2c_readbytes(btv, &msgs[i], i+1 == num);
+			if (retval < 0)
+				goto err;
+		} else {
+			/* write */
+			retval = bttv_i2c_sendbytes(btv, &msgs[i], i+1 == num);
+			if (retval < 0)
+				goto err;
+		}
+	}
+	return num;
+
+ err:
+	return retval;
+}
+
+static struct i2c_algorithm bttv_algo = {
+	.name          = "bt878",
+	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
+	.master_xfer   = bttv_i2c_xfer,
+	.algo_control  = algo_control,
+	.functionality = functionality,
+};
+
+static struct i2c_adapter bttv_i2c_adap_hw_template = {
+#ifdef I2C_PEC
+	.owner         = THIS_MODULE,
+#else
+	.inc_use       = bttv_inc_use,
+	.dec_use       = bttv_dec_use,
+#endif
+#ifdef I2C_ADAP_CLASS_TV_ANALOG
+	.class         = I2C_ADAP_CLASS_TV_ANALOG,
+#endif
+	I2C_DEVNAME("bt878"),
+	.id            = I2C_ALGO_BIT | I2C_HW_B_BT848 /* FIXME */,
+	.algo          = &bttv_algo,
+	.client_register = attach_inform,
+};
+
+/* ----------------------------------------------------------------------- */
+/* I2C functions - common stuff                                            */
+
+#ifndef I2C_PEC
+static void bttv_inc_use(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void bttv_dec_use(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+#endif
 
 static int attach_inform(struct i2c_client *client)
 {
@@ -221,24 +451,6 @@
 	bttv_call_i2c_clients(&bttvs[card], cmd, arg);
 }
 
-static struct i2c_algo_bit_data bttv_i2c_algo_template = {
-	.setsda  = bttv_bit_setsda,
-	.setscl  = bttv_bit_setscl,
-	.getsda  = bttv_bit_getsda,
-	.getscl  = bttv_bit_getscl,
-	.udelay  = 16,
-	.mdelay  = 10,
-	.timeout = 200,
-};
-
-static struct i2c_adapter bttv_i2c_adap_template = {
-	.owner             = THIS_MODULE,
-	.class             = I2C_ADAP_CLASS_TV_ANALOG,
-	I2C_DEVNAME("bt848"),
-	.id                = I2C_HW_B_BT848,
-	.client_register   = attach_inform,
-};
-
 static struct i2c_client bttv_i2c_client_template = {
 	I2C_DEVNAME("bttv internal"),
         .id       = -1,
@@ -308,28 +520,56 @@
 /* init + register i2c algo-bit adapter */
 int __devinit init_bttv_i2c(struct bttv *btv)
 {
-	memcpy(&btv->i2c_adap, &bttv_i2c_adap_template,
-	       sizeof(struct i2c_adapter));
-	memcpy(&btv->i2c_algo, &bttv_i2c_algo_template,
-	       sizeof(struct i2c_algo_bit_data));
+	int use_hw = (btv->id == 878) && i2c_hw;
+
 	memcpy(&btv->i2c_client, &bttv_i2c_client_template,
-	       sizeof(struct i2c_client));
+	       sizeof(bttv_i2c_client_template));
+
+	if (use_hw) {
+		/* bt878 */
+		memcpy(&btv->i2c_adap, &bttv_i2c_adap_hw_template,
+		       sizeof(bttv_i2c_adap_hw_template));
+	} else {
+		/* bt848 */
+		memcpy(&btv->i2c_adap, &bttv_i2c_adap_sw_template,
+		       sizeof(bttv_i2c_adap_sw_template));
+		memcpy(&btv->i2c_algo, &bttv_i2c_algo_bit_template,
+		       sizeof(bttv_i2c_algo_bit_template));
+		btv->i2c_algo.data = btv;
+		btv->i2c_adap.algo_data = &btv->i2c_algo;
+	}
 
-	sprintf(btv->i2c_adap.name, "bt848 #%d", btv->nr);
 	btv->i2c_adap.dev.parent = &btv->dev->dev;
+	snprintf(btv->i2c_adap.name, sizeof(btv->i2c_adap.name),
+		 "bt%d #%d [%s]", btv->id, btv->nr, use_hw ? "hw" : "sw");
 
-        btv->i2c_algo.data = btv;
         i2c_set_adapdata(&btv->i2c_adap, btv);
-        btv->i2c_adap.algo_data = &btv->i2c_algo;
         btv->i2c_client.adapter = &btv->i2c_adap;
 
-	bttv_bit_setscl(btv,1);
-	bttv_bit_setsda(btv,1);
-
-	btv->i2c_rc = i2c_bit_add_bus(&btv->i2c_adap);
+	if (use_hw) {
+		btv->i2c_rc = i2c_add_adapter(&btv->i2c_adap);
+	} else {
+		bttv_bit_setscl(btv,1);
+		bttv_bit_setsda(btv,1);
+		btv->i2c_rc = i2c_bit_add_bus(&btv->i2c_adap);
+	}
 	return btv->i2c_rc;
 }
 
+int __devexit fini_bttv_i2c(struct bttv *btv)
+{
+	int use_hw = (btv->id == 878) && i2c_hw;
+
+	if (0 != btv->i2c_rc)
+		return 0;
+
+	if (use_hw) {
+		return i2c_del_adapter(&btv->i2c_adap);
+	} else {
+		return i2c_bit_del_bus(&btv->i2c_adap);
+	}
+}
+
 /*
  * Local variables:
  * c-basic-offset: 8
diff -u linux-2.6.0-test6/drivers/media/video/bttv-risc.c linux/drivers/media/video/bttv-risc.c
--- linux-2.6.0-test6/drivers/media/video/bttv-risc.c	2003-10-06 17:45:22.000000000 +0200
+++ linux/drivers/media/video/bttv-risc.c	2003-10-06 17:48:02.000000000 +0200
@@ -33,6 +33,8 @@
 
 #include "bttvp.h"
 
+#define VCR_HACK_LINES 4
+
 /* ---------------------------------------------------------- */
 /* risc code generators                                       */
 
@@ -62,6 +64,9 @@
 	/* scan lines */
 	sg = sglist;
 	for (line = 0; line < lines; line++) {
+		if ((btv->opt_vcr_hack) &&
+		    (line >= (lines - VCR_HACK_LINES)))
+			continue;
 		while (offset >= sg_dma_len(sg)) {
 			offset -= sg_dma_len(sg);
 			sg++;
@@ -136,6 +141,9 @@
 	usg = sglist;
 	vsg = sglist;
 	for (line = 0; line < ylines; line++) {
+		if ((btv->opt_vcr_hack) &&
+		    (line >= (ylines - VCR_HACK_LINES)))
+			continue;
 		switch (vshift) {
 		case 0:  chroma = 1;           break;
 		case 1:  chroma = !(line & 1); break;
@@ -219,8 +227,10 @@
 	instructions  = (ov->nclips + 1) *
 		((skip_even || skip_odd) ? ov->w.height>>1 :  ov->w.height);
 	instructions += 2;
-	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0)
+	if ((rc = btcx_riscmem_alloc(btv->dev,risc,instructions*8)) < 0) {
+		kfree(skips);
 		return rc;
+	}
 
 	/* sync instruction */
 	rp = risc->cpu;
@@ -228,12 +238,18 @@
 	*(rp++) = cpu_to_le32(0);
 
 	addr  = (unsigned long)btv->fbuf.base;
-	addr += btv->fbuf.bytesperline * ov->w.top;
-	addr += ((btv->fbuf.depth+7) >> 3) * ov->w.left;
+	addr += btv->fbuf.fmt.bytesperline * ov->w.top;
+	addr += (fmt->depth >> 3)          * ov->w.left;
 
 	/* scan lines */
 	for (maxy = -1, line = 0; line < ov->w.height;
-	     line++, addr += btv->fbuf.bytesperline) {
+	     line++, addr += btv->fbuf.fmt.bytesperline) {
+		if ((btv->opt_vcr_hack) &&
+		     (line >= (ov->w.height - VCR_HACK_LINES)))
+			continue;
+ 		if ((line%2) == 0  &&  skip_even)
+ 			continue;
+ 		if ((line%2) == 1  &&  skip_odd)
 		if ((line%2) == 0  &&  skip_even)
 			continue;
 		if ((line%2) == 1  &&  skip_odd)
diff -u linux-2.6.0-test6/drivers/media/video/bttv-vbi.c linux/drivers/media/video/bttv-vbi.c
--- linux-2.6.0-test6/drivers/media/video/bttv-vbi.c	2003-10-06 17:45:46.000000000 +0200
+++ linux/drivers/media/video/bttv-vbi.c	2003-10-06 17:48:02.000000000 +0200
@@ -87,7 +87,7 @@
 		return -EINVAL;
 
 	if (STATE_NEEDS_INIT == buf->vb.state) {
-		if (0 != (rc = videobuf_iolock(btv->dev,&buf->vb)))
+		if (0 != (rc = videobuf_iolock(btv->dev, &buf->vb, NULL)))
 			goto fail;
 		if (0 != (rc = vbi_buffer_risc(btv,buf,fh->lines)))
 			goto fail;
diff -u linux-2.6.0-test6/drivers/media/video/bttv.h linux/drivers/media/video/bttv.h
--- linux-2.6.0-test6/drivers/media/video/bttv.h	2003-10-06 17:44:44.000000000 +0200
+++ linux/drivers/media/video/bttv.h	2003-10-06 17:48:02.000000000 +0200
@@ -115,6 +115,8 @@
 #define BTTV_XGUARD         0x67
 #define BTTV_NEBULA_DIGITV  0x68
 #define BTTV_PV143          0x69
+#define BTTV_IVC100         0x6e
+#define BTTV_IVC120         0x6f
 
 /* i2c address list */
 #define I2C_TSA5522        0xc2
@@ -170,6 +172,9 @@
 	unsigned int needs_tvaudio:1;
 	unsigned int msp34xx_alt:1;
 
+	/* flag: video pci function is unused */
+	unsigned int no_video;
+
 	/* other settings */
 	unsigned int pll;
 #define PLL_NONE 0
diff -u linux-2.6.0-test6/drivers/media/video/bttvp.h linux/drivers/media/video/bttvp.h
--- linux-2.6.0-test6/drivers/media/video/bttvp.h	2003-10-06 17:45:13.000000000 +0200
+++ linux/drivers/media/video/bttvp.h	2003-10-06 17:48:02.000000000 +0200
@@ -24,9 +24,8 @@
 #ifndef _BTTVP_H_
 #define _BTTVP_H_
 
-
 #include <linux/version.h>
-#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,11)
+#define BTTV_VERSION_CODE KERNEL_VERSION(0,9,12)
 
 #include <linux/types.h>
 #include <linux/wait.h>
@@ -34,9 +33,11 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/videodev.h>
 #include <linux/pci.h>
+#include <linux/input.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 
+#include <linux/device.h>
 #include <media/video-buf.h>
 #include <media/audiochip.h>
 #include <media/tuner.h>
@@ -44,6 +45,9 @@
 #include "bt848.h"
 #include "bttv.h"
 #include "btcx-risc.h"
+#ifdef CONFIG_VIDEO_IR
+#include "ir-common.h"
+#endif
 
 #ifdef __KERNEL__
 
@@ -142,6 +146,9 @@
 struct bttv_fh {
 	struct bttv              *btv;
 	int resources;
+#ifdef VIDIOC_G_PRIORITY 
+	enum v4l2_priority       prio;
+#endif
 	enum v4l2_buf_type       type;
 
 	/* video capture */
@@ -211,6 +218,12 @@
 
 extern struct videobuf_queue_ops bttv_vbi_qops;
 
+/* ---------------------------------------------------------- */
+/* bttv-input.c                                               */
+
+int bttv_input_init(struct bttv *btv);
+void bttv_input_fini(struct bttv *btv);
+void bttv_input_irq(struct bttv *btv);
 
 /* ---------------------------------------------------------- */
 /* bttv-driver.c                                              */
@@ -221,6 +234,7 @@
 extern unsigned int bttv_gpio;
 extern void bttv_gpio_tracking(struct bttv *btv, char *comment);
 extern int init_bttv_i2c(struct bttv *btv);
+extern int fini_bttv_i2c(struct bttv *btv);
 extern int pvr_boot(struct bttv *btv);
 
 extern int bttv_common_ioctls(struct bttv *btv, unsigned int cmd, void *arg);
@@ -249,6 +263,18 @@
 	unsigned int pll_current;  /* Currently programmed ofreq */
 };
 
+#ifdef CONFIG_VIDEO_IR
+/* for gpio-connected remote control */
+struct bttv_input {
+	struct input_dev      dev;
+	struct ir_input_state ir;
+	char                  name[32];
+	char                  phys[32];
+	u32                   mask_keycode;
+	u32                   mask_keydown;
+};
+#endif
+
 struct bttv {
 	/* pci device config */
 	struct pci_dev *dev;
@@ -263,6 +289,7 @@
 	unsigned int type;     /* card type (pointer into tvcards[])  */
         unsigned int tuner_type;  /* tuner chip type */
         unsigned int pinnacle_id;
+	unsigned int svhs;
 	struct bttv_pll_info pll;
 	int triton1;
 
@@ -278,22 +305,31 @@
 	int                        i2c_state, i2c_rc;
 
 	/* video4linux (1) */
-	struct video_device video_dev;
-	struct video_device radio_dev;
-	struct video_device vbi_dev;
+	struct video_device *video_dev;
+	struct video_device *radio_dev;
+	struct video_device *vbi_dev;
+
+	/* infrared remote */
+	int has_remote;
+#ifdef CONFIG_VIDEO_IR
+	struct bttv_input *remote;
+#endif
 
 	/* locking */
 	spinlock_t s_lock;
         struct semaphore lock;
 	int resources;
         struct semaphore reslock;
-
+#ifdef VIDIOC_G_PRIORITY 
+	struct v4l2_prio_state prio;
+#endif
+	
 	/* video state */
 	unsigned int input;
 	unsigned int audio;
 	unsigned long freq;
 	int tvnorm,hue,contrast,bright,saturation;
-	struct video_buffer fbuf;
+	struct v4l2_framebuffer fbuf;
 	unsigned int field_count;
 
 	/* various options */
@@ -302,6 +338,7 @@
 	int opt_automute;
 	int opt_chroma_agc;
 	int opt_adc_crush;
+	int opt_vcr_hack;
 
 	/* radio data/state */
 	int has_radio;
@@ -329,6 +366,7 @@
 	struct list_head        capture;    /* video capture queue */
 	struct list_head        vcapture;   /* vbi capture queue   */
 	struct bttv_buffer_set  curr;       /* active buffers      */
+	int                     new_input;
 
 	unsigned long cap_ctl;
 	unsigned long dma_on;

-- 
You have a new virus in /var/mail/kraxel
