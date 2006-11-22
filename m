Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756171AbWKVSAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171AbWKVSAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbWKVSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:00:21 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:26322 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1756171AbWKVSAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:00:19 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] [NET] dont insert socket dentries into dentry_hashtable.
Date: Wed, 22 Nov 2006 19:00:36 +0100
User-Agent: KMail/1.9.5
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
References: <20061024141739.GB18364@nuim.ie> <20061025.230615.92585270.davem@davemloft.net> <200610311948.48970.dada1@cosmosbay.com>
In-Reply-To: <200610311948.48970.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EBJZFc9OjR8GYJP"
Message-Id: <200611221900.36216.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_EBJZFc9OjR8GYJP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We currently insert socket dentries into the global dentry hashtable.
This is *suboptimal* because there is currently no way these entries can be 
used for a lookup(). (/proc/xxx/fd/xxx uses a different mechanism). Inserting 
them in dentry hashtable slow dcache lookups.


To let __dpath() still work correctly (ie not adding a " (deleted)") after 
dentry name, we do : 

- Right after d_alloc(), pretend they are hashed by clearing the 
DCACHE_UNHASHED bit. 

- Call d_instantiate() instead of d_add() : dentry is not inserted in hash 
table.

__dpath() & friends work as intended during dentry lifetime.

- At dismantle time, once dput() must clear the dentry, setting again 
DCACHE_UNHASHED bit inside the custom d_delete() function provided by socket 
code, so that dput() can just kill_it.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_EBJZFc9OjR8GYJP
Content-Type: text/plain;
  charset="utf-8";
  name="socket_nohash_dentry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="socket_nohash_dentry.patch"

--- linux-2.6.19-rc6/net/socket.c	2006-11-22 17:33:41.000000000 +0100
+++ linux-2.6.19-rc6-ed/net/socket.c	2006-11-22 18:28:12.000000000 +0100
@@ -306,7 +306,14 @@ static struct file_system_type sock_fs_t
 
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
@@ -354,14 +361,20 @@ static int sock_attach_fd(struct socket 
 
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
+	 * This permits a working /proc/$pid/fd/XXX on sockets
+	 */
+	file->f_dentry->d_flags &= ~DCACHE_UNHASHED;
+	d_instantiate(file->f_dentry, SOCK_INODE(sock));
 	file->f_vfsmnt = mntget(sock_mnt);
 	file->f_mapping = file->f_dentry->d_inode->i_mapping;
 

--Boundary-00=_EBJZFc9OjR8GYJP--
