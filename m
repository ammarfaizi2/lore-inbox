Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263129AbSJBQMR>; Wed, 2 Oct 2002 12:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbSJBQMR>; Wed, 2 Oct 2002 12:12:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263129AbSJBQMO>;
	Wed, 2 Oct 2002 12:12:14 -0400
Date: Wed, 2 Oct 2002 09:17:00 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Vincent Hanquez <tab@tuxfamily.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ext3 documentation
In-Reply-To: <20021002085713.GA23086@darwin.crans.org>
Message-ID: <Pine.LNX.4.33L2.0210020915400.14122-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, Vincent Hanquez wrote:

| Here a (small) documentation for ext3 filesystem.
| it seem now correct/accurate. report me any problem/bugs
|
| It can be merge in 2.4/2.5 kernel I think. feedback appreciated.

Here are a few typo corrections for you.  My correction lines
begin with '#'.

Regards,
-- 
~Randy






Ext3 Filesystem
===============

ext3 was originally released in September 1999. Written by Stephen Tweedie
for 2.2 branch, and ported to 2.4 kernels by Peter Braam, Andreas Dilger,
Andrew Morton, Alexander Viro, Ted Ts'o and Stephen Tweedie.

ext3 is ext2 filesystem enhanced with journalling capabilities.
#                                     journaling
#to be consistent.

Options
=======

When mounting an ext3 filesystem, the following option are accepted:
(*) == default

jounal=update		Update the ext3 file system's journal to the
			current format.

journal=inum		When a journal already exists, this option is
			ignored. Otherwise, it specifies the number of
			the inode which will represent the ext3 file
			system's journal file.

bsddf 		(*)	Make 'df' act like BSD.
minixdf			Make 'df' act like Minix.

check=none		Don't do extra checking of bitmaps on mount.
nocheck

debug			Extra debugging information is sent to syslog.

noload			Don't load the journal on mounting.

errors=remount-ro(*)	Remount the filesystem read-only on an error.
errors=continue		Keep going on a filesystem error.
errors=panic		Panic and halt the machine if an error occurs.

grpid			Give objects the same group ID as their creator.
bsdgroups

nogrpid		(*)	New objects have the group ID of their creator.
sysvgroups

resgid=n		The group ID which may use the reserved blocks.

resuid=n		The user ID which may use the reserved blocks.

sb=n			Use alternate superblock at this location.

data=journal		All data are commited into the journal prior
#                                    committed
			to being written into the main file system.

data=ordered	(*)	All data are forced directly out to the main file
			system prior to its metadata being commited to
#                                                          committed
			the journal.

data=writeback  	Data ordering is not preserved, data may be
			written into the main file system after its
			metadata has been committed to the journal.

quota			Quota options are currently silently ignored.
noquota			(see fs/ext3/super.c, line 594)
grpquota
usrquota


Specification
=============
ext3 shares all disk implementation with ext2 filesystem, and add
transactions capabilities to ext2.
Journaling is done by the Journaling block device layer.

Journaling Block Device layer
-----------------------------
The Journaling Block Device layer (JBD) isn't ext3 specific. It was design
#                                                                   designed
to add journaling capabilities on a block device.
The ext3 filesystem code will inform the JBD of modifications it is
performing (Call a transaction). the journal support the transactions start
#          (called a transaction). The journal supports
and stop, and in case of crash, the journal can replayed the transactions
#                                               replay
to put the partition on a consistant state fastly.
#  restore           to a consistent state quickly.

handles represent a single atomic update to a filesystem.
JBD can handle external journal on a block device.

Data Mode
---------
There's 3 different data modes:
#There are 3...

* writeback mode
In data=writeback mode, ext3 doesn't do any form of data journaling at
all (as XFS, JFS, and ReiserFS).
Despite the fact it could corrupt recently modified file, this
#Despite the fact that it...
mode should give you in general the best ext3 performance.

* ordered mode
In data=ordered mode, ext3 only officially journals metadata, but it
logically groups metadata and data blocks into a single unit called a
transaction. When it's time to write the new metadata out to disk, the
associated data blocks are written first.
In general, this mode perform slightly slower than writeback
but significantly faster than journal mode.

* journal mode
data=journal mode provides full data and metadata journaling. All new data
is written to the journal first, and then to its final location.
In the event of a crash, the journal can be replayed, bringing both data
and metadata into a consistent state.
This mode is the slowest except when data needs to be read from and
written to disk at the same time where it outperform all others mode.
#                                        ^may(?)         other modes.

Compatibility
-------------
Ext2 partition can be easily convert to ext3, with `tune2fs -j <dev>`.
#                            converted
Ext3 is fully compatible with Ext2. Ext3 partition can easily be mounted
as Ext2.

Quota
=====
Quota implementation for ext3 is available in -ac tree for 2.4.
There is no implementation for 2.5 yet.

External Tools
==============
see manual pages to know more.

tune2fs: 	create a ext3 journal on a ext2 partition with the -j flags
#                                                                     flag
mke2fs: 	create a ext3 partition with the -j flags
#                                                   flag
debugfs: 	ext2 and ext3 file system debugger

References
==========

kernel source:	file:/usr/src/linux/fs/ext3
		file:/usr/src/linux/fs/jbd

programs: 	http://e2fsprogs.sourceforge.net

useful link:
#      links:
		http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html
		http://www-106.ibm.com/developerworks/linux/library/l-fs7/
		http://www-106.ibm.com/developerworks/linux/library/l-fs8/

