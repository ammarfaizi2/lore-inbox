Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbUCTPGX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbUCTPGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:06:23 -0500
Received: from [218.22.21.1] ([218.22.21.1]:42767 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S263436AbUCTPFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:05:11 -0500
Message-ID: <001601c40e8b$5b1df730$0129a8c0@ccr.corp.intel.com>
From: "Yang, Chen" <chyang@clusterfs.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Yang, Chen" <chyang@clusterfs.com>
Subject: [PATCH] InterMezzo Maintenance Patch
Date: Sat, 20 Mar 2004 22:55:04 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C40ECE.627DF410"
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C40ECE.627DF410
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi, All:
   Below is the patch of InterMezzo against 2.6.5-rc1.
     I can confirm that it's effective.
     Main modification:
       Chen Yang's fix to work with NGROUPS
       Chen Yang's fix to handle file deletion
       Remove TCGETS handling and return  -ENOTTY for unknown ioctl code.
       Removed InterMezzo from BROKEN state
     Thanks.
--
    Yang, Chen
 
 
------=_NextPart_000_0013_01C40ECE.627DF410
Content-Type: application/octet-stream;
	name="linux-2.6.5-rc1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.6.5-rc1.patch"

diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/dir.c =
linux-2.6.5-rc1/fs/intermezzo/dir.c
--- linux-2.6.5-rc1/fs/intermezzo.orig/dir.c	2004-03-15 =
21:52:49.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/dir.c	2004-03-16 22:26:24.000000000 =
+0800
@@ -1300,13 +1300,9 @@
                 return rc;
         }
=20
-        case TCGETS:
-                EXIT;
-                return -EINVAL;
-
         default:
                 EXIT;
-                return -EINVAL;
+                return -ENOTTY;
                =20
         }
         EXIT;
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/file.c =
linux-2.6.5-rc1/fs/intermezzo/file.c
--- linux-2.6.5-rc1/fs/intermezzo.orig/file.c	2004-02-18 =
11:58:34.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/file.c	2004-03-15 22:25:09.000000000 =
+0800
@@ -217,9 +217,9 @@
                 fdata->fd_mode =3D file->f_dentry->d_inode->i_mode;
                 fdata->fd_uid =3D file->f_dentry->d_inode->i_uid;
                 fdata->fd_gid =3D file->f_dentry->d_inode->i_gid;
-                fdata->fd_ngroups =3D current->ngroups;
-                for (i=3D0 ; i < current->ngroups ; i++)
-                        fdata->fd_groups[i] =3D current->groups[i];
+                fdata->fd_ngroups =3D current->group_info->ngroups;
+                for (i=3D0 ; i < current->group_info->ngroups ; i++)
+                        fdata->fd_groups[i] =3D =
GROUP_AT(current->group_info,i);
                 if (!ISLENTO(minor))=20
                         fdata->fd_info.flags =3D LENTO_FL_KML;=20
                 else {=20
diff --exclude=3D'*.cmd' --exclude=3D'*.o' -urN =
linux-2.6.5-rc1/fs/intermezzo.orig/fileset.c =
linux-2.6.5-rc1/fs/intermezzo/fileset.c
--- linux-2.6.5-rc1/fs/intermezzo.orig/fileset.c	2004-02-18 =
11:57:24.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/fileset.c	2004-03-15 =
22:29:48.000000000 +0800
@@ -418,7 +418,7 @@
         new.fsgid =3D 0;
         new.fs =3D get_fs();=20
         /* XXX where can we get the groups from? */
-        new.ngroups =3D 0;
+        new.group_info =3D groups_alloc(0);
=20
         push_ctxt(save, &new);=20
 }
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_fs.h =
linux-2.6.5-rc1/fs/intermezzo/intermezzo_fs.h
--- linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_fs.h	2004-02-18 =
11:57:45.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/intermezzo_fs.h	2004-03-16 =
00:10:20.000000000 +0800
@@ -152,14 +152,14 @@
         uid_t            fsuid;
         gid_t            fsgid;
         mm_segment_t     fs;
