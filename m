Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVAGSxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVAGSxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVAGSxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:53:21 -0500
Received: from alog0205.analogic.com ([208.224.220.220]:6528 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261382AbVAGSxL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:53:11 -0500
Date: Fri, 7 Jan 2005 13:53:04 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Shakthi Kannan <shakstux@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount PCI-express RAM memory as block device
In-Reply-To: <20050107183645.72411.qmail@web54501.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0501071342290.21110@chaos.analogic.com>
References: <20050107183645.72411.qmail@web54501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Shakthi Kannan wrote:

> Greetings!
>
> I would like to know as to how we can mount a
> filesystem for RAM memory on a PCI-express card.
> System for development is x86 with 2.4.22 kernel.
>
> I, initially wrote a ramdisk driver to read/write data
> between buffer and RAM. Here, I have used:
> device->data = vmalloc (device->size);
> where:
> - device is the device driver structure variable
> - data = unsigned char *
> - size = unsigned int
>
> I am able to load the above block driver and mount a
> filesystem using:
> dd if=/dev/zero of=/dev/sbull bs=1k count=64
> mkdir /mnt/mysbull
> mke2fs -vm0 /dev/sbull 64
> mount /dev/sbull /mnt/mysbull
>
> For PCI device driver, I have modifed the above to
> directly ioremap device->data as follows:
> device->data = ioremap_nocache (BASE_ADDRESS,
> BASE_SIZE);
> Have successfully done:
> dd if=/dev/zero of=/dev/sbull bs=1k count=64
> mkdir /mnt/mysbull
> mke2fs -vm0 /dev/sbull 64
>
> But, when I proceed to mount a filesystem, it fails.
> mount /dev/sbull /mnt/mysbull
>
> mount:error while guessing filesystem type
> mount: you must specify the filesystem type
>
> Also, if I give "fsck -v /dev/sbull", it returns with
> improper filesystem super block. Even if I specify "-t
> ext2" for mount, it fails. I even tried a
> loopback device mount, but it fails too:
> mount -o loop /dev/sbull /mnt/mysbull
>
> FAT: bogus logical sector size 0
> VFS: Can't find a valid FAT filesystem on dev FA:00
>
> How can I map the RAM memory on the PCI card, even
> though I don't allocate any memory (during ioremap)
> and display that to the end user as a mounted
> filesystem so that he/she can read/write files to it?
>
> Any help/pointers to links is appreciated.
>
> Thanks,
>
> K Shakthi
>

When you ioremap() in the kernel, you get a cookie that you
can use (in the kernel) to copy data to and from the device.

This doesn't allow a user to copy data directly. Instead,
in your read() and write() routines, you use the appropriate
copy_to/from_user() routines. If the device is not a
block device, then you will have to mount it through the
loop device. If it is a block device, you can mount it
directly after initialization.

>From your explanation, it looks like the BASE_ADDRESS is not
the device's on-board memory, but instead, its control
registers, i.e., a simple implementation bug.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
