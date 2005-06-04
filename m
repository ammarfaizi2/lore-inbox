Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVFDVPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVFDVPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVFDVPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 17:15:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26824 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261270AbVFDVOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 17:14:48 -0400
Date: Sat, 4 Jun 2005 14:13:34 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: USB 2.4.31: ftdi_sio fixes
Message-Id: <20050604141334.5290866f.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are 7 fixes that Ian Abbott sent me in 2.4.31 frame and which were
delayed while 2.4.31 stabilized.

- A big batch of new IDs, backported from 2.6; with renamed CANview
- Change the message about zero length write to warning
- Fix custom baud bases (by Rogier Wolff)
- Unregister user-specified tables, or else we oops on rmmod
- Actually initialize user-specified devices, using FT8U232AM template
- Add ID for UM100 (by Armin Laugher)
- Restore RTS and DTR after B0 (originally by Nathan Croy)

diff -urp -X dontdiff linux-2.4.31/drivers/usb/serial/ftdi_sio.c linux-2.4.31-usb/drivers/usb/serial/ftdi_sio.c
--- linux-2.4.31/drivers/usb/serial/ftdi_sio.c	2005-04-06 17:11:54.000000000 -0700
+++ linux-2.4.31-usb/drivers/usb/serial/ftdi_sio.c	2005-06-04 13:55:06.000000000 -0700
@@ -350,6 +350,17 @@ static struct usb_device_id id_table_8U2
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_3, 0, 0x3ff) },
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_4, 0, 0x3ff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_ELV_UO100_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_ELV_UM100_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, INSIDE_ACCESSO, 0, 0x3ff) },
+	{ USB_DEVICE_VER(INTREPID_VID, INTREPID_VALUECAN_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(INTREPID_VID, INTREPID_NEOVI_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FALCOM_VID, FALCOM_TWIST_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_SUUNTO_SPORTS_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_RM_CANVIEW_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(BANDB_VID, BANDB_USOTL4_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(BANDB_VID, BANDB_USTL4_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(BANDB_VID, BANDB_USO9ML2_PID, 0, 0x3ff) },
+	{ USB_DEVICE_VER(FTDI_VID, EVER_ECO_PRO_CDS, 0, 0x3ff) },
 	{ }						/* Terminating entry */
 };
 
@@ -378,6 +389,7 @@ static struct usb_device_id id_table_FT2
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_MTXORB_5_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_MTXORB_6_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_PERLE_ULTRAPORT_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_PIEGROUP_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(SEALEVEL_VID, SEALEVEL_2101_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(SEALEVEL_VID, SEALEVEL_2102_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(SEALEVEL_VID, SEALEVEL_2103_PID, 0x400, 0xffff) },
@@ -430,9 +442,41 @@ static struct usb_device_id id_table_FT2
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_R2X0, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_3, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, PROTEGO_SPECIAL_4, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E808_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E809_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80A_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80B_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80C_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80D_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80E_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80F_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E888_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E889_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88A_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88B_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88C_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88D_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88E_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88F_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_ELV_UO100_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_ELV_UM100_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_SDMUSBQSS_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_MASTERDEVEL2_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_0_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_1_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_2_PID, 0x400, 0xffff) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CCSICDU20_0_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CCSICDU40_1_PID) },
+	{ USB_DEVICE_VER(FTDI_VID, INSIDE_ACCESSO, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(INTREPID_VID, INTREPID_VALUECAN_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(INTREPID_VID, INTREPID_NEOVI_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FALCOM_VID, FALCOM_TWIST_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_SUUNTO_SPORTS_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_RM_CANVIEW_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(BANDB_VID, BANDB_USOTL4_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(BANDB_VID, BANDB_USTL4_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(BANDB_VID, BANDB_USO9ML2_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, EVER_ECO_PRO_CDS, 0x400, 0xffff) },
 	{ }						/* Terminating entry */
 };
 
@@ -482,6 +526,7 @@ static __devinitdata struct usb_device_i
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_MTXORB_5_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_MTXORB_6_PID, 0x400, 0xffff) },
 	{ USB_DEVICE_VER(FTDI_VID, FTDI_PERLE_ULTRAPORT_PID, 0x400, 0xffff) },
+	{ USB_DEVICE(FTDI_VID, FTDI_PIEGROUP_PID) },
 	{ USB_DEVICE(SEALEVEL_VID, SEALEVEL_2101_PID) },
 	{ USB_DEVICE(SEALEVEL_VID, SEALEVEL_2102_PID) },
 	{ USB_DEVICE(SEALEVEL_VID, SEALEVEL_2103_PID) },
@@ -536,9 +581,41 @@ static __devinitdata struct usb_device_i
 	{ USB_DEVICE(FTDI_VID, PROTEGO_R2X0) },
 	{ USB_DEVICE(FTDI_VID, PROTEGO_SPECIAL_3) },
 	{ USB_DEVICE(FTDI_VID, PROTEGO_SPECIAL_4) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E808_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E809_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80A_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80B_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80C_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80D_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80E_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E80F_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E888_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E889_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88A_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88B_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88C_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88D_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88E_PID, 0x400, 0xffff) },
+	{ USB_DEVICE_VER(FTDI_VID, FTDI_GUDEADS_E88F_PID, 0x400, 0xffff) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ELV_UO100_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_ELV_UM100_PID) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_SDMUSBQSS_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_MASTERDEVEL2_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_0_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_1_PID, 0x400, 0xffff) },
+ 	{ USB_DEVICE_VER(FTDI_VID, LINX_FUTURE_2_PID, 0x400, 0xffff) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CCSICDU20_0_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CCSICDU40_1_PID) },
+	{ USB_DEVICE(FTDI_VID, INSIDE_ACCESSO) },
+	{ USB_DEVICE(INTREPID_VID, INTREPID_VALUECAN_PID) },
+	{ USB_DEVICE(INTREPID_VID, INTREPID_NEOVI_PID) },
+	{ USB_DEVICE(FALCOM_VID, FALCOM_TWIST_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_SUUNTO_SPORTS_PID) },
+	{ USB_DEVICE(FTDI_VID, FTDI_RM_CANVIEW_PID) },
+	{ USB_DEVICE(BANDB_VID, BANDB_USOTL4_PID) },
+	{ USB_DEVICE(BANDB_VID, BANDB_USTL4_PID) },
+	{ USB_DEVICE(BANDB_VID, BANDB_USO9ML2_PID) },
+	{ USB_DEVICE(FTDI_VID, EVER_ECO_PRO_CDS) },
 	{ }						/* Terminating entry */
 };
 
