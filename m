Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130212AbRBMXho>; Tue, 13 Feb 2001 18:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBMXhe>; Tue, 13 Feb 2001 18:37:34 -0500
Received: from smtp8.us.dell.com ([143.166.224.234]:20237 "EHLO
	smtp8.us.dell.com") by vger.kernel.org with ESMTP
	id <S130212AbRBMXhV>; Tue, 13 Feb 2001 18:37:21 -0500
Date: Tue, 13 Feb 2001 17:37:18 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: <Andries.Brouwer@cwi.nl>
cc: <Matt_Domsch@exchange.dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <UTC200102132254.XAA98078.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0102131718560.26922-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries!

On Tue, 13 Feb 2001 Andries.Brouwer@cwi.nl wrote:

> >   The block device uses 1K blocksize, and will prevent userspace from
> > seeing the odd-block at the end of the disk, if the disk is odd-size.
> >
> >   IA-64 architecture defines a new partitioning scheme where there is a
> > backup of the partition table header in the last sector of the disk. While
> > we can read and write to this sector in the kernel partition code, we have
> > no way for userspace to update this partition block.
>
> Are you sure?

Yes.

The only alternative at this time is to use the scsi-generic tools to
read directly from the scsi-layer. But, of course, this only works with
scsi devices.

>
> There may be no easy, convenient way right now, but
> (without having checked anything) it seems to me
> that you can, also today.

Please go check :-)  I believe my statement stands: You cannot read or
write to odd-sectors at the end of the disk from userspace. (see below for
definition of odd sector...)

> Look at the addpart utility in the util-linux package.
> It will allow you to add a partition disjoint from
> previously existing partitions.
> And since a partition can start on an odd sector,
> this should allow you to also read the last sector.
>
> Do I overlook something?

Yes. The addpart utility just uses the block-layer ioctls to dynamically
add and/or remove partitions. What this is doing is just adjusting the
kernel's idea of what the current partition scheme is. This has _nothing_
to do with actually reading or writing data from the disk.

The ia64 gpt partitioning code defines a partition header at the front of
the disk and at the end of the disk. I definetly have a need to read and
write to these headers.

What this proposed patch does has _nothing_ to do with partitioning :-) It
is _only_ to read and write the last sector of the disk. It just so
happens that the reason that I have to read that last sector is to read a
partition header.

>
> Anyway, an ioctl just to read the last sector is too silly.
> An ioctl to change the blocksize is more reasonable.

That may be better, I don't know. That's why this is an RFC. Are there any
possible races with that method? It seems to me that you might adversely
affect io in progress by changing the blocksize. The method demonstrated
in this patch shouldn't do that.

> And I expect that this fixed blocksize will go soon.

That may be, I don't know that much about the block layer. All I know is
that, with the current structure, I cannot read or write to sectors where
(sector #) > total-disk-blocks - (total-disk-blocks /
(softblocksize/hardblocksize))

This ioctl can be deprecated when that is no longer the case.

>
> Andries
>

Thanks for the comments.

> [Sorry if precisely the same discussion has happened earlier -
> I have no memory.]
>

Not really. I have discussed this with some folks with Red Hat, but this
is the first discussion on L-K.
--
Michael Brown

