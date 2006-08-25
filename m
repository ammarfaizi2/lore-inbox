Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWHYVUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWHYVUm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWHYVUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:20:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:186 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751004AbWHYVUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:20:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=sFrnvKfQRgXl7FQWtZXjEQjxPT7zCW4uhrLFGDA0dZNvS0Pf700FIJ53axGVnw91bPt3epUO0ebE7w+s21K01r8nNvHN2QGJokIIqmTQhHWoW7YfSKb+ywmZGu9JHlGhyvse1wIKOJDXqrBT+q+sJRVAe7BxCRlip/NkKHE7M18=
Date: Sat, 26 Aug 2006 01:20:26 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] Really ignore kmem_cache_destroy return value
Message-ID: <20060825212026.GA2246@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rougly half of callers already do it by not checking return value
* Code in drivers/acpi/osl.c does the following to be sure:

	(void)kmem_cache_destroy(cache);

* Those who check it printk something, however, slab_error already printed
  the name of failed cache.
* XFS BUGs on failed kmem_cache_destroy which is not the decision
  low-level filesystem driver should make. Converted to ignore.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/acpi/osl.c            |    2 +-
 drivers/infiniband/core/mad.c |    5 +----
 drivers/usb/host/uhci-hcd.c   |    8 ++------
 fs/adfs/super.c               |    3 +--
 fs/affs/super.c               |    3 +--
 fs/befs/linuxvfs.c            |    4 +---
 fs/bfs/inode.c                |    3 +--
 fs/cifs/cifsfs.c              |   20 +++++---------------
 fs/coda/inode.c               |    3 +--
 fs/efs/super.c                |    3 +--
 fs/ext2/super.c               |    3 +--
 fs/ext3/super.c               |    3 +--
 fs/fat/cache.c                |    3 +--
 fs/fat/inode.c                |    3 +--
 fs/hfs/super.c                |    3 +--
 fs/hfsplus/super.c            |    3 +--
 fs/hpfs/super.c               |    3 +--
 fs/isofs/inode.c              |    4 +---
 fs/minix/inode.c              |    3 +--
 fs/ncpfs/inode.c              |    3 +--
 fs/nfs/direct.c               |    3 +--
 fs/nfs/inode.c                |    3 +--
 fs/nfs/pagelist.c             |    3 +--
 fs/nfs/read.c                 |    3 +--
 fs/nfs/write.c                |    3 +--
 fs/nfsd/nfs4state.c           |    5 +----
 fs/ntfs/super.c               |   28 +++++-----------------------
 fs/ocfs2/dlm/dlmfs.c          |    4 +---
 fs/qnx4/inode.c               |    4 +---
 fs/reiserfs/super.c           |    4 +---
 fs/romfs/inode.c              |    3 +--
 fs/smbfs/inode.c              |    3 +--
 fs/smbfs/request.c            |    3 +--
 fs/udf/super.c                |    3 +--
 fs/ufs/super.c                |    3 +--
 fs/xfs/linux-2.6/kmem.h       |    4 ++--
 ipc/mqueue.c                  |    5 +----
 mm/shmem.c                    |    3 +--
 net/sunrpc/rpc_pipe.c         |    3 +--
 net/sunrpc/sched.c            |    8 ++++----
 40 files changed, 53 insertions(+), 130 deletions(-)

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1069,7 +1069,7 @@ acpi_status acpi_os_purge_cache(acpi_cac
 
 acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
 {
-	(void)kmem_cache_destroy(cache);
+	kmem_cache_destroy(cache);
 	return (AE_OK);
 }
 
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2984,10 +2984,7 @@ error1:
 static void __exit ib_mad_cleanup_module(void)
 {
 	ib_unregister_client(&mad_client);
-
-	if (kmem_cache_destroy(ib_mad_cache)) {
-		printk(KERN_DEBUG PFX "Failed to destroy ib_mad cache\n");
-	}
+	kmem_cache_destroy(ib_mad_cache);
 }
 
 module_init(ib_mad_init_module);
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -909,8 +909,7 @@ static int __init uhci_hcd_init(void)
 	return 0;
 
 init_failed:
-	if (kmem_cache_destroy(uhci_up_cachep))
-		warn("not all urb_privs were freed!");
+	kmem_cache_destroy(uhci_up_cachep);
 
 up_failed:
 	debugfs_remove(uhci_debugfs_root);
@@ -926,10 +925,7 @@ errbuf_failed:
 static void __exit uhci_hcd_cleanup(void) 
 {
 	pci_unregister_driver(&uhci_pci_driver);
-	
-	if (kmem_cache_destroy(uhci_up_cachep))
-		warn("not all urb_privs were freed!");
-
+	kmem_cache_destroy(uhci_up_cachep);
 	debugfs_remove(uhci_debugfs_root);
 	kfree(errbuf);
 }
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -251,8 +251,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(adfs_inode_cachep))
-		printk(KERN_INFO "adfs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(adfs_inode_cachep);
 }
 
 static struct super_operations adfs_sops = {
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -108,8 +108,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(affs_inode_cachep))
-		printk(KERN_INFO "affs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(affs_inode_cachep);
 }
 
 static struct super_operations affs_sops = {
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -446,9 +446,7 @@ befs_init_inodecache(void)
 static void
 befs_destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(befs_inode_cachep))
