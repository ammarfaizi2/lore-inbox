Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270931AbTGPQEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270932AbTGPQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:04:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:44722 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270931AbTGPQEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:04:43 -0400
Date: Wed, 16 Jul 2003 09:19:24 -0700
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030716161924.GA7406@kroah.com>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <20030716084448.GC27600@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716084448.GC27600@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:44:48AM +0200, Gerd Knorr wrote:
> > > Comments?
> > 
> > You _have_ to set up a release function for your class device.  You
> > can't just kfree it like I think you are doing, otherwise any users of
> > the sysfs files will oops the kernel after the video class device is
> > gone.
> 
> class_device_unregister() is called from video_unregister_device() which
> looks fine to me.  Or do you talk about something else?

Heh, yes, that is correct.  But then what do you do with the object that
had the class_device in it after class_device_unregister() returns?  I
don't see you freeing the device directly, which is good, but who does?

You _have_ to let the structure that the kobject is in free itself in a
release() function, you can't guess at what the kobject reference count
is at any time and just assume you can throw it away at that moment.

LWN did an article about how to do this properly at:
	http://lwn.net/Articles/36850/

But for some code that does this in a simple manner, look at
drivers/char/tty_io.c, the release_tty_dev() function.  It's set up in
the tty_class to handle destroying the structure when the last reference
to the tty_dev structure goes away.  Look at the
tty_remove_class_device() to see that the structure isn't kfreed on it's
own.

It looks like the video drivers include a "struct video_device"
structure within their own structures, right?  That will have to be
changed to a pointer to that structure in order for the lifetime rules
to work properly.  I know Hanna is fighting this same battle with the
input layer right now...

Does this help out?

As an example of why you _have_ to do this, consider a user who opens a
sysfs file of a video device, and then removes the video device from the
system.  Then they do a read on the sysfs file.  Oops...

> > Other than that, how about exporting the dev_t value for the video
> > device?  Then you automatically get udev support, and I don't have to go
> > add it to this code later :)
> 
> Do you have a pointer to sample code for that?

Look at the dev file in /sys/class/tty/*, or in /sys/block/hd* or in
/sys/class/usb/*, and so on...

I need to make a general function to support this to make it easier for
everyone to export a dev_t to userspace, but until then, if you want to
look at the show_dev() function in drivers/usb/core/file.c it shows what
you need to do.

thanks,

greg k-h
