Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbSJ2NdO>; Tue, 29 Oct 2002 08:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSJ2NdO>; Tue, 29 Oct 2002 08:33:14 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:25273 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S261860AbSJ2NdN>; Tue, 29 Oct 2002 08:33:13 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC]partitions through device-mapper
Message-ID: <1035898775.3dbe8f97d1a3f@imp.free.fr>
Date: Tue, 29 Oct 2002 14:39:35 +0100 (MET)
From: christophe.varoqui@free.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 171.16.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
 
now that the device mapper is merged into mainline, I would like to open a 
discussion on the possible in-kernel partition handling clean-up. 
 
In-kernel partition handling covers : 
o parsing of the on-disk partition tables 
o partition block devices creation / structs 
 
Along with initramfs will come the possibility to rip off the partition tables 
parsing from the kernel : a userspace parser like partx (part of util-linux 
toolset) can teach the kernel the partition layout. 
 
As driverfs provides elegantly block device add/remove events to hotplug, calls 
to partx can be wrapped into the block.agent 
 
The device-mapper merging could enable the ripping of all kernel partition 
understanding by creating linear device-maps over partitions. 
 
As a proof of concept, I've mutated partx to create those mappings. This tool 
is available for testing and commenting at : 
http://dsit.free.fr/dmpartx.tar.bz2 
 
This tool cannot damage your data : BLKPG_DEL_PARTITION and  
BLKPG_ADD_PARTITION ioctls are removed from the source. 
 
I would like to receive feedback over the following points : 
 
* Is this proposal completely out of the point ? Have I overlooked some 
important implementation details ? 
 
* driverfs send block device-removal-event at the end of the job, but device 
removal cannot happen as there are device-mappings over it. This ordering 
forbids hotplug to trigger the partition-mappings flush before block-device 
removal. Can this ordering be changed, or is there another solution ? 
 
* 2.5.44-ac4 did not notify block-device-add upon scsi disk insertion with 
scsi-add-single-device, which I think is known by scsi subsystem maintainers. 
-> The block.agent provided with dmpartx is not tested. 
 
* Should dmpartx create the 0-lengh partitions ? It does not at the moment. 
Extended partitions are handled the same way as partx : resize to 63 blocks 
 
 
regards, 
cvaroqui 
