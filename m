Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSJHIwI>; Tue, 8 Oct 2002 04:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSJHIwI>; Tue, 8 Oct 2002 04:52:08 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:61201 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261517AbSJHIwH>; Tue, 8 Oct 2002 04:52:07 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15777.38312.339615.506366@laputa.namesys.com>
Date: Mon, 7 Oct 2002 18:09:44 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
       Alexander Viro <viro@math.psu.edu>
Subject: [PATCH]: export generic_{drop,forget}_inode()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Emacs: why choose between a word processor and a Lisp interpreter when you could have neither instead?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

following patch exports fs/inode.c:generic_{drop,forget}_inode(). 

Without this, file system that needs ->drop_inode() super block method
would have to duplicate manipulations with &inode_unused, inodes_stat,
and &inode_lock.

This is one of few changes reiser4 requires in the core.

Please, apply.

Nikita.
diff -rup bk-linux-2.5/fs/inode.c bk-linux-2.5.new/fs/inode.c
--- bk-linux-2.5/fs/inode.c	Fri Oct  4 03:00:47 2002
+++ bk-linux-2.5.new/fs/inode.c	Mon Oct  7 14:42:08 2002
@@ -809,7 +809,7 @@ void generic_delete_inode(struct inode *
 }
 EXPORT_SYMBOL(generic_delete_inode);
 
-static void generic_forget_inode(struct inode *inode)
+void generic_forget_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -836,19 +836,21 @@ static void generic_forget_inode(struct 
 	clear_inode(inode);
 	destroy_inode(inode);
 }
+EXPORT_SYMBOL(generic_forget_inode);
 
 /*
  * Normal UNIX filesystem behaviour: delete the
  * inode when the usage count drops to zero, and
  * i_nlink is zero.
  */
-static void generic_drop_inode(struct inode *inode)
+void generic_drop_inode(struct inode *inode)
 {
 	if (!inode->i_nlink)
 		generic_delete_inode(inode);
 	else
 		generic_forget_inode(inode);
 }
+EXPORT_SYMBOL(generic_drop_inode);
 
 /*
  * Called when we're dropping the last reference
diff -rup bk-linux-2.5/include/linux/fs.h bk-linux-2.5.new/include/linux/fs.h
--- bk-linux-2.5/include/linux/fs.h	Fri Oct  4 03:00:47 2002
+++ bk-linux-2.5.new/include/linux/fs.h	Mon Oct  7 14:42:08 2002
@@ -1202,6 +1202,8 @@ extern struct inode * igrab(struct inode
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
+extern void generic_drop_inode(struct inode *inode);
+extern void generic_forget_inode(struct inode *inode);
 
 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);

