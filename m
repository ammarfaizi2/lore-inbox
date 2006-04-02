Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWDBQkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWDBQkM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWDBQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:40:00 -0400
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:55708 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932392AbWDBQj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:39:56 -0400
Message-ID: <442FFE5B.3040409@free.fr>
Date: Sun, 02 Apr 2006 18:39:55 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 4/4] UEAGLE : memory leack fix
Content-Type: multipart/mixed;
 boundary="------------040304040206020309070001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040304040206020309070001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch fix leak of memory allocated to intr if allocation of 
sc->urb_int fails.
Found by the Coverity checker.

Signed-off-by: Duncan Sands <baldrick@free.fr>
Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>



--------------040304040206020309070001
Content-Type: text/plain;
 name="ueagle4.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ueagle4.patch"

Index: ueagle-atm.c
===================================================================
--- ueagle-atm.c	(révision 266)
+++ ueagle-atm.c	(révision 267)
@@ -1376,7 +1376,7 @@
 	if (ret < 0) {
 		uea_err(INS_TO_USBDEV(sc),
 		       "urb submition failed with error %d\n", ret);
-		goto err1;
+		goto err;
 	}
 
 	sc->kthread = kthread_run(uea_kthread, sc, "ueagle-atm");
@@ -1390,10 +1390,10 @@
 
 err2:
 	usb_kill_urb(sc->urb_int);
-err1:
-	kfree(intr);
 err:
 	usb_free_urb(sc->urb_int);
+	sc->urb_int = NULL;
+	kfree(intr);
 	uea_leaves(INS_TO_USBDEV(sc));
 	return -ENOMEM;
 }

--------------040304040206020309070001--
