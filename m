Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbTDKSjR (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTDKSjQ (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:39:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:49132 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261390AbTDKSjL (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:39:11 -0400
Date: Fri, 11 Apr 2003 11:52:45 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411185245.GF1821@kroah.com>
References: <20030411032424.GA3688@kroah.com> <200304110837.37545.oliver@neukum.org> <20030411172011.GA1821@kroah.com> <200304112012.05054.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304112012.05054.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 08:12:05PM +0200, Oliver Neukum wrote:
> 
> > > - There's a race with replugging, which you can do little about
> >
> > True, but this can get smaller.
> 
> There isn't such a thing as a small race. Either there is a race or there
> is no race. 'Should usually work' is not enough, especially when security
> is concerned.

You are talking about the "issue" of /dev/foo going away because that
device was removed, and then another device added which creates /dev/foo
just as the user starts to open /dev/foo?  Or something else?

> > > - Error handling. What do you do if the invocation ends in EIO ?
> >
> > Which invocation?  From /sbin/hotplug?
> 
> Yes.
> This is a serious problem. Your scheme has very nasty failure modes.
> By implementing this in user space you are introducing additional
> failure modes.
> - You need disk access -> EIO

If udev becomes a deamon, disk access isn't needed.  Actually the
current version of udev doesn't require any disk access, other than
loading it into memory.

> - You have no control over memory allocation -> ENOMEM, EIO in swap space
> Usually I'd not care about EIO, but here security is threatened. EIO crashing
> the system under some circumstances is inevitable, EIO opening a security
> hole is not acceptable however.

So yes, doing this in userspace causes a number of these kinds of
"problems".  The same kinds of "problems" that all other user programs
have to deal with, right?

So, if udev can't be read from the disk, the machine isn't in a very
workable state, creating that new device node is going to be the least
of your worries.

If udev can't get access to memory (actually it does no malloc calls, so
it would have to run out of stack space), or there is no memory to load
udev into memory, then again, you have a unstable machine, and there's
not much else we can do about it.

> 4000 spawnings is 32MB for kernel stacks alone.
> You cannot assume that resources will be sufficient for that.

If you have 4000 disks, you have to have a _lot_ of memory just to deal
with it.  See the other 4000 disk threads for more discussions about
this issue.

If we fix up the kernel to handle that many different disks, then
userspace can surely handle 4000 tasks (it can handle that today,
right?)

Anyway, it will be quite difficult to plug 4000 disks in "all at once".
There is a time delay inbetween discovering each of those disks from
within the kernel, not to mention the physical issues of spinning them
all up.

> That again is a serious problem, because you cannot resync.
> If you lose a 'remove' event you're screwed.

Yes, if you lose a remove, things can get out of whack.  My goal is to
not lose any.

> And of course, what do you do if the driver is not yet loaded?

Nothing.  udev requires that the kernel assign a major/minor to a
device, which means that a driver has to be bound to the device.
Binding drivers to devices is the current hotplug task, and has nothing
to do with udev (with the exception that we have to be able to call both
programs for each hotplug event, but I'm working on that.)

thanks,

greg k-h
