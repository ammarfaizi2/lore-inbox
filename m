Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131220AbRCGWEs>; Wed, 7 Mar 2001 17:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbRCGWEj>; Wed, 7 Mar 2001 17:04:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2718 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131220AbRCGWEX>;
	Wed, 7 Mar 2001 17:04:23 -0500
Date: Wed, 7 Mar 2001 17:04:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ncpfs: d_add + ncp_d_validate fixes
In-Reply-To: <20010307224900.A1907@vana.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0103071653280.3949-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Petr Vandrovec wrote:

> Hi Linus, hi Alan,
>   could you apply following patch into 2.4.2-ac14 and 2.4.3-pre4?
> It does:
> 
>    last three hunks: do not d_add() already hashed dentry.
>                      It is fix for problem discovered by Urban
>                      in his smbfs. Probably it is more utilized
>                      than ncpfs...
>    rest: moved test for dentry->d_parent != parent before
>                      call to d_validate(), instead of doing
>                      it in caller after ncp_d_validate() returns.
>                      Al Viro asked for this some time ago, but
>                      it somewhat did not found its way into 
>                      mainstream kernel yet...
>                      While I was on it, I changed ncp_d_validate
>                      layout a bit to get shorter code.

Petr, while you are at it, care to merge the following patch? It cleans up
both SMBFS and NCPFS side of this business and removes crap from
dcache.c. It's against vanilla 2.4.2, but it should apply at least to
2.4.3-pre2 - none of the relevant areas are affected.
							Cheers,
								Al

diff -urN S2/fs/dcache.c S2-d_validate/fs/dcache.c
--- S2/fs/dcache.c	Thu Feb 22 06:45:12 2001
+++ S2-d_validate/fs/dcache.c	Wed Mar  7 16:57:45 2001
@@ -744,57 +744,48 @@
 
 /**
  * d_validate - verify dentry provided from insecure source
- * @dentry: The dentry alleged to be valid
- * @dparent: The parent dentry
+ * @dentry: The dentry alleged to be valid child of @dparent
+ * @dparent: The parent dentry (known to be valid)
  * @hash: Hash of the dentry
  * @len: Length of the name
  *
  * An insecure source has sent us a dentry, here we verify it and dget() it.
  * This is used by ncpfs in its readdir implementation.
  * Zero is returned in the dentry is invalid.
- *
- * NOTE: This function does _not_ dereference the pointers before we have
- * validated them. We can test the pointer values, but we
- * must not actually use them until we have found a valid
- * copy of the pointer in kernel space..
  */
  
-int d_validate(struct dentry *dentry, struct dentry *dparent,
-	       unsigned int hash, unsigned int len)
+int d_validate(struct dentry *dentry, struct dentry *dparent)
 {
+	unsigned long dent_addr = (unsigned long) dentry;
+	unsigned long min_addr = PAGE_OFFSET;
+	unsigned long align_mask = 0x0F;
 	struct list_head *base, *lhp;
-	int valid = 1;
+	int valid = 0;
 
-	spin_lock(&dcache_lock);
-	if (dentry != dparent) {
-		base = d_hash(dparent, hash);
-		lhp = base;
-		while ((lhp = lhp->next) != base) {
-			if (dentry == list_entry(lhp, struct dentry, d_hash)) {
-				__dget_locked(dentry);
-				goto out;
-			}
-		}
-	} else {
-		/*
-		 * Special case: local mount points don't live in
-		 * the hashes, so we search the super blocks.
-		 */
-		struct super_block *sb = sb_entry(super_blocks.next);
+	if (dent_addr < min_addr)
+		goto out;
+	if (dent_addr > (unsigned long)high_memory - sizeof(struct dentry))
+		goto out;
+	if ((dent_addr & ~align_mask) != dent_addr)
+		goto out;
+	if ((!kern_addr_valid(dent_addr)) || (!kern_addr_valid(dent_addr -1 +
+						sizeof(struct dentry))))
+		goto out;
+
+	if (dentry->d_parent != dparent)
+		goto out;
 
-		for (; sb != sb_entry(&super_blocks); 
-		     sb = sb_entry(sb->s_list.next)) {
-			if (!sb->s_dev)
-				continue;
-			if (sb->s_root == dentry) {
-				__dget_locked(dentry);
-				goto out;
-			}
+	spin_lock(&dcache_lock);
+	lhp = base = d_hash(dparent, dentry->d_name.hash);
+	while ((lhp = lhp->next) != base) {
+		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
+			valid = 1;
+			__dget_locked(dentry);
+			break;
 		}
 	}
-	valid = 0;
-out:
 	spin_unlock(&dcache_lock);
+out:
 	return valid;
 }
 
diff -urN S2/fs/ncpfs/dir.c S2-d_validate/fs/ncpfs/dir.c
--- S2/fs/ncpfs/dir.c	Fri Feb 16 22:52:07 2001
+++ S2-d_validate/fs/ncpfs/dir.c	Wed Mar  7 16:58:11 2001
@@ -326,55 +326,14 @@
 	return res;
 }
 
