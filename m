Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269266AbTGJNT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbTGJNT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:19:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269266AbTGJNTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:19:55 -0400
Date: Thu, 10 Jul 2003 09:34:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
In-Reply-To: <bejnl9$m9l$1@news.cistron.nl>
Message-ID: <Pine.LNX.4.53.0307100918410.203@chaos>
References: <bejhrj$dgg$1@news.cistron.nl> <20030710112728.GX15452@holomorphy.com>
 <bejnl9$m9l$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Miquel van Smoorenburg wrote:

> In article <20030710112728.GX15452@holomorphy.com>,
> William Lee Irwin III  <wli@holomorphy.com> wrote:
> >On Thu, Jul 10, 2003 at 11:14:59AM +0000, Miquel van Smoorenburg wrote:
> >> Enough memory free, no problems at all .. yet every few minutes
> >> the OOM killer kills one of my innfeed processes.
> >> I notice that in -mm3 this was deleted relative to -vanilla:
> >>
> >> -
> >> -       /*
> >> -        * Enough swap space left?  Not OOM.
> >> -        */
> >> -       if (nr_swap_pages > 0)
> >> -               return;
> >> .. is that what causes this ? In any case, that should't vene matter -
> >> there's plenty of memory in this box, all buffers and cached, but that
> >> should be easily freed ..
> >
> >This means we're calling into it more often than we should be.
> >Basically, we hit __alloc_pages() with __GFP_WAIT set, find nothing
> >we're allowed to touch, dive into try_to_free_pages(), fall through
> >scanning there, sleep in blk_congestion_wait(), wake up again, try
> >to shrink_slab(), find nothing there either, repeat that 11 more times,
> >and then fall through to out_of_memory()... and this happens at at
> >least 10Hz.
> >
> >        since = now - lastkill;
> >        if (since < HZ*5)
> >                goto out_unlock;
> >
> >try s/goto out_unlock/goto reset/ and let me know how it goes.
>
> But that will only change the rate at which processes are killed,
> not the fact that they are killed in the first place, right ?
>
> As I said I've got plenty memory free ... perhaps I need to tune
> /proc/sys/vm because I've got so much streaming I/O ? Possibly,
> there are too many dirty pages so cleaning them out faster might
> help (and let pflushd do it instead of my single-threaded app)
>

The problem, as I see it, is that you can dirty pages 10-15 times
faster than they can be written to disk. So, you will always
have the possibility of an OOM situation as long as you are I/O
bound. FYI, you can read/write RAM at 1,000+ megabytes/second, but
you can only write to disk at 80 megabytes/second with the fastest
SCSI around, 40 megabytes/second with ATA, 20 megabytes/second with
IDE/DMA, 10 megabytes/second with PIOW, etc. There just aren't
any disks around that will run at RAM speeds so buffered I/O will
always result in full buffers if the I/O is sustained. To completely
solve the OOM situation requires throttling the generation of data.

It is only when the data generation rate is less than or equal to
the data storage rate that you can generate data forever.

A possibility may be to not return control to the writing process
(including swap), until the write completes if RAM gets low. In
other words, stop buffering data in RAM in tight memory situations.
This forces all the tasks to wait and, therefore slows down the
dirty-page and data generation rate to match the RAM available.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

