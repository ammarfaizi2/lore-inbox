Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUDNKvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 06:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbUDNKvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 06:51:40 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:33943 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264048AbUDNKvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 06:51:31 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 9/9] USB usbfs: drop pointless racy check
Date: Wed, 14 Apr 2004 12:51:28 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141251.28610.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The check of interface->dev.driver requires a lock to be taken
to protect against driver binding changes.  But in fact I think it
is better just to drop the test.  The result is that the caller is
required to claim an interface before changing the altsetting,
which is consistent with the other routines that operate on
interfaces.

 devio.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Wed Apr 14 12:18:37 2004
+++ b/drivers/usb/core/devio.c	Wed Apr 14 12:18:37 2004
@@ -747,10 +747,8 @@
 	if ((ret = findintfif(ps->dev, setintf.interface)) < 0)
 		return ret;
 	interface = ps->dev->actconfig->interface[ret];
-	if (interface->dev.driver) {
-		if ((ret = checkintf(ps, ret)))
-			return ret;
-	}
+	if ((ret = checkintf(ps, ret)))
+		return ret;
 	if (usb_set_interface(ps->dev, setintf.interface, setintf.altsetting))
 		return -EINVAL;
 	return 0;
