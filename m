Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUGMUgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUGMUgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGMUgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:36:01 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:24038 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265840AbUGMUfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:35:42 -0400
Message-ID: <40F447B8.5080208@colorfullife.com>
Date: Tue, 13 Jul 2004 22:36:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU
References: <Pine.LNX.4.44.0407132029540.8535-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0407132029540.8535-100000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>On Tue, 13 Jul 2004, Manfred Spraul wrote:
>  
>
>>An interesting idea:
>>The slab caches are object caches. If a rcu user only needs a valid 
>>object but doesn't care which one then there is no need to wait for a 
>>quiescent cycle after free - the quiescent cycle can be delayed until 
>>the destructor is called.
>>    
>>
>
>Sorry, to be honest, I've not understood you there at all.
>I wonder if you're seeing some other use than I intended.
>
>  
>
No, I just tried to reworden your idea and I obviously failed.
Previously, I always assumed that the free call had to be delayed, but 
you have shown that this is wrong: If a rcu user can detect that an 
object changed its identity (or if he doesn't care), then it's not 
necessary to delay the free call, it's sufficient to delay the object 
destruction. And since the slab cache is an object cache delaying 
destruction causes virtually no overhead at all.
A second restriction is that it must be possible to recover from 
identity changes. I think this rules out the dentry cache - the hash 
chains point to wrong positions after a free/alloc/reuse cycle, it's not 
possible to recover from that.

>>But there are two flaws in your patch:
>>- you must disable poisoning and unmapping if SLAB_DESTROY_BY_RCU is set.
>>    
>>
>
>How right you are!  Thank you.  Does the further patch below suit?
>
>  
>
Yes, that should work.

>>- either delay the dtor calls a well or fail if an object has a non-NULL 
>>dtor and SLAB_DESTROY_BY_RCU is set.
>>    
>>
>
>Doesn't that rather depend on what the dtor does?  I'm not used to how
>destructors are commonly used, but I can easily imagine a destructor
>which, say, frees up some attached objects, but still leaves this cache
>object recognizably itself, good enough for the reference-after-free
>which SLAB_DESTROY_BY_RCU is allowing - all we need to avoid is the
>page being freed (or poisoned or unmapped) and reused.
>
This would introduce a concept of a half destroyed object. I think it's 
a bad idea, too easy to introduce bugs.
The correct fix would be to move the whole slab_destroy call into the 
rcu callback instead of just the kmem_cache_free call, but locking would 
be tricky - kmem_cache_destroy would have to wait for completion of 
outstanding rcu calls, etc.
Thus I'd propose a quick fix (fail if there is a dtor - are there any 
slab caches with dtors at all?) and in the long run slab_destroy should 
be moved into the rcu callback.

--
    Manfred
