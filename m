Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268025AbUJWAte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268025AbUJWAte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269527AbUJWAq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:46:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4881 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269680AbUJWApA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:45:00 -0400
Date: Sat, 23 Oct 2004 02:44:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, patrick.boettcher@desy.de
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [patch] 2.6.9-mm1: dvb-dibusb.c: remove unused code
Message-ID: <20041023004416.GE22558@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following warnings come from Linus' tree:

<--  snip  -->

...
  CC      drivers/media/dvb/dibusb/dvb-dibusb.o
drivers/media/dvb/dibusb/dvb-dibusb.c:308: warning: 'dibusb_interrupt_read_loop' defined but not used
drivers/media/dvb/dibusb/dvb-dibusb.c:318: warning: 'dibusb_read_remote_control' defined but not used
drivers/media/dvb/dibusb/dvb-dibusb.c:345: warning: 'dibusb_hw_sleep' defined but not used
drivers/media/dvb/dibusb/dvb-dibusb.c:351: warning: 'dibusb_hw_wakeup' defined but not used
...

<--  snip  -->


The patch below removes the unused code from this file.


diffstat output:
 drivers/media/dvb/dibusb/dvb-dibusb.c |   62 --------------------------
 1 files changed, 62 deletions(-)



Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/drivers/media/dvb/dibusb/dvb-dibusb.c.old	2004-10-23 02:37:56.000000000 +0200
+++ linux-2.6.9-mm1-full/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-10-23 02:42:14.000000000 +0200
@@ -132,11 +132,6 @@
 	return ret;
 }
 
-static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
-{
-	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
-}
-
 static int dibusb_i2c_msg(struct usb_dibusb *dib, u8 addr,
 		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
 {
@@ -297,63 +292,6 @@
 }
 
 /*
- * firmware transfers
- */
-
-/*
- * do not use this, just a workaround for a bug,
- * which will never occur :).
- */
-static int dibusb_interrupt_read_loop(struct usb_dibusb *dib)
-{
-	u8 b[1] = { DIBUSB_REQ_INTR_READ };
-	return dibusb_write_usb(dib,b,1);
-}
-
-/*
- * TODO: a tasklet should run with a delay of 1/10 second
- * and fill an appropriate event device ?
- */
-static int dibusb_read_remote_control(struct usb_dibusb *dib)
-{
-	u8 b[1] = { DIBUSB_REQ_POLL_REMOTE }, rb[5];
-	int ret;
-	if ((ret = dibusb_readwrite_usb(dib,b,1,rb,5)))
-		return ret;
-
-	return 0;
-}
-
-/*
- * ioctl for the firmware
- */
-static int dibusb_ioctl_cmd(struct usb_dibusb *dib, u8 cmd, u8 *param, int plen)
-{
-	u8 b[34];
-	int size = plen > 32 ? 32 : plen;
-	b[0] = DIBUSB_REQ_SET_IOCTL;
-	b[1] = cmd;
-	memcpy(&b[2],param,size);
-
-	return dibusb_write_usb(dib,b,2+size);
-}
-
-/*
- * ioctl for power control
- */
-static int dibusb_hw_sleep(struct usb_dibusb *dib)
-{
-	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
-	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
-}
-
-static int dibusb_hw_wakeup(struct usb_dibusb *dib)
-{
-	u8 b[1] = { DIBUSB_IOCTL_POWER_WAKEUP };
-	return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
-}
-
-/*
  * I2C
  */
 static int dibusb_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num)


