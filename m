Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWIVTuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWIVTuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWIVTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:50:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964838AbWIVTuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:50:13 -0400
Date: Fri, 22 Sep 2006 12:49:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] do_no_pfn()
Message-Id: <20060922124940.5ca5ee87.akpm@osdl.org>
In-Reply-To: <yq0u033c84a.fsf@jaguar.mkp.net>
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
	<yq0u033c84a.fsf@jaguar.mkp.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Sep 2006 03:25:25 -0400
Jes Sorensen <jes@sgi.com> wrote:

> Implement do_no_pfn() for handling mapping of memory without a struct
> page backing it. This avoids creating fake page table entries for
> regions which are not backed by real memory.
> 
> This feature is used by the MSPEC driver and other users, where it is
> highly undesirable to have a struct page sitting behind the page
> (for instance if the page is accessed in cached mode via the struct
> page in parallel to the the driver accessing it uncached, which can
> result in data corruption on some architectures, such as ia64).
> 
> This version uses specific NOPFN_{SIGBUS,OOM} return values, rather
> than expect all negative pfn values would be an error. It also bugs on
> cow mappings as this would not work with the VM.


How does this followup look?


We don't want the rarely-used do_no_pfn() to get inlined in the oft-used
handle_pte_fault(), using up icache.  Mark it noinline and unlikely.


--- a/mm/memory.c~do_no_pfn-tweaks
+++ a/mm/memory.c
@@ -2276,8 +2276,10 @@ oom:
  *
  * It is expected that the ->nopfn handler always returns the same pfn
  * for a given virtual mapping.
+ *
+ * Mark this `noinline' to prevent it from bloating the main pagefault code.
  */
-static int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
+static noinline int do_no_pfn(struct mm_struct *mm, struct vm_area_struct *vma,
 		     unsigned long address, pte_t *page_table, pmd_t *pmd,
 		     int write_access)
 {
@@ -2376,7 +2378,7 @@ static inline int handle_pte_fault(struc
 					return do_no_page(mm, vma, address,
 							  pte, pmd,
 							  write_access);
-				if (vma->vm_ops->nopfn)
+				if (unlikely(vma->vm_ops->nopfn))
 					return do_no_pfn(mm, vma, address, pte,
 							 pmd, write_access);
 			}
_

