Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271172AbTGQQJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTGQQJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:09:49 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:35715 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271172AbTGQQJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:09:47 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 17 Jul 2003 18:37:15 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030717163715.GA19258@bytesex.org>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <20030716084448.GC27600@bytesex.org> <20030716161924.GA7406@kroah.com> <20030716202018.GC26510@bytesex.org> <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org> <20030717145749.GA5067@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717145749.GA5067@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > ... if a ->release() callback is required anyway to fix it?  I see two
> > ways to handle it:
> > 
> >   (1) mandatory ->release() callback, drivers must make sure the stuff
> >       is not freed before the callback was called.  In that case the
> >       class_device can be left embedded inside the drivers provate
> >       structs.
> 
> That sounds fine, and is the same as what I did for usb host devices.

Ok.

> >   (2) optional ->release() callback (for those drivers which want add
> >       private attributes), "struct video_device" must be moved out of
> >       the drivers private structs then and released in a new function
> >       (which also calls the drivers ->release callback if present).
> >       Should probably also be allocated by videodev.c for symmetry.
> 
> That's "prettier", but probably requires a lot more work in every v4l
> driver, right?

Not sure which of them is actually more work.

Version (1) can be done without breaking the build, with a hack along 
the lines "if (no release callback) printk(KERN_WARN please fix your
driver)", so the drivers can be fixed step-by-step afterwards.

Fixing the drivers might be non-trivial through.  Some drivers are
hot-pluggable (usb cams), some drivers register more than one v4l device
(bttv wants up to three).  Those drivers can't just call kfree() in the
->release callback because there might be other references, some open
file handle for a unplugged usb cam, another not-yet unregistered
v4l device, whatever.  Probably they must implement some reference
counting scheme to get that right.  The very simple ones (in
drivers/media/radio for example) likely just need the kfree() moved
from the ->remove function into the new ->release() callback.

Version (2) needs every v4l driver touched to make it compile again.
Not sure how hard it is to fixup them.  I'd guess it is pretty straigt
forward to do the conversion, it's just alot of work.  I also could do
a number of other cleanups along the way.  Maybe I trap into some hidden
pitfalls through, havn't looked at all the drivers in detail yet.

  Gerd

-- 
sigfault
