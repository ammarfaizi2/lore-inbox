Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbSJQFsZ>; Thu, 17 Oct 2002 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261809AbSJQFsZ>; Thu, 17 Oct 2002 01:48:25 -0400
Received: from packet.digeo.com ([12.110.80.53]:30360 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261808AbSJQFsY>;
	Thu, 17 Oct 2002 01:48:24 -0400
Message-ID: <3DAE5087.76395305@digeo.com>
Date: Wed, 16 Oct 2002 22:54:15 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: balance_dirty_pages broken
References: <20021017043623.GR8159@redhat.com> <3DAE4615.F98B6DE@digeo.com> <20021017052246.GB10276@redhat.com> <20021017054110.GC10276@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 05:54:15.0914 (UTC) FILETIME=[A04954A0:01C275A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> On Thu, Oct 17, 2002 at 01:22:46AM -0400, Doug Ledford wrote:
> > Sure, coming under separate cover.
> 
> Actually, this isn't needed now I assume ;-)

Well I was rather interested in seeing it to find out why your
compile is busted.  You seem to be very protective of the compiler
error messages ;)

> ...
> Patch solves the problem.  Writes don't hang and Shift-ScrollLock shows a
> reasonable number for dirty now.

OK, thanks.  That patch still doesn't fix the ramdisk's current problems
so I'll send a minimal fix for this one to Linus.

Namely:



--- 2.5.43/drivers/block/rd.c~rd-dirty-fix	Wed Oct 16 22:46:02 2002
+++ 2.5.43-akpm/drivers/block/rd.c	Wed Oct 16 22:47:39 2002
@@ -51,6 +51,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
+#include <linux/backing-dev.h>
 #include <asm/uaccess.h>
 
 /*
@@ -351,6 +352,10 @@ static struct file_operations initrd_fop
 
 #endif
 
+static struct backing_dev_info rd_backing_dev_info = {
+	.ra_pages	= 0,	/* No readahead */
+	.memory_backed	= 1,	/* Does not contribute to dirty memory */
+};
 
 static int rd_open(struct inode * inode, struct file * filp)
 {
@@ -379,6 +384,7 @@ static int rd_open(struct inode * inode,
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_block_size = rd_blocksize;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_inode->i_mapping->backing_dev_info = &rd_backing_dev_info;
 		rd_bdev[unit]->bd_inode->i_size = rd_length[unit];
 		rd_bdev[unit]->bd_queue = &blk_dev[MAJOR_NR].request_queue;
 		rd_bdev[unit]->bd_disk = get_disk(rd_disks[unit]);

.
