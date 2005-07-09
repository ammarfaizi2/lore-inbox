Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbVGIAls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVGIAls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 20:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVGIAjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:39:55 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:59319 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263023AbVGIAgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:36:50 -0400
Message-ID: <42CF1C1C.7040905@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:36:44 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 3/14 2.6.13-rc2-mm1] V4L CX88 Update
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------080909020603090306000105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909020603090306000105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------080909020603090306000105
Content-Type: text/x-patch;
 name="v4l_cx88-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_cx88-update.diff"

- Removed unused structures.
- Removed BTTV version check.
- Some debug structs moved to their own .c file and converted to static
- Comment changed to express better when attach_inform is running
- set_freq removed from set_mode at tuner-core.c.
- I2C cleanups and converged to a basic reference structure.
- Rename tuner structures fields.
- It calls VIDIOC_G_FREQUENCY to get tuner freq from tuner.
- added missing contrast offset value, set to 0.
- Let Kconfig decide whether to include frontend-specific code.

Signed-Off-By: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/cx88/cx88-blackbird.c |    5 
 linux/drivers/media/video/cx88/cx88-core.c      |   48 -
 linux/drivers/media/video/cx88/cx88-dvb.c       |   36 -
 linux/drivers/media/video/cx88/cx88-i2c.c       |   31 -
 linux/drivers/media/video/cx88/cx88-input.c     |  448 ++++++++--------
 linux/drivers/media/video/cx88/cx88-mpeg.c      |   26 
 linux/drivers/media/video/cx88/cx88-reg.h       |   11 
 linux/drivers/media/video/cx88/cx88-tvaudio.c   |   76 --
 linux/drivers/media/video/cx88/cx88-video.c     |  303 ----------
 linux/drivers/media/video/cx88/cx88.h           |   12 
 10 files changed, 296 insertions(+), 700 deletions(-)

diff -u linux-2.6.13/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.13/drivers/media/video/cx88/cx88.h	2005-07-07 17:47:38.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88.h	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88.h,v 1.67 2005/07/01 12:10:07 mkrufky Exp $
+ * $Id: cx88.h,v 1.68 2005/07/07 14:17:47 mchehab Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -82,9 +82,9 @@
 static unsigned int inline norm_maxw(struct cx88_tvnorm *norm)
 {
 	return (norm->id & V4L2_STD_625_50) ? 768 : 640;
-//	return (norm->id & V4L2_STD_625_50) ? 720 : 640;
 }
 
+
 static unsigned int inline norm_maxh(struct cx88_tvnorm *norm)
 {
 	return (norm->id & V4L2_STD_625_50) ? 576 : 480;
@@ -220,7 +220,6 @@
 #define RESOURCE_VBI           4
 
 #define BUFFER_TIMEOUT     (HZ/2)  /* 0.5 seconds */
-//#define BUFFER_TIMEOUT     (HZ*2)
 
 /* buffer for one video frame */
 struct cx88_buffer {
@@ -336,11 +335,6 @@
 	struct pci_dev             *pci;
 	unsigned char              pci_rev,pci_lat;
 
-#if 0
-	/* video overlay */
-	struct v4l2_framebuffer    fbuf;
-	struct cx88_buffer         *screen;
-#endif
 
 	/* capture queues */
 	struct cx88_dmaqueue       vidq;
@@ -435,8 +429,6 @@
 /* ----------------------------------------------------------- */
 /* cx88-core.c                                                 */
 
-extern char *cx88_vid_irqs[32];
-extern char *cx88_mpeg_irqs[32];
 extern void cx88_print_irqbits(char *name, char *tag, char **strings,
 			       u32 bits, u32 mask);
 extern void cx88_print_ioctl(char *name, unsigned int cmd);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-reg.h linux/drivers/media/video/cx88/cx88-reg.h
--- linux-2.6.13/drivers/media/video/cx88/cx88-reg.h	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-reg.h	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-reg.h,v 1.7 2005/06/03 13:31:51 mchehab Exp $
+    $Id: cx88-reg.h,v 1.8 2005/07/07 13:58:38 mchehab Exp $
 
     cx88x-hw.h - CX2388x register offsets
 
@@ -604,20 +604,11 @@
 #define EN_I2SIN_STR2DAC        0x00004000
 #define EN_I2SIN_ENABLE         0x00008000
 
-#if 0
-/* old */
-#define EN_DMTRX_SUMDIFF        0x00000800
-#define EN_DMTRX_SUMR           0x00000880
-#define EN_DMTRX_LR             0x00000900
-#define EN_DMTRX_MONO           0x00000980
-#else
-/* dscaler cvs */
 #define EN_DMTRX_SUMDIFF        (0 << 7)
 #define EN_DMTRX_SUMR           (1 << 7)
 #define EN_DMTRX_LR             (2 << 7)
 #define EN_DMTRX_MONO           (3 << 7)
 #define EN_DMTRX_BYPASS         (1 << 11)
-#endif
 
 // Video
 #define VID_CAPTURE_CONTROL		0x310180
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-core.c linux/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-core.c	2005-07-07 17:47:37.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-core.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-core.c,v 1.31 2005/06/22 22:58:04 mchehab Exp $
+ * $Id: cx88-core.c,v 1.33 2005/07/07 14:17:47 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * driver core
@@ -470,25 +470,6 @@
 	return incr[risc >> 28] ? incr[risc >> 28] : 1;
 }
 
-#if 0 /* currently unused, but useful for debugging */
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
-#endif
 
 void cx88_sram_channel_dump(struct cx88_core *core,
 			    struct sram_channel *ch)
@@ -545,30 +526,12 @@
 	       core->name,cx_read(ch->cnt2_reg));
 }
 
-/* Used only on cx88-core */
 static char *cx88_pci_irqs[32] = {
 	"vid", "aud", "ts", "vip", "hst", "5", "6", "tm1",
 	"src_dma", "dst_dma", "risc_rd_err", "risc_wr_err",
 	"brdg_err", "src_dma_err", "dst_dma_err", "ipb_dma_err",
 	"i2c", "i2c_rack", "ir_smp", "gpio0", "gpio1"
 };
-/* Used only on cx88-video */
-char *cx88_vid_irqs[32] = {
-	"y_risci1", "u_risci1", "v_risci1", "vbi_risc1",
-	"y_risci2", "u_risci2", "v_risci2", "vbi_risc2",
-	"y_oflow",  "u_oflow",  "v_oflow",  "vbi_oflow",
-	"y_sync",   "u_sync",   "v_sync",   "vbi_sync",
-	"opc_err",  "par_err",  "rip_err",  "pci_abort",
-};
-/* Used only on cx88-mpeg */
-char *cx88_mpeg_irqs[32] = {
-	"ts_risci1", NULL, NULL, NULL,
-	"ts_risci2", NULL, NULL, NULL,
-	"ts_oflow",  NULL, NULL, NULL,
-	"ts_sync",   NULL, NULL, NULL,
-	"opc_err", "par_err", "rip_err", "pci_abort",
-	"ts_err?",
-};
 
 void cx88_print_irqbits(char *name, char *tag, char **strings,
 			u32 bits, u32 mask)
@@ -618,16 +581,11 @@
 			break;
 		buf = list_entry(q->active.next,
 				 struct cx88_buffer, vb.queue);
-#if 0
-		if (buf->count > count)
-			break;
-#else
 		/* count comes from the hw and is is 16bit wide --
 		 * this trick handles wrap-arounds correctly for
 		 * up to 32767 buffers in flight... */
 		if ((s16) (count - buf->count) < 0)
 			break;
-#endif
 		do_gettimeofday(&buf->vb.ts);
 		dprintk(2,"[%p/%d] wakeup reg=%d buf=%d\n",buf,buf->vb.i,
 			count, buf->count);
@@ -955,12 +913,10 @@
 		norm->cxiformat, cx_read(MO_INPUT_FORMAT) & 0x0f);
 	cx_andor(MO_INPUT_FORMAT, 0xf, norm->cxiformat);
 
-#if 1
 	// FIXME: as-is from DScaler
 	dprintk(1,"set_tvnorm: MO_OUTPUT_FORMAT 0x%08x [old=0x%08x]\n",
 		norm->cxoformat, cx_read(MO_OUTPUT_FORMAT));
 	cx_write(MO_OUTPUT_FORMAT, norm->cxoformat);
