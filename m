Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTI2VgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTI2VgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:36:04 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:30404 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262965AbTI2Vfv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:35:51 -0400
From: Duncan Sands <baldrick@free.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 2.5] USB speedtouch: reduce memory usage
Date: Mon, 29 Sep 2003 23:37:08 +0200
User-Agent: KMail/1.5.1
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309292337.08915.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, incoming packets are reassembled in a sk_buff which is then
sent to the upper layers.  The sk_buff needs to be big enough to hold the
worst case packet since the size cannot be known in advance.  This would
not be so bad if the ATM layer paid attention to the mtu (usually 1500 bytes),
but for some reason it blithely ignores it and typically passes 9188 bytes
as the maximum size.  This means that at best 5/6 of the space in every
sk_buff is wasted.  So instead let's just allocate an assembly buffer (sarb)
which gets reused for every packet, and copy each assembled packet into
a minimally sized sk_buff before sending.
 

 speedtch.c |  106 +++++++++++++++++++++++++++++++------------------------------
 1 files changed, 55 insertions(+), 51 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Sep 30 00:11:15 2003
+++ b/drivers/usb/misc/speedtch.c	Tue Sep 30 00:11:15 2003
@@ -189,8 +189,7 @@
 	struct atm_vcc *vcc;
 
 	/* raw cell reassembly */
-	struct sk_buff *skb;
-	unsigned int max_pdu;
+	struct sk_buff *sarb;
 };
 
 /* send */
@@ -314,12 +313,10 @@
 {
 	struct udsl_vcc_data *cached_vcc = NULL;
 	struct atm_vcc *vcc;
-	struct sk_buff *skb;
+	struct sk_buff *sarb;
 	struct udsl_vcc_data *vcc_data;
 	int cached_vci = 0;
 	unsigned int i;
-	unsigned int length;
-	unsigned int pdu_length;
 	int pti;
 	int vci;
 	short cached_vpi = 0;
@@ -344,74 +341,73 @@
 		}
 
 		vcc = vcc_data->vcc;
+		sarb = vcc_data->sarb;
 
