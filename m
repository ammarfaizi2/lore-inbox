Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTJFR7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTJFR7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:59:16 -0400
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:37270 "EHLO
	mtagate7.uk.ibm.com") by vger.kernel.org with ESMTP id S264035AbTJFR7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:59:07 -0400
Date: Mon, 6 Oct 2003 23:31:19 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006180119.GC1788@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006160846.GA4125@us.ibm.com> <20031006173111.GA1788@in.ibm.com> <20031006173858.GA4403@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006173858.GA4403@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 10:38:58AM -0700, Greg KH wrote:
> On Mon, Oct 06, 2003 at 11:01:11PM +0530, Dipankar Sarma wrote:
> > My guess is that those 24 dentries are just noise. What we should
> > do is verify with a large number of devices if the numbers are all
> > that different after a walk of the sysfs tree.
> 
> Ok, a better test would be with a _lot_ of devices.  Care to test with a
> lot of scsi debug devices?

Sure. At the same time, as Maneesh pointed out, this is just an
RFC. The backing store design probably needs quite some work first.

> > --------------------------------------------------------
> > After mounting sysfs
> > -------------------
> > dentry_cache (active)           2350                    1321
> > inode_cache (active)            1058                    31
> > LowFree                         875096 KB               875836 KB
> > --------------------------------------------------------
> > 
> > That saves ~800KB. If you just mount sysfs and use a few files, you
> > aren't eating up dentries and inodes for every file in sysfs. How often 
> > do you expect hotplug events to happen in a system ?
> 
> Every kobject that is created and is associated with a subsystem
> generates a hotplug call.  So that's about every kobject that we care
> about here :)

That would not happen in a normal running system often, right ? So,
I don't see the point looking at mem usage after hotplug events.

> 
> > Some time after a hotplug event, dentries/inodes will get aged out and
> > then you should see savings. It should greatly benefit in a normal
> > system.
> 
> Can you show this happening?

It should be easy to demonstrate. That is how dentries/inodes
work for on-disk filesystems. If Maneesh's patch didn't work that
way, then the whole point is lost. I hope that is not the case.

> 
> > Now if the additional kobjects cause problems with userland hotplug, then 
> > that needs to be resolved. However that seems to be a different problem 
> > altogether. Could you please elaborate on that ?
> 
> No, I don't think the additional ones you have added will cause
> problems, but can you verify this?  Just log all hotplug events
> happening in your system (point /proc/sys/kernel/hotplug to a simple
> logging program).
> 
> But again, I don't think the added overhead you have added to a kobject
> is acceptable for not much gain for the normal case (systems without a
> zillion devices.)

IIRC, Maneesh test machine is a 2-way P4 xeon with six scsi disks and savings
are of about 800KB. That is as normal a case as it gets, I think.
It only gets better as you have more devices in your system.

Thanks
Dipankar
