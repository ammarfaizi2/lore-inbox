Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbSJ3MEy>; Wed, 30 Oct 2002 07:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbSJ3MEy>; Wed, 30 Oct 2002 07:04:54 -0500
Received: from h-64-105-137-87.SNVACAID.covad.net ([64.105.137.87]:62690 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262383AbSJ3MEx>; Wed, 30 Oct 2002 07:04:53 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 30 Oct 2002 04:11:11 -0800
Message-Id: <200210301211.EAA01709@adam.yggdrasil.com>
To: christophe.varoqui@free.fr
Subject: Re; [RFC]partitions through device-mapper
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>now that the device mapper is merged into mainline, I would like to open a 
>discussion on the possible in-kernel partition handling clean-up. 
> 
>In-kernel partition handling covers : 
>o parsing of the on-disk partition tables 
>o partition block devices creation / structs 
> 
>Along with initramfs will come the possibility to rip off the partition tables 
>parsing from the kernel : a userspace parser like partx (part of util-linux 
>toolset) can teach the kernel the partition layout. 


	Yes!!!!!!

	For the past two years, I have run systems with no kernel
partition parsing code.  The just use partx in the initial ramdisk
(for the root partition) and called by devfs.  I know from experience
that work it works fine.

	I have wanted to get rid of most of the scaffolding supporting
kernel based partition reading as well, and I have been waiting for
device mapper to get integrated to do this, because I also wanted to
get rid of the ioctl's that partx currently uses.

	I'd also like to eliminate all or most of /dev/loop once
the device mapper code is place, perhaps including a block agent
to connect to cryptoapi.

	By the way, I have a patch that turns the kernel partition
readers into modules.

	"rm -rf /usr/src/linux/fs/partitions" is probably politically
infeasible right now (for one thing, that would mean that all systems
that have root a a disk partition would always boot to an initial
ramdisk to run partx first, which would be fine with me, but perhaps
not with other people).

	So, my hope for making everyone happy would be to make the
parititioning code modularizable.  I have changes that make the
individual partition readers into modules, which I posted and have in
all of my kernels, but I haven't given it a try in a long time because
I never run kernel level partition readers anymore.  It would be nice
to see what junk could be scraped from the rest of the kernel and
moved into fs/partitions so that it can be jetisonned into a module.

	Likewise, I have deleted the automatic partition rereading
code on my system from the fs/devfs/base.c, which was only an
incompatibility between devfs and non-devfs systems anway (I think I
originally did this because you could not read CompactFlash cards from
devfs at the time).


>As driverfs provides elegantly block device add/remove events to hotplug, calls 
>to partx can be wrapped into the block.agent 

	And you're not really "relying" on hotplugging here more than
in the current kernel, as this scenario only needs to apply to devices
that are being hotplugged.

	By the way, devfs users do not really need this anyhow.  If I
attempt to read /dev/discs/discN/partN and that device does not exist,
devfsd will automatically run partx -a /dev/discs/discN/disc for me.

	Also, it is important that device mapper itself be optional to
reduce the footprint of systems that do not need to understand
partitions (for example a router that just runs from its initial
ramdisk).

>The device-mapper merging could enable the ripping of all kernel partition 
>understanding by creating linear device-maps over partitions. 
> 
>As a proof of concept, I've mutated partx to create those mappings. This tool 
>is available for testing and commenting at : 
>http://dsit.free.fr/dmpartx.tar.bz2

	After .45 comes out for real, I plan to try switching to your
dmpartx.  If you don't hear me complain shortly after that, I
recommend that you submit a merge of some kind to the util-linux
maintainer (Andries Brouer - aeb@cwi.nl).  I guess it would be a good
idea to preserve that backward compatability of being able to compile
in support for the old ioctls if they are still defined (I'd like to
see them removed from the kernel shortly if this code works, so it
would good to backet the old code in #ifdef's for the ioctls actually
being defined).

[...]
>* driverfs send block device-removal-event at the end of the job, but device 
>removal cannot happen as there are device-mappings over it. This ordering 
>forbids hotplug to trigger the partition-mappings flush before block-device 
>removal. Can this ordering be changed, or is there another solution ? 

	Regardless of partitioning issues, it is physically possible
to yank out a hard disk that has IO pending, so I don't think you
scheme introduces a new race.

	I don't know how dm does it now, but, if an underlying device
disappears, it ideally should not require a user level program to run
to invalidate the dependent partition mappings.  Regarding devfs,
whatever deletes /dev/discs/discN will automatically delete
/dev/discs/discN/partN.

[...]
>* Should dmpartx create the 0-lengh partitions ? It does not at the moment. 
>Extended partitions are handled the same way as partx : resize to 63 blocks 

	This question is not specific to device mapper, and {,dm}partx
conveniently moves this question to user land, where people can customize
as they see fit.  For what its worth, I agree that I would rather that
dmpartx not create zero length partitions by default, but that it should
increment the partition number in the device names.

	Thank you very very much for taking the initiative and writing
dmpartx.  It is a step in exactly the right direction, in my humble
opinion.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
