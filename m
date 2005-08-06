Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVHFByq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVHFByq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 21:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVHFByq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 21:54:46 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2822 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261831AbVHFByS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 21:54:18 -0400
Message-ID: <42F417E3.2070909@vmware.com>
Date: Fri, 05 Aug 2005 18:52:35 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk, hpa@zytor.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, pratap@vmware.com,
       Riley@Williams.Name
Subject: Re: [PATCH 1/1] i386 Encapsulate copying of pgd entries
References: <200508060026.j760Q6FT025108@zach-dev.vmware.com> <20050806011301.GD7991@shell0.pdx.osdl.net>
In-Reply-To: <20050806011301.GD7991@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2005 01:51:48.0860 (UTC) FILETIME=[68910BC0:01C59A29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* zach@vmware.com (zach@vmware.com) wrote:
>  
>
>>+	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>> 	if (PTRS_PER_PMD == 1)
>> 		spin_lock_irqsave(&pgd_lock, flags);
>> 
>>-	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
>>+	clone_pgd_range((pgd_t *)pgd + USER_PTRS_PER_PGD,
>> 			swapper_pg_dir + USER_PTRS_PER_PGD,
>>-			(PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
>>-
>>+			KERNEL_PGD_PTRS);
>> 	if (PTRS_PER_PMD > 1)
>> 		return;
>> 
>> 	pgd_list_add(pgd);
>> 	spin_unlock_irqrestore(&pgd_lock, flags);
>>-	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>>    
>>
>
>Why memset was never done on PAE?
>  
>

That's a good point.  The memset() is redundant on PAE, since it 
allocates all 4 PMDs immediately after that (in pgd_alloc).  There are 
two reasons for moving the memset() - one is that it can potentially 
perform useful work ahead of the lock and effectively act as a 
prefetch.  The second is that at least on a hypervisor, 
clone_pgd_range() is likely to be taken as a page allocation hint, and 
thus moving the memset() before this operation allows only the actually 
present page directory entry updates to be passed to the hypervisor.

Actually, the memset() could be redundant on non-PAE as well, since we 
should have gone through free_pgtables, which would have done a 
pmd_clear() on each user level pmd, and the kernel level pmds are copied 
in again inside the lock.

I'll try it out to see if this is possible.

Zach
