Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSKXHvN>; Sun, 24 Nov 2002 02:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267181AbSKXHvM>; Sun, 24 Nov 2002 02:51:12 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:59332 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S267178AbSKXHvK>; Sun, 24 Nov 2002 02:51:10 -0500
Message-ID: <3DE07833.41A0CBF4@verizon.net>
Date: Sat, 23 Nov 2002 22:56:51 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, intermezzo-discuss@lists.sf.net,
       rread@clusterfs.com
Subject: intermezzo build errors (2.5.49)
Content-Type: multipart/mixed;
 boundary="------------6DF4CD57DA797B5480980F2F"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [4.64.197.173] at Sun, 24 Nov 2002 01:58:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6DF4CD57DA797B5480980F2F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

intermezzo has syntax errors in 2.5.49-plain,
mostly due to inode time field changes from time_t
to struct timespec.  Patches attached for your review.
These just use timespec.tv_sec in place of the previous
time_t fields, gaining no time resolution.  I thought
I should leave that decision up to you.

There is still one outstanding problem, which is in
vfs.c, where BLKDEV_FAIL() calls set_device_ro() with
the incorrect parameter type, which has changed from
kdev_t to struct block_device *.  Is it safe to just
kill this (debug) code?  Killing BLKDEV_FAIL() does
allow it to build successfully.

Thanks,
~Randy
--------------6DF4CD57DA797B5480980F2F
Content-Type: text/plain; charset=us-ascii;
 name="intmez-times-2549.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="intmez-times-2549.patch"

--- ./fs/intermezzo/file.c%intmez	Fri Nov 22 13:40:50 2002
+++ ./fs/intermezzo/file.c	Sat Nov 23 22:06:54 2002
@@ -61,7 +61,7 @@
 
 static int presto_open_upcall(int minor, struct dentry *de)
 {
-        int rc;
+        int rc = 0;
         char *path, *buffer;
         struct presto_file_set *fset;
         int pathlen;
@@ -291,7 +291,7 @@
                         return -EROFS;
                 }
         
-                fdata->fd_info.updated_time = file->f_dentry->d_inode->i_mtime;
+                fdata->fd_info.updated_time = file->f_dentry->d_inode->i_mtime.tv_sec;
                 rc = presto_do_close(fset, file); 
                 presto_put_permit(inode);
         }
--- ./fs/intermezzo/kml_reint.c%intmez	Fri Nov 22 13:40:58 2002
+++ ./fs/intermezzo/kml_reint.c	Sat Nov 23 22:16:56 2002
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
@@ -100,7 +101,7 @@
                 return 0;
         }
 
-        if (inode->i_mtime == a->pv_mtime &&
+        if (inode->i_mtime.tv_sec == a->pv_mtime &&
             (S_ISDIR(inode->i_mode) || inode->i_size == a->pv_size))
                 return 1;
 
@@ -126,8 +127,8 @@
                 struct iattr iattr;
 
                 iattr.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_SIZE;
-                iattr.ia_mtime = (time_t)rec->new_objectv->pv_mtime;
-                iattr.ia_ctime = (time_t)rec->new_objectv->pv_ctime;
+                iattr.ia_mtime.tv_sec = (time_t)rec->new_objectv->pv_mtime;
+                iattr.ia_ctime.tv_sec = (time_t)rec->new_objectv->pv_ctime;
                 iattr.ia_size = (time_t)rec->new_objectv->pv_size;
 
                 /* no kml record, but update last rcvd */
@@ -311,8 +312,8 @@
         iattr.ia_uid   = (uid_t)rec->uid;
         iattr.ia_gid   = (gid_t)rec->gid;
         iattr.ia_size  = (off_t)rec->size;
-        iattr.ia_ctime = (time_t)rec->ctime;
-        iattr.ia_mtime = (time_t)rec->mtime;
+        iattr.ia_ctime.tv_sec = (time_t)rec->ctime;
+        iattr.ia_mtime.tv_sec = (time_t)rec->mtime;
         iattr.ia_atime = iattr.ia_mtime; /* We don't track atimes. */
         iattr.ia_attr_flags = rec->flags;
 
--- ./fs/intermezzo/presto.c%intmez	Fri Nov 22 13:40:47 2002
+++ ./fs/intermezzo/presto.c	Sat Nov 23 22:18:24 2002
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/stat.h>
+#include <linux/time.h>
 #include <linux/errno.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
@@ -627,8 +628,8 @@
 void presto_getversion(struct presto_version * presto_version,
                        struct inode * inode)
 {
-        presto_version->pv_mtime = (__u64)inode->i_mtime;
-        presto_version->pv_ctime = (__u64)inode->i_ctime;
+        presto_version->pv_mtime = (__u64)inode->i_mtime.tv_sec;
+        presto_version->pv_ctime = (__u64)inode->i_ctime.tv_sec;
         presto_version->pv_size  = (__u64)inode->i_size;
 }
 
--- ./fs/intermezzo/vfs.c%intmez	Fri Nov 22 13:40:28 2002
+++ ./fs/intermezzo/vfs.c	Sat Nov 23 22:21:28 2002
@@ -67,6 +67,7 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/blk.h>
+#include <linux/time.h>
 
 #include <linux/intermezzo_fs.h>
 #include <linux/intermezzo_psdev.h>
@@ -237,8 +238,8 @@
                 return 0;
         }
 
-        iattr.ia_ctime = ctx->updated_time;
-        iattr.ia_mtime = ctx->updated_time;
+        iattr.ia_ctime.tv_sec = ctx->updated_time;
+        iattr.ia_mtime.tv_sec = ctx->updated_time;
         iattr.ia_valid = valid;
 
         while (1) {
@@ -475,7 +476,7 @@
                name, iattr->ia_valid, iattr->ia_mode, iattr->ia_uid,
                iattr->ia_gid, iattr->ia_size);
         CDEBUG(D_PIOCTL, "atime %#lx, mtime %#lx, ctime %#lx, attr_flags %#x\n",
-               iattr->ia_atime, iattr->ia_mtime.tv_sec, iattr->ia_ctime.tv_sec,
+               iattr->ia_atime.tv_sec, iattr->ia_mtime.tv_sec, iattr->ia_ctime.tv_sec,
                iattr->ia_attr_flags);
         CDEBUG(D_PIOCTL, "offset %d, recno %d, flags %#x\n",
                info->slot_offset, info->recno, info->flags);

--------------6DF4CD57DA797B5480980F2F--

