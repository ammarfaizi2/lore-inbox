Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290169AbSAKXpi>; Fri, 11 Jan 2002 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290170AbSAKXpd>; Fri, 11 Jan 2002 18:45:33 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51891 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290169AbSAKXpN>; Fri, 11 Jan 2002 18:45:13 -0500
Date: Fri, 11 Jan 2002 16:45:31 -0700
Message-Id: <200201112345.g0BNjVQ13657@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
In-Reply-To: <3C3F4FC6.97A6A66D@zip.com.au>
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com>
	<3C3F4FC6.97A6A66D@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Manfred Spraul wrote:
> > 
> > If an app has an VM_GROWS{DOWN,UP} stack and calls
> > mlockall(MCL_FUTURE|MCL_CURRENT), which pages should the kernel lock?
> > 
> > * grow the vma to the maximum size and lock all.
> > * just according to the current size.
> > 
> > What should happen if the segment is extended by more than one page
> > at once? (i.e. a function with 100 kB local variables)
> > 
> > * Just allocate the page that is needed to handle the page faults
> > * always fill holes immediately.
> > 
> > Right now segments are not grown during the mlockall syscall. Some
> > codepaths fill holes (find_extend_vma()), most don't (page fault
> > handlers)
> > 
> > What's the right thing (tm) to do?
> > I don't care which implementation is choosen, but IMHO all
> > implementations should be identical
> 
> This was a problem encountered when taking a libpthread-based
> application from 2.4.7 to 2.4.15.   It ran fine with mlockall
> under 2.4.7, but under 2.4.15 everything wedged up.   This was, I assume,
> because under 2.4.15, the many pthread stacks were fully faulted in and
> locked at mlockall() time.    We ended up just not using mlockall
> at all.
> 
> Really the 2.4.15 behaviour is correct, but undesirable.  It requires
> each thread to know apriori what its maximum stack use will be.
> (I'm assuming that there's a way of setting a thread's stack size
> in libpthread).
> 
> So in this case, the behaviour I would prefer is MCL_FUTURE for
> all vma's *except* the stack.   Stack pages should be locked
> only when they are faulted in.   Hard call.

How about controlling this with a MCL_STACK flag or some such? If
there's no One True Path[tm], leave the decision to the application.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
