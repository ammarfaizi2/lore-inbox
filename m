Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUIIOE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUIIOE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 10:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUIIOE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 10:04:56 -0400
Received: from unthought.net ([212.97.129.88]:26316 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264299AbUIIOAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 10:00:19 -0400
Date: Thu, 9 Sep 2004 16:00:17 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Anando Bhattacharya <a3217055@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040909140017.GP390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Banks <gnb@melbourne.sgi.com>,
	Anando Bhattacharya <a3217055@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com> <20040908154434.GE390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1094661418.19981.36.camel@hole.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2004 at 02:36:58AM +1000, Greg Banks wrote:
> On Thu, 2004-09-09 at 01:44, Jakob Oestergaard wrote:
> > SMP systems on 2.6 have a problem with XFS+NFS.
> 
> Knfsd threads in 2.6 are no longer serialised by the BKL, and the
> change has exposed a number of SMP issues in the dcache.  Try the
> two patches at

Ok - the "small" server just hosed itself with a debug.c:106 - so I'll
be doing some testing on that one as well (after hours, today).

> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2

Ok, I must say that mail has some *scary* comments to the patch... This
should be interesting  :)

The patch assumes some dcache code is
--------------
if (res) {
 spin_lock(&res->d_lock);
 res->d_sb = inode->i_sb;
 res->d_parent = res;
 res->d_inode = inode;
 res->d_bucket = d_hash(res, res->d_name.hash);
 res->d_flags |= DCACHE_DISCONNECTED;
 res->d_vfs_flags &= ~DCACHE_UNHASHED;
 list_add(&res->d_alias, &inode->i_dentry);
 hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
 spin_unlock(&res->d_lock);
}
--------------
While it was actually changed to
--------------
if (res) {
 spin_lock(&res->d_lock);
 res->d_sb = inode->i_sb;
 res->d_parent = res;
 res->d_inode = inode;

 /*
  * Set d_bucket to an "impossible" bucket address so
  * that d_move() doesn't get a false positive
  */
 res->d_bucket = NULL;
 res->d_flags |= DCACHE_DISCONNECTED;
 res->d_flags &= ~DCACHE_UNHASHED;
 list_add(&res->d_alias, &inode->i_dentry);
 hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
 spin_unlock(&res->d_lock);
}
--------------

I'm assuming I should just adapt this to the res->d_bucket change...

New patch against 2.6.8.1 attached.

> 
> and
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@1.1722.48.23

This one is in plain 2.6.8.1 (as you said).

-- 

 / jakob


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcache-patch2_2.6.8.1.patch"

--- fs/dcache.c.orig	Sat Aug 14 12:54:50 2004
+++ fs/dcache.c	Thu Sep  9 15:56:04 2004
@@ -286,12 +286,11 @@
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
@@ -302,19 +301,26 @@
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
@@ -833,33 +839,27 @@
 	tmp->d_parent = tmp; /* make sure dput doesn't croak */
 	
 	spin_lock(&dcache_lock);
-	if (S_ISDIR(inode->i_mode) && !list_empty(&inode->i_dentry)) {
-		/* A directory can only have one dentry.
-		 * This (now) has one, so use it.
-		 */
-		res = list_entry(inode->i_dentry.next, struct dentry, d_alias);
-		__dget_locked(res);
-	} else {
+	res = __d_find_alias(inode, 0);
+	if (!res) {
 		/* attach a disconnected dentry */
 		res = tmp;
 		tmp = NULL;
-		if (res) {
-			spin_lock(&res->d_lock);
-			res->d_sb = inode->i_sb;
-			res->d_parent = res;
-			res->d_inode = inode;
+		spin_lock(&res->d_lock);
+		res->d_sb = inode->i_sb;
+		res->d_parent = res;
+		res->d_inode = inode;
+
+		/*
+		 * Set d_bucket to an "impossible" bucket address so
+		 * that d_move() doesn't get a false positive
+		 */
+		res->d_bucket = NULL;
+		res->d_flags |= DCACHE_DISCONNECTED;
+		res->d_flags &= ~DCACHE_UNHASHED;
+		list_add(&res->d_alias, &inode->i_dentry);
+		hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
+		spin_unlock(&res->d_lock);
 
-			/*
-			 * Set d_bucket to an "impossible" bucket address so
-			 * that d_move() doesn't get a false positive
-			 */
-			res->d_bucket = NULL;
-			res->d_flags |= DCACHE_DISCONNECTED;
-			res->d_flags &= ~DCACHE_UNHASHED;
-			list_add(&res->d_alias, &inode->i_dentry);
-			hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
-			spin_unlock(&res->d_lock);
-		}
 		inode = NULL; /* don't drop reference */
 	}
 	spin_unlock(&dcache_lock);
@@ -881,7 +881,7 @@
  * DCACHE_DISCONNECTED), then d_move that in place of the given dentry
  * and return it, else simply d_add the inode to the dentry and return NULL.
  *
- * This is (will be) needed in the lookup routine of any filesystem that is exportable
+ * This is needed in the lookup routine of any filesystem that is exportable
  * (via knfsd) so that we can build dcache paths to directories effectively.
  *
  * If a dentry was found and moved, then it is returned.  Otherwise NULL
@@ -892,11 +892,11 @@
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

--zhXaljGHf11kAtnf--
