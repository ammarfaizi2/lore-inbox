Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129489AbRBJRU4>; Sat, 10 Feb 2001 12:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRBJRUr>; Sat, 10 Feb 2001 12:20:47 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:30888 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129596AbRBJRUj>; Sat, 10 Feb 2001 12:20:39 -0500
Message-ID: <3A8577FD.AEFDBB56@redhat.com>
Date: Sat, 10 Feb 2001 12:18:53 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <961rkk$fgm$1@penguin.transmeta.com> <3A847729.2C868879@redhat.com> <3A850555.488DE444@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Doug Ledford wrote:
> >
> > > I have this strong suspicion that your kernel will lock up in a bad way
> > > of you have somebody do something like divide by zero without actually
> > > touching a single FP instruction after the divide (so that the error has
> > > happened, but has not yet been raised as an exception).
> >
> > Or much worse, let the kernel mix-and-match SSE and MMX optimized routines
> > without doing full saves of the FPU on SSE routines, which leads to FPU saves
> > in MMX routines with kernel data in the SSE registers, which then shows up
> > when the app touches those SSE registers and you get use space corruption.  My
> > code to handle this type of situation was *very* complex, and I don't think I
> > ever got it quite perfectly right without simply imposing a rule that the
> > kernel could never use both SSE and MMX instructions on the same CPU.
> >
> 
> I don't see that problem:
> * sse_{copy,clear}_page() restore the sse registers before returning.
> * the fpu saves into current->thread.i387.f{,x}save never happen from
> interrupts.
> 
> How can kernel sse values end up in user space? I'm sure I overlook
> something, but what?

It's not whether or not your particular code does it.  It's whether or not it
can happen in the framework within which you are using the FPU regs.  No, with
just copy/clear page using these things it won't happen.  But if you add an
SSE zero page function, who's to say that we shouldn't add a memset routine,
or a copy_*_user routines, or copy_csum* routines that also use the SSE regs? 
And once you add those various routines, are they all going to be safe with
respect to each other (the tricky one's here are if you add the copy_*_user
stuff since they can pagefault in the middle of the operation)?  Plus, if you
have both SSE and MMX and maybe even 3DNow operations, are you going to pick
the fastest of each on each processor that supports each type, meaning you may
use one SSE and one MMX routine on the same processor if the MMX routine just
happens to beat out the SSE routine for a particular task?  Once you take all
these things into consideration, the question becomes what limit are you going
to place on kernel SSE register usage?  Because if you don't severly limit its
usage, then you have to handle all the odd scenarios above, and that's where
it gets very difficult to get it right.  So, that's the policy decision that
needs to be made (and Linus typically has made it very difficult to get this
stuff accepted into the kernel, which is an implicit statement of that policy)
before a person can decide if your patch is sufficient, or if it needs
additional protection from other possible SSE/MMX using routines.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
