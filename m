Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbUJ0KO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUJ0KO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUJ0KO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:14:29 -0400
Received: from mail.convergence.de ([212.227.36.84]:35231 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262365AbUJ0Jyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:54:46 -0400
Message-ID: <417F702B.9050909@linuxtv.org>
Date: Wed, 27 Oct 2004 11:53:47 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][4/5] DVB: revamp dibusb driver
References: <417F6EB2.2070807@linuxtv.org> <417F6F0D.9020109@linuxtv.org> <417F6F87.5090703@linuxtv.org> <417F6FD3.3090003@linuxtv.org>
In-Reply-To: <417F6FD3.3090003@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------010809070902010801080706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010809070902010801080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------010809070902010801080706
Content-Type: text/plain;
 name="04-dvb-dibusb-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-dvb-dibusb-update.diff"

- [DVB] dibusb: update documentation for the dibusb DVB driver
- [DVB] dibusb: major overhaul of the driver, including adding new vendor and product ids from clones

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB linux-2.6.10-rc1/Documentation/dvb/README.dibusb linux-2.6.10-rc1-patched/Documentation/dvb/README.dibusb
--- linux-2.6.10-rc1/Documentation/dvb/README.dibusb	2004-10-25 14:03:49.000000000 +0200
+++ linux-2.6.10-rc1-patched/Documentation/dvb/README.dibusb	2004-09-28 21:36:44.000000000 +0200
@@ -1,9 +1,11 @@
+
+
 Documentation for dib3000mb frontend driver and dibusb device driver
 
 The drivers should work with
 
 - Twinhan VisionPlus VisionDTV USB-Ter DVB-T Device (VP7041)
-	http://www.twinhan.com/visiontv-2_4.htm
+	http://www.twinhan.com/
 
 - CTS Portable (Chinese Television System)
 	http://www.2cts.tv/ctsportable/
@@ -19,6 +21,10 @@
 - Ultima Electronic/Artec T1 USB TVBOX
 	http://www.arteceuro.com/products-tvbox.html
 
+- Compro Videomate DVB-U2000 - DVB-T USB
+	http://www.comprousa.com/products/vmu2000.htm
+
+- Unknown USB DVB-T device with vendor ID Hyper-Paltek
 
 Copyright (C) 2004 Patrick Boettcher (patrick.boettcher@desy.de),
 
@@ -32,6 +38,11 @@
 
 
 NEWS:
+  2004-09-28 - added support for a new device (Unkown, vendor ID is Hyper-Paltek)
+  2004-09-20 - added support for a new device (Compro DVB-U2000), thanks
+               to Amaury Demol for reporting
+             - changed usb TS transfer method (several urbs, stopping transfer 
+               before setting a new pid)
   2004-09-13 - added support for a new device (Artec T1 USB TVBOX), thanks
                to Christian Motschke for reporting
   2004-09-05 - released the dibusb device and dib3000mb-frontend driver
@@ -85,8 +96,13 @@
 
 If you want to enable debug output, you have to load the driver manually.
 
-modprobe dvb-dibusb debug=1
-modprobe dib3000mb debug=1
+first have a look, which debug level are available:
+
+modinfo dvb-dibusb
+modinfo dib3000mb
+
+modprobe dvb-dibusb debug=<level> 
+modprobe dib3000mb debug=<level>
 
 should do the trick.
 
@@ -102,11 +118,13 @@
 2. Known problems and bugs
 
 TODO:
-- add some additional URBs for USB data transfer
-- due a firmware problem i2c writes during mpeg transfers destroy the stream
-  no i2c writes during streaming, interrupt streaming, when adding another pid
+- remote control tasklet
+- signal-quality and strength calculations
+- debug messages restructure
+- i2c address probing
+- 
 
-2.1. Adding new devices
+2.1. Adding support for devices 
 
 It is not possible to determine the range of devices based on the DiBcom
 reference design. This is because the reference design of DiBcom can be sold
@@ -122,7 +140,7 @@
 others.
 
 If you are familar with C you can also add the VID and PID of the device to
-the dvb-dibusb.[hc]-files and create a patch and send it over to me or to
+the dvb-dibusb.h-file and create a patch and send it over to me or to 
 the linux-dvb mailing list, _after_ you have tried compiling and modprobing
 it.
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/dibusb/Kconfig linux-2.6.10-rc1-patched/drivers/media/dvb/dibusb/Kconfig
--- linux-2.6.10-rc1/drivers/media/dvb/dibusb/Kconfig	2004-10-25 14:07:53.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/dibusb/Kconfig	2004-09-30 23:29:28.000000000 +0200
@@ -1,5 +1,5 @@
 config DVB_DIBUSB
-	tristate "Twinhan/KWorld/Hama/Artec USB DVB-T devices"
+	tristate "DiBcom/Twinhan/KWorld/Hama/Artec/Compro USB DVB-T devices"
 	depends on DVB_CORE && USB
 	select FW_LOADER
 	help
@@ -8,11 +8,13 @@
 
 	  Devices supported by this driver:
 
-	    Twinhan VisionPlus VisionDTV USB-Ter (VP7041)
+	    TwinhanDTV USB-Ter (VP7041)
+		TwinhanDTV Magic Box (VP7041e)
 	    KWorld V-Stream XPERT DTV - DVB-T USB
 	    Hama DVB-T USB-Box
 	    DiBcom reference device (non-public)
 	    Ultima Electronic/Artec T1 USB TVBOX
+	    Compro Videomate DVB-U2000 - DVB-T USB
 
 	  The VP7041 seems to be identical to "CTS Portable" (Chinese
 	  Television System).
@@ -20,7 +22,7 @@
 	  These devices can be understood as budget ones, they "only" deliver
 	  the MPEG data.
 
-	  Currently all known copies of the DiBcom reference design have the DiBcom 3000MB
+	  Currently all known copies of the DiBcom reference design have the DiBcom 3000-MB 
 	  frontend onboard. Please enable and load this one manually in order to use this
 	  device.
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/dibusb/dvb-dibusb.c linux-2.6.10-rc1-patched/drivers/media/dvb/dibusb/dvb-dibusb.c
--- linux-2.6.10-rc1/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-10-25 14:07:53.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/dibusb/dvb-dibusb.c	2004-10-04 11:12:20.000000000 +0200
@@ -20,9 +20,7 @@
  *  Amaury Demol (ademol@dibcom.fr) from DiBcom for providing specs and driver
  *  sources, on which this driver (and the dib3000mb frontend) are based.
  *
- *  TODO
- *   - probing for i2c addresses, it is possible, that they have been changed
- *     by the vendor
+ * 
  *
  * see Documentation/dvb/README.dibusb for more information
  */
@@ -57,7 +55,7 @@
 
 static int debug;
 module_param(debug, int, 0x644);
-MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore (|-able)).");
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore,8=ts,16=err (|-able)).");
 #else
 #define dprintk_new(args...)
 #define debug_dump(b,l)
@@ -66,31 +64,14 @@
 #define deb_info(args...) dprintk_new(0x01,args)
 #define deb_xfer(args...) dprintk_new(0x02,args)
 #define deb_alot(args...) dprintk_new(0x04,args)
+#define deb_ts(args...)   dprintk_new(0x08,args)
+#define deb_err(args...)   dprintk_new(0x10,args)
 
 /* Version information */
 #define DRIVER_VERSION "0.0"
-#define DRIVER_DESC "DiBcom based USB Budget DVB-T device"
+#define DRIVER_DESC "Driver for DiBcom based USB Budget DVB-T device"
 #define DRIVER_AUTHOR "Patrick Boettcher, patrick.boettcher@desy.de"
 
