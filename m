Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTIXWbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTIXWbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:31:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:19129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261625AbTIXWbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:31:07 -0400
Date: Wed, 24 Sep 2003 15:22:06 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: Attributes in /sys/cdev
Message-ID: <20030924222206.GC12016@kroah.com>
References: <20030922210021.GH7665@parcelfarce.linux.theplanet.co.uk> <20030922211511.17009.qmail@lwn.net> <20030922223739.GI7665@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922223739.GI7665@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 11:37:39PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Sep 22, 2003 at 03:15:11PM -0600, Jonathan Corbet wrote:
>  
> > The struct cdev which I, as a driver author, can embed within my own
> > structure has a kobject in it.  If it's an embedded cdev, its ktype pointer
> > will be aimed at ktype_cdev_default, which sets up cdev_default_release()
> > as its release function.
> > 
> > If I understand things correctly, as long as references to the embedded
> > struct cdev remain, I cannot free the driver-specific structure in which
> > the struct cdev is embedded.  So, somehow, I need to know when that struct
> > cdev's release() method is called.  I could do that by changing its ktype
> > field to my own special type, and remembering to call cdev_purge() in my
> > own release function.  Somehow, however, that doesn't feel like the right
> > approach.  It seems to me like we need a release() method in struct cdev
> > that is called from the struct cdev's own release() method - at least, in
> > the non-dynamic case.  No?  What am I missing here?
> 
> Mostly the fact that current cdev_init() is a temporary measure.  Note that
> the only embedded cdev use is in tty_driver and it has tons of problems in
> refcounting/lifetime rules (had them since way back, actually.
> 
> FWIW, I hope to get the following (and pretty soon, since dev_t mess appears
> to be mostly over):
> 	* real classes (e.g. tty drivers) get their own subtrees in sysfs,
> complete with real attributes, etc.  They also get ktypes of their own, with 
> ->release() doing all their freeing, yadda, yadda.  One of the things that
> should be done is cdev_purge().

Most classes do have their own subtree in sysfs.  That's what struct
class is for.  Now I do have a bunch of patches sitting in my tree to
fix up those classes that do not currently have this, but I've been
waiting for things to die down a bit before submitting them.  I can dig
them out for anyone to play with if you like.

The big issue is that char devices do not all work alike.  Infact there
are almost no "raw" char devices that do not fit into some kind of class
today.  So I think that if we use cdev in the core char layer, that's
great, and needed.  But to move that functionality up the levels, into
the different classes probably isn't needed, and would just get messy
quickly (sound devices don't have much in common with tty devices.)

Yes, they both need a reference counting object, hence the struct class
usage.  Now if you think we can merge struct class with cdev, that might
be interesting...

> One more thing: our support of device removal is atrocious.

We have gotten much better at this in 2.6.  USB devices should be sane
now.  PCI devices, well, it's gotten better...  Block devices are a lot
better thanks to the work you've done already (I think the scsi people
have some minor issues left here...)

> IOW, at some point we will have to admit that "device disappears" is a normal
> event that should be handled on generic basis - not by ad-hackery in individual
> driver.

Agreed.

> 	* we'll certainly need to change cdev-related interfaces several
> times before they settle down; hopefully we'll have a clear picture by the
> 2.6.0 time.

Wait, isn't it 2.6.0 time any day now?  :)

thanks,

greg k-h
