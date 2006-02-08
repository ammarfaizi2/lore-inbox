Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWBHWFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWBHWFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWBHWFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:05:38 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:24205
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751138AbWBHWFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:05:35 -0500
Subject: Re: [PATCH] new tty buffering locking fix
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1139361293.22595.14.camel@localhost.localdomain>
References: <200602032312.k13NCbWb012991@hera.kernel.org>
	 <20060207123450.GA854@suse.de>
	 <1139329302.3019.14.camel@amdx2.microgate.com>
	 <20060207171111.GA15912@suse.de>
	 <1139347644.3174.16.camel@amdx2.microgate.com>
	 <1139361293.22595.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 16:05:17 -0600
Message-Id: <1139436317.12888.7.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a different approach to prevent a driver
from stalling pending receive data in the flip buffers
by calling a tty buffer allocation function without
a trailing call to a tty schedule function.
This patch does not have the memory penalty of
my previous patch for the worst case usage patterns.

Alan: let me know what you think.
Olaf: can you please test this with the hvc?

I am going to continue testing tomorrow,
but would like some early feedback.

Thanks,
Paul

--- linux-2.6.16-rc2/include/linux/kbd_kern.h	2006-02-08 12:15:15.000000000 -0600
+++ b/include/linux/kbd_kern.h	2006-02-08 12:15:39.000000000 -0600
@@ -153,8 +153,10 @@ static inline void con_schedule_flip(str
 {
 	unsigned long flags;
 	spin_lock_irqsave(&t->buf.lock, flags);
-	if (t->buf.tail != NULL)
+	if (t->buf.tail != NULL) {
 		t->buf.tail->active = 0;
+		t->buf.tail->commit = t->buf.tail->used;
+	}
 	spin_unlock_irqrestore(&t->buf.lock, flags);
 	schedule_work(&t->buf.work);
 }
--- linux-2.6.16-rc2/include/linux/tty_flip.h	2006-02-07 14:14:36.000000000 -0600
+++ b/include/linux/tty_flip.h	2006-02-08 09:46:58.000000000 -0600
@@ -29,8 +29,10 @@ _INLINE_ void tty_schedule_flip(struct t
 {
 	unsigned long flags;
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	if (tty->buf.tail != NULL)
+	if (tty->buf.tail != NULL) {
 		tty->buf.tail->active = 0;
+		tty->buf.tail->commit = tty->buf.tail->used;
+	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 	schedule_delayed_work(&tty->buf.work, 1);
 }
--- linux-2.6.16-rc2/include/linux/tty.h	2006-02-07 14:14:36.000000000 -0600
+++ b/include/linux/tty.h	2006-02-08 09:45:23.000000000 -0600
@@ -58,6 +58,8 @@ struct tty_buffer {
 	int used;
 	int size;
 	int active;
+	int commit;
+	int read;
 	/* Data points here */
 	unsigned long data[0];
 };
--- linux-2.6.16-rc2/drivers/char/tty_io.c	2006-02-08 12:55:03.000000000 -0600
+++ b/drivers/char/tty_io.c	2006-02-08 13:40:58.000000000 -0600
@@ -268,6 +268,8 @@ static struct tty_buffer *tty_buffer_all
 	p->size = size;
 	p->next = NULL;
 	p->active = 0;
+	p->commit = 0;
+	p->read = 0;
 	p->char_buf_ptr = (char *)(p->data);
 	p->flag_buf_ptr = (unsigned char *)p->char_buf_ptr + size;
 /* 	printk("Flip create %p\n", p); */
@@ -298,6 +300,8 @@ static struct tty_buffer *tty_buffer_fin
 			*tbh = t->next;
 			t->next = NULL;
 			t->used = 0;
+			t->commit = 0;
+			t->read = 0;
 			/* DEBUG ONLY */
 			memset(t->data, '*', size);
 /* 			printk("Flip recycle %p\n", t); */
@@ -335,6 +339,7 @@ int tty_buffer_request_room(struct tty_s
 			if (b != NULL) {
 				b->next = n;
 				b->active = 0;
+				b->commit = b->used;
 			} else
 				tty->buf.head = n;
 			tty->buf.tail = n;
@@ -2752,6 +2757,9 @@ static void flush_to_ldisc(void *private
 	unsigned long 	flags;
 	struct tty_ldisc *disc;
 	struct tty_buffer *tbuf;
+	int count;
+	char *char_buf;
+	unsigned char *flag_buf;
 
 	disc = tty_ldisc_ref(tty);
 	if (disc == NULL)	/*  !TTY_LDISC */
@@ -2765,16 +2773,20 @@ static void flush_to_ldisc(void *private
 		goto out;
 	}
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	while((tbuf = tty->buf.head) != NULL && !tbuf->active) {
+	while((tbuf = tty->buf.head) != NULL) {
+		while ((count = tbuf->commit - tbuf->read) != 0) {
+			char_buf = tbuf->char_buf_ptr + tbuf->read;
+			flag_buf = tbuf->flag_buf_ptr + tbuf->read;
+			tbuf->read += count;
+			spin_unlock_irqrestore(&tty->buf.lock, flags);
+			disc->receive_buf(tty, char_buf, flag_buf, count);
+			spin_lock_irqsave(&tty->buf.lock, flags);
+		}
+		if (tbuf->active)
+			break;
 		tty->buf.head = tbuf->next;
 		if (tty->buf.head == NULL)
 			tty->buf.tail = NULL;
-		spin_unlock_irqrestore(&tty->buf.lock, flags);
-		/* printk("Process buffer %p for %d\n", tbuf, tbuf->used); */
-		disc->receive_buf(tty, tbuf->char_buf_ptr,
-				       tbuf->flag_buf_ptr,
-				       tbuf->used);
-		spin_lock_irqsave(&tty->buf.lock, flags);
 		tty_buffer_free(tty, tbuf);
 	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
@@ -2871,8 +2883,10 @@ void tty_flip_buffer_push(struct tty_str
 {
 	unsigned long flags;
 	spin_lock_irqsave(&tty->buf.lock, flags);
-	if (tty->buf.tail != NULL)
+	if (tty->buf.tail != NULL) {
 		tty->buf.tail->active = 0;
+		tty->buf.tail->commit = tty->buf.tail->used;
+	}
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 
 	if (tty->low_latency)