-/* USB Driver stuff */
-
-/* table of devices that work with this driver */
-static struct usb_device_id dibusb_table [] = {
-	{ USB_DEVICE(USB_TWINHAN_VENDOR_ID, USB_VP7041_PRODUCT_PREFW_ID) },
-	{ USB_DEVICE(USB_TWINHAN_VENDOR_ID, USB_VP7041_PRODUCT_ID) },
-	{ USB_DEVICE(USB_IMC_NETWORKS_VENDOR_ID, USB_VP7041_PRODUCT_PREFW_ID) },
-	{ USB_DEVICE(USB_IMC_NETWORKS_VENDOR_ID, USB_VP7041_PRODUCT_ID) },
-	{ USB_DEVICE(USB_KWORLD_VENDOR_ID, USB_VSTREAM_PRODUCT_PREFW_ID) },
-	{ USB_DEVICE(USB_KWORLD_VENDOR_ID, USB_VSTREAM_PRODUCT_ID) },
-	{ USB_DEVICE(USB_DIBCOM_VENDOR_ID, USB_DIBCOM_PRODUCT_PREFW_ID) },
-	{ USB_DEVICE(USB_DIBCOM_VENDOR_ID, USB_DIBCOM_PRODUCT_ID) },
-	{ USB_DEVICE(USB_ULTIMA_ELECTRONIC_ID, USB_ULTIMA_ELEC_PROD_PREFW_ID) },
-	{ USB_DEVICE(USB_ULTIMA_ELECTRONIC_ID, USB_ULTIMA_ELEC_PROD_ID) },
-	{ }					/* Terminating entry */
-};
-
-MODULE_DEVICE_TABLE (usb, dibusb_table);
-
 static int dibusb_readwrite_usb(struct usb_dibusb *dib,
 		u8 *wbuf, u16 wlen, u8 *rbuf, u16 rlen)
 {
@@ -99,12 +80,14 @@
 	if (wbuf == NULL || wlen == 0)
 		return -EINVAL;
 
-/*	if (dib->disconnecting)
-		return -EINVAL;*/
-
 	if ((ret = down_interruptible(&dib->usb_sem)))
 		return ret;
 
+	if (dib->streaming && wbuf[0] == DIBUSB_REQ_I2C_WRITE)
+		deb_err("BUG: writing to i2c, while TS-streaming destroys the stream. What"
+			" did you do ? Please enable debugging and send the syslog to the author. (%x reg: %x %x)",
+			wbuf[0],wbuf[2],wbuf[3]);
+			
 	debug_dump(wbuf,wlen);
 
 	ret = usb_bulk_msg(dib->udev,COMMAND_PIPE,
@@ -189,6 +172,8 @@
 		(DIB3000MB_FIFO_ACTIVATE >> 8) & 0xff,
 		(DIB3000MB_FIFO_ACTIVATE) & 0xff
 	};
+	dib->streaming = 1;
+	deb_ts("start streaming\n");
 	return dibusb_i2c_msg(dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
 }
 
@@ -200,11 +185,14 @@
 		(DIB3000MB_FIFO_INHIBIT >> 8) & 0xff,
 		(DIB3000MB_FIFO_INHIBIT) & 0xff
 	};
+	dib->streaming = 0;
+	deb_ts("stop streaming\n");
 	return dibusb_i2c_msg(dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
 }
 
 static int dibusb_set_pid(struct dibusb_pid *dpid)
 {
+	struct usb_dibusb *dib = dpid->dib;
 	u16 pid = dpid->pid | (dpid->active ? DIB3000MB_ACTIVATE_FILTERING : 0);
 	u8 b[4] = {
 		(dpid->reg >> 8) & 0xff,
@@ -212,25 +200,50 @@
 		(pid >> 8) & 0xff,
 		(pid) & 0xff
 	};
+	int ret;
+	
+	/* firmware bug, i2c write during mpeg transfer */
+	if (dib->feedcount) {
+		deb_info("stop streaming\n");
+		ret = dibusb_stop_xfer(dib);
+	}
+	
+	if (dpid->active) 
+		dib->feedcount++;
+	else
+		dib->feedcount--;
+
+	ret = dibusb_i2c_msg(dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
 
-	return dibusb_i2c_msg(dpid->dib,DIBUSB_DEMOD_I2C_ADDR_DEFAULT,b,4,NULL,0);
+	if (ret == 0 && dib->feedcount) {
+		deb_info("start streaming\n");
+		ret = dibusb_start_xfer(dib);
+	}
+	return ret;
 }
 
 static void dibusb_urb_complete(struct urb *urb, struct pt_regs *ptregs)
 {
 	struct usb_dibusb *dib = urb->context;
 
-	if (!dib->streaming)
-		return;
+	deb_xfer("urb complete feedcount: %d, status: %d\n",dib->feedcount,urb->status);
 
-	if (urb->status == 0) {
-		deb_info("URB return len: %d\n",urb->actual_length);
+	if (dib->feedcount > 0 && urb->status == 0) {
+		deb_xfer("URB return len: %d\n",urb->actual_length);
 		if (urb->actual_length % 188)
-			deb_info("TS Packets: %d, %d\n", urb->actual_length/188,urb->actual_length % 188);
+			deb_xfer("TS Packets: %d, %d\n", urb->actual_length/188,urb->actual_length % 188);
+
+		/* Francois recommends to drop not full-filled packets, even if they may 
+		 * contain valid TS packets
+		 */
+		if (urb->actual_length == DIBUSB_TS_DEFAULT_SIZE && dib->dvb_is_ready)
 		dvb_dmx_swfilter_packets(&dib->demux, (u8*) urb->transfer_buffer,urb->actual_length/188);
-	}
+		else
+			deb_ts("URB dropped because of the " 
+					"actual_length or !dvb_is_ready (%d).\n",dib->dvb_is_ready);
+	} else 
+		deb_ts("URB dropped because of feedcount or status.\n");
 
-	if (dib->streaming)
 		usb_submit_urb(urb,GFP_KERNEL);
 }
 
@@ -240,9 +253,8 @@
 //	struct dvb_demux *dvbdmx = dvbdmxfeed->demux;
 	struct usb_dibusb *dib = dvbdmxfeed->demux->priv;
 	struct dibusb_pid *dpid;
-	int ret = 0;
 
-	deb_info("pid: 0x%04x, feedtype: %d\n", dvbdmxfeed->pid,dvbdmxfeed->type);
+	deb_ts("pid: 0x%04x, feedtype: %d\n", dvbdmxfeed->pid,dvbdmxfeed->type);
 
 	if ((dpid = dibusb_get_free_pid(dib)) == NULL) {
 		err("no free pid in list.");
@@ -253,32 +265,14 @@
 
 	dibusb_set_pid(dpid);
 
-	if (0 == dib->feed_count++) {
-		usb_fill_bulk_urb( dib->buf_urb, dib->udev, DATA_PIPE,
-			dib->buffer, 8192, dibusb_urb_complete, dib);
-		dib->buf_urb->transfer_flags = 0;
-
-
-		if ((ret = usb_submit_urb(dib->buf_urb,GFP_KERNEL))) {
-			dibusb_stop_xfer(dib);
-			err("could not submit buffer urb.");
-			return ret;
-		}
-
-		if ((ret = dibusb_start_xfer(dib)))
-			return ret;
-
-		dib->streaming = 1;
-	}
 	return 0;
 }
 
 static int dibusb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 {
-	struct usb_dibusb *dib = dvbdmxfeed->demux->priv;
 	struct dibusb_pid *dpid = (struct dibusb_pid *) dvbdmxfeed->priv;
 
-	deb_info("stopfeed pid: 0x%04x, feedtype: %d",dvbdmxfeed->pid, dvbdmxfeed->type);
+	deb_ts("stopfeed pid: 0x%04x, feedtype: %d\n",dvbdmxfeed->pid, dvbdmxfeed->type);
 
 	if (dpid == NULL)
 		err("channel in dmxfeed->priv was NULL");
@@ -288,11 +282,6 @@
 		dibusb_set_pid(dpid);
 	}
 
-	if (--dib->feed_count == 0) {
-		dib->streaming = 0;
-		usb_unlink_urb(dib->buf_urb);
-		dibusb_stop_xfer(dib);
-	}
 	return 0;
 }
 
