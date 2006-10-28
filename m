Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752486AbWJ1NsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbWJ1NsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 09:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbWJ1NsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 09:48:13 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43493 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752479AbWJ1NsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 09:48:12 -0400
Date: Sat, 28 Oct 2006 17:47:32 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org
Subject: Re: [take21 1/4] kevent: Core files.
Message-ID: <20061028134732.GA27013@2ka.mipt.ru>
References: <11619654011980@2ka.mipt.ru> <454330BC.9000108@cosmosbay.com> <20061028105340.GC15038@2ka.mipt.ru> <45434ECF.4090209@cosmosbay.com> <20061028130350.GA18737@2ka.mipt.ru> <454359DC.4020905@cosmosbay.com> <20061028132816.GA25452@2ka.mipt.ru> <45435C7C.10705@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45435C7C.10705@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sat, 28 Oct 2006 17:47:34 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 03:34:52PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> >>>+	list_del(&k->ready_entry);
> >>Arg... no
> >>
> >>You cannot call list_del() , then check overflow_kevent.
> >>
> >>I you call list_del on what happens to be the kevent pointed by 
> >>overflow_kevent, you loose...
> >
> >This function is always called from appropriate context, where it is
> >guaranteed that it is safe to call list_del:
> >1. when kevent is removed. It is called after check, that given kevent 
> >is in the ready queue.
> >2. when dequeued from ready queue, which means that it can be removed
> >from that queue.
> >
> 
> Could you please check the list_del() function ?
> 
> file include/linux/list.h
> 
> static inline void list_del(struct list_head *entry)
> {
>   __list_del(entry->prev, entry->next);
>   entry->next = LIST_POISON1;
>   entry->prev = LIST_POISON2;
> }
> 
> So, after calling list_del(&k->read_entry);
> next and prev are basically destroyed.
> 
> So when you write later :
> 
> +        if (!err || u->overflow_kevent == k) {
> +            if (u->overflow_kevent->ready_entry.next == &u->ready_list)
> +                u->overflow_kevent = NULL;
> +            else
> +                u->overflow_kevent = + 
> list_entry(u->overflow_kevent->ready_entry.next, + 
> struct kevent, ready_entry);
> +        }
> 
> 
> then you have a problem, since
> 
> list_entry(k->ready_entry.next, struct kevent, ready_entry);
> 
> will give you garbage.

Ok, I understand you now.
To remove this issue we can delete entry from the list after all checks
with overflow_kevent pointer are completed, i.e. have something like
this:

diff --git a/kernel/kevent/kevent_user.c b/kernel/kevent/kevent_user.c
index 711a8a8..f3fec9b 100644
--- a/kernel/kevent/kevent_user.c
+++ b/kernel/kevent/kevent_user.c
@@ -235,6 +235,36 @@ static void kevent_free_rcu(struct rcu_h
 }
 
 /*
+ * Must be called under u->ready_lock.
+ * This function removes kevent from ready queue and 
+ * tries to add new kevent into ring buffer.
+ */
+static void kevent_remove_ready(struct kevent *k)
+{
+	struct kevent_user *u = k->user;
+
+	if (++u->pring[0]->uidx == KEVENT_MAX_EVENTS)
+		u->pring[0]->uidx = 0;
+
+	if (u->overflow_kevent) {
+		int err;
+
+		err = kevent_user_ring_add_event(u->overflow_kevent);
+		if (!err || u->overflow_kevent == k) {
+			if (u->overflow_kevent->ready_entry.next == &u->ready_list)
+				u->overflow_kevent = NULL;
+			else
+				u->overflow_kevent = 
+					list_entry(u->overflow_kevent->ready_entry.next, 
+							struct kevent, ready_entry);
+		}
+	}
+	list_del(&k->ready_entry);
+	k->flags &= ~KEVENT_READY;
+	u->ready_num--;
+}
+
+/*
  * Complete kevent removing - it dequeues kevent from storage list
  * if it is requested, removes kevent from ready list, drops userspace
  * control block reference counter and schedules kevent freeing through RCU.
@@ -248,11 +278,8 @@ static void kevent_finish_user_complete(
 		kevent_dequeue(k);
 
 	spin_lock_irqsave(&u->ready_lock, flags);
-	if (k->flags & KEVENT_READY) {
-		list_del(&k->ready_entry);
-		k->flags &= ~KEVENT_READY;
-		u->ready_num--;
-	}
+	if (k->flags & KEVENT_READY)
+		kevent_remove_ready(k);
 	spin_unlock_irqrestore(&u->ready_lock, flags);
 
 	kevent_user_put(u);
@@ -303,25 +330,7 @@ static struct kevent *kqueue_dequeue_rea
 	spin_lock_irqsave(&u->ready_lock, flags);
 	if (u->ready_num && !list_empty(&u->ready_list)) {
 		k = list_entry(u->ready_list.next, struct kevent, ready_entry);
-		list_del(&k->ready_entry);
-		k->flags &= ~KEVENT_READY;
-		u->ready_num--;
-		if (++u->pring[0]->uidx == KEVENT_MAX_EVENTS)
-			u->pring[0]->uidx = 0;
-		
-		if (u->overflow_kevent) {
-			int err;
-
-			err = kevent_user_ring_add_event(u->overflow_kevent);
-			if (!err) {
-				if (u->overflow_kevent->ready_entry.next == &u->ready_list)
-					u->overflow_kevent = NULL;
-				else
-					u->overflow_kevent = 
-						list_entry(u->overflow_kevent->ready_entry.next, 
-								struct kevent, ready_entry);
-			}
-		}
+		kevent_remove_ready(k);
 	}
 	spin_unlock_irqrestore(&u->ready_lock, flags);
 

Thanks.

> Eric

-- 
	Evgeniy Polyakov
