Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVETUUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVETUUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVETUUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:20:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62706 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261572AbVETUUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:20:12 -0400
Message-ID: <428E4671.7020207@us.ibm.com>
Date: Fri, 20 May 2005 13:20:01 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NUMA aware slab allocator V3
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com>  <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com>  <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org>  <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net> <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com> <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com> <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com> <428BB05B.6090704@us.ibm.com> <Pine.LNX.4.62.0505181439080.10598@graphe.net> <Pine.LNX.4.62.0505182105310.17811@graphe.net> <428E3497.3080406@us.ibm.com> <Pine.LNX.4.62.0505201210460.390@graphe.net>
In-Reply-To: <Pine.LNX.4.62.0505201210460.390@graphe.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 20 May 2005, Matthew Dobson wrote:
> 
> 
>>Christoph, I'm getting the following errors building rc4-mm2 w/ GCC 2.95.4:
> 
> 
> Works fine here with gcc 2.95.4.ds15-22 but that is a debian gcc 
> 2.95.4 patched up to work correctly. If you need to address the pathology in pristine 
> gcc 2.95.4 by changing the source then declare the entry field with 0 
> members.
> 
> Index: linux-2.6.12-rc4/mm/slab.c
> ===================================================================
> --- linux-2.6.12-rc4.orig/mm/slab.c	2005-05-19 21:29:45.000000000 +0000
> +++ linux-2.6.12-rc4/mm/slab.c	2005-05-20 19:18:22.000000000 +0000
> @@ -267,7 +267,7 @@
>  #ifdef CONFIG_NUMA
>  	spinlock_t lock;
>  #endif
> -	void *entry[];
> +	void *entry[0];
>  };
>  
>  /* bootstrap: The caches do not work without cpuarrays anymore,
> 
> 
> 
> gcc 2.95 can produce proper code for ppc64?

Apparently...?


>>mm/slab.c:281: field `entry' has incomplete typemm/slab.c: In function
>>'cache_alloc_refill':
> 
> 
> See patch above?

Will do.


>>mm/slab.c:2497: warning: control reaches end of non-void function
> 
> 
> That is the end of cache_alloc_debug_check right? This is a void 
> function in my source.

Nope.  It's the end of this function:
static void *cache_alloc_refill(kmem_cache_t *cachep, unsigned int __nocast
flags)

Though I'm not sure why I'm getting this warning, since the function ends
like this:
	ac->touched = 1;
	return ac->entry[--ac->avail];
} <<--  Line 2497


>>mm/slab.c: In function `kmem_cache_alloc':
>>mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
>>mm/slab.c: In function `kmem_cache_alloc_node':
>>mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
>>mm/slab.c: In function `__kmalloc':
>>mm/slab.c:2567: warning: `objp' might be used uninitialized in this function
> 
> 
> There is a branch there and the object is initialized in either branch.

I agree.  Not sure why this warning is occurring, either.

I tried to build this twice on this particular box, to no avail.  3x == charm?

-Matt
