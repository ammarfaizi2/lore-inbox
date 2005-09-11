Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVIKNWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVIKNWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 09:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVIKNWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 09:22:46 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:63165 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750805AbVIKNWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 09:22:46 -0400
Message-ID: <43242FA4.9010303@vc.cvut.cz>
Date: Sun, 11 Sep 2005 15:22:44 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG at mm/slab.c:662 - current 2.6.13-git (commit 87fc...) crashes
 on x86-64
References: <4322DF10.9080204@vc.cvut.cz> <Pine.LNX.4.62.0509101023120.18771@schroedinger.engr.sgi.com> <43232E65.4000504@vc.cvut.cz> <Pine.LNX.4.62.0509101948230.20145@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509101948230.20145@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sat, 10 Sep 2005, Petr Vandrovec wrote:
> 
> 
>>Christoph Lameter wrote:
>>
>>>Actually the kernel configuration you mentioned (SMP with K8 NUMA support
>>>booted on single processor) was the primary development platform for the
>>>patch. 
>>>CONFIG_DEBUG_SLAB=y
>>
>>Strange...  I had to apply patch below - after doing that everything seems to
>>be happy and running.  Though it is not right fix, it seems to work fine
>>here...
> 
> 
> Hmmm. That is strange indeed and would mean that one of the initial caches 
> has not correctly been initialized or we are using a smaller cache size 
> than the management caches. With your patch the system fell 
> back to a larger size slab (which seems to be present). Weird.
> 
> What is your setting for L1_CACHE_BYTES?

64.  Well, at least CONFIG_X86_L1_CACHE_BYTES has this value.  Last few lines in 
/proc/slabinfo in reverse order are:

kmem_cache
size-64
size-128
size-32
size-32(DMA)
size-64(DMA)
size-128(DMA)

so 64 (INDEX_AC) & 128 (INDEX_L3) slabs were created first.  But 
__find_general_cachep BUGs on *first* entry, which is 32 byte one on systems 
with 4KB pages.

It seems to me that problem is CONFIG_DEBUG_SLAB together with 
CONFIG_DEBUG_SPINLOCK and/or CONFIG_PREEMPT - in your configuration spinlock_t 
has 4 bytes, and whole arraycache_init 32 bytes - so it fits into size-32 slab, 
and you do not hit BUG that size-32 slab does not exist.

On SMP systems with CONFIG_DEBUG_SPINLOCK or CONFIG_PREEMPT spinlock_t is 8 
bytes, and so arraycache_init has 36 bytes, and it no longer fits into 
size-32...  And if you'll enable both SPINLOCK debugging and PREEMPT, you get 12 
bytes spinlock_t and 40 byte arraycache_init...

So I believe that if you'll rebuild your kernel with PREEMPT or DEBUG_SPINLOCK 
(or both), you'll get crash I'm seeing.  Probably size-32 slab needs to be 
special cased same way INDEX_AC and INDEX_L3 arrays are.
								Petr Vandrovec

