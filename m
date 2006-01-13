Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161524AbWAMKGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161524AbWAMKGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161525AbWAMKGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:06:46 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:7340 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161524AbWAMKGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:06:46 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 11/13] USBATM: handle urbs containing partial cells
Date: Fri, 13 Jan 2006 11:06:46 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3u3xD2kLrKU2Yh2"
Message-Id: <200601131106.47262.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3u3xD2kLrKU2Yh2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The receive logic has always assumed that urbs contain an integral
number of ATM cells, which is a bit naughty, though it never caused
any problems with bulk transfers.  Isochronous urbs spank us soundly
for this.  Fixed thanks to this patch, mostly by Stanislaw Gruszka.

Signed-off-by: Duncan Sands <baldrick@free.fr>

--Boundary-00=_3u3xD2kLrKU2Yh2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="11-merge"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="11-merge"

Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 09:12:53.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 09:25:43.000000000 +0100
@@ -296,126 +296,159 @@
 	return NULL;
 }
 
-static void usbatm_extract_cells(struct usbatm_data *instance,
-			       unsigned char *source, unsigned int avail_data)
+static void usbatm_extract_one_cell(struct usbatm_data *instance, unsigned char *source)
 {
-	struct usbatm_vcc_data *cached_vcc = NULL;
 	struct atm_vcc *vcc;
 	struct sk_buff *sarb;
-	unsigned int stride = instance->rx_channel.stride;
-	int vci, cached_vci = 0;
-	short vpi, cached_vpi = 0;
-	u8 pti;
+	short vpi = ((source[0] & 0x0f) << 4)  | (source[1] >> 4);
+	int vci = ((source[1] & 0x0f) << 12) | (source[2] << 4) | (source[3] >> 4);
+	u8 pti = ((source[3] & 0xe) >> 1);
 
-	for (; avail_data >= stride; avail_data -= stride, source += stride) {
-		vpi = ((source[0] & 0x0f) << 4)  | (source[1] >> 4);
-		vci = ((source[1] & 0x0f) << 12) | (source[2] << 4) | (source[3] >> 4);
-		pti = ((source[3] & 0xe) >> 1);
+	vdbg("%s: vpi %hd, vci %d, pti %d", __func__, vpi, vci, pti);
 
-		vdbg("%s: vpi %hd, vci %d, pti %d", __func__, vpi, vci, pti);
+	if ((vci != instance->cached_vci) || (vpi != instance->cached_vpi)) {
+		instance->cached_vpi = vpi;
+		instance->cached_vci = vci;
 
-		if ((vci != cached_vci) || (vpi != cached_vpi)) {
-			cached_vpi = vpi;
-			cached_vci = vci;
+		instance->cached_vcc = usbatm_find_vcc(instance, vpi, vci);
 
-			cached_vcc = usbatm_find_vcc(instance, vpi, vci);
+		if (!instance->cached_vcc)
+			atm_rldbg(instance, "%s: unknown vpi/vci (%hd/%d)!\n", __func__, vpi, vci);
+	}
 
-			if (!cached_vcc)
-				atm_rldbg(instance, "%s: unknown vpi/vci (%hd/%d)!\n", __func__, vpi, vci);
-		}
+	if (!instance->cached_vcc)
+		return;
 
-		if (!cached_vcc)
-			continue;
+	vcc = instance->cached_vcc->vcc;
 
-		vcc = cached_vcc->vcc;
+	/* OAM F5 end-to-end */
+	if (pti == ATM_PTI_E2EF5) {
+		if (printk_ratelimit())
+			atm_warn(instance, "%s: OAM not supported (vpi %d, vci %d)!\n",
+				__func__, vpi, vci);
+		atomic_inc(&vcc->stats->rx_err);
+		return;
+	}
 
-		/* OAM F5 end-to-end */
-		if (pti == ATM_PTI_E2EF5) {
-			if (printk_ratelimit())
-				atm_warn(instance, "%s: OAM not supported (vpi %d, vci %d)!\n",
-					__func__, vpi, vci);
+	sarb = instance->cached_vcc->sarb;
+
+	if (sarb->tail + ATM_CELL_PAYLOAD > sarb->end) {
+		atm_rldbg(instance, "%s: buffer overrun (sarb->len %u, vcc: 0x%p)!\n",
+				__func__, sarb->len, vcc);
+		/* discard cells already received */
+		skb_trim(sarb, 0);
+		UDSL_ASSERT(sarb->tail + ATM_CELL_PAYLOAD <= sarb->end);
+	}
+
+	memcpy(sarb->tail, source + ATM_CELL_HEADER, ATM_CELL_PAYLOAD);
+	__skb_put(sarb, ATM_CELL_PAYLOAD);
+
+	if (pti & 1) {
+		struct sk_buff *skb;
+		unsigned int length;
+		unsigned int pdu_length;
+
+		length = (source[ATM_CELL_SIZE - 6] << 8) + source[ATM_CELL_SIZE - 5];
+
+		/* guard against overflow */
+		if (length > ATM_MAX_AAL5_PDU) {
+			atm_rldbg(instance, "%s: bogus length %u (vcc: 0x%p)!\n",
+				  __func__, length, vcc);
 			atomic_inc(&vcc->stats->rx_err);
-			continue;
+			goto out;
 		}
 
-		sarb = cached_vcc->sarb;
+		pdu_length = usbatm_pdu_length(length);
 
-		if (sarb->tail + ATM_CELL_PAYLOAD > sarb->end) {
-			atm_rldbg(instance, "%s: buffer overrun (sarb->len %u, vcc: 0x%p)!\n",
-					__func__, sarb->len, vcc);
-			/* discard cells already received */
-			skb_trim(sarb, 0);
-			UDSL_ASSERT(sarb->tail + ATM_CELL_PAYLOAD <= sarb->end);
-		}
-
-		memcpy(sarb->tail, source + ATM_CELL_HEADER, ATM_CELL_PAYLOAD);
-		__skb_put(sarb, ATM_CELL_PAYLOAD);
-
-		if (pti & 1) {
-			struct sk_buff *skb;
-			unsigned int length;
-			unsigned int pdu_length;
-
-			length = (source[ATM_CELL_SIZE - 6] << 8) + source[ATM_CELL_SIZE - 5];
-
-			/* guard against overflow */
-			if (length > ATM_MAX_AAL5_PDU) {
-				atm_rldbg(instance, "%s: bogus length %u (vcc: 0x%p)!\n",
-						__func__, length, vcc);
-				atomic_inc(&vcc->stats->rx_err);
-				goto out;
-			}
+		if (sarb->len < pdu_length) {
+			atm_rldbg(instance, "%s: bogus pdu_length %u (sarb->len: %u, vcc: 0x%p)!\n",
+				  __func__, pdu_length, sarb->len, vcc);
+			atomic_inc(&vcc->stats->rx_err);
+			goto out;
+		}
 
-			pdu_length = usbatm_pdu_length(length);
+		if (crc32_be(~0, sarb->tail - pdu_length, pdu_length) != 0xc704dd7b) {
+			atm_rldbg(instance, "%s: packet failed crc check (vcc: 0x%p)!\n",
+				  __func__, vcc);
+			atomic_inc(&vcc->stats->rx_err);
+			goto out;
+		}
 
-			if (sarb->len < pdu_length) {
-				atm_rldbg(instance, "%s: bogus pdu_length %u (sarb->len: %u, vcc: 0x%p)!\n",
-						__func__, pdu_length, sarb->len, vcc);
-				atomic_inc(&vcc->stats->rx_err);
-				goto out;
-			}
+		vdbg("%s: got packet (length: %u, pdu_length: %u, vcc: 0x%p)", __func__, length, pdu_length, vcc);
 
-			if (crc32_be(~0, sarb->tail - pdu_length, pdu_length) != 0xc704dd7b) {
-				atm_rldbg(instance, "%s: packet failed crc check (vcc: 0x%p)!\n",
-						__func__, vcc);
-				atomic_inc(&vcc->stats->rx_err);
-				goto out;
-			}
+		if (!(skb = dev_alloc_skb(length))) {
+			if (printk_ratelimit())
+				atm_err(instance, "%s: no memory for skb (length: %u)!\n",
+					__func__, length);
+			atomic_inc(&vcc->stats->rx_drop);
+			goto out;
+		}
 
-			vdbg("%s: got packet (length: %u, pdu_length: %u, vcc: 0x%p)", __func__, length, pdu_length, vcc);
+		vdbg("%s: allocated new sk_buff (skb: 0x%p, skb->truesize: %u)", __func__, skb, skb->truesize);
 
-			if (!(skb = dev_alloc_skb(length))) {
-				if (printk_ratelimit())
-					atm_err(instance, "%s: no memory for skb (length: %u)!\n",
-							__func__, length);
-				atomic_inc(&vcc->stats->rx_drop);
-				goto out;
-			}
+		if (!atm_charge(vcc, skb->truesize)) {
+			atm_rldbg(instance, "%s: failed atm_charge (skb->truesize: %u)!\n",
+				  __func__, skb->truesize);
+			dev_kfree_skb_any(skb);
+			goto out;	/* atm_charge increments rx_drop */
+		}
 
-			vdbg("%s: allocated new sk_buff (skb: 0x%p, skb->truesize: %u)", __func__, skb, skb->truesize);
+		memcpy(skb->data, sarb->tail - pdu_length, length);
+		__skb_put(skb, length);
 
-			if (!atm_charge(vcc, skb->truesize)) {
-				atm_rldbg(instance, "%s: failed atm_charge (skb->truesize: %u)!\n",
-						__func__, skb->truesize);
-				dev_kfree_skb_any(skb);
-				goto out;	/* atm_charge increments rx_drop */
-			}
+		vdbg("%s: sending skb 0x%p, skb->len %u, skb->truesize %u",
+		     __func__, skb, skb->len, skb->truesize);
 
-			memcpy(skb->data, sarb->tail - pdu_length, length);
-			__skb_put(skb, length);
+		PACKETDEBUG(skb->data, skb->len);
 
-			vdbg("%s: sending skb 0x%p, skb->len %u, skb->truesize %u",
-			     __func__, skb, skb->len, skb->truesize);
+		vcc->push(vcc, skb);
 
-			PACKETDEBUG(skb->data, skb->len);
+		atomic_inc(&vcc->stats->rx);
+	out:
+		skb_trim(sarb, 0);
+	}
+}
 
-			vcc->push(vcc, skb);
+static void usbatm_extract_cells(struct usbatm_data *instance,
+		unsigned char *source, unsigned int avail_data)
+{
+	unsigned int stride = instance->rx_channel.stride;
+	unsigned int buf_usage = instance->buf_usage;
 
-			atomic_inc(&vcc->stats->rx);
-		out:
-			skb_trim(sarb, 0);
+	/* extract cells from incoming data, taking into account that
+	 * the length of avail data may not be a multiple of stride */
+
+	if (buf_usage > 0) {
+		/* we have a partially received atm cell */
+		unsigned char *cell_buf = instance->cell_buf;
+		unsigned int space_left = stride - buf_usage;
+
+		UDSL_ASSERT(buf_usage <= stride);
+
+		if (avail_data >= space_left) {
+			/* add new data and process cell */
+			memcpy(cell_buf + buf_usage, source, space_left);
+			source += space_left;
+			avail_data -= space_left;
+			usbatm_extract_one_cell(instance, cell_buf);
+			instance->buf_usage = 0;
+		} else {
+			/* not enough data to fill the cell */
+			memcpy(cell_buf + buf_usage, source, avail_data);
+			instance->buf_usage = buf_usage + avail_data;
+			return;
 		}
 	}
+
+	for (; avail_data >= stride; avail_data -= stride, source += stride)
+		usbatm_extract_one_cell(instance, source);
+
+	if (avail_data > 0) {
+		/* length was not a multiple of stride -
+		 * save remaining data for next call */
+		memcpy(instance->cell_buf, source, avail_data);
+		instance->buf_usage = avail_data;
+	}
 }
 
 
@@ -496,16 +529,40 @@
 		vdbg("%s: processing urb 0x%p", __func__, urb);
 
 		if (usb_pipeisoc(urb->pipe)) {
+			unsigned char *merge_start = NULL;
+			unsigned int merge_length = 0;
+			const unsigned int packet_size = instance->rx_channel.packet_size;
 			int i;
-			for (i = 0; i < urb->number_of_packets; i++)
-				if (!urb->iso_frame_desc[i].status)
-					usbatm_extract_cells(instance,
-							     (u8 *)urb->transfer_buffer + urb->iso_frame_desc[i].offset,
-							     urb->iso_frame_desc[i].actual_length);
-		}
-		else
+
+			for (i = 0; i < urb->number_of_packets; i++) {
+				if (!urb->iso_frame_desc[i].status) {
+					unsigned int actual_length = urb->iso_frame_desc[i].actual_length;
+
+					UDSL_ASSERT(actual_length <= packet_size);
+
+					if (!merge_length)
+						merge_start = (unsigned char *)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
+					merge_length += actual_length;
+					if (merge_length && (actual_length < packet_size)) {
+						usbatm_extract_cells(instance, merge_start, merge_length);
+						merge_length = 0;
+					}
+				} else {
+					atm_rldbg(instance, "%s: status %d in frame %d!\n", __func__, urb->status, i);
+					if (merge_length)
+						usbatm_extract_cells(instance, merge_start, merge_length);
+					merge_length = 0;
+					instance->buf_usage = 0;
+				}
+			}
+
+			if (merge_length)
+				usbatm_extract_cells(instance, merge_start, merge_length);
+		} else
 			if (!urb->status)
 				usbatm_extract_cells(instance, urb->transfer_buffer, urb->actual_length);
+			else
+				instance->buf_usage = 0;
 
 		if (usbatm_submit_urb(urb))
 			return;
@@ -797,6 +854,9 @@
 	vcc->dev_data = new;
 
 	tasklet_disable(&instance->rx_channel.tasklet);
+	instance->cached_vcc = new;
+	instance->cached_vpi = vpi;
+	instance->cached_vci = vci;
 	list_add(&new->list, &instance->vcc_list);
 	tasklet_enable(&instance->rx_channel.tasklet);
 
@@ -836,6 +896,11 @@
 	down(&instance->serialize);	/* vs self, usbatm_atm_open, usbatm_usb_disconnect */
 
 	tasklet_disable(&instance->rx_channel.tasklet);
+	if (instance->cached_vcc == vcc_data) {
+		instance->cached_vcc = NULL;
+		instance->cached_vpi = ATM_VPI_UNSPEC;
+		instance->cached_vci = ATM_VCI_UNSPEC;
+	}
 	list_del(&vcc_data->list);
 	tasklet_enable(&instance->rx_channel.tasklet);
 
@@ -1146,6 +1211,16 @@
 		     __func__, urb->transfer_buffer, urb->transfer_buffer_length, urb);
 	}
 
