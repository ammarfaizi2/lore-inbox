Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270447AbTHGRA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270453AbTHGRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:00:26 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:33928 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S270447AbTHGRAT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:00:19 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 7 Aug 2003 19:02:11 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>
Subject: Re: [patch] v4l: sysfs'ify videodev
Message-ID: <20030807170211.GA3620@bytesex.org>
References: <20030807154342.GA818@bytesex.org> <20030807165519.A32452@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807165519.A32452@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 04:55:19PM +0100, Russell King wrote:
> On Thu, Aug 07, 2003 at 05:43:42PM +0200, Gerd Knorr wrote:
> > +static void video_release(struct class_device *cd)
> > +{
> > +	struct video_device *vfd = container_of(cd, struct video_device, class_dev);
> >  
> > -static struct proc_dir_entry *video_dev_proc_entry = NULL;
> > -struct proc_dir_entry *video_proc_entry = NULL;
> > -EXPORT_SYMBOL(video_proc_entry);
> > -LIST_HEAD(videodev_proc_list);
> > +#if 1 /* needed until all drivers are fixed */
> > +	if (!vfd->release)
> > +		return;
> > +#endif
> > +	vfd->release(vfd);
> > +}
> 
> Ok, so you're allowing the release to happen elsewhere.  How are you
> ensuring that the code which vfd->release points to hasn't been
> unloaded before the video device has been released,

Which exact corner case you are refering to?  video_release() being
called _after_ video_unregister_device() returns due to a sysfs file
being busy?  Doesn't sysfs refcounting take care of that?  If not
module_{get|put}(vfd->fops->owner) at sensible places should fix that.
get in video_unregister_device(), put in video_release()?

> or, even, how
> are you preventing the module containing the above code being
> removed before all video devices have been released?

videodev.ko simply can't be unloaded while v4l drivers are loaded
due to symbol references.

  Gerd

-- 
sigfault
