Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUJSLEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUJSLEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUJSKCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:02:54 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:42440 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268144AbUJSJnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:43:10 -0400
Date: Tue, 19 Oct 2004 10:42:55 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 17/37] Re: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug
 fixes
In-Reply-To: <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0410191042440.24986@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191038570.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039140.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039320.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191039510.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040220.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040360.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191040490.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041050.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041180.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041290.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041420.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191041590.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042200.24986@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0410191042320.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 17/37 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/10/07 1.2029)
   NTFS: - Move ntfs_{un,}map_page() from ntfs.h to aops.h and fix resulting
           include errors.
         - Move typedefs for runlist_element and runlist from ntfs.h to
           runlist.h and fix resulting include errors.
   
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
--- a/fs/ntfs/ChangeLog	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/ChangeLog	2004-10-19 10:14:07 +01:00
@@ -54,6 +54,10 @@
 	- Switch fs/ntfs/index.h::ntfs_index_entry_mark_dirty() to using the
 	  new helper fs/ntfs/aops.c::mark_ntfs_record_dirty() and remove the no
 	  longer needed fs/ntfs/index.[hc]::__ntfs_index_entry_mark_dirty().
+	- Move ntfs_{un,}map_page() from ntfs.h to aops.h and fix resulting
+	  include errors.
+	- Move the typedefs for runlist_element and runlist from types.h to
+	  runlist.h and fix resulting include errors.
 
 2.1.20 - Fix two stupid bugs introduced in 2.1.18 release.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/aops.c	2004-10-19 10:14:07 +01:00
@@ -28,6 +28,10 @@
 #include <linux/buffer_head.h>
 
 #include "aops.h"
+#include "debug.h"
+#include "inode.h"
+#include "mft.h"
+#include "types.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/aops.h b/fs/ntfs/aops.h
--- a/fs/ntfs/aops.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/aops.h	2004-10-19 10:14:07 +01:00
@@ -24,9 +24,76 @@
 #ifndef _LINUX_NTFS_AOPS_H
 #define _LINUX_NTFS_AOPS_H
 
-#ifdef NTFS_RW
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <linux/fs.h>
 
 #include "inode.h"
+
+/**
+ * ntfs_unmap_page - release a page that was mapped using ntfs_map_page()
+ * @page:	the page to release
+ *
+ * Unpin, unmap and release a page that was obtained from ntfs_map_page().
+ */
+static inline void ntfs_unmap_page(struct page *page)
+{
+	kunmap(page);
+	page_cache_release(page);
+}
+
+/**
+ * ntfs_map_page - map a page into accessible memory, reading it if necessary
+ * @mapping:	address space for which to obtain the page
+ * @index:	index into the page cache for @mapping of the page to map
+ *
+ * Read a page from the page cache of the address space @mapping at position
+ * @index, where @index is in units of PAGE_CACHE_SIZE, and not in bytes.
+ *
+ * If the page is not in memory it is loaded from disk first using the readpage
+ * method defined in the address space operations of @mapping and the page is
+ * added to the page cache of @mapping in the process.
+ *
+ * If the page is in high memory it is mapped into memory directly addressible
+ * by the kernel.
+ *
+ * Finally the page count is incremented, thus pinning the page into place.
+ *
+ * The above means that page_address(page) can be used on all pages obtained
+ * with ntfs_map_page() to get the kernel virtual address of the page.
+ *
+ * When finished with the page, the caller has to call ntfs_unmap_page() to
+ * unpin, unmap and release the page.
+ *
+ * Note this does not grant exclusive access. If such is desired, the caller
+ * must provide it independently of the ntfs_{un}map_page() calls by using
+ * a {rw_}semaphore or other means of serialization. A spin lock cannot be
+ * used as ntfs_map_page() can block.
+ *
+ * The unlocked and uptodate page is returned on success or an encoded error
+ * on failure. Caller has to test for error using the IS_ERR() macro on the
+ * return value. If that evaluates to TRUE, the negative error code can be
+ * obtained using PTR_ERR() on the return value of ntfs_map_page().
+ */
+static inline struct page *ntfs_map_page(struct address_space *mapping,
+		unsigned long index)
+{
+	struct page *page = read_cache_page(mapping, index,
+			(filler_t*)mapping->a_ops->readpage, NULL);
+
+	if (!IS_ERR(page)) {
+		wait_on_page_locked(page);
+		kmap(page);
+		if (PageUptodate(page) && !PageError(page))
+			return page;
+		ntfs_unmap_page(page);
+		return ERR_PTR(-EIO);
+	}
+	return page;
+}
+
+#ifdef NTFS_RW
 
 extern void mark_ntfs_record_dirty(ntfs_inode *ni, struct page *page,
 		unsigned int rec_start);
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/attrib.c	2004-10-19 10:14:07 +01:00
@@ -21,6 +21,10 @@
  */
 
 #include <linux/buffer_head.h>
