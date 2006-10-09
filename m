Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWJITpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWJITpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWJITpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:45:15 -0400
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:27036 "EHLO sMtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1751757AbWJITpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:45:14 -0400
Date: Mon, 09 Oct 2006 21:43:15 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Try to avoid a pessimistic vmalloc() recursion
In-reply-to: <452A77ED.6070001@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <452AA653.6020407@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz>
 <20061006230609.c04e78bc.akpm@osdl.org>
 <200610091647.55184.dada1@cosmosbay.com> <452A77ED.6070001@yahoo.com.au>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin a écrit :
> Eric Dumazet wrote:
>> __vmalloc_area_node() is a litle bit pessimist when allocating space 
>> for storing struct page pointers.
>>
>> When allocating more than 4 MB on ia32, or 2 MB on x86_64,  
>> __vmalloc_area_node() has to allocate more than PAGE_SIZE bytes to 
>> store pointers to  page structs. This means that two TLB translations 
>> are needed to access data.
>>
>> This patch tries a kmalloc() call, then only if this first attempt 
>> failed, a vmalloc() is performed. (Later, at vfree() time we chose 
>> kfree() or vfree() with a test on flags & VM_VPAGES : no change is 
>> needed)
>> Most of the time, the first kmalloc() should be OK, so we reduce TLB 
>> usage.
> 
> But this is only TLB usage when managing (read: freeing) the vmalloc pages,
> isn't it? Not when actually accessing the data.

Yes indeed...
I was trying to reduce time taken by a processes handling lot of files (thus 
vmalloc()ing fdtables and fdset). I noticed a high oprofile hit in 
fget_light(). I suspected overhead caused by vmalloc(), but obviously, once 
the vmalloc() mapping is done, the array of pointers wont be used until vfree().

> 
> I'd be inclined to NACK this, unless you can show an improvement somewhere:
> it is suboptimal to even _try_ allocating higher order pages.
> 

Your point is valid. And it seems there is not much cpu used to linearly scan 
vmlist (to find the vm_struct), at least on my little servers.

Eric
