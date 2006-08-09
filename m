Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWHINol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWHINol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 09:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWHINol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 09:44:41 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:7458 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750818AbWHINok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 09:44:40 -0400
Message-ID: <44D9E676.6000707@sw.ru>
Date: Wed, 09 Aug 2006 17:43:18 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Dave Hansen <haveblue@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       rohitseth@google.com, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, sam@vilain.net, linux-kernel@vger.kernel.org,
       dev@openvz.org, efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: Re: memory resource accounting (was Re: [RFC, PATCH 0/5] Going	forward
 with Resource Management - A	cpu controller)
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>	 <1154975486.31962.40.camel@galaxy.corp.google.com>	 <1154976236.19249.9.camel@localhost.localdomain>	 <1154977257.31962.57.camel@galaxy.corp.google.com>	 <44D798B1.8010604@mbligh.org>  <44D89D7D.8040006@yahoo.com.au> <1155049020.19249.32.camel@localhost.localdomain> <44D8AC23.4090004@yahoo.com.au>
In-Reply-To: <44D8AC23.4090004@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But if you have a unified struct page accounting, you don't need that.
> You don't need struct radix_tree_node accounting, you don't need 
> buffer_head
> accounting, pagetable page accounting, vm_area_struct accounting, 
> task_struct
> accounting, etc etc in order to do your memory accounting if what you just
> want to know is "who allocated what".
Sorry, are you suggesting to use page accounting for slab objects?
You mean, that if we can account page fractions then we can charge
part of slab page to object owners?
If this is correct, then I think it is ineffecient.
In our current implementation page beancounters can charge
only equal fraction of page to each owner, so it is not suitable for slabs.
Moreoever, it is easier to do correct accounting from the slab allocator
itself and with much less overhead.

> And remember that if you have one container going crazy with inode/dentry
> cache, it will get hit by its resource limit and end up having to reclaim
> them or go OOM.
In order to decide which of the containers is crazy you need
to account correctly the amount of _pinned_ dcache memory.
And even to select correct container for OOM you need to have a corect accounting
of _pinned_ dcache.

> Now you *may* want to split the actual accounting into kernel and user 
> parts
> if you're worried about obscure corner cases in kernel memory 
> accounting. But
> this would basically come for free when you have the GFP_EASYRECLAIM thingy
> (at any rate, it is quite unintrusive).
> 
> 
> Basically, what I have been hearing is that people want to be able to
> surgically isolate the memory allocation of one container from that of
> another. IMO this is simply infeasible (and exploit prone) to do it on a
> per-kernel-object basis.
We have the following scheme:
cache which should be charged are marked as SLAB_UBC. the same for particular allocations,
we have a GFP_UBC flag specifing that the allocation should be charged to
the owner. Does it look good for you?
I will post kernel memory accounting patches soon here.

Thanks,
Kirill
