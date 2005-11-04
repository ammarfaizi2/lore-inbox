Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVKDR2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVKDR2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVKDR2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:28:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:18565 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750743AbVKDR2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:28:05 -0500
Date: Fri, 4 Nov 2005 17:28:08 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: Re: [PATCH: eCryptfs] Remove debug wrappers
Message-ID: <20051104232807.GB3568@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20051103033220.GD2772@sshock.rn.byu.edu> <20051103034929.GD3005@sshock.rn.byu.edu> <20051103060236.GB5044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103060236.GB5044@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 10:02:36PM -0800, Greg KH wrote:
> On Wed, Nov 02, 2005 at 08:49:29PM -0700, Phillip Hellewell wrote:
> > +void __ecryptfs_kfree(void *ptr, const char *fun, int line)
> > +{
> > +	if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
> > +		ecryptfs_printk_release(ptr, fun, line);
> > +	kfree(ptr);
> > +}
> > +
> > +void *__ecryptfs_kmalloc(size_t size, unsigned int flags, const char *fun,
> > +			 int line)
> 
> <snip>
> 
> Don't have wrappers for all of the common kernel functions, just call
> them directly.

This patch removes the wrappers from the common kernel functions. For
those who may find them useful, I have posted the reverse patch on the
project site (file release labeled ``debug-wrappers''):

http://sourceforge.net/projects/ecryptfs

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

 crypto.c          |   16 +--
 dentry.c          |    6 -
 ecryptfs_kernel.h |  103 ---------------------
 file.c            |   16 +--
 inode.c           |  129 ++++++++++++--------------
 keystore.c        |   14 +-
 main.c            |  263 ++----------------------------------------------------
 mmap.c            |    5 -
 super.c           |   11 +-
 9 files changed, 104 insertions(+), 459 deletions(-)
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/keystore.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/keystore.c	2005-11-01 15:51:59.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/keystore.c	2005-11-03 18:47:18.000000000 -0600
@@ -147,8 +147,8 @@
 		    list_entry(walker, struct ecryptfs_auth_tok_list_item,
 			       list);
 		walker = auth_tok_list_item->list.next;
-		ecryptfs_kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
-					 auth_tok_list_item);
+		kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
+				auth_tok_list_item);
 	}
 	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
 }
@@ -233,8 +233,8 @@
 	/* Released: wipe_auth_tok_list called in ecryptfs_parse_packet_set or
 	 * at end of function upon failure */
 	auth_tok_list_item =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_auth_tok_list_item_cache,
-				      SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_auth_tok_list_item_cache,
+			     SLAB_KERNEL);
 	if (!auth_tok_list_item) {
 		ecryptfs_printk(0, KERN_ERR, "Unable to allocate memory\n");
 		rc = -ENOMEM;
@@ -372,8 +372,8 @@
 	crypt_stats->encrypted = 1;
 	goto out_success;
 out:
-	ecryptfs_kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
-				 auth_tok_list_item);
+	kmem_cache_free(ecryptfs_auth_tok_list_item_cache,
+			auth_tok_list_item);
 out_no_mem:
 out_success:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
