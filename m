Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWAWU2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWAWU2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWAWU2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:28:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39365 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932474AbWAWU2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:28:09 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Adrian Bunk <bunk@stusta.de>,
       Patrick Boettcher <pb@linuxtv.org>, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 12/16] drivers/media/dvb/ possible cleanups
Date: Mon, 23 Jan 2006 18:24:45 -0200
Message-id: <20060123202445.PS18141000012@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

- Make needlessly global code static
- #if 0 the following unused global functions:
- b2c2/flexcop-dma.c: flexcop_dma_control_packet_irq()
- b2c2/flexcop-dma.c: flexcop_dma_config_packet_count()

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/b2c2/flexcop-common.h      |    2 -
 drivers/media/dvb/b2c2/flexcop-dma.c         |   35 --------------------------
 drivers/media/dvb/b2c2/flexcop-misc.c        |    6 ++--
 drivers/media/dvb/b2c2/flexcop-reg.h         |    4 ---
 drivers/media/dvb/dvb-usb/cxusb.c            |    8 +++---
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 ++++--
 drivers/media/dvb/dvb-usb/dvb-usb.h          |    1 -
 drivers/media/dvb/dvb-usb/vp702x.c           |    6 +++-
 drivers/media/dvb/dvb-usb/vp702x.h           |    2 -
 drivers/media/dvb/ttpci/av7110.h             |    2 -
 drivers/media/dvb/ttpci/av7110_ir.c          |   26 ++++++++++---------
 11 files changed, 29 insertions(+), 71 deletions(-)

