Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965659AbWKGSBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965659AbWKGSBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWKGSBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:01:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34001 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932792AbWKGSBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:01:31 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107172835.GB15629@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
	 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
	 <1162914966.28425.24.camel@dantu.rdu.redhat.com>
	 <20061107172835.GB15629@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 07 Nov 2006 13:01:28 -0500
Message-Id: <1162922488.28425.51.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 18:28 +0100, Jörn Engel wrote:

> Looking at the callers, it seemed a bit more natural to me to call
> new_inode_autonum(sb) than new_inode_autonum(sb, 1).  Would you mind
> turning new_inode_autonum() in a wrapper like new_inode() and putting
> the actual code into a static helper?
> 
> Anyway, here is a first patch converting some callers that looked
> obvious.
> 
> Jörn

Thanks for the feedback. Yeah, I held back on converting any filesystems
until I had some comments. Thanks for doing the legwork on that part.
Here's a respun patch with the suggested modification to
new_inode_autonum. This also adds it to fs.h.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/inode.c b/fs/inode.c
index 26cdb11..dd96799 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -517,14 +517,14 @@ repeat:
 }
 
 /**
- *	new_inode 	- obtain an inode
+ *	__new_inode 	- obtain an inode
  *	@sb: superblock
+ *      @autonum: if true, make sure that i_ino is unique
  *
  *	Allocates a new inode for given superblock.
  */
-struct inode *new_inode(struct super_block *sb)
+static struct inode *__new_inode(struct super_block *sb, int autonum)
 {
-	static unsigned long last_ino;
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);
@@ -535,13 +535,42 @@ struct inode *new_inode(struct super_blo
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
+ *	new_inode_autonum 	- obtain an inode with a unique i_ino value
+ *	@sb: superblock
+ *
+ *	Allocates a new inode for given superblock. Ensures that i_ino is
+ *	unique on the filesystem.
+ */
+struct inode *new_inode_autonum(struct super_block *sb)
+{
+	return __new_inode(sb, 1);
+}
+
+EXPORT_SYMBOL(new_inode_autonum);
+
+/**
+ *	new_inode 	- obtain an inode -- i_ino not guaranteed unique
+ *	@sb: superblock
+ *
+ *	Allocates a new inode for given superblock. i_ino is not guaranteed to
+ *	be unique. Should only be used when i_ino is going to be clobbered.
+ */
+struct inode *new_inode(struct super_block *sb)
+{
+	return __new_inode(sb, 0);
+}
+
 EXPORT_SYMBOL(new_inode);
 
 void unlock_new_inode(struct inode *inode)
@@ -683,22 +712,21 @@ static unsigned long hash(struct super_b
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
+		res = ++sb->s_lastino;
+		head = inode_hashtable + hash(sb,res);
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
index 2fe6e3f..d85c7ba 100644
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
@@ -1712,6 +1720,7 @@ extern void __iget(struct inode * inode)
 extern void clear_inode(struct inode *);
 extern void destroy_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
+extern struct inode *new_inode_autonum(struct super_block *);
 extern int __remove_suid(struct dentry *, int);
 extern int should_remove_suid(struct dentry *);
 extern int remove_suid(struct dentry *);



