Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSFKGN7>; Tue, 11 Jun 2002 02:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316846AbSFKGN6>; Tue, 11 Jun 2002 02:13:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316845AbSFKGNv>;
	Tue, 11 Jun 2002 02:13:51 -0400
Message-ID: <3D0595F7.A21AE62B@zip.com.au>
Date: Mon, 10 Jun 2002 23:17:27 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <10339.1023773628@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> fd = open("foo", O_RDWR);
> map = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> ... modify the mapped pages ...
> munmap(map, size);
> close(fd);
> 
> The timestamp on foo is not updated, even though the contents have
> changed.  Adding msync(map, size, MS_[A]SYNC) before munmap makes no
> difference.  2.4.19-pre10 has no obvious fixes for this problem.
> 
> I was tearing my hair out wondering why some files were not being
> rsynced.  No change on size or timestamp tells rsync that the file is
> "unchanged".  I had to add a dummy write(map, fd, 1) to force a
> timestamp update.

Well it's very easy to fix.  And this (untested) patch will
actually speed the kernel up (lots) because it has the smarter
mtime update logic.  But note that the mtime update won't
occur for a (potentially infinitely) long time after your
program has exited.  Unless you used mysnc.

What do the standards say?

http://www.opengroup.org/onlinepubs/007904975/functions/mmap.html


     The st_ctime and st_mtime fields of a file that is mapped with MAP_SHARED
     and PROT_WRITE shall be marked for update at some point in the interval
     between a write reference to the mapped region and the next call to msync() with
     MS_ASYNC or MS_SYNC for that portion of the file by any process. If there is
     no such call and if the underlying file is modified as a result of a write reference,
     then these fields shall be marked for update at some time after the write reference.

This patch does exactly that.  Guess I should test it.



--- 2.4.19-pre10/mm/vmscan.c~mmap-mtime	Mon Jun 10 23:00:28 2002
+++ 2.4.19-pre10-akpm/mm/vmscan.c	Mon Jun 10 23:04:34 2002
@@ -405,6 +405,9 @@ static int shrink_cache(int nr_pages, zo
 				page_cache_get(page);
 				spin_unlock(&pagemap_lru_lock);
 
+				if (!PageSwapCache(page))
+					update_mtime(page->mapping->host);
+
 				writepage(page);
 				page_cache_release(page);
 
--- 2.4.19-pre10/mm/filemap.c~mmap-mtime	Mon Jun 10 23:00:31 2002
+++ 2.4.19-pre10-akpm/mm/filemap.c	Mon Jun 10 23:05:17 2002
@@ -551,6 +551,9 @@ int filemap_fdatasync(struct address_spa
 	int ret = 0;
 	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 
+	if (!list_empty(&mapping->dirty_pages))
+		update_mtime(mapping->host);
+
 	spin_lock(&pagecache_lock);
 
         while (!list_empty(&mapping->dirty_pages)) {
@@ -3026,8 +3029,7 @@ generic_file_write(struct file *file,con
 		goto out;
 
 	remove_suid(inode);
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	mark_inode_dirty_sync(inode);
+	update_mtime(inode);
 
 	if (file->f_flags & O_DIRECT)
 		goto o_direct;
--- 2.4.19-pre10/fs/inode.c~mmap-mtime	Mon Jun 10 23:02:18 2002
+++ 2.4.19-pre10-akpm/fs/inode.c	Mon Jun 10 23:03:18 2002
@@ -1195,6 +1195,16 @@ void update_atime (struct inode *inode)
 	mark_inode_dirty_sync (inode);
 }   /*  End Function update_atime  */
 
+void update_mtime(struct inode *inode)
+{
+	time_t now = CURRENT_TIME;
+
+	if (inode->i_ctime != now || inode->i_mtime != now) {
+		inode->i_ctime = now;
+		inode->i_mtime = now;
+		mark_inode_dirty_sync(inode);
+	}
+}
 
 /*
  *	Quota functions that want to walk the inode lists..
--- 2.4.19-pre10/include/linux/fs.h~mmap-mtime	Mon Jun 10 23:02:21 2002
+++ 2.4.19-pre10-akpm/include/linux/fs.h	Mon Jun 10 23:03:41 2002
@@ -200,7 +200,8 @@ extern int leases_enable, dir_notify_ena
 #include <asm/semaphore.h>
 #include <asm/byteorder.h>
 
-extern void update_atime (struct inode *);
+void update_atime(struct inode *);
+void update_mtime(struct inode *);
 #define UPDATE_ATIME(inode) update_atime (inode)
 
 extern void buffer_init(unsigned long);


-
