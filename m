Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUJSJzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUJSJzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUJSJwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:52:07 -0400
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:4518 "EHLO
	ppsw-3.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268122AbUJSJl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:41:29 -0400
Date: Tue, 19 Oct 2004 10:41:16 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 10/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038250.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 10/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/01 1.2011)
   NTFS: Implement the equivalent of memset() for an ntfs attribute in
         fs/ntfs/attrib.[hc]::ntfs_attr_set() and switch
         fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-10-19 10:13:41 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:13:41 +01:00
@@ -40,6 +40,9 @@
 	  inline wrapper for ntfs_cluster_free_from_rl_nolock() which takes the
 	  cluster bitmap lock for the duration of the call.
 	- Add fs/ntfs/attrib.[hc]::ntfs_attr_record_resize().
+	- Implement the equivalent of memset() for an ntfs attribute in
+	  fs/ntfs/attrib.[hc]::ntfs_attr_set() and switch
+	  fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
 
 2.1.19 - Many cleanups, improvements, and a minor bug fix.
 
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-19 10:13:41 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-19 10:13:42 +01:00
@@ -986,3 +986,144 @@
 	}
 	return 0;
 }
+
+/**
+ * ntfs_attr_set - fill (a part of) an attribute with a byte
+ * @ni:		ntfs inode describing the attribute to fill
+ * @ofs:	offset inside the attribute at which to start to fill
+ * @cnt:	number of bytes to fill
+ * @val:	the unsigned 8-bit value with which to fill the attribute
+ *
+ * Fill @cnt bytes of the attribute described by the ntfs inode @ni starting at
+ * byte offset @ofs inside the attribute with the constant byte @val.
+ *
+ * This function is effectively like memset() applied to an ntfs attribute.
+ *
+ * Return 0 on success and -errno on error.  An error code of -ESPIPE means
+ * that @ofs + @cnt were outside the end of the attribute and no write was
+ * performed.
+ */
+int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt, const u8 val)
+{
+	ntfs_volume *vol = ni->vol;
+	struct address_space *mapping;
+	struct page *page;
+	u8 *kaddr;
+	pgoff_t idx, end;
+	unsigned int start_ofs, end_ofs, size;
+
+	ntfs_debug("Entering for ofs 0x%llx, cnt 0x%llx, val 0x%hx.",
+			(long long)ofs, (long long)cnt, val);
+	BUG_ON(ofs < 0);
+	BUG_ON(cnt < 0);
+	if (!cnt)
+		goto done;
+	mapping = VFS_I(ni)->i_mapping;
+	/* Work out the starting index and page offset. */
+	idx = ofs >> PAGE_CACHE_SHIFT;
+	start_ofs = ofs & ~PAGE_CACHE_MASK;
+	/* Work out the ending index and page offset. */
+	end = ofs + cnt;
+	end_ofs = end & ~PAGE_CACHE_MASK;
+	/* If the end is outside the inode size return -ESPIPE. */
+	if (unlikely(end > VFS_I(ni)->i_size)) {
+		ntfs_error(vol->sb, "Request exceeds end of attribute.");
+		return -ESPIPE;
+	}
+	end >>= PAGE_CACHE_SHIFT;
+	/* If there is a first partial page, need to do it the slow way. */
+	if (start_ofs) {
+		page = read_cache_page(mapping, idx,
+				(filler_t*)mapping->a_ops->readpage, NULL);
+		if (IS_ERR(page)) {
+			ntfs_error(vol->sb, "Failed to read first partial "
+					"page (sync error, index 0x%lx).", idx);
+			return PTR_ERR(page);
+		}
+		wait_on_page_locked(page);
+		if (unlikely(!PageUptodate(page))) {
+			ntfs_error(vol->sb, "Failed to read first partial page "
+					"(async error, index 0x%lx).", idx);
+			page_cache_release(page);
+			return PTR_ERR(page);
+		}
+		/*
+		 * If the last page is the same as the first page, need to
+		 * limit the write to the end offset.
+		 */
+		size = PAGE_CACHE_SIZE;
+		if (idx == end)
+			size = end_ofs;
+		kaddr = kmap_atomic(page, KM_USER0);
+		memset(kaddr + start_ofs, val, size - start_ofs);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+		set_page_dirty(page);
+		page_cache_release(page);
+		if (idx == end)
+			goto done;
+		idx++;
+	}
+	/* Do the whole pages the fast way. */
+	for (; idx < end; idx++) {
+		/* Find or create the current page.  (The page is locked.) */
+		page = grab_cache_page(mapping, idx);
+		if (unlikely(!page)) {
+			ntfs_error(vol->sb, "Insufficient memory to grab "
+					"page (index 0x%lx).", idx);
+			return -ENOMEM;
+		}
+		kaddr = kmap_atomic(page, KM_USER0);
+		memset(kaddr, val, PAGE_CACHE_SIZE);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+		/*
+		 * If the page has buffers, mark them uptodate since buffer
+		 * state and not page state is definitive in 2.6 kernels.
+		 */
+		if (page_has_buffers(page)) {
+			struct buffer_head *bh, *head;
+
+			bh = head = page_buffers(page);
+			do {
+				set_buffer_uptodate(bh);
+			} while ((bh = bh->b_this_page) != head);
+		}
+		/* Now that buffers are uptodate, set the page uptodate, too. */
+		SetPageUptodate(page);
+		/*
+		 * Set the page and all its buffers dirty and mark the inode
+		 * dirty, too.  The VM will write the page later on.
+		 */
+		set_page_dirty(page);
+		/* Finally unlock and release the page. */
+		unlock_page(page);
+		page_cache_release(page);
+	}
+	/* If there is a last partial page, need to do it the slow way. */
+	if (end_ofs) {
+		page = read_cache_page(mapping, idx,
+				(filler_t*)mapping->a_ops->readpage, NULL);
+		if (IS_ERR(page)) {
+			ntfs_error(vol->sb, "Failed to read last partial page "
+					"(sync error, index 0x%lx).", idx);
+			return PTR_ERR(page);
+		}
+		wait_on_page_locked(page);
+		if (unlikely(!PageUptodate(page))) {
+			ntfs_error(vol->sb, "Failed to read last partial page "
+					"(async error, index 0x%lx).", idx);
+			page_cache_release(page);
+			return PTR_ERR(page);
+		}
+		kaddr = kmap_atomic(page, KM_USER0);
+		memset(kaddr, val, end_ofs);
+		flush_dcache_page(page);
+		kunmap_atomic(kaddr, KM_USER0);
+		set_page_dirty(page);
+		page_cache_release(page);
+	}
+done:
+	ntfs_debug("Done.");
+	return 0;
+}
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-10-19 10:13:41 +01:00
+++ b/fs/ntfs/attrib.h	2004-10-19 10:13:41 +01:00
@@ -86,4 +86,7 @@
 
 extern int ntfs_attr_record_resize(MFT_RECORD *m, ATTR_RECORD *a, u32 new_size);
 
