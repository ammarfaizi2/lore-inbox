Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275826AbRJBGOX>; Tue, 2 Oct 2001 02:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275832AbRJBGON>; Tue, 2 Oct 2001 02:14:13 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:49305 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S275826AbRJBGOA>; Tue, 2 Oct 2001 02:14:00 -0400
Date: Tue, 02 Oct 2001 15:14:21 +0900
Message-ID: <vghy1sci.wl@nisaaru.dvs.cs.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [BUG-2.4.10] deadlock in do_truncate() and shmem_getpage()
User-Agent: Wanderlust/2.7.4 (Too Funky) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.7 () APEL/10.3 MULE XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

I found a a deadlock bug in v2.4.10 due to invert locking order between
inode->i_truncate_sem and inode->i_sem.
Sequence is following.

do_truncate()
	down(&inode->i_sem);
	down_write(&inode->i_truncate_sem);


do_no_page()
	down_read(&inode->i_truncate_sem);

	shmem_nopage();
		shmem_getpage();
			down(&inode->i_sem);
	

Following patch works for me.


diff -r -u -N linux.org/fs/open.c linux/fs/open.c
--- linux.org/fs/open.c	Tue Oct  2 11:35:47 2001
+++ linux/fs/open.c	Tue Oct  2 11:45:33 2001
@@ -81,13 +81,13 @@
 	if (length < 0)
 		return -EINVAL;
 
-	down(&inode->i_sem);
 	down_write(&inode->i_truncate_sem);
+	down(&inode->i_sem);
 	newattrs.ia_size = length;
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
 	error = notify_change(dentry, &newattrs);
-	up_write(&inode->i_truncate_sem);
 	up(&inode->i_sem);
+	up_write(&inode->i_truncate_sem);
 	return error;
 }
 
