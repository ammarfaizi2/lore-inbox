Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVJRHfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVJRHfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVJRHfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:35:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:62651 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751102AbVJRHfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:35:38 -0400
Date: Tue, 18 Oct 2005 00:35:03 -0700
From: Greg KH <gregkh@suse.de>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: dtor_core@ameritech.net, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Message-ID: <20051018073503.GA12385@suse.de>
References: <20051013020844.GA31732@kroah.com> <20051013105826.GA11155@vrfy.org> <d120d5000510131435m7b27fe59l917ac3e11b2458c8@mail.gmail.com> <20051014084554.GA19445@vrfy.org> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org> <20051017214430.GA5193@suse.de> <20051018060435.GA10622@suse.de> <20051018070515.GA12042@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018070515.GA12042@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 12:05:15AM -0700, Greg KH wrote:
> On Mon, Oct 17, 2005 at 11:04:35PM -0700, Greg KH wrote:
> > On Mon, Oct 17, 2005 at 02:44:30PM -0700, Greg KH wrote:
> > > But, if you think we can't break userspace by adding nested class
> > > devices just yet, I agree, and can probably just put a symlink in
> > > /sys/class/input to the nested devices, which will make everything "just
> > > work".  I'll try that out later tonight and let you all know how it
> > > goes.
> > 
> > Below is a patch that does this for the event portion of input.  Good
> > news is that the symlink shows up just fine in sysfs.  Bad news is that
> > even with your previously posted patch, udev dies a horrible death.
> > 
> > And udev dies today with the nested stuff too, so that's not good
> > either.
> 
> Nevermind, that was due to the kernel oops, not udev.
> 
> Kay, your original udev patch works just fine.  What I don't see is why
> the existing udev release doesn't also work, now that I have the
> symlinks set up.  I'll try to figure that one out too...

Bleah, here's a one character patch to the current udev that makes
udevstart work properly with my symlink patch.

diff --git a/udevstart.c b/udevstart.c
index ce96f38..ce72b82 100644
--- a/udevstart.c
+++ b/udevstart.c
@@ -131,7 +131,7 @@ static int add_device(const char *devpat
 		setenv("UDEV_RUN", udev_run_str, 1);
 	dbg("add '%s'", devpath);
 
-	snprintf(path, sizeof(path), "%s%s", sysfs_path, devpath);
+	snprintf(path, sizeof(path), "%s%s/", sysfs_path, devpath);
 	path[sizeof(path)-1] = '\0';
 	class_dev = sysfs_open_class_device_path(path);
 	if (class_dev == NULL) {

So, any way we do it, users are going to have to upgrade udev to get
things to work properly.

But I guess we should use the symlink patch in the kernel too, just to
keep any other tools that don't have this kind of bug in them working
properly...

Opinions?

thanks,

greg k-h
