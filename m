Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSBKOap>; Mon, 11 Feb 2002 09:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289795AbSBKOaN>; Mon, 11 Feb 2002 09:30:13 -0500
Received: from angband.namesys.com ([212.16.7.85]:21120 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289802AbSBKOZW>; Mon, 11 Feb 2002 09:25:22 -0500
Date: Mon, 11 Feb 2002 17:25:18 +0300
From: Oleg Drokin on behalf of Hans Reiser <reiser@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] 2.5 [8 of 8] 08-truncate_update_mtime.diff
Message-ID: <20020211172518.H1768@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   truncate now correctly sets mtime always. Before this fix, mtime was not
   updated if truncated file was of zero length or if new filesize was bigger
   then old.
   Problem was noticed by Matthias Andree <ma@dt.e-technik.uni-dortmund.de>


--- linux/fs/reiserfs/stree.c.orig	Mon Feb 11 16:43:26 2002
+++ linux/fs/reiserfs/stree.c	Mon Feb 11 16:43:41 2002
@@ -1705,8 +1705,7 @@
     }
 
     if ( n_file_size == 0 || n_file_size < n_new_file_size ) {
-	pathrelse(&s_search_path);
-	return;
+	goto update_and_out ;
     }
 
     /* Update key to search for the last file item. */
@@ -1759,6 +1758,7 @@
 	    "PAP-5680: truncate did not finish: new_file_size %Ld, current %Ld, oid %d\n",
 	    n_new_file_size, n_file_size, s_item_key.on_disk_key.k_objectid);
 
+update_and_out:
     if (update_timestamps) {
 	// this is truncate, not file closing
 	p_s_inode->i_mtime = p_s_inode->i_ctime = CURRENT_TIME;
