Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285398AbRLSQ5N>; Wed, 19 Dec 2001 11:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285397AbRLSQ5E>; Wed, 19 Dec 2001 11:57:04 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:26642 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285398AbRLSQ4z>; Wed, 19 Dec 2001 11:56:55 -0500
Date: Wed, 19 Dec 2001 19:56:53 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] Reiserfs fixes for 2.4.17-rc2
Message-ID: <20011219195653.A29999@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    Attached are 2 fixes for reiserfs in 2.4.17-rc2
    map_block_for_writepage_highmem_fix-1.diff fixes oops on incorerct access to (possibly) unkmapped highmem pages.
    mmaped_data_loss_fix.diff fixes a problem where some data may be lost if mmap-writed data is subsequently appended by
    data written with write(2), and because of that mmapped data is lost. (Originally found by fsx tool)

Bye,
    Oleg

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="map_block_for_writepage_highmem_fix-1.diff"

--- linux/fs/reiserfs/inode.c.orig	Wed Dec 19 16:26:05 2001
+++ linux/fs/reiserfs/inode.c	Wed Dec 19 16:32:02 2001
@@ -1772,6 +1772,7 @@
     int bytes_copied = 0 ;
     int copy_size ;
 
+    kmap(bh_result->b_page) ;
 start_over:
     lock_kernel() ;
     journal_begin(&th, inode->i_sb, jbegin_count) ;
@@ -1844,10 +1845,8 @@
 
     /* this is where we fill in holes in the file. */
     if (use_get_block) {
-        kmap(bh_result->b_page) ;
 	retval = reiserfs_get_block(inode, block, bh_result, 
 	                            GET_BLOCK_CREATE | GET_BLOCK_NO_ISEM) ;
-        kunmap(bh_result->b_page) ;
 	if (!retval) {
 	    if (!buffer_mapped(bh_result) || bh_result->b_blocknr == 0) {
 	        /* get_block failed to find a mapped unformatted node. */
@@ -1856,6 +1855,7 @@
 	    }
 	}
     }
+    kunmap(bh_result->b_page) ;
     return retval ;
 }
 

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmaped_data_loss_fix.diff"

--- linux/fs/reiserfs/inode.c.orig	Tue Dec 18 14:50:24 2001
+++ linux/fs/reiserfs/inode.c	Tue Dec 18 14:52:04 2001
@@ -273,7 +273,9 @@
 	pathrelse (&path);
         if (p)
             kunmap(bh_result->b_page) ;
-	if ((args & GET_BLOCK_NO_HOLE)) {
+	// We do not return -ENOENT if there is a hole but page is uptodate, because it means
+	// That there is some MMAPED data associated with it that is yet to be written to disk.
+	if ((args & GET_BLOCK_NO_HOLE) && !Page_Uptodate(bh_result->b_page) ) {
 	    return -ENOENT ;
 	}
         return 0 ;
@@ -294,9 +296,13 @@
 	    bh_result->b_dev = inode->i_dev;
 	    bh_result->b_blocknr = blocknr;
 	    bh_result->b_state |= (1UL << BH_Mapped);
-	} else if ((args & GET_BLOCK_NO_HOLE)) {
-	    ret = -ENOENT ;
-	}
+	} else
+	    // We do not return -ENOENT if there is a hole but page is uptodate, because it means
+	    // That there is some MMAPED data associated with it that is yet to be written to disk.
+	    if ((args & GET_BLOCK_NO_HOLE) && !Page_Uptodate(bh_result->b_page) ) {
+		ret = -ENOENT ;
+	    }
+
 	pathrelse (&path);
         if (p)
             kunmap(bh_result->b_page) ;

--qMm9M+Fa2AknHoGS--