@@ -424,7 +424,7 @@
 	}
 	session_key = (char *)__get_free_page(GFP_KERNEL);
 	if (!session_key) {
-		ecryptfs_kfree(encrypted_session_key);
+		kfree(encrypted_session_key);
 		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
 		rc = -ENOMEM;
 		goto out;
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/mmap.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/mmap.c	2005-11-01 14:40:17.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/mmap.c	2005-11-03 16:12:46.000000000 -0600
@@ -518,7 +518,7 @@
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; lower_page_index = [%d]\n",
 			lower_page_index);
 	lower_page_encrypted_virt =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_lower_page_cache, SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_lower_page_cache, SLAB_KERNEL);
 	if (!lower_page_encrypted_virt) {
 		rc = -ENOMEM;
 		ecryptfs_printk(0, KERN_ERR, "Error getting page for "
@@ -551,8 +551,7 @@
 	}
 	ecryptfs_printk(1, KERN_NOTICE, "First 8 bytes after decryption:\n");
 	ecryptfs_dump_hex((char *)page_address(page), 8);
-	ecryptfs_kmem_cache_free(ecryptfs_lower_page_cache,
-				 lower_page_encrypted_virt);
+	kmem_cache_free(ecryptfs_lower_page_cache, lower_page_encrypted_virt);
 out:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
 	return rc;
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/dentry.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/dentry.c	2005-11-01 14:40:09.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/dentry.c	2005-11-03 15:37:46.000000000 -0600
@@ -94,11 +94,11 @@
 	 * freeing regardless */
 	/* OLD: if (lower_dentry && lower_dentry->d_inode) { */
 	if (DENTRY_TO_PRIVATE(dentry)) {
-		ecryptfs_kmem_cache_free(ecryptfs_dentry_info_cache,
-					 DENTRY_TO_PRIVATE(dentry));
+		kmem_cache_free(ecryptfs_dentry_info_cache,
+				DENTRY_TO_PRIVATE(dentry));
 	}
 	if (lower_dentry)
-		ecryptfs_dput(lower_dentry);
+		dput(lower_dentry);
 out:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
 	return;
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/inode.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/inode.c	2005-11-01 16:42:33.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/inode.c	2005-11-03 18:46:08.000000000 -0600
@@ -38,7 +38,7 @@
 static inline struct dentry *lock_parent(struct dentry *dentry)
 {
 	struct dentry *dir;
-	dir = ecryptfs_dget(dentry->d_parent);
+	dir = dget(dentry->d_parent);
 	down(&dir->d_inode->i_sem);
 	return dir;
 }
@@ -46,7 +46,7 @@
 static inline void unlock_dir(struct dentry *dir)
 {
 	up(&dir->d_inode->i_sem);
-	ecryptfs_dput(dir);
+	dput(dir);
 }
 
 static void ecryptfs_copy_inode_size(struct inode *dst, const struct inode *src)
@@ -218,16 +218,14 @@
 	memset(&fake_file, 0, sizeof(fake_file));
 	fake_file.f_dentry = ecryptfs_dentry;
 	FILE_TO_PRIVATE_SM(&fake_file) =
-		ecryptfs_kmem_cache_alloc(ecryptfs_file_info_cache,
-					  SLAB_KERNEL);
+		kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
 	if (!(FILE_TO_PRIVATE_SM(&fake_file))) {
 		rc = -ENOMEM;
 		goto out;
 	}
 	FILE_TO_LOWER(&fake_file) = lower_file;
 	ecryptfs_fill_zeros(&fake_file, 1);
-	ecryptfs_kmem_cache_free(ecryptfs_file_info_cache,
-				 FILE_TO_PRIVATE(&fake_file));
+	kmem_cache_free(ecryptfs_file_info_cache, FILE_TO_PRIVATE(&fake_file));
 	i_size_write(inode, 0);
 	ecryptfs_write_inode_size_to_header(lower_file, lower_inode, inode);
 	INODE_TO_PRIVATE(inode)->crypt_stats.new_file = 1;
@@ -284,7 +282,7 @@
 	if (!crypt_stats->struct_initialized) {
 		BUG();
 	}
-	tlower_dentry = ecryptfs_dget(lower_dentry);
+	tlower_dentry = dget(lower_dentry);
 	if (!tlower_dentry) {
 		rc = -ENOMEM;
 		ecryptfs_printk(0, KERN_ERR, "Error dget'ing lower_dentry\n");
@@ -297,8 +295,7 @@
 	lower_mnt = SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt;
 	mntget(lower_mnt);
 	/* Corresponding fput() at end of func */
-	lower_file = ecryptfs_dentry_open(tlower_dentry, lower_mnt,
-					  lower_flags);
+	lower_file = dentry_open(tlower_dentry, lower_mnt, lower_flags);
 	if (IS_ERR(lower_file)) {
 		rc = PTR_ERR(lower_file);
 		ecryptfs_printk(0, KERN_ERR,
@@ -420,7 +417,7 @@
 			"= [%d]\n", encoded_name, encoded_namelen);
 	lower_dentry = lookup_one_len(encoded_name, lower_dir_dentry,
 				      encoded_namelen - 1);
-	ecryptfs_kfree(encoded_name);
+	kfree(encoded_name);
 	ecryptfs_printk(1, KERN_NOTICE, "lower_dentry = [%p]; lower_dentry->"
 			"d_name.name = [%s]\n", lower_dentry,
 			lower_dentry->d_name.name);
@@ -437,7 +434,7 @@
 
 	/* Private allocation */
 	DENTRY_TO_PRIVATE_SM(dentry) =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
 	if (!DENTRY_TO_PRIVATE_SM(dentry)) {
 		err = -ENOMEM;
 		ecryptfs_printk(0, KERN_ERR, "Out of memory whilst attempting "
@@ -448,7 +445,7 @@
 	DENTRY_TO_LOWER(dentry) = lower_dentry;
 	if (!lower_dentry->d_inode) {
 		/* We want to add because we couldn't find in lower */
-		ecryptfs_d_add(dentry, NULL);
+		d_add(dentry, NULL);
 		goto out;
 	}
 	err = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 1);
@@ -470,7 +467,7 @@
 				"as we *think* we are about to unlink\n");
 		goto out;
 	}
-	tlower_dentry = ecryptfs_dget(lower_dentry);
+	tlower_dentry = dget(lower_dentry);
 	if (!tlower_dentry || IS_ERR(tlower_dentry)) {
 		err = -ENOMEM;
 		ecryptfs_printk(0, KERN_ERR, "Cannot dget lower_dentry\n");
@@ -478,8 +475,8 @@
 	}
 	/* Released in this function */
 	page_virt =
-	    (char *)ecryptfs_kmem_cache_alloc(ecryptfs_header_cache_2,
-					      SLAB_USER);
+	    (char *)kmem_cache_alloc(ecryptfs_header_cache_2,
+				     SLAB_USER);
 	if (!page_virt) {
 		err = -ENOMEM;
 		ecryptfs_printk(0, KERN_ERR,
@@ -509,16 +506,15 @@
 					"copying file size\n");
 		}
 	}
-	ecryptfs_kmem_cache_free(ecryptfs_header_cache_2, page_virt);
+	kmem_cache_free(ecryptfs_header_cache_2, page_virt);
 	goto out;
 
 out_dput:
-	ecryptfs_dput(lower_dentry);
-	if (tlower_dentry) {
-		ecryptfs_dput(tlower_dentry);
-	}
+	dput(lower_dentry);
+	if (tlower_dentry)
+		dput(tlower_dentry);
 out_drop:
-	ecryptfs_d_drop(dentry);
+	d_drop(dentry);
 out:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
 	return ERR_PTR(err);
@@ -534,8 +530,8 @@
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	lower_old_dentry = ecryptfs_lower_dentry(old_dentry);
 	lower_new_dentry = ecryptfs_lower_dentry(new_dentry);
-	ecryptfs_dget(lower_old_dentry);
-	ecryptfs_dget(lower_new_dentry);
+	dget(lower_old_dentry);
+	dget(lower_new_dentry);
 	lower_dir_dentry = lock_parent(lower_new_dentry);
 	err = vfs_link(lower_old_dentry, lower_dir_dentry->d_inode,
 		       lower_new_dentry);
@@ -549,10 +545,10 @@
 	    INODE_TO_LOWER(old_dentry->d_inode)->i_nlink;
 out_lock:
 	unlock_dir(lower_dir_dentry);
-	ecryptfs_dput(lower_new_dentry);
-	ecryptfs_dput(lower_old_dentry);
+	dput(lower_new_dentry);
+	dput(lower_old_dentry);
 	if (!new_dentry->d_inode)
-		ecryptfs_d_drop(new_dentry);
+		d_drop(new_dentry);
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
 	return err;
 }
@@ -571,7 +567,7 @@
 	lower_dentry = ecryptfs_lower_dentry(dentry);
 	ecryptfs_printk(1, KERN_NOTICE, "dentry = [%p]\n", dentry);
 	ecryptfs_printk(1, KERN_NOTICE, "lower_dentry = [%p]\n", lower_dentry);
