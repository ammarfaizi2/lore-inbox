Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSCWSoz>; Sat, 23 Mar 2002 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310858AbSCWSog>; Sat, 23 Mar 2002 13:44:36 -0500
Received: from [24.93.67.53] ([24.93.67.53]:51984 "EHLO Mail6.mgfairfax.rr.com")
	by vger.kernel.org with ESMTP id <S310835AbSCWSo2>;
	Sat, 23 Mar 2002 13:44:28 -0500
Message-ID: <004901c1d29b$1d8cdfe0$6401a8c0@presto>
From: "Eric Youngdale" <eric@andante.org>
To: "Douglas Gilbert" <dougg@torque.net>, "Pete Zaitcev" <zaitcev@redhat.com>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020322215809.A17173@devserv.devel.redhat.com> <3C9CB643.FC33C0AF@torque.net>
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
Date: Sat, 23 Mar 2002 13:46:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I believe that it was Eric's intention to implement the
> same solution in sd. The generic disk stuff and the
> partitions are a complicating factor.
> All those parallel arrays set up by sd_init (e.g.
> rscsi_disks[], sd_sizes[], sd_blocksizes[],
> sd_hardsizes[], sd_max_sectors[] and sd[] are a mess.
> It is false economy to do the number of index
> operations that sd does, my guess is that 90% of them
> are redundant. Couldn't the sd driver just
> have a device structure that contains an (16 element)
> array of pointers to partition structures?

    Correct on all counts.  Part of what was holding things up was all of
the nonsense related to partition handling.  To a lesser degree the cdrom
driver is being held up for similar reasons.

    The proper cleanup is to eliminate those damned arrays (and make the
access SMP safe at the same time) that live in ll_rw_blk.c.  There would
need to be a generic SMP safe way of obtaining the same information (things
like filesystems need to know this info, for example), and then add SMP safe
ways for low-level drivers to update the sizes of things as required.

    The arrays you mention above are just inserted into the even messier
arrays that live in ll_rw_blk.c - as things currently stand, it really isn't
possible to clean up the arrays in sd.c without solving the larger problem
of the mess of arrays in ll_rw_blk.c.

    I believe it was Jens who had been talking about folding some of this
information into the request_queue_t, and I don't know where this went if
anywhere.  Maybe there was some problem that couldn't be easily resolved.

    Another design goal of messing with this would be to do it in such a way
that support for a larger dev_t is possible.

    Once the basic design is complete, the actual changes shouldn't be too
hard - just tedious.

-Eric


