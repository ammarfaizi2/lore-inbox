Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262942AbSITQ6P>; Fri, 20 Sep 2002 12:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262986AbSITQ6P>; Fri, 20 Sep 2002 12:58:15 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:59060 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262942AbSITQ6I>; Fri, 20 Sep 2002 12:58:08 -0400
Message-ID: <3D8B54CE.33488F1B@us.ibm.com>
Date: Fri, 20 Sep 2002 12:03:10 -0500
From: Duc Vianney <dvianney@us.ibm.com>
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       rddunlap@osdl.org
Subject: JFS performance in sequential write in tiobench benchmark
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the LWE2002 in SF, Randy Dunlap reported that JFS performs poorly
in sequential write in the tiobench benchmark.

The problem was caused by the fragmentation of files within an
allocation
group. Current JFS scheme allows more than one open file growing in an
allocation group. This scheme works fine under UP or single I/O thread
scenario because the blocks allocated to this file will mostly reside
in a contiguous disk area. However, under an SMP or multithreaded I/O
environment, the allocation for one file can be intermixed with the
allocation for another file. This will lead to the situation where it
might have a few blocks for one file followed by some blocks for another

file, and so on. The net result is all allocation groups may be
fragmented,
and the performance of sequential write suffers and degrades to that of
random write.

The solution is to keep the current allocation group for the current
open
file, and to find  another group for the new allocation for the new
file.
This is essentially the patch provided by Shaggy against JFS 1.0.22 and
against linux-2.4.19-pre5. The patch is herein attached below or can be
had at http://www-124.ibm.com/developerworks/patch/?group_id=35

I ran the tiobench benchmark on 2.4.20-pre6 with the patch, and the
data on sequential write throughput for 2, 4 and 6 threads has been
improved from 0.57 MB/s, 1.25 MB/s and 1.36 MB/s to 14.81 MB/s,
15.44 MB/s and 15.66 MB/s respectively. The test partition is 1 GB,
file size is 128MB, and block size is 4KB. The test system is a 4-way
SMP 500MHz, SCSI drive. The following data are in thoughput, MB/s.

Threads   JFS 1.0.22   JFS 1.0.22+Patch
  1         14.04          14.21
  2          0.57          14.81
  4          1.25          15.44
  6          1.36          15.66

Please run your file system test bucket to verify my results.

dbAlloc.patch to fix JFS fragmentation problem in SMP environment


===== fs/jfs/file.c 1.6 vs edited =====
--- 1.6/fs/jfs/file.c Wed Sep  4 16:15:06 2002
+++ edited/fs/jfs/file.c Mon Sep 16 17:02:24 2002
@@ -19,6 +19,7 @@

 #include <linux/fs.h>
 #include "jfs_incore.h"
+#include "jfs_dmap.h"
 #include "jfs_txnmgr.h"
 #include "jfs_xattr.h"
 #include "jfs_debug.h"
@@ -96,6 +97,42 @@
  IWRITE_UNLOCK(ip);
 }

+static int jfs_open(struct inode *inode, struct file *file)
+{
+ int rc;
+
+ if ((rc = generic_file_open(inode, file)))
+  return rc;
+
+ /*
+  * We attempt to allow only one "active" file open per aggregate
+  * group.  Otherwise, appending to files in parallel can cause
+  * fragmentation within the files.
+  */
+ if (S_ISREG(inode->i_mode) && file->f_mode & FMODE_WRITE) {
+  struct jfs_inode_info *ji = JFS_IP(inode);
+  if (ji->active_ag == -1) {
+   ji->active_ag = ji->agno;
+   atomic_inc(
+       &JFS_SBI(inode->i_sb)->bmap->db_active[ji->agno]);
+  }
+ }
+
+ return 0;
+}
+static int jfs_release(struct inode *inode, struct file *file)
+{
+ struct jfs_inode_info *ji = JFS_IP(inode);
+
+ if (ji->active_ag != -1) {
+  struct bmap *bmap = JFS_SBI(inode->i_sb)->bmap;
+  atomic_dec(&bmap->db_active[ji->active_ag]);
+  ji->active_ag = -1;
+ }
+
+ return 0;
+}
+
 struct inode_operations jfs_file_inode_operations = {
  .truncate = jfs_truncate,
  .setxattr = jfs_setxattr,
@@ -105,10 +142,11 @@
 };

 struct file_operations jfs_file_operations = {
- .open  = generic_file_open,
+ .open  = jfs_open,
  .llseek  = generic_file_llseek,
  .write  = generic_file_write,
  .read  = generic_file_read,
  .mmap  = generic_file_mmap,
  .fsync  = jfs_fsync,
+ .release = jfs_release,
 };