-	if (!(tdentry = ecryptfs_dget(dentry))) {
+	if (!(tdentry = dget(dentry))) {
 		err = -EINVAL;
 		ecryptfs_printk(0, KERN_ERR, "Error dget'ing dentry [%p]\n",
 				dentry);
@@ -580,7 +576,7 @@
 	lower_dir_dentry = lock_parent(lower_dentry);
 	ecryptfs_printk(1, KERN_NOTICE, "lower_dir_dentry = [%p]\n",
 			lower_dir_dentry);
-	if (!(tlower_dentry = ecryptfs_dget(lower_dentry))) {
+	if (!(tlower_dentry = dget(lower_dentry))) {
 		err = -EINVAL;
 		ecryptfs_printk(0, KERN_ERR, "Error dget'ing lower_dentry "
 				"[%p]\n", lower_dentry);
@@ -590,7 +586,7 @@
 	err = vfs_unlink(lower_dir, lower_dentry);
 	spin_unlock(&dcache_lock);
 	if (!err) {
-		ecryptfs_dentry_delete(tlower_dentry);
+		d_delete(tlower_dentry);
 		tlower_dentry = NULL;
 	}
 	ecryptfs_copy_attr_times(dir, lower_dir);
@@ -598,16 +594,16 @@
 	ecryptfs_copy_attr_ctime(dentry->d_inode, dir);
 	unlock_dir(lower_dir_dentry);
 	if (!err || err == -ENOENT) {
-		ecryptfs_d_drop(tdentry);
+		d_drop(tdentry);
 		tdentry = NULL;
 	}
 out:
 	if (tdentry)
-		ecryptfs_dput(tdentry);
+		dput(tdentry);
 	if (tlower_dentry)
-		ecryptfs_dput(tlower_dentry);
+		dput(tlower_dentry);
 	if (tlower_dir_dentry)
-		ecryptfs_dput(tlower_dir_dentry);
+		dput(tlower_dir_dentry);
 	return err;
 }
 
@@ -623,7 +619,7 @@
 	struct ecryptfs_crypt_stats *crypt_stats = NULL;
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	lower_dentry = ecryptfs_lower_dentry(dentry);
-	ecryptfs_dget(lower_dentry);
+	dget(lower_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
 	mode = S_IALLUGO;
 	encoded_symlen = ecryptfs_encode_filename(symname, strlen(symname),
@@ -636,7 +632,7 @@
 	}
 	err = vfs_symlink(lower_dir_dentry->d_inode, lower_dentry,
 			  encoded_symname, mode);
-	ecryptfs_kfree(encoded_symname);
+	kfree(encoded_symname);
 	if (err || !lower_dentry->d_inode)
 		goto out_lock;
 	err = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb, 0);
@@ -645,9 +641,9 @@
 	ecryptfs_copy_attr_timesizes(dir, lower_dir_dentry->d_inode);
 out_lock:
 	unlock_dir(lower_dir_dentry);
-	ecryptfs_dput(lower_dentry);
+	dput(lower_dentry);
 	if (!dentry->d_inode)
-		ecryptfs_d_drop(dentry);
+		d_drop(dentry);
 	return err;
 }
 
@@ -670,7 +666,7 @@
 out:
 	unlock_dir(lower_dir_dentry);
 	if (!dentry->d_inode)
-		ecryptfs_d_drop(dentry);
+		d_drop(dentry);
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
 	return err;
 }
@@ -685,14 +681,14 @@
 	struct dentry *tlower_dir_dentry = NULL;
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	lower_dentry = ecryptfs_lower_dentry(dentry);
-	if (!(tdentry = ecryptfs_dget(dentry))) {
+	if (!(tdentry = dget(dentry))) {
 		err = -EINVAL;
 		ecryptfs_printk(0, KERN_ERR, "Error dget'ing dentry [%p]\n",
 				dentry);
 		goto out;
 	}
 	lower_dir_dentry = lock_parent(lower_dentry);
-	if (!(tlower_dentry = ecryptfs_dget(lower_dentry))) {
+	if (!(tlower_dentry = dget(lower_dentry))) {
 		err = -EINVAL;
 		ecryptfs_printk(0, KERN_ERR, "Error dget'ing lower_dentry "
 				"[%p]\n", lower_dentry);
@@ -700,21 +696,21 @@
 	}
 	err = vfs_rmdir(lower_dir_dentry->d_inode, lower_dentry);
 	if (!err) {
-		ecryptfs_dentry_delete(tlower_dentry);
+		d_delete(tlower_dentry);
 		tlower_dentry = NULL;
 	}
 	ecryptfs_copy_attr_times(dir, lower_dir_dentry->d_inode);
 	dir->i_nlink = lower_dir_dentry->d_inode->i_nlink;
 	unlock_dir(lower_dir_dentry);
 	if (!err)
-		ecryptfs_d_drop(dentry);
+		d_drop(dentry);
 out:
 	if (tdentry)
-		ecryptfs_dput(tdentry);
+		dput(tdentry);
 	if (tlower_dentry)
-		ecryptfs_dput(tlower_dentry);
+		dput(tlower_dentry);
 	if (tlower_dir_dentry)
-		ecryptfs_dput(tlower_dir_dentry);
+		dput(tlower_dir_dentry);
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
 	return err;
 }
@@ -754,8 +750,8 @@
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	lower_old_dentry = ecryptfs_lower_dentry(old_dentry);
 	lower_new_dentry = ecryptfs_lower_dentry(new_dentry);
-	ecryptfs_dget(lower_old_dentry);
-	ecryptfs_dget(lower_new_dentry);
+	dget(lower_old_dentry);
+	dget(lower_new_dentry);
 	lower_old_dir_dentry = dget_parent(lower_old_dentry);
 	lower_new_dir_dentry = dget_parent(lower_new_dentry);
 	lock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
@@ -768,8 +764,8 @@
 		ecryptfs_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
 out_lock:
 	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
-	ecryptfs_dput(lower_new_dentry);
-	ecryptfs_dput(lower_old_dentry);
+	dput(lower_new_dentry);
+	dput(lower_old_dentry);
 	return err;
 }
 
@@ -790,7 +786,7 @@
 		goto out;
 	}
 	/* Released in this function */
-	lower_buf = ecryptfs_kmalloc(bufsiz, GFP_KERNEL);
+	lower_buf = kmalloc(bufsiz, GFP_KERNEL);
 	if (lower_buf == NULL) {
 		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
 		err = -ENOMEM;
@@ -817,11 +813,11 @@
 			if (copy_to_user(buf, decoded_name, err))
 				err = -EFAULT;
 		}
-		ecryptfs_kfree(decoded_name);
+		kfree(decoded_name);
 		ecryptfs_copy_attr_atime(dentry->d_inode,
 					 lower_dentry->d_inode);
 	}
-	ecryptfs_kfree(lower_buf);
+	kfree(lower_buf);
       out:
 	return err;
 }
