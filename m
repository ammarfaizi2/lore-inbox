Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbTJORQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTJORQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:16:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63873 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263634AbTJORQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:16:46 -0400
Date: Wed, 15 Oct 2003 13:19:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
In-Reply-To: <16269.29716.461117.338214@laputa.namesys.com>
Message-ID: <Pine.LNX.4.53.0310151253001.7576@chaos>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl>
 <16269.23199.833564.163986@laputa.namesys.com> <Pine.LNX.4.53.0310151150370.7350@chaos>
 <16269.29716.461117.338214@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Nikita Danilov wrote:

> Richard B. Johnson writes:
>  > On Wed, 15 Oct 2003, Nikita Danilov wrote:
>  >
>  > > Erik Mouw writes:
>  > >  > On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
>  > >  > > Erik Mouw writes:
>  > >  > >  > Nowadays disks are so incredibly cheap, that transparent compression
>  > >  > >  > support is not realy worth it anymore (IMHO).
>  > >  > >
>  > [SNIPPED...]
>  >
>  > >  >
>  > >  > PS: let me guess: among other things, reiser4 comes with transparent
>  > >  >     compression? ;-)
>  > >
>  > > Yes, it will.
>  > >
>  >
>  > EeeeeeK!  A single bad sector could prevent an entire database from
>  > being uncompressed! You may want to re-think that idea before you
>  > commit a lot of time to it.
>
> It could not if block-level compression is used. Which is the only
> solution, given random-access to file bodies.
>

Then the degenerative case is no compression at all. There is no
advantage to writing a block that is 1/N full of compressed data.
You end up having to write the whole block anyway.

This problem was well developed in the days where RLE (at the hardware
level) was used to extend the size of hard disks from their physical
size of about 38 megabytes to about 70 megabytes. The minimim size
of a read or write is a sector.

So, lets's use the minimum compression alogithm, no sliding
dictionaries complicating things, just RLE and see.

The alogithm is a sentinal byte, a byte representing the number
of bytes to expand -1, then the byte to expand. The sentinal byte
in RLE was 0xbb. If you needed to read/write a 0xbb, you need
to expand that to three bytes, 0xbb, 0x00, 0xbb.
                                  |     |     |___ byte to expand
                                  |     |________ nr bytes (0 + 1)
                                  |______________ sentinal byte

All other sequences will reduce the size. So, we have a 512-
byte sector full of nulls, what gets written is:
        0xbb, 0xff, 0x00, 0xbb, 0xff, 0x00
           |     |     |     |     |     |___ byte value
           |     |     |     |     |_________ 256 bytes
           |     |     |     |_______________ sentinal
           |     |     |_____________________ byte value
           |     |___________________________ 256 bytes
           |_________________________________ sentinal.

In this example, we have compressed a 512 byte sector to
only 6 bytes. Wonderful! Now we have to write 512 bytes
so that effort was wasted. FYI, I invented RLE and I also
put it into JMODEM the "last" file-transfer protocol that
I created in 1989.  http://www.hal9k.com/cug/v300e.htm

Any time you are bound to a minimum block size to transfer,
you will have this problem.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


