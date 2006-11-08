Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754588AbWKHOej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbWKHOej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbWKHOej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:34:39 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:32517 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1754588AbWKHOej
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:34:39 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/33] usb: writing_usb_driver free urb cleanup
Date: Wed, 8 Nov 2006 15:33:38 +0100
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
Message-Id: <200611081533.41048.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Allright. As Greg KH suggested I split this big patch into smaller ones to
make the changes easier to review. Having no better idea how to split that I 
split it on a 'patch per file' basis. All those patches clean redundant 'if' before 
usb_unlink/free/kill_urb():

if (urb)
	usb_free_urb(urb); /* unlink / free / kill */

I decided not to touch bigger 'if's like 

if (urb) {
	usb_kill_urb(urb);
	usb_free_urb(urb);
	urb = NULL;
}

as that would be probably too intrusive. One of patches also fixes 
drivers/usb/misc/auerswald.c memleak I found when digging the code. All those
patches are against 2.6.19-rc4.
-- 
Regards,

	Mariusz Kozlowski

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/Documentation/DocBook/writing_usb_driver.tmpl	2006-11-06 17:06:39.000000000 +0100
+++ linux-2.6.19-rc4/Documentation/DocBook/writing_usb_driver.tmpl	2006-11-06 19:50:58.000000000 +0100
@@ -345,8 +345,7 @@ static inline void skel_delete (struct u
         usb_buffer_free (dev->udev, dev->bulk_out_size,
             dev->bulk_out_buffer,
             dev->write_urb->transfer_dma);
-    if (dev->write_urb != NULL)
-        usb_free_urb (dev->write_urb);
+    usb_free_urb (dev->write_urb);
     kfree (dev);
 }
   </programlisting>