@@ -833,7 +829,7 @@
 	mm_segment_t old_fs;
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	/* Released in this function */
-	buf = ecryptfs_kmalloc(len, GFP_KERNEL);
+	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf) {
 		rc = -ENOMEM;
 		goto out;
@@ -848,7 +844,7 @@
 	rc = 0;
 	nd_set_link(nd, buf);
 out_free:
-	ecryptfs_kfree(buf);
+	kfree(buf);
 out:
 	return NULL;
 }
@@ -857,7 +853,7 @@
 ecryptfs_put_link(struct dentry *dentry, struct nameidata *nd, void *ptr)
 {
 	/* Free the char* */
-	ecryptfs_kfree(nd_get_link(nd));
+	kfree(nd_get_link(nd));
 }
 
 /**
@@ -943,7 +939,7 @@
 	fake_ecryptfs_file.f_dentry = dentry;
 	/* Released at out_free: */
 	FILE_TO_PRIVATE_SM(&fake_ecryptfs_file) =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
 	if (unlikely(!FILE_TO_PRIVATE(&fake_ecryptfs_file))) {
 		rc = -ENOMEM;
 		goto out;
@@ -952,8 +948,7 @@
 	/* This dget & mntget is released through fput at out_fput: */
 	dget(lower_dentry);
 	mntget(SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt);
-	lower_file =
-	    ecryptfs_dentry_open(lower_dentry,
+	lower_file = dentry_open(lower_dentry,
 				 SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt,
 				 O_RDWR);
 	if (unlikely(IS_ERR(lower_file))) {
@@ -1014,8 +1009,8 @@
 	fput(lower_file);
 out_free:
 	if (FILE_TO_PRIVATE(&fake_ecryptfs_file)) {
-		ecryptfs_kmem_cache_free(ecryptfs_file_info_cache,
-					 FILE_TO_PRIVATE(&fake_ecryptfs_file));
+		kmem_cache_free(ecryptfs_file_info_cache,
+				FILE_TO_PRIVATE(&fake_ecryptfs_file));
 	}
 out:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
@@ -1092,7 +1087,7 @@
 		return NULL;
 	else if (size <= PAGE_SIZE) {
 		/* Released in xattr_free() */
-		ptr = ecryptfs_kmalloc((unsigned long)size, GFP_KERNEL);
+		ptr = kmalloc((unsigned long)size, GFP_KERNEL);
 	} else {
 		/* Released in xattr_free() */
 		ptr = vmalloc((unsigned long)size);
@@ -1109,7 +1104,7 @@
 		return;
 	else if (size <= PAGE_SIZE) {
 		/* Allocated in xallr_alloc() */
-		ecryptfs_kfree(ptr);
+		kfree(ptr);
 	} else {
 		/* Allocated in xallr_alloc() */
 		vfree(ptr);
@@ -1153,7 +1148,7 @@
 		if (IS_ERR(encoded_name)) {
 			err = PTR_ERR(encoded_name);
 			encoded_name = NULL;
-			ecryptfs_kfree(encoded_suffix);
+			kfree(encoded_suffix);
 			goto out;
 		}
 		if (prelen) {
@@ -1166,7 +1161,7 @@
 			memcpy(encoded_name + prelen, encoded_suffix, sufflen);
 			encoded_name[sufflen] = '\0';
 		}
-		ecryptfs_kfree(encoded_suffix);
+		kfree(encoded_suffix);
 		encoded_value = xattr_alloc(size, XATTR_SIZE_MAX);
 		if (IS_ERR(encoded_value)) {
 			err = PTR_ERR(encoded_value);
@@ -1304,7 +1299,7 @@
 	if (encoded_name)
 		xattr_free(encoded_name, namelen + 1);
 	if (encoded_suffix)
-		ecryptfs_kfree(encoded_suffix);
+		kfree(encoded_suffix);
 	if (encoded_value)
 		xattr_free(encoded_value, size);
 	return err;
@@ -1364,7 +1359,7 @@
 	}
 out:
 	if (encoded_suffix)
-		ecryptfs_kfree(encoded_suffix);
+		kfree(encoded_suffix);
 	return err;
 }
 
@@ -1441,7 +1436,7 @@
 			newsize += sufflen + 1;
 		}
 		cur += (namelen + 1);
-		ecryptfs_kfree(encoded_suffix);
+		kfree(encoded_suffix);
 	}
 	err = newsize;
 out:
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/main.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/main.c	2005-11-01 14:41:36.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/main.c	2005-11-03 18:46:35.000000000 -0600
@@ -43,13 +43,9 @@
 /**
  * Module parameter that defines the ecryptfs_verbosity level.
  */
-#define VERBOSE_DUMP 9
-#ifdef DEBUG
-int ecryptfs_verbosity = VERBOSE_DUMP;
-#else
-int ecryptfs_verbosity = 1;
-#endif
-module_param(ecryptfs_verbosity, int, 1);
+int ecryptfs_verbosity = 0;
+
+module_param(ecryptfs_verbosity, int, 0);
 MODULE_PARM_DESC(ecryptfs_verbosity,
 		 "Initial verbosity level (0 or 1; defaults to "
 		 "0, which is Quiet)");
@@ -58,253 +54,16 @@
 {
 	va_list args;
 	va_start(args, fmt);
-	if (unlikely((ecryptfs_verbosity == VERBOSE_DUMP))) {
-		vprintk(fmt, args);
-		goto out;
-	}
 	if ((ecryptfs_verbosity >= verb) && printk_ratelimit()) {
 		vprintk(fmt, args);
 	}
-out:
 	va_end(args);
 }
 
-#ifdef ECRYPTFS_ENABLE_MEMORY_TRACING
-static void ecryptfs_printk_release(void *ptr, const char *fun, int line)
-{
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: Releasing memory at location "
-			"[%p]\n", fun, line, ptr);
-}
-
-static void ecryptfs_printk_alloc(void *ptr, size_t size, const char *fun,
-				  int line)
-{
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: Allocated memory at location "
-			"[%p] ([%d] bytes)\n", fun, line, ptr, size);
-}
-
-void __ecryptfs_kfree(void *ptr, const char *fun, int line)
-{
-	if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
-		ecryptfs_printk_release(ptr, fun, line);
-	kfree(ptr);
-}
-
-void *__ecryptfs_kmalloc(size_t size, unsigned int flags, const char *fun,
-			 int line)
-{
-	void *ptr;
-	ptr = kmalloc(size, flags);
-	if (unlikely(ECRYPTFS_ENABLE_MEMORY_TRACING))
-		ecryptfs_printk_alloc(ptr, size, fun, line);
-	return ptr;
-}
-
-#ifndef ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY
-#define ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY 1
-#endif
-
-void __ecryptfs_kmem_cache_free(struct kmem_cache_s *kmem_cache, void *ptr,
-				const char *fun, int line)
-{
-	ecryptfs_printk(ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY,
-			KERN_NOTICE, "%s:%d: calling kmem_cache_free() on "
-			"kmem_cache = [%p]; ptr = [%p]\n", fun, line,
-			kmem_cache, ptr);
-	kmem_cache_free(kmem_cache, ptr);
-}
-
-void *__ecryptfs_kmem_cache_alloc(kmem_cache_t * kmem_cache,
-				  unsigned int slab_type, const char *fun,
-				  int line)
-{
-	void *ptr;
-	ecryptfs_printk(ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY,
-			KERN_NOTICE, "%s:%d: calling kmem_cache_alloc() on "
-			"kmem_cache = [%p]\n", fun, line, kmem_cache);
-	ptr = kmem_cache_alloc(kmem_cache, slab_type);
-	ecryptfs_printk(ECRYPTFS_KMEM_CACHE_DEBUG_VERBOSITY,
-			KERN_NOTICE, "%s:%d: called kmem_cache_alloc(); ptr "
-			"= [%p]\n", fun, line, ptr);
-	return ptr;
-}
-#endif				/* ECRYPTFS_ENABLE_MEMORY_TRACING */
-
-#ifdef ECRYPTFS_WRAP_VFS_CALLS
-struct inode *__ecryptfs_iget(struct super_block *sb, unsigned long ino,
-			      const char *fun, int line)
-{
-	int count;
-	struct inode *inode;
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling iget(); ino = [%lu]\n",
-			fun, line, ino);
-	inode = iget(sb, ino);
-	count = atomic_read(&inode->i_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called iget(): after call, "
-			"inode = [%p]; inode->i_count = [%d]\n", fun, line,
-			inode, count);
-	return inode;
-}
-
-void __ecryptfs_iput(struct inode *inode, const char *fun, int line)
-{
-	int count;
-	count = atomic_read(&inode->i_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling iput(); before call, "
-			"inode = [%p]; inode->i_count = [%d]\n", fun, line,
-			inode, count);
-	iput(inode);
-	count = atomic_read(&inode->i_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called iput(); after call, "
-			"inode->i_count = [%d]\n", fun, line, count);
-}
-
-void __ecryptfs_fput(struct file *file, const char *fun, int line)
-{
-	int count;
-	count = atomic_read(&file->f_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling fput(); before call, "
-			"file = [%p]; file->f_count = [%d]\n", fun, line,
-			file, count);
-	fput(file);
-	count = atomic_read(&file->f_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called fput(); after call, "
-			"file->f_count = [%d]\n", fun, line, count);
-}
-
-void __ecryptfs_d_add(struct dentry *dentry, struct inode *inode,
-		      const char *fun, int line)
-{
-	int count;
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_add(); before call, "
-			"dentry->d_count = [%d]\n", fun, line, count);
-	d_add(dentry, inode);
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called iget(): after call, "
-			"dentry->d_count = [%d]\n", fun, line, count);
-}
-
-void __ecryptfs_d_instantiate(struct dentry *dentry, struct inode *inode,
-			      const char *fun, int line)
-{
-	int count;
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_instantiate(); "
-			"before call, dentry->d_count = [%d]\n", fun, line,
-			count);
-	d_instantiate(dentry, inode);
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called d_instantiate(); "
-			"dentry->d_count = [%d]\n", fun, line, count);
-}
-
-struct dentry *__ecryptfs_d_alloc(struct dentry *parent,
-				  const struct qstr *name, const char *fun,
-				  int line)
-{
-	struct dentry *dentry;
-	dentry = d_alloc(parent, name);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: Allocated a new dentry at "
-			"location [%p] for name [%s]\n", fun, line, dentry,
-			name);
-	return dentry;
-}
-
-void __ecryptfs_d_drop(struct dentry *dentry, const char *fun, int line)
-{
-	int count;
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_drop() w/ "
-			"dentry = [%p]; dentry->d_count = [%d]\n", fun, line,
-			dentry, count);
-	d_drop(dentry);
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called d_drop(), "
-			"dentry->d_count = [%d]\n", fun, line, count);
-}
-
-void __ecryptfs_dput(struct dentry *dentry, const char *fun, int line)
-{
-	int count;
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling dput() on dentry with "
-			"dentry = [%p]; dentry->d_name.name = [%s]; "
-			"dentry->d_count = [%d]\n", fun, line,
-			dentry, dentry->d_name.name, count);
-	dput(dentry);
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called dput() on dentry; now "
-			"dentry->d_count = [%d]\n", fun, line, count);
-}
-
-struct dentry *__ecryptfs_dget(struct dentry *dentry, const char *fun, int line)
-{
-	int count;
-	struct dentry *ret_dentry;
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling dget() on dentry with "
-			"dentry = [%p]; dentry->d_name.name = [%s]; "
-			"dentry->d_count = [%d]\n", fun, line,
-			dentry, dentry->d_name.name, count);
-	if (count == 0) {
-		ecryptfs_printk(0, KERN_ERR, "%s:%d: The dentry has a count "
-				"of 0, which is illegal!\n");
-	}
-	ret_dentry = dget(dentry);
-	count = atomic_read(&dentry->d_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called dget() on dentry; now "
-			"dentry->d_count = [%d]\n", fun, line, count);
-	return ret_dentry;
-}
-
-struct file *__ecryptfs_dentry_open(struct dentry *dentry, struct vfsmount *mnt,
-				    int flags, const char *fun, int line)
-{
-	struct file *file;
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling dentry_open(); "
-			"dentry=[%p], mnt=[%p], flags=[0x%.8x]); "
-			"dentry->d_count = [%d]\n", fun, line, dentry, mnt,
-			flags, atomic_read(&dentry->d_count));
-	file = dentry_open(dentry, mnt, flags);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called dentry_open()\n",
-			fun, line);
-	return file;
-}
-
-void __ecryptfs_d_delete(struct dentry *dentry, const char *fun, int line)
-{
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling d_delete(); "
-			"dentry = [%p], dentry->d_name.name = [%s], "
-			"dentry->d_count = [%d]\n", fun, line, dentry,
-			dentry->d_name.name, atomic_read(&dentry->d_count));
-	d_delete(dentry);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called d_delete(); "
-			"dentry->d_count = [%d]\n", fun, line,
-			atomic_read(&dentry->d_count));
-}
-
-struct inode *__ecryptfs_igrab(struct inode *inode, const char *fun, int line)
-{
-	struct inode *ret_inode;
-	int count;
-	count = atomic_read(&inode->i_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: calling igrab(); before call, "
-			"inode = [%p]; inode->i_count = [%d]\n", fun, line,
-			inode, count);
-	ret_inode = igrab(inode);
-	count = atomic_read(&inode->i_count);
-	ecryptfs_printk(1, KERN_NOTICE, "%s:%d: called igrab(); after call, "
-			"inode->i_count = [%d]\n", fun, line, count);
-	return ret_inode;
-}
-
-#endif				/* #ifdef ECRYPTFS_WRAP_VFS_CALLS */
-
 /**
  * Interposes upper and lower dentries.
  * This function will call an ecryptfs_inode into existance through the call to
- * ecryptfs_iget(sb, lower_inode->i_ino).
+ * iget(sb, lower_inode->i_ino).
  * 
  * @param lower_dentry	existing dentry in the lower filesystem
  * @param dentry	ecryptfs' dentry
@@ -332,7 +91,7 @@
 		err = -EXDEV;
 		goto out;
 	}
-	inode = ecryptfs_iget(sb, lower_inode->i_ino);
+	inode = iget(sb, lower_inode->i_ino);
 	if (!inode) {
 		err = -EACCES;
 		goto out;
@@ -349,7 +108,7 @@
 	}
 
 	if (NULL == INODE_TO_LOWER(inode)) {
-		INODE_TO_LOWER(inode) = ecryptfs_igrab(lower_inode);
+		INODE_TO_LOWER(inode) = igrab(lower_inode);
 		/* If we are still NULL at this point, igrab failed.
 		 * We are _NOT_ supposed to be failing here */
 		if (NULL == INODE_TO_LOWER(inode)) {
@@ -373,9 +132,9 @@
 	}
 	dentry->d_op = &ecryptfs_dops;
 	if (flag) {
-		ecryptfs_d_add(dentry, inode);
+		d_add(dentry, inode);
 	} else {
-		ecryptfs_d_instantiate(dentry, inode);
+		d_instantiate(dentry, inode);
 	}
 	ecryptfs_copy_attr_all(inode, lower_inode);
 out:
