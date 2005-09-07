Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVIGQga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVIGQga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVIGQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:36:30 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:36075 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751244AbVIGQg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:36:29 -0400
Date: Wed, 7 Sep 2005 18:36:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] s390: flip buffer fixes.
Message-ID: <20050907163628.GA2442@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] s390: flip buffer fixes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Make use of the new flip buffer interface for the s390 specific
console device drivers (3215, sclp, vt220 sclp and ctctty).

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/con3215.c    |   25 ++++++++-----------------
 drivers/s390/char/sclp_tty.c   |   21 ++++++++-------------
 drivers/s390/char/sclp_vt220.c |   12 ++----------
 drivers/s390/net/ctctty.c      |   28 +++++++---------------------
 4 files changed, 25 insertions(+), 61 deletions(-)

diff -urpN linux-2.6.13-mm1/drivers/s390/char/con3215.c linux-2.6.13-flip/drivers/s390/char/con3215.c
--- linux-2.6.13-mm1/drivers/s390/char/con3215.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-flip/drivers/s390/char/con3215.c	2005-09-07 12:39:58.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/vt_kern.h>
 #include <linux/init.h>
 #include <linux/console.h>
@@ -432,8 +433,6 @@ raw3215_irq(struct ccw_device *cdev, uns
 				if (count > slen)
 					count = slen;
 			} else
