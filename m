Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTA1RW5>; Tue, 28 Jan 2003 12:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTA1RW4>; Tue, 28 Jan 2003 12:22:56 -0500
Received: from fw-az.mvista.com ([65.200.49.158]:61431 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S267439AbTA1RWz>; Tue, 28 Jan 2003 12:22:55 -0500
Message-ID: <3E36BBDF.4090104@mvista.com>
Date: Tue, 28 Jan 2003 10:20:31 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: New model for managing dev_t's for partitionable block devices
References: <3F61ABC3.1080502@tin.it>
In-Reply-To: <3F61ABC3.1080502@tin.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking of an entirely new model for partitionable block devices. 
Here is how it would work:

Each physical disk would be assigned a minor number in a group of 
majors.  So assume a major was chosen of 150, 151, 152, 153, there would 
be a total of 1024 physical disks that could be mapped.  Then the device 
mapper code could be used to provide partition devices in another 
major/group of majors.

The advantage of this technique is that instead of wasting tons of 
minors on partitions that are never used, partitions could be 
dynamically allocated out of the minor list, allowing for thousands of 
disks with varying numbers of partitions each.  Further instead of each 
block device (such as i2o, scsi, etc) having their own set of majors for 
each partitionable disk (which wastes dev_t address space) everything 
would be compressed into the same set of majors.

As an example, Lets assume we want 4096 total disks with 16384 total 
partitions (4 partitions per disk, where it is likely to be less):

That is:
4096 disks / 256 disks * 1 major = 16 majors
16384 partitions / 256 partitions * 1 major = 64 majors
total of 80 majors

To allow a similiar configuration in the current block device setup, 
with just the SCSI disk major,
4096 disks / 16 disks * 1 major = 256 majors

Now, assume we have 4096 disks available for i2o, scsi, compaq raid, etc 
etc, we are talking about lots of majors that go way beyond the current 
addressable 16 bytes.

The only downside is addressing the disks in hotswap (ie: how do you 
know what disk is where?)  This can be achieved through per-subsystem 
devfs mapping (ie: linking /dev/scsi/hostX/... to /dev/disc0) or 
userspace utilities that scan the disk devices (such as those that would 
be in /dev/disk) and determine which disks are what.

Thanks
-steve

>

