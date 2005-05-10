Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVEJLL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVEJLL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVEJLL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:11:29 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:40641 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261595AbVEJLLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:11:23 -0400
Message-ID: <42809897.3956381A@tv-sign.ru>
Date: Tue, 10 May 2005 15:18:47 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH 2/4] rt_mutex: add new plist implementation
References: <F989B1573A3A644BAB3920FBECA4D25A0335DBE0@orsmsx407>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" wrote:
>
> >From: Oleg Nesterov
>
> >+extern void plist_add(struct pl_node *node, struct pl_head *head);
> >+extern void plist_del(struct pl_node *node);
>
> At least I'd add return codes for this if the head's priority=20
> changes (or in this case, because head's have no prio, if the=20
> first node's  prio change).

I am not sure I understand you. Why should we track ->prio=20 changes?
plist should be generic, I think.

Original code:
	unsigned plist_add (struct plist *pl, struct plist *plist)
	{
		__plist_add_sorted (plist, pl);
		if (pl->prio < plist->prio) {
			plist->prio = pl->prio;
			return !0;
		}
		return 0;
	}

This could be:
	int plist_add_and_check_min_prio_changed(node, head)
	{
		plist_add(node, head);
		return plist_next(head) == node;
	}

Or plist_add() could be easily changed to return -1,0,+1 to indicate
min/max prio changed/unchanged.

But may be it is better to return 'iter' from plist_add(). This way
we can avoid scanning ->prio_list when we add the node with the same
->prio next time. I am not sure.

And please note that pl_head "has" prio:

	plist_empty(head) ? INT_MAX			// -1 ?
			  : plist_next(head)->prio

> Both function's  logic should make it easy to test and it'd save
> a lot of code in the caller.

Currently these functions are used in void context only. I think
it is better to add return codes when callers need them.

What do you think?

Oleg.
