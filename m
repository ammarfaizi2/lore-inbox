Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288230AbSACHRc>; Thu, 3 Jan 2002 02:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288231AbSACHRW>; Thu, 3 Jan 2002 02:17:22 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:20228 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288230AbSACHRC>; Thu, 3 Jan 2002 02:17:02 -0500
Date: Thu, 3 Jan 2002 10:16:56 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] tail data corruption on mempressure
Message-ID: <20020103101656.A2592@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    This patch fixes a bug when mmap-write to a file tail and subsequent read cause written data to be lost
    due to page-cache interacting mistake in low number of free buffers situation.
    Please apply.

Bye,
     Oleg

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tail_data_corruption_on_mempressure-1.diff"

--- linux/fs/reiserfs/inode.c.orig	Thu Dec 20 11:07:05 2001
+++ linux/fs/reiserfs/inode.c	Thu Dec 20 19:03:51 2001
@@ -325,6 +325,16 @@
     */
     if (buffer_uptodate(bh_result)) {
         goto finished ;
+    } else 
+	/*
+	** grab_tail_page can trigger calls to reiserfs_get_block on up to date
+	** pages without any buffers.  If the page is up to date, we don't want
+	** read old data off disk.  Set the up to date bit on the buffer instead
+	** and jump to the end
+	*/
+	    if (Page_Uptodate(bh_result->b_page)) {
+		mark_buffer_uptodate(bh_result, 1);
+		goto finished ;
     }
 
     // read file tail into part of page
@@ -833,7 +843,7 @@
 	}
 	if (retval == POSITION_FOUND) {
 	    reiserfs_warning ("vs-825: reiserfs_get_block: "
-			      "%k should not be found\n", &key);
+			      "%K should not be found\n", &key);
 	    retval = -EEXIST;
 	    if (allocated_block_nr)
 	        reiserfs_free_block (&th, allocated_block_nr);

--bp/iNruPH9dso1Pn--