-	int              ngroups;
-	gid_t	         groups[NGROUPS];
+        struct group_info * group_info;
+/*	int              ngroups;
+	gid_t	         groups[NGROUPS];*/
=20
 };
=20
 static inline void push_ctxt(struct run_ctxt *save, struct run_ctxt =
*new)
 {
-        int i;
         save->fs =3D get_fs();
         save->pwd =3D dget(current->fs->pwd);
         save->pwdmnt =3D mntget(current->fs->pwdmnt);
@@ -167,9 +167,10 @@
         save->fsuid =3D current->fsuid;
         save->root =3D current->fs->root;
         save->rootmnt =3D current->fs->rootmnt;
-        save->ngroups =3D current->ngroups;
+        save->group_info =3D current->group_info;
+/*      save->ngroups =3D current->ngroups;
         for (i =3D 0; i< current->ngroups; i++)=20
-                save->groups[i] =3D current->groups[i];
+                save->groups[i] =3D current->groups[i];*/
=20
         set_fs(new->fs);
         lock_kernel();
@@ -179,18 +180,17 @@
         unlock_kernel();
         current->fsuid =3D new->fsuid;
         current->fsgid =3D new->fsgid;
-        if (new->ngroups > 0) {
+        /*if (new->ngroups > 0) {
                 current->ngroups =3D new->ngroups;
                 for (i =3D 0; i< new->ngroups; i++)=20
                         current->groups[i] =3D new->groups[i];
-        }
+        }*/
+        current->group_info =3D new->group_info;
        =20
 }
=20
 static inline void pop_ctxt(struct run_ctxt *saved)
 {
-        int i;
-
         set_fs(saved->fs);
         lock_kernel();
         set_fs_pwd(current->fs, saved->pwdmnt, saved->pwd);
@@ -199,10 +199,12 @@
         unlock_kernel();
         current->fsuid =3D saved->fsuid;
         current->fsgid =3D saved->fsgid;
+        current->group_info =3D saved->group_info;
+/*
         current->ngroups =3D saved->ngroups;
         for (i =3D 0; i< saved->ngroups; i++)=20
                 current->groups[i] =3D saved->groups[i];
-
+*/
         mntput(saved->pwdmnt);
         dput(saved->pwd);
 }
@@ -392,7 +394,7 @@
         uid_t fd_fsuid;
         gid_t fd_fsgid;
         int fd_ngroups;
-        gid_t fd_groups[NGROUPS_MAX];
+        gid_t fd_groups[NGROUPS_SMALL];
         /* information how to complete the close operation */
         struct lento_vfs_context fd_info;
         struct presto_version fd_version;
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_kml.h =
linux-2.6.5-rc1/fs/intermezzo/intermezzo_kml.h
--- linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_kml.h	2004-02-18 =
12:00:00.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/intermezzo_kml.h	2004-03-16 =
00:10:35.000000000 +0800
@@ -41,7 +41,7 @@
         u32 fsgid;
         u32 opcode;
         u32 ngroups;
-        u32 groups[NGROUPS_MAX];
+        u32 groups[NGROUPS_SMALL];
 };
