Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTJFRjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbTJFRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:39:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:37067 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262372AbTJFRjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:39:36 -0400
Date: Mon, 6 Oct 2003 10:38:58 -0700
From: Greg KH <greg@kroah.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006173858.GA4403@kroah.com>
References: <20031006085915.GE4220@in.ibm.com> <20031006160846.GA4125@us.ibm.com> <20031006173111.GA1788@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006173111.GA1788@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:01:11PM +0530, Dipankar Sarma wrote:
> On Mon, Oct 06, 2003 at 09:08:46AM -0700, Greg KH wrote:
> > On Mon, Oct 06, 2003 at 02:29:15PM +0530, Maneesh Soni wrote:
> > > 
> > > 				2.6.0-test6		With patches.
> > > -----------------
> > > dentry_cache (active)		2520			2544
> > > inode_cache (active)		1058			1050
> > > LowFree			875032 KB		874748 KB
> > 
> > So with these patches we actually eat up more LowFree if all sysfs
> > entries are searched, and make the dentry_cache bigger?  That's not good :(
> 
> My guess is that those 24 dentries are just noise. What we should
> do is verify with a large number of devices if the numbers are all
> that different after a walk of the sysfs tree.

Ok, a better test would be with a _lot_ of devices.  Care to test with a
lot of scsi debug devices?

> > Remember, every kobject that's created will cause a call to
> > /sbin/hotplug which will cause udev to walk the sysfs tree to get the
> > information for that kobject.  So I don't see any savings in these
> > patches, do you?
> 
> Assuming that unused files/dirs are aged out of dentry and inode cache,
> it should benefit. The numbers you should look at are -
> 
> --------------------------------------------------------
> After mounting sysfs
> -------------------
> dentry_cache (active)           2350                    1321
> inode_cache (active)            1058                    31
> LowFree                         875096 KB               875836 KB
> --------------------------------------------------------
> 
> That saves ~800KB. If you just mount sysfs and use a few files, you
> aren't eating up dentries and inodes for every file in sysfs. How often 
> do you expect hotplug events to happen in a system ?

Every kobject that is created and is associated with a subsystem
generates a hotplug call.  So that's about every kobject that we care
about here :)

> Some time after a hotplug event, dentries/inodes will get aged out and
> then you should see savings. It should greatly benefit in a normal
> system.

Can you show this happening?

> Now if the additional kobjects cause problems with userland hotplug, then 
> that needs to be resolved. However that seems to be a different problem 
> altogether. Could you please elaborate on that ?

No, I don't think the additional ones you have added will cause
problems, but can you verify this?  Just log all hotplug events
happening in your system (point /proc/sys/kernel/hotplug to a simple
logging program).

But again, I don't think the added overhead you have added to a kobject
is acceptable for not much gain for the normal case (systems without a
zillion devices.)

thanks,

greg k-h
