Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130833AbQLEX43>; Tue, 5 Dec 2000 18:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130777AbQLEX4T>; Tue, 5 Dec 2000 18:56:19 -0500
Received: from [212.32.186.211] ([212.32.186.211]:1416 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130399AbQLEX4K>; Tue, 5 Dec 2000 18:56:10 -0500
Date: Wed, 6 Dec 2000 00:25:37 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: smbfs writepage & struct file
In-Reply-To: <Pine.LNX.4.10.10012041906510.2047-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012051959090.3205-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Linus Torvalds wrote:

> Who works on smbfs these days? I see two ways of fixing smbfs now that

That would be me, I guess. This stuff is a bit over my current level of
understanding so try not to laugh too hard ... :)

Maybe it is best to just disable it for now. Below is a patch that passes
a simple 5 minute test. Included for comments/corrections.

Note that MAP_SHARED doesn't seem to work anyway for smbfs (at least my
testprogram fails to actually write anything in 2.4.0-test11, works vs
ext2). I'll look into that later. I'm not even sure this code is being
called (where is my oops?!).

>  - fetch the dentry that writepage needs by just looking at the
>    inode->i_dentry list and/or just make the smbfs page cache host be the
>    dentry instead of the inode like other filesystems. The first approach
>    assumes that all paths are equal for writeout, the second one assumes
>    that there are no hard linking going on in smbfs.

Hardlinks are not supported by smbfs, but they may be supported on the
server side (ntfs). Haven't looked if smb has anything on this. Not sure
if there are any implications on caching and such for smbfs. (If hardlinks
need to be handled, smbfs is probably broken anyway wrt those).

inode->i_dentry is a list of dentries that relate to this inode? When
would there be >1? (Except hardlinks, we don't have those here.) Is it
guaranteed to always be at least one entry in that list?

The write ends up needing 'dentry->d_inode->u.smbfs_i.fileid' to find the
id to tell the server. I can't now think of a case where the dentry
doesn't map to the one inode we have for this fileid.


I was "borrowing" stuff from the nfs code and this looked strange:

nfs_writepage_sync:
        struct dentry   *dentry = file->f_dentry;
        struct rpc_cred *cred = nfs_file_cred(file);

yet it is called like this from nfs_writepage:
        err = nfs_writepage_sync(NULL, inode, page, 0, offset);

where file is the 1st argument. Oh, it calls nfs_writepage_async most of
the time. All of the time?

/Urban


diff -ur -X exclude linux-2.4.0-test12-pre5-orig/fs/smbfs/file.c linux-2.4.0-test12-pre5-smbfs/fs/smbfs/file.c
--- linux-2.4.0-test12-pre5-orig/fs/smbfs/file.c	Sun Aug  6 20:43:18 2000
+++ linux-2.4.0-test12-pre5-smbfs/fs/smbfs/file.c	Tue Dec  5 23:43:30 2000
@@ -82,7 +82,7 @@
 }
 
 /*
- * We are called with the page locked and the caller unlocks.
+ * We are called with the page locked and we unlock it when done.
  */
 static int
 smb_readpage(struct file *file, struct page *page)
@@ -147,17 +147,33 @@
  * Write a page to the server. This will be used for NFS swapping only
  * (for now), and we currently do this synchronously only.
  *
- * We are called with the page locked and the caller unlocks.
+ * We are called with the page locked and we unlock it when done.
  */
 static int
-smb_writepage(struct file *file, struct page *page)
+smb_writepage(struct page *page)
 {
-	struct dentry *dentry = file->f_dentry;
-	struct inode *inode = dentry->d_inode;
-	unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+	struct address_space *mapping = page->mapping;
+	struct dentry *dentry;
+	struct inode *inode;
+	struct list_head *head;
+	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
 
+	if (!mapping)
+		BUG();
+	inode = (struct inode *)mapping->host;
+	if (!inode)
+		BUG();
+
+	/* Pick the first dentry for this inode. */
+	head = &inode->i_dentry;
+	if (list_empty(head))
+		BUG();	/* We need one, are we guaranteed to have one?  */
+	dentry = list_entry(head->next, struct dentry, d_alias);
+
+	end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+
 	/* easy case */
 	if (page->index < end_index)
 		goto do_it;
@@ -170,6 +186,7 @@
 	get_page(page);
 	err = smb_writepage_sync(dentry, page, 0, offset);
 	SetPageUptodate(page);
+	UnlockPage(page);
 	put_page(page);
 	return err;
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
