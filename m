Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965832AbWKHOnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965832AbWKHOnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965888AbWKHOm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:42:59 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:64262 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965857AbWKHOg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:36:57 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 19/33] usb: auerswald free kill urb cleanup and memleak fix
Date: Wed, 8 Nov 2006 15:36:03 +0100
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
Message-Id: <200611081536.04290.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup
- auerbuf_setup() memleak fix
- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c	2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/auerswald.c	2006-11-07 18:25:16.000000000 +0100
@@ -704,9 +704,7 @@ static void auerbuf_free (pauerbuf_t bp)
 {
 	kfree(bp->bufp);
 	kfree(bp->dr);
-	if (bp->urbp) {
-		usb_free_urb(bp->urbp);
-	}
+	usb_free_urb(bp->urbp);
 	kfree(bp);
 }
 
@@ -780,7 +778,7 @@ static int auerbuf_setup (pauerbufctl_t 
 
 bl_fail:/* not enough memory. Free allocated elements */
         dbg ("auerbuf_setup: no more memory");
-	kfree(bep);
+	auerbuf_free(bep);
         auerbuf_free_buffers (bcp);
         return -ENOMEM;
 }
@@ -1155,8 +1153,7 @@ static void auerswald_int_release (pauer
         dbg ("auerswald_int_release");
 
         /* stop the int endpoint */
-        if (cp->inturbp)
-                usb_kill_urb (cp->inturbp);
+	usb_kill_urb (cp->inturbp);
 
         /* deallocate memory */
         auerswald_int_free (cp);