-#endif
 
 	// MO_SCONV_REG = adc clock / video dec clock * 2^17
 	tmp64  = adc_clock * (u64)(1 << 17);
@@ -1219,8 +1175,6 @@
 /* ------------------------------------------------------------------ */
 
 EXPORT_SYMBOL(cx88_print_ioctl);
-EXPORT_SYMBOL(cx88_vid_irqs);
-EXPORT_SYMBOL(cx88_mpeg_irqs);
 EXPORT_SYMBOL(cx88_print_irqbits);
 
 EXPORT_SYMBOL(cx88_core_irq);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c linux/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c	2005-07-07 17:47:38.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-i2c.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-i2c.c,v 1.24 2005/06/17 18:46:23 mkrufky Exp $
+    $Id: cx88-i2c.c,v 1.28 2005/07/05 17:37:35 nsh Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
@@ -91,25 +91,32 @@
 
 static int attach_inform(struct i2c_client *client)
 {
-        struct tuner_addr tun_addr;
+        struct tuner_setup tun_setup;
 	struct cx88_core *core = i2c_get_adapdata(client->adapter);
 
-	dprintk(1, "i2c attach [addr=0x%x,client=%s]\n",
-		client->addr, i2c_clientname(client));
+	dprintk(1, "%s i2c attach [addr=0x%x,client=%s]\n",
+		client->driver->name,client->addr,i2c_clientname(client));
 	if (!client->driver->command)
 		return 0;
 
         if (core->radio_type != UNSET) {
-                tun_addr.v4l2_tuner = V4L2_TUNER_RADIO;
-                tun_addr.type = core->radio_type;
-                tun_addr.addr = core->radio_addr;
-                client->driver->command(client,TUNER_SET_TYPE_ADDR, &tun_addr);
+		if ((core->radio_addr==ADDR_UNSET)||(core->radio_addr==client->addr)) {
+			tun_setup.mode_mask = T_RADIO;
+			tun_setup.type = core->radio_type;
+			tun_setup.addr = core->radio_addr;
+
+			client->driver->command (client, TUNER_SET_TYPE_ADDR, &tun_setup);
+		}
         }
         if (core->tuner_type != UNSET) {
-                tun_addr.v4l2_tuner = V4L2_TUNER_ANALOG_TV;
-                tun_addr.type = core->tuner_type;
-                tun_addr.addr = core->tuner_addr;
-                client->driver->command(client,TUNER_SET_TYPE_ADDR, &tun_addr);
+		if ((core->tuner_addr==ADDR_UNSET)||(core->tuner_addr==client->addr)) {
+
+			tun_setup.mode_mask = T_ANALOG_TV;
+			tun_setup.type = core->tuner_type;
+			tun_setup.addr = core->tuner_addr;
+
+			client->driver->command (client,TUNER_SET_TYPE_ADDR, &tun_setup);
+		}
         }
 
 	if (core->tda9887_conf)
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-tvaudio.c linux/drivers/media/video/cx88/cx88-tvaudio.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-tvaudio.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-tvaudio.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
-    $Id: cx88-tvaudio.c,v 1.36 2005/06/05 05:53:45 mchehab Exp $
+    $Id: cx88-tvaudio.c,v 1.37 2005/07/07 13:58:38 mchehab Exp $
 
     cx88x-audio.c - Conexant CX23880/23881 audio downstream driver driver
 
@@ -278,80 +278,6 @@
 	set_audio_finish(core);
 }
 
-#if 0
-static void set_audio_standard_NICAM(struct cx88_core *core)
-{
-	static const struct rlist nicam_common[] = {
-		/* from dscaler */
-    		{ AUD_RATE_ADJ1,           0x00000010 },
-    		{ AUD_RATE_ADJ2,           0x00000040 },
-    		{ AUD_RATE_ADJ3,           0x00000100 },
-    		{ AUD_RATE_ADJ4,           0x00000400 },
-    		{ AUD_RATE_ADJ5,           0x00001000 },
-    //		{ AUD_DMD_RA_DDS,          0x00c0d5ce },
-
-		// Deemphasis 1:
-		{ AUD_DEEMPHGAIN_R,        0x000023c2 },
-		{ AUD_DEEMPHNUMER1_R,      0x0002a7bc },
-		{ AUD_DEEMPHNUMER2_R,      0x0003023e },
-		{ AUD_DEEMPHDENOM1_R,      0x0000f3d0 },
-		{ AUD_DEEMPHDENOM2_R,      0x00000000 },
-
-#if 0
-		// Deemphasis 2: (other tv norm?)
-		{ AUD_DEEMPHGAIN_R,        0x0000c600 },
-		{ AUD_DEEMPHNUMER1_R,      0x00066738 },
-		{ AUD_DEEMPHNUMER2_R,      0x00066739 },
-		{ AUD_DEEMPHDENOM1_R,      0x0001e88c },
-		{ AUD_DEEMPHDENOM2_R,      0x0001e88c },
-#endif
-
-		{ AUD_DEEMPHDENOM2_R,      0x00000000 },
-		{ AUD_ERRLOGPERIOD_R,      0x00000fff },
-		{ AUD_ERRINTRPTTHSHLD1_R,  0x000003ff },
-		{ AUD_ERRINTRPTTHSHLD2_R,  0x000000ff },
-		{ AUD_ERRINTRPTTHSHLD3_R,  0x0000003f },
-		{ AUD_POLYPH80SCALEFAC,    0x00000003 },
-
-		// setup QAM registers
-		{ AUD_PDF_DDS_CNST_BYTE2,  0x06 },
-		{ AUD_PDF_DDS_CNST_BYTE1,  0x82 },
-		{ AUD_PDF_DDS_CNST_BYTE0,  0x16 },
-		{ AUD_QAM_MODE,            0x05 },
-
-                { /* end of list */ },
-        };
-	static const struct rlist nicam_pal_i[] = {
-		{ AUD_PDF_DDS_CNST_BYTE0,  0x12 },
-		{ AUD_PHACC_FREQ_8MSB,     0x3a },
-		{ AUD_PHACC_FREQ_8LSB,     0x93 },
-
-                { /* end of list */ },
-	};
-	static const struct rlist nicam_default[] = {
-		{ AUD_PDF_DDS_CNST_BYTE0,  0x16 },
-		{ AUD_PHACC_FREQ_8MSB,     0x34 },
-		{ AUD_PHACC_FREQ_8LSB,     0x4c },
-
-                { /* end of list */ },
-	};
-
-        set_audio_start(core, 0x0010,
-			EN_DMTRX_LR | EN_DMTRX_BYPASS | EN_NICAM_AUTO_STEREO);
-        set_audio_registers(core, nicam_common);
-	switch (core->tvaudio) {
-	case WW_NICAM_I:
-		dprintk("%s PAL-I NICAM (status: unknown)\n",__FUNCTION__);
-		set_audio_registers(core, nicam_pal_i);
-		break;
-	case WW_NICAM_BGDKL:
-		dprintk("%s PAL-BGDK NICAM (status: unknown)\n",__FUNCTION__);
-		set_audio_registers(core, nicam_default);
-		break;
-	};
-        set_audio_finish(core);
-}
-#endif
 
 static void set_audio_standard_NICAM_L(struct cx88_core *core, int stereo)
 {
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-video.c	2005-07-07 17:47:38.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-video.c,v 1.70 2005/06/20 03:36:00 mkrufky Exp $
+ * $Id: cx88-video.c,v 1.79 2005/07/07 14:17:47 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -86,13 +86,6 @@
 		.id        = V4L2_STD_NTSC_M_JP,
 		.cxiformat = VideoFormatNTSCJapan,
 		.cxoformat = 0x181f0008,
-#if 0
-	},{
-		.name      = "NTSC-4.43",
-		.id        = FIXME,
-		.cxiformat = VideoFormatNTSC443,
-		.cxoformat = 0x181f0008,
-#endif
 	},{
 		.name      = "PAL-BG",
 		.id        = V4L2_STD_PAL_BG,
@@ -248,6 +241,7 @@
 			.default_value = 0,
 			.type          = V4L2_CTRL_TYPE_INTEGER,
 		},
+		.off                   = 0,
 		.reg                   = MO_CONTR_BRIGHT,
 		.mask                  = 0xff00,
 		.shift                 = 8,
@@ -674,231 +668,6 @@
 
 /* ------------------------------------------------------------------ */
 
