Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTEDHqc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 03:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTEDHqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 03:46:32 -0400
Received: from [12.47.58.20] ([12.47.58.20]:23591 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263552AbTEDHq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 03:46:29 -0400
Date: Sun, 4 May 2003 01:00:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] how to fix is_local_disk()?
Message-Id: <20030504010014.67352345.akpm@digeo.com>
In-Reply-To: <20030504003021.077e8819.akpm@digeo.com>
References: <20030504090003.A7285@lst.de>
	<20030504003021.077e8819.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2003 07:58:50.0367 (UTC) FILETIME=[FF9C98F0:01C31212]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> Christoph Hellwig <hch@lst.de> wrote:
> >
> > In drivers/char/sysrq.c we have this nice piece of code:
> > 
> 
> Suggest you chainsaw the whole lot and simply do a wakeup_bdflush(0) from
> interrupt context.
> 

Actually, that's a bit slack because it won't run journal commits and such. 
The below should do the trick.

But we still need superblock walking code to do the remount-ro thing. 
Another superblock-iterator which calls do_remount_sb()?


 fs/buffer.c        |   16 +++++++++++++---
 include/linux/fs.h |    1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff -puN fs/buffer.c~emergency_sync fs/buffer.c
--- 25/fs/buffer.c~emergency_sync	2003-05-04 00:46:15.000000000 -0700
+++ 25-akpm/fs/buffer.c	2003-05-04 00:48:54.000000000 -0700
@@ -244,18 +244,28 @@ int fsync_bdev(struct block_device *bdev
  * sync everything.  Start out by waking pdflush, because that writes back
  * all queues in parallel.
  */
-asmlinkage long sys_sync(void)
+static void do_sync(unsigned long wait)
 {
 	wakeup_bdflush(0);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
 	sync_supers();		/* Write the superblocks */
 	sync_filesystems(0);	/* Start syncing the filesystems */
-	sync_filesystems(1);	/* Waitingly sync the filesystems */
-	sync_inodes(1);		/* Mappings, inodes and blockdevs, again. */
+	sync_filesystems(wait);	/* Waitingly sync the filesystems */
+	sync_inodes(wait);	/* Mappings, inodes and blockdevs, again. */
+}
+
+asmlinkage long sys_sync(void)
+{
+	do_sync(1);
 	return 0;
 }
 
+void emergency_sync(void)
+{
+	pdflush_operation(do_sync, 0);
+}
+
 /*
  * Generic function to fsync a file.
  *
diff -puN include/linux/fs.h~emergency_sync include/linux/fs.h
--- 25/include/linux/fs.h~emergency_sync	2003-05-04 00:46:21.000000000 -0700
+++ 25-akpm/include/linux/fs.h	2003-05-04 00:47:01.000000000 -0700
@@ -1113,6 +1113,7 @@ extern int filemap_flush(struct address_
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
+extern void emergency_sync(void);
 extern sector_t bmap(struct inode *, sector_t);
 extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);

_


