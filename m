Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275338AbTHGNWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275339AbTHGNWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:22:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:61432 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275338AbTHGNWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:22:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 15:22:00 +0200 (MEST)
Message-Id: <UTC200308071322.h77DM0P11942.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Cc: alan@lxorguk.ukuu.org.uk, andersen@codepoet.org,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

    >     >   > So, the clean way is to examine what the disk reported,
    >     >   > never change it
    >     >
    >     >   Even if disk's info changes?  I don't think so.
    >     >
    >     > Yes. The disk geometry data that we use is drive->*
    >     > What the disk reported to us is drive->id->*.

    After issuing SET_MAX_ADDRESS or SET_MAX_ADDRESS_EXT hardware
    drive->id is updated

Yes. So far no kernel has asked the disk for an update.
And I don't think we have seen cases where that would have been
necessary.

(I mean, theoretically it would be possible that the disk reported
at first that DMA was supported, while after SET_MAX_ADDRESS this
no longer is supported, e.g. because of some strange problem that
allows DMA only from/to the first 32GB. In practice we have never seen
such things, I think.)

    and we are using this information,
    so disk reports to us geometry, nope?

Still difficult to parse.

Let me just say some things. Maybe I answer your question, maybe not,
then ask again, as explicitly as possible.

What geometry stuff do we need? Let me sketch roughly, omitting details.

First, there is drive->{head,sect,cyl}.
If the drive does not know LBA, then we use drive->{head,sect} for
actual I/O. If the drive uses LBA we do not use drive->{head,sect,cyl}
at all. It is a bug when drive->head is larger than 16, or drive->sect
larger than 63.

Secondly, there is drive->bios_{head,sect,cyl}.
This is not what we use, but it is what we report when user space asks.
It is for LILO and fdisk. It is a very difficult question what we have
to answer here, but it is irrelevant for the kernel.

Thirdly, there is the total disk size.
The kernel stores this in drive->capacity{48}.
    [Yes, that reminds me - having two values here is unnecessary.
    One of my following patch fragments eliminates drive->capacity
    so that only drive->capacity48 is left.]
What is actually used as total size, and also reported by BLKGETSIZE,
is the return value of current_capacity(), and it is equal to
drive->capacity48 minus the part used by a disk manager.

The kernel does not directly use id->lba_capacity anywhere, except
in the initial setup, in order to compute drive->capacity*.
(So, changing it does not do anything useful.)

    > >From "man hdparm"
    >
    >        -i     Display the identification info that  was  obtained
    >               from the drive at boot time, if available.
    >        -I     Request  identification  info  directly  from   the
    >               drive.

    This is a show-stopper only for changing HDIO_GET_IDENTITY semantics,
    not driver itself (we can have separate drive->boot_id for this).

    I am starting to think that drive->id (reflecting actual identity) and
    drive->boot_id (saved boot drive->id) is a long-term solution.

Yes, in principle there is nothing wrong with that.

[But I wrote my first operating system on a 4K computer.
Spent hours reducing the size of a driver from 129 to 128 instructions.
Am permanently damaged now, very strongly conditioned against wasting memory.]

Andries
