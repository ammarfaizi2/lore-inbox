Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261625AbTCTScw>; Thu, 20 Mar 2003 13:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbTCTScw>; Thu, 20 Mar 2003 13:32:52 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:48149 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261625AbTCTScr>; Thu, 20 Mar 2003 13:32:47 -0500
Subject: [Patch] ext3_journal_stop inode access
From: "Stephen C. Tweedie" <sct@redhat.com>
To: ext3 users list <ext3-users@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Stephen Tweedie <sct@redhat.com>
Content-Type: multipart/mixed; boundary="=-0e94nh2C++iqyYzQECGt"
Organization: 
Message-Id: <1048185825.2491.386.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 20 Mar 2003 18:43:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0e94nh2C++iqyYzQECGt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

The patch below addresses the problem we were talking about earlier
where ext3_writepage ends up accessing the inode after the page lock has
been dropped (and hence at a point where it is possible for the inode to
have been reclaimed.)  Tested minimally (it builds and boots.)

It makes ext3_journal_stop take an sb, not an inode, as its final
parameter.  It also sets sb->s_need_sync_fs, not sb->s_dirt, as setting
s_dirt was only ever a workaround for the lack of a proper sync-fs
mechanism.

Btw, we clear s_need_sync_fs in sync_filesystems().  Don't we also need
to do the same in fsync_super()?

--Stephen


--=-0e94nh2C++iqyYzQECGt
Content-Disposition: inline; filename=01-journal_stop.patch
Content-Type: text/plain; name=01-journal_stop.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

>From 2.5 proposed diff to fix illegal access to inode in
ext3_journal_stop during writepage:

=3D=3D=3D=3D=3D fs/ext3/acl.c 1.6 vs edited =3D=3D=3D=3D=3D
--- 1.6/fs/ext3/acl.c	Tue Feb 25 16:21:08 2003
+++ edited/fs/ext3/acl.c	Thu Mar 20 17:18:19 2003
@@ -420,7 +420,7 @@
 			return PTR_ERR(handle);
 		}
 		error =3D ext3_set_acl(handle, inode, ACL_TYPE_ACCESS, clone);
-		ext3_journal_stop(handle, inode);
+		ext3_journal_stop(handle, inode->i_sb);
 	}
 	posix_acl_release(clone);
 	return error;
@@ -522,7 +522,7 @@
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 	error =3D ext3_set_acl(handle, inode, type, acl);
-	ext3_journal_stop(handle, inode);
+	ext3_journal_stop(handle, inode->i_sb);
=20
 release_and_out:
 	posix_acl_release(acl);
=3D=3D=3D=3D=3D fs/ext3/inode.c 1.63 vs edited =3D=3D=3D=3D=3D
--- 1.63/fs/ext3/inode.c	Mon Mar 17 06:33:16 2003
+++ edited/fs/ext3/inode.c	Thu Mar 20 17:19:55 2003
@@ -235,7 +235,7 @@
 		clear_inode(inode);
 	else
 		ext3_free_inode(handle, inode);
-	ext3_journal_stop(handle, inode);
+	ext3_journal_stop(handle, inode->i_sb);
 	unlock_kernel();
 	return;
 no_delete:
@@ -1107,7 +1107,7 @@
 	}
 prepare_write_failed:
 	if (ret)
-		ext3_journal_stop(handle, inode);
+		ext3_journal_stop(handle, inode->i_sb);
 out:
 	unlock_kernel();
 	return ret;
@@ -1176,7 +1176,7 @@
 		if (!ret)=20
 			ret =3D ret2;
 	}
-	ret2 =3D ext3_journal_stop(handle, inode);
+	ret2 =3D ext3_journal_stop(handle, inode->i_sb);
 	unlock_kernel();
 	if (!ret)
 		ret =3D ret2;
