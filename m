Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbWCUNGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbWCUNGs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWCUNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:06:48 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:39266 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751655AbWCUNGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:06:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gkbdbY60rRjDobPWFoGB/qn3zn4tYncdmCk7/l46aBRvawSpcq3kwCPgWhjWi0vDsbItKQk1R09c4MLHjEWc6IjYQrPIUk7QZ2kILzaXl0dLSEKLzoiaZyAR60MqOd0foPTQqPHjBxi4209tGPMHnF+ch8UxlK8kKLD+ZL8BGig=  ;
Message-ID: <441FEFB4.6050700@yahoo.com.au>
Date: Tue, 21 Mar 2006 23:21:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
References: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
In-Reply-To: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> 1. Add make_pages_unwired routine.

Unfortunately you forgot wire_page and unwire_page, so this patch will
not even compile.

> 2. Replace make_pages_present with make_pages_wired, support rollback.

What does support rollback mean?

> 3. Pass 1 more param ("wire") to get_user_pages.
> 

As others have pointed out, wire may be a BSD / other unix thing, but
it does not feature in Linux memory management terminology. If you
want to introduce it, you need to do a better job of specifying it.

> Signed-off-by: Shaoping Wang <pwstone@gmail.com>
> 

> +void make_pages_unwired(struct mm_struct *mm,
> +					unsigned long start,unsigned long end)
> +{
> +	struct vm_area_struct *vma;
> +	struct page *page;
> +	unsigned int foll_flags;
> +
> +	foll_flags =0;
> +
> +	vma=find_vma(mm,start);
> +	if(!vma)
> +		BUG();
> +	if(is_vm_hugetlb_page(vma))
> +		return;
> +	
> +	for(; start<end ; start+=PAGE_SIZE) {
> +		page=follow_page(vma,start,foll_flags);
> +		if(page)
> +			unwire_page(page);
> +	}
> +}
> +

What happens when start goes past vma->vm_end?

>  int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> -		unsigned long start, int len, int write, int force,
> +		unsigned long start, int len, int write,int force, int wire,
>  		struct page **pages, struct vm_area_struct **vmas)
>  {
>  	int i;
> @@ -973,6 +995,7 @@
>  		if (!vma && in_gate_area(tsk, start)) {
>  			unsigned long pg = start & PAGE_MASK;
>  			struct vm_area_struct *gate_vma = get_gate_vma(tsk);
> +			struct page *page;	
>  			pgd_t *pgd;
>  			pud_t *pud;
>  			pmd_t *pmd;
> @@ -994,6 +1017,7 @@
>  				pte_unmap(pte);
>  				return i ? : -EFAULT;
>  			}
> +			page = vm_normal_page(gate_vma, start, *pte);

You wire gate_vma pages? But it doesn't look like you can unwire them with
make_pages_unwired.

>  			if (pages) {
>  				struct page *page = vm_normal_page(gate_vma, start, *pte);

This can go now?

>  				pages[i] = page;
> @@ -1003,9 +1027,12 @@
>  			pte_unmap(pte);
>  			if (vmas)
>  				vmas[i] = gate_vma;
> +			if(wire)
> +				wire_page(page);
>  			i++;
>  			start += PAGE_SIZE;
>  			len--;
> +
>  			continue;
>  		}
> 
> @@ -1013,6 +1040,7 @@
>  				|| !(vm_flags & vma->vm_flags))
>  			return i ? : -EFAULT;
> 
> +		/* We dont account wired HugeTLB pages */

You don't account wired HugeTLB pages? If you can wire them you should be able
to unwire them as well shouldn't you?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