===== fs/jfs/inode.c 1.6 vs edited =====
--- 1.6/fs/jfs/inode.c Wed Sep  4 16:15:06 2002
+++ edited/fs/jfs/inode.c Tue Sep 17 13:14:51 2002
@@ -41,6 +41,13 @@

  jFYI(1, ("jfs_clear_inode called ip = 0x%p\n", inode));

+ if (ji->active_ag != -1) {
+  printk(KERN_ERR "jfs_clear_inode, active_ag = %d\n",
+         ji->active_ag);
+  printk(KERN_ERR "i_ino = %ld, i_mode = %o\n",
+         inode->i_ino, inode->i_mode);
+ }
+
  ASSERT(list_empty(&ji->mp_list));
  ASSERT(list_empty(&ji->anon_inode_list));

===== fs/jfs/jfs_dmap.c 1.2 vs edited =====
--- 1.2/fs/jfs/jfs_dmap.c Fri Aug  2 13:19:08 2002
+++ edited/fs/jfs/jfs_dmap.c Tue Sep 17 13:40:16 2002
@@ -234,6 +234,7 @@
  bmp->db_ipbmap = ipbmap;
  JFS_SBI(ipbmap->i_sb)->bmap = bmp;

+ memset(bmp->db_active, 0, sizeof(bmp->db_active));
  DBINITMAP(bmp->db_mapsize, ipbmap, &bmp->db_DBmap);

  /*
@@ -264,6 +265,7 @@
 int dbUnmount(struct inode *ipbmap, int mounterror)
 {
  bmap_t *bmp = JFS_SBI(ipbmap->i_sb)->bmap;
+ int i;

  if (!(mounterror || isReadOnly(ipbmap)))
   dbSync(ipbmap);
@@ -273,6 +275,14 @@
   */
  truncate_inode_pages(ipbmap->i_mapping, 0);

+ /*
+  * Sanity Check
+  */
+ for (i = 0; i < bmp->db_numag; i++)
+  if (atomic_read(&bmp->db_active[i]))
+   printk(KERN_ERR "dbUnmount: db_active[%d] = %d\n",
+          i, atomic_read(&bmp->db_active[i]));
+
  /* free the memory for the in-memory bmap. */
  kfree(bmp);

@@ -591,102 +601,77 @@
  *
  * FUNCTION:    find the preferred allocation group for new
allocations.
  *
- *  we try to keep the trailing (rightmost) allocation groups
- *  free for large allocations.  we try to do this by targeting
- *  new inode allocations towards the leftmost or 'active'
- *  allocation groups while keeping the rightmost or 'inactive'
- *  allocation groups free. once the active allocation groups
- *  have dropped to a certain percentage of free space, we add
- *  the leftmost inactive allocation group to the active set.
- *
- *  within the active allocation groups, we maintain a preferred
+ *  Within the allocation groups, we maintain a preferred
  *  allocation group which consists of a group with at least
- *  average free space over the active set. it is the preferred
- *  group that we target new inode allocation towards.  the
- *  tie-in between inode allocation and block allocation occurs
- *  as we allocate the first (data) block of an inode and specify
- *  the inode (block) as the allocation hint for this block.
+ *  average free space.  It is the preferred group that we target
+ *  new inode allocation towards.  The tie-in between inode
+ *  allocation and block allocation occurs as we allocate the
+ *  first (data) block of an inode and specify the inode (block)
+ *  as the allocation hint for this block.
+ *
+ *  We try to avoid having more than one open file growing in
+ *  an allocation group, as this will lead to fragmentation.
+ *  This differs from the old OS/2 method of trying to keep
+ *  empty ags around for large allocations.
  *
  * PARAMETERS:
  *      ipbmap -  pointer to in-core inode for the block map.
  *
  * RETURN VALUES:
  *      the preferred allocation group number.
