Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTLSMgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTLSMe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:34:26 -0500
Received: from mail.directfb.org ([212.84.236.4]:31674 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262868AbTLSM2q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:46 -0500
Subject: [PATCH 9/12] Update TTUSB DEC driver
In-Reply-To: <10718369223748@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:43 +0100
Message-Id: <1071836923279@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - add support for the DEC3000-s (Alex Woods)
DVB: - use the hotplug firmware loader for 2.6 kernels instead of compiling the firmware into the module (Alex Woods)
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttusb-dec/Kconfig linux-2.6.0-p/drivers/media/dvb/ttusb-dec/Kconfig
--- linux-2.6.0/drivers/media/dvb/ttusb-dec/Kconfig	2003-12-18 03:58:17.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttusb-dec/Kconfig	2003-12-08 16:19:01.000000000 +0100
@@ -1,24 +1,26 @@
 config DVB_TTUSB_DEC
-	tristate "Technotrend/Hauppauge USB DEC2000-T devices"
-	depends on DVB_CORE && USB && !STANDALONE
+	tristate "Technotrend/Hauppauge USB DEC devices"
+	depends on DVB_CORE && USB && FW_LOADER
 	help
 	  Support for external USB adapters designed by Technotrend and
-	  produced by Hauppauge, shipped under the brand name 'DEC2000-T'.
+	  produced by Hauppauge, shipped under the brand name 'DEC2000-t'
+	  and 'DEC3000-s'.
 
           Even if these devices have a MPEG decoder built in, they transmit
 	  only compressed MPEG data over the USB bus, so you need
 	  an external software decoder to watch TV on your computer.	  
 
-	  Say Y if you own such a device and want to use it.
+	  The DEC devices require firmware in order to boot into a mode in
+	  which they are slaves to the PC.  See
+	  linux/Documentation/dvb/FIRMWARE for details.
+
+	  The firmware can be obtained and put into the default
+	  locations as follows:
 
-config DVB_TTUSB_DEC_FIRMWARE_FILE
-	string "Full pathname of dec2000t.bin firmware file"
-	depends on DVB_TTUSB_DEC
-	default "/etc/dvb/dec2000t.bin"
-	help
-	  The DEC2000-T requires a firmware in order to boot into a mode in
-	  which it is a slave to the PC.  The firmware file can obtained as
-	  follows:
 	    wget http://hauppauge.lightpath.net/de/dec215a.exe
 	    unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_T.bin
-	    mv STB_PC_T.bin /etc/dvb/dec2000t.bin
+	    mv STB_PC_T.bin /usr/lib/hotplug/firmware/dec2000t.bin
+	    unzip -j dec215a.exe Software/Oem/STB/App/Boot/STB_PC_S.bin
+	    mv STB_PC_S.bin /usr/lib/hotplug/firmware/dec3000s.bin
+
+	  Say Y if you own such a device and want to use it.
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttusb-dec/Makefile linux-2.6.0-p/drivers/media/dvb/ttusb-dec/Makefile
--- linux-2.6.0/drivers/media/dvb/ttusb-dec/Makefile	2003-12-18 03:58:56.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttusb-dec/Makefile	2003-12-08 16:19:01.000000000 +0100
@@ -1,11 +1,3 @@
-
-obj-$(CONFIG_DVB_TTUSB_DEC) += ttusb_dec.o dec2000_frontend.o
+obj-$(CONFIG_DVB_TTUSB_DEC) += ttusb_dec.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
-
-host-progs	:= fdump
-
-$(obj)/ttusb_dec.o: $(obj)/dsp_dec2000.h
-
-$(obj)/dsp_dec2000.h: $(patsubst "%", %, $(CONFIG_DVB_TTUSB_DEC_FIRMWARE_FILE)) $(obj)/fdump
-	$(obj)/fdump $< dsp_dec2000 > $@
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.0-p/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.0/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-12-18 03:59:37.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-12-10 13:50:16.000000000 +0100
@@ -19,19 +19,137 @@
  *
  */
 
-#include <linux/version.h>
+#include <asm/semaphore.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/usb.h>
+#include <linux/version.h>
+#include <linux/interrupt.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+#include <linux/firmware.h>
+#endif
 
-#include "ttusb_dec.h"
+#include "dmxdev.h"
+#include "dvb_demux.h"
+#include "dvb_i2c.h"
+#include "dvb_filter.h"
 #include "dvb_frontend.h"
+#include "dvb_net.h"
 
 static int debug = 0;
 
 #define dprintk	if (debug) printk
 
+#define DRIVER_NAME		"TechnoTrend/Hauppauge DEC USB"
+
+#define COMMAND_PIPE		0x03
+#define RESULT_PIPE		0x84
+#define STREAM_PIPE		0x88
+
+#define COMMAND_PACKET_SIZE	0x3c
+#define ARM_PACKET_SIZE		0x1000
+
+#define ISO_BUF_COUNT		0x04
+#define FRAMES_PER_ISO_BUF	0x04
+#define ISO_FRAME_SIZE		0x0380
+
+#define	MAX_AV_PES_LENGTH	6144
+
+#define LOF_HI			10600000
+#define LOF_LO			9750000
+
+enum ttusb_model {
+	TTUSB_DEC2000T,
+	TTUSB_DEC3000S
+};
+
+struct ttusb_dec {
+	enum ttusb_model		model;
+	char				*model_name;
+	char				*firmware_name;
+
+	/* DVB bits */
+	struct dvb_adapter		*adapter;
+	struct dmxdev			dmxdev;
+	struct dvb_demux		demux;
+	struct dmx_frontend		frontend;
+	struct dvb_i2c_bus		i2c_bus;
+	struct dvb_net			dvb_net;
+	struct dvb_frontend_info	*frontend_info;
+	int (*frontend_ioctl) (struct dvb_frontend *, unsigned int, void *);
+
+	u16			pid[DMX_PES_OTHER];
+	int			hi_band;
+
+	/* USB bits */
+	struct usb_device	*udev;
+	u8			trans_count;
+	unsigned int		command_pipe;
+	unsigned int		result_pipe;
+	unsigned int		stream_pipe;
+	int			interface;
+	struct semaphore	usb_sem;
+
+	void			*iso_buffer;
+	dma_addr_t		iso_dma_handle;
+	struct urb		*iso_urb[ISO_BUF_COUNT];
+	int			iso_stream_count;
+	struct semaphore	iso_sem;
+
+	u8			av_pes[MAX_AV_PES_LENGTH + 4];
+	int			av_pes_state;
+	int			av_pes_length;
+	int			av_pes_payload_length;
+
+	struct dvb_filter_pes2ts	a_pes2ts;
+	struct dvb_filter_pes2ts	v_pes2ts;
+
+	u8			v_pes[16 + MAX_AV_PES_LENGTH];
+	int			v_pes_length;
+	int			v_pes_postbytes;
+
+	struct list_head	urb_frame_list;
+	struct tasklet_struct	urb_tasklet;
+	spinlock_t		urb_frame_list_lock;
+
+	int			active; /* Loaded successfully */
+};
+
+struct urb_frame {
+	u8			data[ISO_FRAME_SIZE];
+	int			length;
+	struct list_head	urb_frame_list;
+};
+
+static struct dvb_frontend_info dec2000t_frontend_info = {
+	.name			= "TechnoTrend/Hauppauge DEC2000-t Frontend",
+	.type			= FE_OFDM,
+	.frequency_min		= 51000000,
+	.frequency_max		= 858000000,
+	.frequency_stepsize	= 62500,
+	.caps =	FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+		FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+		FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
+		FE_CAN_HIERARCHY_AUTO,
+};
+
+static struct dvb_frontend_info dec3000s_frontend_info = {
+	.name			= "TechnoTrend/Hauppauge DEC3000-s Frontend",
+	.type			= FE_QPSK,
+	.frequency_min		= 950000,
+	.frequency_max		= 2150000,
+	.frequency_stepsize	= 125,
+	.caps =	FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+		FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+		FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO |
+		FE_CAN_HIERARCHY_AUTO,
+};
+
 static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
 				  int param_length, const u8 params[],
 				  int *result_length, u8 cmd_result[])