+
+#include "attrib.h"
+#include "debug.h"
+#include "mft.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
--- a/fs/ntfs/bitmap.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/bitmap.c	2004-10-19 10:14:07 +01:00
@@ -25,6 +25,7 @@
 
 #include "bitmap.h"
 #include "debug.h"
+#include "aops.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/collate.c b/fs/ntfs/collate.c
--- a/fs/ntfs/collate.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/collate.c	2004-10-19 10:14:07 +01:00
@@ -19,8 +19,9 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include "ntfs.h"
 #include "collate.h"
+#include "debug.h"
+#include "ntfs.h"
 
 static int ntfs_collate_binary(ntfs_volume *vol,
 		const void *data1, const int data1_len,
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/compress.c	2004-10-19 10:14:07 +01:00
@@ -25,6 +25,8 @@
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 
+#include "inode.h"
+#include "debug.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/dir.c	2004-10-19 10:14:07 +01:00
@@ -21,8 +21,14 @@
  */
 
 #include <linux/smp_lock.h>
-#include "ntfs.h"
+#include <linux/buffer_head.h>
+
 #include "dir.h"
+#include "aops.h"
+#include "attrib.h"
+#include "mft.h"
+#include "debug.h"
+#include "ntfs.h"
 
 /**
  * The little endian Unicode string $I30 as a global constant.
diff -Nru a/fs/ntfs/dir.h b/fs/ntfs/dir.h
--- a/fs/ntfs/dir.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/dir.h	2004-10-19 10:14:07 +01:00
@@ -24,6 +24,8 @@
 #define _LINUX_NTFS_DIR_H
 
 #include "layout.h"
+#include "inode.h"
+#include "types.h"
 
 /*
  * ntfs_name is used to return the file name to the caller of
diff -Nru a/fs/ntfs/file.c b/fs/ntfs/file.c
--- a/fs/ntfs/file.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/file.c	2004-10-19 10:14:07 +01:00
@@ -19,6 +19,10 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/pagemap.h>
+#include <linux/buffer_head.h>
+
+#include "debug.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/index.c	2004-10-19 10:14:07 +01:00
@@ -19,9 +19,11 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include "ntfs.h"
+#include "aops.h"
 #include "collate.h"
+#include "debug.h"
 #include "index.h"
+#include "ntfs.h"
 
 /**
  * ntfs_index_ctx_get - allocate and initialize a new index context
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/inode.c	2004-10-19 10:14:07 +01:00
@@ -27,8 +27,11 @@
 
 #include "ntfs.h"
 #include "dir.h"
+#include "debug.h"
 #include "inode.h"
 #include "attrib.h"
+#include "malloc.h"
+#include "mft.h"
 #include "time.h"
 
 /**
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/inode.h	2004-10-19 10:14:07 +01:00
@@ -24,10 +24,17 @@
 #ifndef _LINUX_NTFS_INODE_H
 #define _LINUX_NTFS_INODE_H
 
+#include <linux/mm.h>
+#include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/list.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
 
 #include "layout.h"
 #include "volume.h"
+#include "types.h"
+#include "runlist.h"
 
 typedef struct _ntfs_inode ntfs_inode;
 
diff -Nru a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
--- a/fs/ntfs/lcnalloc.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/lcnalloc.c	2004-10-19 10:14:07 +01:00
@@ -30,6 +30,7 @@
 #include "volume.h"
 #include "attrib.h"
 #include "malloc.h"
+#include "aops.h"
 #include "ntfs.h"
 
 /**
diff -Nru a/fs/ntfs/lcnalloc.h b/fs/ntfs/lcnalloc.h
--- a/fs/ntfs/lcnalloc.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/lcnalloc.h	2004-10-19 10:14:07 +01:00
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 
 #include "types.h"
+#include "runlist.h"
 #include "volume.h"
 
 typedef enum {
diff -Nru a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
--- a/fs/ntfs/logfile.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/logfile.c	2004-10-19 10:14:07 +01:00
@@ -29,8 +29,10 @@
 
 #include "logfile.h"
 #include "volume.h"
-#include "ntfs.h"
+#include "aops.h"
 #include "debug.h"
+#include "malloc.h"
+#include "ntfs.h"
 
 /**
  * ntfs_check_restart_page_header - check the page header for consistency
diff -Nru a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
--- a/fs/ntfs/malloc.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/malloc.h	2004-10-19 10:14:07 +01:00
@@ -24,6 +24,7 @@
 
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/highmem.h>
 
 /**
  * ntfs_malloc_nofs - allocate memory in multiples of pages
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/mft.c	2004-10-19 10:14:07 +01:00
@@ -20,10 +20,16 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/buffer_head.h>
 #include <linux/swap.h>
 
-#include "ntfs.h"
 #include "bitmap.h"
+#include "lcnalloc.h"
+#include "aops.h"
+#include "debug.h"
+#include "mft.h"
+#include "malloc.h"
+#include "ntfs.h"
 
 /**
  * __format_mft_record - initialize an empty mft record
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/mft.h	2004-10-19 10:14:07 +01:00
@@ -24,6 +24,8 @@
 #define _LINUX_NTFS_MFT_H
 
 #include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
 
 #include "inode.h"
 
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/namei.c	2004-10-19 10:14:07 +01:00
@@ -23,8 +23,10 @@
 #include <linux/dcache.h>
 #include <linux/security.h>
 
-#include "ntfs.h"
 #include "dir.h"
+#include "debug.h"
+#include "mft.h"
+#include "ntfs.h"
 
 /**
  * ntfs_lookup - find the inode represented by a dentry in a directory inode
diff -Nru a/fs/ntfs/ntfs.h b/fs/ntfs/ntfs.h
--- a/fs/ntfs/ntfs.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/ntfs.h	2004-10-19 10:14:07 +01:00
@@ -29,21 +29,12 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
-#include <linux/buffer_head.h>
 #include <linux/nls.h>
-#include <linux/pagemap.h>
 #include <linux/smp.h>
-#include <asm/atomic.h>
 
 #include "types.h"
-#include "debug.h"
-#include "malloc.h"
-#include "endian.h"
 #include "volume.h"
-#include "inode.h"
 #include "layout.h"
-#include "attrib.h"
-#include "mft.h"
 
 typedef enum {
 	NTFS_BLOCK_SIZE		= 512,
@@ -87,72 +78,12 @@
 	return sb->s_fs_info;
 }
 
-/**
- * ntfs_unmap_page - release a page that was mapped using ntfs_map_page()
- * @page:	the page to release
- *
- * Unpin, unmap and release a page that was obtained from ntfs_map_page().
- */
-static inline void ntfs_unmap_page(struct page *page)
-{
-	kunmap(page);
-	page_cache_release(page);
-}
-
-/**
- * ntfs_map_page - map a page into accessible memory, reading it if necessary
- * @mapping:	address space for which to obtain the page
- * @index:	index into the page cache for @mapping of the page to map
- *
- * Read a page from the page cache of the address space @mapping at position
- * @index, where @index is in units of PAGE_CACHE_SIZE, and not in bytes.
- *
- * If the page is not in memory it is loaded from disk first using the readpage
- * method defined in the address space operations of @mapping and the page is
- * added to the page cache of @mapping in the process.
- *
- * If the page is in high memory it is mapped into memory directly addressible
- * by the kernel.
- *
- * Finally the page count is incremented, thus pinning the page into place.
- *
- * The above means that page_address(page) can be used on all pages obtained
- * with ntfs_map_page() to get the kernel virtual address of the page.
- *
- * When finished with the page, the caller has to call ntfs_unmap_page() to
- * unpin, unmap and release the page.
- *
- * Note this does not grant exclusive access. If such is desired, the caller
- * must provide it independently of the ntfs_{un}map_page() calls by using
- * a {rw_}semaphore or other means of serialization. A spin lock cannot be
- * used as ntfs_map_page() can block.
- *
- * The unlocked and uptodate page is returned on success or an encoded error
- * on failure. Caller has to test for error using the IS_ERR() macro on the
- * return value. If that evaluates to TRUE, the negative error code can be
- * obtained using PTR_ERR() on the return value of ntfs_map_page().
- */
-static inline struct page *ntfs_map_page(struct address_space *mapping,
-		unsigned long index)
-{
-	struct page *page = read_cache_page(mapping, index,
-			(filler_t*)mapping->a_ops->readpage, NULL);
-
-	if (!IS_ERR(page)) {
-		wait_on_page_locked(page);
-		kmap(page);
-		if (PageUptodate(page) && !PageError(page))
-			return page;
-		ntfs_unmap_page(page);
-		return ERR_PTR(-EIO);
-	}
-	return page;
-}
-
 /* Declarations of functions and global variables. */
 
 /* From fs/ntfs/compress.c */
 extern int ntfs_read_compressed_block(struct page *page);
+extern int allocate_compression_buffers(void);
+extern void free_compression_buffers(void);
 
 /* From fs/ntfs/super.c */
 #define default_upcase_len 0x10000
@@ -165,10 +96,6 @@
 	char *str;
 } option_t;
 extern const option_t on_errors_arr[];
