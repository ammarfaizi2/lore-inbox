Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUEIMIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUEIMIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUEIMIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 08:08:21 -0400
Received: from linuxhacker.ru ([217.76.32.60]:29146 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264278AbUEIMIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 08:08:18 -0400
Date: Sun, 9 May 2004 15:08:34 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: [2.4] [PATCH] Fix possible memleaks in VIA IrDA driver
Message-ID: <20040509120834.GA13899@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Patch below fixes some possible memleaks in VIA IrDA driver, also
   checks for skb->data being non-NULL are dropped since alloc_skb
   cannot return such skbs as far as I can see.

Bye,

    Oleg
===== drivers/net/irda/via-ircc.c 1.3 vs edited =====
--- 1.3/drivers/net/irda/via-ircc.c	Fri Jan 30 21:14:14 2004
+++ edited/drivers/net/irda/via-ircc.c	Sun May  9 15:01:34 2004
@@ -1142,13 +1142,16 @@
 		st_fifo->head++;
 		st_fifo->len--;
 
-		skb = dev_alloc_skb(len + 1 - 4);
 		/*
-		 * if frame size,data ptr,or skb ptr are wrong ,the get next
+		 * if frame size or data ptr are wrong ,then get next
 		 * entry.
 		 */
-		if ((skb == NULL) || (skb->data == NULL)
-		    || (self->rx_buff.data == NULL) || (len < 6)) {
+		if ((self->rx_buff.data == NULL) || (len < 6)) {
+			self->stats.rx_dropped++;
+			return TRUE;
+		}
+		skb = dev_alloc_skb(len + 1 - 4);
+		if (!skb) {
 			self->stats.rx_dropped++;
 			return TRUE;
 		}
@@ -1194,8 +1197,12 @@
 #ifdef	DBGMSG
 	DBG(printk(KERN_INFO "upload_rxdata: len=%x\n", len));
 #endif
+	if ((len - 4) < 2) {
+		self->stats.rx_dropped++;
+		return FALSE;
+	}
 	skb = dev_alloc_skb(len + 1);
-	if ((skb == NULL) || ((len - 4) < 2)) {
+	if (!skb) {
 		self->stats.rx_dropped++;
 		return FALSE;
 	}
@@ -1258,13 +1265,17 @@
 			st_fifo->head++;
 			st_fifo->len--;
 
-			skb = dev_alloc_skb(len + 1 - 4);
 			/*
-			 * if frame size, data ptr, or skb ptr are wrong,
+			 * if frame size or data ptr are wrong,
 			 * then get next entry.
 			 */
-			if ((skb == NULL) || (skb->data == NULL)
-			    || (self->rx_buff.data == NULL) || (len < 6)) {
+			if ((self->rx_buff.data == NULL) || (len < 6)) {
+				self->stats.rx_dropped++;
+				continue;
+			}
+
+			skb = dev_alloc_skb(len + 1 - 4);
+			if (!skb) {
 				self->stats.rx_dropped++;
 				continue;
 			}