-#if 0 /* overlay support not finished yet */
-static u32* ov_risc_field(struct cx8800_dev *dev, struct cx8800_fh *fh,
-			  u32 *rp, struct btcx_skiplist *skips,
-			  u32 sync_line, int skip_even, int skip_odd)
-{
-	int line,maxy,start,end,skip,nskips;
-	u32 ri,ra;
-	u32 addr;
-
-	/* sync instruction */
-	*(rp++) = cpu_to_le32(RISC_RESYNC | sync_line);
-
-	addr  = (unsigned long)dev->fbuf.base;
-	addr += dev->fbuf.fmt.bytesperline * fh->win.w.top;
-	addr += (fh->fmt->depth >> 3)      * fh->win.w.left;
-
-	/* scan lines */
-	for (maxy = -1, line = 0; line < fh->win.w.height;
-	     line++, addr += dev->fbuf.fmt.bytesperline) {
-		if ((line%2) == 0  &&  skip_even)
-			continue;
-		if ((line%2) == 1  &&  skip_odd)
-			continue;
-
-		/* calculate clipping */
-		if (line > maxy)
-			btcx_calc_skips(line, fh->win.w.width, &maxy,
-					skips, &nskips, fh->clips, fh->nclips);
-
-		/* write out risc code */
-		for (start = 0, skip = 0; start < fh->win.w.width; start = end) {
-			if (skip >= nskips) {
-				ri  = RISC_WRITE;
-				end = fh->win.w.width;
-			} else if (start < skips[skip].start) {
-				ri  = RISC_WRITE;
-				end = skips[skip].start;
-			} else {
-				ri  = RISC_SKIP;
-				end = skips[skip].end;
-				skip++;
-			}
-			if (RISC_WRITE == ri)
-				ra = addr + (fh->fmt->depth>>3)*start;
-			else
-				ra = 0;
-
-			if (0 == start)
-				ri |= RISC_SOL;
-			if (fh->win.w.width == end)
-				ri |= RISC_EOL;
-			ri |= (fh->fmt->depth>>3) * (end-start);
-
-			*(rp++)=cpu_to_le32(ri);
-			if (0 != ra)
-				*(rp++)=cpu_to_le32(ra);
-		}
-	}
-	kfree(skips);
-	return rp;
-}
-
-static int ov_risc_frame(struct cx8800_dev *dev, struct cx8800_fh *fh,
-			 struct cx88_buffer *buf)
-{
-	struct btcx_skiplist *skips;
-	u32 instructions,fields;
-	u32 *rp;
-	int rc;
-
-	/* skip list for window clipping */
-	if (NULL == (skips = kmalloc(sizeof(*skips) * fh->nclips,GFP_KERNEL)))
-		return -ENOMEM;
-
-	fields = 0;
-	if (V4L2_FIELD_HAS_TOP(fh->win.field))
-		fields++;
-	if (V4L2_FIELD_HAS_BOTTOM(fh->win.field))
-		fields++;
-
-        /* estimate risc mem: worst case is (clip+1) * lines instructions
-           + syncs + jump (all 2 dwords) */
-	instructions  = (fh->nclips+1) * fh->win.w.height;
-	instructions += 3 + 4;
-	if ((rc = btcx_riscmem_alloc(dev->pci,&buf->risc,instructions*8)) < 0) {
-		kfree(skips);
-		return rc;
-	}
-
-	/* write risc instructions */
-	rp = buf->risc.cpu;
-	switch (fh->win.field) {
-	case V4L2_FIELD_TOP:
-		rp = ov_risc_field(dev, fh, rp, skips, 0,     0, 0);
-		break;
-	case V4L2_FIELD_BOTTOM:
-		rp = ov_risc_field(dev, fh, rp, skips, 0x200, 0, 0);
-		break;
-	case V4L2_FIELD_INTERLACED:
-		rp = ov_risc_field(dev, fh, rp, skips, 0,     0, 1);
-		rp = ov_risc_field(dev, fh, rp, skips, 0x200, 1, 0);
-		break;
-	default:
-		BUG();
-	}
-
-	/* save pointer to jmp instruction address */
-	buf->risc.jmp = rp;
-	kfree(skips);
-	return 0;
-}
-
-static int verify_window(struct cx8800_dev *dev, struct v4l2_window *win)
-{
-	enum v4l2_field field;
-	int maxw, maxh;
-
-	if (NULL == dev->fbuf.base)
-		return -EINVAL;
-	if (win->w.width < 48 || win->w.height <  32)
-		return -EINVAL;
-	if (win->clipcount > 2048)
-		return -EINVAL;
-
-	field = win->field;
-	maxw  = norm_maxw(core->tvnorm);
-	maxh  = norm_maxh(core->tvnorm);
-
-	if (V4L2_FIELD_ANY == field) {
-                field = (win->w.height > maxh/2)
-                        ? V4L2_FIELD_INTERLACED
-                        : V4L2_FIELD_TOP;
-        }
-        switch (field) {
-        case V4L2_FIELD_TOP:
-        case V4L2_FIELD_BOTTOM:
-                maxh = maxh / 2;
-                break;
-        case V4L2_FIELD_INTERLACED:
-                break;
-        default:
-                return -EINVAL;
-        }
-
-	win->field = field;
-	if (win->w.width > maxw)
-		win->w.width = maxw;
-	if (win->w.height > maxh)
-		win->w.height = maxh;
-	return 0;
-}
-
-static int setup_window(struct cx8800_dev *dev, struct cx8800_fh *fh,
-			struct v4l2_window *win)
-{
-	struct v4l2_clip *clips = NULL;
-	int n,size,retval = 0;
-
-	if (NULL == fh->fmt)
-		return -EINVAL;
-	retval = verify_window(dev,win);
-	if (0 != retval)
-		return retval;
-
-	/* copy clips  --  luckily v4l1 + v4l2 are binary
-	   compatible here ...*/
-	n = win->clipcount;
-	size = sizeof(*clips)*(n+4);
-	clips = kmalloc(size,GFP_KERNEL);
-	if (NULL == clips)
-		return -ENOMEM;
-	if (n > 0) {
-		if (copy_from_user(clips,win->clips,sizeof(struct v4l2_clip)*n)) {
-			kfree(clips);
-			return -EFAULT;
-		}
-	}
-
-	/* clip against screen */
-	if (NULL != dev->fbuf.base)
-		n = btcx_screen_clips(dev->fbuf.fmt.width, dev->fbuf.fmt.height,
-				      &win->w, clips, n);
-	btcx_sort_clips(clips,n);
-
-	/* 4-byte alignments */
-	switch (fh->fmt->depth) {
-	case 8:
-	case 24:
-		btcx_align(&win->w, clips, n, 3);
-		break;
-	case 16:
-		btcx_align(&win->w, clips, n, 1);
-		break;
-	case 32:
-		/* no alignment fixups needed */
-		break;
-	default:
-		BUG();
-	}
-
-	down(&fh->vidq.lock);
-	if (fh->clips)
-		kfree(fh->clips);
-	fh->clips    = clips;
-	fh->nclips   = n;
-	fh->win      = *win;
-#if 0
-	fh->ov.setup_ok = 1;
-#endif
-
-	/* update overlay if needed */
-	retval = 0;
-#if 0
-	if (check_btres(fh, RESOURCE_OVERLAY)) {
-		struct bttv_buffer *new;
-
-		new = videobuf_alloc(sizeof(*new));
-		bttv_overlay_risc(btv, &fh->ov, fh->ovfmt, new);
-		retval = bttv_switch_overlay(btv,fh,new);
-	}
-#endif
-	up(&fh->vidq.lock);
-	return retval;
-}
-#endif
 
 /* ------------------------------------------------------------------ */
 
@@ -1327,9 +1096,6 @@
 	struct cx8800_fh  *fh   = file->private_data;
 	struct cx8800_dev *dev  = fh->dev;
 	struct cx88_core  *core = dev->core;
-#if 0
-	unsigned long flags;
-#endif
 	int err;
 
 	if (video_debug > 1)
@@ -1350,9 +1116,6 @@
 			V4L2_CAP_READWRITE     |
 			V4L2_CAP_STREAMING     |
 			V4L2_CAP_VBI_CAPTURE   |
