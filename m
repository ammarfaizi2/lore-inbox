Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267249AbUHOXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267249AbUHOXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbUHOXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:38:27 -0400
Received: from ozlabs.org ([203.10.76.45]:33224 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267249AbUHOXhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:37:43 -0400
Date: Mon, 16 Aug 2004 09:37:32 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jrsantos@austin.ibm.com
Subject: [PATCH] remove cacheline alignment from inode slabs
Message-ID: <20040815233732.GL5637@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most of the inode slabs are cacheline aligned. This can waste a fair
amount of memory, especially on architectures with large cacheline sizes
(eg 128 bytes). 

Alignment has a few advantages. It prevents 2 cpus from accessing 2 data
structures in the same cacheline. Since struct inodes are well over a
cacheline and there are so many of them, there is little chance we will
hit this problem if we remove the alignment. 

Alignment also ensures the maximum amount of the data structure is in
the same cacheline (instead of straddling 2 for example). The large size
of struct inode reduces this advantage.

With this patch the inode_cache slab goes from 640 bytes to 544 bytes,
and the number that fits in a 4kB slab goes from 6 to 7 on ppc64. A
number of other inode slabs also see improvements.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN fs/ext2/super.c~no_align_in_inode_slabs fs/ext2/super.c
--- gr_work/fs/ext2/super.c~no_align_in_inode_slabs	2004-08-15 17:29:04.444915268 -0500
+++ gr_work-anton/fs/ext2/super.c	2004-08-15 17:29:45.146590932 -0500
@@ -189,7 +189,7 @@ static int init_inodecache(void)
 {
 	ext2_inode_cachep = kmem_cache_create("ext2_inode_cache",
 					     sizeof(struct ext2_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (ext2_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/ext3/super.c~no_align_in_inode_slabs fs/ext3/super.c
--- gr_work/fs/ext3/super.c~no_align_in_inode_slabs	2004-08-15 17:29:08.820887901 -0500
+++ gr_work-anton/fs/ext3/super.c	2004-08-15 17:29:51.395533379 -0500
@@ -480,7 +480,7 @@ static int init_inodecache(void)
 {
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
 					     sizeof(struct ext3_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (ext3_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/jfs/super.c~no_align_in_inode_slabs fs/jfs/super.c
diff -puN fs/proc/inode.c~no_align_in_inode_slabs fs/proc/inode.c
--- gr_work/fs/proc/inode.c~no_align_in_inode_slabs	2004-08-15 17:32:09.345711620 -0500
+++ gr_work-anton/fs/proc/inode.c	2004-08-15 17:32:20.155595160 -0500
@@ -120,7 +120,7 @@ int __init proc_init_inodecache(void)
 {
 	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
 					     sizeof(struct proc_inode),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (proc_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/reiserfs/super.c~no_align_in_inode_slabs fs/reiserfs/super.c
--- gr_work/fs/reiserfs/super.c~no_align_in_inode_slabs	2004-08-15 17:33:11.289339191 -0500
+++ gr_work-anton/fs/reiserfs/super.c	2004-08-15 17:33:16.626292176 -0500
@@ -444,7 +444,7 @@ static int init_inodecache(void)
 {
 	reiserfs_inode_cachep = kmem_cache_create("reiser_inode_cache",
 					     sizeof(struct reiserfs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (reiserfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/inode.c~no_align_in_inode_slabs fs/inode.c
--- gr_work/fs/inode.c~no_align_in_inode_slabs	2004-08-15 17:37:11.802678868 -0500
+++ gr_work-anton/fs/inode.c	2004-08-15 17:37:15.528754508 -0500
@@ -1372,8 +1372,7 @@ void __init inode_init(unsigned long mem
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
-				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, init_once,
-				NULL);
+				0, SLAB_PANIC, init_once, NULL);
 	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 }
 
diff -puN fs/xfs/linux-2.6/xfs_super.c~no_align_in_inode_slabs fs/xfs/linux-2.6/xfs_super.c
--- gr_work/fs/xfs/linux-2.6/xfs_super.c~no_align_in_inode_slabs	2004-08-15 17:39:10.339989081 -0500
+++ gr_work-anton/fs/xfs/linux-2.6/xfs_super.c	2004-08-15 17:39:20.670814302 -0500
@@ -334,8 +334,7 @@ STATIC int
 init_inodecache( void )
 {
 	linvfs_inode_zone = kmem_cache_create("linvfs_icache",
-				sizeof(vnode_t), 0,
-				SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				sizeof(vnode_t), 0, SLAB_RECLAIM_ACCOUNT,
 				init_once, NULL);
 
 	if (linvfs_inode_zone == NULL)
diff -puN fs/cifs/cifsfs.c~no_align_in_inode_slabs fs/cifs/cifsfs.c
--- gr_work/fs/cifs/cifsfs.c~no_align_in_inode_slabs	2004-08-15 17:40:47.709325435 -0500
+++ gr_work-anton/fs/cifs/cifsfs.c	2004-08-15 17:40:56.075197622 -0500
@@ -561,7 +561,7 @@ cifs_init_inodecache(void)
 {
 	cifs_inode_cachep = kmem_cache_create("cifs_inode_cache",
 					      sizeof (struct cifsInodeInfo),
-					      0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					      0, SLAB_RECLAIM_ACCOUNT,
 					      cifs_init_once, NULL);
 	if (cifs_inode_cachep == NULL)
 		return -ENOMEM;
diff -L fg -puN /dev/null /dev/null
diff -puN fs/adfs/super.c~no_align_in_inode_slabs fs/adfs/super.c
--- gr_work/fs/adfs/super.c~no_align_in_inode_slabs	2004-08-15 17:42:35.804560669 -0500
+++ gr_work-anton/fs/adfs/super.c	2004-08-15 17:42:41.068526399 -0500
@@ -241,7 +241,7 @@ static int init_inodecache(void)
 {
 	adfs_inode_cachep = kmem_cache_create("adfs_inode_cache",
 					     sizeof(struct adfs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (adfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/affs/super.c~no_align_in_inode_slabs fs/affs/super.c
--- gr_work/fs/affs/super.c~no_align_in_inode_slabs	2004-08-15 17:42:50.062429263 -0500
+++ gr_work-anton/fs/affs/super.c	2004-08-15 17:42:53.635528176 -0500
@@ -115,7 +115,7 @@ static int init_inodecache(void)
 {
 	affs_inode_cachep = kmem_cache_create("affs_inode_cache",
 					     sizeof(struct affs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (affs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/befs/linuxvfs.c~no_align_in_inode_slabs fs/befs/linuxvfs.c
--- gr_work/fs/befs/linuxvfs.c~no_align_in_inode_slabs	2004-08-15 17:43:04.483405694 -0500
+++ gr_work-anton/fs/befs/linuxvfs.c	2004-08-15 17:43:14.928347851 -0500
@@ -433,7 +433,7 @@ befs_init_inodecache(void)
 {
 	befs_inode_cachep = kmem_cache_create("befs_inode_cache",
 					      sizeof (struct befs_inode_info),
-					      0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					      0, SLAB_RECLAIM_ACCOUNT,
 					      init_once, NULL);
 	if (befs_inode_cachep == NULL) {
 		printk(KERN_ERR "befs_init_inodecache: "
diff -puN fs/bfs/inode.c~no_align_in_inode_slabs fs/bfs/inode.c
--- gr_work/fs/bfs/inode.c~no_align_in_inode_slabs	2004-08-15 17:43:27.315249172 -0500
+++ gr_work-anton/fs/bfs/inode.c	2004-08-15 17:43:31.450257737 -0500
@@ -245,7 +245,7 @@ static int init_inodecache(void)
 {
 	bfs_inode_cachep = kmem_cache_create("bfs_inode_cache",
 					     sizeof(struct bfs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (bfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/coda/inode.c~no_align_in_inode_slabs fs/coda/inode.c
--- gr_work/fs/coda/inode.c~no_align_in_inode_slabs	2004-08-15 17:44:02.507992099 -0500
+++ gr_work-anton/fs/coda/inode.c	2004-08-15 17:44:05.989974591 -0500
@@ -69,7 +69,7 @@ int coda_init_inodecache(void)
 {
 	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
 				sizeof(struct coda_inode_info),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_RECLAIM_ACCOUNT,
 				init_once, NULL);
 	if (coda_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/efs/super.c~no_align_in_inode_slabs fs/efs/super.c
--- gr_work/fs/efs/super.c~no_align_in_inode_slabs	2004-08-15 17:44:16.845984858 -0500
+++ gr_work-anton/fs/efs/super.c	2004-08-15 17:45:06.320591414 -0500
@@ -58,7 +58,7 @@ static int init_inodecache(void)
 {
 	efs_inode_cachep = kmem_cache_create("efs_inode_cache",
 				sizeof(struct efs_inode_info),
-				0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+				0, SLAB_RECLAIM_ACCOUNT,
 				init_once, NULL);
 	if (efs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/fat/inode.c~no_align_in_inode_slabs fs/fat/inode.c
--- gr_work/fs/fat/inode.c~no_align_in_inode_slabs	2004-08-15 17:45:22.127483907 -0500
+++ gr_work-anton/fs/fat/inode.c	2004-08-15 17:45:26.282489613 -0500
@@ -744,7 +744,7 @@ int __init fat_init_inodecache(void)
 {
 	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
 					     sizeof(struct msdos_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (fat_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/hpfs/super.c~no_align_in_inode_slabs fs/hpfs/super.c
--- gr_work/fs/hpfs/super.c~no_align_in_inode_slabs	2004-08-15 17:45:35.806445229 -0500
+++ gr_work-anton/fs/hpfs/super.c	2004-08-15 17:45:39.440400440 -0500
@@ -191,7 +191,7 @@ static int init_inodecache(void)
 {
 	hpfs_inode_cachep = kmem_cache_create("hpfs_inode_cache",
 					     sizeof(struct hpfs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (hpfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/isofs/inode.c~no_align_in_inode_slabs fs/isofs/inode.c
--- gr_work/fs/isofs/inode.c~no_align_in_inode_slabs	2004-08-15 17:45:49.530263076 -0500
+++ gr_work-anton/fs/isofs/inode.c	2004-08-15 17:45:52.737288208 -0500
@@ -108,7 +108,7 @@ static int init_inodecache(void)
 {
 	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
 					     sizeof(struct iso_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (isofs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/jffs/inode-v23.c~no_align_in_inode_slabs fs/jffs/inode-v23.c
diff -puN fs/jffs2/super.c~no_align_in_inode_slabs fs/jffs2/super.c
--- gr_work/fs/jffs2/super.c~no_align_in_inode_slabs	2004-08-15 17:47:13.834812179 -0500
+++ gr_work-anton/fs/jffs2/super.c	2004-08-15 17:47:19.357734492 -0500
@@ -302,7 +302,7 @@ static int __init init_jffs2_fs(void)
 
 	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
 					     sizeof(struct jffs2_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     jffs2_i_init_once, NULL);
 	if (!jffs2_inode_cachep) {
 		printk(KERN_ERR "JFFS2 error: Failed to initialise inode cache\n");
diff -puN fs/minix/inode.c~no_align_in_inode_slabs fs/minix/inode.c
--- gr_work/fs/minix/inode.c~no_align_in_inode_slabs	2004-08-15 17:47:32.855589364 -0500
+++ gr_work-anton/fs/minix/inode.c	2004-08-15 17:47:35.765662625 -0500
@@ -79,7 +79,7 @@ static int init_inodecache(void)
 {
 	minix_inode_cachep = kmem_cache_create("minix_inode_cache",
 					     sizeof(struct minix_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (minix_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/ncpfs/inode.c~no_align_in_inode_slabs fs/ncpfs/inode.c
--- gr_work/fs/ncpfs/inode.c~no_align_in_inode_slabs	2004-08-15 17:47:42.290560260 -0500
+++ gr_work-anton/fs/ncpfs/inode.c	2004-08-15 17:47:46.321584484 -0500
@@ -72,7 +72,7 @@ static int init_inodecache(void)
 {
 	ncp_inode_cachep = kmem_cache_create("ncp_inode_cache",
 					     sizeof(struct ncp_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (ncp_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/nfs/inode.c~no_align_in_inode_slabs fs/nfs/inode.c
--- gr_work/fs/nfs/inode.c~no_align_in_inode_slabs	2004-08-15 17:47:53.536505318 -0500
+++ gr_work-anton/fs/nfs/inode.c	2004-08-15 17:47:57.704509960 -0500
@@ -1779,7 +1779,7 @@ int nfs_init_inodecache(void)
 {
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
 					     sizeof(struct nfs_inode),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (nfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/ntfs/super.c~no_align_in_inode_slabs fs/ntfs/super.c
--- gr_work/fs/ntfs/super.c~no_align_in_inode_slabs	2004-08-15 17:48:18.232316183 -0500
+++ gr_work-anton/fs/ntfs/super.c	2004-08-15 17:48:21.724295928 -0500
@@ -2528,7 +2528,7 @@ static int __init init_ntfs_fs(void)
 
 	ntfs_inode_cache = kmem_cache_create(ntfs_inode_cache_name,
 			sizeof(ntfs_inode), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT, NULL, NULL);
+			SLAB_RECLAIM_ACCOUNT, NULL, NULL);
 	if (!ntfs_inode_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
 				ntfs_inode_cache_name);
diff -puN fs/qnx4/inode.c~no_align_in_inode_slabs fs/qnx4/inode.c
--- gr_work/fs/qnx4/inode.c~no_align_in_inode_slabs	2004-08-15 17:48:40.502246527 -0500
+++ gr_work-anton/fs/qnx4/inode.c	2004-08-15 17:48:43.772126650 -0500
@@ -544,7 +544,7 @@ static int init_inodecache(void)
 {
 	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
 					     sizeof(struct qnx4_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (qnx4_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/romfs/inode.c~no_align_in_inode_slabs fs/romfs/inode.c
--- gr_work/fs/romfs/inode.c~no_align_in_inode_slabs	2004-08-15 17:48:54.099087007 -0500
+++ gr_work-anton/fs/romfs/inode.c	2004-08-15 17:48:57.929012276 -0500
@@ -579,7 +579,7 @@ static int init_inodecache(void)
 {
 	romfs_inode_cachep = kmem_cache_create("romfs_inode_cache",
 					     sizeof(struct romfs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (romfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/smbfs/inode.c~no_align_in_inode_slabs fs/smbfs/inode.c
--- gr_work/fs/smbfs/inode.c~no_align_in_inode_slabs	2004-08-15 17:49:06.812068449 -0500
+++ gr_work-anton/fs/smbfs/inode.c	2004-08-15 17:49:10.245058715 -0500
@@ -80,7 +80,7 @@ static int init_inodecache(void)
 {
 	smb_inode_cachep = kmem_cache_create("smb_inode_cache",
 					     sizeof(struct smb_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (smb_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/sysv/inode.c~no_align_in_inode_slabs fs/sysv/inode.c
--- gr_work/fs/sysv/inode.c~no_align_in_inode_slabs	2004-08-15 17:49:21.300901232 -0500
+++ gr_work-anton/fs/sysv/inode.c	2004-08-15 17:49:24.646903305 -0500
@@ -340,7 +340,7 @@ int __init sysv_init_icache(void)
 {
 	sysv_inode_cachep = kmem_cache_create("sysv_inode_cache",
 			sizeof(struct sysv_inode_info), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT, 
+			SLAB_RECLAIM_ACCOUNT, 
 			init_once, NULL);
 	if (!sysv_inode_cachep)
 		return -ENOMEM;
diff -puN fs/udf/super.c~no_align_in_inode_slabs fs/udf/super.c
--- gr_work/fs/udf/super.c~no_align_in_inode_slabs	2004-08-15 17:49:32.328884201 -0500
+++ gr_work-anton/fs/udf/super.c	2004-08-15 17:49:35.754872418 -0500
@@ -145,7 +145,7 @@ static int init_inodecache(void)
 {
 	udf_inode_cachep = kmem_cache_create("udf_inode_cache",
 					     sizeof(struct udf_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (udf_inode_cachep == NULL)
 		return -ENOMEM;
diff -puN fs/ufs/super.c~no_align_in_inode_slabs fs/ufs/super.c
--- gr_work/fs/ufs/super.c~no_align_in_inode_slabs	2004-08-15 17:49:44.912753104 -0500
+++ gr_work-anton/fs/ufs/super.c	2004-08-15 17:49:53.160775191 -0500
@@ -1183,7 +1183,7 @@ static int init_inodecache(void)
 {
 	ufs_inode_cachep = kmem_cache_create("ufs_inode_cache",
 					     sizeof(struct ufs_inode_info),
-					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
+					     0, SLAB_RECLAIM_ACCOUNT,
 					     init_once, NULL);
 	if (ufs_inode_cachep == NULL)
 		return -ENOMEM;
_

