Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129271AbRBOSnO>; Thu, 15 Feb 2001 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129378AbRBOSnE>; Thu, 15 Feb 2001 13:43:04 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:9734 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129271AbRBOSmz>;
	Thu, 15 Feb 2001 13:42:55 -0500
Date: Thu, 15 Feb 2001 19:42:46 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: Ben LaHaise <bcrl@redhat.com>, linux-mm@kvack.org, mingo@redhat.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010215194246.A2437@pcep-jamie.cern.ch>
In-Reply-To: <20010215184729.A2247@pcep-jamie.cern.ch> <200102151823.KAA00802@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102151823.KAA00802@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Thu, Feb 15, 2001 at 10:23:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kanoj Sarcar wrote:
> > Here's the important part: when processor 2 wants to set the pte's dirty
> > bit, it *rereads* the pte and *rechecks* the permission bits again.
> > Even though it has a non-dirty TLB entry for that pte.
> > 
> > That is how I read Ben LaHaise's description, and his test program tests
> > exactly this.
> 
> Okay, I will quote from Intel Architecture Software Developer's Manual
> Volume 3: System Programming Guide (1997 print), section 3.7, page 3-27:
> 
> "Bus cycles to the page directory and page tables in memory are performed
> only when the TLBs do not contain the translation information for a 
> requested page."
> 
> And on the same page:
> 
> "Whenever a page directory or page table entry is changed (including when 
> the present flag is set to zero), the operating system must immediately
> invalidate the corresponding entry in the TLB so that it can be updated
> the next time the entry is referenced."
> 
> So, it looks highly unlikely to me that the basic assumption about how
> x86 works wrt tlb/ptes in the ptep_get_and_clear() solution is correct.

To me those quotes don't address the question we're asking.  We know
that bus cycles _do_ occur when a TLB entry is switched from clean to
dirty, and furthermore they are locked cycles.  (Don't ask me how I know
this though).

Does that mean, in jargon, the TLB does not "contain
the translation information" for a write?

The second quote: sure, if we want the TLB updated we have to flush it.
And eventually in mm/mprotect.c we do.  But what before, it keeps on
using the old TLB entry?  That's ok.  If the entry was already dirty
then we don't mind if processor 2 continues with the old TLB entry for a
while, until we do the big TLB range flush.

In other words I don't think those two quotes address our question at
all.

What worries more is that this is quite a subtle requirement, and the
code in mm/mprotect.c is not specific to one architecture.  Do all SMP
CPUs support by Linux do the same thing on converting TLB entries from
clean to dirty, or do they have a subtle, easily missed data integrity
problem?

-- Jamie
