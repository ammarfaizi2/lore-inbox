Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319567AbSH3OMK>; Fri, 30 Aug 2002 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319572AbSH3OMK>; Fri, 30 Aug 2002 10:12:10 -0400
Received: from da.ru ([195.161.113.6]:46092 "EHLO inc.ru")
	by vger.kernel.org with ESMTP id <S319567AbSH3OMA>;
	Fri, 30 Aug 2002 10:12:00 -0400
From: <pavel@parabel.inc.ru>
Subject: Re: [GENERIC HDLC LAYER] Messages of a hdlc device
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro Web Mailer v.3.5.6
Date: Fri, 30 Aug 2002 18:19:14 +0400
Message-ID: <web-1637547@inc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm using the generic hdlc layer with PPP protocol
against a Lucent MAX6000. 
> Everything works OK but there a kernel message bothering
me:
> 	protocol 0008 is buggy, dev hdlc0
> 
> I get this message nearly once per minute.
> 
> Do anyone know what is this message about ?

I've seen that problem since 2.2.x kernels.
I think there is an error while building cisco/ppp
keepalive packet (hdlc.c & syncppp.c).
Lines skb->nh.raw = skb->data;
will solve it.
Following patch is for 2.2.x kernel.
If you want to patch 2.4.x, simply add
skb->nh.raw = skb->data;
at cisco_keepalive_send (hdlc.c)
at sppp_cisco_send (syncppp.c)
and at sppp_cp_send (syncppp.c)

Here is a patch(for hdlc.c & syncppp.c from 2.2.x):
==========================
diff -urN kernel-source-2.2.17.orig/drivers/net/hdlc.c
kernel-source-2.2.17.hdlc_patch/drivers/net/hdlc.c
--- kernel-source-2.2.17.orig/drivers/net/hdlc.c	Sat Jun 24
15:25:37 2000
+++ kernel-source-2.2.17.hdlc_patch/drivers/net/hdlc.c	Fri
Mar 22 19:51:41 2002
@@ -19,6 +19,13 @@
  *
  * Use sethdlc utility to set line parameters, protocol
and PVCs
  */
+ /*
+   Patched by Pavel Selivanov. 08 Aug. 2001
+   If we are using dev_queue_xmit, and we have a
listeners,
+   we should set skb->nh.raw. If no, we'll get a lot of
warnings in 
+   /var/log/debug
+   Look at core/net/dev.c dev_queue_xmit_nit  
+*/
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -99,6 +106,7 @@
 	skb_put(skb, sizeof(cisco_packet));
 	skb->priority=TC_PRIO_CONTROL;
 	skb->dev = hdlc_to_dev(hdlc);
+	skb->nh.raw = skb->data;
 	
 	dev_queue_xmit(skb);
 }
@@ -369,7 +377,8 @@
 	skb_put(skb, i);
 	skb->priority=TC_PRIO_CONTROL;
 	skb->dev = hdlc_to_dev(hdlc);
-
+	skb->nh.raw = skb->data;
+	
 	dev_queue_xmit(skb);
 }
 
@@ -805,6 +814,7 @@
 {
 	pvc_device *pvc=dev_to_pvc(dev);
 
+	skb->nh.raw = skb->data;
 	if (pvc->state & PVC_STATE_ACTIVE) {
 		skb->dev = hdlc_to_dev(pvc->master);
 		pvc->stats.tx_bytes+=skb->len;
diff -urN kernel-source-2.2.17.orig/drivers/net/syncppp.c
kernel-source-2.2.17.hdlc_patch/drivers/net/syncppp.c
--- kernel-source-2.2.17.orig/drivers/net/syncppp.c	Thu Jun
 8 04:26:43 2000
+++
kernel-source-2.2.17.hdlc_patch/drivers/net/syncppp.c	Fri
Mar 22 19:51:41 2002
@@ -16,7 +16,14 @@
  *
  *	Port for Linux-2.1 by Jan "Yenya" Kasprzak
<kas@fi.muni.cz>
  */
-
+ /*
+  Patched by Pavel Selivanov. 08 Aug. 2001
+  If we are using dev_queue_xmit, and we have a listeners,
+  we should set skb->nh.raw. If no, we'll get a lot of
warnings in
+  /var/log/debug
+  Look at core/net/dev.c dev_queue_xmit_nit
+*/
+				
 /*
  * Synchronous PPP/Cisco link level subroutines.
  * Keepalive protocol implemented in both Cisco and PPP
modes.
@@ -779,6 +786,8 @@
 	/* Control is high priority so it doesnt get queued
behind data */
 	skb->priority=TC_PRIO_CONTROL;
 	skb->dev = dev;
+	skb->nh.raw = skb->data;
+	
 	dev_queue_xmit(skb);
 }
 
@@ -821,6 +830,8 @@
 	sp->obytes += skb->len;
 	skb->priority=TC_PRIO_CONTROL;
 	skb->dev = dev;
+	skb->nh.raw = skb->data;
+	
 	dev_queue_xmit(skb);
 }
======================

Regards
Pavel
mail: pavel[AT]parabel.inc.ru
