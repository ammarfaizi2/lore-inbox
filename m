Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUEJD2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUEJD2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 23:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUEJD2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 23:28:20 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:1769 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264499AbUEJD1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 23:27:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Greg Banks <gnb@melbourne.sgi.com>, Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Date: Mon, 10 May 2004 13:27:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16542.63130.911881.340894@cse.unsw.edu.au>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from Neil Brown on Tuesday May 4
References: <16521.5104.489490.617269@laputa.namesys.com>
	<16529.56343.764629.37296@cse.unsw.edu.au>
	<409634B9.8D9484DA@melbourne.sgi.com>
	<16534.54704.792101.617408@cse.unsw.edu.au>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 4, neilb@cse.unsw.edu.au wrote:
> On Monday May 3, gnb@melbourne.sgi.com wrote:
> > 
> > *   Logic bug in d_splice_alias() forgets to clear the DCACHE_DISCONNECTED
> >     flag when a lookup connects a disconnected dentry.  Fix is (relative
> >     to Neil's patch):
> 
> I seem to recall that this was intentional.  When I first wrote the
> code I wanted to leave the splicing code to just splice things, and
> when the code that cared about disconnected-ness (in knfsd) discovered
> that something really was connected, it would clear the bit
> (find_exported_dentry does this). 
> However if we want to ensure that there is at-most one disconnected
> dentry for an inode, we do need to set the bit more aggressively.
> I'll try and review the code with that in mind.  Thanks.
> 

Ok, I've reviewed the code and thought about it some more.

This was intentional and the patch to clear DCACHE_DISCONNECTED is not
needed and possibly wrong.

DCACHE_DISCONNECTED *doesn't* mean that the entries isn't connected,
but only that it might not be.
In knfsd, we build a patch from the bottom up, and the dentry at the
bottom is not "connected" until the top is finally connected to the
root.  If DCACHE_DISCONNECTED were to mean precisely that the dentry
isn't connected, then at that point were we finally connect a path we
would have to walk down the path (which could possibly branch)
clearing all the DCACHE_DISCONNECTED flags, and this clearly isn't a
good idea.
nfsd and exportfs should be the only bits of code that cares if
DCACHE_DISCONNECTED is set or not, and they will clear it if
appropriate.

A more significant measure is "IS_ROOT". When we call d_splice_alias,
it should look for an IS_ROOT alias to consider splicing in rather
than a DCACHE_DISCONNECTED alias, as a DCACHE_DISCONNECTED alias might
already be spliced into some other path (if it is for a file with
multiple links).

The follow patch should resolve all of this, and a few other things.
IT:

 - moves DCACHE_DISCONNECTED into d_vfs_flags and uses dcache_lock to
   make sure that setting the flag doesn't tread on some other flag
   in the same field.
 - introduces "d_get_alias" which is similar to "d_find_alias", but is
   less choosy: any alias will do.
 - uses d_get_alias in d_alloc_anon and d_splice_alias to try to use a
   pre-exisiting alias if possible.
 - Only splices in a pre-exisiting alias if it was IS_ROOT.  There can
   now only be one of these per inode, and if there is one, there will
   be no other alias.
 - introduces d_move_locked which does the same as d_move, but without
   getting dcache_lock first (it must already be held).  This is
   needed to be able to atomically test IS_ROOT, and then convert the
   dentry to non IS_ROOT before anyone else gets to test IS_ROOT.


Comments and testing results very welcome.

NeilBrown


 ----------- Diffstat output ------------
 ./fs/dcache.c            |  105 +++++++++++++++++++++++++++++++----------------
 ./fs/exportfs/expfs.c    |   17 ++++---
 ./fs/intermezzo/dir.c    |    4 +
 ./fs/nfsd/nfsfh.c        |    2 
 ./include/linux/dcache.h |    2 
 5 files changed, 86 insertions(+), 44 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2004-05-10 13:26:54.000000000 +1000
+++ ./fs/dcache.c	2004-05-10 13:26:54.000000000 +1000
@@ -297,7 +297,7 @@ struct dentry * d_find_alias(struct inod
 		prefetch(next);
 		alias = list_entry(tmp, struct dentry, d_alias);
  		if (!d_unhashed(alias)) {
-			if (alias->d_flags & DCACHE_DISCONNECTED)
+			if (alias->d_vfs_flags & DCACHE_DISCONNECTED)
 				discon_alias = alias;
 			else {
 				__dget_locked(alias);
@@ -312,6 +312,39 @@ struct dentry * d_find_alias(struct inod
 	return discon_alias;
 }
 
+/**
+ * d_get_alias - grab any alias of inode
+ * @inode: inode in question
+ *
+ * Return a counted reference to an alias for @inode, or
+ * NULL if there are none.
+ *
+ * An inode can have one of:
+ *  - no aliases
+ *  - exactly one alias which IS_ROOT()
+ *  - one or more !IS_ROOT() aliases which might be hashed
+ * thus the returned alias might not be hashed, but will only be IS_ROOT
+ * if there are no other aliases.
+ */
+struct dentry *__d_get_alias(struct inode *inode)
+{
+	struct dentry *alias = NULL;
+	if (!list_empty(&inode->i_dentry)) {
+		alias = list_entry(inode->i_dentry.next, struct dentry, d_alias);
+		__dget_locked(alias);
+	}
+	return alias;
+}
+struct dentry *d_get_alias(struct inode *inode)
+{
+	struct dentry *alias = NULL;
+	spin_lock(&dcache_lock);
+	alias = __d_get_alias(inode);
+	spin_unlock(&dcache_lock);
+	return alias;
+}
+
+
 /*
  *	Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
@@ -828,7 +861,7 @@ struct dentry * d_alloc_anon(struct inod
 	struct dentry *tmp;
 	struct dentry *res;
 
-	if ((res = d_find_alias(inode))) {
+	if ((res = d_get_alias(inode))) {
 		iput(inode);
 		return res;
 	}
@@ -840,28 +873,21 @@ struct dentry * d_alloc_anon(struct inod
 	tmp->d_parent = tmp; /* make sure dput doesn't croak */
 	
 	spin_lock(&dcache_lock);
-	if (S_ISDIR(inode->i_mode) && !list_empty(&inode->i_dentry)) {
-		/* A directory can only have one dentry.
-		 * This (now) has one, so use it.
-		 */
-		res = list_entry(inode->i_dentry.next, struct dentry, d_alias);
-		__dget_locked(res);
-	} else {
-		/* attach a disconnected dentry */
+
+	res = __d_get_alias(inode);
+	if (!res) {
 		res = tmp;
 		tmp = NULL;
-		if (res) {
-			spin_lock(&res->d_lock);
-			res->d_sb = inode->i_sb;
-			res->d_parent = res;
-			res->d_inode = inode;
-			res->d_bucket = d_hash(res, res->d_name.hash);
-			res->d_flags |= DCACHE_DISCONNECTED;
-			res->d_vfs_flags &= ~DCACHE_UNHASHED;
-			list_add(&res->d_alias, &inode->i_dentry);
-			hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
-			spin_unlock(&res->d_lock);
-		}
+		spin_lock(&res->d_lock);
+		res->d_sb = inode->i_sb;
+		res->d_parent = res;
+		res->d_inode = inode;
+		res->d_bucket = d_hash(res, res->d_name.hash);
+		res->d_vfs_flags |= DCACHE_DISCONNECTED;
+		res->d_vfs_flags &= ~DCACHE_UNHASHED;
+		list_add(&res->d_alias, &inode->i_dentry);
+		hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
+		spin_unlock(&res->d_lock);
 		inode = NULL; /* don't drop reference */
 	}
 	spin_unlock(&dcache_lock);
@@ -879,30 +905,32 @@ struct dentry * d_alloc_anon(struct inod
  * @inode:  the inode which may have a disconnected dentry
  * @dentry: a negative dentry which we want to point to the inode.
  *
- * If inode is a directory and has a 'disconnected' dentry (i.e. IS_ROOT and
- * DCACHE_DISCONNECTED), then d_move that in place of the given dentry
- * and return it, else simply d_add the inode to the dentry and return NULL.
+ * If inode has a 'disconnected' dentry (i.e. IS_ROOT and DCACHE_DISCONNECTED),
+ * then d_move that in place of the given dentry and return it, else simply
+ * d_add the inode to the dentry and return NULL.
  *
- * This is (will be) needed in the lookup routine of any filesystem that is exportable
+ * This is needed in the lookup routine of any filesystem that is exportable
  * (via knfsd) so that we can build dcache paths to directories effectively.
  *
  * If a dentry was found and moved, then it is returned.  Otherwise NULL
  * is returned.  This matches the expected return value of ->lookup.
  *
  */
+static void d_move_locked(struct dentry * dentry, struct dentry * target);
+
 struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 {
 	struct dentry *new = NULL;
 
-	if (inode && S_ISDIR(inode->i_mode)) {
+	if (inode) {
 		spin_lock(&dcache_lock);
-		if (!list_empty(&inode->i_dentry)) {
-			new = list_entry(inode->i_dentry.next, struct dentry, d_alias);
-			__dget_locked(new);
+		new = __d_get_alias(inode);
+		if (new && IS_ROOT(new)) {
+			dentry->d_bucket = d_hash(dentry->d_parent,
+						  dentry->d_name.hash);
+			d_move_locked(new, dentry);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
-			d_rehash(dentry);
-			d_move(new, dentry);
 			iput(inode);
 		} else {
 			/* d_instantiate takes dcache_lock, so we do it by hand */
@@ -911,6 +939,7 @@ struct dentry *d_splice_alias(struct ino
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
+			if (new) dput(new);
 		}
 	} else
 		d_add(dentry, inode);
@@ -1185,12 +1214,11 @@ static inline void switch_names(struct d
  * dcache entries should not be moved in this way.
  */
 
-void d_move(struct dentry * dentry, struct dentry * target)
+static void d_move_locked(struct dentry * dentry, struct dentry * target)
 {
 	if (!dentry->d_inode)
 		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
 
-	spin_lock(&dcache_lock);
 	write_seqlock(&rename_lock);
 	/*
 	 * XXXX: do we really need to take target->d_lock?
@@ -1243,6 +1271,15 @@ already_unhashed:
 	spin_unlock(&target->d_lock);
 	spin_unlock(&dentry->d_lock);
 	write_sequnlock(&rename_lock);
+}
+
+void d_move(struct dentry * dentry, struct dentry * target)
+{
+	if (!dentry->d_inode)
+		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
+
+	spin_lock(&dcache_lock);
+	d_move_locked(dentry, target);
 	spin_unlock(&dcache_lock);
 }
 

diff ./fs/exportfs/expfs.c~current~ ./fs/exportfs/expfs.c
--- ./fs/exportfs/expfs.c~current~	2004-05-10 13:26:54.000000000 +1000
+++ ./fs/exportfs/expfs.c	2004-05-10 13:26:54.000000000 +1000
@@ -68,7 +68,7 @@ find_exported_dentry(struct super_block 
 		goto err_out;
 	}
 	if (S_ISDIR(result->d_inode->i_mode) &&
-	    (result->d_flags & DCACHE_DISCONNECTED)) {
+	    (result->d_vfs_flags & DCACHE_DISCONNECTED)) {
 		/* it is an unconnected directory, we must connect it */
 		;
 	} else {
@@ -87,7 +87,6 @@ find_exported_dentry(struct super_block 
 			spin_unlock(&dcache_lock);
 			if (toput)
 				dput(toput);
-			toput = NULL;
 			if (dentry != result &&
 			    acceptable(context, dentry)) {
 				dput(result);
@@ -136,13 +135,13 @@ find_exported_dentry(struct super_block 
 	 * probably enough) without getting anywhere, we just give up
 	 */
 	noprogress= 0;
-	while (target_dir->d_flags & DCACHE_DISCONNECTED && noprogress++ < 10) {
+	while (target_dir->d_vfs_flags & DCACHE_DISCONNECTED && noprogress++ < 10) {
 		struct dentry *pd = target_dir;
 
 		dget(pd);
 		spin_lock(&pd->d_lock);
 		while (!IS_ROOT(pd) &&
-				(pd->d_parent->d_flags&DCACHE_DISCONNECTED)) {
+				(pd->d_parent->d_vfs_flags&DCACHE_DISCONNECTED)) {
 			struct dentry *parent = pd->d_parent;
 
 			dget(parent);
@@ -155,11 +154,15 @@ find_exported_dentry(struct super_block 
 
 		if (!IS_ROOT(pd)) {
 			/* must have found a connected parent - great */
-			pd->d_flags &= ~DCACHE_DISCONNECTED;
+			spin_lock(&dcache_lock);
+			pd->d_vfs_flags &= ~DCACHE_DISCONNECTED;
+			spin_unlock(&dcache_lock);
 			noprogress = 0;
 		} else if (pd == sb->s_root) {
 			printk(KERN_ERR "export: Eeek filesystem root is not connected, impossible\n");
-			pd->d_flags &= ~DCACHE_DISCONNECTED;
+			spin_lock(&dcache_lock);
+			pd->d_vfs_flags &= ~DCACHE_DISCONNECTED;
+			spin_unlock(&dcache_lock);
 			noprogress = 0;
 		} else {
 			/* we have hit the top of a disconnected path.  Try
@@ -227,7 +230,7 @@ find_exported_dentry(struct super_block 
 		dput(pd);
 	}
 
-	if (target_dir->d_flags & DCACHE_DISCONNECTED) {
+	if (target_dir->d_vfs_flags & DCACHE_DISCONNECTED) {
 		/* something went wrong - oh-well */
 		if (!err)
 			err = -ESTALE;

diff ./fs/intermezzo/dir.c~current~ ./fs/intermezzo/dir.c
--- ./fs/intermezzo/dir.c~current~	2004-05-10 13:26:54.000000000 +1000
+++ ./fs/intermezzo/dir.c	2004-05-10 13:26:54.000000000 +1000
@@ -161,7 +161,9 @@ struct dentry *presto_iget_ilookup(struc
         }
 
         d_instantiate(dentry, inode);
-        dentry->d_flags |= DCACHE_DISCONNECTED; /* NFS hack */
+        spin_lock(&dcache_lock);
+        dentry->d_vfs_flags |= DCACHE_DISCONNECTED; /* NFS hack */
+        spin_unlock(&dcache_lock);
 
         EXIT;
         return NULL;

diff ./fs/nfsd/nfsfh.c~current~ ./fs/nfsd/nfsfh.c
--- ./fs/nfsd/nfsfh.c~current~	2004-05-10 13:26:54.000000000 +1000
+++ ./fs/nfsd/nfsfh.c	2004-05-10 13:26:54.000000000 +1000
@@ -204,7 +204,7 @@ fh_verify(struct svc_rqst *rqstp, struct
 		}
 #ifdef NFSD_PARANOIA
 		if (S_ISDIR(dentry->d_inode->i_mode) &&
-		    (dentry->d_flags & DCACHE_DISCONNECTED)) {
+		    (dentry->d_vfs_flags & DCACHE_DISCONNECTED)) {
 			printk("nfsd: find_fh_dentry returned a DISCONNECTED directory: %s/%s\n",
 			       dentry->d_parent->d_name.name, dentry->d_name.name);
 		}

diff ./include/linux/dcache.h~current~ ./include/linux/dcache.h
--- ./include/linux/dcache.h~current~	2004-05-10 13:26:54.000000000 +1000
+++ ./include/linux/dcache.h	2004-05-10 13:26:54.000000000 +1000
@@ -146,7 +146,7 @@ d_iput:		no		no		yes
       * first endeavour to clear the bit either by discovering that it is
       * connected, or by performing lookup operations.   Any filesystem which
       * supports nfsd_operations MUST have a lookup function which, if it finds
-      * a directory inode with a DCACHE_DISCONNECTED dentry, will d_move
+      * an inode with an IS_ROOT, DCACHE_DISCONNECTED dentry, will d_move
       * that dentry into place and return that dentry rather than the passed one,
       * typically using d_splice_alias.
       */
