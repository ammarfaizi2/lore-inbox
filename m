Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWGMFpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWGMFpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 01:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWGMFpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 01:45:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751405AbWGMFpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 01:45:18 -0400
Date: Wed, 12 Jul 2006 22:44:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: greg@kroah.com, 76306.1226@compuserve.com, fork0@t-online.de,
       linux-kernel@vger.kernel.org, mchehab@infradead.org,
       shemminger@osdl.org, video4linux-list@redhat.com,
       v4l-dvb-maintainer@linuxtv.org
Subject: Re: oops in bttv
Message-Id: <20060712224453.5faeea4a.akpm@osdl.org>
In-Reply-To: <20060712222407.d737129c.rdunlap@xenotime.net>
References: <200607130047_MC3-1-C4D3-43D6@compuserve.com>
	<20060713050541.GA31257@kroah.com>
	<20060712222407.d737129c.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 22:24:07 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > > The class_dev is created like this, in video_register_device():
> > > 
> > >         memset(&vfd->class_dev, 0x00, sizeof(vfd->class_dev));
> > >         if (vfd->dev)
> > >                 vfd->class_dev.dev = vfd->dev;
> > >         vfd->class_dev.class       = &video_class;
> > >         vfd->class_dev.devt        = MKDEV(VIDEO_MAJOR, vfd->minor);
> > >         sprintf(vfd->class_dev.class_id, "%s%d", name_base, i - base);
> > >         class_device_register(&vfd->class_dev);
> > >         class_device_create_file(&vfd->class_dev,
> > >                                 &class_device_attr_name);
> > > 
> > > so it looks like class_device_register() is putting the 1 into the dentry?
> > > Culprit looks to be class_device_add() in that case.
> > 
> > Perhaps we should check the return value of class_device_register() to
> > verify that nothing bad happened there?  A dentry of 1 is very odd.
> 
> Yes.  We are in the process of adding such checks.
> Join the fun.

Chuck got about as far through this as I did.  Yes, I'm suspecting an
earlier uncaught error of some form.  The videodev changes since 2.6.17 are
small and look to be unrelated.  I'd be suspecting preexisting videodev
bugs which have been exposed by sysfs/driver-model changes.  But it's very
hard to tell.

Going through and adding 1000 missing check-error-then-recover instances is
the ideal approach, but I suspect that leaving callers as-is and blurting a
message from the driver core when some of these things fail might get us
what we need.  But right now we have neither, and we see the result.
