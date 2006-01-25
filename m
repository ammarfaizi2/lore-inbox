Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWAYVA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWAYVA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAYVA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:00:57 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:60120
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751155AbWAYVA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:00:56 -0500
Subject: Re: pppd oopses current linu's git tree on disconnect
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1138148573.21723.3.camel@localhost.localdomain>
References: <20060119010601.f259bb32.diegocg@gmail.com>
	 <1137692039.3279.1.camel@amdx2.microgate.com>
	 <20060119230746.ea78fcf4.diegocg@gmail.com> <43D01537.40705@microgate.com>
	 <20060123034243.22ba0a8f.diegocg@gmail.com>
	 <20060124044846.de6508eb.diegocg@gmail.com>
	 <1138140391.3223.15.camel@amdx2.microgate.com>
	 <1138145129.21284.12.camel@localhost.localdomain>
	 <43D6BBCF.7090403@microgate.com>
	 <1138148573.21723.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 15:00:41 -0600
Message-Id: <1138222841.4478.12.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a refined and more thoroughly tested patch
that implements the needed tty buffer locking.

Change from last:

1. fix tty_buffer_request_room() to clear active flag
   when moving buffer from tail position

2. fixup esp and cyclades drivers which scheduled the
   flip work directly. They now use tty_schedule_flip().

3. change tty->read_lock in flush_to_ldisc() to tty->buf.lock
   like the rest of the code. (stupid, duhhh)

I've beat on it all day, and it looks good.
This is ready for anyone else to actually apply and test.

Alan:

I left the redundant con_schedule_flip, tty_schedule_flip,
and tty_flip_buffer_push functions in place for now. They
each do slightly different things, and I don't want to mix
that optimization with the locking change.

--- linux-2.6.16-rc1/drivers/char/tty_io.c	2006-01-25 13:46:06.000000000 -0600
+++ linux-2.6.16-rc1-mg/drivers/char/tty_io.c	2006-01-25 13:50:15.000000000 -0600
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
-	int left = 0;
+	struct tty_buffer *b, *n;
+	int left;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tty->buf.lock, flags);
 
 	/* OPTIMISATION: We could keep a per tty "zero" sized buffer to
 	   remove this conditional if its worth it. This would be invisible
 	   to the callers */
-	if(b != NULL)
+	if ((b = tty->buf.tail) != NULL) {
 		left = b->size - b->used;
-	if(left >= size)
-		return size;
-	/* This is the slow path - looking for new buffers to use */
-	n = tty_buffer_find(tty, size);
-	if(n == NULL)
-		return left;
-	if(b != NULL)
-		b->next = n;
-	else
-		tty->buf.head = n;
-	tty->buf.tail = n;
+		b->active = 1;
+	} else
+		left = 0;
+
+	if (left < size) {
+		/* This is the slow path - looking for new buffers to use */
+		if ((n = tty_buffer_find(tty, size)) != NULL) {
+			if (b != NULL) {
+				b->next = n;
+				b->active = 0;
+			} else
+				tty->buf.head = n;
+			tty->buf.tail = n;
+			n->active = 1;
+		} else
+			size = left;
+	}
+
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
+	if (likely(space)) {
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
+	if (likely(space)) {
+		struct tty_buffer *tb = tty->buf.tail;
+		*chars = tb->char_buf_ptr + tb->used;
+		*flags = tb->flag_buf_ptr + tb->used;
+		tb->used += space;
+	}
 	return space;
 }
 
@@ -2747,20 +2764,20 @@ static void flush_to_ldisc(void *private
 		schedule_delayed_work(&tty->buf.work, 1);
 		goto out;
 	}
-	spin_lock_irqsave(&tty->read_lock, flags);
-	while((tbuf = tty->buf.head) != NULL) {
+	spin_lock_irqsave(&tty->buf.lock, flags);
+	while((tbuf = tty->buf.head) != NULL && !tbuf->active) {
 		tty->buf.head = tbuf->next;
 		if (tty->buf.head == NULL)
 			tty->buf.tail = NULL;
-		spin_unlock_irqrestore(&tty->read_lock, flags);
+		spin_unlock_irqrestore(&tty->buf.lock, flags);
 		/* printk("Process buffer %p for %d\n", tbuf, tbuf->used); */
 		disc->receive_buf(tty, tbuf->char_buf_ptr,
 				       tbuf->flag_buf_ptr,
 				       tbuf->used);
-		spin_lock_irqsave(&tty->read_lock, flags);
+		spin_lock_irqsave(&tty->buf.lock, flags);
 		tty_buffer_free(tty, tbuf);
 	}
-	spin_unlock_irqrestore(&tty->read_lock, flags);
+	spin_unlock_irqrestore(&tty->buf.lock, flags);
 out:
 	tty_ldisc_deref(disc);
 }
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
 
--- linux-2.6.16-rc1/drivers/char/esp.c	2006-01-17 09:31:19.000000000 -0600
+++ linux-2.6.16-rc1-mg/drivers/char/esp.c	2006-01-25 09:48:23.000000000 -0600
@@ -359,7 +359,7 @@ static inline void receive_chars_pio(str
 		}
 	}
 
-	schedule_delayed_work(&tty->buf.work, 1);
+	tty_schedule_flip(tty);
 
 	info->stat_flags &= ~ESP_STAT_RX_TIMEOUT;
 	release_pio_buffer(pio_buf);
@@ -426,7 +426,7 @@ static inline void receive_chars_dma_don
 			}
 			tty_insert_flip_char(tty, dma_buffer[num_bytes - 1], statflag);
 		}
-		schedule_delayed_work(&tty->buf.work, 1);
+		tty_schedule_flip(tty);
 	}
 
 	if (dma_bytes != num_bytes) {
--- linux-2.6.16-rc1/drivers/char/cyclades.c	2006-01-17 09:31:19.000000000 -0600
+++ linux-2.6.16-rc1-mg/drivers/char/cyclades.c	2006-01-25 09:51:12.000000000 -0600
@@ -1233,7 +1233,7 @@ cyy_interrupt(int irq, void *dev_id, str
                             }
                              info->idle_stats.recv_idle = jiffies;
                         }
-                        schedule_delayed_work(&tty->buf.work, 1);
+			tty_schedule_flip(tty);
                     }
                     /* end of service */
                     cy_writeb(base_addr+(CyRIR<<index), (save_xir & 0x3f));
@@ -1606,7 +1606,7 @@ cyz_handle_rx(struct cyclades_port *info
 	    }
 #endif
 	    info->idle_stats.recv_idle = jiffies;
-	    schedule_delayed_work(&tty->buf.work, 1);
+	    tty_schedule_flip(tty);
 	}
 	/* Update rx_get */
 	cy_writel(&buf_ctrl->rx_get, new_rx_get);
@@ -1809,7 +1809,7 @@ cyz_handle_cmd(struct cyclades_card *cin
 	if(delta_count)
 	    cy_sched_event(info, Cy_EVENT_DELTA_WAKEUP);
 	if(special_count)
-	    schedule_delayed_work(&tty->buf.work, 1);
+		tty_schedule_flip(tty);
     }
 }
 

   


