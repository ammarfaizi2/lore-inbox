Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTDRTPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbTDRTPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:15:04 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35459 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263219AbTDRTPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:15:02 -0400
Date: Fri, 18 Apr 2003 15:29:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Trivial Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
In-Reply-To: <3EA0469D.7090602@pobox.com>
Message-ID: <Pine.LNX.4.53.0304181512220.22901@chaos>
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
 <3EA02E55.80103@pobox.com> <Pine.LNX.4.53.0304181323400.22493@chaos>
 <3EA0469D.7090602@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Jeff Garzik wrote:

> Richard B. Johnson wrote:
> > On Fri, 18 Apr 2003, Jeff Garzik wrote:
> >
> >
> >>Linus Torvalds wrote:
> >>
> >>>On Fri, 18 Apr 2003, Jeff Garzik wrote:
> >>>
> >>>
> >>>>You should save the strlen result to a temp var, and then s/strcpy/memcpy/
> >>>
> >>>
> >>>No, you should just not do this. I don't see the point.
> >>
> >>
> >>strcpy has a test for each byte of its contents, and memcpy doesn't.
> >>Why search 's' for NULL twice?
> >>
> >>	Jeff
> >
> >
> > Because it doesn't. strcpy() is usually implemented by getting
> > the string-length, using the same code sequence as strlen(), then
> > using the same code sequence as memcpy(), but copying the null-byte
> > as well. The check for the null-byte is done in the length routine.
> >
> > If you do a memcpy(a, b, strlen(b));, then you are making two
> > procedure calls and dirtying the cache twice..
>
> Wrong, because we have to call strlen _anyway_, to provide the size to
> kmalloc.
>
>
> > A typical Intel procedure, stripped of the push/pops to save
> > registers is here....
>
> That's kinda cute.  Why not submit a patch to the strcpy implementation
> in include/asm-i386/string.h?  :)  Ours is shorter, but does have a jump:
>          "1:\tlodsb\n\t"
>          "stosb\n\t"
>          "testb %%al,%%al\n\t"
>          "jne 1b"
>

Years ago I did submit patches of all kinds, mostly 'asm' stuff
because I have been doing assembly for over 20 years. However,
I got tired of being shot-down in flames by persons who haven't
a clue, so I stopped doing that.

The history of the stuff in asm-i386 is full of changes, with
many bugs introduced by persons who tried so save a nanosecond
here and there. In recent times (past two years) somebody changed
the stuff back to things which were not optimum, but quite obviously
correct.

I might 'risk' sending in some patches again. Maybe.

> Which is better?  I don't know; I'm still learning the performance
> eccentricities of x86 insns on various processors.
>

The test for every byte transferred is, quite obviously, correct.
It is also, quite obviously, non optimum.

>
> Related x86 question:  if the memory buffer is not dword-aligned, is
> 'rep movsl' the best idea?  On RISC it's usually smarter to unroll the
> head of the loop to avoid unaligned accesses; but from reading x86 asm
> code in the kernel, nobody seems to care about that.  Is the
> unaligned-access penalty so small that the increased code size of the
> head-unroll is never worth it?
>

Unaligned access takes a penalty. On early i586 machines, it was
horrible, doubled the access time. On i486 and, later on i686
machines, the access times are not changed as radically. Many
of the changes, that were later reverted back, to the string
and memory 'asm' routines occurred when the 'awful' i586
came out. Of course, the unaligned access on the i586 was
still faster than the i486 with aligned access (because of
clock speeds). However, it was worth the trouble to improve
the assembly routines at that time.

>
> > A lot of persons who are unfamiliar with tools other than 'C' think
> > that strcpy() is made like this:
> >
> > 	while(*dsp++ = *src++)
> >                    ;
>
> In fact, that's basically the kernel's non-arch-specific implementation :)
>
> 	Jeff

Yep. Naive code looks so 'simple', must be "optimum", no? ;^).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