@@ -129,22 +247,8 @@
 				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
 		dvb_filter_pes2ts_init(&dec->v_pes2ts, dec->pid[DMX_PES_VIDEO],
 				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
-}
-
-static int ttusb_dec_i2c_master_xfer(struct dvb_i2c_bus *i2c,
-				     const struct i2c_msg msgs[], int num)
-{
-	int result, i;
-
-	dprintk("%s\n", __FUNCTION__);
-
-	for (i = 0; i < num; i++)
-		if ((result = ttusb_dec_send_command(i2c->data, msgs[i].addr,
-						     msgs[i].len, msgs[i].buf,
-						     NULL, NULL)))
-			return result;
-
-	return 0;
+	dec->v_pes_length = 0;
+	dec->v_pes_postbytes = 0;
 }
 
 static void ttusb_dec_process_av_pes(struct ttusb_dec * dec, u8 * av_pes,
@@ -194,7 +298,8 @@
 				       &av_pes[12], prebytes);
 
 				dvb_filter_pes2ts(&dec->v_pes2ts, dec->v_pes,
-						  dec->v_pes_length + prebytes);
+						  dec->v_pes_length + prebytes,
+						  1);
 			}
 
 			if (av_pes[5] & 0x10) {
@@ -239,13 +344,14 @@
 
 			if (postbytes == 0)
 				dvb_filter_pes2ts(&dec->v_pes2ts, dec->v_pes,
-							  dec->v_pes_length);
+						  dec->v_pes_length, 1);
 
 			break;
 		}
 
 	case 0x02:		/* MainAudioStream */