@@ -576,7 +335,7 @@
 			"silent = [%d]\n", sb, (char *)raw_data, silent);
 	/* Released in ecryptfs_put_super() */
 	SUPERBLOCK_TO_PRIVATE_SM(sb) =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_sb_info_cache, SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_sb_info_cache, SLAB_KERNEL);
 	if (!SUPERBLOCK_TO_PRIVATE_SM(sb)) {
 		ecryptfs_printk(0, KERN_WARNING, "Out of memory\n");
 		err = -ENOMEM;
@@ -595,10 +354,10 @@
 	sb->s_root->d_op = &ecryptfs_dops;
 	sb->s_root->d_sb = sb;
 	sb->s_root->d_parent = sb->s_root;
-	/* Released in ecryptfs_d_release when dput(sb->s_root) is called */
+	/* Released in d_release when dput(sb->s_root) is called */
 	/* through deactivate_super(sb) from get_sb_nodev() */
 	DENTRY_TO_PRIVATE_SM(sb->s_root) = (struct ecryptfs_dentry_info *)
-	    ecryptfs_kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_dentry_info_cache, SLAB_KERNEL);
 	if (!DENTRY_TO_PRIVATE_SM(sb->s_root)) {
 		ecryptfs_printk(0, KERN_ERR,
 				"dentry_info_cache alloc failed\n");
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/crypto.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/crypto.c	2005-11-01 15:55:57.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/crypto.c	2005-11-03 16:20:31.000000000 -0600
@@ -667,8 +667,7 @@
 		goto out;
 	}
 	/* Released in this function */
