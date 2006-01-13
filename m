Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWAMJNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWAMJNT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161503AbWAMJNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:13:19 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:8908 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161167AbWAMJNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:13:18 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 08/13] USBATM: use dev_kfree_skb_any rather than dev_kfree_skb
Date: Fri, 13 Jan 2006 10:13:19 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_v82xDCAEZ1tghV6"
Message-Id: <200601131013.19986.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_v82xDCAEZ1tghV6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In one spot (usbatm_cancel_send) we were calling dev_kfree_skb with irqs
disabled.  This mistake is just too easy to make, so systematically use
dev_kfree_skb_any rather than dev_kfree_skb.

Signed-off-by:	Duncan Sands <baldrick@free.fr>

--Boundary-00=_v82xDCAEZ1tghV6
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="08-dev_kfree_skb_any"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="08-dev_kfree_skb_any"

Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 08:59:16.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 09:00:06.000000000 +0100
@@ -72,6 +72,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/netdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/sched.h>
 #include <linux/signal.h>
@@ -199,7 +200,7 @@
 	if (vcc->pop)
 		vcc->pop(vcc, skb);
 	else
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 }
 
 
@@ -397,7 +398,7 @@
 			if (!atm_charge(vcc, skb->truesize)) {
 				atm_rldbg(instance, "%s: failed atm_charge (skb->truesize: %u)!\n",
 						__func__, skb->truesize);
-				dev_kfree_skb(skb);
+				dev_kfree_skb_any(skb);
 				goto out;	/* atm_charge increments rx_drop */
 			}
 

--Boundary-00=_v82xDCAEZ1tghV6--
