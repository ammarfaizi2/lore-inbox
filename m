Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424171AbWKPPuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424171AbWKPPuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424206AbWKPPuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:50:20 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:37647 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1424171AbWKPPuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:50:19 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Torrey Hoffman <thoffman@arnor.net>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ati remote memleak fix
Date: Thu, 16 Nov 2006 16:50:25 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161650.26989.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This is a bug. When checking for ati_remote->outbuf we free
freeing ati_remote->inbuf so we end up freeing ati_remote->inbuf twice.
Also the checks for 'ati_remote->inbuf != NULL' and
'ati_remote->outbuf != NULL' are redundant as usb_buffer_free() does
this.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/usb/input/ati_remote.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff -up linux-2.6.19-rc5-mm2-a/drivers/usb/input/ati_remote.c linux-2.6.19-rc5-mm2-b/drivers/usb/input/ati_remote.c
--- linux-2.6.19-rc5-mm2-a/drivers/usb/input/ati_remote.c	2006-11-15 11:24:24.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/usb/input/ati_remote.c	2006-11-15 16:33:02.000000000 +0100
@@ -633,13 +633,11 @@ static void ati_remote_free_buffers(stru
 	usb_free_urb(ati_remote->irq_urb);
 	usb_free_urb(ati_remote->out_urb);

-	if (ati_remote->inbuf)
-		usb_buffer_free(ati_remote->udev, DATA_BUFSIZE,
-				ati_remote->inbuf, ati_remote->inbuf_dma);
-
-	if (ati_remote->outbuf)
-		usb_buffer_free(ati_remote->udev, DATA_BUFSIZE,
-				ati_remote->inbuf, ati_remote->outbuf_dma);
+	usb_buffer_free(ati_remote->udev, DATA_BUFSIZE,
+		ati_remote->inbuf, ati_remote->inbuf_dma);
+
+	usb_buffer_free(ati_remote->udev, DATA_BUFSIZE,
+		ati_remote->outbuf, ati_remote->outbuf_dma);
 }



-- 
Regards,

	Mariusz Kozlowski
