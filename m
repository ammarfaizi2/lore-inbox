Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbRCWTNo>; Fri, 23 Mar 2001 14:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbRCWTNd>; Fri, 23 Mar 2001 14:13:33 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:60144 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S131346AbRCWTNT>; Fri, 23 Mar 2001 14:13:19 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103231911.f2NJBps23651@webber.adilger.int>
Subject: Re: [linux-lvm] EXT2-fs panic (device lvm(58,0)):
In-Reply-To: <Pine.GSO.4.21.0103230631540.8373-100000@weyl.math.psu.edu> from
 Alexander Viro at "Mar 23, 2001 06:44:24 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 23 Mar 2001 12:11:51 -0700 (MST)
CC: Linux FS development list <linux-fsdevel@vger.kernel.org>,
        Linux kernel development list <linux-kernel@vger.kernel.org>,
        HPFS maintainer <mikulas@artax.karlin.mff.cuni.cz>,
        nfs@lists.sourceforge.net, samba@samba.org,
        linux_udf@hootie.lvld.hp.com, UFS maintainer <daniel.pirkl@email.cz>,
        Reiserfs mailing list <reiserfs-list@namesys.com>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al writes:
> On Thu, 22 Mar 2001, Andreas Dilger wrote:
> > If this is the case, then all of the other zero initializations can be
> > removed as well.  I figured that if most of the fields were being
> > zeroed, then ones _not_ being zeroed would lead to this problem.
> 
> 	Other zero initializations in inode->u certainly can be
> removed, but whether it's worth doing or not depends is a matter of
> taste (recall the flamefest around Tigran's crusade against global
> zero initializers several months ago ;-)

Yes, but now it is common practise to remove any global zero inits.

> 	The rule is that inode->u is zeroed before fs gets to see
> the inode, be it in ->read_inode() or after get_empty_inode().
> The rest is private business of that fs. That's what ->u is about,
> after all...

I did a quick check through the 2.4 tree looking for zero initializations
on the ->u data in *_read_inode() and *_new_inode().  Some set individual
fields to zero and others to non-zero values, some only set non-zero
values, and some did memset(inode->u.*_i, 0, sizeof(inode->u.*_i)) before
filling in their private data.

Patch attached, and filesystem maintainers (as applicable) CC'd.  UDF
needs a bit of looking into, because I'm not 100% sure of the code.

Cheers, Andreas
=========================================================================
diff -ru linux-2.4.3p6/fs/affs/inode.c linux-2.4.3p6-aed/fs/affs/inode.c
--- linux-2.4.3p6/fs/affs/inode.c	Wed Feb 21 19:09:45 2001
+++ linux-2.4.3p6-aed/fs/affs/inode.c	Fri Mar 23 01:11:52 2001
@@ -324,14 +324,8 @@
 	inode->i_ino     = block;
 	inode->i_mtime   = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 
-	inode->u.affs_i.i_original  = 0;
+	/* The inode->u struct is zeroed for us by new_inode() */
 	inode->u.affs_i.i_parent    = dir->i_ino;
-	inode->u.affs_i.i_zone      = 0;
-	inode->u.affs_i.i_hlink     = 0;
-	inode->u.affs_i.i_pa_cnt    = 0;
-	inode->u.affs_i.i_pa_next   = 0;
-	inode->u.affs_i.i_pa_last   = 0;
-	inode->u.affs_i.i_ec        = NULL;
 	inode->u.affs_i.i_lastblock = -1;
 
 	insert_inode_hash(inode);
diff -ru linux-2.4.3p6/fs/coda/inode.c linux-2.4.3p6-aed/fs/coda/inode.c
--- linux-2.4.3p6/fs/coda/inode.c	Fri Mar 23 10:54:50 2001
+++ linux-2.4.3p6-aed/fs/coda/inode.c	Fri Mar 23 10:57:05 2001
@@ -209,7 +209,7 @@
             return;
         }
 
-	memset(cii, 0, sizeof(struct coda_inode_info));
+	/* The inode->u struct is zeroed for us by clear_inode() */
 	list_add(&cii->c_cilist, &sbi->sbi_cihead);
         cii->c_magic = CODA_CNODE_MAGIC;
 }
diff -ru linux-2.4.3p6/fs/ext2/ialloc.c linux-2.4.3p6-aed/fs/ext2/ialloc.c
--- linux-2.4.3p6/fs/ext2/ialloc.c	Fri Dec  8 18:35:54 2000
+++ linux-2.4.3p6-aed/fs/ext2/ialloc.c	Fri Mar 23 00:47:46 2001
@@ -432,16 +416,13 @@
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	/* The inode->u struct is zeroed for us by new_inode() */
 	inode->u.ext2_i.i_new_inode = 1;
 	inode->u.ext2_i.i_flags = dir->u.ext2_i.i_flags;
 	if (S_ISLNK(mode))
 		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL | EXT2_APPEND_FL);
-	inode->u.ext2_i.i_faddr = 0;
-	inode->u.ext2_i.i_frag_no = 0;
-	inode->u.ext2_i.i_frag_size = 0;
-	inode->u.ext2_i.i_file_acl = 0;
-	inode->u.ext2_i.i_dir_acl = 0;
-	inode->u.ext2_i.i_dtime = 0;
 	inode->u.ext2_i.i_block_group = i;
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
diff -ru linux-2.4.3p6/fs/hpfs/inode.c linux-2.4.3p6-aed/fs/hpfs/inode.c
--- linux-2.4.3p6/fs/hpfs/inode.c	Mon Jan 22 11:40:47 2001
+++ linux-2.4.3p6-aed/fs/hpfs/inode.c	Fri Mar 23 01:02:36 2001
@@ -68,21 +68,9 @@
 	i->i_blksize = 512;
 	i->i_size = -1;
 	i->i_blocks = -1;
