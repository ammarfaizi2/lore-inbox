Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLJOOQ>; Sun, 10 Dec 2000 09:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLJOOF>; Sun, 10 Dec 2000 09:14:05 -0500
Received: from [212.32.186.211] ([212.32.186.211]:48328 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129228AbQLJON5>; Sun, 10 Dec 2000 09:13:57 -0500
Date: Sun, 10 Dec 2000 14:43:26 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs writepage & struct file
In-Reply-To: <Pine.LNX.4.10.10012051530100.13428-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012062145570.18265-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Linus Torvalds wrote:

> In comparison to these dentry host problems, your patch looks fine. But I
> suspect that you _can_ trigger the BUG() with an empty dentry list due to
> dentry shrinking. So what I did is basically to (a) apply your patch and
> (b) set writepage to NULL in the address space operations, so that shared
> mappings will be disabled for the time being.

A simple fix for this seems to be just not looking at the dentry. Turns
out it is only used to find the inode anyway ...
(and for a debug printout of the filename)

Replaced smb_invent_inos with iunique.

Changed the smb_proc_read to use an inode argument too, for symmetry with
smb_proc_write. smb_readpage_sync needs the dentry since it calls smb_open
(what a strange thing to do ... see below) and needs to find the pathname.

smb_file_open doesn't actually open anything on the remote end. So for
mmap you can open, mmap, write to mem, msync and writepage gets called on
a file the server doesn't consider opened. It will work the first time
since readpage opens the file, but not the second if the page cache
already has the page.

writepage enabled again, although I think there are problems with
reconnections (a file you had open is no longer open after reconnect).

Below a patch for this vs 2.4.0-test12-pre7.


If the aliasing of inodes&pages only affects efficiency of caching in
smbfs I think that may be acceptable. With nothing good to use for ino's I
don't see any simple inexpensive way to map filenames to inodes which
would be necessary to avoid aliases.
(Any smbfs-inode with pages could be placed on a list/hash with the
 pathname attached. Lookup would search that list to avoid creating
 aliases. Or something clever. Abusing the dcache so that dentries for
 smbfs are not dropped while the inode is in use? If that is even
 possible.)

Or is it possible to loose data because of aliased pages? even if the
application(s) do proper locking/msync/... Is it possible to get two pages
of the same file but the two pages in the page cache disagree on the
contents, and both can be written to the fs?

/Urban


diff -ur -X exclude linux-2.4.0-test12-pre7-orig/fs/smbfs/dir.c linux-2.4.0-test12-pre7-smbfs/fs/smbfs/dir.c
--- linux-2.4.0-test12-pre7-orig/fs/smbfs/dir.c	Mon Aug 14 22:31:10 2000
+++ linux-2.4.0-test12-pre7-smbfs/fs/smbfs/dir.c	Thu Dec  7 22:11:09 2000
@@ -124,7 +124,7 @@
 			qname.len  = entry->len;
 			entry->ino = find_inode_number(dentry, &qname);
 			if (!entry->ino)
-				entry->ino = smb_invent_inos(1);
+				entry->ino = iunique(dentry->d_sb, 2);
 		}
 
 		if (filldir(dirent, entry->name, entry->len, 
@@ -325,7 +325,7 @@
 		goto add_entry;
 	if (!error) {
 		error = -EACCES;
-		finfo.f_ino = smb_invent_inos(1);
+		finfo.f_ino = iunique(dentry->d_sb, 2);
 		inode = smb_iget(dir->i_sb, &finfo);
 		if (inode) {
 	add_entry:
@@ -362,7 +362,7 @@
 		goto out_close;
 
 	smb_renew_times(dentry);
-	fattr.f_ino = smb_invent_inos(1);
+	fattr.f_ino = iunique(dentry->d_sb, 2);
 	inode = smb_iget(dentry->d_sb, &fattr);
 	if (!inode)
 		goto out_no_inode;
diff -ur -X exclude linux-2.4.0-test12-pre7-orig/fs/smbfs/file.c linux-2.4.0-test12-pre7-smbfs/fs/smbfs/file.c
--- linux-2.4.0-test12-pre7-orig/fs/smbfs/file.c	Thu Dec  7 20:29:38 2000
+++ linux-2.4.0-test12-pre7-smbfs/fs/smbfs/file.c	Sun Dec 10 14:21:32 2000
@@ -48,8 +48,7 @@
 		DENTRY_PATH(dentry), count, offset, rsize);
 
 	result = smb_open(dentry, SMB_O_RDONLY);
-	if (result < 0)
-	{
+	if (result < 0) {
 		PARANOIA("%s/%s open failed, error=%d\n",
 			 DENTRY_PATH(dentry), result);
 		goto io_error;
@@ -59,7 +58,7 @@
 		if (count < rsize)
 			rsize = count;
 
-		result = smb_proc_read(dentry, offset, rsize, buffer);
+		result = smb_proc_read(dentry->d_inode, offset, rsize, buffer);
 		if (result < 0)
 			goto io_error;
 
@@ -103,25 +102,27 @@
  * Offset is the data offset within the page.
  */
 static int
-smb_writepage_sync(struct dentry *dentry, struct page *page,
+smb_writepage_sync(struct inode *inode, struct page *page,
 		   unsigned long offset, unsigned int count)
 {
-	struct inode *inode = dentry->d_inode;
 	u8 *buffer = page_address(page) + offset;
-	int wsize = smb_get_wsize(server_from_dentry(dentry));
+	int wsize = smb_get_wsize(server_from_inode(inode));
 	int result, written = 0;
 
 	offset += page->index << PAGE_CACHE_SHIFT;
-	VERBOSE("file %s/%s, count=%d@%ld, wsize=%d\n",
-		DENTRY_PATH(dentry), count, offset, wsize);
+	VERBOSE("file ino=%ld, fileid=%d, count=%d@%ld, wsize=%d\n",
+		inode->i_ino, inode->u.smbfs_i.fileid, count, offset, wsize);
 
 	do {
 		if (count < wsize)
 			wsize = count;
 
-		result = smb_proc_write(dentry, offset, wsize, buffer);
-		if (result < 0)
+		result = smb_proc_write(inode, offset, wsize, buffer);
+		if (result < 0) {
+			PARANOIA("failed write, wsize=%d, result=%d\n",
+				 wsize, result);
 			break;
+		}
 		/* N.B. what if result < wsize?? */
 #ifdef SMBFS_PARANOIA
 		if (result < wsize)
@@ -153,9 +154,7 @@
 smb_writepage(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
-	struct dentry *dentry;
 	struct inode *inode;
-	struct list_head *head;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
@@ -166,12 +165,6 @@
 	if (!inode)
 		BUG();
 
-	/* Pick the first dentry for this inode. */
-	head = &inode->i_dentry;
-	if (list_empty(head))
-		BUG();	/* We need one, are we guaranteed to have one?  */
-	dentry = list_entry(head->next, struct dentry, d_alias);
-
 	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 
 	/* easy case */
@@ -184,7 +177,7 @@
 		return -EIO;
 do_it:
 	get_page(page);
-	err = smb_writepage_sync(dentry, page, 0, offset);
+	err = smb_writepage_sync(inode, page, 0, offset);
 	SetPageUptodate(page);
 	UnlockPage(page);
 	put_page(page);
@@ -200,7 +193,7 @@
 	DEBUG1("(%s/%s %d@%ld)\n", DENTRY_PATH(dentry), 
 	       count, (page->index << PAGE_CACHE_SHIFT)+offset);
 
-	return smb_writepage_sync(dentry, page, offset, count);
+	return smb_writepage_sync(dentry->d_inode, page, offset, count);
 }
 
 static ssize_t
@@ -281,7 +274,7 @@
 
 struct address_space_operations smb_file_aops = {
 	readpage: smb_readpage,
-	/* writepage: smb_writepage, */
+	writepage: smb_writepage,
 	prepare_write: smb_prepare_write,
 	commit_write: smb_commit_write
 };
@@ -325,8 +318,16 @@
 static int
 smb_file_open(struct inode *inode, struct file * file)
 {
+	int result;
+	struct dentry *dentry = file->f_dentry;
+	int smb_mode = (file->f_mode & O_ACCMODE) - 1;
+
 	lock_kernel();
+	result = smb_open(dentry, smb_mode);
+	if (result)
+		goto out;
 	inode->u.smbfs_i.openers++;
+out:
 	unlock_kernel();
 	return 0;
 }
diff -ur -X exclude linux-2.4.0-test12-pre7-orig/fs/smbfs/inode.c linux-2.4.0-test12-pre7-smbfs/fs/smbfs/inode.c
--- linux-2.4.0-test12-pre7-orig/fs/smbfs/inode.c	Thu Nov 16 22:18:26 2000
+++ linux-2.4.0-test12-pre7-smbfs/fs/smbfs/inode.c	Sun Dec 10 14:23:37 2000
@@ -53,22 +53,6 @@
 	statfs:		smb_statfs,
 };
 
-/* FIXME: Look at all inodes whether so that we do not get duplicate
- * inode numbers. */
-
-unsigned long
-smb_invent_inos(unsigned long n)
-{
-	static unsigned long ino = 2;
-
-	if (ino + 2*n < ino)
-	{
-		/* wrap around */
-		ino = 2;
-	}
-	ino += n;
-	return ino;
-}
 
 /* We are always generating a new inode here */
 struct inode *
@@ -282,7 +266,7 @@
 static void
 smb_delete_inode(struct inode *ino)
 {
-	DEBUG1("\n");
+	DEBUG1("ino=%ld\n", ino->i_ino);
 	lock_kernel();
 	if (smb_close(ino))
 		PARANOIA("could not close inode %ld\n", ino->i_ino);
diff -ur -X exclude linux-2.4.0-test12-pre7-orig/fs/smbfs/proc.c linux-2.4.0-test12-pre7-smbfs/fs/smbfs/proc.c
--- linux-2.4.0-test12-pre7-orig/fs/smbfs/proc.c	Mon Aug 14 22:31:10 2000
+++ linux-2.4.0-test12-pre7-smbfs/fs/smbfs/proc.c	Sun Dec 10 14:25:14 2000
@@ -1072,9 +1072,9 @@
    file-id would not be valid after a reconnection. */
 
 int
-smb_proc_read(struct dentry *dentry, off_t offset, int count, char *data)
+smb_proc_read(struct inode *inode, off_t offset, int count, char *data)
 {
-	struct smb_sb_info *server = server_from_dentry(dentry);
+	struct smb_sb_info *server = server_from_inode(inode);
 	__u16 returned_count, data_len;
 	unsigned char *buf;
 	int result;
@@ -1082,7 +1082,7 @@
 	smb_lock_server(server);
 	smb_setup_header(server, SMBread, 5, 0);
 	buf = server->packet;
-	WSET(buf, smb_vwv0, dentry->d_inode->u.smbfs_i.fileid);
+	WSET(buf, smb_vwv0, inode->u.smbfs_i.fileid);
 	WSET(buf, smb_vwv1, count);
 	DSET(buf, smb_vwv2, offset);
 	WSET(buf, smb_vwv4, 0);
@@ -1114,25 +1114,26 @@
 	result = data_len;
 
 out:
-	VERBOSE("file %s/%s, count=%d, result=%d\n",
-		DENTRY_PATH(dentry), count, result);
+	VERBOSE("ino=%ld, fileid=%d, count=%d, result=%d\n",
+		inode->ino, inode->u.smbfs_i.fileid, count, result);
 	smb_unlock_server(server);
 	return result;
 }
 
 int
-smb_proc_write(struct dentry *dentry, off_t offset, int count, const char *data)
+smb_proc_write(struct inode *inode, off_t offset, int count, const char *data)
 {
-	struct smb_sb_info *server = server_from_dentry(dentry);
+	struct smb_sb_info *server = server_from_inode(inode);
 	int result;
 	__u8 *p;
 	
-	VERBOSE("file %s/%s, count=%d@%ld, packet_size=%d\n",
-		DENTRY_PATH(dentry), count, offset, server->packet_size);
+	VERBOSE("ino=%ld, fileid=%d, count=%d@%ld, packet_size=%d\n",
+		inode->ino, inode->u.smbfs_i.fileid, count, offset,
+		server->packet_size);
 
 	smb_lock_server(server);
 	p = smb_setup_header(server, SMBwrite, 5, count + 3);
-	WSET(server->packet, smb_vwv0, dentry->d_inode->u.smbfs_i.fileid);
+	WSET(server->packet, smb_vwv0, inode->u.smbfs_i.fileid);
 	WSET(server->packet, smb_vwv1, count);
 	DSET(server->packet, smb_vwv2, offset);
 	WSET(server->packet, smb_vwv4, 0);
diff -ur -X exclude linux-2.4.0-test12-pre7-orig/include/linux/smb_fs.h linux-2.4.0-test12-pre7-smbfs/include/linux/smb_fs.h
--- linux-2.4.0-test12-pre7-orig/include/linux/smb_fs.h	Thu Dec  7 20:42:42 2000
+++ linux-2.4.0-test12-pre7-smbfs/include/linux/smb_fs.h	Thu Dec  7 21:17:57 2000
@@ -126,8 +126,8 @@
 int smb_close(struct inode *);
 int smb_close_fileid(struct dentry *, __u16);
 int smb_open(struct dentry *, int);
-int smb_proc_read(struct dentry *, off_t, int, char *);
-int smb_proc_write(struct dentry *, off_t, int, const char *);
+int smb_proc_read(struct inode *, off_t, int, char *);
+int smb_proc_write(struct inode *, off_t, int, const char *);
 int smb_proc_create(struct dentry *, __u16, time_t, __u16 *);
 int smb_proc_mv(struct dentry *, struct dentry *);
 int smb_proc_mkdir(struct dentry *);
diff -ur -X exclude linux-2.4.0-test12-pre7-orig/include/linux/smb_fs_sb.h linux-2.4.0-test12-pre7-smbfs/include/linux/smb_fs_sb.h
--- linux-2.4.0-test12-pre7-orig/include/linux/smb_fs_sb.h	Thu Dec  7 20:35:56 2000
+++ linux-2.4.0-test12-pre7-smbfs/include/linux/smb_fs_sb.h	Thu Dec  7 21:11:56 2000
@@ -14,8 +14,9 @@
 #include <linux/types.h>
 #include <linux/smb.h>
 
-/* Get the server for the specified dentry */
-#define server_from_dentry(dentry) &dentry->d_sb->u.smbfs_sb
+/* structure access macros */
+#define server_from_inode(inode) (&(inode)->i_sb->u.smbfs_sb)
+#define server_from_dentry(dentry) (&(dentry)->d_sb->u.smbfs_sb)
 #define SB_of(server) ((struct super_block *) ((char *)(server) - \
 	(unsigned long)(&((struct super_block *)0)->u.smbfs_sb)))
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