-		printk(KERN_ERR "befs_destroy_inodecache: "
-		       "not all structures were freed\n");
+	kmem_cache_destroy(befs_inode_cachep);
 }
 
 /*
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -268,8 +268,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(bfs_inode_cachep))
-		printk(KERN_INFO "bfs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(bfs_inode_cachep);
 }
 
 static struct super_operations bfs_sops = {
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -705,8 +705,7 @@ cifs_init_inodecache(void)
 static void
 cifs_destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(cifs_inode_cachep))
-		printk(KERN_WARNING "cifs_inode_cache: error freeing\n");
+	kmem_cache_destroy(cifs_inode_cachep);
 }
 
 static int
@@ -784,13 +783,9 @@ static void
 cifs_destroy_request_bufs(void)
 {
 	mempool_destroy(cifs_req_poolp);
-	if (kmem_cache_destroy(cifs_req_cachep))
-		printk(KERN_WARNING
-		       "cifs_destroy_request_cache: error not all structures were freed\n");
+	kmem_cache_destroy(cifs_req_cachep);
 	mempool_destroy(cifs_sm_req_poolp);
-	if (kmem_cache_destroy(cifs_sm_req_cachep))
-		printk(KERN_WARNING
-		      "cifs_destroy_request_cache: cifs_small_rq free error\n");
+	kmem_cache_destroy(cifs_sm_req_cachep);
 }
 
 static int
@@ -825,13 +820,8 @@ static void
 cifs_destroy_mids(void)
 {
 	mempool_destroy(cifs_mid_poolp);
-	if (kmem_cache_destroy(cifs_mid_cachep))
-		printk(KERN_WARNING
-		       "cifs_destroy_mids: error not all structures were freed\n");
-
-	if (kmem_cache_destroy(cifs_oplock_cachep))
-		printk(KERN_WARNING
-		       "error not all oplock structures were freed\n");
+	kmem_cache_destroy(cifs_mid_cachep);
+	kmem_cache_destroy(cifs_oplock_cachep);
 }
 
 static int cifs_oplock_thread(void * dummyarg)
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -80,8 +80,7 @@ int coda_init_inodecache(void)
 
 void coda_destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(coda_inode_cachep))
-		printk(KERN_INFO "coda_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(coda_inode_cachep);
 }
 
 static int coda_remount(struct super_block *sb, int *flags, char *data)
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -90,8 +90,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(efs_inode_cachep))
-		printk(KERN_INFO "efs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(efs_inode_cachep);
 }
 
 static void efs_put_super(struct super_block *s)
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -184,8 +184,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(ext2_inode_cachep))
-		printk(KERN_INFO "ext2_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(ext2_inode_cachep);
 }
 
 static void ext2_clear_inode(struct inode *inode)
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -490,8 +490,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(ext3_inode_cachep))
-		printk(KERN_INFO "ext3_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(ext3_inode_cachep);
 }
 
 static void ext3_clear_inode(struct inode *inode)
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -58,8 +58,7 @@ int __init fat_cache_init(void)
 
 void fat_cache_destroy(void)
 {
-	if (kmem_cache_destroy(fat_cache_cachep))
-		printk(KERN_INFO "fat_cache: not all structures were freed\n");
+	kmem_cache_destroy(fat_cache_cachep);
 }
 
 static inline struct fat_cache *fat_cache_alloc(struct inode *inode)
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -528,8 +528,7 @@ static int __init fat_init_inodecache(vo
 
 static void __exit fat_destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(fat_inode_cachep))
-		printk(KERN_INFO "fat_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(fat_inode_cachep);
 }
 
 static int fat_remount(struct super_block *sb, int *flags, char *data)
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -455,8 +455,7 @@ static int __init init_hfs_fs(void)
 static void __exit exit_hfs_fs(void)
 {
 	unregister_filesystem(&hfs_fs_type);
-	if (kmem_cache_destroy(hfs_inode_cachep))
-		printk(KERN_ERR "hfs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(hfs_inode_cachep);
 }
 
 module_init(init_hfs_fs)
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -493,8 +493,7 @@ static int __init init_hfsplus_fs(void)
 static void __exit exit_hfsplus_fs(void)
 {
 	unregister_filesystem(&hfsplus_fs_type);
-	if (kmem_cache_destroy(hfsplus_inode_cachep))
-		printk(KERN_ERR "hfsplus_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(hfsplus_inode_cachep);
 }
 
 module_init(init_hfsplus_fs)
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -202,8 +202,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(hpfs_inode_cachep))
-		printk(KERN_INFO "hpfs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(hpfs_inode_cachep);
 }
 
 /*
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -96,9 +96,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(isofs_inode_cachep))
-		printk(KERN_INFO "iso_inode_cache: not all structures were "
-					"freed\n");
+	kmem_cache_destroy(isofs_inode_cachep);
 }
 
 static int isofs_remount(struct super_block *sb, int *flags, char *data)
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -90,8 +90,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(minix_inode_cachep))
-		printk(KERN_INFO "minix_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(minix_inode_cachep);
 }
 
 static struct super_operations minix_sops = {
--- a/fs/ncpfs/inode.c
+++ b/fs/ncpfs/inode.c
@@ -81,8 +81,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(ncp_inode_cachep))
-		printk(KERN_INFO "ncp_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(ncp_inode_cachep);
 }
 
 static int ncp_remount(struct super_block *sb, int *flags, char* data)
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -877,6 +877,5 @@ int __init nfs_init_directcache(void)
  */
 void nfs_destroy_directcache(void)
 {
-	if (kmem_cache_destroy(nfs_direct_cachep))
-		printk(KERN_INFO "nfs_direct_cache: not all structures were freed\n");
+	kmem_cache_destroy(nfs_direct_cachep);
 }
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1133,8 +1133,7 @@ static int __init nfs_init_inodecache(vo
 
 static void nfs_destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(nfs_inode_cachep))
