Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWJREcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWJREcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWJREcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:32:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:62143 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751372AbWJREcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:32:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=JPN8UA0aDHk6jtu4wvl6aDNiZZJV7gUMT8/k1V8Fm0bphHevtsdceGFzPTaPbEZLMBWUcl1XdxVyKWIutO/lwO6FmRMtlLfrck5oQ3gsdXRHzwxAiO+3Lc2eye+pTdvOKFQGUeYIOV/fdn5Jcv/vAzknz0sDc901fEffQj2N09U=
Date: Tue, 17 Oct 2006 21:31:55 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] [REVISED] drivers/media/video/se401.c: check
 kmalloc() return value.
Message-Id: <20061017213155.35983846.amit2030@gmail.com>
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
index 7aeec57..fe94227 100644
--- a/drivers/media/video/se401.c
+++ b/drivers/media/video/se401.c
@@ -450,6 +450,8 @@ static int se401_start_stream(struct usb
 	}
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		se401->sbuf[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
+		if (!se401->sbuf[i].data)
+			goto nomem_err;
 	}
 
 	se401->bayeroffset=0;
@@ -458,13 +460,15 @@ static int se401_start_stream(struct usb
 	se401->scratch_overflow=0;
 	for (i=0; i<SE401_NUMSCRATCH; i++) {
 		se401->scratch[i].data=kmalloc(SE401_PACKETSIZE, GFP_KERNEL);
+		if (!se401->scratch[i].data)
+			goto nomem_err;
 		se401->scratch[i].state=BUFFER_UNUSED;
 	}
 
 	for (i=0; i<SE401_NUMSBUF; i++) {
 		urb=usb_alloc_urb(0, GFP_KERNEL);
 		if(!urb)
-			return -ENOMEM;
+			goto nomem_err;
 
 		usb_fill_bulk_urb(urb, se401->dev,
 			usb_rcvbulkpipe(se401->dev, SE401_VIDEO_ENDPOINT),
@@ -482,6 +486,20 @@ static int se401_start_stream(struct usb
 	se401->framecount=0;
 
 	return 0;
+
+ nomem_err:
+	for (i=0; i<SE401_NUMSBUF; i++) {
+		usb_kill_urb(se401->urb[i]);
+		usb_free_urb(se401->urb[i]);
+		se401->urb[i] = NULL;
+		kfree(se401->sbuf[i].data);
+		se401->sbuf[i].data = NULL;
+	}
+	for (i=0; i<SE401_NUMSCRATCH; i++) {
+		kfree(se401->scratch[i].data);
+		se401->scratch[i].data = NULL;
+	}
+	return -ENOMEM;
 }
 
 static int se401_stop_stream(struct usb_se401 *se401)
