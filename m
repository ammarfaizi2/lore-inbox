Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131682AbQKXF3x>; Fri, 24 Nov 2000 00:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131788AbQKXF3n>; Fri, 24 Nov 2000 00:29:43 -0500
Received: from nat-dial-160.valinux.com ([198.186.202.160]:19955 "EHLO
        tytlal.z.streaker.org") by vger.kernel.org with ESMTP
        id <S131682AbQKXF31>; Fri, 24 Nov 2000 00:29:27 -0500
Date: Thu, 23 Nov 2000 20:56:55 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: NFSD dentry manipulation (was Re: d_move())
Message-ID: <20001123205655.A10506@valinux.com>
In-Reply-To: <20001121011744.A2147@valinux.com> <20001121101836.C7075@valinux.com> <14877.50621.10445.237897@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14877.50621.10445.237897@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Fri, Nov 24, 2000 at 12:34:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Neil Brown:
>  You suggest that d_move (or it's caller) must be able to deal with
>  the [second parameter] being an "root" dentry (x->d_parent == x).
>  However, I cannot see that this could possibly happen.

Hmph.  It seems you're right; my d_move changes [1][2] were apparently
not required after all.  However...

The sum of my recent NFS patches incontrovertably turned a totally
unstable server into the very model of stability.  Why?

Let's assume that d_move was a red herring.  What else in the old code
could have cause dentry bugs?  My first thought on that is that the
old code (1) created multiple disconnected dentries for a given inode,
and yet (2) assumed that multiple disconnected dentries would never be
found.  I invite others' opinions.  And I've included a copy of my
recent patches (less d_move) below.

[1] I still think it would be reasonable for d_move() to handle root
    dentries, or at least oops on them for debugging.
[2] One bit of the d_splice patches is unrelated to d_move, namely,
    the move of 'dput(tdentry)' to the bottom of d_splice, allowing
    the 'parent' flag manipulation to finish before calling dput(),
    which can sleep.  But knfsd uses the big kernel lock, so I guess
    that's probably no issue either.

Index: fs/nfsd/nfsfh.c
--- fs/nfsd/nfsfh.c.prev
+++ fs/nfsd/nfsfh.c	Mon Nov 20 22:31:52 2000
@@ -108,4 +108,15 @@ static int get_ino_name(struct dentry *d
 	}
 
+	if (!error) {
+	    /*
+	     * Check for a fs-specific hash function. Note that we must
+	     * calculate the standard hash first, as the d_op->d_hash()
+	     * routine may choose to leave the hash value unchanged.
+	     */
+	    name->hash = full_name_hash(name->name, name->len);
+	    if (dentry->d_op && dentry->d_op->d_hash)
+		error = dentry->d_op->d_hash(dentry, name);
+	}
+
 out_close:
 	if (file.f_op->release)
@@ -115,4 +126,35 @@ out:
 }
 
+/* Arrange a dentry for the given inode:
+ *  1. Prefer an existing connected dentry.
+ *  2. Settle for an existing disconnected dentry.
+ *  3. If necessary, create a (disconnected) dentry.
+ */
+static struct dentry *nfsd_arrange_dentry(struct inode *inode)
+{
+	struct list_head *lp;
+	struct dentry *result;
+
+	result = NULL;
+	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
+		result = list_entry(lp,struct dentry, d_alias);
+		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED))
+			break;
+	}
+	if (result) {
+		dget(result);
+		iput(inode);
+	} else {
+		result = d_alloc_root(inode, NULL);
+		if (!result) {
+			iput(inode);
+			return ERR_PTR(-ENOMEM);
+		}
+		result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+		d_rehash(result); /* so a dput won't loose it */
+	}
+	return result;
+}
+
 /* this should be provided by each filesystem in an nfsd_operations interface;
  * iget isn't really the right interface
@@ -121,6 +163,4 @@ static struct dentry *nfsd_iget(struct s
 {
 	struct inode *inode;
-	struct list_head *lp;
-	struct dentry *result;
 
 	inode = iget(sb, ino);
@@ -149,23 +189,6 @@ static struct dentry *nfsd_iget(struct s
 		return ERR_PTR(-ESTALE);
 	}
-	/* now to find a dentry.
-	 * If possible, get a well-connected one
-	 */
-	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
-		result = list_entry(lp,struct dentry, d_alias);
-		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
-			dget(result);
-			iput(inode);
-			return result;
-		}
-	}
-	result = d_alloc_root(inode, NULL);
-	if (result == NULL) {
-		iput(inode);
-		return ERR_PTR(-ENOMEM);
-	}
-	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
-	d_rehash(result); /* so a dput won't loose it */
-	return result;
+
+	return nfsd_arrange_dentry(inode);
 }
 
@@ -228,43 +245,21 @@ int d_splice(struct dentry *target, stru
 struct dentry *nfsd_findparent(struct dentry *child)
 {
-	struct dentry *tdentry, *pdentry;
-	tdentry = d_alloc(child, &(const struct qstr) {"..", 2, 0});
-	if (!tdentry)
+	struct dentry *dotdot, *parent;
+
+	dotdot = d_alloc(child, &(const struct qstr) {"..", 2, 0});
+	if (!dotdot)
 		return ERR_PTR(-ENOMEM);
+	parent = child->d_inode->i_op->lookup(child->d_inode, dotdot);
+	d_drop(dotdot); /* we never want ".." hashed */
 
-	/* I'm going to assume that if the returned dentry is different, then
-	 * it is well connected.  But nobody returns different dentrys do they?
-	 */
-	pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
-	d_drop(tdentry); /* we never want ".." hashed */
-	if (!pdentry) {
-		/* I don't want to return a ".." dentry.
-		 * I would prefer to return an unconnected "IS_ROOT" dentry,
-		 * though a properly connected dentry is even better
-		 */
-		/* if first or last of alias list is not tdentry, use that
-		 * else make a root dentry
-		 */
-		struct list_head *aliases = &tdentry->d_inode->i_dentry;
-		if (aliases->next != aliases) {
-			pdentry = list_entry(aliases->next, struct dentry, d_alias);
-			if (pdentry == tdentry)
-				pdentry = list_entry(aliases->prev, struct dentry, d_alias);
-			if (pdentry == tdentry)
-				pdentry = NULL;
-			if (pdentry) dget(pdentry);
-		}
-		if (pdentry == NULL) {
-			pdentry = d_alloc_root(igrab(tdentry->d_inode), NULL);
-			if (pdentry) {
-				pdentry->d_flags |= DCACHE_NFSD_DISCONNECTED;
-				d_rehash(pdentry);
-			}
-		}
-		if (pdentry == NULL)
-			pdentry = ERR_PTR(-ENOMEM);
+	if (parent)
+		dput(dotdot);	/* not hashed, thus discarded */
+	else {
+		/* Discard the ".." dentry, then arrange for a better one. */
+		struct inode *inode = igrab(dotdot->d_inode);
+		dput(dotdot);	/* not hashed, thus discarded */
+		parent = nfsd_arrange_dentry(inode);
 	}
-	dput(tdentry); /* it is not hashed, it will be discarded */
-	return pdentry;
+	return parent;
 }
 

-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
