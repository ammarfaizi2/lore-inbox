Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSEJImm>; Fri, 10 May 2002 04:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315913AbSEJIml>; Fri, 10 May 2002 04:42:41 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:40037 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315883AbSEJImi>; Fri, 10 May 2002 04:42:38 -0400
Message-Id: <5.1.0.14.2.20020510093714.01fa9680@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 10 May 2002 09:43:06 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] remove 2TB block device limit
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        martin@dalecki.de, neilb@cse.unsw.edu.au
In-Reply-To: <3CDB4711.1A4FFDAC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:05 10/05/02, Andrew Morton wrote:
>Peter Chubb wrote:
> >
> > Hi,
> >         At present, linux is limited to 2TB filesystems even on 64-bit
> > systems, because there are various places where the block offset on
> > disc are assigned to unsigned or int 32-bit variables.
> >
> > There's a type, sector_t, that's meant to hold offsets in sectors and
> > blocks.  It's not used consistently (yet).
> >
> > The patch at
> >     http://www.gelato.unsw.edu.au/patches/2.5.14-largefile-patch
> >
> > ...
> >
> > As this touches lots of places -- the generic block layer (Andrew?)
> > the IDE code (Martin?) and RAID (Neil?) and minor changes to the scsi
> > I've CCd a few people directly.
>
>That would be more Jens and aviro than I.
>
>My vote would be: just merge the sucker while it still (almost)
>applies. 2TB is a showstopper for some people in 2.4 today.  Obviously
>2.6 will need 64-bit block numbers.
>
>The next obstacle will be page cache indices into the blockdev mapping.
>That's either an 8TB or 16TB limit, depending on signedness correctness.
>
>One minor point - it is currently not possible to print sector_t's.
>This code:
>
>         printk("%lu%s", some_sector, some_string);
>
>will work fine with 32-bit sector_t.  But with 64-bit sector_t it
>will generate a warning at compile-time and an oops at runtime.
>
>The same problem applies to dma_addr_t.  Jeff, davem and I kicked
>that around a while back and ended up deciding that although there
>are a number of high-tech solutions, the dumb one was best:

Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu and 
typecast (unsigned long long)sector_t_variable in the printk.

May be ugly, but isn't it correct that you actually need the above typecast 
on some architectures where %Lu == unsigned long long != u64?

Anton

>--- 2.5.14/include/linux/types.h~sector_t-printing      Thu May  9 
>17:08:13 2002
>+++ 2.5.14-akpm/include/linux/types.h   Thu May  9 17:08:13 2002
>@@ -120,8 +120,10 @@ typedef            __s64           int64_t;
>
>  #ifdef BLK_64BIT_SECTOR
>  typedef u64 sector_t;
>+#define FMT_SECTOR_T   "%Lu"
>  #else
>  typedef unsigned long sector_t;
>+#define FMT_SECTOR_T   "%lu"
>  #endif
>
>  #endif /* __KERNEL_STRICT_NAMES */
>--- 2.5.14/fs/buffer.c~sector_t-printing        Thu May  9 17:08:13 2002
>+++ 2.5.14-akpm/fs/buffer.c     Thu May  9 17:09:35 2002
>@@ -179,7 +179,8 @@ __clear_page_buffers(struct page *page)
>
>  static void buffer_io_error(struct buffer_head *bh)
>  {
>-       printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
>+       printk(KERN_ERR "Buffer I/O error on device %s,"
>+                       " logical block " FMT_SECTOR_T "\n",
>                         bdevname(bh->b_bdev), bh->b_blocknr);
>  }
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

