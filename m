Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbUBRQSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266681AbUBRQSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:18:11 -0500
Received: from linux-bt.org ([217.160.111.169]:61389 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264233AbUBRQSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:18:01 -0500
Subject: [PATCH] Fix for I4L over CAPI and CMTP
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karsten Keil <kkeil@suse.de>
Content-Type: multipart/mixed; boundary="=-FIQY/1HS3FamuIPJ41e0"
Message-Id: <1077121040.2676.28.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 17:17:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FIQY/1HS3FamuIPJ41e0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcelo,

to use ISDN over CAPI and CMTP/Bluetooth without any problems you need
this patch.

 drivers/isdn/avmb1/capidrv.c |   22 +++++++++++++++++-----
 drivers/isdn/avmb1/kcapi.c   |   31 ++++++++++++++++---------------
 2 files changed, 33 insertions(+), 20 deletions(-)

The patch is from Karsten Keil and I have included it for a long time in
my -mh patches without any problems. Please apply.

Regards

Marcel


--=-FIQY/1HS3FamuIPJ41e0
Content-Disposition: attachment; filename=patch-capidrv
Content-Type: text/x-patch; name=patch-capidrv; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -ur linux-2.4.21-116.org/drivers/isdn/avmb1/capidrv.c linux/drivers/isdn/avmb1/capidrv.c
--- linux-2.4.21-116.org/drivers/isdn/avmb1/capidrv.c	2003-10-10 12:53:20.000000000 +0200
+++ linux/drivers/isdn/avmb1/capidrv.c	2003-10-13 01:01:13.000000000 +0200
@@ -523,13 +523,25 @@
 
 static void send_message(capidrv_contr * card, _cmsg * cmsg)
 {
-	struct sk_buff *skb;
-	size_t len;
+	struct sk_buff	*skb;
+	size_t		len;
+	u16		err;
+
 	capi_cmsg2message(cmsg, cmsg->buf);
 	len = CAPIMSG_LEN(cmsg->buf);
 	skb = alloc_skb(len, GFP_ATOMIC);
+	if(!skb) {
+		printk(KERN_ERR "no skb len(%d) memory\n", len);
+		return;
+	}
 	memcpy(skb_put(skb, len), cmsg->buf, len);
-	(*capifuncs->capi_put_message) (global.appid, skb);
+	err = (*capifuncs->capi_put_message) (global.appid, skb);
+	if (err) {
+		printk(KERN_WARNING "%s: capi_put_message error: %04x\n",
+			__FUNCTION__, err);
+		kfree_skb(skb);
+		return;
+	}
 	global.nsentctlpkt++;
 }
 
@@ -2188,10 +2200,10 @@
 			free_ncci(card, card->bchans[card->nbchan-1].nccip);
 		if (card->bchans[card->nbchan-1].plcip)
 			free_plci(card, card->bchans[card->nbchan-1].plcip);
-		if (card->plci_list)
-			printk(KERN_ERR "capidrv: bug in free_plci()\n");
 		card->nbchan--;
 	}
+	if (card->plci_list)
+		printk(KERN_ERR "capidrv: bug in free_plci()\n");
 	kfree(card->bchans);
 	card->bchans = 0;
 
diff -ur linux-2.4.21-116.org/drivers/isdn/avmb1/kcapi.c linux/drivers/isdn/avmb1/kcapi.c
--- linux-2.4.21-116.org/drivers/isdn/avmb1/kcapi.c	2003-10-10 12:53:20.000000000 +0200
+++ linux/drivers/isdn/avmb1/kcapi.c	2003-10-12 21:26:33.000000000 +0200
@@ -546,7 +546,13 @@
 static void notify_up(__u32 contr)
 {
 	struct capi_interface_user *p;
+	__u16 appl;
 
+	for (appl = 1; appl <= CAPI_MAXAPPL; appl++) {
+		if (!VALID_APPLID(appl)) continue;
+		if (APPL(appl)->releasing) continue;
+		CARD(contr)->driver->register_appl(CARD(contr), appl, &APPL(appl)->rparam);
+	}
         printk(KERN_NOTICE "kcapi: notify up contr %d\n", contr);
 	spin_lock(&capi_users_lock);
 	for (p = capi_users; p; p = p->next) {
@@ -714,12 +720,16 @@
 			nextpp = &(*pp)->next;
 		}
 	}
-	APPL(appl)->releasing--;
-	if (APPL(appl)->releasing <= 0) {
-		APPL(appl)->signal = 0;
-		APPL_MARK_FREE(appl);
-		printk(KERN_INFO "kcapi: appl %d down\n", appl);
-	}
+	if (APPL(appl)->releasing) { /* only release if the application was marked for release */
+		printk(KERN_DEBUG "kcapi: appl %d releasing(%d)\n", appl, APPL(appl)->releasing);
+		APPL(appl)->releasing--;
+		if (APPL(appl)->releasing <= 0) {
+			APPL(appl)->signal = 0;
+			APPL_MARK_FREE(appl);
+			printk(KERN_INFO "kcapi: appl %d down\n", appl);
+		}
+	} else
+		printk(KERN_WARNING "kcapi: appl %d card%d released without request\n", appl, card->cnr);
 }
 /*
  * ncci management
@@ -872,16 +882,7 @@
 
 static void controllercb_ready(struct capi_ctr * card)
 {
-	__u16 appl;
-
 	card->cardstate = CARD_RUNNING;
-
-	for (appl = 1; appl <= CAPI_MAXAPPL; appl++) {
-		if (!VALID_APPLID(appl)) continue;
-		if (APPL(appl)->releasing) continue;
-		card->driver->register_appl(card, appl, &APPL(appl)->rparam);
-	}
-
         printk(KERN_NOTICE "kcapi: card %d \"%s\" ready.\n",
 		CARDNR(card), card->name);
 

--=-FIQY/1HS3FamuIPJ41e0--