-#if 0
-			V4L2_CAP_VIDEO_OVERLAY |
-#endif
 			0;
 		if (UNSET != core->tuner_type)
 			cap->capabilities |= V4L2_CAP_TUNER;
@@ -1453,36 +1216,6 @@
 	}
 
 
-#if 0
-	/* needs review */
-	case VIDIOC_G_AUDIO:
-	{
-		struct v4l2_audio *a = arg;
-		unsigned int n = a->index;
-
-		memset(a,0,sizeof(*a));
-		a->index = n;
-		switch (n) {
-		case 0:
-			if ((CX88_VMUX_TELEVISION == INPUT(n)->type)
-			    || (CX88_VMUX_CABLE == INPUT(n)->type)) {
-				strcpy(a->name,"Television");
-				// FIXME figure out if stereo received and set V4L2_AUDCAP_STEREO.
-				return 0;
-			}
-			break;
-		case 1:
-			if (CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q == core->board) {
-				strcpy(a->name,"Line In");
-				a->capability = V4L2_AUDCAP_STEREO;
-				return 0;
-			}
-			break;
-		}
-		// Audio input not available.
-		return -EINVAL;
-	}
-#endif
 
 	/* --- capture ioctls ---------------------------------------- */
 	case VIDIOC_ENUM_FMT:
@@ -1592,6 +1325,9 @@
 
 		f->type = fh->radio ? V4L2_TUNER_RADIO : V4L2_TUNER_ANALOG_TV;
 		f->frequency = dev->freq;
+
+		cx88_call_i2c_clients(dev->core,VIDIOC_G_FREQUENCY,f);
+
 		return 0;
 	}
 	case VIDIOC_S_FREQUENCY:
@@ -1846,6 +1582,14 @@
 	spin_unlock_irqrestore(&dev->slock,flags);
 }
 
