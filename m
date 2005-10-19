Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbVJSUx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVJSUx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJSUx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:53:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751305AbVJSUx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:53:27 -0400
Date: Wed, 19 Oct 2005 13:53:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rohit Seth <rohit.seth@intel.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
In-Reply-To: <1129747647.339.78.camel@akash.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0510191345420.3369@g5.osdl.org>
References: <20051018141512.A26194@unix-os.sc.intel.com> 
 <20051018143438.66d360c4.akpm@osdl.org>  <1129673824.19875.36.camel@akash.sc.intel.com>
  <20051018172549.7f9f31da.akpm@osdl.org>  <1129692330.24309.44.camel@akash.sc.intel.com>
  <Pine.LNX.4.61.0510191551180.7586@goblin.wat.veritas.com>
 <1129747647.339.78.camel@akash.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Oct 2005, Rohit Seth wrote:
> 
> IA-64 can prefetch any entry from VHPT (last level page table)
> irrespective of its value.  You are right that i386 and x86_64 does not
> cache !present entry.  Though OS is suppose to handle those faults if
> happen.

Well.. 

The fact is, the VM layer is designed for systems that do not cache 
not-present entries in their TLB. See for example the end of do_no_page() 
in mm/memory.c:

	        /* no need to invalidate: a not-present page shouldn't be cached */
	        update_mmu_cache(vma, address, entry);
	        lazy_mmu_prot_update(entry);
	        spin_unlock(&mm->page_table_lock);
	out:
	        return ret;

which _allows_ for hardware that caches not-present pages, but the 
architecture needs to catch them in the "update_mmu_cache()".

IOW, the kernel is largely designed for present-only caching, and only has 
explicit tlb flush macros for that case.

If ia64 caches non-present TLB entries, then that would seem to be a bug 
in the Linux ia64 port:

 - include/asm-ia64/pgtable.h:
	#define update_mmu_cache(vma, address, pte) do { } while (0)

(Of course, you can and maybe do handle it differently: you can also 
decide to just take the TLB fault, and flush the TLB at fault time in your 
handler. I don't see that either on ia64, though. Although I didn't look 
into any of the asm code, so maybe it's hidden somewhere there).

			Linus
