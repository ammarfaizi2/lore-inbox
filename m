Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTJFR3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTJFR3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:29:10 -0400
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:11918 "EHLO
	mtagate7.uk.ibm.com") by vger.kernel.org with ESMTP id S262464AbTJFR3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:29:06 -0400
Date: Mon, 6 Oct 2003 23:01:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/6] Backing Store for sysfs
Message-ID: <20031006173111.GA1788@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006160846.GA4125@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006160846.GA4125@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 09:08:46AM -0700, Greg KH wrote:
> On Mon, Oct 06, 2003 at 02:29:15PM +0530, Maneesh Soni wrote:
> > 
> > 				2.6.0-test6		With patches.
> > -----------------
> > dentry_cache (active)		2520			2544
> > inode_cache (active)		1058			1050
> > LowFree			875032 KB		874748 KB
> 
> So with these patches we actually eat up more LowFree if all sysfs
> entries are searched, and make the dentry_cache bigger?  That's not good :(

My guess is that those 24 dentries are just noise. What we should
do is verify with a large number of devices if the numbers are all
that different after a walk of the sysfs tree.

> 
> Remember, every kobject that's created will cause a call to
> /sbin/hotplug which will cause udev to walk the sysfs tree to get the
> information for that kobject.  So I don't see any savings in these
> patches, do you?

Assuming that unused files/dirs are aged out of dentry and inode cache,
it should benefit. The numbers you should look at are -

--------------------------------------------------------
After mounting sysfs
-------------------
dentry_cache (active)           2350                    1321
inode_cache (active)            1058                    31
LowFree                         875096 KB               875836 KB
--------------------------------------------------------

That saves ~800KB. If you just mount sysfs and use a few files, you
aren't eating up dentries and inodes for every file in sysfs. How often 
do you expect hotplug events to happen in a system ? Some time after a 
hotplug event, dentries/inodes will get aged out and then you should see 
savings. It should greatly benefit in a normal system.

Now if the additional kobjects cause problems with userland hotplug, then 
that needs to be resolved. However that seems to be a different problem 
altogether. Could you please elaborate on that ?

Thanks
Dipankar