+static char *cx88_vid_irqs[32] = {
+	"y_risci1", "u_risci1", "v_risci1", "vbi_risc1",
+	"y_risci2", "u_risci2", "v_risci2", "vbi_risc2",
+	"y_oflow",  "u_oflow",  "v_oflow",  "vbi_oflow",
+	"y_sync",   "u_sync",   "v_sync",   "vbi_sync",
+	"opc_err",  "par_err",  "rip_err",  "pci_abort",
+};
+
 static void cx8800_vid_irq(struct cx8800_dev *dev)
 {
 	struct cx88_core *core = dev->core;
@@ -2013,7 +1757,6 @@
 {
 	struct cx8800_dev *dev;
 	struct cx88_core *core;
-	struct tuner_addr tun_addr;
 	int err;
 
 	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
@@ -2087,22 +1830,6 @@
 		request_module("tuner");
 	if (core->tda9887_conf)
 		request_module("tda9887");
-	if (core->radio_type != UNSET) {
-	        tun_addr.v4l2_tuner = V4L2_TUNER_RADIO;
-		tun_addr.type = core->radio_type;
-		tun_addr.addr = core->radio_addr;
-		cx88_call_i2c_clients(dev->core,TUNER_SET_TYPE_ADDR, &tun_addr);
-	}
-	if (core->tuner_type != UNSET) {
-	        tun_addr.v4l2_tuner = V4L2_TUNER_ANALOG_TV;
-		tun_addr.type = core->tuner_type;
-		tun_addr.addr = core->tuner_addr;
-		cx88_call_i2c_clients(dev->core,TUNER_SET_TYPE_ADDR, &tun_addr);
-	}
-
-	if (core->tda9887_conf)
-		cx88_call_i2c_clients(dev->core,TDA9887_SET_CONFIG,&core->tda9887_conf);
-
 	/* register v4l devices */
 	dev->video_dev = cx88_vdev_init(core,dev->pci,
 					&cx8800_video_template,"video");
@@ -2212,10 +1939,8 @@
 	}
 	spin_unlock(&dev->slock);
 
-#if 1
 	/* FIXME -- shutdown device */
 	cx88_shutdown(dev->core);
-#endif
 
 	pci_save_state(pci_dev);
 	if (0 != pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))) {
@@ -2237,10 +1962,8 @@
 	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
-#if 1
 	/* FIXME: re-initialize hardware */
 	cx88_reset(dev->core);
-#endif
 
 	/* restart video+vbi capture */
 	spin_lock(&dev->slock);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-input.c linux/drivers/media/video/cx88/cx88-input.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-input.c	2005-07-07 17:47:38.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-input.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-input.c,v 1.13 2005/06/13 16:07:46 nsh Exp $
+ * $Id: cx88-input.c,v 1.15 2005/07/07 13:58:38 mchehab Exp $
  *
  * Device driver for GPIO attached remote control interfaces
  * on Conexant 2388x based TV/DVB cards.
@@ -38,199 +38,206 @@
 
 /* DigitalNow DNTV Live DVB-T Remote */
 static IR_KEYTAB_TYPE ir_codes_dntv_live_dvb_t[IR_KEYTAB_SIZE] = {
-	[ 0x00 ] = KEY_ESC,         // 'go up a level?'
-	[ 0x01 ] = KEY_KP1,         // '1'
-	[ 0x02 ] = KEY_KP2,         // '2'
-	[ 0x03 ] = KEY_KP3,         // '3'
-	[ 0x04 ] = KEY_KP4,         // '4'
-	[ 0x05 ] = KEY_KP5,         // '5'
-	[ 0x06 ] = KEY_KP6,         // '6'
-	[ 0x07 ] = KEY_KP7,         // '7'
-	[ 0x08 ] = KEY_KP8,         // '8'
-	[ 0x09 ] = KEY_KP9,         // '9'
-	[ 0x0a ] = KEY_KP0,         // '0'
-	[ 0x0b ] = KEY_TUNER,       // 'tv/fm'
-	[ 0x0c ] = KEY_SEARCH,      // 'scan'
-	[ 0x0d ] = KEY_STOP,        // 'stop'
-	[ 0x0e ] = KEY_PAUSE,       // 'pause'
-	[ 0x0f ] = KEY_LIST,        // 'source'
-
-	[ 0x10 ] = KEY_MUTE,        // 'mute'
-	[ 0x11 ] = KEY_REWIND,      // 'backward <<'
-	[ 0x12 ] = KEY_POWER,       // 'power'
-	[ 0x13 ] = KEY_S,           // 'snap'
-	[ 0x14 ] = KEY_AUDIO,       // 'stereo'
-	[ 0x15 ] = KEY_CLEAR,       // 'reset'
-	[ 0x16 ] = KEY_PLAY,        // 'play'
-	[ 0x17 ] = KEY_ENTER,       // 'enter'
-	[ 0x18 ] = KEY_ZOOM,        // 'full screen'
-	[ 0x19 ] = KEY_FASTFORWARD, // 'forward >>'
-	[ 0x1a ] = KEY_CHANNELUP,   // 'channel +'
-	[ 0x1b ] = KEY_VOLUMEUP,    // 'volume +'
-	[ 0x1c ] = KEY_INFO,        // 'preview'
-	[ 0x1d ] = KEY_RECORD,      // 'record'
-	[ 0x1e ] = KEY_CHANNELDOWN, // 'channel -'
-	[ 0x1f ] = KEY_VOLUMEDOWN,  // 'volume -'
+	[0x00] = KEY_ESC,		/* 'go up a level?' */
+	/* Keys 0 to 9 */
+	[0x0a] = KEY_KP0,
+	[0x01] = KEY_KP1,
+	[0x02] = KEY_KP2,
+	[0x03] = KEY_KP3,
+	[0x04] = KEY_KP4,
+	[0x05] = KEY_KP5,
+	[0x06] = KEY_KP6,
+	[0x07] = KEY_KP7,
+	[0x08] = KEY_KP8,
+	[0x09] = KEY_KP9,
+
+	[0x0b] = KEY_TUNER,		/* tv/fm */
+	[0x0c] = KEY_SEARCH,		/* scan */
+	[0x0d] = KEY_STOP,
+	[0x0e] = KEY_PAUSE,
+	[0x0f] = KEY_LIST,		/* source */
+
+	[0x10] = KEY_MUTE,
+	[0x11] = KEY_REWIND,		/* backward << */
+	[0x12] = KEY_POWER,
+	[0x13] = KEY_S,			/* snap */
+	[0x14] = KEY_AUDIO,		/* stereo */
+	[0x15] = KEY_CLEAR,		/* reset */
+	[0x16] = KEY_PLAY,
+	[0x17] = KEY_ENTER,
+	[0x18] = KEY_ZOOM,		/* full screen */
+	[0x19] = KEY_FASTFORWARD,	/* forward >> */
+	[0x1a] = KEY_CHANNELUP,
+	[0x1b] = KEY_VOLUMEUP,
+	[0x1c] = KEY_INFO,		/* preview */
+	[0x1d] = KEY_RECORD,		/* record */
+	[0x1e] = KEY_CHANNELDOWN,
+	[0x1f] = KEY_VOLUMEDOWN,
 };
 
 /* ---------------------------------------------------------------------- */
 
 /* IO-DATA BCTV7E Remote */
 static IR_KEYTAB_TYPE ir_codes_iodata_bctv7e[IR_KEYTAB_SIZE] = {
-	[ 0x40 ] = KEY_TV,              // TV
-	[ 0x20 ] = KEY_RADIO,           // FM
-	[ 0x60 ] = KEY_EPG,             // EPG
-	[ 0x00 ] = KEY_POWER,           // power
-
-	[ 0x50 ] = KEY_KP1,             // 1
-	[ 0x30 ] = KEY_KP2,             // 2
-	[ 0x70 ] = KEY_KP3,             // 3
-	[ 0x10 ] = KEY_L,               // Live
-
-	[ 0x48 ] = KEY_KP4,             // 4
-	[ 0x28 ] = KEY_KP5,             // 5
-	[ 0x68 ] = KEY_KP6,             // 6
-	[ 0x08 ] = KEY_T,               // Time Shift
-
-	[ 0x58 ] = KEY_KP7,             // 7
-	[ 0x38 ] = KEY_KP8,             // 8
-	[ 0x78 ] = KEY_KP9,             // 9
-	[ 0x18 ] = KEY_PLAYPAUSE,       // Play
-
-	[ 0x44 ] = KEY_KP0,             // 10
-	[ 0x24 ] = KEY_ENTER,           // 11
-	[ 0x64 ] = KEY_ESC,             // 12
-	[ 0x04 ] = KEY_M,               // Multi
-
-	[ 0x54 ] = KEY_VIDEO,           // VIDEO
-	[ 0x34 ] = KEY_CHANNELUP,       // channel +
-	[ 0x74 ] = KEY_VOLUMEUP,        // volume +
-	[ 0x14 ] = KEY_MUTE,            // Mute
-
-	[ 0x4c ] = KEY_S,               // SVIDEO
-	[ 0x2c ] = KEY_CHANNELDOWN,     // channel -
-	[ 0x6c ] = KEY_VOLUMEDOWN,      // volume -
-	[ 0x0c ] = KEY_ZOOM,            // Zoom
-
-	[ 0x5c ] = KEY_PAUSE,           // pause
-	[ 0x3c ] = KEY_C,               // || (red)
-	[ 0x7c ] = KEY_RECORD,          // recording
-	[ 0x1c ] = KEY_STOP,            // stop
-
-	[ 0x41 ] = KEY_REWIND,          // backward <<
-	[ 0x21 ] = KEY_PLAY,            // play
-	[ 0x61 ] = KEY_FASTFORWARD,     // forward >>
-	[ 0x01 ] = KEY_NEXT,            // skip >|
+	[0x40] = KEY_TV,
+	[0x20] = KEY_RADIO,		/* FM */
+	[0x60] = KEY_EPG,
+	[0x00] = KEY_POWER,
+
+	/* Keys 0 to 9 */
+	[0x44] = KEY_KP0,		/* 10 */
+	[0x50] = KEY_KP1,
+	[0x30] = KEY_KP2,
+	[0x70] = KEY_KP3,
+	[0x48] = KEY_KP4,
+	[0x28] = KEY_KP5,
+	[0x68] = KEY_KP6,
+	[0x58] = KEY_KP7,
+	[0x38] = KEY_KP8,
+	[0x78] = KEY_KP9,
+
+	[0x10] = KEY_L,			/* Live */
+	[0x08] = KEY_T,			/* Time Shift */
+
+	[0x18] = KEY_PLAYPAUSE,		/* Play */
+
+	[0x24] = KEY_ENTER,		/* 11 */
+	[0x64] = KEY_ESC,		/* 12 */
+	[0x04] = KEY_M,			/* Multi */
+
+	[0x54] = KEY_VIDEO,
+	[0x34] = KEY_CHANNELUP,
+	[0x74] = KEY_VOLUMEUP,
+	[0x14] = KEY_MUTE,
+
+	[0x4c] = KEY_S,			/* SVIDEO */
+	[0x2c] = KEY_CHANNELDOWN,
+	[0x6c] = KEY_VOLUMEDOWN,
+	[0x0c] = KEY_ZOOM,
+
+	[0x5c] = KEY_PAUSE,
+	[0x3c] = KEY_C,			/* || (red) */
+	[0x7c] = KEY_RECORD,		/* recording */
+	[0x1c] = KEY_STOP,
+
+	[0x41] = KEY_REWIND,		/* backward << */
+	[0x21] = KEY_PLAY,
+	[0x61] = KEY_FASTFORWARD,	/* forward >> */
+	[0x01] = KEY_NEXT,		/* skip >| */
 };
 
 /* ---------------------------------------------------------------------- */
 
 /* ADS Tech Instant TV DVB-T PCI Remote */
 static IR_KEYTAB_TYPE ir_codes_adstech_dvb_t_pci[IR_KEYTAB_SIZE] = {
-	[ 0x5b ] = KEY_POWER,
-	[ 0x5f ] = KEY_MUTE,
-	[ 0x57 ] = KEY_1,
-	[ 0x4f ] = KEY_2,
-	[ 0x53 ] = KEY_3,
-	[ 0x56 ] = KEY_4,
-	[ 0x4e ] = KEY_5,
-	[ 0x5e ] = KEY_6,
-	[ 0x54 ] = KEY_7,
-	[ 0x4c ] = KEY_8,
-	[ 0x5c ] = KEY_9,
-	[ 0x4d ] = KEY_0,
-	[ 0x55 ] = KEY_GOTO,
-	[ 0x5d ] = KEY_SEARCH,
-	[ 0x17 ] = KEY_EPG,             // Guide
-	[ 0x1f ] = KEY_MENU,
-	[ 0x0f ] = KEY_UP,
-	[ 0x46 ] = KEY_DOWN,
-	[ 0x16 ] = KEY_LEFT,
-	[ 0x1e ] = KEY_RIGHT,
-	[ 0x0e ] = KEY_SELECT,          // Enter
-	[ 0x5a ] = KEY_INFO,
-	[ 0x52 ] = KEY_EXIT,
-	[ 0x59 ] = KEY_PREVIOUS,
-	[ 0x51 ] = KEY_NEXT,
-	[ 0x58 ] = KEY_REWIND,
-	[ 0x50 ] = KEY_FORWARD,
-	[ 0x44 ] = KEY_PLAYPAUSE,
-	[ 0x07 ] = KEY_STOP,
-	[ 0x1b ] = KEY_RECORD,
-	[ 0x13 ] = KEY_TUNER,           // Live
-	[ 0x0a ] = KEY_A,
-	[ 0x12 ] = KEY_B,
-	[ 0x03 ] = KEY_PROG1,           // 1
-	[ 0x01 ] = KEY_PROG2,           // 2
-	[ 0x00 ] = KEY_PROG3,           // 3
-	[ 0x06 ] = KEY_DVD,
-	[ 0x48 ] = KEY_AUX,             // Photo
-	[ 0x40 ] = KEY_VIDEO,
-	[ 0x19 ] = KEY_AUDIO,           // Music
-	[ 0x0b ] = KEY_CHANNELUP,
-	[ 0x08 ] = KEY_CHANNELDOWN,
-	[ 0x15 ] = KEY_VOLUMEUP,
-	[ 0x1c ] = KEY_VOLUMEDOWN,
+	/* Keys 0 to 9 */
+	[0x4d] = KEY_0,
+	[0x57] = KEY_1,
+	[0x4f] = KEY_2,
+	[0x53] = KEY_3,
+	[0x56] = KEY_4,
+	[0x4e] = KEY_5,
+	[0x5e] = KEY_6,
+	[0x54] = KEY_7,
+	[0x4c] = KEY_8,
+	[0x5c] = KEY_9,
+
+	[0x5b] = KEY_POWER,
+	[0x5f] = KEY_MUTE,
+	[0x55] = KEY_GOTO,
+	[0x5d] = KEY_SEARCH,
+	[0x17] = KEY_EPG,		/* Guide */
+	[0x1f] = KEY_MENU,
+	[0x0f] = KEY_UP,
+	[0x46] = KEY_DOWN,
+	[0x16] = KEY_LEFT,
+	[0x1e] = KEY_RIGHT,
+	[0x0e] = KEY_SELECT,		/* Enter */
+	[0x5a] = KEY_INFO,
+	[0x52] = KEY_EXIT,
+	[0x59] = KEY_PREVIOUS,
+	[0x51] = KEY_NEXT,
+	[0x58] = KEY_REWIND,
+	[0x50] = KEY_FORWARD,
+	[0x44] = KEY_PLAYPAUSE,
+	[0x07] = KEY_STOP,
+	[0x1b] = KEY_RECORD,
+	[0x13] = KEY_TUNER,		/* Live */
+	[0x0a] = KEY_A,
+	[0x12] = KEY_B,
+	[0x03] = KEY_PROG1,		/* 1 */
+	[0x01] = KEY_PROG2,		/* 2 */
+	[0x00] = KEY_PROG3,		/* 3 */
+	[0x06] = KEY_DVD,
+	[0x48] = KEY_AUX,		/* Photo */
+	[0x40] = KEY_VIDEO,
+	[0x19] = KEY_AUDIO,		/* Music */
+	[0x0b] = KEY_CHANNELUP,
+	[0x08] = KEY_CHANNELDOWN,
+	[0x15] = KEY_VOLUMEUP,
+	[0x1c] = KEY_VOLUMEDOWN,
 };
 
 /* ---------------------------------------------------------------------- */
 
 /* MSI TV@nywhere remote */
 static IR_KEYTAB_TYPE ir_codes_msi_tvanywhere[IR_KEYTAB_SIZE] = {
-       [ 0x00 ] = KEY_0,           /* '0' */
-       [ 0x01 ] = KEY_1,           /* '1' */
-       [ 0x02 ] = KEY_2,           /* '2' */
-       [ 0x03 ] = KEY_3,           /* '3' */
-       [ 0x04 ] = KEY_4,           /* '4' */
-       [ 0x05 ] = KEY_5,           /* '5' */
-       [ 0x06 ] = KEY_6,           /* '6' */
-       [ 0x07 ] = KEY_7,           /* '7' */
-       [ 0x08 ] = KEY_8,           /* '8' */
-       [ 0x09 ] = KEY_9,           /* '9' */
-       [ 0x0c ] = KEY_MUTE,        /* 'Mute' */
-       [ 0x0f ] = KEY_SCREEN,      /* 'Full Screen' */
-       [ 0x10 ] = KEY_F,           /* 'Funtion' */
-       [ 0x11 ] = KEY_T,           /* 'Time shift' */
-       [ 0x12 ] = KEY_POWER,       /* 'Power' */
-       [ 0x13 ] = KEY_MEDIA,       /* 'MTS' */
-       [ 0x14 ] = KEY_SLOW,        /* 'Slow' */
-       [ 0x16 ] = KEY_REWIND,      /* 'backward <<' */
-       [ 0x17 ] = KEY_ENTER,       /* 'Return' */
-       [ 0x18 ] = KEY_FASTFORWARD, /* 'forward >>' */
-       [ 0x1a ] = KEY_CHANNELUP,   /* 'Channel+' */
-       [ 0x1b ] = KEY_VOLUMEUP,    /* 'Volume+' */
-       [ 0x1e ] = KEY_CHANNELDOWN, /* 'Channel-' */
-       [ 0x1f ] = KEY_VOLUMEDOWN,  /* 'Volume-' */
+	/* Keys 0 to 9 */
+	[0x00] = KEY_0,
+	[0x01] = KEY_1,
+	[0x02] = KEY_2,
+	[0x03] = KEY_3,
+	[0x04] = KEY_4,
+	[0x05] = KEY_5,
+	[0x06] = KEY_6,
+	[0x07] = KEY_7,
+	[0x08] = KEY_8,
+	[0x09] = KEY_9,
+
+	[0x0c] = KEY_MUTE,
+	[0x0f] = KEY_SCREEN,		/* Full Screen */
+	[0x10] = KEY_F,			/* Funtion */
+	[0x11] = KEY_T,			/* Time shift */
+	[0x12] = KEY_POWER,
+	[0x13] = KEY_MEDIA,		/* MTS */
+	[0x14] = KEY_SLOW,
+	[0x16] = KEY_REWIND,		/* backward << */
+	[0x17] = KEY_ENTER,		/* Return */
+	[0x18] = KEY_FASTFORWARD,	/* forward >> */
+	[0x1a] = KEY_CHANNELUP,
+	[0x1b] = KEY_VOLUMEUP,
+	[0x1e] = KEY_CHANNELDOWN,
+	[0x1f] = KEY_VOLUMEDOWN,
 };
 
 /* ---------------------------------------------------------------------- */
 
 struct cx88_IR {
-	struct cx88_core	*core;
-	struct input_dev        input;
-	struct ir_input_state   ir;
-	char                    name[32];
-	char                    phys[32];
+	struct cx88_core *core;
+	struct input_dev input;
+	struct ir_input_state ir;
+	char name[32];
+	char phys[32];
 
 	/* sample from gpio pin 16 */
-	int                     sampling;
-	u32                     samples[16];
-	int                     scount;
-	unsigned long           release;
+	int sampling;
+	u32 samples[16];
+	int scount;
+	unsigned long release;
 
 	/* poll external decoder */
-	int                     polling;
-	struct work_struct      work;
-	struct timer_list       timer;
-	u32			gpio_addr;
-	u32                     last_gpio;
-	u32                     mask_keycode;
-	u32                     mask_keydown;
-	u32                     mask_keyup;
+	int polling;
+	struct work_struct work;
+	struct timer_list timer;
+	u32 gpio_addr;
+	u32 last_gpio;
+	u32 mask_keycode;
+	u32 mask_keydown;
+	u32 mask_keyup;
 };
 
 static int ir_debug = 0;
-module_param(ir_debug, int, 0644);    /* debug level [IR] */
+module_param(ir_debug, int, 0644);	/* debug level [IR] */
 MODULE_PARM_DESC(ir_debug, "enable debug messages [IR]");
 
 #define ir_dprintk(fmt, arg...)	if (ir_debug) \
@@ -254,37 +261,37 @@
 	/* extract data */
 	data = ir_extract_bits(gpio, ir->mask_keycode);
 	ir_dprintk("irq gpio=0x%x code=%d | %s%s%s\n",
-		gpio, data,
-		ir->polling               ? "poll"  : "irq",
-		(gpio & ir->mask_keydown) ? " down" : "",
-		(gpio & ir->mask_keyup)   ? " up"   : "");
+		   gpio, data,
+		   ir->polling ? "poll" : "irq",
+		   (gpio & ir->mask_keydown) ? " down" : "",
+		   (gpio & ir->mask_keyup) ? " up" : "");
 
 	if (ir->mask_keydown) {
 		/* bit set on keydown */
 		if (gpio & ir->mask_keydown) {
-			ir_input_keydown(&ir->input,&ir->ir,data,data);
+			ir_input_keydown(&ir->input, &ir->ir, data, data);
 		} else {
-			ir_input_nokey(&ir->input,&ir->ir);
+			ir_input_nokey(&ir->input, &ir->ir);
 		}
 
 	} else if (ir->mask_keyup) {
 		/* bit cleared on keydown */
 		if (0 == (gpio & ir->mask_keyup)) {
-			ir_input_keydown(&ir->input,&ir->ir,data,data);
+			ir_input_keydown(&ir->input, &ir->ir, data, data);
 		} else {
-			ir_input_nokey(&ir->input,&ir->ir);
+			ir_input_nokey(&ir->input, &ir->ir);
 		}
 
 	} else {
 		/* can't distinguish keydown/up :-/ */
-		ir_input_keydown(&ir->input,&ir->ir,data,data);
-		ir_input_nokey(&ir->input,&ir->ir);
+		ir_input_keydown(&ir->input, &ir->ir, data, data);
+		ir_input_nokey(&ir->input, &ir->ir);
 	}
 }
 
 static void ir_timer(unsigned long data)
 {
-	struct cx88_IR *ir = (struct cx88_IR*)data;
+	struct cx88_IR *ir = (struct cx88_IR *)data;
 
 	schedule_work(&ir->work);
 }
