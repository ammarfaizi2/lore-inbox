Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTJICxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 22:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTJICxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 22:53:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:8881 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbTJICxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 22:53:40 -0400
Date: Wed, 8 Oct 2003 19:53:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <20031009024334.GA7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> How about
>  
>         action = NULL;
>         if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS))) {
>                 action = desc->action;
>                 status &= ~IRQ_PENDING; /* we commit to handling */
> 		if (likely(action))
> 			status |= IRQ_INPROGRESS; /* we are handling it */
>         }
>         desc->status = status;
> 
> in handle_irq()?

I don't mind it per se, but I don't much see the point either. 
handle_irq() is pretty timing-critical, so we should keep it as fast as 
humanly possible. In contrast, all the other paths that care about 
IRQ_INPROGRESS are _not_ generally timing-critical, which is why I'd 
rather have them do the extra work.

In particular, in this case the only other path that seems to care would 
be "disable_irq()", which does indeed care (well "request_irq()" also 
cares, but request_irq() already clears the bit).

> 	See above - we shouldn't clear it on action == NULL, but we don't
> need to set it, AFAICS.

I agree that we don't need to set it. It's more of a streamlining 
question.

For 2.4.x it might also be a question of "which patch is smaller"  
(conceptually and in practice). I think they end up being exactly the same
in this case.

> > So the fix is to make 2.4.x do what 2.6.x does, methinks.
> 
> ObOtherFun:  There's another bogosity in quoted ide-probe.c code, according
> to dwmw2 - he says that there are PCI IDE cards that get IRQ 0, so the
> test for hwif->irq is b0rken.  We probably should stop overloading
> ->irq == 0 for "none given", but I'm not sure that we *have* a value
> that would never be used as an IRQ number on all platforms...

The BIOS defines irq 0 in the PCI config space to be "no irq" as far as I
know, and on all PC platforms I've ever heard of it's not a usable irq for
generic PCI devices (it's wired to the timer thing). 

All PCI routing chipsets I know about also make "irq0" mean "disabled". 

Which is not to say that a badly configured setup might not do it, but it 
really sounds fundamentally broken. 

		Linus

