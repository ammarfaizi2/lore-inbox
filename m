Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVFQJ2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVFQJ2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVFQJ2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:28:06 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:65295 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261928AbVFQJXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:23:54 -0400
Subject: [Fwd: Re: [PATCH] ReiserFS _get_block_create_0 wrong behavior when
	I/O fails]
From: fs <fs@ercist.iscas.ac.cn>
To: Vladimir Saveliev <vs@namesys.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       reiserfs-list <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Content-Type: multipart/mixed; boundary="=-MFJckxKB2UinblcnlUzs"
Organization: iscas
Message-Id: <1119039879.4151.4.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Jun 2005 16:24:39 -0400
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MFJckxKB2UinblcnlUzs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-MFJckxKB2UinblcnlUzs
Content-Disposition: inline
Content-Description: Forwarded message - Re: [PATCH] ReiserFS
	_get_block_create_0 wrong behavior when I/O fails
Content-Type: message/rfc822

Received: from  [159.226.5.243] by ercist.iscas.ac.cn (ArGoSoft Mail Server
	Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Fri, 17 Jun 2005 18:12:55 
Date: Fri, 17 Jun 2005 16:15:03 -0400
From: fs <fs@ercist.iscas.ac.cn>
To: Vladimir Saveliev <vs@namesys.com>
Cc: fs <fs@ercist.iscas.ac.cn>, reiserfs-list@namesys.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans Reiser <reiser@namesys.com>
Subject: Re: [PATCH] ReiserFS _get_block_create_0 wrong behavior when I/O
	fails
Message-ID: <20050617201502.GA5155@CoolQ.6f.iscas.ac.cn>
References: <1118865954.4231.4.camel@CoolQ>
	 <1118850101.17622.579.camel@tribesman.namesys.com>
	 <1118941347.2886.2.camel@CoolQ>
	 <1118918486.3851.77.camel@tribesman.namesys.com>
	 <1118918818.9357.83.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118918818.9357.83.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.1i
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Content-Transfer-Encoding: 7bit

On Thu, Jun 16, 2005 at 02:46:59PM +0400, Vladimir Saveliev wrote:
> 
> Yes. reiserfs may store file page in different blocks. In this do {}
> while loop it looks for different parts of page in the tree. If
> search_for_position_by_key fails - one part of page is not found and
> -EIO is to be returned.
> 
> > > 	    break;
you mean the patch should be like this?

Signed-off-by: Qu Fuping<fs@ercist.iscas.ac.cn>
diff -uNp linux-2.6.12-rc6.old/fs/reiserfs/inode.c linux-2.6.12-rc6.new/fs/reiserfs/inode.c > reiserfs_read.diff

--- linux-2.6.12-rc6.old/fs/reiserfs/inode.c	2005-06-06 11:22:29.000000000 -0400
+++ linux-2.6.12-rc6.new/fs/reiserfs/inode.c	2005-06-17 16:12:18.000000000 -0400
@@ -254,6 +254,7 @@ static int _get_block_create_0 (struct i
     char * p = NULL;
     int chars;
     int ret ;
+    int	result ;
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
+	}else if(result == IO_ERROR)
+		return -EIO;
         return 0 ;
     }
     
@@ -382,7 +385,8 @@ research:
 
 	// update key to look for the next piece
 	set_cpu_key_k_offset (&key, cpu_key_k_offset (&key) + chars);
-	if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND)
+	result = search_for_position_by_key (inode->i_sb, &key, &path);
+	if (result != POSITION_FOUND)
 	    // we read something from tail, even if now we got IO_ERROR
 	    break;
 	bh = get_last_bh (&path);
@@ -394,6 +398,10 @@ research:
 
 finished:
     pathrelse (&path);
+
+    if(result == IO_ERROR)
+	    return -EIO;
+    
     /* this buffer has valid data, but isn't valid for io.  mapping it to
      * block #0 tells the rest of reiserfs it just has a tail in it
      */


--=-MFJckxKB2UinblcnlUzs--


