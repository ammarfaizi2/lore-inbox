Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTKBR3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 12:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTKBR3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 12:29:09 -0500
Received: from quechua.inka.de ([193.197.184.2]:50663 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261754AbTKBR3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 12:29:03 -0500
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Daniel Stekloff <dsteklof@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200310290920.06056.dsteklof@us.ibm.com>
References: <3F9D82F0.4000307@mvista.com> <20031028224416.GA8671@kroah.com>
	 <pan.2003.10.29.14.30.29.628488@dungeon.inka.de>
	 <200310290920.06056.dsteklof@us.ibm.com>
Content-Type: text/plain
Organization: small linux home
Message-Id: <1067794124.30274.18.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 02 Nov 2003 18:28:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-29 at 18:20, Daniel Stekloff wrote:
> The tdb database is for storing current device information, udev needs to 
> reference names to devices. The database also enables an api for applications 
> to query what devices are on the system, their names, and their nodes. 
> 
> Using tdb has its advantages too; it's small, it's flexible, it's fast, it can 
> be in memory or on disk, and it has locking for multiple accesses.
> 
> IMVHO - tdb isn't bloat.

Hi Dan,

thanks for your email.
I took a look at tdb. Upon adding devices, the DEVPATH is resolved via
config files etc. to a final /dev filename. That combination is stored
in tdb, and when the device is remove, the same resolution process is
not done, but the tdb is looked up to find the filename, and remove
the device. Is that right?

So the advantage would be resistance against config file changes - if
the nameing scheme is changed while a devices is added, the remove would
get the new name, and that way try to remove the wrong device.

Also this mechanism could be used to implement counting device names
like "disc/0", where the final name depends on the devices currently
available, so there is no static translation from devpath to the
filename.

I'd prefer the kernel giving up the old device names, and migrating
to counter names i.e. disc/0, cdrom/0, printer/0, etc. Those who
still want the old names could use /sys/ to determine the details
on the device, and that way create devices per the old naming schema.
That way tdb wouldn't be necessary for counting device names, at least
if sysfs still has the full information on the device while the hotplug
event runs. I guess that is not the case or not guaranteed?

Also I have to admit, if symlinks like "hpdeskjet" to some usb device
are configured in the config, the device is attached, and the config
is changed, then a remove event will not find the old symlink and
cannot remove it, without tdb.

But maybe like a coldplug / fulling an empty /dev, there should be
rerun command? I.e. like coldplug determine what device and symlinks
shold be in /dev, and the remove unnecessary, add missing, and modify
outdated entries (devices,files)? If that existed, configuration changes
wouldn't be a reason for udev to use tdb?

So why is tdb currently required? I only see the possibility to use
naming schemes like disc/0 as a reason, but that isn't implemented
in udev so far...

other than a theological discussion about needed or not, I guess nobody
will complain about it - even people with /dev on tmpfs and a readonly
/ will have a writable or tmpfs /var so they can live with it anyway.
but I'm still not sure, if it isn't unnecessary.

Regards, Andreas

