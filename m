Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUGNHiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUGNHiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 03:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUGNHiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 03:38:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:4795 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265649AbUGNHiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 03:38:08 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Takao Indoh <indou.takao@soft.fujitsu.com>,
       lkcd-devel@lists.sourceforge.net
Reply-To: linux-kernel@vger.kernel.org
Subject: [RFC] Standard filesystem types for crash dumping
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Jul 2004 17:37:43 +1000
Message-ID: <11077.1089790663@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Follow ups to lkml please, to keep any discussion on the same list.

Several kernel additions exist for saving crash dump information, among
them are lkcd, crash, kmsgdump.  They all have the same problems :-

* Where to store the crash data.
* How to write data when the kernel is unreliable, it may not be
  servicing interrupts.
* User space needs to read and clear the dump data.
* Performance!
* Coexistence of multiple dump drivers.

This RFC proposes a common interface to handle the above points.  In
the true Unix way (everything is a file), it adds two new filesystem
types, dump_0 and dump_1.

Each partition to be used for dump data is mounted as type dump_0.  The
list of mounted dump_0 partitions automatically tells the kernel where
to store the dump data.  No need for special proc/sysfs entries or
extra ioctls.  Fully extensible, it can handle any number of dump
partitions.

Often the swap partition is overloaded as the dump device.  To support
this, fstype dump_0 only writes its superblock when a dump is being
taken, allowing the partition to be used for other data (e.g. swap) as
long as the kernel is still working.  The superblock is written at an
offset past the swap header.

/etc/fstab has one line per dump_0 partition

  /dev/sda2       none    dump_0  defaults 0 0
  /dev/sdb7       none    dump_0  defaults 0 0

All partitions mounted as dump_0 should support polled mode disk I/O,
so the dump can be taken even when interrupts are not working.  The
polling methods used by Takao Indoh in the diskdump patches below are a
good starting point.  They add device operations such as
dump_sanity_check and dump_poll.  In the current diskdump patches,
these operations are tied too tightly to the specific needs of the
crash code, this RFC moves the polled I/O code and the selection of the
dump partitions to the dump_0 fstype, so they are available to all dump
code.

http://marc.theaimsgroup.com/?l=linux-kernel&m=108935733702127&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=108935788223895&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=108935810612335&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=108935810500510&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=108935826502978&w=2

One option to fstype dump_0 is poll=.  poll=1 means that the driver
must support polling, this is the default.  poll=0 means that the
partition can still be used even if the driver does not have polling
methods, with no guarantees that this will work for every crash, it may
hang if interrupts are not being serviced.

Another dump_0 option is clear.  "mount -a -t dump_0 -o clear" clears
all the dump_0 superblocks.  This removes any ambiguity about old dump
data when the partition is being shared with swap.  Only the dump_0
superblock is cleared, the rest of the partition is preserved,
including the swap signature.


Fstype dump_1 is the interface to user space to read and clear the dump
information.  dump_1 can only be mounted once.  It locates all the
mounted dump_0 partitions that contain a valid dump_0 superblock and
logically merges them together.  User space sees a single dump_1
directory with one file for each dump.  Those files can only be read or
unlinked; rename, mkdir and write are not supported operations.  The
dump_1 directory is empty if no dump_0 superblocks exist or they exist
but contain no useful data.

When a kernel dump component such as lkcd, crash or kmsgdump wants to
write its data, it asks the dump_1 code to create a file.  Then the
dump component writes to that file.  The name of the file and its
contents are determined by the dump component, dump_1 just writes the
data to the dump_0 partitions.  "Everything is a file" allows all the
kernel dump components to coexist, each writes to its own logical file
which dump_1 then makes available to user space.

To simplify the allocation algorithms, only one dump_1 file at a time
can be opened and written to by the kernel.  Not a problem, during a
dump the system is already single threading.

For performance, each block written to or read from dump_1 is striped
over the underlying dump_0 partitions in round robin fashion.  The
striping is hidden from the kernel dump code and the user space code
that reads and clears the dumps, both just see files.

Typical user space code to extract and clear all dump data.

  mount -a -t dump_0
  mount -t dump_1 none /dump
  (cd /dump; for f in `find -type f`; do mv $f /var/log/dump; done)
  umount /dump
  umount -a -t dump_0
  mount -a -t dump_0 -o clear
  umount -a -t dump_0
  ....
  mount -a -t swap

No special utilities to search partitions for dump data.  No special
proc or sysfs entries to define the dump partitions.  All the code for
writing to disk from the kernel (including polling mode) is
encapsulated in the dump_0 and dump_1 code.  The kernel dump components
can just concentrate on their own data, instead of each one reinventing
the wheel to get its data out.

