Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135267AbRDLTUC>; Thu, 12 Apr 2001 15:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135269AbRDLTTx>; Thu, 12 Apr 2001 15:19:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:59664 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135267AbRDLTTk>; Thu, 12 Apr 2001 15:19:40 -0400
Date: Thu, 12 Apr 2001 14:37:20 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: generic_osync_inode() broken?
Message-ID: <Pine.LNX.4.21.0104121412150.2892-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

generic_osync_inode() (called by generic_file_write()) is not checking if
the inode being synced has the I_LOCK bit set before checking the I_DIRTY
bit.

AFAICS, the following problem can happen:

sync()
...
sync_one()
reset I_DIRTY, set I_LOCK
filemap_fdatasync() <-- #window 
write_inode()  <-- #window	
filemap_fdatawait() <-- #window
unset I_LOCK

There is no guarantee that the inode is fully synced until sync_one()
cleans the inode I_LOCK bit. 

If generic_osync_inode() checks the I_DIRTY bit (and sees it clean) during
"#window", an "O_SYNC write()" call may return to userspace without having
all the data actually synced.

If I'm not missing something here this patch should the problem. 

Comments? 

--- fs/inode.c~	Thu Mar 22 16:04:13 2001
+++ fs/inode.c	Thu Apr 12 15:18:22 2001
@@ -347,6 +347,11 @@
 #endif
 
 	spin_lock(&inode_lock);
+	while (inode->i_state & I_LOCK) {
+		spin_unlock(&inode_lock);
+		__wait_on_inode(inode);
+		spin_lock(&inode_lock);
+	}
 	if (!(inode->i_state & I_DIRTY))
 		goto out;
 	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))

