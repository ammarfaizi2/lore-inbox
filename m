Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTJTVyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJTVxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:53:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:56315 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262853AbTJTVxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:53:15 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Subject: Re: ide retry behavior
Date: Mon, 20 Oct 2003 23:53:09 +0200
User-Agent: KMail/1.5.1
References: <785F348679A4D5119A0C009027DE33C105CDB316@mcoexc04.mlm.maxtor.com>
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB316@mcoexc04.mlm.maxtor.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200310202353.09881.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Eric, please forgive me the repost to LKML, since it nicely 
 underscores nicely my attempt!]

Hi Eric,

nice to get some feedback from you. I definitely didn't expected
an answer from down the driving core with such a brillant response
time. Thanks a lot!

On Monday 20 October 2003 22:12, Mudama, Eric wrote:
> > -----Original Message-----
> > From: Hans-Peter Jansen [mailto:hpj@urpla.net]
>
> First, glad you were able to get some data back.

All in all, the damage was pretty harmless. Critical data lives
on IDE SW Raid5 arrays here anyway. This was the first out of 10 
Maxtors failing, which were purchased during the IBM IDE disasters
around 2000/2001.

> > Analyzing the syslogs showed, that a few retries are done.
> > This raises the question, is it possible to adjust the retry
> > count on the fly, since this would allow a more intelligent
> > datarecovery strategy:
>
> Not that I am aware of.  That being said:
>
> You may have success doing your various retry passes in different
> environmental conditions, however, two attempts on the same LBA at
> the same temperature/humidity/etc I wouldn't expect to give
> different results.

Then let's prove the fact. One could cool the drive, swap controllers, 
cable, driver settings...

> There are already hundreds of retries within the drive before we
> report an ECC error... going from 350 or whatever retries to 700
> probably isn't going to change the fact that the data there is
> corrupt.

I'm under the expression, that this is different in my case. It looked
like after some retries, it finally responded with the correct block in
some cases. I will later analyse this further.

>From was I see, the kernel retries up to 8 times to read the same
LBA:

Oct 17 22:36:17 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:36:39 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:37:02 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:37:25 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:37:48 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:38:11 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:38:34 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:38:57 pico kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448

$((350*8)) = 2800 physical retries, if your number is right.

That's why it took 31 hours to copy the 80 GB. Under error free 
conditions, this job takes about 30-60 Min.

Thanks to your hint, I've found the offending piece in ide-disk.c/900:

    } else if (stat & ERR_STAT) {
        /* err has different meaning on cdrom and tape */
        if (err == ABRT_ERR) {
            if (drive->select.b.lba &&
                /* some newer drives don't support WIN_SPECIFY */
                hwif->INB(IDE_COMMAND_REG) == WIN_SPECIFY)
                return ide_stopped;
        } else if ((err & BAD_CRC) == BAD_CRC) {
            /* UDMA crc error, just retry the operation */
            drive->crc_count++;
        } else if (err & (BBD_ERR | ECC_ERR)) {
            /* retries won't help these */
            rq->errors = ERROR_MAX;
        } else if (err & TRK0_ERR) {
            /* help it find track zero */
            rq->errors |= ERROR_RECAL;
        }
    }

Now it looks, like I need an interface for a new option in the 
drive structure, where I can switch off this behavior of just
stupidly retrying on CRC errors. Any hints from somebody for
this one (which has a chance to get included, finally...).

Thanks again, Eric. This brought me directly to this.

> --eric

Pete
