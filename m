Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWH3VMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWH3VMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWH3VMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:12:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12989 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751593AbWH3VMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:12:07 -0400
Date: Wed, 30 Aug 2006 16:12:03 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] eCryptfs: ino_t to u64 for filldir
Message-ID: <20060830211203.GA12953@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060825221615.GA11613@us.ibm.com> <20060824182044.GE17658@us.ibm.com> <20060824181722.GA17658@us.ibm.com> <22796.1156542677@warthog.cambridge.redhat.com> <27154.1156546746@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27154.1156546746@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 11:59:06PM +0100, David Howells wrote:
> I think what you need to do is actually simple.  Use iget5 to look
> up your inode, using the _pointer_ to the lower inode as the key.
> Then just fill in i_ino from the lower inode.  The lower inode can't
> escape whilst you have it pinned, so the pointer is, in effect,
> invariant whilst you are using it.

Is this the right approach?

Note that I used to depend on iget() to wind up calling
ecryptfs_read_inode(); it looks like iget5_locked() does not make that
call, so I broke the inode initialization code out into
ecryptfs_init_inode(). I now call it explicitly if the I_NEW flag is
set, and ecryptfs_read_inode() is now a no-op.

I have not tested this under a condition when there is an i_ino
conflict, so the ecryptfs_inode_test() code has not been exercised,
but I know that the candidate_lower_inode pointer is being set right,
so that this would work.

---

Modify inode number generation to account for differences in the inode
number data type sizes in lower filesystems.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |    4 +++-
 fs/ecryptfs/inode.c           |   15 +++++++++++++++
 fs/ecryptfs/main.c            |   14 +++++++-------
 fs/ecryptfs/super.c           |   11 +++++++----
 4 files changed, 32 insertions(+), 12 deletions(-)

e61cf76bd76643eee6299dc1331a6e2f2d9e01e2
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index c61ef97..6e4f46e 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -567,6 +567,8 @@ int ecryptfs_send_connector(char *data, 
 			    u16 msg_flags, pid_t daemon_pid);
 int ecryptfs_init_connector(void);
 void ecryptfs_release_connector(void);
-
+int ecryptfs_inode_test(struct inode *inode, void *candidate_lower_inode);
+int ecryptfs_inode_set(struct inode *inode, void *ignored);
+void ecryptfs_init_inode(struct inode *inode);
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index bfc7f41..331d6d2 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1022,6 +1022,21 @@ out:
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
+int ecryptfs_inode_set(struct inode *inode, void *ignored)
+{
+	return 0;
+}
+
 struct inode_operations ecryptfs_symlink_iops = {
 	.readlink = ecryptfs_readlink,
 	.follow_link = ecryptfs_follow_link,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index d7a1672..98839bc 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -106,9 +106,6 @@ void __ecryptfs_printk(const char *fmt, 
  *
  * Interposes upper and lower dentries.
  *
- * This function will allocate an ecryptfs_inode through the call to
- * iget(sb, lower_inode->i_ino).
- *
  * Returns zero on success; non-zero otherwise
  */
 int ecryptfs_interpose(struct dentry *lower_dentry, struct dentry *dentry,
@@ -123,14 +120,17 @@ int ecryptfs_interpose(struct dentry *lo
 		rc = -EXDEV;
 		goto out;
 	}
-	inode = iget(sb, lower_inode->i_ino);
+	inode = iget5_locked(sb, lower_inode->i_ino, ecryptfs_inode_test,
+			     ecryptfs_inode_set, lower_inode);
 	if (!inode) {
 		rc = -EACCES;
 		goto out;
 	}
-	/* This check is required here because if we failed to allocated the
-	 * required space for an inode_info_cache struct, then the only way
-	 * we know we failed, is by the pointer being NULL */
+	inode->i_ino = lower_inode->i_ino;
+	if (inode->i_state & I_NEW) {
+		ecryptfs_init_inode(inode);
+		unlock_new_inode(inode);
+	}
 	if (!ecryptfs_inode_to_private(inode)) {
 		ecryptfs_printk(KERN_ERR, "Out of memory. Failure to "
 				"allocate memory in ecryptfs_read_inode.\n");
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index f4f06ea..9caae2c 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -78,18 +78,19 @@ static void ecryptfs_destroy_inode(struc
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
 	/* This is where we setup the self-reference in the vfs_inode's
 	 * i_private. That way we don't have to walk the list again. */
 	ecryptfs_set_inode_private(inode,
-				   list_entry(inode, struct ecryptfs_inode_info,
-					      vfs_inode));
+				   container_of(inode,
+						struct ecryptfs_inode_info,
+						vfs_inode));
 	ecryptfs_set_inode_lower(inode, NULL);
 	inode->i_version++;
 	inode->i_op = &ecryptfs_main_iops;
@@ -97,6 +98,8 @@ static void ecryptfs_read_inode(struct i
 	inode->i_mapping->a_ops = &ecryptfs_aops;
 }
 
+static void ecryptfs_read_inode(struct inode *inode) { }
+
 /**
  * ecryptfs_put_super
  * @sb: Pointer to the ecryptfs super block
-- 
1.3.3

