Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758984AbWLAFF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758984AbWLAFF4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758987AbWLAFF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:05:56 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:28851
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1758980AbWLAFFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:05:54 -0500
Date: Thu, 30 Nov 2006 21:05:57 -0800 (PST)
Message-Id: <20061130.210557.55834997.davem@davemloft.net>
To: hch@infradead.org
Cc: bunk@stusta.de, chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] NET_SCH_ATM doesn't need ipcommon.o
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061127060437.GA2682@infradead.org>
References: <20061127005934.GN15364@stusta.de>
	<20061127060437.GA2682@infradead.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 27 Nov 2006 06:04:37 +0000

> On Mon, Nov 27, 2006 at 01:59:34AM +0100, Adrian Bunk wrote:
> > NET_SCH_ATM doesn't need ipcommon.o
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.19-rc6-mm1/net/atm/Makefile.old	2006-11-26 08:50:05.000000000 +0100
> > +++ linux-2.6.19-rc6-mm1/net/atm/Makefile	2006-11-26 08:56:29.000000000 +0100
> > @@ -10,7 +10,6 @@
> >  atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
> >  obj-$(CONFIG_ATM_BR2684) += br2684.o
> >  atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
> > -atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
> 
> Btw, ages ago Dave said there plans to get rid of ipcommon.c (it's just
> a single function).  Did anything ever happen towards those plans?

Let's get rid of that crap.  I just checked the following into
my net-2.6.20 tree.

commit 5465ae68b5ec11b2820db3f9b4c6fd94f113da44
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Thu Nov 30 21:05:23 2006 -0800

    [ATM]: Kill ipcommon.[ch]
    
    All that remained was skb_migrate() and that was overkill
    for what the two call sites were trying to do.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/atm/Makefile b/net/atm/Makefile
index 89656d6..cc50bd1 100644
--- a/net/atm/Makefile
+++ b/net/atm/Makefile
@@ -7,10 +7,7 @@ mpoa-objs	:= mpc.o mpoa_caches.o mpoa_pr
 
 obj-$(CONFIG_ATM) += atm.o
 obj-$(CONFIG_ATM_CLIP) += clip.o
-atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
 obj-$(CONFIG_ATM_BR2684) += br2684.o
-atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
-atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
 atm-$(CONFIG_PROC_FS) += proc.o
 
 obj-$(CONFIG_ATM_LANE) += lec.o
diff --git a/net/atm/br2684.c b/net/atm/br2684.c
index b04162f..83a1c1b 100644
--- a/net/atm/br2684.c
+++ b/net/atm/br2684.c
@@ -23,7 +23,6 @@ #include <linux/seq_file.h>
 #include <linux/atmbr2684.h>
 
 #include "common.h"
-#include "ipcommon.h"
 
 /*
  * Define this to use a version of the code which interacts with the higher
@@ -500,11 +499,12 @@ Note: we do not have explicit unassign, 
 */
 	int err;
 	struct br2684_vcc *brvcc;
-	struct sk_buff_head copy;
 	struct sk_buff *skb;
+	struct sk_buff_head *rq;
 	struct br2684_dev *brdev;
 	struct net_device *net_dev;
 	struct atm_backend_br2684 be;
+	unsigned long flags;
 
 	if (copy_from_user(&be, arg, sizeof be))
 		return -EFAULT;
@@ -554,12 +554,30 @@ Note: we do not have explicit unassign, 
 	brvcc->old_push = atmvcc->push;
 	barrier();
 	atmvcc->push = br2684_push;
