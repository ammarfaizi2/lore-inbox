Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129926AbRBOTUQ>; Thu, 15 Feb 2001 14:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRBOTUG>; Thu, 15 Feb 2001 14:20:06 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:42500 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129259AbRBOTTz>;
	Thu, 15 Feb 2001 14:19:55 -0500
Date: Thu, 15 Feb 2001 20:19:45 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-mm@kvack.org, mingo@redhat.com, alan@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010215201945.A2505@pcep-jamie.cern.ch>
In-Reply-To: <3A8C254F.17334682@colorfullife.com> <200102151905.LAA62688@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102151905.LAA62688@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Thu, Feb 15, 2001 at 11:05:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kanoj Sarcar wrote:
> > Is the sequence
> > << lock;
> > read pte
> > pte |= dirty
> > write pte
> > >> end lock;
> > or
> > << lock;
> > read pte
> > if (!present(pte))
> > 	do_page_fault();
> > pte |= dirty
> > write pte.
> > >> end lock;
> 
> No, it is a little more complicated. You also have to include in the
> tlb state into this algorithm. Since that is what we are talking about.
> Specifically, what does the processor do when it has a tlb entry allowing
> RW, the processor has only done reads using the translation, and the 
> in-memory pte is clear?

Yes (no to the no): Manfred's pseudo-code is exactly the question you're
asking.  Because when the TLB entry is non-dirty and you do a write, we
_know_ the processor will do a locked memory cycle to update the dirty
bit.  A locked memory cycle implies read-modify-write, not "write TLB
entry + dirty" (which would be a plain write) or anything like that.

Given you know it's a locked cycle, the only sensible design from Intel
is going to be one of Manfred's scenarios.

An interesting thought experiment though is this:

<< lock;
read pte
pte |= dirty
write pte
>> end lock;
if (!present(pte))
	do_page_fault();

It would have a mighty odd effect wouldn't it?

-- Jamie
