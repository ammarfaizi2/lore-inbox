Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287231AbSALRtP>; Sat, 12 Jan 2002 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287234AbSALRtG>; Sat, 12 Jan 2002 12:49:06 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:46340 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287231AbSALRs7>; Sat, 12 Jan 2002 12:48:59 -0500
Message-ID: <3C4076EC.FEA42077@linux-m68k.org>
Date: Sat, 12 Jan 2002 18:48:28 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
CC: Rob Landley <landley@trommello.org>, Robert Love <rml@tech9.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, nigel@nrg.org,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020111195018.A2008@hq.fsmlabs.com> <20020112042404.WCSI23959.femail47.sdc1.sfba.home.com@there> <20020111220051.A2333@hq.fsmlabs.com> <3C4023A2.8B89C278@linux-m68k.org> <20020112052802.A3734@hq.fsmlabs.com> <3C40392F.C4E1EFF3@linux-m68k.org> <20020112075638.A5098@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> No. The point of using semaphores is that one can sleep while
> _waiting_ for the resource.
> [...]
> In a preemptive kernel this can cause a deadlock. In a non
> preemptive it cannot. You are correct in that
> B:
>         get sem on memory pool
>                 do potentially blocking operations
>         release sem
> is also dangerous - but I don't think that helps your case.
> To fix B, we can enforce a coding rule - one of the reasons why
> we have all those atomic ops in the kernel is to be able to
> avoid this problem.

Sorry I can't follow you. First, one can sleep while waiting for the
semaphore _and_ while holding it. Second we use atomic ops (e.g. for
resource management) exactly because there are not protected by any
semaphore/spinlock.

> Let's suppose the Gnome desktop constantly creates and
> destroys new fresh i/o bound tasks to do something. So with the old fashioned non
> preempt (ignoring Andrew) we get
> [...]

There is no priority problem! If there is a more important task to run,
the less important one simply has to wait, but it will still get its
time. Your deadlock situation does not exists. The average time a
process has to wait for a lower priority process might be increased, but
the worst case behaviour is still the same.
The problem that does exist is the coarse time slice accounting, which
is easier to exploit with the preempt kernel, but it's not a new
problem. On the other hand it's a solvable problem, which requires no
priority inversion.

> > Andrew's patch requires constant audition and Andrew can't audit all
> > drivers for possible problems. That doesn't mean Andrew's work is
> > wasted, since it identifies problems, which preempting can't solve, but
> > it will always be a hunt for the worst cases, where preempting goes for
> > the general case.
> 
> the preempt requires constant auditing too - and more complex auditing.
> After all, a missed audit in Andrew will simply increase worst case timing.
> A missed audit in preempt will hang the system.

As long as the scheduler isn't changed, this isn't true and as I said
there are latency problems which preempting can't solve, but it will
automatically take care of the rest.

> Come on! First of all, you are causing me a great deal of pain by making
> me struggle not to make some bad joke about the economics of Linux companies.

Feel free, I'm not a big believer in the economics of software companies
in general, anyway.

> More important, not making money has nothing to do with purity of motivation -
> don't you read this list?

Everyone has its motivation and I do respect that, but I'm getting
suspicious as soon as money is involved. If people disagree, they can
still get along nicely and do their thing independently. But if they
have to make a living by getting a share of a cake, it usually only
works as long as there is enough cake, otherwise it can get nasty very
quickly (and usually there is never enough cake).

bye, Roman
