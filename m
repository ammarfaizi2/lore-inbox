Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWHDMh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWHDMh4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 08:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbWHDMh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 08:37:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57325 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161150AbWHDMh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 08:37:56 -0400
Subject: PATCH: Fix tty layer DoS and comment relevant code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 13:57:22 +0100
Message-Id: <1154696242.23655.220.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other tty comment patch this one has code changes.
Specifically it limits the queue size for a tty to 64K characters
(128Kbytes) worst case even if the tty is ignoring tty->throttle. This
is because certain drivers don't honour the throttle value correctly,
although it is a useful safeguard anyway.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_io.c linux-2.6.18-rc2-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_io.c	2006-07-27 16:19:51.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/tty_io.c	2006-08-04 13:02:22.306400960 +0100
@@ -235,6 +264,17 @@
  * Tty buffer allocation management
  */
 
+
+/**
+ *	tty_buffer_free_all		-	free buffers used by a tty
+ *	@tty: tty to free from
+ *
+ *	Remove all the buffers pending on a tty whether queued with data
+ *	or in the free ring. Must be called when the tty is no longer in use
+ *
+ *	Locking: none
+ */
+ 
 static void tty_buffer_free_all(struct tty_struct *tty)
 {
 	struct tty_buffer *thead;
@@ -247,19 +287,47 @@
 		kfree(thead);
 	}
 	tty->buf.tail = NULL;
+	tty->buf.memory_used = 0;
 }
 
+/**
+ *	tty_buffer_init		-	prepare a tty buffer structure
+ *	@tty: tty to initialise
+ *
+ *	Set up the initial state of the buffer management for a tty device.
+ *	Must be called before the other tty buffer functions are used.
+ *
+ *	Locking: none
+ */
+ 
 static void tty_buffer_init(struct tty_struct *tty)
 {
 	spin_lock_init(&tty->buf.lock);
 	tty->buf.head = NULL;
 	tty->buf.tail = NULL;
 	tty->buf.free = NULL;
+	tty->buf.memory_used = 0;
 }
 
-static struct tty_buffer *tty_buffer_alloc(size_t size)
+/**
+ *	tty_buffer_alloc	-	allocate a tty buffer
+ *	@tty: tty device
+ *	@size: desired size (characters)
+ *
+ *	Allocate a new tty buffer to hold the desired number of characters.
+ *	Return NULL if out of memory or the allocation would exceed the
+ *	per device queue
+ *
+ *	Locking: Caller must hold tty->buf.lock
+ */
+ 
+static struct tty_buffer *tty_buffer_alloc(struct tty_struct *tty, size_t size)
 {
-	struct tty_buffer *p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
+	struct tty_buffer *p;
+
+	if (tty->buf.memory_used + size > 65536)
+		return NULL;
+	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
 	if(p == NULL)
 		return NULL;
 	p->used = 0;
@@ -269,17 +337,27 @@
 	p->read = 0;
 	p->char_buf_ptr = (char *)(p->data);
 	p->flag_buf_ptr = (unsigned char *)p->char_buf_ptr + size;
-/* 	printk("Flip create %p\n", p); */
+	tty->buf.memory_used += size;
 	return p;
 }
 
-/* Must be called with the tty_read lock held. This needs to acquire strategy
-   code to decide if we should kfree or relink a given expired buffer */
+/**
+ *	tty_buffer_free		-	free a tty buffer
+ *	@tty: tty owning the buffer
+ *	@b: the buffer to free
+ *
+ *	Free a tty buffer, or add it to the free list according to our
+ *	internal strategy
+ *
+ *	Locking: Caller must hold tty->buf.lock
+ */
 
 static void tty_buffer_free(struct tty_struct *tty, struct tty_buffer *b)
 {
 	/* Dumb strategy for now - should keep some stats */
-/* 	printk("Flip dispose %p\n", b); */
+	tty->buf.memory_used -= b->size;
+	WARN_ON(tty->buf.memory_used < 0);
+
 	if(b->size >= 512)
 		kfree(b);
 	else {
@@ -288,6 +366,18 @@
 	}
 }
 
+/**
+ *	tty_buffer_find		-	find a free tty buffer
+ *	@tty: tty owning the buffer
+ *	@size: characters wanted
+ *
+ *	Locate an existing suitable tty buffer or if we are lacking one then
+ *	allocate a new one. We round our buffers off in 256 character chunks
+ *	to get better allocation behaviour.
+ *
+ *	Locking: Caller must hold tty->buf.lock
+ */
+
 static struct tty_buffer *tty_buffer_find(struct tty_struct *tty, size_t size)
 {
 	struct tty_buffer **tbh = &tty->buf.free;
@@ -299,20 +389,29 @@
 			t->used = 0;
 			t->commit = 0;
 			t->read = 0;
-			/* DEBUG ONLY */
-			memset(t->data, '*', size);
-/* 			printk("Flip recycle %p\n", t); */
+			tty->buf.memory_used += t->size;
 			return t;
 		}
 		tbh = &((*tbh)->next);
 	}
 	/* Round the buffer size out */
 	size = (size + 0xFF) & ~ 0xFF;
-	return tty_buffer_alloc(size);
+	return tty_buffer_alloc(tty, size);
 	/* Should possibly check if this fails for the largest buffer we
 	   have queued and recycle that ? */
 }
 
+/**
+ *	tty_buffer_request_room		-	grow tty buffer if needed
+ *	@tty: tty structure
+ *	@size: size desired
+ *
+ *	Make at least size bytes of linear space available for the tty
+ *	buffer. If we fail return the size we managed to find.
+ *
+ *	Locking: Takes tty->buf.lock
+ */
+ 
 int tty_buffer_request_room(struct tty_struct *tty, size_t size)
 {
 	struct tty_buffer *b, *n;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/include/linux/tty.h linux-2.6.18-rc2-mm1/include/linux/tty.h
--- linux.vanilla-2.6.18-rc2-mm1/include/linux/tty.h	2006-07-27 16:19:26.000000000 +0100
+++ linux-2.6.18-rc2-mm1/include/linux/tty.h	2006-07-27 16:45:37.000000000 +0100
@@ -59,6 +59,7 @@
 	struct tty_buffer *head;	/* Queue head */
 	struct tty_buffer *tail;	/* Active buffer */
 	struct tty_buffer *free;	/* Free queue head */
+	int memory_used;		/* Buffer space used excluding free queue */
 };
 /*
  * The pty uses char_buf and flag_buf as a contiguous buffer

