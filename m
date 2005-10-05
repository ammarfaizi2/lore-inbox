Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVJEEBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVJEEBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 00:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJEEBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 00:01:31 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:11427 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751210AbVJEEBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 00:01:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GcTDZeJJgQotq1/z2GRLCBsiIr6Zfnhbm6u8sa4ieyvk/VXVxRzqBGN7qMhMpd+PPLkxJIZM60tbHGbaxNCc4MRP0v3YPhSlZ0r6z7aU4Xg/9TXLz7cJ0gW3Y7UpH4Vgiu5zmEZoDzAKICwRhMIFrOv6OjfDLDcGUeL8izouZCo=
Message-ID: <43435013.6040303@gmail.com>
Date: Wed, 05 Oct 2005 13:01:23 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
References: <43426EB4.6080703@gmail.com> <200510042101.44946.ak@suse.de> <4342D5A5.2080902@gmail.com> <200510042127.21238.ak@suse.de>
In-Reply-To: <200510042127.21238.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, Andi.

Andi Kleen wrote:
> On Tuesday 04 October 2005 21:19, Tejun Heo wrote:
> 
> 
>>  Hmmm.. but, currently
>>
>>* PHYSICAL_PAGE_MASK == (~(PAGE_SIZE-1)&(__PHYSICAL_MASK << PAGE_SHIFT)
>>	== (0xffffffff_fffff000 & (0x00003fff_ffffffff << 12)
>>  	== 0x03ffffff_fffff000
>>  while it actually should be 0x00003fff_fffff000
> 
> 
> Right. Fixed now
> 
> 
>>* PTE_FILE_MAX_BITS == __PHYSICAL_MASK_SHIFT == 46, but only 40bits are
>>available in page table entries.
> 
> 
> The non linear mapping format is independent from the MMU, the number
> is pretty much arbitary, but it is consistent to make it the same as
> other ptes for easier sanity checking.

  Okay, please forgive me if I'm bugging you with something stupid but I 
still don't quite get it.  When using NONLINEAR mapping, pgoff is stored 
to pte to use later when faulting in the page.  Storing and reading 
pgoff are done with the following macros.

#define pte_to_pgoff(pte) \
	((pte_val(pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
#define pgoff_to_pte(off) \
	((pte_t) { ((off) << PAGE_SHIFT) | _PAGE_FILE })

  In pte_to_pgoff we're masking pte value with PHYSICAL_PAGE_MASK which 
gives us 34bits with patches applied.  This means that if a pgoff goes 
through pgoff_to_pte and then pte_to_pgoff only 34bits survive.

  sys_remap_file_pages() checks if required pgoff's fit in pte's using 
PTE_FILE_MAX_BITS.

#define PTE_FILE_MAX_BITS __PHYSICAL_MASK_SHIFT

  Which is 46 with patches applied.  Meaning that we could end up 
shoving up value larger than 34bits into pte and losing information when 
reading back (and it's only 16GB!).

  So, IMHO, we should either shrink PTE_FILE_MAX_BITS to 36 or change 
pte_to_pgoff/pgoff_to_pte macros to carry more bits (as pte bits 52-62 
are available, we can shove 46bits easily).

  No?

-- 
tejun
