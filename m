Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132116AbRADA00>; Wed, 3 Jan 2001 19:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132059AbRADA0H>; Wed, 3 Jan 2001 19:26:07 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:47882 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131058AbRADA0B>; Wed, 3 Jan 2001 19:26:01 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 4 Jan 2001 11:25:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14931.49919.203847.122344@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: PATCH(prerelease) - knfsd fix
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus/Alan,

please accept the following patch for knfsd in 2.4.0-prerelease.

What it does is extend the protection offered by  s_nfsd_free_path_sem
to cover the first call to nfsd_iget.
I had previously avoided this as I didn't think it was necessary and
it ment that the semaphore wasn't claimed at all on the common path.
However Chip Salzenberg managed to convince me that it is needed.
I think that his case-in-point is mentioned towards the end of

  http://www.cnn.com/2001/TECH/computing/01/03/linux.mission.idg/index.html

under "Taking the plunge".

There is actually more that I would like to do to this code, but I
don't think now is the right time.  This is the minimal change that
will fix a real bug.

NeilBrown


--- ./fs/nfsd/nfsfh.c	2001/01/04 00:09:13	1.1
+++ ./fs/nfsd/nfsfh.c	2001/01/04 00:09:37	1.2
@@ -346,7 +346,7 @@
 	struct dentry *dentry, *result = NULL;
 	struct dentry *tmp;
 	int  found =0;
-	int err;
+	int err = -ESTALE;
 	/* the sb->s_nfsd_free_path_sem semaphore is needed to make sure that only one unconnected (free)
 	 * dcache path ever exists, as otherwise two partial paths might get
 	 * joined together, which would be very confusing.
@@ -360,19 +360,18 @@
 	 * Attempt to find the inode.
 	 */
  retry:
+	down(&sb->s_nfsd_free_path_sem);
 	result = nfsd_iget(sb, ino, generation);
-	err = PTR_ERR(result);
-	if (IS_ERR(result))
-		goto err_out;
-	err = -ESTALE;
-	if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED))
-		return result;
-
-	/* result is now an anonymous dentry, which may be adequate as it stands, or else
-	 * will get spliced into the dcache tree */
-
-	if (!S_ISDIR(result->d_inode->i_mode) && ! needpath) {
-		nfsdstats.fh_anon++;
+	if (IS_ERR(result)
+	    || !(result->d_flags & DCACHE_NFSD_DISCONNECTED)
+	    || (!S_ISDIR(result->d_inode->i_mode) && ! needpath)) {
+		up(&sb->s_nfsd_free_path_sem);
+	    
+		err = PTR_ERR(result);
+		if (IS_ERR(result))
+			goto err_out;
+		if ((result->d_flags & DCACHE_NFSD_DISCONNECTED))
+			nfsdstats.fh_anon++;
 		return result;
 	}
 
@@ -380,14 +379,6 @@
 	 * location in the tree.
 	 */
 	dprintk("nfs_fh: need to look harder for %d/%ld\n",sb->s_dev,ino);
-	down(&sb->s_nfsd_free_path_sem);
-
-	/* claiming the semaphore might have allowed things to get fixed up */
-	if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
-		up(&sb->s_nfsd_free_path_sem);
-		return result;
-	}
-
 
 	found = 0;
 	if (!S_ISDIR(result->d_inode->i_mode)) {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
