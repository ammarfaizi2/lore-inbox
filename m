Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUI2Vqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUI2Vqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUI2Vqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:46:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:60164 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269068AbUI2VqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:46:19 -0400
Date: Wed, 29 Sep 2004 22:45:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, neilb@cse.unsw.edu.au,
       Greg Banks <gnb@melbourne.sgi.com>,
       "akpm @ osdl. org Anando Bhattacharya" <a3217055@gmail.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Re: Major XFS problems...
Message-ID: <20040929224558.A18353@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>, neilb@cse.unsw.edu.au,
	Greg Banks <gnb@melbourne.sgi.com>,
	"akpm @ osdl. org Anando Bhattacharya" <a3217055@gmail.com>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
	Linus Torvalds <torvalds@osdl.org>
References: <20040908123524.GZ390@unthought.net> <322909db040908080456c9f291@mail.gmail.com> <20040908154434.GE390@unthought.net> <1094661418.19981.36.camel@hole.melbourne.sgi.com> <20040909140017.GP390@unthought.net> <20040913072918.GU390@unthought.net> <20040917112647.GC390@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040917112647.GC390@unthought.net>; from jakob@unthought.net on Fri, Sep 17, 2004 at 01:26:47PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 01:26:47PM +0200, Jakob Oestergaard wrote:
> In the light of all this, I would like to suggest that the following
> patch is included in mainline - it is the old patch from Neil Brown
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=108330112505555&w=2)
> adapted by me for 2.6.8.1 (this patch was attached to a previous mail
> from me in this thread as well):


Neil, any chance we could get this patch into mainline ASAP?  Without
it we get ->get_parent called on non-directories under heavy NFS loads..


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


PS: I'll be without internet access from now until sunday the 26th - if
there are comments or questions, please make sure they are sent to this
list and/or as@cohaesio.com - Anders can get in touch with me if
necessary.


-- 

 / jakob

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