-		dvb_filter_pes2ts(&dec->a_pes2ts, &av_pes[8], length - 12);
+		dvb_filter_pes2ts(&dec->a_pes2ts, &av_pes[8], length - 12,
+				  av_pes[5] & 0x10);
 		break;
 
 	default:
@@ -379,7 +485,11 @@
 		int i;
 
 		for (i = 0; i < FRAMES_PER_ISO_BUF; i++) {
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+			struct iso_packet_descriptor *d;
+#else
 			struct usb_iso_packet_descriptor *d;
+#endif
 			u8 *b;
 			int length;
 			struct urb_frame *frame;
@@ -432,9 +542,11 @@
 		urb->context = dec;
 		urb->complete = ttusb_dec_process_urb;
 		urb->pipe = dec->stream_pipe;
-		urb->transfer_flags = URB_ISO_ASAP;
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+		urb->transfer_flags = URB_ISO_ASAP;
 		urb->interval = 1;
+#else
+		urb->transfer_flags = USB_ISO_ASAP;
 #endif
 		urb->number_of_packets = FRAMES_PER_ISO_BUF;
 		urb->transfer_buffer_length = ISO_FRAME_SIZE *
@@ -502,8 +614,12 @@
 		ttusb_dec_setup_urbs(dec);
 
 		for (i = 0; i < ISO_BUF_COUNT; i++) {
-			if ((result = usb_submit_urb(dec->iso_urb[i]
-						    , GFP_KERNEL))) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+			if ((result = usb_submit_urb(dec->iso_urb[i],
+						     GFP_ATOMIC))) {
+#else
+			if ((result = usb_submit_urb(dec->iso_urb[i]))) {
+#endif
 				printk("%s: failed urb submission %d: "
 				       "error %d\n", __FUNCTION__, i, result);
 
@@ -659,7 +775,11 @@
 	for (i = 0; i < ISO_BUF_COUNT; i++) {
 		struct urb *urb;
 
-		if (!(urb = usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_KERNEL))) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+		if (!(urb = usb_alloc_urb(FRAMES_PER_ISO_BUF, GFP_ATOMIC))) {
+#else
+		if (!(urb = usb_alloc_urb(FRAMES_PER_ISO_BUF))) {
+#endif
 			ttusb_dec_free_iso_urbs(dec);
 			return -ENOMEM;
 		}
@@ -711,20 +831,61 @@
 	ttusb_dec_alloc_iso_urbs(dec);
 }
 
-#include "dsp_dec2000.h"
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+#include "dsp_dec2000t.h"
+#include "dsp_dec3000s.h"
+#endif
 
 static int ttusb_dec_boot_dsp(struct ttusb_dec *dec)
 {
 	int i, j, actual_len, result, size, trans_count;
-	u8 b0[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1b, 0xc8, 0x61,
+	u8 b0[] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 		    0x00 };
 	u8 b1[] = { 0x61 };
 	u8 b[ARM_PACKET_SIZE];
-	u32 dsp_length = htonl(sizeof(dsp_dec2000));
+	u8 *firmware = NULL;
+	size_t firmware_size = 0;
+	u32 firmware_csum = 0;
+	u32 firmware_size_nl;
+	u32 firmware_csum_nl;
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	const struct firmware *fw_entry = NULL;
+#endif
 
 	dprintk("%s\n", __FUNCTION__);
 
-	memcpy(b0, &dsp_length, 4);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
+	if (request_firmware(&fw_entry, dec->firmware_name, &dec->udev->dev)) {
+		printk(KERN_ERR "%s: Firmware (%s) unavailable.\n",
+		       __FUNCTION__, dec->firmware_name);
+		return 1;
+	}
+
+	firmware = fw_entry->data;
+	firmware_size = fw_entry->size;
+#endif
+	switch (dec->model) {
+		case TTUSB_DEC2000T:
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+			firmware = &dsp_dec2000t[0];
+			firmware_size = sizeof(dsp_dec2000t);
+#endif
+			firmware_csum = 0x1bc86100;
+			break;
+
+		case TTUSB_DEC3000S:
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+			firmware = &dsp_dec3000s[0];
+			firmware_size = sizeof(dsp_dec3000s);
+#endif
+			firmware_csum = 0x00000000;
+			break;
+	}
+
+	firmware_size_nl = htonl(firmware_size);
+	memcpy(b0, &firmware_size_nl, 4);
+	firmware_csum_nl = htonl(firmware_csum);
+	memcpy(&b0[6], &firmware_csum_nl, 4);
 
 	result = ttusb_dec_send_command(dec, 0x41, sizeof(b0), b0, NULL, NULL);
 
@@ -734,8 +895,8 @@
 	trans_count = 0;
 	j = 0;
 
-	for (i = 0; i < sizeof(dsp_dec2000); i += COMMAND_PACKET_SIZE) {
-		size = sizeof(dsp_dec2000) - i;
+	for (i = 0; i < firmware_size; i += COMMAND_PACKET_SIZE) {
+		size = firmware_size - i;
 		if (size > COMMAND_PACKET_SIZE)
 			size = COMMAND_PACKET_SIZE;
 
@@ -743,7 +904,7 @@
 		b[j + 1] = trans_count++;
 		b[j + 2] = 0xf0;
 		b[j + 3] = size;
-		memcpy(&b[j + 4], &dsp_dec2000[i], size);
+		memcpy(&b[j + 4], &firmware[i], size);
 
 		j += COMMAND_PACKET_SIZE + 4;
 
@@ -764,7 +925,7 @@
 	return result;
 }
 
-static void ttusb_dec_init_stb(struct ttusb_dec *dec)
+static int ttusb_dec_init_stb(struct ttusb_dec *dec)
 {
 	u8 c[COMMAND_PACKET_SIZE];
 	int c_length;
@@ -774,9 +935,14 @@
 
 	result = ttusb_dec_send_command(dec, 0x08, 0, NULL, &c_length, c);
 
-	if (!result)
+	if (!result) {
 		if (c_length != 0x0c || (c_length == 0x0c && c[9] != 0x63))
-			ttusb_dec_boot_dsp(dec);
+			return ttusb_dec_boot_dsp(dec);
+		else
+			return 0;
+	}
+	else
+		return result;
 }
 
 static int ttusb_dec_init_dvb(struct ttusb_dec *dec)
@@ -785,22 +951,13 @@
 
 	dprintk("%s\n", __FUNCTION__);
 
-	if ((result = dvb_register_adapter(&dec->adapter, "dec2000")) < 0) {
+	if ((result = dvb_register_adapter(&dec->adapter, dec->model_name)) < 0) {
 		printk("%s: dvb_register_adapter failed: error %d\n",
 		       __FUNCTION__, result);
 
 		return result;
 	}
 
-	if (!(dec->i2c_bus = dvb_register_i2c_bus(ttusb_dec_i2c_master_xfer,
-						  dec, dec->adapter, 0))) {
-		printk("%s: dvb_register_i2c_bus failed\n", __FUNCTION__);
-
-		dvb_unregister_adapter(dec->adapter);
-
-		return -ENOMEM;
-	}
-
 	dec->demux.dmx.capabilities = DMX_TS_FILTERING | DMX_SECTION_FILTERING;
 
 	dec->demux.priv = (void *)dec;
@@ -814,8 +971,6 @@
 		printk("%s: dvb_dmx_init failed: error %d\n", __FUNCTION__,
 		       result);
 
-		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
-				       0);
 		dvb_unregister_adapter(dec->adapter);
 
 		return result;
@@ -830,8 +985,6 @@
 		       __FUNCTION__, result);
 
 		dvb_dmx_release(&dec->demux);
-		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
-				       0);
 		dvb_unregister_adapter(dec->adapter);
 
 		return result;
@@ -846,8 +999,6 @@
 
 		dvb_dmxdev_release(&dec->dmxdev);
 		dvb_dmx_release(&dec->demux);
-		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
-				       0);
 		dvb_unregister_adapter(dec->adapter);
 
 		return result;
@@ -861,8 +1012,6 @@
 		dec->demux.dmx.remove_frontend(&dec->demux.dmx, &dec->frontend);
 		dvb_dmxdev_release(&dec->dmxdev);
 		dvb_dmx_release(&dec->demux);
-		dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter,
-				       0);
 		dvb_unregister_adapter(dec->adapter);
 
 		return result;
@@ -882,7 +1031,6 @@
 	dec->demux.dmx.remove_frontend(&dec->demux.dmx, &dec->frontend);
 	dvb_dmxdev_release(&dec->dmxdev);
 	dvb_dmx_release(&dec->demux);
-	dvb_unregister_i2c_bus(ttusb_dec_i2c_master_xfer, dec->adapter, 0);
 	dvb_unregister_adapter(dec->adapter);
 }
 
@@ -914,6 +1062,257 @@
 	}
 }
 
