Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265082AbSJPPeg>; Wed, 16 Oct 2002 11:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSJPPef>; Wed, 16 Oct 2002 11:34:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:32520 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265082AbSJPPed>; Wed, 16 Oct 2002 11:34:33 -0400
Message-ID: <3DAD8868.30502@namesys.com>
Date: Wed, 16 Oct 2002 19:40:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [BK]: reiser4: export generic_{drop,forget}_inode, and fsync_super
 1 of 2
Content-Type: multipart/mixed;
 boundary="------------070206020204050404060305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070206020204050404060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Reiser4 is fairly self-contained, except for a few minor details.  We 
thought it best to send the minor details in earlier than the rest of it.

We'll try to send the rest on the 20th, but one can never predict the 
exact pace of debugging....

Hans

--------------070206020204050404060305
Content-Type: message/rfc822;
 name="[PATCH]: [reiser4/1] export generic_{drop,forget}_inode, and fsync_super"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH]: [reiser4/1] export generic_{drop,forget}_inode, and fsync_super"

Return-Path: <Nikita@Namesys.COM>
Delivered-To: Reiser@Namesys.COM
Received: (qmail 6644 invoked from network); 16 Oct 2002 14:54:50 -0000
Received: from laputa.namesys.com.7.16.212.in-addr.arpa (HELO laputa.namesys.com) (212.16.7.124)
  by thebsh.namesys.com with SMTP; 16 Oct 2002 14:54:50 -0000
Received: by laputa.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 511)
	id 89F1724B6C; Wed, 16 Oct 2002 18:54:47 +0400 (MSD)
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15789.32181.107418.938194@laputa.namesys.com>
Date: Wed, 16 Oct 2002 18:54:45 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Hans Reiser <Reiser@Namesys.COM>
Subject: [PATCH]: [reiser4/1] export generic_{drop,forget}_inode, and fsync_super

Hello, Linus,

following patch exports fs/inode.c:generic_{drop,forget}_inode(), and
fs/buffer.c:fsync_super().

Without access to generic_{drop,forget}_inode, file system that needs
->drop_inode() super block method would have to duplicate manipulations
with &inode_unused, inodes_stat, and &inode_lock.

fsync_super() is required for reiser4, because during umount we want to
perform some tasks after ->writepage has been called on all pages
dirtied through mmap (that is, after fsync_super()), but before inode
destruction. As a result, reiser4 cannot use kill_block_super() and has
to call fsync_super() explicitly.

This is one of few changes reiser4 requires in the core.

Please, apply.

Hans on behalf of reiser4 team.
diff -X dontdiff -rup bk-linux-2.5/fs/buffer.c linux-2.5-reiser4/fs/buffer.c
--- bk-linux-2.5/fs/buffer.c	Mon Oct 14 17:41:05 2002
+++ linux-2.5-reiser4/fs/buffer.c	Tue Oct 15 11:27:32 2002
@@ -224,6 +224,7 @@ int fsync_super(struct super_block *sb)
 
 	return sync_blockdev(sb->s_bdev);
 }
+EXPORT_SYMBOL(fsync_super);
 
 /*
  * Write out and wait upon all dirty data associated with this
diff -X dontdiff -rup bk-linux-2.5/fs/inode.c linux-2.5-reiser4/fs/inode.c
--- bk-linux-2.5/fs/inode.c	Mon Oct 14 17:41:05 2002
+++ linux-2.5-reiser4/fs/inode.c	Tue Oct 15 11:27:32 2002
@@ -938,7 +938,7 @@ void generic_delete_inode(struct inode *
 }
 EXPORT_SYMBOL(generic_delete_inode);
 
-static void generic_forget_inode(struct inode *inode)
+void generic_forget_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -965,19 +965,21 @@ static void generic_forget_inode(struct 
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
diff -X dontdiff -rup bk-linux-2.5/include/linux/fs.h linux-2.5-reiser4/include/linux/fs.h
--- bk-linux-2.5/include/linux/fs.h	Sun Oct 13 03:01:04 2002
+++ linux-2.5-reiser4/include/linux/fs.h	Mon Oct 14 15:01:26 2002
@@ -1197,10 +1197,11 @@ extern struct inode * igrab(struct inode
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
-
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);
 extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
+extern void generic_drop_inode(struct inode *inode);
+extern void generic_forget_inode(struct inode *inode);
 
 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);




--------------070206020204050404060305--

