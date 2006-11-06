Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753700AbWKFSEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbWKFSEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753745AbWKFSEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:04:21 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:63236 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753700AbWKFSEV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:04:21 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Wolfgang =?iso-8859-2?q?M=FCes?= <wolfgang@iksw-muees.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc4] usb auerswald possible memleak fix
Date: Mon, 6 Nov 2006 19:03:09 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061903.09320.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	There is possible memleak in auerbuf_setup(). Fix is to replace kfree() with auerbuf_free().
An argument to usb_free_urb() does not need a check as usb_free_urb() already does that. Not sure if I should
send this in two separate patches. The patch is against 2.6.19-rc4 (not -mm).

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

diff -up linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c linux-2.6.19-rc4/drivers/usb/misc/auerswald.c
--- linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c  2006-11-06 17:08:20.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/auerswald.c       2006-11-06 18:25:32.000000000 +0100
@@ -704,9 +704,7 @@ static void auerbuf_free (pauerbuf_t bp)
 {
        kfree(bp->bufp);
        kfree(bp->dr);
-       if (bp->urbp) {
-               usb_free_urb(bp->urbp);
-       }
+       usb_free_urb(bp->urbp);
        kfree(bp);
 }
 
@@ -780,7 +778,7 @@ static int auerbuf_setup (pauerbufctl_t 
 
 bl_fail:/* not enough memory. Free allocated elements */
         dbg ("auerbuf_setup: no more memory");
-       kfree(bep);
+        auerbuf_free(bep);
         auerbuf_free_buffers (bcp);
         return -ENOMEM;
 }
@@ -1085,10 +1083,8 @@ exit:
 */
 static void auerswald_int_free (pauerswald_t cp)
 {
-       if (cp->inturbp) {
-               usb_free_urb(cp->inturbp);
-               cp->inturbp = NULL;
-       }
+       usb_free_urb(cp->inturbp);
+       cp->inturbp = NULL;
        kfree(cp->intbufp);
        cp->intbufp = NULL;
 }
