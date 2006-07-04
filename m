Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWGDQNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWGDQNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWGDQNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:13:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32170 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932232AbWGDQNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:13:05 -0400
Subject: Re: possible recursive locking in ATM layer
From: Arjan van de Ven <arjan@infradead.org>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, chas@cmf.nrl.navy.mil
In-Reply-To: <200607041759.43064.duncan.sands@math.u-psud.fr>
References: <200607041759.43064.duncan.sands@math.u-psud.fr>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 18:13:02 +0200
Message-Id: <1152029582.3109.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Arjan van de Ven <arjan@linux.intel.com>

> Linux version 2.6.17-git22 (duncan@baldrick) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #20 PREEMPT Tue Jul 4 10:35:04 CEST 2006
> 
> [ 2381.598609] =============================================
> [ 2381.619314] [ INFO: possible recursive locking detected ]
> [ 2381.635497] ---------------------------------------------
> [ 2381.651706] atmarpd/2696 is trying to acquire lock:
> [ 2381.666354]  (&skb_queue_lock_key){-+..}, at: [<c028c540>] skb_migrate+0x24/0x6c
> [ 2381.688848]


ok this is a real potential deadlock in a way, it takes two locks of 2
skbuffs without doing any kind of lock ordering; I think the following
patch should fix it. Just sort the lock taking order by address of the
skb.. it's not pretty but it's the best this can do in a minimally
invasive way.

I still agree with the comment that this code shouldn't live in the atm
layer...

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 net/atm/ipcommon.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-2.6.17-mm6/net/atm/ipcommon.c
===================================================================
--- linux-2.6.17-mm6.orig/net/atm/ipcommon.c
+++ linux-2.6.17-mm6/net/atm/ipcommon.c
@@ -25,8 +25,8 @@
 /*
  * skb_migrate appends the list at "from" to "to", emptying "from" in the
  * process. skb_migrate is atomic with respect to all other skb operations on
- * "from" and "to". Note that it locks both lists at the same time, so beware
- * of potential deadlocks.
+ * "from" and "to". Note that it locks both lists at the same time, so to deal
+ * with the lock ordering, the locks are taken in address order.
  *
  * This function should live in skbuff.c or skbuff.h.
  */
@@ -39,8 +39,13 @@ void skb_migrate(struct sk_buff_head *fr
 	struct sk_buff *skb_to = (struct sk_buff *) to;
 	struct sk_buff *prev;
 
-	spin_lock_irqsave(&from->lock,flags);
-	spin_lock(&to->lock);
+	if (from<to) {
+		spin_lock_irqsave(&from->lock,flags);
+		spin_lock_nested(&to->lock, SINGLE_DEPTH_NESTING);
+	} else {
+		spin_lock_irqsave(&to->lock, flags);
+		spin_lock_nested(&from->lock, SINGLE_DEPTH_NESTING);
+	}
 	prev = from->prev;
 	from->next->prev = to->prev;
 	prev->next = skb_to;


