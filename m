Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSGKH0B>; Thu, 11 Jul 2002 03:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317783AbSGKH0A>; Thu, 11 Jul 2002 03:26:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38389 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317782AbSGKHZ7>; Thu, 11 Jul 2002 03:25:59 -0400
Message-ID: <3D2D338F.109@us.ibm.com>
Date: Thu, 11 Jul 2002 00:28:15 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] AFFS fix return without releasing BKL
Content-Type: multipart/mixed;
 boundary="------------040005020801000203020607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005020801000203020607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
This was found by Dan Carpenter <error27@email.com>, using an smatch 
script.  Looks to me like like an error caused during all the BKL 
pushing.  1 more coming...

Not tested (Greg, please don't hurt me :p )
-- 
Dave Hansen
haveblue@us.ibm.com

--------------040005020801000203020607
Content-Type: text/plain;
 name="affs-bkl_ret-2.5.25-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="affs-bkl_ret-2.5.25-0.patch"

--- linux-2.5.25-clean/fs/affs/namei.c	Thu Jun 20 15:53:49 2002
+++ linux/fs/affs/namei.c	Thu Jul 11 00:15:16 2002
@@ -345,8 +345,10 @@
 	lock_kernel();
 
 	/* WTF??? */
-	if (!dentry->d_inode)
+	if (!dentry->d_inode) {
+		unlock_kernel();
 		return -ENOENT;
+	}
 
 	res = affs_remove_header(dentry);
 	unlock_kernel();

--------------040005020801000203020607--

