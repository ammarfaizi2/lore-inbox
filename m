Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVEFLGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVEFLGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 07:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEFLGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 07:06:14 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:46812 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261210AbVEFLGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 07:06:05 -0400
Message-ID: <427B5147.36DE54D1@tv-sign.ru>
Date: Fri, 06 May 2005 15:13:11 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Priority Lists for the RT mutex
References: <427B333F.5A0BB431@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
>
> Daniel Walker wrote:
> >
> > Description:
> > 	This patch adds the priority list data structure from Inaky Perez-Gonzalez
> > to the Preempt Real-Time mutex.
> >
> ...
>
> I can't understand how this can work.

And I think it is possible to simplify plist's design.

struct plist {
	int prio;
	struct list_head prio_list;
	struct list_head node_list;
};

#define	plist_for_each(pos, head)	\
	 list_for_each_entry(pos, &(head)->node_list, node_list)

static inline void plist_add(struct plist *new, struct plist *head)
{
	struct plist* pos;

	INIT_LIST_HEAD(&new->prio_list);

	list_for_each_entry(pos, &head->prio_list, prio_list)
		if (new->prio < pos->prio)
			goto lt_prio;
		else if (new->prio == pos->prio) {
			pos = list_entry(pos->prio_list.next,
					 struct plist, prio_list);
			goto eq_prio;
		}

lt_prio:
	list_add_tail(&new->prio_list, &pos->prio_list);
eq_prio:
	list_add_tail(&new->node_list, &pos->node_list);
}

static inline void plist_del(struct plist *del)
{
	if (!list_empty(&del->prio_list)) {
		struct plist *next = list_entry(del->node_list.next,
						struct plist, node_list);
		list_move_tail(&next->prio_list, &del->prio_list);
		list_del_init(&del->prio_list);
	}

	list_del_init(&del->node_list);
}

All nodes in prio list are chained via ->node_list, sorted in ascending
->prio/fifo order. Nodes which start different priority slice are chained
via ->prio_list, ascending ->prio order.

Slightly tested, seems to work.

I think this would be even better:

struct plist_head {
	struct list_head prio_list;
	struct list_head node_list;
}

struct plist {
	int prio;
	struct plist_head head;
}

The plist_head's min/max prio can be found from
plist_head.prio_list.next/prev.

What do you think?

Oleg.
