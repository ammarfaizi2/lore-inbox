Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130843AbRCJHpe>; Sat, 10 Mar 2001 02:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130946AbRCJHpZ>; Sat, 10 Mar 2001 02:45:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16881 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130843AbRCJHpU>;
	Sat, 10 Mar 2001 02:45:20 -0500
Date: Sat, 10 Mar 2001 02:44:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] read_cache_page() cleanup
Message-ID: <Pine.GSO.4.21.0103100152290.18115-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, looks like we can simplify both the callers of read_cache_page
and function itself. Without breaking existing code.
a) all but two callers do the following:

	page = read_cache_page(...);
	if (IS_ERR(page))
		goto fail;
	wait_on_page(page);
	if (!PageUptodate(page) {
		page_cache_release(page);
		page = ERR_PTR(-EIO);
		goto fail;
	}

or equivalents of that.

b) two exceptions are in NFS readdir and symlink handling resp. There we
do not call wait_on_page(). However, in both cases filler _always_ unlocks
page before returning. I.e. wait_on_page() would be a no-op - could as
well have it there.

c) after moving the wait_on_page() and check for page being not uptodate
after it into the read_cache_page() the function itself becomes simpler.
I've substituted __read_cache_page() in place of its call and did an
obvious cleanup of the result.

The bottom line: __read_cache_page() is gone, callers of read_cache_page()
dropped the waiting/handling of async errors, read_cache_page() returns
either an uptodate page or error.

Notice that read_cache_page() never was really async - only if we had a
page already in pagecache, not locked and not uptodate. BTW, if page
was _not_ in pagecache and filler got an asynchronous error we used
to cald it again. For no good reason. AFAICS patch below cleans the things
up and shouldn't break anything - code that used to work should work with
new variant. I'd definitely like to see it applied - IMO it counts as
obvious cleanup... Comments? 
							Cheers,
								Al
Patch (against 2.4.3-pre3) follows:
diff -urN S3-pre3/fs/namei.c S3-pre3-read_cache_page/fs/namei.c
--- S3-pre3/fs/namei.c	Fri Feb 16 21:20:06 2001
+++ S3-pre3-read_cache_page/fs/namei.c	Sat Mar 10 00:47:09 2001
@@ -1952,18 +1952,11 @@
 	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
 				NULL);
 	if (IS_ERR(page))
-		goto sync_fail;
-	wait_on_page(page);
-	if (!Page_Uptodate(page))
-		goto async_fail;
+		goto fail;
 	*ppage = page;
 	return kmap(page);
 
-async_fail:
-	page_cache_release(page);
-	return ERR_PTR(-EIO);
-
-sync_fail:
+fail:
 	return (char*)page;
 }
 
diff -urN S3-pre3/fs/nfs/dir.c S3-pre3-read_cache_page/fs/nfs/dir.c
--- S3-pre3/fs/nfs/dir.c	Thu Mar  8 06:33:59 2001
+++ S3-pre3-read_cache_page/fs/nfs/dir.c	Sat Mar 10 00:47:45 2001
@@ -197,8 +197,6 @@
 		status = PTR_ERR(page);
 		goto out;
 	}
-	if (!Page_Uptodate(page))
-		goto read_error;
 
 	/* NOTE: Someone else may have changed the READDIRPLUS flag */
 	desc->plus = NFS_USE_READDIRPLUS(inode);
@@ -210,9 +208,6 @@
  out:
 	dfprintk(VFS, "NFS: find_dirent_page() returns %d\n", status);
 	return status;
- read_error:
-	page_cache_release(page);
-	return -EIO;
 }
 
 /*
diff -urN S3-pre3/fs/nfs/symlink.c S3-pre3-read_cache_page/fs/nfs/symlink.c
--- S3-pre3/fs/nfs/symlink.c	Fri Feb 16 22:52:05 2001
+++ S3-pre3-read_cache_page/fs/nfs/symlink.c	Sat Mar 10 00:48:02 2001
@@ -64,15 +64,10 @@
 				(filler_t *)nfs_symlink_filler, inode);
 	if (IS_ERR(page))
 		goto read_failed;
-	if (!Page_Uptodate(page))
-		goto getlink_read_error;
 	*ppage = page;
 	p = kmap(page);
 	return (char*)(p+1);
 		
-getlink_read_error:
-	page_cache_release(page);
-	return ERR_PTR(-EIO);
 read_failed:
 	return (char*)page;
 }
diff -urN S3-pre3/fs/umsdos/dir.c S3-pre3-read_cache_page/fs/umsdos/dir.c
--- S3-pre3/fs/umsdos/dir.c	Fri Feb 16 22:52:06 2001
+++ S3-pre3-read_cache_page/fs/umsdos/dir.c	Sat Mar 10 00:48:45 2001
@@ -692,9 +692,6 @@
 	dentry_dst=(struct dentry *)page;
 	if (IS_ERR(page))
 		goto out;
-	wait_on_page(page);
-	if (!Page_Uptodate(page))
-		goto async_fail;
 
 	dentry_dst = ERR_PTR(-ENOMEM);
 	path = (char *) kmalloc (PATH_MAX, GFP_KERNEL);
@@ -776,8 +773,6 @@
 	dput(hlink);	/* original hlink no longer needed */
 	return dentry_dst;
 
