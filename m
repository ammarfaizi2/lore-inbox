Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUCLVVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUCLVVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:21:00 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:19084 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262509AbUCLVUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:20:46 -0500
Message-ID: <405228DC.1010107@matchmail.com>
Date: Fri, 12 Mar 2004 13:17:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Nick Piggin <piggin@cyberone.com.au>, Mark_H_Johnson@raytheon.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, m.c.p@wolk-project.de, owner-linux-mm@kvack.org,
       plate@gmx.tm
Subject: Re: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
References: <OF62A00090.6117DDE8-ON86256E55.004FED23@raytheon.com> <4051D39D.80207@cyberone.com.au> <20040312193547.GD18799@mail.shareable.org>
In-Reply-To: <20040312193547.GD18799@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Nick Piggin wrote:
> 
>>In Linux, all reclaim is driven by a memory shortage. Often it
>>is just because more memory is being requested for more file
>>cache.
> 
> 
> Is reclaim the same as swapping, though?  I'd expect pages to be
> written to the swapfile speculatively, before they are needed for
> reclaim.  Is that one of those behaviours which everyone agrees is
> sensible, but it's yet to be implemented in the 2.6 VM?
> 

Nobody has mentioned the swap cache yet.  If a page is in ram, and swap 
and not dirty, it's counted in the swap cache.

> 
>>But presumably if you are running into memory pressure, you really
>>will need to free those free list pages, requiring the page to be
>>read from disk when it is used again.
> 
> 
> The idea is that you write pages to swap _before_ the memory pressure
> arrives, which makes those pages available immediately when memory
> pressure does arrive, provided they are still clean.  It's speculative.
> 
> I thought Linux did this already, but I don't know the current VM well.
> 

You're saying all anon memory should become swap_cache eventually 
(though, it should be a background "task" so it doesn't block userspace 
memory requests).

That would have other side benefits.  If the anon page matches (I'm not 
calling it "!dirty" since that might have other semantics in the current 
VM) what is in swap, it can be cleaned without performing any IO.  Also, 
  suspending will have much less IO to perform before completion.

Though there would have to be swap recycling algo if swap size < ram.

Mike
