Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264174AbTCXMTR>; Mon, 24 Mar 2003 07:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264178AbTCXMTR>; Mon, 24 Mar 2003 07:19:17 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.29]:54078 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264174AbTCXMTK>; Mon, 24 Mar 2003 07:19:10 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] USB speedtouch: code reorganization
Date: Mon, 24 Mar 2003 13:30:09 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303241330.09755.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Forgot to CC LKML]

Remove dead code from sarlib, reorganize live sarlib code (trivial transformations).

speedtch.c |  312 +++++++++++++++++++------------------------------------------
1 files changed, 100 insertions(+), 212 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Mon Mar 24 12:13:27 2003
+++ b/drivers/usb/misc/speedtch.c	Mon Mar 24 12:13:27 2003
@@ -151,21 +151,13 @@
 struct atmsar_vcc_data {
 	struct atmsar_vcc_data *next;
 
-	/* general atmsar flags, per connection */
-	int flags;
-	int type;
-
 	/* connection specific non-atmsar data */
 	struct atm_vcc *vcc;
-	struct k_atm_aal_stats *stats;
 	unsigned short mtu;	/* max is actually  65k for AAL5... */
 
 	/* cell data */
 	unsigned int vp;
 	unsigned int vc;
-	unsigned char gfc;
-	unsigned char pti;
-	unsigned int headerFlags;
 	unsigned long atmHeader;
 
 	/* raw cell reassembly */
@@ -259,7 +251,6 @@
 *************/
 
 #define ATM_HDR_VPVC_MASK		(ATM_HDR_VPI_MASK | ATM_HDR_VCI_MASK)
-#define ATMSAR_USE_53BYTE_CELL		0x1L
 
 struct sk_buff *atmsar_decode_rawcell (struct atmsar_vcc_data *list, struct sk_buff *skb,
 				       struct atmsar_vcc_data **ctx)
@@ -292,85 +283,49 @@
 			(int) ((atmHeader & ATM_HDR_VPI_MASK) >> ATM_HDR_VPI_SHIFT),
 			(int) ((atmHeader & ATM_HDR_VCI_MASK) >> ATM_HDR_VCI_SHIFT));
 
