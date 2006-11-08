Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965819AbWKHOi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965819AbWKHOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965882AbWKHOhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:37:53 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:519 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965804AbWKHOhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:09 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 20/33] usb: legousbtower free kill urb cleanup
Date: Wed, 8 Nov 2006 15:36:14 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <200611071030.57152.m.kozlowski@tuxland.pl> <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <20061107013702.46b5710f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611081536.15954.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup
- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/misc/legousbtower.c	2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/legousbtower.c	2006-11-07 17:01:19.000000000 +0100
@@ -317,12 +317,8 @@ static inline void tower_delete (struct 
 	tower_abort_transfers (dev);
 
 	/* free data structures */
-	if (dev->interrupt_in_urb != NULL) {
-		usb_free_urb (dev->interrupt_in_urb);
-	}
-	if (dev->interrupt_out_urb != NULL) {
-		usb_free_urb (dev->interrupt_out_urb);
-	}
+	usb_free_urb (dev->interrupt_in_urb);
+	usb_free_urb (dev->interrupt_out_urb);
 	kfree (dev->read_buffer);
 	kfree (dev->interrupt_in_buffer);
 	kfree (dev->interrupt_out_buffer);
@@ -502,15 +498,11 @@ static void tower_abort_transfers (struc
 	if (dev->interrupt_in_running) {
 		dev->interrupt_in_running = 0;
 		mb();
-		if (dev->interrupt_in_urb != NULL && dev->udev) {
+		if (dev->udev)
 			usb_kill_urb (dev->interrupt_in_urb);
-		}
-	}
-	if (dev->interrupt_out_busy) {
-		if (dev->interrupt_out_urb != NULL && dev->udev) {
-			usb_kill_urb (dev->interrupt_out_urb);
-		}
 	}
+	if (dev->interrupt_out_busy && dev->udev)
+		usb_kill_urb (dev->interrupt_out_urb);
 
 exit:
 	dbg(2, "%s: leave", __FUNCTION__);
