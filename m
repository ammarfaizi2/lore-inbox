Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUARSn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUARSnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:43:00 -0500
Received: from mail.convergence.de ([212.84.236.4]:47340 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263014AbUARSfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:35:42 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 5/5] TTUSB DVB driver update
In-Reply-To: <10744509243070@convergence.de>
Message-Id: <10744509281247@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Sun, 18 Jan 2004 13:35:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] TTUSB-DEC update by Alex Woods:
        - fix USB timeout bug under 2.6
        - change some variable names to make it clearer what we are dealing with (PVA).
	- support DEC2540-t and add info on it to the ttusb-dec docs.
	- add model number returned from DEC2540-t firmware.
	- add a module option to get the raw AVPES packets from the dvr device.
	- send audio packets to their filter rather than the videos.
	- handle the new empty packets that appear with the 2.16 firmware.
	- extra error checks.
	- handle the new firmwares that change the devices' USB IDs.
	- tidy up the STB initialisation process a little.
	- apply Hans-Frieder Vogt's patch for calculating firmware CRCs.
- [DVB] make TTUSB budget card depend on USB subsystem
diff -uraNbBw xx-linux-2.6.1-mm4/drivers/media/dvb/ttusb-budget/Kconfig linux-2.6.1-mm4.patched/drivers/media/dvb/ttusb-budget/Kconfig
--- xx-linux-2.6.1-mm4/drivers/media/dvb/ttusb-budget/Kconfig	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.patched/drivers/media/dvb/ttusb-budget/Kconfig	2004-01-09 20:27:29.000000000 +0100
@@ -1,6 +1,6 @@
 config DVB_TTUSB_BUDGET
 	tristate "Technotrend/Hauppauge Nova-USB devices"
-	depends on DVB_CORE
+	depends on DVB_CORE && USB
 	help
 	  Support for external USB adapters designed by Technotrend and
 	  produced by Hauppauge, shipped under the brand name 'Nova-USB'.
diff -urabBw xx-linux-2.6.1-mm4/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.1-mm4.usb/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- xx-linux-2.6.1-mm4/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-01-16 19:48:22.000000000 +0100
+++ linux-2.6.1-mm4.usb/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-01-18 15:32:39.000000000 +0100
@@ -20,9 +20,9 @@
  */
 
 #include <asm/semaphore.h>
+#include <linux/crc32.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -39,6 +39,7 @@
 #include "dvb_net.h"
 
 static int debug = 0;
+static int output_pva = 0;
 
 #define dprintk	if (debug) printk
 
@@ -46,34 +47,44 @@
 
 #define COMMAND_PIPE		0x03
 #define RESULT_PIPE		0x84
-#define STREAM_PIPE		0x88
+#define IN_PIPE			0x88
+#define OUT_PIPE		0x07
 
 #define COMMAND_PACKET_SIZE	0x3c
 #define ARM_PACKET_SIZE		0x1000
 
 #define ISO_BUF_COUNT		0x04
 #define FRAMES_PER_ISO_BUF	0x04
-#define ISO_FRAME_SIZE		0x0380
+#define ISO_FRAME_SIZE		0x03FF
 
