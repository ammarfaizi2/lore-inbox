Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbVH0Rax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbVH0Rax (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 13:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVH0Rax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 13:30:53 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:57781 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1751618AbVH0Rax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 13:30:53 -0400
Date: Sat, 27 Aug 2005 19:30:30 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub3.ifh.de
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for race problem in DVB USB drivers (dibusb)
Message-ID: <Pine.LNX.4.61.0508271911540.15908@pub3.ifh.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Report: ALL_TRUSTED,AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Below you'll find a patch, which fixes an ugly problem with some DVB USB 
devices. I would highly appreciate the inclusion into the linux kernel 
before 2.6.13 is released.

Thank you very much in advance,
Patrick.

--------

Fixed race between submitting streaming URBs in the driver and starting 
the actual transfer in hardware (demodulator and USB controller) which 
sometimes lead to garbled data transfers. URBs are now submitted first, 
then the transfer is enabled. Dibusb devices and clones are now fully 
functional again.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>

Index: linux/drivers/media/dvb/dvb-usb/dibusb-common.c
===================================================================
RCS file: /cvs/linuxtv/dvb-kernel/linux/drivers/media/dvb/dvb-usb/dibusb-common.c,v
retrieving revision 1.9
diff -u -r1.9 dibusb-common.c
--- linux/drivers/media/dvb/dvb-usb/dibusb-common.c	19 Jun 2005 13:13:47 -0000	1.9
+++ linux/drivers/media/dvb/dvb-usb/dibusb-common.c	27 Aug 2005 16:56:10 -0000
@@ -69,13 +69,22 @@

  int dibusb2_0_streaming_ctrl(struct dvb_usb_device *d, int onoff)
  {
-	u8 b[2];
-	b[0] = DIBUSB_REQ_SET_IOCTL;
-	b[1] = onoff ? DIBUSB_IOCTL_CMD_ENABLE_STREAM : DIBUSB_IOCTL_CMD_DISABLE_STREAM;
+	u8 b[3] = { 0 };
+	int ret;

-	dvb_usb_generic_write(d,b,3);
+	if ((ret = dibusb_streaming_ctrl(d,onoff)) < 0)
+		return ret;

-	return dibusb_streaming_ctrl(d,onoff);
+	if (onoff) {
+		b[0] = DIBUSB_REQ_SET_STREAMING_MODE;
+		b[1] = 0x00;
+		if ((ret = dvb_usb_generic_write(d,b,2)) < 0)
+			return ret;
+	}
+
+	b[0] = DIBUSB_REQ_SET_IOCTL;
+	b[1] = onoff ? DIBUSB_IOCTL_CMD_ENABLE_STREAM : DIBUSB_IOCTL_CMD_DISABLE_STREAM;
+	return dvb_usb_generic_write(d,b,3);
  }
  EXPORT_SYMBOL(dibusb2_0_streaming_ctrl);

Index: linux/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c
===================================================================
RCS file: /cvs/linuxtv/dvb-kernel/linux/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c,v
retrieving revision 1.8
diff -u -r1.8 dvb-usb-dvb.c
--- linux/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c	2 Jul 2005 12:49:23 -0000	1.8
+++ linux/drivers/media/dvb/dvb-usb/dvb-usb-dvb.c	27 Aug 2005 16:56:10 -0000
@@ -23,12 +23,12 @@
  	 */
  	if (newfeedcount == 0) {
  		deb_ts("stop feeding\n");
+		dvb_usb_urb_kill(d);

  		if (d->props.streaming_ctrl != NULL)
  			if ((ret = d->props.streaming_ctrl(d,0)))
  				err("error while stopping stream.");

-		dvb_usb_urb_kill(d);
  	}

  	d->feedcount = newfeedcount;
@@ -44,6 +44,8 @@
  	 * for reception.
  	 */
  	if (d->feedcount == onoff && d->feedcount > 0) {
+		deb_ts("submitting all URBs\n");
+		dvb_usb_urb_submit(d);

  		deb_ts("controlling pid parser\n");
  		if (d->props.caps & DVB_USB_HAS_PID_FILTER &&
@@ -59,7 +61,6 @@
  				return -ENODEV;
  			}

-		dvb_usb_urb_submit(d);
  	}
  	return 0;
  }