@@ -1012,7 +1089,7 @@ static int set_serial_info(struct usb_se
 		goto check_and_exit;
 	}
 
-	if ((new_serial.baud_base != priv->baud_base) ||
+	if ((new_serial.baud_base != priv->baud_base) &&
 	    (new_serial.baud_base < 9600))
 		return -EINVAL;
 
@@ -1238,25 +1315,23 @@ static int ftdi_HE_TIRA1_startup (struct
 } /* ftdi_HE_TIRA1_startup */
 
 
-/* Startup for the 8U232AM chip */
+/* Startup for user specified 8U232AM (or 232BM) device */
 static int ftdi_userdev_startup (struct usb_serial *serial)
 {
 	struct ftdi_private *priv;
+	int err;
 
-	priv = serial->port->private = kmalloc(sizeof(struct ftdi_private), GFP_KERNEL);
-	if (!priv){
-		err("%s- kmalloc(%Zd) failed.", __FUNCTION__, sizeof(struct ftdi_private));
-		return -ENOMEM;
+
+	dbg("%s",__FUNCTION__);
+	/* XXX Assume it's a FT8U232AM.  An FT232BM device can be used, but
+	 * it will behave like a FT8U232AM.  -- IJA */
+	err = ftdi_8U232AM_startup(serial);
+	if (err){
+		return (err);
 	}
 
-	priv->chip_type = FT8U232AM; /* XXX: Hmm. Keep this.... -- REW */
+	priv = serial->port->private;
 	priv->baud_base = baud_base; 
-	priv->custom_divisor = 0;
-	priv->write_offset = 0;
-        init_waitqueue_head(&priv->delta_msr_wait);
-	/* This will push the characters through immediately rather
-	   than queue a task to deliver them */
-	priv->flags = ASYNC_LOW_LATENCY;
 	
 	return (0);
 }
@@ -1451,7 +1526,7 @@ static int ftdi_write (struct usb_serial
 	dbg("%s port %d, %d bytes", __FUNCTION__, port->number, count);
 
 	if (count == 0) {
-		err("write request of 0 bytes");
+		dbg("write request of 0 bytes");
 		goto exit;
 	}
 	
@@ -1585,17 +1660,18 @@ static int ftdi_write_room( struct usb_s
 	int i;
 	unsigned long flags;
 
-
 	spin_lock_irqsave (&priv->write_urb_pool_lock, flags);
-
 	for (i = 0; i < NUM_URBS && priv->write_urb_pool[i]; i++) {
-		if (priv->write_urb_pool[i]->status != -EINPROGRESS) {
-			room += URB_TRANSFER_BUFFER_SIZE - priv->write_offset;
-		}
+		if (priv->write_urb_pool[i]->status != -EINPROGRESS)
+			room++;
 	}
-	
 	spin_unlock_irqrestore (&priv->write_urb_pool_lock, flags);
 
+	/* Harmless lies for the sake of line disciplines */
+	if ((room -= 2) < 0)
+		room = 0;
+
+	room *= URB_TRANSFER_BUFFER_SIZE - priv->write_offset;
 	dbg("%s - returns %d", __FUNCTION__, room);	
 	return(room);
 } /* ftdi_write_room */
@@ -1913,6 +1989,13 @@ static void ftdi_set_termios (struct usb
 		if (change_speed(port)) {
 			err("%s urb failed to set baurdrate", __FUNCTION__);
 		}
+		/* Ensure  RTS and DTR are raised */
+		else if (set_dtr(port, HIGH) < 0){
+			err("%s Error from DTR HIGH urb", __FUNCTION__);
+		}
+		else if (set_rts(port, HIGH) < 0){
+			err("%s Error from RTS HIGH urb", __FUNCTION__);
+		}
 	}
 
 	/* Set flow control */
@@ -2209,6 +2292,8 @@ static void __exit ftdi_exit (void)
 
 	dbg("%s", __FUNCTION__);
 
+	if (vendor != -1)
+		usb_serial_deregister (&ftdi_userdev_device);
 	usb_serial_deregister (&ftdi_HE_TIRA1_device);
 	usb_serial_deregister (&ftdi_USB_UIRT_device);
 	usb_serial_deregister (&ftdi_FT232BM_device);
diff -urp -X dontdiff linux-2.4.31/drivers/usb/serial/ftdi_sio.h linux-2.4.31-usb/drivers/usb/serial/ftdi_sio.h
--- linux-2.4.31/drivers/usb/serial/ftdi_sio.h	2004-08-10 13:43:36.000000000 -0700
+++ linux-2.4.31-usb/drivers/usb/serial/ftdi_sio.h	2005-06-04 13:38:29.000000000 -0700
@@ -143,6 +143,8 @@
 
 /* ELV USB Module UO100 (PID sent by Stefan Frings) */
 #define FTDI_ELV_UO100_PID	0xFB58	/* Product Id */
+/* ELV USB Module UM100 (PID sent by Arnim Laeuger) */
+#define FTDI_ELV_UM100_PID	0xFB5A	/* Product Id */
 
 /*
  * Definitions for ID TECH (www.idt-net.com) devices
@@ -155,8 +157,13 @@
  */
 #define OCT_VID			0x0B39	/* OCT vendor ID */
 /* Note: OCT US101 is also rebadged as Dick Smith Electronics (NZ) XH6381 */
+/* Also rebadged as Dick Smith Electronics (Aus) XH6451 */
+/* Also rebadged as SIIG Inc. model US2308 hardware version 1 */
 #define OCT_US101_PID		0x0421	/* OCT US101 USB to RS-232 */
 
+/* an infrared receiver for user access control with IR tags */
+#define FTDI_PIEGROUP_PID	0xF208	/* Product Id */
+
 /*
  * Protego product ids
  */
@@ -165,11 +172,81 @@
 #define PROTEGO_SPECIAL_3	0xFC72	/* special/unknown device */
 #define PROTEGO_SPECIAL_4	0xFC73	/* special/unknown device */ 
 
+/*
+ * Gude Analog- und Digitalsysteme GmbH
+ */
+#define FTDI_GUDEADS_E808_PID    0xE808
+#define FTDI_GUDEADS_E809_PID    0xE809
+#define FTDI_GUDEADS_E80A_PID    0xE80A
+#define FTDI_GUDEADS_E80B_PID    0xE80B
+#define FTDI_GUDEADS_E80C_PID    0xE80C
+#define FTDI_GUDEADS_E80D_PID    0xE80D
+#define FTDI_GUDEADS_E80E_PID    0xE80E
+#define FTDI_GUDEADS_E80F_PID    0xE80F
+#define FTDI_GUDEADS_E888_PID    0xE888  /* Expert ISDN Control USB */
+#define FTDI_GUDEADS_E889_PID    0xE889  /* USB RS-232 OptoBridge */
+#define FTDI_GUDEADS_E88A_PID    0xE88A
+#define FTDI_GUDEADS_E88B_PID    0xE88B
+#define FTDI_GUDEADS_E88C_PID    0xE88C
+#define FTDI_GUDEADS_E88D_PID    0xE88D
+#define FTDI_GUDEADS_E88E_PID    0xE88E
+#define FTDI_GUDEADS_E88F_PID    0xE88F
+
+/*
+ * Linx Technologies product ids
+ */
+#define LINX_SDMUSBQSS_PID	0xF448	/* Linx SDM-USB-QS-S */
+#define LINX_MASTERDEVEL2_PID   0xF449   /* Linx Master Development 2.0 */
+#define LINX_FUTURE_0_PID   0xF44A   /* Linx future device */
+#define LINX_FUTURE_1_PID   0xF44B   /* Linx future device */
+#define LINX_FUTURE_2_PID   0xF44C   /* Linx future device */
+
 /* CCS Inc. ICDU/ICDU40 product ID - the FT232BM is used in an in-circuit-debugger */
 /* unit for PIC16's/PIC18's */
 #define FTDI_CCSICDU20_0_PID  0xF9D0     
 #define FTDI_CCSICDU40_1_PID  0xF9D1     
 
+/* Inside Accesso contactless reader (http://www.insidefr.com) */
+#define INSIDE_ACCESSO		0xFAD0
+
+/*
+ * Intrepid Control Systems (http://www.intrepidcs.com/) ValueCAN and NeoVI
+ */
+#define INTREPID_VID		0x093C
+#define INTREPID_VALUECAN_PID	0x0601
+#define INTREPID_NEOVI_PID	0x0701
+
+/*
+ * Falcom Wireless Communications GmbH
+ */
+#define FALCOM_VID		0x0F94	/* Vendor Id */
+#define FALCOM_TWIST_PID	0x0001	/* Falcom Twist USB GPRS modem */
+
+/*
+ * SUUNTO product ids
+ */
+#define FTDI_SUUNTO_SPORTS_PID	0xF680	/* Suunto Sports instrument */
+
+/*
+ * Definitions for B&B Electronics products.
+ */
+#define BANDB_VID		0x0856	/* B&B Electronics Vendor ID */
+#define BANDB_USOTL4_PID	0xAC01	/* USOTL4 Isolated RS-485 Converter */
+#define BANDB_USTL4_PID		0xAC02	/* USTL4 RS-485 Converter */
+#define BANDB_USO9ML2_PID	0xAC03	/* USO9ML2 Isolated RS-232 Converter */
+
+/*
+ * RM Michaelides CANview USB (http://www.rmcan.com)
+ * CAN fieldbus interface adapter, added by port GmbH www.port.de).
+ * Ian Abbott changed the macro names for consistency.
+ */
+#define FTDI_RM_CANVIEW_PID	0xfd60	/* Product Id */
+
+/*
+ * EVER Eco Pro UPS (http://www.ever.com.pl/)
+ */
+#define	EVER_ECO_PRO_CDS	0xe520	/* RS-232 converter */
+
 /* Commands */
 #define FTDI_SIO_RESET 		0 /* Reset the port */
 #define FTDI_SIO_MODEM_CTRL 	1 /* Set the modem control register */
