Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSFTXWl>; Thu, 20 Jun 2002 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSFTXWk>; Thu, 20 Jun 2002 19:22:40 -0400
Received: from hera.cwi.nl ([192.16.191.8]:47003 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315806AbSFTXWj>;
	Thu, 20 Jun 2002 19:22:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 21 Jun 2002 01:21:40 +0200 (MEST)
Message-Id: <UTC200206202321.g5KNLeT22807.aeb@smtp.cwi.nl>
To: davej@suse.de
Subject: Re: /proc/partitions broken in 2.5.23
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org,
       whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 10:02:48AM +0100, Dave Jones wrote:

    > I got a bug report about an issue with LVM in 2.5.22-dj1, which turns
    > out to be caused by broken /proc/partitions in mainline.
    > 
    > (davej@mesh:davej)$ cat /proc/partitions 
    > major minor  #blocks  name
    > 
    >    8     0          0 sda
    >   22     0 1515870810 hdc
    > 
    > Note the huge numbers in hex are 0x5a5a5a5a, so something
    > seems to be getting poisoned somewhere.

Is this LVM?

I don't see how LVM could produce such values.
(And in fact LVM does not even compile, so only a patched LVM
could produce anything at all.)



From: Wayne Whitney <whitney@adsl-209-76-109-63.dsl.snfc21.pacbell.net>

    I traced the change to the part of mainline ChangeSet 1.496 given
    below (warning: cut and pasted).  It seems to cause every possible
    device that a driver could provide to show up in /proc/partitions.
    For LVM, that's a zillion devices, and /proc/partitions overflows,
    showing some random pages from memory.  Reverting the patch below
    makes /proc/partitions and LVM happy again.


    --- a/drivers/block/genhd.c    Wed May  8 09:53:06 2002
    +++ b/drivers/block/genhd.c    Sun Jun  9 18:58:36 2002
    @@ -177,9 +177,10 @@
         if (sgp == gendisk_head)
             seq_puts(part, "major minor  #blocks  name\n\n");
     
    -    /* show all non-0 size partitions of this disk */
    +    /* show the full disk and all non-0 size partitions of it */
         for (n = 0; n < (sgp->nr_real << sgp->minor_shift); n++) {
    -        if (sgp->part[n].nr_sects == 0)
    +        int minormask = (1<<sgp->minor_shift) - 1;
    +        if ((n & minormask) && sgp->part[n].nr_sects == 0)
                 continue;
             seq_printf(part, "%4d  %4d %10d %s\n",
                 sgp->major, n, sgp->sizes[n],

Yes.
Normally the nr_real field indicates how many devices are
present. But LVM sets that to 256 even when nothing is present.
So, indeed, when all size fields are set to 0 this would probably
yield a list of 256 absent LVM devices.
Maybe LVM has to be fixed, or this patch fragment reverted, or both.

Something else is that if /proc/partitions overflows that must be
fixed independently of zeros or LVM.

Andries
