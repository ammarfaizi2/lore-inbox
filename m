Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751646AbVJSX6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbVJSX6g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 19:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbVJSX6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 19:58:36 -0400
Received: from fmr22.intel.com ([143.183.121.14]:58274 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751645AbVJSX6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 19:58:35 -0400
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
	2.6.14-rc4-git5
From: Rohit Seth <rohit.seth@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510191345420.3369@g5.osdl.org>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	 <20051018143438.66d360c4.akpm@osdl.org>
	 <1129673824.19875.36.camel@akash.sc.intel.com>
	 <20051018172549.7f9f31da.akpm@osdl.org>
	 <1129692330.24309.44.camel@akash.sc.intel.com>
	 <Pine.LNX.4.61.0510191551180.7586@goblin.wat.veritas.com>
	 <1129747647.339.78.camel@akash.sc.intel.com>
	 <Pine.LNX.4.64.0510191345420.3369@g5.osdl.org>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 19 Oct 2005 17:05:41 -0700
Message-Id: <1129766741.339.141.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2005 23:58:23.0383 (UTC) FILETIME=[FD2AEA70:01C5D508]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 13:53 -0700, Linus Torvalds wrote:
> 

> The fact is, the VM layer is designed for systems that do not cache 
> not-present entries in their TLB. See for example the end of do_no_page() 
> in mm/memory.c:
> 
> 	        /* no need to invalidate: a not-present page shouldn't be cached */
> 	        update_mmu_cache(vma, address, entry);
> 	        lazy_mmu_prot_update(entry);
> 	        spin_unlock(&mm->page_table_lock);
> 	out:
> 	        return ret;
> 
> which _allows_ for hardware that caches not-present pages, but the 
> architecture needs to catch them in the "update_mmu_cache()".
> 

I agree that one way would be to flush the TLB as part of
update_mmu_cache.  But that would result in too many extra global
flushes.  Instead in IA-64, we wait till fault time to do local flushes
whenever needed.

> If ia64 caches non-present TLB entries, then that would seem to be a bug 
> in the Linux ia64 port:
> 
>  - include/asm-ia64/pgtable.h:
> 	#define update_mmu_cache(vma, address, pte) do { } while (0)
> 
> (Of course, you can and maybe do handle it differently: you can also 
> decide to just take the TLB fault, and flush the TLB at fault time in your 
> handler. I don't see that either on ia64, though. Although I didn't look 
> into any of the asm code, so maybe it's hidden somewhere there).
> 

The low level page_not_present vector (asm code) flushes the stale entry
that could be sitting in TLB resulting in current page fault.


But anyways now there is another scenario that Hugh has pointed out in
the last mail that needs to be taken care of too...

-rohit

