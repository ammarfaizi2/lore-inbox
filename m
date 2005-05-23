Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVEWO5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVEWO5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEWO5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:57:50 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:1926 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261879AbVEWO5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:57:43 -0400
Message-ID: <4291F134.4338A50B@tv-sign.ru>
Date: Mon, 23 May 2005 19:05:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> Changes:
>
>  - more plist fixes (Daniel Walker)

plists were changed so that all nodes are tied via ->sp_node.

Now:

	#define plist_for_each(pos1, head)	\
		list_for_each_entry(pos1, &((head)->sp_node), sp_node)

This is correct.

	plist_for_each(curr1, &old_owner->pi_waiters) {
		w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
		if (w == waiter)
			goto ok;
	}

And this is not. because:

	#define plist_entry(ptr, type, member) \
		container_of(plist_first(ptr), type, member)
			     ^^^^^^^^^^^
	struct plist * plist_first(struct plist *plist)
	{
		return list_entry(plist->dp_node.next, struct plist, dp_node);
	}

So the very first node will be skipped, iteration will be out of order,
and you will have the plist's *head* as a last element (which is not
struct rt_mutex_waiter, of course).

>  unsigned plist_empty(const struct plist *plist)
>  {
> -	return list_empty (&plist->dp_node);
> +	return list_empty(&plist->dp_node) && list_empty(&plist->sp_node);
>  }

It's enough to check list_empty(&plist->sp_node) only.


And I don't understand why __plist_add_sorted is so complecated.
Why should we consider ->prio == INT_MAX as a special case?
This is also strange:

	new_sp_head:
		itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
		list_add(&pl->sp_node, &itr_pl2->sp_node);

Why?  Just list_add_tail(&pl->sp_node, itr_pl->sp_node), you don't
need itr_pl2 at all.

Daniel, if you accepted all-nodes-tied-via-sp_node idea, could you
also look at the code I've suggested. I think it is much simpler
and understandable.

void plist_add(struct plist *new, struct plist *head)
{
	struct plist* pos;

	INIT_LIST_HEAD(&new->dp_node);

	list_for_each_entry(pos, &head->dp_node, dp_node)
		if (new->prio < pos->prio)
			goto lt_prio;
		else if (new->prio == pos->prio) {
			pos = list_entry(pos->dp_node.next,
					 struct plist, dp_node);
			goto eq_prio;
		}

lt_prio:
	list_add_tail(&new->dp_node, &pos->dp_node);
eq_prio:
	list_add_tail(&new->sp_node, &pos->sp_node);
}

void plist_del(struct plist *del)
{
	if (!list_empty(&del->dp_node)) {
		struct plist *next = list_entry(del->sp_node.next,
						struct plist, sp_node);
		list_move_tail(&next->dp_node, &del->dp_node);
		list_del_init(&del->dp_node);
	}

	list_del_init(&del->sp_node);
}

Personally, I think it is better to have pl_head for plist's head,
and pl_node for nodes. It is pointless to store ->prio in the plist's
head, it can be found in plist_first()->prio. This way we can trim
the size of rt_mutex to 32 bytes, and it is good for typechecking.

Ingo, did you see these patches?
http://marc.theaimsgroup.com/?l=linux-kernel&m=111565001426673
http://marc.theaimsgroup.com/?l=linux-kernel&m=111565001415428
http://marc.theaimsgroup.com/?l=linux-kernel&m=111565001427334
http://marc.theaimsgroup.com/?l=linux-kernel&m=111565001408303
?

What do you think?

Oleg.
