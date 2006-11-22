Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756075AbWKVRsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbWKVRsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 12:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756077AbWKVRsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 12:48:25 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:50897 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1756075AbWKVRsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 12:48:24 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] dont insert pipe dentries into dentry_hashtable.
Date: Wed, 22 Nov 2006 18:48:41 +0100
User-Agent: KMail/1.9.5
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com> <20061121224613.548207f9.akpm@osdl.org> <200611221602.29597.dada1@cosmosbay.com>
In-Reply-To: <200611221602.29597.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_51IZFfqs669MdBI"
Message-Id: <200611221848.41330.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_51IZFfqs669MdBI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

We currently insert pipe dentries into the global dentry hashtable.
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
DCACHE_UNHASHED bit inside the custom d_delete() function provided by pipe 
code, so that dput() can just kill_it.

This patch, combined with the next one (avoid RCU for never hashed dentries) 
reduced time of { pipe(p); close(p[0]); close(p[1]);} on my UP machine 
(1.6GHz Pentium-M) from 3.23 us to 2.86 us 
(But this patch does not depend on other patches, only bench results)

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_51IZFfqs669MdBI
Content-Type: text/plain;
  charset="utf-8";
  name="pipe_nohash_dentry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="pipe_nohash_dentry.patch"

--- linux-2.6.19-rc6/fs/pipe.c	2006-11-22 17:33:52.000000000 +0100
+++ linux-2.6.19-rc6-ed/fs/pipe.c	2006-11-22 17:53:02.000000000 +0100
@@ -830,7 +830,14 @@ void free_pipe_info(struct inode *inode)
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
@@ -891,17 +898,22 @@ struct file *create_write_pipe(void)
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
+	 * We dont want to publish this dentry into global dentry hash table. 
+	 * We pretend dentry is already hashed, by unsetting DCACHE_UNHASHED
+	 * This permits a working /proc/$pid/fd/XXX on pipes
+	 */
+	dentry->d_flags &= ~DCACHE_UNHASHED;
+	d_instantiate(dentry, inode);
 	f->f_vfsmnt = mntget(pipe_mnt);
 	f->f_dentry = dentry;
 	f->f_mapping = inode->i_mapping;

--Boundary-00=_51IZFfqs669MdBI--
