Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWJTF7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWJTF7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWJTF7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:59:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20244 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751678AbWJTF7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:59:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=H8OZplkwU3BLYCU4g1deV/1Ake305s9aPtcGhHWaa8H1pT7X5XQroAupgR7pfNC51BA3Poa1IB1y9I+g4L9qy6fTY8xpdkGiYeQPDjNPrFPAzbz71xZu0TAI9fhdgQ7kWjg1cxngMo+idZY6qrsp9pqyS+zk303WBDyb2bKjPkI=
Date: Thu, 19 Oct 2006 22:59:29 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] [REVISED] drivers/media/video/stv680.c: check
 kmalloc() return value.
Message-Id: <20061019225929.e1bf9816.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function stv680_start_stream(), in file drivers/media/video/stv680.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/stv680.c b/drivers/media/video/stv680.c
index 6d1ef1e..f35c664 100644
--- a/drivers/media/video/stv680.c
+++ b/drivers/media/video/stv680.c
@@ -687,7 +687,11 @@ static int stv680_start_stream (struct u
 		stv680->sbuf[i].data = kmalloc (stv680->rawbufsize, GFP_KERNEL);
 		if (stv680->sbuf[i].data == NULL) {
 			PDEBUG (0, "STV(e): Could not kmalloc raw data buffer %i", i);
-			return -1;
+			for (i = i - 1; i >= 0; i--) {
+				kfree(stv680->sbuf[i].data);
+				stv680->sbuf[i].data = NULL;
+			}
+			return -ENOMEM;
 		}
 	}
 
@@ -698,15 +702,25 @@ static int stv680_start_stream (struct u
 		stv680->scratch[i].data = kmalloc (stv680->rawbufsize, GFP_KERNEL);
 		if (stv680->scratch[i].data == NULL) {
 			PDEBUG (0, "STV(e): Could not kmalloc raw scratch buffer %i", i);
-			return -1;
+			for (i = i - 1; i >= 0; i--) {
+				kfree(stv680->scratch[i].data);
+				stv680->scratch[i].data = NULL;
+			}
+			goto nomem_sbuf;
 		}
 		stv680->scratch[i].state = BUFFER_UNUSED;
 	}
 
 	for (i = 0; i < STV680_NUMSBUF; i++) {
 		urb = usb_alloc_urb (0, GFP_KERNEL);
-		if (!urb)
-			return -ENOMEM;
+		if (!urb) {
+			for (i = i - 1; i >= 0; i--) {
+				usb_kill_urb(stv680->urb[i]);
+				usb_free_urb(stv680->urb[i]);
+				stv680->urb[i] = NULL;
+			}
+			goto nomem_scratch;
+		}
 
 		/* sbuf is urb->transfer_buffer, later gets memcpyed to scratch */
 		usb_fill_bulk_urb (urb, stv680->udev,
@@ -721,6 +735,18 @@ static int stv680_start_stream (struct u
 
 	stv680->framecount = 0;
 	return 0;
+
+ nomem_scratch:
+	for (i=0; i<STV680_NUMSCRATCH; i++) {
+		kfree(stv680->scratch[i].data);
+		stv680->scratch[i].data = NULL;
+	}
+ nomem_sbuf:
+	for (i=0; i<STV680_NUMSBUF; i++) {
+		kfree(stv680->sbuf[i].data);
+		stv680->sbuf[i].data = NULL;
+	}
+	return -ENOMEM;
 }
 
 static int stv680_stop_stream (struct usb_stv *stv680)
