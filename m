Return-Path: <linux-kernel-owner+w=401wt.eu-S965170AbWL2Vvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWL2Vvi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWL2Vvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:51:38 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:54082 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965170AbWL2Vvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:51:37 -0500
Message-ID: <45958E0F.2020309@yahoo.fr>
Date: Fri, 29 Dec 2006 22:52:15 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Factor outstanding I/O error handling
Content-Type: multipart/mixed;
 boundary="------------040105070708070207090208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040105070708070207090208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Against 2.6.20-rc2, first some cleanup, then a bug fix.

-- 
Guillaume


--------------040105070708070207090208
Content-Type: text/x-patch;
 name="01-factor-outstanding-error-handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-factor-outstanding-error-handling.diff"

Cleanup: setting an outstanding error on a mapping was open coded too
many times. Factor it out in mapping_set_error().

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
---

 fs/gfs2/glops.c         |    5 +----
 fs/mpage.c              |   16 ++--------------
 include/linux/pagemap.h |   10 ++++++++++
 mm/page-writeback.c     |    7 +------
 mm/vmscan.c             |    8 ++------
 5 files changed, 16 insertions(+), 30 deletions(-)

diff -r 3859b1144d3a fs/gfs2/glops.c
--- a/fs/gfs2/glops.c	Sun Dec 24 05:00:03 2006 +0000
+++ b/fs/gfs2/glops.c	Fri Dec 29 22:13:21 2006 +0100
@@ -213,10 +213,7 @@ static void inode_go_sync(struct gfs2_gl
 		if (ip) {
 			struct address_space *mapping = ip->i_inode.i_mapping;
 			int error = filemap_fdatawait(mapping);
-			if (error == -ENOSPC)
-				set_bit(AS_ENOSPC, &mapping->flags);
-			else if (error)
-				set_bit(AS_EIO, &mapping->flags);
+			mapping_set_error(mapping, error);
 		}
 		clear_bit(GLF_DIRTY, &gl->gl_flags);
 		gfs2_ail_empty_gl(gl);
diff -r 3859b1144d3a fs/mpage.c
--- a/fs/mpage.c	Sun Dec 24 05:00:03 2006 +0000
+++ b/fs/mpage.c	Fri Dec 29 22:12:09 2006 +0100
@@ -663,12 +663,7 @@ confused:
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
-	if (*ret) {
-		if (*ret == -ENOSPC)
-			set_bit(AS_ENOSPC, &mapping->flags);
-		else
-			set_bit(AS_EIO, &mapping->flags);
-	}
+	mapping_set_error(mapping, *ret);
 out:
 	return bio;
 }
@@ -776,14 +771,7 @@ retry:
 
 			if (writepage) {
 				ret = (*writepage)(page, wbc);
-				if (ret) {
-					if (ret == -ENOSPC)
-						set_bit(AS_ENOSPC,
-							&mapping->flags);
-					else
-						set_bit(AS_EIO,
-							&mapping->flags);
-				}
+				mapping_set_error(mapping, ret);
 			} else {
 				bio = __mpage_writepage(bio, page, get_block,
 						&last_block_in_bio, &ret, wbc,
diff -r 3859b1144d3a include/linux/pagemap.h
--- a/include/linux/pagemap.h	Sun Dec 24 05:00:03 2006 +0000
+++ b/include/linux/pagemap.h	Fri Dec 29 22:09:01 2006 +0100
@@ -19,6 +19,16 @@
 #define	AS_EIO		(__GFP_BITS_SHIFT + 0)	/* IO error on async write */
 #define AS_ENOSPC	(__GFP_BITS_SHIFT + 1)	/* ENOSPC on async write */
 
+static inline void mapping_set_error(struct address_space * mapping, int error)
+{
+	if (error) {
+		if (error == -ENOSPC)
+			set_bit(AS_ENOSPC, &mapping->flags);
+		else
+			set_bit(AS_EIO, &mapping->flags);
+	}
+}
+
 static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
 {
 	return (__force gfp_t)mapping->flags & __GFP_BITS_MASK;
diff -r 3859b1144d3a mm/page-writeback.c
--- a/mm/page-writeback.c	Sun Dec 24 05:00:03 2006 +0000
+++ b/mm/page-writeback.c	Fri Dec 29 22:19:30 2006 +0100
@@ -651,12 +651,7 @@ retry:
 			}
 
 			ret = (*writepage)(page, wbc);
-			if (ret) {
-				if (ret == -ENOSPC)
-					set_bit(AS_ENOSPC, &mapping->flags);
-				else
-					set_bit(AS_EIO, &mapping->flags);
-			}
+			mapping_set_error(mapping, ret);
 
 			if (unlikely(ret == AOP_WRITEPAGE_ACTIVATE))
 				unlock_page(page);
diff -r 3859b1144d3a mm/vmscan.c
--- a/mm/vmscan.c	Sun Dec 24 05:00:03 2006 +0000
+++ b/mm/vmscan.c	Fri Dec 29 22:14:33 2006 +0100
@@ -284,12 +284,8 @@ static void handle_write_error(struct ad
 				struct page *page, int error)
 {
 	lock_page(page);
-	if (page_mapping(page) == mapping) {
-		if (error == -ENOSPC)
-			set_bit(AS_ENOSPC, &mapping->flags);
-		else
-			set_bit(AS_EIO, &mapping->flags);
-	}
+	if (page_mapping(page) == mapping)
+		mapping_set_error(mapping, error);
 	unlock_page(page);
 }
 

--------------040105070708070207090208--
