Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVJDTTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVJDTTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVJDTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:19:14 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:4491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964938AbVJDTTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:19:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uVYv24b4oqYRBkb6zv6wpvbuBQRSM4qFISCyVz98Nf5z2509OPWQZNqVROXkMega+zR9Z9CXpWmnWu7Shrw/bcrLEQX6wyZFXqk3hBjNrOwAur2Z/fHD022yEBP/ztLiEAeX4cl78TY6a768krAxRECn9VoR70547etJdDU24Y4=
Message-ID: <4342D5A5.2080902@gmail.com>
Date: Wed, 05 Oct 2005 04:19:01 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: Question regarding x86_64 __PHYSICAL_MASK_SHIFT
References: <43426EB4.6080703@gmail.com> <200510041924.56772.ak@suse.de> <20051004185230.GA8431@htj.dyndns.org> <200510042101.44946.ak@suse.de>
In-Reply-To: <200510042101.44946.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 04 October 2005 20:52, Tejun Heo wrote:
> 
>> Hello, Andi.
>>
>>On Tue, Oct 04, 2005 at 07:24:56PM +0200, Andi Kleen wrote:
>>
>>>You're right - PHYSICAL_MASK shouldn't be applied to PFNs, only to full
>>>addresses. Fixed with appended patch.
>>>
>>>The 46bits limit is because half of the 48bit virtual space
>>>is used for user space and the other 47 bit half is divided into
>>>direct mapping and other mappings (ioremap, vmalloc etc.). All
>>>physical memory has to fit into the direct mapping, so you
>>>end with a 46 bit limit.
>>
>> __PHYSICAL_MASK is only used to mask out non-pfn bits from page table
>>entries.  I don't really see how it's related to virtual space
>>construction.
> 
> 
> Any other bits are not needed and should be pte_bad()ed.
> 
> Ok there could be IO mappings beyond 46bits in theory, but I will worry about
> these when they happen. For now it's better to error out to easier detect
> memory corruptions in page tables (some x86-64 CPUs tend to machine
> check when presented with unmapped physical addresses, which 
> is nasty to track down) 
> 

  Ahh.. I see.

> 
>>>See also Documentation/x86-64/mm.txt
>>
>> Thanks.  :-)
>>
>> I think PHYSICAL_PAGE_MASK and PTE_FILE_MAX_BITS should also be
>>updated.  How about the following patch?  Compile & boot tested.
> 
> 
> No, I think the existing code with my patch is fine.

  Hmmm.. but, currently

* PHYSICAL_PAGE_MASK == (~(PAGE_SIZE-1)&(__PHYSICAL_MASK << PAGE_SHIFT)
	== (0xffffffff_fffff000 & (0x00003fff_ffffffff << 12)
  	== 0x03ffffff_fffff000
  while it actually should be 0x00003fff_fffff000

* PTE_FILE_MAX_BITS == __PHYSICAL_MASK_SHIFT == 46, but only 40bits are 
available in page table entries.

-- 
tejun
