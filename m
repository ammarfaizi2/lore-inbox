Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbUJ0Sxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUJ0Sxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUJ0SxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:53:07 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37785 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262589AbUJ0Soh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:44:37 -0400
Subject: [resend patch] HVSI reset support
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Content-Type: text/plain
Message-Id: <1098884404.3484.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 27 Oct 2004 13:40:04 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, I've retested this with current BK as you requested.

This patch adds support for when the service processor (the
other end of the console) resets due to a critical error; we can resume
the connection when it comes back. Please apply.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

-- 
Hollis Blanchard
IBM Linux Technology Center

--- drivers/char/hvsi.c.orig	Mon Sep 13 19:23:15 2004
+++ drivers/char/hvsi.c	Wed Oct 20 17:10:34 2004
@@ -29,11 +29,6 @@
  * the OS cannot change the speed of the port through this protocol.
  */
 
-/* TODO:
- * test FSP reset
- * add udbg support for xmon/kdb
- */
-
 #undef DEBUG
 
 #include <linux/console.h>
@@ -54,6 +49,7 @@
 #include <asm/prom.h>
 #include <asm/uaccess.h>
 #include <asm/vio.h>
+#include <asm/param.h>
 
 #define HVSI_MAJOR	229
 #define HVSI_MINOR	128
@@ -74,6 +70,7 @@
 
 struct hvsi_struct {
 	struct work_struct writer;
+	struct work_struct handshaker;
 	wait_queue_head_t emptyq; /* woken when outbuf is emptied */
 	wait_queue_head_t stateq; /* woken when HVSI state changes */
 	spinlock_t lock;
@@ -109,6 +106,7 @@
 	HVSI_WAIT_FOR_VER_QUERY,
 	HVSI_OPEN,
 	HVSI_WAIT_FOR_MCTRL_RESPONSE,
+	HVSI_FSP_DIED,
 };
 #define HVSI_CONSOLE 0x1
 
@@ -172,6 +170,13 @@
 	} u;
 } __attribute__((packed));
 
+
+
+static inline int is_console(struct hvsi_struct *hp)
+{
+	return hp->flags & HVSI_CONSOLE;
+}
+
 static inline int is_open(struct hvsi_struct *hp)
 {
 	/* if we're waiting for an mctrl then we're already open */
@@ -188,6 +193,7 @@
 		"HVSI_WAIT_FOR_VER_QUERY",
 		"HVSI_OPEN",
 		"HVSI_WAIT_FOR_MCTRL_RESPONSE",
+		"HVSI_FSP_DIED",
 	};
 	const char *name = state_names[hp->state];
 
@@ -296,14 +302,9 @@
 	return 0;
 }
 
-/*
- * we can't call tty_hangup() directly here because we need to call that
- * outside of our lock
- */
-static struct tty_struct *hvsi_recv_control(struct hvsi_struct *hp,
-		uint8_t *packet)
+static void hvsi_recv_control(struct hvsi_struct *hp, uint8_t *packet,
+	struct tty_struct **to_hangup, struct hvsi_struct **to_handshake)
 {
-	struct tty_struct *to_hangup = NULL;
 	struct hvsi_control *header = (struct hvsi_control *)packet;
 
 	switch (header->verb) {
@@ -313,15 +314,14 @@
 				pr_debug("hvsi%i: CD dropped\n", hp->index);
 				hp->mctrl &= TIOCM_CD;
 				if (!(hp->tty->flags & CLOCAL))
-					to_hangup = hp->tty;
+					*to_hangup = hp->tty;
 			}
 			break;
 		case VSV_CLOSE_PROTOCOL:
-			printk(KERN_DEBUG
-				"hvsi%i: service processor closed connection!\n", hp->index);
-			__set_state(hp, HVSI_CLOSED);
-			to_hangup = hp->tty;
-			hp->tty = NULL;
+			pr_debug("hvsi%i: service processor came back\n", hp->index);
+			if (hp->state != HVSI_CLOSED) {
+				*to_handshake = hp;
+			}
 			break;
 		default:
 			printk(KERN_WARNING "hvsi%i: unknown HVSI control packet: ",
@@ -329,8 +329,6 @@
 			dump_packet(packet);
 			break;
 	}
-
-	return to_hangup;
 }
 
 static void hvsi_recv_response(struct hvsi_struct *hp, uint8_t *packet)
