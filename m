Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSFJM1N>; Mon, 10 Jun 2002 08:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSFJM1N>; Mon, 10 Jun 2002 08:27:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43014 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312938AbSFJM1H>; Mon, 10 Jun 2002 08:27:07 -0400
Message-ID: <3D048D5A.1030103@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:28:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 5/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020805070009010709000902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020805070009010709000902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix improper __FUNCTION__ usage in st680 driver code,
cdc-ether.c. Fix namespace clash in cdc-ether.h

--------------020805070009010709000902
Content-Type: text/plain;
 name="warn-2.5.21-5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="warn-2.5.21-5.diff"

diff -urN linux-2.5.21/drivers/usb/media/stv680.c linux/drivers/usb/media/stv680.c
--- linux-2.5.21/drivers/usb/media/stv680.c	2002-06-09 07:27:26.000000000 +0200
+++ linux/drivers/usb/media/stv680.c	2002-06-09 19:30:32.000000000 +0200
@@ -86,7 +86,7 @@
 #define PDEBUG(level, fmt, args...) \
 	do { \
 	if (debug >= level)	\
-		info("[" __PRETTY_FUNCTION__ ":%d] " fmt, __LINE__ , ## args);	\
+		info("[%s:%d] " fmt, __FUNCTION__, __LINE__ , ## args);	\
 	} while (0)
 
 
diff -urN linux-2.5.21/drivers/usb/net/cdc-ether.c linux/drivers/usb/net/cdc-ether.c
--- linux-2.5.21/drivers/usb/net/cdc-ether.c	2002-06-09 07:26:52.000000000 +0200
+++ linux/drivers/usb/net/cdc-ether.c	2002-06-09 19:35:57.000000000 +0200
@@ -129,13 +129,13 @@
 			usb_rcvbulkpipe(ether_dev->usb, ether_dev->data_ep_in),
 			ether_dev->rx_buff, ether_dev->wMaxSegmentSize, 
 			read_bulk_callback, ether_dev );
-			
-	// Give this to the USB subsystem so it can tell us 
+
+	// Give this to the USB subsystem so it can tell us
 	// when more data arrives.
 	if ( (res = usb_submit_urb(ether_dev->rx_urb, GFP_KERNEL)) ) {
-		warn( __FUNCTION__ " failed submint rx_urb %d", res);
+		warn("%s failed submint rx_urb %d", __FUNCTION__, res);
 	}
-	
+
 	// We are no longer busy, show us the frames!!!
 	ether_dev->flags &= ~CDC_ETHER_RX_BUSY;
 }
@@ -339,7 +339,7 @@
 
 	// Turn on the USB and let the packets flow!!!
 	if ( (res = enable_net_traffic( ether_dev )) ) {
-		err( __FUNCTION__ "can't enable_net_traffic() - %d", res );
+		err("%s can't enable_net_traffic() - %d", __FUNCTION__, res );
 		return -EIO;
 	}
 
@@ -353,7 +353,7 @@
 	if ( (res = usb_submit_urb(ether_dev->rx_urb, GFP_KERNEL)) )
 	{
 		// Hmm...  Okay...
-		warn( __FUNCTION__ " failed rx_urb %d", res );
+		warn("%s failed rx_urb %d", __FUNCTION__, res );
 	}
 
 	// Tell the kernel we are ready to start receiving from it
@@ -411,6 +411,7 @@
 	}
 }
 
+#if 0
 static void CDC_SetEthernetPacketFilter (ether_dev_t *ether_dev)
 {
 	usb_control_msg(ether_dev->usb,
@@ -422,15 +423,15 @@
 			NULL,
 			0, /* size */
 			HZ); /* timeout */
-}	
-
+}
+#endif
 
 static void CDCEther_set_multicast( struct net_device *net )
 {
 	ether_dev_t *ether_dev = net->priv;
 	int i;
 	__u8 *buff;
-	
+
 
 	// Tell the kernel to stop sending us frames while we get this
 	// all set up.
diff -urN linux-2.5.21/drivers/usb/net/cdc-ether.h linux/drivers/usb/net/cdc-ether.h
--- linux-2.5.21/drivers/usb/net/cdc-ether.h	2002-06-09 07:27:42.000000000 +0200
+++ linux/drivers/usb/net/cdc-ether.h	2002-06-09 19:34:50.000000000 +0200
@@ -43,7 +43,7 @@
 #define	CDC_ETHER_REQ_GET_REGS	0xf0
 #define	CDC_ETHER_REQ_SET_REGS	0xf1
 #define	CDC_ETHER_REQ_SET_REG	PIPERIDER_REQ_SET_REGS
-#define	ALIGN(x)		x __attribute__((aligned(L1_CACHE_BYTES)))
+#define	L1_ALIGN(x)		x __attribute__((aligned(L1_CACHE_BYTES)))
 
 #define MODE_FLAG_PROMISCUOUS   (1<<0)
 #define MODE_FLAG_ALL_MULTICAST (1<<1)
@@ -84,9 +84,9 @@
 	__u8			bNumberPowerFilters;
 	int			intr_interval;
 	struct urb		*rx_urb, *tx_urb, *intr_urb;
-	unsigned char		ALIGN(rx_buff[CDC_ETHER_MAX_MTU]);
-	unsigned char		ALIGN(tx_buff[CDC_ETHER_MAX_MTU]);
-	unsigned char		ALIGN(intr_buff[8]);
+	unsigned char		L1_ALIGN(rx_buff[CDC_ETHER_MAX_MTU]);
+	unsigned char		L1_ALIGN(tx_buff[CDC_ETHER_MAX_MTU]);
+	unsigned char		L1_ALIGN(intr_buff[8]);
 } ether_dev_t;
 
 #define REQ_HDR_FUNC_DESCR	0x0001

--------------020805070009010709000902--

