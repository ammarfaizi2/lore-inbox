Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423789AbWJaSsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423789AbWJaSsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423791AbWJaSsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:48:51 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:18394 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1423790AbWJaSsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:48:50 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: David Miller <davem@davemloft.net>
Subject: [RFC, PATCH] dont insert sockets/pipes dentries into dentry_hashtable.
Date: Tue, 31 Oct 2006 19:48:48 +0100
User-Agent: KMail/1.9.5
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061024141739.GB18364@nuim.ie> <20061025084726.GE18364@nuim.ie> <20061025.230615.92585270.davem@davemloft.net>
In-Reply-To: <20061025.230615.92585270.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Qq5RFLe4+Q1s5vf"
Message-Id: <200610311948.48970.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Qq5RFLe4+Q1s5vf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi David

Here is the patch I cooked after our mail exchange. (was [RFC] Any strong 
reason why socket dentries are hashed in global dentry_hashtable )

If necessary, I could split this patch in 4 elementary patches. I chose to 
sent it as one patch for initial discussion.

[RFC, PATCH] dont insert sockets/pipes dentries into dentry_hashtable.

We currently insert sockets/pipes dentries into the global dentry hashtable.
This is *useless* because there is currently no way these entries can be used 
for a lookup(). (/proc/xxx/fd/xxx uses a different mechanism)

Machines with a lot of sockets/pipes might suffer from longer chains in dentry 
hashtable.

The goals of this patch are :

[0] No more insertion in hashtable of sockets/pipes dentries.

[1] Introduction of a DENTRY_DELETED flag, that can distinguish dentries that 
were deleted and others in d_path(). (previous code was using d_unhashed())

[2] Small optimization to bypass RCU freeing in d_free() for dentries that 
were never hashed (like sockets and pipes). Such dentries dont have to wait a 
RCU grace period.

[3] Plug socket code to use d_instantiate() instead of d_hash()
   (No more need for a private d_delete function, and dentry_operations)

[4] Plug pipe code to use d_instantiate() instead of d_hash()
   (No more need for a private d_delete function, and dentry_operations)

Another step would be to eliminate dentries for sockets/pipes, but that's 
another story. (Or at least allocate them from a separate kmem_cache_t as 
they are not reclaimable, and they might be smaller than a full dentry)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_Qq5RFLe4+Q1s5vf
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dcache.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="dcache.patch"

--- linux-2.6.19-rc4/include/linux/dcache.h	2006-10-31 17:38:09.000000000 +0100
+++ linux-2.6.19-rc4-ed/include/linux/dcache.h	2006-10-31 17:39:15.000000000 +0100
@@ -175,6 +175,7 @@
 #define DCACHE_UNHASHED		0x0010	
 
 #define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
+#define DCACHE_DELETED		0x0040 /* dentry was deleted */
 
 extern spinlock_t dcache_lock;
 
--- linux-2.6.19-rc4/fs/dcache.c	2006-10-31 17:39:25.000000000 +0100
+++ linux-2.6.19-rc4-ed/fs/dcache.c	2006-10-31 18:37:26.000000000 +0100
@@ -68,15 +68,19 @@
 	.age_limit = 45,
 };
 
-static void d_callback(struct rcu_head *head)
+static void __d_free(struct dentry *dentry)
 {
-	struct dentry * dentry = container_of(head, struct dentry, d_u.d_rcu);
-
 	if (dname_external(dentry))
 		kfree(dentry->d_name.name);
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
+static void d_callback(struct rcu_head *head)
+{
+	struct dentry * dentry = container_of(head, struct dentry, d_u.d_rcu);
+	__d_free(dentry);
+}
+
 /*
  * no dcache_lock, please.  The caller must decrement dentry_stat.nr_dentry
  * inside dcache_lock.
@@ -85,7 +89,11 @@
 {
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);
- 	call_rcu(&dentry->d_u.d_rcu, d_callback);
+	/* if dentry was never inserted into hash, immediate free is OK */
+	if (dentry->d_hash.pprev == NULL)
+		__d_free(dentry);
+	else
+		call_rcu(&dentry->d_u.d_rcu, d_callback);
 }
 
 /*
@@ -1376,6 +1384,7 @@
 		return;
 	}
 
+	dentry->d_flags |= DCACHE_DELETED;
 	if (!d_unhashed(dentry))
 		__d_drop(dentry);
 
@@ -1749,7 +1758,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
+	if (!IS_ROOT(dentry) && (dentry->d_flags & DCACHE_DELETED)) {
 		buflen -= 10;
 		end -= 10;
 		if (buflen < 0)
--- linux-2.6.19-rc4/net/socket.c	2006-10-31 17:53:34.000000000 +0100
+++ linux-2.6.19-rc4-ed/net/socket.c	2006-10-31 18:39:06.000000000 +0100
@@ -304,13 +304,6 @@
 	.kill_sb =	kill_anon_super,
 };
 
-static int sockfs_delete_dentry(struct dentry *dentry)
-{
-	return 1;
-}
-static struct dentry_operations sockfs_dentry_operations = {
-	.d_delete = sockfs_delete_dentry,
-};
 
 /*
  *	Obtains the first available file descriptor and sets it up for use.
@@ -360,8 +353,9 @@
 	if (unlikely(!file->f_dentry))
 		return -ENOMEM;
 
-	file->f_dentry->d_op = &sockfs_dentry_operations;
-	d_add(file->f_dentry, SOCK_INODE(sock));
+	/* Dont insert socket dentry into global dentry hashtable */
+	d_instantiate(file->f_dentry, SOCK_INODE(sock));
+
 	file->f_vfsmnt = mntget(sock_mnt);
 	file->f_mapping = file->f_dentry->d_inode->i_mapping;
 
--- linux-2.6.19-rc4/fs/pipe.c	2006-10-31 18:53:21.000000000 +0100
+++ linux-2.6.19-rc4-ed/fs/pipe.c	2006-10-31 18:55:20.000000000 +0100
@@ -828,14 +828,6 @@
 }
 
 static struct vfsmount *pipe_mnt __read_mostly;
-static int pipefs_delete_dentry(struct dentry *dentry)
-{
-	return 1;
-}
-
-static struct dentry_operations pipefs_dentry_operations = {
-	.d_delete	= pipefs_delete_dentry,
-};
 
 static struct inode * get_pipe_inode(void)
 {
@@ -891,17 +883,15 @@
 	if (!inode)
 		goto err_file;
 
-	sprintf(name, "[%lu]", inode->i_ino);
+	this.len = sprintf(name, "[%lu]", inode->i_ino);
 	this.name = name;
-	this.len = strlen(name);
 	this.hash = inode->i_ino; /* will go */
 	err = -ENOMEM;
 	dentry = d_alloc(pipe_mnt->mnt_sb->s_root, &this);
 	if (!dentry)
 		goto err_inode;
-
-	dentry->d_op = &pipefs_dentry_operations;
-	d_add(dentry, inode);
+	/* Dont insert pipe dentry into global dentry hashtable */
+	d_instantiate(dentry, inode);
 	f->f_vfsmnt = mntget(pipe_mnt);
 	f->f_dentry = dentry;
 	f->f_mapping = inode->i_mapping;

--Boundary-00=_Qq5RFLe4+Q1s5vf--
