Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbTFLVcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbTFLVcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:32:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:65006 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265003AbTFLVb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:31:57 -0400
Date: Thu, 12 Jun 2003 14:47:53 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030612214753.GA1087@kroah.com>
References: <3EE8D038.7090600@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE8D038.7090600@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nice, you posted the same message and tarball to lkml that we have been
talking about privately for a few days.

Just to save time, and to bring everyone else up to speed, I'll just
include my responses and then yours to this thread and then finally
respond to your last message to me about this.

Let me know if I get any of the attribution wrong, this is going to be a
fun cut and paste...


On Thu, Jun 12, 2003 at 12:10:48PM -0700, Steven Dake wrote:
> Folks,
> 
> I have been looking at the udev idea that Greg KH has developed.  
> Userland device enumeration definately is the way to go, however, there 
> are some problems with using /sbin/hotplug to transmit device 
> enumeration events:
> 
> 1) performance of fork/exec with lots of devices is very poor

You later said your binary of udev was 500k.  I said:
	500k binary?  Who's running anything that big?  udev weighs in
	around 6k right now!  You have to add a _lot_ of functionality
	to move up to 500k.

You responded:
	Hmm perhaps my binary was not built optmized when I looked at
	it, I'll take another look.

> 2) lots of processes can be forked with no policy to control how many 
> are forked at once potentially leading to OOM

I responded:
	No, this is pure speculation.  Have you actually tried this out?
	I have.  I've hotplugged pci drawers connected to huge numbers
	of SCSI disks and never even seen a blip on system load.  It
	turns out that pretty much everything happens consecutively, with
	a reasonable amount of time just spent probing the SCSI busses.
	USB is pretty slow in enumerating their devices too, so I don't
	see a real world application that has this problem.  Do you have
	any proof of this?

You responded:
	I don't agree.  I've timed bootup with 12 fibrechannel disks
	with 4 partitions each with udev using the SDEF patches.  I've
	then timed bootup and added in the time required to add those 12
	fibrechannel disks (via a script) using /sbin/hotplug.  The
	script method (executing  /sbin/hotplug 12*4 times with the
	appropriate data hardcoded) takes rougly 1.25-1.75 seconds
	longer.  Since I'm using a chronograph, its not very accurate,
	but it is definately slower to enumerate with /sbin/hotplug
	using this methodlogy.  That is only 12 disks.  What about the
	case of 1000 disks?

	fork and exec are very expensive system calls, to be avoided at
	all costs...

To which I responded:
	Well, if you don't dynamically link a 500K file, perhaps it
	would be a lot faster to start up :)

	Anyway, who really cares?  This is _not_ a time critical thing.
	Who really cares that it takes 1 second longer to see the device
	node for the newly plugged in device?  And if you plug in 5000
	devices all at once, you better be willing to wait the extra
	minute or so for the system to calm down and make all of the
	devices available to userspace.

And again you came back with:
	System bootup time and time between failures are the two factors
	used to determine availability. Reducing bootup time and
	increasing time between failures both improve availability. Even
	1 second is considerable when 5 9s is 30seconds of downtime per
	year. 1 more second is a considerable change in availability
	when you run the equations.

I now respond:
Bootup time reduction would be a great thing to have.  And I agree for
situations where 1 second is a considerable amount of time, it is
important.  However, 99.99% of the people running Linux out there, do
not have those problems.  And even then, for those 00.01% of the people
who do, they do whatever they possibly can to keep from having to reboot
at all.  I still say the measurable ammount of time to plug in a new
disk and have it's device node created is not measurable, from using
/sbin/hotplug and udev, and using your character node.  Also, the
ultimate solution for these kinds of people is the in-kernel devfs, or
the current static /dev.  If they use either of them, it's guaranteed to
be faster then yours or mine implementation.

> 3) /sbin/hotplug events can occur out of order, eg: remove event occurs, 
> /sbin/hotplug sleeps waiting for something, insert event occurs and 
> completes immediately.  Then the remove event completes, after the 
> insert, resulting in out-of-order completion and a broken /dev.  I have 
> seen this several times with udev.

I responded:
	Yes this happens.  I have a fix for this for udev itself.  No
	kernel changes are needed.  I'll show it at OLS in July if you
	want to see it :)
	
You responded:
	There is a problem in udev that fork doesn't wait for the parent
	to exit (mknod) which is solved by using the mknod system call.
	But there is still another problem that /sbin/hotplug can
	execute out of order.  I'll be at OLS so I'll take a look at
	your solution then.

So we agree to talk about this at OLS, fine.

> 4) early device enumeration (character devices, etc) are missed because 
> /sbin/hotplug is not available during early device init.

I responded:
	Then use early initramfs to catch this.  I've done this and seen
	it work already.  If you don't want to do early init, walk the
	sysfs tree yourself from userspace, it works just as well, and
	we don't have to do any buffering in kernelspace at all.

