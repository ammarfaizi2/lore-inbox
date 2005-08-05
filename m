Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVHEWIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVHEWIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVHEWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:07:15 -0400
Received: from fmr24.intel.com ([143.183.121.16]:28108 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261986AbVHEWGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:06:22 -0400
Message-Id: <200508052205.j75M5gg32259@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: <ak@suse.de>, <christoph@lameter.com>, <dwg@au1.ibm.com>
Subject: RE: [RFC] Demand faulting for large pages
Date: Fri, 5 Aug 2005 15:05:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWZ00XQTpOmHs4TRqi/fjGiR6pjDwAL+WHAAAEB/QA=
In-Reply-To: <200508052133.j75LXig31835@unix-os.sc.intel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Friday, August 05, 2005 8:22 AM
> Below is a patch to implement demand faulting for huge pages.  The main
> motivation for changing from prefaulting to demand faulting is so that
> huge page allocations can follow the NUMA API.  Currently, huge pages
> are allocated round-robin from all NUMA nodes.   

Chen, Kenneth W wrote on Friday, August 05, 2005 2:34 PM
> Spurious WARN_ON.  Calls to hugetlb_pte_fault() is conditioned upon 
> if (is_vm_hugetlb_page(vma))
> 
> ....
> 
> Broken here.  Return VM_FAULT_SIGBUS when *pte is present??  Why
> can't you move all the logic into hugetlb_pte_fault and simply call
> it directly from handle_mm_fault?


I'm wondering has this patch ever been tested?  More broken bits:
in arch/i386/mm/hugetlbpage.c:huge_pte_offset - with demand paging,
you can't unconditionally walk the page table without checking
existence of pud and pmd.

I haven't looked closely at recent change in free_pgtables(), but
we used to have a need to scrub old pmd mapping before allocate one
for hugetlb pte on x86.  You have to do that in huge_pte_alloc(),
I'm specifically concerned with arch/i386/mm/hugetlbpage.c:huge_pte_alloc()

- Ken

