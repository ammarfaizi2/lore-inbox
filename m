Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271117AbTGPUK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271102AbTGPUK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:10:26 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:22931 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S271117AbTGPUKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:10:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 16 Jul 2003 22:20:18 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030716202018.GC26510@bytesex.org>
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com> <20030716084448.GC27600@bytesex.org> <20030716161924.GA7406@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716161924.GA7406@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like the video drivers include a "struct video_device"
> structure within their own structures, right?

Yes, it is allocated/freed by the driver, most seem to simply include
one ore more "struct video_device" somewhere in the per-device struct.

> That will have to be changed to a pointer to that structure in order
> for the lifetime rules to work properly.

Hmm.  I doubt it will be that simple.  struct video_device has a priv
field which can be used by the drivers to hook in some driver-private
data.  That may point into nowhere if struct video_device has a longer
live time due to some kobject still being referenced.  Wouldn't be a
issue for videodev.o itself, but might become a problem for drivers
which want add private properties and rely on video_device->priv
for finding the per-device data.  Problem isn't solved but justed
moved to the next corner ...

Maybe let video_unregister sleep on a semaphore which gets woken up
by the release function?  That should make sure the sysfs objects are
not referenced any more if video_unregister() returns.  I use a similar
method in some places when shutting down kernel threads, to make sure it
is really stopped before rmmod frees the memory.

> Look at the dev file in /sys/class/tty/*, or in /sys/block/hd* or in
> /sys/class/usb/*, and so on...

I've found the code in drivers/block/genhd.c in the meantime :)

  Gerd

-- 
sigfault
