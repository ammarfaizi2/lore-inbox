Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUDMJPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUDMJPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:15:40 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:6318 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S263171AbUDMJPa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:15:30 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2/3] USB speedtouch: fix memory leak in error path
Date: Tue, 13 Apr 2004 11:15:25 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131115.25784.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, this patch fixes a memory leak in the speedtouch driver.
The leak occurs when the ATM layer submits a skbuff for transmission,
but the driver rejects it (because the device has been unplugged for
example).  The ATM layer requires the driver to free the skbuff in this
case.  The patch is against your 2.6 kernel tree.

 speedtch.c |   42 +++++++++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 15 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Apr 13 10:57:43 2004
+++ b/drivers/usb/misc/speedtch.c	Tue Apr 13 10:57:43 2004
@@ -299,6 +299,19 @@
 };
 
 
+/***********
+**  misc  **
+***********/
+
+static inline void udsl_pop (struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	if (vcc->pop)
+		vcc->pop (vcc, skb);
+	else
+		dev_kfree_skb (skb);
+}
+
+
 /*************
 **  decode  **
 *************/
@@ -720,10 +733,7 @@
 	if (!UDSL_SKB (skb)->num_cells) {
 		struct atm_vcc *vcc = UDSL_SKB (skb)->atm_data.vcc;
 
-		if (vcc->pop)
-			vcc->pop (vcc, skb);
-		else
-			dev_kfree_skb (skb);
+		udsl_pop (vcc, skb);
 		instance->current_skb = NULL;
 
 		atomic_inc (&vcc->stats->tx);
@@ -742,10 +752,7 @@
 		if (UDSL_SKB (skb)->atm_data.vcc == vcc) {
 			dbg ("udsl_cancel_send: popping skb 0x%p", skb);
 			__skb_unlink (skb, &instance->sndqueue);
-			if (vcc->pop)
-				vcc->pop (vcc, skb);
-			else
-				dev_kfree_skb (skb);
+			udsl_pop (vcc, skb);
 		}
 	spin_unlock_irq (&instance->sndqueue.lock);
 
@@ -753,10 +760,7 @@
 	if ((skb = instance->current_skb) && (UDSL_SKB (skb)->atm_data.vcc == vcc)) {
 		dbg ("udsl_cancel_send: popping current skb (0x%p)", skb);
 		instance->current_skb = NULL;
-		if (vcc->pop)
-			vcc->pop (vcc, skb);
-		else
-			dev_kfree_skb (skb);
+		udsl_pop (vcc, skb);
 	}
 	tasklet_enable (&instance->send_tasklet);
 	dbg ("udsl_cancel_send done");
@@ -765,22 +769,26 @@
 static int udsl_atm_send (struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
+	int err;
 
 	vdbg ("udsl_atm_send called (skb 0x%p, len %u)", skb, skb->len);
 
 	if (!instance || !instance->usb_dev) {
 		dbg ("udsl_atm_send: NULL data!");
-		return -ENODEV;
+		err = -ENODEV;
+		goto fail;
 	}
 
 	if (vcc->qos.aal != ATM_AAL5) {
 		dbg ("udsl_atm_send: unsupported ATM type %d!", vcc->qos.aal);
-		return -EINVAL;
+		err = -EINVAL;
+		goto fail;
 	}
 
 	if (skb->len > ATM_MAX_AAL5_PDU) {
 		dbg ("udsl_atm_send: packet too long (%d vs %d)!", skb->len, ATM_MAX_AAL5_PDU);
-		return -EINVAL;
+		err = -EINVAL;
+		goto fail;
 	}
 
 	PACKETDEBUG (skb->data, skb->len);
@@ -790,6 +798,10 @@
 	tasklet_schedule (&instance->send_tasklet);
 
 	return 0;
+
+fail:
+	udsl_pop (vcc, skb);
+	return err;
 }
 
 
