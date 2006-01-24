Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWAXWGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWAXWGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWAXWGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:06:46 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:60344
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750770AbWAXWGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:06:45 -0500
Subject: Re: pppd oopses current linu's git tree on disconnect
From: Paul Fulghum <paulkf@microgate.com>
To: Diego Calleja <diegocg@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060124044846.de6508eb.diegocg@gmail.com>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	 <1137692039.3279.1.camel@amdx2.microgate.com>
	 <20060119230746.ea78fcf4.diegocg@gmail.com> <43D01537.40705@microgate.com>
	 <20060123034243.22ba0a8f.diegocg@gmail.com>
	 <20060124044846.de6508eb.diegocg@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 24 Jan 2006 16:06:31 -0600
Message-Id: <1138140391.3223.15.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 04:48 +0100, Diego Calleja wrote:
> El Mon, 23 Jan 2006 03:42:43 +0100,
> Diego Calleja <diegocg@gmail.com> escribió:
> 
> > Ok - I seem to be able to reproduce it in a unpatched kernel using
> > a lengthy session. I will try your patch and report back.
> 
> It doesn't seems to happen today at least, after a lentghty session
> similar to the one which triggered the bug.

I reasonably sure that your problem is lack
of locking for the new tty buffering scheme.
There is a question of how to best fix it
with minimal code change and impact on performance.

Alan:

Look at the attached patches against 2.6.16-rc1

1. I added an active flag for each tty buffer

2. I added locking to anything that manipulates the
   buffer lists or sets/clears an active flag
   This uses a lock dedicated to the tty buffer lists
   instead of using the tty->read_lock to reduce lock
   contention.

3. Calls to tty insertion functions set the active
   flag for the tail buffer:
   tty_buffer_request_room()
   tty_insert_flip_string()
   tty_insert_flip_string_flags()
   tty_prepare_flip_string()
   tty_prepare_flip_string_flags()
   tty_insert_flip_char()

4. The active flag is cleared when calling
   tty_schedule_flip()
   con_schedule_flip()
   tty_flip_buffer_push()

This lets the tail buffer be 'owned' by the driver
while filling it. flush_to_ldisc stops when an
active buffer is encountered. Calling the scheduling
functions in #4 releases the buffer for use by flush_to_ldisc.

This scheme centralizes the locking so every driver does not
need to be modified, and avoids excessive locking/unlocking
for each inserted character. The lock is grabbed once by
the driver to activate (get ownership of) the tail buffer.
The driver fills the buffer (possibly one char at a time).
When the driver is done, the buffer is marked inactive and
flush_to_ldisc can process it.

I've done some initial testing with success.
Let me know what you think.

