Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbTCJJ2z>; Mon, 10 Mar 2003 04:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbTCJJ2y>; Mon, 10 Mar 2003 04:28:54 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.25]:6854 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261191AbTCJJ2w>; Mon, 10 Mar 2003 04:28:52 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-users@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: send path optimization
Date: Mon, 10 Mar 2003 10:38:52 +0100
User-Agent: KMail/1.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303101038.52069.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Write multiple cells in one function call, rather than one cell per
function call.  Under maximum send load, this reduces cell writing
CPU usage from 0.0095% to 0.0085% on my machine.  A 10% improvement! :)


 speedtouch.c |   68 +++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 41 insertions(+), 27 deletions(-)


diff -Nru a/drivers/usb/misc/speedtouch.c b/drivers/usb/misc/speedtouch.c
--- a/drivers/usb/misc/speedtouch.c	Mon Mar 10 10:35:23 2003
+++ b/drivers/usb/misc/speedtouch.c	Mon Mar 10 10:35:23 2003
@@ -273,39 +273,60 @@
 	ctrl->aal5_trailer [7] = crc;
 }
 
-static char *udsl_write_cell (struct sk_buff *skb, char *target) {
+unsigned int udsl_write_cells (unsigned int howmany, struct sk_buff *skb, unsigned char **target_p) {
 	struct udsl_control *ctrl = UDSL_SKB (skb);
+	unsigned char *target = *target_p;
+	unsigned int nc, ne, i;
 
-	ctrl->num_cells--;
+	dbg ("udsl_write_cells: howmany=%u, skb->len=%d, num_cells=%u, num_entire=%u, pdu_padding=%u", howmany, skb->len, ctrl->num_cells, ctrl->num_entire, ctrl->pdu_padding);
 
-	memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
-	target += ATM_CELL_HEADER;
+	nc = ctrl->num_cells;
+	ne = min (howmany, ctrl->num_entire);
 
-	if (ctrl->num_entire) {
-		ctrl->num_entire--;
+	for (i = 0; i < ne; i++) {
+		memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
+		target += ATM_CELL_HEADER;
 		memcpy (target, skb->data, ATM_CELL_PAYLOAD);
 		target += ATM_CELL_PAYLOAD;
 		__skb_pull (skb, ATM_CELL_PAYLOAD);
-		return target;
 	}
 
+	ctrl->num_entire -= ne;
+
+	if (!(ctrl->num_cells -= ne) || !(howmany -= ne))
+		goto out;
+
+	memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
+	target += ATM_CELL_HEADER;
 	memcpy (target, skb->data, skb->len);
 	target += skb->len;
 	__skb_pull (skb, skb->len);
-
 	memset (target, 0, ctrl->pdu_padding);
 	target += ctrl->pdu_padding;
 
-	if (ctrl->num_cells) {
-		ctrl->pdu_padding = ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER;
-	} else {
-		memcpy (target, ctrl->aal5_trailer, ATM_AAL5_TRAILER);
-		target += ATM_AAL5_TRAILER;
-		/* set pti bit in last cell */
-		*(target + 3 - ATM_CELL_SIZE) |= 0x2;
+	if (--ctrl->num_cells) {
+		if (!--howmany) {
+			ctrl->pdu_padding = ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER;
+			goto out;
+		}
+
+		memcpy (target, ctrl->cell_header, ATM_CELL_HEADER);
+		target += ATM_CELL_HEADER;
+		memset (target, 0, ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER);
+		target += ATM_CELL_PAYLOAD - ATM_AAL5_TRAILER;
+
+		if (--ctrl->num_cells)
+			BUG();
 	}
 
-	return target;
+	memcpy (target, ctrl->aal5_trailer, ATM_AAL5_TRAILER);
+	target += ATM_AAL5_TRAILER;
+	/* set pti bit in last cell */
+	*(target + 3 - ATM_CELL_SIZE) |= 0x2;
+
+out:
+	*target_p = target;
+	return nc - ctrl->num_cells;
 }
 
 
@@ -500,14 +521,12 @@
 static void udsl_process_send (unsigned long data)
 {
 	struct udsl_send_buffer *buf;
-	unsigned int cells_to_write;
 	int err;
 	unsigned long flags;
-	unsigned int i;
 	struct udsl_instance_data *instance = (struct udsl_instance_data *) data;
+	unsigned int num_written;
 	struct sk_buff *skb;
 	struct udsl_sender *snd;
-	unsigned char *target;
 
 	dbg ("udsl_process_send entered");
 
@@ -577,16 +596,11 @@
 		instance->current_buffer = buf;
 	}
 
-	cells_to_write = min (buf->free_cells, UDSL_SKB (skb)->num_cells);
-	target = buf->free_start;
-
-	dbg ("writing %u cells from skb 0x%p to buffer 0x%p", cells_to_write, skb, buf);
+	num_written = udsl_write_cells (buf->free_cells, skb, &buf->free_start);
 
-	for (i = 0; i < cells_to_write; i++)
-		target = udsl_write_cell (skb, target);
+	dbg ("wrote %u cells from skb 0x%p to buffer 0x%p", num_written, skb, buf);
 
-	buf->free_start = target;
-	if (!(buf->free_cells -= cells_to_write)) {
+	if (!(buf->free_cells -= num_written)) {
 		list_add_tail (&buf->list, &instance->filled_buffers);
 		instance->current_buffer = NULL;
 		dbg ("queued filled buffer");

