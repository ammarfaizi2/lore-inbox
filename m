Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289375AbSBJJKa>; Sun, 10 Feb 2002 04:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289369AbSBJJKX>; Sun, 10 Feb 2002 04:10:23 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:8973 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S289376AbSBJJKK>; Sun, 10 Feb 2002 04:10:10 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Sun, 10 Feb 2002 10:11:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Mark McClelland <mark@alpha.dyndns.org>
Cc: video4linux-list@redhat.com, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [V4L] [PATCH/RFC] videodev.[ch] redesign
Message-ID: <20020210101130.A28225@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org> <3C65EFF4.2000906@alpha.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C65EFF4.2000906@alpha.dyndns.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Excellent work. I have no complaints, just a few questions:
> 
> 1. Would it be better to memset the temp buffer in video_generic_ioctl() 
> rather than in the driver? I've seen so many drivers forget to do this, 
> and it's a potential (albeit very small) security hole.

The wrapper fills the buffer using copy_from_user() -- even for _IOR
ioctls because some are labeled wrong -- and the driver needs that data.
I can't zero the buffer ...

> 2. In skeleton_open(), couldn't the device_data lookup code be replaced 
> with:
> 
>    struct video_device *vdev = video_devdata(file);
>    struct device_data *dev = vdev->priv;

Good point.  Yes, that should work.

> 3. In skeleton_initdev(), shouldn't...
> 
>    dev->vdev = skeleton_template;
> 
> ...be...
> 
>    memcpy(&dev->vdev, &skeleton_template, sizeof(skeleton_template);

No.  It does the same.

> 4. Is it safe to keep even 128 bytes on the stack in 
> video_generic_ioctl()? Consider that devices might spend a relatively 
> long time blocking on VIDIOCSYNC. With 32 devices in use at once, you'd 
> be coming dangerously close to a stack overflow.

I don't see a overflow can easily happen here.  There is one kernel
strack _per process_.  Calling schedule() will also switch the stack.

> IMHO it would be better 
> to only allocate as much as MCAPTURE and SYNC need, and fall back on 
> kmalloc for the less time-critical ones (if necessary).

struct v4l2_buffer should fit onto the stack too.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
