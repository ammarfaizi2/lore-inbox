Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVLFQAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVLFQAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVLFQAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:00:09 -0500
Received: from main.gmane.org ([80.91.229.2]:58328 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750809AbVLFQAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:00:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: [RFC] lockless radix tree readside
Date: Tue, 06 Dec 2005 10:53:53 -0500
Message-ID: <dn4c20$e7m$1@sea.gmane.org>
References: <4394EC28.8050304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <4394EC28.8050304@yahoo.com.au>
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> The following patch against recent -mm kernels implements lockless
> radix tree lookups using RCU. No users of this new facility yet,
> but it is a requirement for lockless pagecache.
> 
> I have recently added (what I think are) the missing rcu_dereference
> calls needed on Alpha, and the implementation now has no known bugs.
> (actually that's wrong: the new capabilities in the lookup APIs need
> commenting)
> 
> I realise that radix-tree.c isn't a trivial bit of code so I don't
> expect reviews to be forthcoming, but if anyone had some spare time
> to glance over it that would be great.
> 
> Is my given detail of the implementation clear? Sufficient? Would
> diagrams be helpful?
> 

Well, I don't have a kernel development set up so I can't comment on
the specific patch but I have done some minor experimentation with reader
lock-free b-trees, specifically insert, delete, and rotate (no actual
balancing heuristics though) so I can comment on what some of the 
general issues are.

You need to have a serialization point in your tree modifications so
the change becomes atomically visible to threads reading the tree.
This is important for the semantics of your data structure.  It's not
good to have a node become temporarily invisible to readers if the
tree operation involved moving a node or subtree around with more than
a single link modification.  So you will likely find yourself needing to use
COW (copy on write) or PCOW (partial copy on write), particularly on
deletes of non leaf nodes. PCOW is naturally better, especially if you
can minimize the number of nodes that have to be copied.

So that's probably what you want to have in your documentation; what
the serialization points are, your COW or PCOW mechanism, and how
they preserve semantics.

Also I assume you're returning lookups by value and not reference
unless they're refcounted (which naturally since you're using RCU
can be incremented safely if the refcount is not zero)

--
Joe Seigh



