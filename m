Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752061AbWFWVLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWFWVLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWFWVLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:11:46 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:15560
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1752061AbWFWVLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:11:46 -0400
Subject: [PATCH] add receive_room flow control to flush_to_ldisc
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:11:24 -0500
Message-Id: <1151097084.4249.10.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flush data serially to line discipline in blocks no
larger than tty->receive_room to avoid losing data
if line discipline is busy (such as N_TTY operating at
high speed on heavily loaded system) or does
not accept data in large blocks (such as N_MOUSE).

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
--- a/drivers/char/tty_io.c	2006-06-23 15:40:14.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-06-23 15:39:47.000000000 -0500
@@ -2772,7 +2772,7 @@ static void flush_to_ldisc(void *private
 	struct tty_struct *tty = (struct tty_struct *) private_;
 	unsigned long 	flags;
 	struct tty_ldisc *disc;
-	struct tty_buffer *tbuf;
+	struct tty_buffer *tbuf, *head;
 	int count;
 	char *char_buf;
 	unsigned char *flag_buf;
@@ -2782,21 +2782,33 @@ static void flush_to_ldisc(void *private
 		return;
 
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	while((tbuf = tty->buf.head) != NULL) {
-		while ((count = tbuf->commit - tbuf->read) != 0) {
-			char_buf = tbuf->char_buf_ptr + tbuf->read;
-			flag_buf = tbuf->flag_buf_ptr + tbuf->read;
-			tbuf->read += count;
+	head = tty->buf.head;
+	if (head != NULL) {
+		tty->buf.head = NULL;
+		for (;;) {
+			count = head->commit - head->read;
+			if (!count) {
+				if (head->next == NULL)
+					break;
+				tbuf = head;
+				head = head->next;
+				tty_buffer_free(tty, tbuf);
+				continue;
+			}
+			if (!tty->receive_room) {
+				schedule_delayed_work(&tty->buf.work, 1);
+				break;
+			}
+			if (count > tty->receive_room)
+				count = tty->receive_room;
+			char_buf = head->char_buf_ptr + head->read;
+			flag_buf = head->flag_buf_ptr + head->read;
+			head->read += count;
 			spin_unlock_irqrestore(&tty->buf.lock, flags);
 			disc->receive_buf(tty, char_buf, flag_buf, count);
 			spin_lock_irqsave(&tty->buf.lock, flags);
 		}
-		if (tbuf->active)
-			break;
-		tty->buf.head = tbuf->next;
-		if (tty->buf.head == NULL)
-			tty->buf.tail = NULL;
-		tty_buffer_free(tty, tbuf);
+		tty->buf.head = head;
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 


