Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271111AbTGPUyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271112AbTGPUyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:54:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:48350 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271111AbTGPUyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:54:01 -0400
Date: Wed, 16 Jul 2003 14:08:00 -0700
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030716210800.GE2279@kroah.com>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <20030716084448.GC27600@bytesex.org> <20030716161924.GA7406@kroah.com> <20030716202018.GC26510@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716202018.GC26510@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:20:18PM +0200, Gerd Knorr wrote:
> > It looks like the video drivers include a "struct video_device"
> > structure within their own structures, right?
> 
> Yes, it is allocated/freed by the driver, most seem to simply include
> one ore more "struct video_device" somewhere in the per-device struct.

So you CAN NOT just blindly put a kobject (meaning a class_device)
structure inside of there.

> > That will have to be changed to a pointer to that structure in order
> > for the lifetime rules to work properly.
> 
> Hmm.  I doubt it will be that simple.  struct video_device has a priv
> field which can be used by the drivers to hook in some driver-private
> data.  That may point into nowhere if struct video_device has a longer
> live time due to some kobject still being referenced.  Wouldn't be a
> issue for videodev.o itself, but might become a problem for drivers
> which want add private properties and rely on video_device->priv
> for finding the per-device data.  Problem isn't solved but justed
> moved to the next corner ...

No, just have the video drivers have a release callback to do the
freeing.  It's pretty simple, look at usb_host_release() in
drivers/usb/core/hcd.c.  That's exactly what that is for.  Hm, I
shouldn't have to check for bus->release() there, as release is now
required...

> Maybe let video_unregister sleep on a semaphore which gets woken up
> by the release function?  That should make sure the sysfs objects are
> not referenced any more if video_unregister() returns.  I use a similar
> method in some places when shutting down kernel threads, to make sure it
> is really stopped before rmmod frees the memory.

Ick, no.  Try doing what I did for usb hosts, it's much simpler.

> > Look at the dev file in /sys/class/tty/*, or in /sys/block/hd* or in
> > /sys/class/usb/*, and so on...
> 
> I've found the code in drivers/block/genhd.c in the meantime :)

genhd.c uses "raw" kobjects.  It might be easier to look at a
class_device example like the above mentioned usb_host one.

If you have any other questions/problems, feel free to ask.

thanks,

greg k-h