+	instance->cached_vpi = ATM_VPI_UNSPEC;
+	instance->cached_vci = ATM_VCI_UNSPEC;
+	instance->cell_buf = kmalloc(instance->rx_channel.stride, GFP_KERNEL);
+
+	if (!instance->cell_buf) {
+		dev_err(dev, "%s: no memory for cell buffer!\n", __func__);
+		error = -ENOMEM;
+		goto fail_unbind;
+	}
+
 	if (!(instance->flags & UDSL_SKIP_HEAVY_INIT) && driver->heavy_init) {
 		error = usbatm_heavy_init(instance);
 	} else {
@@ -1165,6 +1240,8 @@
 	if (instance->driver->unbind)
 		instance->driver->unbind(instance, intf);
  fail_free:
+	kfree(instance->cell_buf);
+
 	for (i = 0; i < num_rcv_urbs + num_snd_urbs; i++) {
 		if (instance->urbs[i])
 			kfree(instance->urbs[i]->transfer_buffer);
@@ -1236,6 +1313,8 @@
 		usb_free_urb(instance->urbs[i]);
 	}
 
+	kfree(instance->cell_buf);
+
 	/* ATM finalize */
 	if (instance->atm_dev)
 		atm_dev_deregister(instance->atm_dev);
Index: Linux/drivers/usb/atm/usbatm.h
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.h	2006-01-13 09:12:53.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.h	2006-01-13 09:25:43.000000000 +0100
@@ -187,6 +187,13 @@
 	struct sk_buff_head sndqueue;
 	struct sk_buff *current_skb;	/* being emptied */
 
+	struct usbatm_vcc_data *cached_vcc;
+	int cached_vci;
+	short cached_vpi;
+
+	unsigned char *cell_buf;	/* holds partial rx cell */
+	unsigned int buf_usage;
+
 	struct urb *urbs[0];
 };
 

--Boundary-00=_3u3xD2kLrKU2Yh2--