@@ -302,7 +291,7 @@
 
 /*
  * do not use this, just a workaround for a bug,
- * which will never occur :).
+ * which will hopefully never occur :).
  */
 static int dibusb_interrupt_read_loop(struct usb_dibusb *dib)
 {
@@ -312,7 +301,8 @@
 
 /*
  * TODO: a tasklet should run with a delay of 1/10 second
- * and fill an appropriate event device ?
+ * and feed an appropriate event device ?
+ * NEC protocol is used for remote controlls
  */
 static int dibusb_read_remote_control(struct usb_dibusb *dib)
 {
@@ -321,6 +311,18 @@
 	if ((ret = dibusb_readwrite_usb(dib,b,1,rb,5)))
 		return ret;
 
+
+	
+	switch (rb[0]) {
+		case DIBUSB_RC_NEC_KEY_PRESSED:
+
+			break;
+		case DIBUSB_RC_NEC_EMPTY:
+		case DIBUSB_RC_NEC_KEY_REPEATED:
+		default:
+			break;
+	}
+	
 	return 0;
 }
 
@@ -474,11 +476,13 @@
 err:
 	return ret;
 success:
+	dib->dvb_is_ready = 1;
 	return 0;
 }
 
 static int dibusb_dvb_exit(struct usb_dibusb *dib)
 {
+	dib->dvb_is_ready = 0;
 	deb_info("unregistering DVB part\n");
 	dvb_net_release(&dib->dvb_net);
 	dib->demux.dmx.close(&dib->demux.dmx);
@@ -492,8 +496,16 @@
 
 static int dibusb_exit(struct usb_dibusb *dib)
 {
-	usb_free_urb(dib->buf_urb);
-	pci_free_consistent(NULL,8192,dib->buffer,dib->dma_handle);
+	int i;
+	for (i = 0; i < DIBUSB_TS_NUM_URBS; i++) 
+		if (dib->buf_urb[i] != NULL) {
+			deb_info("killing URB no. %d.\n",i);
+			usb_kill_urb(dib->buf_urb[i]); // TODO kernel version ifdef for unlink_urb
+			
+			deb_info("freeing URB no. %d.\n",i);
+			usb_free_urb(dib->buf_urb[i]);
+		}
+	pci_free_consistent(NULL,DIBUSB_TS_BUFFER_SIZE,dib->buffer,dib->dma_handle);
 	return 0;
 }
 
@@ -513,12 +525,28 @@
 
 	/* dibusb_reset_cpu(dib); */
 
-	dib->buffer = pci_alloc_consistent(NULL,8192, &dib->dma_handle);
-	memset(dib->buffer,0,8192);
-	if (!(dib->buf_urb = usb_alloc_urb(0,GFP_KERNEL))) {
+	if ((dib->buffer = pci_alloc_consistent(NULL,DIBUSB_TS_BUFFER_SIZE, &dib->dma_handle)) == NULL) {
+		return -ENOMEM;
+	}
+	memset(dib->buffer,0,DIBUSB_TS_BUFFER_SIZE);
+	for (i = 0; i < DIBUSB_TS_NUM_URBS; i++) {
+		if (!(dib->buf_urb[i] = usb_alloc_urb(0,GFP_KERNEL))) {
 		dibusb_exit(dib);
 		return -ENOMEM;
 	}
+		deb_info("submitting URB no. %d\n",i);
+
+		usb_fill_bulk_urb( dib->buf_urb[i], dib->udev, DATA_PIPE,
+				&dib->buffer[i*DIBUSB_TS_URB_BUFFER_SIZE], DIBUSB_TS_URB_BUFFER_SIZE, 
+				dibusb_urb_complete, dib);
+		dib->buf_urb[i]->transfer_flags = 0;
+
+		if ((ret = usb_submit_urb(dib->buf_urb[i],GFP_KERNEL))) {
+			err("could not submit buffer urb no. %d\n",i);
+			dibusb_exit(dib);
+			return ret;
+		}
+	}
 
 	for (i=0; i < DIBUSB_MAX_PIDS; i++) {
 		dib->pid_list[i].reg = i+DIB3000MB_REG_FIRST_PID;
@@ -527,8 +555,9 @@
 		dib->pid_list[i].dib = dib;
 	}
 
+	dib->feedcount = 0;
 	dib->streaming = 0;
-	dib->feed_count = 0;
+	dib->dvb_is_ready = 0;
 
 	if ((ret = dibusb_dvb_init(dib))) {
 		dibusb_exit(dib);
@@ -591,19 +620,23 @@
 			if (ret != b[0]) {
 				err("error while transferring firmware "
 					"(transferred size: %d, block size: %d)",
-					ret,b[1]);
+					ret,b[0]);
 				ret = -EINVAL;
 				break;
 			}
 			i += 5 + b[0];
 		}
+		/* length in ret */
+		if (ret > 0)
+			ret = 0;
 		/* restart the CPU */
 		reset = 0;
-		if ((ret = dibusb_writemem(udev,DIBUSB_CPU_CSREG,&reset,1)) != 1)
+		if (ret || dibusb_writemem(udev,DIBUSB_CPU_CSREG,&reset,1) != 1) {
 			err("could not restart the USB controller CPU.");
+			ret = -EINVAL;
+		}
 
 		kfree(p);
-		ret = 0;
 	} else {
 		ret = -ENOMEM;
 	}
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/dibusb/dvb-dibusb.h linux-2.6.10-rc1-patched/drivers/media/dvb/dibusb/dvb-dibusb.h
--- linux-2.6.10-rc1/drivers/media/dvb/dibusb/dvb-dibusb.h	2004-10-25 14:07:53.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/dibusb/dvb-dibusb.h	2004-09-30 23:29:28.000000000 +0200
@@ -7,6 +7,7 @@
  *	modify it under the terms of the GNU General Public License as
  *	published by the Free Software Foundation, version 2.
  *
+ * 
  *
  * for more information see dvb-dibusb.c .
  */
@@ -14,24 +15,102 @@
 #ifndef __DVB_DIBUSB_H__
 #define __DVB_DIBUSB_H__
 
+#define DIBUSB_DEMOD_I2C_ADDR_DEFAULT	0x10
+
 /* Vendor IDs */
-#define USB_TWINHAN_VENDOR_ID			0x1822
-#define USB_IMC_NETWORKS_VENDOR_ID		0x13d3
-#define USB_KWORLD_VENDOR_ID			0xeb1a
-#define USB_DIBCOM_VENDOR_ID			0x10b8
-#define USB_ULTIMA_ELECTRONIC_ID		0x05d8
+#define USB_VID_TWINHAN_ID					0x1822
+#define USB_VID_IMC_NETWORKS_ID				0x13d3
+#define USB_VID_EMPIA_ID					0xeb1a
+#define USB_VID_DIBCOM_ID					0x10b8
+#define USB_VID_ULTIMA_ELECTRONIC_ID		0x05d8
+#define USB_VID_COMPRO_ID					0x185b
+#define USB_VID_HYPER_PALTEK				0x1025
 
 /* Product IDs before loading the firmware */
-#define USB_VP7041_PRODUCT_PREFW_ID		0x3201
-#define USB_VSTREAM_PRODUCT_PREFW_ID	0x17de
-#define USB_DIBCOM_PRODUCT_PREFW_ID		0x0bb8
-#define USB_ULTIMA_ELEC_PROD_PREFW_ID	0x8105
+#define USB_PID_TWINHAN_VP7041_COLD_ID		0x3201
+#define USB_PID_KWORLD_VSTREAM_COLD_ID		0x17de
+#define USB_PID_DIBCOM_MOD3000_COLD_ID		0x0bb8
+#define USB_PID_ULTIMA_TVBOX_COLD_ID		0x8105
+#define USB_PID_COMPRO_DVBU2000_COLD_ID		0xd000
+#define USB_PID_UNK_HYPER_PALTEK_COLD_ID	0x005e
 
 /* product ID afterwards */
