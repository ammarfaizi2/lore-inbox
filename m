Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbTDLLiF (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 07:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTDLLiF (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 07:38:05 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.26]:18135 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263169AbTDLLiC (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 07:38:02 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: discard packets for non-existant vcc's
Date: Sat, 12 Apr 2003 13:49:39 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T1/l+xAr3Y6mb/i"
Message-Id: <200304121349.39418.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_T1/l+xAr3Y6mb/i
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I broke part of the udsl_decode_rawcell logic in a previous patch, leading to
possible hangs on startup/shutdown.  I've attached the 2.4 and 2.5 versions.
Thanks to Subodh Srivastava and Ted Phelps for their bug reports.  Here is the
2.5 patch included inline for reference:

--- redux-2.5/drivers/usb/misc/speedtch.c	2003-04-12 11:29:03.000000000 +0200
+++ bollux-2.5/drivers/usb/misc/speedtch.c	2003-04-12 13:35:57.000000000 +0200
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


--Boundary-00=_T1/l+xAr3Y6mb/i
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.4.diff"

--- redux-2.4/drivers/usb/speedtouch.c	2003-04-12 11:23:46.000000000 +0200
+++ bollux-2.4/drivers/usb/speedtouch.c	2003-04-12 11:19:25.000000000 +0200
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

--Boundary-00=_T1/l+xAr3Y6mb/i
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.5.diff"

--- redux-2.5/drivers/usb/misc/speedtch.c	2003-04-12 11:29:03.000000000 +0200
+++ bollux-2.5/drivers/usb/misc/speedtch.c	2003-04-12 13:35:57.000000000 +0200
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

--Boundary-00=_T1/l+xAr3Y6mb/i--