+static int ttusb_dec_2000t_frontend_ioctl(struct dvb_frontend *fe, unsigned int cmd,
+				  void *arg)
+{
+	struct ttusb_dec *dec = fe->data;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+
+	case FE_GET_INFO:
+		dprintk("%s: FE_GET_INFO\n", __FUNCTION__);
+		memcpy(arg, dec->frontend_info,
+		       sizeof (struct dvb_frontend_info));
+		break;
+
+	case FE_READ_STATUS: {
+			fe_status_t *status = (fe_status_t *)arg;
+			dprintk("%s: FE_READ_STATUS\n", __FUNCTION__);
+			*status = FE_HAS_SIGNAL | FE_HAS_VITERBI |
+				  FE_HAS_SYNC | FE_HAS_CARRIER | FE_HAS_LOCK;
+			break;
+		}
+
+	case FE_READ_BER: {
+			u32 *ber = (u32 *)arg;
+			dprintk("%s: FE_READ_BER\n", __FUNCTION__);
+			*ber = 0;
+			return -ENOSYS;
+			break;
+		}
+
+	case FE_READ_SIGNAL_STRENGTH: {
+			dprintk("%s: FE_READ_SIGNAL_STRENGTH\n", __FUNCTION__);
+			*(s32 *)arg = 0xFF;
+			return -ENOSYS;
+			break;
+		}
+
+	case FE_READ_SNR:
+		dprintk("%s: FE_READ_SNR\n", __FUNCTION__);
+		*(s32 *)arg = 0;
+		return -ENOSYS;
+		break;
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		dprintk("%s: FE_READ_UNCORRECTED_BLOCKS\n", __FUNCTION__);
+		*(u32 *)arg = 0;
+		return -ENOSYS;
+		break;
+
+	case FE_SET_FRONTEND: {
+			struct dvb_frontend_parameters *p =
+				(struct dvb_frontend_parameters *)arg;
+			u8 b[] = { 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+				   0x00, 0xff, 0x00, 0x00, 0x00, 0xff };
+			u32 freq;
+
+			dprintk("%s: FE_SET_FRONTEND\n", __FUNCTION__);
+
+			dprintk("            frequency->%d\n", p->frequency);
+			dprintk("            symbol_rate->%d\n",
+				p->u.qam.symbol_rate);
+			dprintk("            inversion->%d\n", p->inversion);
+
+			freq = htonl(p->frequency / 1000);
+			memcpy(&b[4], &freq, sizeof (u32));
+			ttusb_dec_send_command(dec, 0x71, sizeof(b), b, NULL, NULL);
+
+			break;
+		}
+
+	case FE_GET_FRONTEND:
+		dprintk("%s: FE_GET_FRONTEND\n", __FUNCTION__);
+		break;
+
+	case FE_SLEEP:
+		dprintk("%s: FE_SLEEP\n", __FUNCTION__);
+		return -ENOSYS;
+		break;
+
+	case FE_INIT:
+		dprintk("%s: FE_INIT\n", __FUNCTION__);
+		break;
+
+	case FE_RESET:
+		dprintk("%s: FE_RESET\n", __FUNCTION__);
+		break;
+
+	default:
+		dprintk("%s: unknown IOCTL (0x%X)\n", __FUNCTION__, cmd);
+		return -EINVAL;
+
+	}
+
+	return 0;
+}
+
+static int ttusb_dec_3000s_frontend_ioctl(struct dvb_frontend *fe, unsigned int cmd,
+				  void *arg)
+{
+	struct ttusb_dec *dec = fe->data;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	switch (cmd) {
+
+	case FE_GET_INFO:
+		dprintk("%s: FE_GET_INFO\n", __FUNCTION__);
+		memcpy(arg, dec->frontend_info,
+		       sizeof (struct dvb_frontend_info));
+		break;
+
+	case FE_READ_STATUS: {
+			fe_status_t *status = (fe_status_t *)arg;
+			dprintk("%s: FE_READ_STATUS\n", __FUNCTION__);
+			*status = FE_HAS_SIGNAL | FE_HAS_VITERBI |
+				  FE_HAS_SYNC | FE_HAS_CARRIER | FE_HAS_LOCK;
+			break;
+		}
+
+	case FE_READ_BER: {
+			u32 *ber = (u32 *)arg;
+			dprintk("%s: FE_READ_BER\n", __FUNCTION__);
+			*ber = 0;
+			return -ENOSYS;
+			break;
+		}
+
+	case FE_READ_SIGNAL_STRENGTH: {
+			dprintk("%s: FE_READ_SIGNAL_STRENGTH\n", __FUNCTION__);
+			*(s32 *)arg = 0xFF;
+			return -ENOSYS;
+			break;
+		}
+
+	case FE_READ_SNR:
+		dprintk("%s: FE_READ_SNR\n", __FUNCTION__);
+		*(s32 *)arg = 0;
+		return -ENOSYS;
+		break;
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		dprintk("%s: FE_READ_UNCORRECTED_BLOCKS\n", __FUNCTION__);
+		*(u32 *)arg = 0;
+		return -ENOSYS;
+		break;
+
+	case FE_SET_FRONTEND: {
+			struct dvb_frontend_parameters *p =
+				(struct dvb_frontend_parameters *)arg;
+			u8 b[] = { 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x0d, 0x00, 0x00, 0x00,
+				   0x00, 0x00, 0x00, 0x00, 0x00 };
+			u32 freq;
+			u32 sym_rate;
+			u32 band;
+
+
+			dprintk("%s: FE_SET_FRONTEND\n", __FUNCTION__);
+
+			dprintk("            frequency->%d\n", p->frequency);
+			dprintk("            symbol_rate->%d\n",
+				p->u.qam.symbol_rate);
+			dprintk("            inversion->%d\n", p->inversion);
+
+			freq = htonl(p->frequency * 1000 + (dec->hi_band ? LOF_HI : LOF_LO));
+			memcpy(&b[4], &freq, sizeof(u32));
+			sym_rate = htonl(p->u.qam.symbol_rate);
+			memcpy(&b[12], &sym_rate, sizeof(u32));
+			band = htonl(dec->hi_band ? LOF_HI : LOF_LO);
+			memcpy(&b[24], &band, sizeof(u32));
+
+			ttusb_dec_send_command(dec, 0x71, sizeof(b), b, NULL, NULL);
+
+			break;
+		}
+
+	case FE_GET_FRONTEND:
+		dprintk("%s: FE_GET_FRONTEND\n", __FUNCTION__);
+		break;
+
+	case FE_SLEEP:
+		dprintk("%s: FE_SLEEP\n", __FUNCTION__);
+		return -ENOSYS;
+		break;
+
+	case FE_INIT:
+		dprintk("%s: FE_INIT\n", __FUNCTION__);
+		break;
+
+	case FE_RESET:
+		dprintk("%s: FE_RESET\n", __FUNCTION__);
+		break;
+
+	case FE_DISEQC_SEND_MASTER_CMD:
+		dprintk("%s: FE_DISEQC_SEND_MASTER_CMD\n", __FUNCTION__);
+		break;
+
+	case FE_DISEQC_SEND_BURST:
+		dprintk("%s: FE_DISEQC_SEND_BURST\n", __FUNCTION__);
+		break;
+
+	case FE_SET_TONE: {
+			fe_sec_tone_mode_t tone = (fe_sec_tone_mode_t)arg;
+			dprintk("%s: FE_SET_TONE\n", __FUNCTION__);
+			dec->hi_band = (SEC_TONE_ON == tone);
+			break;
+		}
+
+	case FE_SET_VOLTAGE:
+		dprintk("%s: FE_SET_VOLTAGE\n", __FUNCTION__);
+		break;
+
+	default:
+		dprintk("%s: unknown IOCTL (0x%X)\n", __FUNCTION__, cmd);
+		return -EINVAL;
+
+	}
+
+	return 0;
+}
+
+static void ttusb_dec_init_frontend(struct ttusb_dec *dec)
+{
+	dec->i2c_bus.adapter = dec->adapter;
+
+	switch (dec->model) {
+		case TTUSB_DEC2000T:
+			dec->frontend_info = &dec2000t_frontend_info;
+			dec->frontend_ioctl = ttusb_dec_2000t_frontend_ioctl;
+			break;
+
+		case TTUSB_DEC3000S:
+			dec->frontend_info = &dec3000s_frontend_info;
+			dec->frontend_ioctl = ttusb_dec_3000s_frontend_ioctl;
+			break;
+	}
+
+	dvb_register_frontend(dec->frontend_ioctl, &dec->i2c_bus, (void *)dec,
+			      dec->frontend_info);
+}
+
+static void ttusb_dec_exit_frontend(struct ttusb_dec *dec)
+{
+	dvb_unregister_frontend(dec->frontend_ioctl, &dec->i2c_bus);
+}
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 static void *ttusb_dec_probe(struct usb_device *udev, unsigned int ifnum,
 			     const struct usb_device_id *id)
