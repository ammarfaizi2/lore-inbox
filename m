Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315793AbSEJECp>; Fri, 10 May 2002 00:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315794AbSEJECo>; Fri, 10 May 2002 00:02:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35079 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315793AbSEJECo>;
	Fri, 10 May 2002 00:02:44 -0400
Message-ID: <3CDB4711.1A4FFDAC@zip.com.au>
Date: Thu, 09 May 2002 21:05:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: linux-kernel@vger.kernel.org, martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
> 
> Hi,
>         At present, linux is limited to 2TB filesystems even on 64-bit
> systems, because there are various places where the block offset on
> disc are assigned to unsigned or int 32-bit variables.
> 
> There's a type, sector_t, that's meant to hold offsets in sectors and
> blocks.  It's not used consistently (yet).
> 
> The patch at
>     http://www.gelato.unsw.edu.au/patches/2.5.14-largefile-patch
> 
> ...
> 
> As this touches lots of places -- the generic block layer (Andrew?)
> the IDE code (Martin?) and RAID (Neil?) and minor changes to the scsi
> I've CCd a few people directly.

That would be more Jens and aviro than I.

My vote would be: just merge the sucker while it still (almost) 
applies. 2TB is a showstopper for some people in 2.4 today.  Obviously
2.6 will need 64-bit block numbers.

The next obstacle will be page cache indices into the blockdev mapping.
That's either an 8TB or 16TB limit, depending on signedness correctness.

One minor point - it is currently not possible to print sector_t's.
This code:

	printk("%lu%s", some_sector, some_string);

will work fine with 32-bit sector_t.  But with 64-bit sector_t it
will generate a warning at compile-time and an oops at runtime.

The same problem applies to dma_addr_t.  Jeff, davem and I kicked
that around a while back and ended up deciding that although there
are a number of high-tech solutions, the dumb one was best:


--- 2.5.14/include/linux/types.h~sector_t-printing	Thu May  9 17:08:13 2002
+++ 2.5.14-akpm/include/linux/types.h	Thu May  9 17:08:13 2002
@@ -120,8 +120,10 @@ typedef		__s64		int64_t;
 
 #ifdef BLK_64BIT_SECTOR
 typedef u64 sector_t;
+#define FMT_SECTOR_T	"%Lu"
 #else
 typedef unsigned long sector_t;
+#define FMT_SECTOR_T	"%lu"
 #endif
 
 #endif /* __KERNEL_STRICT_NAMES */
--- 2.5.14/fs/buffer.c~sector_t-printing	Thu May  9 17:08:13 2002
+++ 2.5.14-akpm/fs/buffer.c	Thu May  9 17:09:35 2002
@@ -179,7 +179,8 @@ __clear_page_buffers(struct page *page)
 
 static void buffer_io_error(struct buffer_head *bh)
 {
-	printk(KERN_ERR "Buffer I/O error on device %s, logical block %ld\n",
+	printk(KERN_ERR "Buffer I/O error on device %s,"
+			" logical block " FMT_SECTOR_T "\n",
 			bdevname(bh->b_bdev), bh->b_blocknr);
 }
