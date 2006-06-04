Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750761AbWFDRPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFDRPF (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWFDRPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 13:15:04 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750761AbWFDRPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 13:15:03 -0400
Subject: Re: [RFC] Per-architecture randomization
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44830703.3000905@comcast.net>
References: <44825E42.5090902@comcast.net>
	 <1149411968.3109.79.camel@laptopd505.fenrus.org>
	 <44830703.3000905@comcast.net>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 19:15:01 +0200
Message-Id: <1149441301.3109.120.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 12:14 -0400, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Arjan van de Ven wrote:
> > On Sun, 2006-06-04 at 00:14 -0400, John Richard Moser wrote:
> >> Pavel Machek recommended per-architecture randomization defaults when I
> >> poked a (very hackish) patch up here.  As follow-up, I have taken out
> >> the command line parameter code and used the infrastructure I wrote to
> >> implement per-architecture randomization settings.
> >>
> >> Three #defines are needed per architecture, preferably in
> >> include/asm-ARCH/processor.h or equivalent.  These defines are as follows:
> >>
> >>  STACK_ALIGN -- Alignment of the stack, typically 16 (bytes).
> >>     If not defined, stack randomization is carried out to page
> >>     granularity
> >>  ARCH_RANDOM_STACK_BITS -- Bits of entropy to apply to the stack.
> >>     If not defined, stack randomization is disabled by defining this
> >>     as 0.
> >>  ARCH_RANDOM_MMAP_BITS -- Bits of entropy to apply to the mmap() base.
> >>     If not defined, mmap() randomization is disabled by defining this
> >>     as 0.
> > 
> > 
> > eh....
> > 
> > I think you missed a few things..
> > like
> > 1) This is per architecture already for the most part!
> >    arch_align_stack() is obvious per architecture already
> 
> Yes you write a new one for each individual architecture, to tweak a few
> variables in it.  Not that having the same function with the same blob
> of code with 1 or 2 numbers in it changed matters, since only 1 is
> generated to code...

well stack alignment IS a per architecture property, and on some
architectures it'll be more complex than a single one-liner (think about
a 32 bit userspace needing different alignment than 64 bit as a simple
example of this).

It's a 2 or 3 line function for the simple cases like x86 so... why
bother making it really complex.


> > Also you probably should explain what the advantage is over the existing
> > per architecture approach. Just stating "it's per architecture" (as you
> > suggest) doesn't cut it since it is per architecture already for the
> > most part.
> 
> 1.  I can get away with exactly 1 mmap() randomization function, instead
> of 1 function per architecture.

which needs to be there for other reasons anyway; VA space layout is a
per architecture thing no matter what (just look at ia64 or ppc on how
complex things can get), randomization within each region is, as a
result of that, also a per architecture thing; with different rules for
different part of the VA space sometimes (ia64/ppc64) or on the type of
userspace that happens to be running (on all architectures that also
have a compat arch)

>   - Less code to maintain

we're talking less than a handful lines of code again, most of which is
NOT shareable.

>   - The entropy levels are #defined per arch instead of hard-coded into
>     functions (more readable in the future)

that's a separate thing; if you want to use a define rather than an open
coded value, fair enough, but make that a separate patch really;
especially since that is basically a "one line to a header + one line
code delta" which is then trivial to review for identity.

> 2.  I can get away with exactly 1 arch_align_stack() function, instead
> of 1 per architecture.

I don't think that that is fundamentally possible, see above.

> 3.  Entropy levels are rather easy to adjust and tweak per-architecture
>     or per-compile or per-execve().

this I don't get; you change a per arch thing to.. a per arch thing.


> Part of the bulk stems from the fact that I didn't do randomization
> based on range, but based on bits of entropy.  

I don't understand why you want to do that. It will make code a lot more
complex, and at the same time it limits you to powers-of-two in
practice.

> I became more comfortable
> with looking at entropy based on entropy instead of period*entropy
> mostly from reading through the PaX documents**.  

Using bits-of-entropy in documentation is fine, you can do fractions
there as well for example. No objection from me on that, but it
shouldn't have to complicate or limit the code. For code, "range" is a
native principle much more than "bits of". 