-#define USB_VP7041_PRODUCT_ID			0x3202
-#define USB_VSTREAM_PRODUCT_ID			0x17df
-#define USB_DIBCOM_PRODUCT_ID			0x0bb9
-#define USB_ULTIMA_ELEC_PROD_ID			0x8106
+#define USB_PID_TWINHAN_VP7041_WARM_ID		0x3202
+#define USB_PID_KWORLD_VSTREAM_WARM_ID		0x17df
+#define USB_PID_DIBCOM_MOD3000_WARM_ID		0x0bb9
+#define USB_PID_ULTIMA_TVBOX_WARM_ID		0x8106
+#define USB_PID_COMPRO_DVBU2000_WARM_ID		0xd001
+#define USB_PID_UNK_HYPER_PALTEK_WARM_ID	0x005f
+
+/* static array of valid firmware names, the best one first */
+static const char * valid_firmware_filenames[] = {
+	"dvb-dibusb-5.0.0.11.fw",
+};
+
+struct dibusb_device {
+	u16 cold_product_id;
+	u16 warm_product_id;
+	u8 demod_addr;
+	const char *name;
+};
+
+#define DIBUSB_SUPPORTED_DEVICES	6
+
+/* USB Driver stuff */
+static struct dibusb_device dibusb_devices[DIBUSB_SUPPORTED_DEVICES] = {
+	{	.cold_product_id = USB_PID_TWINHAN_VP7041_COLD_ID, 
+		.warm_product_id = USB_PID_TWINHAN_VP7041_WARM_ID,
+		.name = "TwinhanDTV USB-Ter/Magic Box / HAMA USB DVB-T device", 
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_PID_KWORLD_VSTREAM_COLD_ID,
+		.warm_product_id = USB_PID_KWORLD_VSTREAM_WARM_ID,
+		.name = "KWorld V-Stream XPERT DTV - DVB-T USB",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_PID_DIBCOM_MOD3000_COLD_ID,
+		.warm_product_id = USB_PID_DIBCOM_MOD3000_WARM_ID,
+		.name = "DiBcom USB DVB-T reference design (MOD300)",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_PID_ULTIMA_TVBOX_COLD_ID,
+		.warm_product_id = USB_PID_ULTIMA_TVBOX_WARM_ID,
+		.name = "Ultima Electronic/Artec T1 USB TVBOX",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_PID_COMPRO_DVBU2000_COLD_ID,
+		.warm_product_id = USB_PID_COMPRO_DVBU2000_WARM_ID,
+		.name = "Compro Videomate DVB-U2000 - DVB-T USB",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	},
+	{	.cold_product_id = USB_PID_UNK_HYPER_PALTEK_COLD_ID,
+		.warm_product_id = USB_PID_UNK_HYPER_PALTEK_WARM_ID,
+		.name = "Unkown USB DVB-T device ???? please report the name to linux-dvb or to the author",
+		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
+	}
+};
+
+/* USB Driver stuff */
+/* table of devices that work with this driver */
+static struct usb_device_id dibusb_table [] = {
+	{ USB_DEVICE(USB_VID_TWINHAN_ID, 	USB_PID_TWINHAN_VP7041_COLD_ID) },
+	{ USB_DEVICE(USB_VID_TWINHAN_ID, 	USB_PID_TWINHAN_VP7041_WARM_ID) },
+	{ USB_DEVICE(USB_VID_IMC_NETWORKS_ID,USB_PID_TWINHAN_VP7041_COLD_ID) },
+	{ USB_DEVICE(USB_VID_IMC_NETWORKS_ID,USB_PID_TWINHAN_VP7041_WARM_ID) },
+	{ USB_DEVICE(USB_VID_EMPIA_ID,		USB_PID_KWORLD_VSTREAM_COLD_ID) },
+	{ USB_DEVICE(USB_VID_EMPIA_ID,		USB_PID_KWORLD_VSTREAM_WARM_ID) },
+	{ USB_DEVICE(USB_VID_DIBCOM_ID,		USB_PID_DIBCOM_MOD3000_COLD_ID) },
+	{ USB_DEVICE(USB_VID_DIBCOM_ID,		USB_PID_DIBCOM_MOD3000_WARM_ID) },
+	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC_ID, USB_PID_ULTIMA_TVBOX_COLD_ID) },
+	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC_ID, USB_PID_ULTIMA_TVBOX_WARM_ID) },
+	{ USB_DEVICE(USB_VID_COMPRO_ID,		USB_PID_COMPRO_DVBU2000_COLD_ID) },
+	{ USB_DEVICE(USB_VID_COMPRO_ID,		USB_PID_COMPRO_DVBU2000_WARM_ID) },
+	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_COLD_ID) },
+	{ USB_DEVICE(USB_VID_HYPER_PALTEK,	USB_PID_UNK_HYPER_PALTEK_WARM_ID) },
+	{ }                 /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE (usb, dibusb_table);
 
 /* CS register start/stop the usb controller cpu */
 #define DIBUSB_CPU_CSREG				0x7F92
@@ -53,15 +132,20 @@
 	struct usb_dibusb *dib;
 };
 
+#define DIBUSB_TS_NUM_URBS			3
+#define DIBUSB_TS_URB_BUFFER_SIZE	4096
+#define DIBUSB_TS_BUFFER_SIZE		(DIBUSB_TS_NUM_URBS * DIBUSB_TS_URB_BUFFER_SIZE)
+#define DIBUSB_TS_DEFAULT_SIZE		(188*21)
+
 struct usb_dibusb {
 	/* usb */
 	struct usb_device * udev;
 
 	struct dibusb_device * dibdev;
 
+	int feedcount;
 	int streaming;
-	int feed_count;
-	struct urb *buf_urb;
+	struct urb * buf_urb[DIBUSB_TS_NUM_URBS];
 	u8 *buffer;
 	dma_addr_t dma_handle;
 
@@ -77,52 +161,13 @@
 	struct semaphore i2c_sem;
 
 	/* dvb */
+	int dvb_is_ready;
 	struct dvb_adapter *adapter;
 	struct dmxdev dmxdev;
 	struct dvb_demux demux;
 	struct dvb_net dvb_net;
 };
 
-
-struct dibusb_device {
-	u16 cold_product_id;
-	u16 warm_product_id;
-	u8 demod_addr;
-	const char *name;
-};
-
-/* static array of valid firmware names, the best one first */
-static const char * valid_firmware_filenames[] = {
-	"dvb-dibusb-5.0.0.11.fw",
-};
-
-#define DIBUSB_SUPPORTED_DEVICES	4
-
-/* USB Driver stuff */
-static struct dibusb_device dibusb_devices[DIBUSB_SUPPORTED_DEVICES] = {
-	{	.cold_product_id = USB_VP7041_PRODUCT_PREFW_ID,
-		.warm_product_id = USB_VP7041_PRODUCT_ID,
-		.name = "Twinhan VisionDTV USB-Ter/HAMA USB DVB-T device",
-		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
-	},
-	{	.cold_product_id = USB_VSTREAM_PRODUCT_PREFW_ID,
-		.warm_product_id = USB_VSTREAM_PRODUCT_ID,
-		.name = "KWorld V-Stream XPERT DTV - DVB-T USB",
-		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
-	},
-	{	.cold_product_id = USB_DIBCOM_PRODUCT_PREFW_ID,
-		.warm_product_id = USB_DIBCOM_PRODUCT_ID,
-		.name = "DiBcom USB reference design",
-		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
-	},
-	{
- 		.cold_product_id = USB_ULTIMA_ELEC_PROD_PREFW_ID,
-		.warm_product_id = USB_ULTIMA_ELEC_PROD_ID,
-		.name = "Ultima Electronic/Artec T1 USB TVBOX",
-		.demod_addr = DIBUSB_DEMOD_I2C_ADDR_DEFAULT,
-	},
-};
-
 #define COMMAND_PIPE	usb_sndbulkpipe(dib->udev, 0x01)
 #define RESULT_PIPE		usb_rcvbulkpipe(dib->udev, 0x81)
 #define DATA_PIPE		usb_rcvbulkpipe(dib->udev, 0x82)
