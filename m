Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269709AbTGOVPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbTGOVPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:15:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:41695 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269732AbTGOVNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:13:42 -0400
Date: Tue, 15 Jul 2003 14:27:14 -0700
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030715212714.GB5458@kroah.com>
References: <20030715143119.GB14133@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715143119.GB14133@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 04:31:19PM +0200, Gerd Knorr wrote:
>   Hi,
> 
> This patch moves the video4linux subsystem from procfs to sysfs.
> Changes:
> 
>   * procfs support is completely gone, i.e. /proc/video doesn't
>     exist any more.

Yeah!

>   * there is a new device class instead: /sys/class/video4linux.
>     All video4linux devices which used to be listed in
>     /proc/video/dev are moved to that place.

Nice.

> Changes required/recommended in video4linux drivers:
> 
>   * some usb webcam drivers (usbvideo.ko, stv680.ko, se401.ko 
>     and ov511.ko) use the video_proc_entry() to add additional
>     procfs files.  These drivers must be converted to sysfs too
>     because video_proc_entry() doesn't exist any more.

I'd be glad to do this work once your change makes it into the core.  Is
there any need for these drivers to export anything through sysfs now
instead of /proc?  From what I remember, it only looked like debugging
and other general info stuff.

>   * struct video_device has a new "dev" field pointing to a struct
>     device.  Drivers should fill that one if possible.  It isn't
>     required through.  It will give you fancy device + driver symlinks
>     in /sys/class/video4linux/<name>.
>     The patch below includes the changes for bttv.

So dev should point to the dev of the video class device?

> Comments?

You _have_ to set up a release function for your class device.  You
can't just kfree it like I think you are doing, otherwise any users of
the sysfs files will oops the kernel after the video class device is
gone.  I can point you to some examples of how to do this if you like.

Other than that, how about exporting the dev_t value for the video
device?  Then you automatically get udev support, and I don't have to go
add it to this code later :)

thanks,

greg k-h