-		if (vcc && (skb->len >= (vcc->flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52))) {
-			cell_payload = cell + (vcc->flags & ATMSAR_USE_53BYTE_CELL ? 5 : 4);
+		if (vcc && (skb->len >= 53)) {
+			cell_payload = cell + 5;
 
-			switch (vcc->type) {
-			case ATM_AAL0:
-				/* case ATM_AAL1: when we have a decode AAL1 function... */
-				{
-					struct sk_buff *tmp = dev_alloc_skb (vcc->mtu);
-
-					if (tmp) {
-						memcpy (tmp->tail, cell_payload, 48);
-						skb_put (tmp, 48);
-
-						if (vcc->stats)
-							atomic_inc (&vcc->stats->rx);
-
-						skb_pull (skb,
-							  (vcc->
-							   flags & ATMSAR_USE_53BYTE_CELL ? 53 :
-							   52));
-						dbg
-						    ("atmsar_decode_rawcell returns ATM_AAL0 pdu 0x%p with length %d",
-						     tmp, tmp->len);
-						return tmp;
-					};
-				}
-				break;
-			case ATM_AAL1:
-			case ATM_AAL2:
-			case ATM_AAL34:
-				/* not supported */
-				break;
-			case ATM_AAL5:
-				if (!vcc->reasBuffer)
-					vcc->reasBuffer = dev_alloc_skb (vcc->mtu);
-
-				/* if alloc fails, we just drop the cell. it is possible that we can still
-				 * receive cells on other vcc's
-				 */
-				if (vcc->reasBuffer) {
-					/* if (buffer overrun) discard received cells until now */
-					if ((vcc->reasBuffer->len) > (vcc->mtu - 48))
-						skb_trim (vcc->reasBuffer, 0);
-
-					/* copy data */
-					memcpy (vcc->reasBuffer->tail, cell_payload, 48);
-					skb_put (vcc->reasBuffer, 48);
-
-					/* check for end of buffer */
-					if (cell[3] & 0x2) {
-						struct sk_buff *tmp;
-
-						/* the aal5 buffer ends here, cut the buffer. */
-						/* buffer will always have at least one whole cell, so */
-						/* don't need to check return from skb_pull */
-						skb_pull (skb,
-							  (vcc->
-							   flags & ATMSAR_USE_53BYTE_CELL ? 53 :
-							   52));
-						*ctx = vcc;
-						tmp = vcc->reasBuffer;
-						vcc->reasBuffer = NULL;
+			if (!vcc->reasBuffer)
+				vcc->reasBuffer = dev_alloc_skb (vcc->mtu);
 
-						dbg
-						    ("atmsar_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d",
-						     tmp, tmp->len);
-						return tmp;
-					}
+			/* if alloc fails, we just drop the cell. it is possible that we can still
+			 * receive cells on other vcc's
+			 */
+			if (vcc->reasBuffer) {
+				/* if (buffer overrun) discard received cells until now */
+				if ((vcc->reasBuffer->len) > (vcc->mtu - 48))
+					skb_trim (vcc->reasBuffer, 0);
+
+				/* copy data */
+				memcpy (vcc->reasBuffer->tail, cell_payload, 48);
+				skb_put (vcc->reasBuffer, 48);
+
+				/* check for end of buffer */
+				if (cell[3] & 0x2) {
+					struct sk_buff *tmp;
+
+					/* the aal5 buffer ends here, cut the buffer. */
+					/* buffer will always have at least one whole cell, so */
+					/* don't need to check return from skb_pull */
+					skb_pull (skb, 53);
+					*ctx = vcc;
+					tmp = vcc->reasBuffer;
+					vcc->reasBuffer = NULL;
+
+					dbg
+					    ("atmsar_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d",
+					     tmp, tmp->len);
+					return tmp;
 				}
-				break;
-			};
+			}
 			/* flush the cell */
 			/* buffer will always contain at least one whole cell, so don't */
 			/* need to check return value from skb_pull */
-			skb_pull (skb, (vcc->flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52));
+			skb_pull (skb, 53);
 		} else {
 			/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
-			if (skb_pull (skb, (list->flags & ATMSAR_USE_53BYTE_CELL ? 53 : 52)) ==
-			    NULL)
+			if (skb_pull (skb, 53) == NULL)
 				return NULL;
 		}
 	}
@@ -398,8 +353,8 @@
 
 	/* is skb long enough ? */
 	if (skb->len < pdu_length) {
-		if (ctx->stats)
-			atomic_inc (&ctx->stats->rx_err);
+		if (ctx->vcc->stats)
+			atomic_inc (&ctx->vcc->stats->rx_err);
 		return NULL;
 	}
 
@@ -419,8 +374,8 @@
 	/* check crc */
 	if (pdu_crc != crc) {
 		dbg ("atmsar_decode_aal5: crc check failed!");
-		if (ctx->stats)
-			atomic_inc (&ctx->stats->rx_err);
+		if (ctx->vcc->stats)
+			atomic_inc (&ctx->vcc->stats->rx_err);
 		return NULL;
 	}
 
@@ -428,8 +383,8 @@
 	skb_trim (skb, length);
 
 	/* update stats */
-	if (ctx->stats)
-		atomic_inc (&ctx->stats->rx);
+	if (ctx->vcc->stats)
+		atomic_inc (&ctx->vcc->stats->rx);
 
 	dbg ("atmsar_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
 	return skb;
@@ -602,35 +557,25 @@
 						       &atmsar_vcc)) != NULL) {
 				dbg ("(after cell processing)skb->len = %d", new->len);
 
-				switch (atmsar_vcc->type) {
-				case ATM_AAL5:
-					tmp = new;
-					new = atmsar_decode_aal5 (atmsar_vcc, new);
-
-					/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
-					if (new) {
-						dbg ("(after aal5 decap) skb->len = %d", new->len);
-						if (new->len && atm_charge (atmsar_vcc->vcc, new->truesize)) {
-							PACKETDEBUG (new->data, new->len);
-							atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
-						} else {
-							dbg
-							    ("dropping incoming packet : rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
-							     atomic_read (&atmsar_vcc->vcc->rx_inuse),
-							     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
-							dev_kfree_skb (new);
-						}
+				tmp = new;
+				new = atmsar_decode_aal5 (atmsar_vcc, new);
+
+				/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
+				if (new) {
+					dbg ("(after aal5 decap) skb->len = %d", new->len);
+					if (new->len && atm_charge (atmsar_vcc->vcc, new->truesize)) {
+						PACKETDEBUG (new->data, new->len);
+						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
 					} else {
-						dbg ("atmsar_decode_aal5 returned NULL!");
-						dev_kfree_skb (tmp);
+						dbg
+						    ("dropping incoming packet : rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
+						     atomic_read (&atmsar_vcc->vcc->rx_inuse),
+						     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
+						dev_kfree_skb (new);
 					}
-					break;
-				default:
-					/* not supported. we delete the skb. */
-					printk (KERN_INFO
-						"SpeedTouch USB: illegal vcc type. Dropping packet.\n");
-					dev_kfree_skb (new);
-					break;
+				} else {
+					dbg ("atmsar_decode_aal5 returned NULL!");
+					dev_kfree_skb (tmp);
 				}
 			}
 
@@ -901,95 +846,6 @@
 **  ATM  **
 **********/
 
-#define ATMSAR_DEF_MTU_AAL0		48
-#define ATMSAR_DEF_MTU_AAL1		47
-#define ATMSAR_DEF_MTU_AAL2		0  /* not supported */
-#define ATMSAR_DEF_MTU_AAL34		0  /* not supported */
-#define ATMSAR_DEF_MTU_AAL5		65535  /* max mtu ..    */
-
-struct atmsar_vcc_data *atmsar_open (struct atmsar_vcc_data **list, struct atm_vcc *vcc, uint type,
-				     ushort vpi, ushort vci, unchar pti, unchar gfc, uint flags)
-{
-	struct atmsar_vcc_data *new;
-
-	if (!vcc)
-		return NULL;
-
-	new = kmalloc (sizeof (struct atmsar_vcc_data), GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-
-	memset (new, 0, sizeof (struct atmsar_vcc_data));
-	new->vcc = vcc;
-	new->stats = vcc->stats;
-	new->type = type;
-	new->next = NULL;
-	new->gfc = gfc;
-	new->vp = vpi;
-	new->vc = vci;
-	new->pti = pti;
-
-	switch (type) {
-	case ATM_AAL0:
-		new->mtu = ATMSAR_DEF_MTU_AAL0;
-		break;
-	case ATM_AAL1:
-		new->mtu = ATMSAR_DEF_MTU_AAL1;
-		break;
-	case ATM_AAL2:
-		new->mtu = ATMSAR_DEF_MTU_AAL2;
-		break;
-	case ATM_AAL34:
-		/* not supported */
-		new->mtu = ATMSAR_DEF_MTU_AAL34;
-		break;
-	case ATM_AAL5:
-		new->mtu = ATMSAR_DEF_MTU_AAL5;
-		break;
-	}
-
-	new->atmHeader = ((unsigned long) gfc << ATM_HDR_GFC_SHIFT)
-	    | ((unsigned long) vpi << ATM_HDR_VPI_SHIFT)
-	    | ((unsigned long) vci << ATM_HDR_VCI_SHIFT)
-	    | ((unsigned long) pti << ATM_HDR_PTI_SHIFT);
-	new->flags = flags;
-	new->next = NULL;
-	new->reasBuffer = NULL;
-
-	new->next = *list;
-	*list = new;
-
-	dbg ("Allocated new SARLib vcc 0x%p with vp %d vc %d", new, vpi, vci);
-
-	return new;
-}
-
-void atmsar_close (struct atmsar_vcc_data **list, struct atmsar_vcc_data *vcc)
-{
-	struct atmsar_vcc_data *work;
-
-	if (*list == vcc) {
-		*list = (*list)->next;
-	} else {
-		for (work = *list; work && work->next && (work->next != vcc); work = work->next);
-
-		/* return if not found */
-		if (work->next != vcc)
-			return;
-
-		work->next = work->next->next;
-	}
-
-	if (vcc->reasBuffer) {
-		dev_kfree_skb (vcc->reasBuffer);
-	}
-
-	dbg ("Allocated SARLib vcc 0x%p with vp %d vc %d", vcc, vcc->vp, vcc->vc);
-
-	kfree (vcc);
-}
-
 static void udsl_atm_dev_close (struct atm_dev *dev)
 {
 	struct udsl_instance_data *instance = dev->dev_data;
@@ -1066,6 +922,7 @@
 static int udsl_atm_open (struct atm_vcc *vcc, short vpi, int vci)
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
+	struct atmsar_vcc_data *new;
 
 	dbg ("udsl_atm_open called");
 
@@ -1078,15 +935,28 @@
 	if (vcc->qos.aal != ATM_AAL5)
 		return -EINVAL;
 
+	if (!(new = kmalloc (sizeof (struct atmsar_vcc_data), GFP_KERNEL)))
+		return -ENOMEM;
+
 	MOD_INC_USE_COUNT;
 
-	vcc->dev_data =
-	    atmsar_open (&(instance->atmsar_vcc_list), vcc, ATM_AAL5, vpi, vci, 0, 0,
-			 ATMSAR_USE_53BYTE_CELL | ATMSAR_SET_PTI);
-	if (!vcc->dev_data) {
-		MOD_DEC_USE_COUNT;
-		return -ENOMEM;	/* this is the only reason atmsar_open can fail... */
-	}
+	memset (new, 0, sizeof (struct atmsar_vcc_data));
+	new->vcc = vcc;
+	new->vp = vpi;
+	new->vc = vci;
+
+	new->mtu = UDSL_MAX_AAL5_MRU;
+
+	new->atmHeader = ((unsigned long) vpi << ATM_HDR_VPI_SHIFT) |
+			 ((unsigned long) vci << ATM_HDR_VCI_SHIFT);
+	new->reasBuffer = NULL;
+
+	new->next = instance->atmsar_vcc_list;
+	instance->atmsar_vcc_list = new;
+
+	dbg ("Allocated new SARLib vcc 0x%p with vp %d vc %d", new, vpi, vci);
+
+	vcc->dev_data = new;
 
 	vcc->vpi = vpi;
 	vcc->vci = vci;
@@ -1094,8 +964,6 @@
 	set_bit (ATM_VF_PARTIAL, &vcc->flags);
 	set_bit (ATM_VF_READY, &vcc->flags);
 
-	((struct atmsar_vcc_data *)vcc->dev_data)->mtu = UDSL_MAX_AAL5_MRU;
-
 	if (instance->firmware_loaded)
 		udsl_fire_receivers (instance);
 
@@ -1106,6 +974,7 @@
 static void udsl_atm_close (struct atm_vcc *vcc)
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
+	struct atmsar_vcc_data *work;
 
 	dbg ("udsl_atm_close called");
 
@@ -1118,7 +987,26 @@
 	/* cancel all sends on this vcc */
 	udsl_cancel_send (instance, vcc);
 
-	atmsar_close (&(instance->atmsar_vcc_list), vcc->dev_data);
+	if (instance->atmsar_vcc_list == vcc->dev_data) {
+		instance->atmsar_vcc_list = instance->atmsar_vcc_list->next;
+	} else {
+		for (work = instance->atmsar_vcc_list; work && work->next && (work->next != vcc->dev_data); work = work->next);
+
+		/* return if not found */
+		if (work->next != vcc->dev_data)
+			BUG ();
+
+		work->next = work->next->next;
+	}
+
+	if (((struct atmsar_vcc_data *)vcc->dev_data)->reasBuffer) {
+		dev_kfree_skb (((struct atmsar_vcc_data *)vcc->dev_data)->reasBuffer);
+	}
+
+	dbg ("Deallocated SARLib vcc 0x%p with vp %d vc %d", vcc->dev_data, vcc->dev_data->vp, vcc->dev_data->vc);
+
+	kfree (vcc->dev_data);
+
 	vcc->dev_data = NULL;
 	clear_bit (ATM_VF_PARTIAL, &vcc->flags);
 