@@ -142,6 +187,10 @@
 /* prefix for reading the current RC key */
 #define DIBUSB_REQ_POLL_REMOTE			0x04
 
+#define DIBUSB_RC_NEC_EMPTY				0x00
+#define DIBUSB_RC_NEC_KEY_PRESSED		0x01
+#define DIBUSB_RC_NEC_KEY_REPEATED		0x02
+
 /* 0x05 0xXX */
 #define DIBUSB_REQ_SET_STREAMING_MODE	0x05
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/frontends/dib3000mb.c linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/dib3000mb.c
--- linux-2.6.10-rc1/drivers/media/dvb/frontends/dib3000mb.c	2004-10-25 14:07:55.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/dib3000mb.c	2004-10-13 21:36:12.000000000 +0200
@@ -17,6 +17,8 @@
  *  Amaury Demol (ademol@dibcom.fr) from DiBcom for providing specs and driver
  *  sources, on which this driver (and the dvb-dibusb) are based.
  *
+ * 
+ * 
  * see Documentation/dvb/README.dibusb for more information
  *
  */
@@ -36,19 +38,21 @@
 /* debug */
 
 #ifdef CONFIG_DVB_DIBCOM_DEBUG
-#define dprintk_new(level,args...) \
+#define dprintk(level,args...) \
 	do { if ((debug & level)) { printk(args); } } while (0)
 
 static int debug;
 module_param(debug, int, 0x644);
-MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore (|-able)).");
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=xfer,4=alotmore,8=setfe,16=getfe (|-able)).");
 #else
-#define dprintk_new(args...)
+#define dprintk(args...) do { } while (0);
 #endif
 
-#define deb_info(args...) dprintk_new(0x01,args)
-#define deb_xfer(args...) dprintk_new(0x02,args)
-#define deb_alot(args...) dprintk_new(0x04,args)
+#define deb_info(args...) dprintk(0x01,args)
+#define deb_xfer(args...) dprintk(0x02,args)
+#define deb_alot(args...) dprintk(0x04,args)
+#define deb_setf(args...) dprintk(0x08,args)
+#define deb_getf(args...) dprintk(0x10,args)
 
 /* Version information */
 #define DRIVER_VERSION "0.1"
@@ -63,7 +67,7 @@
 };
 
 static struct dvb_frontend_info dib3000mb_info = {
-	.name			= "DiBcom 3000-MB DVB-T frontend",
+	.name			= "DiBcom 3000-MB DVB-T",
 	.type 			= FE_OFDM,
 	.frequency_min 		= 44250000,
 	.frequency_max 		= 867250000,
@@ -72,8 +76,8 @@
 			FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 			FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
 			FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
-			FE_CAN_TRANSMISSION_MODE_AUTO |
 			FE_CAN_GUARD_INTERVAL_AUTO |
+			FE_CAN_TRANSMISSION_MODE_AUTO | 
 			FE_CAN_HIERARCHY_AUTO,
 };
 
@@ -149,7 +153,7 @@
 	u32 dds_val, threshold = 0x800000;
 
 	if (!rd(DIB3000MB_REG_TPS_LOCK))
-		return -EINVAL;
+		return 0;
 
 	dds_val = ((rd(DIB3000MB_REG_DDS_VALUE_MSB) & 0xff) << 16) + rd(DIB3000MB_REG_DDS_VALUE_LSB);
 	if (dds_val & threshold)
@@ -172,56 +176,56 @@
 					||
 		((inv_test2 == 0) && (inv_test1==1 || inv_test1==2));
 
-	deb_info("inversion %d %d, %d\n",inv_test2,inv_test1, fep->inversion);
+	deb_getf("inversion %d %d, %d\n",inv_test2,inv_test1, fep->inversion);
 
 	switch ((tps_val = rd(DIB3000MB_REG_TPS_QAM))) {
 		case DIB3000MB_QAM_QPSK:
-			deb_info("QPSK ");
+			deb_getf("QPSK ");
 			ofdm->constellation = QPSK;
 			break;
 		case DIB3000MB_QAM_QAM16:
-			deb_info("QAM16 ");
+			deb_getf("QAM16 ");
 			ofdm->constellation = QAM_16;
 			break;
 		case DIB3000MB_QAM_QAM64:
-			deb_info("QAM64 ");
+			deb_getf("QAM64 ");
 			ofdm->constellation = QAM_64;
 			break;
 		default:
 			err("Unexpected constellation returned by TPS (%d)",tps_val);
 			break;
  	}
-	deb_info("TPS: %d\n",tps_val);
+	deb_getf("TPS: %d\n",tps_val);
 
 	if (rd(DIB3000MB_REG_TPS_HRCH)) {
-		deb_info("HRCH ON\n");
+		deb_getf("HRCH ON\n");
 		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_LP);
 		cr = &ofdm->code_rate_LP;
 		ofdm->code_rate_HP = FEC_NONE;
 
 		switch ((tps_val = rd(DIB3000MB_REG_TPS_VIT_ALPHA))) {
 			case DIB3000MB_VIT_ALPHA_OFF:
-				deb_info("HIERARCHY_NONE ");
+				deb_getf("HIERARCHY_NONE ");
 				ofdm->hierarchy_information = HIERARCHY_NONE;
 				break;
 			case DIB3000MB_VIT_ALPHA_1:
-				deb_info("HIERARCHY_1 ");
+				deb_getf("HIERARCHY_1 ");
 				ofdm->hierarchy_information = HIERARCHY_1;
 				break;
 			case DIB3000MB_VIT_ALPHA_2:
-				deb_info("HIERARCHY_2 ");
+				deb_getf("HIERARCHY_2 ");
 				ofdm->hierarchy_information = HIERARCHY_2;
 				break;
 			case DIB3000MB_VIT_ALPHA_4:
-				deb_info("HIERARCHY_4 ");
+				deb_getf("HIERARCHY_4 ");
 				ofdm->hierarchy_information = HIERARCHY_4;
 				break;
 			default:
 				err("Unexpected ALPHA value returned by TPS (%d)",tps_val);
 		}
