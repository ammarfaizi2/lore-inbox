Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313236AbSDJPGX>; Wed, 10 Apr 2002 11:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSDJPFW>; Wed, 10 Apr 2002 11:05:22 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:20996 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S313207AbSDJPEK>; Wed, 10 Apr 2002 11:04:10 -0400
Message-ID: <3CB45352.6030109@namesys.com>
Date: Wed, 10 Apr 2002 18:59:30 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bugfixes, the critical one of the thirteen, please
 apply, 12 of 13
Content-Type: multipart/mixed;
 boundary="------------000804060002080704050503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000804060002080704050503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000804060002080704050503
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 12 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 12 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13285 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 2F6E34D1B34; Wed, 10 Apr 2002 15:21:51 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:51 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 12 of 13
Message-ID: <20020410152151.A20916@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


 This patch fixes a problem that was created during inode structure
 cleanup/ private parts separation. This fix was made by Chris Mason.
 This is very critical bugfix. Without it, filesystem corruption
 happens on savelinks processing and possibly in some other cases.


--- linux-2.5.8-pre2/fs/reiserfs/inode.c.orig	Mon Apr  8 14:09:57 2002
+++ linux-2.5.8-pre2/fs/reiserfs/inode.c	Mon Apr  8 14:23:15 2002
@@ -1111,8 +1111,19 @@
     return;
 }
 
+/* reiserfs_read_inode2 is called to read the inode off disk, and it
+** does a make_bad_inode when things go wrong.  But, we need to make sure
+** and clear the key in the private portion of the inode, otherwise a
+** corresponding iput might try to delete whatever object the inode last
+** represented.
+*/
+static void reiserfs_make_bad_inode(struct inode *inode) {
+    memset(INODE_PKEY(inode), 0, KEY_SIZE);
+    make_bad_inode(inode);
+}
+
 void reiserfs_read_inode(struct inode *inode) {
-    make_bad_inode(inode) ;
+    reiserfs_make_bad_inode(inode) ;
 }
 
 
@@ -1132,7 +1143,7 @@
     int retval;
 
     if (!p) {
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
 
@@ -1152,13 +1163,13 @@
 	reiserfs_warning ("vs-13070: reiserfs_read_inode2: "
                     "i/o failure occurred trying to find stat data of %K\n",
                     &key);
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	return;
     }
     if (retval != ITEM_FOUND) {
 	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
-	make_bad_inode(inode) ;
+	reiserfs_make_bad_inode(inode) ;
 	inode->i_nlink = 0;
 	return;
     }
@@ -1185,7 +1196,7 @@
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
-	    make_bad_inode( inode );
+	    reiserfs_make_bad_inode( inode );
     }
 
     reiserfs_check_path(&path_to_sd) ; /* init inode should be relsing */
--- linux-2.5.8-pre2/fs/reiserfs/super.c.orig	Mon Apr  8 14:00:50 2002
+++ linux-2.5.8-pre2/fs/reiserfs/super.c	Mon Apr  8 14:23:15 2002
@@ -746,9 +746,8 @@
     //
     // ok, reiserfs signature (old or new) found in at the given offset
     //    
-    brelse (bh);
-    
     sb_set_blocksize (s, sb_blocksize(rs));
+    brelse (bh);
     
     bh = reiserfs_bread (s, offset / s->s_blocksize);
     if (!bh) {



--------------000804060002080704050503--

