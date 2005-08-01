Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVHABHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVHABHw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 21:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVHABHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 21:07:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261802AbVHABHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 21:07:50 -0400
Date: Sun, 31 Jul 2005 18:07:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Pavel Machek <pavel@ucw.cz>, ambx1@neo.rr.com,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <21d7e9970507311744261a3bb7@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0507311800560.14342@g5.osdl.org>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> 
 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>  <20050731230507.GE27580@elf.ucw.cz>
  <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>  <20050731232735.GF27580@elf.ucw.cz>
  <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org>  <21d7e9970507311659259e5560@mail.gmail.com>
  <Pine.LNX.4.58.0507311709410.14342@g5.osdl.org> <21d7e9970507311744261a3bb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Dave Airlie wrote:
> 
> You said earlier we only should fix drivers that need fixing, but they
> all need fixing

I think you're still talking from a theoretical standpoing, while all my 
arguments are practical.

In _practice_, I hope that

 (a) we don't see that very much (ie the people for whom things work 
     already are a strong argument that this is less of a problem in
     practice than people try to make it appear)

 (b) drivers, _especially_ on notebooks, are already able to handle an 
     incoming interrupt with the device in D3 state and returning 0xff
     for all reads.

     In particular, this is exactly the same thing that you get on a 
     surprise device removal too.

iow it really _really_ shouldn't matter that a shared interrupt comes in
after (or before) a device has gone to sleep. Because a driver that can't
handle that schenario is buggy for totally unrelated reasons, and doing a 
"free_irq()/request_irq()" pair at suspend time is _not_ the solution!

> I'm trying to see which way they should be fixed, either the PM people
> say we need request/free irq pairs or say we need to put support code in
> the interrupt handlers,

And I say that's not true. See (b) above. As far as I can tell, the 
"interrupt when in D3" really looks _exactly_ the same as "interrupt when 
device was just removed by the user", and nobody will hopefully argue that 
free_irq/request_irq can protect against forced removal?

> This has nothing to do with the issues with highlevel PM interfaces
> for shutting down hardware, this is do with fixing the drivers in the
> kernel currently and what the correct way to do it is without breaking
> someone elses hardware....

... and I don't think this has _anything_ to do with free_irq/request_irq, 
and everything to do with the fact that we can try to make at least the 
common drivers "hardened" for unexpected interrupts coming in when the hw 
might not be ready for them.

		Linus
