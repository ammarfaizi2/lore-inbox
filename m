Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312983AbSDDAg2>; Wed, 3 Apr 2002 19:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDDAgM>; Wed, 3 Apr 2002 19:36:12 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59903 "EHLO
	e31.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S312983AbSDDAf4>; Wed, 3 Apr 2002 19:35:56 -0500
Message-ID: <3CAB9FCA.2020000@us.ibm.com>
Date: Wed, 03 Apr 2002 16:35:22 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shift BKL out of notify_change
In-Reply-To: <3CAB8BB4.8040400@us.ibm.com> <200204032358.g33Nw1S13759@vindaloo.ras.ucalgary.ca>
Content-Type: multipart/mixed;
 boundary="------------010404040209050007070904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010404040209050007070904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a fixed patch.  Doesn't toch devfs.  Also fixed a } instead of ) 
error.  This one actually compiles :)

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010404040209050007070904
Content-Type: text/plain;
 name="notify_change-bkl_shift-2.5.7.patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="notify_change-bkl_shift-2.5.7.patch.2"

diff -ur linux-2.5.7-clean/fs/adfs/inode.c linux/fs/adfs/inode.c
--- linux-2.5.7-clean/fs/adfs/inode.c	Thu Mar  7 18:18:22 2002
+++ linux/fs/adfs/inode.c	Wed Apr  3 13:46:14 2002
@@ -302,6 +302,8 @@
 	struct super_block *sb = inode->i_sb;
 	unsigned int ia_valid = attr->ia_valid;
 	int error;
+	
+	lock_kernel();
 
 	error = inode_change_ok(inode, attr);
 
@@ -346,6 +348,7 @@
 	if (ia_valid & (ATTR_SIZE | ATTR_MTIME | ATTR_MODE))
 		mark_inode_dirty(inode);
 out:
+	unlock_kernel();
 	return error;
 }
 
diff -ur linux-2.5.7-clean/fs/affs/inode.c linux/fs/affs/inode.c
--- linux-2.5.7-clean/fs/affs/inode.c	Tue Apr  2 10:43:19 2002
+++ linux/fs/affs/inode.c	Wed Apr  3 13:46:31 2002
@@ -235,6 +235,8 @@
 	struct inode *inode = dentry->d_inode;
 	int error;
 
+	lock_kernel();
+
 	pr_debug("AFFS: notify_change(%lu,0x%x)\n",inode->i_ino,attr->ia_valid);
 
 	error = inode_change_ok(inode,attr);
@@ -254,6 +256,7 @@
 	if (!error && (attr->ia_valid & ATTR_MODE))
 		mode_to_prot(inode);
 out:
+	unlock_kernel();
 	return error;
 }
 
diff -ur linux-2.5.7-clean/fs/attr.c linux/fs/attr.c
--- linux-2.5.7-clean/fs/attr.c	Thu Mar  7 18:18:13 2002
+++ linux/fs/attr.c	Wed Apr  3 14:17:56 2002
@@ -21,6 +21,8 @@
 	int retval = -EPERM;
 	unsigned int ia_valid = attr->ia_valid;
 
+	lock_kernel();
+
 	/* If force is set do it anyway. */
 	if (ia_valid & ATTR_FORCE)
 		goto fine;
@@ -55,6 +57,7 @@
 fine:
 	retval = 0;
 error:
+	unlock_kernel();
 	return retval;
 }
 
@@ -62,7 +65,8 @@
 {
 	unsigned int ia_valid = attr->ia_valid;
 	int error = 0;
-
+	
+	lock_kernel();
 	if (ia_valid & ATTR_SIZE) {
 		error = vmtruncate(inode, attr->ia_size);
 		if (error)
@@ -86,6 +90,7 @@
 	}
 	mark_inode_dirty(inode);
 out:
+	unlock_kernel();
 	return error;
 }
 
@@ -127,7 +132,7 @@
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
 
