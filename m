Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283517AbRK3GJp>; Fri, 30 Nov 2001 01:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283518AbRK3GJZ>; Fri, 30 Nov 2001 01:09:25 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:34052 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283517AbRK3GJP>; Fri, 30 Nov 2001 01:09:15 -0500
Message-ID: <3C072279.D346CD09@zip.com.au>
Date: Thu, 29 Nov 2001 22:08:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] smarter atime updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mark_inode_dirty() is quite expensive for journalling filesystems,
and we're calling it a lot more than we need to.

--- linux-2.4.17-pre1/fs/inode.c	Mon Nov 26 11:52:07 2001
+++ linux-akpm/fs/inode.c	Thu Nov 29 21:53:02 2001
@@ -1187,6 +1187,8 @@ void __init inode_init(unsigned long mem
  
 void update_atime (struct inode *inode)
 {
+	if (inode->i_atime == CURRENT_TIME)
+		return;
 	if ( IS_NOATIME (inode) ) return;
 	if ( IS_NODIRATIME (inode) && S_ISDIR (inode->i_mode) ) return;
 	if ( IS_RDONLY (inode) ) return;


with this patch, the time to read a 10 meg file with 10 million
read()s falls from 38 seconds (ext3), 39 seconds (reiserfs) and
11.6 seconds (ext2) down to 10.5 seconds.

-
