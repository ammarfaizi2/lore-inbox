Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbULMQ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbULMQ0e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbULMQ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:26:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261267AbULMQYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:24:02 -0500
Date: Mon, 13 Dec 2004 16:23:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213162355.E24748@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrea Arcangeli <andrea@suse.de>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk> <1102949565.2687.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1102949565.2687.2.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Mon, Dec 13, 2004 at 02:52:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 02:52:46PM +0000, Alan Cox wrote:
> On Llu, 2004-12-13 at 13:58, Russell King wrote:
> > Lets take an example.  Lets say that:
> > * a CPU runs at about 245mA when active
> > * 90mA when inactive
> > * the timer interrupt takes 2us to execute 1000 times a second
> > * no other processing is occuring
> 
> Now take a real laptop and the numbers are in the 20W (15A) range.

Roughly 650mA for my laptop while idle or just under 7W - by calculation
from battery capacity and measured lifetime.  The question is how much
of that is due to the CPU itself and how much is due to the peripherals.

> > to eliminate the timer tick to save some power.  However, I've
> > never been able to justify the extra code complexity against the
> > power savings.  It really only makes sense if you can essentially
> > _power off_ your system until the next timer interrupt (thereby,
> > in the above example, reducing the power consumption by some 174mA)
> 
> On a PC it makes huge sense, the deeply embedded folks who do turn the
> thing off for 30secs at a time (Eg cellphone) also want it as do
> virtualisation people where it trashes your scaling. API wise it isn't
> too hard, its just a matter of time to convert the jiffies users away
> and to do relative versions of add_timer with accuracy info included.

I don't disagree with your cellphone example - it makes a whole lot of
sense there, where the device is going to end up in someones pocket
not doing very much at all.


There is another twist here though - the Linux kernel kicks itself out
of idle mode and into some other thread multiple times a second while
the system is idle.  So far, in all my Linux kernel experience, I've
yet to see a kernel where it's possible to stay in the idle thread
for more than half a second.  (The ARM kernels I run are always
configured with IDLE LED support, so I can _see_ when it gets kicked
out of the idle thread.)

So, not only do the VST people need to solve the HZ interrupt problem,
but also need to track down which kernel threads keep waking up on an
otherwise idle system "just in case" they need to do something.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