-		printk(KERN_INFO "nfs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(nfs_inode_cachep);
 }
 
 /*
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -392,7 +392,6 @@ int __init nfs_init_nfspagecache(void)
 
 void nfs_destroy_nfspagecache(void)
 {
-	if (kmem_cache_destroy(nfs_page_cachep))
-		printk(KERN_INFO "nfs_page: not all structures were freed\n");
+	kmem_cache_destroy(nfs_page_cachep);
 }
 
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -713,6 +713,5 @@ int __init nfs_init_readpagecache(void)
 void nfs_destroy_readpagecache(void)
 {
 	mempool_destroy(nfs_rdata_mempool);
-	if (kmem_cache_destroy(nfs_rdata_cachep))
-		printk(KERN_INFO "nfs_read_data: not all structures were freed\n");
+	kmem_cache_destroy(nfs_rdata_cachep);
 }
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1565,7 +1565,6 @@ void nfs_destroy_writepagecache(void)
 {
 	mempool_destroy(nfs_commit_mempool);
 	mempool_destroy(nfs_wdata_mempool);
-	if (kmem_cache_destroy(nfs_wdata_cachep))
-		printk(KERN_INFO "nfs_write_data: not all structures were freed\n");
+	kmem_cache_destroy(nfs_wdata_cachep);
 }
 
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1006,13 +1006,10 @@ alloc_init_file(struct inode *ino)
 static void
 nfsd4_free_slab(kmem_cache_t **slab)
 {
-	int status;
-
 	if (*slab == NULL)
 		return;
-	status = kmem_cache_destroy(*slab);
+	kmem_cache_destroy(*slab);
 	*slab = NULL;
-	WARN_ON(status);
 }
 
 static void
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -3248,32 +3248,14 @@ ictx_err_out:
 
 static void __exit exit_ntfs_fs(void)
 {
-	int err = 0;
-
 	ntfs_debug("Unregistering NTFS driver.");
 
 	unregister_filesystem(&ntfs_fs_type);
-
-	if (kmem_cache_destroy(ntfs_big_inode_cache) && (err = 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
-				ntfs_big_inode_cache_name);
-	if (kmem_cache_destroy(ntfs_inode_cache) && (err = 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
-				ntfs_inode_cache_name);
-	if (kmem_cache_destroy(ntfs_name_cache) && (err = 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
-				ntfs_name_cache_name);
-	if (kmem_cache_destroy(ntfs_attr_ctx_cache) && (err = 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
-				ntfs_attr_ctx_cache_name);
-	if (kmem_cache_destroy(ntfs_index_ctx_cache) && (err = 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
-				ntfs_index_ctx_cache_name);
-	if (err)
-		printk(KERN_CRIT "NTFS: This causes memory to leak! There is "
-				"probably a BUG in the driver! Please report "
-				"you saw this message to "
-				"linux-ntfs-dev@lists.sourceforge.net\n");
+	kmem_cache_destroy(ntfs_big_inode_cache);
+	kmem_cache_destroy(ntfs_inode_cache);
+	kmem_cache_destroy(ntfs_name_cache);
+	kmem_cache_destroy(ntfs_attr_ctx_cache);
+	kmem_cache_destroy(ntfs_index_ctx_cache);
 	/* Unregister the ntfs sysctls. */
 	ntfs_sysctl(0);
 }
