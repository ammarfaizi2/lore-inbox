Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWAGSND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWAGSND (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWAGSNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:13:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030529AbWAGSNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:13:00 -0500
Date: Sat, 7 Jan 2006 19:12:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/media/dvb/: possible cleanups
Message-ID: <20060107181258.GM3774@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - b2c2/flexcop-dma.c: flexcop_dma_control_packet_irq()
  - b2c2/flexcop-dma.c: flexcop_dma_config_packet_count()

Please review which of these changes do make sense and which conflict 
with pending patches.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/dvb/b2c2/flexcop-common.h      |    2 -
 drivers/media/dvb/b2c2/flexcop-dma.c         |    4 ++
 drivers/media/dvb/b2c2/flexcop-misc.c        |    6 ++--
 drivers/media/dvb/b2c2/flexcop-reg.h         |    4 --
 drivers/media/dvb/bt8xx/dst.c                |   19 +++++--------
 drivers/media/dvb/bt8xx/dst_common.h         |    5 ---
 drivers/media/dvb/dvb-usb/cxusb.c            |    2 -
 drivers/media/dvb/dvb-usb/dvb-usb-firmware.c |    8 +++--
 drivers/media/dvb/dvb-usb/dvb-usb.h          |    1 
 drivers/media/dvb/dvb-usb/vp702x.c           |    6 ++--
 drivers/media/dvb/dvb-usb/vp702x.h           |    2 -
 drivers/media/dvb/ttpci/av7110.h             |    2 -
 drivers/media/dvb/ttpci/av7110_ir.c          |   26 +++++++++----------
 13 files changed, 38 insertions(+), 49 deletions(-)

--- linux-2.6.15-mm2-full/drivers/media/dvb/bt8xx/dst_common.h.old	2006-01-07 16:51:59.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/bt8xx/dst_common.h	2006-01-07 16:54:49.000000000 +0100
@@ -139,10 +139,8 @@
 };
 
 int rdc_reset_state(struct dst_state *state);
-int rdc_8820_reset(struct dst_state *state);
 
 int dst_wait_dst_ready(struct dst_state *state, u8 delay_mode);
-int dst_pio_enable(struct dst_state *state);
 int dst_pio_disable(struct dst_state *state);
 int dst_error_recovery(struct dst_state* state);
 int dst_error_bailout(struct dst_state *state);
@@ -153,9 +151,6 @@
 u8 dst_check_sum(u8 * buf, u32 len);
 struct dst_state* dst_attach(struct dst_state* state, struct dvb_adapter *dvb_adapter);
 int dst_ca_attach(struct dst_state *state, struct dvb_adapter *dvb_adapter);
-int dst_gpio_outb(struct dst_state* state, u32 mask, u32 enbb, u32 outhigh, int delay);
-
-int dst_command(struct dst_state* state, u8 * data, u8 len);
 
 
 #endif // DST_COMMON_H
--- linux-2.6.15-mm2-full/drivers/media/dvb/bt8xx/dst.c.old	2006-01-07 16:42:33.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/bt8xx/dst.c	2006-01-07 16:54:56.000000000 +0100
@@ -63,6 +63,7 @@
 	}										\
 } while(0)
 
+static int dst_command(struct dst_state *state, u8 *data, u8 len);
 
 static void dst_packsize(struct dst_state *state, int psize)
 {
@@ -72,7 +73,8 @@
 	bt878_device_control(state->bt, DST_IG_TS, &bits);
 }
 
