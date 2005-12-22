Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVLVNld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVLVNld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLVNld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:41:33 -0500
Received: from [195.144.244.147] ([195.144.244.147]:3012 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S932204AbVLVNlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:41:32 -0500
Message-ID: <43AAAD09.1010005@varma-el.com>
Date: Thu, 22 Dec 2005 16:41:29 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tnt.com>
Cc: jes@trained-monkey.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com> <43A9B2F1.8090402@246tNt.com>
In-Reply-To: <43A9B2F1.8090402@246tNt.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylvain,

Sylvain Munaut wrote:
> Hi Andrey,
> 
> 
> Didn't I sent you the memory allocator I wrote a few month back for 5200
> SRAM ?
Yes, I receive it and currently I use it for Bestcomm, but,
as I wrote before, I also writing another driver for which I need
allocator too, and sram_xxx/gen_pool_xxx completely inappropriate for it
(since device is PCI based). Also, trust me, it will be 6th or 7th
allocator implementation what I did, its more than enough to make me
sick from allocators.

As well, IMHO, yet another allocator in kernel (currently almost each
driver for dev. with onboard dynamically allocated mem. implement
somehow or other buddy/first fit alloc) will cause yet another bugs in
kernel ALREADY FIXED in driver in the neighbourhood dir.

> 
> It uses the sram itself for the free block list but without using any
> (iow, you could allocate the whole SRAM, no memory is wasted). The SRAM
> is on-chip so pretty fast access. That kind of allocator is no good for
> memory on a PCI board or such though (bad access time ! using main
> memory would be better)
>
> Sylvain

Completely agree, but - for BESTCOMM case. This is what I have in mind
when I wrote 'usually' at 1) ;). Also don't forget about storage
for size of allocated blocks  (which later passed to free) - in sram_xxx
case main memory used for it indirectly (when you push constant as
param) or directly, when you are store it in data struct. So, IMO,
better use it directly and control it in one place, then try to catch
bugs with invalid size pushed to free.


> 
> 
> Andrey Volkov wrote:
> 
>>Hello Jes and all
>>
>>I try to use your allocator (gen_pool_xxx), idea of which
>>is a cute nice thing. But current implementation of it is
>>inappropriate for a _device_ (aka onchip, like framebuffer) memory
>>allocation, by next reasons:
>>
>> 1) Device memory is expensive resource by access time and/or size cost.
>>    So we couldn't use (usually) this memory for the free blocks lists.
>> 2) Device memory usually have special requirement of access to it
>>    (alignment/special insn). So we couldn't use part of allocated
>>    blocks for some control structures (this problem solved in your
>>    implementation, it's common remark)
>> 3) Obvious (IMHO) workflow of mem. allocator look like:
>> 	- at startup time, driver allocate some big
>>	  (almost) static mem. chunk(s) for a control/data structures.
>>        - during work of the device, driver allocate many small
>>	  mem. blocks with almost identical size.
>>    such behavior lead to degeneration of buddy method and
>>    transform it to the first/best fit method (with long seek
>>    by the free node list).
>> 4) The simple binary buddy method is far away from perfect for a device
>>    due to a big internal fragmentation. Especially for a
>>    network/mfd devices, for which, size of allocated data very
>>    often is not a power of 2.
>>
>>I start to modify your code to satisfy above demands,
>>but firstly I wish to know your, or somebody else, opinion.
>>
>>Especially I will very happy if somebody have and could
>>provide to all, some device specific memory usage statistics.
>>

-- 
Regards
Andrey Volkov

P.S. Oops, sorry for duplication, I forget insert CC in prev replay.

