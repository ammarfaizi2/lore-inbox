Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbTFLWfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbTFLWfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:35:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:3730 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265027AbTFLWf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:35:28 -0400
Date: Thu, 12 Jun 2003 15:50:40 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030612225040.GA1492@kroah.com>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612150335.6710a94f.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:03:35PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > > 3) /sbin/hotplug events can occur out of order, eg: remove event occurs, 
> > > /sbin/hotplug sleeps waiting for something, insert event occurs and 
> > > completes immediately.  Then the remove event completes, after the 
> > > insert, resulting in out-of-order completion and a broken /dev.  I have 
> > > seen this several times with udev.
> > 
> > I responded:
> > 	Yes this happens.  I have a fix for this for udev itself.  No
> > 	kernel changes are needed.  I'll show it at OLS in July if you
> > 	want to see it :)
> 
> This is a significantly crappy aspect of the /sbin/hotplug callout.  I'd be
> very interested in reading an outline of how you propose fixing it, without
> waiting until OLS, thanks.

Sure, I knew someone would probably want to :)

Anyway, here's what I've come up with, feel free to shoot it full of
holes:

<handwaving>
	- serialize the hotplug events in userspace:
		- udev daemon running listening on named pipe
		- small event generator kicked off from /sbin/hotplug
		  call to write event to udev pipe

	  This alone solves the major memory issues that people have
	  complained about, and allows us to keep a ram database of
	  present devices and their names, which a lot of people want to
	  have.  It also makes the /sbin/hotplug binary even smaller
	  than 6k :)

	- apply debounce on events:
		- get event, delay Tbus amount of time.
		- after time expires, check queue to see if we have any
		  other events for this device.
		- if not, this is the only one, act on it.
		- if so, delay Tbus amount of time again.
		- continue delaying until no new events for this device
		  are present.
		- count up events for this device, and throw away the
		  odd ones (even vs. odd, i.e.  2 adds and 1 remove
		  really mean add the device.)
		- if both counts are even, then leave device at its
		  current state (added or removed) but check device
		  attributes to see if we had named it a "special" name.
		  If so, need to make sure "special" name is still
		  correct.  If not, fix it.

Now the whole trick is coming up with the Tbus time limit :)

For all physical busses, it takes a decent amount of time to add or
remove a device (in the seconds for PCI and USB).  It's pretty hard to
get these events out of order in the first place, except on a _very_
heavily loaded system (I've tried.)  It's easier to get events out of
order for virtual devices (like scsi-debug).  That's why a different
time value for different busses makes sense.

So if Tbus is too small, we do get events out of order, make Tbus too
big, and we start delaying too long, and get a real deep queue.
So it's better to leave Tbus too big to be safe, more testing of proper
values is essential before I even start to claim that this will work for
all people, but I do think it is possible.

One other thing that I think will work is making it a sliding scale (if
we get an event, for example, for add, and the device is already there,
increase Tbus and throw it back on the queue (and don't delete the other
ones) and sleep again).  This too needs a lot of testing.

The above sequence has seemed to work pretty well for me so far, but it
needs a lot more work and tweaking with real life loads.

I've also been sidetracked recently with other work, but should have
code to show by OLS...

</handwaving>

thanks,

greg k-h