-
-/* From fs/ntfs/compress.c */
-extern int allocate_compression_buffers(void);
-extern void free_compression_buffers(void);
 
 /* From fs/ntfs/mst.c */
 extern int post_read_mst_fixup(NTFS_RECORD *b, const u32 size);
diff -Nru a/fs/ntfs/quota.c b/fs/ntfs/quota.c
--- a/fs/ntfs/quota.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/quota.c	2004-10-19 10:14:07 +01:00
@@ -22,9 +22,10 @@
 
 #ifdef NTFS_RW
 
-#include "ntfs.h"
 #include "index.h"
 #include "quota.h"
+#include "debug.h"
+#include "ntfs.h"
 
 /**
  * ntfs_mark_quotas_out_of_date - mark the quotas out of date on an ntfs volume
diff -Nru a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/runlist.c	2004-10-19 10:14:07 +01:00
@@ -20,8 +20,10 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include "ntfs.h"
 #include "dir.h"
+#include "debug.h"
+#include "malloc.h"
+#include "ntfs.h"
 
 /**
  * ntfs_rl_mm - runlist memmove
diff -Nru a/fs/ntfs/runlist.h b/fs/ntfs/runlist.h
--- a/fs/ntfs/runlist.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/runlist.h	2004-10-19 10:14:07 +01:00
@@ -28,6 +28,34 @@
 #include "layout.h"
 #include "volume.h"
 
+/**
+ * runlist_element - in memory vcn to lcn mapping array element
+ * @vcn:	starting vcn of the current array element
+ * @lcn:	starting lcn of the current array element
+ * @length:	length in clusters of the current array element
+ *
+ * The last vcn (in fact the last vcn + 1) is reached when length == 0.
+ *
+ * When lcn == -1 this means that the count vcns starting at vcn are not
+ * physically allocated (i.e. this is a hole / data is sparse).
+ */
+typedef struct {	/* In memory vcn to lcn mapping structure element. */
+	VCN vcn;	/* vcn = Starting virtual cluster number. */
+	LCN lcn;	/* lcn = Starting logical cluster number. */
+	s64 length;	/* Run length in clusters. */
+} runlist_element;
+
+/**
+ * runlist - in memory vcn to lcn mapping array including a read/write lock
+ * @rl:		pointer to an array of runlist elements
+ * @lock:	read/write spinlock for serializing access to @rl
+ *
+ */
+typedef struct {
+	runlist_element *rl;
+	struct rw_semaphore lock;
+} runlist;
+
 static inline void ntfs_init_runlist(runlist *rl)
 {
 	rl->rl = NULL;
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/super.c	2004-10-19 10:14:07 +01:00
@@ -31,12 +31,15 @@
 #include <linux/moduleparam.h>
 #include <linux/smp_lock.h>
 
-#include "ntfs.h"
 #include "sysctl.h"
 #include "logfile.h"
 #include "quota.h"
 #include "dir.h"
+#include "debug.h"
 #include "index.h"
+#include "aops.h"
+#include "malloc.h"
+#include "ntfs.h"
 
 /* Number of mounted file systems which have compression enabled. */
 static unsigned long ntfs_nr_compression_users;
diff -Nru a/fs/ntfs/types.h b/fs/ntfs/types.h
--- a/fs/ntfs/types.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/types.h	2004-10-19 10:14:07 +01:00
@@ -53,34 +53,6 @@
 typedef s64 LSN;
 typedef sle64 leLSN;
 
-/**
- * runlist_element - in memory vcn to lcn mapping array element
- * @vcn:	starting vcn of the current array element
- * @lcn:	starting lcn of the current array element
- * @length:	length in clusters of the current array element
- *
- * The last vcn (in fact the last vcn + 1) is reached when length == 0.
- *
- * When lcn == -1 this means that the count vcns starting at vcn are not
- * physically allocated (i.e. this is a hole / data is sparse).
- */
-typedef struct {	/* In memory vcn to lcn mapping structure element. */
-	VCN vcn;	/* vcn = Starting virtual cluster number. */
-	LCN lcn;	/* lcn = Starting logical cluster number. */
-	s64 length;	/* Run length in clusters. */
-} runlist_element;
-
-/**
- * runlist - in memory vcn to lcn mapping array including a read/write lock
- * @rl:		pointer to an array of runlist elements
- * @lock:	read/write spinlock for serializing access to @rl
- *
- */
-typedef struct {
-	runlist_element *rl;
-	struct rw_semaphore lock;
-} runlist;
-
 typedef enum {
 	FALSE = 0,
 	TRUE = 1
diff -Nru a/fs/ntfs/unistr.c b/fs/ntfs/unistr.c
--- a/fs/ntfs/unistr.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/unistr.c	2004-10-19 10:14:07 +01:00
@@ -19,6 +19,8 @@
  * Foundation,Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include "types.h"
+#include "debug.h"
 #include "ntfs.h"
 
 /*
diff -Nru a/fs/ntfs/upcase.c b/fs/ntfs/upcase.c
--- a/fs/ntfs/upcase.c	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/upcase.c	2004-10-19 10:14:07 +01:00
@@ -24,6 +24,7 @@
  * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include "malloc.h"
 #include "ntfs.h"
 
 ntfschar *generate_default_upcase(void)
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	2004-10-19 10:14:07 +01:00
+++ b/fs/ntfs/volume.h	2004-10-19 10:14:07 +01:00
@@ -24,6 +24,8 @@
 #ifndef _LINUX_NTFS_VOLUME_H
 #define _LINUX_NTFS_VOLUME_H
 
+#include <linux/rwsem.h>
+
 #include "types.h"
 #include "layout.h"
 
