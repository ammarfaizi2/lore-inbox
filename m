Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRBOSYL>; Thu, 15 Feb 2001 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbRBOSYC>; Thu, 15 Feb 2001 13:24:02 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:18437 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129434AbRBOSXu>; Thu, 15 Feb 2001 13:23:50 -0500
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200102151823.KAA00802@google.engr.sgi.com>
Subject: Re: x86 ptep_get_and_clear question
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Thu, 15 Feb 2001 10:23:38 -0800 (PST)
Cc: bcrl@redhat.com (Ben LaHaise), linux-mm@kvack.org, mingo@redhat.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010215184729.A2247@pcep-jamie.cern.ch> from "Jamie Lokier" at Feb 15, 2001 06:47:29 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> [Added Linus and linux-kernel as I think it's of general interest]
> 
> Kanoj Sarcar wrote:
> > Whether Jamie was trying to illustrate a different problem, I am not
> > sure.
> 
> Yes, I was talking about pte_test_and_clear_dirty in the earlier post.
> 
> > Look in mm/mprotect.c. Look at the call sequence change_protection() -> ...
> > change_pte_range(). Specifically at the sequence:
> > 
> > 	entry = ptep_get_and_clear(pte);
> > 	set_pte(pte, pte_modify(entry, newprot));
> >
> > Go ahead and pull your x86 specs, and prove to me that between the 
> > ptep_get_and_clear(), which zeroes out the pte (specifically, when the 
> > dirty bit is not set), processor 2 can not come in and set the dirty 
> > bit on the in-memory pte. Which immediately gets overwritten by the 
> > set_pte(). For an example of how this can happen, look at my previous 
> > postings.
> 
> Let's see.  We'll assume processor 2 does a write between the
> ptep_get_and_clear and the set_pte, which are done on processor 1.
> 
> Now, ptep_get_and_clear is atomic, so we can talk about "before" and
> "after".  Before it, either processor 2 has a TLB entry with the dirty
> bit set, or it does not (it has either a clean TLB entry or no TLB entry
> at all).
> 
> After ptep_get_and_clear, processor 2 does a write.  If it already has a
> dirty TLB entry, then `entry' will also be dirty so the dirty bit is
> preserved.  If processor 2 does not have a dirty TLB entry, then it will
> look up the pte.  Processor 2 finds the pte is clear, so raises a page fault.
> Spinlocks etc. sort everything out in the page fault.
> 
> Here's the important part: when processor 2 wants to set the pte's dirty
> bit, it *rereads* the pte and *rechecks* the permission bits again.
> Even though it has a non-dirty TLB entry for that pte.
> 
> That is how I read Ben LaHaise's description, and his test program tests
> exactly this.

Okay, I will quote from Intel Architecture Software Developer's Manual
Volume 3: System Programming Guide (1997 print), section 3.7, page 3-27:

"Bus cycles to the page directory and page tables in memory are performed
only when the TLBs do not contain the translation information for a 
requested page."

And on the same page:

"Whenever a page directory or page table entry is changed (including when 
the present flag is set to zero), the operating system must immediately
invalidate the corresponding entry in the TLB so that it can be updated
the next time the entry is referenced."

So, it looks highly unlikely to me that the basic assumption about how
x86 works wrt tlb/ptes in the ptep_get_and_clear() solution is correct.

Kanoj

> 
> If the processor worked by atomically setting the dirty bit in the pte
> without rechecking the permissions when it reads that pte bit, then this
> scheme would fail and you'd be right about the lost dirty bits.  I would
> have thought it would be simpler to implement a CPU this way, but
> clearly it is not as efficient for SMP OS design so perhaps CPU
> designers thought about this.
> 
> The only remaining question is: is the observed behaviour defined for
> x86 CPUs in general, or are we depending on the results of testing a few
> particular CPUs?
> 
> -- Jamie
> 