-		deb_info("TPS: %d\n",tps_val);
+		deb_getf("TPS: %d\n",tps_val);
 	} else {
-		deb_info("HRCH OFF\n");
+		deb_getf("HRCH OFF\n");
 		tps_val = rd(DIB3000MB_REG_TPS_CODE_RATE_HP);
 		cr = &ofdm->code_rate_HP;
 		ofdm->code_rate_LP = FEC_NONE;
@@ -230,67 +234,67 @@
 
 	switch (tps_val) {
 		case DIB3000MB_FEC_1_2:
-			deb_info("FEC_1_2 ");
+			deb_getf("FEC_1_2 ");
 			*cr = FEC_1_2;
 			break;
 		case DIB3000MB_FEC_2_3:
-			deb_info("FEC_2_3 ");
+			deb_getf("FEC_2_3 ");
 			*cr = FEC_2_3;
 			break;
 		case DIB3000MB_FEC_3_4:
-			deb_info("FEC_3_4 ");
+			deb_getf("FEC_3_4 ");
 			*cr = FEC_3_4;
 			break;
 		case DIB3000MB_FEC_5_6:
-			deb_info("FEC_5_6 ");
+			deb_getf("FEC_5_6 ");
 			*cr = FEC_4_5;
 			break;
 		case DIB3000MB_FEC_7_8:
-			deb_info("FEC_7_8 ");
+			deb_getf("FEC_7_8 ");
 			*cr = FEC_7_8;
 			break;
 		default:
 			err("Unexpected FEC returned by TPS (%d)",tps_val);
 			break;
 	}
-	deb_info("TPS: %d\n",tps_val);
+	deb_getf("TPS: %d\n",tps_val);
 
 	switch ((tps_val = rd(DIB3000MB_REG_TPS_GUARD_TIME))) {
 		case DIB3000MB_GUARD_TIME_1_32:
-			deb_info("GUARD_INTERVAL_1_32 ");
+			deb_getf("GUARD_INTERVAL_1_32 ");
 			ofdm->guard_interval = GUARD_INTERVAL_1_32;
 			break;
 		case DIB3000MB_GUARD_TIME_1_16:
-			deb_info("GUARD_INTERVAL_1_16 ");
+			deb_getf("GUARD_INTERVAL_1_16 ");
 			ofdm->guard_interval = GUARD_INTERVAL_1_16;
 			break;
 		case DIB3000MB_GUARD_TIME_1_8:
-			deb_info("GUARD_INTERVAL_1_8 ");
+			deb_getf("GUARD_INTERVAL_1_8 ");
 			ofdm->guard_interval = GUARD_INTERVAL_1_8;
 			break;
 		case DIB3000MB_GUARD_TIME_1_4:
-			deb_info("GUARD_INTERVAL_1_4 ");
+			deb_getf("GUARD_INTERVAL_1_4 ");
 			ofdm->guard_interval = GUARD_INTERVAL_1_4;
 			break;
 		default:
 			err("Unexpected Guard Time returned by TPS (%d)",tps_val);
 			break;
 	}
-	deb_info("TPS: %d\n",tps_val);
+	deb_getf("TPS: %d\n",tps_val);
 
 	switch ((tps_val = rd(DIB3000MB_REG_TPS_FFT))) {
 		case DIB3000MB_FFT_2K:
-			deb_info("TRANSMISSION_MODE_2K ");
+			deb_getf("TRANSMISSION_MODE_2K ");
 			ofdm->transmission_mode = TRANSMISSION_MODE_2K;
 			break;
 		case DIB3000MB_FFT_8K:
-			deb_info("TRANSMISSION_MODE_8K ");
+			deb_getf("TRANSMISSION_MODE_8K ");
 			ofdm->transmission_mode = TRANSMISSION_MODE_8K;
 			break;
 		default:
 			err("unexpected transmission mode return by TPS (%d)",tps_val);
 	}
-	deb_info("TPS: %d\n",tps_val);
+	deb_getf("TPS: %d\n",tps_val);
 	return 0;
 }
 
@@ -307,18 +311,18 @@
 	if (irq & 0x02) {
 		if (rd(DIB3000MB_REG_LOCK2_VALUE) & 0x01) {
 			if (dib3000mb_get_frontend(state,&fep) == 0) {
-				deb_info("reading tuning data from frontend succeeded.\n");
+				deb_setf("reading tuning data from frontend succeeded.\n");
 				return dib3000mb_set_frontend(state,&fep,0) == 0;
 			} else {
-				deb_info("reading tuning data failed -> tuning failed.\n");
+				deb_setf("reading tuning data failed -> tuning failed.\n");
 				return 0;
 			}
 		} else {
-			deb_info("AS IRQ was pending, but LOCK2 was not & 0x01.\n");
+			deb_setf("AS IRQ was pending, but LOCK2 was not & 0x01.\n");
 			return 0;
 		}
 	} else if (irq & 0x01) {
-		deb_info("Autosearch failed.\n");
+		deb_setf("Autosearch failed.\n");
 		return 0;
 	}
 
@@ -329,7 +333,7 @@
 		struct dvb_frontend_parameters *fep, int tuner)
 {
 	struct dvb_ofdm_parameters *ofdm = &fep->u.ofdm;
-	fe_code_rate_t fe_cr;
+	fe_code_rate_t fe_cr = FEC_NONE;
 	int search_state,seq;
 
 	if (tuner) {
@@ -342,82 +346,105 @@
 		wr(DIB3000MB_REG_TUNER,
 				DIB3000MB_DEACTIVATE_TUNER_XFER( DIB3000MB_TUNER_ADDR_DEFAULT ) );
 
+		deb_setf("bandwidth: ");
 		switch (ofdm->bandwidth) {
 			case BANDWIDTH_8_MHZ:
-			case BANDWIDTH_AUTO:
+				deb_setf("8 MHz\n");
 				wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[2]);
 				wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_8mhz);
 				break;
 			case BANDWIDTH_7_MHZ:
+				deb_setf("7 MHz\n");
 				wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[1]);
 				wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_7mhz);
 				break;
 			case BANDWIDTH_6_MHZ:
+				deb_setf("6 MHz\n");
 				wr_foreach(dib3000mb_reg_timing_freq,dib3000mb_timing_freq[0]);
 				wr_foreach(dib3000mb_reg_bandwidth,dib3000mb_bandwidth_6mhz);
 				break;
+			case BANDWIDTH_AUTO:
+				return -EOPNOTSUPP;
 			default:
 				err("unkown bandwidth value.");
 				return -EINVAL;
-				break;
 		}
 	}
 	wr(DIB3000MB_REG_LOCK1_MASK,DIB3000MB_LOCK1_SEARCH_4);
 
+	deb_setf("transmission mode: ");
 	switch (ofdm->transmission_mode) {
 		case TRANSMISSION_MODE_2K:
+			deb_setf("2k\n");
 			wr(DIB3000MB_REG_FFT,DIB3000MB_FFT_2K);
 			break;
 		case TRANSMISSION_MODE_8K:
+			deb_setf("8k\n");
 			wr(DIB3000MB_REG_FFT,DIB3000MB_FFT_8K);
 			break;
 		case TRANSMISSION_MODE_AUTO:
+			deb_setf("auto\n");
 			wr(DIB3000MB_REG_FFT,DIB3000MB_FFT_AUTO);
 			break;
 		default:
 			return -EINVAL;
 	}
 
+	deb_setf("guard: ");
 	switch (ofdm->guard_interval) {
 		case GUARD_INTERVAL_1_32:
+			deb_setf("1_32\n");
 			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_32);
 			break;
 		case GUARD_INTERVAL_1_16:
+			deb_setf("1_16\n");
 			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_16);
 			break;
 		case GUARD_INTERVAL_1_8:
+			deb_setf("1_8\n");
 			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_8);
 			break;
 		case GUARD_INTERVAL_1_4:
+			deb_setf("1_4\n");
 			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_1_4);
 			break;
 		case GUARD_INTERVAL_AUTO:
+			deb_setf("auto\n");
 			wr(DIB3000MB_REG_GUARD_TIME,DIB3000MB_GUARD_TIME_AUTO);
 			break;
 		default:
 			return -EINVAL;
 	}
 
+	deb_setf("invsersion: ");
 	switch (fep->inversion) {
+		case INVERSION_AUTO:
+			deb_setf("auto\n");
+			break;
 		case INVERSION_OFF:
+			deb_setf("on\n");
 			wr(DIB3000MB_REG_DDS_INV,DIB3000MB_DDS_INV_OFF);
 			break;
-		case INVERSION_AUTO:
 		case INVERSION_ON:
+			deb_setf("on\n");
 			wr(DIB3000MB_REG_DDS_INV,DIB3000MB_DDS_INV_ON);
 			break;
 		default:
 			return -EINVAL;
 	}
 
+	deb_setf("constellation: ");
 	switch (ofdm->constellation) {
 		case QPSK:
+			deb_setf("qpsk\n");
 			wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_QPSK);
 			break;
 		case QAM_16:
+			deb_setf("qam16\n");
 			wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_QAM16);
 			break;
 		case QAM_64:
+			deb_setf("qam64\n");
 			wr(DIB3000MB_REG_QAM,DIB3000MB_QAM_QAM64);
 			break;
 		case QAM_AUTO:
@@ -425,53 +452,69 @@
 		default:
 			return -EINVAL;
 	}
-
+	deb_setf("hierachy: ");	
 	switch (ofdm->hierarchy_information) {
 		case HIERARCHY_NONE:
+			deb_setf("none ");
+			/* fall through alpha is 1, even when HIERARCHY is NONE */ 
 		case HIERARCHY_1:
+			deb_setf("alpha=1\n");	
 			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_1);
 			break;
 		case HIERARCHY_2:
+			deb_setf("alpha=2\n");	
 			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_2);
 			break;
 		case HIERARCHY_4:
