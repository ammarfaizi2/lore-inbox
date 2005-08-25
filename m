Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVHYOfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVHYOfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVHYOfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:35:05 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:4528 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751240AbVHYOfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:35:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=McFOJIqdFNLJeSCB/hiNENlKUcDp0p7PkWiSdz1EJqIbyVBe695iKckf46XVq9cqnqDcK7HCrtrkPI7TGJRnggGegnGF59z0DKtdurlQbrvF0VvsZo+sMC1Y2tpZzxvqd6NwNliWIqGR+1DyylL2Pw1dEeTUJhvSYmVBvFmB/iM=  ;
Message-ID: <430DD71B.50806@yahoo.com.au>
Date: Fri, 26 Aug 2005 00:35:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Parag Warudkar <kernel-stuff@comcast.net>,
       Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
References: <082520051405.5272.430DD0420003F49F00001498220076139400009A9B9CD3040A029D0A05@comcast.net> <200508251622.08456.ak@suse.de>
In-Reply-To: <200508251622.08456.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Would it be worth trying to do something like this?
> 
> 
> Maybe. Shouldn't be very hard though - you just need to check if the VMA is 
> backed by an object and if yes don't call copy_page_range for it.
> 
> I think it just needs (untested) 
> 

I think you need to check for MAP_SHARED as well, because
MAP_PRIVATE mapping of a file could be modified in parent.

See patch I posted just now.

Also, do you need any special case for hugetlb?


> Index: linux-2.6.13-rc5-misc/kernel/fork.c
> ===================================================================
> --- linux-2.6.13-rc5-misc.orig/kernel/fork.c
> +++ linux-2.6.13-rc5-misc/kernel/fork.c
> @@ -265,7 +265,8 @@ static inline int dup_mmap(struct mm_str
>  		rb_parent = &tmp->vm_rb;
>  
>  		mm->map_count++;
> -		retval = copy_page_range(mm, current->mm, tmp);
> +		if (!file && !is_vm_hugetlb_page(vma))
> +			retval = copy_page_range(mm, current->mm, tmp);
>  		spin_unlock(&mm->page_table_lock);
>  
>  		if (tmp->vm_ops && tmp->vm_ops->open)
> 
> But I'm not sure it's a good idea in all cases. Would need a lot of 
> benchmarking  at least.
> 

Yep. I'm sure it must have come up in the past, and Linus
must have said something about best-for-most.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