--- a/fs/ocfs2/dlm/dlmfs.c
+++ b/fs/ocfs2/dlm/dlmfs.c
@@ -629,9 +629,7 @@ static void __exit exit_dlmfs_fs(void)
 	flush_workqueue(user_dlm_worker);
 	destroy_workqueue(user_dlm_worker);
 
-	if (kmem_cache_destroy(dlmfs_inode_cache))
-		printk(KERN_INFO "dlmfs_inode_cache: not all structures "
-		       "were freed\n");
+	kmem_cache_destroy(dlmfs_inode_cache);
 }
 
 MODULE_AUTHOR("Oracle");
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -557,9 +557,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(qnx4_inode_cachep))
-		printk(KERN_INFO
-		       "qnx4_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(qnx4_inode_cachep);
 }
 
 static int qnx4_get_sb(struct file_system_type *fs_type,
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -530,9 +530,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(reiserfs_inode_cachep))
-		reiserfs_warning(NULL,
-				 "reiserfs_inode_cache: not all structures were freed");
+	kmem_cache_destroy(reiserfs_inode_cachep);
 }
 
 /* we don't mark inodes dirty, we just log them */
--- a/fs/romfs/inode.c
+++ b/fs/romfs/inode.c
@@ -589,8 +589,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(romfs_inode_cachep))
-		printk(KERN_INFO "romfs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(romfs_inode_cachep);
 }
 
 static int romfs_remount(struct super_block *sb, int *flags, char *data)
