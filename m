Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTDKSTw (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTDKSTw (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:19:52 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:59288 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261521AbTDKSTt (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:19:49 -0400
Message-ID: <3E970A00.2050204@cox.net>
Date: Fri, 11 Apr 2003 11:31:28 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-hotplug-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com>
In-Reply-To: <20030411182313.GG25862@wind.cocodriloo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Vargas wrote:

> On Fri, Apr 11, 2003 at 06:46:09PM +0100, John Bradford wrote:
> 
>>>>- Performance. What happens if you plug in 4000 disks at once?
>>>
>>>You crash your power supply :)
>>
>>[Puzzle]
>>
>>Say the power supply had five 5.25" drive power connecters, how many 1
>>into 3 power cable splitters would you need to connect all 4000 disks?
>>

OK, this is all fun and games, but this is a valid point. All it takes for the 
driver for a Fibre Channel host adapter to load, and enumerate the devices it 
can see. In a matter of seconds many hundreds or thousands of disk devices could 
be registered with the kernel.

This is definitely an issue that will need to be addressed, and I think Oliver's 
suggestion of using a pipe (i'm going to say it: like devfs did :-) to forward 
the events to /sbin/hotplug in a FIFO fashion makes some sense. I have also been 
considering this issue from another angle; I am working on userspace partition 
discovery, which will be driven by /sbin/hotplug (and udev, probably). I have 
concerns that the following scenario will cause problems, if not extreme problems:

- kernel driver finds an IDE drive, registers it and the hotplug event happens
- udev gets called and gives it device node /dev/discs/disc0 (or whatever)
- /sbin/hotplug calls userspace partition discovery, which opens the device and 
scans for partitions
- if any partitions are found, they are registered with the kernel using 
device-mapper ioctls
- because these new "mapped sections" of the drive are _also_ usable block 
devices in their own right, they generate hotplug events
- because these hotplug events are for new block devices, userspace partition 
discovery will get called _again_ to handle them (it may not find anything (the 
normal case), but this model will support nearly infinite levels of partitioning 
on any block device supported by the kernel)

What happens if these secondary hotplug events occur while /sbin/hotplug has not 
yet finished processing the first one? Ignoring locking/race issues for the 
moment, I'm concerned about memory consumption as many layers of 
hotplug/udev/kpartx/etc. are running processing these events.

Of course, another possibility I'll look into this weekend is to actually have 
kpartx run as a daemon and receive messages over D-BUS, instead of being invoked 
directly by /sbin/hotplug. This would mean it could serialize the events itself 
and reduce some of the load (if D-BUS supports message queueing, which I believe 
it does).

Actually, here's another thought: have the kernel continue to call /sbin/hotplug 
for every event, just as it does now. However, /sbin/hotplug would do _nothing_ 
but translate that into D-BUS messages and post them. udev, kpartx, etc. would 
all just be D-BUS clients that would respond to their messages as they are received.

