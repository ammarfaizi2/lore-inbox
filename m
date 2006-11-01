Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992798AbWKAUOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992798AbWKAUOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992801AbWKAUOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:14:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:39649 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992798AbWKAUN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:13:59 -0500
Date: Wed, 1 Nov 2006 12:13:06 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Galbraith <efault@gmx.de>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061101201306.GA1423@suse.de>
References: <20061031065912.GA13465@suse.de> <1162278594.6416.4.camel@Homer.simpson.net> <20061031072241.GB7306@suse.de> <1162312126.5918.12.camel@Homer.simpson.net> <1162318477.6016.3.camel@Homer.simpson.net> <1162356198.6105.18.camel@Homer.simpson.net> <20061031212508.1b116655.akpm@osdl.org> <1162361529.5899.1.camel@Homer.simpson.net> <1162373184.6126.8.camel@Homer.simpson.net> <20061101104853.4e5e6c64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101104853.4e5e6c64.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 10:48:53AM -0800, Andrew Morton wrote:
> On Wed, 01 Nov 2006 10:26:24 +0100
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Wed, 2006-11-01 at 07:12 +0100, Mike Galbraith wrote:
> > > On Tue, 2006-10-31 at 21:25 -0800, Andrew Morton wrote:
> > > > On Wed, 01 Nov 2006 05:43:18 +0100
> > > > Mike Galbraith <efault@gmx.de> wrote:
> > > > 
> > > > > On Tue, 2006-10-31 at 19:14 +0100, Mike Galbraith wrote:
> > > > > 
> > > > > > Seems it's driver-core-fixes-sysfs_create_link-retval-checks-in.patch
> > > > > > 
> > > > > > Tomorrow, I'll revert that alone from 2.6.19-rc3-mm1 to confirm...
> > > > > 
> > > > > Confirmed.  Boots fine with that patch reverted.
> > > > 
> > > > Could you test with something like this applied?
> > > 
> > > No output.  I had already enabled debugging, but got nada there either.
> > > Bugger.  <scritch scritch>
> > 
> > Duh!  (what a maroon)  I booted the wrong kernel due to a typo.
> > 
> > I enabled some other debug options (poke/hope), and it now boots past
> > the BUG at arch/i386/mm/pageattr.c:165 point, through the sound NULL
> > pointer dereference, and on to the eventual complete hang as NFS is
> > being initialized.  The log shows 326 failures at lines 385 and 589.
> 
> You mean 326 separate failures?  erp.
> 
> So it's failing here:
> 
> static int device_add_class_symlinks(struct device *dev)
> {
> 	int error;
> 
> 	if (!dev->class)
> 		return 0;
> 	error = sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
> 				  "subsystem");
> 	if (error) {
> 		DB();
> 		goto out;
> 	}
> 	error = sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
> 				  dev->bus_id);
> 	if (error) {
> -->>		DB();
> 		goto out_subsys;
> 	}
> 
> 
> Now, prior to driver-core-fixes-sysfs_create_link-retval-checks-in.patch we
> were simply ignoring the return value of sysfs_create_link().  Now we're
> not ignoring it and stuff is failing.
> 
> I'm suspecting that the second call to sysfs_create_link() in device_add():
> 
> 
> 	if (dev->class) {
> 		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
> 				  "subsystem");
> -->>		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
> 				  dev->bus_id);
> 
> is simply always failing, only we never knew about it.
> 
> It would be useful if you could tell us what `error' is in there.  Usually
> -EEXIST.
> 
> Greg, what is that call actually linking from and to?

That is creating the symlink for the class device to show up properly in
/sys/class.

For example, the /sys/class/net/eth0 entry will be a symlink pointing to
the proper device.

Oh, DOH!  That will fail if CONFIG_SYSFS_DEPRECATED is enabled because
that symlink can not be created because the device itself is already
called that and has been registered with sysfs in that location.

That might fix my other problem I am now seeing which happens when a
device is removed from the system at startup with that config option
enabled.  Let me go rework this and see if it solves the issue...

thanks for the big hint, I was tracking it down through a different path
and hadn't gotten here yet.

greg k-h