-		if (!vcc_data->skb && !(vcc_data->skb = dev_alloc_skb (vcc_data->max_pdu))) {
-			dbg ("udsl_extract_cells: no memory for skb (vcc: 0x%p)!", vcc);
-			if (pti)
-				atomic_inc (&vcc->stats->rx_err);
-			continue;
-		}
-
-		skb = vcc_data->skb;
-
-		if (skb->len + ATM_CELL_PAYLOAD > vcc_data->max_pdu) {
-			dbg ("udsl_extract_cells: buffer overrun (max_pdu: %u, skb->len %u, vcc: 0x%p)", vcc_data->max_pdu, skb->len, vcc);
+		if (sarb->tail + ATM_CELL_PAYLOAD > sarb->end) {
+			dbg ("udsl_extract_cells: buffer overrun (sarb->len %u, vcc: 0x%p)!", sarb->len, vcc);
 			/* discard cells already received */
-			skb_trim (skb, 0);
-			DEBUG_ON (vcc_data->max_pdu < ATM_CELL_PAYLOAD);
+			skb_trim (sarb, 0);
 		}
 
-		memcpy (skb->tail, source + ATM_CELL_HEADER, ATM_CELL_PAYLOAD);
-		__skb_put (skb, ATM_CELL_PAYLOAD);
+		memcpy (sarb->tail, source + ATM_CELL_HEADER, ATM_CELL_PAYLOAD);
+		__skb_put (sarb, ATM_CELL_PAYLOAD);
 
 		if (pti) {
+			struct sk_buff *skb;
+			unsigned int length;
+			unsigned int pdu_length;
+
 			length = (source [ATM_CELL_SIZE - 6] << 8) + source [ATM_CELL_SIZE - 5];
 
 			/* guard against overflow */
 			if (length > ATM_MAX_AAL5_PDU) {
-				dbg ("udsl_extract_cells: bogus length %u (vcc: 0x%p)", length, vcc);
-				goto drop;
+				dbg ("udsl_extract_cells: bogus length %u (vcc: 0x%p)!", length, vcc);
+				atomic_inc (&vcc->stats->rx_err);
+				goto out;
 			}
 
 			pdu_length = UDSL_NUM_CELLS (length) * ATM_CELL_PAYLOAD;
 
-			if (skb->len < pdu_length) {
-				dbg ("udsl_extract_cells: bogus pdu_length %u (skb->len: %u, vcc: 0x%p)", pdu_length, skb->len, vcc);
-				goto drop;
+			if (sarb->len < pdu_length) {
+				dbg ("udsl_extract_cells: bogus pdu_length %u (sarb->len: %u, vcc: 0x%p)!", pdu_length, sarb->len, vcc);
+				atomic_inc (&vcc->stats->rx_err);
+				goto out;
 			}
 
-			if (crc32_be (~0, skb->tail - pdu_length, pdu_length) != 0xc704dd7b) {
-				dbg ("udsl_extract_cells: packet failed crc check (vcc: 0x%p)", vcc);
-				goto drop;
+			if (crc32_be (~0, sarb->tail - pdu_length, pdu_length) != 0xc704dd7b) {
+				dbg ("udsl_extract_cells: packet failed crc check (vcc: 0x%p)!", vcc);
+				atomic_inc (&vcc->stats->rx_err);
+				goto out;
 			}
 
-			if (!atm_charge (vcc, skb->truesize)) {
-				dbg ("udsl_extract_cells: failed atm_charge (skb->truesize: %u)", skb->truesize);
-				goto drop_no_stats; /* atm_charge increments rx_drop */
-			}
+			vdbg ("udsl_extract_cells: got packet (length: %u, pdu_length: %u, vcc: 0x%p)", length, pdu_length, vcc);
 
-			/* now that we are sure to send the skb, it is ok to change skb->data */
-			if (skb->len > pdu_length)
-				skb_pull (skb, skb->len - pdu_length); /* discard initial junk */
+			if (!(skb = dev_alloc_skb (length))) {
+				dbg ("udsl_extract_cells: no memory for skb (length: %u)!", length);
+				atomic_inc (&vcc->stats->rx_drop);
+				goto out;
+			}
 
-			skb_trim (skb, length); /* drop zero padding and trailer */
+			vdbg ("udsl_extract_cells: allocated new sk_buff (skb: 0x%p, skb->truesize: %u)", skb, skb->truesize);
 
-			atomic_inc (&vcc->stats->rx);
+			if (!atm_charge (vcc, skb->truesize)) {
+				dbg ("udsl_extract_cells: failed atm_charge (skb->truesize: %u)!", skb->truesize);
+				dev_kfree_skb (skb);
+				goto out; /* atm_charge increments rx_drop */
+			}
 
-			PACKETDEBUG (skb->data, skb->len);
+			memcpy (skb->data, sarb->tail - pdu_length, length);
+			__skb_put (skb, length);
 
 			vdbg ("udsl_extract_cells: sending skb 0x%p, skb->len %u, skb->truesize %u", skb, skb->len, skb->truesize);
 
-			vcc->push (vcc, skb);
-
-			vcc_data->skb = NULL;
+			PACKETDEBUG (skb->data, skb->len);
 
-			continue;
+			vcc->push (vcc, skb);
 
-drop:
-			atomic_inc (&vcc->stats->rx_err);
-drop_no_stats:
-			skb_trim (skb, 0);
+			atomic_inc (&vcc->stats->rx);
+out:
+			skb_trim (sarb, 0);
 		}
 	}
 }
@@ -871,6 +867,7 @@
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
 	struct udsl_vcc_data *new;
+	unsigned int max_pdu;
 
 	dbg ("udsl_atm_open: vpi %hd, vci %d", vpi, vci);
 
@@ -907,7 +904,15 @@
 	new->vcc = vcc;
 	new->vpi = vpi;
 	new->vci = vci;
-	new->max_pdu = max (1, UDSL_NUM_CELLS (vcc->qos.rxtp.max_sdu)) * ATM_CELL_PAYLOAD;
+
+	/* udsl_extract_cells requires at least one cell */
+	max_pdu = max (1, UDSL_NUM_CELLS (vcc->qos.rxtp.max_sdu)) * ATM_CELL_PAYLOAD;
+	if (!(new->sarb = alloc_skb (max_pdu, GFP_KERNEL))) {
+		dbg ("udsl_atm_open: no memory for SAR buffer!");
+	        kfree (new);
+		up (&instance->serialize);
+		return -ENOMEM;
+	}
 
 	vcc->dev_data = new;
 	vcc->vpi = vpi;
@@ -925,7 +930,7 @@
 
 	tasklet_schedule (&instance->receive_tasklet);
 
-	dbg ("udsl_atm_open: allocated vcc data 0x%p (max_pdu: %u)", new, new->max_pdu);
+	dbg ("udsl_atm_open: allocated vcc data 0x%p (max_pdu: %u)", new, max_pdu);
 
 	return 0;
 }
@@ -952,9 +957,8 @@
 	list_del (&vcc_data->list);
 	tasklet_enable (&instance->receive_tasklet);
 
-	if (vcc_data->skb)
-		dev_kfree_skb (vcc_data->skb);
-	vcc_data->skb = NULL;
+	kfree_skb (vcc_data->sarb);
+	vcc_data->sarb = NULL;
 
 	kfree (vcc_data);
 	vcc->dev_data = NULL;
