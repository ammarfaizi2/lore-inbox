Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318622AbSICAsw>; Mon, 2 Sep 2002 20:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318614AbSICAsv>; Mon, 2 Sep 2002 20:48:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9124 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318608AbSICAss>;
	Mon, 2 Sep 2002 20:48:48 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 3 Sep 2002 02:53:09 +0200 (MEST)
Message-Id: <UTC200209030053.g830r9b16219.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, torvalds@transmeta.com
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, neilb@cse.unsw.edu.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > I think it important to get rid of partition table reading in the kernel.

    Why?

Let me be more precise.
I think it important to get rid of automatic partition table reading
in the kernel.

Why?
Because in some cases it is undesirable.
Because in some cases it crashes the kernel.
Because it involves guessing and heuristics.
Because policy belongs in user space.


    >  One argument is that our traditional DOS-type partition table will
    >  soon be at the end of its useful life. Yes, maybe it survives
    >  a few more years but our own stability requires slow changes,
    >  so we must start thinking a long time in advance.

    That's a bad argument. It's not as if we want to have random formats for 
    this thing. Partitioning is damn important, and it has to be portable 
    across different machines and different operating systems. That all means 
    that there is absolutely _zero_ incentive to make up a partition format of 
    our own, since there are perfectly fine and existing formats.

That is a separate discussion best left for some other time.
[But every OS has its own partition table type, and the types
are not compatible. We started using the DOS-type partition table.
But it is dying. Windows replaces it with their dynamic disks.
What do we do? Follow Microsoft? Pick the Plan9 format?]

    >  Another argument is that it sometimes takes a *long* time, like several
    >  minutes, especially when this reading triggers hardware bugs.

    This is only an argument for doing it on demand, not for dropping it.

Yes - that is my main point: doing it on demand. On demand only.

    >  Another argument is that nobody knows whether there is
    >  a partition table. (ZIP: "large floppy" vs "removable disk")
    >  Another argument is that tricky things happen with disk managers.

    And none of these work any better in user space.

Well, in fact they do.

The user knows whether she treats her ZIP like a removable disk
or like a big floppy, that is, whether she should ask or refrain
from asking to read the pt.

And yes, if the partitions on the disk are to be shifted by 63 sectors
then partx can notice that and tell the kernel. But if the kernel does
these things automatically it can be difficult to remove Disk Manager.


    You seem to think that kernel space somehow cannot do something that
    user space can. I just don't see the overriding problems you claim.

It is the user who knows and wants to decide.

If my disk has media errors and I want to rescue what still can be read,
then I am very unhappy that the kernel starts reading the first sector
and the last sector and various sectors in the middle.
I want to have very precise control over what I/O happens.

If I insert a SmartMedia card then I know very precisely that it has
a FAT filesystem, a special one. Some cameras will refuse to read
such cards formatted by DOS. If the kernel starts probing, as it does
today, then it will read the first sector and the last sector, etc.
But my reader has a firmware bug, an off-by-one mistake in the reported
capacity, and the kernel tries to read a sector past the end of the card,
gets an error and the SCSI code starts retrying, resetting the device,
the host, the bus, finally takes the device offline. In the meantime
the USB code is entirely confused by aborts and crashes the kernel.
Of course both SCSI and USB code have to be improved, but it would
certainly be nice if I could tell from userspace: probe only for FAT.
No need at all to read this last sector.

I have seen partition tables with a loop. They would poison Linux
so that it was impossible to boot Linux on a system with such a disk.

I have seen disks with random test data causing Linux to go out and
read nonexistent sectors. There is the real possibility that no
partition table is present, and trying to find one may be a bad idea.

I have seen disks that form part of a multi-disk array.
Often the partition tables are meaningless.


Not doing things automatically gives power to the user.
In some situations this power is needed.


And once this partition reading is done on demand only, it does not
matter very much who does the reading. It may be the kernel.
It may be a user space program.

Andries