-async_fail:
-	dentry_dst = ERR_PTR(-EIO);
 out_release:
 	page_cache_release(page);
 	goto out;
diff -urN S3-pre3/fs/umsdos/emd.c S3-pre3-read_cache_page/fs/umsdos/emd.c
--- S3-pre3/fs/umsdos/emd.c	Thu Mar  8 06:33:59 2001
+++ S3-pre3-read_cache_page/fs/umsdos/emd.c	Sat Mar 10 00:51:54 2001
@@ -125,9 +125,6 @@
 			(filler_t*)mapping->a_ops->readpage, NULL);
 	if (IS_ERR(page))
 		goto sync_fail;
-	wait_on_page(page);
-	if (!Page_Uptodate(page))
-		goto async_fail;
 	p = (struct umsdos_dirent*)(kmap(page)+offs);
 
 	/* if this is an invalid entry (invalid name length), ignore it */
@@ -150,12 +147,6 @@
 			page = page2;
 			goto sync_fail;
 		}
-		wait_on_page(page2);
-		if (!Page_Uptodate(page2)) {
-			kunmap(page);
-			page_cache_release(page2);
-			goto async_fail;
-		}
 		memcpy(entry->spare,p->spare,part);
 		memcpy(entry->spare+part,kmap(page2),
 				recsize+offs-PAGE_CACHE_SIZE);
@@ -168,9 +159,6 @@
 	page_cache_release(page);
 	*pos += recsize;
 	return ret;
-async_fail:
-	page_cache_release(page);
-	page = ERR_PTR(-EIO);
 sync_fail:
 	return PTR_ERR(page);
 }
@@ -395,9 +383,6 @@
 			page = read_cache_page(mapping,index,readpage,NULL);
 			if (IS_ERR(page))
 				goto sync_fail;
-			wait_on_page(page);
-			if (!Page_Uptodate(page))
-				goto async_fail;
 			p = kmap(page);
 		}
 
@@ -443,12 +428,6 @@
 				page_cache_release(page);
 				page = next_page;
 				goto sync_fail;
-			}
-			wait_on_page(next_page);
-			if (!Page_Uptodate(next_page)) {
-				page_cache_release(page);
-				page = next_page;
-				goto async_fail;
 			}
 			q = kmap(next_page);
 			if (memcmp(entry->name, rentry->name, len) ||
diff -urN S3-pre3/mm/filemap.c S3-pre3-read_cache_page/mm/filemap.c
--- S3-pre3/mm/filemap.c	Thu Mar  8 06:34:01 2001
+++ S3-pre3-read_cache_page/mm/filemap.c	Sat Mar 10 01:38:21 2001
@@ -2306,8 +2306,11 @@
 	return error;
 }
 
-static inline
-struct page *__read_cache_page(struct address_space *mapping,
+/*
+ * Make sure that @mapping contains a page with index @index, creating a
+ * new one if needed. If that page is not uptodate - try to fill it.
+ */
+struct page *read_cache_page(struct address_space *mapping,
 				unsigned long index,
 				int (*filler)(void *,struct page*),
 				void *data)
@@ -2315,7 +2318,8 @@
 	struct page **hash = page_hash(mapping, index);
 	struct page *page, *cached_page = NULL;
 	int err;
-repeat:
+
+retry:
 	page = __find_get_page(mapping, index, hash);
 	if (!page) {
 		if (!cached_page) {
@@ -2325,53 +2329,38 @@
 		}
 		page = cached_page;
 		if (add_to_page_cache_unique(page, mapping, index, hash))
-			goto repeat;
+			goto retry;
 		cached_page = NULL;
-		err = filler(data, page);
-		if (err < 0) {
+	} else {
+		lock_page(page);
+		if (!page->mapping) {
+			UnlockPage(page);
 			page_cache_release(page);
-			page = ERR_PTR(err);
+			goto retry;
+		}
+		if (Page_Uptodate(page)) {
+			UnlockPage(page);
+			goto out1;
 		}
 	}
-	if (cached_page)
-		page_cache_free(cached_page);
-	return page;
-}
 
-/*
- * Read into the page cache. If a page already exists,
- * and Page_Uptodate() is not set, try to fill the page.
- */
-struct page *read_cache_page(struct address_space *mapping,
-				unsigned long index,
-				int (*filler)(void *,struct page*),
-				void *data)
-{
-	struct page *page;
-	int err;
-
-retry:
-	page = __read_cache_page(mapping, index, filler, data);
-	if (IS_ERR(page) || Page_Uptodate(page))
-		goto out;
-
-	lock_page(page);
-	if (!page->mapping) {
-		UnlockPage(page);
-		page_cache_release(page);
-		goto retry;
-	}
-	if (Page_Uptodate(page)) {
-		UnlockPage(page);
-		goto out;
-	}
 	err = filler(data, page);
 	if (err < 0) {
 		page_cache_release(page);
 		page = ERR_PTR(err);
+		goto out1;
 	}
- out:
+	wait_on_page(page);
+	if (!Page_Uptodate(page))
+		goto async_fail;
+out1:
+	if (cached_page)
+		page_cache_free(cached_page);
 	return page;
+async_fail:
+	page_cache_release(page);
+	page = ERR_PTR(-EIO);
+	goto out1;
 }
 
 static inline struct page * __grab_cache_page(struct address_space *mapping,

