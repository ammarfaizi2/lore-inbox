Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266150AbUF3Gog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUF3Gog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 02:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUF3Gog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 02:44:36 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:12484 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266150AbUF3GoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 02:44:21 -0400
Date: Tue, 29 Jun 2004 23:44:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: remap_pte_range
Message-ID: <1530000.1088577840@[10.10.2.4]>
In-Reply-To: <20040629173037.68e5d958.akpm@osdl.org>
References: <65600000.1088554644@flay> <20040629173037.68e5d958.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I have no idea what remap_pte_range is trying to do here, but what it
>> is doing makes no sense (to me at least). 
>> 
>> If the pfn is not valid, we CANNOT safely call PageReserved on it - 
>> the *page returned from pfn_to_page is bullshit, and we crash deref'ing
>> it.
>> 
>> Perhaps this was what it was trying to do? Not sure.
>> 
>> diff -purN -X /home/mbligh/.diff.exclude virgin/mm/memory.c remap_pte_range/mm/memory.c
>> --- virgin/mm/memory.c	2004-06-16 10:22:15.000000000 -0700
>> +++ remap_pte_range/mm/memory.c	2004-06-29 17:15:35.000000000 -0700
>> @@ -908,7 +908,7 @@ static inline void remap_pte_range(pte_t
>>  	pfn = phys_addr >> PAGE_SHIFT;
>>  	do {
>>  		BUG_ON(!pte_none(*pte));
>> -		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
>> +		if (pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)))
>>   			set_pte(pte, pfn_pte(pfn, prot));
>>  		address += PAGE_SIZE;
>>  		pfn++;
> 
> It seems OK as-is.
> 
> If the pfn is not valid then establish the pte to point at physical memory.
> 
> If the pfn _is_ valid then check PageReserved.  If the page is reserved
> then establish a pte to point at it.

Mmmm - yeah, maybe I've got that backwards. pfn_valid = 0  => !pfn_valid = 1,
so it needn't do the PageReserved by lazy eval I spose. But it seems to.
See http://bugme.osdl.org/show_bug.cgi?id=2019 from comment #11 on.

The instruction it's blowing up on is "mov    (%eax),%eax" inside
remap_pte_range (which is inlined), where we're deferencing the page from
pfn_to_page for PageReserved. Now the debug I shoved in (to trigger whenever
pfn_to_page(pfn) < PAGE_OFFSET) shows pfn_valid is 0 ... but maybe that's
for another page there, which is what's confusing me. Humpf.

I still find the fact that we're deliberately pointing the pte to a page 
that doesn't exist a little odd ... but still.

> The slightly weird thing is that we do

> 
> 	pfn = phys_addr >> PAGE_SHIFT;
> 	...
> 	pfn_pte(pfn);
> 
> to go from the physical address back to a masked&shifted version of the
> physical address.  Maybe that operation is doing the wrong thing in your
> setup and we should go straight from the physical address to the pte value,
> like 2.4's mk_pte_phys().

Mmmm. I'm pretty damned sure we're blowing up before we ever do that bit.
And pfn_pte looks OK to me ... it should be 36bit (PAE) safe ...

M.

PS ... here's the second half of remap_page_range for that dump:

