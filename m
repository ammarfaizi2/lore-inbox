Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUD3Ez3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUD3Ez3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 00:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUD3Ez3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 00:55:29 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:19651 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264973AbUD3EzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 00:55:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Nikita Danilov <Nikita@Namesys.COM>
Date: Fri, 30 Apr 2004 14:54:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16529.56343.764629.37296@cse.unsw.edu.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from Nikita Danilov on Friday April 23
References: <16521.5104.489490.617269@laputa.namesys.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday April 23, Nikita@Namesys.COM wrote:
> Hello,
> 
> for some time I am observing that during stress tests over NFS
> 
>    shrink_slab->...->prune_dcache()->prune_one_dentry()->...->iput()
> 
> is called on inode with ->i_nlink == 0 which results in truncate and
> file deletion. This is wrong in general (file system is re-entered), and
> deadlock prone on some file systems.
> 
> After some debugging, I tracked problem down the to d_splice_alias()
> failing to identify dentries when necessary.
> 
> Suppose we have an inode with ->i_nlink == 1. It's accessed over NFS and
> DCACHE_DISCONNECTED dentry D1 is created for it. Then, unlink request
> comes for this file. nfsd looks name up in the parent directory
> (nfsd_unlink()->lookup_one_len()). File system back-end uses
> d_splice_alias(), but it only works for directories and we end up with
> second (this time connected) dentry D2.
> 
> D2 is successfully unlinked, file has ->i_nlink == 0, and ->i_count == 1
> from D1, and when prune_dcache() hits D1 bad things happen.
> 
> It's hard to imagine how new name can be identified with one among
> multiple anonymous dentries, which is necessary for
> NFSEXP_NOSUBTREECHECK export to work reliably.
> 
> One possible work-around is to forcibly destroy all remaining
> DCACHE_DISCONNECTED dentries when ->i_nlink drops to zero, but I am not
> sure that this is possible and solves all problems of having more
> dentries than there are nlinks.
> 
> Nikita.

If I understand you correctly, the main problem is that a disconnected
dentry can hold an inode active after the last link has been removed.
The file will not then be truncated and removed until memory pressure
flushes the disconnected dentry from the dcache.

This problem can be resolved by making sure that an inode never has
both a connected and a disconnected dentry.

This is already the case for directories (as they must only have one
dentry), but it is not the case for non-directories.

The following patch tries to address this.  It is a "technology
preview" in that the only testing I have done is that it compiles OK. 

Please consider reviewing it to see if it makes sense.

It:
 - changes d_alloc_anon to make sure that a new disconnected dentry is
   only allocated if there is currently no (hashed) dentry for the
   inode. (Previously this would noramlly be true, but a race was
   possible).
 - changes d_splice_alias to re-use a disconnected dentry on
   non-directories as well as directories.
 - splits most of d_find_alias out into a separate function to make
   the above easier.

I haven't fully thought through issues with unhashed, connected
dentries.
__d_find_alias won't return them so d_alloc_anon will never return
one, so it is possible to have an unhashed dentry and a disconnected
dentry at the same time, which probably isn't desirable.

Is it OK for d_alloc_anon to return an unaliased dentry, and then have
it possibly spliced back into the dentry tree??? I'm not sure.

Comments welcome.

NeilBrown


===========================================================

 ----------- Diffstat output ------------
 ./fs/dcache.c |   60 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2004-04-30 14:25:50.000000000 +1000
+++ ./fs/dcache.c	2004-04-30 14:39:20.000000000 +1000
@@ -281,12 +281,11 @@ struct dentry * dget_locked(struct dentr
  * any other hashed alias over that one.
  */
 
-struct dentry * d_find_alias(struct inode *inode)
+static struct dentry * __d_find_alias(struct inode *inode, int want_discon)
 {
 	struct list_head *head, *next, *tmp;
 	struct dentry *alias, *discon_alias=NULL;
 
-	spin_lock(&dcache_lock);
 	head = &inode->i_dentry;
 	next = inode->i_dentry.next;
 	while (next != head) {
@@ -297,19 +296,26 @@ struct dentry * d_find_alias(struct inod
  		if (!d_unhashed(alias)) {
 			if (alias->d_flags & DCACHE_DISCONNECTED)
 				discon_alias = alias;
-			else {
+			else if (!want_discon) {
 				__dget_locked(alias);
-				spin_unlock(&dcache_lock);
 				return alias;
 			}
 		}
 	}
 	if (discon_alias)
 		__dget_locked(discon_alias);
-	spin_unlock(&dcache_lock);
 	return discon_alias;
 }
 
+struct dentry * d_find_alias(struct inode *inode)
+{
+	struct dentry *de;
+	spin_lock(&dcache_lock);
+	de = __d_find_alias(inode, 0);
+	spin_unlock(&dcache_lock);
+	return de;
+}
+
 /*
  *	Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
@@ -835,28 +841,22 @@ struct dentry * d_alloc_anon(struct inod
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
+	res = __d_find_alias(inode, 0);
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
+		res->d_flags |= DCACHE_DISCONNECTED;
+		res->d_vfs_flags &= ~DCACHE_UNHASHED;
+		list_add(&res->d_alias, &inode->i_dentry);
+		hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
+		spin_unlock(&res->d_lock);
+
 		inode = NULL; /* don't drop reference */
 	}
 	spin_unlock(&dcache_lock);
@@ -878,7 +878,7 @@ struct dentry * d_alloc_anon(struct inod
  * DCACHE_DISCONNECTED), then d_move that in place of the given dentry
  * and return it, else simply d_add the inode to the dentry and return NULL.
  *
- * This is (will be) needed in the lookup routine of any filesystem that is exportable
+ * This is needed in the lookup routine of any filesystem that is exportable
  * (via knfsd) so that we can build dcache paths to directories effectively.
  *
  * If a dentry was found and moved, then it is returned.  Otherwise NULL
@@ -889,11 +889,11 @@ struct dentry *d_splice_alias(struct ino
 {
 	struct dentry *new = NULL;
 
-	if (inode && S_ISDIR(inode->i_mode)) {
+	if (inode) {
 		spin_lock(&dcache_lock);
-		if (!list_empty(&inode->i_dentry)) {
-			new = list_entry(inode->i_dentry.next, struct dentry, d_alias);
-			__dget_locked(new);
+		new = __d_find_alias(inode, 1);
+		if (new) {
+			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);
