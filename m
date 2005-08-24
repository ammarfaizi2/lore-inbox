Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbVHXTso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbVHXTso (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbVHXTso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:48:44 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:18253 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751500AbVHXTsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:48:37 -0400
Date: Wed, 24 Aug 2005 12:48:36 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question on memory barrier
Message-ID: <20050824194836.GA26526@hexapodia.org>
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com> <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050824173131.50938.qmail@web25809.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 07:31:31PM +0200, moreau francis wrote:
> --- "linux-os (Dick Johnson)" <linux-os@analogic.com> a écrit :
> > On Wed, 24 Aug 2005, moreau francis wrote:
> > > I'm currently trying to write a USB driver for Linux. The device must be
> > > configured by writing some values into the same register but I want to be
> > > sure that the writing order is respected by either the compiler and the
> > > cpu.
[snip]
> > > static inline void dev_out(u32 *reg, u32 value)
> > > {
> > >        writel(value, regs);
> > > }
> > >
> > > void config_dev(void)
> > > {
> > >        dev_out(reg_a, 0x0); /* first io */
> > >        dev_out(reg_a, 0xA); /* second io */
> > > }
> > >
> > 
> > This should be fine. The effect of the first bit of code
> > plus all side-effects (if any) should be complete at the
> > first effective sequence-point (;) but you need to

While sequence points are relevant for purposes of reasoning about the
effects of C code on the abstract state machine as defined by the C
standard, they are irrelevant when talking about IO.

> sorry but I'm not sure to understand you...Do you mean that the first write
> into reg_a pointer will be completed before the second write because they're
> separated by a (;) ?
> Or because writes are encapsulated inside an inline function,
> therefore compiler must execute every single writes before returning
> from the inline function ?

The first register write will be completed before the second register
write because you use writel, which is defined to have the semantics you
want.  (It uses a platform-specific method to guarantee this, possibly
"volatile" or "asm("eieio")" or whatever method your platform requires.)

The sequence points, by themselves, do not make any requirements on the
externally visible behavior of the program.  Nor does the fact that
there's an inline function involved.  It's just the writel() that
contains the magic to force in-order execution.

You might benefit by running your source code through gcc -E and seeing
what the writel() expands to.  (I do something like "rm drivers/mydev.o;
make V=1" and then copy-n-paste the gcc line, replacing the "-c -o mydev.o"
options with -E.)

The sequence point argument is obviously wrong, BTW - if it were the
case that a mere sequence point required the compiler to have completed
all externally-visible side effects, then almost every optimization that
gcc does with -O2 would be impossible.  CSE, loop splitting, etc.

-andy
