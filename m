Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129335AbRBOS5z>; Thu, 15 Feb 2001 13:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129326AbRBOS5p>; Thu, 15 Feb 2001 13:57:45 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:28740 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129118AbRBOS53>;
	Thu, 15 Feb 2001 13:57:29 -0500
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200102151857.KAA82397@google.engr.sgi.com>
Subject: Re: x86 ptep_get_and_clear question
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Thu, 15 Feb 2001 10:57:16 -0800 (PST)
Cc: bcrl@redhat.com (Ben LaHaise), linux-mm@kvack.org, mingo@redhat.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010215194246.A2437@pcep-jamie.cern.ch> from "Jamie Lokier" at Feb 15, 2001 07:42:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Kanoj Sarcar wrote:
> > > Here's the important part: when processor 2 wants to set the pte's dirty
> > > bit, it *rereads* the pte and *rechecks* the permission bits again.
> > > Even though it has a non-dirty TLB entry for that pte.
> > > 
> > > That is how I read Ben LaHaise's description, and his test program tests
> > > exactly this.
> > 
> > Okay, I will quote from Intel Architecture Software Developer's Manual
> > Volume 3: System Programming Guide (1997 print), section 3.7, page 3-27:
> > 
> > "Bus cycles to the page directory and page tables in memory are performed
> > only when the TLBs do not contain the translation information for a 
> > requested page."
> > 
> > And on the same page:
> > 
> > "Whenever a page directory or page table entry is changed (including when 
> > the present flag is set to zero), the operating system must immediately
> > invalidate the corresponding entry in the TLB so that it can be updated
> > the next time the entry is referenced."
> > 
> > So, it looks highly unlikely to me that the basic assumption about how
> > x86 works wrt tlb/ptes in the ptep_get_and_clear() solution is correct.
> 
> To me those quotes don't address the question we're asking.  We know
> that bus cycles _do_ occur when a TLB entry is switched from clean to
> dirty, and furthermore they are locked cycles.  (Don't ask me how I know
> this though).
> 
> Does that mean, in jargon, the TLB does not "contain
> the translation information" for a write?
> 
> The second quote: sure, if we want the TLB updated we have to flush it.
> And eventually in mm/mprotect.c we do.  But what before, it keeps on
> using the old TLB entry?  That's ok.  If the entry was already dirty
> then we don't mind if processor 2 continues with the old TLB entry for a
> while, until we do the big TLB range flush.
> 
> In other words I don't think those two quotes address our question at
> all.

Agreed. But these are the only relevant quotes I could come up with. And
to me, these quotes make the ptep_get_and_clear() assumption look risky
at best ... even though they do not give clear answers either way.

> 
> What worries more is that this is quite a subtle requirement, and the
> code in mm/mprotect.c is not specific to one architecture.  Do all SMP
> CPUs support by Linux do the same thing on converting TLB entries from
> clean to dirty, or do they have a subtle, easily missed data integrity
> problem?

No. All architectures do not have this problem. For example, if the
Linux "dirty" (not the pte dirty) bit is managed by software, a fault
will actually be taken when processor 2 tries to do the write. The fault
is solely to make sure that the Linux "dirty" bit can be tracked. As long
as the fault handler grabs the right locks before updating the Linux "dirty"
bit, things should be okay. This is the case with mips, for example.

The problem with x86 is that we depend on automatic x86 dirty bit
update to manage the Linux "dirty" bit (they are the same!). So appropriate
locks are not grabbed.

Kanoj


> 
> -- Jamie
> 

