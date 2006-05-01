Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWEAQhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWEAQhy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWEAQhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:37:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58818 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932148AbWEAQhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:37:53 -0400
To: vgoyal@in.ibm.com
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kexec: Avoid overwriting the current pgd
 (i386)
References: <20060501095041.16897.49541.sendpatchset@cherry.local>
	<20060501143512.GA7129@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 01 May 2006 10:37:26 -0600
In-Reply-To: <20060501143512.GA7129@in.ibm.com> (Vivek Goyal's message of
 "Mon, 1 May 2006 10:35:12 -0400")
Message-ID: <m1u089aegp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, May 01, 2006 at 06:49:16PM +0900, Magnus Damm wrote:
>> kexec: Avoid overwriting the current pgd (i386)
>> 
>> This patch upgrades the i386-specific kexec code to avoid overwriting the
>> current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
>> to start a secondary kernel that dumps the memory of the previous kernel.
>> 
>> The code introduces a new set of page tables called "page_table_a". These
>> tables are used to provide an executable identity mapping without overwriting
>> the current pgd.
>
> True, current pgd is overwritten but that effects only user space mappings
> and currently "crash" supports only backtracing kernel space code. But at
> the same time probably it is not a bad idea to maintain a separate page
> table and switch to that instead of overwriting the existing pgd. This
> shall help if in future user space backtracing is also supported.
>   
> [..]
>>  
>> +static int allocate_page_table_a(struct kimage *image)
>> +{
>> +	struct page *page;
>> +	int k = sizeof(image->page_table_a) / sizeof(image->page_table_a[0]);
>> +
>> +	for (; k > 0; k--) {
>> +		page = kimage_alloc_control_pages(image, 0);
>> +		if (!page)
>> +			return -ENOMEM;
>> +
>> +		clear_page(page_address(page));
>> +		image->page_table_a[k - 1] = page;
>
> I think you also need to write the logic to free those pages if somebody
> chooses to unload the pre-loaded kernel.

Because these are control pages we already keep track of them,
so we can free them along with everything else.

> [..]
>> --- 0001/include/linux/kexec.h
>> +++ work/include/linux/kexec.h	2006-05-01 11:13:14.000000000 +0900
>> @@ -69,6 +69,17 @@ struct kimage {
>>  	unsigned long start;
>>  	struct page *control_code_page;
>>  
>> +	/* page_table_a[] holds enough pages to create a new page table
>> +	 * that maps the control page twice..
>> +	 */
>> +
>> +#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
>> +	struct page *page_table_a[3]; /* (2 * pte) + pgd */
>> +#endif
>> +#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
>> +	struct page *page_table_a[5]; /* (2 * pte) + (2 * pmd) + pgd */
>> +#endif
>> +
>
> Would it make a cleaner interface if these array of pointers are maintained
> in arch dependent code as global variables instead of putting in arch
> independent code. Existing code does something simlar. This becomes further
> ugly when another array comes into the picture for x86_64 in next patch.
> (page_table_b)

Well global variables don't quite work in the normal case.

However it probably makes most sense to maintain the needed variables
in a structure on the control page.  Which will keep them out of harms way,
and won't require patches to the generic code.

Eric
