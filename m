Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946881AbWKANzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946881AbWKANzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946885AbWKANzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:55:04 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:49304 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1946881AbWKANzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:55:01 -0500
Date: Wed, 01 Nov 2006 14:54:56 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC, PATCH] dont insert sockets/pipes dentries into
 dentry_hashtable.
In-reply-to: <20061031.231954.23010447.davem@davemloft.net>
To: David Miller <davem@davemloft.net>, Al Viro <viro@ftp.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-id: <4548A730.8060507@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Bbnpg4e8BNkq2p3HegTRqA)"
References: <20061025084726.GE18364@nuim.ie>
 <20061025.230615.92585270.davem@davemloft.net>
 <200610311948.48970.dada1@cosmosbay.com>
 <20061031.231954.23010447.davem@davemloft.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Bbnpg4e8BNkq2p3HegTRqA)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT

David Miller a écrit :
> It turns out that while procfs uses a different "mechanism", those
> procfs symlinks do point to the real socket dentry, so when you
> readlink() on it you do d_path() on the real socket dentry.
> 
> Al Viro just suggested a way around this to me:
> 
> 1) Just mark the dentry HASHED by hand in the dentry flags, but don't
>    actually hash it.
> 
> 2) Create a special dentry->d_deleted method for sockets that returns
>    0 and clears by hand the HASHED flag bit in the dentry (see what
>    dput() does when this happens).
> 
> It's an abuse but it will work.
> 


Thank you David and Al for the feedback.

Here is a new version of the patch with your suggestions included.

If necessary, I could split this patch in 3 elementary patches. I chose to
sent it as one patch for ease of discussion.

[RFC, PATCH] dont insert sockets/pipes dentries into dentry_hashtable.

We currently insert sockets/pipes dentries into the global dentry hashtable.
This is *useless* because there is currently no way these entries can be used
for a lookup(). (/proc/xxx/fd/xxx uses a different mechanism)

Machines with a lot of sockets/pipes might suffer from longer chains in dentry
hashtable.

Since dentries an unhashed dentry means __dpath() adds a " (deleted)", the 
trick for socket/pipe dentries is to :

- Right after d_alloc(), pretend they are hashed by clearing the 
DCACHE_UNHASHED bit. __dpath() & friends work as intended.

- Call d_instantiate() instead of d_add() : dentry is not inserted in hash table.

- Once dput() must clear the dentry, setting again DCACHE_UNHASHED bit inside 
the custom d_delete() function provided by socket/pipe code.


[patch 1/3] Small optimization to bypass RCU freeing in d_free() for dentries 
that were never hashed (like sockets and pipes). Such dentries dont have to 
wait a RCU grace period.

[patch 2/3] Change socket code to use d_instantiate() instead of d_add()

[patch 3/3] Change pipe code to use d_instantiate() instead of d_add()

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary_(ID_Bbnpg4e8BNkq2p3HegTRqA)
Content-type: text/plain; name=donthash.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=donthash.patch

--- linux-2.6.19-rc4/fs/dcache.c	2006-11-01 12:38:23.000000000 +0100
+++ linux-2.6.19-rc4-ed/fs/dcache.c	2006-11-01 13:22:44.000000000 +0100
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
--- linux-2.6.19-rc4/net/socket.c	2006-11-01 12:40:27.000000000 +0100
+++ linux-2.6.19-rc4-ed/net/socket.c	2006-11-01 14:33:18.000000000 +0100
@@ -306,7 +306,14 @@
 
 static int sockfs_delete_dentry(struct dentry *dentry)
 {
-	return 1;
+	/*
+	 * At creation time, we pretended this dentry was hashed
+	 * (by clearing DCACHE_UNHASHED bit in d_flags)
+	 * At delete time, we restore the truth : not hashed.
+	 * (so that dput() can proceed correctly)
+	 */
+	dentry->d_flags |= DCACHE_UNHASHED;
+	return 0;
 }
 static struct dentry_operations sockfs_dentry_operations = {
 	.d_delete = sockfs_delete_dentry,
@@ -354,14 +361,20 @@
 
 	this.len = sprintf(name, "[%lu]", SOCK_INODE(sock)->i_ino);
 	this.name = name;
-	this.hash = SOCK_INODE(sock)->i_ino;
+	this.hash = 0;
 
 	file->f_dentry = d_alloc(sock_mnt->mnt_sb->s_root, &this);
 	if (unlikely(!file->f_dentry))
 		return -ENOMEM;
 
 	file->f_dentry->d_op = &sockfs_dentry_operations;
-	d_add(file->f_dentry, SOCK_INODE(sock));
+	/*
+	 * We dont want to push this dentry into global dentry hash table. 
+	 * We pretend dentry is already hashed, by unsetting DCACHE_UNHASHED
+	 * This hack permits a working /proc/$pid/fd/XXX on sockets
+	 */
+	file->f_dentry->d_flags &= ~DCACHE_UNHASHED;
+	d_instantiate(file->f_dentry, SOCK_INODE(sock));
 	file->f_vfsmnt = mntget(sock_mnt);
 	file->f_mapping = file->f_dentry->d_inode->i_mapping;
 
--- linux-2.6.19-rc4/fs/pipe.c	2006-11-01 12:56:05.000000000 +0100
+++ linux-2.6.19-rc4-ed/fs/pipe.c	2006-11-01 14:33:18.000000000 +0100
@@ -830,7 +830,14 @@
 static struct vfsmount *pipe_mnt __read_mostly;
 static int pipefs_delete_dentry(struct dentry *dentry)
 {
-	return 1;
+	/*
+	 * At creation time, we pretended this dentry was hashed
+	 * (by clearing DCACHE_UNHASHED bit in d_flags)
+	 * At delete time, we restore the truth : not hashed.
+	 * (so that dput() can proceed correctly)
+	 */
+	dentry->d_flags |= DCACHE_UNHASHED;
+	return 0;
 }
 
 static struct dentry_operations pipefs_dentry_operations = {
@@ -891,17 +898,22 @@
 	if (!inode)
 		goto err_file;
 
-	sprintf(name, "[%lu]", inode->i_ino);
+	this.len = sprintf(name, "[%lu]", inode->i_ino);
 	this.name = name;
-	this.len = strlen(name);
-	this.hash = inode->i_ino; /* will go */
+	this.hash = 0;
 	err = -ENOMEM;
 	dentry = d_alloc(pipe_mnt->mnt_sb->s_root, &this);
 	if (!dentry)
 		goto err_inode;
 
 	dentry->d_op = &pipefs_dentry_operations;
-	d_add(dentry, inode);
+	/*
+	 * We dont want to push this dentry into global dentry hash table. 
+	 * We pretend dentry is already hashed, by unsetting DCACHE_UNHASHED
+	 * This hack permits a working /proc/$pid/fd/XXX on pipes
+	 */
+	dentry->d_flags &= ~DCACHE_UNHASHED;
+	d_instantiate(dentry, inode);
 	f->f_vfsmnt = mntget(pipe_mnt);
 	f->f_dentry = dentry;
 	f->f_mapping = inode->i_mapping;

--Boundary_(ID_Bbnpg4e8BNkq2p3HegTRqA)--