+			deb_setf("alpha=4\n");	
 			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_4);
 			break;
 		case HIERARCHY_AUTO:
+			deb_setf("alpha=auto\n");	
 			wr(DIB3000MB_REG_VIT_ALPHA,DIB3000MB_VIT_ALPHA_AUTO);
 			break;
 		default:
 			return -EINVAL;
 	}
 
+	deb_setf("hierarchy: ");
 	if (ofdm->hierarchy_information == HIERARCHY_NONE) {
+		deb_setf("none\n");
 		wr(DIB3000MB_REG_VIT_HRCH,DIB3000MB_VIT_HRCH_OFF);
 		wr(DIB3000MB_REG_VIT_HP,DIB3000MB_VIT_HP);
 		fe_cr = ofdm->code_rate_HP;
-	} else {
+	} else if (ofdm->hierarchy_information != HIERARCHY_AUTO) {
+		deb_setf("on\n");
 		wr(DIB3000MB_REG_VIT_HRCH,DIB3000MB_VIT_HRCH_ON);
 		wr(DIB3000MB_REG_VIT_HP,DIB3000MB_VIT_LP);
 		fe_cr = ofdm->code_rate_LP;
 	}
-
+	deb_setf("fec: ");
 	switch (fe_cr) {
 		case FEC_1_2:
+			deb_setf("1_2\n");
 			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_1_2);
 			break;
 		case FEC_2_3:
+			deb_setf("2_3\n");
 			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_2_3);
 			break;
 		case FEC_3_4:
+			deb_setf("3_4\n");
 			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_3_4);
 			break;
 		case FEC_5_6:
+			deb_setf("5_6\n");
 			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_5_6);
 			break;
 		case FEC_7_8:
+			deb_setf("7_8\n");
 			wr(DIB3000MB_REG_VIT_CODE_RATE,DIB3000MB_FEC_7_8);
 			break;
 		case FEC_NONE:
+			deb_setf("none ");
 		case FEC_AUTO:
+			deb_setf("auto\n");
 			break;
 		default:
 			return -EINVAL;
@@ -482,7 +525,7 @@
 		[ofdm->guard_interval == GUARD_INTERVAL_AUTO]
 		[fep->inversion == INVERSION_AUTO];
 
-	deb_info("seq? %d\n",seq);
+	deb_setf("seq? %d\n",seq);
 
 	wr(DIB3000MB_REG_SEQ,seq);
 
@@ -522,7 +565,7 @@
 		fe_cr == FEC_AUTO ||
 		fep->inversion == INVERSION_AUTO) {
 
-		deb_info("autosearch enabled.\n");
+		deb_setf("autosearch enabled.\n");	
 
 		wr(DIB3000MB_REG_ISI,DIB3000MB_ISI_INHIBIT);
 
@@ -530,7 +573,7 @@
 		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_OFF);
 
 		while ((search_state = dib3000mb_fe_read_search_status(state)) < 0);
