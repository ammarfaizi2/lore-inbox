Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbTCYItQ>; Tue, 25 Mar 2003 03:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261654AbTCYItQ>; Tue, 25 Mar 2003 03:49:16 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.25]:41194 "EHLO
	mwinf0602.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261765AbTCYItF>; Tue, 25 Mar 2003 03:49:05 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: per vcc data cleanups
Date: Tue, 25 Mar 2003 10:00:07 +0100
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303251000.07690.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct list_head rather than a singly linked list in udsl_vcc_data.  Reject
attempts to open multiple vccs with the same vpi/vci pair.  Some cleanups too.


speedtch.c |  204 +++++++++++++++++++++++++++++--------------------------------
1 files changed, 98 insertions(+), 106 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Mar 25 09:54:05 2003
+++ b/drivers/usb/misc/speedtch.c	Tue Mar 25 09:54:05 2003
@@ -150,10 +150,9 @@
 
 struct udsl_vcc_data {
 	/* vpi/vci lookup */
-	struct udsl_vcc_data *next;
-	unsigned int vpi;
-	unsigned int vci;
-	unsigned long atmHeader;
+	struct list_head list;
+	short vpi;
+	int vci;
 	struct atm_vcc *vcc;
 
 	/* raw cell reassembly */
@@ -175,7 +174,7 @@
 
 	/* atm device part */
 	struct atm_dev *atm_dev;
-	struct udsl_vcc_data *vcc_list;
+	struct list_head vcc_list;
 
 	/* receiving */
 	struct udsl_receiver all_receivers [UDSL_NUMBER_RCV_URBS];
@@ -247,11 +246,19 @@
 **  decode  **
 *************/
 
-#define ATM_HDR_VPVC_MASK		(ATM_HDR_VPI_MASK | ATM_HDR_VCI_MASK)
+static inline struct udsl_vcc_data *udsl_find_vcc (struct udsl_instance_data *instance, short vpi, int vci)
+{
+	struct udsl_vcc_data *vcc;
 
-static struct sk_buff *udsl_decode_rawcell (struct udsl_vcc_data *list, struct sk_buff *skb, struct udsl_vcc_data **ctx)
+	list_for_each_entry (vcc, &instance->vcc_list, list)
+		if ((vcc->vpi == vpi) && (vcc->vci == vci))
+			return vcc;
+	return NULL;
+}
+
+static struct sk_buff *udsl_decode_rawcell (struct udsl_instance_data *instance, struct sk_buff *skb, struct udsl_vcc_data **ctx)
 {
-	if (!list || !skb || !ctx)
+	if (!instance || !skb || !ctx)
 		return NULL;
 	if (!skb->data || !skb->tail)
 		return NULL;
@@ -259,68 +266,66 @@
 	while (skb->len) {
 		unsigned char *cell = skb->data;
 		unsigned char *cell_payload;
-		struct udsl_vcc_data *vcc = list;
-		unsigned long atmHeader =
-		    ((unsigned long) (cell[0]) << 24) | ((unsigned long) (cell[1]) << 16) |
-		    ((unsigned long) (cell[2]) << 8) | (cell[3] & 0xff);
+		struct udsl_vcc_data *vcc;
+		short vpi;
+		int vci;
+
+		vpi = ((cell[0] & 0x0f) << 4) | (cell[1] >> 4);
+		vci = ((cell[1] & 0x0f) << 12) | (cell[2] << 4) | (cell[3] >> 4);
 
-		dbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", list, skb, ctx);
+		dbg ("udsl_decode_rawcell (0x%p, 0x%p, 0x%p) called", instance, skb, ctx);
 		dbg ("udsl_decode_rawcell skb->data %p, skb->tail %p", skb->data, skb->tail);
 
 		/* here should the header CRC check be... */
 
-		/* look up correct vcc */
-		for (;
-		     vcc
-		     && ((vcc->atmHeader & ATM_HDR_VPVC_MASK) != (atmHeader & ATM_HDR_VPVC_MASK));
-		     vcc = vcc->next);
-
-		dbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc,
-			(int) ((atmHeader & ATM_HDR_VPI_MASK) >> ATM_HDR_VPI_SHIFT),
-			(int) ((atmHeader & ATM_HDR_VCI_MASK) >> ATM_HDR_VCI_SHIFT));
-
-		if (vcc && (skb->len >= 53)) {
-			cell_payload = cell + 5;
-
-			if (!vcc->reasBuffer)
-				vcc->reasBuffer = dev_alloc_skb (vcc->mtu);
-
-			/* if alloc fails, we just drop the cell. it is possible that we can still
-			 * receive cells on other vcc's
-			 */
-			if (vcc->reasBuffer) {
-				/* if (buffer overrun) discard received cells until now */
-				if ((vcc->reasBuffer->len) > (vcc->mtu - 48))
-					skb_trim (vcc->reasBuffer, 0);
-
-				/* copy data */
-				memcpy (vcc->reasBuffer->tail, cell_payload, 48);
-				skb_put (vcc->reasBuffer, 48);
-
-				/* check for end of buffer */
-				if (cell[3] & 0x2) {
-					struct sk_buff *tmp;
-
-					/* the aal5 buffer ends here, cut the buffer. */
-					/* buffer will always have at least one whole cell, so */
-					/* don't need to check return from skb_pull */
-					skb_pull (skb, 53);
-					*ctx = vcc;
-					tmp = vcc->reasBuffer;
-					vcc->reasBuffer = NULL;
+		if (!(vcc = udsl_find_vcc (instance, vpi, vci)))
+			dbg ("udsl_decode_rawcell: no vcc found for packet on vpi %d, vci %d", vpi, vci);
+		else {
+			dbg ("udsl_decode_rawcell found vcc %p for packet on vpi %d, vci %d", vcc, vpi, vci);
+
+			if (skb->len >= 53) {
+				cell_payload = cell + 5;
+
+				if (!vcc->reasBuffer)
+					vcc->reasBuffer = dev_alloc_skb (vcc->mtu);
+
+				/* if alloc fails, we just drop the cell. it is possible that we can still
+				 * receive cells on other vcc's
+				 */
+				if (vcc->reasBuffer) {
+					/* if (buffer overrun) discard received cells until now */
+					if ((vcc->reasBuffer->len) > (vcc->mtu - 48))
+						skb_trim (vcc->reasBuffer, 0);
+
+					/* copy data */
+					memcpy (vcc->reasBuffer->tail, cell_payload, 48);
+					skb_put (vcc->reasBuffer, 48);
+
+					/* check for end of buffer */
+					if (cell[3] & 0x2) {
+						struct sk_buff *tmp;
+
+						/* the aal5 buffer ends here, cut the buffer. */
+						/* buffer will always have at least one whole cell, so */
+						/* don't need to check return from skb_pull */
+						skb_pull (skb, 53);
+						*ctx = vcc;
+						tmp = vcc->reasBuffer;
+						vcc->reasBuffer = NULL;
 
-					dbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
-					return tmp;
+						dbg ("udsl_decode_rawcell returns ATM_AAL5 pdu 0x%p with length %d", tmp, tmp->len);
+						return tmp;
+					}
 				}
+				/* flush the cell */
+				/* buffer will always contain at least one whole cell, so don't */
+				/* need to check return value from skb_pull */
+				skb_pull (skb, 53);
+			} else {
+				/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
+				if (skb_pull (skb, 53) == NULL)
+					return NULL;
 			}
-			/* flush the cell */
-			/* buffer will always contain at least one whole cell, so don't */
-			/* need to check return value from skb_pull */
-			skb_pull (skb, 53);
-		} else {
-			/* If data is corrupt and skb doesn't hold a whole cell, flush the lot */
-			if (skb_pull (skb, 53) == NULL)
-				return NULL;
 		}
 	}
 
@@ -342,8 +347,7 @@
 	    (skb->tail[-4] << 24) + (skb->tail[-3] << 16) + (skb->tail[-2] << 8) + skb->tail[-1];
 	pdu_length = ((length + 47 + 8) / 48) * 48;
 
-	dbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d",
-		skb->len, length, pdu_crc, pdu_length);
+	dbg ("udsl_decode_aal5: skb->len = %d, length = %d, pdu_crc = 0x%x, pdu_length = %d", skb->len, length, pdu_crc, pdu_length);
 
 	/* is skb long enough ? */
 	if (skb->len < pdu_length) {
@@ -354,8 +358,7 @@
 
 	/* is skb too long ? */
 	if (skb->len > pdu_length) {
-		dbg ("udsl_decode_aal5: Warning: readjusting illegal size %d -> %d",
-			skb->len, pdu_length);
+		dbg ("udsl_decode_aal5: Warning: readjusting illegal size %d -> %d", skb->len, pdu_length);
 		/* buffer is too long. we can try to recover
 		 * if we discard the first part of the skb.
 		 * the crc will decide whether this was ok
@@ -548,7 +551,7 @@
 			dbg ("skb->len = %d", skb->len);
 			PACKETDEBUG (skb->data, skb->len);
 
-			while ((new = udsl_decode_rawcell (instance->vcc_list, skb, &atmsar_vcc))) {
+			while ((new = udsl_decode_rawcell (instance, skb, &atmsar_vcc))) {
 				dbg ("(after cell processing)skb->len = %d", new->len);
 
 				tmp = new;
@@ -923,94 +926,81 @@
 		return -ENODEV;
 	}
 
+	if ((vpi == ATM_VPI_ANY) || (vci == ATM_VCI_ANY))
+		return -EINVAL;
+
 	/* only support AAL5 */
 	if (vcc->qos.aal != ATM_AAL5)
 		return -EINVAL;
 
+	if (udsl_find_vcc (instance, vpi, vci))
+		return -EADDRINUSE;
+
 	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL)))
 		return -ENOMEM;
 
-	MOD_INC_USE_COUNT;
-
 	memset (new, 0, sizeof (struct udsl_vcc_data));
 	new->vcc = vcc;
 	new->vpi = vpi;
 	new->vci = vci;
-
 	new->mtu = UDSL_MAX_AAL5_MRU;
 
-	new->atmHeader = ((unsigned long) vpi << ATM_HDR_VPI_SHIFT) |
-			 ((unsigned long) vci << ATM_HDR_VCI_SHIFT);
-	new->reasBuffer = NULL;
-
-	new->next = instance->vcc_list;
-	instance->vcc_list = new;
-
-	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
-
 	vcc->dev_data = new;
-
 	vcc->vpi = vpi;
 	vcc->vci = vci;
+
+	list_add (&new->list, &instance->vcc_list);
+
 	set_bit (ATM_VF_ADDR, &vcc->flags);
 	set_bit (ATM_VF_PARTIAL, &vcc->flags);
 	set_bit (ATM_VF_READY, &vcc->flags);
 
+	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
+
+	MOD_INC_USE_COUNT;
+
 	if (instance->firmware_loaded)
 		udsl_fire_receivers (instance);
 
 	dbg ("udsl_atm_open successful");
+
 	return 0;
 }
 
 static void udsl_atm_close (struct atm_vcc *vcc)
 {
 	struct udsl_instance_data *instance = vcc->dev->dev_data;
-	struct udsl_vcc_data *work;
+	struct udsl_vcc_data *vcc_data = vcc->dev_data;
 
 	dbg ("udsl_atm_close called");
 
-	if (!instance) {
-		dbg ("NULL instance!");
+	if (!instance || !vcc_data) {
+		dbg ("NULL data!");
 		return;
 	}
 
-	/* freeing resources */
-	/* cancel all sends on this vcc */
-	udsl_cancel_send (instance, vcc);
-
-	if (instance->vcc_list == vcc->dev_data) {
-		instance->vcc_list = instance->vcc_list->next;
-	} else {
-		for (work = instance->vcc_list; work && work->next && (work->next != vcc->dev_data); work = work->next);
-
-		/* return if not found */
-		if (work->next != vcc->dev_data)
-			BUG ();
+	dbg ("Deallocating SARLib vcc 0x%p with vpi %d vci %d", vcc_data, vcc_data->vpi, vcc_data->vci);
 
-		work->next = work->next->next;
-	}
-
-	if (((struct udsl_vcc_data *)vcc->dev_data)->reasBuffer) {
-		dev_kfree_skb (((struct udsl_vcc_data *)vcc->dev_data)->reasBuffer);
-	}
+	udsl_cancel_send (instance, vcc);
 
-	dbg ("Deallocated SARLib vcc 0x%p with vpi %d vci %d", vcc->dev_data, vcc->dev_data->vpi, vcc->dev_data->vci);
+	list_del (&vcc_data->list);
 
-	kfree (vcc->dev_data);
+	if (vcc_data->reasBuffer)
+		kfree_skb (vcc_data->reasBuffer);
+	vcc_data->reasBuffer = NULL;
 
+	kfree (vcc_data);
 	vcc->dev_data = NULL;
-	clear_bit (ATM_VF_PARTIAL, &vcc->flags);
 
-	/* freeing address */
 	vcc->vpi = ATM_VPI_UNSPEC;
 	vcc->vci = ATM_VCI_UNSPEC;
+	clear_bit (ATM_VF_READY, &vcc->flags);
+	clear_bit (ATM_VF_PARTIAL, &vcc->flags);
 	clear_bit (ATM_VF_ADDR, &vcc->flags);
 
 	MOD_DEC_USE_COUNT;
 
 	dbg ("udsl_atm_close successful");
-	return;
 }
 
 static int udsl_atm_ioctl (struct atm_dev *dev, unsigned int cmd, void *arg)
@@ -1088,6 +1078,8 @@
 	init_MUTEX (&instance->serialize);
 
 	instance->usb_dev = dev;
+
+	INIT_LIST_HEAD (&instance->vcc_list);
 
 	spin_lock_init (&instance->spare_receivers_lock);
 	INIT_LIST_HEAD (&instance->spare_receivers);

