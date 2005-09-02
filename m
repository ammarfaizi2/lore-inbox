Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVIBTAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVIBTAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVIBTAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:00:05 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:59281 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750772AbVIBTAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:00:02 -0400
Message-ID: <4318A12A.4070909@acm.org>
Date: Fri, 02 Sep 2005 13:59:54 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] part 3 - Convert IPMI driver over to use refcounts
References: <1125602042.4403.7.camel@i2.minyard.local> <20050901164703.6a21f8e3.akpm@osdl.org>
In-Reply-To: <20050901164703.6a21f8e3.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>The IPMI driver uses read/write locks to ensure that things
>>exist while they are in use.  This is bad from a number of
>>points of view.  This patch removes the rwlocks and uses
>>refcounts and a special synced list (the entries can be
>>refcounted and removal is blocked while an entry is in
>>use).
>>
>>    
>>
>
>This:
>
>  
>
>>+
>>+struct synced_list_entry_task_q
>> {
>> 	struct list_head link;
>>+	task_t           *process;
>>+};
>>+
>>    
>>
>
>  
>
>>+#define synced_list_for_each_entry(pos, l, entry, flags)		\
>>+	for ((spin_lock_irqsave(&(l)->lock, flags),			      \
>>+	      pos = container_of((l)->head.next, typeof(*(pos)),entry.link)); \
>>+	     (prefetch((pos)->entry.link.next),				      \
>>+	      &(pos)->entry.link != (&(l)->head)			      \
>>+	        ? (atomic_inc(&(pos)->entry.usecount),			      \
>>+                   spin_unlock_irqrestore(&(l)->lock, flags), 1)	      \
>>+	        : (spin_unlock_irqrestore(&(l)->lock, flags), 0));	      \
>>+	     (spin_lock_irqsave(&(l)->lock, flags),			      \
>>+	      synced_list_wake(&(pos)->entry),				      \
>>+              pos = container_of((pos)->entry.link.next, typeof(*(pos)),      \
>>+				 entry.link)))
>>    
>>
>
>(gad)
>  
>
Yes, I was trying to preserve list semantics and it got out of hand. It 
is pretty ugly.

>
>And this:
>
>  
>
>>+static int synced_list_clear(struct synced_list *head,
>>+			     int (*match)(struct synced_list_entry *,
>>+					  void *),
>>+			     void (*free)(struct synced_list_entry *),
>>+			     void *match_data)
>>+{
>>+	struct synced_list_entry *ent, *ent2;
>>+	int                      rv = -ENODEV;
>>+	int                      mrv = SYNCED_LIST_MATCH_CONTINUE;
>>+
>>+	spin_lock_irq(&head->lock);
>>+ restart:
>>+	list_for_each_entry_safe(ent, ent2, &head->head, link) {
>>+		if (match) {
>>+			mrv = match(ent, match_data);
>>+			if (mrv == SYNCED_LIST_NO_MATCH)
>>+				continue;
>>+		}
>>+		if (atomic_read(&ent->usecount)) {
>>+			struct synced_list_entry_task_q e;
>>+			e.process = current;
>>+			list_add(&e.link, &ent->task_list);
>>+			__set_current_state(TASK_UNINTERRUPTIBLE);
>>+			spin_unlock_irq(&head->lock);
>>+			schedule();
>>+			spin_lock_irq(&head->lock);
>>+			list_del(&e.link);
>>+			goto restart;
>>+		}
>>+		list_del(&ent->link);
>>+		rv = 0;
>>+		if (free)
>>+			free(ent);
>>+		if (mrv == SYNCED_LIST_MATCH_STOP)
>>+			break;
>>+	}
>>+	spin_unlock_irq(&head->lock);
>>+	return rv;
>>+}
>>    
>>
>
>Look awfully similar to wait_queue_head_t.  Are you sure existing
>infrastructure cannot be used?
>  
>
I already had a lock and it seemed wasteful to have two locks. And it 
didn't really save much code and it didn't quite fit.

Basically, I need a notifier list that avoids traversal/removal race 
conditions. An asynchronous event or command comes in and you need to 
inform all the users who are waiting for events or commands. I don't 
think anything like that exists currently (the current notifier list has 
no lock on traversal). I don't want a lock around the whole traversal 
because doing callbacks with locks held is not a good idea.

The list I created simply blocks a deleter while the item is in use. 
There may be a better way to handle this, I'll think about it (and take 
any suggestions :). I read some stuff about RCU when looking at this, 
and it didn't seem suitable at the time, but I just reread it and it 
seems like it would be fine. I'll remove all this garbage and replace it 
with an RCU list.

>  
>
>>1 files changed, 692 insertions(+), 461 deletions(-)
>>    
>>
>
>Ow.  Why is it worthwhile?
>  
>
The change is definately needed. The driver, as it currently is, holds 
read locks for very long periods of time. It does this to make sure 
various objects don't get deleted. Holding read locks for this long is 
bad, and this is the job of refcounts. It's hard to break up changing 
fundamental underpinnings like this.

The patch is big, and from the above it looks like it is not quite 
ready. I'll continue to look at it.

Thank you,

-Corey
