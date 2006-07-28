Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWG1New@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWG1New (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 09:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWG1New
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 09:34:52 -0400
Received: from [81.2.110.250] ([81.2.110.250]:42963 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030242AbWG1Nev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 09:34:51 -0400
Subject: [PATCH]: tty buffering limit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1153941029.6903.5.camel@amdx2.microgate.com>
References: <200607221209_MC3-1-C5CA-50EB@compuserve.com>
	 <44C25548.5070307@microgate.com> <20060725184158.GH9021@kroah.com>
	 <44C66D1C.7010903@microgate.com>  <20060726071652.GA6204@kroah.com>
	 <1153941029.6903.5.camel@amdx2.microgate.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 14:53:36 +0100
Message-Id: <1154094816.13509.132.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Certain people seem to have assumed tty->throttled was 'advisory'. In
the absence of tty->author->throttle(), it seems we should keep a simple
limit of our own to avoid problems when this occurs. 

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_io.c linux-2.6.18-rc2-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/char/tty_io.c	2006-07-27 16:19:51.000000000 +0100
+++ linux-2.6.18-rc2-mm1/drivers/char/tty_io.c	2006-07-27 16:44:17.000000000 +0100
@@ -247,6 +247,7 @@
 		kfree(thead);
 	}
 	tty->buf.tail = NULL;
+	tty->buf.memory_used = 0;
 }
 
 static void tty_buffer_init(struct tty_struct *tty)
@@ -255,11 +256,16 @@
 	tty->buf.head = NULL;
 	tty->buf.tail = NULL;
 	tty->buf.free = NULL;
+	tty->buf.memory_used = 0;
 }
 
-static struct tty_buffer *tty_buffer_alloc(size_t size)
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
@@ -269,7 +275,7 @@
 	p->read = 0;
 	p->char_buf_ptr = (char *)(p->data);
 	p->flag_buf_ptr = (unsigned char *)p->char_buf_ptr + size;
-/* 	printk("Flip create %p\n", p); */
+	tty->buf.memory_used += size;
 	return p;
 }
 
@@ -279,7 +285,9 @@
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
@@ -299,16 +307,14 @@
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

