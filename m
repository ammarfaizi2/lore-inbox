Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWGLGtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWGLGtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWGLGtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:49:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32469 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750733AbWGLGtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:49:49 -0400
Subject: Re: [openib-general] ipoib lockdep warning
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Zach Brown <zach.brown@oracle.com>, openib-general@openib.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <ada7j2jzh5o.fsf@cisco.com>
References: <44B405C8.4040706@oracle.com>  <ada7j2jzh5o.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 08:49:38 +0200
Message-Id: <1152686978.3217.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 19:33 -0700, Roland Dreier wrote:
> OK, the patch to lib/idr.c below is at least one way to fix this.
> However, with that applied I get the lockdep warning below, which
> seems to be a false positive -- I'm not sure what the right fix is,
> but the blame really seems to fall on udp_ioctl for poking into the
> sk_buff_head lock itself.

this does not have to be a false positive!
It is not legal to take ANY non-hardirq safe lock after having taken a
lock that's used in hardirq context.
(having said that the skb_queue_tail lock needs a  special treatment for
some real false positives; Linus merged that already)

> And here's the warning I get, which appears to be a false positive:
> 
> ======================================================
> [ INFO: hard-safe -> hard-unsafe lock order detected ]
> ------------------------------------------------------
> swapper/0 [HC0[0]:SC1[2]:HE0:SE0] is trying to acquire:
>  (&skb_queue_lock_key){-+..}, at: [<ffffffff8038683e>] skb_queue_tail+0x1d/0x47
> 
> and this task is already holding:
>  (&priv->lock){.+..}, at: [<ffffffff881efd5b>] ipoib_mcast_send+0x29/0x413 [ib_ipoib]
> which would create a new lock dependency:
>  (&priv->lock){.+..} -> (&skb_queue_lock_key){-+..}
> 

Lets call priv->lock lock A, and the skb_queue_lock lock B to keep this
short


CPU 0			CPU 1
soft irq context	user or softirq context

take lock B
(anywhere in net stack)
			take lock A 
			(ipoib_mcast_send)

interrupt happens

take lock A (spins)
in ISR somewhere

			take lock B (spins)
			(in skb_queue_tail() called from
			ipoib_mcast_send)




Now this assumes your queue is shared with the networking stack,
so that the first "take lock B" on CPU 0 can happen without disabling interrupts.
(as several of the SKB functions do that get used by the networking stack, but not
 the simple ones used by drivers for private queues).
If this queue used in ipoib_mcast_send() is a private queue you probably want to 
apply the patch below (already in/on its way to mainline)

Index: linux-2.6.18-rc1/include/linux/skbuff.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/skbuff.h
+++ linux-2.6.18-rc1/include/linux/skbuff.h
@@ -606,10 +606,17 @@ static inline __u32 skb_queue_len(const 
 
 extern struct lock_class_key skb_queue_lock_key;
 
+/*
+ * This function creates a split out lock class for each invocation;
+ * this is needed for now since a whole lot of users of the skb-queue
+ * infrastructure in drivers have different locking usage (in hardirq)
+ * than the networking core (in softirq only). In the long run either the
+ * network layer or drivers should need annotation to consolidate the
+ * main types of usage into 3 classes.
+ */
 static inline void skb_queue_head_init(struct sk_buff_head *list)
 {
 	spin_lock_init(&list->lock);
-	lockdep_set_class(&list->lock, &skb_queue_lock_key);
 	list->prev = list->next = (struct sk_buff *)list;
 	list->qlen = 0;
 }