-	
-	i->i_hpfs_dno = 0;
-	i->i_hpfs_n_secs = 0;
-	i->i_hpfs_file_sec = 0;
-	i->i_hpfs_disk_sec = 0;
-	i->i_hpfs_dpos = 0;
-	i->i_hpfs_dsubdno = 0;
-	i->i_hpfs_ea_mode = 0;
-	i->i_hpfs_ea_uid = 0;
-	i->i_hpfs_ea_gid = 0;
-	i->i_hpfs_ea_size = 0;
-	i->i_version = ++event;
 
-	i->i_hpfs_rddir_off = NULL;
-	i->i_hpfs_dirty = 0;
+	/* The inode->u struct is zeroed for us by clear_inode() */
+	i->i_version = ++event;
 
 	i->i_atime = 0;
 	i->i_mtime = 0;
diff -ru linux-2.4.3p6/fs/nfs/inode.c linux-2.4.3p6-aed/fs/nfs/inode.c
--- linux-2.4.3p6/fs/nfs/inode.c	Fri Mar 23 10:54:52 2001
+++ linux-2.4.3p6-aed/fs/nfs/inode.c	Fri Mar 23 10:57:06 2001
@@ -98,17 +98,11 @@
 	inode->i_blksize = inode->i_sb->s_blocksize;
 	inode->i_mode = 0;
 	inode->i_rdev = 0;
+	/* The inode->u struct is zeroed for us by clear_inode() */
-	NFS_FILEID(inode) = 0;
-	NFS_FSID(inode) = 0;
-	NFS_FLAGS(inode) = 0;
 	INIT_LIST_HEAD(&inode->u.nfs_i.read);
 	INIT_LIST_HEAD(&inode->u.nfs_i.dirty);
 	INIT_LIST_HEAD(&inode->u.nfs_i.commit);
 	INIT_LIST_HEAD(&inode->u.nfs_i.writeback);
-	inode->u.nfs_i.nread = 0;
-	inode->u.nfs_i.ndirty = 0;
-	inode->u.nfs_i.ncommit = 0;
-	inode->u.nfs_i.npages = 0;
 	NFS_CACHEINV(inode);
 	NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 	NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
diff -ru linux-2.4.3p6/fs/reiserfs/inode.c linux-2.4.3p6-aed/fs/reiserfs/inode.c
--- linux-2.4.3p6/fs/reiserfs/inode.c	Fri Mar 23 10:54:53 2001
+++ linux-2.4.3p6-aed/fs/reiserfs/inode.c	Fri Mar 23 10:57:06 2001
@@ -946,8 +946,7 @@
 	rdev = le32_to_cpu (sd->u.sd_rdev);
     }
 
-    /* nopack = 0, by default */
-    inode->u.reiserfs_i.nopack = 0;
+    /* The inode->u struct is zeroed for us by get_empty_inode() */
 
     pathrelse (path);
     if (S_ISREG (inode->i_mode)) {
diff -ru linux-2.4.3p6/fs/smbfs/inode.c linux-2.4.3p6-aed/fs/smbfs/inode.c
--- linux-2.4.3p6/fs/smbfs/inode.c	Fri Mar 23 10:54:53 2001
+++ linux-2.4.3p6-aed/fs/smbfs/inode.c	Fri Mar 23 10:57:06 2001
@@ -65,7 +65,7 @@
 	if (!result)
 		return result;
 	result->i_ino = fattr->f_ino;
-	memset(&(result->u.smbfs_i), 0, sizeof(result->u.smbfs_i));
+	/* The inode->u struct is zeroed for us by new_inode() */
 	smb_set_inode_attr(result, fattr);
 	if (S_ISREG(result->i_mode)) {
 		result->i_op = &smb_file_inode_operations;
diff -ru linux-2.4.3p6/fs/udf/ialloc.c linux-2.4.3p6-aed/fs/udf/ialloc.c
--- linux-2.4.3p6/fs/udf/ialloc.c	Fri Nov 17 12:35:27 2000
+++ linux-2.4.3p6-aed/fs/udf/ialloc.c	Fri Mar 23 00:49:54 2001
@@ -127,15 +127,12 @@
 	inode->i_ino = udf_get_lb_pblock(sb, UDF_I_LOCATION(inode), 0);
 	inode->i_blksize = PAGE_SIZE;
 	inode->i_blocks = 0;
-	UDF_I_LENEATTR(inode) = 0;
-	UDF_I_LENALLOC(inode) = 0;
+	/* The inode->u struct is zeroed for us by new_inode() */
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_EXTENDED_FE))
 	{
 		UDF_I_EXTENDED_FE(inode) = 1;
 		UDF_UPDATE_UDFREV(inode->i_sb, UDF_VERS_USE_EXTENDED_FE);
 	}
-	else
-		UDF_I_EXTENDED_FE(inode) = 0;
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_AD_IN_ICB))
 		UDF_I_ALLOCTYPE(inode) = ICB_FLAG_AD_IN_ICB;
 	else if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
diff -ru linux-2.4.3p6/fs/ufs/ialloc.c linux-2.4.3p6-aed/fs/ufs/ialloc.c
--- linux-2.4.3p6/fs/ufs/ialloc.c	Thu Nov 16 14:18:26 2000
+++ linux-2.4.3p6-aed/fs/ufs/ialloc.c	Fri Mar 23 00:51:16 2001
@@ -271,7 +271,7 @@
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->u.ufs_i.i_flags = dir->u.ufs_i.i_flags;
-	inode->u.ufs_i.i_lastfrag = 0;
+	/* The inode->u struct is zeroed for us by new_inode() */
 
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
