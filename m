Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUEFNyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUEFNyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUEFNyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:54:15 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:61194 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S261682AbUEFNyF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:54:05 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <408D65A7.7060207@nortelnetworks.com>
	<s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com>
	<s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com>
	<s5ghduvdg1u.fsf@patl=users.sf.net> <20040504223550.GA32155@kroah.com>
	<s5gy8o7bnhv.fsf@patl=users.sf.net> <20040505025602.GA19873@kroah.com>
	<s5gpt9jexwg.fsf@patl=users.sf.net> <20040505224534.GB30345@kroah.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gk6zpso2m.fsf@patl=users.sf.net>
Date: 06 May 2004 09:54:04 -0400
In-Reply-To: <20040505224534.GB30345@kroah.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> No, it is designed this way on purpose.  Think about devices that
> can be added or removed at any point in time.  Failing a module load
> if a device isn't present at this point in time is not good if the
> device is plugged in a while later.

I am starting to see the benefits of the design.  But I do not think
that it properly addresses every common usage scenario, yet.

> It also would not allow you to bind a driver to a device while the
> kernel is running that the driver doesn't originally know about.
> See the pci sysfs file "new_id" for how you can do this today.  If
> we didn't allow the driver to load that would not be possible at
> all.

I am not suggesting preventing the module from loading.  I am
suggesting that "cold plugging" is a little different from hot
plugging, and that it would be nice to be able to tell when a module
fails to bind to any hardware at initial load.

> >   1) Loading hid.o to talk to the keyboard, as described.
> 
> Why not just build this in the kernel?

No particular reason beyond general principles.  I ultimately plan to
load hid.o only when a USB keyboard is actually present.

> Once the driver is bound to the device, the user can eventually
> press a key.  Perhaps make your timeout longer (1 minute)?

Aside from being theoretically inelegant and unreliable (strictly
speaking, no finite time bound is ever guaranteed to work), it just
feels wrong to make someone wait 1 minute when "the system" should
usually only need a few seconds to tell whether a keyboard is
available.

> >   3) When I load the network driver, I want to wait until it is ready
> >      to use.  Otherwise, when I try to obtain a DHCP lease, sometimes
> >      it fails.
> 
> Run your dhcp connect script after the device is bound to the driver
> through the hotplug interface (the default hotplug scripts do this
> today.)  No waiting, no guessing, no additional scripting, it just works
> exactly when the device is ready for it to work.

OK, I admit that is nice.

However...  It really just pushes the problem back a step.  Once the
network is running, I want to invoke "smbmount".  That is, I want to
*wait* for the DHCP lease to be acquired and then do something else.

I could continue with the event-driven model and have the acquisition
of the lease trigger the mount.  But what if that first event ("device
bound") never comes?  If no network hardware is initially found, I
just want to print a sane diagnostic and halt.  Which brings me back
to using some arbitrary timeout.

> Sorry, but your situation is very unusual, and based on my
> suggestions, I don't think it is needed.

Is it really that unusual?  I thought it happened every time any Linux
system booted.

On my desktop, for instance, a bunch of init.d scripts run in a
certain order and print things like:

    starting network  [OK]
    setting time      [OK]
    etc.

That "setting time" step is not supposed to begin until the "starting
network" step finishes.  And by finishes, I mean succeeds *or fails*.
How does a normal distribution avoid blocking forever when starting
the network, or loading the keyboard driver?  I suspect they use an
arbitrary timeout, which is just fundamentally unreliable.

Sure, there are arbitrary timeouts when fetching a DHCP lease.  But
those are inherent to the network.  Using an arbitrary timeout for
something which should be 100% certain (like "is there a keyboard?")
is poor design.

> But hey, you have the source, if you don't like it, feel free to
> change the code :)

Maintaining my own kernel fork would be even more expensive than
arbitrary timeouts :-).

However, if you agree that this is a problem worth solving, I am
interested in working on patches until you find them acceptable.

Fundamentally, here is what I am thinking.  (I have not yet tried to
understand the source code, so please forgive me if this is way
off-base.)  I presume that when a device driver is loaded, there is a
loop somewhere which offers hardware to the driver.  Each time the
driver binds to a piece of hardware, a hotplug event is generated (?).

All we need is a synthetic event which is generated when NO "device
bound" events are triggered by that loop.  Because really the only
problem, in the cold plugging case, is detecting when the device
driver *fails* to bind to anything.

So I guess I have two questions:

  1) Would you be willing to consider patches which address this
     issue?  Or do you just consider it irrelevant?

  2) As I said, I have not dived into the source code yet.  Any
     suggestions for where to start?

 - Pat