-	skb_queue_head_init(&copy);
-	skb_migrate(&sk_atm(atmvcc)->sk_receive_queue, &copy);
-	while ((skb = skb_dequeue(&copy)) != NULL) {
+
+	rq = &sk_atm(atmvcc)->sk_receive_queue;
+
+	spin_lock_irqsave(&rq->lock, flags);
+	if (skb_queue_empty(rq)) {
+		skb = NULL;
+	} else {
+		/* NULL terminate the list.  */
+		rq->prev->next = NULL;
+		skb = rq->next;
+	}
+	rq->prev = rq->next = (struct sk_buff *)rq;
+	rq->qlen = 0;
+	spin_unlock_irqrestore(&rq->lock, flags);
+
+	while (skb) {
+		struct sk_buff *next = skb->next;
+
+		skb->next = skb->prev = NULL;
 		BRPRIV(skb->dev)->stats.rx_bytes -= skb->len;
 		BRPRIV(skb->dev)->stats.rx_packets--;
 		br2684_push(atmvcc, skb);
+
+		skb = next;
 	}
 	__module_get(THIS_MODULE);
 	return 0;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 1c41693..5f8a1d2 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -38,7 +38,6 @@ #include <asm/atomic.h>
 
 #include "common.h"
 #include "resources.h"
-#include "ipcommon.h"
 #include <net/atmclip.h>
 
 
@@ -469,8 +468,9 @@ static struct net_device_stats *clip_get
 static int clip_mkip(struct atm_vcc *vcc, int timeout)
 {
 	struct clip_vcc *clip_vcc;
-	struct sk_buff_head copy;
 	struct sk_buff *skb;
+	struct sk_buff_head *rq;
+	unsigned long flags;
 
 	if (!vcc->push)
 		return -EBADFD;
@@ -490,10 +490,26 @@ static int clip_mkip(struct atm_vcc *vcc
 	clip_vcc->old_pop = vcc->pop;
 	vcc->push = clip_push;
 	vcc->pop = clip_pop;
-	skb_queue_head_init(&copy);
-	skb_migrate(&sk_atm(vcc)->sk_receive_queue, &copy);
+
+	rq = &sk_atm(vcc)->sk_receive_queue;
+
+	spin_lock_irqsave(&rq->lock, flags);
+	if (skb_queue_empty(rq)) {
+		skb = NULL;
+	} else {
+		/* NULL terminate the list.  */
+		rq->prev->next = NULL;
+		skb = rq->next;
+	}
+	rq->prev = rq->next = (struct sk_buff *)rq;
+	rq->qlen = 0;
+	spin_unlock_irqrestore(&rq->lock, flags);
+
 	/* re-process everything received between connection setup and MKIP */
-	while ((skb = skb_dequeue(&copy)) != NULL)
+	while (skb) {
+		struct sk_buff *next = skb->next;
+
+		skb->next = skb->prev = NULL;
 		if (!clip_devs) {
 			atm_return(vcc, skb->truesize);
 			kfree_skb(skb);
@@ -506,6 +522,9 @@ static int clip_mkip(struct atm_vcc *vcc
 			PRIV(skb->dev)->stats.rx_bytes -= len;
 			kfree_skb(skb);
 		}
+
+		skb = next;
+	}
 	return 0;
 }
 
diff --git a/net/atm/ipcommon.c b/net/atm/ipcommon.c
deleted file mode 100644
index 1d3de42..0000000
--- a/net/atm/ipcommon.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/* net/atm/ipcommon.c - Common items for all ways of doing IP over ATM */
-
-/* Written 1996-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <linux/in.h>
-#include <linux/atmdev.h>
-#include <linux/atmclip.h>
-
-#include "common.h"
-#include "ipcommon.h"
-
-
-#if 0
-#define DPRINTK(format,args...) printk(KERN_DEBUG format,##args)
-#else
-#define DPRINTK(format,args...)
-#endif
-
-
-/*
- * skb_migrate appends the list at "from" to "to", emptying "from" in the
- * process. skb_migrate is atomic with respect to all other skb operations on
- * "from" and "to". Note that it locks both lists at the same time, so to deal
- * with the lock ordering, the locks are taken in address order.
- *
- * This function should live in skbuff.c or skbuff.h.
- */
-
-
-void skb_migrate(struct sk_buff_head *from, struct sk_buff_head *to)
-{
-	unsigned long flags;
-	struct sk_buff *skb_from = (struct sk_buff *) from;
-	struct sk_buff *skb_to = (struct sk_buff *) to;
-	struct sk_buff *prev;
-
-	if ((unsigned long) from < (unsigned long) to) {
-		spin_lock_irqsave(&from->lock, flags);
-		spin_lock_nested(&to->lock, SINGLE_DEPTH_NESTING);
-	} else {
-		spin_lock_irqsave(&to->lock, flags);
-		spin_lock_nested(&from->lock, SINGLE_DEPTH_NESTING);
-	}
-	prev = from->prev;
-	from->next->prev = to->prev;
-	prev->next = skb_to;
-	to->prev->next = from->next;
-	to->prev = from->prev;
-	to->qlen += from->qlen;
-	spin_unlock(&to->lock);
-	from->prev = skb_from;
-	from->next = skb_from;
-	from->qlen = 0;
-	spin_unlock_irqrestore(&from->lock, flags);
-}
-
-
-EXPORT_SYMBOL(skb_migrate);
diff --git a/net/atm/ipcommon.h b/net/atm/ipcommon.h
deleted file mode 100644
index d72165f..0000000
--- a/net/atm/ipcommon.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* net/atm/ipcommon.h - Common items for all ways of doing IP over ATM */
-
-/* Written 1996-2000 by Werner Almesberger, EPFL LRC/ICA */
-
-
-#ifndef NET_ATM_IPCOMMON_H
-#define NET_ATM_IPCOMMON_H
-
-
-#include <linux/string.h>
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <linux/atmdev.h>
-
-/*
- * Appends all skbs from "from" to "to". The operation is atomic with respect
- * to all other skb operations on "from" or "to".
- */
-
-void skb_migrate(struct sk_buff_head *from,struct sk_buff_head *to);
-
-#endif