- *
- * note: only called by dbAlloc();
  */
 int dbNextAG(struct inode *ipbmap)
 {
- s64 avgfree, inactfree, actfree, rem;
- int actags, inactags, l2agsize;
+ s64 avgfree;
+ int agpref;
+ s64 hwm = 0;
+ int i;
+ int next_best = -1;
  bmap_t *bmp = JFS_SBI(ipbmap->i_sb)->bmap;

  BMAP_LOCK(bmp);

- /* determine the number of active allocation groups (i.e.
-  * the number of allocation groups up to and including
-  * the rightmost allocation group with blocks allocated
-  * in it.
-  */
- actags = bmp->db_maxag + 1;
- assert(actags <= bmp->db_numag);
-
- /* get the number of inactive allocation groups (i.e. the
-  * number of allocation group following the rightmost group
-  * with allocation in it.
-  */
- inactags = bmp->db_numag - actags;
-
- /* determine how many blocks are in the inactive allocation
-  * groups. in doing this, we must account for the fact that
-  * the rightmost group might be a partial group (i.e. file
-  * system size is not a multiple of the group size).
-  */
- l2agsize = bmp->db_agl2size;
- rem = bmp->db_mapsize & (bmp->db_agsize - 1);
- inactfree = (inactags
-       && rem) ? ((inactags - 1) << l2agsize) +
-     rem : inactags << l2agsize;
-
- /* now determine how many free blocks are in the active
-  * allocation groups plus the average number of free blocks
-  * within the active ags.
-  */
- actfree = bmp->db_nfree - inactfree;
- avgfree = (u32) actfree / (u32) actags;
-
- /* check if not all of the allocation groups are active.
-  */
- if (actags < bmp->db_numag) {
-  /* not all of the allocation groups are active.  determine
-   * if we should extend the active set by 1 (i.e. add the
-   * group following the current active set).  we do so if
-   * the number of free blocks within the active set is less
-   * than the allocation group set and average free within
-   * the active set is less than 60%.  we activate a new group
-   * by setting the allocation group preference to the new
-   * group.
-   */
-  if (actfree < bmp->db_agsize &&
-      ((avgfree * 100) >> l2agsize) < 60)
-   bmp->db_agpref = actags;
- } else {
-  /* all allocation groups are in the active set.  check if
-   * the preferred allocation group has average free space.
-   * if not, re-establish the preferred group as the leftmost
-   * group with average free space.
-   */
-  if (bmp->db_agfree[bmp->db_agpref] < avgfree) {
-   for (bmp->db_agpref = 0; bmp->db_agpref < actags;
-        bmp->db_agpref++) {
-    if (bmp->db_agfree[bmp->db_agpref] <=
-        avgfree)
-     break;
-   }
-   assert(bmp->db_agpref < bmp->db_numag);
+ /* determine the average number of free blocks within the ags. */
+ avgfree = (u32)bmp->db_nfree / bmp->db_numag;
+
+ /*
+  * if the current preferred ag does not have an active allocator
+  * and has at least average freespace, return it
+  */
+ agpref = bmp->db_agpref;
+ if ((atomic_read(&bmp->db_active[agpref]) == 0) &&
+     (bmp->db_agfree[agpref] >= avgfree))
+  goto found;
+
+ /* From the last preferred ag, find the next one with at least
+  * average free space.
+  */
+ for (i = 0 ; i < bmp->db_numag; i++, agpref++) {
+  if (agpref == bmp->db_numag)
+   agpref = 0;
+
+  if (atomic_read(&bmp->db_active[agpref]))
+   /* open file is currently growing in this ag */
+   continue;
+  if (bmp->db_agfree[agpref] >= avgfree)
+   goto found;
+  else if (bmp->db_agfree[agpref] > hwm) {
+   hwm = bmp->db_agfree[agpref];
+   next_best = agpref;
   }
  }

+ /*
+  * If no inactive ag was found with average freespace, use the
+  * next best
+  */
+ if (next_best != -1)
+  agpref = next_best;
+
+ /* else agpref should be back to its original value */
+
+found:
+ bmp->db_agpref = agpref;
  BMAP_UNLOCK(bmp);

  /* return the preferred group.
@@ -694,7 +679,6 @@
  return (bmp->db_agpref);
 }

-
 /*
  * NAME: dbAlloc()
  *
@@ -743,6 +727,7 @@
  dmap_t *dp;
  int l2nb;
  s64 mapSize;
+ int writers;

  /* assert that nblocks is valid */
  assert(nblocks > 0);
@@ -767,11 +752,10 @@
  /* the hint should be within the map */
  assert(hint < mapSize);

- /* if no hint was specified or the number of blocks to be
-  * allocated is greater than the allocation group size, try
-  * to allocate anywhere.
+ /* if the number of blocks to be allocated is greater than the
+  * allocation group size, try to allocate anywhere.
   */
- if (hint == 0 || l2nb > bmp->db_agl2size) {
+ if (l2nb > bmp->db_agl2size) {
   IWRITE_LOCK(ipbmap);

   rc = dbAllocAny(bmp, nblocks, l2nb, results);
@@ -783,39 +767,34 @@
   goto write_unlock;
  }

+ /*
+  * If no hint, let dbNextAG recommend an allocation group
+  */
+ if (hint == 0)
+  goto pref_ag;
+
  /* we would like to allocate close to the hint.  adjust the
   * hint to the block following the hint since the allocators
   * will start looking for free space starting at this point.
-  * if the hint was the last block of the file system, try to
-  * allocate in the same allocation group as the hint.
   */
  blkno = hint + 1;
- if (blkno >= bmp->db_mapsize) {
-  blkno--;
-  goto tryag;
- }
+
+ if (blkno >= bmp->db_mapsize)
+  goto pref_ag;
+
+ agno = blkno >> bmp->db_agl2size;

  /* check if blkno crosses over into a new allocation group.
   * if so, check if we should allow allocations within this
-  * allocation group.  we try to keep the trailing (rightmost)
-  * allocation groups of the file system free for large
-  * allocations and may want to prevent this allocation from
-  * spilling over into this space.
-  */
- if ((blkno & (bmp->db_agsize - 1)) == 0) {
-  /* check if the AG is beyond the rightmost AG with
-   * allocations in it.  if so, call dbNextAG() to
-   * determine if the allocation should be allowed
-   * to proceed within this AG or should be targeted
-   * to another AG.
-   */
-  agno = blkno >> bmp->db_agl2size;
-  if (agno > bmp->db_maxag) {
-   agno = dbNextAG(ipbmap);
-   blkno = (s64) agno << bmp->db_agl2size;
-   goto tryag;
-  }
- }
+  * allocation group.
+  */
+ if ((blkno & (bmp->db_agsize - 1)) == 0)
+  /* check if the AG is currenly being written to.
+   * if so, call dbNextAG() to find a non-busy
+   * AG with sufficient free space.
+   */
+  if (atomic_read(&bmp->db_active[agno]))
+   goto pref_ag;

  /* check if the allocation request size can be satisfied from a
   * single dmap.  if so, try to allocate from the dmap containing
@@ -837,9 +816,8 @@
   /* first, try to satisfy the allocation request with the
    * blocks beginning at the hint.
    */
-  if ((rc =
-       dbAllocNext(bmp, dp, blkno,
-     (int) nblocks)) != ENOSPC) {
+  if ((rc = dbAllocNext(bmp, dp, blkno, (int) nblocks))
+      != ENOSPC) {
    if (rc == 0) {
     *results = blkno;
     DBALLOC(bmp->db_DBmap, bmp->db_mapsize,
@@ -851,12 +829,23 @@
    goto read_unlock;
   }

+  writers = atomic_read(&bmp->db_active[agno]);
+  if ((writers > 1) ||
+      ((writers == 1) && (JFS_IP(ip)->active_ag != agno))) {
+   /*
+    * Someone else is writing in this allocation
+    * group.  To avoid fragmenting, try another ag
+    */
+   release_metapage(mp);
+   IREAD_UNLOCK(ipbmap);
+   goto pref_ag;
+  }
+
   /* next, try to satisfy the allocation request with blocks
    * near the hint.
    */
   if ((rc =
-       dbAllocNear(bmp, dp, blkno, (int) nblocks, l2nb,
-     results))
+       dbAllocNear(bmp, dp, blkno, (int) nblocks, l2nb, results))
       != ENOSPC) {
    if (rc == 0) {
     DBALLOC(bmp->db_DBmap, bmp->db_mapsize,
@@ -869,10 +858,9 @@
   }

   /* try to satisfy the allocation request with blocks within
-   * the same allocation group as the hint.
+   * the same dmap as the hint.
    */
-  if ((rc =
-       dbAllocDmapLev(bmp, dp, (int) nblocks, l2nb, results))
+  if ((rc = dbAllocDmapLev(bmp, dp, (int) nblocks, l2nb, results))
       != ENOSPC) {
    if (rc == 0) {
     DBALLOC(bmp->db_DBmap, bmp->db_mapsize,
@@ -888,14 +876,30 @@
   IREAD_UNLOCK(ipbmap);
  }

-      tryag:
+ /* try to satisfy the allocation request with blocks within
+  * the same allocation group as the hint.
+  */
+ IWRITE_LOCK(ipbmap);
+ if ((rc = dbAllocAG(bmp, agno, nblocks, l2nb, results))
+     != ENOSPC) {
+  if (rc == 0)
+   DBALLOC(bmp->db_DBmap, bmp->db_mapsize,
+    *results, nblocks);
+  goto write_unlock;
+ }
+ IWRITE_UNLOCK(ipbmap);
+
+
+      pref_ag:
+ /*
+  * Let dbNextAG recommend a preferred allocation group
+  */
+ agno = dbNextAG(ipbmap);
  IWRITE_LOCK(ipbmap);

- /* determine the allocation group number of the hint and try to
-  * allocate within this allocation group.  if that fails, try to
+ /* Try to allocate within this allocation group.  if that fails, try
to
   * allocate anywhere in the map.
   */
- agno = blkno >> bmp->db_agl2size;
  if ((rc = dbAllocAG(bmp, agno, nblocks, l2nb, results)) == ENOSPC)
   rc = dbAllocAny(bmp, nblocks, l2nb, results);
  if (rc == 0) {
@@ -2302,11 +2306,9 @@
   * if so, establish the new maximum allocation group number by
   * searching left for the first allocation group with allocation.
   */
- if ((bmp->db_agfree[agno] == bmp->db_agsize
-      && agno == bmp->db_maxag) || (agno == bmp->db_numag - 1
-        && bmp->db_agfree[agno] ==
-        (bmp-> db_mapsize &
-         (BPERDMAP - 1)))) {
+ if ((bmp->db_agfree[agno] == bmp->db_agsize && agno == bmp->db_maxag)
||
+     (agno == bmp->db_numag - 1 &&
+      bmp->db_agfree[agno] == (bmp-> db_mapsize & (BPERDMAP - 1)))) {
   while (bmp->db_maxag > 0) {
    bmp->db_maxag -= 1;
    if (bmp->db_agfree[bmp->db_maxag] !=
===== fs/jfs/jfs_dmap.h 1.1 vs edited =====
--- 1.1/fs/jfs/jfs_dmap.h Fri May 31 08:19:23 2002
+++ edited/fs/jfs/jfs_dmap.h Mon Sep 16 15:11:38 2002
@@ -227,6 +227,7 @@
  dbmap_t db_bmap; /* on-disk aggregate map descriptor */
  struct inode *db_ipbmap; /* ptr to aggregate map incore inode */
  struct semaphore db_bmaplock; /* aggregate map lock */
+ atomic_t db_active[MAXAG]; /* count of active, open files in AG */
  u32 *db_DBmap;
 } bmap_t;

===== fs/jfs/jfs_extent.c 1.4 vs edited =====
--- 1.4/fs/jfs/jfs_extent.c Wed Sep  4 11:07:25 2002
+++ edited/fs/jfs/jfs_extent.c Mon Sep 16 22:06:11 2002
@@ -514,9 +514,12 @@
 static int
 extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
 {
+ struct jfs_inode_info *ji = JFS_IP(ip);
+ struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
  s64 nb, nblks, daddr, max;
- int rc, nbperpage = JFS_SBI(ip->i_sb)->nbperpage;
- bmap_t *mp = JFS_SBI(ip->i_sb)->bmap;
+ int rc, nbperpage = sbi->nbperpage;
+ bmap_t *bmp = sbi->bmap;
+ int ag;

  /* get the number of blocks to initially attempt to allocate.
   * we'll first try the number of blocks requested unless this
@@ -524,7 +527,7 @@
   * blocks in the map. in that case, we'll start off with the
   * maximum free.
   */
- max = (s64) 1 << mp->db_maxfreebud;
+ max = (s64) 1 << bmp->db_maxfreebud;
  if (*nblocks >= max && *nblocks > nbperpage)
   nb = nblks = (max > nbperpage) ? max : nbperpage;
  else
@@ -548,6 +551,18 @@

  *nblocks = nb;
  *blkno = daddr;
+
+ if (S_ISREG(ip->i_mode) && (ji->fileset == FILESYSTEM_I)) {
+  ag = BLKTOAG(daddr, sbi);
+  if (ji->active_ag == -1) {
+   atomic_inc(&bmp->db_active[ag]);
+   ji->active_ag = ag;
+  } else if (ji->active_ag != ag) {
+   atomic_dec(&bmp->db_active[ji->active_ag]);
+   atomic_inc(&bmp->db_active[ag]);
+   ji->active_ag = ag;
+  }
+ }

  return (0);
 }
===== fs/jfs/jfs_imap.c 1.7 vs edited =====
--- 1.7/fs/jfs/jfs_imap.c Wed Sep  4 16:15:06 2002
+++ edited/fs/jfs/jfs_imap.c Mon Sep 16 15:52:18 2002
@@ -428,6 +428,7 @@

  /* set the ag for the inode */
  JFS_IP(ip)->agno = BLKTOAG(agstart, sbi);
+ JFS_IP(ip)->active_ag = -1;

  return (rc);
 }
@@ -1364,6 +1365,7 @@
  DBG_DIALLOC(JFS_IP(ipimap)->i_imap, ip->i_ino);
  jfs_ip->ixpxd = iagp->inoext[extno];
  jfs_ip->agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+ jfs_ip->active_ag = -1;
 }


@@ -1419,15 +1421,27 @@
   * moving backward on the disk.)  compute the hint within the
   * file system and the iag.
   */
+
+ /* get the ag number of this iag */
+ agno = JFS_IP(pip)->agno;
+
+ if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
+  /*
+   * There is an open file actively growing.  We want to
+   * allocate new inodes from a different ag to avoid
+   * fragmentation problems.
+   */
+  agno = dbNextAG(JFS_SBI(pip->i_sb)->ipbmap);
+  AG_LOCK(imap, agno);
+  goto tryag;
+ }
+
  inum = pip->i_ino + 1;
  ino = inum & (INOSPERIAG - 1);

  /* back off the the hint if it is outside of the iag */
  if (ino == 0)
   inum = pip->i_ino;
-
- /* get the ag number of this iag */
- agno = JFS_IP(pip)->agno;

  /* lock the AG inode map information */
  AG_LOCK(imap, agno);
===== fs/jfs/jfs_incore.h 1.6 vs edited =====
--- 1.6/fs/jfs/jfs_incore.h Wed Sep  4 16:15:06 2002
+++ edited/fs/jfs/jfs_incore.h Mon Sep 16 15:27:00 2002
@@ -50,7 +50,7 @@
  long cflag;  /* commit flags  */
  u16 bxflag;  /* xflag of pseudo buffer? */
  unchar agno;  /* ag number   */
- unchar pad;  /* pad   */
+ signed char active_ag; /* ag currently allocating from */
  lid_t blid;  /* lid of pseudo buffer? */
  lid_t atlhead; /* anonymous tlock list head */
  lid_t atltail; /* anonymous tlock list tail */
===== fs/jfs/super.c 1.12 vs edited =====
--- 1.12/fs/jfs/super.c Wed Sep  4 16:36:18 2002
+++ edited/fs/jfs/super.c Mon Sep 16 22:28:30 2002
@@ -378,6 +378,7 @@
   init_rwsem(&jfs_ip->rdwrlock);
   init_MUTEX(&jfs_ip->commit_sem);
   jfs_ip->atlhead = 0;
+  jfs_ip->active_ag = -1;
  }
 }



