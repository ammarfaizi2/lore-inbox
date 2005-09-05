Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932683AbVIEVoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbVIEVoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVIEVoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:44:15 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:24914 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932684AbVIEVn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:43:59 -0400
Date: Mon, 05 Sep 2005 18:26:14 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 03/24] V4L: CX88 updates and card additions
Message-ID: <431cb7f6.s1eUf453vQ9qg7jl%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_431cb7f6.3NIzBq//K4Jutu/EC3ksBZzq52vSlQGeUFaJtrE06FyAiVns"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_431cb7f6.3NIzBq//K4Jutu/EC3ksBZzq52vSlQGeUFaJtrE06FyAiVns
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

.

--=_431cb7f6.3NIzBq//K4Jutu/EC3ksBZzq52vSlQGeUFaJtrE06FyAiVns
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v4l-03-cx88-update.diff"

- Remove $Id CVS logs for V4L files
- add ioctl indirection via cx88_ioctl_hook and cx88_ioctl_translator to 
  cx88-blackbird.c.
- declare the indirection hooks from cx88-blackbird.c.
- dcprintk macro which uses core instead of dev->core on cx88-video.c.
- replace dev->core occurances with core on cx88-video.c.
- CodingStyle fixes.
- MaxInput replaced by a define.
- cx8801 structures moved from cx88.h.
- The output_mode needs to be set for the Hauppauge Nova-T DVB-T
  for versions after 2.6.12.
- Corrected GPIO values for cx88 cards #28 & #31 for s-video and composite.
- Updated DViCO FusionHDTV5 Gold & added DVB support.
- Fixed DViCO FusionHDTV 3 Gold-Q GPIO.
- Some clean up in cx88-tvaudio.c
- replaced hex values when writing to AUD_CTL to EN_xx for better reading.
- Allow select by hand between Mono, Lang1, Lang2 and Stereo for BTSC.
- Support for stereo NICAM and BTSC improved.
- Broken stereo check removed.
- Added support for remote control to Cinergy DVBT-1400.
- local var renamed from rc5 to a better name (ircode).
- LGDT330X QAM lock bug fixes.
- Some reorg: move some bits to struct cx88_core, factor out common ioctl's
  to cx88_do_ioctl.
- Get rid of '//' comments, replace them with #if 0 and /**/.
- Minor clean-ups: remove dcprintk and replace all instances of "dev->core"
  with "core".
- Added some registers to control PCI controller at CX2388x chips.
- New tuner standby API.
- Small mpeg fixes and cleanups for blackbird.
- fix mpeg packet size & count
- add VIDIOC_QUERYCAP ioctl for the mpeg stream
- return more information in struct v4l2_format
- fix default window height
- small cleanups

Signed-off-by: Uli Luckas <luckas@musoft.de>
Signed-off-by: Torsten Seeboth <Torsten.Seeboth@t-online.de>
Signed-off-by: Nickolay V. Shmyrev <nshmyrev@yandex.ru>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Patrick Boettcher <patrick.boettcher@desy.de>
Signed-off-by: Catalin Climov <catalin@climov.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 cx88-blackbird.c |   73 ++++-
 cx88-cards.c     |   24 -
 cx88-core.c      |   21 +
 cx88-dvb.c       |   47 +++
 cx88-i2c.c       |    1 
 cx88-input.c     |   94 ++++++
 cx88-mpeg.c      |   17 -
 cx88-reg.h       |   24 +
 cx88-tvaudio.c   |  756 ++++++++++++++++++++++++++++---------------------------
 cx88-vbi.c       |    1 
 cx88-video.c     |  388 +++++++++++++++-------------
 cx88.h           |   39 +-
 12 files changed, 880 insertions(+), 605 deletions(-)

diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-blackbird.c linux-2.6.13/drivers/media/video/cx88/cx88-blackbird.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-blackbird.c	2005-09-05 11:41:05.677507613 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-blackbird.c	2005-09-05 11:49:51.573205948 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-blackbird.c,v 1.27 2005/06/03 13:31:50 mchehab Exp $
  *
  *  Support for a cx23416 mpeg encoder via cx2388x host port.
  *  "blackbird" reference design.
@@ -62,7 +61,6 @@ static LIST_HEAD(cx8802_devlist);
 #define IVTV_CMD_HW_BLOCKS_RST 0xFFFFFFFF
 
 /* Firmware API commands */
-/* #define IVTV_API_STD_TIMEOUT 0x00010000 // 65536, units?? */
 #define IVTV_API_STD_TIMEOUT 500
 
 #define BLACKBIRD_API_PING               0x80
