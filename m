Return-Path: <linux-kernel-owner+w=401wt.eu-S932323AbXAISFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbXAISFw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbXAISFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:05:52 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35066 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932323AbXAISFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:05:50 -0500
Subject: [PATCH] JFS: possible recursive locking detected
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: Tomasz Kvarsin <kvarsin@gmail.com>, linux-kernel@vger.kernel.org,
       jfs-discussion@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1168350974.13500.5.camel@kleikamp.austin.ibm.com>
References: <5157576d0701082333h276b99f3l7a785f6e2f250c27@mail.gmail.com>
	 <45A3613F.1050604@in.ibm.com>
	 <1168350974.13500.5.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 12:05:46 -0600
Message-Id: <1168365947.14792.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 07:56 -0600, Dave Kleikamp wrote:
> On Tue, 2007-01-09 at 15:02 +0530, Srinivasa Ds wrote:
> > Tomasz Kvarsin wrote:
> > > This I got during boot with 2.6.20-rc4:
> > > =============================================
> > > [ INFO: possible recursive locking detected ]
> 
> ... 
> 
> > So below patch should fix this problem,please test this. Let me know 
> > your comments on this.
> 
> I'm sure there are several other places in the jfs code that need the
> same treatment.  I've put this off too long already.  I'll get a
> comprehensive lock annotation patch out today, starting with this one.

Okay,
Here it is.  I'd appreciate it if anyone who has looked into the lockdep
annotations would give this a sanity check.

Thanks,
Shaggy

JFS: Add lockdep annotations

Yeah, it's about time.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index f571911..e285022 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -182,9 +182,9 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	 * Take appropriate lock on inode
 	 */
 	if (create)
-		IWRITE_LOCK(ip);
+		IWRITE_LOCK(ip, RDWRLOCK_NORMAL);
 	else
-		IREAD_LOCK(ip);
+		IREAD_LOCK(ip, RDWRLOCK_NORMAL);
 
 	if (((lblock64 << ip->i_sb->s_blocksize_bits) < ip->i_size) &&
 	    (!xtLookup(ip, lblock64, xlen, &xflag, &xaddr, &xlen, 0)) &&
@@ -359,7 +359,7 @@ void jfs_truncate(struct inode *ip)
 
 	nobh_truncate_page(ip->i_mapping, ip->i_size);
 
-	IWRITE_LOCK(ip);
+	IWRITE_LOCK(ip, RDWRLOCK_NORMAL);
 	jfs_truncate_nolock(ip, ip->i_size);
 	IWRITE_UNLOCK(ip);
 }
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 23546c8..82b0544 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -337,7 +337,7 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
 	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
 
