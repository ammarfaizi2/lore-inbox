Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271487AbTGQO47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271488AbTGQO47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:56:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:19602 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271487AbTGQO44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:56:56 -0400
Date: Thu, 17 Jul 2003 07:57:50 -0700
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030717145749.GA5067@kroah.com>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <20030716084448.GC27600@bytesex.org> <20030716161924.GA7406@kroah.com> <20030716202018.GC26510@bytesex.org> <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717120121.GA15061@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 02:01:21PM +0200, Gerd Knorr wrote:
> On Wed, Jul 16, 2003 at 02:08:00PM -0700, Greg KH wrote:
> > On Wed, Jul 16, 2003 at 10:20:18PM +0200, Gerd Knorr wrote:
> > > Yes, it is allocated/freed by the driver, most seem to simply include
> > > one ore more "struct video_device" somewhere in the per-device struct.
> > 
> > So you CAN NOT just blindly put a kobject (meaning a class_device)
> > structure inside of there.
> 
> Why not ...
> 
> > > which want add private properties and rely on video_device->priv
> > > for finding the per-device data.  Problem isn't solved but justed
> > > moved to the next corner ...
> > 
> > No, just have the video drivers have a release callback to do the
> > freeing.
> 
> ... if a ->release() callback is required anyway to fix it?  I see two
> ways to handle it:
> 
>   (1) mandatory ->release() callback, drivers must make sure the stuff
>       is not freed before the callback was called.  In that case the
>       class_device can be left embedded inside the drivers provate
>       structs.

That sounds fine, and is the same as what I did for usb host devices.

>   (2) optional ->release() callback (for those drivers which want add
>       private attributes), "struct video_device" must be moved out of
>       the drivers private structs then and released in a new function
>       (which also calls the drivers ->release callback if present).
>       Should probably also be allocated by videodev.c for symmetry.

That's "prettier", but probably requires a lot more work in every v4l
driver, right?

> Both approaches require touching all v4l drivers in non-trivial ways
> through, not sure whenever it is a good idea to do that now.  Any chance
> to get that in before 2.6.0?  Or should I better make that change in
> 2.7.x and live with /proc for the time being?

I'd say you should try for it now.  It's required if you want support
for things like udev in 2.6, which is what a lot of people seem to
want...

I know there are still a few other subsystems that need this kind of
change in 2.6, so you are not alone (input, misc, parallel port, sound,
etc.)

I'd be glad to help you out with this if you want.

thanks,

greg k-h
