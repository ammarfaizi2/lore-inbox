Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVEWPMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVEWPMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEWPMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:12:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:41198 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261881AbVEWPM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:12:29 -0400
Date: Mon, 23 May 2005 08:12:18 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
In-Reply-To: <4291F134.4338A50B@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0505230800580.863-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Oleg Nesterov wrote:

> So the very first node will be skipped, iteration will be out of order,
> and you will have the plist's *head* as a last element (which is not
> struct rt_mutex_waiter, of course).

True, but the first node is the list head which must be static, 
It's not an actual list member.
 
> >  unsigned plist_empty(const struct plist *plist)
> >  {
> > -	return list_empty (&plist->dp_node);
> > +	return list_empty(&plist->dp_node) && list_empty(&plist->sp_node);
> >  }
> 
> It's enough to check list_empty(&plist->sp_node) only.

True. 

> 	new_sp_head:
> 		itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> 		list_add(&pl->sp_node, &itr_pl2->sp_node);
> 
> Why?  Just list_add_tail(&pl->sp_node, itr_pl->sp_node), you don't
> need itr_pl2 at all.

Wouldn't work . What if itr_pl has 15 elements at it's priority?

> Daniel, if you accepted all-nodes-tied-via-sp_node idea, could you
> also look at the code I've suggested. I think it is much simpler
> and understandable.

I will/have. The sp_node all connect idea came from your stuff.
 
> Personally, I think it is better to have pl_head for plist's head,
> and pl_node for nodes. It is pointless to store ->prio in the plist's
> head, it can be found in plist_first()->prio. This way we can trim
> the size of rt_mutex to 32 bytes, and it is good for typechecking.

I like that idea, I just haven't done it yet.


Daniel

