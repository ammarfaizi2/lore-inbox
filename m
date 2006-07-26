Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWGZSpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWGZSpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751737AbWGZSpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:45:39 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:40361 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751106AbWGZSpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:45:39 -0400
Message-ID: <44C7B842.5060606@colorfullife.com>
Date: Wed, 26 Jul 2006 20:45:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/2] slab: always consider arch mandated alignment
References: <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com> <20060723162427.GA10553@osiris.ibm.com> <20060726085113.GD9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261303270.17613@sbz-30.cs.Helsinki.FI> <20060726101340.GE9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261325070.17986@sbz-30.cs.Helsinki.FI> <20060726105204.GF9592@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.58.0607261411420.17986@sbz-30.cs.Helsinki.FI> <44C7AF31.9000507@colorfullife.com> <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607261118001.6608@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Wed, 26 Jul 2006, Manfred Spraul wrote:
>
>  
>
>>Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>>    
>>
>
>Good bye to all those cacheline contentions that helped us find so many 
>race conditions in the past if we switched on SLAB_DEBUG. I thought this 
>was intentional?
>
>  
>
Relax, align is nearly never set.

- kmalloc uses align==0, except if the architecture requests it 
(ARCH_KMALLOC_MINALIGN not 0)
- on my i386 system, the following users explicitely use align:
* the pmd structure (4096: hardware requirement)
* the pgd structure (32 bytes: hardware requirement)
* the task structure (16 byte. fxsave)
* sigqueue, pid: both request 4 byte alignment (based on __alignof__()). 
Doesn't affect debugging.

 From the other mail:

>Thus the patch is correct, it's a bug in the slab allocator. If HWCACHE_ALIGN
>> is set, then the allocator ignores align or ARCH_SLAB_MINALIGN.
>  
>
>
>But then Heiko does not want to set ARCH_SLAB_MINALIGN at all. This is not 
>the issue we are discussing. In the DEBUG case he wants 
>ARCH_KMALLOC_MINALIGN to be enforced even if ARCH_SLAB_MINALIGN is not 
>set.
>  
>
The kmalloc caches are allocated with 
HWCACHE_ALIGN+ARCH_KMALLOC_MINALIGN. The logic in kmem_cache_create 
didn't handle that case correctly.
On most architectures, ARCH_KMALLOC_MINALIGN is 0. Thus SLAB_DEBUG 
redzones everything.
On s390, ARCH_KMALLOC_MINALIGN is 8. This disables redzoning.

Ok?

--
    Manfred
