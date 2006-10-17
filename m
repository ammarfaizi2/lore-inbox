Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWJQHLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWJQHLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 03:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWJQHLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 03:11:12 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:23074 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932175AbWJQHLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 03:11:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Y1IwjIGiipkWjBjQ4/8WyZubsNTVU/6y6hIvuZVVQrnrNR3RdT6wQyEW5a3Sc55BlvdQ8I8LRbU4LBjvmd/WfSqOYucIqgEurMjBAf7LPx76ZozdM+PFVNJgQpeKhsZ8veluKJi6Nb/kKzinZBKyeGhWwjTMEBDtj3NHFcToshY=
Date: Tue, 17 Oct 2006 00:11:03 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc2] drivers/media/video/stv680.c: check kmalloc()
 return value.
Message-Id: <20061017001103.e29905ab.amit2030@gmail.com>
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
index 6d1ef1e..a1ec3ac 100644
--- a/drivers/media/video/stv680.c
+++ b/drivers/media/video/stv680.c
@@ -687,7 +687,7 @@ static int stv680_start_stream (struct u
 		stv680->sbuf[i].data = kmalloc (stv680->rawbufsize, GFP_KERNEL);
 		if (stv680->sbuf[i].data == NULL) {
 			PDEBUG (0, "STV(e): Could not kmalloc raw data buffer %i", i);
-			return -1;
+			goto nomem_err;
 		}
 	}
 
@@ -698,7 +698,7 @@ static int stv680_start_stream (struct u
 		stv680->scratch[i].data = kmalloc (stv680->rawbufsize, GFP_KERNEL);
 		if (stv680->scratch[i].data == NULL) {
 			PDEBUG (0, "STV(e): Could not kmalloc raw scratch buffer %i", i);
-			return -1;
+			goto nomem_err;
 		}
 		stv680->scratch[i].state = BUFFER_UNUSED;
 	}
@@ -706,7 +706,7 @@ static int stv680_start_stream (struct u
 	for (i = 0; i < STV680_NUMSBUF; i++) {
 		urb = usb_alloc_urb (0, GFP_KERNEL);
 		if (!urb)
-			return -ENOMEM;
+			goto nomem_err;
 
 		/* sbuf is urb->transfer_buffer, later gets memcpyed to scratch */
 		usb_fill_bulk_urb (urb, stv680->udev,
@@ -721,6 +721,21 @@ static int stv680_start_stream (struct u
 
 	stv680->framecount = 0;
 	return 0;
+
+ nomem_err:
+	for (i = 0; i < STV680_NUMSCRATCH; i++) {
+		kfree(stv680->scratch[i].data);
+		stv680->scratch[i].data = NULL;
+	}
+	for (i = 0; i < STV680_NUMSBUF; i++) {
+		usb_kill_urb(stv680->urb[i]);
+		usb_free_urb(stv680->urb[i]);
+		stv680->urb[i] = NULL;
+		kfree(stv680->sbuf[i].data);
+		stv680->sbuf[i].data = NULL;
+	}
+	return -ENOMEM;
+
 }
 
 static int stv680_stop_stream (struct usb_stv *stv680)
