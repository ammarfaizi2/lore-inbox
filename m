Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTKZNEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTKZNEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:04:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47233 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261889AbTKZNEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:04:50 -0500
Date: Wed, 26 Nov 2003 08:06:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
In-Reply-To: <3FC3E2F4.4080809@softhome.net>
Message-ID: <Pine.LNX.4.53.0311260745190.9601@chaos>
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos>
 <3FC3E2F4.4080809@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Ihar 'Philips' Filipau wrote:

> Richard B. Johnson wrote:
> >
> > As documented, malloc() will never fail as long as there
> > is still address space (not memory) available. This is
> > the required nature of the over-commit strategy. This is
> > necessary because many programs never even touch all the
> > memory they allocate.
> >
>
>    We are reading different mans? My man malloc(3) clearly states that
> malloc() can return NULL. (*)
>

Yes. It returns (void *) NULL if it fails to allocate memory. On
many/most/(all?) Unix memory allocators, this failure occurs when
there is no more address-space available (learn about setting the
break address and/or memory-mapping). Expecting malloc() to
know how much free RAM is available is simply wrong. Dynamic
RAM is dynamic. What is available at this instant will be
different during another, especially when tasks can be created
and die thousands of times before you ever even touch that
memory.

>    May I ask you one question? Did you were ever doing once graceful
> failure of application under memory pressure? Looks like not.
>

Yes. I'm in the business of making embedded systems that cannot
fail. And they do not fail. They allocate memory once during
startup and they never fail or exit. They also do not use malloc()
but that's not an issue.

>    I can guess why sendmail allocates memory it never touches - memory
> pools. There are situations where you really cannot fail - and memory
> allocation failures are really nasty. Do you wanna to lose your e-mails?
> No? So then think twice, while implementing lazy allocators.
>
>    So from my tests I see that by default Linux is not safe. You allocate
> memory - malloc() != NULL. Then later you try to write to this memory
> and you get killed by oom_killer. What is the point of this? Your
> reasoning doesn't sound to me.
>

There is MUCH more to designing a "safe" system than having some
'C' runtime library figure out if there will be memory available
next week when your program touches it. You should learn that
malloc() and friends are not kernel functions. The kernel simply
sets the break address when asked by the caller and/or memory-maps
some address space. In both cases the only reason to fail is
the address-space being out-of-range.

You can ask the kernel to check available dunamic RAM during
this procedure, which is what I showed you how to do, but
that is not a very good idea because there will likely be
no RAM available at this instant, but many GB available when
you actually need it.

Note that if you write a byte at offset 0x1zillion, you do NOT
need to allocate 0x1zillion bytes of memory. You only need
one page. That's a major reason why Virtual RAM systems work.

>    Memory pools used by applications exactly to make grace error
> handling under memory pressure - but it looks like this stuff under
> Linux gets no testing at all. And default settings could make from
> simple bug complete disaster.
>

Wrong. It is up to the application to allocate and deallocate
dynamic memory properly.  FYI, you can always look at /proc/meminfo
yourself instead of expecting malloc() to do it for you. You only
need to look at swap.

[SNIPPED..tirade]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


