Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266707AbUGVQUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266707AbUGVQUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266727AbUGVQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:20:35 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:25027 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266707AbUGVQTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:19:38 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Announce: dumpfs v0.01 - common RAS output API
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Jul 2004 02:19:27 +1000
Message-ID: <16734.1090513167@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing dumpfs - a common API for all the RAS code that wants to
save data during a kernel failure and to extract that RAS data on the
next boot.  The documentation file is appended to this mail.

ftp://oss.sgi.com/projects/kdb/download/dumpfs - current version is
v0.01, patch against 2.6.8-rc2.

This is a work in progress, the code is not complete and is subject to
change without notice.

dumpfs-v0.01 handles mounting the dumpfs partitions, including reliable
sharing with swap partitions and clearing the dumpfs partitions.  I am
working on the code that reads and writes dumpfs data from kernel
space, it is incomplete and has not been tested yet.  After
dumpfs_kernel is working, dumpfs_user is trivial.  The code is proof of
concept, some sections of the API (including polled I/O and data
compression) are not supported yet, and some of the code is ugly.

Why announce incomplete and untested code?  Mainly because RAS and
kernel dumping are being discussed at OLS this week.  Since I cannot be
at OLS, this is the next best thing.  Also the dumpfs API has
stabilized for the first cut, so it is time to get more discussion on
the API and to determine if it is worth continuing with the dumpfs
approach.  If dumpfs is discussed at OLS then I would appreciate any
feedback.

Questions for the other people who care about RAS (which rules out most
of the kernel developers) -

* Is using a common dump API the right thing to do?

  Obviously I think that this makes sense.  At the moment every bit of
  RAS code has its own dedicated I/O mechanism, not to mention its own
  user space tools to interface with the kernel, and to initialize,
  extract and clear its own data.

  dumpfs consolidates a lot of common code that is scattered over
  several RAS tools.  dumpfs removes the need for special RAS tools to
  extract dump data on reboot, instead standard user space commands
  will do the job.

* Is overloading mount the best approach?

  Making mount dumpfs share the partition with swap is ugly.  OTOH most
  of the existing code that dumpfs is intended to replace makes no
  attempt to verify its partition usage.  At least dumpfs tries to
  verify its partition data, ugly though the code is.

* Does the dumpfs API need to be extended or even replaced, either in
  kernel or in user space?

  One obvious extension is to make compression selective, so that some
  sections of the file can be compressed and others be in clear text.
  The lcrash header springs to mind.  Omitted for now since this
  version does not support compression yet.

* How do we get a clean API to do polling mode I/O to disk?

  One thing that is absolutely required for reliable RAS output is a
  polling mode method.  netdump is available for the network, we need
  the equivalent for disk I/O.  What is the best way to integrate
  polling mode I/O into the block device subsystem?

If the people who care about RAS think that a common RAS output API is
worthwhile then I will continue working on dumpfs.  Otherwise it will
be just another idea that did not get taken up, and each RAS tool will
continue to be developed and maintained in isolation.


==== 2.6.8-rc2/Documentation/filesystems/dumpfs.txt ====

dumpfs provides a common API for RAS components that need to dump kernel data
during a problem.  The dumped data is expected to be copied and cleared on the
next successful boot.

dumpfs consists of two layers, with completely different semantics.  These are
dumpfs (kernel only) and dumpfs_user (user space view of any saved dump data).

dumpfs uses one mount for each dump partition.  Each dumpfs partition can be
mounted with option share or noshare, the default is noshare.  The only
allowable user space operations on a dumpfs partition are mount and umount, user
space cannot directly access the dumpfs data.  Each dumpfs partition is mounted
with "mount -t dumpfs /dev/partition /mnt/dumpfs".  /mnt/dumpfs must be a
directory; it never contains anything useful but the mount semantics require a
directory here.

A shared dumpfs partition will normally coexist with a swap partition; the
dumpfs superblock is stored at an offset which leaves the swap signature alone.
A shared dump partition has no superblock on disk until the first dump file is
created.  Mounting a dumpfs partition with "-o clear" will completely zero the
dumpfs superblock, including the magic field.  This ensures that old dumpfs data
in a shared partition will not be used, its contents are unreliable because of
the data sharing.

When mounting a shared dumpfs partition, no check is made to see if the disk
contains a dumpfs superblock.  Mounting a dumpfs partition with -o share will
only share with a swap partition, it will not share with any other mounted
partition.

A non-shared dumpfs partition must have a superblock before being mounted.
mkfs.dumpfs and fsck.dumpfs (only used for non-shared partitions) are trivial.
Mounting dumpfs with "-o noshare,clear" will clear the metadata in the dumpfs
superblock, but preserve the magic field.

mkfs.dumpfs

#!/bin/sh
dd if=/dev/zero of="$1" bs=64k count=1
echo 'dum0' | dd of="$1" bs=64k seek=1 conv=sync

fsck.dumpfs

#!/bin/sh
true

Each dumpfs partition can be mounted with option poll or nopoll, the default is
poll.  Poll uses low level polled mode I/O direct to the partition, completely
bypassing the normal interrupt driven code.  This is done in an attempt to get
the data out to disk even when the kernel is so badly broken that interrupts are
not working.  Poll requires that the device driver for the dumpfs partition
supports polling mode I/O.  Nopoll uses the standard kernel I/O mechanisms, so
it is not guaranteed to work when the kernel is crashing.  Nopoll should only be
used when your device driver does not support polling mode I/O yet; you must
accept that dumpfs may hang waiting for the I/O to be serviced.

