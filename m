Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVLTR3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVLTR3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVLTR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:29:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49146 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750716AbVLTR3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:29:35 -0500
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
In-Reply-To: <43A84DFD.D8B2151F@tv-sign.ru>
References: <43A5A7B5.21A4CAAE@tv-sign.ru>  <20051220143848.GA2053@elte.hu>
	 <1135096463.3834.3.camel@localhost.localdomain>
	 <43A84DFD.D8B2151F@tv-sign.ru>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 09:29:33 -0800
Message-Id: <1135099773.3834.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 21:31 +0300, Oleg Nesterov wrote:
> Daniel Walker wrote:
> > 
> > On Tue, 2005-12-20 at 15:38 +0100, Ingo Molnar wrote:
> > > * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> > >
> > I think there is a bug in the new plist_add() , which was in the
> > original code. It doesn't properly handle the new maximum node scenario,
> > or INT_MAX .
> > 
> > If the list is 1 2 3 4
> > 
> > and you insert 5 , you'll end up with the list 1 2 3 5 4 . Or something
> > like that .
> 
> I think you are not right, please look at the code.
> 
> The code under list_for_each_entry() can break the loop only
> when node->prio <= iter->prio.
> 
> void plist_add(struct pl_node *node, struct pl_head *head)
> {
> 	struct pl_node *iter;
> 
> 	list_for_each_entry(iter, &head->prio_list, plist.prio_list)
> 		if (node->prio < iter->prio)
> 			goto lt_prio;
> 		else if (node->prio == iter->prio)
> 			...
> 
> 	// So, node->prio is a new maximum, or the list was empty.
> 
> 	// &iter.plist == head. We don't touch iter->prio, so it
> 	// is ok that this pl_node is fake, it is really pl_head.
> 
> 	// We are doing list_add_tail(), this means that new node
> 	// will stay _after_ all other nodes.
> 
> 	// In this case the code below is equal to:
> 	//
> 	//	list_add_tail(&node->plist.prio_list, &head->prio_list);
> 	//	list_add_tail(&node->plist.prio_list, &head->node_list);
> 
> lt_prio:
> 	list_add_tail(&node->plist.prio_list, &iter->plist.prio_list);
> eq_prio:
> 	list_add_tail(&node->plist.node_list, &iter->plist.node_list);
> }
> 
> Note that this also garantees FIFO ordering, which was documented
> in plist.h, but was not true for plist_for_each().
> 
> Daniel, do you agree ?

It seems correct, however Inaky's code had special cases for this .
Since the two iteration implementation are near identical, it's a bit
suspect. Maybe Inaky can shed some light on it .

Daniel

