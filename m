Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUBJLdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUBJLdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:33:52 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:63370 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S265833AbUBJLdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:33:49 -0500
Date: Tue, 10 Feb 2004 03:34:18 -0800
From: Mike Bell <kernel@mikebell.org>
To: linux-kernel@vger.kernel.org
Subject: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210113417.GD4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been reading a lot lately about udev and how it's both very
different to and much better than devfs, and with _most_ of the reasons
given, I can't see how either is the case. I'd like to lay out why I
think that is.

I keep hearing about how udev has no naming policy in the kenel, while
devfs has a fixed one and if you don't like it tough. But udev relies on
sysfs, which IS naming policy in the kernel. And devfs has devfsd, which
is a userspace daemon that listens to a kernel-exported filesystem (just
like udev) and can create whatever /dev layout you want from that, in
userspace (just like udev). Basically, udev relies on sysfs exporting
device numbers. Well, imagine for a moment sysfs exported actual device
files instead of just the numbers you'd need to make a device file (a
pretty minor change, though not one I'm advocating). What you've got
there is basically devfs and devfsd, right? Not the same
implementation-wise, obviously, but essentially IDENTICAL concepts.
Kernel exports device files to a kernel-generated filesystem, user-space
daemon creates /dev from those with a layout according to your liking.

Meanwhile, devfs (or a devfs-like solution) offer several things which
udev just can't. Having a special kernel-exported filesystem just for
/dev means your user-space daemon can see when a program is trying to
access a device file that doesn't exist yet, you can't do that with
udev and tmpfs. Moreover, it means you've got a functional /dev that
accurately represents the system regardless of whether the user-space
daemon is running yet. With udev, you're stuck with a static /dev unless
udev is running. This can happen when broken system or doing a fresh
installation, or if you accidentally break your udev binary. And heavens
help you if linux ever moves to dynamic device files, that would make a
static /dev completely unusable. Which would in turn mean that your
system is unusable unless udev is running. It's not a big problem, but
myself I find myself using devfs without devfsd for those two reasons
every once in a while, and in those instances devfs is really nice.

So the question is, is a devfs-like implementation really unfixable? And
if not, is it worth whatever disadvantages can't be avoided? On the
matter of memory usage, I'm really not sure why a new devfs couldn't be
tied to the new device model. As I said earlier, it's only a subtle
change from exporting a major and minor in sysfs to exporting a device
file (in newdevfs or wherever). And I haven't heard anyone say devfs's
race conditions are inherent to the idea, just that devfs's
implementation has them.

Finally, from /my/ experience, the one thing people disliked most about
devfs was the long names for hard drive partitions. But isn't one of the
first things on the agenda for 2.7 taking the partition detection code
out of the kernel and replacing it with device-mapper? If you do that,
then the block devices you actually USE are all device mapper created.
They're already controlled by a user-space daemon. The real block
devices are only used when you're partitioning (or LVMing, or EVMSing,
or whatever). The rest of the time, in /etc/fstab or passing to mkfs or
whatever else, you're using the dm devices. Now there's no reason
a new devfs would HAVE to export long and unwieldy names for block
devices, but if the only time you're actually using those names is for
repartitioning, I really wouldn't care if they were long and unwieldy.
It wouldn't show up in fstab, or df, or anywhere else the devfs style
names have made a nuicance of themselves, so who cares?

Sorry if any of these points has already been discussed on
linux-kernel, I don't have time to read the list so I'm going based on
what's been reported in things like kernel-traffic.
