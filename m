Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVIQVwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVIQVwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVIQVwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 17:52:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:33155 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751207AbVIQVwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 17:52:42 -0400
Date: Sat, 17 Sep 2005 23:52:42 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ST 5481 USB driver
Message-ID: <20050917215242.GA27813@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ST 5481 USB driver

The old driver was not fully adapted to new USB ABI and does not
work.

Signed-off-by: Karsten Keil <kkeil@suse.de>

---

 drivers/isdn/hisax/st5481.h      |    4 +-
 drivers/isdn/hisax/st5481_b.c    |   22 ++++++++----
 drivers/isdn/hisax/st5481_d.c    |   26 ++++++++------
 drivers/isdn/hisax/st5481_init.c |    4 +-
 drivers/isdn/hisax/st5481_usb.c  |   70 +++++++++++++++++++++++---------------
 5 files changed, 76 insertions(+), 50 deletions(-)

0677b284b827fbac20961037982f2a6459a827a8
diff --git a/drivers/isdn/hisax/st5481.h b/drivers/isdn/hisax/st5481.h
--- a/drivers/isdn/hisax/st5481.h
+++ b/drivers/isdn/hisax/st5481.h
@@ -466,10 +466,10 @@ void st5481_stop(struct st5481_adapter *
 #define __debug_variable st5481_debug
 #include "hisax_debug.h"
 
-#ifdef CONFIG_HISAX_DEBUG
-
 extern int st5481_debug;
 
+#ifdef CONFIG_HISAX_DEBUG
+
 #define DBG_ISO_PACKET(level,urb) \
   if (level & __debug_variable) dump_iso_packet(__FUNCTION__,urb)
 
diff --git a/drivers/isdn/hisax/st5481_b.c b/drivers/isdn/hisax/st5481_b.c
--- a/drivers/isdn/hisax/st5481_b.c
+++ b/drivers/isdn/hisax/st5481_b.c
@@ -172,14 +172,18 @@ static void usb_b_out_complete(struct ur
 	test_and_clear_bit(buf_nr, &b_out->busy);
 
 	if (unlikely(urb->status < 0)) {
-		if (urb->status != -ENOENT && urb->status != -ESHUTDOWN) {
-			WARN("urb status %d",urb->status);
-			if (b_out->busy == 0) {
-				st5481_usb_pipe_reset(adapter, (bcs->channel+1)*2 | USB_DIR_OUT, NULL, NULL);
-			}
-		} else {
-			DBG(1,"urb killed"); 
-			return; // Give up
+		switch (urb->status) {
+			case -ENOENT:
+			case -ESHUTDOWN:
+			case -ECONNRESET:
+				DBG(4,"urb killed status %d", urb->status);
+				return; // Give up
+			default: 
+				WARN("urb status %d",urb->status);
+				if (b_out->busy == 0) {
+					st5481_usb_pipe_reset(adapter, (bcs->channel+1)*2 | USB_DIR_OUT, NULL, NULL);
+				}
+				break;
 		}
 	}
 
@@ -205,7 +209,9 @@ static void st5481B_mode(struct st5481_b
 	bcs->mode = mode;
 
 	// Cancel all USB transfers on this B channel
+	b_out->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(b_out->urb[0]);
+	b_out->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(b_out->urb[1]);
 	b_out->busy = 0;
 
diff --git a/drivers/isdn/hisax/st5481_d.c b/drivers/isdn/hisax/st5481_d.c
--- a/drivers/isdn/hisax/st5481_d.c
+++ b/drivers/isdn/hisax/st5481_d.c
@@ -382,16 +382,20 @@ static void usb_d_out_complete(struct ur
 	test_and_clear_bit(buf_nr, &d_out->busy);
 
 	if (unlikely(urb->status < 0)) {
-		if (urb->status != -ENOENT && urb->status != -ESHUTDOWN) {
-			WARN("urb status %d",urb->status);
-			if (d_out->busy == 0) {
-				st5481_usb_pipe_reset(adapter, EP_D_OUT | USB_DIR_OUT, fifo_reseted, adapter);
-			}
-			return;
-		} else {
-			DBG(1,"urb killed"); 
-			return; // Give up
+		switch (urb->status) {
+			case -ENOENT:
+			case -ESHUTDOWN:
+			case -ECONNRESET:
+				DBG(1,"urb killed status %d", urb->status);
+				break;
+			default: 
+				WARN("urb status %d",urb->status);
+				if (d_out->busy == 0) {
+					st5481_usb_pipe_reset(adapter, EP_D_OUT | USB_DIR_OUT, fifo_reseted, adapter);
+				}
+				break;
 		}
+		return; // Give up
 	}
 
 	FsmEvent(&adapter->d_out.fsm, EV_DOUT_COMPLETE, (void *) buf_nr);
@@ -709,14 +713,14 @@ int st5481_setup_d(struct st5481_adapter
 
 	adapter->l1m.fsm = &l1fsm;
 	adapter->l1m.state = ST_L1_F3;
-	adapter->l1m.debug = 1;
+	adapter->l1m.debug = st5481_debug & 0x100;
 	adapter->l1m.userdata = adapter;
 	adapter->l1m.printdebug = l1m_debug;
 	FsmInitTimer(&adapter->l1m, &adapter->timer);
 
 	adapter->d_out.fsm.fsm = &dout_fsm;
 	adapter->d_out.fsm.state = ST_DOUT_NONE;
-	adapter->d_out.fsm.debug = 1;
+	adapter->d_out.fsm.debug = st5481_debug & 0x100;
 	adapter->d_out.fsm.userdata = adapter;
 	adapter->d_out.fsm.printdebug = dout_debug;
 
diff --git a/drivers/isdn/hisax/st5481_init.c b/drivers/isdn/hisax/st5481_init.c
--- a/drivers/isdn/hisax/st5481_init.c
+++ b/drivers/isdn/hisax/st5481_init.c
@@ -43,10 +43,10 @@ static int number_of_leds = 2;       /* 
 module_param(number_of_leds, int, 0);
 
 #ifdef CONFIG_HISAX_DEBUG
-static int debug = 0x1;
+static int debug = 0;
 module_param(debug, int, 0);
-int st5481_debug;
 #endif
+int st5481_debug;
 
 static LIST_HEAD(adapter_list);
 
diff --git a/drivers/isdn/hisax/st5481_usb.c b/drivers/isdn/hisax/st5481_usb.c
--- a/drivers/isdn/hisax/st5481_usb.c
+++ b/drivers/isdn/hisax/st5481_usb.c
@@ -132,11 +132,15 @@ static void usb_ctrl_complete(struct urb
 	struct ctrl_msg *ctrl_msg;
 	
 	if (unlikely(urb->status < 0)) {
-		if (urb->status != -ENOENT && urb->status != -ESHUTDOWN) {
-			WARN("urb status %d",urb->status);
-		} else {
-			DBG(1,"urb killed");
-			return; // Give up
+		switch (urb->status) {
+			case -ENOENT:
+			case -ESHUTDOWN:
+			case -ECONNRESET:
+				DBG(1,"urb killed status %d", urb->status);
+				return; // Give up
+			default: 
+				WARN("urb status %d",urb->status);
+				break;
 		}
 	}
 
@@ -184,22 +188,22 @@ static void usb_int_complete(struct urb 
 	int status;
 
 	switch (urb->status) {
-	case 0:
-		/* success */
-		break;
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/* this urb is terminated, clean up */
-		DBG(1, "urb shutting down with status: %d", urb->status);
-		return;
-	default:
-		WARN("nonzero urb status received: %d", urb->status);
-		goto exit;
+		case 0:
+			/* success */
+			break;
+		case -ECONNRESET:
+		case -ENOENT:
+		case -ESHUTDOWN:
+			/* this urb is terminated, clean up */
+			DBG(2, "urb shutting down with status: %d", urb->status);
+			return;
+		default:
+			WARN("nonzero urb status received: %d", urb->status);
+			goto exit;
 	}
 
 	
-	DBG_PACKET(1, data, INT_PKT_SIZE);
+	DBG_PACKET(2, data, INT_PKT_SIZE);
 		
 	if (urb->actual_length == 0) {
 		goto exit;
@@ -250,7 +254,7 @@ int st5481_setup_usb(struct st5481_adapt
 	struct urb *urb;
 	u8 *buf;
 	
-	DBG(1,"");
+	DBG(2,"");
 	
 	if ((status = usb_reset_configuration (dev)) < 0) {
 		WARN("reset_configuration failed,status=%d",status);
@@ -330,15 +334,17 @@ void st5481_release_usb(struct st5481_ad
 	DBG(1,"");
 
 	// Stop and free Control and Interrupt URBs
-	usb_unlink_urb(ctrl->urb);
+	usb_kill_urb(ctrl->urb);
 	if (ctrl->urb->transfer_buffer)
 		kfree(ctrl->urb->transfer_buffer);
 	usb_free_urb(ctrl->urb);
+	ctrl->urb = NULL;
 
-	usb_unlink_urb(intr->urb);
+	usb_kill_urb(intr->urb);
 	if (intr->urb->transfer_buffer)
 		kfree(intr->urb->transfer_buffer);
 	usb_free_urb(intr->urb);
+	ctrl->urb = NULL;
 }
 
 /*
@@ -406,6 +412,7 @@ fill_isoc_urb(struct urb *urb, struct us
 	spin_lock_init(&urb->lock);
 	urb->dev=dev;
 	urb->pipe=pipe;
+	urb->interval = 1;
 	urb->transfer_buffer=buf;
 	urb->number_of_packets = num_packets;
 	urb->transfer_buffer_length=num_packets*packet_size;
@@ -452,7 +459,9 @@ st5481_setup_isocpipes(struct urb* urb[2
 		if (urb[j]) {
 			if (urb[j]->transfer_buffer)
 				kfree(urb[j]->transfer_buffer);
+			urb[j]->transfer_buffer = NULL;
 			usb_free_urb(urb[j]);
+			urb[j] = NULL;
 		}
 	}
 	return retval;
@@ -463,10 +472,11 @@ void st5481_release_isocpipes(struct urb
 	int j;
 
 	for (j = 0; j < 2; j++) {
-		usb_unlink_urb(urb[j]);
+		usb_kill_urb(urb[j]);
 		if (urb[j]->transfer_buffer)
 			kfree(urb[j]->transfer_buffer);			
 		usb_free_urb(urb[j]);
+		urb[j] = NULL;
 	}
 }
 
@@ -485,11 +495,15 @@ static void usb_in_complete(struct urb *
 	int len, count, status;
 
 	if (unlikely(urb->status < 0)) {
-		if (urb->status != -ENOENT && urb->status != -ESHUTDOWN) {
-			WARN("urb status %d",urb->status);
-		} else {
-			DBG(1,"urb killed");
-			return; // Give up
+		switch (urb->status) {
+			case -ENOENT:
+			case -ESHUTDOWN:
+			case -ECONNRESET:
+				DBG(1,"urb killed status %d", urb->status);
+				return; // Give up
+			default: 
+				WARN("urb status %d",urb->status);
+				break;
 		}
 	}
 
@@ -631,7 +645,9 @@ void st5481_in_mode(struct st5481_in *in
 
 	in->mode = mode;
 
+	in->urb[0]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(in->urb[0]);
+	in->urb[1]->transfer_flags |= URB_ASYNC_UNLINK;
 	usb_unlink_urb(in->urb[1]);
 
 	if (in->mode != L1_MODE_NULL) {

-- 
Karsten Keil
SuSE Labs
ISDN development
