Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbTDAA6b>; Mon, 31 Mar 2003 19:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261958AbTDAA6b>; Mon, 31 Mar 2003 19:58:31 -0500
Received: from [12.47.58.55] ([12.47.58.55]:19164 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261954AbTDAA62>;
	Mon, 31 Mar 2003 19:58:28 -0500
Date: Mon, 31 Mar 2003 17:09:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-Id: <20030331170927.013a0d4a.akpm@digeo.com>
In-Reply-To: <87el4ngi8l.fsf@enki.rimspace.net>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no>
	<3E88BAF9.8040100@cyberone.com.au>
	<20030331144500.17bf3a2e.akpm@digeo.com>
	<87el4ngi8l.fsf@enki.rimspace.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 01:09:44.0355 (UTC) FILETIME=[616AA730:01C2F7EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Pittman <daniel@rimspace.net> wrote:
>
> Capturing a real-time video stream from an IEEE1394 DV stream means
> writing a stead 3.5MB per second for two on two and a half hours.
> 
> Linux isn't great at this, using the default writeout policy, even as
> recent as 2.5.64. The writer goes OK for a while but, eventually, blocks
> on writeout for long enough to drop a frame -- more than 8/25ths of a
> second.
> 
> 
> This can be resolved by tuning the default delay before write-out start
> to 5 seconds, down from 30, or by running sync every second, or by doing
> fsync tricks.

Interesting.

Yes, I expect that you could fix that up by altering dirty_background_ratio
and dirty_expire_centisecs.

The problem with fsync() is that it waits on the writeout.  You don't want
that to happen - you just want to tell the kernel "I won't be overwriting or
deleting this data".  Make the kernel queue up and start the IO but not wait
on its completion.

It is quite appropriate to do this in fadvise(FADV_DONTNEED) - as a
lower-latency fsync().  The app would need to call it once per second or so. 

It would also throw away any written-back pagecache inside your (start, len)
which is exactly what your applications wants to happen, so the app should be
calling fadvise _anyway_.

What do you think?


 25-akpm/include/linux/fs.h |    1 +
 25-akpm/mm/fadvise.c       |    1 +
 25-akpm/mm/filemap.c       |   18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff -puN include/linux/fs.h~fadvise-flush-data include/linux/fs.h
--- 25/include/linux/fs.h~fadvise-flush-data	Mon Mar 31 17:03:39 2003
+++ 25-akpm/include/linux/fs.h	Mon Mar 31 17:03:39 2003
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
+++ 25-akpm/mm/fadvise.c	Mon Mar 31 17:03:39 2003
@@ -61,6 +61,7 @@ long sys_fadvise64(int fd, loff_t offset
 			ret = 0;
 		break;
 	case POSIX_FADV_DONTNEED:
+		filemap_flush(mapping);
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