-int dst_gpio_outb(struct dst_state *state, u32 mask, u32 enbb, u32 outhigh, int delay)
+static int dst_gpio_outb(struct dst_state *state, u32 mask, u32 enbb,
+			 u32 outhigh, int delay)
 {
 	union dst_gpio_packet enb;
 	union dst_gpio_packet bits;
@@ -101,9 +103,8 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(dst_gpio_outb);
 
-int dst_gpio_inb(struct dst_state *state, u8 *result)
+static int dst_gpio_inb(struct dst_state *state, u8 *result)
 {
 	union dst_gpio_packet rd_packet;
 	int err;
@@ -117,7 +118,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(dst_gpio_inb);
 
 int rdc_reset_state(struct dst_state *state)
 {
@@ -137,7 +137,7 @@
 }
 EXPORT_SYMBOL(rdc_reset_state);
 
-int rdc_8820_reset(struct dst_state *state)
+static int rdc_8820_reset(struct dst_state *state)
 {
 	dprintk(verbose, DST_DEBUG, 1, "Resetting DST");
 	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, 0, NO_DELAY) < 0) {
@@ -152,9 +152,8 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(rdc_8820_reset);
 
-int dst_pio_enable(struct dst_state *state)
+static int dst_pio_enable(struct dst_state *state)
 {
 	if (dst_gpio_outb(state, ~0, RDC_8820_PIO_0_ENABLE, 0, NO_DELAY) < 0) {
 		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
@@ -164,7 +163,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(dst_pio_enable);
 
 int dst_pio_disable(struct dst_state *state)
 {
@@ -602,7 +600,7 @@
 
 */
 
-struct dst_types dst_tlist[] = {
+static struct dst_types dst_tlist[] = {
 	{
 		.device_id = "200103A",
 		.offset = 0,
@@ -958,7 +956,7 @@
 	return 0;
 }
 
-int dst_command(struct dst_state *state, u8 *data, u8 len)
+static int dst_command(struct dst_state *state, u8 *data, u8 len)
 {
 	u8 reply;
 
@@ -1021,7 +1019,6 @@
 	return -EIO;
 
 }
-EXPORT_SYMBOL(dst_command);
 
 static int dst_get_signal(struct dst_state *state)
 {
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-common.h.old	2006-01-07 16:49:18.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-common.h	2006-01-07 16:49:28.000000000 +0100
@@ -116,11 +116,9 @@
 
 int flexcop_dma_control_timer_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_control_size_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
-int flexcop_dma_control_packet_irq(struct flexcop_device *fc, flexcop_dma_index_t no, int onoff);
 int flexcop_dma_config(struct flexcop_device *fc, struct flexcop_dma *dma, flexcop_dma_index_t dma_idx);
 int flexcop_dma_xfer_control(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, flexcop_dma_addr_index_t index, int onoff);
 int flexcop_dma_config_timer(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 cycles);
-int flexcop_dma_config_packet_count(struct flexcop_device *fc, flexcop_dma_index_t dma_idx, u8 packets);
 
 /* from flexcop-eeprom.c */
 /* the PCI part uses this call to get the MAC address, the USB part has its own */
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-dma.c.old	2006-01-07 16:49:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-dma.c	2006-01-07 16:50:25.000000000 +0100
@@ -169,6 +169,8 @@
 }
 EXPORT_SYMBOL(flexcop_dma_config_timer);
 
+#if 0
+
 /* packet IRQ does not exist in FCII or FCIIb - according to data book and tests */
 int flexcop_dma_control_packet_irq(struct flexcop_device *fc,
 		flexcop_dma_index_t no,
@@ -204,3 +206,5 @@
 	return 0;
 }
 EXPORT_SYMBOL(flexcop_dma_config_packet_count);
+
+#endif  /*  0  */
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-reg.h.old	2006-01-07 16:51:05.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-reg.h	2006-01-07 16:51:38.000000000 +0100
@@ -16,8 +16,6 @@
 	FLEXCOP_III,
 } flexcop_revision_t;
 
-extern const char *flexcop_revision_names[];
-
 typedef enum {
 	FC_UNK = 0,
 	FC_AIR_DVB,
@@ -34,8 +32,6 @@
 	FC_PCI,
 } flexcop_bus_t;
 
-extern const char *flexcop_device_names[];
-
 /* FlexCop IBI Registers */
 #if defined(__LITTLE_ENDIAN)
 	#include "flexcop_ibi_value_le.h"
--- linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-misc.c.old	2006-01-07 16:48:00.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/b2c2/flexcop-misc.c	2006-01-07 16:51:27.000000000 +0100
@@ -36,14 +36,14 @@
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
@@ -54,7 +54,7 @@
 	"Air2PC/AirStar 2 ATSC 3rd generation (HD5000)",
 };
 
-const char *flexcop_bus_names[] = {
+static const char *flexcop_bus_names[] = {
 	"USB",
 	"PCI",
 };
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/cxusb.c.old	2006-01-07 16:55:20.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/cxusb.c	2006-01-07 16:55:27.000000000 +0100
@@ -156,7 +156,7 @@
 	return 0;
 }
 
-struct cx22702_config cxusb_cx22702_config = {
+static struct cx22702_config cxusb_cx22702_config = {
 	.demod_address = 0x63,
 
 	.output_mode = CX22702_PARALLEL_OUTPUT,
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb.h.old	2006-01-07 16:56:12.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb.h	2006-01-07 16:56:18.000000000 +0100
@@ -341,6 +341,5 @@
 	u8 data[255];
 	u8 chk;
 };
-extern int dvb_usb_get_hexline(const struct firmware *, struct hexline *, int *);
 
 #endif
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c.old	2006-01-07 16:56:27.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c	2006-01-07 16:57:06.000000000 +0100
@@ -24,6 +24,9 @@
 	{ .id = CYPRESS_FX2,     .name = "Cypress FX2",     .cpu_cs_register = 0xe600 },
 };
 
+static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
+			       int *pos);
+
 /*
  * load a firmware packet to the device
  */
@@ -111,7 +114,8 @@
 	return ret;
 }
 
-int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx, int *pos)
+static int dvb_usb_get_hexline(const struct firmware *fw, struct hexline *hx,
+			       int *pos)
 {
 	u8 *b = (u8 *) &fw->data[*pos];
 	int data_offs = 4;
@@ -141,5 +145,3 @@
 
 	return *pos;
 }
-EXPORT_SYMBOL(dvb_usb_get_hexline);
-
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.h.old	2006-01-07 16:57:23.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.h	2006-01-07 16:58:15.000000000 +0100
@@ -102,8 +102,6 @@
 extern struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d);
 
 extern int vp702x_usb_inout_op(struct dvb_usb_device *d, u8 *o, int olen, u8 *i, int ilen, int msec);
-extern int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec);
 extern int vp702x_usb_in_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
