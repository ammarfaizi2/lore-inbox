Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318564AbSHEPfr>; Mon, 5 Aug 2002 11:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318585AbSHEPfr>; Mon, 5 Aug 2002 11:35:47 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:11945 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318564AbSHEPfq>; Mon, 5 Aug 2002 11:35:46 -0400
Date: Mon, 5 Aug 2002 16:39:11 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
Message-ID: <20020805163910.C7130@kushida.apsleyroad.org>
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain> <m3u1mb5df3.fsf@averell.firstfloor.org> <ail2qh$bf0$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <ail2qh$bf0$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Aug 05, 2002 at 05:35:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I agree that it is really sad that we have to save/restore FP on
> signals, but I think it's unavoidable.

Couldn't you mark the FPU as unused for the duration of the
handler, and let the lazy FPU mechanism save the state when it is used
by the signal handler?

> And yes, this signal handler thing is clearly visible on benchmarks. 
> MUCH too clearly visible.  I just didn't see any safe alternatives
> (and I still don't ;( )

I use SEGVs to trap access to read-only pages for garbage collection,
and I know I'm not the only one.  That's a lot of SEGVs...

Fwiw, I have timed SIGSEGV handling time on Linux on various Intel CPUs,
on a PA-RISC running HP-UX and on a few Sparcs running Solaris.  Linux
came out faster in all cases.  Best case: 8 microseconds to trap a page
fault, handle the SEGV and mprotect() one page (600MHz P3).  Worst case:
37 microseconds (133MHz Pentium).

That's about 5000 cycles.  I'm sure we can do better than that.

For sophisticated user space uses, like the above, I'd like to see
a trap handling mechanism that saves only the _minimum_ state.
Userspace can take care of the rest.  Maybe even without a sigreturn in
some cases.

-- Jamie
