Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262214AbVCVAkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262214AbVCVAkj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVCVAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:38:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:11483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262220AbVCVAiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:38:18 -0500
Date: Mon, 21 Mar 2005 16:38:08 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050322003807.GA10180@kroah.com>
References: <9e47339105030909031486744f@mail.gmail.com> <20050321154131.30616ed0.akpm@osdl.org> <9e473391050321155735fc506d@mail.gmail.com> <20050321161925.76c37a7f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321161925.76c37a7f.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:19:25PM -0800, Andrew Morton wrote:
> 
> (Adds lots of cc's.  I trust that's OK).
> 
> Jon Smirl <jonsmirl@gmail.com> wrote:
> >
> > No, I think Jens wants all of the distributions to fix it. I have
> > filed a bug with Fedora on it.
> > 
> > Something changed in the timing for loading drivers during boot. You
> > used to be able to do:
> > modprobe ata_piix
> > mount /dev/sda1

You can't do that on any udev based system reliably.  That has _never_
been true.  You might just have been getting lucky in the past.

> > Now you have to do this:
> > modprobe ata_piix
> > sleep 1
> > mount /dev/sda1

That's still racy.  Rely on the /etc/dev.d/ notifier to be able to tell
you when you can mount your device, that is what it is there for.

This is a udev issue, not a kernel issue, there's nothing we can do in
the kernel about it (well, except for the obvious thing of giving udev
lots of hints and making it easier for it to work properly and faster,
which we have been doing over the past months.)

> > I suspect the problem is that udev doesn't get a chance to run anymore. 
> > The sleep 1 allows it to run and it creates /dev/sda1.
> > Build ata_piix in and the problem goes away too.
> > 
> > Jens is right that this is a user space issue, but how many people are
> > going to find this out the hard way when their root drives stop
> > mounting. Since no one is complaining I have to assume that most
> > kernel developers have their root device drivers built into the
> > kernel. I was loading mine as a module since for a long time Redhat
> > was not shipping kernels with SATA built in.
> 
> I don't agree that this is a userspace issue.  It's just not sane for a
> driver to be in an unusable state for an arbitrary length of time after
> modprobe returns.

It is a userspace issue.  If you have a static /dev there are no
problems, right?  If you use udev, you need to wait for the device node
to show up, it will not be there right after modprobe returns.

thanks,

greg k-h
