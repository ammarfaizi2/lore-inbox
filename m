Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUHGWZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUHGWZT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUHGWZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:25:19 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21163 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264503AbUHGWYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:24:55 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: schilling@fokus.fraunhofer.de
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1091908405.5759.49.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Aug 2004 15:53:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 5) Take a look at /etc/path_to_inst and call "man path_to_inst"
>
> The used method even works nicely for USB devices.

OK, I took a look.

Solaris is mapping from devfs to dev_t with this file.
You start with a device patch like this:
    /iommu@f,e0000000/sbus@f,e0001000/sbusmem@f,0
It maps to a driver name and instance number:
    sbusmem   15
The driver name implys the major number. (in a dev_t)
The instance number is, more or less, the minor number.

Linux does something like this too now, using "udev"
and the rest of the hotplug stuff. Linux is better.
Linux lets you map from most any device attribute
(bus, serial number, vendor, scsi level, speed...)
to a device name.

Oh, the dev_t value? That's becoming a random number.
Users don't need it, and shouldn't have to deal with it.
They have the device name. Bus numbers are random too.

So let's suppose I plug in two FireWire CD burners.
The Que!Fire one is mapped to /dev/quefire-cdrw,
and the Sony one is mapped to /dev/sony-cdrw. The
device numbers will vary, as will any bus numbers,
but the users don't care. They have nice names.

Suppose I kick the FireWire cable loose. The device
nodes in /dev go away. Then I plug the cable back in,
and new device nodes appear. The numbers might change!
No matter what the numbers though, the drives always
get the names that I have assigned to them.

Before I kick the cable loose:

dev=0,0,1  matches with  /dev/quefire-cdrw
dev=0,0,2  matches with  /dev/sony-cdrw

After I plug the cable back in:

dev=0,0,0  matches with  /dev/quefire-cdrw
dev=0,0,1  matches with  /dev/sony-cdrw

Everything's cool for apps that use device names.
Only cdrecord will try to access the wrong device.

I'm sure this dynamic world isn't appealing to you.
People do kick cables loose though, and they do like
having nice device names. The days of jumpers are
long gone. Plug-and-play is here to stay, even while
the machine is running. CAM-based operating systems
will have some adjusting to do if they are to survive.

Go ahead and drop support for old Linux kernels.
Users with old kernels can use the old cdrecord.
Handling Linux 2.6.x well means using /dev names.




