Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTJIPqs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJIPqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:46:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40071 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262193AbTJIPqq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:46:46 -0400
Date: Thu, 9 Oct 2003 16:46:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031009154641.GB7665@parcelfarce.linux.theplanet.co.uk>
References: <20031009024334.GA7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 07:53:36PM -0700, Linus Torvalds wrote:
> For 2.4.x it might also be a question of "which patch is smaller"  
> (conceptually and in practice). I think they end up being exactly the same
> in this case.

Unfortunately, they don't (AFAICS) ;-/

BTW, there is another thing that feels odd - we start with IRQ_DISABLED
set for everything and ->depth set to 0.  disable_irq(irq); enable_irq(irq);
gets us into the state where
	a) IRQ_DISABLED is reset
	b) ->depth is 0.
However, any subsequent register_irq();free_irq() gets us back to the
IRQ_DISABLED being set and ->depth set to 0.

IOW, we have very odd rules of IRQ_DISABLED - when ->action is non-NULL,
it's set iff ->depth is positive.  That's nice - if you call disable_irq(),
you know that enable_irq() will undo the effects.

*However*, if you have ->action == NULL, the state depends on history.
Morover, once you've done disable_irq(), you have no way to undo all
effects - enable_irq() will land you in a different state.

It gets particulary ugly when you consider modules - if you do disable_irq(),
poke into the hardware and decide to bail out, there is no way to restore
the original state on cleanup path.  Which leaves us with permanent effects
of failed insmod.

I'm not saying that it's necessary a bug (aside of the issues with
IRQ_INPROGRESS), but it feels like a bug waiting to happen.  If we really
don't care about interrupts arriving after e.g. such failed insmod, why don't
we simply have enable_irq() check that ->action is non-NULL and reset
IRQ_DISABLED only in that case?  Then it would really be an opposite
of disable_irq() in all cases we care about.

I do realize that some code might rely on the current behaviour and call
irq_disable();irq_enable() as a way to reset IRQ_DISABLED when ->action
is NULL.   However, I'd argue that it's a kludge - note that simply calling
enable_irq() will *not* work, you need to call disable_irq() first.  Which
doesn't look like a sane interface...

IOW, the question is: do we want enable_irq() to undo all effects of
disable_irq()?  Whether the current behaviour is intentional or not,
it's worth documenting, IMO...
