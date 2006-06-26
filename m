Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWFZR6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWFZR6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFZR6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:58:35 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:162
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751251AbWFZR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:58:19 -0400
Subject: [PATCH] remove active field from tty buffer structure
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 12:57:55 -0500
Message-Id: <1151344675.32146.17.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'active' field from tty buffer structure.
This was added in 2.6.16 as part of a patch to
make the new tty buffering SMP safe. This field is
unnecessary with the more intelligently written
flush_to_ldisc that adds receive_room handling.

Removing this field reverts to simpler logic
where the tail buffer is always the 'active' buffer,
which should not be freed by flush_to_ldisc.
(active == buffer being filled with new data)

The result is simpler, smaller, and faster
tty buffer code.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>


--- a/include/linux/tty.h	2006-06-26 10:13:22.000000000 -0500
+++ b/include/linux/tty.h	2006-06-26 09:55:25.000000000 -0500
@@ -58,7 +58,6 @@ struct tty_buffer {
 	unsigned char *flag_buf_ptr;
 	int used;
 	int size;
-	int active;
 	int commit;
 	int read;
 	/* Data points here */
--- a/include/linux/tty_flip.h	2006-06-17 20:49:35.000000000 -0500
+++ b/include/linux/tty_flip.h	2006-06-26 10:17:11.000000000 -0500
@@ -12,7 +12,7 @@ static inline int tty_insert_flip_char(s
 					unsigned char ch, char flag)
 {
 	struct tty_buffer *tb = tty->buf.tail;
-	if (tb && tb->active && tb->used < tb->size) {
+	if (tb && tb->used < tb->size) {
 		tb->flag_buf_ptr[tb->used] = flag;
 		tb->char_buf_ptr[tb->used++] = ch;
 		return 1;
--- a/include/linux/kbd_kern.h	2006-06-26 10:13:22.000000000 -0500
+++ b/include/linux/kbd_kern.h	2006-06-26 10:02:41.000000000 -0500
@@ -155,10 +155,8 @@ static inline void con_schedule_flip(str
 {
 	unsigned long flags;
 	spin_lock_irqsave(&t->buf.lock, flags);
-	if (t->buf.tail != NULL) {
-		t->buf.tail->active = 0;
+	if (t->buf.tail != NULL)
 		t->buf.tail->commit = t->buf.tail->used;
-	}
 	spin_unlock_irqrestore(&t->buf.lock, flags);
 	schedule_work(&t->buf.work);
 }
--- a/drivers/char/tty_io.c	2006-06-26 10:13:22.000000000 -0500
+++ b/drivers/char/tty_io.c	2006-06-26 09:55:05.000000000 -0500
@@ -267,7 +267,6 @@ static struct tty_buffer *tty_buffer_all
 	p->used = 0;
 	p->size = size;
 	p->next = NULL;
-	p->active = 0;
 	p->commit = 0;
 	p->read = 0;
 	p->char_buf_ptr = (char *)(p->data);
@@ -327,10 +326,9 @@ int tty_buffer_request_room(struct tty_s
 	/* OPTIMISATION: We could keep a per tty "zero" sized buffer to
 	   remove this conditional if its worth it. This would be invisible
 	   to the callers */
-	if ((b = tty->buf.tail) != NULL) {
+	if ((b = tty->buf.tail) != NULL)
 		left = b->size - b->used;
-		b->active = 1;
-	} else
+	else
 		left = 0;
 
 	if (left < size) {
@@ -338,12 +336,10 @@ int tty_buffer_request_room(struct tty_s
 		if ((n = tty_buffer_find(tty, size)) != NULL) {
 			if (b != NULL) {
 				b->next = n;
-				b->active = 0;
 				b->commit = b->used;
 			} else
 				tty->buf.head = n;
 			tty->buf.tail = n;
-			n->active = 1;
 		} else
 			size = left;
 	}
@@ -404,10 +400,8 @@ void tty_schedule_flip(struct tty_struct
 {
 	unsigned long flags;
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	if (tty->buf.tail != NULL) {
-		tty->buf.tail->active = 0;
+	if (tty->buf.tail != NULL)
 		tty->buf.tail->commit = tty->buf.tail->used;
-	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 	schedule_delayed_work(&tty->buf.work, 1);
 }
@@ -2903,10 +2897,8 @@ void tty_flip_buffer_push(struct tty_str
 {
 	unsigned long flags;
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	if (tty->buf.tail != NULL) {
-		tty->buf.tail->active = 0;
+	if (tty->buf.tail != NULL)
 		tty->buf.tail->commit = tty->buf.tail->used;
-	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 
 	if (tty->low_latency)


