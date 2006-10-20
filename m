Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992432AbWJTFQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992432AbWJTFQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992442AbWJTFQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:16:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:48016 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992432AbWJTFQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:16:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=V/Nqu6BMndqwiv5EdFhSMZnYpe8NbV3hgfQWEvssalKKyDqc6MNj0yUrjpI+ApJCr71AJ1G6XOlVCVbLPeUwO3y5kaN3Ky+m6sHaSBs+Jki3cp1z9eEpGiKBtwiW4Mrev1n9J3agqE8wZgy9RWJUFNuSKnXI7ptiU9bF+ihaNNQ=
Date: Thu, 19 Oct 2006 22:16:42 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] [REVISED 2] drivers/media/video/se401.c: check
 kmalloc() return value.
Message-Id: <20061019221642.d10bae34.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function se401_start_stream(), in file drivers/media/video/se401.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/se401.c b/drivers/media/video/se401.c
index 7aeec57..006c818 100644
--- a/drivers/media/video/se401.c
+++ b/drivers/media/video/se401.c
@@ -450,6 +450,13 @@ static int se401_start_stream(struct usb
 	}
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		se401->sbuf[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
+		if (!se401->sbuf[i].data) {
+			for(i = i - 1; i >= 0; i--) {
+				kfree(se401->sbuf[i].data);
+				se401->sbuf[i].data = NULL;
+			}
+			return -ENOMEM;
+		}
 	}
 
 	se401->bayeroffset=0;
@@ -458,13 +465,26 @@ static int se401_start_stream(struct usb
 	se401->scratch_overflow=0;
 	for (i=0; i<SE401_NUMSCRATCH; i++) {
 		se401->scratch[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
+		if (!se401->scratch[i].data) {
+			for(i = i - 1; i >= 0; i--) {
+				kfree(se401->scratch[i].data);
+				se401->scratch[i].data = NULL;
+			}
+			goto nomem_sbuf;
+		}
 		se401->scratch[i].state=BUFFER_UNUSED;
 	}
 
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		urb=usb_alloc_urb(0, GFP_KERNEL);
-		if(!urb)
-			return -ENOMEM;
+		if(!urb) {
+			for(i = i - 1; i >= 0; i--) {
+				usb_kill_urb(se401->urb[i]);
+				usb_free_urb(se401->urb[i]);
+				se401->urb[i] = NULL;
+			}
+			goto nomem_scratch;
+		}
 
 		usb_fill_bulk_urb(urb, se401->dev,
 			usb_rcvbulkpipe(se401->dev, SE401_VIDEO_ENDPOINT),
@@ -482,6 +502,18 @@ static int se401_start_stream(struct usb
 	se401->framecount=0;
 
 	return 0;
+
+ nomem_scratch:
+	for (i=0; i<SE401_NUMSCRATCH; i++) {
+		kfree(se401->scratch[i].data);
+		se401->scratch[i].data = NULL;
+	}
+ nomem_sbuf:
+	for (i=0; i<SE401_NUMSBUF; i++) {
+		kfree(se401->sbuf[i].data);
+		se401->sbuf[i].data = NULL;
+	}
+	return -ENOMEM;
 }
 
 static int se401_stop_stream(struct usb_se401 *se401)
