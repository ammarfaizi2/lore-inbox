Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTDXLOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTDXLOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:14:42 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:48556 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261759AbTDXLOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:14:38 -0400
Date: Thu, 24 Apr 2003 13:26:12 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Richard Zidlicky <rz@linux-m68k.org>
cc: John Bradford <john@grabjohn.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <20030424094732.GA925@linux-m68k.org>
Message-ID: <Pine.GSO.4.21.0304241309200.19942-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Apr 2003, Richard Zidlicky wrote:
> On Wed, Apr 23, 2003 at 09:19:07PM +0100, John Bradford wrote:
> > Moving byte swapping out of the IDE layer also means that dumping the
> > whole disk to a file will then give you non-byte swapped data, which
> > could then be written back to a disk on another machine without a
> > byte-swapped IDE interface.
> > 
> > It will also allow you to exchange tar archives on raw hard disk
> > devices, and have them readable on non-byte swapped IDE interfaces
> > :-).
> 
> Linux is much better and will do all of that work perfectly since 
> ages, just use hdX=swapdata on one of the machines. Trivially it 
> is also possible to mount the partitions on either architecture.

Note that the swapping works for PIO only, IIRC. For DMA mode, you're limited
to the loop solution.

> The issue is the distinction between drive control data (like SMART
> and ident) and on disk data - currently the ide layer makes no clear
> distinction between those varieties and thus in some cases the 
> byteswapping must be done (or undone) in userspace.
> 
> There are some reasons why I am hesitant to move it out of IDE:
> 
> - IDE knows best what is control or on disk data and
>   having separate ide-iops for them would be trivial
> - partitioning loop devices smells like plenty of fun
> - performance, for compatibility with current kernels
>   we would byteswap in IDE and undo it in the loop layer
> - don´t like to rely on utterly complicated boot ramdisks

After some more thinking, Alan's suggestion (always doing the swapping) isn't
that bad. Except for the loop layer on old slow machines, which I'd like to
avoid.

If we always swap, we only have to un-swap when reading/writing platter data
from native disks. No more swapping has to be done in ide_fix_driveid(), apart
from the obvious conversion from little to big endian of the driveid structure
itself, which we cannot avoid.

Since both Atari and Q40/Q60 use PIO only, this affects ata_{in,out}put_data()
only. It's quite easy to add a swap flag to ide_drive_t (configurable through
hdX=swapdata), that is checked in ata_{in,out}put_data().  To improve
performance, we wouldn't swap twice, but just call the new routines
hwif->{IN,OUT}S[WL]_NOSWAP.

Note that this would be the inverse logic of the current scheme, which swaps
conditionally in atapi_{in,out}put_bytes().

All of this can be protected by #ifdef CONFIG_IDE_BYTESWAPPED_HWIF. Influence
on generic code is limited to ata_{in,out}put_data() and the new routines
hwif->{IN,OUT}S[WL]_NOSWAP.

Is this OK?

For reference, I think this is the list of machines with a byteswapped IDE
interface:
  - Atari Falcon
  - Q40/Q60
  - Tivo

Any others?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