@@ -929,19 +1328,6 @@
 		printk("%s: couldn't allocate memory.\n", __FUNCTION__);
 		return NULL;
 	}
-
-	memset(dec, 0, sizeof(struct ttusb_dec));
-
-	dec->udev = udev;
-
-	ttusb_dec_init_usb(dec);
-	ttusb_dec_init_stb(dec);
-	ttusb_dec_init_dvb(dec);
-	ttusb_dec_init_v_pes(dec);
-	ttusb_dec_init_tasklet(dec);
-
-	return (void *)dec;
-}
 #else
 static int ttusb_dec_probe(struct usb_interface *intf,
 			   const struct usb_device_id *id)
@@ -958,22 +1344,47 @@
 		return -ENOMEM;
 	}
 
+	usb_set_intfdata(intf, (void *)dec);
+#endif
+
 	memset(dec, 0, sizeof(struct ttusb_dec));
 
+	switch (id->idProduct) {
+		case 0x1006:
+			dec->model = TTUSB_DEC3000S;
+			dec->model_name = "DEC3000-s";
+			dec->firmware_name = "dec3000s.bin";
+			break;
+
+		case 0x1008:
+			dec->model = TTUSB_DEC2000T;
+			dec->model_name = "DEC2000-t";
+			dec->firmware_name = "dec2000t.bin";
+			break;
+	}
+
 	dec->udev = udev;
 
 	ttusb_dec_init_usb(dec);
