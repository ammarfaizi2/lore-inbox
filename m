Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSH0Xio>; Tue, 27 Aug 2002 19:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSH0Xio>; Tue, 27 Aug 2002 19:38:44 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:65475 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317399AbSH0Xim>; Tue, 27 Aug 2002 19:38:42 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 27 Aug 2002 16:42:56 -0700
Message-Id: <200208272342.QAA05414@adam.yggdrasil.com>
To: hch@infradead.org
Subject: Re: Loop devices under NTFS
Cc: aia21@cantab.net, kernel@bonin.ca, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Aug 27, 2002 at 06:53:19AM -0700, Adam J. Richter wrote:
>> 	Why?
>> 
>> 	According to linux-2.5.31/Documentation/Locking,
>> "->prepare_write(), ->commit_write(), ->sync_page() and ->readpage()
>> may be called from the request handler (/dev/loop)."

>Just because it's present in current code it doesn't mean it's right.
>Calling aops directly from generic code is a layering violation and
>it will not survive 2.5.

	Only according your own proclamation.  You are arguing
circular logic, and I am aruging a concrete benefit: we can avoid an
extra copying of all data in the input and output paths going through
an encrypted device.  While I don't have a benchmark to show you (and
the burden of proof is upon you since you want a change), an extra
copying of all data going through a potentially high throughput
service (like, say, all of your file systems if you're running an
encryptd disk), is likely to have a substantial performance impact.
There is a real world benefit at stake here of making strong
encryption as "cheap" to use as as possible.


>> 	Using the page cache in loop.c saves a copy when there is a
>> data transformation (such as encryption) involved, and that can be
>> important for reducing the cost of privacy.

>Separating a stackalbe encryption block device from the loop driver is
>a good idea.  The current loop code is a horrible mess because it tries
>to do the job of three drivers in one.

	Just saying "good idea" is no substitute for an argument about
real world benefits, like performance, code footprint, etc.

	Granted, loop.c is more complex than I would like it to be,
but other changes elsewhere in the kernel that I'd like to see would
make the same or better simplifications in loop.c without introducing
extra data copy in the critical path:

	1. If every writable plain file had aops->{prepare,commit}_write,		   I could delete the file_ops->{read,write} transfer mode from
	   loop.c.

	2. At some point, lvm2 device mapper will hopefully be merged
	   into the kernel.  This will allow pushing drivers/md,
	   drivers/ide/*raid*.[ch], and even disk partitioning out of
	   the kernel to raidtools and partx.  Device Mapper supports
	   data transformations in order to do RAID parity sectors.
	   This duplication between loop.c and lvm2 could be
	   eliminated by making a cryptoapi lvm2 plugin, and porting
	   the code to the device mapper to map files to devices.
	   That would also allow users to do things like RAID across
	   files on different remote file systems (so you don't need
	   to convince a central administration to reallocate space on
	   file servers to run nbd).


>> >Depending on the filesystem implementation _anything_ may happen.
>> >With current intree filesystems the only real life problem is that
>> >it doesn't work on certain filesystems.
>> 
>> 	Sorry for repeating myself here: If you're referring to the
>> stock loop.c not working with tmpfs because tmpfs lacks
>> {prepare,commit}_write which my patch works around (based on Jari's
>> patch before mine, and a patch by Andrew Morton as well).  I have yet
>> to hear a clear reason why any writable plain file on any given file
>> system could not have {prepare,commit}_write operations available.

>No, tmpfs also does not use generic_file_read but a sligh variation,
>calling do_generic_file_read on tmpfs inodes will not always works as
>expected.  Don't do it.

	Your first sentence is not a clear reason why tmpfs cannot
provide {prepare,commit}_write, and your second sentence ("Don't do
it.") is not a reason.


>> 	Please come up with a clear example.  I'm not asking you for a
>> test case that can produce it, just some narrative of the problem
>> occurring.

>loop on nfs, do_generic_file_read is called without the needed 
>nfs_revalidate_inode, thus i_size is outdated, and loop might happily
>read out of the filesize.

>> 	I am aware that you can get races if someone mounts a loop
>> device while accessing the underlying file by some other mechanism,
>> but I believe that the only case where that would be done in practice
>> is to change the encryption of a device, and, because of the read and
>> write patterns involved in that, it should not be a problem.

>This is true for filesystems like nfs (above) that only revalidate and then
>call generic_file_read.  For totally different implementations anything can
>happen.  Even if it mostly works it's not the kind of design we want to have
>in the kernel.

	I have to say I haven't see much documentation of
address_space_operations aside from the code, and a few pages about
the page cache in _Understanding The Linux Kernel_.  However, if you
believe that loop.c is relying on some guarantee that aops does not
officially provide but all of its implementations currently abide by,
then simply documenting that guarantee as "official" would result in a
kerenl that is lives within its guarantees and yet has faster performance
for software encrypted block devices.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
