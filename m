Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbUCESJU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCESJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:09:20 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:55791 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262096AbUCESJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:09:11 -0500
Message-ID: <4048C245.7060009@mvista.com>
Date: Fri, 05 Mar 2004 10:09:09 -0800
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
References: <40462AA1.7010807@mvista.com>
In-Reply-To: <40462AA1.7010807@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steve Longerbeam wrote:

> An intro to PRAMFS along with a technical specification
> is at the SourceForge project web page at
> http://pramfs.sourceforge.net/. A patch for 2.6.3 has
> been released at the SF project site. 


A new patch for 2.6.4 is available, but it and the 2.6.3 patch
are each ~2900 lines, so I won't post here. But here's the intro:


PRAMFS Overview
===============
                                                                                

Many embedded systems have a block of non-volatile RAM seperate from
normal system memory, i.e. of which the kernel maintains no memory page
descriptors. For such systems it would be beneficial to mount a
fast read/write filesystem over this "I/O memory", for storing frequently
accessed data that must survive system reboots and power cycles. An
example usage might be system logs under /var/log, or a user address
book in a cell phone or PDA.
                                                                                

Currently Linux has no support for a persistent, non-volatile RAM-based
filesystem, persistent meaning the filesystem survives a system reboot
or power cycle intact. The current RAM-based filesystems such as tmpfs
and ramfs have no actual backing store but exist entirely in the page and
buffer caches, hence the filesystem disappears after a system reboot or
power cycle.
                                                                                

A relatively straight-forward solution is to write a simple block driver
for the non-volatile RAM, and mount over it any disk-based filesystem such
as ext2/ext3, reiserfs, etc.
                                                                                

But the disk-based fs over non-volatile RAM block driver approach has
some drawbacks:
                                                                                

1. Disk-based filesystems such as ext2/ext3 were designed for optimum
   performance on spinning disk media, so they implement features such
   as block groups, which attempts to group inode data into a contiguous
   set of data blocks to minimize disk seeking when accessing files. For
   RAM there is no such concern; a file's data blocks can be scattered
   throughout the media with no access speed penalty at all. So block
   groups in a filesystem mounted over RAM just adds unnecessary
   complexity. A better approach is to use a filesystem specifically
   tailored to RAM media which does away with these disk-based features.
   This increases the efficient use of space on the media, i.e. more
   space is dedicated to actual file data storage and less to meta-data
   needed to maintain that file data.
                                                                                

2. If the backing-store RAM is comparable in access speed to system memory,
   there's really no point in caching the file I/O data in the page
   cache. Better to move file data directly between the user buffers
   and the backing store RAM, i.e. use direct I/O. This prevents the
   unnecessary populating of the page cache with dirty pages. However
   direct I/O has to be enabled at every file open. To enable direct
   I/O at all times for all regular files requires either that
   applications be modified to include the O_DIRECT flag on all file
   opens, or that a new filesystem be used that always performs direct
   I/O by default.
                                                                                

The Persistent/Protected RAM Special Filesystem (PRAMFS) is a
full-featured read/write filesystem that has been designed to address
these issues. PRAMFS is targeted to fast I/O memory, and if the memory
is non-volatile, the filesystem will be persistent.
                                                                                

In PRAMFS, direct I/O is enabled across all files in the filesystem, in
other words the O_DIRECT flag is forced on every open of a PRAMFS file.
Also, file I/O in the PRAMFS is always synchronous. There is no need
to block the current process while the transfer to/from the PRAMFS
is in progress, since one of the requirements of the PRAMFS is that the
filesystem exist in fast RAM. So file I/O in PRAMFS is always direct,
synchronous, and never blocks.
                                                                                

The data organization in PRAMFS can be thought of as an extremely
simplified version of ext2, such that the ratio of data to meta-data is
very high.
                                                                                

PRAMFS is also write protected. The page table entries that map the
backing-store RAM are normally marked read-only. Write operations into
the filesystem temporarily mark the affected pages as writeable, the
write operation is carried out with locks held, and then the pte is
marked read-only again. This feature provides some protection against
filesystem corruption caused by errant writes into the RAM due to
kernel bugs for instance. In case there are systems where the write
protection is not possible (for instance the RAM cannot be mapped
with page tables), this feature can be disabled with the
CONFIG_PRAMFS_NOWP config option.
                                                                                

In summary, PRAMFS is a light-weight, full-featured, and space-efficient
special filesystem that is ideal for systems with a block of fast
non-volatile RAM that need to access data on it using a standard
filesytem interface.

Supported mount options
=======================
                                                                                

The PRAMFS currently requires one mount option, and there are several
optional mount options:
                                                                                

physaddr=       Required. It tells PRAMFS the physical address of the
                start of the RAM that makes up the filesystem. The
                physical address must be located on a page boundary.
                                                                                

init=           Optional. It is used to initialize the memory to an
                empty filesystem. Any data in an existing filesystem
                will be lost if this option is given. The parameter to
                "init=" is the RAM size in bytes.
                                                                                

bs=             Optional. It is used to specify a block size. It is
                ignored if the "init=" option is not specified, since
                otherwise the block size is read from the PRAMFS
                super-block. The default blocksize is 2048 bytes,
                and the allowed block sizes are 512, 1024, 2048, and
                4096.
                                                                                

bpi=            Optional. It is used to specify the bytes per inode
                ratio, i.e. For every N bytes in the filesystem, an
                inode will be created. This behaves the same as the "-i"
                option to mke2fs. It is ignored if the "init=" option is
                not specified.
                                                                                

N=              Optional. It is used to specify the number of inodes to
                allocate in the inode table. If the option is not
                specified, the bytes-per-inode ratio is used the
                calculate the number of inodes. If neither the "N=" or
                "bpi=" options are specified, the default behavior is to
                reserve 5% of the total space in the filesystem for the
                inode table. This option behaves the same as the "-N"
                option to mke2fs. It is ignored if the "init=" option is
                not specified.

Examples:
                                                                                

mount -t pramfs -o physaddr=0x20000000,init=0x2F000,bs=1024 none /mnt/pram
                                                                                

This example locates the filesystem at physical address 0x20000000, and
also requests an empty filesystem be initialized, of total size 0x2f000
bytes and blocksize 1024. The mount point is /mnt/pram.
                                                                                

mount -t pramfs -o physaddr=0x20000000 none /mnt/pram
                                                                                

This example locates the filesystem at physical address 0x20000000 as in
the first example, but uses the intact filesystem that already exists.


