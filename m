Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQKPIcw>; Thu, 16 Nov 2000 03:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKPIcm>; Thu, 16 Nov 2000 03:32:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59267 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129636AbQKPIcc>;
	Thu, 16 Nov 2000 03:32:32 -0500
Date: Thu, 16 Nov 2000 03:02:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 truncate() change broke `dd'
In-Reply-To: <200011160058.BAA20802@harpo.it.uu.se>
Message-ID: <Pine.GSO.4.21.0011160251450.11017-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Mikael Pettersson wrote:

> I noticed because I needed to build a boot floppy with an
> initial ram disk under 2.4.0-test11pre5. The standard recipe
> (Documentation/ramdisk.txt) basically goes:
> - dd if=bzImage of=/dev/fd0 bs=1k
>   notice how many blocks dd reported (NNN)
> - dd if=ram_image of=/dev/fd0 bs=1k seek=NNN
> dd implements the seek=NNN option by calling ftruncate() before
> starting the write. This is where 2.4.0-test10 breaks, since
> ftruncate on a block device now provokes an EACCES error.

And what kind of meaning would you assign to truncate on floppy?
 
> Maybe `dd' is buggy and should use lseek() instead, but this has
> apparently worked for a long time.

Use conv=notrunc.

> Does anyone know the reason for the S_ISDIR -> !S_ISREG change in test10?

For one thing, you really don't want it working on pipes. For another -
it's just damn meaningless on devices, symlinks and sockets. Which leaves
regular files.

OTOH, -EACCES looks wrong - for directories we must return -EISDIR and for
sockets ftruncate() should return -EINVAL. Adopting -EINVAL for devices
and pipes may be a good idea... Andries, could you comment on that?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