--- linux-2.6.16-rc1/drivers/char/tty_io.c	2006-01-24 15:31:45.000000000 -0600
+++ linux-2.6.16-rc1-mg/drivers/char/tty_io.c	2006-01-24 15:33:28.000000000 -0600
@@ -253,6 +253,7 @@ static void tty_buffer_free_all(struct t
 
 static void tty_buffer_init(struct tty_struct *tty)
 {
+	spin_lock_init(&tty->buf.lock);
 	tty->buf.head = NULL;
 	tty->buf.tail = NULL;
 	tty->buf.free = NULL;
@@ -266,6 +267,7 @@ static struct tty_buffer *tty_buffer_all
 	p->used = 0;
 	p->size = size;
 	p->next = NULL;
+	p->active = 0;
 	p->char_buf_ptr = (char *)(p->data);
 	p->flag_buf_ptr = (unsigned char *)p->char_buf_ptr + size;
 /* 	printk("Flip create %p\n", p); */
@@ -312,25 +314,36 @@ static struct tty_buffer *tty_buffer_fin
 
 int tty_buffer_request_room(struct tty_struct *tty, size_t size)
 {
-	struct tty_buffer *b = tty->buf.tail, *n;
+	struct tty_buffer *b, *n;
 	int left = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tty->buf.lock, flags);
 
 	/* OPTIMISATION: We could keep a per tty "zero" sized buffer to
 	   remove this conditional if its worth it. This would be invisible
 	   to the callers */
-	if(b != NULL)
+	if ((b = tty->buf.tail) != NULL)
 		left = b->size - b->used;
 	if(left >= size)
-		return size;
+		goto done;
+
 	/* This is the slow path - looking for new buffers to use */
 	n = tty_buffer_find(tty, size);
-	if(n == NULL)
-		return left;
+	if(n == NULL) {
+		size = left;
+		goto done;
+	}
 	if(b != NULL)
 		b->next = n;
 	else
 		tty->buf.head = n;
 	tty->buf.tail = n;
+
+done:
+	if (tty->buf.tail != NULL)
+		tty->buf.tail->active = 1;
+	spin_unlock_irqrestore(&tty->buf.lock, flags);
 	return size;
 }
 
@@ -396,10 +409,12 @@ EXPORT_SYMBOL_GPL(tty_insert_flip_string
 int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size)
 {
 	int space = tty_buffer_request_room(tty, size);
-	struct tty_buffer *tb = tty->buf.tail;
-	*chars = tb->char_buf_ptr + tb->used;
-	memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
-	tb->used += space;
+	if (space) {
+		struct tty_buffer *tb = tty->buf.tail;
+		*chars = tb->char_buf_ptr + tb->used;
+		memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
+		tb->used += space;
+	}
 	return space;
 }
 
@@ -416,10 +431,12 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_strin
 int tty_prepare_flip_string_flags(struct tty_struct *tty, unsigned char **chars, char **flags, size_t size)
 {
 	int space = tty_buffer_request_room(tty, size);
-	struct tty_buffer *tb = tty->buf.tail;
-	*chars = tb->char_buf_ptr + tb->used;
-	*flags = tb->flag_buf_ptr + tb->used;
-	tb->used += space;
+	if (space) {
+		struct tty_buffer *tb = tty->buf.tail;
+		*chars = tb->char_buf_ptr + tb->used;
+		*flags = tb->flag_buf_ptr + tb->used;
+		tb->used += space;
+	}
 	return space;
 }
 
@@ -2748,7 +2765,7 @@ static void flush_to_ldisc(void *private
 		goto out;
 	}
 	spin_lock_irqsave(&tty->read_lock, flags);
-	while((tbuf = tty->buf.head) != NULL) {
+	while((tbuf = tty->buf.head) != NULL && !tbuf->active) {
 		tty->buf.head = tbuf->next;
 		if (tty->buf.head == NULL)
 			tty->buf.tail = NULL;
@@ -2852,6 +2869,12 @@ EXPORT_SYMBOL(tty_get_baud_rate);
 
 void tty_flip_buffer_push(struct tty_struct *tty)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&tty->buf.lock, flags);
+	if (tty->buf.tail != NULL)
+		tty->buf.tail->active = 0;
+	spin_unlock_irqrestore(&tty->buf.lock, flags);
+
 	if (tty->low_latency)
 		flush_to_ldisc((void *) tty);
 	else
--- linux-2.6.16-rc1/include/linux/tty.h	2006-01-17 09:31:30.000000000 -0600
+++ linux-2.6.16-rc1-mg/include/linux/tty.h	2006-01-24 14:12:19.000000000 -0600
@@ -57,6 +57,7 @@ struct tty_buffer {
 	unsigned char *flag_buf_ptr;
 	int used;
 	int size;
+	int active;
 	/* Data points here */
 	unsigned long data[0];
 };
@@ -64,6 +65,7 @@ struct tty_buffer {
 struct tty_bufhead {
 	struct work_struct		work;
 	struct semaphore pty_sem;
+	spinlock_t lock;
 	struct tty_buffer *head;	/* Queue head */
 	struct tty_buffer *tail;	/* Active buffer */
 	struct tty_buffer *free;	/* Free queue head */
--- linux-2.6.16-rc1/include/linux/tty_flip.h	2006-01-24 12:24:47.000000000 -0600
+++ linux-2.6.16-rc1-mg/include/linux/tty_flip.h	2006-01-24 14:46:59.000000000 -0600
@@ -17,7 +17,7 @@ _INLINE_ int tty_insert_flip_char(struct
 				   unsigned char ch, char flag)
 {
 	struct tty_buffer *tb = tty->buf.tail;
-	if (tb && tb->used < tb->size) {
+	if (tb && tb->active && tb->used < tb->size) {
 		tb->flag_buf_ptr[tb->used] = flag;
 		tb->char_buf_ptr[tb->used++] = ch;
 		return 1;
@@ -27,6 +27,11 @@ _INLINE_ int tty_insert_flip_char(struct
 
 _INLINE_ void tty_schedule_flip(struct tty_struct *tty)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&tty->buf.lock, flags);
+	if (tty->buf.tail != NULL)
+		tty->buf.tail->active = 0;
+	spin_unlock_irqrestore(&tty->buf.lock, flags);
 	schedule_delayed_work(&tty->buf.work, 1);
 }
 
--- linux-2.6.16-rc1/include/linux/kbd_kern.h	2006-01-17 09:31:29.000000000 -0600
+++ linux-2.6.16-rc1-mg/include/linux/kbd_kern.h	2006-01-24 15:38:19.000000000 -0600
@@ -151,6 +151,11 @@ extern unsigned int keymap_count;
 
 static inline void con_schedule_flip(struct tty_struct *t)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&t->buf.lock, flags);
+	if (t->buf.tail != NULL)
+		t->buf.tail->active = 0;
+	spin_unlock_irqrestore(&t->buf.lock, flags);
 	schedule_work(&t->buf.work);
 }
 



