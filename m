Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTKCXbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTKCXbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 18:31:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:25826 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263485AbTKCXbs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 18:31:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Date: Mon, 3 Nov 2003 15:29:21 -0800
User-Agent: KMail/1.4.1
References: <3F9D82F0.4000307@mvista.com> <200310290920.06056.dsteklof@us.ibm.com> <1067794124.30274.18.camel@simulacron>
In-Reply-To: <1067794124.30274.18.camel@simulacron>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311031529.21509.dsteklof@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 November 2003 09:28 am, Andreas Jellinghaus wrote:
> On Wed, 2003-10-29 at 18:20, Daniel Stekloff wrote:
> > The tdb database is for storing current device information, udev needs to
> > reference names to devices. The database also enables an api for
> > applications to query what devices are on the system, their names, and
> > their nodes.
> >
> > Using tdb has its advantages too; it's small, it's flexible, it's fast,
> > it can be in memory or on disk, and it has locking for multiple accesses.
> >
> > IMVHO - tdb isn't bloat.
>
> Hi Dan,


Hi Andreas, 

Sorry for my late reply. 


> thanks for your email.
> I took a look at tdb. Upon adding devices, the DEVPATH is resolved via
> config files etc. to a final /dev filename. That combination is stored
> in tdb, and when the device is remove, the same resolution process is
> not done, but the tdb is looked up to find the filename, and remove
> the device. Is that right?


The device path and device name are stored in the tdb database. The path is 
used as the primary key, the unique identifier to locate the specific device. 
A device is added by path and then removed using the path. 


> So the advantage would be resistance against config file changes - if
> the nameing scheme is changed while a devices is added, the remove would
> get the new name, and that way try to remove the wrong device.


Adding and removing device from the tdb database is done based on the device's 
path and not the generated name. Changing the config file shouldn't impact 
currently loaded and configured devices. 



> Also this mechanism could be used to implement counting device names
> like "disc/0", where the final name depends on the devices currently
> available, so there is no static translation from devpath to the
> filename.
>
> I'd prefer the kernel giving up the old device names, and migrating
> to counter names i.e. disc/0, cdrom/0, printer/0, etc. Those who
> still want the old names could use /sys/ to determine the details
> on the device, and that way create devices per the old naming schema.
> That way tdb wouldn't be necessary for counting device names, at least
> if sysfs still has the full information on the device while the hotplug
> event runs. I guess that is not the case or not guaranteed?
>
> Also I have to admit, if symlinks like "hpdeskjet" to some usb device
> are configured in the config, the device is attached, and the config
> is changed, then a remove event will not find the old symlink and
> cannot remove it, without tdb.
>
> But maybe like a coldplug / fulling an empty /dev, there should be
> rerun command? I.e. like coldplug determine what device and symlinks
> shold be in /dev, and the remove unnecessary, add missing, and modify
> outdated entries (devices,files)? If that existed, configuration changes
> wouldn't be a reason for udev to use tdb?
>
> So why is tdb currently required? I only see the possibility to use
> naming schemes like disc/0 as a reason, but that isn't implemented
> in udev so far...
>
> other than a theological discussion about needed or not, I guess nobody
> will complain about it - even people with /dev on tmpfs and a readonly
> / will have a writable or tmpfs /var so they can live with it anyway.
> but I'm still not sure, if it isn't unnecessary.


Honestly, I'm not exactly sure what you're questioning - is tdb specifically 
unnecessary or is having a backing store unnecessary. 

It's true, you could do without a backing store. You could build the reference 
between device and name every time you wish to work with the device. In some 
cases that would be easy, such as simply using the kernel naming system. In 
other cases it might not be so easy, especially if you use a specific and 
complicated naming scheme. You'd have to pay the processing hit it would take 
to calculate the names every time you access a device. You'd also have to 
deal with issues like current devices and adjusting the config files, which 
you've already brought up. 

I believe having a backing store - whether tdb, gdbm, a table in memory, or a 
flat file - is useful for storing the configured devices and their names. 
It's cheap to submit a small query to find the necessary device, rather than 
having to go through the naming process every time a device is added, 
removed, or queried. Having the backing store removes the problem you 
mentioned about changing config files on the fly, there's no loose ends or 
missing or changed device names - they are stored in the database. I believe 
the trade off between backing store complexity and storage versus on the fly 
calculation is worth it. I can understand if you feel differently.

As for tdb specifically being unnecessary, you could most certainly use 
something else to store device information. You could use a flat file. You 
could use gdbm. You could use a simple table in memory. I chose tdb for the 
following reasons: 

- it is a proven mechanism. 
- it could handle thousands of devices.
- it is fast to query.
- it has a small footprint.

It seemed to me like a good solution for udev's backing store need. 

If you believe udev doesn't need the backing store and/or tdb, let's see your 
solution and we can decide on its technical merit by looking it over. I'm 
certainly open to new ideas and solutions. I'm sorry if you felt this was a 
"theological" discussion, I certainly don't feel the same way.

Cheers,

Dan

 


> Regards, Andreas

