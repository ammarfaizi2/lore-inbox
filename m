Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275339AbTHGNuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 09:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275347AbTHGNuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 09:50:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58540 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275339AbTHGNua
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 09:50:30 -0400
Date: Thu, 7 Aug 2003 15:50:16 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <andersen@codepoet.org>,
       <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
In-Reply-To: <UTC200308071322.h77DM0P11942.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308071539140.20585-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Aug 2003 Andries.Brouwer@cwi.nl wrote:

>     From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
>
>     >     >   > So, the clean way is to examine what the disk reported,
>     >     >   > never change it
>     >     >
>     >     >   Even if disk's info changes?  I don't think so.
>     >     >
>     >     > Yes. The disk geometry data that we use is drive->*
>     >     > What the disk reported to us is drive->id->*.
>
>     After issuing SET_MAX_ADDRESS or SET_MAX_ADDRESS_EXT hardware
>     drive->id is updated
>
> Yes. So far no kernel has asked the disk for an update.
> And I don't think we have seen cases where that would have been
> necessary.
>
> (I mean, theoretically it would be possible that the disk reported
> at first that DMA was supported, while after SET_MAX_ADDRESS this
> no longer is supported, e.g. because of some strange problem that
> allows DMA only from/to the first 32GB. In practice we have never seen
> such things, I think.)

There should be no such things.

>     and we are using this information,
>     so disk reports to us geometry, nope?
>
> Still difficult to parse.
>
> Let me just say some things. Maybe I answer your question, maybe not,
> then ask again, as explicitly as possible.
>
> What geometry stuff do we need? Let me sketch roughly, omitting details.
>
> First, there is drive->{head,sect,cyl}.
> If the drive does not know LBA, then we use drive->{head,sect} for
> actual I/O. If the drive uses LBA we do not use drive->{head,sect,cyl}
> at all. It is a bug when drive->head is larger than 16, or drive->sect
> larger than 63.
>
> Secondly, there is drive->bios_{head,sect,cyl}.
> This is not what we use, but it is what we report when user space asks.
> It is for LILO and fdisk. It is a very difficult question what we have
> to answer here, but it is irrelevant for the kernel.
>
> Thirdly, there is the total disk size.
> The kernel stores this in drive->capacity{48}.
>     [Yes, that reminds me - having two values here is unnecessary.
>     One of my following patch fragments eliminates drive->capacity
>     so that only drive->capacity48 is left.]

Yep, I've noticed this too.

> What is actually used as total size, and also reported by BLKGETSIZE,
> is the return value of current_capacity(), and it is equal to
> drive->capacity48 minus the part used by a disk manager.

I know this stuff :-).

> The kernel does not directly use id->lba_capacity anywhere, except
> in the initial setup, in order to compute drive->capacity*.
> (So, changing it does not do anything useful.)

Indeed.

>     > >From "man hdparm"
>     >
>     >        -i     Display the identification info that  was  obtained
>     >               from the drive at boot time, if available.
>     >        -I     Request  identification  info  directly  from   the
>     >               drive.
>
>     This is a show-stopper only for changing HDIO_GET_IDENTITY semantics,
>     not driver itself (we can have separate drive->boot_id for this).
>
>     I am starting to think that drive->id (reflecting actual identity) and
>     drive->boot_id (saved boot drive->id) is a long-term solution.
>
> Yes, in principle there is nothing wrong with that.
>
> [But I wrote my first operating system on a 4K computer.
> Spent hours reducing the size of a driver from 129 to 128 instructions.
> Am permanently damaged now, very strongly conditioned against wasting memory.]

I came to the same conclusion about increased memory usage.
I will fix overwrtitting of drive->id->* by keeping current values in drive->*
(just as you've suggested).

Thanks,
--
Bartlomiej