@@ -1299,6 +1299,7 @@
 static int ext3_writepage(struct page *page, struct writeback_control *wbc=
)
 {
 	struct inode *inode =3D page->mapping->host;
+	struct super_block *sb =3D inode->i_sb;
 	struct buffer_head *page_bufs;
 	handle_t *handle =3D NULL;
 	int ret =3D 0, err;
@@ -1374,7 +1375,7 @@
 				PAGE_CACHE_SIZE, NULL, bput_one);
 	}
=20
-	err =3D ext3_journal_stop(handle, inode);
+	err =3D ext3_journal_stop(handle, sb);
 	if (!ret)
 		ret =3D err;
 	unlock_kernel();
@@ -1479,7 +1480,7 @@
 					ret =3D err;
 			}
 		}
-		err =3D ext3_journal_stop(handle, inode);
+		err =3D ext3_journal_stop(handle, inode->i_sb);
 		if (ret =3D=3D 0)
 			ret =3D err;
 		unlock_kernel();
@@ -2140,7 +2141,7 @@
 	if (inode->i_nlink)
 		ext3_orphan_del(handle, inode);
=20
-	ext3_journal_stop(handle, inode);
+	ext3_journal_stop(handle, inode->i_sb);
 	unlock_kernel();
 }
=20
@@ -2560,7 +2561,7 @@
 		rc =3D ext3_mark_inode_dirty(handle, inode);
 		if (!error)
 			error =3D rc;
-		ext3_journal_stop(handle, inode);
+		ext3_journal_stop(handle, inode->i_sb);
 	}
 =09
 	rc =3D inode_setattr(inode, attr);
@@ -2737,7 +2738,7 @@
 				current_handle);
 		ext3_mark_inode_dirty(handle, inode);
 	}
-	ext3_journal_stop(handle, inode);
+	ext3_journal_stop(handle, inode->i_sb);
 out:
 	unlock_kernel();
 }
@@ -2818,7 +2819,7 @@
=20
 	err =3D ext3_mark_inode_dirty(handle, inode);
 	handle->h_sync =3D 1;
-	ext3_journal_stop(handle, inode);
+	ext3_journal_stop(handle, inode->i_sb);
 	ext3_std_error(inode->i_sb, err);
 =09
 	return err;
=3D=3D=3D=3D=3D fs/ext3/ioctl.c 1.7 vs edited =3D=3D=3D=3D=3D
--- 1.7/fs/ext3/ioctl.c	Mon Mar 17 06:33:16 2003
+++ edited/fs/ext3/ioctl.c	Thu Mar 20 17:18:18 2003
@@ -90,7 +90,7 @@
=20
 		err =3D ext3_mark_iloc_dirty(handle, inode, &iloc);
 flags_err:
-		ext3_journal_stop(handle, inode);
+		ext3_journal_stop(handle, inode->i_sb);
 		if (err)
 			return err;
 	=09
@@ -126,7 +126,7 @@
 		inode->i_generation =3D generation;
=20
 		err =3D ext3_mark_iloc_dirty(handle, inode, &iloc);
-		ext3_journal_stop(handle, inode);
+		ext3_journal_stop(handle, inode->i_sb);
 		return err;
 	}
 #ifdef CONFIG_JBD_DEBUG
=3D=3D=3D=3D=3D fs/ext3/namei.c 1.36 vs edited =3D=3D=3D=3D=3D
--- 1.36/fs/ext3/namei.c	Fri Feb 28 20:13:20 2003
+++ edited/fs/ext3/namei.c	Thu Mar 20 17:18:39 2003
@@ -1615,7 +1615,7 @@
 			inode->i_mapping->a_ops =3D &ext3_aops;
 		err =3D ext3_add_nondir(handle, dentry, inode);
 	}
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	unlock_kernel();
 	return err;
 }
@@ -1647,7 +1647,7 @@
 #endif
 		err =3D ext3_add_nondir(handle, dentry, inode);
 	}
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	unlock_kernel();
 	return err;
 }
@@ -1721,7 +1721,7 @@
 	ext3_mark_inode_dirty(handle, dir);
 	d_instantiate(dentry, inode);
 out_stop:
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	unlock_kernel();
 	return err;
 }