-extern int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen);
 
 #endif
--- linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.c.old	2006-01-07 16:57:37.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/dvb-usb/vp702x.c	2006-01-07 16:58:27.000000000 +0100
@@ -53,7 +53,8 @@
 	return ret;
 }
 
-int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value, u16 index, u8 *b, int blen)
+static int vp702x_usb_out_op(struct dvb_usb_device *d, u8 req, u16 value,
+			     u16 index, u8 *b, int blen)
 {
 	deb_xfer("out: req. %x, val: %x, ind: %x, buffer: ",req,value,index);
 	debug_dump(b,blen,deb_xfer);
@@ -88,7 +89,8 @@
 	return ret;
 }
 
-int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o, int olen, u8 *i, int ilen, int msec)
+static int vp702x_usb_inout_cmd(struct dvb_usb_device *d, u8 cmd, u8 *o,
+				int olen, u8 *i, int ilen, int msec)
 {
 	u8 bout[olen+2];
 	u8 bin[ilen+1];
--- linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110.h.old	2006-01-07 16:59:33.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110.h	2006-01-07 16:59:39.000000000 +0100
@@ -261,8 +261,6 @@
 extern int ChangePIDs(struct av7110 *av7110, u16 vpid, u16 apid, u16 ttpid,
 		       u16 subpid, u16 pcrpid);
 
-extern int av7110_setup_irc_config (struct av7110 *av7110, u32 ir_config);
-
 extern int av7110_ir_init(struct av7110 *av7110);
 extern void av7110_ir_exit(struct av7110 *av7110);
 
--- linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110_ir.c.old	2006-01-07 16:59:47.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/media/dvb/ttpci/av7110_ir.c	2006-01-07 17:00:21.000000000 +0100
@@ -155,6 +155,19 @@
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
@@ -187,19 +200,6 @@
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

