Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285616AbRLGW0x>; Fri, 7 Dec 2001 17:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285617AbRLGW0o>; Fri, 7 Dec 2001 17:26:44 -0500
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:9625 "HELO
	sanosuke.troilus.org") by vger.kernel.org with SMTP
	id <S285616AbRLGW0f>; Fri, 7 Dec 2001 17:26:35 -0500
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
	<Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
	<20011207185847.A20876@wotan.suse.de>
	<87wuzyq4ms.fsf@sanosuke.troilus.org> <3C110C0B.4030102@antefacto.com>
	<87snampvww.fsf@sanosuke.troilus.org> <3C11368F.4020408@antefacto.com>
From: Michael Poole <poole@troilus.org>
Date: 07 Dec 2001 17:26:34 -0500
In-Reply-To: <3C11368F.4020408@antefacto.com>
Message-ID: <87oflapsyt.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady <padraig@antefacto.com> writes:

> Well you have to deal with the general case. A single threaded
> app linking against a multithreaded lib. It mightn't be just
> shared FILE*'s that could cause problems.

The question was about putc(), and presumably other stdio functions.
They deal with FILE*'s.  They are also commonly used and small
operations, so forcing locking on an app that doesn't ask for it can
(and has in the past) cause a major performance degredation.  I bet
you could find very similar results for memory allocation in other
applications.

> > Linus's suggestion to add hooks to pthread_create() gets around that
> > problem, anyway.
> 
> I don't think this will work as I said before current apps that
> use _unlocked() functions directly manipulate the stdio structures,
> hence a "new smarter locking stdio" would never get used by existing
> compiled apps.

As Linus pointed out, you just need another test in those macros, so
they can be forced to call functions rather than using inline code.
When you call a function, it can use whatever new smarter locking
library you want.

> > Alternatively, the multi-threaded library could
> > require any application linking to it to define _REENTRANT.
> 
> It could, but what if an existing interface (lib) is changed
> from signle to multithreaded. You can't preclude this.

I certainly can preclude that.  I'd consider adding threads and their
locking considerations to the library a change in the API and ABI --
and quite a big one at that.  If you change the ABI (rather than just
extending it), you must increase the major version number, which
prevents linking with those applications that expect the semantics of
earlier versions.

(BSD variants have in the past had both libc and libc_r, where only
libc_r makes you pay locking overhead.  This is yet another way to
enforce the ABI separation between single- and multi-threaded
applications, with different tradeoffs than the others mentioned.)

-- Michael
