Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTDKSx3 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTDKSx3 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:53:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60912 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261334AbTDKSx1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:53:27 -0400
Date: Fri, 11 Apr 2003 12:07:17 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411190717.GH1821@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E970A00.2050204@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 11:31:28AM -0700, Kevin P. Fleming wrote:
> 
> OK, this is all fun and games, but this is a valid point. All it takes for 
> the driver for a Fibre Channel host adapter to load, and enumerate the 
> devices it can see. In a matter of seconds many hundreds or thousands of 
> disk devices could be registered with the kernel.

Sure, the kernel can handle spawning hundreds or thousands of tasks all
at once, it's not a problem.

> This is definitely an issue that will need to be addressed, and I think 
> Oliver's suggestion of using a pipe (i'm going to say it: like devfs did 
> :-) to forward the events to /sbin/hotplug in a FIFO fashion makes some 
> sense.

I agree too.  Having /sbin/hotplug send events to a pipe where a daemon
can get them from makes a lot of sense.  It will handle most of the
synchronization and spawning a zillion tasks problems.

> I have also been considering this issue from another angle; I am 
> working on userspace partition discovery, which will be driven by 
> /sbin/hotplug (and udev, probably). I have concerns that the following 
> scenario will cause problems, if not extreme problems:
> 
> - kernel driver finds an IDE drive, registers it and the hotplug event 
> happens
> - udev gets called and gives it device node /dev/discs/disc0 (or whatever)
> - /sbin/hotplug calls userspace partition discovery, which opens the device 
> and scans for partitions
> - if any partitions are found, they are registered with the kernel using 
> device-mapper ioctls
> - because these new "mapped sections" of the drive are _also_ usable block 
> devices in their own right, they generate hotplug events
> - because these hotplug events are for new block devices, userspace 
> partition discovery will get called _again_ to handle them (it may not find 
> anything (the normal case), but this model will support nearly infinite 
> levels of partitioning on any block device supported by the kernel)
> 
> What happens if these secondary hotplug events occur while /sbin/hotplug 
> has not yet finished processing the first one? Ignoring locking/race issues 
> for the moment, I'm concerned about memory consumption as many layers of 
> hotplug/udev/kpartx/etc. are running processing these events.

Yes, this can quickly get recursive up to a point.  There will never be
an infinite number of partitions, so we will eventually quiet down.

> Of course, another possibility I'll look into this weekend is to actually 
> have kpartx run as a daemon and receive messages over D-BUS, instead of 
> being invoked directly by /sbin/hotplug. This would mean it could serialize 
> the events itself and reduce some of the load (if D-BUS supports message 
> queueing, which I believe it does).

Problem is I don't think we can use D-BUS messages during early boot,
before init is called, so we still have to be able to handle startup
issues.  But hopefully the D-BUS code can be small enough to possibly be
used in this manner, I haven't checked that out yet.

> Actually, here's another thought: have the kernel continue to call 
> /sbin/hotplug for every event, just as it does now. However, /sbin/hotplug 
> would do _nothing_ but translate that into D-BUS messages and post them. 
> udev, kpartx, etc. would all just be D-BUS clients that would respond to 
> their messages as they are received.

That's another possibility too.  This is getting interesting :)

thanks,

greg k-h