@@ -388,8 +386,8 @@
 
 	switch (hp->state) {
 		case HVSI_WAIT_FOR_VER_QUERY:
-			__set_state(hp, HVSI_OPEN);
 			hvsi_version_respond(hp, query->seqno);
+			__set_state(hp, HVSI_OPEN);
 			break;
 		default:
 			printk(KERN_ERR "hvsi%i: unexpected query: ", hp->index);
@@ -467,17 +465,20 @@
  * incoming data).
  */
 static int hvsi_load_chunk(struct hvsi_struct *hp, struct tty_struct **flip,
-		struct tty_struct **hangup)
+		struct tty_struct **hangup, struct hvsi_struct **handshake)
 {
 	uint8_t *packet = hp->inbuf;
 	int chunklen;
 
 	*flip = NULL;
 	*hangup = NULL;
+	*handshake = NULL;
 
 	chunklen = hvsi_read(hp, hp->inbuf_end, HVSI_MAX_READ);
-	if (chunklen == 0)
+	if (chunklen == 0) {
+		pr_debug("%s: 0-length read\n", __FUNCTION__);
 		return 0;
+	}
 
 	pr_debug("%s: got %i bytes\n", __FUNCTION__, chunklen);
 	dbg_dump_hex(hp->inbuf_end, chunklen);
@@ -509,7 +510,7 @@
 				*flip = hvsi_recv_data(hp, packet);
 				break;
 			case VS_CONTROL_PACKET_HEADER:
-				*hangup = hvsi_recv_control(hp, packet);
+				hvsi_recv_control(hp, packet, hangup, handshake);
 				break;
 			case VS_QUERY_RESPONSE_PACKET_HEADER:
 				hvsi_recv_response(hp, packet);
@@ -526,8 +527,8 @@
 
 		packet += len_packet(packet);
 
-		if (*hangup) {
-			pr_debug("%s: hangup\n", __FUNCTION__);
+		if (*hangup || *handshake) {
+			pr_debug("%s: hangup or handshake\n", __FUNCTION__);
 			/*
 			 * we need to send the hangup now before receiving any more data.
 			 * If we get "data, hangup, data", we can't deliver the second
@@ -560,16 +561,15 @@
 	struct hvsi_struct *hp = (struct hvsi_struct *)arg;
 	struct tty_struct *flip;
 	struct tty_struct *hangup;
+	struct hvsi_struct *handshake;
 	unsigned long flags;
-	irqreturn_t handled = IRQ_NONE;
 	int again = 1;
 
 	pr_debug("%s\n", __FUNCTION__);
 
 	while (again) {
 		spin_lock_irqsave(&hp->lock, flags);
-		again = hvsi_load_chunk(hp, &flip, &hangup);
-		handled = IRQ_HANDLED;
+		again = hvsi_load_chunk(hp, &flip, &hangup, &handshake);
 		spin_unlock_irqrestore(&hp->lock, flags);
 
 		/*
@@ -587,6 +587,11 @@
 		if (hangup) {
 			tty_hangup(hangup);
 		}
+
+		if (handshake) {
+			pr_debug("hvsi%i: attempting re-handshake\n", handshake->index);
+			schedule_work(&handshake->handshaker);
+		}
 	}
 
 	spin_lock_irqsave(&hp->lock, flags);
@@ -603,7 +608,7 @@
 		tty_flip_buffer_push(flip);
 	}
 
-	return handled;
+	return IRQ_HANDLED;
 }
 
 /* for boot console, before the irq handler is running */
@@ -757,6 +762,23 @@
 	return 0;
 }
 
+static void hvsi_handshaker(void *arg)
+{
+	struct hvsi_struct *hp = (struct hvsi_struct *)arg;
+
+	if (hvsi_handshake(hp) >= 0)
+		return;
+
+	printk(KERN_ERR "hvsi%i: re-handshaking failed\n", hp->index);
+	if (is_console(hp)) {
+		/*
+		 * ttys will re-attempt the handshake via hvsi_open, but
+		 * the console will not.
+		 */
+		printk(KERN_ERR "hvsi%i: lost console!\n", hp->index);
+	}
+}
+
 static int hvsi_put_chars(struct hvsi_struct *hp, const char *buf, int count)
 {
 	struct hvsi_data packet __ALIGNED__;
@@ -808,6 +830,10 @@
 	tty->driver_data = hp;
 	tty->low_latency = 1; /* avoid throttle/tty_flip_buffer_push race */
 
+	mb();
+	if (hp->state == HVSI_FSP_DIED)
+		return -EIO;
+
 	spin_lock_irqsave(&hp->lock, flags);
 	hp->tty = tty;
 	hp->count++;
@@ -815,7 +841,7 @@
 	h_vio_signal(hp->vtermno, VIO_IRQ_ENABLE);
 	spin_unlock_irqrestore(&hp->lock, flags);
 
-	if (hp->flags & HVSI_CONSOLE)
+	if (is_console(hp))
 		return 0; /* this has already been handshaked as the console */
 
 	ret = hvsi_handshake(hp);
@@ -889,7 +915,7 @@
 		hp->inbuf_end = hp->inbuf; /* discard remaining partial packets */
 
 		/* only close down connection if it is not the console */
-		if (!(hp->flags & HVSI_CONSOLE)) {
+		if (!is_console(hp)) {
 			h_vio_signal(hp->vtermno, VIO_IRQ_DISABLE); /* no more irqs */
 			__set_state(hp, HVSI_CLOSED);
 			/*
@@ -943,12 +969,13 @@
 		return;
 
 	n = hvsi_put_chars(hp, hp->outbuf, hp->n_outbuf);
-	if (n != 0) {
-		/*
-		 * either all data was sent or there was an error, and we throw away
-		 * data on error.
-		 */
+	if (n > 0) {
+		/* success */
+		pr_debug("%s: wrote %i chars\n", __FUNCTION__, n);
 		hp->n_outbuf = 0;
+	} else if (n == -EIO) {
+		__set_state(hp, HVSI_FSP_DIED);
+		printk(KERN_ERR "hvsi%i: service processor died\n", hp->index);
 	}
 }
 
@@ -966,6 +993,19 @@
 
 	spin_lock_irqsave(&hp->lock, flags);
 
+	pr_debug("%s: %i chars in buffer\n", __FUNCTION__, hp->n_outbuf);
+
+	if (!is_open(hp)) {
+		/*
+		 * We could have a non-open connection if the service processor died
+		 * while we were busily scheduling ourselves. In that case, it could
+		 * be minutes before the service processor comes back, so only try
+		 * again once a second.
+		 */
+		schedule_delayed_work(&hp->writer, HZ);
+		goto out;
+	}
+
 	hvsi_push(hp);
 	if (hp->n_outbuf > 0)
 		schedule_delayed_work(&hp->writer, 10);
@@ -982,6 +1022,7 @@
 		wake_up_interruptible(&hp->tty->write_wait);
 	}
 
+out:
 	spin_unlock_irqrestore(&hp->lock, flags);
 }
 
@@ -1022,6 +1063,8 @@
 
 	spin_lock_irqsave(&hp->lock, flags);
 
+	pr_debug("%s: %i chars in buffer\n", __FUNCTION__, hp->n_outbuf);
+
 	if (!is_open(hp)) {
 		/* we're either closing or not yet open; don't accept data */
 		pr_debug("%s: not open\n", __FUNCTION__);
@@ -1294,6 +1337,7 @@
 
 		hp = &hvsi_ports[hvsi_count];
 		INIT_WORK(&hp->writer, hvsi_write_worker, hp);
+		INIT_WORK(&hp->handshaker, hvsi_handshaker, hp);
 		init_waitqueue_head(&hp->emptyq);
 		init_waitqueue_head(&hp->stateq);
 		hp->lock = SPIN_LOCK_UNLOCKED;