-#define	MAX_AV_PES_LENGTH	6144
+#define	MAX_PVA_LENGTH		6144
 
 #define LOF_HI			10600000
 #define LOF_LO			9750000
 
 enum ttusb_dec_model {
 	TTUSB_DEC2000T,
+	TTUSB_DEC2540T,
 	TTUSB_DEC3000S
 };
 
 enum ttusb_dec_packet_type {
-	PACKET_AV_PES,
-	PACKET_SECTION
+	TTUSB_DEC_PACKET_PVA,
+	TTUSB_DEC_PACKET_SECTION,
+	TTUSB_DEC_PACKET_EMPTY
+};
+
+enum ttusb_dec_interface {
+	TTUSB_DEC_INTERFACE_INITIAL,
+	TTUSB_DEC_INTERFACE_IN,
+	TTUSB_DEC_INTERFACE_OUT
 };
 
 struct ttusb_dec {
 	enum ttusb_dec_model		model;
 	char				*model_name;
 	char				*firmware_name;
+	int				can_playback;
 
 	/* DVB bits */
 	struct dvb_adapter		*adapter;
@@ -93,8 +104,9 @@
 	u8			trans_count;
 	unsigned int		command_pipe;
 	unsigned int		result_pipe;
-	unsigned int		stream_pipe;
-	int			interface;
+	unsigned int			in_pipe;
+	unsigned int			out_pipe;
+	enum ttusb_dec_interface	interface;
 	struct semaphore	usb_sem;
 
 	void			*iso_buffer;
@@ -103,19 +115,20 @@
 	int			iso_stream_count;
 	struct semaphore	iso_sem;
 
-	u8				packet[MAX_AV_PES_LENGTH + 4];
+	u8				packet[MAX_PVA_LENGTH + 4];
 	enum ttusb_dec_packet_type	packet_type;
 	int				packet_state;
 	int				packet_length;
 	int				packet_payload_length;
+	u16				next_packet_id;
 
-	int				av_pes_stream_count;
+	int				pva_stream_count;
 	int				filter_stream_count;
 
 	struct dvb_filter_pes2ts	a_pes2ts;
 	struct dvb_filter_pes2ts	v_pes2ts;
 
-	u8			v_pes[16 + MAX_AV_PES_LENGTH];
+	u8			v_pes[16 + MAX_PVA_LENGTH];
 	int			v_pes_length;
 	int			v_pes_postbytes;
 
@@ -123,6 +136,8 @@
 	struct tasklet_struct	urb_tasklet;
 	spinlock_t		urb_frame_list_lock;
 
+	struct dvb_demux_filter	*audio_filter;
+	struct dvb_demux_filter	*video_filter;
 	struct list_head	filter_info_list;
 	spinlock_t		filter_info_list_lock;
 
@@ -167,6 +182,22 @@
 		FE_CAN_HIERARCHY_AUTO,
 };
 
+static void ttusb_dec_set_model(struct ttusb_dec *dec,
+				enum ttusb_dec_model model);
+
+static u16 crc16(u16 crc, const u8 *buf, size_t len)
+{
+	u16 tmp;
+
+	while (len--) {
+		crc ^= *buf++;
+		crc ^= (u8)crc >> 4;
+		tmp = (u8)crc;
+		crc ^= (tmp ^ (tmp << 1)) << 4;
+	}
+	return crc;
+}
+
 static int ttusb_dec_send_command(struct ttusb_dec *dec, const u8 command,
 				  int param_length, const u8 params[],
 				  int *result_length, u8 cmd_result[])
@@ -234,11 +265,57 @@
 	}
 }
 
