Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVCASp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVCASp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 13:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVCASp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 13:45:29 -0500
Received: from colin2.muc.de ([193.149.48.15]:12040 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262023AbVCASpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 13:45:20 -0500
Date: 1 Mar 2005 19:45:18 +0100
Date: Tue, 1 Mar 2005 19:45:18 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050301184518.GA18207@muc.de>
References: <422428EC.3090905@jp.fujitsu.com> <m1hdjvi8r3.fsf@muc.de> <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 10:08:48AM -0800, Linus Torvalds wrote:
> The thing is, IO errors just will be very architecture-dependent. Some 
> might have exceptions happening, without the exception handler really 
> having much of an idea of who caused it, unless that driver had prepared 
> it some way, and gotten the proper locks.

A lot of architectures will move towards PCI Express over the next years,
and it has nice standardized error handling. It won't work
on a lot of older chipsets, but having such a feature only
on new hardware is ok.

> A non-converted driver just doesn't _do_ any of that. It doesn't guarantee 
> that it's the only one accessing that bus, since it doesn't do the 
> "iocheck_clear()/iocheck_read()" things that imply all the locking etc.

It just reads 0xffffffff all the time and moves on. That will
not be nice, but work for a short time until a higher level
error handler can take over.

> 
> So the default handling for iochecks pretty much _has_ to be "report them 
> to the user", and then letting the user decide what to do if the hardware 
> is going bad.

Not with PCI Express. There is a standard way now to figure out which
device went bad and you can get interrupts for it.


> 
> Shutting down the hardware by default might be a horribly bad thing to do
> even _if_ you could pinpoint the driver that caused the problem in the
> first place (and that's a big if, and probably depends on the details of
> what the actual hw architecture support ends up being). So don't even try. 
> The sysadmin may have different preferences than some driver default.

There are already architectures that do it (e.g. IBM ppc64 or HP zx*).
It doesn't work too badly for them.


> 
> In fact, I'd argue that even a driver that _uses_ the interface should not
> necessarily shut itself down on error. Obviously, it should always log the
> error, but outside of that it might be good if the operator can decide and
> set a flag whether it should try to re-try (which may not always be
> possible, of course), shut down, or just continue.

Ok, maybe an /sbin/hotplug like interface may make sense for it.
However shutdown as default is not too bad.

-Andi
