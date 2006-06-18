Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWFRVFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWFRVFY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWFRVFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 17:05:24 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:5822
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932076AbWFRVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 17:05:24 -0400
Subject: [PATCH] fix memory leak in rocketport rp_do_receive
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 16:05:32 -0500
Message-Id: <1150664732.2606.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak caused by incorrect use of tty
buffer facility. tty buffers are allocated but never
processed by call to tty_flip_buffer_push so they
accumulate on the full buffer list. Current code
uses the buffers as a temporary storage for data before
passing it directly to the line discipline.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.16/drivers/char/rocket.c	2006-06-04 10:22:24.000000000 -0500
+++ b/drivers/char/rocket.c	2006-06-04 10:45:35.000000000 -0500
@@ -324,35 +324,15 @@ static void rp_do_receive(struct r_port 
 			  CHANNEL_t * cp, unsigned int ChanStatus)
 {
 	unsigned int CharNStat;
-	int ToRecv, wRecv, space = 0, count;
-	unsigned char *cbuf, *chead;
-	char *fbuf, *fhead;
-	struct tty_ldisc *ld;
-
-	ld = tty_ldisc_ref(tty);
+	int ToRecv, wRecv, space;
+	unsigned char *cbuf;
 
 	ToRecv = sGetRxCnt(cp);
-	space = tty->receive_room;
-	if (space > 2 * TTY_FLIPBUF_SIZE)
-		space = 2 * TTY_FLIPBUF_SIZE;
-	count = 0;
 #ifdef ROCKET_DEBUG_INTR
-	printk(KERN_INFO "rp_do_receive(%d, %d)...", ToRecv, space);
+	printk(KERN_INFO "rp_do_receive(%d)...", ToRecv);
 #endif
-
-	/*
-	 * determine how many we can actually read in.  If we can't
-	 * read any in then we have a software overrun condition.
-	 */
-	if (ToRecv > space)
-		ToRecv = space;
-
-	ToRecv = tty_prepare_flip_string_flags(tty, &chead, &fhead, ToRecv);
-	if (ToRecv <= 0)
-		goto done;
-
-	cbuf = chead;
-	fbuf = fhead;
+	if (ToRecv == 0)
+		return;
 
 	/*
 	 * if status indicates there are errored characters in the
@@ -380,6 +360,8 @@ static void rp_do_receive(struct r_port 
 		       info->read_status_mask);
 #endif
 		while (ToRecv) {
+			char flag;
+
 			CharNStat = sInW(sGetTxRxDataIO(cp));
 #ifdef ROCKET_DEBUG_RECEIVE
 			printk(KERN_INFO "%x...", CharNStat);
@@ -392,17 +374,16 @@ static void rp_do_receive(struct r_port 
 			}
 			CharNStat &= info->read_status_mask;
 			if (CharNStat & STMBREAKH)
-				*fbuf++ = TTY_BREAK;
+				flag = TTY_BREAK;
 			else if (CharNStat & STMPARITYH)
-				*fbuf++ = TTY_PARITY;
+				flag = TTY_PARITY;
 			else if (CharNStat & STMFRAMEH)
-				*fbuf++ = TTY_FRAME;
+				flag = TTY_FRAME;
 			else if (CharNStat & STMRCVROVRH)
-				*fbuf++ = TTY_OVERRUN;
+				flag = TTY_OVERRUN;
 			else
-				*fbuf++ = TTY_NORMAL;
-			*cbuf++ = CharNStat & 0xff;
-			count++;
+				flag = TTY_NORMAL;
+			tty_insert_flip_char(tty, CharNStat & 0xff, flag);
 			ToRecv--;
 		}
 
@@ -422,20 +403,23 @@ static void rp_do_receive(struct r_port 
 		 * characters at time by doing repeated word IO
 		 * transfer.
 		 */
+		space = tty_prepare_flip_string(tty, &cbuf, ToRecv);
+		if (space < ToRecv) {
+#ifdef ROCKET_DEBUG_RECEIVE
+			printk(KERN_INFO "rp_do_receive:insufficient space ToRecv=%d space=%d\n", ToRecv, space);
+#endif
+			if (space <= 0)
+				return;
+			ToRecv = space;
+		}
 		wRecv = ToRecv >> 1;
 		if (wRecv)
 			sInStrW(sGetTxRxDataIO(cp), (unsigned short *) cbuf, wRecv);
 		if (ToRecv & 1)
 			cbuf[ToRecv - 1] = sInB(sGetTxRxDataIO(cp));
-		memset(fbuf, TTY_NORMAL, ToRecv);
-		cbuf += ToRecv;
-		fbuf += ToRecv;
-		count += ToRecv;
 	}
 	/*  Push the data up to the tty layer */
-	ld->receive_buf(tty, chead, fhead, count);
-done:
-	tty_ldisc_deref(ld);
+	tty_flip_buffer_push(tty);
 }
 
 /*


