Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTANWAU>; Tue, 14 Jan 2003 17:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTANWAU>; Tue, 14 Jan 2003 17:00:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14345 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264716AbTANWAT>;
	Tue, 14 Jan 2003 17:00:19 -0500
Date: Tue, 14 Jan 2003 14:08:59 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
Message-ID: <20030114220859.GA17226@kroah.com>
References: <20030113054708.GA3604@kroah.com> <20030114200719.B4077@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114200719.B4077@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 08:07:19PM +0000, Russell King wrote:
> On Sun, Jan 12, 2003 at 09:47:09PM -0800, Greg KH wrote:
> > In digging into the tty layer locking, I noticed that the tty layer
> > doesn't handle module reference counting for any tty drivers.  Well, I've
> > known this for a long time, just finally got around to fixing it :)
> > Here's a patch against 2.5.56 that should fix this issue (works for
> > me...)
> > 
> > Comments?  If no one objects, I'll send it on to Linus, and add support
> > for this to a number of tty drivers that commonly get built as modules.
> 
> Firstly, I've proven my original suspicions about tty hangup wrong.
> However, I'm concerned that we don't have sufficient locking present
> (even in 2.4) to ensure that unloading tty driver modules is safe by
> any means.
> 
> The first point where we obtain a driver structure is under the
> BKL in tty_io.c:init_dev(), which calls get_tty_driver().
> get_tty_driver() searches a list of drivers for the relevant
> entry.  There are no locks here.

init_dev() is only called from tty_open() which is called under the BKL.

> Now, consider tty_unregister_driver().  This is normally called from
> a tty driver modules cleanup function.  Also note that there are no
> locks here.
> 
> Also consider tty_register_driver() and note, again, that there are
> no locks here.

Ok, there should be some kind of lock of the tty_drivers list, I agree.
But that doesn't pertain to this module reference counting patch, right?

> Checking kernel/module.c, the BKL isn't held when calling the modules
> init and cleanup functions.

Woah!  Hm, this is going to cause lots of problems in drivers that have
been assuming that the BKL is grabbed during module unload, and during
open().  Hm, time to just fallback on the argument, "module unloading is
unsafe" :(

> So, all in all, we have a nice SMP race between loading tty driver
> modules, unloading tty driver modules, and getting reference counts
> on driver modules.

Yeah, you're right.  But this isn't the only subsystem that now has this
race :(

I still think the original patch will help, and it will remove all of
the MOD_INC usages in tty drivers, which is a step in the right
direction.

So I'll send this to Linus, and we'll move on to the next locking mess
in here...

thanks,

greg k-h
