Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264130AbTCXQxY>; Mon, 24 Mar 2003 11:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264341AbTCXQwR>; Mon, 24 Mar 2003 11:52:17 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.27]:41461 "EHLO
	mwinf0404.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264277AbTCXQvb>; Mon, 24 Mar 2003 11:51:31 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: trivial cleanups
Date: Mon, 24 Mar 2003 18:02:32 +0100
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303241802.32437.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

speedtch.c |  110 ++++++++++++++++++++++++++++---------------------------------
1 files changed, 51 insertions(+), 59 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Mon Mar 24 18:00:56 2003
+++ b/drivers/usb/misc/speedtch.c	Mon Mar 24 18:00:56 2003
@@ -148,19 +148,16 @@
 
 #define UDSL_SKB(x)		((struct udsl_control *)(x)->cb)
 
-struct atmsar_vcc_data {
-	struct atmsar_vcc_data *next;
-
-	/* connection specific non-atmsar data */
-	struct atm_vcc *vcc;
-	unsigned short mtu;	/* max is actually  65k for AAL5... */
-
-	/* cell data */
-	unsigned int vp;
-	unsigned int vc;
+struct udsl_vcc_data {
+	/* vpi/vci lookup */
+	struct udsl_vcc_data *next;
+	unsigned int vpi;
+	unsigned int vci;
 	unsigned long atmHeader;
+	struct atm_vcc *vcc;
 
 	/* raw cell reassembly */
+	unsigned short mtu;
 	struct sk_buff *reasBuffer;
 };
 
@@ -178,7 +175,7 @@
 
 	/* atm device part */
 	struct atm_dev *atm_dev;
-	struct atmsar_vcc_data *atmsar_vcc_list;
+	struct udsl_vcc_data *vcc_list;
 
 	/* receiving */
 	struct udsl_receiver all_receivers [UDSL_NUMBER_RCV_URBS];
@@ -252,24 +249,23 @@
 
 #define ATM_HDR_VPVC_MASK		(ATM_HDR_VPI_MASK | ATM_HDR_VCI_MASK)
 
-struct sk_buff *atmsar_decode_rawcell (struct atmsar_vcc_data *list, struct sk_buff *skb,
-				       struct atmsar_vcc_data **ctx)
+static struct sk_buff *udsl_decode_rawcell (struct udsl_vcc_data *list, struct sk_buff *skb, struct udsl_vcc_data **ctx)
 {
+	if (!list || !skb || !ctx)
+		return NULL;
+	if (!skb->data || !skb->tail)
+		return NULL;
+
 	while (skb->len) {
 		unsigned char *cell = skb->data;
 		unsigned char *cell_payload;
-		struct atmsar_vcc_data *vcc = list;
+		struct udsl_vcc_data *vcc = list;
 		unsigned long atmHeader =
 		    ((unsigned long) (cell[0]) << 24) | ((unsigned long) (cell[1]) << 16) |
 		    ((unsigned long) (cell[2]) << 8) | (cell[3] & 0xff);
 
-		dbg ("atmsar_decode_rawcell (0x%p, 0x%p, 0x%p) called", list, skb, ctx);
-		dbg ("atmsar_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
-
-		if (!list || !skb || !ctx)
-			return NULL;
-		if (!skb->data || !skb->tail)
-			return NULL;
+		dbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", list, skb, ctx);
+		dbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
 
 		/* here should the header CRC check be... */
 
@@ -279,7 +275,7 @@
 		     && ((vcc->atmHeader & ATM_HDR_VPVC_MASK) != (atmHeader & ATM_HDR_VPVC_MASK));
 		     vcc = vcc->next);
 
-		dbg ("atmsar_decode_rawcell found vcc %p for packet on vp %d, vc %d", vcc,
+		dbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc,
 			(int) ((atmHeader & ATM_HDR_VPI_MASK) >> ATM_HDR_VPI_SHIFT),
 			(int) ((atmHeader & ATM_HDR_VCI_MASK) >> ATM_HDR_VCI_SHIFT));
 
@@ -313,9 +309,7 @@
 					tmp = vcc->reasBuffer;
 					vcc->reasBuffer = NULL;
 
-					dbg
-					    ("atmsar_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d",
-					     tmp, tmp->len);
+					dbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
 					return tmp;
 				}
 			}
@@ -331,14 +325,14 @@
 	}
 
 	return NULL;
