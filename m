Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992546AbWKASu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992546AbWKASu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 13:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992549AbWKASu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 13:50:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992546AbWKASu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 13:50:26 -0500
Date: Wed, 1 Nov 2006 10:48:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Greg KH <gregkh@suse.de>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-Id: <20061101104853.4e5e6c64.akpm@osdl.org>
In-Reply-To: <1162373184.6126.8.camel@Homer.simpson.net>
References: <45461977.3020201@shadowen.org>
	<45461E74.1040408@google.com>
	<20061030084722.ea834a08.akpm@osdl.org>
	<454631C1.5010003@google.com>
	<45463481.80601@shadowen.org>
	<20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	<1162276206.5959.9.camel@Homer.simpson.net>
	<4546EF3B.1090503@google.com>
	<20061031065912.GA13465@suse.de>
	<1162278594.6416.4.camel@Homer.simpson.net>
	<20061031072241.GB7306@suse.de>
	<1162312126.5918.12.camel@Homer.simpson.net>
	<1162318477.6016.3.camel@Homer.simpson.net>
	<1162356198.6105.18.camel@Homer.simpson.net>
	<20061031212508.1b116655.akpm@osdl.org>
	<1162361529.5899.1.camel@Homer.simpson.net>
	<1162373184.6126.8.camel@Homer.simpson.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 10:26:24 +0100
Mike Galbraith <efault@gmx.de> wrote:

> On Wed, 2006-11-01 at 07:12 +0100, Mike Galbraith wrote:
> > On Tue, 2006-10-31 at 21:25 -0800, Andrew Morton wrote:
> > > On Wed, 01 Nov 2006 05:43:18 +0100
> > > Mike Galbraith <efault@gmx.de> wrote:
> > > 
> > > > On Tue, 2006-10-31 at 19:14 +0100, Mike Galbraith wrote:
> > > > 
> > > > > Seems it's driver-core-fixes-sysfs_create_link-retval-checks-in.patch
> > > > > 
> > > > > Tomorrow, I'll revert that alone from 2.6.19-rc3-mm1 to confirm...
> > > > 
> > > > Confirmed.  Boots fine with that patch reverted.
> > > 
> > > Could you test with something like this applied?
> > 
> > No output.  I had already enabled debugging, but got nada there either.
> > Bugger.  <scritch scritch>
> 
> Duh!  (what a maroon)  I booted the wrong kernel due to a typo.
> 
> I enabled some other debug options (poke/hope), and it now boots past
> the BUG at arch/i386/mm/pageattr.c:165 point, through the sound NULL
> pointer dereference, and on to the eventual complete hang as NFS is
> being initialized.  The log shows 326 failures at lines 385 and 589.

You mean 326 separate failures?  erp.

So it's failing here:

static int device_add_class_symlinks(struct device *dev)
{
	int error;

	if (!dev->class)
		return 0;
	error = sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
				  "subsystem");
	if (error) {
		DB();
		goto out;
	}
	error = sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
				  dev->bus_id);
	if (error) {
-->>		DB();
		goto out_subsys;
	}


Now, prior to driver-core-fixes-sysfs_create_link-retval-checks-in.patch we
were simply ignoring the return value of sysfs_create_link().  Now we're
not ignoring it and stuff is failing.

I'm suspecting that the second call to sysfs_create_link() in device_add():


	if (dev->class) {
		sysfs_create_link(&dev->kobj, &dev->class->subsys.kset.kobj,
				  "subsystem");
-->>		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
				  dev->bus_id);

is simply always failing, only we never knew about it.

It would be useful if you could tell us what `error' is in there.  Usually
-EEXIST.

Greg, what is that call actually linking from and to?