-	lock_kernel();
+	down(&inode->i_attr_lock);
 	if (inode->i_op && inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
 	else {
@@ -140,7 +145,7 @@
 				error = inode_setattr(inode, attr);
 		}
 	}
-	unlock_kernel();
+	up(&inode->i_attr_lock);
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
 		if (dn_mask)
diff -ur linux-2.5.7-clean/fs/coda/inode.c linux/fs/coda/inode.c
--- linux-2.5.7-clean/fs/coda/inode.c	Tue Apr  2 10:43:19 2002
+++ linux/fs/coda/inode.c	Wed Apr  3 13:46:50 2002
@@ -258,6 +258,8 @@
         struct coda_vattr vattr;
         int error;
 	
+	lock_kernel();
+	
         memset(&vattr, 0, sizeof(vattr)); 
 
 	inode->i_ctime = CURRENT_TIME;
@@ -272,6 +274,8 @@
 		coda_cache_clear_inode(inode);
 	}
 
+	unlock_kernel();
+
 	return error;
 }
 
diff -ur linux-2.5.7-clean/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.5.7-clean/fs/fat/inode.c	Tue Apr  2 10:43:19 2002
+++ linux/fs/fat/inode.c	Wed Apr  3 13:55:04 2002
@@ -1054,18 +1054,24 @@
 {
 	struct super_block *sb = dentry->d_sb;
 	struct inode *inode = dentry->d_inode;
-	int error;
+	int error = 0;
+
+	lock_kernel();
 
 	/* FAT cannot truncate to a longer file */
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (attr->ia_size > inode->i_size)
-			return -EPERM;
+		if (attr->ia_size > inode->i_size) {
+			error = -EPERM;
+			goto out;
+		}
 	}
 
 	error = inode_change_ok(inode, attr);
-	if (error)
-		return MSDOS_SB(sb)->options.quiet ? 0 : error;
-
+	if (error) {
+		if( MSDOS_SB(sb)->options.quiet )
+		    error = 0; 
+		goto out;
+	}
 	if (((attr->ia_valid & ATTR_UID) && 
 	     (attr->ia_uid != MSDOS_SB(sb)->options.fs_uid)) ||
 	    ((attr->ia_valid & ATTR_GID) && 
@@ -1074,12 +1080,13 @@
 	     (attr->ia_mode & ~MSDOS_VALID_MODE)))
 		error = -EPERM;
 
-	if (error)
-		return MSDOS_SB(sb)->options.quiet ? 0 : error;
-
-	error = inode_setattr(inode, attr);
-	if (error)
-		return error;
+	if (error) {
+		if( MSDOS_SB(sb)->options.quiet )  
+			error = 0;
+		goto out;
+	}
+	if( error = inode_setattr(inode, attr) )
+		goto out;
 
 	if (S_ISDIR(inode->i_mode))
 		inode->i_mode |= S_IXUGO;
@@ -1087,6 +1094,8 @@
 	inode->i_mode = ((inode->i_mode & S_IFMT) | ((((inode->i_mode & S_IRWXU
 	    & ~MSDOS_SB(sb)->options.fs_umask) | S_IRUSR) >> 6)*S_IXUGO)) &
 	    ~MSDOS_SB(sb)->options.fs_umask;
-	return 0;
+out:
+	unlock_kernel();
+	return error;
 }
 MODULE_LICENSE("GPL");
diff -ur linux-2.5.7-clean/fs/hfs/inode.c linux/fs/hfs/inode.c
--- linux-2.5.7-clean/fs/hfs/inode.c	Thu Mar  7 18:18:30 2002
+++ linux/fs/hfs/inode.c	Wed Apr  3 14:33:02 2002
@@ -117,17 +117,18 @@
 	struct hfs_cat_entry *entry = HFS_I(inode)->entry;
 	struct dentry **de = entry->sys_entry;
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
-	int error, i;
+	int error=0, i;
+
+	lock_kernel();
 
 	error = inode_change_ok(inode, attr); /* basic permission checks */
 	if (error) {
 		/* Let netatalk's afpd think chmod() always succeeds */
 		if (hsb->s_afpd &&
 		    (attr->ia_valid == (ATTR_MODE | ATTR_CTIME))) {
-			return 0;
-		} else {
-			return error;
+			error = 0;
 		}
+		goto out; 
 	}
 
 	/* no uig/gid changes and limit which mode bits can be set */
