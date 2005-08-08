Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVHHWWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVHHWWq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVHHWWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:22:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:45525 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932287AbVHHWWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:22:45 -0400
Subject: RE: [RFC] Demand faulting for large pages
From: Adam Litke <agl@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, christoph@lameter.com,
       dwg@au1.ibm.com
In-Reply-To: <200508052205.j75M5gg32259@unix-os.sc.intel.com>
References: <200508052205.j75M5gg32259@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1123539400.3122.365.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 08 Aug 2005 17:16:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 17:05, Chen, Kenneth W wrote:
> Adam Litke wrote on Friday, August 05, 2005 8:22 AM
> > Below is a patch to implement demand faulting for huge pages.  The main
> > motivation for changing from prefaulting to demand faulting is so that
> > huge page allocations can follow the NUMA API.  Currently, huge pages
> > are allocated round-robin from all NUMA nodes.   
> 
> Chen, Kenneth W wrote on Friday, August 05, 2005 2:34 PM
> > Spurious WARN_ON.  Calls to hugetlb_pte_fault() is conditioned upon 
> > if (is_vm_hugetlb_page(vma))
> > 
> > ....
> > 
> > Broken here.  Return VM_FAULT_SIGBUS when *pte is present??  Why
> > can't you move all the logic into hugetlb_pte_fault and simply call
> > it directly from handle_mm_fault?

The reason for the VM_FAULT_SIGBUS default return is because I thought a
fault on a pte_present hugetlb page was an invalid/unhandled fault. 
I'll have another think about races to the fault handler though.

With respect to your code logic comment:  The idea was to make
hugetlb_fault() an entry point into the huge page fault handling code. 
This would make the task of adding other types of faults (Copy on Write
for example) easier later.  If people prefer, it would be easy enough to
roll everything into hugetlb_pte_fault().

> I'm wondering has this patch ever been tested?  More broken bits:
> in arch/i386/mm/hugetlbpage.c:huge_pte_offset - with demand paging,
> you can't unconditionally walk the page table without checking
> existence of pud and pmd.

I have tested the patch to the best extent that I can, but would
definitely appreciate more :)  Thanks for the hint about page table
walking.  I've fixed that up for the next iteration.

> 
> I haven't looked closely at recent change in free_pgtables(), but
> we used to have a need to scrub old pmd mapping before allocate one
> for hugetlb pte on x86.  You have to do that in huge_pte_alloc(),
> I'm specifically concerned with arch/i386/mm/hugetlbpage.c:huge_pte_alloc()

I've definitely been able to produce some strange behavior on 2.6.7
relative to your post about this topic here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/0234.html 
I confirmed the fix in 2.6.8 and also don't see the problem when using
my demand fault patch.  Do you have a copy of the program you used to
generate the Oops in the post linked above so I can use it as a test
case?  I'd guess either the problem is gone entirely with demand
faulting, or just harder to trigger.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

