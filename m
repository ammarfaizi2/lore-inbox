Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129283AbQKVODI>; Wed, 22 Nov 2000 09:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129412AbQKVOC6>; Wed, 22 Nov 2000 09:02:58 -0500
Received: from myrile.madriver.k12.oh.us ([156.63.175.142]:9485 "EHLO
        myrile.madriver.k12.oh.us") by vger.kernel.org with ESMTP
        id <S129283AbQKVOCt>; Wed, 22 Nov 2000 09:02:49 -0500
Date: Wed, 22 Nov 2000 08:31:58 -0500 (EST)
From: Eric Lowe <elowe@myrile.madriver.k12.oh.us>
To: MOHAMMED AZAD <mohammedazad@nestec.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Locking User memory pages from a driver....
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A520D00B@pdc2.nestec.net>
Message-ID: <Pine.BSF.4.10.10011220814060.34604-100000@myrile.madriver.k12.oh.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> How do i lock user mode memmory pages from kernel mode driver.. so that i
> can access it whenever i need to from the driver.... I am using linux kernel
> 2.2.14.. can this be done in this kernel version... or is it supported in
> some other newer versions.. like 2.4..
> 

raw I/O.  Stock in 2.4, available as a patch in 2.2.  You're in luck,
I just released an updated patch against 2.2.17 and 2.2.18preXX yesterday,
based on SCT's raw I/O and with Andrea's fixes.

http://www.donet.com/~elowe/linux/patches

For example usage see fs/block.c brw_kiovec() and drivers/char/raw.c
Basically you call:

  alloc_kiovec() to initialize kiobufs

  map_user_kiobuf() to map a kiobuf to a user buffer (best if <= 64K)

  Look in the kiobuf to get the iobuf->offset into the first page
    and addresses to the pages:

	bounce = iobuf->bouncelist[pageind];

	if (bounce)
		page = bounce;
	else
		page = iobuf->pagelist[pageind];

  The page is a kernel virtual address as an unsigned long you can
    then translate in the usual way (e.g. virt_to_bus() for PCI).
    Don't forget to count the length of the last page as
    PAGE_SIZE-iobuf->offset or you'll run over in your S/G.

  unmap_kiobuf() to unmap the kiobuf and unpin the pages

If you do a lot of DMA I/O with large buffers you'll need to apply
the 22vmfix patch in the same directory or you'll run out memory
and things will start to be OOM killed.

--
Eric Lowe
Software Engineer, Systran Corporation
elowe@systran.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