@@ -696,7 +694,6 @@ static void blackbird_codec_settings(str
 
 	/* assign stream type */
 	blackbird_api_cmd(dev, BLACKBIRD_API_SET_STREAM_TYPE, 1, 0, BLACKBIRD_STREAM_PROGRAM);
-	/* blackbird_api_cmd(dev, BLACKBIRD_API_SET_STREAM_TYPE, 1, 0, BLACKBIRD_STREAM_TRANSPORT); */
 
 	/* assign output port */
 	blackbird_api_cmd(dev, BLACKBIRD_API_SET_OUTPUT_PORT, 1, 0, BLACKBIRD_OUTPUT_PORT_STREAMING); /* Host */
@@ -824,7 +821,8 @@ static int blackbird_initialize_codec(st
 			BLACKBIRD_CUSTOM_EXTENSION_USR_DATA,
 			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
 
-	blackbird_api_cmd(dev, BLACKBIRD_API_INIT_VIDEO_INPUT, 0, 0); /* initialize the video input */
+	/* initialize the video input */
+	blackbird_api_cmd(dev, BLACKBIRD_API_INIT_VIDEO_INPUT, 0, 0);
 
 	msleep(1);
 
@@ -833,11 +831,12 @@ static int blackbird_initialize_codec(st
 	blackbird_api_cmd(dev, BLACKBIRD_API_MUTE_AUDIO, 1, 0, BLACKBIRD_UNMUTE);
 	msleep(1);
 
-	/* blackbird_api_cmd(dev, BLACKBIRD_API_BEGIN_CAPTURE, 2, 0, 0, 0x13); // start capturing to the host interface */
+	/* start capturing to the host interface */
+	/* blackbird_api_cmd(dev, BLACKBIRD_API_BEGIN_CAPTURE, 2, 0, 0, 0x13); */
 	blackbird_api_cmd(dev, BLACKBIRD_API_BEGIN_CAPTURE, 2, 0,
 			BLACKBIRD_MPEG_CAPTURE,
 			BLACKBIRD_RAW_BITS_NONE
-		); /* start capturing to the host interface */
+		);
 	msleep(10);
 
 	blackbird_api_cmd(dev, BLACKBIRD_API_REFRESH_INPUT, 0,0);
@@ -851,8 +850,8 @@ static int bb_buf_setup(struct videobuf_
 {
 	struct cx8802_fh *fh = q->priv_data;
 
-	fh->dev->ts_packet_size  = 512;
-	fh->dev->ts_packet_count = 100;
+	fh->dev->ts_packet_size  = 188 * 4; /* was: 512 */
+	fh->dev->ts_packet_count = 32; /* was: 100 */
 
 	*size = fh->dev->ts_packet_size * fh->dev->ts_packet_count;
 	if (0 == *count)
@@ -900,12 +899,36 @@ static int mpeg_do_ioctl(struct inode *i
 {
 	struct cx8802_fh  *fh  = file->private_data;
 	struct cx8802_dev *dev = fh->dev;
+	struct cx88_core  *core = dev->core;
 
 	if (debug > 1)
-		cx88_print_ioctl(dev->core->name,cmd);
+		cx88_print_ioctl(core->name,cmd);
 
 	switch (cmd) {
 
+	/* --- capabilities ------------------------------------------ */
+	case VIDIOC_QUERYCAP:
+	{
+		struct v4l2_capability *cap = arg;
+
+		memset(cap,0,sizeof(*cap));
+		strcpy(cap->driver, "cx88_blackbird");
+		strlcpy(cap->card, cx88_boards[core->board].name,sizeof(cap->card));
+		sprintf(cap->bus_info,"PCI:%s",pci_name(dev->pci));
+		cap->version = CX88_VERSION_CODE;
+		cap->capabilities =
+			V4L2_CAP_VIDEO_CAPTURE |
+			V4L2_CAP_READWRITE     |
+			V4L2_CAP_STREAMING     |
+			V4L2_CAP_VBI_CAPTURE   |
+			V4L2_CAP_VIDEO_OVERLAY |
+			0;
+		if (UNSET != core->tuner_type)
+			cap->capabilities |= V4L2_CAP_TUNER;
+
+		return 0;
+	}
+
 	/* --- capture ioctls ---------------------------------------- */
 	case VIDIOC_ENUM_FMT:
 	{
@@ -935,7 +958,11 @@ static int mpeg_do_ioctl(struct inode *i
 		f->fmt.pix.width        = dev->width;
 		f->fmt.pix.height       = dev->height;
 		f->fmt.pix.pixelformat  = V4L2_PIX_FMT_MPEG;
-		f->fmt.pix.sizeimage    = 1024 * 512 /* FIXME: BUFFER_SIZE */;
+		f->fmt.pix.field        = V4L2_FIELD_NONE;
+		f->fmt.pix.bytesperline = 0;
+		f->fmt.pix.sizeimage    = 188 * 4 * 1024; /* 1024 * 512 */ /* FIXME: BUFFER_SIZE */;
+		f->fmt.pix.colorspace   = 0;
+		return 0;
 	}
 
 	/* --- streaming capture ------------------------------------- */
@@ -959,15 +986,25 @@ static int mpeg_do_ioctl(struct inode *i
 		return videobuf_streamoff(&fh->mpegq);
 
 	default:
-		return -EINVAL;
+		return cx88_do_ioctl( inode, file, 0, dev->core, cmd, arg, cx88_ioctl_hook );
 	}
 	return 0;
 }
 
+int (*cx88_ioctl_hook)(struct inode *inode, struct file *file,
+			unsigned int cmd, void *arg);
+unsigned int (*cx88_ioctl_translator)(unsigned int cmd);
+
+static unsigned int mpeg_translate_ioctl(unsigned int cmd)
+{
+	return cmd;
+}
+
 static int mpeg_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg)
+			unsigned int cmd, unsigned long arg)
 {
-	return video_usercopy(inode, file, cmd, arg, mpeg_do_ioctl);
+	cmd = cx88_ioctl_translator( cmd );
+	return video_usercopy(inode, file, cmd, arg, cx88_ioctl_hook);
 }
 
 static int mpeg_open(struct inode *inode, struct file *file)
@@ -1135,7 +1172,7 @@ static int __devinit blackbird_probe(str
 	dev->pci = pci_dev;
 	dev->core = core;
 	dev->width = 720;
-	dev->height = 480;
+	dev->height = 576;
 
 	err = cx8802_init_common(dev);
 	if (0 != err)
@@ -1148,6 +1185,9 @@ static int __devinit blackbird_probe(str
 
 	list_add_tail(&dev->devlist,&cx8802_devlist);
 	blackbird_register_video(dev);
+
+	/* initial device configuration: needed ? */
+
 	return 0;
 
  fail_free:
@@ -1202,6 +1242,8 @@ static int blackbird_init(void)
 	printk(KERN_INFO "cx2388x: snapshot date %04d-%02d-%02d\n",
 	       SNAPSHOT/10000, (SNAPSHOT/100)%100, SNAPSHOT%100);
 #endif
+	cx88_ioctl_hook = mpeg_do_ioctl;
+	cx88_ioctl_translator = mpeg_translate_ioctl;
 	return pci_register_driver(&blackbird_pci_driver);
 }
 
@@ -1213,6 +1255,9 @@ static void blackbird_fini(void)
 module_init(blackbird_init);
 module_exit(blackbird_fini);
 
+EXPORT_SYMBOL(cx88_ioctl_hook);
+EXPORT_SYMBOL(cx88_ioctl_translator);
+
 /* ----------------------------------------------------------- */
 /*
  * Local variables:
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-cards.c linux-2.6.13/drivers/media/video/cx88/cx88-cards.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-cards.c	2005-09-05 11:41:05.678507240 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-cards.c	2005-09-05 11:49:21.535418550 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-cards.c,v 1.90 2005/07/28 02:47:42 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * card-specific stuff.
@@ -499,9 +498,6 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
                         .type   = CX88_VMUX_DVB,
                         .vmux   = 0,
-		},{
-			.type   = CX88_VMUX_SVIDEO,
-			.vmux   = 2,
                 }},
 		.dvb            = 1,
 	},
@@ -614,12 +610,12 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-			.gpio0  = 0xed12,  // internal decoder
+			.gpio0  = 0xed12,  /* internal decoder */
 			.gpio2  = 0x00ff,
 		},{
 			.type   = CX88_VMUX_DEBUG,
 			.vmux   = 0,
-			.gpio0  = 0xff01,  // mono from tuner chip
+			.gpio0  = 0xff01,  /* mono from tuner chip */
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
@@ -715,19 +711,18 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		/*  See DViCO FusionHDTV 3 Gold-Q for GPIO documentation.  */
 		.input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
-                        .gpio0  = 0x0f0d,
+                        .gpio0  = 0x97ed,
                 },{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
-                        .gpio0  = 0x0f00,
+                        .gpio0  = 0x97e9,
                 },{
                         .type   = CX88_VMUX_SVIDEO,
                         .vmux   = 2,
-                        .gpio0  = 0x0f00,
+                        .gpio0  = 0x97e9,
                 }},
 		.dvb            = 1,
         },
@@ -765,20 +760,21 @@ struct cx88_board cx88_boards[] = {
 		.radio_type     = UNSET,
 		.tuner_addr	= ADDR_UNSET,
 		.radio_addr	= ADDR_UNSET,
-		/*  See DViCO FusionHDTV 3 Gold-Q for GPIO documentation.  */
+		.tda9887_conf   = TDA9887_PRESENT,
 		.input          = {{
                         .type   = CX88_VMUX_TELEVISION,
                         .vmux   = 0,
-                        .gpio0  = 0x0f0d,
+                        .gpio0  = 0x87fd,
                 },{
                         .type   = CX88_VMUX_COMPOSITE1,
                         .vmux   = 1,
-                        .gpio0  = 0x0f00,
+                        .gpio0  = 0x87f9,
                 },{
                         .type   = CX88_VMUX_SVIDEO,
                         .vmux   = 2,
-                        .gpio0  = 0x0f00,
+                        .gpio0  = 0x87f9,
                 }},
+		.dvb            = 1,
 	},
 };
 const unsigned int cx88_bcount = ARRAY_SIZE(cx88_boards);
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-core.c linux-2.6.13/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-core.c	2005-09-05 11:41:05.677507613 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-core.c	2005-09-05 11:49:51.569207441 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-core.c,v 1.33 2005/07/07 14:17:47 mchehab Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * driver core
@@ -876,7 +875,7 @@ static int set_tvaudio(struct cx88_core 
 
 	cx_andor(MO_AFECFG_IO, 0x1f, 0x0);
 	cx88_set_tvaudio(core);
-	// cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO);
+	/* cx88_set_stereo(dev,V4L2_TUNER_MODE_STEREO); */
 
 	cx_write(MO_AUDD_LNGTH,    128); /* fifo size */
 	cx_write(MO_AUDR_LNGTH,    128); /* fifo size */
@@ -1087,10 +1086,17 @@ struct cx88_core* cx88_core_get(struct p
 	core->pci_bus  = pci->bus->number;
 	core->pci_slot = PCI_SLOT(pci->devfn);
 	core->pci_irqmask = 0x00fc00;
+	init_MUTEX(&core->lock);
 
 	core->nr = cx88_devcount++;
 	sprintf(core->name,"cx88[%d]",core->nr);
 	if (0 != get_ressources(core,pci)) {
+		printk(KERN_ERR "CORE %s No more PCI ressources for "
+			"subsystem: %04x:%04x, board: %s\n",
+			core->name,pci->subsystem_vendor,
+			pci->subsystem_device,
+			cx88_boards[core->board].name);
+
 		cx88_devcount--;
 		goto fail_free;
 	}
@@ -1114,11 +1120,11 @@ struct cx88_core* cx88_core_get(struct p
 		core->board = CX88_BOARD_UNKNOWN;
 		cx88_card_list(core,pci);
 	}
-        printk(KERN_INFO "%s: subsystem: %04x:%04x, board: %s [card=%d,%s]\n",
-	       core->name,pci->subsystem_vendor,
-	       pci->subsystem_device,cx88_boards[core->board].name,
-	       core->board, card[core->nr] == core->board ?
-	       "insmod option" : "autodetected");
+	printk(KERN_INFO "CORE %s: subsystem: %04x:%04x, board: %s [card=%d,%s]\n",
+		core->name,pci->subsystem_vendor,
+		pci->subsystem_device,cx88_boards[core->board].name,
+		core->board, card[core->nr] == core->board ?
+		"insmod option" : "autodetected");
 
 	core->tuner_type = tuner[core->nr];
 	core->radio_type = radio[core->nr];
@@ -1202,4 +1208,5 @@ EXPORT_SYMBOL(cx88_core_put);
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-dvb.c linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-dvb.c	2005-09-05 11:41:05.677507613 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-dvb.c	2005-09-05 11:49:51.573205948 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-dvb.c,v 1.58 2005/08/07 09:24:08 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * MPEG Transport Stream (DVB) routines
@@ -31,6 +30,7 @@
 #include <linux/suspend.h>
 #include <linux/config.h>
 
+
 #include "cx88.h"
 #include "dvb-pll.h"
 
@@ -210,16 +210,26 @@ static struct or51132_config pchdtv_hd30
 static int lgdt330x_pll_set(struct dvb_frontend* fe,
 			    struct dvb_frontend_parameters* params)
 {
+	/* FIXME make this routine use the tuner-simple code.
+	 * It could probably be shared with a number of ATSC
+	 * frontends. Many share the same tuner with analog TV. */
+
 	struct cx8802_dev *dev= fe->dvb->priv;
+	struct cx88_core *core = dev->core;
 	u8 buf[4];
 	struct i2c_msg msg =
 		{ .addr = dev->core->pll_addr, .flags = 0, .buf = buf, .len = 4 };
 	int err;
 
-	dvb_pll_configure(dev->core->pll_desc, buf, params->frequency, 0);
+	/* Put the analog decoder in standby to keep it quiet */
+	if (core->tda9887_conf) {
+		cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
+	}
+
+	dvb_pll_configure(core->pll_desc, buf, params->frequency, 0);
 	dprintk(1, "%s: tuner at 0x%02x bytes: 0x%02x 0x%02x 0x%02x 0x%02x\n",
 			__FUNCTION__, msg.addr, buf[0],buf[1],buf[2],buf[3]);
-	if ((err = i2c_transfer(&dev->core->i2c_adap, &msg, 1)) != 1) {
+	if ((err = i2c_transfer(&core->i2c_adap, &msg, 1)) != 1) {
 		printk(KERN_WARNING "cx88-dvb: %s error "
 			   "(addr %02x <- %02x, err = %i)\n",
 			   __FUNCTION__, buf[0], buf[1], err);
@@ -228,6 +238,13 @@ static int lgdt330x_pll_set(struct dvb_f
 		else
 			return -EREMOTEIO;
 	}
+	if (core->tuner_type == TUNER_LG_TDVS_H062F) {
+		/* Set the Auxiliary Byte. */
+		buf[2] &= ~0x20;
+		buf[2] |= 0x18;
+		buf[3] = 0x50;
+		i2c_transfer(&core->i2c_adap, &msg, 1);
+	}
 	return 0;
 }
 
@@ -261,6 +278,14 @@ static struct lgdt330x_config fusionhdtv
 	.pll_set          = lgdt330x_pll_set,
 	.set_ts_params    = lgdt330x_set_ts_param,
 };
+
+static struct lgdt330x_config fusionhdtv_5_gold = {
+	.demod_address    = 0x0e,
+	.demod_chip       = LGDT3303,
+	.serial_mpeg      = 0x40, /* TPSERIAL for 3303 in TOP_CONTROL */
+	.pll_set          = lgdt330x_pll_set,
+	.set_ts_params    = lgdt330x_set_ts_param,
+};
 #endif
 
 static int dvb_register(struct cx8802_dev *dev)
@@ -346,6 +371,22 @@ static int dvb_register(struct cx8802_de
 						    &dev->core->i2c_adap);
 		}
 		break;
+	case CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD:
+		dev->ts_gen_cntrl = 0x08;
+		{
+		/* Do a hardware reset of chip before using it. */
+		struct cx88_core *core = dev->core;
+
+		cx_clear(MO_GP0_IO, 1);
+		mdelay(100);
+		cx_set(MO_GP0_IO, 1);
+		mdelay(200);
+		dev->core->pll_addr = 0x61;
+		dev->core->pll_desc = &dvb_pll_tdvs_tua6034;
+		dev->dvb.frontend = lgdt330x_attach(&fusionhdtv_5_gold,
+						    &dev->core->i2c_adap);
+		}
+		break;
 #endif
 	default:
 		printk("%s: The frontend of your DVB/ATSC card isn't supported yet\n",
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88.h linux-2.6.13/drivers/media/video/cx88/cx88.h
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88.h	2005-09-05 11:41:05.678507240 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88.h	2005-09-05 11:49:51.568207814 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88.h,v 1.70 2005/07/24 17:44:09 mkrufky Exp $
  *
  * v4l2 device driver for cx2388x based TV cards
  *
@@ -48,6 +47,9 @@
 
 #define CX88_MAXBOARDS 8
 
+/* Max number of inputs by card */
+#define MAX_CX88_INPUT 8
+
 /* ----------------------------------------------------------- */
 /* defines and enums                                           */
 
@@ -199,7 +201,7 @@ struct cx88_board {
 	unsigned char		tuner_addr;
 	unsigned char		radio_addr;
 	int                     tda9887_conf;
-	struct cx88_input       input[8];
+	struct cx88_input       input[MAX_CX88_INPUT];
 	struct cx88_input       radio;
 	int                     blackbird:1;
 	int                     dvb:1;
@@ -288,6 +290,11 @@ struct cx88_core {
 
 	/* IR remote control state */
 	struct cx88_IR             *ir;
+
+	struct semaphore           lock;
+
+	/* various v4l controls */
+	u32                        freq;
 };
 
 struct cx8800_dev;
@@ -323,8 +330,7 @@ struct cx8800_suspend_state {
 struct cx8800_dev {
 	struct cx88_core           *core;
 	struct list_head           devlist;
-        struct semaphore           lock;
-       	spinlock_t                 slock;
+	spinlock_t                 slock;
 
 	/* various device info */
 	unsigned int               resources;
@@ -342,7 +348,6 @@ struct cx8800_dev {
 	struct cx88_dmaqueue       vbiq;
 
 	/* various v4l controls */
-	u32                        freq;
 
 	/* other global state info */
 	struct cx8800_suspend_state state;
@@ -350,14 +355,8 @@ struct cx8800_dev {
 
 /* ----------------------------------------------------------- */
 /* function 1: audio/alsa stuff                                */
+/* =============> moved to cx88-alsa.c <====================== */
 
-struct cx8801_dev {
-	struct cx88_core           *core;
-
-	/* pci i/o */
-	struct pci_dev             *pci;
-	unsigned char              pci_rev,pci_lat;
-};
 
 /* ----------------------------------------------------------- */
 /* function 2: mpeg stuff                                      */
@@ -373,8 +372,7 @@ struct cx8802_suspend_state {
 
 struct cx8802_dev {
 	struct cx88_core           *core;
-        struct semaphore           lock;
-       	spinlock_t                 slock;
+	spinlock_t                 slock;
 
 	/* pci i/o */
 	struct pci_dev             *pci;
@@ -553,8 +551,21 @@ void cx8802_fini_common(struct cx8802_de
 int cx8802_suspend_common(struct pci_dev *pci_dev, pm_message_t state);
 int cx8802_resume_common(struct pci_dev *pci_dev);
 
+/* ----------------------------------------------------------- */
+/* cx88-video.c                                                */
+extern int cx88_do_ioctl(struct inode *inode, struct file *file, int radio,
+				struct cx88_core *core, unsigned int cmd,
+				void *arg, v4l2_kioctl driver_ioctl);
+
+/* ----------------------------------------------------------- */
+/* cx88-blackbird.c                                            */
+extern int (*cx88_ioctl_hook)(struct inode *inode, struct file *file,
+				unsigned int cmd, void *arg);
+extern unsigned int (*cx88_ioctl_translator)(unsigned int cmd);
+
 /*
  * Local variables:
  * c-basic-offset: 8
  * End:
+ * kate: eol "unix"; indent-width 3; remove-trailing-space on; replace-trailing-space-save on; tab-width 8; replace-tabs off; space-indent off; mixed-indent off
  */
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-i2c.c linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-i2c.c	2005-09-05 11:41:05.679506867 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-i2c.c	2005-09-05 11:49:08.287363813 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: cx88-i2c.c,v 1.30 2005/07/25 05:10:13 mkrufky Exp $
 
     cx88-i2c.c  --  all the i2c code is here
 
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-input.c linux-2.6.13/drivers/media/video/cx88/cx88-input.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-input.c	2005-09-05 11:41:05.678507240 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-input.c	2005-09-05 11:49:21.539417057 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-input.c,v 1.15 2005/07/07 13:58:38 mchehab Exp $
  *
  * Device driver for GPIO attached remote control interfaces
  * on Conexant 2388x based TV/DVB cards.
@@ -212,6 +211,53 @@ static IR_KEYTAB_TYPE ir_codes_msi_tvany
 
 /* ---------------------------------------------------------------------- */
 
+/* Cinergy 1400 DVB-T */
+static IR_KEYTAB_TYPE ir_codes_cinergy_1400[IR_KEYTAB_SIZE] = {
+	[0x01] = KEY_POWER,
+	[0x02] = KEY_1,
+	[0x03] = KEY_2,
+	[0x04] = KEY_3,
+	[0x05] = KEY_4,
+	[0x06] = KEY_5,
+	[0x07] = KEY_6,
+	[0x08] = KEY_7,
+	[0x09] = KEY_8,
+	[0x0a] = KEY_9,
+	[0x0c] = KEY_0,
+
+	[0x0b] = KEY_VIDEO,
+	[0x0d] = KEY_REFRESH,
+	[0x0e] = KEY_SELECT,
+	[0x0f] = KEY_EPG,
+	[0x10] = KEY_UP,
+	[0x11] = KEY_LEFT,
+	[0x12] = KEY_OK,
+	[0x13] = KEY_RIGHT,
+	[0x14] = KEY_DOWN,
+	[0x15] = KEY_TEXT,
+	[0x16] = KEY_INFO,
+
+	[0x17] = KEY_RED,
+	[0x18] = KEY_GREEN,
+	[0x19] = KEY_YELLOW,
+	[0x1a] = KEY_BLUE,
+
+	[0x1b] = KEY_CHANNELUP,
+	[0x1c] = KEY_VOLUMEUP,
+	[0x1d] = KEY_MUTE,
+	[0x1e] = KEY_VOLUMEDOWN,
+	[0x1f] = KEY_CHANNELDOWN,
+
+	[0x40] = KEY_PAUSE,
+	[0x4c] = KEY_PLAY,
+	[0x58] = KEY_RECORD,
+	[0x54] = KEY_PREVIOUS,
+	[0x48] = KEY_STOP,
+	[0x5c] = KEY_NEXT,
+};
+
+/* ---------------------------------------------------------------------- */
+
 struct cx88_IR {
 	struct cx88_core *core;
 	struct input_dev input;
@@ -329,6 +375,11 @@ int cx88_ir_init(struct cx88_core *core,
 		ir->mask_keyup = 0x60;
 		ir->polling = 50; /* ms */
 		break;
+	case CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1:
+		ir_codes = ir_codes_cinergy_1400;
+		ir_type = IR_TYPE_PD;
+		ir->sampling = 1;
+		break;
 	case CX88_BOARD_HAUPPAUGE:
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
 		ir_codes = ir_codes_hauppauge_new;
@@ -445,7 +496,7 @@ int cx88_ir_fini(struct cx88_core *core)
 void cx88_ir_irq(struct cx88_core *core)
 {
 	struct cx88_IR *ir = core->ir;
-	u32 samples, rc5;
+	u32 samples, ircode;
 	int i;
 
 	if (NULL == ir)
@@ -477,13 +528,44 @@ void cx88_ir_irq(struct cx88_core *core)
 
 	/* decode it */
 	switch (core->board) {
+	case CX88_BOARD_TERRATEC_CINERGY_1400_DVB_T1:
+		ircode = ir_decode_pulsedistance(ir->samples, ir->scount, 1, 4);
+
+		if (ircode == 0xffffffff) { /* decoding error */
+			ir_dprintk("pulse distance decoding error\n");
+			break;
+		}
+
+		ir_dprintk("pulse distance decoded: %x\n", ircode);
+
+		if (ircode == 0) { /* key still pressed */
+			ir_dprintk("pulse distance decoded repeat code\n");
+			ir->release = jiffies + msecs_to_jiffies(120);
+			break;
+		}
+
+		if ((ircode & 0xffff) != 0xeb04) { /* wrong address */
+			ir_dprintk("pulse distance decoded wrong address\n");
+ 			break;
+		}
+
+		if (((~ircode >> 24) & 0xff) != ((ircode >> 16) & 0xff)) { /* wrong checksum */
+			ir_dprintk("pulse distance decoded wrong check sum\n");
+			break;
+		}
+
+		ir_dprintk("Key Code: %x\n", (ircode >> 16) & 0x7f);
+
+		ir_input_keydown(&ir->input, &ir->ir, (ircode >> 16) & 0x7f, (ircode >> 16) & 0xff);
+		ir->release = jiffies + msecs_to_jiffies(120);
+		break;
 	case CX88_BOARD_HAUPPAUGE:
 	case CX88_BOARD_HAUPPAUGE_DVB_T1:
-		rc5 = ir_decode_biphase(ir->samples, ir->scount, 5, 7);
-		ir_dprintk("biphase decoded: %x\n", rc5);
-		if ((rc5 & 0xfffff000) != 0x3000)
+		ircode = ir_decode_biphase(ir->samples, ir->scount, 5, 7);
+		ir_dprintk("biphase decoded: %x\n", ircode);
+		if ((ircode & 0xfffff000) != 0x3000)
 			break;
-		ir_input_keydown(&ir->input, &ir->ir, rc5 & 0x3f, rc5);
+		ir_input_keydown(&ir->input, &ir->ir, ircode & 0x3f, ircode);
 		ir->release = jiffies + msecs_to_jiffies(120);
 		break;
 	}
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-mpeg.c linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-mpeg.c	2005-09-05 11:41:05.678507240 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-mpeg.c	2005-09-05 11:49:51.572206322 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-mpeg.c,v 1.31 2005/07/07 14:17:47 mchehab Exp $
  *
  *  Support for the mpeg transport stream transfers
  *  PCI function #2 of the cx2388x.
@@ -73,11 +72,15 @@ static int cx8802_start_dma(struct cx880
 		udelay(100);
 		cx_write(MO_PINMUX_IO, 0x00);
 		cx_write(TS_HW_SOP_CNTRL,0x47<<16|188<<4|0x01);
-		if ((core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q) ||
-		    (core->board == CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T)) {
+		switch (core->board) {
+		case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_Q:
+		case CX88_BOARD_DVICO_FUSIONHDTV_3_GOLD_T:
+		case CX88_BOARD_DVICO_FUSIONHDTV_5_GOLD:
 			cx_write(TS_SOP_STAT, 1<<13);
-		} else {
+			break;
+		default:
 			cx_write(TS_SOP_STAT, 0x00);
+			break;
 		}
 		cx_write(TS_GEN_CNTRL, dev->ts_gen_cntrl);
 		udelay(100);
@@ -86,12 +89,10 @@ static int cx8802_start_dma(struct cx880
 	if (cx88_boards[core->board].blackbird) {
 		cx_write(MO_PINMUX_IO, 0x88); /* enable MPEG parallel IO */
 
-		// cx_write(TS_F2_CMD_STAT_MM, 0x2900106); /* F2_CMD_STAT_MM defaults + master + memory space */
 		cx_write(TS_GEN_CNTRL, 0x46); /* punctured clock TS & posedge driven & software reset */
 		udelay(100);
 
 		cx_write(TS_HW_SOP_CNTRL, 0x408); /* mpeg start byte */
-		//cx_write(TS_HW_SOP_CNTRL, 0x2F0BC0); /* mpeg start byte ts: 0x2F0BC0 ? */
 		cx_write(TS_VALERR_CNTRL, 0x2000);
 
 		cx_write(TS_GEN_CNTRL, 0x06); /* punctured clock TS & posedge driven */
@@ -106,7 +107,6 @@ static int cx8802_start_dma(struct cx880
 	dprintk( 0, "setting the interrupt mask\n" );
 	cx_set(MO_PCI_INTMSK, core->pci_irqmask | 0x04);
 	cx_set(MO_TS_INTMSK,  0x1f0011);
-	//cx_write(MO_TS_INTMSK,  0x0f0011);
 
 	/* start dma */
 	cx_set(MO_DEV_CNTRL2, (1<<5));
@@ -206,7 +206,6 @@ void cx8802_buf_queue(struct cx8802_dev 
 		mod_timer(&q->timeout, jiffies+BUFFER_TIMEOUT);
 		dprintk(0,"[%p/%d] %s - first active\n",
 			buf, buf->vb.i, __FUNCTION__);
-		//udelay(100);
 
 	} else {
 		dprintk( 1, "queue is not empty - append to active\n" );
@@ -217,7 +216,6 @@ void cx8802_buf_queue(struct cx8802_dev 
 		prev->risc.jmp[1] = cpu_to_le32(buf->risc.dma);
 		dprintk( 1, "[%p/%d] %s - append to active\n",
 			buf, buf->vb.i, __FUNCTION__);
-		//udelay(100);
 	}
 }
 
@@ -387,7 +385,6 @@ int cx8802_init_common(struct cx8802_dev
 	       dev->pci_lat,pci_resource_start(dev->pci,0));
 
 	/* initialize driver struct */
-        init_MUTEX(&dev->lock);
 	spin_lock_init(&dev->slock);
 
 	/* init dma queue */
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-reg.h linux-2.6.13/drivers/media/video/cx88/cx88-reg.h
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-reg.h	2005-09-05 11:41:05.679506867 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-reg.h	2005-09-05 11:49:51.569207441 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: cx88-reg.h,v 1.8 2005/07/07 13:58:38 mchehab Exp $
 
     cx88x-hw.h - CX2388x register offsets
 
@@ -40,6 +39,29 @@
 #define CX88X_EN_TBFX 0x02
 #define CX88X_EN_VSFX 0x04
 
+/* ---------------------------------------------------------------------- */
+/* PCI controller registers                                               */
+
+/* Command and Status Register */
+#define F0_CMD_STAT_MM      0x2f0004
+#define F1_CMD_STAT_MM      0x2f0104
+#define F2_CMD_STAT_MM      0x2f0204
+#define F3_CMD_STAT_MM      0x2f0304
+#define F4_CMD_STAT_MM      0x2f0404
+
+/* Device Control #1 */
+#define F0_DEV_CNTRL1_MM    0x2f0040
+#define F1_DEV_CNTRL1_MM    0x2f0140
+#define F2_DEV_CNTRL1_MM    0x2f0240
+#define F3_DEV_CNTRL1_MM    0x2f0340
+#define F4_DEV_CNTRL1_MM    0x2f0440
+
+/* Device Control #1 */
+#define F0_BAR0_MM          0x2f0010
+#define F1_BAR0_MM          0x2f0110
+#define F2_BAR0_MM          0x2f0210
+#define F3_BAR0_MM          0x2f0310
+#define F4_BAR0_MM          0x2f0410
 
 /* ---------------------------------------------------------------------- */
 /* DMA Controller registers                                               */
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-tvaudio.c linux-2.6.13/drivers/media/video/cx88/cx88-tvaudio.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-tvaudio.c	2005-09-05 11:41:05.677507613 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-tvaudio.c	2005-09-05 11:49:51.570207068 -0500
@@ -1,5 +1,4 @@
 /*
-    $Id: cx88-tvaudio.c,v 1.37 2005/07/07 13:58:38 mchehab Exp $
 
     cx88x-audio.c - Conexant CX23880/23881 audio downstream driver driver
 
@@ -121,25 +120,19 @@ static void set_audio_registers(struct c
 }
 
 static void set_audio_start(struct cx88_core *core,
-			    u32 mode, u32 ctl)
+			u32 mode)
 {
 	// mute
 	cx_write(AUD_VOL_CTL,       (1 << 6));
 
-	//  increase level of input by 12dB
-//	cx_write(AUD_AFE_12DB_EN,   0x0001);
-	cx_write(AUD_AFE_12DB_EN,   0x0000);
-
 	// start programming
 	cx_write(AUD_CTL,           0x0000);
 	cx_write(AUD_INIT,          mode);
 	cx_write(AUD_INIT_LD,       0x0001);
 	cx_write(AUD_SOFT_RESET,    0x0001);
-
-	cx_write(AUD_CTL,           ctl);
 }
 
-static void set_audio_finish(struct cx88_core *core)
+static void set_audio_finish(struct cx88_core *core, u32 ctl)
 {
 	u32 volume;
 
@@ -154,25 +147,25 @@ static void set_audio_finish(struct cx88
 		cx_write(AUD_I2SOUTPUTCNTL, 1);
 		cx_write(AUD_I2SCNTL, 0);
 		//cx_write(AUD_APB_IN_RATE_ADJ, 0);
+	} else {
+	ctl |= EN_DAC_ENABLE;
+	cx_write(AUD_CTL, ctl);
 	}
 
-	// finish programming
+	/* finish programming */
 	cx_write(AUD_SOFT_RESET, 0x0000);
 
-	// start audio processing
-	cx_set(AUD_CTL, EN_DAC_ENABLE);
-
-	// unmute
+	/* unmute */
 	volume = cx_sread(SHADOW_AUD_VOL_CTL);
 	cx_swrite(SHADOW_AUD_VOL_CTL, AUD_VOL_CTL, volume);
 }
 
 /* ----------------------------------------------------------- */
 
-static void set_audio_standard_BTSC(struct cx88_core *core, unsigned int sap)
+static void set_audio_standard_BTSC(struct cx88_core *core, unsigned int sap, u32 mode)
 {
 	static const struct rlist btsc[] = {
-		/* from dscaler */
+	{ AUD_AFE_12DB_EN,             0x00000001 },
 		{ AUD_OUT1_SEL,                0x00000013 },
 		{ AUD_OUT1_SHIFT,              0x00000000 },
 		{ AUD_POLY0_DDS_CONSTANT,      0x0012010c },
@@ -206,9 +199,10 @@ static void set_audio_standard_BTSC(stru
 		{ AUD_RDSI_SHIFT,              0x00000000 },
 		{ AUD_RDSQ_SHIFT,              0x00000000 },
 		{ AUD_POLYPH80SCALEFAC,        0x00000003 },
-                { /* end of list */ },
+		{ /* end of list */ },
 	};
 	static const struct rlist btsc_sap[] = {
+	{ AUD_AFE_12DB_EN,             0x00000001 },
 		{ AUD_DBX_IN_GAIN,             0x00007200 },
 		{ AUD_DBX_WBE_GAIN,            0x00006200 },
 		{ AUD_DBX_SE_GAIN,             0x00006200 },
@@ -259,371 +253,400 @@ static void set_audio_standard_BTSC(stru
 		{ AUD_RDSI_SHIFT,              0x00000000 },
 		{ AUD_RDSQ_SHIFT,              0x00000000 },
 		{ AUD_POLYPH80SCALEFAC,        0x00000003 },
-                { /* end of list */ },
+		{ /* end of list */ },
 	};
 
-	// dscaler: exactly taken from driver,
-	// dscaler: don't know why to set EN_FMRADIO_EN_RDS
+	mode |= EN_FMRADIO_EN_RDS;
+
 	if (sap) {
 		dprintk("%s SAP (status: unknown)\n",__FUNCTION__);
-		set_audio_start(core, 0x0001,
-				EN_FMRADIO_EN_RDS | EN_BTSC_FORCE_SAP);
+	set_audio_start(core, SEL_SAP);
 		set_audio_registers(core, btsc_sap);
+		set_audio_finish(core, mode);
 	} else {
 		dprintk("%s (status: known-good)\n",__FUNCTION__);
-		set_audio_start(core, 0x0001,
-				EN_FMRADIO_EN_RDS | EN_BTSC_AUTO_STEREO);
+	set_audio_start(core, SEL_BTSC);
 		set_audio_registers(core, btsc);
+		set_audio_finish(core, mode);
 	}
-	set_audio_finish(core);
 }
 
 
 static void set_audio_standard_NICAM_L(struct cx88_core *core, int stereo)
 {
-        /* This is probably weird..
-         * Let's operate and find out. */
+	/* This is probably weird..
+	* Let's operate and find out. */
 
-        static const struct rlist nicam_l_mono[] = {
-                { AUD_ERRLOGPERIOD_R,     0x00000064 },
-                { AUD_ERRINTRPTTHSHLD1_R, 0x00000FFF },
-                { AUD_ERRINTRPTTHSHLD2_R, 0x0000001F },
-                { AUD_ERRINTRPTTHSHLD3_R, 0x0000000F },
-
-                { AUD_PDF_DDS_CNST_BYTE2, 0x48 },
-                { AUD_PDF_DDS_CNST_BYTE1, 0x3D },
-                { AUD_QAM_MODE,           0x00 },
-                { AUD_PDF_DDS_CNST_BYTE0, 0xf5 },
-                { AUD_PHACC_FREQ_8MSB,    0x3a },
-                { AUD_PHACC_FREQ_8LSB,    0x4a },
-
-                { AUD_DEEMPHGAIN_R, 0x6680 },
-                { AUD_DEEMPHNUMER1_R, 0x353DE },
-                { AUD_DEEMPHNUMER2_R, 0x1B1 },
-                { AUD_DEEMPHDENOM1_R, 0x0F3D0 },
-                { AUD_DEEMPHDENOM2_R, 0x0 },
-                { AUD_FM_MODE_ENABLE, 0x7 },
-                { AUD_POLYPH80SCALEFAC, 0x3 },
-                { AUD_AFE_12DB_EN, 0x1 },
-                { AAGC_GAIN, 0x0 },
-                { AAGC_HYST, 0x18 },
-                { AAGC_DEF, 0x20 },
-                { AUD_DN0_FREQ, 0x0 },
-                { AUD_POLY0_DDS_CONSTANT, 0x0E4DB2 },
-                { AUD_DCOC_0_SRC, 0x21 },
-                { AUD_IIR1_0_SEL, 0x0 },
-                { AUD_IIR1_0_SHIFT, 0x7 },
-                { AUD_IIR1_1_SEL, 0x2 },
-                { AUD_IIR1_1_SHIFT, 0x0 },
-                { AUD_DCOC_1_SRC, 0x3 },
-                { AUD_DCOC1_SHIFT, 0x0 },
-                { AUD_DCOC_PASS_IN, 0x0 },
-                { AUD_IIR1_2_SEL, 0x23 },
-                { AUD_IIR1_2_SHIFT, 0x0 },
-                { AUD_IIR1_3_SEL, 0x4 },
-                { AUD_IIR1_3_SHIFT, 0x7 },
-                { AUD_IIR1_4_SEL, 0x5 },
-                { AUD_IIR1_4_SHIFT, 0x7 },
-                { AUD_IIR3_0_SEL, 0x7 },
-                { AUD_IIR3_0_SHIFT, 0x0 },
-                { AUD_DEEMPH0_SRC_SEL, 0x11 },
-                { AUD_DEEMPH0_SHIFT, 0x0 },
-                { AUD_DEEMPH0_G0, 0x7000 },
-                { AUD_DEEMPH0_A0, 0x0 },
-                { AUD_DEEMPH0_B0, 0x0 },
-                { AUD_DEEMPH0_A1, 0x0 },
-                { AUD_DEEMPH0_B1, 0x0 },
-                { AUD_DEEMPH1_SRC_SEL, 0x11 },
-                { AUD_DEEMPH1_SHIFT, 0x0 },
-                { AUD_DEEMPH1_G0, 0x7000 },
-                { AUD_DEEMPH1_A0, 0x0 },
-                { AUD_DEEMPH1_B0, 0x0 },
-                { AUD_DEEMPH1_A1, 0x0 },
-                { AUD_DEEMPH1_B1, 0x0 },
-                { AUD_OUT0_SEL, 0x3F },
-                { AUD_OUT1_SEL, 0x3F },
-                { AUD_DMD_RA_DDS, 0x0F5C285 },
-                { AUD_PLL_INT, 0x1E },
-                { AUD_PLL_DDS, 0x0 },
-                { AUD_PLL_FRAC, 0x0E542 },
-
-                // setup QAM registers
-                { AUD_RATE_ADJ1,      0x00000100 },
-                { AUD_RATE_ADJ2,      0x00000200 },
-                { AUD_RATE_ADJ3,      0x00000300 },
-                { AUD_RATE_ADJ4,      0x00000400 },
-                { AUD_RATE_ADJ5,      0x00000500 },
-                { AUD_RATE_THRES_DMD, 0x000000C0 },
-                { /* end of list */ },
-        };
-
-        static const struct rlist nicam_l[] = {
-                // setup QAM registers
-                { AUD_RATE_ADJ1, 0x00000060 },
-                { AUD_RATE_ADJ2, 0x000000F9 },
-                { AUD_RATE_ADJ3, 0x000001CC },
-                { AUD_RATE_ADJ4, 0x000002B3 },
-                { AUD_RATE_ADJ5, 0x00000726 },
-                { AUD_DEEMPHDENOM1_R, 0x0000F3D0 },
-                { AUD_DEEMPHDENOM2_R, 0x00000000 },
-                { AUD_ERRLOGPERIOD_R, 0x00000064 },
-                { AUD_ERRINTRPTTHSHLD1_R, 0x00000FFF },
-                { AUD_ERRINTRPTTHSHLD2_R, 0x0000001F },
-                { AUD_ERRINTRPTTHSHLD3_R, 0x0000000F },
-                { AUD_POLYPH80SCALEFAC, 0x00000003 },
-                { AUD_DMD_RA_DDS, 0x00C00000 },
-                { AUD_PLL_INT, 0x0000001E },
-                { AUD_PLL_DDS, 0x00000000 },
-                { AUD_PLL_FRAC, 0x0000E542 },
-                { AUD_START_TIMER, 0x00000000 },
-                { AUD_DEEMPHNUMER1_R, 0x000353DE },
-                { AUD_DEEMPHNUMER2_R, 0x000001B1 },
-                { AUD_PDF_DDS_CNST_BYTE2, 0x06 },
-                { AUD_PDF_DDS_CNST_BYTE1, 0x82 },
-                { AUD_QAM_MODE, 0x05 },
-                { AUD_PDF_DDS_CNST_BYTE0, 0x12 },
-                { AUD_PHACC_FREQ_8MSB, 0x34 },
-                { AUD_PHACC_FREQ_8LSB, 0x4C },
-                { AUD_DEEMPHGAIN_R, 0x00006680 },
-                { AUD_RATE_THRES_DMD, 0x000000C0  },
-                { /* end of list */ },
-        } ;
-        dprintk("%s (status: devel), stereo : %d\n",__FUNCTION__,stereo);
-
-        if (!stereo) {
-		/* AM mono sound */
-                set_audio_start(core, 0x0004,
-				0x100c /* FIXME again */);
-                set_audio_registers(core, nicam_l_mono);
-        } else {
-                set_audio_start(core, 0x0010,
-				0x1924 /* FIXME again */);
-                set_audio_registers(core, nicam_l);
-        }
-        set_audio_finish(core);
+	static const struct rlist nicam_l_mono[] = {
+		{ AUD_ERRLOGPERIOD_R,     0x00000064 },
+		{ AUD_ERRINTRPTTHSHLD1_R, 0x00000FFF },
+		{ AUD_ERRINTRPTTHSHLD2_R, 0x0000001F },
+		{ AUD_ERRINTRPTTHSHLD3_R, 0x0000000F },
+
+		{ AUD_PDF_DDS_CNST_BYTE2, 0x48 },
+		{ AUD_PDF_DDS_CNST_BYTE1, 0x3D },
+		{ AUD_QAM_MODE,           0x00 },
+		{ AUD_PDF_DDS_CNST_BYTE0, 0xf5 },
+		{ AUD_PHACC_FREQ_8MSB,    0x3a },
+		{ AUD_PHACC_FREQ_8LSB,    0x4a },
+
+		{ AUD_DEEMPHGAIN_R, 0x6680 },
+		{ AUD_DEEMPHNUMER1_R, 0x353DE },
+		{ AUD_DEEMPHNUMER2_R, 0x1B1 },
+		{ AUD_DEEMPHDENOM1_R, 0x0F3D0 },
+		{ AUD_DEEMPHDENOM2_R, 0x0 },
+		{ AUD_FM_MODE_ENABLE, 0x7 },
+		{ AUD_POLYPH80SCALEFAC, 0x3 },
+		{ AUD_AFE_12DB_EN, 0x1 },
+		{ AAGC_GAIN, 0x0 },
+		{ AAGC_HYST, 0x18 },
+		{ AAGC_DEF, 0x20 },
+		{ AUD_DN0_FREQ, 0x0 },
+		{ AUD_POLY0_DDS_CONSTANT, 0x0E4DB2 },
+		{ AUD_DCOC_0_SRC, 0x21 },
+		{ AUD_IIR1_0_SEL, 0x0 },
+		{ AUD_IIR1_0_SHIFT, 0x7 },
+		{ AUD_IIR1_1_SEL, 0x2 },
+		{ AUD_IIR1_1_SHIFT, 0x0 },
+		{ AUD_DCOC_1_SRC, 0x3 },
+		{ AUD_DCOC1_SHIFT, 0x0 },
+		{ AUD_DCOC_PASS_IN, 0x0 },
+		{ AUD_IIR1_2_SEL, 0x23 },
+		{ AUD_IIR1_2_SHIFT, 0x0 },
+		{ AUD_IIR1_3_SEL, 0x4 },
+		{ AUD_IIR1_3_SHIFT, 0x7 },
+		{ AUD_IIR1_4_SEL, 0x5 },
+		{ AUD_IIR1_4_SHIFT, 0x7 },
+		{ AUD_IIR3_0_SEL, 0x7 },
+		{ AUD_IIR3_0_SHIFT, 0x0 },
+		{ AUD_DEEMPH0_SRC_SEL, 0x11 },
+		{ AUD_DEEMPH0_SHIFT, 0x0 },
+		{ AUD_DEEMPH0_G0, 0x7000 },
+		{ AUD_DEEMPH0_A0, 0x0 },
+		{ AUD_DEEMPH0_B0, 0x0 },
+		{ AUD_DEEMPH0_A1, 0x0 },
+		{ AUD_DEEMPH0_B1, 0x0 },
+		{ AUD_DEEMPH1_SRC_SEL, 0x11 },
+		{ AUD_DEEMPH1_SHIFT, 0x0 },
+		{ AUD_DEEMPH1_G0, 0x7000 },
+		{ AUD_DEEMPH1_A0, 0x0 },
+		{ AUD_DEEMPH1_B0, 0x0 },
+		{ AUD_DEEMPH1_A1, 0x0 },
+		{ AUD_DEEMPH1_B1, 0x0 },
+		{ AUD_OUT0_SEL, 0x3F },
+		{ AUD_OUT1_SEL, 0x3F },
+		{ AUD_DMD_RA_DDS, 0x0F5C285 },
+		{ AUD_PLL_INT, 0x1E },
+		{ AUD_PLL_DDS, 0x0 },
+		{ AUD_PLL_FRAC, 0x0E542 },
+
+		// setup QAM registers
+		{ AUD_RATE_ADJ1,      0x00000100 },
+		{ AUD_RATE_ADJ2,      0x00000200 },
+		{ AUD_RATE_ADJ3,      0x00000300 },
+		{ AUD_RATE_ADJ4,      0x00000400 },
+		{ AUD_RATE_ADJ5,      0x00000500 },
+		{ AUD_RATE_THRES_DMD, 0x000000C0 },
+		{ /* end of list */ },
+	};
 
+	static const struct rlist nicam_l[] = {
+		// setup QAM registers
+		{ AUD_RATE_ADJ1, 0x00000060 },
+		{ AUD_RATE_ADJ2, 0x000000F9 },
+		{ AUD_RATE_ADJ3, 0x000001CC },
+		{ AUD_RATE_ADJ4, 0x000002B3 },
+		{ AUD_RATE_ADJ5, 0x00000726 },
+		{ AUD_DEEMPHDENOM1_R, 0x0000F3D0 },
+		{ AUD_DEEMPHDENOM2_R, 0x00000000 },
+		{ AUD_ERRLOGPERIOD_R, 0x00000064 },
+		{ AUD_ERRINTRPTTHSHLD1_R, 0x00000FFF },
+		{ AUD_ERRINTRPTTHSHLD2_R, 0x0000001F },
+		{ AUD_ERRINTRPTTHSHLD3_R, 0x0000000F },
+		{ AUD_POLYPH80SCALEFAC, 0x00000003 },
+		{ AUD_DMD_RA_DDS, 0x00C00000 },
+		{ AUD_PLL_INT, 0x0000001E },
+		{ AUD_PLL_DDS, 0x00000000 },
+		{ AUD_PLL_FRAC, 0x0000E542 },
+		{ AUD_START_TIMER, 0x00000000 },
+		{ AUD_DEEMPHNUMER1_R, 0x000353DE },
+		{ AUD_DEEMPHNUMER2_R, 0x000001B1 },
+		{ AUD_PDF_DDS_CNST_BYTE2, 0x06 },
+		{ AUD_PDF_DDS_CNST_BYTE1, 0x82 },
+		{ AUD_QAM_MODE, 0x05 },
+		{ AUD_PDF_DDS_CNST_BYTE0, 0x12 },
+		{ AUD_PHACC_FREQ_8MSB, 0x34 },
+		{ AUD_PHACC_FREQ_8LSB, 0x4C },
+		{ AUD_DEEMPHGAIN_R, 0x00006680 },
+		{ AUD_RATE_THRES_DMD, 0x000000C0  },
+		{ /* end of list */ },
+	} ;
+	dprintk("%s (status: devel), stereo : %d\n",__FUNCTION__,stereo);
+
+	if (!stereo) {
+	/* AM Mono */
+		set_audio_start(core, SEL_A2);
+		set_audio_registers(core, nicam_l_mono);
+	set_audio_finish(core, EN_A2_FORCE_MONO1);
+	} else {
+	/* Nicam Stereo */
+		set_audio_start(core, SEL_NICAM);
+		set_audio_registers(core, nicam_l);
+	set_audio_finish(core, 0x1924); /* FIXME */
+	}
 }
 
 static void set_audio_standard_PAL_I(struct cx88_core *core, int stereo)
 {
        static const struct rlist pal_i_fm_mono[] = {
-            {AUD_ERRLOGPERIOD_R,       0x00000064},
-            {AUD_ERRINTRPTTHSHLD1_R,   0x00000fff},
-            {AUD_ERRINTRPTTHSHLD2_R,   0x0000001f},
-            {AUD_ERRINTRPTTHSHLD3_R,   0x0000000f},
-            {AUD_PDF_DDS_CNST_BYTE2,   0x06},
-            {AUD_PDF_DDS_CNST_BYTE1,   0x82},
-            {AUD_PDF_DDS_CNST_BYTE0,   0x12},
-            {AUD_QAM_MODE,             0x05},
-            {AUD_PHACC_FREQ_8MSB,      0x3a},
-            {AUD_PHACC_FREQ_8LSB,      0x93},
-            {AUD_DMD_RA_DDS,           0x002a4f2f},
-            {AUD_PLL_INT,              0x0000001e},
-            {AUD_PLL_DDS,              0x00000004},
-            {AUD_PLL_FRAC,             0x0000e542},
-            {AUD_RATE_ADJ1,            0x00000100},
-            {AUD_RATE_ADJ2,            0x00000200},
-            {AUD_RATE_ADJ3,            0x00000300},
-            {AUD_RATE_ADJ4,            0x00000400},
-            {AUD_RATE_ADJ5,            0x00000500},
-            {AUD_THR_FR,               0x00000000},
-            {AUD_PILOT_BQD_1_K0,       0x0000755b},
-            {AUD_PILOT_BQD_1_K1,       0x00551340},
-            {AUD_PILOT_BQD_1_K2,       0x006d30be},
-            {AUD_PILOT_BQD_1_K3,       0xffd394af},
-            {AUD_PILOT_BQD_1_K4,       0x00400000},
-            {AUD_PILOT_BQD_2_K0,       0x00040000},
-            {AUD_PILOT_BQD_2_K1,       0x002a4841},
-            {AUD_PILOT_BQD_2_K2,       0x00400000},
-            {AUD_PILOT_BQD_2_K3,       0x00000000},
-            {AUD_PILOT_BQD_2_K4,       0x00000000},
-            {AUD_MODE_CHG_TIMER,       0x00000060},
-            {AUD_AFE_12DB_EN,          0x00000001},
-            {AAGC_HYST,                0x0000000a},
-            {AUD_CORDIC_SHIFT_0,       0x00000007},
-            {AUD_CORDIC_SHIFT_1,       0x00000007},
-            {AUD_C1_UP_THR,            0x00007000},
-            {AUD_C1_LO_THR,            0x00005400},
-            {AUD_C2_UP_THR,            0x00005400},
-            {AUD_C2_LO_THR,            0x00003000},
-            {AUD_DCOC_0_SRC,           0x0000001a},
-            {AUD_DCOC0_SHIFT,          0x00000000},
-            {AUD_DCOC_0_SHIFT_IN0,     0x0000000a},
-            {AUD_DCOC_0_SHIFT_IN1,     0x00000008},
-            {AUD_DCOC_PASS_IN,         0x00000003},
-            {AUD_IIR3_0_SEL,           0x00000021},
-            {AUD_DN2_AFC,              0x00000002},
-            {AUD_DCOC_1_SRC,           0x0000001b},
-            {AUD_DCOC1_SHIFT,          0x00000000},
-            {AUD_DCOC_1_SHIFT_IN0,     0x0000000a},
-            {AUD_DCOC_1_SHIFT_IN1,     0x00000008},
-            {AUD_IIR3_1_SEL,           0x00000023},
-            {AUD_DN0_FREQ,             0x000035a3},
-            {AUD_DN2_FREQ,             0x000029c7},
-            {AUD_CRDC0_SRC_SEL,        0x00000511},
-            {AUD_IIR1_0_SEL,           0x00000001},
-            {AUD_IIR1_1_SEL,           0x00000000},
-            {AUD_IIR3_2_SEL,           0x00000003},
-            {AUD_IIR3_2_SHIFT,         0x00000000},
-            {AUD_IIR3_0_SEL,           0x00000002},
-            {AUD_IIR2_0_SEL,           0x00000021},
-            {AUD_IIR2_0_SHIFT,         0x00000002},
-            {AUD_DEEMPH0_SRC_SEL,      0x0000000b},
-            {AUD_DEEMPH1_SRC_SEL,      0x0000000b},
-            {AUD_POLYPH80SCALEFAC,     0x00000001},
-            {AUD_START_TIMER,          0x00000000},
-            { /* end of list */ },
+	{AUD_ERRLOGPERIOD_R,       0x00000064},
+	{AUD_ERRINTRPTTHSHLD1_R,   0x00000fff},
+	{AUD_ERRINTRPTTHSHLD2_R,   0x0000001f},
+	{AUD_ERRINTRPTTHSHLD3_R,   0x0000000f},
+	{AUD_PDF_DDS_CNST_BYTE2,   0x06},
+	{AUD_PDF_DDS_CNST_BYTE1,   0x82},
+	{AUD_PDF_DDS_CNST_BYTE0,   0x12},
+	{AUD_QAM_MODE,             0x05},
+	{AUD_PHACC_FREQ_8MSB,      0x3a},
+	{AUD_PHACC_FREQ_8LSB,      0x93},
+	{AUD_DMD_RA_DDS,           0x002a4f2f},
+	{AUD_PLL_INT,              0x0000001e},
+	{AUD_PLL_DDS,              0x00000004},
+	{AUD_PLL_FRAC,             0x0000e542},
+	{AUD_RATE_ADJ1,            0x00000100},
+	{AUD_RATE_ADJ2,            0x00000200},
+	{AUD_RATE_ADJ3,            0x00000300},
+	{AUD_RATE_ADJ4,            0x00000400},
+	{AUD_RATE_ADJ5,            0x00000500},
+	{AUD_THR_FR,               0x00000000},
+	{AUD_PILOT_BQD_1_K0,       0x0000755b},
+	{AUD_PILOT_BQD_1_K1,       0x00551340},
+	{AUD_PILOT_BQD_1_K2,       0x006d30be},
+	{AUD_PILOT_BQD_1_K3,       0xffd394af},
+	{AUD_PILOT_BQD_1_K4,       0x00400000},
+	{AUD_PILOT_BQD_2_K0,       0x00040000},
+	{AUD_PILOT_BQD_2_K1,       0x002a4841},
+	{AUD_PILOT_BQD_2_K2,       0x00400000},
+	{AUD_PILOT_BQD_2_K3,       0x00000000},
+	{AUD_PILOT_BQD_2_K4,       0x00000000},
+	{AUD_MODE_CHG_TIMER,       0x00000060},
+	{AUD_AFE_12DB_EN,          0x00000001},
+	{AAGC_HYST,                0x0000000a},
+	{AUD_CORDIC_SHIFT_0,       0x00000007},
+	{AUD_CORDIC_SHIFT_1,       0x00000007},
+	{AUD_C1_UP_THR,            0x00007000},
+	{AUD_C1_LO_THR,            0x00005400},
+	{AUD_C2_UP_THR,            0x00005400},
+	{AUD_C2_LO_THR,            0x00003000},
+	{AUD_DCOC_0_SRC,           0x0000001a},
+	{AUD_DCOC0_SHIFT,          0x00000000},
+	{AUD_DCOC_0_SHIFT_IN0,     0x0000000a},
+	{AUD_DCOC_0_SHIFT_IN1,     0x00000008},
+	{AUD_DCOC_PASS_IN,         0x00000003},
+	{AUD_IIR3_0_SEL,           0x00000021},
+	{AUD_DN2_AFC,              0x00000002},
+	{AUD_DCOC_1_SRC,           0x0000001b},
+	{AUD_DCOC1_SHIFT,          0x00000000},
+	{AUD_DCOC_1_SHIFT_IN0,     0x0000000a},
+	{AUD_DCOC_1_SHIFT_IN1,     0x00000008},
+	{AUD_IIR3_1_SEL,           0x00000023},
+	{AUD_DN0_FREQ,             0x000035a3},
+	{AUD_DN2_FREQ,             0x000029c7},
+	{AUD_CRDC0_SRC_SEL,        0x00000511},
+	{AUD_IIR1_0_SEL,           0x00000001},
+	{AUD_IIR1_1_SEL,           0x00000000},
+	{AUD_IIR3_2_SEL,           0x00000003},
+	{AUD_IIR3_2_SHIFT,         0x00000000},
+	{AUD_IIR3_0_SEL,           0x00000002},
+	{AUD_IIR2_0_SEL,           0x00000021},
+	{AUD_IIR2_0_SHIFT,         0x00000002},
+	{AUD_DEEMPH0_SRC_SEL,      0x0000000b},
+	{AUD_DEEMPH1_SRC_SEL,      0x0000000b},
+	{AUD_POLYPH80SCALEFAC,     0x00000001},
+	{AUD_START_TIMER,          0x00000000},
+	{ /* end of list */ },
        };
 
        static const struct rlist pal_i_nicam[] = {
-           { AUD_RATE_ADJ1,           0x00000010 },
-           { AUD_RATE_ADJ2,           0x00000040 },
-           { AUD_RATE_ADJ3,           0x00000100 },
-           { AUD_RATE_ADJ4,           0x00000400 },
-           { AUD_RATE_ADJ5,           0x00001000 },
-	   //     { AUD_DMD_RA_DDS,          0x00c0d5ce },
-	   { AUD_DEEMPHGAIN_R,        0x000023c2 },
-	   { AUD_DEEMPHNUMER1_R,      0x0002a7bc },
-	   { AUD_DEEMPHNUMER2_R,      0x0003023e },
-	   { AUD_DEEMPHDENOM1_R,      0x0000f3d0 },
-	   { AUD_DEEMPHDENOM2_R,      0x00000000 },
-	   { AUD_DEEMPHDENOM2_R,      0x00000000 },
-	   { AUD_ERRLOGPERIOD_R,      0x00000fff },
-	   { AUD_ERRINTRPTTHSHLD1_R,  0x000003ff },
-	   { AUD_ERRINTRPTTHSHLD2_R,  0x000000ff },
-	   { AUD_ERRINTRPTTHSHLD3_R,  0x0000003f },
-	   { AUD_POLYPH80SCALEFAC,    0x00000003 },
-	   { AUD_PDF_DDS_CNST_BYTE2,  0x06 },
-	   { AUD_PDF_DDS_CNST_BYTE1,  0x82 },
-	   { AUD_PDF_DDS_CNST_BYTE0,  0x16 },
-	   { AUD_QAM_MODE,            0x05 },
-	   { AUD_PDF_DDS_CNST_BYTE0,  0x12 },
-	   { AUD_PHACC_FREQ_8MSB,     0x3a },
-	   { AUD_PHACC_FREQ_8LSB,     0x93 },
-            { /* end of list */ },
-        };
-
-        dprintk("%s (status: devel), stereo : %d\n",__FUNCTION__,stereo);
-
-        if (!stereo) {
-		// FM mono
-		set_audio_start(core, 0x0004, EN_DMTRX_SUMDIFF | EN_A2_FORCE_MONO1);
+	{ AUD_RATE_ADJ1,           0x00000010 },
+	{ AUD_RATE_ADJ2,           0x00000040 },
+	{ AUD_RATE_ADJ3,           0x00000100 },
+	{ AUD_RATE_ADJ4,           0x00000400 },
+	{ AUD_RATE_ADJ5,           0x00001000 },
+	//     { AUD_DMD_RA_DDS,          0x00c0d5ce },
+	{ AUD_DEEMPHGAIN_R,        0x000023c2 },
+	{ AUD_DEEMPHNUMER1_R,      0x0002a7bc },
+	{ AUD_DEEMPHNUMER2_R,      0x0003023e },
+	{ AUD_DEEMPHDENOM1_R,      0x0000f3d0 },
+	{ AUD_DEEMPHDENOM2_R,      0x00000000 },
+	{ AUD_DEEMPHDENOM2_R,      0x00000000 },
+	{ AUD_ERRLOGPERIOD_R,      0x00000fff },
+	{ AUD_ERRINTRPTTHSHLD1_R,  0x000003ff },
+	{ AUD_ERRINTRPTTHSHLD2_R,  0x000000ff },
+	{ AUD_ERRINTRPTTHSHLD3_R,  0x0000003f },
+	{ AUD_POLYPH80SCALEFAC,    0x00000003 },
+	{ AUD_PDF_DDS_CNST_BYTE2,  0x06 },
+	{ AUD_PDF_DDS_CNST_BYTE1,  0x82 },
+	{ AUD_PDF_DDS_CNST_BYTE0,  0x16 },
+	{ AUD_QAM_MODE,            0x05 },
+	{ AUD_PDF_DDS_CNST_BYTE0,  0x12 },
+	{ AUD_PHACC_FREQ_8MSB,     0x3a },
+	{ AUD_PHACC_FREQ_8LSB,     0x93 },
+	{ /* end of list */ },
+	};
+
+	dprintk("%s (status: devel), stereo : %d\n",__FUNCTION__,stereo);
+
+	if (!stereo) {
+	/* FM Mono */
+	set_audio_start(core, SEL_A2);
 		set_audio_registers(core, pal_i_fm_mono);
-        } else {
-		// Nicam Stereo
-		set_audio_start(core, 0x0010, EN_DMTRX_LR | EN_DMTRX_BYPASS | EN_NICAM_AUTO_STEREO);
+		set_audio_finish(core, EN_DMTRX_SUMDIFF | EN_A2_FORCE_MONO1);
+	} else {
+	/* Nicam Stereo */
+	set_audio_start(core, SEL_NICAM);
 		set_audio_registers(core, pal_i_nicam);
-        }
-        set_audio_finish(core);
+		set_audio_finish(core, EN_DMTRX_LR | EN_DMTRX_BYPASS | EN_NICAM_AUTO_STEREO);
+	}
 }
 
-static void set_audio_standard_A2(struct cx88_core *core)
+static void set_audio_standard_A2(struct cx88_core *core, u32 mode)
 {
-	/* from dscaler cvs */
 	static const struct rlist a2_common[] = {
-		{ AUD_PDF_DDS_CNST_BYTE2,     0x06 },
-		{ AUD_PDF_DDS_CNST_BYTE1,     0x82 },
-		{ AUD_PDF_DDS_CNST_BYTE0,     0x12 },
-		{ AUD_QAM_MODE,		      0x05 },
-		{ AUD_PHACC_FREQ_8MSB,	      0x34 },
-		{ AUD_PHACC_FREQ_8LSB,	      0x4c },
-
-		{ AUD_RATE_ADJ1,	0x00001000 },
-		{ AUD_RATE_ADJ2,	0x00002000 },
-		{ AUD_RATE_ADJ3,	0x00003000 },
-		{ AUD_RATE_ADJ4,	0x00004000 },
-		{ AUD_RATE_ADJ5,	0x00005000 },
-		{ AUD_THR_FR,		0x00000000 },
-		{ AAGC_HYST,		0x0000001a },
-		{ AUD_PILOT_BQD_1_K0,	0x0000755b },
-		{ AUD_PILOT_BQD_1_K1,	0x00551340 },
-		{ AUD_PILOT_BQD_1_K2,	0x006d30be },
-		{ AUD_PILOT_BQD_1_K3,	0xffd394af },
-		{ AUD_PILOT_BQD_1_K4,	0x00400000 },
-		{ AUD_PILOT_BQD_2_K0,	0x00040000 },
-		{ AUD_PILOT_BQD_2_K1,	0x002a4841 },
-		{ AUD_PILOT_BQD_2_K2,	0x00400000 },
-		{ AUD_PILOT_BQD_2_K3,	0x00000000 },
-		{ AUD_PILOT_BQD_2_K4,	0x00000000 },
-		{ AUD_MODE_CHG_TIMER,	0x00000040 },
-		{ AUD_START_TIMER,	0x00000200 },
-		{ AUD_AFE_12DB_EN,	0x00000000 },
-		{ AUD_CORDIC_SHIFT_0,	0x00000007 },
-		{ AUD_CORDIC_SHIFT_1,	0x00000007 },
-		{ AUD_DEEMPH0_G0,	0x00000380 },
-		{ AUD_DEEMPH1_G0,	0x00000380 },
-		{ AUD_DCOC_0_SRC,	0x0000001a },
-		{ AUD_DCOC0_SHIFT,	0x00000000 },
-		{ AUD_DCOC_0_SHIFT_IN0,	0x0000000a },
-		{ AUD_DCOC_0_SHIFT_IN1,	0x00000008 },
-		{ AUD_DCOC_PASS_IN,	0x00000003 },
-		{ AUD_IIR3_0_SEL,	0x00000021 },
-		{ AUD_DN2_AFC,		0x00000002 },
-		{ AUD_DCOC_1_SRC,	0x0000001b },
-		{ AUD_DCOC1_SHIFT,	0x00000000 },
-		{ AUD_DCOC_1_SHIFT_IN0,	0x0000000a },
-		{ AUD_DCOC_1_SHIFT_IN1,	0x00000008 },
-		{ AUD_IIR3_1_SEL,	0x00000023 },
-		{ AUD_RDSI_SEL,		0x00000017 },
-		{ AUD_RDSI_SHIFT,	0x00000000 },
-		{ AUD_RDSQ_SEL,		0x00000017 },
-		{ AUD_RDSQ_SHIFT,	0x00000000 },
-		{ AUD_POLYPH80SCALEFAC,	0x00000001 },
-
-		{ /* end of list */ },
-	};
-
-	static const struct rlist a2_table1[] = {
-		// PAL-BG
-		{ AUD_DMD_RA_DDS,	0x002a73bd },
-		{ AUD_C1_UP_THR,	0x00007000 },
-		{ AUD_C1_LO_THR,	0x00005400 },
-		{ AUD_C2_UP_THR,	0x00005400 },
-		{ AUD_C2_LO_THR,	0x00003000 },
-		{ /* end of list */ },
-	};
-	static const struct rlist a2_table2[] = {
-		// PAL-DK
-		{ AUD_DMD_RA_DDS,	0x002a73bd },
-		{ AUD_C1_UP_THR,	0x00007000 },
-		{ AUD_C1_LO_THR,	0x00005400 },
-		{ AUD_C2_UP_THR,	0x00005400 },
-		{ AUD_C2_LO_THR,	0x00003000 },
-		{ AUD_DN0_FREQ,		0x00003a1c },
-		{ AUD_DN2_FREQ,		0x0000d2e0 },
-		{ /* end of list */ },
-	};
-	static const struct rlist a2_table3[] = {
-		// unknown, probably NTSC-M
-		{ AUD_DMD_RA_DDS,	0x002a2873 },
-		{ AUD_C1_UP_THR,	0x00003c00 },
-		{ AUD_C1_LO_THR,	0x00003000 },
-		{ AUD_C2_UP_THR,	0x00006000 },
-		{ AUD_C2_LO_THR,	0x00003c00 },
-		{ AUD_DN0_FREQ,		0x00002836 },
-		{ AUD_DN1_FREQ,		0x00003418 },
-		{ AUD_DN2_FREQ,		0x000029c7 },
-		{ AUD_POLY0_DDS_CONSTANT, 0x000a7540 },
+	{AUD_ERRLOGPERIOD_R,            0x00000064},
+	{AUD_ERRINTRPTTHSHLD1_R,        0x00000fff},
+	{AUD_ERRINTRPTTHSHLD2_R,        0x0000001f},
+	{AUD_ERRINTRPTTHSHLD3_R,        0x0000000f},
+	{AUD_PDF_DDS_CNST_BYTE2,        0x06},
+	{AUD_PDF_DDS_CNST_BYTE1,        0x82},
+	{AUD_PDF_DDS_CNST_BYTE0,        0x12},
+	{AUD_QAM_MODE,                  0x05},
+	{AUD_PHACC_FREQ_8MSB,           0x34},
+	{AUD_PHACC_FREQ_8LSB,           0x4c},
+	{AUD_RATE_ADJ1,                 0x00000100},
+	{AUD_RATE_ADJ2,                 0x00000200},
+	{AUD_RATE_ADJ3,                 0x00000300},
+	{AUD_RATE_ADJ4,                 0x00000400},
+	{AUD_RATE_ADJ5,                 0x00000500},
+	{AUD_THR_FR,                    0x00000000},
+	{AAGC_HYST,                     0x0000001a},
+	{AUD_PILOT_BQD_1_K0,            0x0000755b},
+	{AUD_PILOT_BQD_1_K1,            0x00551340},
+	{AUD_PILOT_BQD_1_K2,            0x006d30be},
+	{AUD_PILOT_BQD_1_K3,            0xffd394af},
+	{AUD_PILOT_BQD_1_K4,            0x00400000},
+	{AUD_PILOT_BQD_2_K0,            0x00040000},
+	{AUD_PILOT_BQD_2_K1,            0x002a4841},
+	{AUD_PILOT_BQD_2_K2,            0x00400000},
+	{AUD_PILOT_BQD_2_K3,            0x00000000},
+	{AUD_PILOT_BQD_2_K4,            0x00000000},
+	{AUD_MODE_CHG_TIMER,            0x00000040},
+	{AUD_AFE_12DB_EN,               0x00000001},
+	{AUD_CORDIC_SHIFT_0,            0x00000007},
+	{AUD_CORDIC_SHIFT_1,            0x00000007},
+	{AUD_DEEMPH0_G0,                0x00000380},
+	{AUD_DEEMPH1_G0,                0x00000380},
+	{AUD_DCOC_0_SRC,                0x0000001a},
+	{AUD_DCOC0_SHIFT,               0x00000000},
+	{AUD_DCOC_0_SHIFT_IN0,          0x0000000a},
+	{AUD_DCOC_0_SHIFT_IN1,          0x00000008},
+	{AUD_DCOC_PASS_IN,              0x00000003},
+	{AUD_IIR3_0_SEL,                0x00000021},
+	{AUD_DN2_AFC,                   0x00000002},
+	{AUD_DCOC_1_SRC,                0x0000001b},
+	{AUD_DCOC1_SHIFT,               0x00000000},
+	{AUD_DCOC_1_SHIFT_IN0,          0x0000000a},
+	{AUD_DCOC_1_SHIFT_IN1,          0x00000008},
+	{AUD_IIR3_1_SEL,                0x00000023},
+	{AUD_RDSI_SEL,                  0x00000017},
+	{AUD_RDSI_SHIFT,                0x00000000},
+	{AUD_RDSQ_SEL,                  0x00000017},
+	{AUD_RDSQ_SHIFT,                0x00000000},
+	{AUD_PLL_INT,                   0x0000001e},
+	{AUD_PLL_DDS,                   0x00000000},
+	{AUD_PLL_FRAC,                  0x0000e542},
+	{AUD_POLYPH80SCALEFAC,          0x00000001},
+	{AUD_START_TIMER,               0x00000000},
+	{ /* end of list */ },
+	};
+
+	static const struct rlist a2_bg[] = {
+	{AUD_DMD_RA_DDS,                0x002a4f2f},
+	{AUD_C1_UP_THR,                 0x00007000},
+	{AUD_C1_LO_THR,                 0x00005400},
+	{AUD_C2_UP_THR,                 0x00005400},
+	{AUD_C2_LO_THR,                 0x00003000},
+		{ /* end of list */ },
+	};
+
+	static const struct rlist a2_dk[] = {
+	{AUD_DMD_RA_DDS,                0x002a4f2f},
+	{AUD_C1_UP_THR,                 0x00007000},
+	{AUD_C1_LO_THR,                 0x00005400},
+	{AUD_C2_UP_THR,                 0x00005400},
+	{AUD_C2_LO_THR,                 0x00003000},
+	{AUD_DN0_FREQ,                  0x00003a1c},
+	{AUD_DN2_FREQ,                  0x0000d2e0},
+		{ /* end of list */ },
+	};
+/* unknown, probably NTSC-M */
+	static const struct rlist a2_m[] = {
+	{AUD_DMD_RA_DDS,                0x002a0425},
+	{AUD_C1_UP_THR,                 0x00003c00},
+	{AUD_C1_LO_THR,                 0x00003000},
+	{AUD_C2_UP_THR,                 0x00006000},
+	{AUD_C2_LO_THR,                 0x00003c00},
+	{AUD_DEEMPH0_A0,                0x00007a80},
+	{AUD_DEEMPH1_A0,                0x00007a80},
+	{AUD_DEEMPH0_G0,                0x00001200},
+	{AUD_DEEMPH1_G0,                0x00001200},
+	{AUD_DN0_FREQ,                  0x0000283b},
+	{AUD_DN1_FREQ,                  0x00003418},
+	{AUD_DN2_FREQ,                  0x000029c7},
+	{AUD_POLY0_DDS_CONSTANT,        0x000a7540},
+		{ /* end of list */ },
+	};
+
+	static const struct rlist a2_deemph50[] = {
+	{AUD_DEEMPH0_G0,                0x00000380},
+	{AUD_DEEMPH1_G0,                0x00000380},
+	{AUD_DEEMPHGAIN_R,              0x000011e1},
+	{AUD_DEEMPHNUMER1_R,            0x0002a7bc},
+	{AUD_DEEMPHNUMER2_R,            0x0003023c},
+	{ /* end of list */ },
+	};
+
+	static const struct rlist a2_deemph75[] = {
+	{AUD_DEEMPH0_G0,                0x00000480},
+	{AUD_DEEMPH1_G0,                0x00000480},
+	{AUD_DEEMPHGAIN_R,              0x00009000},
+	{AUD_DEEMPHNUMER1_R,            0x000353de},
+	{AUD_DEEMPHNUMER2_R,            0x000001b1},
 		{ /* end of list */ },
 	};
 
-	set_audio_start(core, 0x0004, EN_DMTRX_SUMDIFF | EN_A2_AUTO_STEREO);
+	set_audio_start(core, SEL_A2);
 	set_audio_registers(core, a2_common);
 	switch (core->tvaudio) {
 	case WW_A2_BG:
 		dprintk("%s PAL-BG A2 (status: known-good)\n",__FUNCTION__);
-		set_audio_registers(core, a2_table1);
+	set_audio_registers(core, a2_bg);
+	set_audio_registers(core, a2_deemph50);
 		break;
 	case WW_A2_DK:
 		dprintk("%s PAL-DK A2 (status: known-good)\n",__FUNCTION__);
-		set_audio_registers(core, a2_table2);
+	set_audio_registers(core, a2_dk);
+	set_audio_registers(core, a2_deemph50);
 		break;
 	case WW_A2_M:
 		dprintk("%s NTSC-M A2 (status: unknown)\n",__FUNCTION__);
-		set_audio_registers(core, a2_table3);
+	set_audio_registers(core, a2_m);
+	set_audio_registers(core, a2_deemph75);
 		break;
 	};
-	set_audio_finish(core);
+
+	mode |= EN_FMRADIO_EN_RDS | EN_DMTRX_SUMDIFF;
+	set_audio_finish(core, mode);
 }
 
 static void set_audio_standard_EIAJ(struct cx88_core *core)
@@ -635,9 +658,9 @@ static void set_audio_standard_EIAJ(stru
 	};
 	dprintk("%s (status: unknown)\n",__FUNCTION__);
 
-	set_audio_start(core, 0x0002, EN_EIAJ_AUTO_STEREO);
+	set_audio_start(core, SEL_EIAJ);
 	set_audio_registers(core, eiaj);
-	set_audio_finish(core);
+	set_audio_finish(core, EN_EIAJ_AUTO_STEREO);
 }
 
 static void set_audio_standard_FM(struct cx88_core *core, enum cx88_deemph_type deemph)
@@ -683,7 +706,7 @@ static void set_audio_standard_FM(struct
 	};
 
 	dprintk("%s (status: unknown)\n",__FUNCTION__);
-	set_audio_start(core, 0x0020, EN_FMRADIO_AUTO_STEREO);
+	set_audio_start(core, SEL_FMRADIO);
 
 	switch (deemph)
 	{
@@ -700,7 +723,7 @@ static void set_audio_standard_FM(struct
 			break;
 	}
 
-	set_audio_finish(core);
+	set_audio_finish(core, EN_FMRADIO_AUTO_STEREO);
 }
 
 /* ----------------------------------------------------------- */
@@ -709,7 +732,7 @@ void cx88_set_tvaudio(struct cx88_core *
 {
 	switch (core->tvaudio) {
 	case WW_BTSC:
-		set_audio_standard_BTSC(core,0);
+		set_audio_standard_BTSC(core, 0, EN_BTSC_AUTO_STEREO);
 		break;
 	case WW_NICAM_BGDKL:
 		set_audio_standard_NICAM_L(core,0);
@@ -720,7 +743,7 @@ void cx88_set_tvaudio(struct cx88_core *
 	case WW_A2_BG:
 	case WW_A2_DK:
 	case WW_A2_M:
-		set_audio_standard_A2(core);
+	set_audio_standard_A2(core, EN_A2_FORCE_MONO1);
 		break;
 	case WW_EIAJ:
 		set_audio_standard_EIAJ(core);
@@ -734,7 +757,7 @@ void cx88_set_tvaudio(struct cx88_core *
 	case WW_NONE:
 	default:
 		printk("%s/0: unknown tv audio mode [%d]\n",
-		       core->name, core->tvaudio);
+		core->name, core->tvaudio);
 		break;
 	}
 	return;
@@ -769,6 +792,13 @@ void cx88_get_stereo(struct cx88_core *c
 			aud_ctl_names[cx_read(AUD_CTL) & 63]);
 	core->astat = reg;
 
+/* TODO
+       Reading from AUD_STATUS is not enough
+       for auto-detecting sap/dual-fm/nicam.
+       Add some code here later.
+*/
+
+# if 0
 	t->capability = V4L2_TUNER_CAP_STEREO | V4L2_TUNER_CAP_SAP |
 		V4L2_TUNER_CAP_LANG1 | V4L2_TUNER_CAP_LANG2;
 	t->rxsubchans = V4L2_TUNER_SUB_MONO;
@@ -779,7 +809,7 @@ void cx88_get_stereo(struct cx88_core *c
 		t->capability = V4L2_TUNER_CAP_STEREO |
 			V4L2_TUNER_CAP_SAP;
 		t->rxsubchans = V4L2_TUNER_SUB_STEREO;
- 		if (1 == pilot) {
+		if (1 == pilot) {
 			/* SAP */
 			t->rxsubchans |= V4L2_TUNER_SUB_SAP;
 		}
@@ -787,13 +817,13 @@ void cx88_get_stereo(struct cx88_core *c
 	case WW_A2_BG:
 	case WW_A2_DK:
 	case WW_A2_M:
- 		if (1 == pilot) {
+		if (1 == pilot) {
 			/* stereo */
 			t->rxsubchans = V4L2_TUNER_SUB_MONO | V4L2_TUNER_SUB_STEREO;
 			if (0 == mode)
 				t->audmode = V4L2_TUNER_MODE_STEREO;
 		}
- 		if (2 == pilot) {
+		if (2 == pilot) {
 			/* dual language -- FIXME */
 			t->rxsubchans = V4L2_TUNER_SUB_LANG1 | V4L2_TUNER_SUB_LANG2;
 			t->audmode = V4L2_TUNER_MODE_LANG1;
@@ -805,16 +835,17 @@ void cx88_get_stereo(struct cx88_core *c
 			t->rxsubchans |= V4L2_TUNER_SUB_STEREO;
 		}
 		break;
-        case WW_SYSTEM_L_AM:
-                if (0x0 == mode && !(cx_read(AUD_INIT) & 0x04)) {
-                        t->audmode = V4L2_TUNER_MODE_STEREO;
+	case WW_SYSTEM_L_AM:
+		if (0x0 == mode && !(cx_read(AUD_INIT) & 0x04)) {
+			t->audmode = V4L2_TUNER_MODE_STEREO;
 			t->rxsubchans |= V4L2_TUNER_SUB_STEREO;
 		}
-                break ;
+		break ;
 	default:
 		/* nothing */
 		break;
 	}
+# endif
 	return;
 }
 
@@ -835,16 +866,16 @@ void cx88_set_stereo(struct cx88_core *c
 	case WW_BTSC:
 		switch (mode) {
 		case V4L2_TUNER_MODE_MONO:
-			ctl  = EN_BTSC_FORCE_MONO;
-			mask = 0x3f;
+			set_audio_standard_BTSC(core, 0, EN_BTSC_FORCE_MONO);
 			break;
-		case V4L2_TUNER_MODE_SAP:
-			ctl  = EN_BTSC_FORCE_SAP;
-			mask = 0x3f;
+		case V4L2_TUNER_MODE_LANG1:
+			set_audio_standard_BTSC(core, 0, EN_BTSC_AUTO_STEREO);
+			break;
+		case V4L2_TUNER_MODE_LANG2:
+			set_audio_standard_BTSC(core, 1, EN_BTSC_FORCE_SAP);
 			break;
 		case V4L2_TUNER_MODE_STEREO:
-			ctl  = EN_BTSC_AUTO_STEREO;
-			mask = 0x3f;
+			set_audio_standard_BTSC(core, 0, EN_BTSC_FORCE_STEREO);
 			break;
 		}
 		break;
@@ -854,16 +885,13 @@ void cx88_set_stereo(struct cx88_core *c
 		switch (mode) {
 		case V4L2_TUNER_MODE_MONO:
 		case V4L2_TUNER_MODE_LANG1:
-			ctl  = EN_A2_FORCE_MONO1;
-			mask = 0x3f;
+		set_audio_standard_A2(core, EN_A2_FORCE_MONO1);
 			break;
 		case V4L2_TUNER_MODE_LANG2:
-			ctl  = EN_A2_AUTO_MONO2;
-			mask = 0x3f;
+		set_audio_standard_A2(core, EN_A2_FORCE_MONO2);
 			break;
 		case V4L2_TUNER_MODE_STEREO:
-			ctl  = EN_A2_AUTO_STEREO | EN_DMTRX_SUMR;
-			mask = 0x8bf;
+		set_audio_standard_A2(core, EN_A2_FORCE_STEREO);
 			break;
 		}
 		break;
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-vbi.c linux-2.6.13/drivers/media/video/cx88/cx88-vbi.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-vbi.c	2005-09-05 11:41:05.677507613 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-vbi.c	2005-09-05 11:49:08.293361574 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-vbi.c,v 1.17 2005/06/12 04:19:19 mchehab Exp $
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -upr linux-2.6.13.orig/drivers/media/video/cx88/cx88-video.c linux-2.6.13/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.13.orig/drivers/media/video/cx88/cx88-video.c	2005-09-05 11:41:05.678507240 -0500
+++ linux-2.6.13/drivers/media/video/cx88/cx88-video.c	2005-09-05 11:49:51.572206322 -0500
@@ -1,5 +1,4 @@
 /*
- * $Id: cx88-video.c,v 1.82 2005/07/22 05:13:34 mkrufky Exp $
  *
  * device driver for Conexant 2388x based TV cards
  * video4linux video interface
@@ -66,7 +65,7 @@ module_param(vid_limit,int,0644);
 MODULE_PARM_DESC(vid_limit,"capture memory limit in megabytes");
 
 #define dprintk(level,fmt, arg...)	if (video_debug >= level) \
-	printk(KERN_DEBUG "%s/0: " fmt, dev->core->name , ## arg)
+	printk(KERN_DEBUG "%s/0: " fmt, core->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 
@@ -326,22 +325,23 @@ static const int CX8800_CTLS = ARRAY_SIZ
 
 static int res_get(struct cx8800_dev *dev, struct cx8800_fh *fh, unsigned int bit)
 {
+	struct cx88_core *core = dev->core;
 	if (fh->resources & bit)
 		/* have it already allocated */
 		return 1;
 
 	/* is it free? */
-	down(&dev->lock);
+	down(&core->lock);
 	if (dev->resources & bit) {
 		/* no, someone else uses it */
-		up(&dev->lock);
+		up(&core->lock);
 		return 0;
 	}
 	/* it's free, grab it */
 	fh->resources  |= bit;
 	dev->resources |= bit;
 	dprintk(1,"res: get %d\n",bit);
-	up(&dev->lock);
+	up(&core->lock);
 	return 1;
 }
 
@@ -360,27 +360,29 @@ int res_locked(struct cx8800_dev *dev, u
 static
 void res_free(struct cx8800_dev *dev, struct cx8800_fh *fh, unsigned int bits)
 {
+	struct cx88_core *core = dev->core;
 	if ((fh->resources & bits) != bits)
 		BUG();
 
-	down(&dev->lock);
+	down(&core->lock);
 	fh->resources  &= ~bits;
 	dev->resources &= ~bits;
 	dprintk(1,"res: put %d\n",bits);
-	up(&dev->lock);
+	up(&core->lock);
 }
 
 /* ------------------------------------------------------------------ */
 
-static int video_mux(struct cx8800_dev *dev, unsigned int input)
+/* static int video_mux(struct cx8800_dev *dev, unsigned int input) */
+static int video_mux(struct cx88_core *core, unsigned int input)
 {
-	struct cx88_core *core = dev->core;
+	/* struct cx88_core *core = dev->core; */
 
 	dprintk(1,"video_mux: %d [vmux=%d,gpio=0x%x,0x%x,0x%x,0x%x]\n",
 		input, INPUT(input)->vmux,
 		INPUT(input)->gpio0,INPUT(input)->gpio1,
 		INPUT(input)->gpio2,INPUT(input)->gpio3);
-	dev->core->input = input;
+	core->input = input;
 	cx_andor(MO_INPUT_FORMAT, 0x03 << 14, INPUT(input)->vmux << 14);
 	cx_write(MO_GP3_IO, INPUT(input)->gpio3);
 	cx_write(MO_GP0_IO, INPUT(input)->gpio0);
@@ -413,9 +415,9 @@ static int start_video_dma(struct cx8800
 	struct cx88_core *core = dev->core;
 
 	/* setup fifo + format */
-	cx88_sram_channel_setup(dev->core, &cx88_sram_channels[SRAM_CH21],
+	cx88_sram_channel_setup(core, &cx88_sram_channels[SRAM_CH21],
 				buf->bpl, buf->risc.dma);
-	cx88_set_scale(dev->core, buf->vb.width, buf->vb.height, buf->vb.field);
+	cx88_set_scale(core, buf->vb.width, buf->vb.height, buf->vb.field);
 	cx_write(MO_COLOR_CTRL, buf->fmt->cxformat | ColorFormatGamma);
 
 	/* reset counter */
@@ -424,6 +426,14 @@ static int start_video_dma(struct cx8800
 
 	/* enable irqs */
 	cx_set(MO_PCI_INTMSK, core->pci_irqmask | 0x01);
+
+	/* Enables corresponding bits at PCI_INT_STAT:
+		bits 0 to 4: video, audio, transport stream, VIP, Host
+		bit 7: timer
+		bits 8 and 9: DMA complete for: SRC, DST
+		bits 10 and 11: BERR signal asserted for RISC: RD, WR
+		bits 12 to 15: BERR signal asserted for: BRDG, SRC, DST, IPB
+	 */
 	cx_set(MO_VID_INTMSK, 0x0f0011);
 
 	/* enable capture */
@@ -431,7 +441,7 @@ static int start_video_dma(struct cx8800
 
 	/* start dma */
 	cx_set(MO_DEV_CNTRL2, (1<<5));
-	cx_set(MO_VID_DMACNTRL, 0x11);
+	cx_set(MO_VID_DMACNTRL, 0x11); /* Planar Y and packed FIFO and RISC enable */
 
 	return 0;
 }
@@ -455,6 +465,7 @@ static int stop_video_dma(struct cx8800_
 static int restart_video_queue(struct cx8800_dev    *dev,
 			       struct cx88_dmaqueue *q)
 {
+	struct cx88_core *core = dev->core;
 	struct cx88_buffer *buf, *prev;
 	struct list_head *item;
 
@@ -524,12 +535,13 @@ buffer_prepare(struct videobuf_queue *q,
 {
 	struct cx8800_fh   *fh  = q->priv_data;
 	struct cx8800_dev  *dev = fh->dev;
+	struct cx88_core *core = dev->core;
 	struct cx88_buffer *buf = container_of(vb,struct cx88_buffer,vb);
 	int rc, init_buffer = 0;
 
 	BUG_ON(NULL == fh->fmt);
-	if (fh->width  < 48 || fh->width  > norm_maxw(dev->core->tvnorm) ||
-	    fh->height < 32 || fh->height > norm_maxh(dev->core->tvnorm))
+	if (fh->width  < 48 || fh->width  > norm_maxw(core->tvnorm) ||
+	    fh->height < 32 || fh->height > norm_maxh(core->tvnorm))
 		return -EINVAL;
 	buf->vb.size = (fh->width * fh->height * fh->fmt->depth) >> 3;
 	if (0 != buf->vb.baddr  &&  buf->vb.bsize < buf->vb.size)
@@ -609,6 +621,7 @@ buffer_queue(struct videobuf_queue *vq, 
 	struct cx88_buffer    *prev;
 	struct cx8800_fh      *fh   = vq->priv_data;
 	struct cx8800_dev     *dev  = fh->dev;
+	struct cx88_core      *core = dev->core;
 	struct cx88_dmaqueue  *q    = &dev->vidq;
 
 	/* add jump to stopper */
@@ -701,6 +714,7 @@ static int video_open(struct inode *inod
 {
 	int minor = iminor(inode);
 	struct cx8800_dev *h,*dev = NULL;
+	struct cx88_core *core;
 	struct cx8800_fh *fh;
 	struct list_head *list;
 	enum v4l2_buf_type type = 0;
@@ -725,6 +739,8 @@ static int video_open(struct inode *inod
 	if (NULL == dev)
 		return -ENODEV;
 
+	core = dev->core;
+
 	dprintk(1,"open minor=%d radio=%d type=%s\n",
 		minor,radio,v4l2_type_names[type]);
 
@@ -755,17 +771,16 @@ static int video_open(struct inode *inod
 			    fh);
 
 	if (fh->radio) {
-		struct cx88_core *core = dev->core;
 		int board = core->board;
 		dprintk(1,"video_open: setting radio device\n");
 		cx_write(MO_GP3_IO, cx88_boards[board].radio.gpio3);
 		cx_write(MO_GP0_IO, cx88_boards[board].radio.gpio0);
 		cx_write(MO_GP1_IO, cx88_boards[board].radio.gpio1);
 		cx_write(MO_GP2_IO, cx88_boards[board].radio.gpio2);
-		dev->core->tvaudio = WW_FM;
+		core->tvaudio = WW_FM;
 		cx88_set_tvaudio(core);
 		cx88_set_stereo(core,V4L2_TUNER_MODE_STEREO,1);
-		cx88_call_i2c_clients(dev->core,AUDC_SET_RADIO,NULL);
+		cx88_call_i2c_clients(core,AUDC_SET_RADIO,NULL);
 	}
 
         return 0;
@@ -857,6 +872,9 @@ static int video_release(struct inode *i
 	videobuf_mmap_free(&fh->vbiq);
 	file->private_data = NULL;
 	kfree(fh);
+
+	cx88_call_i2c_clients (dev->core, TUNER_SET_STANDBY, NULL);
+
 	return 0;
 }
 
@@ -870,9 +888,10 @@ video_mmap(struct file *file, struct vm_
 
 /* ------------------------------------------------------------------ */
 
-static int get_control(struct cx8800_dev *dev, struct v4l2_control *ctl)
+/* static int get_control(struct cx8800_dev *dev, struct v4l2_control *ctl) */
+static int get_control(struct cx88_core *core, struct v4l2_control *ctl)
 {
-	struct cx88_core *core = dev->core;
+	/* struct cx88_core *core = dev->core; */
 	struct cx88_ctrl *c = NULL;
 	u32 value;
 	int i;
@@ -898,9 +917,10 @@ static int get_control(struct cx8800_dev
 	return 0;
 }
 
-static int set_control(struct cx8800_dev *dev, struct v4l2_control *ctl)
+/* static int set_control(struct cx8800_dev *dev, struct v4l2_control *ctl) */
+static int set_control(struct cx88_core *core, struct v4l2_control *ctl)
 {
-	struct cx88_core *core = dev->core;
+	/* struct cx88_core *core = dev->core; */
 	struct cx88_ctrl *c = NULL;
         u32 v_sat_value;
 	u32 value;
@@ -913,9 +933,9 @@ static int set_control(struct cx8800_dev
 		return -EINVAL;
 
 	if (ctl->value < c->v.minimum)
-		return -ERANGE;
+		ctl->value = c->v.minimum;
 	if (ctl->value > c->v.maximum)
-		return -ERANGE;
+		ctl->value = c->v.maximum;
 	switch (ctl->id) {
 	case V4L2_CID_AUDIO_BALANCE:
 		value = (ctl->value < 0x40) ? (0x40 - ctl->value) : ctl->value;
@@ -946,7 +966,8 @@ static int set_control(struct cx8800_dev
 	return 0;
 }
 
-static void init_controls(struct cx8800_dev *dev)
+/* static void init_controls(struct cx8800_dev *dev) */
+static void init_controls(struct cx88_core *core)
 {
 	static struct v4l2_control mute = {
 		.id    = V4L2_CID_AUDIO_MUTE,
@@ -969,11 +990,11 @@ static void init_controls(struct cx8800_
 		.value = 0x80,
 	};
 
-	set_control(dev,&mute);
-	set_control(dev,&volume);
-	set_control(dev,&hue);
-	set_control(dev,&contrast);
-	set_control(dev,&brightness);
+	set_control(core,&mute);
+	set_control(core,&volume);
+	set_control(core,&hue);
+	set_control(core,&contrast);
+	set_control(core,&brightness);
 }
 
 /* ------------------------------------------------------------------ */
@@ -1004,6 +1025,8 @@ static int cx8800_g_fmt(struct cx8800_de
 static int cx8800_try_fmt(struct cx8800_dev *dev, struct cx8800_fh *fh,
 			  struct v4l2_format *f)
 {
+	struct cx88_core *core = dev->core;
+
 	switch (f->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	{
@@ -1016,8 +1039,8 @@ static int cx8800_try_fmt(struct cx8800_
 			return -EINVAL;
 
 		field = f->fmt.pix.field;
-		maxw  = norm_maxw(dev->core->tvnorm);
-		maxh  = norm_maxh(dev->core->tvnorm);
+		maxw  = norm_maxw(core->tvnorm);
+		maxh  = norm_maxh(core->tvnorm);
 
 		if (V4L2_FIELD_ANY == field) {
 			field = (f->fmt.pix.height > maxh/2)
@@ -1101,12 +1124,14 @@ static int video_do_ioctl(struct inode *
 	if (video_debug > 1)
 		cx88_print_ioctl(core->name,cmd);
 	switch (cmd) {
+
+	/* --- capabilities ------------------------------------------ */
 	case VIDIOC_QUERYCAP:
 	{
 		struct v4l2_capability *cap = arg;
 
 		memset(cap,0,sizeof(*cap));
-                strcpy(cap->driver, "cx8800");
+		strcpy(cap->driver, "cx8800");
 		strlcpy(cap->card, cx88_boards[core->board].name,
 			sizeof(cap->card));
 		sprintf(cap->bus_info,"PCI:%s",pci_name(dev->pci));
@@ -1116,12 +1141,128 @@ static int video_do_ioctl(struct inode *
 			V4L2_CAP_READWRITE     |
 			V4L2_CAP_STREAMING     |
 			V4L2_CAP_VBI_CAPTURE   |
+			V4L2_CAP_VIDEO_OVERLAY |
 			0;
 		if (UNSET != core->tuner_type)
 			cap->capabilities |= V4L2_CAP_TUNER;
 		return 0;
 	}
 
+	/* --- capture ioctls ---------------------------------------- */
+	case VIDIOC_ENUM_FMT:
+	{
+		struct v4l2_fmtdesc *f = arg;
+		enum v4l2_buf_type type;
+		unsigned int index;
+
+		index = f->index;
+		type  = f->type;
+		switch (type) {
+		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
+			if (index >= ARRAY_SIZE(formats))
+				return -EINVAL;
+			memset(f,0,sizeof(*f));
+			f->index = index;
+			f->type  = type;
+			strlcpy(f->description,formats[index].name,sizeof(f->description));
+			f->pixelformat = formats[index].fourcc;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return 0;
+	}
+	case VIDIOC_G_FMT:
+	{
+		struct v4l2_format *f = arg;
+		return cx8800_g_fmt(dev,fh,f);
+	}
+	case VIDIOC_S_FMT:
+	{
+		struct v4l2_format *f = arg;
+		return cx8800_s_fmt(dev,fh,f);
+	}
+	case VIDIOC_TRY_FMT:
+	{
+		struct v4l2_format *f = arg;
+		return cx8800_try_fmt(dev,fh,f);
+	}
+
+	/* --- streaming capture ------------------------------------- */
+	case VIDIOCGMBUF:
+	{
+		struct video_mbuf *mbuf = arg;
+		struct videobuf_queue *q;
+		struct v4l2_requestbuffers req;
+		unsigned int i;
+
+		q = get_queue(fh);
+		memset(&req,0,sizeof(req));
+		req.type   = q->type;
+		req.count  = 8;
+		req.memory = V4L2_MEMORY_MMAP;
+		err = videobuf_reqbufs(q,&req);
+		if (err < 0)
+			return err;
+		memset(mbuf,0,sizeof(*mbuf));
+		mbuf->frames = req.count;
+		mbuf->size   = 0;
+		for (i = 0; i < mbuf->frames; i++) {
+			mbuf->offsets[i]  = q->bufs[i]->boff;
+			mbuf->size       += q->bufs[i]->bsize;
+		}
+		return 0;
+	}
+	case VIDIOC_REQBUFS:
+		return videobuf_reqbufs(get_queue(fh), arg);
+
+	case VIDIOC_QUERYBUF:
+		return videobuf_querybuf(get_queue(fh), arg);
+
+	case VIDIOC_QBUF:
+		return videobuf_qbuf(get_queue(fh), arg);
+
+	case VIDIOC_DQBUF:
+		return videobuf_dqbuf(get_queue(fh), arg,
+					file->f_flags & O_NONBLOCK);
+
+	case VIDIOC_STREAMON:
+	{
+		int res = get_ressource(fh);
+
+		if (!res_get(dev,fh,res))
+			return -EBUSY;
+		return videobuf_streamon(get_queue(fh));
+	}
+	case VIDIOC_STREAMOFF:
+	{
+		int res = get_ressource(fh);
+
+		err = videobuf_streamoff(get_queue(fh));
+		if (err < 0)
+			return err;
+		res_free(dev,fh,res);
+		return 0;
+	}
+
+	default:
+		return cx88_do_ioctl( inode, file, fh->radio, core, cmd, arg, video_do_ioctl );
+	}
+	return 0;
+}
+
+int cx88_do_ioctl(struct inode *inode, struct file *file, int radio,
+                  struct cx88_core *core, unsigned int cmd, void *arg, v4l2_kioctl driver_ioctl)
+{
+	int err;
+
+	if (video_debug > 1)
+		cx88_print_ioctl(core->name,cmd);
+	printk( KERN_INFO "CORE IOCTL: 0x%x\n", cmd );
+	cx88_print_ioctl(core->name,cmd);
+	dprintk( 1, "CORE IOCTL: 0x%x\n", cmd );
+
+	switch (cmd) {
 	/* ---------- tv norms ---------- */
 	case VIDIOC_ENUMSTD:
 	{
@@ -1156,9 +1297,9 @@ static int video_do_ioctl(struct inode *
 		if (i == ARRAY_SIZE(tvnorms))
 			return -EINVAL;
 
-		down(&dev->lock);
-		cx88_set_tvnorm(dev->core,&tvnorms[i]);
-		up(&dev->lock);
+		down(&core->lock);
+		cx88_set_tvnorm(core,&tvnorms[i]);
+		up(&core->lock);
 		return 0;
 	}
 
@@ -1199,7 +1340,7 @@ static int video_do_ioctl(struct inode *
 	{
 		unsigned int *i = arg;
 
-		*i = dev->core->input;
+		*i = core->input;
 		return 0;
 	}
 	case VIDIOC_S_INPUT:
@@ -1208,55 +1349,15 @@ static int video_do_ioctl(struct inode *
 
 		if (*i >= 4)
 			return -EINVAL;
-		down(&dev->lock);
+		down(&core->lock);
 		cx88_newstation(core);
-		video_mux(dev,*i);
-		up(&dev->lock);
+		video_mux(core,*i);
+		up(&core->lock);
 		return 0;
 	}
 
 
 
-	/* --- capture ioctls ---------------------------------------- */
-	case VIDIOC_ENUM_FMT:
-	{
-		struct v4l2_fmtdesc *f = arg;
-		enum v4l2_buf_type type;
-		unsigned int index;
-
-		index = f->index;
-		type  = f->type;
-		switch (type) {
-		case V4L2_BUF_TYPE_VIDEO_CAPTURE:
-			if (index >= ARRAY_SIZE(formats))
-				return -EINVAL;
-			memset(f,0,sizeof(*f));
-			f->index = index;
-			f->type  = type;
-			strlcpy(f->description,formats[index].name,sizeof(f->description));
-			f->pixelformat = formats[index].fourcc;
-			break;
-		default:
-			return -EINVAL;
-		}
-		return 0;
-	}
-	case VIDIOC_G_FMT:
-	{
-		struct v4l2_format *f = arg;
-		return cx8800_g_fmt(dev,fh,f);
-	}
-	case VIDIOC_S_FMT:
-	{
-		struct v4l2_format *f = arg;
-		return cx8800_s_fmt(dev,fh,f);
-	}
-	case VIDIOC_TRY_FMT:
-	{
-		struct v4l2_format *f = arg;
-		return cx8800_try_fmt(dev,fh,f);
-	}
-
 	/* --- controls ---------------------------------------------- */
 	case VIDIOC_QUERYCTRL:
 	{
@@ -1277,9 +1378,9 @@ static int video_do_ioctl(struct inode *
 		return 0;
 	}
 	case VIDIOC_G_CTRL:
-		return get_control(dev,arg);
+		return get_control(core,arg);
 	case VIDIOC_S_CTRL:
-		return set_control(dev,arg);
+		return set_control(core,arg);
 
 	/* --- tuner ioctls ------------------------------------------ */
 	case VIDIOC_G_TUNER:
@@ -1323,10 +1424,11 @@ static int video_do_ioctl(struct inode *
 		if (UNSET == core->tuner_type)
 			return -EINVAL;
 
-		f->type = fh->radio ? V4L2_TUNER_RADIO : V4L2_TUNER_ANALOG_TV;
-		f->frequency = dev->freq;
+		/* f->type = fh->radio ? V4L2_TUNER_RADIO : V4L2_TUNER_ANALOG_TV; */
+		f->type = radio ? V4L2_TUNER_RADIO : V4L2_TUNER_ANALOG_TV;
+		f->frequency = core->freq;
 
-		cx88_call_i2c_clients(dev->core,VIDIOC_G_FREQUENCY,f);
+		cx88_call_i2c_clients(core,VIDIOC_G_FREQUENCY,f);
 
 		return 0;
 	}
@@ -1338,83 +1440,26 @@ static int video_do_ioctl(struct inode *
 			return -EINVAL;
 		if (f->tuner != 0)
 			return -EINVAL;
-		if (0 == fh->radio && f->type != V4L2_TUNER_ANALOG_TV)
+		if (0 == radio && f->type != V4L2_TUNER_ANALOG_TV)
 			return -EINVAL;
-		if (1 == fh->radio && f->type != V4L2_TUNER_RADIO)
+		if (1 == radio && f->type != V4L2_TUNER_RADIO)
 			return -EINVAL;
-		down(&dev->lock);
-		dev->freq = f->frequency;
+		down(&core->lock);
+		core->freq = f->frequency;
 		cx88_newstation(core);
-		cx88_call_i2c_clients(dev->core,VIDIOC_S_FREQUENCY,f);
+		cx88_call_i2c_clients(core,VIDIOC_S_FREQUENCY,f);
 
 		/* When changing channels it is required to reset TVAUDIO */
 		msleep (10);
 		cx88_set_tvaudio(core);
 
-		up(&dev->lock);
-		return 0;
-	}
-
-	/* --- streaming capture ------------------------------------- */
-	case VIDIOCGMBUF:
-	{
-		struct video_mbuf *mbuf = arg;
-		struct videobuf_queue *q;
-		struct v4l2_requestbuffers req;
-		unsigned int i;
-
-		q = get_queue(fh);
-		memset(&req,0,sizeof(req));
-		req.type   = q->type;
-		req.count  = 8;
-		req.memory = V4L2_MEMORY_MMAP;
-		err = videobuf_reqbufs(q,&req);
-		if (err < 0)
-			return err;
-		memset(mbuf,0,sizeof(*mbuf));
-		mbuf->frames = req.count;
-		mbuf->size   = 0;
-		for (i = 0; i < mbuf->frames; i++) {
-			mbuf->offsets[i]  = q->bufs[i]->boff;
-			mbuf->size       += q->bufs[i]->bsize;
-		}
-		return 0;
-	}
-	case VIDIOC_REQBUFS:
-		return videobuf_reqbufs(get_queue(fh), arg);
-
-	case VIDIOC_QUERYBUF:
-		return videobuf_querybuf(get_queue(fh), arg);
-
-	case VIDIOC_QBUF:
-		return videobuf_qbuf(get_queue(fh), arg);
-
-	case VIDIOC_DQBUF:
-		return videobuf_dqbuf(get_queue(fh), arg,
-				      file->f_flags & O_NONBLOCK);
-
-	case VIDIOC_STREAMON:
-	{
-		int res = get_ressource(fh);
-
-                if (!res_get(dev,fh,res))
-			return -EBUSY;
-		return videobuf_streamon(get_queue(fh));
-	}
-	case VIDIOC_STREAMOFF:
-	{
-		int res = get_ressource(fh);
-
-		err = videobuf_streamoff(get_queue(fh));
-		if (err < 0)
-			return err;
-		res_free(dev,fh,res);
+		up(&core->lock);
 		return 0;
 	}
 
 	default:
 		return v4l_compat_translate_ioctl(inode,file,cmd,arg,
-						  video_do_ioctl);
+						  driver_ioctl);
 	}
 	return 0;
 }
@@ -1461,7 +1506,7 @@ static int radio_do_ioctl(struct inode *
 		memset(t,0,sizeof(*t));
 		strcpy(t->name, "Radio");
 
-		cx88_call_i2c_clients(dev->core,VIDIOC_G_TUNER,t);
+		cx88_call_i2c_clients(core,VIDIOC_G_TUNER,t);
 		return 0;
 	}
 	case VIDIOC_ENUMINPUT:
@@ -1501,8 +1546,8 @@ static int radio_do_ioctl(struct inode *
 		if (v->tuner) /* Only tuner 0 */
 			return -EINVAL;
 
-		cx88_call_i2c_clients(dev->core,VIDIOCSTUNER,v);
-                return 0;
+		cx88_call_i2c_clients(core,VIDIOCSTUNER,v);
+		return 0;
 	}
 	case VIDIOC_S_TUNER:
 	{
@@ -1511,7 +1556,7 @@ static int radio_do_ioctl(struct inode *
 		if (0 != t->index)
 			return -EINVAL;
 
-		cx88_call_i2c_clients(dev->core,VIDIOC_S_TUNER,t);
+		cx88_call_i2c_clients(core,VIDIOC_S_TUNER,t);
 
 		return 0;
 	}
@@ -1569,7 +1614,7 @@ static void cx8800_vid_timeout(unsigned 
 	struct cx88_buffer *buf;
 	unsigned long flags;
 
-	cx88_sram_channel_dump(dev->core, &cx88_sram_channels[SRAM_CH21]);
+	cx88_sram_channel_dump(core, &cx88_sram_channels[SRAM_CH21]);
 
 	cx_clear(MO_VID_DMACNTRL, 0x11);
 	cx_clear(VID_CAPTURE_CONTROL, 0x06);
@@ -1614,14 +1659,14 @@ static void cx8800_vid_irq(struct cx8800
 		printk(KERN_WARNING "%s/0: video risc op code error\n",core->name);
 		cx_clear(MO_VID_DMACNTRL, 0x11);
 		cx_clear(VID_CAPTURE_CONTROL, 0x06);
-		cx88_sram_channel_dump(dev->core, &cx88_sram_channels[SRAM_CH21]);
+		cx88_sram_channel_dump(core, &cx88_sram_channels[SRAM_CH21]);
 	}
 
 	/* risc1 y */
 	if (status & 0x01) {
 		spin_lock(&dev->slock);
 		count = cx_read(MO_VIDY_GPCNT);
-		cx88_wakeup(dev->core, &dev->vidq, count);
+		cx88_wakeup(core, &dev->vidq, count);
 		spin_unlock(&dev->slock);
 	}
 
@@ -1629,7 +1674,7 @@ static void cx8800_vid_irq(struct cx8800
 	if (status & 0x08) {
 		spin_lock(&dev->slock);
 		count = cx_read(MO_VBI_GPCNT);
-		cx88_wakeup(dev->core, &dev->vbiq, count);
+		cx88_wakeup(core, &dev->vbiq, count);
 		spin_unlock(&dev->slock);
 	}
 
@@ -1798,7 +1843,6 @@ static int __devinit cx8800_initdev(stru
 	}
 
 	/* initialize driver struct */
-        init_MUTEX(&dev->lock);
 	spin_lock_init(&dev->slock);
 	core->tvnorm = tvnorms;
 
@@ -1835,6 +1879,7 @@ static int __devinit cx8800_initdev(stru
 		request_module("tuner");
 	if (core->tda9887_conf)
 		request_module("tda9887");
+
 	/* register v4l devices */
 	dev->video_dev = cx88_vdev_init(core,dev->pci,
 					&cx8800_video_template,"video");
@@ -1878,11 +1923,11 @@ static int __devinit cx8800_initdev(stru
 	pci_set_drvdata(pci_dev,dev);
 
 	/* initial device configuration */
-	down(&dev->lock);
-	init_controls(dev);
-	cx88_set_tvnorm(dev->core,tvnorms);
-	video_mux(dev,0);
-	up(&dev->lock);
+	down(&core->lock);
+	init_controls(core);
+	cx88_set_tvnorm(core,tvnorms);
+	video_mux(core,0);
+	up(&core->lock);
 
 	/* start tvaudio thread */
 	if (core->tuner_type != TUNER_ABSENT)
@@ -1902,14 +1947,15 @@ fail_free:
 static void __devexit cx8800_finidev(struct pci_dev *pci_dev)
 {
         struct cx8800_dev *dev = pci_get_drvdata(pci_dev);
+	struct cx88_core *core = dev->core;
 
 	/* stop thread */
-	if (dev->core->kthread) {
-		kthread_stop(dev->core->kthread);
-		dev->core->kthread = NULL;
+	if (core->kthread) {
+		kthread_stop(core->kthread);
+		core->kthread = NULL;
 	}
 
-	cx88_shutdown(dev->core); /* FIXME */
+	cx88_shutdown(core); /* FIXME */
 	pci_disable_device(pci_dev);
 
 	/* unregister stuff */
@@ -1921,7 +1967,7 @@ static void __devexit cx8800_finidev(str
 	/* free memory */
 	btcx_riscmem_free(dev->pci,&dev->vidq.stopper);
 	list_del(&dev->devlist);
-	cx88_core_put(dev->core,dev->pci);
+	cx88_core_put(core,dev->pci);
 	kfree(dev);
 }
 
@@ -1945,7 +1991,7 @@ static int cx8800_suspend(struct pci_dev
 	spin_unlock(&dev->slock);
 
 	/* FIXME -- shutdown device */
-	cx88_shutdown(dev->core);
+	cx88_shutdown(core);
 
 	pci_save_state(pci_dev);
 	if (0 != pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state))) {
@@ -1968,7 +2014,7 @@ static int cx8800_resume(struct pci_dev 
 	pci_restore_state(pci_dev);
 
 	/* FIXME: re-initialize hardware */
-	cx88_reset(dev->core);
+	cx88_reset(core);
 
 	/* restart video+vbi capture */
 	spin_lock(&dev->slock);
@@ -2030,6 +2076,8 @@ static void cx8800_fini(void)
 module_init(cx8800_init);
 module_exit(cx8800_fini);
 
+EXPORT_SYMBOL(cx88_do_ioctl);
+
 /* ----------------------------------------------------------- */
 /*
  * Local variables:

--=_431cb7f6.3NIzBq//K4Jutu/EC3ksBZzq52vSlQGeUFaJtrE06FyAiVns--
