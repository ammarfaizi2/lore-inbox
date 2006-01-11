Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWAKXv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWAKXv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWAKXv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:51:56 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:49592
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751134AbWAKXvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:51:55 -0500
Subject: [PATCH] new tty buffering access fix
From: Paul Fulghum <paulkf@microgate.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 17:51:48 -0600
Message-Id: <1137023508.3113.10.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix typos in new tty buffering that incorrectly
access and update buffers in pending queue.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>
Acked-by: Alan Cox <alan@redhat.com>


--- linux-2.6.15/drivers/char/tty_io.c	2006-01-11 16:22:10.000000000 -0600
+++ linux-2.6.15-mg/drivers/char/tty_io.c	2006-01-11 16:21:52.000000000 -0600
@@ -312,7 +312,7 @@ static struct tty_buffer *tty_buffer_fin
 
 int tty_buffer_request_room(struct tty_struct *tty, size_t size)
 {
-	struct tty_buffer *b = tty->buf.head, *n;
+	struct tty_buffer *b = tty->buf.tail, *n;
 	int left = 0;
 
 	/* OPTIMISATION: We could keep a per tty "zero" sized buffer to
@@ -326,7 +326,6 @@ int tty_buffer_request_room(struct tty_s
 	n = tty_buffer_find(tty, size);
 	if(n == NULL)
 		return left;
-	n->next = b;
 	if(b != NULL)
 		b->next = n;
 	else
@@ -2751,6 +2750,8 @@ static void flush_to_ldisc(void *private
 	spin_lock_irqsave(&tty->read_lock, flags);
 	while((tbuf = tty->buf.head) != NULL) {
 		tty->buf.head = tbuf->next;
+		if (tty->buf.head == NULL)
+			tty->buf.tail = NULL;
 		spin_unlock_irqrestore(&tty->read_lock, flags);
 		/* printk("Process buffer %p for %d\n", tbuf, tbuf->used); */
 		disc->receive_buf(tty, tbuf->char_buf_ptr,
@@ -2759,7 +2760,6 @@ static void flush_to_ldisc(void *private
 		spin_lock_irqsave(&tty->read_lock, flags);
 		tty_buffer_free(tty, tbuf);
 	}
-	tty->buf.tail = NULL;
 	spin_unlock_irqrestore(&tty->read_lock, flags);
 out:
 	tty_ldisc_deref(disc);



