Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbTLYKWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTLYKWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 05:22:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:33505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264278AbTLYKWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 05:22:32 -0500
Date: Thu, 25 Dec 2003 02:22:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: sebek64@post.cz (Marcel Sebek)
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make ppp_async callable from hard interrupt
Message-Id: <20031225022228.69f78d18.akpm@osdl.org>
In-Reply-To: <20031225100850.GA6629@penguin.localdomain>
References: <16356.60597.133074.809551@cargo.ozlabs.ibm.com>
	<20031225100850.GA6629@penguin.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sebek64@post.cz (Marcel Sebek) wrote:
>
> On Sun, Dec 21, 2003 at 11:43:33AM +1100, Paul Mackerras wrote:
>  >  /* called when a flag is seen - do end-of-packet processing */
>  > -static inline void
>  > +static void
>  >  process_input_packet(struct asyncppp *ap)
>  >  {
>  >  	struct sk_buff *skb;
>  >  	unsigned char *p;
>  >  	unsigned int len, fcs, proto;
>  > -	int code = 0;
>  > +
>  > +	if (ap->state & (SC_TOSS | SC_ESCAPE))
>  > +		goto err;
>  If this is true, skb will be used uninitialized.

True.    Here's an updated patch.


diff -puN drivers/net/ppp_async.c~ppp_async-locking-fix drivers/net/ppp_async.c
--- 25/drivers/net/ppp_async.c~ppp_async-locking-fix	2003-12-25 02:22:14.000000000 -0800
+++ 25-akpm/drivers/net/ppp_async.c	2003-12-25 02:22:14.000000000 -0800
@@ -16,8 +16,6 @@
  * Part of the code in this driver was inspired by the old async-only
  * PPP driver, written by Michael Callahan and Al Longyear, and
  * subsequently hacked by Paul Mackerras.
- *
- * ==FILEVERSION 20020125==
  */
 
 #include <linux/module.h>
@@ -61,6 +59,9 @@ struct asyncppp {
 
 	struct sk_buff	*rpkt;
 	int		lcp_fcs;
+	struct sk_buff_head rqueue;
+
+	struct tasklet_struct tsk;
 
 	atomic_t	refcnt;
 	struct semaphore dead_sem;
@@ -74,8 +75,9 @@ struct asyncppp {
 #define XMIT_BUSY	2
 
 /* State bits */
-#define SC_TOSS		0x20000000
-#define SC_ESCAPE	0x40000000
+#define SC_TOSS		1
+#define SC_ESCAPE	2
+#define SC_PREV_ERROR	4
 
 /* Bits in rbits */
 #define SC_RCV_BITS	(SC_RCV_B7_1|SC_RCV_B7_0|SC_RCV_ODDP|SC_RCV_EVNP)
@@ -97,6 +99,8 @@ static void ppp_async_input(struct async
 			    char *flags, int count);
 static int ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd,
 			   unsigned long arg);
+static void ppp_async_process(unsigned long arg);
+
 static void async_lcp_peek(struct asyncppp *ap, unsigned char *data,
 			   int len, int inbound);
 
@@ -165,6 +169,9 @@ ppp_asynctty_open(struct tty_struct *tty
 	ap->olim = ap->obuf;
 	ap->lcp_fcs = -1;
 
+	skb_queue_head_init(&ap->rqueue);
+	tasklet_init(&ap->tsk, ppp_async_process, (unsigned long) ap);
+
 	atomic_set(&ap->refcnt, 1);
 	init_MUTEX_LOCKED(&ap->dead_sem);
 
@@ -214,10 +221,12 @@ ppp_asynctty_close(struct tty_struct *tt
 	 */
 	if (!atomic_dec_and_test(&ap->refcnt))
 		down(&ap->dead_sem);
+	tasklet_kill(&ap->tsk);
 
 	ppp_unregister_channel(&ap->chan);
 	if (ap->rpkt != 0)
 		kfree_skb(ap->rpkt);
+	skb_queue_purge(&ap->rqueue);
 	if (ap->tpkt != 0)
 		kfree_skb(ap->tpkt);
 	kfree(ap);
@@ -316,17 +325,24 @@ ppp_asynctty_room(struct tty_struct *tty
 	return 65535;
 }
 
+/*
+ * This can now be called from hard interrupt level as well
+ * as soft interrupt level or mainline.
+ */
 static void
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
-		  char *flags, int count)
+		  char *cflags, int count)
 {
 	struct asyncppp *ap = ap_get(tty);
+	unsigned long flags;
 
 	if (ap == 0)
 		return;
-	spin_lock_bh(&ap->recv_lock);
-	ppp_async_input(ap, buf, flags, count);
-	spin_unlock_bh(&ap->recv_lock);
+	spin_lock_irqsave(&ap->recv_lock, flags);
+	ppp_async_input(ap, buf, cflags, count);
+	spin_unlock_irqrestore(&ap->recv_lock, flags);
+	if (skb_queue_len(&ap->rqueue))
+		tasklet_schedule(&ap->tsk);
 	ap_put(ap);
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags)
 	    && tty->driver->unthrottle)
@@ -341,8 +357,8 @@ ppp_asynctty_wakeup(struct tty_struct *t
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (ap == 0)
 		return;
-	if (ppp_async_push(ap))
-		ppp_output_wakeup(&ap->chan);
+	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
+	tasklet_schedule(&ap->tsk);
 	ap_put(ap);
 }
 
@@ -396,9 +412,9 @@ ppp_async_ioctl(struct ppp_channel *chan
 		if (get_user(val, (int *) arg))
 			break;
 		ap->flags = val & ~SC_RCV_BITS;
-		spin_lock_bh(&ap->recv_lock);
+		spin_lock_irq(&ap->recv_lock);
 		ap->rbits = val & SC_RCV_BITS;
-		spin_unlock_bh(&ap->recv_lock);
+		spin_unlock_irq(&ap->recv_lock);
 		err = 0;
 		break;
 
@@ -460,6 +476,28 @@ ppp_async_ioctl(struct ppp_channel *chan
 }
 
 /*
+ * This is called at softirq level to deliver received packets
+ * to the ppp_generic code, and to tell the ppp_generic code
+ * if we can accept more output now.
+ */
+static void ppp_async_process(unsigned long arg)
+{
+	struct asyncppp *ap = (struct asyncppp *) arg;
+	struct sk_buff *skb;
+
+	/* process received packets */
+	while ((skb = skb_dequeue(&ap->rqueue)) != NULL) {
+		if (skb->cb[0])
+			ppp_input_error(&ap->chan, 0);
+		ppp_input(&ap->chan, skb);
+	}
+
+	/* try to push more stuff out */
+	if (test_bit(XMIT_WAKEUP, &ap->xmit_flags) && ppp_async_push(ap))
+		ppp_output_wakeup(&ap->chan);
+}
+
+/*
  * Procedures for encapsulation and framing.
  */
 
@@ -641,7 +679,6 @@ ppp_async_push(struct asyncppp *ap)
 	struct tty_struct *tty = ap->tty;
 	int tty_stuffed = 0;
 
-	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
 	/*
 	 * We can get called recursively here if the tty write
 	 * function calls our wakeup function.  This can happen
@@ -752,22 +789,19 @@ scan_ordinary(struct asyncppp *ap, const
 }
 
 /* called when a flag is seen - do end-of-packet processing */
-static inline void
+static void
 process_input_packet(struct asyncppp *ap)
 {
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	unsigned char *p;
 	unsigned int len, fcs, proto;
-	int code = 0;
+
+	if (ap->state & (SC_TOSS | SC_ESCAPE))
+		goto err;
 
 	skb = ap->rpkt;
-	ap->rpkt = 0;
-	if ((ap->state & (SC_TOSS | SC_ESCAPE)) || skb == 0) {
-		ap->state &= ~(SC_TOSS | SC_ESCAPE);
-		if (skb != 0)
-			kfree_skb(skb);
-		return;
-	}
+	if (skb == NULL)
+		return;		/* 0-length packet */
 
 	/* check the FCS */
 	p = skb->data;
@@ -801,20 +835,18 @@ process_input_packet(struct asyncppp *ap
 			async_lcp_peek(ap, p, skb->len, 1);
 	}
 
-	/* all OK, give it to the generic layer */
-	ppp_input(&ap->chan, skb);
+	/* queue the frame to be processed */
+	skb->cb[0] = ap->state;
+	skb_queue_tail(&ap->rqueue, skb);
+	ap->rpkt = 0;
+	ap->state = 0;
 	return;
 
  err:
-	kfree_skb(skb);
-	ppp_input_error(&ap->chan, code);
-}
-
-static inline void
-input_error(struct asyncppp *ap, int code)
-{
-	ap->state |= SC_TOSS;
-	ppp_input_error(&ap->chan, code);
+	/* frame had an error, remember that, reset SC_TOSS & SC_ESCAPE */
+	ap->state = SC_PREV_ERROR;
+	if (skb)
+		skb_trim(skb, 0);
 }
 
 /* called when the tty driver has data for us. */
@@ -856,7 +888,7 @@ ppp_async_input(struct asyncppp *ap, con
 		}
 		if (f != 0) {
 			/* start tossing */
-			input_error(ap, f);
+			ap->state |= SC_TOSS;
 
 		} else if (n > 0 && (ap->state & SC_TOSS) == 0) {
 			/* stuff the chars in the skb */
@@ -872,7 +904,7 @@ ppp_async_input(struct asyncppp *ap, con
 			}
 			if (n > skb_tailroom(skb)) {
 				/* packet overflowed MRU */
-				input_error(ap, 1);
+				ap->state |= SC_TOSS;
 			} else {
 				sp = skb_put(skb, n);
 				memcpy(sp, buf, n);
@@ -909,7 +941,7 @@ ppp_async_input(struct asyncppp *ap, con
 
  nomem:
 	printk(KERN_ERR "PPPasync: no memory (input pkt)\n");
-	input_error(ap, 0);
+	ap->state |= SC_TOSS;
 }
 
 /*

_