-	ttusb_dec_init_stb(dec);
+	if (ttusb_dec_init_stb(dec)) {
+		ttusb_dec_exit_usb(dec);
+		return 0;
+	}
 	ttusb_dec_init_dvb(dec);
+	ttusb_dec_init_frontend(dec);
 	ttusb_dec_init_v_pes(dec);
 	ttusb_dec_init_tasklet(dec);
 
-	usb_set_intfdata(intf, (void *)dec);
+	dec->active = 1;
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+	return (void *)dec;
+#else
 	ttusb_dec_set_streaming_interface(dec);
 
 	return 0;
-}
 #endif
+}
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 static void ttusb_dec_disconnect(struct usb_device *udev, void *data)
@@ -989,17 +1400,20 @@
 
 	dprintk("%s\n", __FUNCTION__);
 
+	if (dec->active) {
 	ttusb_dec_exit_tasklet(dec);
 	ttusb_dec_exit_usb(dec);
+		ttusb_dec_exit_frontend(dec);
 	ttusb_dec_exit_dvb(dec);
+	}
 
 	kfree(dec);
 }
 
 static struct usb_device_id ttusb_dec_table[] = {
-	{USB_DEVICE(0x0b48, 0x1006)},	/* Unconfirmed */
-	{USB_DEVICE(0x0b48, 0x1007)},	/* Unconfirmed */
-	{USB_DEVICE(0x0b48, 0x1008)},	/* DEC 2000 t */
+	{USB_DEVICE(0x0b48, 0x1006)},	/* DEC3000-s */
+	/*{USB_DEVICE(0x0b48, 0x1007)},	   Unconfirmed */
+	{USB_DEVICE(0x0b48, 0x1008)},	/* DEC2000-t */
 	{}
 };
 

