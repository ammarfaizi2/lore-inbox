Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135912AbRDZUor>; Thu, 26 Apr 2001 16:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135909AbRDZUoh>; Thu, 26 Apr 2001 16:44:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:62336 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135912AbRDZUoX>; Thu, 26 Apr 2001 16:44:23 -0400
Date: Thu, 26 Apr 2001 16:42:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alexander Viro <viro@math.psu.edu>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <Pine.GSO.4.21.0104261530370.15385-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.95.1010426163144.20158A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Alexander Viro wrote:

> 
> 
> On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> 
> > > the wait-on-buffer is not strictly necessary: it's probably there to make
> > 
> > maybe not but I need to check some more bit to be sure.
> 
> Same scenario, but with read-in-progress started before we do getblk(). BTW,
> old writeback is harmless - we will overwrite anyway. And _that_ can happen
> without direct access to device - truncate() doesn't terminate writeout of
> the indirect blocks it frees (IMO it should, but that's another story).
> 

This seems to be the problem reported about a year ago, but never fixed.
It exists, even in early kernels.

mke2fs /dev/fd0
mount /dev/fd0 /mnt
cp stuff /mnt

lilo -C - <<EOF
boot = /dev/fd0
map  = /mnt/map
backup = /dev/null
install=/mnt/boot.b
image=/mnt/vmlinuz
initrd=/mnt/initrd
root=/dev/ram0
EOF

umount /dev/fd0
cp /dev/fd0  raw.bin

The disk image, raw.bin, does NOT contain the image of the floppy.
Most of boot stuff added by lilo is missing. It will eventually
get there, but it's not there now, even though the floppy was
un-mounted!

A work-around was to do:

	ioctl(fd, FDFLUSH, NULL);

... from a program  before copying the image.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


