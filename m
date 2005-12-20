Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVLTRPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVLTRPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVLTRPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:15:52 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:21703 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750796AbVLTRPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:15:52 -0500
Message-ID: <43A84DFD.D8B2151F@tv-sign.ru>
Date: Tue, 20 Dec 2005 21:31:25 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
References: <43A5A7B5.21A4CAAE@tv-sign.ru>  <20051220143848.GA2053@elte.hu> <1135096463.3834.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> On Tue, 2005-12-20 at 15:38 +0100, Ingo Molnar wrote:
> > * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> I think there is a bug in the new plist_add() , which was in the
> original code. It doesn't properly handle the new maximum node scenario,
> or INT_MAX .
> 
> If the list is 1 2 3 4
> 
> and you insert 5 , you'll end up with the list 1 2 3 5 4 . Or something
> like that .

I think you are not right, please look at the code.

The code under list_for_each_entry() can break the loop only
when node->prio <= iter->prio.

void plist_add(struct pl_node *node, struct pl_head *head)
{
	struct pl_node *iter;

	list_for_each_entry(iter, &head->prio_list, plist.prio_list)
		if (node->prio < iter->prio)
			goto lt_prio;
		else if (node->prio == iter->prio)
			...

	// So, node->prio is a new maximum, or the list was empty.

	// &iter.plist == head. We don't touch iter->prio, so it
	// is ok that this pl_node is fake, it is really pl_head.

	// We are doing list_add_tail(), this means that new node
	// will stay _after_ all other nodes.

	// In this case the code below is equal to:
	//
	//	list_add_tail(&node->plist.prio_list, &head->prio_list);
	//	list_add_tail(&node->plist.prio_list, &head->node_list);

lt_prio:
	list_add_tail(&node->plist.prio_list, &iter->plist.prio_list);
eq_prio:
	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
}

Note that this also garantees FIFO ordering, which was documented
in plist.h, but was not true for plist_for_each().

Daniel, do you agree ?

Oleg.
