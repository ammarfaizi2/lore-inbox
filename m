Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbSI1VHk>; Sat, 28 Sep 2002 17:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261871AbSI1VHk>; Sat, 28 Sep 2002 17:07:40 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:60316 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261768AbSI1VHi>;
	Sat, 28 Sep 2002 17:07:38 -0400
Message-ID: <3D961B56.2010403@colorfullife.com>
Date: Sat, 28 Sep 2002 23:12:54 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: John Levon <movement@marcelothewonderpenguin.com>,
       Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.39 kmem_cache bug
References: <20020928201308.GA59189@compsoc.man.ac.uk> <3D961797.B4094994@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> John Levon wrote:
> 
>>kmem_cache_destroy() is falsely reporting
>>"kmem_cache_destroy: Can't free all objects" in 2.5.39. I have
>>verified my code was freeing all allocated items correctly.
>>
>>Reverting this chunk :
>>
>>-                       list_add(&slabp->list, &cachep->slabs_free);
>>+/*                     list_add(&slabp->list, &cachep->slabs_free);            */
>>+                       if (unlikely(list_empty(&cachep->slabs_partial)))
>>+                               list_add(&slabp->list, &cachep->slabs_partial);
>>+                       else
>>+                               kmem_slab_destroy(cachep, slabp);
>>
>>and the problem goes away. I haven't investigated why.
>>
> 
> 
> Thanks.  That's the code which leaves one empty page available
> for new allocations rather than freeing it immediately.
> 
> It's temporary.  Ed, I think we can just do
> 
> 	if (list_empty(&cachep->slabs_free))
> 		list_add(&slabp->list, &cachep->slabs_free);
> 	else
> 		kmem_slab_destroy(cachep, slabp);
> 
> there?

Look correct.
If you apply it, then reenable the BUG check in s_show() if a slab with 
0 allocations is found on the partial list, too.

--
	Manfred

