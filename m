Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVCVAIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVCVAIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVCVAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:06:32 -0500
Received: from [213.186.44.138] ([213.186.44.138]:30213 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262144AbVCVACO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:02:14 -0500
Date: Tue, 22 Mar 2005 01:02:10 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: Make NFS userspace and server directories cookies independant [patch, fc3, 2.6.10-1.766_FC3]
Message-ID: <20050322000210.GA4681@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	nfs@lists.sourceforge.net
References: <20050321162142.GB46055@dspnet.fr.eu.org> <1111427218.10508.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1111427218.10508.27.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 12:46:58PM -0500, Trond Myklebust wrote:
> må den 21.03.2005 Klokka 17:21 (+0100) skreiv Olivier Galibert:
> 
> > Patch is against a fedora core 3 2.6.10, it requires minor
> > modifications (context change, not contents) in the nfs_do_filldir par
> > of the dir.c change to account for the dirent addition to apply to
> > 2.6.11.  I can update it if useful.
> > 
> 
> If you could please update it for 2.6.12-rc1, then I'll be able to queue
> it up for testing and possible inclusion in 2.6.13.

Here we go.  Forgot to add I removed a useless parameter "page" from
find_direct.  It's in desc->page in any case.

  OG.

Signed-off-by: Olivier Galibert <galibert@pobox.com>

 fs/nfs/dir.c           |  114 ++++++++++++++++++++++++++++++++++++++-----------
 fs/nfs/inode.c         |    2 
 include/linux/nfs_fs.h |    3 +
 3 files changed, 95 insertions(+), 24 deletions(-)

--- linux-2.6.12-rc1-orig/fs/nfs/dir.c	2005-03-22 00:12:17.000000000 +0100
+++ linux-2.6.12-rc1/fs/nfs/dir.c	2005-03-22 00:44:23.000000000 +0100
@@ -116,7 +116,9 @@ typedef struct {
 	struct page	*page;
 	unsigned long	page_index;
 	u32		*ptr;
-	u64		target;
+	u64		target_cookie;
+	int		target_index;
+	int		current_index;
 	struct nfs_entry *entry;
 	decode_dirent_t	decode;
 	int		plus;
@@ -202,14 +204,14 @@ void dir_page_release(nfs_readdir_descri
 
 /*
  * Given a pointer to a buffer that has already been filled by a call
- * to readdir, find the next entry.
+ * to readdir, find the next entry with cookie 'desc->target_cookie'.
  *
  * If the end of the buffer has been reached, return -EAGAIN, if not,
  * return the offset within the buffer of the next entry to be
  * read.
  */
 static inline
-int find_dirent(nfs_readdir_descriptor_t *desc, struct page *page)
+int find_dirent(nfs_readdir_descriptor_t *desc)
 {
 	struct nfs_entry *entry = desc->entry;
 	int		loop_count = 0,
@@ -217,7 +219,7 @@ int find_dirent(nfs_readdir_descriptor_t
 
 	while((status = dir_decode(desc)) == 0) {
 		dfprintk(VFS, "NFS: found cookie %Lu\n", (long long)entry->cookie);
-		if (entry->prev_cookie == desc->target)
+		if (entry->prev_cookie == desc->target_cookie)
 			break;
 		if (loop_count++ > 200) {
 			loop_count = 0;
@@ -229,8 +231,44 @@ int find_dirent(nfs_readdir_descriptor_t
 }
 
 /*
- * Find the given page, and call find_dirent() in order to try to
- * return the next entry.
+ * Given a pointer to a buffer that has already been filled by a call
+ * to readdir, find the entry at offset 'desc->target_index'.
+ *
+ * If the end of the buffer has been reached, return -EAGAIN, if not,
+ * return the offset within the buffer of the next entry to be
+ * read.
+ */
+static inline
+int find_dirent_index(nfs_readdir_descriptor_t *desc)
+{
+	struct nfs_entry *entry = desc->entry;
+	int		loop_count = 0,
+			status;
+
+	for(;;) {
+		status = dir_decode(desc);
+		if (status)
+			break;
+
+		dfprintk(VFS, "NFS: found cookie %Lu at index %d\n", (long long)entry->cookie, desc->current_index);
+
+		if (desc->target_index == desc->current_index) {
+			desc->target_cookie = entry->cookie;
+			break;
+		}
+		desc->current_index++;
+		if (loop_count++ > 200) {
+			loop_count = 0;
+			schedule();
+		}
+	}
+	dfprintk(VFS, "NFS: find_dirent_index() returns %d\n", status);
+	return status;
+}
+
+/*
+ * Find the given page, and call find_dirent() or find_dirent_index in
+ * order to try to return the next entry.
  */
 static inline
 int find_dirent_page(nfs_readdir_descriptor_t *desc)
@@ -253,7 +291,10 @@ int find_dirent_page(nfs_readdir_descrip
 	/* NOTE: Someone else may have changed the READDIRPLUS flag */
 	desc->page = page;
 	desc->ptr = kmap(page);		/* matching kunmap in nfs_do_filldir */
-	status = find_dirent(desc, page);
+	if (desc->target_cookie)
+		status = find_dirent(desc);
+	else
+		status = find_dirent_index(desc);
 	if (status < 0)
 		dir_page_release(desc);
  out:
@@ -268,7 +309,8 @@ int find_dirent_page(nfs_readdir_descrip
  * Recurse through the page cache pages, and return a
  * filled nfs_entry structure of the next directory entry if possible.
  *
- * The target for the search is 'desc->target'.
+ * The target for the search is 'desc->target_cookie' if non-0,
+ * 'desc->target_index' otherwise
  */
 static inline
 int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
@@ -276,7 +318,19 @@ int readdir_search_pagecache(nfs_readdir
 	int		loop_count = 0;
 	int		res;
 
-	dfprintk(VFS, "NFS: readdir_search_pagecache() searching for cookie %Lu\n", (long long)desc->target);
+	if (desc->target_cookie)
+		dfprintk(VFS, "NFS: readdir_search_pagecache() searching for cookie %Lu\n", (long long)desc->target_cookie);
+	else
+		dfprintk(VFS, "NFS: readdir_search_pagecache() searching for cookie number %d\n", desc->target_index);
+
+	/* Always search-by-index from the beginning of the cache */
+	if (!(desc->target_cookie)) {
+		desc->page_index = 0;
+		desc->entry->cookie = desc->entry->prev_cookie = 0;
+		desc->entry->eof = 0;
+		desc->current_index = 0;
+	}
+
 	for (;;) {
 		res = find_dirent_page(desc);
 		if (res != -EAGAIN)
@@ -309,11 +363,12 @@ int nfs_do_filldir(nfs_readdir_descripto
 	struct file	*file = desc->file;
 	struct nfs_entry *entry = desc->entry;
 	struct dentry	*dentry = NULL;
+	struct nfs_open_context *ctx = file->private_data;
 	unsigned long	fileid;
 	int		loop_count = 0,
 			res;
 
-	dfprintk(VFS, "NFS: nfs_do_filldir() filling starting @ cookie %Lu\n", (long long)desc->target);
+	dfprintk(VFS, "NFS: nfs_do_filldir() filling starting @ cookie %Lu\n", (long long)entry->cookie);
 
 	for(;;) {
 		unsigned d_type = DT_UNKNOWN;
@@ -333,10 +388,10 @@ int nfs_do_filldir(nfs_readdir_descripto
 		}
 
 		res = filldir(dirent, entry->name, entry->len, 
-			      entry->prev_cookie, fileid, d_type);
+			      file->f_pos, fileid, d_type);
 		if (res < 0)
 			break;
-		file->f_pos = desc->target = entry->cookie;
+		file->f_pos++;
 		if (dir_decode(desc) != 0) {
 			desc->page_index ++;
 			break;
@@ -346,10 +401,13 @@ int nfs_do_filldir(nfs_readdir_descripto
 			schedule();
 		}
 	}
+	ctx->dir_pos        = file->f_pos;
+	ctx->dir_cookie     = entry->cookie;
+	desc->target_cookie = entry->cookie;
 	dir_page_release(desc);
 	if (dentry != NULL)
 		dput(dentry);
-	dfprintk(VFS, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n", (long long)desc->target, res);
+	dfprintk(VFS, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n", (long long)ctx->dir_cookie, res);
 	return res;
 }
 
@@ -375,14 +433,14 @@ int uncached_readdir(nfs_readdir_descrip
 	struct page	*page = NULL;
 	int		status;
 
-	dfprintk(VFS, "NFS: uncached_readdir() searching for cookie %Lu\n", (long long)desc->target);
+	dfprintk(VFS, "NFS: uncached_readdir() searching for cookie %Lu\n", (long long)desc->target_cookie);
 
 	page = alloc_page(GFP_HIGHUSER);
 	if (!page) {
 		status = -ENOMEM;
 		goto out;
 	}
-	desc->error = NFS_PROTO(inode)->readdir(file->f_dentry, cred, desc->target,
+	desc->error = NFS_PROTO(inode)->readdir(file->f_dentry, cred, desc->target_cookie,
 						page,
 						NFS_SERVER(inode)->dtsize,
 						desc->plus);
@@ -391,7 +449,7 @@ int uncached_readdir(nfs_readdir_descrip
 	desc->ptr = kmap(page);		/* matching kunmap in nfs_do_filldir */
 	if (desc->error >= 0) {
 		if ((status = dir_decode(desc)) == 0)
-			desc->entry->prev_cookie = desc->target;
+			desc->entry->prev_cookie = desc->target_cookie;
 	} else
 		status = -EIO;
 	if (status < 0)
@@ -412,13 +470,15 @@ int uncached_readdir(nfs_readdir_descrip
 	goto out;
 }
 
-/* The file offset position is now represented as a true offset into the
- * page cache as is the case in most of the other filesystems.
+/* The file offset position represents the dirent entry number.  A
+   last cookie cache takes care of the common case of reading the
+   whole directory.
  */
 static int nfs_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
+	struct nfs_open_context *ctx = filp->private_data;
 	nfs_readdir_descriptor_t my_desc,
 			*desc = &my_desc;
 	struct nfs_entry my_entry;
@@ -435,17 +495,22 @@ static int nfs_readdir(struct file *filp
 	}
 
 	/*
-	 * filp->f_pos points to the file offset in the page cache.
-	 * but if the cache has meanwhile been zapped, we need to
-	 * read from the last dirent to revalidate f_pos
-	 * itself.
+	 * filp->f_pos points to the dirent entry number.
+	 * ctx->dir_pos has the number of the cached cookie.  We have
+	 * to either find the entry with the appropriate number or
+	 * revalidate the cookie.
 	 */
 	memset(desc, 0, sizeof(*desc));
 
 	desc->file = filp;
-	desc->target = filp->f_pos;
 	desc->decode = NFS_PROTO(inode)->decode_dirent;
 	desc->plus = NFS_USE_READDIRPLUS(inode);
+	desc->target_index = filp->f_pos;
+
+	if (filp->f_pos == ctx->dir_pos)
+		desc->target_cookie = ctx->dir_cookie;
+	else
+		desc->target_cookie = 0;
 
 	my_entry.cookie = my_entry.prev_cookie = 0;
 	my_entry.eof = 0;
@@ -455,9 +520,10 @@ static int nfs_readdir(struct file *filp
 
 	while(!desc->entry->eof) {
 		res = readdir_search_pagecache(desc);
+
 		if (res == -EBADCOOKIE) {
 			/* This means either end of directory */
-			if (desc->entry->cookie != desc->target) {
+			if (desc->target_cookie && desc->entry->cookie != desc->target_cookie) {
 				/* Or that the server has 'lost' a cookie */
 				res = uncached_readdir(desc, dirent, filldir);
 				if (res >= 0)
--- linux-2.6.12-rc1-orig/fs/nfs/inode.c	2005-03-22 00:12:17.000000000 +0100
+++ linux-2.6.12-rc1/fs/nfs/inode.c	2005-03-22 00:42:20.000000000 +0100
@@ -851,6 +851,8 @@ struct nfs_open_context *alloc_nfs_open_
 		ctx->state = NULL;
 		ctx->lockowner = current->files;
 		ctx->error = 0;
+		ctx->dir_pos = 0;
+		ctx->dir_cookie = 0;
 		init_waitqueue_head(&ctx->waitq);
 	}
 	return ctx;
--- linux-2.6.12-rc1-orig/include/linux/nfs_fs.h	2005-03-22 00:12:17.000000000 +0100
+++ linux-2.6.12-rc1/include/linux/nfs_fs.h	2005-03-22 00:42:20.000000000 +0100
@@ -97,6 +97,9 @@ struct nfs_open_context {
 
 	struct list_head list;
 	wait_queue_head_t waitq;
+
+	int dir_pos;		/* Directory cookie cache */
+	__u64 dir_cookie;
 };
 
 /*