=20
 enum kml_opcode {
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/journal.c =
linux-2.6.5-rc1/fs/intermezzo/journal.c
--- linux-2.6.5-rc1/fs/intermezzo.orig/journal.c	2004-02-18 =
11:57:12.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/journal.c	2004-03-16 =
00:11:06.000000000 +0800
@@ -309,7 +309,7 @@
                                        __u32 fsuid, __u32 fsgid)
 {
         struct kml_prefix_hdr p;
-        u32 loggroups[NGROUPS_MAX];
+        u32 loggroups[NGROUPS_SMALL];
=20
         int i;=20
=20
@@ -332,15 +332,15 @@
 static inline char *
 journal_log_prefix(char *buf, int opcode, struct rec_info *rec)
 {
-        __u32 groups[NGROUPS_MAX];=20
+        __u32 groups[NGROUPS_SMALL];=20
         int i;=20
=20
         /* convert 16 bit gid's to 32 bit gid's */
-        for (i=3D0; i<current->ngroups; i++)=20
-                groups[i] =3D (__u32) current->groups[i];
+        for (i=3D0; i<current->group_info->ngroups; i++)=20
+                groups[i] =3D GROUP_AT(current->group_info,i);
        =20
         return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,
-                                                      =
(__u32)current->ngroups,
+                                                      =
(__u32)current->group_info->ngroups,
                                                       groups,
                                                       =
(__u32)current->fsuid,
                                                       =
(__u32)current->fsgid);
@@ -1319,7 +1319,7 @@
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
         ino =3D cpu_to_le64(dentry->d_inode->i_ino);
         generation =3D cpu_to_le32(dentry->d_inode->i_generation);
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + sizeof(*new_file_ver) +
                 sizeof(ino) + sizeof(generation) + sizeof(pathlen) +
                 sizeof(remote_ino) + sizeof(remote_generation) +=20
@@ -1529,7 +1529,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + sizeof(*old_ver) +
                 sizeof(valid) + sizeof(mode) + sizeof(uid) + =
sizeof(gid) +
                 sizeof(fsize) + sizeof(mtime) + sizeof(ctime) + =
sizeof(flags) +
@@ -1600,7 +1600,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + sizeof(pathlen) +
                 size_round(le32_to_cpu(pathlen)) +
                 sizeof(struct kml_suffix);
@@ -1659,7 +1659,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + =
sizeof(pathlen) +
                 sizeof(struct kml_suffix);
@@ -1715,7 +1715,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(uid) + sizeof(gid) + sizeof(pathlen) +
                 sizeof(targetlen) + sizeof(struct kml_suffix);
@@ -1773,7 +1773,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D sizeof(__u32) * current->ngroups +=20
+        size =3D sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + =
sizeof(pathlen) +
                 sizeof(struct kml_suffix);
@@ -1828,7 +1828,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dir, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(pathlen) + sizeof(llen) + sizeof(*rb) +
                 sizeof(struct kml_suffix);
@@ -1891,7 +1891,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D sizeof(__u32) * current->ngroups +=20
+        size =3D sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + =
sizeof(lmajor) +
                 sizeof(lminor) + sizeof(pathlen) +
@@ -1951,7 +1951,7 @@
         BUFF_ALLOC(buffer, srcbuffer);
         path =3D presto_path(tgt, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(srcpathlen) + sizeof(pathlen) +
                 sizeof(struct kml_suffix);
@@ -2009,7 +2009,7 @@
         BUFF_ALLOC(buffer, srcbuffer);
         path =3D presto_path(tgt, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 4 * =
sizeof(*src_dir_ver) +
                 sizeof(srcpathlen) + sizeof(pathlen) +
                 sizeof(struct kml_suffix);
@@ -2069,7 +2069,7 @@
         BUFF_ALLOC(buffer, NULL);
         path =3D presto_path(dir, root, buffer, PAGE_SIZE);
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));
-        size =3D sizeof(__u32) * current->ngroups +=20
+        size =3D sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) + 3 * =
sizeof(*tgt_dir_ver) +
                 sizeof(pathlen) + sizeof(llen) + sizeof(*rb) +
                 sizeof(old_targetlen) + sizeof(struct kml_suffix);
@@ -2116,7 +2116,7 @@
         __u32 open_fsuid;
         __u32 open_fsgid;
         __u32 open_ngroups;
-        __u32 open_groups[NGROUPS_MAX];
+        __u32 open_groups[NGROUPS_SMALL];
         __u32 open_mode;
         __u32 open_uid;
         __u32 open_gid;
