Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVCVELQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVCVELQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVCVCTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:19:39 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:55178 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262311AbVCVBej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:34:39 -0500
Message-Id: <20050322013454.699542000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:36 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-dibusb.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 03/48] dibusb: misc. fixes
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o worked around hw_sleep handling for usb1.1 devices
o fixed oops when no frontend was attached (because of usb1.1 timeouts in my
  debugging sessions)
(Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 dvb-dibusb-fe-i2c.c |    4 ++
 dvb-dibusb-usb.c    |   70 ++++++++++++++++++++++++++--------------------------
 2 files changed, 39 insertions(+), 35 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-fe-i2c.c	2005-03-22 00:14:35.000000000 +0100
@@ -178,6 +178,8 @@ int dibusb_fe_init(struct usb_dibusb* di
 				break;
 			}
 		}
+		/* if a frontend was found */
+		if (dib->fe != NULL) {
 			if (dib->fe->ops->sleep != NULL)
 				dib->fe_sleep = dib->fe->ops->sleep;
 			dib->fe->ops->sleep = dibusb_hw_sleep;
@@ -192,6 +194,7 @@ int dibusb_fe_init(struct usb_dibusb* di
 			/* check which tuner is mounted on this device, in case this is unsure */
 			dibusb_tuner_quirk(dib);
 		}
+	}
 	if (dib->fe == NULL) {
 		err("A frontend driver was not found for device '%s'.",
 		       dib->dibdev->name);
@@ -205,6 +208,7 @@ int dibusb_fe_init(struct usb_dibusb* di
 			return -ENODEV;
 		}
 	}
+
 	return 0;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-21 23:27:59.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/dibusb/dvb-dibusb-usb.c	2005-03-22 00:14:35.000000000 +0100
@@ -1,12 +1,12 @@
 /*
- * dvb-dibusb-usb.c is part of the driver for mobile USB Budget DVB-T devices 
+ * dvb-dibusb-usb.c is part of the driver for mobile USB Budget DVB-T devices
  * based on reference design made by DiBcom (http://www.dibcom.fr/)
  *
  * Copyright (C) 2004-5 Patrick Boettcher (patrick.boettcher@desy.de)
  *
  * see dvb-dibusb-core.c for more copyright details.
  *
- * This file contains functions for initializing and handling the 
+ * This file contains functions for initializing and handling the
  * usb specific stuff.
  */
 #include "dvb-dibusb.h"
@@ -25,18 +25,18 @@ int dibusb_readwrite_usb(struct usb_dibu
 	if ((ret = down_interruptible(&dib->usb_sem)))
 		return ret;
 
-	if (dib->feedcount && 
-		wbuf[0] == DIBUSB_REQ_I2C_WRITE && 
+	if (dib->feedcount &&
+		wbuf[0] == DIBUSB_REQ_I2C_WRITE &&
 		dib->dibdev->dev_cl->id == DIBUSB1_1)
 		deb_err("BUG: writing to i2c, while TS-streaming destroys the stream."
 				"(%x reg: %x %x)\n", wbuf[0],wbuf[2],wbuf[3]);
-			
+
 	debug_dump(wbuf,wlen);
 
 	ret = usb_bulk_msg(dib->udev,usb_sndbulkpipe(dib->udev,
 			dib->dibdev->dev_cl->pipe_cmd), wbuf,wlen,&actlen,
 			DIBUSB_I2C_TIMEOUT);
-		
+
 	if (ret)
 		err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
 	else
@@ -55,7 +55,7 @@ int dibusb_readwrite_usb(struct usb_dibu
 			debug_dump(rbuf,actlen);
 		}
 	}
-	
+
 	up(&dib->usb_sem);
 	return ret;
 }