@@ -139,7 +140,10 @@
 	     (((entry->type == HFS_CDR_DIR) &&
 	       (attr->ia_mode != inode->i_mode))||
 	      (attr->ia_mode & ~HFS_VALID_MODE_BITS)))) {
-		return hsb->s_quiet ? 0 : error;
+		if( hsb->s_quiet ) { 
+			error = 0;
+			goto out;
+		}
 	}
 	
 	if (entry->type == HFS_CDR_DIR) {
@@ -170,9 +174,9 @@
 		}
 	}
 	error = inode_setattr(inode, attr);
-	if (error)
-		return error;
-
+	if (error) 
+		goto out;
+	
 	/* We wouldn't want to mess with the sizes of the other fork */
 	attr->ia_valid &= ~ATTR_SIZE;
 
@@ -204,7 +208,9 @@
 	}
 	/* size changes handled in hfs_extent_adj() */
 
-	return 0;
+out:
+	unlock_kernel();
+	return error;
 }
 
 int hfs_notify_change(struct dentry *dentry, struct iattr * attr)
diff -ur linux-2.5.7-clean/fs/hpfs/inode.c linux/fs/hpfs/inode.c
--- linux-2.5.7-clean/fs/hpfs/inode.c	Thu Mar  7 18:18:22 2002
+++ linux/fs/hpfs/inode.c	Wed Apr  3 14:05:51 2002
@@ -303,15 +303,18 @@
 int hpfs_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
-	int error;
-	if ((attr->ia_valid & ATTR_SIZE) && attr->ia_size > inode->i_size) 
-		return -EINVAL;
-	if (inode->i_sb->s_hpfs_root == inode->i_ino) return -EINVAL;
-	if ((error = inode_change_ok(inode, attr))) return error;
-	error = inode_setattr(inode, attr);
-	if (error) return error;
-	hpfs_write_inode(inode);
-	return 0;
+	int error=0;
+	lock_kernel();
+	if ( ((attr->ia_valid & ATTR_SIZE) && attr->ia_size > inode->i_size) ||
+	     (inode->i_sb->s_hpfs_root == inode->i_ino) ) {
+		error = -EINVAL;
+	} else if ((error = inode_change_ok(inode, attr))) {
+	} else if ((error = inode_setattr(inode, attr))) {
+	} else {
+		hpfs_write_inode(inode);
+	}
+	unlock_kernel();
+	return error;
 }
 
 void hpfs_write_if_changed(struct inode *inode)
diff -ur linux-2.5.7-clean/fs/inode.c linux/fs/inode.c
--- linux-2.5.7-clean/fs/inode.c	Tue Apr  2 10:43:20 2002
+++ linux/fs/inode.c	Wed Apr  3 15:00:24 2002
@@ -143,6 +143,7 @@
 	INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
+	sema_init(&inode->i_attr_lock, 1);
 	spin_lock_init(&inode->i_data.i_shared_lock);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap);
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
diff -ur linux-2.5.7-clean/fs/intermezzo/dir.c linux/fs/intermezzo/dir.c
--- linux-2.5.7-clean/fs/intermezzo/dir.c	Thu Mar  7 18:18:19 2002
+++ linux/fs/intermezzo/dir.c	Wed Apr  3 14:35:35 2002
@@ -282,11 +282,13 @@
         struct presto_file_set *fset;
         struct lento_vfs_context info = { 0, 0, 0 };
 
+	lock_kernel();	
+
         ENTRY;
         error = presto_prep(de, &cache, &fset);
         if ( error ) {
                 EXIT;
-                return error;
+                goto out;        
         }
 
         if (!iattr->ia_valid)
