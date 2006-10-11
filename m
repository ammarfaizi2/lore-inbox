Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWJKHBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWJKHBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 03:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWJKHBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 03:01:52 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:24846 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932447AbWJKHBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 03:01:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XBijFiG7tq1pi9H4o0IeZOrDXvF9bkxd1F9+OjDlOUZ3y9Xr1Xg4++rgyoniDDSh1W5PQiWnxBEBL26SlAGwRXc2ucuoQTOHL89w0aWugk4OcRPyDYaNZ564akLMT22Tve+nm6AeS2iulLzqbKCAf1RmuQUcE5g87JgCq47Ae8w=
Date: Wed, 11 Oct 2006 00:01:47 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1] drivers/media/video/se401.c: fix memory leak.
Message-Id: <20061011000147.61081f5d.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: In function usb_se401_remove_disconnected() [drivers/media/video/se401.c], se401->sbuf[i].data was freed only when se401->urb[i] existed. This could result in a memory leak because sbuf[i].data is allocated before urb[i]. Let's assume that the memory gets exhausted while allocating for urb[i] Now, some event results in calling of usb_se401_remove_disconnected(). This will free sbuf[i].data only for those 'i' for which an urb exists. Since, we could not allocate all urb[i] as memory got exhausted, some of sbuf[i].data would never be freed at all.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/media/video/se401.c b/drivers/media/video/se401.c
index d411a27..7d598e0 100644
--- a/drivers/media/video/se401.c
+++ b/drivers/media/video/se401.c
@@ -881,15 +881,18 @@ static void usb_se401_remove_disconnecte
 
 	se401->dev = NULL;
 
-	for (i=0; i<SE401_NUMSBUF; i++)
+	for (i=0; i<SE401_NUMSBUF; i++) {
 		if (se401->urb[i]) {
 			usb_kill_urb(se401->urb[i]);
 			usb_free_urb(se401->urb[i]);
 			se401->urb[i] = NULL;
-			kfree(se401->sbuf[i].data);
 		}
+		kfree(se401->sbuf[i].data);
+		se401->sbuf[i].data=NULL;
+	}
 	for (i=0; i<SE401_NUMSCRATCH; i++) {
 		kfree(se401->scratch[i].data);
+		se401->scratch[i].data=NULL;
 	}
 	if (se401->inturb) {
 		usb_kill_urb(se401->inturb);
