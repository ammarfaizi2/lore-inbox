Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTKDP2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 10:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTKDP2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 10:28:38 -0500
Received: from s4.uklinux.net ([80.84.72.14]:2249 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S262310AbTKDP2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 10:28:36 -0500
From: Thomas Stewart <thomas@stewarts.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Griffin Powermate broken in 2.6.0-test-9
Date: Tue, 4 Nov 2003 15:29:18 +0000
User-Agent: KMail/1.5.4
Cc: thomas@stewarts.org.uk
X-PGP-Key: http://www.stewarts.org.uk/public-key.asc
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041529.18102.thomas@stewarts.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me, I'm not on the list)

Hi,
My Griffin Powermate (www.griffintechnology.com/products/powermate/) stopped 
working when I switched to 2.6.0-testx. I'm using 2.6-test9 now.

It worked fine when using 2.4.21 and this patch 
http://sowerbutts.com/powermate/powermate-2.4.21.patch, this patch was 
included in 2.4.22, and it continued to work fine.

As far as I can tell, only part of that patch made it into 2.6-0-testx. I have 
the newer variant of the device, which is of coarse is a bit different. It 
sends more data.

I had a stab at getting it working, and the patch I produced appears to work 
fine. I have been using it for about a week, with no obvious problems.

Has anyone else come across this? Or maybe I'm the only person with a 
powermate and 2.6.0-testx running. Anyhow can someone more clever than me 
look at it and get it in test10?

Here it is:-

--- linux-2.6.0-test9/drivers/usb/input/powermate.c.orig	2003-11-04 14:36:23.000000000 +0000
+++ linux-2.6.0-test9/drivers/usb/input/powermate.c	2003-11-04 14:38:07.000000000 +0000
@@ -54,7 +54,11 @@
 #define UPDATE_PULSE_AWAKE       (1<<2)
 #define UPDATE_PULSE_MODE        (1<<3)
 
-#define POWERMATE_PAYLOAD_SIZE 3
+/* at least two versions of the hardware exist, with differing payload 
+   sizes. the first three bytes always contain the "interesting" data in
+   the relevant format. */
+#define POWERMATE_PAYLOAD_SIZE_MAX 6
+#define POWERMATE_PAYLOAD_SIZE_MIN 3
 struct powermate_device {
 	signed char *data;
 	dma_addr_t data_dma;
@@ -269,7 +273,7 @@
 
 static int powermate_alloc_buffers(struct usb_device *udev, struct powermate_device *pm)
 {
-	pm->data = usb_buffer_alloc(udev, POWERMATE_PAYLOAD_SIZE,
+	pm->data = usb_buffer_alloc(udev, POWERMATE_PAYLOAD_SIZE_MAX,
 				    SLAB_ATOMIC, &pm->data_dma);
 	if (!pm->data)
 		return -1;
@@ -284,7 +288,7 @@
 static void powermate_free_buffers(struct usb_device *udev, struct powermate_device *pm)
 {
 	if (pm->data)
-		usb_buffer_free(udev, POWERMATE_PAYLOAD_SIZE,
+		usb_buffer_free(udev, POWERMATE_PAYLOAD_SIZE_MAX,
 				pm->data, pm->data_dma);
 	if (pm->configcr)
 		usb_buffer_free(udev, sizeof(*(pm->configcr)),
@@ -347,12 +351,14 @@
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
 
-	if (maxp != POWERMATE_PAYLOAD_SIZE)
-		printk("powermate: Expected payload of %d bytes, found %d bytes!\n", POWERMATE_PAYLOAD_SIZE, maxp);
-
+	if(maxp < POWERMATE_PAYLOAD_SIZE_MIN || maxp > POWERMATE_PAYLOAD_SIZE_MAX){
+		printk("powermate: Expected payload of %d--%d bytes, found %d bytes!\n",
+			POWERMATE_PAYLOAD_SIZE_MIN, POWERMATE_PAYLOAD_SIZE_MAX, maxp);
+		maxp = POWERMATE_PAYLOAD_SIZE_MAX;
+	}
 
 	usb_fill_int_urb(pm->irq, udev, pipe, pm->data,
-			 POWERMATE_PAYLOAD_SIZE, powermate_irq,
+			 maxp, powermate_irq,
 			 pm, endpoint->bInterval);
 	pm->irq->transfer_dma = pm->data_dma;
 	pm->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

-- 
Tom

PGP Fingerprint [DCCD 7DCB A74A 3E3B 60D5  DF4C FC1D 1ECA 68A7 0C48]
PGP Publickey   [http://www.stewarts.org.uk/public-key.asc]
PGP ID		[0x68A70C48]
