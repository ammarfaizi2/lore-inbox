Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTKETkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbTKETkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:40:04 -0500
Received: from palrel12.hp.com ([156.153.255.237]:40846 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263148AbTKETjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:39:54 -0500
Date: Wed, 5 Nov 2003 11:39:53 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrCOMM might_sleep Oops
Message-ID: <20031105193953.GB24323@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir2609_ircomm_might_sleep-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Martin Diehl>
	o [CRITICA] Don't do copy_from_user() under spinlock
	o [CRITICA] Always access self->skb under spinlock


diff -u -p linux/net/irda/ircomm/ircomm_tty.d4.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm/ircomm_tty.d4.c	Tue Nov  4 10:31:28 2003
+++ linux/net/irda/ircomm/ircomm_tty.c	Tue Nov  4 10:50:14 2003
@@ -663,9 +663,10 @@ static void ircomm_tty_do_softint(void *
  *    accepted for writing. This routine is mandatory.
  */
 static int ircomm_tty_write(struct tty_struct *tty, int from_user,
-			    const unsigned char *buf, int count)
+			    const unsigned char *ubuf, int count)
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	unsigned char *kbuf;		/* Buffer in kernel space */
 	unsigned long flags;
 	struct sk_buff *skb;
 	int tailroom = 0;
@@ -702,6 +703,24 @@ static int ircomm_tty_write(struct tty_s
 #endif
 	}
 
+	if (count < 1)
+		return 0;
+
+	/* Additional copy to avoid copy_from_user() under spinlock.
+	 * We tradeoff this extra copy to allow to pack more the
+	 * IrCOMM frames. This is advantageous because the IrDA link
+	 * is the bottleneck. */
+	if (from_user) {
+		kbuf = kmalloc(count, GFP_KERNEL);
+		if (kbuf == NULL)
+			return -ENOMEM;
+		if (copy_from_user(kbuf, ubuf, count))
+			return -EFAULT;
+	} else
+		/* The buffer is already in kernel space */
+		kbuf = (unsigned char *) ubuf;
+
+	/* Protect our manipulation of self->tx_skb and related */
 	spin_lock_irqsave(&self->spinlock, flags);
 
 	/* Fetch current transmit buffer */
@@ -761,19 +780,19 @@ static int ircomm_tty_write(struct tty_s
 			 * change later on - Jean II */
 			self->tx_data_size = self->max_data_size;
 		}
-		
+
 		/* Copy data */
-		if (from_user)
-			copy_from_user(skb_put(skb,size), buf+len, size);
-		else
-			memcpy(skb_put(skb,size), buf+len, size);
-		
+		memcpy(skb_put(skb,size), kbuf + len, size);
+
 		count -= size;
 		len += size;
 	}
 
 	spin_unlock_irqrestore(&self->spinlock, flags);
 
+	if (from_user)
+		kfree(kbuf);
+
 	/*     
 	 * Schedule a new thread which will transmit the frame as soon
 	 * as possible, but at a safe point in time. We do this so the
@@ -837,6 +856,7 @@ static void ircomm_tty_wait_until_sent(s
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
 	unsigned long orig_jiffies, poll_time;
+	unsigned long flags;
 	
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__ );
 
@@ -848,14 +868,18 @@ static void ircomm_tty_wait_until_sent(s
 	/* Set poll time to 200 ms */
 	poll_time = IRDA_MIN(timeout, MSECS_TO_JIFFIES(200));
 
+	spin_lock_irqsave(&self->spinlock, flags);
 	while (self->tx_skb && self->tx_skb->len) {
+		spin_unlock_irqrestore(&self->spinlock, flags);
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(poll_time);
+		spin_lock_irqsave(&self->spinlock, flags);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
+	spin_unlock_irqrestore(&self->spinlock, flags);
 	current->state = TASK_RUNNING;
 }
 
