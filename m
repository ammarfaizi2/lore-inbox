Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbREMRc0>; Sun, 13 May 2001 13:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbREMRcG>; Sun, 13 May 2001 13:32:06 -0400
Received: from ns.suse.de ([213.95.15.193]:5388 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262059AbREMRcF>;
	Sun, 13 May 2001 13:32:05 -0400
Date: Sun, 13 May 2001 19:31:41 +0200
From: Andi Kleen <ak@suse.de>
To: Matt <madmatt@bits.bris.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Timers
Message-ID: <20010513193141.A13912@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0105131735140.22953-100000@bits.bris.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105131735140.22953-100000@bits.bris.ac.uk>; from madmatt@bits.bris.ac.uk on Sun, May 13, 2001 at 05:45:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2001 at 05:45:13PM +0100, Matt wrote:
> I'm having some major headaches trying to get a timer working in my
> driver.
> 
> The timer is started when the device node is opened, and deleted when it's
> closed. The timer code itself calls mod_timer to add itself back in
> again. At the moment, it runs every second and does nothing more than
> issue a debug printk to say it's working okay.
> 
> The problem comes when I try and wrap the timer code inside some down()
> and up() calls to make sure it's not fiddling with the hardware at the
> same time as some other calls. When I do this, I get a huge oops which
> goes right off my screen and I get the "Aieee..." message afterwards and I
> have to push the reset button :(.

You're trying to sleep in an interrupt, which is not allowed.

> 
> Should I be using spin_(un)lock_irqsave() calls anywhere instead of just a
> semaphore? Or is there anything else I should be doing?

Yes you should. The only way to use a semaphore from interrupt context
(=timers) is to use down_trylock() and retry when it was locked, e.g. by
resetting the timer. That is normally awkward and irqsafe spinlocks are 
probably better.  Of course they cannot be held schedules or anything 
that may sleep.

-Andi
