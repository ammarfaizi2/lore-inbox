Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267626AbSKTECc>; Tue, 19 Nov 2002 23:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbSKTECc>; Tue, 19 Nov 2002 23:02:32 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59363 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265736AbSKTEC1>; Tue, 19 Nov 2002 23:02:27 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Date: Wed, 20 Nov 2002 15:09:18 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
Subject: RFC - new raid superblock layout for md driver
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The md driver in linux uses a 'superblock' written to all devices in a
RAID to record the current state and geometry of a RAID and to allow
the various parts to be re-assembled reliably.

The current superblock layout is sub-optimal.  It contains a lot of
redundancy and wastes space.  In 4K it can only fit 27 component
devices.  It has other limitations.

I (and others) would like to define a new (version 1) format that
resolves the problems in the current (0.90.0) format.

The code in 2.5.lastest has all the superblock handling factored out so
that defining a new format is very straight forward.

I would like to propose a new layout, and to receive comment on it..

My current design looks like:
	/* constant array information - 128 bytes */
    u32  md_magic
    u32  major_version == 1
    u32  feature_map     /* bit map of extra features in superblock */
    u32  set_uuid[4]
    u32  ctime
    u32  level
    u32  layout
    u64  size		/* size of component devices, if they are all
			 * required to be the same (Raid 1/5 */
    u32  chunksize
    u32  raid_disks
    char name[32]
    u32  pad1[10];

	/* constant this-device information - 64 bytes */
    u64  address of superblock in device
    u32  number of this device in array  /* constant over reconfigurations */
    u32  device_uuid[4]
    u32  pad3[9]

	/* array state information - 64 bytes */
    u32  utime
    u32  state    /* clean, resync-in-progress */
    u32  sb_csum
    u64  events
    u64  resync-position	/* flag in state if this is valid)
    u32  number of devices
    u32  pad2[8]

	/* device state information, indexed by 'number of device in array' 
	   4 bytes per device */
    for each device:
      u16 position     /* in raid array or 0xffff for a spare. */
      u16 state flags  /* error detected,  in-sync */


This has 128 bytes for essentially constant information about the
array, 64 bytes for constant information about this device, 64 bytes
for changable state information about the array, and 4 bytes per
device for state information about the devices.  This would allow an
array with 192 devices in a 1K superblock, and 960 devices in a 4k
superblock (the current size).

Other features:
   A feature map instead of a minor version number.
   64 bit component device size field.
   field for storing current position of resync process if array is
       shut down while resync is running.
   no "minor" field but a textual "name" field instead.
   address of superblock in superblock to avoid misidentifying
      superblock. e.g. is it in a partition or a whole device.
   uuid for each device.  This is not directly used by the md driver,
      but it is maintained, even if a drive is moved between arrays, 
      and user-space can use it for tracking devices.

md would, of course, continue to support the current layout
indefinately, but this new layout would be available for use by people
who don't need compatability with 2.4 and do want more than 27 devices
etc. 

To create an array with the new superblock layout, the user-space
tool would write directly to the devices, (like mkfs does) and then
assemble the array.  Creating an array using the ioctl interface will
still create an array with the old superblock.

When the kernel loads a superblock, it would check the major_version
to see which piece of code to use to handle it.
When it writes out a superblock, it would use the same version as was
read in (of course).

This superblock would *not* support in-kernel auto-assembly as that
requires the "minor" field that I have deliberatly removed.  However I
don't think this is a big cost as it looks like in-kernel
auto-assembly is about to disappear with the early-user-space patches.

The interpretation of the 'name' field would be up to the user-space
tools and the system administrator.
I imagine having something like:
	host:name
where if "host" isn't the current host name, auto-assembly is not
tried, and if "host" is the current host name then:
  if "name" looks like "md[0-9]*" then the array is assembled as that
    device
  else the array is assembled as /dev/mdN for some large, unused N,
    and a symlink is created from /dev/md/name to /dev/mdN
If the "host" part is empty or non-existant, then the array would be
assembled no-matter what the hostname is.  This would be important
e.g. for assembling the device that stores the root filesystem, as we
may not know the host name until after the root filesystem were loaded.

This would make auto-assembly much more flexable.

Comments welcome.

NeilBrown
