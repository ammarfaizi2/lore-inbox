Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268137AbTBMSWJ>; Thu, 13 Feb 2003 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268139AbTBMSWI>; Thu, 13 Feb 2003 13:22:08 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:43747 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268137AbTBMSWF>; Thu, 13 Feb 2003 13:22:05 -0500
Message-ID: <3E4BE499.90305@namesys.com>
Date: Thu, 13 Feb 2003 21:31:53 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] 2.4 ReiserFS Direct IO bugfix patch
Content-Type: multipart/mixed;
 boundary="------------010003000603030607080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010003000603030607080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


-- 
Hans


--------------010003000603030607080505
Content-Type: message/rfc822;
 name="2.4 patch to forward"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4 patch to forward"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 14525 invoked from network); 13 Feb 2003 13:33:09 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 13 Feb 2003 13:33:09 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 33D1344D5CE; Thu, 13 Feb 2003 16:33:06 +0300 (MSK)
Date: Thu, 13 Feb 2003 16:33:06 +0300
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: 2.4 patch to forward
Message-ID: <20030213163305.A4419@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

    This is the fix for the problem where DIRECT IO on a file that
    later will be tail-packed can cause reiserfs to crash
    in 2.4 kernels.

    It can be pulled from bk://namesys.com/bk/reiser3-linux-2.4-directio-fix

    Please apply, thanks.

Diffstat:
 inode.c           |   43 +++++++++++++++++++++++++++++++++++--------
 tail_conversion.c |    4 +++-
 2 files changed, 38 insertions(+), 9 deletions(-)

Plain text patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.967   -> 1.968  
#	 fs/reiserfs/inode.c	1.41    -> 1.42   
#	fs/reiserfs/tail_conversion.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/13	green@angband.namesys.com	1.968
# reiserfs: Fix DIRECT IO interference with tail packing
# --------------------------------------------
#
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Thu Feb 13 16:22:56 2003
+++ b/fs/reiserfs/inode.c	Thu Feb 13 16:22:56 2003
@@ -418,6 +418,7 @@
 			struct buffer_head * bh_result, int create) {
     int ret ;
 
+    bh_result->b_page = NULL;
     ret = reiserfs_get_block(inode, block, bh_result, create) ;
 
     /* don't allow direct io onto tail pages */
@@ -428,6 +429,14 @@
 	reiserfs_unmap_buffer(bh_result);
         ret = -EINVAL ;
     }
+    /* Possible unpacked tail. Flush the data before pages have
+       disappeared */
+    if (inode->u.reiserfs_i.i_flags & i_pack_on_close_mask) {
+	lock_kernel();
+	reiserfs_commit_for_inode(inode);
+	inode->u.reiserfs_i.i_flags &= ~i_pack_on_close_mask;
+	unlock_kernel();
+    }
     return ret ;
 }
 
@@ -566,7 +575,12 @@
 	return ret;
     }
 
-    inode->u.reiserfs_i.i_flags |= i_pack_on_close_mask;
+    /* If file is of such a size, that it might have a tail and tails are enabled
+    ** we should mark it as possibly needing tail packing on close
+    */
+    if ( (have_large_tails (inode->i_sb) && inode->i_size < block_size (inode)*4) ||
+	 (have_small_tails (inode->i_sb) && inode->i_size < block_size(inode)) )
+	inode->u.reiserfs_i.i_flags |= i_pack_on_close_mask;
 
     windex = push_journal_writer("reiserfs_get_block") ;
   
@@ -757,15 +771,21 @@
 	    */
 	    mark_buffer_uptodate (unbh, 1);
 
-	    /* we've converted the tail, so we must 
-	    ** flush unbh before the transaction commits
+	    /* unbh->b_page == NULL in case of DIRECT_IO request, this means
+	       buffer will disappear shortly, so it should not be added to
+	       any of our lists.
 	    */
-	    add_to_flushlist(inode, unbh) ;
+	    if ( unbh->b_page ) {
+		/* we've converted the tail, so we must 
+		** flush unbh before the transaction commits
+		*/
+		add_to_flushlist(inode, unbh) ;
 
-	    /* mark it dirty now to prevent commit_write from adding
-	     ** this buffer to the inode's dirty buffer list
-	     */
-	    __mark_buffer_dirty(unbh) ;
+		/* mark it dirty now to prevent commit_write from adding
+		 ** this buffer to the inode's dirty buffer list
+		 */
+		__mark_buffer_dirty(unbh) ;
+	    }
 
 	    //inode->i_blocks += inode->i_sb->s_blocksize / 512;
 	    //mark_tail_converted (inode);
@@ -2062,6 +2082,13 @@
     if (pos > inode->i_size) {
 	struct reiserfs_transaction_handle th ;
 	lock_kernel();
+	/* If the file have grown beyond the border where it
+	   can have a tail, unmark it as needing a tail
+	   packing */
+	if ( (have_large_tails (inode->i_sb) && inode->i_size < block_size (inode)*4) ||
+	     (have_small_tails (inode->i_sb) && inode->i_size < block_size(inode)) )
+	    inode->u.reiserfs_i.i_flags &= ~i_pack_on_close_mask;
+
 	journal_begin(&th, inode->i_sb, 1) ;
 	reiserfs_update_inode_transaction(inode) ;
 	inode->i_size = pos ;
diff -Nru a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
--- a/fs/reiserfs/tail_conversion.c	Thu Feb 13 16:22:56 2003
+++ b/fs/reiserfs/tail_conversion.c	Thu Feb 13 16:22:56 2003
@@ -105,8 +105,10 @@
 	/* we only send the unbh pointer if the buffer is not up to date.
 	** this avoids overwriting good data from writepage() with old data
 	** from the disk or buffer cache
+	** Special case: unbh->b_page will be NULL if we are coming through
+	** DIRECT_IO handler here.
 	*/
-	if (buffer_uptodate(unbh) || Page_Uptodate(unbh->b_page)) {
+	if ( !unbh->b_page || buffer_uptodate(unbh) || Page_Uptodate(unbh->b_page)) {
 	    up_to_date_bh = NULL ;
 	} else {
 	    up_to_date_bh = unbh ;

Bye,
    Oleg



--------------010003000603030607080505--

