Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbTDABep>; Mon, 31 Mar 2003 20:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbTDABep>; Mon, 31 Mar 2003 20:34:45 -0500
Received: from [12.47.58.55] ([12.47.58.55]:994 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261994AbTDABen>;
	Mon, 31 Mar 2003 20:34:43 -0500
Date: Mon, 31 Mar 2003 17:45:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-Id: <20030331174543.374030ba.akpm@digeo.com>
In-Reply-To: <87pto7f1ad.fsf@enki.rimspace.net>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no>
	<3E88BAF9.8040100@cyberone.com.au>
	<20030331144500.17bf3a2e.akpm@digeo.com>
	<87el4ngi8l.fsf@enki.rimspace.net>
	<20030331170927.013a0d4a.akpm@digeo.com>
	<87pto7f1ad.fsf@enki.rimspace.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 01:46:01.0216 (UTC) FILETIME=[72ED4800:01C2F7F0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman <daniel@rimspace.net> wrote:
>
> > What do you think?
> 
> I will apply the patch and test later today.  This, however, looks like
> a *really* good thing to me.

I think so too.

A possible enhancement is to only do the flush if the backing queue is not
write-congested.  So the syscall will very probably be async.  If the queue
is write congested then it's a sure bet that someone else is saturating the
disk ayway.  We don't want to block in that case.


 25-akpm/include/linux/fs.h |    1 +
 25-akpm/mm/fadvise.c       |    2 ++
 25-akpm/mm/filemap.c       |   18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff -puN include/linux/fs.h~fadvise-flush-data include/linux/fs.h
--- 25/include/linux/fs.h~fadvise-flush-data	Mon Mar 31 17:03:39 2003
+++ 25-akpm/include/linux/fs.h	Mon Mar 31 17:43:45 2003
@@ -1112,6 +1112,7 @@ unsigned long invalidate_inode_pages(str
 extern void invalidate_inode_pages2(struct address_space *mapping);
 extern void write_inode_now(struct inode *, int);
 extern int filemap_fdatawrite(struct address_space *);
+extern int filemap_flush(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
 extern void sync_filesystems(int wait);
diff -puN mm/fadvise.c~fadvise-flush-data mm/fadvise.c
--- 25/mm/fadvise.c~fadvise-flush-data	Mon Mar 31 17:03:39 2003
+++ 25-akpm/mm/fadvise.c	Mon Mar 31 17:44:49 2003
@@ -61,6 +61,8 @@ long sys_fadvise64(int fd, loff_t offset
 			ret = 0;
 		break;
 	case POSIX_FADV_DONTNEED:
+		if (!bdi_write_congested(mapping->backing_dev_info))
+			filemap_flush(mapping);
 		invalidate_mapping_pages(mapping, offset >> PAGE_CACHE_SHIFT,
 				(len >> PAGE_CACHE_SHIFT) + 1);
 		break;
diff -puN mm/filemap.c~fadvise-flush-data mm/filemap.c
--- 25/mm/filemap.c~fadvise-flush-data	Mon Mar 31 17:03:39 2003
+++ 25-akpm/mm/filemap.c	Mon Mar 31 17:03:39 2003
@@ -122,11 +122,11 @@ static inline int sync_page(struct page 
  * if a dirty page/buffer is encountered, it must be waited upon, and not just
  * skipped over.
  */
-int filemap_fdatawrite(struct address_space *mapping)
+static int __filemap_fdatawrite(struct address_space *mapping, int sync_mode)
 {
 	int ret;
 	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
+		.sync_mode = sync_mode,
 		.nr_to_write = mapping->nrpages * 2,
 	};
 
@@ -140,6 +140,20 @@ int filemap_fdatawrite(struct address_sp
 	return ret;
 }
 
+int filemap_fdatawrite(struct address_space *mapping)
+{
+	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
+}
+
+/*
+ * This is a mostly non-blocking flush.  Not suitable for data-integrity
+ * purposes.
+ */
+int filemap_flush(struct address_space *mapping)
+{
+	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
+}
+
 /**
  * filemap_fdatawait - walk the list of locked pages of the given address
  *                     space and wait for all of them.

_

