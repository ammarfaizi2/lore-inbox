Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVAHJAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVAHJAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVAHIzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:55:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:52869 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261880AbVAHFsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:24 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632583265@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:38 -0800
Message-Id: <11051632581992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.53, 2005/01/07 08:45:52-08:00, david-b@pacbell.net

[PATCH] USB: definitions for USB2 debug device, debug port

This provides basic definitions to support "USB2 Debug Devices", as
supported by certain EHCI root hub ports (from ALI, Intel, NVidia, and
other vendors).  Docs are available at Intel's USB spec webpage.

The basic idea is to help debug "legacy free" systems, with no serial port
for a console or debugger to use.  The USB debug port uses PIO to send and
receive at most 8 bytes of high speed data at a time, so it can support one
I/O channel without needing _any_ of the usbcore infrastructure, or DMA,
or IRQs.  (Cost can be 2KB rather than ~150KB.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/host/ehci.h |   24 ++++++++++++++++++++++++
 include/linux/usb_ch9.h |   13 +++++++++++++
 2 files changed, 37 insertions(+)


diff -Nru a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
--- a/drivers/usb/host/ehci.h	2005-01-07 15:36:12 -08:00
+++ b/drivers/usb/host/ehci.h	2005-01-07 15:36:12 -08:00
@@ -264,6 +264,30 @@
 #define PORT_CONNECT	(1<<0)		/* device connected */
 } __attribute__ ((packed));
 
+/* Appendix C, Debug port ... intended for use with special "debug devices"
+ * that can help if there's no serial console.  (nonstandard enumeration.)
+ */
+struct ehci_dbg_port {
+	u32	control;
+#define DBGP_OWNER	(1<<30)
+#define DBGP_ENABLED	(1<<28)
+#define DBGP_DONE	(1<<16)
+#define DBGP_INUSE	(1<<10)
+#define DBGP_ERRCODE(x)	(((x)>>7)&0x0f)
+#	define DBGP_ERR_BAD	1
+#	define DBGP_ERR_SIGNAL	2
+#define DBGP_ERROR	(1<<6)
+#define DBGP_GO		(1<<5)
+#define DBGP_OUT	(1<<4)
+#define DBGP_LEN(x)	(((x)>>0)&0x0f)
+	u32	pids;
+#define DBGP_PID_GET(x)		(((x)>>16)&0xff)
+#define DBGP_PID_SET(data,tok)	(((data)<<8)|(tok));
+	u32	data03;
+	u32	data47;
+	u32	address;
+#define DBGP_EPADDR(dev,ep)	(((dev)<<8)|(ep));
+} __attribute__ ((packed));
 
 /*-------------------------------------------------------------------------*/
 
diff -Nru a/include/linux/usb_ch9.h b/include/linux/usb_ch9.h
--- a/include/linux/usb_ch9.h	2005-01-07 15:36:12 -08:00
+++ b/include/linux/usb_ch9.h	2005-01-07 15:36:12 -08:00
@@ -79,6 +79,7 @@
 #define USB_DEVICE_B_HNP_ENABLE		3	/* dev may initiate HNP */
 #define USB_DEVICE_A_HNP_SUPPORT	4	/* RH port supports HNP */
 #define USB_DEVICE_A_ALT_HNP_SUPPORT	5	/* other RH port does */
+#define USB_DEVICE_DEBUG_MODE		6	/* (special devices only) */
 
 #define USB_ENDPOINT_HALT		0	/* IN/OUT will STALL */
 
@@ -320,6 +321,18 @@
 /* from usb_otg_descriptor.bmAttributes */
 #define USB_OTG_SRP		(1 << 0)
 #define USB_OTG_HNP		(1 << 1)	/* swap host/device roles */
+
+/*-------------------------------------------------------------------------*/
+
+/* USB_DT_DEBUG:  for special highspeed devices, replacing serial console */
+struct usb_debug_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+
+	/* bulk endpoints with 8 byte maxpacket */
+	__u8  bDebugInEndpoint;
+	__u8  bDebugOutEndpoint;
+};
 
 /*-------------------------------------------------------------------------*/
 

