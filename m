Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVEMWMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVEMWMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbVEMWL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:11:27 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:62368 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262571AbVEMWKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:11 -0400
Message-Id: <20050513220225.247672000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:22 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Vadim Catana <skystar@moldova.cc>,
       Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-usb-fixes.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 03/11] flexcop: fix USB transfer handling
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- driver receives many null TS packets (pid=0x1fff). They occupy the
  limited USB bandwidth and this leads to loss of video packets.
  Enabling the null packet filter fixes this.
- packets that flexcop sends to USB have a 2 byte header that has to
  be removed.
- sometimes a TS packet is split between different urbs. These parts have
  to be combined in a temporary buffer.

Signed-off-by: Vadim Catana <skystar@moldova.cc>
Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/b2c2/flexcop-hw-filter.c |    9 +++--
 drivers/media/dvb/b2c2/flexcop-usb.c       |   47 ++++++++++++++++++++++++++++-
 drivers/media/dvb/b2c2/flexcop-usb.h       |    3 +
 3 files changed, 55 insertions(+), 4 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-hw-filter.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-hw-filter.c	2005-05-12 01:30:16.000000000 +0200
@@ -159,7 +159,7 @@ int flexcop_pid_feed_control(struct flex
 	} else if (fc->feedcount == onoff && !onoff) {
 		if (!fc->pid_filtering) {
 			deb_ts("disabling full TS transfer\n");
-			flexcop_pid_group_filter(fc, 0x1fe0,0);
+			flexcop_pid_group_filter(fc, 0, 0x1fe0);
 			flexcop_pid_group_filter_ctrl(fc,0);
 		}
 
@@ -175,7 +175,7 @@ int flexcop_pid_feed_control(struct flex
 		flexcop_pid_group_filter(fc, 0,0);
 		flexcop_pid_group_filter_ctrl(fc,1);
 	} else if (fc->pid_filtering && fc->feedcount <= max_pid_filter) {
-		flexcop_pid_group_filter(fc, 0x1fe0,0);
+		flexcop_pid_group_filter(fc, 0,0x1fe0);
 		flexcop_pid_group_filter_ctrl(fc,0);
 	}
 
@@ -189,10 +189,13 @@ void flexcop_hw_filter_init(struct flexc
 	for (i = 0; i < 6 + 32*fc->has_32_hw_pid_filter; i++)
 		flexcop_pid_control(fc,i,0x1fff,0);
 
-	flexcop_pid_group_filter(fc, 0x1fe0,0);
+	flexcop_pid_group_filter(fc, 0, 0x1fe0);
+	flexcop_pid_group_filter_ctrl(fc,0);
 
 	v = fc->read_ibi_reg(fc,pid_filter_308);
 	v.pid_filter_308.EMM_filter_4 = 1;
 	v.pid_filter_308.EMM_filter_6 = 0;
 	fc->write_ibi_reg(fc,pid_filter_308,v);
+
+	flexcop_null_filter_ctrl(fc, 1);
 }
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-usb.c	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.c	2005-05-12 01:30:16.000000000 +0200
@@ -282,6 +282,51 @@ static int flexcop_usb_i2c_request(struc
 		return flexcop_usb_i2c_req(fc->bus_specific,B2C2_USB_I2C_REQUEST,USB_FUNC_I2C_WRITE,port,chipaddr,addr,buf,len);
 }
 
+static void flexcop_usb_process_frame(struct flexcop_usb *fc_usb, u8 *buffer, int buffer_length)
+{
+	u8 *b;
+	int l;
+
+	deb_ts("tmp_buffer_length=%d, buffer_length=%d\n", fc_usb->tmp_buffer_length, buffer_length);
+
+	if (fc_usb->tmp_buffer_length > 0) {
+		memcpy(fc_usb->tmp_buffer+fc_usb->tmp_buffer_length, buffer, buffer_length);
+		fc_usb->tmp_buffer_length += buffer_length;
+		b = fc_usb->tmp_buffer;
+		l = fc_usb->tmp_buffer_length;
+	} else {
+		b=buffer;
+		l=buffer_length;
+	}
+
+	while (l >= 190) {
+		if (*b == 0xff)
+			switch (*(b+1) & 0x03) {
+				case 0x01: /* media packet */
+					if ( *(b+2) == 0x47 )
+						flexcop_pass_dmx_packets(fc_usb->fc_dev, b+2, 1);
+					else
+						deb_ts("not ts packet %02x %02x %02x %02x \n", *(b+2), *(b+3), *(b+4), *(b+5) );
+
+					b += 190;
+					l -= 190;
+				break;
+				default:
+					deb_ts("wrong packet type\n");
+					l = 0;
+				break;
+			}
+		else {
+			deb_ts("wrong header\n");
+			l = 0;
+		}
+	}
+
+	if (l>0)
+		memcpy(fc_usb->tmp_buffer, b, l);
+	fc_usb->tmp_buffer_length = l;
+}
+
 static void flexcop_usb_urb_complete(struct urb *urb, struct pt_regs *ptregs)
 {
 	struct flexcop_usb *fc_usb = urb->context;
@@ -297,7 +342,7 @@ static void flexcop_usb_urb_complete(str
 			if (urb->iso_frame_desc[i].actual_length > 0) {
 				deb_ts("passed %d bytes to the demux\n",urb->iso_frame_desc[i].actual_length);
 
-				flexcop_pass_dmx_data(fc_usb->fc_dev,
+				flexcop_usb_process_frame(fc_usb,
 					urb->transfer_buffer + urb->iso_frame_desc[i].offset,
 					urb->iso_frame_desc[i].actual_length);
 		}
Index: linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/b2c2/flexcop-usb.h	2005-05-12 01:30:04.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/b2c2/flexcop-usb.h	2005-05-12 01:30:16.000000000 +0200
@@ -21,6 +21,9 @@ struct flexcop_usb {
 	struct urb *iso_urb[B2C2_USB_NUM_ISO_URB];
 
 	struct flexcop_device *fc_dev;
+
+	u8 tmp_buffer[1023+190];
+	int tmp_buffer_length;
 };
 
 #if 0

--

