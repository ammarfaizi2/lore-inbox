Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbQLSSRO>; Tue, 19 Dec 2000 13:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQLSSRF>; Tue, 19 Dec 2000 13:17:05 -0500
Received: from hera.cwi.nl ([192.16.191.1]:52911 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129778AbQLSSQp>;
	Tue, 19 Dec 2000 13:16:45 -0500
Date: Tue, 19 Dec 2000 18:45:42 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: [PATCH] ident of whole-disk ext2 fs
Message-ID: <20001219184542.A367@veritas.com>
In-Reply-To: <3A3F42FC.4E341732@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A3F42FC.4E341732@yahoo.com>; from p_gortmaker@yahoo.com on Tue, Dec 19, 2000 at 06:14:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 06:14:04AM -0500, Paul Gortmaker wrote:

> I always disliked the unknown partition table messages you get when you
> mke2fs a whole disk and don't bother with a table at all, so I fixed it.
> Output before/after shown below:
> 
>  Partition check:
>   hda: hda1 hda2
> - hdd: unknown partition table
> + hdd: whole disk EXT2-fs, revision 1.0, 1k blocks, status: clean.

A nice boot message.

But what if you just replace the "unknown partition table"
by the more correct "no recognized partition table"?


> +static int ext2_partition(struct gendisk *hd, ...

I don't like the patch very much. It is too ad hoc.
Why ext2? Not ext3? reiser? ufs?

At boot time, the kernel needs 6 pieces of information:
- the rootdevice
- the partitiontype of the rootdevice
- the rootpartition
- the filesystemtype of the root filesystem
- the remaining mount options for the root filesystem
- the first program to start

We can make the kernel guess, or we can specify.
The usual situation is that we specify rootdevice and rootpartition
and mount options like ro/rw or nfsaddr and perhaps the init program,
but make the kernel guess partitiontype and rootfstype.

It would be good to at least have the possibility to specify
partitiontype and rootfstype. In the course of time several
people have submitted patches adding a "rootfstype=" boot option.
Today or so Tigran did this again - maybe Linus accepts it this time.

Remains the partitiontype. You remind us of the fact that a good
partitiontype is "none". And then there are "dos", "bsd", "atari", ...
And recursive ones: a dos-type partition further sliced up into
bsd-type partitions, etc.
So, I can imagine two useful boot options here:
(i) "root_partition_type=", and
(ii) "do_not_parse_partition_tables"
(you may invent shorter forms if you prefer).
Since it is possible to parse partition tables from user space
and tell the kernel which disk regions should be considered
partitions, there is no need for the kernel to do this parsing,
except for the rootdevice, just like there is no need for the
kernel to do any mounting except for the root filesystem.
(And one could have /etc/pttab as analogue of /etc/fstab.)
The second option would tell the kernel to leave the disks alone,
except for the rootdevice; the first option would tell the kernel
what partition table type to expect there.

There is no hurry, but sooner or later it would be good to
get rid of all partition table parsing in the kernel.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
