Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262722AbRFOBos>; Thu, 14 Jun 2001 21:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbRFOBoj>; Thu, 14 Jun 2001 21:44:39 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:20239 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262722AbRFOBoY>; Thu, 14 Jun 2001 21:44:24 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: John Covici <covici@ccs.covici.com>,
        Knuth Posern <posern@Mathematik.Uni-Marburg.de>,
        Bob Sully <rcs@malibyte.net>, madhu@quickmonkey.com
Date: Fri, 15 Jun 2001 11:43:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.26678.795145.781375@notabene.cse.unsw.edu.au>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: is there a way to export a fat32 file system using nfs? - YES!
In-Reply-To: message from Neil Brown on Wednesday June 13
In-Reply-To: <15142.55093.846398.117560@notabene.cse.unsw.edu.au>
	<Pine.GSO.4.21.0106122304190.942-100000@weyl.math.psu.edu>
	<15142.57598.708971.905304@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 13, neilb@cse.unsw.edu.au wrote:
> 
> I might just do that first step (find_ino) and offer it as as an
> experimental patch to the growing number of people who have asked for
> nfs exporting of FAT filesystems, and see how reliable it is in
> practice.

Following is a patch against 2.4.6-pre3 which allows FAT (msdos or
VFAT) filesystems to be exported via NFS in Linux.

It should work reasonable well for simple accesses if the server
doesn't suffer too much memory pressure.

If the server reboots, if you hold a file open for extended periods
without much activity, or if the server needs to flush inodes due to
memory pressure, you will probably loose.

I would be interested to hear of how well it goes for anyone who needs
to use it.  If I get enough favourable response, I might submit it to Linus.

It is also available at:

  http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.6-pre3/patch-C-fatnfs

NeilBrown

--- ./fs/fat/inode.c	2001/06/13 23:07:25	1.1
+++ ./fs/fat/inode.c	2001/06/15 01:29:22	1.2
@@ -154,15 +154,19 @@
 
 void fat_delete_inode(struct inode *inode)
 {
-	lock_kernel();
-	inode->i_size = 0;
-	fat_truncate(inode);
-	unlock_kernel();
+	if (!is_bad_inode(inode)) {
+		lock_kernel();
+		inode->i_size = 0;
+		fat_truncate(inode);
+		unlock_kernel();
+	}
 	clear_inode(inode);
 }
 
 void fat_clear_inode(struct inode *inode)
 {
+	if (is_bad_inode(inode))
+		return;
 	lock_kernel();
 	spin_lock(&fat_inode_lock);
 	fat_cache_inval_inode(inode);
@@ -372,6 +376,7 @@
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode->i_version = ++event;
+	inode->i_generation = 0;
 	inode->i_mode = (S_IRWXUGO & ~sbi->options.fs_umask) | S_IFDIR;
 	inode->i_op = sbi->dir_ops;
 	inode->i_fop = &fat_dir_operations;
@@ -403,12 +408,123 @@
 	inode->i_nlink = fat_subdirs(inode)+2;
 }
 
+/*
+ * a FAT file handle with fhtype 3 is
+ *  0/  i_ino - for fast, reliable lookup if still in the cache
+ *  1/  i_generation - to see if i_ino is still valid
+ *          bit 0 == 0 iff directory
+ *  2/  i_location - if ino has changed, but still in cache
+ *  3/  i_logstart - to semi-verify inode found at i_location
+ *  4/  parent->i_logstart - maybe used to hunt for the file on disc
+ *
+ */
+struct dentry *fat_fh_to_dentry(struct super_block *sb, __u32 *fh,
+				int len, int fhtype, int parent)
+{
+	struct inode *inode = NULL;
+	struct list_head *lp;
+	struct dentry *result;
+
+	if (fhtype != 3)
+		return NULL;
+	if (len < 5)
+		return NULL;
+	if (parent)
+		return NULL; /* We cannot find the parent,
+				It better just *be* there */
+
+	inode = iget(sb, fh[0]);
+	if (!inode || is_bad_inode(inode) ||
+	    inode->i_generation != fh[1]) {
+		if (inode) iput(inode);
+		inode = NULL;
+	}
+	if (!inode) {
+		/* try 2 - see if i_location is in F-d-c
+		 * require i_logstart to be the same
+		 * Will fail if you truncate and then re-write
+		 */
+
+		inode = fat_iget(sb, fh[2]);
+		if (inode && MSDOS_I(inode)->i_logstart != fh[3]) {
+			iput(inode);
+			inode = NULL;
+		}
+	}
+	if (!inode) {
+		/* For now, do nothing
+		 * What we could do is:
+		 * follow the file starting at fh[4], and record
+		 * the ".." entry, and the name of the fh[2] entry.
+		 * The follow the ".." file finding the next step up.
+		 * This way we build a path to the root of
+		 * the tree. If this works, we lookup the path and so
+		 * get this inode into the cache.
+		 * Finally try the fat_iget lookup again
+		 * If that fails, then weare totally out of luck
+		 * But all that is for another day
+		 */
+	}
+	if (!inode)
+		return ERR_PTR(-ESTALE);
+
+	
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 *
+	 * Given the way that we found the inode, it *MUST* be
+	 * well-connected, but it is easiest to just copy the
+	 * code.
+	 */
+	spin_lock(&dcache_lock);
+	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
+		result = list_entry(lp,struct dentry, d_alias);
+		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
+			dget_locked(result);
+			result->d_vfs_flags |= DCACHE_REFERENCED;
+			spin_unlock(&dcache_lock);
+			iput(inode);
+			return result;
+		}
+	}
+	spin_unlock(&dcache_lock);
+	result = d_alloc_root(inode);
+	if (result == NULL) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+	return result;
+
+		
+}
+
+int fat_dentry_to_fh(struct dentry *de, __u32 *fh, int *lenp, int needparent)
+{
+	int len = *lenp;
+	struct inode *inode =  de->d_inode;
+	
+	if (len < 5)
+		return 255; /* no room */
+	*lenp = 5;
+	fh[0] = inode->i_ino;
+	fh[1] = inode->i_generation;
+	fh[2] = MSDOS_I(inode)->i_location;
+	fh[3] = MSDOS_I(inode)->i_logstart;
+	fh[4] = MSDOS_I(de->d_parent->d_inode)->i_logstart;
+	return 3;
+}
+
 static struct super_operations fat_sops = { 
 	write_inode:	fat_write_inode,
 	delete_inode:	fat_delete_inode,
 	put_super:	fat_put_super,
 	statfs:		fat_statfs,
 	clear_inode:	fat_clear_inode,
+
+	read_inode:	make_bad_inode,
+	fh_to_dentry:	fat_fh_to_dentry,
+	dentry_to_fh:	fat_dentry_to_fh,
 };
 
 /*
@@ -771,7 +887,10 @@
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode->i_version = ++event;
+	inode->i_generation = CURRENT_TIME;
+	
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
+		inode->i_generation &= ~1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,S_IRWXUGO &
 		    ~sbi->options.fs_umask) | S_IFDIR;
 		inode->i_op = sbi->dir_ops;
@@ -802,6 +921,7 @@
 			}
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	} else { /* not a directory */
+		inode->i_generation |= 1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,
 		    ((IS_NOEXEC(inode) || 
 		      (sbi->options.showexec &&