-	IREAD_LOCK(ipbmap);
+	IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 	/* block to be freed better be within the mapsize. */
 	if (unlikely((blkno == 0) || (blkno + nblocks > bmp->db_mapsize))) {
@@ -733,7 +733,7 @@ int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 	 * allocation group size, try to allocate anywhere.
 	 */
 	if (l2nb > bmp->db_agl2size) {
-		IWRITE_LOCK(ipbmap);
+		IWRITE_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 		rc = dbAllocAny(bmp, nblocks, l2nb, results);
 
@@ -774,7 +774,7 @@ int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 	 * the hint using a tiered strategy.
 	 */
 	if (nblocks <= BPERDMAP) {
-		IREAD_LOCK(ipbmap);
+		IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 		/* get the buffer for the dmap containing the hint.
 		 */
@@ -844,7 +844,7 @@ int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 	/* try to satisfy the allocation request with blocks within
 	 * the same allocation group as the hint.
 	 */
-	IWRITE_LOCK(ipbmap);
+	IWRITE_LOCK(ipbmap, RDWRLOCK_DMAP);
 	if ((rc = dbAllocAG(bmp, agno, nblocks, l2nb, results)) != -ENOSPC)
 		goto write_unlock;
 
@@ -856,7 +856,7 @@ int dbAlloc(struct inode *ip, s64 hint, s64 nblocks, s64 * results)
 	 * Let dbNextAG recommend a preferred allocation group
 	 */
 	agno = dbNextAG(ipbmap);
-	IWRITE_LOCK(ipbmap);
+	IWRITE_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 	/* Try to allocate within this allocation group.  if that fails, try to
 	 * allocate anywhere in the map.
@@ -900,7 +900,7 @@ int dbAllocExact(struct inode *ip, s64 blkno, int nblocks)
 	s64 lblkno;
 	struct metapage *mp;
 
-	IREAD_LOCK(ipbmap);
+	IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 	/*
 	 * validate extent request:
@@ -1050,7 +1050,7 @@ static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks)
 	 */
 	extblkno = lastblkno + 1;
 
-	IREAD_LOCK(ipbmap);
+	IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 	/* better be within the file system */
 	bmp = sbi->bmap;
@@ -3116,7 +3116,7 @@ int dbAllocBottomUp(struct inode *ip, s64 blkno, s64 nblocks)
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
 	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
 
-	IREAD_LOCK(ipbmap);
+	IREAD_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 	/* block to be allocated better be within the mapsize. */
 	ASSERT(nblocks <= bmp->db_mapsize - blkno);
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 53f63b4..aa5124b 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -331,7 +331,7 @@ int diRead(struct inode *ip)
 
 	/* read the iag */
 	imap = JFS_IP(ipimap)->i_imap;
-	IREAD_LOCK(ipimap);
+	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
 	rc = diIAGRead(imap, iagno, &mp);
 	IREAD_UNLOCK(ipimap);
 	if (rc) {
@@ -920,7 +920,7 @@ int diFree(struct inode *ip)
 	/* Obtain read lock in imap inode.  Don't release it until we have
 	 * read all of the IAG's that we are going to.
 	 */
-	IREAD_LOCK(ipimap);
+	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
 
 	/* read the iag.
 	 */
@@ -1415,7 +1415,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	AG_LOCK(imap, agno);
 
 	/* Get read lock on imap inode */
-	IREAD_LOCK(ipimap);
+	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
 
 	/* get the iag number and read the iag */
 	iagno = INOTOIAG(inum);
@@ -1808,7 +1808,7 @@ static int diAllocIno(struct inomap * imap, int agno, struct inode *ip)
 		return -ENOSPC;
 
 	/* obtain read lock on imap inode */
-	IREAD_LOCK(imap->im_ipimap);
+	IREAD_LOCK(imap->im_ipimap, RDWRLOCK_IMAP);
 
 	/* read the iag at the head of the list.
 	 */
@@ -1946,7 +1946,7 @@ static int diAllocExt(struct inomap * imap, int agno, struct inode *ip)
 	} else {
 		/* read the iag.
 		 */
-		IREAD_LOCK(imap->im_ipimap);
+		IREAD_LOCK(imap->im_ipimap, RDWRLOCK_IMAP);
 		if ((rc = diIAGRead(imap, iagno, &mp))) {
 			IREAD_UNLOCK(imap->im_ipimap);
 			jfs_error(ip->i_sb, "diAllocExt: error reading iag");
@@ -2509,7 +2509,7 @@ diNewIAG(struct inomap * imap, int *iagnop, int agno, struct metapage ** mpp)
 		 */
 
 		/* acquire inode map lock */
-		IWRITE_LOCK(ipimap);
+		IWRITE_LOCK(ipimap, RDWRLOCK_IMAP);
 
 		if (ipimap->i_size >> L2PSIZE != imap->im_nextiag + 1) {
 			IWRITE_UNLOCK(ipimap);
@@ -2648,7 +2648,7 @@ diNewIAG(struct inomap * imap, int *iagnop, int agno, struct metapage ** mpp)
 	}
 
 	/* obtain read lock on map */
-	IREAD_LOCK(ipimap);
+	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
 
 	/* read the iag */
 	if ((rc = diIAGRead(imap, iagno, &mp))) {
@@ -2779,7 +2779,7 @@ diUpdatePMap(struct inode *ipimap,
 		return -EIO;
 	}
 	/* read the iag */
-	IREAD_LOCK(ipimap);
+	IREAD_LOCK(ipimap, RDWRLOCK_IMAP);
 	rc = diIAGRead(imap, iagno, &mp);
 	IREAD_UNLOCK(ipimap);
 	if (rc)
diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 9400558..8f453ef 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -109,9 +109,11 @@ struct jfs_inode_info {
 
 #define JFS_ACL_NOT_CACHED ((void *)-1)
 
-#define IREAD_LOCK(ip)		down_read(&JFS_IP(ip)->rdwrlock)
+#define IREAD_LOCK(ip, subclass) \
+	down_read_nested(&JFS_IP(ip)->rdwrlock, subclass)
 #define IREAD_UNLOCK(ip)	up_read(&JFS_IP(ip)->rdwrlock)
-#define IWRITE_LOCK(ip)		down_write(&JFS_IP(ip)->rdwrlock)
+#define IWRITE_LOCK(ip, subclass) \
+	down_write_nested(&JFS_IP(ip)->rdwrlock, subclass)
 #define IWRITE_UNLOCK(ip)	up_write(&JFS_IP(ip)->rdwrlock)
 
 /*
@@ -127,6 +129,29 @@ enum cflags {
 	COMMIT_Synclist,	/* metadata pages on group commit synclist */
 };
 
+/*
+ * commit_mutex nesting subclasses:
+ */
+enum commit_mutex_class
+{
+	COMMIT_MUTEX_PARENT,
+	COMMIT_MUTEX_CHILD,
+	COMMIT_MUTEX_SECOND_PARENT,	/* Renaming */
+	COMMIT_MUTEX_VICTIM		/* Inode being unlinked due to rename */
+};
+
+/*
+ * rdwrlock subclasses:
+ * The dmap inode may be locked while a normal inode or the imap inode are
+ * locked.
+ */
+enum rdwrlock_class
+{
+	RDWRLOCK_NORMAL,
+	RDWRLOCK_IMAP,
+	RDWRLOCK_DMAP
+};
+
 #define set_cflag(flag, ip)	set_bit(flag, &(JFS_IP(ip)->cflag))
 #define clear_cflag(flag, ip)	clear_bit(flag, &(JFS_IP(ip)->cflag))
 #define test_cflag(flag, ip)	test_bit(flag, &(JFS_IP(ip)->cflag))
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index a6a8c16..7ab4756 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -104,8 +104,8 @@ static int jfs_create(struct inode *dip, struct dentry *dentry, int mode,
 
 	tid = txBegin(dip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dip)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	rc = jfs_init_acl(tid, ip, dip);
 	if (rc)
@@ -238,8 +238,8 @@ static int jfs_mkdir(struct inode *dip, struct dentry *dentry, int mode)
 
 	tid = txBegin(dip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dip)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	rc = jfs_init_acl(tid, ip, dip);
 	if (rc)
@@ -365,8 +365,8 @@ static int jfs_rmdir(struct inode *dip, struct dentry *dentry)
 
 	tid = txBegin(dip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dip)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	iplist[0] = dip;
 	iplist[1] = ip;
@@ -483,12 +483,12 @@ static int jfs_unlink(struct inode *dip, struct dentry *dentry)
 	if ((rc = get_UCSname(&dname, dentry)))
 		goto out;
 
-	IWRITE_LOCK(ip);
+	IWRITE_LOCK(ip, RDWRLOCK_NORMAL);
 
 	tid = txBegin(dip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dip)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	iplist[0] = dip;
 	iplist[1] = ip;
@@ -802,8 +802,8 @@ static int jfs_link(struct dentry *old_dentry,
 
 	tid = txBegin(ip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dir)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	/*
 	 * scan parent directory for entry/freespace
@@ -913,8 +913,8 @@ static int jfs_symlink(struct inode *dip, struct dentry *dentry,
 
 	tid = txBegin(dip->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dip)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	rc = jfs_init_security(tid, ip, dip);
 	if (rc)
@@ -1127,7 +1127,7 @@ static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out3;
 		}
 	} else if (new_ip) {
-		IWRITE_LOCK(new_ip);
+		IWRITE_LOCK(new_ip, RDWRLOCK_NORMAL);
 		/* Init inode for quota operations. */
 		DQUOT_INIT(new_ip);
 	}
@@ -1137,13 +1137,21 @@ static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 */
 	tid = txBegin(new_dir->i_sb, 0);
 
-	mutex_lock(&JFS_IP(new_dir)->commit_mutex);
-	mutex_lock(&JFS_IP(old_ip)->commit_mutex);
+	/*
+	 * How do we know the locking is safe from deadlocks?
+	 * The vfs does the hard part for us.  Any time we are taking nested
+	 * commit_mutexes, the vfs already has i_mutex held on the parent.
+	 * Here, the vfs has already taken i_mutex on both old_dir and new_dir.
+	 */
+	mutex_lock_nested(&JFS_IP(new_dir)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(old_ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 	if (old_dir != new_dir)
-		mutex_lock(&JFS_IP(old_dir)->commit_mutex);
+		mutex_lock_nested(&JFS_IP(old_dir)->commit_mutex,
+				  COMMIT_MUTEX_SECOND_PARENT);
 
 	if (new_ip) {
-		mutex_lock(&JFS_IP(new_ip)->commit_mutex);
+		mutex_lock_nested(&JFS_IP(new_ip)->commit_mutex,
+				  COMMIT_MUTEX_VICTIM);
 		/*
 		 * Change existing directory entry to new inode number
 		 */
@@ -1357,8 +1365,8 @@ static int jfs_mknod(struct inode *dir, struct dentry *dentry,
 
 	tid = txBegin(dir->i_sb, 0);
 
-	mutex_lock(&JFS_IP(dir)->commit_mutex);
-	mutex_lock(&JFS_IP(ip)->commit_mutex);
+	mutex_lock_nested(&JFS_IP(dir)->commit_mutex, COMMIT_MUTEX_PARENT);
+	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
 
 	rc = jfs_init_acl(tid, ip, dir);
 	if (rc)

-- 
David Kleikamp
IBM Linux Technology Center

