Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRF0PAW>; Wed, 27 Jun 2001 11:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbRF0PAM>; Wed, 27 Jun 2001 11:00:12 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:47441 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262715AbRF0PAB>; Wed, 27 Jun 2001 11:00:01 -0400
Date: Wed, 27 Jun 2001 16:59:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Zeng Yu <yu_zeng@263.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk Bug?
Message-ID: <20010627165945.A16936@athlon.random>
In-Reply-To: <001e01c0ff14$0bdc7540$0101a8c0@weqeqe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001e01c0ff14$0bdc7540$0101a8c0@weqeqe>; from yu_zeng@263.net on Wed, Jun 27, 2001 at 10:18:26PM +0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 10:18:26PM +0800, Zeng Yu wrote:
> Hi all,
> 
> I think find a ramdisk bug of 2.4.4 kernel -- ramdisk
> use both buffers and cached mem of the same size, thus
> double the mem use. 
> mke2fs -m0 /dev/ram1
> mount /dev/ram1 /mnt
> dd if=/dev/zero of=/mnt/data bs=1k count=110000
> cat /proc/meminfo will see that both buffers and
> cached mem increase about 110M of size. More worse,
> the cached mem won't be released untile the ramdisk
> be umounted. I attach the meminfo and slabinfo before

the "more worse" part is the only thing which is wrong. The fact cache
also grows to 110M is expected and it won't change. With the
blkdev-pagecache patch the cache will grow to 220M and it will shrink to
110M if you are low on memory (buffer cache will only be allocated for
the superblock and inode metadata with ext2).

use ramfs if you want zero ram duplication and you don't care about the
physical representation on disk of your data in cache.

> and after data transfer below.

Try this patch to fix the "more worst part"  (beware totally untested).

--- blkdev-rd/include/linux/swap.h.~1~	Sun Jun 24 02:06:13 2001
+++ blkdev-rd/include/linux/swap.h	Wed Jun 27 16:47:57 2001
@@ -274,7 +274,7 @@
 #endif
 
 #define page_ramdisk(page) \
-	(page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR))
+	(!page->mapping && page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR))
 
 extern spinlock_t swaplock;
 

Andrea
