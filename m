Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266133AbRGSW50>; Thu, 19 Jul 2001 18:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266130AbRGSW5P>; Thu, 19 Jul 2001 18:57:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:64530 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266133AbRGSW5D>; Thu, 19 Jul 2001 18:57:03 -0400
Date: Thu, 19 Jul 2001 15:55:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Julian Anastasov <ja@ssi.bg>
cc: "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <Pine.LNX.4.33.0107200051480.984-100000@u.domain.uli>
Message-ID: <Pine.LNX.4.33.0107191550220.3044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Fri, 20 Jul 2001, Julian Anastasov wrote:
>
> In my distro (now with gcc 2.96) I have a gcc info with name "Extended
> Asm", "Assembler Instructions with C Expression Operands" with the
> following text:

[ yes ]

> What I want to say (I could be wrong and that can't surprise me) is
> that the original cpuid_eax is in fact incorrect.

No. It's correct, because cpuid doesn't have any side effects (*), so we
don't need to mark it volatile. gcc is free to remove it if nothing uses
the outputs, for example. But gcc cannot (and generally does not) ignore
outputs that _are_ specified.

Now, adding the "volatile" doesn't really make things worse, and it will
make gcc even more anal about optimizations than it normally is, which is
probably why that also hides the gcc bug.

Note that gcc having bus in the inline asm handling is nothing new. We've
had that before, and I'm sure we'll have it again. Not very many people
use them: the kernel tends to be the heaviest user of them (with libc
probably a good second). Which is why bugs here often take time to get
fixed. It doesn't help that the documentation has been quite bad, even
misleading, at times.

		Linus

(*) cpuid has the side effect of being a "synchronizing instruction", and
as such you can use it for some SMP ordering things etc, but as it's one
of the slowest such instructions nobody is really ever interested in using
it that way, and it doesn't have any other "architecturally visible"
effects that the compiler could care about.