diff --git a/drivers/media/dvb/b2c2/flexcop-common.h b/drivers/media/dvb/b2c2/flexcop-common.h
index 344a3c8..7d7e161 100644
--- a/drivers/media/dvb/b2c2/flexcop-common.h
+++ b/drivers/media/dvb/b2c2/flexcop-common.h
@@ -116,11 +116,9 @@ void flexcop_dma_free(struct flexcop_dma
 
 int flexcop_dma_control_timer_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_control_size_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
-int flexcop_dma_control_packet_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_config(struct flexcop_device *fc, struct flexcop_dma *dma, flexcop_dma_index_t dma_idx);
 int flexcop_dma_xfer_control(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, flexcop_dma_addr_index_t index, int onoff);
 int flexcop_dma_config_timer(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 cycles);
-int flexcop_dma_config_packet_count(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 packets);
 
 /* from flexcop-eeprom.c */
 /* the PCI part uses this call to get the MAC address, the USB part has its own */
diff --git a/drivers/media/dvb/b2c2/flexcop-dma.c b/drivers/media/dvb/b2c2/flexcop-dma.c
index cf4ed1d..6f592bc 100644
--- a/drivers/media/dvb/b2c2/flexcop-dma.c
+++ b/drivers/media/dvb/b2c2/flexcop-dma.c
@@ -169,38 +169,3 @@ int flexcop_dma_config_timer(struct flex
 }
 EXPORT_SYMBOL(flexcop_dma_config_timer);
 
-/* packet IRQ does not exist in FCII or FCIIb - according to data book and tests */
-int flexcop_dma_control_packet_irq(struct flexcop_device *fc,
-		flexcop_dma_index_t no,
-		int onoff)
-{
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
-
-	deb_rdump("reg: %03x: %x\n",ctrl_208,v.raw);
-	if (no & FC_DMA_1)
-		v.ctrl_208.DMA1_Size_IRQ_Enable_sig = onoff;
-
-	if (no & FC_DMA_2)
-		v.ctrl_208.DMA2_Size_IRQ_Enable_sig = onoff;
-
-	fc->write_ibi_reg(fc,ctrl_208,v);
-	deb_rdump("reg: %03x: %x\n",ctrl_208,v.raw);
-
-	return 0;
-}
-EXPORT_SYMBOL(flexcop_dma_control_packet_irq);
-
-int flexcop_dma_config_packet_count(struct flexcop_device *fc,
-		flexcop_dma_index_t dma_idx,
-		u8 packets)
-{
-	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_004 : dma2_014;
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
-
-	flexcop_dma_remap(fc,dma_idx,1);
-
-	v.dma_0x4_remap.DMA_maxpackets = packets;
-	fc->write_ibi_reg(fc,r,v);
-	return 0;
-}
-EXPORT_SYMBOL(flexcop_dma_config_packet_count);
diff --git a/drivers/media/dvb/b2c2/flexcop-misc.c b/drivers/media/dvb/b2c2/flexcop-misc.c
index 62282d8..167583b 100644
--- a/drivers/media/dvb/b2c2/flexcop-misc.c
+++ b/drivers/media/dvb/b2c2/flexcop-misc.c
@@ -36,14 +36,14 @@ void flexcop_determine_revision(struct f
 	/* bus parts have to decide if hw pid filtering is used or not. */
 }
 
-const char *flexcop_revision_names[] = {
+static const char *flexcop_revision_names[] = {
 	"Unkown chip",
 	"FlexCopII",
 	"FlexCopIIb",
 	"FlexCopIII",
 };
 
-const char *flexcop_device_names[] = {
+static const char *flexcop_device_names[] = {
 	"Unkown device",
 	"Air2PC/AirStar 2 DVB-T",
 	"Air2PC/AirStar 2 ATSC 1st generation",
@@ -54,7 +54,7 @@ const char *flexcop_device_names[] = {
 	"Air2PC/AirStar 2 ATSC 3rd generation (HD5000)",
 };
 
-const char *flexcop_bus_names[] = {
+static const char *flexcop_bus_names[] = {
 	"USB",
 	"PCI",
 };
diff --git a/drivers/media/dvb/b2c2/flexcop-reg.h b/drivers/media/dvb/b2c2/flexcop-reg.h
index 3153f95..491f9bd 100644
--- a/drivers/media/dvb/b2c2/flexcop-reg.h
+++ b/drivers/media/dvb/b2c2/flexcop-reg.h
@@ -16,8 +16,6 @@ typedef enum {
 	FLEXCOP_III,
 } flexcop_revision_t;
 
-extern const char *flexcop_revision_names[];
-
 typedef enum {
 	FC_UNK = 0,
 	FC_AIR_DVB,
@@ -34,8 +32,6 @@ typedef enum {
 	FC_PCI,
 } flexcop_bus_t;
 
-extern const char *flexcop_device_names[];
-
 /* FlexCop IBI Registers */
 #if defined(__LITTLE_ENDIAN)
 	#include "flexcop_ibi_value_le.h"
diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/cxusb.c
index a7fb06f..f140037 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -184,7 +184,7 @@ static int cxusb_rc_query(struct dvb_usb
 	return 0;
 }
 
-struct dvb_usb_rc_key dvico_mce_rc_keys[] = {
+static struct dvb_usb_rc_key dvico_mce_rc_keys[] = {
 	{ 0xfe, 0x02, KEY_TV },
 	{ 0xfe, 0x0e, KEY_MP3 },
 	{ 0xfe, 0x1a, KEY_DVD },
@@ -273,7 +273,7 @@ static int cxusb_mt352_demod_init(struct
 	return 0;
 }
 
-struct cx22702_config cxusb_cx22702_config = {
+static struct cx22702_config cxusb_cx22702_config = {
 	.demod_address = 0x63,
 
 	.output_mode = CX22702_PARALLEL_OUTPUT,
@@ -282,13 +282,13 @@ struct cx22702_config cxusb_cx22702_conf
 	.pll_set  = dvb_usb_pll_set_i2c,
 };
 
-struct lgdt330x_config cxusb_lgdt330x_config = {
+static struct lgdt330x_config cxusb_lgdt330x_config = {
 	.demod_address = 0x0e,
 	.demod_chip    = LGDT3303,
 	.pll_set       = dvb_usb_pll_set_i2c,
 };
 
-struct mt352_config cxusb_dee1601_config = {
+static struct mt352_config cxusb_dee1601_config = {
 	.demod_address = 0x0f,
 	.demod_init    = cxusb_dee1601_demod_init,
 	.pll_set       = dvb_usb_pll_set,
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c b/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c
index 8535895..9222b0a 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c
+++ b/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c
@@ -24,6 +24,9 @@ static struct usb_cypress_controller cyp
 	{ .id = CYPRESS_FX2,     .name = "Cypress FX2",     .cpu_cs_register = 0xe600 },
 };
 
+static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
+			       int *pos);
+
 /*
  * load a firmware packet to the device
  */
@@ -112,7 +115,8 @@ int dvb_usb_download_firmware(struct usb
 	return ret;
 }
 
-int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx, int *pos)
+static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
+			       int *pos)
 {
 	u8 *b = (u8 *) &fw->data[*pos];
 	int data_offs = 4;
@@ -142,5 +146,3 @@ int dvb_usb_get_hexline(const struct fir
 
 	return *pos;
 }
-EXPORT_SYMBOL(dvb_usb_get_hexline);
-
diff --git a/drivers/media/dvb/dvb-usb/dvb-usb.h b/drivers/media/dvb/dvb-usb/dvb-usb.h
index dd56839..5e5d21a 100644
--- a/drivers/media/dvb/dvb-usb/dvb-usb.h
+++ b/drivers/media/dvb/dvb-usb/dvb-usb.h
@@ -341,7 +341,6 @@ struct hexline {
 	u8 data[255];
 	u8 chk;
 };
-extern int dvb_usb_get_hexline(const struct firmware *, struct hexline *, int *);
 extern int usb_cypress_load_firmware(struct usb_device *udev, const struct firmware *fw, int type);
 
 #endif
diff --git a/drivers/media/dvb/dvb-usb/vp702x.c b/drivers/media/dvb/dvb-usb/vp702x.c
index afa00fd..4a95eca 100644
--- a/drivers/media/dvb/dvb-usb/vp702x.c
+++ b/drivers/media/dvb/dvb-usb/vp702x.c
@@ -53,7 +53,8 @@ int vp702x_usb_in_op(struct dvb_usb_devi
 	return ret;
 }
 
-int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen)
+static int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value,
+			     u16 index, u8 *b, int blen)
 {
 	deb_xfer("out: req. %x, val: %x, ind: %x, buffer: ",req,value,index);
 	debug_dump(b,blen,deb_xfer);
@@ -88,7 +89,8 @@ unlock:
 	return ret;
 }
 
-int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec)
+static int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o,
+				int olen, u8 *i, int ilen, int msec)
 {
 	u8 bout[olen+2];
 	u8 bin[ilen+1];
diff --git a/drivers/media/dvb/dvb-usb/vp702x.h b/drivers/media/dvb/dvb-usb/vp702x.h
index a808d48..c2f97f9 100644
--- a/drivers/media/dvb/dvb-usb/vp702x.h
+++ b/drivers/media/dvb/dvb-usb/vp702x.h
@@ -101,8 +101,6 @@ extern int dvb_usb_vp702x_debug;
 extern struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d);
 
 extern int vp702x_usb_inout_op(struct dvb_usb_device *d, u8 *o, int olen, u8 *i, int ilen, int msec);
-extern int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec);
 extern int vp702x_usb_in_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
-extern int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
 
 #endif
diff --git a/drivers/media/dvb/ttpci/av7110.h b/drivers/media/dvb/ttpci/av7110.h
index 6ea30df..fafd25f 100644
--- a/drivers/media/dvb/ttpci/av7110.h
+++ b/drivers/media/dvb/ttpci/av7110.h
@@ -273,8 +273,6 @@ struct av7110 {
 extern int ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		       u16 subpid, u16 pcrpid);
 
-extern int av7110_setup_irc_config (struct av7110 *av7110, u32 ir_config);
-
 extern int av7110_ir_init(struct av7110 *av7110);
 extern void av7110_ir_exit(struct av7110 *av7110);
 
diff --git a/drivers/media/dvb/ttpci/av7110_ir.c b/drivers/media/dvb/ttpci/av7110_ir.c
index 9138132..617e4f6 100644
--- a/drivers/media/dvb/ttpci/av7110_ir.c
+++ b/drivers/media/dvb/ttpci/av7110_ir.c
@@ -155,6 +155,19 @@ static void input_repeat_key(unsigned lo
 }
 
 
+static int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
+{
+	int ret = 0;
+
+	dprintk(4, "%p\n", av7110);
+	if (av7110) {
+		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
+		av7110->ir_config = ir_config;
+	}
+	return ret;
+}
+
+
 static int av7110_ir_write_proc(struct file *file, const char __user *buffer,
 				unsigned long count, void *data)
 {
@@ -187,19 +200,6 @@ static int av7110_ir_write_proc(struct f
 }
 
 
-int av7110_setup_irc_config(struct av7110 *av7110, u32 ir_config)
-{
-	int ret = 0;
-
-	dprintk(4, "%p\n", av7110);
-	if (av7110) {
-		ret = av7110_fw_cmd(av7110, COMTYPE_PIDFILTER, SetIR, 1, ir_config);
-		av7110->ir_config = ir_config;
-	}
-	return ret;
-}
-
-
 static void ir_handler(struct av7110 *av7110, u32 ircom)
 {
 	dprintk(4, "ircommand = %08x\n", ircom);

