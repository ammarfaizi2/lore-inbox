Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbTDQFyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTDQFxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:53:05 -0400
Received: from granite.he.net ([216.218.226.66]:55312 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263085AbTDQFvB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:51:01 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1050559505328@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595052196@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:05 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1065, 2003/04/14 10:31:35-07:00, baldrick@wanadoo.fr

[PATCH] USB speedtouch: discard packets for non-existant vcc's

I broke part of the udsl_decode_rawcell logic in a previous patch, leading to
possible hangs on startup/shutdown.  I've attached the 2.4 and 2.5 versions.
Thanks to Subodh Srivastava and Ted Phelps for their bug reports.  Here is the
2.5 patch included inline for reference:


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 16 10:48:36 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 16 10:48:36 2003
@@ -278,9 +278,10 @@
 
 		/* here should the header CRC check be... */
 
-		if (!(vcc = udsl_find_vcc (instance, vpi, vci)))
+		if (!(vcc = udsl_find_vcc (instance, vpi, vci))) {
 			dbg ("udsl_decode_rawcell: no vcc found for packet on vpi %d, vci %d", vpi, vci);
-		else {
+			__skb_pull (skb, min (skb->len, (unsigned) 53));
+		} else {
 			dbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc, vpi, vci);
 
 			if (skb->len >= 53) {
@@ -323,8 +324,8 @@
 				skb_pull (skb, 53);
 			} else {
 				/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
-				if (skb_pull (skb, 53) == NULL)
-					return NULL;
+				__skb_pull (skb, skb->len);
+				return NULL;
 			}
 		}
 	}

