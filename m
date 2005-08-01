Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVHAATt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVHAATt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVHAATt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:19:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261818AbVHAATs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:19:48 -0400
Date: Sun, 31 Jul 2005 17:19:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Pavel Machek <pavel@ucw.cz>, ambx1@neo.rr.com,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <21d7e9970507311659259e5560@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0507311709410.14342@g5.osdl.org>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com> 
 <Pine.LNX.4.58.0507311550400.14342@g5.osdl.org>  <20050731230507.GE27580@elf.ucw.cz>
  <Pine.LNX.4.58.0507311622510.14342@g5.osdl.org>  <20050731232735.GF27580@elf.ucw.cz>
  <Pine.LNX.4.58.0507311635360.14342@g5.osdl.org> <21d7e9970507311659259e5560@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Aug 2005, Dave Airlie wrote:
> 
> That still doesn't handle the case where a device has an interrupt
> handler on a shared IRQ and another device on the chain interrupts it
> after it has suspended its device,

I don't know why people bother arguing about this. Face the facts: we have 
to do things incrementally. Any design that breaks unmodified drivers is 
by _definition_ broken. You can't fix all drivers, and anybody who starts 
their arguments with "we should just fix drivers" is living in la-la-land.

Anyway.

My original PM suggestion handled that case perfectly well. The rule was 
to make "go to sleep" be a two-phase operation:

 - phase 1: save state, and possibly return errors
 - phase 2: turn off

where the second stage was done with interrupts disabled and atomically.

And the first phase was done without actually changing the state of the
device at all (so that if some device said "I can't do that, Dave", there
is no need to go back and wake anything up at all), and we could allocate 
memory freely, because the disk was still working etc etc.

For some totally inexplicable reason, the PM people never liked this, and 
ended up doing a single "power off" setup. Which was always known to be 
broken, and caused tons of problems, like the fact that save-to-disk had 
to wake up a device that had already been shut off etc.

So the fact that the PM layer was "simplified" to a single-phase setup 
causes a lot of problems, but hey, stupid is as stupid does. I've given up 
worrying about what crazy things the PM list comes up with, and instead I 
now have a hard rule: a patch that breaks some machine gets reverted.

Is that too hard to understand?

I'll repeat it again:

	A patch that breaks some machine gets reverted.

and maybe somebody on the PM list will one day understand what it means to
have slow and steady progress instead of dicking around with the idea of 
the week.

			Linus