You responded:
	Initramfs still misses early events.  That leaves walking sysfs.

	I have considered and rejected using a user space program to
	walk sysfs for this information.  There are several problems
	1) kobject device name is not present in sysfs (how do you know
	if its a character or block, then without some external mapping
	db, yuck)
	2) scan of sysfs is not atomic, resulting in potential lost
	events and lost device enumerations

I responded:
	You don't know this from hotplug either.  You have to figure it
	out from the kobject name either way.  Actually it's quite easy,
	only block devices show up in /sys/block, everything else is a
	character device.

	No, this is quite simple to fix:
		- set up /sbin/hotplug udev handler after init has
		  started.
		- start walking sysfs to "cold plug" devices.              
		- any new events that happen are caught by udev and
		  handled there, while you are walking the tree.
		- no events are lost.

You responded:
	Events could be handled in this situation twice, which is
	definately not what is desireable.

I now respond:
Doing a mknod() on a node that is already present doesn't harm anything.
And since you have to keep a database around of what devices are
present, and what you have called them, removing them after already
removing them again, is detectable.  So handing the same event twice
isn't a problem.

> To solve these problems, I've developed a driver and some minor 
> modifications to the lib/kobject.c to queue these events and allow a 
> user space program to read the events at its leisure.  The driver 
> supports poll/select for effecient use of the processor.
> 
> The feature is called the System Device Enumeration Event Queue.  I've 
> attached a tarball which includes udev-0.1 modified to use the SDEQ, a 
> kernel patch against linux 2.5.70 that implements the SDEQ, and a 
> test/library that tests the SDEQ functionality.

I responded:
	Ok, I looked at your code.  To put it kindly, it will never work
	properly.  See the long thread on lkml by Inaky after I
	announced udev.  He tried to create something like what you have
	done, but got a big better implementation (yours has a number of
	memory leaks, and permission problems...)

	See that thread for why doing this in the kernel is not the way
	to go.  Please don't waste your time on this anymore, it's a
	loosing battle...

You responded:
	It obviously works properly when using the udev application so I
	am at a loss as to how you can make a claim that "it will never
	work".  Please explain your comments about memory leaks. Data
	structures are allocated and then freed at appropriate times.
	Even in the case of a crash during a transaciton (get event,
	clera events), there are no leaks.  Please explain permission
	problems. Permissions are controlled through policy in the
	filesystem (/dev/sdeq) which fully controls access to the system
	device enumeration event queue.

	I did look at Inaky's code, and frankly it was too complicated
	to solve the simple problem that needed to be solved. We also
	have a full-blown event mechanism (for redundant system slot
	compact pci support), but feel its too heavy-weight to be of
	general purpose use to the kernel.  This particular
	implementation is lightweight and solves a specific need with
	real applications that can really use the functionality.
	
	I have read the thread and atleast 70% of the comments where "we
	should not use /sbin/hotplug, but instead events should be
	queued in the kernel". The thread raised all of the issues that
	are solved with this kernel patch. Several core kernel
	maintainers were the authors of the comments, so I'm not alone
	in this belief.

	Your obviously opposed to using character devices to queue
	kobject creation/deletion events for some reason which I don't
	understand.  /sbin/hotplug is an inferior solution to queueing
	events in the kernel.  Your not the maintainer of the code this
	feature is going into (which is the linux driver model). I'd
	really like to hear Pat's thoughts on this issue as he is the
	one that has to live with the changes. If you want to continue
	using /sbin/hotplug, with all of its numerous problems for your
	work, your more then welcome to do so. No one is forcing you to
	use sdeq, however, for those other vendors that may want to make
	persistent device naming solutions, this is a core feature that
	can not easily be solved by poorly thought out hacks.

I will respond now:

Ok, permission problems can be solved by relying on the permission of
the device node, you are correct.

As for the memory issues, if no one ever reads from the character node,
it will constantly fill up with events, right?  Shouldn't they be
eventually flushed out at some point in time?

Also for trying to remove events, why is userspace allowed to remove a
multiple of events at once?  I would think that a valid read would
remove that event, you can have two applications grab the same event,
which is not what I think you want to have happen.


And finally...

Yes, I know I'm not the maintainer of the code that this feature is
going into.  But my position is that this code is not needed in the main
kernel tree, and offer that opinion to the maintainer of this code.

I agree, most of the arguments in the previous udev thread talked about
out of order events, but I think I've gotten that solved now (I can wave
my hands about how it will be done, or I can show you working code at
OLS.  I think I'll wait until OLS, as code matters, wavy hands don't.)

So, because of this, I still think that everything you are trying to do
can be successfully done from userspace today (or use devfsd today, it
will give you the same info!)  And due to that, I do not think this code
is necessary to be in the kernel.

Thanks for reading this far, and my apologies if I got any of the above
quotes out of order or misspoken, I just wanted to cut to the chase, and
not have to go through 4 more rounds of email to make it to this point
in the conversation again.

greg k-h