-
+		deb_info("search_state after autosearch %d\n",search_state);
 		return search_state ? 0 : -EINVAL;
 	} else {
 		wr(DIB3000MB_REG_RESTART,DIB3000MB_RESTART_CTRL);
@@ -622,14 +665,25 @@
 static int dib3000mb_read_status(struct dib3000mb_state *state,fe_status_t *stat)
 {
 	*stat = 0;
-	*stat |= rd(DIB3000MB_REG_AGC_LOCK) ? FE_HAS_SIGNAL : 0;
-	*stat |= rd(DIB3000MB_REG_CARRIER_LOCK) ? FE_HAS_CARRIER : 0;
-	*stat |= rd(DIB3000MB_REG_VIT_LCK) ? FE_HAS_VITERBI : 0;
-	*stat |= rd(DIB3000MB_REG_TS_SYNC_LOCK) ? FE_HAS_SYNC : 0;
-	*stat |= *stat ? FE_HAS_LOCK : 0;
+
+	if (rd(DIB3000MB_REG_AGC_LOCK))
+		*stat |= FE_HAS_SIGNAL;
+	if (rd(DIB3000MB_REG_CARRIER_LOCK))
+		*stat |= FE_HAS_CARRIER;
+	if (rd(DIB3000MB_REG_VIT_LCK))
+		*stat |= FE_HAS_VITERBI;
+	if (rd(DIB3000MB_REG_TS_SYNC_LOCK))
+		*stat |= (FE_HAS_SYNC | FE_HAS_LOCK);
 
 	deb_info("actual status is %2x\n",*stat);
 
+	deb_getf("tps %x %x %x %x %x\n",
+			rd(DIB3000MB_REG_TPS_1),
+			rd(DIB3000MB_REG_TPS_2),
+			rd(DIB3000MB_REG_TPS_3),
+			rd(DIB3000MB_REG_TPS_4),
+			rd(DIB3000MB_REG_TPS_5));
+	
 	deb_info("autoval: tps: %d, qam: %d, hrch: %d, alpha: %d, hp: %d, lp: %d, guard: %d, fft: %d cell: %d\n",
 			rd(DIB3000MB_REG_TPS_LOCK),
 			rd(DIB3000MB_REG_TPS_QAM),
@@ -647,15 +701,75 @@
 
 static int dib3000mb_read_ber(struct dib3000mb_state *state,u32 *ber)
 {
-	*ber =
-		(((rd(DIB3000MB_REG_BER_MSB) << 16) & 0x1f) | rd(DIB3000MB_REG_BER_LSB) ) /
-		 100000000;
+	*ber = ((rd(DIB3000MB_REG_BER_MSB) << 16) | rd(DIB3000MB_REG_BER_LSB) );
+	return 0;
+}
+/*
+ * Amaury:
+ * signal strength is measured with dBm (power compared to mW)
+ * the standard range is -90dBm(low power) to -10 dBm (strong power),
+ * but the calibration is done for -100 dBm to 0dBm
+ */
+
+#define DIB3000MB_AGC_REF_dBm		-14
+#define DIB3000MB_GAIN_SLOPE_dBm	100
+#define DIB3000MB_GAIN_DELTA_dBm	-2
+static int dib3000mb_read_signal_strength(struct dib3000mb_state *state, u16 *strength)
+{
+/* TODO log10 
+	u16 sigpow = rd(DIB3000MB_REG_SIGNAL_POWER), 
+		n_agc_power = rd(DIB3000MB_REG_AGC_POWER),
+		rf_power = rd(DIB3000MB_REG_RF_POWER);
+	double rf_power_dBm, ad_power_dBm, minar_power_dBm;
+	
+	if (n_agc_power == 0 )
+		n_agc_power = 1 ;
+
+	ad_power_dBm    = 10 * log10 ( (float)n_agc_power / (float)(1<<16) );
+	minor_power_dBm = ad_power_dBm - DIB3000MB_AGC_REF_dBm;
+	rf_power_dBm = (-DIB3000MB_GAIN_SLOPE_dBm * (float)rf_power / (float)(1<<16) + 
+			DIB3000MB_GAIN_DELTA_dBm) + minor_power_dBm;
+	// relative rf_power 
+	*strength = (u16) ((rf_power_dBm + 100) / 100 * 0xffff);
+*/
+	*strength = rd(DIB3000MB_REG_SIGNAL_POWER) * 0xffff / 0x170;
+	return 0;
+}
+
+/*
+ * Amaury: 
+ * snr is the signal quality measured in dB.
+ * snr = 10*log10(signal power / noise power)
+ * the best quality is near 35dB (cable transmission & good modulator)
+ * the minimum without errors depend of transmission parameters
+ * some indicative values are given in en300744 Annex A
+ * ex : 16QAM 2/3 (Gaussian)  = 11.1 dB
+ *
+ * If SNR is above 20dB, BER should be always 0.
+ * choose 0dB as the minimum
+ */
+static int dib3000mb_read_snr(struct dib3000mb_state *state,u16 *snr)
+{
+	short sigpow = rd(DIB3000MB_REG_SIGNAL_POWER);
+	int icipow = ((rd(DIB3000MB_REG_NOISE_POWER_MSB) & 0xff) << 16) |
+		rd(DIB3000MB_REG_NOISE_POWER_LSB);
+/*
+	float snr_dBm=0;
+
+	if (sigpow > 0 && icipow > 0)
+		snr_dBm = 10.0 * log10( (float) (sigpow<<8) / (float)icipow )  ;
+	else if (sigpow > 0)
+		snr_dBm = 35;
+	
+	*snr = (u16) ((snr_dBm / 35) * 0xffff);
+*/
+	*snr = (sigpow<<8) / (icipow > 0 ? icipow : 1);
 	return 0;
 }
 
-static int dib3000mb_signal_strength(struct dib3000mb_state *state, u16 *strength)
+static int dib3000mb_read_unc_blocks(struct dib3000mb_state *state,u32 *unc)
 {
-//	*stength = DIB3000MB_REG_SIGNAL_POWER
+	*unc = rd(DIB3000MB_REG_UNC);
 	return 0;
 }
 
@@ -665,63 +779,81 @@
 	return 0;
 }
 
+static int dib3000mb_fe_get_tune_settings(struct dib3000mb_state *state, 
+		struct dvb_frontend_tune_settings *tune)
+{
+	tune->min_delay_ms = 800;
+	tune->step_size = 166667;
+	tune->max_drift = 166667*2;
+					
+	return 0;
+}
+
 static int dib3000mb_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
 	struct dib3000mb_state *state = fe->data;
-	int ret = 0;
 	switch (cmd) {
 		case FE_GET_INFO:
 			deb_info("FE_GET_INFO\n");
 			memcpy(arg, &dib3000mb_info, sizeof(struct dvb_frontend_info));
+			return 0;
 			break;
 
 		case FE_READ_STATUS:
 			deb_info("FE_READ_STATUS\n");
-			ret = dib3000mb_read_status(state,(fe_status_t *)arg);
+			return dib3000mb_read_status(state,(fe_status_t *)arg);
 			break;
 
 		case FE_READ_BER:
 			deb_info("FE_READ_BER\n");
-			ret = dib3000mb_read_ber(state,(u32 *)arg);
+			return dib3000mb_read_ber(state,(u32 *)arg);
 			break;
 
 		case FE_READ_SIGNAL_STRENGTH:
 			deb_info("FE_READ_SIG_STRENGTH\n");
-			ret = dib3000mb_signal_strength(state,(u16 *) arg);
+			return dib3000mb_read_signal_strength(state,(u16 *) arg);
 			break;
 
 		case FE_READ_SNR:
 			deb_info("FE_READ_SNR\n");
+			return dib3000mb_read_snr(state,(u16 *) arg);
 			break;
 
 		case FE_READ_UNCORRECTED_BLOCKS:
 			deb_info("FE_READ_UNCORRECTED_BLOCKS\n");
+			return dib3000mb_read_unc_blocks(state,(u32 *) arg);
 			break;
 
 		case FE_SET_FRONTEND:
 			deb_info("FE_SET_FRONTEND\n");
-			ret = dib3000mb_set_frontend(state,(struct dvb_frontend_parameters *) arg,1);
+			return dib3000mb_set_frontend(state,(struct dvb_frontend_parameters *) arg,1);
 			break;
 
 		case FE_GET_FRONTEND:
 			deb_info("FE_GET_FRONTEND\n");
-			ret = dib3000mb_get_frontend(state,(struct dvb_frontend_parameters *) arg);
+			return dib3000mb_get_frontend(state,(struct dvb_frontend_parameters *) arg);
 			break;
 
 		case FE_SLEEP:
 			deb_info("FE_SLEEP\n");
-			ret = dib3000mb_sleep(state);
+			return dib3000mb_sleep(state);
 			break;
 
 		case FE_INIT:
 			deb_info("FE_INIT\n");
-			ret = dib3000mb_fe_init(state,0);
+			return dib3000mb_fe_init(state,0);
 			break;
 
+		case FE_GET_TUNE_SETTINGS:
+			deb_info("GET_TUNE_SETTINGS");
+			return dib3000mb_fe_get_tune_settings(state, (struct
+						dvb_frontend_tune_settings *) arg);
+
+			break;
 		case FE_SET_TONE:
 		case FE_SET_VOLTAGE:
 		default:
-			ret = -EOPNOTSUPP;
+			return -EOPNOTSUPP;
 			break;
 	}
 	return 0;
@@ -753,16 +885,20 @@
 	i2c_set_clientdata(client,state);
 
 	state->manufactor_id = dib3000mb_read_reg(client, DIB3000MB_REG_MANUFACTOR_ID);
+	if (state->manufactor_id != 0x01b3) {
+		ret = -ENODEV;
+		goto probe_err;
+	}
+	
 	state->device_id = dib3000mb_read_reg(client,DIB3000MB_REG_DEVICE_ID);
-	if (state->manufactor_id == 0x01b3 && state->device_id == 0x3000)
-		info("found a DiBCom (0x%04x) 3000-MB DVB-T frontend (ver: %x).",
-				state->manufactor_id, state->device_id);
-	else {
-		err("did not found a DiBCom 3000-MB.");
+	if (state->device_id != 0x3000) {
 		ret = -ENODEV;
 		goto probe_err;
 	}
 
+	info("found a DiBCom (0x%04x) 3000-MB DVB-T frontend (ver: %x).",
+			state->manufactor_id, state->device_id);
+	
 	if ((ret = i2c_attach_client(client)))
 		goto i2c_attach_err;
 
diff -uraNwB linux-2.6.10-rc1/drivers/media/dvb/frontends/dib3000mb.h linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/dib3000mb.h
--- linux-2.6.10-rc1/drivers/media/dvb/frontends/dib3000mb.h	2004-10-25 14:07:56.000000000 +0200
+++ linux-2.6.10-rc1-patched/drivers/media/dvb/frontends/dib3000mb.h	2004-09-28 21:39:06.000000000 +0200
@@ -7,6 +7,7 @@
  *	modify it under the terms of the GNU General Public License as
  *	published by the Free Software Foundation, version 2.
  *
+ * 
  *
  * for more information see dib3000mb.c .
  */
@@ -320,7 +321,7 @@
 #define DIB3000MB_REG_UNK_108			(   108)
 #define DIB3000MB_UNK_108					(0x0080)
 
-/* fft ??? */
+/* fft */
 #define DIB3000MB_REG_UNK_121			(   121)
 #define DIB3000MB_UNK_121_2K				(     7)
 #define DIB3000MB_UNK_121_DEFAULT			(     5)
@@ -351,12 +352,11 @@
 #define DIB3000MB_REG_VIT_CODE_RATE		(   129)
 
 /* forward error correction code rates */
-#define DIB3000MB_FEC_1_2					(     0)
-#define DIB3000MB_FEC_2_3					(     1)
-#define DIB3000MB_FEC_3_4					(     2)
-#define DIB3000MB_FEC_4_5					(     3)
-#define DIB3000MB_FEC_5_6					(     4)
-#define DIB3000MB_FEC_7_8					(     5)
+#define DIB3000MB_FEC_1_2					(     1)
+#define DIB3000MB_FEC_2_3					(     2)
+#define DIB3000MB_FEC_3_4					(     3)
+#define DIB3000MB_FEC_5_6					(     5)
+#define DIB3000MB_FEC_7_8					(     7)
 
 /* vit select hp */
 #define DIB3000MB_REG_VIT_HP			(   130)
@@ -627,8 +627,8 @@
 /* packet error rate (uncorrected TS packets) (16) */
 #define DIB3000MB_REG_PACKET_ERROR_RATE	(   417)
 
-/* packet error count (16) */
-#define DIB3000MB_REG_PACKET_ERROR_COUNT	(   420)
+/* uncorrected packet count (16) */
+#define DIB3000MB_REG_UNC				(   420)
 
 /* viterbi locked (1) */
 #define DIB3000MB_REG_VIT_LCK			(   421)

--------------010809070902010801080706--