@@ -307,62 +314,62 @@
 	IR_KEYTAB_TYPE *ir_codes = NULL;
 	int ir_type = IR_TYPE_OTHER;
 
-	ir = kmalloc(sizeof(*ir),GFP_KERNEL);
+	ir = kmalloc(sizeof(*ir), GFP_KERNEL);
 	if (NULL == ir)
 		return -ENOMEM;
-	memset(ir,0,sizeof(*ir));
+	memset(ir, 0, sizeof(*ir));
 
 	/* detect & configure */
 	switch (core->board) {
 	case CX88_BOARD_DNTV_LIVE_DVB_T:
 	case CX88_BOARD_KWORLD_DVB_T:
-		ir_codes         = ir_codes_dntv_live_dvb_t;
-		ir->gpio_addr    = MO_GP1_IO;
+		ir_codes = ir_codes_dntv_live_dvb_t;
+		ir->gpio_addr = MO_GP1_IO;
 		ir->mask_keycode = 0x1f;
-		ir->mask_keyup   = 0x60;
-		ir->polling      = 50; // ms
+		ir->mask_keyup = 0x60;
+		ir->polling = 50; /* ms */
 		break;
 	case CX88_BOARD_HAUPPAUGE:
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
-		ir_codes         = ir_codes_hauppauge_new;
-		ir_type          = IR_TYPE_RC5;
-		ir->sampling     = 1;
+		ir_codes = ir_codes_hauppauge_new;
+		ir_type = IR_TYPE_RC5;
+		ir->sampling = 1;
 		break;
 	case CX88_BOARD_WINFAST2000XP_EXPERT:
-		ir_codes         = ir_codes_winfast;
-		ir->gpio_addr    = MO_GP0_IO;
+		ir_codes = ir_codes_winfast;
+		ir->gpio_addr = MO_GP0_IO;
 		ir->mask_keycode = 0x8f8;
-		ir->mask_keyup   = 0x100;
-		ir->polling      = 1; // ms
+		ir->mask_keyup = 0x100;
+		ir->polling = 1; /* ms */
 		break;
 	case CX88_BOARD_IODATA_GVBCTV7E:
-		ir_codes         = ir_codes_iodata_bctv7e;
-		ir->gpio_addr    = MO_GP0_IO;
+		ir_codes = ir_codes_iodata_bctv7e;
+		ir->gpio_addr = MO_GP0_IO;
 		ir->mask_keycode = 0xfd;
 		ir->mask_keydown = 0x02;
-		ir->polling      = 5; // ms
+		ir->polling = 5; /* ms */
 		break;
 	case CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO:
-		ir_codes         = ir_codes_pixelview;
-		ir->gpio_addr    = MO_GP1_IO;
+		ir_codes = ir_codes_pixelview;
+		ir->gpio_addr = MO_GP1_IO;
 		ir->mask_keycode = 0x1f;
-		ir->mask_keyup   = 0x80;
-		ir->polling      = 1; // ms
+		ir->mask_keyup = 0x80;
+		ir->polling = 1; /* ms */
 		break;
 	case CX88_BOARD_ADSTECH_DVB_T_PCI:
-		ir_codes         = ir_codes_adstech_dvb_t_pci;
-		ir->gpio_addr    = MO_GP1_IO;
+		ir_codes = ir_codes_adstech_dvb_t_pci;
+		ir->gpio_addr = MO_GP1_IO;
 		ir->mask_keycode = 0xbf;
-		ir->mask_keyup   = 0x40;
-		ir->polling      = 50; // ms
+		ir->mask_keyup = 0x40;
+		ir->polling = 50; /* ms */
+		break;
+	case CX88_BOARD_MSI_TVANYWHERE_MASTER:
+		ir_codes = ir_codes_msi_tvanywhere;
+		ir->gpio_addr = MO_GP1_IO;
+		ir->mask_keycode = 0x1f;
+		ir->mask_keyup = 0x40;
+		ir->polling = 1; /* ms */
 		break;
-        case CX88_BOARD_MSI_TVANYWHERE_MASTER:
-                ir_codes         = ir_codes_msi_tvanywhere;
-                ir->gpio_addr    = MO_GP1_IO;
-                ir->mask_keycode = 0x1f;
-                ir->mask_keyup   = 0x40;
-                ir->polling      = 1;
-                break;
 	}
 
 	if (NULL == ir_codes) {
@@ -373,8 +380,7 @@
 	/* init input device */
 	snprintf(ir->name, sizeof(ir->name), "cx88 IR (%s)",
 		 cx88_boards[core->board].name);
-	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0",
-		 pci_name(pci));
+	snprintf(ir->phys, sizeof(ir->phys), "pci-%s/ir0", pci_name(pci));
 
 	ir_input_init(&ir->input, &ir->ir, ir_type, ir_codes);
 	ir->input.name = ir->name;