-	page_virt =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_header_cache_0, SLAB_USER);
+	page_virt = kmem_cache_alloc(ecryptfs_header_cache_0, SLAB_USER);
 	if (!page_virt) {
 		ecryptfs_printk(0, KERN_ERR, "Out of memory\n");
 		return -ENOMEM;
@@ -694,11 +693,11 @@
 	lower_file->f_op->write(lower_file, (char __user *)page_virt,
 				PAGE_CACHE_SIZE, &lower_file->f_pos);
 	set_fs(oldfs);
-	ecryptfs_fput(lower_file);
+	fput(lower_file);
 	ecryptfs_printk(1, KERN_NOTICE,
 			"Done writing key packet set to underlying file.\n");
 out_free:
-	ecryptfs_kmem_cache_free(ecryptfs_header_cache_0, page_virt);
+	kmem_cache_free(ecryptfs_header_cache_0, page_virt);
 out:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
 	return rc;
@@ -719,8 +718,7 @@
 
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	/* Read the first page from the underlying file */
-	page_virt =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_header_cache_1, SLAB_USER);
+	page_virt = kmem_cache_alloc(ecryptfs_header_cache_1, SLAB_USER);
 	if (IS_ERR(page_virt)) {
 		rc = -ENOMEM;
 		ecryptfs_printk(0, KERN_ERR, "Unable to allocate page_virt\n");
@@ -740,7 +738,7 @@
 		goto out;
 	}
 	rc = ecryptfs_parse_packet_set(page_virt, crypt_stats, ecryptfs_dentry);