@@ -63,15 +63,18 @@ int dibusb_readwrite_usb(struct usb_dibu
 /*
  * Cypress controls
  */
+static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
+{
+	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
+}
 
 #if 0
-/* 
- * #if 0'ing the following functions as they are not in use _now_, 
+/*
+ * #if 0'ing the following functions as they are not in use _now_,
  * but probably will be sometime.
  */
-
 /*
- * do not use this, just a workaround for a bug, 
+ * do not use this, just a workaround for a bug,
  * which will hopefully never occur :).
  */
 int dibusb_interrupt_read_loop(struct usb_dibusb *dib)
@@ -79,15 +82,10 @@ int dibusb_interrupt_read_loop(struct us
 	u8 b[1] = { DIBUSB_REQ_INTR_READ };
 	return dibusb_write_usb(dib,b,1);
 }
-
-#endif 
-static int dibusb_write_usb(struct usb_dibusb *dib, u8 *buf, u16 len)
-{
-	return dibusb_readwrite_usb(dib,buf,len,NULL,0);
-}
+#endif
 
 /*
- * ioctl for the firmware 
+ * ioctl for the firmware
  */
 static int dibusb_ioctl_cmd(struct usb_dibusb *dib, u8 cmd, u8 *param, int plen)
 {
@@ -112,10 +110,10 @@ int dibusb_hw_wakeup(struct dvb_frontend
 	u8 b[1] = { DIBUSB_IOCTL_POWER_WAKEUP };
 	deb_info("dibusb-device is getting up.\n");
 	dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
-	
+
 	if (dib->fe_init)
 		return dib->fe_init(fe);
-	
+
 	return 0;
 }
 
@@ -124,11 +122,13 @@ int dibusb_hw_sleep(struct dvb_frontend 
 	struct usb_dibusb *dib = (struct usb_dibusb *) fe->dvb->priv;
 	u8 b[1] = { DIBUSB_IOCTL_POWER_SLEEP };
 	deb_info("dibusb-device is going to bed.\n");
-	dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
+	/* workaround, something is wrong, when dibusb 1.1 device are going to bed too late */
+	if (dib->dibdev->dev_cl->id != DIBUSB1_1)
+		dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_POWER_MODE, b,1);
 
 	if (dib->fe_sleep)
 		return dib->fe_sleep(fe);
-	
+
 	return 0;
 }
 
@@ -147,7 +147,7 @@ int dibusb_streaming(struct usb_dibusb *
 			else
 				return dibusb_ioctl_cmd(dib,DIBUSB_IOCTL_CMD_DISABLE_STREAM,NULL,0);
 			break;
-		case UMT2_0: 
+		case UMT2_0:
 			return dibusb_set_streaming_mode(dib,onoff);
 			break;
 		default:
@@ -159,9 +159,9 @@ int dibusb_streaming(struct usb_dibusb *
 int dibusb_urb_init(struct usb_dibusb *dib)
 {
 	int ret,i,bufsize,def_pid_parse = 1;
-	
+
 	/*
-	 * when reloading the driver w/o replugging the device 
+	 * when reloading the driver w/o replugging the device
 	 * a timeout occures, this helps
 	 */
 	usb_clear_halt(dib->udev,usb_sndbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_cmd));
@@ -175,7 +175,7 @@ int dibusb_urb_init(struct usb_dibusb *d
 	memset(dib->urb_list,0,dib->dibdev->dev_cl->urb_count*sizeof(struct urb *));
 
 	dib->init_state |= DIBUSB_STATE_URB_LIST;
-	
+
 	bufsize = dib->dibdev->dev_cl->urb_count*dib->dibdev->dev_cl->urb_buffer_size;
 	deb_info("allocate %d bytes as buffersize for all URBs\n",bufsize);
 	/* allocate the actual buffer for the URBs */
@@ -185,7 +185,7 @@ int dibusb_urb_init(struct usb_dibusb *d
 	}
 	deb_info("allocation complete\n");
 	memset(dib->buffer,0,bufsize);
-	
+
 	dib->init_state |= DIBUSB_STATE_URB_BUF;
 
 	/* allocate and submit the URBs */
@@ -194,13 +194,13 @@ int dibusb_urb_init(struct usb_dibusb *d
 			return -ENOMEM;
 		}
 		deb_info("submitting URB no. %d\n",i);
-		
-		usb_fill_bulk_urb( dib->urb_list[i], dib->udev, 
+
+		usb_fill_bulk_urb( dib->urb_list[i], dib->udev,
 				usb_rcvbulkpipe(dib->udev,dib->dibdev->dev_cl->pipe_data),
-				&dib->buffer[i*dib->dibdev->dev_cl->urb_buffer_size], 
-				dib->dibdev->dev_cl->urb_buffer_size, 
+				&dib->buffer[i*dib->dibdev->dev_cl->urb_buffer_size],
+				dib->dibdev->dev_cl->urb_buffer_size,
 				dibusb_urb_complete, dib);
-		
+
 		dib->urb_list[i]->transfer_flags = 0;
 
 		if ((ret = usb_submit_urb(dib->urb_list[i],GFP_ATOMIC))) {
@@ -222,12 +222,12 @@ int dibusb_urb_init(struct usb_dibusb *d
 			} else
 				info("will use pid_parsing.");
 			break;
-		default: 
+		default:
 			break;
 	}
 	/* from here on it contains the device and user decision */
 	dib->pid_parse = def_pid_parse;
-	
+
 	return 0;
 }
 
@@ -241,7 +241,7 @@ int dibusb_urb_exit(struct usb_dibusb *d
 
 				/* stop the URBs */
 				usb_kill_urb(dib->urb_list[i]);
-				
+
 				deb_info("freeing URB no. %d.\n",i);
 				/* free the URBs */
 				usb_free_urb(dib->urb_list[i]);

--

