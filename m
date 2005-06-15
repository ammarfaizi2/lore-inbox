Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVFOJIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVFOJIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 05:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFOJIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 05:08:47 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:60942 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261343AbVFOJI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 05:08:27 -0400
Subject: [PATCH] ReiserFS _get_block_create_0 wrong behavior when I/O fails
From: fs <fs@ercist.iscas.ac.cn>
To: reiserfs-list@namesys.com
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, reiser@namesys.com
Content-Type: multipart/mixed; boundary="=-JOi07tU77Vnfki0dnX9d"
Organization: iscas
Message-Id: <1118865954.4231.4.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Jun 2005 16:09:13 -0400
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JOi07tU77Vnfki0dnX9d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-JOi07tU77Vnfki0dnX9d
Content-Disposition: inline
Content-Description: Forwarded message - [iscas-linaccident 50] [PATCH]
	ReiserFS _get_block_create_0 wrong behavior when I/O fails
Content-Type: message/rfc822

Received: from  [61.115.5.249] by ercist.iscas.ac.cn (ArGoSoft Mail Server
	Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Wed, 15 Jun 2005 17:09:41 
Received: from mail.intellilink.co.jp ([127.0.0.1]) by ns.intellilink.co.jp
	(NAVGW 2.5.1.16) with SMTP id M2005061517095925409 ; Wed, 15 Jun 2005
	17:09:59 +0900
Received: from spool.intellilink.co.jp (spool.intellilink.co.jp
	[172.30.16.208]) by mail.intellilink.co.jp (Postfix) with ESMTP id
	A203128956; Wed, 15 Jun 2005 17:09:19 +0900 (JST)
Received: by spool.intellilink.co.jp (Postfix) id 86EF5330DE7; Wed, 15 Jun
	2005 17:09:03 +0900 (JST)
Delivered-To: iscas-linaccident-list@intellilink.co.jp
Received: by spool.intellilink.co.jp (Postfix, from userid 502) id
	465F1330DFC; Wed, 15 Jun 2005 17:09:03 +0900 (JST)
Delivered-To: iscas-linaccident@intellilink.co.jp
Date: Wed, 15 Jun 2005 15:10:05 -0400
From: fs <fs@ercist.iscas.ac.cn>
To: reiserfs-list@namesys.com
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,  iscas-linaccident@intellilink.co.jp
Subject: [iscas-linaccident 50] [PATCH] ReiserFS _get_block_create_0 wrong
	behavior when I/O fails
Message-ID: <20050615191005.GA3188@CoolQ.6f.iscas.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: owner-iscas-linaccident@intellilink.co.jp
Precedence: bulk
Reply-To: iscas-linaccident@intellilink.co.jp
Return-Path: <owner-iscas-linaccident@intellilink.co.jp>
Content-Transfer-Encoding: 7bit

Related FS:
    ReiserFS

Related Files:
    fs/reiserfs/inode.c

Bug description:
    Make a ReiserFS partition in USB storage HDD, create a test file with
enough size.
    Write a program, do: open(O_RDONLY) - read - close. After each
operation, pause for a while, such as 3s. Between open and read, unlug the
USB wire. open returns zero-filled buffer, no error returns.

Bug analysis:
    do_mpage_readpage will call FS-specific get_block to get buffer mapped
from disk. reiserfs_get_block doesn't return non-zero when I/O failure occurs.
    reiserfs_get_block -> _get_block_create_0 -> search_by_position_by_key
search_by_position_by_key returns IO_ERROR, but the original code just simply
returns 0

research:
    if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND) {
	pathrelse (&path);
        if (p)
            kunmap(bh_result->b_page) ;
	// We do not return -ENOENT if there is a hole but page is uptodate, because it means
	// That there is some MMAPED data associated with it that is yet to be written to disk.
	if ((args & GET_BLOCK_NO_HOLE) && !PageUptodate(bh_result->b_page) ) {
	    return -ENOENT ;
	}
        return 0 ; <- 0 retuns for IO_ERROR
    }

Way around:
    test result of search_for_position_by_key

Signed-off-by: Qu Fuping<fs@ercist.iscas.ac.cn>

Patch:
diff -uNp /tmp/linux-2.6.12-rc6/fs/reiserfs/inode.c /tmp/linux-2.6.12-rc6.new/fs/reiserfs/inode.c
--- /tmp/linux-2.6.12-rc6/fs/reiserfs/inode.c	2005-06-06 11:22:29.000000000 -0400
+++ /tmp/linux-2.6.12-rc6.new/fs/reiserfs/inode.c	2005-06-15 13:56:45.552564512 -0400
@@ -254,6 +254,7 @@ static int _get_block_create_0 (struct i
     char * p = NULL;
     int chars;
     int ret ;
+    int result ;
     int done = 0 ;
     unsigned long offset ;
 
@@ -262,7 +263,8 @@ static int _get_block_create_0 (struct i
 		  (loff_t)block * inode->i_sb->s_blocksize + 1, TYPE_ANY, 3);
 
 research:
-    if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND) {
+    result = search_for_position_by_key (inode->i_sb, &key, &path) ;
+    if (result != POSITION_FOUND) {
 	pathrelse (&path);
         if (p)
             kunmap(bh_result->b_page) ;
@@ -270,7 +272,8 @@ research:
 	// That there is some MMAPED data associated with it that is yet to be written to disk.
 	if ((args & GET_BLOCK_NO_HOLE) && !PageUptodate(bh_result->b_page) ) {
 	    return -ENOENT ;
-	}
+	}else if (result == IO_ERROR)
+		return -EIO ;
         return 0 ;
     }
     



--=-JOi07tU77Vnfki0dnX9d--