-static int ttusb_dec_av_pes2ts_cb(void *priv, unsigned char *data)
+static int ttusb_dec_get_stb_state (struct ttusb_dec *dec, unsigned int *mode,
+				    unsigned int *model, unsigned int *version)
+{
+	u8 c[COMMAND_PACKET_SIZE];
+	int c_length;
+	int result;
+	unsigned int tmp;
+
+	dprintk("%s\n", __FUNCTION__);
+
+	result = ttusb_dec_send_command(dec, 0x08, 0, NULL, &c_length, c);
+	if (result)
+		return result;
+
+	if (c_length >= 0x0c) {
+		if (mode != NULL) {
+			memcpy(&tmp, c, 4);
+			*mode = ntohl(tmp);
+		}
+		if (model != NULL) {
+			memcpy(&tmp, &c[4], 4);
+			*model = ntohl(tmp);
+		}
+		if (version != NULL) {
+			memcpy(&tmp, &c[8], 4);
+			*version = ntohl(tmp);
+		}
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+static int ttusb_dec_audio_pes2ts_cb(void *priv, unsigned char *data)
 {
-	struct dvb_demux_feed *dvbdmxfeed = (struct dvb_demux_feed *)priv;
+	struct ttusb_dec *dec = (struct ttusb_dec *)priv;
 
-	dvbdmxfeed->cb.ts(data, 188, 0, 0, &dvbdmxfeed->feed.ts, DMX_OK);
+	dec->audio_filter->feed->cb.ts(data, 188, 0, 0,
+				       &dec->audio_filter->feed->feed.ts,
+				       DMX_OK);
+
+	return 0;
+}
+
+static int ttusb_dec_video_pes2ts_cb(void *priv, unsigned char *data)
+{
+	struct ttusb_dec *dec = (struct ttusb_dec *)priv;
+
+	dec->video_filter->feed->cb.ts(data, 188, 0, 0,
+				       &dec->video_filter->feed->feed.ts,
+				       DMX_OK);
 
 	return 0;
 }
@@ -262,64 +339,69 @@
 	ttusb_dec_send_command(dec, 0x50, sizeof(b), b, NULL, NULL);
 
 		dvb_filter_pes2ts_init(&dec->a_pes2ts, dec->pid[DMX_PES_AUDIO],
-				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
+			       ttusb_dec_audio_pes2ts_cb, dec);
 		dvb_filter_pes2ts_init(&dec->v_pes2ts, dec->pid[DMX_PES_VIDEO],
-				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
+			       ttusb_dec_video_pes2ts_cb, dec);
 	dec->v_pes_length = 0;
 	dec->v_pes_postbytes = 0;
 }
 
-static void ttusb_dec_process_av_pes(struct ttusb_dec * dec, u8 * av_pes,
-				     int length)
+static void ttusb_dec_process_pva(struct ttusb_dec *dec, u8 *pva, int length)
 {
 	if (length < 8) {
 		printk("%s: packet too short - discarding\n", __FUNCTION__);
 		return;
 	}
 
-	if (length > 8 + MAX_AV_PES_LENGTH) {
+	if (length > 8 + MAX_PVA_LENGTH) {
 		printk("%s: packet too long - discarding\n", __FUNCTION__);
 		return;
 	}
 
-	switch (av_pes[2]) {
+	switch (pva[2]) {
 
 	case 0x01: {		/* VideoStream */
-			int prebytes = av_pes[5] & 0x03;
-			int postbytes = (av_pes[5] & 0x0c) >> 2;
+		int prebytes = pva[5] & 0x03;
+		int postbytes = (pva[5] & 0x0c) >> 2;
 			u16 v_pes_payload_length;
 
+		if (output_pva) {
+			dec->video_filter->feed->cb.ts(pva, length, 0, 0,
+				&dec->video_filter->feed->feed.ts, DMX_OK);
+			return;
+		}
+
 			if (dec->v_pes_postbytes > 0 &&
 			    dec->v_pes_postbytes == prebytes) {
 				memcpy(&dec->v_pes[dec->v_pes_length],
-				       &av_pes[12], prebytes);
+			       &pva[12], prebytes);
 
 				dvb_filter_pes2ts(&dec->v_pes2ts, dec->v_pes,
 					  dec->v_pes_length + prebytes, 1);
 			}
 
-			if (av_pes[5] & 0x10) {
+		if (pva[5] & 0x10) {
 				dec->v_pes[7] = 0x80;
 				dec->v_pes[8] = 0x05;
 
-			dec->v_pes[9] = 0x21 | ((av_pes[8] & 0xc0) >> 5);
-				dec->v_pes[10] = ((av_pes[8] & 0x3f) << 2) |
-						 ((av_pes[9] & 0xc0) >> 6);
+			dec->v_pes[9] = 0x21 | ((pva[8] & 0xc0) >> 5);
+			dec->v_pes[10] = ((pva[8] & 0x3f) << 2) |
+					 ((pva[9] & 0xc0) >> 6);
 				dec->v_pes[11] = 0x01 |
-						 ((av_pes[9] & 0x3f) << 2) |
-						 ((av_pes[10] & 0x80) >> 6);
-				dec->v_pes[12] = ((av_pes[10] & 0x7f) << 1) |
-						 ((av_pes[11] & 0xc0) >> 7);
-			dec->v_pes[13] = 0x01 | ((av_pes[11] & 0x7f) << 1);
+					 ((pva[9] & 0x3f) << 2) |
+					 ((pva[10] & 0x80) >> 6);
+			dec->v_pes[12] = ((pva[10] & 0x7f) << 1) |
+					 ((pva[11] & 0xc0) >> 7);
+			dec->v_pes[13] = 0x01 | ((pva[11] & 0x7f) << 1);
 
-				memcpy(&dec->v_pes[14], &av_pes[12 + prebytes],
+			memcpy(&dec->v_pes[14], &pva[12 + prebytes],
 			       length - 12 - prebytes);
 			dec->v_pes_length = 14 + length - 12 - prebytes;
 			} else {
 				dec->v_pes[7] = 0x00;
 				dec->v_pes[8] = 0x00;
 
-			memcpy(&dec->v_pes[9], &av_pes[8], length - 8);
+			memcpy(&dec->v_pes[9], &pva[8], length - 8);
 			dec->v_pes_length = 9 + length - 8;
 			}
 
@@ -344,13 +426,19 @@
 		}
 
 	case 0x02:		/* MainAudioStream */
-		dvb_filter_pes2ts(&dec->a_pes2ts, &av_pes[8], length - 8,
-				  av_pes[5] & 0x10);
+		if (output_pva) {
+			dec->audio_filter->feed->cb.ts(pva, length, 0, 0,
+				&dec->audio_filter->feed->feed.ts, DMX_OK);
+			return;
+		}
+
+		dvb_filter_pes2ts(&dec->a_pes2ts, &pva[8], length - 8,
+				  pva[5] & 0x10);
 		break;
 
 	default:
-		printk("%s: unknown AV_PES type: %02x.\n", __FUNCTION__,
-		       av_pes[2]);
+		printk("%s: unknown PVA type: %02x.\n", __FUNCTION__,
+		       pva[2]);
 		break;
 	}
 }
@@ -385,6 +473,7 @@
 {
 	int i;
 	u16 csum = 0;
+	u16 packet_id;
 
 	if (dec->packet_length % 2) {
 		printk("%s: odd sized packet - discarding\n", __FUNCTION__);
@@ -399,18 +488,34 @@
 		return;
 	}
 
+	packet_id = dec->packet[dec->packet_length - 4] << 8;
+	packet_id += dec->packet[dec->packet_length - 3];
+
+	if ((packet_id != dec->next_packet_id) && dec->next_packet_id) {
+		printk("%s: warning: lost packets between %u and %u\n",
+		       __FUNCTION__, dec->next_packet_id - 1, packet_id);
+	}
+
+	if (packet_id == 0xffff)
+		dec->next_packet_id = 0x8000;
+	else
+		dec->next_packet_id = packet_id + 1;
+
 	switch (dec->packet_type) {
-	case PACKET_AV_PES:
-		if (dec->av_pes_stream_count)
-			ttusb_dec_process_av_pes(dec, dec->packet,
+	case TTUSB_DEC_PACKET_PVA:
+		if (dec->pva_stream_count)
+			ttusb_dec_process_pva(dec, dec->packet,
 						 dec->packet_payload_length);
 		break;
 
-	case PACKET_SECTION:
+	case TTUSB_DEC_PACKET_SECTION:
 		if (dec->filter_stream_count)
 			ttusb_dec_process_filter(dec, dec->packet,
 						 dec->packet_payload_length);
 		break;
+
+	case TTUSB_DEC_PACKET_EMPTY:
+		break;
 	}
 }
 
@@ -459,15 +564,25 @@
 		case 4:
 			dec->packet[dec->packet_length++] = *b++;
 
-			if (dec->packet_length == 3) {
+			if (dec->packet_length == 2) {
 				if (dec->packet[0] == 'A' &&
 				    dec->packet[1] == 'V') {
-					dec->packet_type = PACKET_AV_PES;
+					dec->packet_type =
+						TTUSB_DEC_PACKET_PVA;
 					dec->packet_state++;
 				} else if (dec->packet[0] == 'S') {
-					dec->packet_type = PACKET_SECTION;
+					dec->packet_type =
+						TTUSB_DEC_PACKET_SECTION;
 					dec->packet_state++;
+				} else if (dec->packet[0] == 0x00) {
+					dec->packet_type =
+						TTUSB_DEC_PACKET_EMPTY;
+					dec->packet_payload_length = 2;
+					dec->packet_state = 7;
 			} else {
+					printk("%s: unknown packet type: "
+					       "%02x%02x\n", __FUNCTION__,
+					       dec->packet[0], dec->packet[1]);
 					dec->packet_state = 0;
 				}
 			}
@@ -478,13 +593,14 @@
 		case 5:
 			dec->packet[dec->packet_length++] = *b++;
 
-			if (dec->packet_type == PACKET_AV_PES &&
+			if (dec->packet_type == TTUSB_DEC_PACKET_PVA &&
 			    dec->packet_length == 8) {
 				dec->packet_state++;
 				dec->packet_payload_length = 8 +
 					(dec->packet[6] << 8) +
 					dec->packet[7];
-			} else if (dec->packet_type == PACKET_SECTION &&
+			} else if (dec->packet_type ==
+					TTUSB_DEC_PACKET_SECTION &&
 				   dec->packet_length == 5) {
 				dec->packet_state++;
 				dec->packet_payload_length = 5 +
@@ -521,7 +637,7 @@
 
 			dec->packet[dec->packet_length++] = *b++;
 
-			if (dec->packet_type == PACKET_SECTION &&
+			if (dec->packet_type == TTUSB_DEC_PACKET_SECTION &&
 			    dec->packet_payload_length % 2)
 				tail++;
 
@@ -627,10 +742,9 @@
 		urb->dev = dec->udev;
 		urb->context = dec;
 		urb->complete = ttusb_dec_process_urb;
-		urb->pipe = dec->stream_pipe;
+		urb->pipe = dec->in_pipe;
 		urb->transfer_flags = URB_ISO_ASAP;
 		urb->interval = 1;
-
 		urb->number_of_packets = FRAMES_PER_ISO_BUF;
 		urb->transfer_buffer_length = ISO_FRAME_SIZE *
 					      FRAMES_PER_ISO_BUF;
@@ -668,12 +782,36 @@
  * for a short period, so it's important not to call this function just before
  * trying to talk to it.
  */
-static void ttusb_dec_set_streaming_interface(struct ttusb_dec *dec)
+static int ttusb_dec_set_interface(struct ttusb_dec *dec,
+				   enum ttusb_dec_interface interface)
 {
-	if (!dec->interface) {
-		usb_set_interface(dec->udev, 0, 8);
-		dec->interface = 8;
+	int result = 0;
+	u8 b[] = { 0x05 };
+
+	if (interface != dec->interface) {
+		switch (interface) {
+		case TTUSB_DEC_INTERFACE_INITIAL:
+			result = usb_set_interface(dec->udev, 0, 0);
+			break;
+		case TTUSB_DEC_INTERFACE_IN:
+			result = ttusb_dec_send_command(dec, 0x80, sizeof(b),
+							b, NULL, NULL);
+			if (result)
+				return result;
+			result = usb_set_interface(dec->udev, 0, 7);
+			break;
+		case TTUSB_DEC_INTERFACE_OUT:
+			result = usb_set_interface(dec->udev, 0, 1);
+			break;
+		}
+
+		if (result)
+			return result;
+
+		dec->interface = interface;
 	}
+
+	return 0;
 }
 
 static int ttusb_dec_start_iso_xfer(struct ttusb_dec *dec)
@@ -688,6 +826,10 @@
 	if (!dec->iso_stream_count) {
 		ttusb_dec_setup_urbs(dec);
 
+		dec->packet_state = 0;
+		dec->v_pes_postbytes = 0;
+		dec->next_packet_id = 0;
+
 		for (i = 0; i < ISO_BUF_COUNT; i++) {
 			if ((result = usb_submit_urb(dec->iso_urb[i],
 						     GFP_ATOMIC))) {
@@ -703,9 +845,6 @@
 				return result;
 			}
 		}
-
-		dec->packet_state = 0;
-		dec->v_pes_postbytes = 0;
 	}
 
 	dec->iso_stream_count++;
@@ -720,6 +859,7 @@
 	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	struct ttusb_dec *dec = dvbdmx->priv;
 	u8 b0[] = { 0x05 };
+	int result = 0;
 
 	dprintk("%s\n", __FUNCTION__);
 
@@ -742,12 +882,14 @@
 		dprintk("  pes_type: DMX_TS_PES_VIDEO\n");
 		dec->pid[DMX_PES_PCR] = dvbdmxfeed->pid;
 		dec->pid[DMX_PES_VIDEO] = dvbdmxfeed->pid;
+		dec->video_filter = dvbdmxfeed->filter;
 		ttusb_dec_set_pids(dec);
 		break;
 
 	case DMX_TS_PES_AUDIO:
 		dprintk("  pes_type: DMX_TS_PES_AUDIO\n");
 		dec->pid[DMX_PES_AUDIO] = dvbdmxfeed->pid;
+		dec->audio_filter = dvbdmxfeed->filter;
 		ttusb_dec_set_pids(dec);
 		break;
 
@@ -772,12 +914,12 @@
 
 	}
 
-	ttusb_dec_send_command(dec, 0x80, sizeof(b0), b0, NULL, NULL);
-
-	dec->av_pes_stream_count++;
-	ttusb_dec_start_iso_xfer(dec);
+	result = ttusb_dec_send_command(dec, 0x80, sizeof(b0), b0, NULL, NULL);
+	if (result)
+		return result;
 
-	return 0;
+	dec->pva_stream_count++;
+	return ttusb_dec_start_iso_xfer(dec);
 }
 
 static int ttusb_dec_start_sec_feed(struct dvb_demux_feed *dvbdmxfeed)
@@ -827,9 +969,7 @@
 			dvbdmxfeed->priv = finfo;
 
 			dec->filter_stream_count++;
-			ttusb_dec_start_iso_xfer(dec);
-
-			return 0;
+			return ttusb_dec_start_iso_xfer(dec);
 		}
 
 		return -EAGAIN;
@@ -872,7 +1012,7 @@
 
 	ttusb_dec_send_command(dec, 0x81, sizeof(b0), b0, NULL, NULL);
 
-	dec->av_pes_stream_count--;
+	dec->pva_stream_count--;
 
 	ttusb_dec_stop_iso_xfer(dec);
 
@@ -991,7 +1131,8 @@
 
 	dec->command_pipe = usb_sndbulkpipe(dec->udev, COMMAND_PIPE);
 	dec->result_pipe = usb_rcvbulkpipe(dec->udev, RESULT_PIPE);
-	dec->stream_pipe = usb_rcvisocpipe(dec->udev, STREAM_PIPE);
+	dec->in_pipe = usb_rcvisocpipe(dec->udev, IN_PIPE);
+	dec->out_pipe = usb_sndisocpipe(dec->udev, OUT_PIPE);
 
 	ttusb_dec_alloc_iso_urbs(dec);
 }
@@ -1001,14 +1142,16 @@
 	int i, j, actual_len, result, size, trans_count;
 	u8 b0[] = { 0x00, 0x00, 0x00, 0x00,
 		    0x00, 0x00, 0x00, 0x00,
-		    0x00, 0x00 };
+		    0x61, 0x00 };
 	u8 b1[] = { 0x61 };
 	u8 b[ARM_PACKET_SIZE];
+	char idstring[21];
 	u8 *firmware = NULL;
 	size_t firmware_size = 0;
-	u32 firmware_csum = 0;
+	u16 firmware_csum = 0;
+	u16 firmware_csum_ns;
 	u32 firmware_size_nl;
-	u32 firmware_csum_nl;
+	u32 crc32_csum, crc32_check, tmp;
 	const struct firmware *fw_entry = NULL;
 
 	dprintk("%s\n", __FUNCTION__);
@@ -1022,20 +1165,33 @@
 	firmware = fw_entry->data;
 	firmware_size = fw_entry->size;
 
-	switch (dec->model) {
-		case TTUSB_DEC2000T:
-			firmware_csum = 0x1bc86100;
-			break;
-
-		case TTUSB_DEC3000S:
-			firmware_csum = 0x00000000;
-			break;
-	}
+	if (firmware_size < 60) {
+		printk("%s: firmware size too small for DSP code (%u < 60).\n",
+			__FUNCTION__, firmware_size);
+		return -1;
+	}
+
+	/* a 32 bit checksum over the first 56 bytes of the DSP Code is stored
+	   at offset 56 of file, so use it to check if the firmware file is
+	   valid. */
+	crc32_csum = crc32(~0L, firmware, 56) ^ ~0L;
+	memcpy(&tmp, &firmware[56], 4);
+	crc32_check = htonl(tmp);
+	if (crc32_csum != crc32_check) {
+		printk("%s: crc32 check of DSP code failed (calculated "
+		       "0x%08x != 0x%08x in file), file invalid.\n",
+			__FUNCTION__, crc32_csum, crc32_check);
+		return -1;
+	}
+	memcpy(idstring, &firmware[36], 20);
+	idstring[20] = '\0';
+	printk(KERN_INFO "ttusb_dec: found DSP code \"%s\".\n", idstring);
 
 	firmware_size_nl = htonl(firmware_size);
 	memcpy(b0, &firmware_size_nl, 4);
-	firmware_csum_nl = htonl(firmware_csum);
-	memcpy(&b0[6], &firmware_csum_nl, 4);
+	firmware_csum = crc16(~0, firmware, firmware_size) ^ ~0;
+	firmware_csum_ns = htons(firmware_csum);
+	memcpy(&b0[6], &firmware_csum_ns, 2);
 
 	result = ttusb_dec_send_command(dec, 0x41, sizeof(b0), b0, NULL, NULL);
 
@@ -1077,20 +1233,56 @@
 
 static int ttusb_dec_init_stb(struct ttusb_dec *dec)
 {
-	u8 c[COMMAND_PACKET_SIZE];
-	int c_length;
 	int result;
+	unsigned int mode, model, version;
 
 	dprintk("%s\n", __FUNCTION__);
 
-	result = ttusb_dec_send_command(dec, 0x08, 0, NULL, &c_length, c);
+	result = ttusb_dec_get_stb_state(dec, &mode, &model, &version);
 
 	if (!result) {
-		if (c_length != 0x0c || (c_length == 0x0c && c[9] != 0x63))
-			return ttusb_dec_boot_dsp(dec);
+		if (!mode) {
+			if (version == 0xABCDEFAB)
+				printk(KERN_INFO "ttusb_dec: no version "
+				       "info in Firmware\n");
+			else
+				printk(KERN_INFO "ttusb_dec: Firmware "
+				       "%x.%02x%c%c\n",
+				       version >> 24, (version >> 16) & 0xff,
+				       (version >> 8) & 0xff, version & 0xff);
+
+			result = ttusb_dec_boot_dsp(dec);
+			if (result)
+				return result;
 		else
+				return 1;
+		} else {
+			/* We can't trust the USB IDs that some firmwares
+			   give the box */
+			switch (model) {
+			case 0x00070008:
+				ttusb_dec_set_model(dec, TTUSB_DEC3000S);
+				break;
+			case 0x00070009:
+				ttusb_dec_set_model(dec, TTUSB_DEC2000T);
+				break;
+			case 0x00070011:
+				ttusb_dec_set_model(dec, TTUSB_DEC2540T);
+				break;
+			default:
+				printk(KERN_ERR "%s: unknown model returned "
+				       "by firmware (%08x) - please report\n",
+				       __FUNCTION__, model);
+				return -1;
+				break;
+			}
+
+			if (version >= 0x01770000)
+				dec->can_playback = 1;
+
 			return 0;
 	}
+	}
 	else
 		return result;
 }
@@ -1101,7 +1293,8 @@
 
 	dprintk("%s\n", __FUNCTION__);
 
-	if ((result = dvb_register_adapter(&dec->adapter, dec->model_name)) < 0) {
+	if ((result = dvb_register_adapter(&dec->adapter,
+					   dec->model_name)) < 0) {
 		printk("%s: dvb_register_adapter failed: error %d\n",
 		       __FUNCTION__, result);
 
@@ -1449,18 +1638,6 @@
 {
 	dec->i2c_bus.adapter = dec->adapter;
 
-	switch (dec->model) {
-		case TTUSB_DEC2000T:
-			dec->frontend_info = &dec2000t_frontend_info;
-			dec->frontend_ioctl = ttusb_dec_2000t_frontend_ioctl;
-			break;
-
-		case TTUSB_DEC3000S:
-			dec->frontend_info = &dec3000s_frontend_info;
-			dec->frontend_ioctl = ttusb_dec_3000s_frontend_ioctl;
-			break;
-	}
-
 	dvb_register_frontend(dec->frontend_ioctl, &dec->i2c_bus, (void *)dec,
 			      dec->frontend_info);
 }
@@ -1509,15 +1686,15 @@
 
 	switch (id->idProduct) {
 		case 0x1006:
-			dec->model = TTUSB_DEC3000S;
-			dec->model_name = "DEC3000-s";
-		dec->firmware_name = "dvb-ttusb-dec-3000s-2.15a.fw";
+		ttusb_dec_set_model(dec, TTUSB_DEC3000S);
 			break;
 
 		case 0x1008:
-			dec->model = TTUSB_DEC2000T;
-			dec->model_name = "DEC2000-t";
-		dec->firmware_name = "dvb-ttusb-dec-2000t-2.15a.fw";
+		ttusb_dec_set_model(dec, TTUSB_DEC2000T);
+		break;
+
+	case 0x1009:
+		ttusb_dec_set_model(dec, TTUSB_DEC2540T);
 			break;
 	}
 
@@ -1536,7 +1713,7 @@
 
 	dec->active = 1;
 
-	ttusb_dec_set_streaming_interface(dec);
+	ttusb_dec_set_interface(dec, TTUSB_DEC_INTERFACE_IN);
 
 	return 0;
 }
@@ -1560,15 +1737,45 @@
 	kfree(dec);
 }
 
+static void ttusb_dec_set_model(struct ttusb_dec *dec,
+				enum ttusb_dec_model model)
+{
+	dec->model = model;
+
+	switch (model) {
+	case TTUSB_DEC2000T:
+		dec->model_name = "DEC2000-t";
+		dec->firmware_name = "dvb-ttusb-dec-2000t.fw";
+		dec->frontend_info = &dec2000t_frontend_info;
+		dec->frontend_ioctl = ttusb_dec_2000t_frontend_ioctl;
+		break;
+
+	case TTUSB_DEC2540T:
+		dec->model_name = "DEC2540-t";
+		dec->firmware_name = "dvb-ttusb-dec-2540t.fw";
+		dec->frontend_info = &dec2000t_frontend_info;
+		dec->frontend_ioctl = ttusb_dec_2000t_frontend_ioctl;
+		break;
+
+	case TTUSB_DEC3000S:
+		dec->model_name = "DEC3000-s";
+		dec->firmware_name = "dvb-ttusb-dec-3000s.fw";
+		dec->frontend_info = &dec3000s_frontend_info;
+		dec->frontend_ioctl = ttusb_dec_3000s_frontend_ioctl;
+		break;
+	}
+}
+
 static struct usb_device_id ttusb_dec_table[] = {
 	{USB_DEVICE(0x0b48, 0x1006)},	/* DEC3000-s */
 	/*{USB_DEVICE(0x0b48, 0x1007)},	   Unconfirmed */
 	{USB_DEVICE(0x0b48, 0x1008)},	/* DEC2000-t */
+	{USB_DEVICE(0x0b48, 0x1009)},	/* DEC2540-t */
 	{}
 };
 
 static struct usb_driver ttusb_dec_driver = {
-      .name		= DRIVER_NAME,
+	.name		= "ttusb-dec",
       .probe		= ttusb_dec_probe,
       .disconnect	= ttusb_dec_disconnect,
       .id_table		= ttusb_dec_table,
@@ -1602,3 +1809,5 @@
 
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debug level");
+MODULE_PARM(output_pva, "i");
+MODULE_PARM_DESC(output_pva, "Output PVA from dvr device");