0xc0140112 <remap_page_range+243>:      mov    %esi,%ecx
0xc0140114 <remap_page_range+245>:      call   0xc013e966 <pte_alloc_map>
0xc0140119 <remap_page_range+250>:      mov    %eax,0xffffffc4(%ebp)
0xc014011c <remap_page_range+253>:      mov    $0xfffffff4,%eax
0xc0140121 <remap_page_range+258>:      mov    0xffffffc4(%ebp),%ebx
0xc0140124 <remap_page_range+261>:      test   %ebx,%ebx
0xc0140126 <remap_page_range+263>:      je     0xc014022d <remap_page_range+526>
0xc014012c <remap_page_range+269>:      mov    0xffffffc8(%ebp),%eax
0xc014012f <remap_page_range+272>:      and    $0x1fffff,%esi
0xc0140135 <remap_page_range+278>:      mov    0xffffffd4(%ebp),%ecx
0xc0140138 <remap_page_range+281>:      sub    0xffffffd4(%ebp),%eax
0xc014013b <remap_page_range+284>:      add    0xffffffd0(%ebp),%ecx
0xc014013e <remap_page_range+287>:      mov    0xffffffc4(%ebp),%ebx
0xc0140141 <remap_page_range+290>:      lea    (%eax,%esi,1),%eax
0xc0140144 <remap_page_range+293>:      cmp    $0x200001,%eax
0xc0140149 <remap_page_range+298>:      mov    %eax,0xffffffc0(%ebp)
0xc014014c <remap_page_range+301>:      mov    $0x200000,%eax
0xc0140151 <remap_page_range+306>:      cmovb  0xffffffc0(%ebp),%eax
0xc0140155 <remap_page_range+310>:      shr    $0xc,%ecx
0xc0140158 <remap_page_range+313>:      mov    %ecx,%edi
0xc014015a <remap_page_range+315>:      mov    %eax,0xffffffc0(%ebp)
0xc014015d <remap_page_range+318>:      shl    $0xc,%edi
0xc0140160 <remap_page_range+321>:      mov    (%ebx),%eax
0xc0140162 <remap_page_range+323>:      mov    0x4(%ebx),%edx
0xc0140165 <remap_page_range+326>:      test   %eax,%eax
0xc0140167 <remap_page_range+328>:      jne    0xc014016d <remap_page_range+334>
0xc0140169 <remap_page_range+330>:      test   %edx,%edx
0xc014016b <remap_page_range+332>:      je     0xc0140175 <remap_page_range+342>
0xc014016d <remap_page_range+334>:      ud2a   
0xc014016f <remap_page_range+336>:      xchg   %eax,%ebx
0xc0140170 <remap_page_range+337>:      add    0x89c03b82(%edi),%edx
0xc0140176 <remap_page_range+343>:      enter  $0xe8c1,$0x10
0xc014017a <remap_page_range+347>:      movzbl 0xc0401a60(%eax),%eax
0xc0140181 <remap_page_range+354>:      mov    0xc0500860(,%eax,4),%edx
0xc0140188 <remap_page_range+361>:      mov    0x3d40(%edx),%eax
0xc014018e <remap_page_range+367>:      add    0x3d38(%edx),%eax
0xc0140194 <remap_page_range+373>:      cmp    %eax,%ecx
0xc0140196 <remap_page_range+375>:      setb   %al
0xc0140199 <remap_page_range+378>:      movzbl %al,%eax
0xc014019c <remap_page_range+381>:      test   %eax,%eax
0xc014019e <remap_page_range+383>:      je     0xc01401b8 <remap_page_range+409>
0xc01401a0 <remap_page_range+385>:      mov    %ecx,%eax
0xc01401a2 <remap_page_range+387>:      sub    0x3d38(%edx),%eax
0xc01401a8 <remap_page_range+393>:      shl    $0x5,%eax
0xc01401ab <remap_page_range+396>:      add    0x3d30(%edx),%eax
**************  blows up on next instruction ***********************
0xc01401b1 <remap_page_range+402>:      mov    (%eax),%eax
0xc01401b3 <remap_page_range+404>:      test   $0x8,%ah
0xc01401b6 <remap_page_range+407>:      je     0xc01401d0 <remap_page_range+433>
0xc01401b8 <remap_page_range+409>:      mov    %ecx,%eax
0xc01401ba <remap_page_range+411>:      shr    $0x14,%eax
0xc01401bd <remap_page_range+414>:      mov    %eax,0xffffffbc(%ebp)
0xc01401c0 <remap_page_range+417>:      mov    0xc(%ebp),%eax
0xc01401c3 <remap_page_range+420>:      or     %edi,%eax
0xc01401c5 <remap_page_range+422>:      mov    0xffffffbc(%ebp),%edx
0xc01401c8 <remap_page_range+425>:      mov    %eax,0xffffffb8(%ebp)
0xc01401cb <remap_page_range+428>:      mov    %edx,0x4(%ebx)
0xc01401ce <remap_page_range+431>:      mov    %eax,(%ebx)
0xc01401d0 <remap_page_range+433>:      add    $0x1,%ecx
0xc01401d3 <remap_page_range+436>:      add    $0x1000,%edi
0xc01401d9 <remap_page_range+442>:      add    $0x8,%ebx
0xc01401dc <remap_page_range+445>:      add    $0x1000,%esi
0xc01401e2 <remap_page_range+451>:      setne  %dl
0xc01401e5 <remap_page_range+454>:      cmp    0xffffffc0(%ebp),%esi
0xc01401e8 <remap_page_range+457>:      setb   %al
0xc01401eb <remap_page_range+460>:      and    %edx,%eax
0xc01401ed <remap_page_range+462>:      test   $0x1,%al
0xc01401ef <remap_page_range+464>:      jne    0xc0140160 <remap_page_range+321>
0xc01401f5 <remap_page_range+470>:      mov    $0x7,%edx
0xc01401fa <remap_page_range+475>:      mov    0xffffffc4(%ebp),%eax
0xc01401fd <remap_page_range+478>:      call   0xc01154b7 <kunmap_atomic>
0xc0140202 <remap_page_range+483>:      mov    0xffffffd4(%ebp),%eax
0xc0140205 <remap_page_range+486>:      addl   $0x8,0xffffffd8(%ebp)
0xc0140209 <remap_page_range+490>:      add    $0x200000,%eax
0xc014020e <remap_page_range+495>:      mov    0xffffffc8(%ebp),%ecx
0xc0140211 <remap_page_range+498>:      and    $0xffe00000,%eax
0xc0140216 <remap_page_range+503>:      setne  %dl
0xc0140219 <remap_page_range+506>:      cmp    %ecx,%eax
0xc014021b <remap_page_range+508>:      mov    %eax,0xffffffd4(%ebp)
0xc014021e <remap_page_range+511>:      setb   %al
0xc0140221 <remap_page_range+514>:      and    %edx,%eax
0xc0140223 <remap_page_range+516>:      test   $0x1,%al
0xc0140225 <remap_page_range+518>:      jne    0xc0140106 <remap_page_range+231>
0xc014022b <remap_page_range+524>:      xor    %eax,%eax
0xc014022d <remap_page_range+526>:      test   %eax,%eax
0xc014022f <remap_page_range+528>:      mov    %eax,%ebx
0xc0140231 <remap_page_range+530>:      jne    0xc014025c <remap_page_range+573>
0xc0140233 <remap_page_range+532>:      mov    0xffffffec(%ebp),%eax
0xc0140236 <remap_page_range+535>:      addl   $0x8,0xffffffe4(%ebp)
0xc014023a <remap_page_range+539>:      mov    0xffffffe0(%ebp),%ecx
0xc014023d <remap_page_range+542>:      add    $0x40000000,%eax
0xc0140242 <remap_page_range+547>:      and    $0xc0000000,%eax
0xc0140247 <remap_page_range+552>:      setne  %dl
0xc014024a <remap_page_range+555>:      cmp    %ecx,%eax
0xc014024c <remap_page_range+557>:      mov    %eax,0xffffffec(%ebp)
0xc014024f <remap_page_range+560>:      setb   %al
0xc0140252 <remap_page_range+563>:      and    %edx,%eax
0xc0140254 <remap_page_range+565>:      test   $0x1,%al
0xc0140256 <remap_page_range+567>:      jne    0xc0140099 <remap_page_range+122>
0xc014025c <remap_page_range+573>:      mov    0xfffffff0(%ebp),%edx
0xc014025f <remap_page_range+576>:      mov    (%edx),%eax
0xc0140261 <remap_page_range+578>:      call   0xc0110a79 <flush_tlb_mm>
0xc0140266 <remap_page_range+583>:      mov    0xffffffdc(%ebp),%ecx
0xc0140269 <remap_page_range+586>:      movb   $0x1,0x30(%ecx)
0xc014026d <remap_page_range+590>:      mov    $0xffffe000,%eax
0xc0140272 <remap_page_range+595>:      and    %esp,%eax
0xc0140274 <remap_page_range+597>:      subl   $0x1,0x14(%eax)
0xc0140278 <remap_page_range+601>:      mov    0x8(%eax),%eax
0xc014027b <remap_page_range+604>:      test   $0x8,%al
0xc014027d <remap_page_range+606>:      jne    0xc0140295 <remap_page_range+630>
0xc014027f <remap_page_range+608>:      add    $0x3c,%esp
0xc0140282 <remap_page_range+611>:      mov    %ebx,%eax
0xc0140284 <remap_page_range+613>:      pop    %ebx
0xc0140285 <remap_page_range+614>:      pop    %esi
0xc0140286 <remap_page_range+615>:      pop    %edi
0xc0140287 <remap_page_range+616>:      pop    %ebp
0xc0140288 <remap_page_range+617>:      ret    
0xc0140289 <remap_page_range+618>:      mov    %edx,%eax
0xc014028b <remap_page_range+620>:      call   0xc03a24e3 <__preempt_spin_lock>
0xc0140290 <remap_page_range+625>:      jmp    0xc0140099 <remap_page_range+122>
0xc0140295 <remap_page_range+630>:      call   0xc03a2035 <preempt_schedule>
0xc014029a <remap_page_range+635>:      add    $0x3c,%esp
0xc014029d <remap_page_range+638>:      mov    %ebx,%eax
0xc014029f <remap_page_range+640>:      pop    %ebx
0xc01402a0 <remap_page_range+641>:      pop    %esi
0xc01402a1 <remap_page_range+642>:      pop    %edi
0xc01402a2 <remap_page_range+643>:      pop    %ebp
0xc01402a3 <remap_page_range+644>:      ret    

