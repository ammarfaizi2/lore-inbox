Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVG3VK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVG3VK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVG3VK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:10:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262771AbVG3VK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:10:56 -0400
Date: Sat, 30 Jul 2005 14:10:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <20050730215403.J26592@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <20050730210306.D26592@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507301335050.29650@g5.osdl.org>
 <20050730215403.J26592@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jul 2005, Russell King wrote:
> 
> I don't think so - I believe one of the problem cases is where you
> have a screaming interrupt caused by an improperly setup device.

Not a problem.

The thing is, this is trivially solved by
 - disable irq controller last on shutdown
 - re-enable irq controller last on resume

Think about it. Even if you have screaming irq's (and thus we'll shut
things down somewhere during the resume), when we then get to re-enable
the irq controller thing, we'll have them all back again at that point.
Problem solved.

You can have variations on this, of course - you can enable the irq
controller early _and_ late in the resume process. Ie do a minimal "get
the basics working" early - you might want to make sure that timers etc
work early on, for example, and then a "fix up the details" thing late.

An interrupt controller is clearly a special case, so it's worth spending 
some effort on handling it.

In contrast, what is _not_ worth doing is screweing over every single
driver we have.

		Linus