@@ -300,7 +302,8 @@
         
         if ( presto_get_permit(de->d_inode) < 0 ) {
                 EXIT;
-                return -EROFS;
+                error = -EROFS;
+                goto out;
         }
 
         if (!ISLENTO(presto_c2m(cache)))
@@ -308,6 +311,8 @@
 	info.flags |= LENTO_FL_IGNORE_TIME;
         error = presto_do_setattr(fset, de, iattr, &info);
         presto_put_permit(de->d_inode);
+out:
+        unlock_kernel();
         return error;
 }
 
diff -ur linux-2.5.7-clean/fs/jffs/inode-v23.c linux/fs/jffs/inode-v23.c
--- linux-2.5.7-clean/fs/jffs/inode-v23.c	Tue Apr  2 10:43:20 2002
+++ linux/fs/jffs/inode-v23.c	Wed Apr  3 14:13:37 2002
@@ -196,11 +196,13 @@
 	struct jffs_file *f;
 	struct jffs_node *new_node;
 	int update_all;
-	int res;
+	int res = 0;
 	int recoverable = 0;
 
-	if ((res = inode_change_ok(inode, iattr)))
-		return res;
+	lock_kernel();
+
+	if ((res = inode_change_ok(inode, iattr))) 
+		goto out;
 
 	c = (struct jffs_control *)inode->i_sb->u.generic_sbp;
 	fmc = c->fmc;
@@ -215,7 +217,8 @@
 		       inode->i_ino);
 		D3(printk (KERN_NOTICE "notify_change(): up biglock\n"));
 		up(&fmc->biglock);
-		return -EINVAL;
+		res = -EINVAL;
+		goto out;
 	});
 
 	D1(printk("***jffs_setattr(): file: \"%s\", ino: %u\n",
@@ -235,7 +238,8 @@
 		D(printk("jffs_setattr(): Allocation failed!\n"));
 		D3(printk (KERN_NOTICE "notify_change(): up biglock\n"));
 		up(&fmc->biglock);
-		return -ENOMEM;
+		res = -ENOMEM;
+		goto out;
 	}
 
 	new_node->data_offset = 0;
@@ -321,7 +325,7 @@
 		jffs_free_node(new_node);
 		D3(printk (KERN_NOTICE "n_c(): up biglock\n"));
 		up(&c->fmc->biglock);
-		return res;
+		goto out;
 	}
 
 	jffs_insert_node(c, f, &raw_inode, 0, new_node);
@@ -329,7 +333,9 @@
 	mark_inode_dirty(inode);
 	D3(printk (KERN_NOTICE "n_c(): up biglock\n"));
 	up(&c->fmc->biglock);
-	return 0;
+out:
+	unlock_kernel();
+	return res;
 } /* jffs_notify_change()  */
 
 
diff -ur linux-2.5.7-clean/fs/jffs2/file.c linux/fs/jffs2/file.c
--- linux-2.5.7-clean/fs/jffs2/file.c	Tue Apr  2 10:43:21 2002
+++ linux/fs/jffs2/file.c	Wed Apr  3 14:15:08 2002
@@ -109,11 +109,12 @@
 	int mdatalen = 0;
 	unsigned int ivalid;
 	uint32_t phys_ofs, alloclen;
-	int ret;
+	int ret = 0;
+	lock_kernel();
 	D1(printk(KERN_DEBUG "jffs2_setattr(): ino #%lu\n", inode->i_ino));
 	ret = inode_change_ok(inode, iattr);
 	if (ret) 
