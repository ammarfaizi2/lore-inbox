Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTDKTUV (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTDKTUV (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:20:21 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:58044 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261605AbTDKTUQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:20:16 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 21:31:56 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
References: <20030411032424.GA3688@kroah.com> <200304112012.05054.oliver@neukum.org> <20030411185245.GF1821@kroah.com>
In-Reply-To: <20030411185245.GF1821@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304112131.56457.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are talking about the "issue" of /dev/foo going away because that
> device was removed, and then another device added which creates /dev/foo
> just as the user starts to open /dev/foo?  Or something else?

The name is not important. The numbers matter.
A device goes away. It has major:minor x:y. Say it has the name /dev/foo. 
A new device is added and reuses x:y, name /dev/foo2. During the window
while /dev/foo isn't unlinked, you have access to /dev/foo2 with possibly
wrong permissions. It's worse, if you miss a 'remove' event. In that case
you are potentially permanently screwed.

You can avoid that if you never reuse device numbers. But in that case
you'd better think about a 16:48 major:minor split.

> > > > - Error handling. What do you do if the invocation ends in EIO ?
> > >
> > > Which invocation?  From /sbin/hotplug?
> >
> > Yes.
> > This is a serious problem. Your scheme has very nasty failure modes.
> > By implementing this in user space you are introducing additional
> > failure modes.
> > - You need disk access -> EIO
>
> If udev becomes a deamon, disk access isn't needed.  Actually the
> current version of udev doesn't require any disk access, other than
> loading it into memory.

Not true. You might need to swap out memory it uses.

> > - You have no control over memory allocation -> ENOMEM, EIO in swap space
> > Usually I'd not care about EIO, but here security is threatened. EIO
> > crashing the system under some circumstances is inevitable, EIO opening a
> > security hole is not acceptable however.
>
> So yes, doing this in userspace causes a number of these kinds of
> "problems".  The same kinds of "problems" that all other user programs
> have to deal with, right?

They don't and don't have to. Everything else fails securely. If a PAM
module fails, you get no access.

And yes, any scheme that handles device removal in user space has this
problem.

> So, if udev can't be read from the disk, the machine isn't in a very
> workable state, creating that new device node is going to be the least
> of your worries.

Why? You need just a single sector to fail. Murphy will always strike.

> If udev can't get access to memory (actually it does no malloc calls, so
> it would have to run out of stack space), or there is no memory to load
> udev into memory, then again, you have a unstable machine, and there's
> not much else we can do about it.

By this logic you should remove the checks for kmalloc failing.
Running a box into OOM happens. Worse, it can be triggered intentionally.

> > 4000 spawnings is 32MB for kernel stacks alone.
> > You cannot assume that resources will be sufficient for that.
>
> If you have 4000 disks, you have to have a _lot_ of memory just to deal
> with it.  See the other 4000 disk threads for more discussions about
> this issue.
>
> If we fix up the kernel to handle that many different disks, then
> userspace can surely handle 4000 tasks (it can handle that today,
> right?)

Nevertheless, kmalloc can fail and you need to allocate a kernel stack and
page tables to spawn a task. Security must not suffer from that.

> Anyway, it will be quite difficult to plug 4000 disks in "all at once".
> There is a time delay inbetween discovering each of those disks from
> within the kernel, not to mention the physical issues of spinning them
> all up.

Spinning them up? Plug in a cable to a FibreChannel fabric and you get
exactly that situation.

> > That again is a serious problem, because you cannot resync.
> > If you lose a 'remove' event you're screwed.
>
> Yes, if you lose a remove, things can get out of whack.  My goal is to
> not lose any.

How? Or precisely, how can you guarantee it?

	Regards
		Oliver

