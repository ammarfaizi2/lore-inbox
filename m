Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270489AbTGXExi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 00:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270490AbTGXExi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 00:53:38 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:49036 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S270489AbTGXExh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 00:53:37 -0400
Date: Thu, 24 Jul 2003 15:06:55 +1000
From: David McCullough <davidm@snapgear.com>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Message-ID: <20030724050655.GA11947@beast>
References: <200307232046.46990.bernie@develer.com> <200307240035.38502.bernie@develer.com> <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk> <200307240100.00632.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307240100.00632.bernie@develer.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Bernardo Innocenti lays it down ...
> On Thursday 24 July 2003 00:37, Alan Cox wrote:
> 
> > On Mer, 2003-07-23 at 23:35, Bernardo Innocenti wrote:
> > > It's a sequence of 6 instructions, 18 bytes long, clobbering 4 registers.
> > > The compiler cannot see around it.
> > > This takes 18*11 = 198 bytes just for invoking the 'current'
> > > macro so many times.
> >
> > Unless you support SMP I'm not sure I understand why m68k nommu changed
> > from using a global for current_task ?
> 
> The people who might know best are Greg and David from SnapGear.
> I'm appending them to the Cc list.
> 
> But I noticed that most archs in 2.6 do like this. Is it some kind
> of flock-effect? Things get changed in i386 and all other archs
> just follow... :-)

It's a little this way for sure.

Back when I first did the 2.4 uClinux port,  the m68k MMU code was
dedicating a register (a2) for current.  I thought that was a bad idea
given how often you run out of registers on the 68k,  and made it a
global.  Because it was still effectively a pointer,  the code size
change was not a factor.  I just didn't want to give up a register.
So that is the 2.4 history and it has served us well so far ;-)

On the 2.5/2.6 front,  I think the change comes from the 8K (2 page) task
structure and everyone just masking the kernel stack pointer to get the
task pointer.  Gerg would know for sure,  he did the 2.5 work in this area.
We should be easily able to switch back to the current_task pointer with a
few small mods to entry.S.

A general comment on the use of inline throughout the kernel.  Although
they may show gains on x86 platforms,  they often perform worse on 
embedded processors with limited cache,  as well as adding size.  I
can't see any way of coding around this though.  As long as x86 is
driving influence,  other platforms will jut have to deal with it as
best they can.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
