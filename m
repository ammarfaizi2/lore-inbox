Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUBIMht (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265117AbUBIMht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:37:49 -0500
Received: from [217.157.19.70] ([217.157.19.70]:13072 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S265111AbUBIMh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:37:27 -0500
Date: Mon, 9 Feb 2004 12:37:25 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.)
 BIOS RAID development
In-Reply-To: <20040209121144.GA24503@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.40.0402091220130.8715-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Arjan van de Ven wrote:

> On Mon, Feb 09, 2004 at 12:01:55PM +0000, Thomas Horsten wrote:
> > Ideally I'd want something like the MD autodetect code, so that the whole
> > thing can be set up by the kernel at boot-time if the necessary drivers
> > are compiled in (by reading the Medley superblock the same way it's done
> > for 0xfe partitions).
>
> I (and I suspect a lot of other folks) rather get rid of such autodetect and
> move it to userspace. Either via initrd or initramfs.

The question is, where do we draw the line between kernel and userspace
setup of devices. For example, why is the frame buffer device detected in
the kernel, it could just as well be done in the initrd.

My gut feeling is that if it is provided by the BIOS and reliable
autodetection is possible, it should be autodetected. Why require the user
to discover and supply information that the kernel could easily and
reliably find out by itself? Besides, if there is no autodetection, the
drive will come up with an invalid partition table (since the partition
tables for these arrays are stored as the first block of the first disk in
the array). If there is an extended partition, the kernel may try to read
past the end of the disk, causing a lot of spurious error messages that
confuse the user.

If the user tries to mount any of these partitions, or edit the partition
table, they will probably corrupt the disk.

What I have in mind currently is a solution that uses the md and dm
frameworks. Basically an option that adds support for reading and parsing
the Medley superblock, and create an md raiddev based on it (using the
standard RAID0/RAID1 personalities). Then a dm drive needs to be
registered, to support the partition table on the whole disk array.

For the autodetection to work, when compiled into the kernel I would put a
call into gendisk.c, just before it calls add_disk to parse the partition
table. That way, if the Medley superblock is detected it will not try to
parse the partition table.

The only thing I don't like about this solution is that we are relying on
both the md and dm framework. I can't see an easy way around this, since
we need to parse the partition table on the RAID. If we just create a
separate md device for each partition, the user won't be able to change
the partition table.

> > Having autodetection at kernel level would make it possible to boot from a
> > kernel on a floppy disk without initrd support, and in general make a
> > system easier to set up.
>
> initrd/initramfs is increasingly becoming mandatory sort of, and it's
> actually easy if not even default to set up. (Eg on Fedora / Red Hat even
> just typing make install will auto-create this for you)

It's sort of mandatory for generic systems like distro installer disks,
livecd's etc. But I've never needed to use it on any of my own systems
after I compile a cutom kernel. I guess a lot of people are like me, and
prefer to keep it simple with the essential drivers to get my specific
system running compiled in, and the rest as modules.

> > But the reason I wanted this discussion is to figure out the best way to
> > go about it, and if there are some good arguments against autodetecting in
> > the kernel I'll listen to them.
>
> It doesn't really belong there.

But where to draw the line?

I think if it can be implemented cleanly (as cleanly as the current md
detection at least), and if it can be nearly 100% reliable, it doesn't add
much complexity to the kernel and removes a lot from userspace.

// Thomas

