Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRBIXFA>; Fri, 9 Feb 2001 18:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130041AbRBIXEv>; Fri, 9 Feb 2001 18:04:51 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:10028 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129927AbRBIXEf>; Fri, 9 Feb 2001 18:04:35 -0500
Message-ID: <3A847729.2C868879@redhat.com>
Date: Fri, 09 Feb 2001 18:03:05 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [beta patch] SSE copy_page() / clear_page()
In-Reply-To: <3A846C84.109F1D7D@colorfullife.com> <961rkk$fgm$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3A846C84.109F1D7D@colorfullife.com>,
> Manfred Spraul  <manfred@colorfullife.com> wrote:
> >
> >* use sse for normal memcopy. Then main advantage of sse over mmx is
> >that only the clobbered registers must be saved, not the full fpu state.
> >
> >* verify that the code doesn't break SSE enabled apps.
> >I checked a sse enabled mp3 encoder and Mesa.
> 
> Ehh..  Did you try this with pending FPU exceptions that have not yet
> triggered?

There are other gotcha's here as well (speaking from experience :-(

> I have this strong suspicion that your kernel will lock up in a bad way
> of you have somebody do something like divide by zero without actually
> touching a single FP instruction after the divide (so that the error has
> happened, but has not yet been raised as an exception).

Or much worse, let the kernel mix-and-match SSE and MMX optimized routines
without doing full saves of the FPU on SSE routines, which leads to FPU saves
in MMX routines with kernel data in the SSE registers, which then shows up
when the app touches those SSE registers and you get use space corruption.  My
code to handle this type of situation was *very* complex, and I don't think I
ever got it quite perfectly right without simply imposing a rule that the
kernel could never use both SSE and MMX instructions on the same CPU.

> And when it hits your SSE copy routines with the pending error, it will
> likely loop forever on taking the fault in kernel space.
> 
> Basically, kernel use of MMX and SSE are a lot harder to get right than
> many people seem to realize.  Why do you think I threw out all the
> patches that tried to do this?
> 
> And no, the bug won't show up in any normal testing.  You'll never know
> about it until somebody malicious turns your machine into a doorstop.
> 
> Finally, did you actually see any performance gain in any benchmarks?

Now this I can comment on.  Real life gain.  We had to re-run a SpecWEB99 test
after taking the SSE instructions out of our (buggy) 2.2.14-5.0 kernel that
shipped in Red Hat Linux 6.2 (hanging bag over my head).  We recompiled the
exact same kernel without the SSE stuff, then re-ran the SpecWEB99 test, and
there was an performance drop of roughly 2% overall from the change.  So, yes,
they make an aggregate performance difference to the typical running of the
kernel (and this was without copy_page or zero_page being optimized, instead I
had done memset, memcpy, copy_*_user as optimized routines) and they make a
huge difference to benchmarks that target the areas they help the most (like
disk I/O benchmarks which would sometimes see a 40% or more boost in
performance).

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
