Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318244AbSHKJXP>; Sun, 11 Aug 2002 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSHKJXP>; Sun, 11 Aug 2002 05:23:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17161 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318244AbSHKJXN>;
	Sun, 11 Aug 2002 05:23:13 -0400
Message-ID: <3D563035.C6BA9F51@zip.com.au>
Date: Sun, 11 Aug 2002 02:36:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <20020810201027.E306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101529490.2401-100000@home.transmeta.com> <20020811031705.GA13878@netnation.com> <3D55FF30.6164040D@zip.com.au> <20020811084652.GB22497@netnation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby wrote:
> 
> With tcpdump in another window, I can see that the readahead doesn'
> start prefetching until it's right near the end of the data it
> fetched last, rather than doing it in advance.

That's a big fat bug.   And it wouldn't be astonishing if my
shiny new readahead does the same thing - I haven't analysed/tested
this scenario.  Shall though.

Knowing zero about NFS, this:

        if (!PageError(page) && NFS_SERVER(inode)->rsize >= PAGE_CACHE_SIZE) {
                error = nfs_readpage_async(file, inode, page);
                goto out;
        }

        error = nfs_readpage_sync(file, inode, page);

would seem to indicate that it's important to have 4k or 8k rsize and
wsize.

> ...
> 
> > OK, it's doing 128k of readahead there, which is a bit gross for a floppy.
> > You can tune that down with `blockdev --setra N /dev/floppy'.  The
> 
> Ooh, is there something like this for NFS?

In 2.4, /proc/sys/vm/[min|max]_readahead should affect NFS, I think.

In 2.5, no knobs yet.  NFS is using the default_backing_dev_info's
readahead setting, which isn't tunable.  It needs to create its
own backing_dev_info (probably per mount?), make each inode's
inode.i_data.backing_dev_info point at that backing_dev_info
structure and export it to userspace in some manner.  Guess I
should have told Trond that ;)

> > but `mke2fs /dev/fd0' oopses in 2.5.30.  ho hum)
> 
> Yes, floppy in 2.5 has been broken for a while...
> 

Well it's oopsing in the code which tries to work out the
device geometry:

generic_unplug_device (data=0x0) at /usr/src/25/include/asm/spinlock.h:117
117     {
(gdb) bt
#0  generic_unplug_device (data=0x0) at /usr/src/25/include/asm/spinlock.h:117
#1  0xc020b57c in __floppy_read_block_0 (bdev=0xf62c4e00) at floppy.c:3896
#2  0xc020b5f6 in floppy_read_block_0 (dev={value = 512}) at floppy.c:3915
#3  0xc020b745 in floppy_revalidate (dev={value = 512}) at floppy.c:3954
#4  0xc01448b7 in check_disk_change (bdev=0xf62c4e00) at block_dev.c:522
#5  0xc020b377 in floppy_open (inode=0xf54e5ec0, filp=0xf4baa1a0) at floppy.c:3808
#6  0xc0144bc6 in do_open (bdev=0xf62c4e00, inode=0xf54e5ec0, file=0xf4baa1a0) at block_dev.c:623
#7  0xc0144f63 in blkdev_open (inode=0xf54e5ec0, filp=0xf4baa1a0) at block_dev.c:740
#8  0xc013d83e in dentry_open (dentry=0xf62dc5e0, mnt=0xc3ff5ee0, flags=32768) at open.c:655
#9  0xc013d770 in filp_open (filename=0xf6362000 "/dev/fd0", flags=32768, mode=0) at open.c:624
#10 0xc013db4f in sys_open (filename=0xbffffb9c "/dev/fd0", flags=32768, mode=0) at open.c:800
#11 0xc0107123 in syscall_call () at stats.c:204

So if you use something with known geometry, like /dev/fd0h1440, it works!