@@ -382,10 +388,10 @@
 	ir->input.id.bustype = BUS_PCI;
 	ir->input.id.version = 1;
 	if (pci->subsystem_vendor) {
-		ir->input.id.vendor  = pci->subsystem_vendor;
+		ir->input.id.vendor = pci->subsystem_vendor;
 		ir->input.id.product = pci->subsystem_device;
 	} else {
-		ir->input.id.vendor  = pci->vendor;
+		ir->input.id.vendor = pci->vendor;
 		ir->input.id.product = pci->device;
 	}
 
@@ -397,13 +403,13 @@
 		INIT_WORK(&ir->work, cx88_ir_work, ir);
 		init_timer(&ir->timer);
 		ir->timer.function = ir_timer;
-		ir->timer.data     = (unsigned long)ir;
+		ir->timer.data = (unsigned long)ir;
 		schedule_work(&ir->work);
 	}
 	if (ir->sampling) {
-		core->pci_irqmask |= (1<<18);   // IR_SMP_INT
-		cx_write(MO_DDS_IO, 0xa80a80);  // 4 kHz sample rate
-		cx_write(MO_DDSCFG_IO,   0x5);  // enable
+		core->pci_irqmask |= (1 << 18);	/* IR_SMP_INT */
+		cx_write(MO_DDS_IO, 0xa80a80);	/* 4 kHz sample rate */
+		cx_write(MO_DDSCFG_IO, 0x5);	/* enable */
 	}
 
 	/* all done */