Another option when mounting a dumpfs partition is to specify the size of its
data buffer, in kibibytes.  This buffer is permanently allocated as long as the
dumpfs partition is mounted, it is only used when writing RAS data via dumpfs.
The buffer size will be rounded up to a multiple of the kernel page size.  The
default is buffer=128.


The user space view of the RAS data held in the dumpfs partitions is created by
"mount -t dumpfs_user none /mnt/dumpfs".  It logically merges and validates all
the dumpfs partitions that have been mounted and provides a user space view of
the files that have been written to dumpfs.  The only user space operations
supported on dumpfs_user are llseek, read, readdir, open (read only), close and
unlink.  Just enough to copy the files out of dumpfs_user and remove them.  User
space cannot write to dumpfs_user.

The kernel can write to files held in dumpfs partitions, to save RAS data over a
reboot.  Note that when kernel RAS components write to dumpfs they do _not_ use
the normal VFS layer, it may not be working during a failure.  Instead a RAS
component makes direct calls to the following dumpfs_kernel functions.

dumpfs_kernel_open("prefix", flags)

  Create and open for writing a file in dumpfs.  It returns a file descriptor
  within dumpfs.

  The dumpfs filename is constructed from "prefix-" followed by the value of
  xtime in the format CCYY-MM-DD-hh:mm:ss.n, where n starts at 0 and is
  incremented for each dumpfs file in the current boot.

  There is no requirement that a dumpfs_user mount point exist before the kernel
  can dump its data.  The first call to dumpfs_kernel_open will automatically
  create a kernel view that merges all the mounted dumpfs partitions.  The first
  call to dumpfs_kernel_open also writes the dumpfs superblocks to any shared
  partitions.

  Flags select compression, if any.

  dumpfs_kernel_open() is the simple interface.  It automatically stripes the
  data across all dumpfs partitions that are not currently being used.

  Most RAS code will open one dump file at a time, mainly because most users
  will only have one dumpfs partition.  The dumpfs code has a module_parm called
  dumpfs_max_open, with a default value of 1.

dumpfs_kernel_bdev_list()
dumpfs_kernel_open_choose("prefix", flags, bdev_list)

  Some platforms may need to have multiple output streams open in parallel.  For
  example a system with large amounts of memory and multiple disks may wish to
  assign different sections of memory to each cpu and to write to separate
  partitions.

  dumpfs_kernel_bdev_list() returns the list of usable dumpfs partitions.  If
  all partitions are in use then the list is empty.

  dumpfs_kernel_open_choose() opens a file using only the selected bdev entries.

  Systems that use concurrent parallel dumps should set module_parm
  dumpfs_max_open to a suitable value.

  Note: The following problems are inherently architecture and platform specific
  and are outside the scope of dumpfs.  That is not to say that we should not
  have an API for handling these problems on large systems, but it would be a
  separate API from dumpfs.

    Deciding which cpus to use for parallel dumping.
    Deciding which block devices each cpu should use.
    Getting the chosen cpus into the RAS code.
    Assigning the range of work to each cpu and each partition.
    Watching the dumping cpus for problems, recovering from those problems
      and reassigning the work to another cpu.
    Reconstructing the parallel dumps into a format for analysis.  dumpfs_user
      makes each dump file available to user space, but some code may be
      required to merge the separate files together.

dumpfs_kernel_close(fd)

  Sync the file's data to disk, close the file and update the dumpfs metadata.

dumpfs_kernel_write(fd, buffer, length)

  Write the buffer at the current dumpfs file location.  The data may or may not
  be written to disk immediately.  It returns the current location, including
  the data that was just written.

  For performance, the dumpfs data is striped over all the assigned partitions,
  in round robin.  The stripe unit is the minimum of the buffer= value across
  all the assigned partitions.

dumpfs_kernel_read(fd, buffer, length)

  Read the buffer from the current dumpfs file location.  It returns the current
  location, including the data that was just read.

dumpfs_kernel_llseek(fd, position)

  Set the current dumpfs file location.  It returns the previous location.  Only
  absolute seeking is supported.

dumpfs_kernel_sync(fd)

  Sync the file's data to disk and update the dumpfs metadata.

dumpfs_kernel_dirty_shared()

  Returns true if any shared partitions have been dirtied, in which case the
  kernel must be rebooted after all the RAS components have completed their
  work.

dumpfs_kernel_all_polled()

  Returns true if all dumpfs partitions can support polling mode I/O.  Otherwise
  the RAS code that calls dumpfs should enable interrupts, if at all possible.


Sample /etc/fstab entries for dumpfs partitions.

  /dev/sda2  /mnt/dumpfs  dumpfs  defaults  0 0
  /dev/sdb2  /mnt/dumpfs  dumpfs  share     0 0
  /dev/sdc7  /mnt/dumpfs  dumpfs  nopoll    0 0

Sample code in /etc/rc.sysinit to save dump data from the previous boot.  If you
are sharing dumpfs with swap, these commands must be executed before mounting
swap.  Note that dumpfs does not require any special user space tools to poke
inside partitions to see if there is any useful data to save, everything is a
file.

  # mount all the dumpfs partitions
  mount -a -t dumpfs
  # merge all dumpfs into dumpfs_user on /mnt/dump
  mount -t dumpfs_user none /mnt/dump
  # copy the data out
  (cd /mnt/dump; for f in `find -type f`; do echo saving $f; mv $f /var/log/dump; done)
  # drop dumpfs_user
  umount /mnt/dump
  # clear all the dumpfs metadata
  umount -a -t dumpfs
  mount -a -t dumpfs -o clear
  umount -a -t dumpfs

rc.sysinit will later mount the swap partitions, then mount all the other
partition types.  That will remount the dumpfs partitions, ready for the next
kernel crash.

