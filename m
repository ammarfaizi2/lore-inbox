Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSIHWab>; Sun, 8 Sep 2002 18:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSIHWaa>; Sun, 8 Sep 2002 18:30:30 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:40916 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315414AbSIHWa2>; Sun, 8 Sep 2002 18:30:28 -0400
Subject: NTFS: Fixup NTFS after kmap() changes in generic_file_write()
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 8 Sep 2002 23:35:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17oAe7-0006Ve-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

This is urgent as NTFS will die horribly on highmem boxes without
this patch since it relies on the page already being kmapped in
->prepare/commit_write() and this is no longer the case...

Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/ntfs/aops.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/09/08 1.575)
   NTFS: Pages are no longer kmapped around calls to
   ->{prepare,commit}_write, adapt NTFS appropriately.


diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Sun Sep  8 23:07:14 2002
+++ b/fs/ntfs/aops.c	Sun Sep  8 23:07:14 2002
@@ -1018,7 +1018,6 @@
 	ntfs_volume *vol;
 	run_list_element *rl;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
-	char *kaddr = page_address(page);
 	unsigned int vcn_ofs, block_start, block_end, blocksize;
 	int err;
 	BOOL is_retry;
@@ -1267,13 +1266,20 @@
 				 * region. NOTE: This is how we decide if to
 				 * zero or not!
 				 */
-				if (block_end > to)
-					memset(kaddr + to, 0, block_end - to);
-				if (block_start < from)
-					memset(kaddr + block_start, 0,
-							from - block_start);
-				if (block_end > to || block_start < from)
+				if (block_end > to || block_start < from) {
+					void *kaddr;
+
+					kaddr = kmap_atomic(page, KM_USER0);
+					if (block_end > to)
+						memset(kaddr + to, 0,
+								block_end - to);
+					if (block_start < from)
+						memset(kaddr + block_start, 0,
+								from -
+								block_start);
 					flush_dcache_page(page);
+					kunmap_atomic(kaddr, KM_USER0);
+				}
 				continue;
 			}
 		}
@@ -1330,10 +1336,14 @@
 		if (block_start >= to)
 			break;
 		if (buffer_new(bh)) {
+			void *kaddr;
+
 			clear_buffer_new(bh);
 			if (buffer_uptodate(bh))
 				buffer_error();
+			kaddr = kmap_atomic(page, KM_USER0);
 			memset(kaddr + block_start, 0, bh->b_size);
+			kunmap_atomic(kaddr, KM_USER0);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
 			is_retry = TRUE;

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020908220434|13926
aia21@cantab.net|ChangeSet|20020908212947|13911
aia21@cantab.net|ChangeSet|20020907104127|04876
aia21@cantab.net|ChangeSet|20020901002342|24934
aia21@cantab.net|ChangeSet|20020831172741|21789
## Wrapped with gzip_uu ##


begin 664 bkpatch31569
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
JCJ_<$SC>&^HQ)Q]<R3^@^N:/8O':QINJR4YU`.)-EM;['_[7`UG1&P``
`
end