@@ -2146,9 +2146,9 @@
                 open_fsuid =3D fd->fd_fsuid;
                 open_fsgid =3D fd->fd_fsgid;
         } else {
-                open_ngroups =3D current->ngroups;
-                for (i=3D0; i<current->ngroups; i++)
-                        open_groups[i] =3D  (__u32) current->groups[i]; =

+                open_ngroups =3D current->group_info->ngroups;
+                for (i=3D0; i<current->group_info->ngroups; i++)
+                        open_groups[i] =3D  (__u32) =
GROUP_AT(current->group_info,i);=20
                 open_mode =3D dentry->d_inode->i_mode;
                 open_uid =3D dentry->d_inode->i_uid;
                 open_gid =3D dentry->d_inode->i_gid;
@@ -2246,7 +2246,7 @@
 /* write closes for the local close records in the LML */=20
 int presto_complete_lml(struct presto_file_set *fset)
 {
-        __u32 groups[NGROUPS_MAX];
+        __u32 groups[NGROUPS_SMALL];
         loff_t lml_offset;
         loff_t read_offset;=20
         char *buffer;
@@ -2408,7 +2408,7 @@
          */
         mode=3Dcpu_to_le32(dentry->d_inode->i_mode);
=20
-        size =3D  sizeof(__u32) * current->ngroups +=20
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20
                 sizeof(struct kml_prefix_hdr) +=20
                 2 * sizeof(struct presto_version) +
                 sizeof(flags) + sizeof(mode) + sizeof(namelen) +=20
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/kml_reint.c =
linux-2.6.5-rc1/fs/intermezzo/kml_reint.c
--- linux-2.6.5-rc1/fs/intermezzo.orig/kml_reint.c	2004-02-18 =
11:59:20.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/kml_reint.c	2004-03-16 =
00:08:48.000000000 +0800
@@ -53,11 +53,11 @@
         ctxt.root =3D ctxt.pwd;
         ctxt.rootmnt =3D ctxt.pwdmnt;
         if (rec->prefix.hdr->ngroups > 0) {
-                ctxt.ngroups =3D rec->prefix.hdr->ngroups;
-                for (i =3D 0; i< ctxt.ngroups; i++)=20
-                        ctxt.groups[i] =3D rec->prefix.groups[i];
+                ctxt.group_info =3D =
groups_alloc(rec->prefix.hdr->ngroups);
+                for (i =3D 0; i< ctxt.group_info->ngroups; i++)=20
+                        GROUP_AT(ctxt.group_info,i)=3D =
rec->prefix.groups[i];
         } else
-                ctxt.ngroups =3D 0;
+                ctxt.group_info =3D groups_alloc(0);
=20
         push_ctxt(saved, &ctxt);
 }
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/vfs.c =
linux-2.6.5-rc1/fs/intermezzo/vfs.c
--- linux-2.6.5-rc1/fs/intermezzo.orig/vfs.c	2004-02-18 =
11:57:22.000000000 +0800
+++ linux-2.6.5-rc1/fs/intermezzo/vfs.c	2004-03-16 22:30:04.000000000 =
+0800
@@ -965,8 +965,6 @@
                 do_rcvd =3D presto_do_rcvd(info, dir);
                 error =3D iops->unlink(dir->d_inode, dentry);
                 unlock_kernel();
-                if (!error)
-                        d_delete(dentry);
         }
=20
         if (linkno > 1) {=20
@@ -988,10 +986,6 @@
         }
=20
         //        up(&dir->d_inode->i_zombie);
-        if (error) {
-                EXIT;
-                goto exit;
-        }
=20
         presto_debug_fail_blkdev(fset, KML_OPCODE_UNLINK | 0x10);
         if ( do_kml )
@@ -1048,6 +1042,8 @@
                 if (nd.last.name[nd.last.len])
                         goto slashes;
                 error =3D presto_do_unlink(fset, nd.dentry, dentry, =
info);
+                if (!error)
+                        d_delete(dentry);
         exit2:
                 EXIT;
                 dput(dentry);
--- linux-2.6.5-rc1/fs/Kconfig.orig	2004-03-15 21:52:48.000000000 +0800
+++ linux-2.6.5-rc1/fs/Kconfig	2004-03-16 22:17:55.000000000 +0800
@@ -1585,7 +1587,7 @@
 #
 config INTERMEZZO_FS
 	tristate "InterMezzo file system support (replicating fs) =
(EXPERIMENTAL)"
-	depends on INET && EXPERIMENTAL && BROKEN
+	depends on INET && EXPERIMENTAL=20
 	help
 	  InterMezzo is a networked file system with disconnected operation
 	  and kernel level write back caching.  It is most often used for
------=_NextPart_000_0013_01C40ECE.627DF410--

