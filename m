Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTDKT7T (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDKT7T (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:59:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:43716 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261692AbTDKT7P (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:59:15 -0400
Date: Fri, 11 Apr 2003 13:10:29 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, Daniel Stekloff <dsteklof@us.ibm.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411201029.GP1821@kroah.com>
References: <20030411032424.GA3688@kroah.com> <200304112012.05054.oliver@neukum.org> <20030411185245.GF1821@kroah.com> <200304112131.56457.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304112131.56457.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 09:31:56PM +0200, Oliver Neukum wrote:
> 
> > You are talking about the "issue" of /dev/foo going away because that
> > device was removed, and then another device added which creates /dev/foo
> > just as the user starts to open /dev/foo?  Or something else?
> 
> The name is not important. The numbers matter.

Agreed, I was just using names here as a simplification.

> A device goes away. It has major:minor x:y. Say it has the name /dev/foo. 
> A new device is added and reuses x:y, name /dev/foo2.  During the window
> while /dev/foo isn't unlinked, you have access to /dev/foo2 with possibly
> wrong permissions.

If you are worried about this, don't reuse x:y.  Make them purely
dynamic, and incrementing :)  Yes, this is a 2.7 thing, but will happen
eventually.  I need this framework in order to be able to do that, so
one can't happen without the other...

> It's worse, if you miss a 'remove' event. In that case you are
> potentially permanently screwed.

I don't want to ever miss events.

> You can avoid that if you never reuse device numbers. But in that case
> you'd better think about a 16:48 major:minor split.

I thought we were thinking about a 32:32 split.  But whatever, it
doesn't matter to me.

> > > > > - Error handling. What do you do if the invocation ends in EIO ?
> > > >
> > > > Which invocation?  From /sbin/hotplug?
> > >
> > > Yes.
> > > This is a serious problem. Your scheme has very nasty failure modes.
> > > By implementing this in user space you are introducing additional
> > > failure modes.
> > > - You need disk access -> EIO
> >
> > If udev becomes a deamon, disk access isn't needed.  Actually the
> > current version of udev doesn't require any disk access, other than
> > loading it into memory.
> 
> Not true. You might need to swap out memory it uses.

Then it gets swapped back in.  There isn't anything I can do from
userspace about this.  Hm, well I could pin the memory for the daemon,
but that wouldn't be nice :)

Ok, if you are worried about these kinds of things, then use the
in-kernel devfs.  I'm not going to dispute that userspace faults can
happen.

> > > - You have no control over memory allocation -> ENOMEM, EIO in swap space
> > > Usually I'd not care about EIO, but here security is threatened. EIO
> > > crashing the system under some circumstances is inevitable, EIO opening a
> > > security hole is not acceptable however.
> >
> > So yes, doing this in userspace causes a number of these kinds of
> > "problems".  The same kinds of "problems" that all other user programs
> > have to deal with, right?
> 
> They don't and don't have to. Everything else fails securely. If a PAM
> module fails, you get no access.

See above solution about not re-using numbers :)

> And yes, any scheme that handles device removal in user space has this
> problem.

True.  This is hard, let's go shopping...

> > Anyway, it will be quite difficult to plug 4000 disks in "all at once".
> > There is a time delay inbetween discovering each of those disks from
> > within the kernel, not to mention the physical issues of spinning them
> > all up.
> 
> Spinning them up? Plug in a cable to a FibreChannel fabric and you get
> exactly that situation.

Ok, and the scsi code takes a while to discover them all.  Try it with
scsi-debug, you can watch them get all created, one after another.  Yes,
we spawn a lot of userspace tasks.

> > > That again is a serious problem, because you cannot resync.
> > > If you lose a 'remove' event you're screwed.
> >
> > Yes, if you lose a remove, things can get out of whack.  My goal is to
> > not lose any.
> 
> How? Or precisely, how can you guarantee it?

I can guarantee nothing :)
But I can do a lot to prevent losses.  A lot of people around here point
to the old way PTX used to regenerate the device naming database on the
fly.  We could do that by periodically scanning sysfs to make sure we
are keeping /dev in sync with what the system has physically present.
That's one way, I'm sure there are others.

thanks,

greg k-h
