Return-Path: <linux-kernel-owner+w=401wt.eu-S1762520AbWLJTWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762520AbWLJTWA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762613AbWLJTWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:22:00 -0500
Received: from lx1.pxnet.com ([195.227.45.3]:51620 "EHLO lx1.pxnet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762520AbWLJTV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:21:58 -0500
Date: Sun, 10 Dec 2006 20:21:38 +0100
From: Tilman Schmidt <tilman@imap.cc>
To: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Hansjoerg Lipp <hjlipp@web.de>
Subject: [Patch] isdn/gigaset: fix possible missing wakeup
Message-ID: <20061210204138.tilman@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tilman Schmidt <tilman@imap.cc>

This patch to the isdn4linux Siemens Gigaset Base driver elliminates
some possibilities for user processes writing to the Gigaset character
device to be left sleeping indefinitely, by adding wakeup calls to
error paths and properly disposing of pending write requests when the
device is disconnected.

It also removes unnecessary NULL checks before usb_free_urb() and
usb_kill_urb() calls.

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
---

 bas-gigaset.c |  118 +++++++++++++++++++++++++---------------------------------
 1 files changed, 52 insertions(+), 66 deletions(-)

--- linux-2.6.19/drivers/isdn/gigaset/bas-gigaset.c	2006-12-10 13:37:45.000000000 +0100
+++ linux-2.6.19-work/drivers/isdn/gigaset/bas-gigaset.c	2006-12-10 14:01:25.000000000 +0100
@@ -1853,20 +1853,24 @@ static int gigaset_write_cmd(struct card
 {
 	struct cmdbuf_t *cb;
 	unsigned long flags;
-	int status;
+	int rc;
 
 	gigaset_dbg_buffer(atomic_read(&cs->mstate) != MS_LOCKED ?
 			     DEBUG_TRANSCMD : DEBUG_LOCKCMD,
 			   "CMD Transmit", len, buf);
 
-	if (len <= 0)
-		return 0;			/* nothing to do */
+	if (len <= 0) {
+		/* nothing to do */
+		rc = 0;
+		goto notqueued;
+	}
 
 	if (len > IF_WRITEBUF)
 		len = IF_WRITEBUF;
 	if (!(cb = kmalloc(sizeof(struct cmdbuf_t) + len, GFP_ATOMIC))) {
 		dev_err(cs->dev, "%s: out of memory\n", __func__);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto notqueued;
 	}
 
 	memcpy(cb->buf, buf, len);
@@ -1891,11 +1895,21 @@ static int gigaset_write_cmd(struct card
 	if (unlikely(!cs->connected)) {
 		spin_unlock_irqrestore(&cs->lock, flags);
 		gig_dbg(DEBUG_USBREQ, "%s: not connected", __func__);
+		/* flush command queue */
+		spin_lock_irqsave(&cs->cmdlock, flags);
+		while (cs->cmdbuf != NULL)
+			complete_cb(cs);
+		spin_unlock_irqrestore(&cs->cmdlock, flags);
 		return -ENODEV;
 	}
-	status = start_cbsend(cs);
+	rc = start_cbsend(cs);
 	spin_unlock_irqrestore(&cs->lock, flags);
-	return status < 0 ? status : len;
+	return rc < 0 ? rc : len;
+
+notqueued:			/* request handled without queuing */
+	if (wake_tasklet)
+		tasklet_schedule(wake_tasklet);
+	return rc;
 }
 
 /* gigaset_write_room
@@ -1978,20 +1978,15 @@ static int gigaset_freebcshw(struct bc_s
 
 	/* kill URBs and tasklets before freeing - better safe than sorry */
 	atomic_set(&ubc->running, 0);
-	for (i = 0; i < BAS_OUTURBS; ++i)
-		if (ubc->isoouturbs[i].urb) {
-			gig_dbg(DEBUG_INIT, "%s: killing iso out URB %d",
-				__func__, i);
-			usb_kill_urb(ubc->isoouturbs[i].urb);
-			usb_free_urb(ubc->isoouturbs[i].urb);
-		}
-	for (i = 0; i < BAS_INURBS; ++i)
-		if (ubc->isoinurbs[i]) {
-			gig_dbg(DEBUG_INIT, "%s: killing iso in URB %d",
-				__func__, i);
-			usb_kill_urb(ubc->isoinurbs[i]);
-			usb_free_urb(ubc->isoinurbs[i]);
-		}
+	gig_dbg(DEBUG_INIT, "%s: killing iso URBs", __func__);
+	for (i = 0; i < BAS_OUTURBS; ++i) {
+		usb_kill_urb(ubc->isoouturbs[i].urb);
+		usb_free_urb(ubc->isoouturbs[i].urb);
+	}
+	for (i = 0; i < BAS_INURBS; ++i) {
+		usb_kill_urb(ubc->isoinurbs[i]);
+		usb_free_urb(ubc->isoinurbs[i]);
+	}
 	tasklet_kill(&ubc->sent_tasklet);
 	tasklet_kill(&ubc->rcvd_tasklet);
 	kfree(ubc->isooutbuf);
@@ -2113,55 +2108,32 @@ static void freeurbs(struct cardstate *c
 	struct bas_bc_state *ubc;
 	int i, j;
 
+	gig_dbg(DEBUG_INIT, "%s: killing URBs", __func__);
 	for (j = 0; j < 2; ++j) {
 		ubc = cs->bcs[j].hw.bas;
-		for (i = 0; i < BAS_OUTURBS; ++i)
-			if (ubc->isoouturbs[i].urb) {
-				usb_kill_urb(ubc->isoouturbs[i].urb);
-				gig_dbg(DEBUG_INIT,
-					"%s: isoc output URB %d/%d unlinked",
-					__func__, j, i);
-				usb_free_urb(ubc->isoouturbs[i].urb);
-				ubc->isoouturbs[i].urb = NULL;
-			}
-		for (i = 0; i < BAS_INURBS; ++i)
-			if (ubc->isoinurbs[i]) {
-				usb_kill_urb(ubc->isoinurbs[i]);
-				gig_dbg(DEBUG_INIT,
-					"%s: isoc input URB %d/%d unlinked",
-					__func__, j, i);
-				usb_free_urb(ubc->isoinurbs[i]);
-				ubc->isoinurbs[i] = NULL;
-			}
-	}
-	if (ucs->urb_int_in) {
-		usb_kill_urb(ucs->urb_int_in);
-		gig_dbg(DEBUG_INIT, "%s: interrupt input URB unlinked",
-			__func__);
-		usb_free_urb(ucs->urb_int_in);
-		ucs->urb_int_in = NULL;
-	}
-	if (ucs->urb_cmd_out) {
-		usb_kill_urb(ucs->urb_cmd_out);
-		gig_dbg(DEBUG_INIT, "%s: command output URB unlinked",
-			__func__);
-		usb_free_urb(ucs->urb_cmd_out);
-		ucs->urb_cmd_out = NULL;
-	}
-	if (ucs->urb_cmd_in) {
-		usb_kill_urb(ucs->urb_cmd_in);
-		gig_dbg(DEBUG_INIT, "%s: command input URB unlinked",
-			__func__);
-		usb_free_urb(ucs->urb_cmd_in);
-		ucs->urb_cmd_in = NULL;
-	}
-	if (ucs->urb_ctrl) {
-		usb_kill_urb(ucs->urb_ctrl);
-		gig_dbg(DEBUG_INIT, "%s: control output URB unlinked",
-			__func__);
-		usb_free_urb(ucs->urb_ctrl);
-		ucs->urb_ctrl = NULL;
+		for (i = 0; i < BAS_OUTURBS; ++i) {
+			usb_kill_urb(ubc->isoouturbs[i].urb);
+			usb_free_urb(ubc->isoouturbs[i].urb);
+			ubc->isoouturbs[i].urb = NULL;
+		}
+		for (i = 0; i < BAS_INURBS; ++i) {
+			usb_kill_urb(ubc->isoinurbs[i]);
+			usb_free_urb(ubc->isoinurbs[i]);
+			ubc->isoinurbs[i] = NULL;
+		}
 	}
+	usb_kill_urb(ucs->urb_int_in);
+	usb_free_urb(ucs->urb_int_in);
+	ucs->urb_int_in = NULL;
+	usb_kill_urb(ucs->urb_cmd_out);
+	usb_free_urb(ucs->urb_cmd_out);
+	ucs->urb_cmd_out = NULL;
+	usb_kill_urb(ucs->urb_cmd_in);
+	usb_free_urb(ucs->urb_cmd_in);
+	ucs->urb_cmd_in = NULL;
+	usb_kill_urb(ucs->urb_ctrl);
+	usb_free_urb(ucs->urb_ctrl);
+	ucs->urb_ctrl = NULL;
 }
 
 /* gigaset_probe