@@ -1994,7 +1994,7 @@
 	ext3_mark_inode_dirty(handle, dir);
=20
 end_rmdir:
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	brelse (bh);
 	unlock_kernel();
 	return retval;
@@ -2050,7 +2050,7 @@
 	retval =3D 0;
=20
 end_unlink:
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	unlock_kernel();
 	brelse (bh);
 	return retval;
@@ -2109,7 +2109,7 @@
 	EXT3_I(inode)->i_disksize =3D inode->i_size;
 	err =3D ext3_add_nondir(handle, dentry, inode);
 out_stop:
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	unlock_kernel();
 	return err;
 }
@@ -2142,7 +2142,7 @@
 	atomic_inc(&inode->i_count);
=20
 	err =3D ext3_add_nondir(handle, dentry, inode);
-	ext3_journal_stop(handle, dir);
+	ext3_journal_stop(handle, dir->i_sb);
 	unlock_kernel();
 	return err;
 }
@@ -2299,7 +2299,7 @@
 	brelse (dir_bh);
 	brelse (old_bh);
 	brelse (new_bh);
-	ext3_journal_stop(handle, old_dir);
+	ext3_journal_stop(handle, old_dir->i_sb);
 	unlock_kernel();
 	return retval;
 }
=3D=3D=3D=3D=3D fs/ext3/super.c 1.53 vs edited =3D=3D=3D=3D=3D
--- 1.53/fs/ext3/super.c	Tue Mar 11 06:34:32 2003
+++ edited/fs/ext3/super.c	Thu Mar 20 11:01:35 2003
@@ -1735,7 +1735,7 @@
 	tid_t target;
=20
 	lock_kernel();=09
-	sb->s_dirt =3D 0;
+	sb->s_need_sync_fs =3D 0;
 	target =3D log_start_commit(EXT3_SB(sb)->s_journal, NULL);
 	if (wait)
 		log_wait_commit(EXT3_SB(sb)->s_journal, target);
=3D=3D=3D=3D=3D fs/ext3/xattr.c 1.11 vs edited =3D=3D=3D=3D=3D
--- 1.11/fs/ext3/xattr.c	Sat Mar  8 22:50:42 2003
+++ edited/fs/ext3/xattr.c	Thu Mar 20 17:18:38 2003
@@ -854,7 +854,7 @@
 	else
 		error =3D ext3_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
-	error2 =3D ext3_journal_stop(handle, inode);
+	error2 =3D ext3_journal_stop(handle, inode->i_sb);
 	unlock_kernel();
=20
 	return error ? error : error2;
=3D=3D=3D=3D=3D include/linux/ext3_jbd.h 1.9 vs edited =3D=3D=3D=3D=3D
--- 1.9/include/linux/ext3_jbd.h	Tue Feb 11 03:20:37 2003
+++ edited/include/linux/ext3_jbd.h	Thu Mar 20 17:13:18 2003
@@ -217,20 +217,21 @@
  * appropriate.=20
  */
 static inline int __ext3_journal_stop(const char *where,
-				      handle_t *handle, struct inode *inode)
+				      handle_t *handle,=20
+				      struct super_block *sb)
 {
 	int err =3D handle->h_err;
 	int rc =3D journal_stop(handle);
=20
-	inode->i_sb->s_dirt =3D 1;
+	sb->s_need_sync_fs =3D 1;
 	if (!err)
 		err =3D rc;
 	if (err)
-		__ext3_std_error(inode->i_sb, where, err);
+		__ext3_std_error(sb, where, err);
 	return err;
 }
-#define ext3_journal_stop(handle, inode) \
-	__ext3_journal_stop(__FUNCTION__, (handle), (inode))
+#define ext3_journal_stop(handle, sb) \
+	__ext3_journal_stop(__FUNCTION__, (handle), (sb))
=20
 static inline handle_t *ext3_journal_current_handle(void)
 {

--=-0e94nh2C++iqyYzQECGt--
