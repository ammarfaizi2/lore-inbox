Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbULaLrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbULaLrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbULaLrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:47:17 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:32657 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261863AbULaLrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:47:12 -0500
Message-ID: <41D53C25.4030402@colorfullife.com>
Date: Fri, 31 Dec 2004 12:46:45 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard \"Georg C. F.
	Greve\"" <greve@fsfeurope.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Did that last night. You are right -- it is so slow that it is no fun
>at all. So I started the test run last night and went to bed. 
>
>  
>
It was a crash in free_block - this means control structures of the slab 
allocator were corrupted.

You wrote that enabling everything caused a hard crash without anything 
on the console. Could you try what happens if slab debugging is enabled, 
but page alloc debugging is off? You should get a verbose BUG_ON() with 
kmem_cache_free/kmem_cache_alloc caller addresses and similar stuff.

> EFLAGS: 00010002   (2.6.10)
> EIP is at free_block+0x45/0xd0
> eax: 46484849   ebx: df2b1000   ecx: df2b1050   edx: df2ab000
> esi: c183cd80   edi: 00000001   ebp: 00000018   esp: c188fef8
> ds: 007b   es: 007b   ss: 0068

Could you compile your kernel without debug and send me mm/slab.o? The 
%eax value is odd: FHHI or IHHF.

Btw, if it's still too slow for you without page alloc debug: remove the 
forced poisoning:

  if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
          flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
- if (!(flags & SLAB_DESTROY_BY_RCU))
-         flags |= SLAB_POISON;
 #endif

--
	Manfred


