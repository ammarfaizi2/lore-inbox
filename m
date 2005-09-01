Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbVIAXoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbVIAXoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbVIAXoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:44:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030542AbVIAXoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:44:38 -0400
Date: Thu, 1 Sep 2005 16:47:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] part 3 - Convert IPMI driver over to use refcounts
Message-Id: <20050901164703.6a21f8e3.akpm@osdl.org>
In-Reply-To: <1125602042.4403.7.camel@i2.minyard.local>
References: <1125602042.4403.7.camel@i2.minyard.local>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The IPMI driver uses read/write locks to ensure that things
> exist while they are in use.  This is bad from a number of
> points of view.  This patch removes the rwlocks and uses
> refcounts and a special synced list (the entries can be
> refcounted and removal is blocked while an entry is in
> use).
> 

This:

> +
> +struct synced_list_entry_task_q
>  {
>  	struct list_head link;
> +	task_t           *process;
> +};
> +

> +#define synced_list_for_each_entry(pos, l, entry, flags)		\
> +	for ((spin_lock_irqsave(&(l)->lock, flags),			      \
> +	      pos = container_of((l)->head.next, typeof(*(pos)),entry.link)); \
> +	     (prefetch((pos)->entry.link.next),				      \
> +	      &(pos)->entry.link != (&(l)->head)			      \
> +	        ? (atomic_inc(&(pos)->entry.usecount),			      \
> +                   spin_unlock_irqrestore(&(l)->lock, flags), 1)	      \
> +	        : (spin_unlock_irqrestore(&(l)->lock, flags), 0));	      \
> +	     (spin_lock_irqsave(&(l)->lock, flags),			      \
> +	      synced_list_wake(&(pos)->entry),				      \
> +              pos = container_of((pos)->entry.link.next, typeof(*(pos)),      \
> +				 entry.link)))

(gad)


And this:

> +static int synced_list_clear(struct synced_list *head,
> +			     int (*match)(struct synced_list_entry *,
> +					  void *),
> +			     void (*free)(struct synced_list_entry *),
> +			     void *match_data)
> +{
> +	struct synced_list_entry *ent, *ent2;
> +	int                      rv = -ENODEV;
> +	int                      mrv = SYNCED_LIST_MATCH_CONTINUE;
> +
> +	spin_lock_irq(&head->lock);
> + restart:
> +	list_for_each_entry_safe(ent, ent2, &head->head, link) {
> +		if (match) {
> +			mrv = match(ent, match_data);
> +			if (mrv == SYNCED_LIST_NO_MATCH)
> +				continue;
> +		}
> +		if (atomic_read(&ent->usecount)) {
> +			struct synced_list_entry_task_q e;
> +			e.process = current;
> +			list_add(&e.link, &ent->task_list);
> +			__set_current_state(TASK_UNINTERRUPTIBLE);
> +			spin_unlock_irq(&head->lock);
> +			schedule();
> +			spin_lock_irq(&head->lock);
> +			list_del(&e.link);
> +			goto restart;
> +		}
> +		list_del(&ent->link);
> +		rv = 0;
> +		if (free)
> +			free(ent);
> +		if (mrv == SYNCED_LIST_MATCH_STOP)
> +			break;
> +	}
> +	spin_unlock_irq(&head->lock);
> +	return rv;
> +}

Look awfully similar to wait_queue_head_t.  Are you sure existing
infrastructure cannot be used?

> 1 files changed, 692 insertions(+), 461 deletions(-)

Ow.  Why is it worthwhile?