-};
+}
 
-struct sk_buff *atmsar_decode_aal5 (struct atmsar_vcc_data *ctx, struct sk_buff *skb)
+static struct sk_buff *udsl_decode_aal5 (struct udsl_vcc_data *ctx, struct sk_buff *skb)
 {
 	uint crc = 0xffffffff;
 	uint length, pdu_crc, pdu_length;
 
-	dbg ("atmsar_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
+	dbg ("udsl_decode_aal5 (0x%p, 0x%p) called", ctx, skb);
 
 	if (skb->len && (skb->len % 48))
 		return NULL;
@@ -348,7 +342,7 @@
 	    (skb->tail[-4] << 24) + (skb->tail[-3] << 16) + (skb->tail[-2] << 8) + skb->tail[-1];
 	pdu_length = ((length + 47 + 8) / 48) * 48;
 
-	dbg ("atmsar_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d",
+	dbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d",
 		skb->len, length, pdu_crc, pdu_length);
 
 	/* is skb long enough ? */
@@ -360,7 +354,7 @@
 
 	/* is skb too long ? */
 	if (skb->len > pdu_length) {
-		dbg ("atmsar_decode_aal5: Warning: readjusting illeagl size %d -> %d",
+		dbg ("udsl_decode_aal5: Warning: readjusting illegal size %d -> %d",
 			skb->len, pdu_length);
 		/* buffer is too long. we can try to recover
 		 * if we discard the first part of the skb.
@@ -373,7 +367,7 @@
 
 	/* check crc */
 	if (pdu_crc != crc) {
-		dbg ("atmsar_decode_aal5: crc check failed!");
+		dbg ("udsl_decode_aal5: crc check failed!");
 		if (ctx->vcc->stats)
 			atomic_inc (&ctx->vcc->stats->rx_err);
 		return NULL;
@@ -386,16 +380,17 @@
 	if (ctx->vcc->stats)
 		atomic_inc (&ctx->vcc->stats->rx);
 
-	dbg ("atmsar_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
+	dbg ("udsl_decode_aal5 returns pdu 0x%p with length %d", skb, skb->len);
 	return skb;
-};
+}
 
 
 /*************
 **  encode  **
 *************/
 
-static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb) {
+static void udsl_groom_skb (struct atm_vcc *vcc, struct sk_buff *skb)
+{
 	struct udsl_control *ctrl = UDSL_SKB (skb);
 	unsigned int i, zero_padding;
 	unsigned char zero = 0;
@@ -435,7 +430,8 @@
 	ctrl->aal5_trailer [7] = crc;
 }
 
-unsigned int udsl_write_cells (unsigned int howmany, struct sk_buff *skb, unsigned char **target_p) {
+static unsigned int udsl_write_cells (unsigned int howmany, struct sk_buff *skb, unsigned char **target_p)
+{
 	struct udsl_control *ctrl = UDSL_SKB (skb);
 	unsigned char *target = *target_p;
 	unsigned int nc, ne, i;
@@ -524,7 +520,7 @@
 	unsigned char *data_start;
 	struct sk_buff *skb;
 	struct urb *urb;
-	struct atmsar_vcc_data *atmsar_vcc = NULL;
+	struct udsl_vcc_data *atmsar_vcc = NULL;
 	struct sk_buff *new = NULL, *tmp = NULL;
 	int err;
 
@@ -552,13 +548,11 @@
 			dbg ("skb->len = %d", skb->len);
 			PACKETDEBUG (skb->data, skb->len);
 
-			while ((new =
-				atmsar_decode_rawcell (instance->atmsar_vcc_list, skb,
-						       &atmsar_vcc)) != NULL) {
+			while ((new = udsl_decode_rawcell (instance->vcc_list, skb, &atmsar_vcc))) {
 				dbg ("(after cell processing)skb->len = %d", new->len);
 
 				tmp = new;
-				new = atmsar_decode_aal5 (atmsar_vcc, new);
+				new = udsl_decode_aal5 (atmsar_vcc, new);
 
 				/* we can't send NULL skbs upstream, the ATM layer would try to close the vcc... */
 				if (new) {
@@ -574,7 +568,7 @@
 						dev_kfree_skb (new);
 					}
 				} else {
-					dbg ("atmsar_decode_aal5 returned NULL!");
+					dbg ("udsl_decode_aal5 returned NULL!");
 					dev_kfree_skb (tmp);
 				}
 			}
@@ -917,12 +911,10 @@
 	return 0;
 }
 
-#define ATMSAR_SET_PTI		0x2L
-
 static int udsl_atm_open (struct atm_vcc *vcc, short vpi, int vci)
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
-	struct atmsar_vcc_data *new;
+	struct udsl_vcc_data *new;
 
 	dbg ("udsl_atm_open called");
 
@@ -931,19 +923,19 @@
 		return -ENODEV;
 	}
 
-	/* at the moment only AAL5 support */
+	/* only support AAL5 */
 	if (vcc->qos.aal != ATM_AAL5)
 		return -EINVAL;
 
-	if (!(new = kmalloc (sizeof (struct atmsar_vcc_data), GFP_KERNEL)))
+	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL)))
 		return -ENOMEM;
 
 	MOD_INC_USE_COUNT;
 
-	memset (new, 0, sizeof (struct atmsar_vcc_data));
+	memset (new, 0, sizeof (struct udsl_vcc_data));
 	new->vcc = vcc;
-	new->vp = vpi;
-	new->vc = vci;
+	new->vpi = vpi;
+	new->vci = vci;
 
 	new->mtu = UDSL_MAX_AAL5_MRU;
 
@@ -951,10 +943,10 @@
 			 ((unsigned long) vci << ATM_HDR_VCI_SHIFT);
 	new->reasBuffer = NULL;
 
-	new->next = instance->atmsar_vcc_list;
-	instance->atmsar_vcc_list = new;
+	new->next = instance->vcc_list;
+	instance->vcc_list = new;
 
-	dbg ("Allocated new SARLib vcc 0x%p with vp %d vc %d", new, vpi, vci);
+	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
 
 	vcc->dev_data = new;
 
@@ -974,7 +966,7 @@
 static void udsl_atm_close (struct atm_vcc *vcc)
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
-	struct atmsar_vcc_data *work;
+	struct udsl_vcc_data *work;
 
 	dbg ("udsl_atm_close called");
 
@@ -987,10 +979,10 @@
 	/* cancel all sends on this vcc */
 	udsl_cancel_send (instance, vcc);
 
-	if (instance->atmsar_vcc_list == vcc->dev_data) {
-		instance->atmsar_vcc_list = instance->atmsar_vcc_list->next;
+	if (instance->vcc_list == vcc->dev_data) {
+		instance->vcc_list = instance->vcc_list->next;
 	} else {
-		for (work = instance->atmsar_vcc_list; work && work->next && (work->next != vcc->dev_data); work = work->next);
+		for (work = instance->vcc_list; work && work->next && (work->next != vcc->dev_data); work = work->next);
 
 		/* return if not found */
 		if (work->next != vcc->dev_data)
@@ -999,11 +991,11 @@
 		work->next = work->next->next;
 	}
 
-	if (((struct atmsar_vcc_data *)vcc->dev_data)->reasBuffer) {
-		dev_kfree_skb (((struct atmsar_vcc_data *)vcc->dev_data)->reasBuffer);
+	if (((struct udsl_vcc_data *)vcc->dev_data)->reasBuffer) {
+		dev_kfree_skb (((struct udsl_vcc_data *)vcc->dev_data)->reasBuffer);
 	}
 
-	dbg ("Deallocated SARLib vcc 0x%p with vp %d vc %d", vcc->dev_data, vcc->dev_data->vp, vcc->dev_data->vc);
+	dbg ("Deallocated SARLib vcc 0x%p with vpi %d vci %d", vcc->dev_data, vcc->dev_data->vpi, vcc->dev_data->vci);
 
 	kfree (vcc->dev_data);
 