-			if (count >= TTY_FLIPBUF_SIZE - tty->flip.count)
-				count = TTY_FLIPBUF_SIZE - tty->flip.count - 1;
 			EBCASC(raw->inbuf, count);
 			cchar = ctrlchar_handle(raw->inbuf, count, tty);
 			switch (cchar & CTRLCHAR_MASK) {
@@ -441,28 +440,20 @@ raw3215_irq(struct ccw_device *cdev, uns
 				break;
 
 			case CTRLCHAR_CTRL:
-				tty->flip.count++;
-				*tty->flip.flag_buf_ptr++ = TTY_NORMAL;
-				*tty->flip.char_buf_ptr++ = cchar;
+				tty_insert_flip_char(tty, cchar, TTY_NORMAL);
 				tty_flip_buffer_push(raw->tty);
 				break;
 
 			case CTRLCHAR_NONE:
-				memcpy(tty->flip.char_buf_ptr,
-				       raw->inbuf, count);
 				if (count < 2 ||
-				    (strncmp(raw->inbuf+count-2, "^n", 2) &&
-				    strncmp(raw->inbuf+count-2, "\252n", 2)) ) {
-					/* don't add the auto \n */
-					tty->flip.char_buf_ptr[count] = '\n';
-					memset(tty->flip.flag_buf_ptr,
-					       TTY_NORMAL, count + 1);
+				    (strncmp(raw->inbuf+count-2, "\252n", 2) &&
+				     strncmp(raw->inbuf+count-2, "^n", 2)) ) {
+					/* add the auto \n */
+					raw->inbuf[count] = '\n';
 					count++;
 				} else
-					count-=2;
-				tty->flip.char_buf_ptr += count;
-				tty->flip.flag_buf_ptr += count;
-				tty->flip.count += count;
+					count -= 2;
+				tty_insert_flip_string(tty, raw->inbuf, count);
 				tty_flip_buffer_push(raw->tty);
 				break;
 			}
diff -urpN linux-2.6.13-mm1/drivers/s390/char/sclp_tty.c linux-2.6.13-flip/drivers/s390/char/sclp_tty.c
--- linux-2.6.13-mm1/drivers/s390/char/sclp_tty.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-flip/drivers/s390/char/sclp_tty.c	2005-09-07 12:44:56.000000000 +0200
@@ -13,6 +13,7 @@
 #include <linux/kmod.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
@@ -496,25 +497,19 @@ sclp_tty_input(unsigned char* buf, unsig
 	case CTRLCHAR_SYSRQ:
 		break;
 	case CTRLCHAR_CTRL:
-		sclp_tty->flip.count++;
-		*sclp_tty->flip.flag_buf_ptr++ = TTY_NORMAL;
-		*sclp_tty->flip.char_buf_ptr++ = cchar;
+		tty_insert_flip_char(sclp_tty, cchar, TTY_NORMAL);
 		tty_flip_buffer_push(sclp_tty);
 		break;
 	case CTRLCHAR_NONE:
 		/* send (normal) input to line discipline */
-		memcpy(sclp_tty->flip.char_buf_ptr, buf, count);
 		if (count < 2 ||
-		    (strncmp ((const char *) buf + count - 2, "^n", 2) &&
-		     strncmp ((const char *) buf + count - 2, "\0252n", 2))) {
-			sclp_tty->flip.char_buf_ptr[count] = '\n';
-			count++;
+		    (strncmp((const char *) buf + count - 2, "^n", 2) &&
+		     strncmp((const char *) buf + count - 2, "\252n", 2))) {
+			/* add the auto \n */
+			tty_insert_flip_string(sclp_tty, buf, count);
+			tty_insert_flip_char(sclp_tty, '\n', TTY_NORMAL);
 		} else
-			count -= 2;
-		memset(sclp_tty->flip.flag_buf_ptr, TTY_NORMAL, count);
-		sclp_tty->flip.char_buf_ptr += count;
-		sclp_tty->flip.flag_buf_ptr += count;
-		sclp_tty->flip.count += count;
+			tty_insert_flip_string(sclp_tty, buf, count - 2);
 		tty_flip_buffer_push(sclp_tty);
 		break;
 	}
diff -urpN linux-2.6.13-mm1/drivers/s390/char/sclp_vt220.c linux-2.6.13-flip/drivers/s390/char/sclp_vt220.c
--- linux-2.6.13-mm1/drivers/s390/char/sclp_vt220.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-flip/drivers/s390/char/sclp_vt220.c	2005-09-07 12:46:59.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
@@ -482,16 +483,7 @@ sclp_vt220_receiver_fn(struct evbuf_head
 		/* Send input to line discipline */
 		buffer++;
 		count--;
-		/* Prevent buffer overrun by discarding input. Note that
-		 * because buffer_push works asynchronously, we cannot wait
-		 * for the buffer to be emptied. */
-		if (count + sclp_vt220_tty->flip.count > TTY_FLIPBUF_SIZE)
-			count = TTY_FLIPBUF_SIZE - sclp_vt220_tty->flip.count;
-		memcpy(sclp_vt220_tty->flip.char_buf_ptr, buffer, count);
-		memset(sclp_vt220_tty->flip.flag_buf_ptr, TTY_NORMAL, count);
-		sclp_vt220_tty->flip.char_buf_ptr += count;
-		sclp_vt220_tty->flip.flag_buf_ptr += count;
-		sclp_vt220_tty->flip.count += count;
+		tty_insert_flip_string(sclp_vt220_tty, buffer, count);
 		tty_flip_buffer_push(sclp_vt220_tty);
 		break;
 	}
diff -urpN linux-2.6.13-mm1/drivers/s390/net/ctctty.c linux-2.6.13-flip/drivers/s390/net/ctctty.c
--- linux-2.6.13-mm1/drivers/s390/net/ctctty.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.13-flip/drivers/s390/net/ctctty.c	2005-09-07 12:50:21.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/serial_reg.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -101,25 +102,17 @@ static spinlock_t ctc_tty_lock;
 static int
 ctc_tty_try_read(ctc_tty_info * info, struct sk_buff *skb)
 {
-	int c;
 	int len;
 	struct tty_struct *tty;
 
 	DBF_TEXT(trace, 5, __FUNCTION__);
 	if ((tty = info->tty)) {
 		if (info->mcr & UART_MCR_RTS) {
-			c = TTY_FLIPBUF_SIZE - tty->flip.count;
 			len = skb->len;
-			if (c >= len) {
-				memcpy(tty->flip.char_buf_ptr, skb->data, len);
-				memset(tty->flip.flag_buf_ptr, 0, len);
-				tty->flip.count += len;
-				tty->flip.char_buf_ptr += len;
-				tty->flip.flag_buf_ptr += len;
-				tty_flip_buffer_push(tty);
-				kfree_skb(skb);
-				return 1;
-			}
+			tty_insert_flip_string(tty, skb->data, len);
+			tty_flip_buffer_push(tty);
+			kfree_skb(skb);
+			return 1;
 		}
 	}
 	return 0;
@@ -138,19 +131,12 @@ ctc_tty_readmodem(ctc_tty_info *info)
 	DBF_TEXT(trace, 5, __FUNCTION__);
 	if ((tty = info->tty)) {
 		if (info->mcr & UART_MCR_RTS) {
-			int c = TTY_FLIPBUF_SIZE - tty->flip.count;
 			struct sk_buff *skb;
 			
-			if ((c > 0) && (skb = skb_dequeue(&info->rx_queue))) {
+			if ((skb = skb_dequeue(&info->rx_queue))) {
 				int len = skb->len;
-				if (len > c)
-					len = c;
-				memcpy(tty->flip.char_buf_ptr, skb->data, len);
+				tty_insert_flip_string(tty, skb->data, len);
 				skb_pull(skb, len);
-				memset(tty->flip.flag_buf_ptr, 0, len);
-				tty->flip.count += len;
-				tty->flip.char_buf_ptr += len;
-				tty->flip.flag_buf_ptr += len;
 				tty_flip_buffer_push(tty);
 				if (skb->len > 0)
 					skb_queue_head(&info->rx_queue, skb);
