Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVGGRXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVGGRXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 13:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGGRXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 13:23:14 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:9105 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261508AbVGGRV1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 13:21:27 -0400
X-IronPort-AV: i="3.94,178,1118034000"; 
   d="scan'208"; a="263106146:sNHT57677488"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Thu, 7 Jul 2005 12:21:26 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B407436D@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcWDANEI5EMImxzSS+eibk+rnQV+8QAEQuFg
From: <Stuart_Hayes@Dell.com>
To: <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>
X-OriginalArrivalTime: 07 Jul 2005 17:21:27.0220 (UTC) FILETIME=[4EAAD740:01C58318]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Andi--
>> 
>> I made another pass at this.  This does roughly the same thing, but
>> it doesn't create the new "change_page_attr_perm()" functions.  With
>> this patch, the change to init.c (cleanup_nx_in_kerneltext()) is
>> optional. 
>> I changed __change_page_attr() so that, if the page to be changed is
>> part of a large executable page, it splits the page up *keeping the
>> executability of the extra 511 pages*, and then marks the new PTE
>> page as reserved so that it won't be reverted.
>> 
>> So, basically, without the changes to init.c, the NX bits for data in
>> the first two big pages won't get fixed until someone calls
>> change_page_attr() on them.  If NX is disabled, these patches have
>> no functional effect at all. 
>> 
>> How does this look?
> 
> If anything you would need to ask Ingo who did the i386 NX code
> (cc'ed) 
> 
> I personally wouldn't like doing this NX cleanup very late like you
> did but instead directly after the early NX setup. 
> 

I started to do this earlier, in kernel_physical_mapping_init(), where
the PTEs are set up in the first place.  However, at that point, the
__init code still needs to be executable, and the first 1MB of memory
from PAGE_OFFSET to _text also (apparently) needs to be executable.

But I could change it to set it up right from the start, then change
those ranges back to NX after they no longer need to be executable.

> 
>> Thanks!
>> Stuart
>> 
>> -----
>> 
>> diff -purN linux-2.6.12grep/arch/i386/mm/init.c
>> linux-2.6.12/arch/i386/mm/init.c
>> --- linux-2.6.12grep/arch/i386/mm/init.c	2005-07-01
>> 15:09:27.000000000 -0500 +++
>> linux-2.6.12/arch/i386/mm/init.c	2005-07-05 14:32:57.000000000
-0500
>>  @@ -666,6 +666,28 @@ static int noinline do_test_wp_bit(void) 
>> return flag; } 
>> 
>> +/*
>> + * In kernel_physical_mapping_init(), any big pages that contained
>> kernel text area were + * set up as big executable pages.  This
>> function should be called when the initmem + * is freed, to
>> correctly set up the executable & non-executable pages in this area.
>> + */ +static void cleanup_nx_in_kerneltext(void)
>> +{
>> +	unsigned long from, to;
>> +
>> +	if (!nx_enabled) return;
>> +
>> +	from = PAGE_OFFSET;
>> +	to = (unsigned long)_text & PAGE_MASK;
>> +	for (; from<to; from += PAGE_SIZE)
>> +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); +
>> +	from = ((unsigned long)_etext + PAGE_SIZE - 1) & PAGE_MASK;
>> +	to = ((unsigned long)__init_end + LARGE_PAGE_SIZE) &
>> LARGE_PAGE_MASK;
>> +	for (; from<to; from += PAGE_SIZE)
>> +		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL); +}
>> +
>>  void free_initmem(void)
>>  {
>>  	unsigned long addr;
>> @@ -679,6 +701,8 @@ void free_initmem(void)
>>  		totalram_pages++;
>>  	}
>>  	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n",
>> (__init_end - __init_begin) >> 10);
>> +
>> +	cleanup_nx_in_kerneltext();
>>  }
>> 
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> diff -purN linux-2.6.12grep/arch/i386/mm/pageattr.c
>> linux-2.6.12/arch/i386/mm/pageattr.c
>> --- linux-2.6.12grep/arch/i386/mm/pageattr.c	2005-07-01
>> 15:09:08.000000000 -0500 +++
>> linux-2.6.12/arch/i386/mm/pageattr.c	2005-07-05 14:44:53.000000000
>>          -0500 @@ -35,7 +35,8 @@ pte_t *lookup_address(unsigned long
>>  addr return pte_offset_kernel(pmd, address); }
>> 
>> -static struct page *split_large_page(unsigned long address,
>> pgprot_t prot) +static struct page *split_large_page(unsigned long
>> address, pgprot_t prot, +					pgprot_t
ref_prot)
>>  {
>>  	int i;
>>  	unsigned long addr;
>> @@ -53,7 +54,7 @@ static struct page *split_large_page(uns
>>  	pbase = (pte_t *)page_address(base);
>>  	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
>>  		pbase[i] = pfn_pte(addr >> PAGE_SHIFT,
>> -				   addr == address ? prot :
>> PAGE_KERNEL);
>> +				   addr == address ? prot : ref_prot);
>>  	}
>>  	return base;
>>  }
>> @@ -118,11 +119,30 @@ __change_page_attr(struct page *page, pg
if
>>  		(!kpte) return -EINVAL;
>>  	kpte_page = virt_to_page(kpte);
>> +
>> +	/*
>> +	 * If this page is part of a large page that's executable (and
>> NX is
>> +	 * enabled), then split page up and set new PTE page as reserved
>> so
>> +	 * we won't revert this back into a large page.  This should
>> only
>> +	 * happen in large pages that also contain kernel executable
>> code,
>> +	 * and shouldn't happen at all if init.c correctly sets up NX
>> regions. +	 */
>> +	if (nx_enabled &&
>> +	    !(pte_val(*kpte) & _PAGE_NX) &&
>> +	    (pte_val(*kpte) & _PAGE_PSE)) {
>> +		struct page *split = split_large_page(address, prot,
>> PAGE_KERNEL_EXEC); +		if (!split)
>> +			return -ENOMEM;
>> +		set_pmd_pte(kpte,address,mk_pte(split,
>> PAGE_KERNEL_EXEC));
>> +		SetPageReserved(split);
> 
> Why setting reserved? I don't think cpa checks that anywhere.
> In fact Nick has been working on getting rid of Reserved completely.
> 
> 
> Anyways, isn't the code from x86-64 for this enough? It should
> work here too. I don't think such a ugly special case is needed.
> 
> 
> -Andi

I set it reserved so that the large page that was just split wouldn't
get reverted back into a large page ever again (the __change_page_attr()
code won't do that if the PTE page is reserved).  I guess this wouldn't
really be necessary, though, if I make sure that the page count works
right in this case... with this patch the counting won't work right
since the cleanup_nx_in_kerneltext() would be calling
change_page_attr(page,PAGE_KERNEL) on pages that weren't previously
changed to something else.

I still don't think the code from x86_64 would work, because, in x86_64,
kernel_text is mapped to a different virtual address from where data is
accessed.  In x86_64, change_page_attr() changes the PTE attributes as
requested where data is accessed, and, if the same physical address is
in kernel text, it *also* changes the attributes in kernel text.  For
the kernel text addresses, the NX bit in the requested prot is ignored,
and NX is never set.

Because i386 doesn't have a separate virtual address space for the
kernel text and data areas, we couldn't do exactly that.  But we could
do something *similar* to that, where we use either PAGE_KERNEL or
PAGE_KERNEL_EXEC as the "ref_prot", depending on whether the address in
question has any executable kernel code residing in the same large page
as it.  Unless we simply ignored the NX bit in the requested prot,
though, the page still wouldn't get reverted back into a large
(executable) page, so it would have the same affect as this path--i.e.,
large executable pages would get split up the first time anyone called
change_page_attr() on them, and they wouldn't get recombined into a
large page.  It would move the ugly special case above into an address
check in "change_page_attr()".

Thanks again for the feedback!  I'll think about it some more and wait
for comments from Ingo, then try again.


> 
>> +		return 0;
>> +	}
>> +
>>  	if (pgprot_val(prot) != pgprot_val(PAGE_KERNEL)) {
>>  		if ((pte_val(*kpte) & _PAGE_PSE) == 0) {
>>  			set_pte_atomic(kpte, mk_pte(page, prot));
>>  		} else {
>> -			struct page *split = split_large_page(address,
>> prot);
>> +			struct page *split = split_large_page(address,
>> prot, PAGE_KERNEL);
>>  			if (!split)
>>  				return -ENOMEM;
>>  			set_pmd_pte(kpte,address,mk_pte(split,
>> PAGE_KERNEL));
