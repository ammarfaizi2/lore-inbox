Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWEOXww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWEOXww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWEOXww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:52:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750827AbWEOXwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:52:51 -0400
Date: Mon, 15 May 2006 16:52:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
In-Reply-To: <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605151644090.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>  <20060423150206.546b7483.akpm@osdl.org>
  <20060508145609.GA3983@rhlx01.fht-esslingen.de>  <20060508084301.5025b25d.akpm@osdl.org>
  <20060508163453.GB19040@flint.arm.linux.org.uk> 
 <1147730828.26686.165.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org> <1147734026.26686.200.camel@localhost.localdomain>
 <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 May 2006, Linus Torvalds wrote:
> 
> On Tue, 16 May 2006, Alan Cox wrote:
> > 
> > It would certainly be a lot cleaner than this sort of code in the 
> > pcmcia core right now. Want me to send a patch which only allows for 
> > SA_SHIRQ and WARN_ON()'s for any driver not asking for shared IRQ ?
> 
> I think it's too late for that in the current series, but yes, we could do 
> it for 2.6.18.

Actually, thinking about it some more, what we _should_ do is to just make 
any code that simply doesn't _work_ with shared interrupts have to use 
SA_EXCLUSIVE.

And then, for a while, warn if we see a "request_irq()" call that has 
neither SA_SHIRQ nor SA_EXCLUSIVE set. But this would be a pretty mild 
warning, along the lines of

 "%s getting non-SHIRQ irq. It _may_ or may not be shared in the future"

and eventually just stop caring, and making SA_SHIRQ have no meaning. It's 
kind of pointless to ask all drivers to use SA_SHIRQ, when it really 
should be the default.

Even the ISA drivers that currently do not have SA_SHIRQ won't generally 
_break_ when/if they were to get a shared interrupt. The reason they don't 
have SA_SHIRQ isn't generally that they really really want an exclusive 
interrupt, but simply because they never had a reason to say SA_SHIRQ.

So a lack of SA_SHIRQ doesn't generally mean "I _need_ an exclusive 
interrupt". It could equally well mean "I never bothered to even think 
about whether I could share interrupts or not".

Making it an error to pass in 0 would be silly, because for old ISA 
devices, most of the time they really just don't care.

What think you?

The SA_EXCLUSIVE flag is still needed, but it would be used by things that 
literally cannot handle anything but an exclusive interrupt (eg vm86 mode 
irq access), exactly because they do things like disable that particular 
irq for long times, or because they don't have a status register to read 
(eg, on x86, the timer interrupt really _is_ exclusive for that reason).

Most ISA drivers probably wouldn't care at all one way or the other, I 
suspect. And it would be a waste of time to add SA_SHIRQ to them for no 
actual real gain.

Comments?

		Linus
