Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSLQRqy>; Tue, 17 Dec 2002 12:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbSLQRqy>; Tue, 17 Dec 2002 12:46:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265320AbSLQRqw>; Tue, 17 Dec 2002 12:46:52 -0500
Date: Tue, 17 Dec 2002 09:55:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>
cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021217171908.GY32122@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Matti Aarnio wrote:
>
> On Tue, Dec 17, 2002 at 09:07:21AM -0800, Linus Torvalds wrote:
> > On Tue, 17 Dec 2002, Hugh Dickins wrote:
> > > I thought that last page was intentionally left invalid?
> >
> > It was. But I thought it made sense to use, as it's the only really
> > "special" page.
>
>   In couple of occasions I have caught myself from pre-decrementing
>   a char pointer which "just happened" to be NULL.
>
>   Please keep the last page, as well as a few of the first pages as
>   NULL-pointer poisons.

I think I have a good clean solution to this, that not only avoids the
need for any hard-coded address _at_all_, but also solves Uli's problem
quite cleanly.

Uli, how about I just add one ne warchitecture-specific ELF AT flag, which
is the "base of sysinfo page". Right now that page is all zeroes except
for the system call trampoline at the beginning, but we might want to add
other system information to the page in the future (it is readable, after
all).

So we'd have an AT_SYSINFO entry, that with the current implementation
would just get the value 0xfffff000. And then the glibc startup code could
easily be backwards compatible with the suggestion I had in the previous
email. Since we basically want to do an indirect jump anyway (because of
the lack of absolute jumps in the instruction set), this looks like the
natural way to do it.

That also allows the kernel to move around the SYSINFO page at will, and
even makes it possible to avoid it altogether (ie this will solve the
inevitable problems with UML - UML just wouldn't set AT_SYSINFO, so user
level just wouldn't even _try_ to use it).

With that, there's nothing "special" about the vsyscall page, and I'd just
go back to having the very last page unmapped (and have the vsyscall page
in some other fixmap location that might even depend on kernel
configuration).

Whaddaya think?

		Linus