+extern int ntfs_attr_set(ntfs_inode *ni, const s64 ofs, const s64 cnt,
+		const u8 val);
+
 #endif /* _LINUX_NTFS_ATTRIB_H */
diff -Nru a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c	2004-10-19 10:13:41 +01:00
+++ b/fs/ntfs/logfile.c	2004-10-19 10:13:41 +01:00
@@ -681,60 +681,20 @@
 BOOL ntfs_empty_logfile(struct inode *log_vi)
 {
 	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
-	struct address_space *mapping;
-	pgoff_t idx, end;
 
 	ntfs_debug("Entering.");
-	if (NVolLogFileEmpty(vol))
-		goto done;
-	mapping = log_vi->i_mapping;
-	end = (log_vi->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	for (idx = 0; idx < end; ++idx) {
-		struct page *page;
-		u8 *kaddr;
-
-		/* Find or create the current page.  (The page is locked.) */
-		page = grab_cache_page(mapping, idx);
-		if (unlikely(!page)) {
-			ntfs_error(vol->sb, "Insufficient memory to grab "
-					"$LogFile page (index %lu).", idx);
+	if (!NVolLogFileEmpty(vol)) {
+		int err;
+		
+		err = ntfs_attr_set(NTFS_I(log_vi), 0, log_vi->i_size, 0xff);
+		if (unlikely(err)) {
+			ntfs_error(vol->sb, "Failed to fill $LogFile with "
+					"0xff bytes (error code %i).", err);
 			return FALSE;
 		}
-		/*
-		 * Set all bytes in the page to 0xff.  It doesn't matter if we
-		 * go beyond i_size, because ntfs_writepage() will take care of
-		 * that for us.
-		 */
-		kaddr = (u8*)kmap_atomic(page, KM_USER0);
-		memset(kaddr, 0xff, PAGE_CACHE_SIZE);
-		flush_dcache_page(page);
-		kunmap_atomic(kaddr, KM_USER0);
-		/*
-		 * If the page has buffers, mark them uptodate since buffer
-		 * state and not page state is definitive in 2.6 kernels.
-		 */
-		if (page_has_buffers(page)) {
-			struct buffer_head *bh, *head;
-
-			bh = head = page_buffers(page);
-			do {
-				set_buffer_uptodate(bh);
-			} while ((bh = bh->b_this_page) != head);
-		}
-		/* Now that buffers are uptodate, set the page uptodate, too. */
-		SetPageUptodate(page);
-		/*
-		 * Set the page and all its buffers dirty and mark the inode
-		 * dirty, too. The VM will write the page later on.
-		 */
-		set_page_dirty(page);
-		/* Finally unlock and release the page. */
-		unlock_page(page);
-		page_cache_release(page);
+		/* Set the flag so we do not have to do it again on remount. */
+		NVolSetLogFileEmpty(vol);
 	}
-	/* We set the flag so we do not clear the log file again on remount. */
-	NVolSetLogFileEmpty(vol);
-done:
 	ntfs_debug("Done.");
 	return TRUE;
 }