-	ecryptfs_kmem_cache_free(ecryptfs_header_cache_1, page_virt);
+	kmem_cache_free(ecryptfs_header_cache_1, page_virt);
 	if (rc) {
 		ecryptfs_printk(1, KERN_NOTICE, "File not encrypted\n");
 		rc = -EINVAL;
@@ -772,7 +770,7 @@
 {
 	int error = 0;
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; length = [%d]\n", length);
-	(*encoded_name) = ecryptfs_kmalloc(length + 2, GFP_KERNEL);
+	(*encoded_name) = kmalloc(length + 2, GFP_KERNEL);
 	if (!(*encoded_name)) {
 		error = -ENOMEM;
 		goto out;
@@ -805,7 +803,7 @@
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; length = [%d]\n", length);
 	/* Make sure we are called correctly */
 	BUG_ON(length < 0);
-	(*decrypted_name) = ecryptfs_kmalloc(length + 2, GFP_KERNEL);
+	(*decrypted_name) = kmalloc(length + 2, GFP_KERNEL);
 	if (!(*decrypted_name)) {
 		error = -ENOMEM;
 		goto out;
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/ecryptfs_kernel.h	2005-11-01 14:40:09.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/ecryptfs_kernel.h	2005-11-03 15:36:39.000000000 -0600
@@ -417,107 +417,4 @@
 /* inode.c */
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
 
-/* For debugging purposes only */
-#ifdef ECRYPTFS_DEBUG
-#define ECRYPTFS_ENABLE_MEMORY_TRACING 1
-#endif
-#ifdef ECRYPTFS_ENABLE_MEMORY_TRACING
-void __ecryptfs_kfree(void *ptr, const char *fun, int line);
-#define ecryptfs_kfree(ptr) \
-        __ecryptfs_kfree(ptr, __FUNCTION__, __LINE__);
-#define ecryptfs_kmalloc(size, flags) \
-        __ecryptfs_kmalloc(size, flags, __FUNCTION__, __LINE__);
-#define ecryptfs_kmem_cache_alloc(kmem_cache, slab_type) \
-        __ecryptfs_kmem_cache_alloc(kmem_cache, slab_type, __FUNCTION__, \
-                                    __LINE__)
-#define ecryptfs_kmem_cache_free(kmem_cache, ptr) \
-        __ecryptfs_kmem_cache_free(kmem_cache, ptr, __FUNCTION__, __LINE__)
-void *__ecryptfs_kmalloc(size_t size, unsigned int flags,
-			 const char *fun, int line);
-void *__ecryptfs_kmem_cache_alloc(kmem_cache_t * kmem_cache,
-				  unsigned int slab_type, const char *fun,
-				  int line);
-void __ecryptfs_kmem_cache_free(kmem_cache_t * kmem_cache, void *ptr,
-				const char *fun, int line);
-#else
-#define ecryptfs_kfree(ptr) \
-	kfree(ptr)
-#define ecryptfs_kmalloc(size, flags) \
-	kmalloc(size, flags)
-#define ecryptfs_kmem_cache_alloc(kmem_cache, slab_type) \
-	kmem_cache_alloc(kmem_cache, slab_type)
-#define ecryptfs_kmem_cache_free(kmem_cache, ptr) \
-	kmem_cache_free(kmem_cache, ptr)
-#endif				/* ECRYPTFS_ENABLE_MEMORY_TRACING */
-
-/**
- * For debugging purposes; replace with direct calls when done
- * debugging. Wouldn't it be neat to put something like this in
- * mainline?
- */
-#ifdef ECRYPTFS_DEBUG
-#define ECRYPTFS_WRAP_VFS_CALLS 1
-#endif
-#ifdef ECRYPTFS_WRAP_VFS_CALLS
-#define ecryptfs_iget(sb, inode) \
-        __ecryptfs_iget(sb, inode, __FUNCTION__, __LINE__)
-#define ecryptfs_iput(inode) \
-        __ecryptfs_iput(inode, __FUNCTION__, __LINE__)
-#define ecryptfs_fput(file) \
-        __ecryptfs_fput(file, __FUNCTION__, __LINE__)
-#define ecryptfs_d_add(dentry, inode) \
-        __ecryptfs_d_add(dentry, inode, __FUNCTION__, __LINE__)
-#define ecryptfs_d_instantiate(dentry, inode) \
-        __ecryptfs_d_instantiate(dentry, inode, __FUNCTION__, __LINE__)
-#define ecryptfs_d_alloc(parent, name) \
-        __ecryptfs_d_alloc(parent, name, __FUNCTION__, __LINE__)
-#define ecryptfs_dput(dentry) \
-        __ecryptfs_dput(dentry, __FUNCTION__, __LINE__)
-#define ecryptfs_dget(dentry) \
-        __ecryptfs_dget(dentry, __FUNCTION__, __LINE__)
-#define ecryptfs_d_drop(dentry) \
-        __ecryptfs_d_drop(dentry, __FUNCTION__, __LINE__)
-#define ecryptfs_dentry_open(dentry, mnt, flags) \
-        __ecryptfs_dentry_open(dentry, mnt, flags, __FUNCTION__, __LINE__)
-#define ecryptfs_dentry_delete(dentry) \
-        __ecryptfs_d_delete(dentry, __FUNCTION__, __LINE__)
-#define ecryptfs_igrab(inode) \
-        __ecryptfs_igrab(inode, __FUNCTION__, __LINE__)
-/* Wrappers for various VFS calls, for debugging purposes. */
-void __ecryptfs_d_drop(struct dentry *dentry, const char *fun, int line);
-struct dentry *__ecryptfs_dget(struct dentry *dentry, const char *fun,
-			       int line);
-void __ecryptfs_dput(struct dentry *dentry, const char *fun, int line);
-struct dentry *__ecryptfs_d_alloc(struct dentry *parent,
-				  const struct qstr *name, const char *fun,
-				  int line);
-void __ecryptfs_d_instantiate(struct dentry *dentry, struct inode *inode,
-			      const char *fun, int line);
-void __ecryptfs_d_add(struct dentry *dentry, struct inode *inode,
-		      const char *fun, int line);
-void __ecryptfs_iput(struct inode *inode, const char *fun, int line);
-void __ecryptfs_fput(struct file *file, const char *fun, int line);
-struct inode *__ecryptfs_iget(struct super_block *sb, unsigned long ino,
-			      const char *fun, int line);
-struct file *__ecryptfs_dentry_open(struct dentry *dentry, struct vfsmount *mnt,
-				    int flags, const char *fun, int line);
-void __ecryptfs_d_delete(struct dentry *dentry, const char *fun, int line);
-struct inode *__ecryptfs_igrab(struct inode *inode, const char *fun, int line);
-
-#else
-#define ecryptfs_iget(sb, inode) iget(sb, inode)
-#define ecryptfs_iput(inode) iput(inode)
-#define ecryptfs_fput(file) fput(file)
-#define ecryptfs_d_add(dentry, inode) d_add(dentry, inode)
-#define ecryptfs_d_instantiate(dentry, inode) d_instantiate(dentry, inode)
-#define ecryptfs_d_alloc(parent, name) d_alloc(parent, name)
-#define ecryptfs_dput(dentry) dput(dentry)
-#define ecryptfs_dget(dentry) dget(dentry)
-#define ecryptfs_d_drop(dentry) d_drop(dentry)
-#define ecryptfs_dentry_open(dentry, mnt, flags) dentry_open(dentry, mnt, flags)
-#define ecryptfs_d_delete(dentry) d_delete(dentry)
-#define ecryptfs_dentry_delete(dentry) d_delete(dentry)
-#define ecryptfs_igrab(inode) igrab(inode)
-#endif				/* ECRYPTFS_WRAP_VFS_CALLS */
-
 #endif				/* ndef ECRYPTFS_KERNEL_H */
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/file.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/file.c	2005-11-01 14:40:10.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/file.c	2005-11-03 15:42:55.000000000 -0600
@@ -192,7 +192,7 @@
 		return 0;
 	rc = buf->filldir(buf->dirent, decoded_name, decoded_length, offset,
 			  ino, d_type);
-	ecryptfs_kfree(decoded_name);
+	kfree(decoded_name);
 	if (rc >= 0)
 		buf->entries_written++;
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
@@ -316,7 +316,7 @@
 	ASSERT(DENTRY_TO_PRIVATE(ecryptfs_dentry));
 	/* Released in ecryptfs_release or end of function if failure */
 	FILE_TO_PRIVATE_SM(file) =
-	    ecryptfs_kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
+	    kmem_cache_alloc(ecryptfs_file_info_cache, SLAB_KERNEL);
 	if (!FILE_TO_PRIVATE_SM(file)) {
 		ecryptfs_printk(0, KERN_ERR,
 				"Error attempting to allocate memory\n");
@@ -333,7 +333,7 @@
 		crypt_stats->encrypted = 1;
 	}
 	/* This mntget & dget is undone via fput when the file is released */
-	ecryptfs_dget(lower_dentry);
+	dget(lower_dentry);
 	lower_flags = file->f_flags;
 	if ((lower_flags & O_ACCMODE) == O_WRONLY)
 		lower_flags = (lower_flags & O_ACCMODE) | O_RDWR;
@@ -342,7 +342,7 @@
 	lower_mnt = SUPERBLOCK_TO_PRIVATE(inode->i_sb)->lower_mnt;
 	mntget(lower_mnt);
 	/* Corresponding fput() in ecryptfs_release() */
-	lower_file = ecryptfs_dentry_open(lower_dentry, lower_mnt, lower_flags);
+	lower_file = dentry_open(lower_dentry, lower_mnt, lower_flags);
 	if (IS_ERR(lower_file)) {
 		rc = PTR_ERR(lower_file);
 		ecryptfs_printk(0, KERN_ERR, "Error opening lower file\n");
@@ -394,9 +394,8 @@
 	goto out;
 out_puts:
 	mntput(lower_mnt);
-	ecryptfs_dput(lower_dentry);
-	ecryptfs_kmem_cache_free(ecryptfs_file_info_cache,
-				 FILE_TO_PRIVATE(file));
+	dput(lower_dentry);
+	kmem_cache_free(ecryptfs_file_info_cache, FILE_TO_PRIVATE(file));
 out:
 	ecryptfs_printk(1, KERN_NOTICE, "Exit; rc = [%d]\n", rc);
 	return rc;
@@ -426,8 +425,7 @@
 	if (FILE_TO_PRIVATE(file) != NULL)
 		lower_file = FILE_TO_LOWER(file);
 	ASSERT(lower_file);
-	ecryptfs_kmem_cache_free(ecryptfs_file_info_cache,
-				 FILE_TO_PRIVATE(file));
+	kmem_cache_free(ecryptfs_file_info_cache, FILE_TO_PRIVATE(file));
 	lower_inode = INODE_TO_LOWER(ecryptfs_inode);
 	fput(lower_file);
 	ecryptfs_inode->i_blocks = lower_inode->i_blocks;
Index: linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/super.c
===================================================================
--- linux-2.6.14-rc5-ecryptfs.orig/fs/ecryptfs/super.c	2005-11-01 14:40:17.000000000 -0600
+++ linux-2.6.14-rc5-ecryptfs/fs/ecryptfs/super.c	2005-11-03 18:46:59.000000000 -0600
@@ -50,8 +50,8 @@
 	struct ecryptfs_inode_info *ecryptfs_inode = NULL;
 	struct inode *inode = NULL;
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; sb = [%p]\n", sb);
-	ecryptfs_inode = ecryptfs_kmem_cache_alloc(ecryptfs_inode_info_cache,
-						   SLAB_KERNEL);
+	ecryptfs_inode = kmem_cache_alloc(ecryptfs_inode_info_cache,
+					  SLAB_KERNEL);
 	if (unlikely(!ecryptfs_inode)) {
 		ecryptfs_printk(1, KERN_WARNING,
 				"Failed to allocate new inode\n");
@@ -75,8 +75,7 @@
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode = [%p]\n", inode);
 	crypt_stats = &(INODE_TO_PRIVATE(inode))->crypt_stats;
 	ecryptfs_destruct_crypt_stats(crypt_stats);
-	ecryptfs_kmem_cache_free(ecryptfs_inode_info_cache,
-                                  INODE_TO_PRIVATE(inode));
+	kmem_cache_free(ecryptfs_inode_info_cache, INODE_TO_PRIVATE(inode));
 	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
 }
 
@@ -131,7 +130,7 @@
 	ecryptfs_printk(1, KERN_NOTICE, "Enter\n");
 	mntput(sb_info->lower_mnt);
 	key_put(sb_info->mount_crypt_stats.global_auth_tok_key);
-	ecryptfs_kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
+	kmem_cache_free(ecryptfs_sb_info_cache, sb_info);
 	SUPERBLOCK_TO_PRIVATE_SM(sb) = NULL;
 	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
 }
@@ -176,7 +175,7 @@
 {
 	ecryptfs_printk(1, KERN_NOTICE, "Enter; inode = [%p]; i_ino = [%lu]\n",
 			inode, inode->i_ino);
-	ecryptfs_iput(INODE_TO_LOWER(inode));
+	iput(INODE_TO_LOWER(inode));
 	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
 }
 
