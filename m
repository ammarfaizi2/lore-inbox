Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313168AbSDJOWK>; Wed, 10 Apr 2002 10:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSDJOWJ>; Wed, 10 Apr 2002 10:22:09 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:36107 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313168AbSDJOWD>; Wed, 10 Apr 2002 10:22:03 -0400
Message-ID: <3CB4496F.40702@namesys.com>
Date: Wed, 10 Apr 2002 18:17:19 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS 3 of 13
Content-Type: multipart/mixed;
 boundary="------------030108080700060006080600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030108080700060006080600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030108080700060006080600
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 3 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 3 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13240 invoked from network); 10 Apr 2002 11:21:50 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:50 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id BD9034D1B33; Wed, 10 Apr 2002 15:21:50 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:50 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 3 of 13
Message-ID: <20020410152150.A20871@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch is to convert pap14030 panic into warning. While doing this,
a bug was uncovered, that when get_block() returns a failure, buffer
is still marked as mapped, and on subsequent access to this buffer
get_block() was not called anymore. This is also fixed.
 
--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:08:06 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:08:28 2002
@@ -752,6 +752,11 @@
 		goto research ;
 	    }
 	    retval = direct2indirect (&th, inode, &path, unbh, tail_offset);
+	    if (retval) {
+		reiserfs_unmap_buffer(unbh);
+		reiserfs_free_block (&th, allocated_block_nr);
+		goto failure;
+	    }
 	    /* it is important the mark_buffer_uptodate is done after
 	    ** the direct2indirect.  The buffer might contain valid
 	    ** data newer than the data on disk (read by readpage, changed,
@@ -761,10 +766,7 @@
 	    ** the disk
 	    */
 	    mark_buffer_uptodate (unbh, 1);
-	    if (retval) {
-		reiserfs_free_block (&th, allocated_block_nr);
-		goto failure;
-	    }
+
 	    /* we've converted the tail, so we must 
 	    ** flush unbh before the transaction commits
 	    */
--- linux-2.5.8-pre2.orig/fs/reiserfs/tail_conversion.c	Mon Apr  8 14:00:50 2002
+++ linux-2.5.8-pre2/fs/reiserfs/tail_conversion.c	Mon Apr  8 14:08:28 2002
@@ -49,9 +49,13 @@
     make_cpu_key (&end_key, inode, tail_offset, TYPE_INDIRECT, 4);
 
     // FIXME: we could avoid this 
-    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND )
-	reiserfs_panic (sb, "PAP-14030: direct2indirect: "
-			"pasted or inserted byte exists in the tree");
+    if ( search_for_position_by_key (sb, &end_key, path) == POSITION_FOUND ) {
+	reiserfs_warning ("PAP-14030: direct2indirect: "
+			"pasted or inserted byte exists in the tree %K. "
+			"Use fsck to repair.\n", &end_key);
+	pathrelse(path);
+	return -EIO;
+    }
     
     p_le_ih = PATH_PITEM_HEAD (path);
 



--------------030108080700060006080600--