-/* most parts from nfsd_d_validate() */
-static int
-ncp_d_validate(struct dentry *dentry)
-{
-	unsigned long dent_addr = (unsigned long) dentry;
-	unsigned long min_addr = PAGE_OFFSET;
-	unsigned long align_mask = 0x0F;
-	unsigned int len;
-	int valid = 0;
-
-	if (dent_addr < min_addr)
-		goto bad_addr;
-	if (dent_addr > (unsigned long)high_memory - sizeof(struct dentry))
-		goto bad_addr;
-	if ((dent_addr & ~align_mask) != dent_addr)
-		goto bad_align;
-	if ((!kern_addr_valid(dent_addr)) || (!kern_addr_valid(dent_addr -1 +
-						sizeof(struct dentry))))
-		goto bad_addr;
-	/*
-	 * Looks safe enough to dereference ...
-	 */
-	len = dentry->d_name.len;
-	if (len > NCP_MAXPATHLEN)
-		goto out;
-	/*
-	 * Note: d_validate doesn't dereference the parent pointer ...
-	 * just combines it with the name hash to find the hash chain.
-	 */
-	valid = d_validate(dentry, dentry->d_parent, dentry->d_name.hash, len);
-out:
-	return valid;
-
-bad_addr:
-	PRINTK("ncp_d_validate: invalid address %lx\n", dent_addr);
-	goto out;
-bad_align:
-	PRINTK("ncp_d_validate: unaligned address %lx\n", dent_addr);
-	goto out;
-}
-
 static struct dentry *
 ncp_dget_fpos(struct dentry *dentry, struct dentry *parent, unsigned long fpos)
 {
 	struct dentry *dent = dentry;
 	struct list_head *next;
 
-	if (ncp_d_validate(dent)) {
-		if (dent->d_parent == parent &&
+	if (d_validate(dent, parent)) {
+		if (dent->d_name.len <= NCP_MAXPATHLEN &&
 		   (unsigned long)dent->d_fsdata == fpos) {
 			if (!dent->d_inode) {
 				dput(dent);
diff -urN S2/fs/smbfs/cache.c S2-d_validate/fs/smbfs/cache.c
--- S2/fs/smbfs/cache.c	Thu Feb 22 06:45:15 2001
+++ S2-d_validate/fs/smbfs/cache.c	Wed Mar  7 16:57:57 2001
@@ -71,47 +71,6 @@
 	spin_unlock(&dcache_lock);
 }
 
-
-static int
-smb_d_validate(struct dentry *dentry)
-{
-	unsigned long dent_addr = (unsigned long) dentry;
-	unsigned long min_addr = PAGE_OFFSET;
-	unsigned long align_mask = 0x0F;
-	unsigned int len;
-	int valid = 0;
-
-	if (dent_addr < min_addr)
-		goto bad_addr;
-	if (dent_addr > (unsigned long)high_memory - sizeof(struct dentry))
-		goto bad_addr;
-	if ((dent_addr & ~align_mask) != dent_addr)
-		goto bad_align;
-	if ((!kern_addr_valid(dent_addr)) || (!kern_addr_valid(dent_addr -1 +
-						       sizeof(struct dentry))))
-		goto bad_addr;
-	/*
-	 * Looks safe enough to dereference ...
-	 */
-	len = dentry->d_name.len;
-	if (len > SMB_MAXPATHLEN)
-		goto out;
-	/*
-	 * Note: d_validate doesn't dereference the parent pointer ...
-	 * just combines it with the name hash to find the hash chain.
-	 */
-	valid = d_validate(dentry, dentry->d_parent, dentry->d_name.hash, len);
-out:
-	return valid;
-
-bad_addr:
-	printk(KERN_ERR "smb_d_validate: invalid address %lx\n", dent_addr);
-	goto out;
-bad_align:
-	printk(KERN_ERR "smb_d_validate: unaligned address %lx\n", dent_addr);
-	goto out;
-}
-
 /*
  * dget, but require that fpos and parent matches what the dentry contains.
  * dentry is not known to be a valid pointer at entry.
@@ -122,8 +81,8 @@
 	struct dentry *dent = dentry;
 	struct list_head *next;
 
-	if (smb_d_validate(dent)) {
-		if (dent->d_parent == parent &&
+	if (d_validate(dent, parent)) {
+		if (dent->d_name.len <= SMB_MAXPATHLEN &&
 		    (unsigned long)dent->d_fsdata == fpos) {
 			if (!dent->d_inode) {
 				dput(dent);
diff -urN S2/include/linux/dcache.h S2-d_validate/include/linux/dcache.h
--- S2/include/linux/dcache.h	Thu Feb 22 06:45:34 2001
+++ S2-d_validate/include/linux/dcache.h	Wed Mar  7 16:57:26 2001
@@ -217,7 +217,7 @@
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
-extern int d_validate(struct dentry *, struct dentry *, unsigned int, unsigned int);
+extern int d_validate(struct dentry *, struct dentry *);
 
 extern char * __d_path(struct dentry *, struct vfsmount *, struct dentry *,
 	struct vfsmount *, char *, int);

