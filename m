Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTJVBsm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTJVBsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:48:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:22412 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263395AbTJVBsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:48:38 -0400
Date: Tue, 21 Oct 2003 18:46:39 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 004 release
Message-ID: <20031022014639.GA5573@kroah.com>
References: <20031021162856.GA1030@kroah.com> <20031021214554.GA7791@sgi.com> <20031021221337.GA3083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021221337.GA3083@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 03:13:38PM -0700, Greg KH wrote:
> On Tue, Oct 21, 2003 at 02:45:55PM -0700, Jesse Barnes wrote:
> > Thanks for the new release, Greg.  I just tried it out on a system with
> > some disks, but a bunch of udev processes ended up hanging.  Is there
> > something I'm missing or do you need a patch like this?
> 
> Yeah, sorry, this kind of fix is required :(
> 
> It's fixed in my bk tree now.
> 
> Oh, and it looks like the LABEL rule is also broken due to the libsysfs
> changes...  I'm working on adding regression tests right now to prevent
> things like this from slipping through.

Here's a patch for this.  It fixes the problem of LABEL rules on the
device, not the class device.  LABEL rules on the class device seem to
work just fine.

Thanks to Dan Stekloff for help in finding this bug.

thanks,

greg k-h


# fix LABEL bug for device files (not class files.)

diff -Nru a/namedev.c b/namedev.c
--- a/namedev.c	Tue Oct 21 18:44:59 2003
+++ b/namedev.c	Tue Oct 21 18:44:59 2003
@@ -566,7 +566,7 @@
 
 			/* look in the class device directory if present */
 			if (class_dev->sysdevice) {
-				tmpattr = sysfs_get_classdev_attr(class_dev, dev->sysfs_file);
+				tmpattr = sysfs_get_device_attr(class_dev->sysdevice, dev->sysfs_file);
 				if (tmpattr)
 					goto label_found;
 			}
@@ -599,7 +599,7 @@
 
 					/* look in the class device directory if present */
 					if (class_dev_parent->sysdevice) {
-						tmpattr = sysfs_get_classdev_attr(class_dev_parent, dev->sysfs_file);
+						tmpattr = sysfs_get_device_attr(class_dev_parent->sysdevice, dev->sysfs_file);
 						if (tmpattr) 
 							goto label_found;
 					}