-		return ret;
+		goto out;
 
 	/* Special cases - we don't want more than one data node
 	   for these types on the medium at any time. So setattr
@@ -130,12 +131,14 @@
 	} else if (S_ISLNK(inode->i_mode)) {
 		mdatalen = f->metadata->size;
 		mdata = kmalloc(f->metadata->size, GFP_USER);
-		if (!mdata)
-			return -ENOMEM;
+		if (!mdata) {
+			ret = -ENOMEM;
+			goto out;
+		}
 		ret = jffs2_read_dnode(c, f->metadata, mdata, 0, mdatalen);
 		if (ret) {
 			kfree(mdata);
-			return ret;
+			goto out;
 		}
 		D1(printk(KERN_DEBUG "jffs2_setattr(): Writing %d bytes of symlink target\n", mdatalen));
 	}
@@ -144,7 +147,8 @@
 	if (!ri) {
 		if (S_ISLNK(inode->i_mode))
 			kfree(mdata);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 		
 	ret = jffs2_reserve_space(c, sizeof(*ri) + mdatalen, &phys_ofs, &alloclen, ALLOC_NORMAL);
@@ -152,7 +156,7 @@
 		jffs2_free_raw_inode(ri);
 		if (S_ISLNK(inode->i_mode & S_IFMT))
 			 kfree(mdata);
-		return ret;
+		goto out;
 	}
 	down(&f->sem);
 	ivalid = iattr->ia_valid;
@@ -201,7 +205,8 @@
 		jffs2_complete_reservation(c);
 		jffs2_free_raw_inode(ri);
 		up(&f->sem);
-		return PTR_ERR(new_metadata);
+		ret = PTR_ERR(new_metadata);
+		goto out;
 	}
 	/* It worked. Update the inode */
 	inode->i_atime = ri->atime;
@@ -235,7 +240,9 @@
 	up(&f->sem);
 	jffs2_complete_reservation(c);
 
-	return 0;
+out:
+	unlock_kernel();	
+	return ret;
 }
 
 int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
diff -ur linux-2.5.7-clean/fs/ncpfs/inode.c linux/fs/ncpfs/inode.c
--- linux-2.5.7-clean/fs/ncpfs/inode.c	Tue Apr  2 10:43:22 2002
+++ linux/fs/ncpfs/inode.c	Wed Apr  3 14:38:24 2002
@@ -592,6 +592,8 @@
 
 	result = -EIO;
 
+	lock_kernel();	
+
 	server = NCP_SERVER(inode);
 	if ((!server) || !ncp_conn_valid(server))
 		goto out;
@@ -636,7 +638,8 @@
 				info.attributes |=  (aRONLY|aRENAMEINHIBIT|aDELETEINHIBIT);
                 } else if (!S_ISREG(inode->i_mode))
                 {
-                        return -EPERM;
+			result = -EPERM;
+			goto out;
                 }
                 else
                 {
@@ -722,7 +725,8 @@
 			attr->ia_size);
 
 		if ((result = ncp_make_open(inode, O_WRONLY)) < 0) {
-			return -EACCES;
+			result = -EACCES;
+			goto out;
 		}
 		ncp_write_kernel(NCP_SERVER(inode), NCP_FINFO(inode)->file_handle,
 			  attr->ia_size, 0, "", &written);
@@ -735,6 +739,7 @@
 			result = vmtruncate(inode, attr->ia_size);
 	}
 out:
+	unlock_kernel();
 	return result;
 }
 
diff -ur linux-2.5.7-clean/fs/nfs/inode.c linux/fs/nfs/inode.c
--- linux-2.5.7-clean/fs/nfs/inode.c	Tue Apr  2 10:43:22 2002
+++ linux/fs/nfs/inode.c	Wed Apr  3 14:07:56 2002
@@ -728,6 +728,8 @@
 	struct nfs_fattr fattr;
 	int error;
 
+	lock_kernel();
+
 	/*
 	 * Make sure the inode is up-to-date.
 	 */
@@ -776,6 +778,7 @@
 	NFS_CACHEINV(inode);
 	error = nfs_refresh_inode(inode, &fattr);
 out:
+	unlock_kernel();
 	return error;
 }
 
