Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbSJCQss>; Thu, 3 Oct 2002 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJCQss>; Thu, 3 Oct 2002 12:48:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57491 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261385AbSJCQsp>;
	Thu, 3 Oct 2002 12:48:45 -0400
Date: Thu, 3 Oct 2002 09:55:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Alexander Viro <viro@math.psu.edu>
cc: Kevin Corry <corryk@us.ibm.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <evms-devel@lists.sourceforge.net>
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <Pine.GSO.4.21.0210031042210.15787-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210030945060.27710-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > I might agree with something along the lines of
> > > 	* when evms is initialized, it's notified of all existing gendisks
> > > 	* whenever disk is added after evms initialization, we notify evms
> > > 	* whenever disk is removed, we notify evms
> > 
> > This sounds like it would be exactly what EVMS needs. The only thing we would 
> > want to add to this list is: "*whenever a disk is modified, notify evms". For 
> > example, with removable media drives (such as Zip and Jaz), when a cartidge 
> > is changed, the capacity of the drive might change, and we would like to be 
> > notified of that event.
> 
> Umm...  OK.  There were some plans to add a notifier chain for such events
> and EVMS looks like a possible user of that beast.  However, it's not
> obvious whether we need to do any of that in the kernel - we definitely
> can have userland up and running before _any_ block devices are initialized,
> so it might be a work for userland helper.

There should be (almost) enough infrastructure in place to do either of
those things using the driver model core. There is now a disk
device_class, with which a struct device_interface can register with. When 
a device is added to the class, it is passed to each of the interfaces 
registered with the class (via the add_device method). 

There is a struct device in struct gendisk, and each device registered 
with the class will be the member of a struct gendisk. So, you can do

int add_device(struct device * dev)
{
	struct gendisk * disk = container_of(dev,struct gendisk,disk_dev);
	...

to get the gendisk structure. 

See include/linux/device.h and Documentation/driver-model/ for more info.

Also, /sbin/hotplug will be called after a device is registered with a 
class. Greg has been working on this aspect, and should be close to having 
it done. 

The missing piece is converting the disk drivers to have thier ->devclass 
set to the disk class, and having them register with the core. 


	-pat