@@ -439,7 +445,7 @@
 void cx88_ir_irq(struct cx88_core *core)
 {
 	struct cx88_IR *ir = core->ir;
-	u32 samples,rc5;
+	u32 samples, rc5;
 	int i;
 
 	if (NULL == ir)
@@ -448,7 +454,7 @@
 		return;
 
 	samples = cx_read(MO_SAMPLE_IO);
-	if (0 != samples  &&  0xffffffff != samples) {
+	if (0 != samples && 0xffffffff != samples) {
 		/* record sample data */
 		if (ir->scount < ARRAY_SIZE(ir->samples))
 			ir->samples[ir->scount++] = samples;
@@ -456,8 +462,8 @@
 	}
 	if (!ir->scount) {
 		/* nothing to sample */
-		if (ir->ir.keypressed && time_after(jiffies,ir->release))
-			ir_input_nokey(&ir->input,&ir->ir);
+		if (ir->ir.keypressed && time_after(jiffies, ir->release))
+			ir_input_nokey(&ir->input, &ir->ir);
 		return;
 	}
 
@@ -467,14 +473,14 @@
 	for (i = 0; i < ir->scount; i++)
 		ir->samples[i] = ~ir->samples[i];
 	if (ir_debug)
-		ir_dump_samples(ir->samples,ir->scount);
+		ir_dump_samples(ir->samples, ir->scount);
 
 	/* decode it */
 	switch (core->board) {
 	case CX88_BOARD_HAUPPAUGE:
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
-		rc5 = ir_decode_biphase(ir->samples,ir->scount,5,7);
-		ir_dprintk("biphase decoded: %x\n",rc5);
+		rc5 = ir_decode_biphase(ir->samples, ir->scount, 5, 7);
+		ir_dprintk("biphase decoded: %x\n", rc5);
 		if ((rc5 & 0xfffff000) != 0x3000)
 			break;
 		ir_input_keydown(&ir->input, &ir->ir, rc5 & 0x3f, rc5);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c linux/drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c	2005-07-07 17:47:38.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-mpeg.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-mpeg.c,v 1.30 2005/07/05 19:44:40 mkrufky Exp $
+ * $Id: cx88-mpeg.c,v 1.31 2005/07/07 14:17:47 mchehab Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -64,7 +64,6 @@
 	/* write TS length to chip */
 	cx_write(MO_TS_LNGTH, buf->vb.width);
 
-#if 1
 	/* FIXME: this needs a review.
 	 * also: move to cx88-blackbird + cx88-dvb source files? */
 
@@ -76,9 +75,9 @@
 		cx_write(TS_HW_SOP_CNTRL,0x47<<16|188<<4|0x01);
 		if ((core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q) ||
 		    (core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T)) {
-			cx_write(TS_SOP_STAT, 0<<16 | 0<<14 | 1<<13 | 0<<12);
+			cx_write(TS_SOP_STAT, 1<<13);
 		} else {
-			cx_write(TS_SOP_STAT,0x00);
+			cx_write(TS_SOP_STAT, 0x00);
 		}
 		cx_write(TS_GEN_CNTRL, dev->ts_gen_cntrl);
 		udelay(100);
@@ -98,7 +97,6 @@
 		cx_write(TS_GEN_CNTRL, 0x06); /* punctured clock TS & posedge driven */
 		udelay(100);
 	}
-#endif
 
 	/* reset counter */
 	cx_write(MO_TS_GPCNTRL, GP_COUNT_CONTROL_RESET);
@@ -270,6 +268,15 @@
 	do_cancel_buffers(dev,"timeout",1);
 }
 
+static char *cx88_mpeg_irqs[32] = {
+	"ts_risci1", NULL, NULL, NULL,
+	"ts_risci2", NULL, NULL, NULL,
+	"ts_oflow",  NULL, NULL, NULL,
+	"ts_sync",   NULL, NULL, NULL,
+	"opc_err", "par_err", "rip_err", "pci_abort",
+	"ts_err?",
+};
+
 static void cx8802_mpeg_irq(struct cx8802_dev *dev)
 {
 	struct cx88_core *core = dev->core;
@@ -282,10 +289,7 @@
 		return;
 
 	cx_write(MO_TS_INTSTAT, status);
-#if 0
-	cx88_print_irqbits(core->name, "irq mpeg ",
-			cx88_mpeg_irqs, status, mask);
-#endif
+
 	if (debug || (status & mask & ~0xff))
 		cx88_print_irqbits(core->name, "irq mpeg ",
 				   cx88_mpeg_irqs, status, mask);
@@ -441,10 +445,8 @@
 	}
 	spin_unlock(&dev->slock);
 
-#if 1
 	/* FIXME -- shutdown device */
 	cx88_shutdown(dev->core);
-#endif
 
 	pci_save_state(pci_dev);
 	if (0 != pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))) {
@@ -466,10 +468,8 @@
 	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 
-#if 1
 	/* FIXME: re-initialize hardware */
 	cx88_reset(dev->core);
-#endif
 
 	/* restart video+vbi capture */
 	spin_lock(&dev->slock);
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c linux/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-07-07 17:47:37.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-dvb.c	2005-07-07 18:44:17.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: cx88-dvb.c,v 1.39 2005/07/02 20:00:46 mkrufky Exp $
+ * $Id: cx88-dvb.c,v 1.41 2005/07/04 19:35:05 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -30,22 +30,20 @@
 #include <linux/file.h>
 #include <linux/suspend.h>
 
-/* these three frontends need merging via linuxtv cvs ... */
-#define HAVE_CX22702 1
-#define HAVE_OR51132 1
-#define HAVE_LGDT3302 1
-
 #include "cx88.h"
 #include "dvb-pll.h"
-#include "mt352.h"
-#include "mt352_priv.h"
-#if HAVE_CX22702
+
+#if CONFIG_DVB_MT352
+# include "mt352.h"
+# include "mt352_priv.h"
+#endif
+#if CONFIG_DVB_CX22702
 # include "cx22702.h"
 #endif
-#if HAVE_OR51132
+#if CONFIG_DVB_OR51132
 # include "or51132.h"
 #endif
-#if HAVE_LGDT3302
+#if CONFIG_DVB_LGDT3302
 # include "lgdt3302.h"
 #endif
 
@@ -104,6 +102,7 @@
 
 /* ------------------------------------------------------------------ */
 
+#if CONFIG_DVB_MT352
 static int dvico_fusionhdtv_demod_init(struct dvb_frontend* fe)
 {
 	static u8 clock_config []  = { CLOCK_CTL,  0x38, 0x39 };
@@ -171,8 +170,9 @@
 	.demod_init    = dntv_live_dvbt_demod_init,
 	.pll_set       = mt352_pll_set,
 };
+#endif
 
-#if HAVE_CX22702
+#if CONFIG_DVB_CX22702
 static struct cx22702_config connexant_refboard_config = {
 	.demod_address = 0x43,
 	.pll_address   = 0x60,
@@ -186,7 +186,7 @@
 };
 #endif
 
-#if HAVE_OR51132
+#if CONFIG_DVB_OR51132
 static int or51132_set_ts_param(struct dvb_frontend* fe,
 				int is_punctured)
 {
@@ -203,7 +203,7 @@
 };
 #endif
 
-#if HAVE_LGDT3302
+#if CONFIG_DVB_LGDT3302
 static int lgdt3302_set_ts_param(struct dvb_frontend* fe, int is_punctured)
 {
 	struct cx8802_dev *dev= fe->dvb->priv;
@@ -237,7 +237,7 @@
 
 	/* init frontend */
 	switch (dev->core->board) {
-#if HAVE_CX22702
+#if CONFIG_DVB_CX22702
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
 		dev->dvb.frontend = cx22702_attach(&hauppauge_novat_config,
 						   &dev->core->i2c_adap);
@@ -248,6 +248,7 @@
 						   &dev->core->i2c_adap);
 		break;
 #endif
+#if CONFIG_DVB_MT352
 	case CX88_BOARD_DVICO_FUSIONHDTV_DVB_T1:
 		dev->core->pll_addr = 0x61;
 		dev->core->pll_desc = &dvb_pll_lg_z201;
@@ -268,13 +269,14 @@
 		dev->dvb.frontend = mt352_attach(&dntv_live_dvbt_config,
 						 &dev->core->i2c_adap);
 		break;
-#if HAVE_OR51132
+#endif
+#if CONFIG_DVB_OR51132
 	case CX88_BOARD_PCHDTV_HD3000:
 		dev->dvb.frontend = or51132_attach(&pchdtv_hd3000,
 						 &dev->core->i2c_adap);
 		break;
 #endif
-#if HAVE_LGDT3302
+#if CONFIG_DVB_LGDT3302
 	case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q:
 		dev->ts_gen_cntrl = 0x08;
 		{
diff -u linux-2.6.13/drivers/media/video/cx88/cx88-blackbird.c linux/drivers/media/video/cx88/cx88-blackbird.c
--- linux-2.6.13/drivers/media/video/cx88/cx88-blackbird.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/cx88/cx88-blackbird.c	2005-07-07 18:44:17.000000000 -0300
@@ -690,11 +690,9 @@
 	int bitrate_mode = 1;
 	int bitrate = 7500000;
 	int bitrate_peak = 7500000;
-#if 1
 	bitrate_mode = BLACKBIRD_VIDEO_CBR;
 	bitrate = 4000*1024;
 	bitrate_peak = 4000*1024;
-#endif
 
 	/* assign stream type */
 	blackbird_api_cmd(dev, BLACKBIRD_API_SET_STREAM_TYPE, 1, 0, BLACKBIRD_STREAM_PROGRAM);
@@ -810,9 +808,6 @@
 	cx_write(MO_VBOS_CONTROL, 0x84A00); /* no 656 mode, 8-bit pixels, disable VBI */
 	cx_clear(MO_OUTPUT_FORMAT, 0x0008); /* Normal Y-limits to let the mpeg encoder sync */
 
-#if 0 /* FIXME */
-	set_scale(dev, 720, 480, V4L2_FIELD_INTERLACED);
-#endif
 	blackbird_codec_settings(dev);
 	msleep(1);
 

--------------080909020603090306000105--
