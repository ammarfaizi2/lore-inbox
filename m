Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWHGWz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWHGWz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWHGWz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:55:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14502 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750809AbWHGWz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:55:58 -0400
Date: Mon, 7 Aug 2006 17:55:55 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rubini@vision.unipv.it,
       device@lanana.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Chardev checking of overlapping ranges is incorrect.
Message-ID: <20060807225555.GQ10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The current code in register_chrdev_region() attempts to check 
for overlapping regions of minor device numbers, but performs 
that check incorrectly. For example, if a device with minor 
numbers 128, 129, 130 is registered first, and a device with 
minor number 3,4,5 is registered later, then the later range
is incorrectly identified as "overlapping" (since 130>3), 
when clearly this is the wrong conclusion.

This patch fixes the overlap check to work correctly.

Signed-off-by: Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 fs/char_dev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc3-mm2/fs/char_dev.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/fs/char_dev.c	2006-08-07 17:16:53.000000000 -0500
+++ linux-2.6.18-rc3-mm2/fs/char_dev.c	2006-08-07 17:18:59.000000000 -0500
@@ -93,6 +93,7 @@ __register_chrdev_region(unsigned int ma
 		}
 
 		if (i == 0) {
+printk ("duude egister_chrdev_regio no major !!\n");
 			ret = -EBUSY;
 			goto out;
 		}
@@ -113,9 +114,13 @@ __register_chrdev_region(unsigned int ma
 		     (((*cp)->baseminor >= baseminor) ||
 		      ((*cp)->baseminor + (*cp)->minorct > baseminor))))
 			break;
+
+	/* Check for overlap of minor ranges */
 	if (*cp && (*cp)->major == major &&
-	    (((*cp)->baseminor < baseminor + minorct) ||
-	     ((*cp)->baseminor + (*cp)->minorct > baseminor))) {
+	    ((((*cp)->baseminor <= baseminor) &&
+		   ((*cp)->baseminor + (*cp)->minorct >= baseminor)) ||
+	     (((*cp)->baseminor >= baseminor) &&
+	      ((*cp)->baseminor <= baseminor+minorct)))) {
 		ret = -EBUSY;
 		goto out;
 	}
