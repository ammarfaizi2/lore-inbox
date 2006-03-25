Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWCYEMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWCYEMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWCYEMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:12:32 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:16031
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750782AbWCYEMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:12:31 -0500
Date: Fri, 24 Mar 2006 20:12:10 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, viro@ftp.linux.org.uk,
       masouds@google.com
Subject: [PATCH 08/08] Fix ext2 readdir f_pos re-validation logic
Message-ID: <20060325041210.GI16955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325040852.GA16955@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>

This fixes not one, but _two_, silly (but admittedly hard to hit) bugs
in the ext2 filesystem "readdir()" function.  It also cleans up the code
to avoid the unnecessary goto mess.

The bugs were related to re-valiating the f_pos value after somebody had
either done an "lseek()" on the directory to an invalid offset, or when
the offset had become invalid due to a file being unlinked in the
directory.  The code would not only set the f_version too eagerly, it
would also not update f_pos appropriately for when the offset fixup took
place.

When that happened, we'd occasionally subsequently fail the readdir()
even when we shouldn't (no real harm done, but an ugly printk, and
obviously you would end up not necessarily seeing all entries).

Thanks to Masoud Sharbiani <masouds@google.com> who noticed the problem
and had a test-case for it, and also fixed up a thinko in the first
version of this patch.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Masoud Sharbiani <masouds@google.com>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/ext2/dir.c |   28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

2d7f2ea9c989853310c7f6e8be52cc090cc8e66b
--- linux-2.6.15.6.orig/fs/ext2/dir.c
+++ linux-2.6.15.6/fs/ext2/dir.c
@@ -256,11 +256,10 @@ ext2_readdir (struct file * filp, void *
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
 	unsigned char *types = NULL;
-	int need_revalidate = (filp->f_version != inode->i_version);
-	int ret;
+	int need_revalidate = filp->f_version != inode->i_version;
 
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
-		goto success;
+		return 0;
 
 	if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
 		types = ext2_filetype_table;
@@ -275,12 +274,15 @@ ext2_readdir (struct file * filp, void *
 				   "bad page in #%lu",
 				   inode->i_ino);
 			filp->f_pos += PAGE_CACHE_SIZE - offset;
-			ret = -EIO;
-			goto done;
+			return -EIO;
 		}
 		kaddr = page_address(page);
-		if (need_revalidate) {
-			offset = ext2_validate_entry(kaddr, offset, chunk_mask);
+		if (unlikely(need_revalidate)) {
+			if (offset) {
+				offset = ext2_validate_entry(kaddr, offset, chunk_mask);
+				filp->f_pos = (n<<PAGE_CACHE_SHIFT) + offset;
+			}
+			filp->f_version = inode->i_version;
 			need_revalidate = 0;
 		}
 		de = (ext2_dirent *)(kaddr+offset);
@@ -289,9 +291,8 @@ ext2_readdir (struct file * filp, void *
 			if (de->rec_len == 0) {
 				ext2_error(sb, __FUNCTION__,
 					"zero-length directory entry");
-				ret = -EIO;
 				ext2_put_page(page);
-				goto done;
+				return -EIO;
 			}
 			if (de->inode) {
 				int over;
@@ -306,19 +307,14 @@ ext2_readdir (struct file * filp, void *
 						le32_to_cpu(de->inode), d_type);
 				if (over) {
 					ext2_put_page(page);
-					goto success;
+					return 0;
 				}
 			}
 			filp->f_pos += le16_to_cpu(de->rec_len);
 		}
 		ext2_put_page(page);
 	}
-
-success:
-	ret = 0;
-done:
-	filp->f_version = inode->i_version;
-	return ret;
+	return 0;
 }
 
 /*
