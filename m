Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWDCOpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWDCOpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWDCOpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:45:54 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:27498 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751629AbWDCOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:45:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=szfED7B74nbC+tFc6VsksW9UHDhXzmC9UJ/5j0jTXeVK/HV3m2uhcRbQ+eiQGc+VkGaIKEXRzcDuxfdB6zKE1THcgh7yIz0epTMlkmjFz/iifCYWmw4H4u+DuF0Z1HDAWfBa90zbo1O47SiRI/P6FMH3KGf1YYcOuryiKZ3E9J8=  ;
Message-ID: <44310B0C.3070203@yahoo.com.au>
Date: Mon, 03 Apr 2006 21:46:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       bjorn_helgaas@hp.com, cotte@de.ibm.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net>
In-Reply-To: <yq0k6a6uc7i.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> +static int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
> +		     unsigned long address, pte_t *page_table, pmd_t *pmd,
> +		     int write_access)
> +{
> +	spinlock_t *ptl;
> +	pte_t entry;
> +	long pfn;
> +	int ret = VM_FAULT_MINOR;
> +
> +	pte_unmap(page_table);
> +	BUG_ON(!(vma->vm_flags & VM_PFNMAP));
> +
> +	pfn = vma->vm_ops->nopfn(vma, address & PAGE_MASK, &ret);
> +	if (pfn == -ENOMEM)
> +		return VM_FAULT_OOM;
> +	if (pfn == -EFAULT)
> +		return VM_FAULT_SIGBUS;
> +	if (pfn < 0)
> +		return VM_FAULT_SIGBUS;
> +
> +	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
> +
> +	entry = pfn_pte(pfn, vma->vm_page_prot);
> +	if (write_access)
> +		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	set_pte_at(mm, address, page_table, entry);
> +

Should you recheck to make sure nobody else faulted this in
before it was relocked? Doesn't seem to matter in this case,
but it would be more consistent with the other fault handlers.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
