Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbTIVWhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTIVWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:37:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53666 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261668AbTIVWhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:37:40 -0400
Date: Mon, 22 Sep 2003 23:37:39 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
Message-ID: <20030922223739.GI7665@parcelfarce.linux.theplanet.co.uk>
References: <20030922210021.GH7665@parcelfarce.linux.theplanet.co.uk> <20030922211511.17009.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922211511.17009.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 03:15:11PM -0600, Jonathan Corbet wrote:
 
> The struct cdev which I, as a driver author, can embed within my own
> structure has a kobject in it.  If it's an embedded cdev, its ktype pointer
> will be aimed at ktype_cdev_default, which sets up cdev_default_release()
> as its release function.
> 
> If I understand things correctly, as long as references to the embedded
> struct cdev remain, I cannot free the driver-specific structure in which
> the struct cdev is embedded.  So, somehow, I need to know when that struct
> cdev's release() method is called.  I could do that by changing its ktype
> field to my own special type, and remembering to call cdev_purge() in my
> own release function.  Somehow, however, that doesn't feel like the right
> approach.  It seems to me like we need a release() method in struct cdev
> that is called from the struct cdev's own release() method - at least, in
> the non-dynamic case.  No?  What am I missing here?

Mostly the fact that current cdev_init() is a temporary measure.  Note that
the only embedded cdev use is in tty_driver and it has tons of problems in
refcounting/lifetime rules (had them since way back, actually.

FWIW, I hope to get the following (and pretty soon, since dev_t mess appears
to be mostly over):
	* real classes (e.g. tty drivers) get their own subtrees in sysfs,
complete with real attributes, etc.  They also get ktypes of their own, with 
->release() doing all their freeing, yadda, yadda.  One of the things that
should be done is cdev_purge().
	* that transition is done on subsystem-by-subsystem basis, with
usual work on lifetime rules.  Again, it's a non-trivial work and subsystems
that are not up to that are free to keep doing exactly what they did in 2.4.
	* Freeing stuff in the converted subsystems *must* be done from
->release().  We can empty the object (i.e. mark it dead and junk most of
its fields) when we unregister the sucker, but we can't free it until it's
released.

One more thing: our support of device removal is atrocious.  That's probably
the most important lesson I've learnt from Linux - there are objects that
should stay alive as long as they are wanted, there are objects that should
stay alive until they want to die and there should be a clear boundary between
them - preferably designed to be there from the very beginning, since moving
it around afterwards is a royal PITA.  Filesystem objects tend to belong to
the first category, network ones to the second.  Hardware, sad as it is,
obviously belongs to the second category - after all, if it decides to let
the magic smoke out, no amount of "but I still need it" will help you.
Somewhere on the path from opened file to the piece of hardware there should
be a boundary.

A *lot* of grotty mess had come out of the fact that we never had a clear
boundary there.  Note that so-called "module removal" issues are of the same
origin - modules themselves belong to the first class (you can keep them
loaded as long as they are used; no problems with that) and that masks the
real problem.  Namely, device removal appears to be tied to the removal of
1st category object (== rmmod) and that gives an illusion that there's a
single place where we could deal with all these issues.  That's what Rusty
is trying to do, BTW - put a lot of smarts into rmmod in hope to deal with
that mess.

Unfortunately, it doesn't work.  Not only because there is hotplug, USB,
SCSI, etc. to deal with, but because there are object classes that contain
both hardware (which we could pretend to be non-removable) and non-hardware.
Trivial example: network interfaces.  Whatever you do, you *must* deal with
ppp link going up and down.  It's equivalent to inserting/removing NIC and
there is no hope in hell to deal with that anywhere near rmmod.

IOW, at some point we will have to admit that "device disappears" is a normal
event that should be handled on generic basis - not by ad-hackery in individual
driver.  If anything, rmmod should be "atomically check that no exported
objects are in use and initiate removal on all of them" sort of event.

Now, for block devices there is some breathing space - we have block_device,
gendisk and queue to play with; somewhere among those a boundary can be
set and it's not too hard to do.  It's messy (and in part it's my fault -
basically, back in 2.3 I'd considered block_device to be permanently
associated with device number and not with the driver objects; that turned
out to be a bad mistake), but at least here I have a hope to get the things
right before 2.6.0 with minimal PITA.

For character devices we have *nothing*.  It goes from file to device number
and there drivers do whatever they do.  Removal issues are there - in spades.
TTY hangup, USB device removal, yadda, yadda.  Some subsystems try to handle
that with ad-hackery, faith and a bit of duct-tape.  Some do not even pretend
to (look at drivers/input and try to figure out what protects the lists of
objects; the answer's "nothing").

A very big part of motivation for embedded cdevs was to get the real driver
objects into the game in hope to localize the mess.  It *definitely* won't
be finished for all subsystems by the time of 2.6.0, so we have no hope in
hell to get it rigth until 2.7.  There will be need of follow-up work on
device removal issues in that area.  And it won't really happen until the
next branch.  What we can do is to get the things into more or less sane
shape without making them worse.  Full solution will have to wait.  And
I suspect that we'll have to go through interface changes before it's over.

The bottom line:
	* embedded cdevs are mostly subsystem business right now and this
work just begins
	* eventually it will filter down to drivers
	* for now any driver can regsiter regions as it used to - the way
it works involves cdevs, but that's 100% transparent from the driver POV.
	* we'll certainly need to change cdev-related interfaces several
times before they settle down; hopefully we'll have a clear picture by the
2.6.0 time.
	* in 2.7 there will be a lot of fun work related to hotplug/device
removal/insertion/invalidation; hopefully by that time we'll have to deal
only with generic subsystem code and not with individual drivers.
