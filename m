Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbTLROQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbTLROQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:16:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:61060 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265182AbTLROQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:16:08 -0500
Date: Thu, 18 Dec 2003 09:17:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: jshankar <jshankar@CS.ColoState.EDU>
cc: Mike Fedyk <mfedyk@matchmail.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: ext3 file system
In-Reply-To: <3FF18FD8@webmail.colostate.edu>
Message-ID: <Pine.LNX.4.53.0312180831560.2348@chaos>
References: <3FF18FD8@webmail.colostate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, jshankar wrote:

> Hello,
>
> Please provide some more insight.
>
> Suppose a filesystem issues a write command to the disk with around 10 4K
> Blocks  to be written. SCSI device point of view i don't get what is the
> parallel I/O.
> It has only 1 write command. If some other sends a write request it needs to
> be queued. But the next question arises how the write data would be handled.
> Does it mean the SCSI does not give a response for the block of data written.
> In otherwords does it mean that the response would be given after all the
> block of data is written for a single write request.
>
> Thanks
> Jay


I guess you completely misunderstand. Any I/O to the physical devices
are completely asynchronous. There is no relationship between when
an application writes a buffer of data to a file, and when it gets
written to the physical media. This includes the device-file,
i.e., the raw device with no file-system.

What is implemented is called VFS (Virtual File System). It is
a RAM-Disk with all user data going to and from the RAM-Disk.

In principle, many temporary files never even get written to
the physical device. They are created, written, read, then
deleted long before there is any reason to write to the physical
media. Writing to physical media is a performance bottle-neck.

Eventually, the supply of kernel buffers used to keep the
file-system data might get short. When it does, the kernel
writes (through the drivers) data to the devices using a
LRU (least recently used) algorithm. This write also is
asynchronous. It gets handed-off to a SCSI, or IDE, or whatever,
driver which should eventually get the data into the drives.

In the meantime, the devices may time-out, there may be errors
that require the writes to be retried, etc. Eventually the
operating system will be notified that a write succeeded so
that particular amount of RAM containing the data can be
freed.

Even if there are errors, a subsequent read of the data, which
comes from RAM will succeed. It is only after that data gets
to the drive that subsequent reads may require the data to be
re-read from the drive.

All this work executes in parallel with the work of the
application software. Notification of the success or failure
of a particular operation is handled in the drivers using
an interrupt. With common SCSI controllers, data are transferred
using Bus-Master DMA so the CPU continues handling user and
kernel code while the DMA is occurring. The CPU is not locked-
off the bus during DMA so there is additional parallelism
under these conditions.

At the SCSI device-driver level, typically a data block is
built that tells the SCSI controller all it needs to know
about the transfer. The controller is then "told" to execute
the command. The success or failure of the command is determined
by some status read in an interrupt. The controller does whatever
it needs to do, to get the data to the drive without using
the CPU at all. This means that the CPU can be executing code
(doing useful work) in parallel with the data transfer.

You can force the file-systems to write their data to the
physical media by executing sync(). This is not a good thing
to do very often if you expect any reasonable performance.

The only time all the data gets to the drive(s) is when they
are dismounted (umount). This gets all the data into the drives
and severs the logical connection between your applications and
the file-systems that you just dismounted.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


