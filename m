Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWIFAdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWIFAdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWIFAdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:33:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:15081 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751287AbWIFAdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:33:12 -0400
Date: Mon, 4 Sep 2006 17:54:19 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir
Message-ID: <20060904225419.GA4367@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060830211203.GA12953@us.ibm.com> <20060825221615.GA11613@us.ibm.com> <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> <27154.1156546746@warthog.cambridge.redhat.com> <10689.1157020231@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10689.1157020231@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 11:30:31AM +0100, David Howells wrote:
> Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > +	inode = iget5_locked(sb, lower_inode->i_ino, ecryptfs_inode_test,
> > +			     ecryptfs_inode_set, lower_inode);
> 
> The second argument of iget5_locked() is a hash value.  I would use
> lower_inode not lower_inode->i_ino as the former is fundamental to
> your search and the latter irrelevant.

Is it safe to assume that a pointer will always be equal to or smaller
than an unsigned long for all architectures? Casting a pointer to an
unsigned long, in general, makes me a bit uncomfortable.

> > +	inode->i_ino = lower_inode->i_ino;
> > +	if (inode->i_state & I_NEW) {
> > +		ecryptfs_init_inode(inode);
> > +		unlock_new_inode(inode);
> > +	}
> 
> Shouldn't the setting of i_ino be inside the if-statement?
> 
> You should set the lower inode pointer in ecryptfs_inode_set() so
> that the ecryptfs inode is linked to the lower inode whilst
> inode_lock is held (see get_new_inode()).  You could also set i_ino
> there too.  Consider this bit of pseudocode:
> 
> 	int ecryptfs_inode_set(struct inode *inode, void *lower_inode)
> 	{
> 		ecryptfs_set_lower_inode(inode, lower_inode);
> 		inode->i_ino = lower_inode->i_ino;
> 		return 0;
> 	}

Dave Chinner told me that XFS uses 32-bit inode numbers on 32-bit
machines, so I imagine that this patch really is only helpful for NFS.

How does this look?

---

Modify inode number generation to account for differences in the inode
number data type sizes in lower filesystems.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    3 +++
 fs/ecryptfs/inode.c           |   23 +++++++++++++++++++++++
 fs/ecryptfs/main.c            |   16 +++++++---------
 fs/ecryptfs/super.c           |   12 ++++--------
 4 files changed, 37 insertions(+), 17 deletions(-)

62dee692ac7e88898f329e389ebd3178fce428a3
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 349ce2a..860af16 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -474,5 +474,8 @@ int ecryptfs_truncate(struct dentry *den
 int
 ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
 			char *cipher_name, size_t key_size);
+int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode);
+int ecryptfs_inode_set(struct inode *inode, void *ignored);
+void ecryptfs_init_inode(struct inode *inode);
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d8659ff..642a260 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1024,6 +1024,29 @@ out:
 	return rc;
 }
 
+int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode)
+{
+	if (ecryptfs_inode_to_private(inode) && 
+	    (ecryptfs_inode_to_lower(inode)
+	     == (struct inode *)candidate_lower_inode))
+		return 1;
+	else
+		return 0;
+}
+
+int ecryptfs_inode_set(struct inode *inode, void *lower_inode)
+{
+	/* This is where we setup the self-reference in the vfs_inode's
+	 * i_private. That way we don't have to walk the list again. */
+	ecryptfs_set_inode_private(inode,
+				   container_of(inode,
+						struct ecryptfs_inode_info,
+						vfs_inode));
+	ecryptfs_set_inode_lower(inode, igrab((struct inode *)lower_inode));
+	inode->i_ino = ((struct inode *)lower_inode)->i_ino;
+	return 0;
+}
+
 struct inode_operations ecryptfs_symlink_iops = {
 	.readlink = ecryptfs_readlink,
 	.follow_link = ecryptfs_follow_link,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index f7ea912..83e920c 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -68,9 +68,6 @@ void __ecryptfs_printk(const char *fmt, 
  *
  * Interposes upper and lower dentries.
  *
- * This function will allocate an ecryptfs_inode through the call to
- * iget(sb, lower_inode->i_ino).
- *
  * Returns zero on success; non-zero otherwise
  */
 int ecryptfs_interpose(struct dentry *lower_dentry, struct dentry *dentry,
@@ -85,22 +82,23 @@ int ecryptfs_interpose(struct dentry *lo
 		rc = -EXDEV;
 		goto out;
 	}
-	inode = iget(sb, lower_inode->i_ino);
+	inode = iget5_locked(sb, (unsigned long)lower_inode,
+			     ecryptfs_inode_test, ecryptfs_inode_set,
+			     lower_inode);
 	if (!inode) {
 		rc = -EACCES;
 		goto out;
 	}
-	/* This check is required here because if we failed to allocated the
-	 * required space for an inode_info_cache struct, then the only way
-	 * we know we failed, is by the pointer being NULL */
+	if (inode->i_state & I_NEW) {
+		ecryptfs_init_inode(inode);
+		unlock_new_inode(inode);
+	}
 	if (!ecryptfs_inode_to_private(inode)) {
 		ecryptfs_printk(KERN_ERR, "Out of memory. Failure to "
 				"allocate memory in ecryptfs_read_inode.\n");
 		rc = -ENOMEM;
 		goto out;
 	}
-	if (!ecryptfs_inode_to_lower(inode))
-		ecryptfs_set_inode_lower(inode, igrab(lower_inode));
 	if (S_ISLNK(lower_inode->i_mode))
 		inode->i_op = &ecryptfs_symlink_iops;
 	else if (S_ISDIR(lower_inode->i_mode))
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index f4f06ea..f2bfac3 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -78,25 +78,21 @@ static void ecryptfs_destroy_inode(struc
 }
 
 /**
- * ecryptfs_read_inode
+ * ecryptfs_init_inode
  * @inode: The ecryptfs inode
  *
  * Set up the ecryptfs inode.
  */
-static void ecryptfs_read_inode(struct inode *inode)
+void ecryptfs_init_inode(struct inode *inode)
 {
-	/* This is where we setup the self-reference in the vfs_inode's
-	 * i_private. That way we don't have to walk the list again. */
-	ecryptfs_set_inode_private(inode,
-				   list_entry(inode, struct ecryptfs_inode_info,
-					      vfs_inode));
-	ecryptfs_set_inode_lower(inode, NULL);
 	inode->i_version++;
 	inode->i_op = &ecryptfs_main_iops;
 	inode->i_fop = &ecryptfs_main_fops;
 	inode->i_mapping->a_ops = &ecryptfs_aops;
 }
 
+static void ecryptfs_read_inode(struct inode *inode) { }
+
 /**
  * ecryptfs_put_super
  * @sb: Pointer to the ecryptfs super block
-- 
1.3.3