diff -ur linux-2.5.7-clean/fs/reiserfs/file.c linux/fs/reiserfs/file.c
--- linux-2.5.7-clean/fs/reiserfs/file.c	Thu Mar  7 18:18:05 2002
+++ linux/fs/reiserfs/file.c	Wed Apr  3 14:40:27 2002
@@ -95,14 +95,16 @@
 static int reiserfs_setattr(struct dentry *dentry, struct iattr *attr) {
     struct inode *inode = dentry->d_inode ;
     int error ;
+    lock_kernel();
     if (attr->ia_valid & ATTR_SIZE) {
 	/* version 2 items will be caught by the s_maxbytes check
 	** done for us in vmtruncate
 	*/
 	if (get_inode_item_key_version(inode) == KEY_FORMAT_3_5 &&
-	    attr->ia_size > MAX_NON_LFS)
-            return -EFBIG ;
-
+	    attr->ia_size > MAX_NON_LFS) {
+	    error = -EFBIG ;
+	    goto out;
+	}
 	/* fill in hole pointers in the expanding truncate case. */
         if (attr->ia_size > inode->i_size) {
 	    error = generic_cont_expand(inode, attr->ia_size) ;
@@ -114,20 +116,24 @@
 		journal_end(&th, inode->i_sb, 4) ;
 	    }
 	    if (error)
-	        return error ;
+	        goto out;
 	}
     }
 
     if ((((attr->ia_valid & ATTR_UID) && (attr->ia_uid & ~0xffff)) ||
 	 ((attr->ia_valid & ATTR_GID) && (attr->ia_gid & ~0xffff))) &&
-	(get_inode_sd_version (inode) == STAT_DATA_V1))
+	(get_inode_sd_version (inode) == STAT_DATA_V1)) {
 		/* stat data of format v3.5 has 16 bit uid and gid */
-	    return -EINVAL;
+	    error = -EINVAL;
+	    goto out;	
+	}
 
     error = inode_change_ok(inode, attr) ;
     if (!error)
         inode_setattr(inode, attr) ;
 
+out:
+    unlock_kernel();
     return error ;
 }
 
diff -ur linux-2.5.7-clean/fs/smbfs/inode.c linux/fs/smbfs/inode.c
--- linux-2.5.7-clean/fs/smbfs/inode.c	Tue Apr  2 10:43:22 2002
+++ linux/fs/smbfs/inode.c	Wed Apr  3 14:08:17 2002
@@ -621,6 +621,8 @@
 	int error, changed, refresh = 0;
 	struct smb_fattr fattr;
 
+	lock_kernel();
+
 	error = smb_revalidate_inode(dentry);
 	if (error)
 		goto out;
@@ -714,6 +716,7 @@
 out:
 	if (refresh)
 		smb_refresh_inode(dentry);
+	unlock_kernel();
 	return error;
 }
 
diff -ur linux-2.5.7-clean/fs/umsdos/inode.c linux/fs/umsdos/inode.c
--- linux-2.5.7-clean/fs/umsdos/inode.c	Tue Apr  2 10:43:23 2002
+++ linux/fs/umsdos/inode.c	Wed Apr  3 14:08:36 2002
@@ -165,6 +165,8 @@
 	struct dentry *temp, *old_dentry = NULL;
 	int ret;
 
+	lock_kernel();
+
 	ret = umsdos_parse (dentry->d_name.name, dentry->d_name.len,
 				&info);
 	if (ret)
@@ -216,6 +218,7 @@
 out:
 	if (old_dentry)
 		dput (dentry);	/* if we had to use fake dentry for hardlinks, dput() it now */
+	unlock_kernel();
 	return ret;
 }
 
diff -ur linux-2.5.7-clean/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-clean/include/linux/fs.h	Tue Apr  2 10:43:27 2002
+++ linux/include/linux/fs.h	Wed Apr  3 11:53:41 2002
@@ -426,6 +426,7 @@
 	unsigned long		i_blocks;
 	unsigned long		i_version;
 	struct semaphore	i_sem;
+	struct semaphore	i_attr_lock;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 	struct super_block	*i_sb;

--------------010404040209050007070904--

