Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSJDHyh>; Fri, 4 Oct 2002 03:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSJDHyg>; Fri, 4 Oct 2002 03:54:36 -0400
Received: from franka.aracnet.com ([216.99.193.44]:6531 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261520AbSJDHyf>; Fri, 4 Oct 2002 03:54:35 -0400
Date: Fri, 04 Oct 2002 00:55:02 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] slab cleanup
Message-ID: <1081530558.1033692901@[10.10.2.3]>
In-Reply-To: <3D9C3763.5090203@colorfullife.com>
References: <3D9C3763.5090203@colorfullife.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Off the mu2 patch you sent me ....

Unable to handle kernel paging request at virtual address a2de3920
 printing eip:
c01388f0
*pde = 5a5a5a5a
Oops: 0000
 
CPU:    1
EIP:    0060:[<c01388f0>]    Not tainted
EFLAGS: 00010093
EIP is at cache_alloc_refill+0xfc/0x2e8
eax: f5ae1000   ebx: 00000003   ecx: cc25f908   edx: 00000003
esi: 00000001   edi: cc25f908   ebp: 00000003   esp: f5e49f08
ds: 0068   es: 0068   ss: 0068
Process gcc (pid: 5494, threadinfo=f5e48000 task=f56960c0)
Stack: 000001d0 00000286 cc25f880 00004111 cc25f918 cc25f908 cc25f93c cc25f910 
       cc373ed4 00000005 c01390cf cc25f880 000001d0 f5aec800 f5a65914 f5aec9c0 
       c0119b40 cc25f880 000001d0 bffff0b4 00004111 08060218 f5e49fbc c02feb00 
Call Trace:
 [<c01390cf>]kmem_cache_alloc+0x53/0xdc
 [<c0119b40>]copy_process+0x4e8/0xb44
 [<c011a1bf>]do_fork+0x23/0xb4
 [<c0105bb1>]sys_vfork+0x19/0x30
 [<c0107497>]syscall_call+0x7/0xb

Code: 8b 44 81 18 83 f8 ff 75 e8 8b 51 10 89 d8 29 d0 39 c6 74 0c 


--On Thursday, October 03, 2002 2:26 PM +0200 Manfred Spraul <manfred@colorfullife.com> wrote:

> I've performed a larger modification of slab.c, as a preparation for NUMA awareness.
> 
> Could you please test it? Especially SMP, or non-x86 platforms would be interesting.
> 
> A kernprof profile, with function counts, for several loads would be great, but I don't know if kernprof works with recent 2.5 kernels.
> 
> With slab debugging enabled, it's possible to measure the efficiency of the headarrays: The block after the last ":" list the hits/misses:
> 
> names_cache  [snip] : 262924    118 263042      0
> 
> 262924 times kmem_cache_alloc(names_cache) found an object in the headarray, only 118 times it had to go back into the slab lists.
> 263042 times kmem_cache_free(names_cache) could store an object directly in the per-cpu array, it never had to flush the array. Note that additional flushing can happen in a timer, which is not counted right now.
> 
> The patch is against 2.5.40. It relies on Ingo's smptimers.
> 
> Changes:
> - always enable head arrays, right now they are SMP only.
> - make the per-cpu arrays strictly LIFO.
> - move slabs during kmem_cache_free to the end of the partial
> 	list, that should reduce the internal fragmentation.
> - smp_call_function() doesn't break disable_irq() anymore,
> 	remove the workarounds that were necessary.
> - Add head arrays to all caches, remove the  fallback to no-headarray.
> - Add a dynamic limit to the lengh of the free list
> - Do not flush headarrays if they were recently accessed.
> - Do not flush free slabs, if the free slab list was recently
> 	accessed.
> - Remove the GROWN flag: activity matters, not when the cache
> 	was grown last.
> - flush free list and head array in a per-cpu timer
> - remove kmem_ from slab internal functions.
> - poison all objects, even objects with constructors
> - add further debug checks [wrong interrupt flags, might_sleep]
> 
> --
> 	Manfred


