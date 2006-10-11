Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWJKGpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWJKGpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWJKGpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:45:44 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:17925 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161152AbWJKGpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:45:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=bqemuxtC8TnO+1PlnDOLe7NJmWJyXwNQecmbl0RloIL7kx90a72oTSL0sIWTiNv9vbjLegi4r8Uur6OWqU48yIo4zob2AIri93d4KZa5H2z5ZV9ScF31gsrUobjAHIoF5OXlgCaOd7TLijwO+jGVD5e5JZs0nNIovvkTWDzUgKU=
Date: Tue, 10 Oct 2006 23:45:38 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1 2/2] drivers/media/video/se401.c: check kmalloc()
 return value.
Message-Id: <20061010234538.1ec737e1.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: In function se401_stop_stream() [drivers/media/video/se401.c], se401->sbuf[i].data was freed only when se401->urb[i] existed. This could result in a memory leak because sbuf[i].data is allocated before urb[i]. Hence, if the memory gets exhausted while allocating for sbuf[i], the urb[i] would still be NULL, and this would result in sbuf[i] not getting freed when se401_stop_stream() is called.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/se401.c b/drivers/media/video/se401.c
index 20b91db..d411a27 100644
--- a/drivers/media/video/se401.c
+++ b/drivers/media/video/se401.c
@@ -509,11 +509,14 @@ static int se401_stop_stream(struct usb_
 	se401_sndctrl(1, se401, SE401_REQ_LED_CONTROL, 0, NULL, 0);
 	se401_sndctrl(1, se401, SE401_REQ_CAMERA_POWER, 0, NULL, 0);
 
-	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
-		usb_kill_urb(se401->urb[i]);
-		usb_free_urb(se401->urb[i]);
-		se401->urb[i]=NULL;
+	for (i=0; i<SE401_NUMSBUF; i++) {
+		if (se401->urb[i]) {
+			usb_kill_urb(se401->urb[i]);
+			usb_free_urb(se401->urb[i]);
+			se401->urb[i]=NULL;
+		}
 		kfree(se401->sbuf[i].data);
+		se401->sbuf[i].data=NULL;
 	}
 	for (i=0; i<SE401_NUMSCRATCH; i++) {
 		kfree(se401->scratch[i].data);
