Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWKGP42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWKGP42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWKGP41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:56:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28575 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932635AbWKGP4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:56:15 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <454FAAF8.8080707@redhat.com>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
	 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de>  <454FAAF8.8080707@redhat.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 10:56:06 -0500
Message-Id: <1162914966.28425.24.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 15:36 -0600, Eric Sandeen wrote:
> *shrug* I dunno, it's probably not worth arguing this point, it needs to
> be fixed properly in any case. :)
> 
> -Eric

Here's a more involved (again, untested) patch. I turned new_inode into
a wrapper for a new function (new_inode_autonum). If the autonum arg is
set, then we should get back a unique i_ino.

This also converts the iunique function to use the per sb s_lastino
counter. I think that's the right thing to do here, but I'm new to the
hlist stuff and so feedback would be appreciated there.

Current behavior for new_inode shouldn't be changed (aside from the
per-sb s_lastino counter). The idea here would be to move filesystems
that don't later overwrite the i_ino field, to use new_inode_autonum
rather than new_inode and set autonum to true.

Not sure how bad performance with new inode creation will be when that
is set to true, but this is the best way I could see to do this without
adding something like an radix tree to track used inodes.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/inode.c b/fs/inode.c
index 26cdb11..83b9bab 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -517,14 +517,14 @@ repeat:
 }
 
 /**
- *	new_inode 	- obtain an inode
+ *	new_inode_autonum 	- obtain an inode
  *	@sb: superblock
+ *      @autonum: if true, make sure that i_ino is unique
  *
  *	Allocates a new inode for given superblock.
  */
-struct inode *new_inode(struct super_block *sb)
+struct inode *new_inode_autonum(struct super_block *sb, int autonum)
 {
-	static unsigned long last_ino;
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);
@@ -535,13 +535,26 @@ struct inode *new_inode(struct super_blo
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
 		list_add(&inode->i_sb_list, &sb->s_inodes);
-		inode->i_ino = ++last_ino;
+		if (autonum)
+			inode->i_ino = iunique(sb, 0);
+		else
+			inode->i_ino = ++sb->s_lastino;
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
 	}
 	return inode;
 }
 
+/**
+ *	new_inode 	- obtain an inode
+ *	@sb: superblock
+ *
+ *	Allocates a new inode for given superblock.
+ */
+struct inode *new_inode(struct super_block *sb)
+{
+	new_inode_autonum(sb, 0);
+}
 EXPORT_SYMBOL(new_inode);
 
 void unlock_new_inode(struct inode *inode)
@@ -683,22 +696,21 @@ static unsigned long hash(struct super_b
  */
 ino_t iunique(struct super_block *sb, ino_t max_reserved)
 {
-	static ino_t counter;
 	struct inode *inode;
 	struct hlist_head * head;
 	ino_t res;
 	spin_lock(&inode_lock);
 retry:
-	if (counter > max_reserved) {
-		head = inode_hashtable + hash(sb,counter);
-		res = counter++;
+	if (sb->s_lastino >= max_reserved) {
+		head = inode_hashtable + hash(sb,++sb->s_lastino);
+		res = sb->s_lastino;
 		inode = find_inode_fast(sb, head, res);
 		if (!inode) {
 			spin_unlock(&inode_lock);
 			return res;
 		}
 	} else {
-		counter = max_reserved + 1;
+		 sb->s_lastino = max_reserved;
 	}
 	goto retry;
 	
diff --git a/fs/super.c b/fs/super.c
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2fe6e3f..1010e64 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -961,6 +961,14 @@ #endif
 	/* Granularity of c/m/atime in ns.
 	   Cannot be worse than a second */
 	u32		   s_time_gran;
+
+	/* per-sb inode counter for new_inode. Make it a 32-bit counter when
+	   we have the possibility of dealing with 32-bit apps */
+#ifdef CONFIG_COMPAT
+	unsigned int		s_lastino;
+#else
+	unsigned long		s_lastino;
+#endif
 };
 
 extern struct timespec current_fs_time(struct super_block *sb);


