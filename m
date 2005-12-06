Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVLFWgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVLFWgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVLFWgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:36:24 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:8072 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932643AbVLFWgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:36:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2WLrqWMLGtPTtpsq/YBzQRHnEeDZks3eYJctEkW5L5KgZEBK1byHSwOMvJTWgUY0F69E7ntucBUJgWphK6F9i02E4AJzuTdIobQhruH4dDwC3o7RaQbzuEV3z1xhybGZDzrNs/h9+NIbApeIoMPiLuGveDFiDxo5lKxgYkRCjKI=  ;
Message-ID: <43961264.5060006@yahoo.com.au>
Date: Wed, 07 Dec 2005 09:36:20 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Seigh <jseigh_02@xemaps.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] lockless radix tree readside
References: <4394EC28.8050304@yahoo.com.au> <dn4c20$e7m$1@sea.gmane.org>
In-Reply-To: <dn4c20$e7m$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Seigh wrote:

> Well, I don't have a kernel development set up so I can't comment on
> the specific patch but I have done some minor experimentation with reader
> lock-free b-trees, specifically insert, delete, and rotate (no actual
> balancing heuristics though) so I can comment on what some of the 
> general issues are.
> 
> You need to have a serialization point in your tree modifications so
> the change becomes atomically visible to threads reading the tree.

Yes, that is the memory barrier in rcu_assign_pointer.

> This is important for the semantics of your data structure.  It's not
> good to have a node become temporarily invisible to readers if the
> tree operation involved moving a node or subtree around with more than
> a single link modification.  So you will likely find yourself needing to 
> use
> COW (copy on write) or PCOW (partial copy on write), particularly on
> deletes of non leaf nodes. PCOW is naturally better, especially if you
> can minimize the number of nodes that have to be copied.
> 

Fortunately the radix tree never needs to do anything like this.
It doesn't move nodes or subtrees - the only modification operations
needed are to insert and delete items (ignoring the tag operations,
which are done under lock).

> So that's probably what you want to have in your documentation; what
> the serialization points are, your COW or PCOW mechanism, and how
> they preserve semantics.
> 
> Also I assume you're returning lookups by value and not reference
> unless they're refcounted (which naturally since you're using RCU
> can be incremented safely if the refcount is not zero)
> 

It can return either. It is up to the reader to do the right thing
in either case (which will need a note in the API comments).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