--- a/fs/smbfs/inode.c
+++ b/fs/smbfs/inode.c
@@ -89,8 +89,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(smb_inode_cachep))
-		printk(KERN_INFO "smb_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(smb_inode_cachep);
 }
 
 static int smb_remount(struct super_block *sb, int *flags, char *data)
--- a/fs/smbfs/request.c
+++ b/fs/smbfs/request.c
@@ -49,8 +49,7 @@ int smb_init_request_cache(void)
 
 void smb_destroy_request_cache(void)
 {
-	if (kmem_cache_destroy(req_cachep))
-		printk(KERN_INFO "smb_destroy_request_cache: not all structures were freed\n");
+	kmem_cache_destroy(req_cachep);
 }
 
 /*
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -156,8 +156,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(udf_inode_cachep))
-		printk(KERN_INFO "udf_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(udf_inode_cachep);
 }
 
 /* Superblock operations */
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1245,8 +1245,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(ufs_inode_cachep))
-		printk(KERN_INFO "ufs_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(ufs_inode_cachep);
 }
 
 #ifdef CONFIG_QUOTA
--- a/fs/xfs/linux-2.6/kmem.h
+++ b/fs/xfs/linux-2.6/kmem.h
@@ -91,8 +91,8 @@ kmem_zone_free(kmem_zone_t *zone, void *
 static inline void
 kmem_zone_destroy(kmem_zone_t *zone)
 {
-	if (zone && kmem_cache_destroy(zone))
-		BUG();
+	if (zone)
+		kmem_cache_destroy(zone);
 }
 
 extern void *kmem_zone_alloc(kmem_zone_t *, unsigned int __nocast);
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1275,10 +1275,7 @@ out_filesystem:
 out_sysctl:
 	if (mq_sysctl_table)
 		unregister_sysctl_table(mq_sysctl_table);
-	if (kmem_cache_destroy(mqueue_inode_cachep)) {
-		printk(KERN_INFO
-			"mqueue_inode_cache: not all structures were freed\n");
-	}
+	kmem_cache_destroy(mqueue_inode_cachep);
 	return error;
 }
 
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2156,8 +2156,7 @@ static int init_inodecache(void)
 
 static void destroy_inodecache(void)
 {
-	if (kmem_cache_destroy(shmem_inode_cachep))
-		printk(KERN_INFO "shmem_inode_cache: not all structures were freed\n");
+	kmem_cache_destroy(shmem_inode_cachep);
 }
 
 static const struct address_space_operations shmem_aops = {
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -865,7 +865,6 @@ int register_rpc_pipefs(void)
 
 void unregister_rpc_pipefs(void)
 {
-	if (kmem_cache_destroy(rpc_inode_cachep))
-		printk(KERN_WARNING "RPC: unable to free inode cache\n");
+	kmem_cache_destroy(rpc_inode_cachep);
 	unregister_filesystem(&rpc_pipe_fs_type);
 }
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1146,10 +1146,10 @@ rpc_destroy_mempool(void)
 		mempool_destroy(rpc_buffer_mempool);
 	if (rpc_task_mempool)
 		mempool_destroy(rpc_task_mempool);
-	if (rpc_task_slabp && kmem_cache_destroy(rpc_task_slabp))
-		printk(KERN_INFO "rpc_task: not all structures were freed\n");
-	if (rpc_buffer_slabp && kmem_cache_destroy(rpc_buffer_slabp))
-		printk(KERN_INFO "rpc_buffers: not all structures were freed\n");
+	if (rpc_task_slabp)
+		kmem_cache_destroy(rpc_task_slabp);
+	if (rpc_buffer_slabp)
+		kmem_cache_destroy(rpc_buffer_slabp);
 }
 
 int

