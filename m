Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbUCTPeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUCTPeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:34:18 -0500
Received: from [218.22.21.1] ([218.22.21.1]:18476 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S263447AbUCTPdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:33:35 -0500
Date: Sat, 20 Mar 2004 23:26:20 +0800 (CST)
From: Chen Yang <chyang@mail.ustc.edu.cn>
X-X-Sender: <chyang@mail>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] InterMezzo Maintenance Patch [resend]
Message-ID: <Pine.GSO.4.31L2A.0403202323130.10853-200000@mail>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; CHARSET=gb2312; BOUNDARY="----=_20040317115624_56019"
Content-ID: <Pine.GSO.4.31L2A.0403202323131.10853@mail>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------=_20040317115624_56019
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.31L2A.0403202323132.10853@mail>

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


------=_20040317115624_56019
Content-Type: TEXT/PLAIN; NAME="linux-2.6.5-rc1.patch"
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.GSO.4.31L2A.0403202323133.10853@mail>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="linux-2.6.5-rc1.patch"

diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/dir.c linux-2.6.5-rc1/fs/inter=
mezzo/dir.c=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/dir.c=092004-03-15 21:52:49.00000000=
0 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/dir.c=092004-03-16 22:26:24.000000000 +08=
00=0D
@@ -1300,13 +1300,9 @@=0D
                 return rc;=0D
         }=0D
=20=0D
-        case TCGETS:=0D
-                EXIT;=0D
-                return -EINVAL;=0D
-=0D
         default:=0D
                 EXIT;=0D
-                return -EINVAL;=0D
+                return -ENOTTY;=0D
                =20=0D
         }=0D
         EXIT;=0D
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/file.c linux-2.6.5-rc1/fs/inte=
rmezzo/file.c=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/file.c=092004-02-18 11:58:34.0000000=
00 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/file.c=092004-03-15 22:25:09.000000000 +0=
800=0D
@@ -217,9 +217,9 @@=0D
                 fdata->fd_mode =3D file->f_dentry->d_inode->i_mode;=0D
                 fdata->fd_uid =3D file->f_dentry->d_inode->i_uid;=0D
                 fdata->fd_gid =3D file->f_dentry->d_inode->i_gid;=0D
-                fdata->fd_ngroups =3D current->ngroups;=0D
-                for (i=3D0 ; i < current->ngroups ; i++)=0D
-                        fdata->fd_groups[i] =3D current->groups[i];=0D
+                fdata->fd_ngroups =3D current->group_info->ngroups;=0D
+                for (i=3D0 ; i < current->group_info->ngroups ; i++)=0D
+                        fdata->fd_groups[i] =3D GROUP_AT(current->group_in=
fo,i);=0D
                 if (!ISLENTO(minor))=20=0D
                         fdata->fd_info.flags =3D LENTO_FL_KML;=20=0D
                 else {=20=0D
diff --exclude=3D'*.cmd' --exclude=3D'*.o' -urN linux-2.6.5-rc1/fs/intermez=
zo.orig/fileset.c linux-2.6.5-rc1/fs/intermezzo/fileset.c=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/fileset.c=092004-02-18 11:57:24.0000=
00000 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/fileset.c=092004-03-15 22:29:48.000000000=
 +0800=0D
@@ -418,7 +418,7 @@=0D
         new.fsgid =3D 0;=0D
         new.fs =3D get_fs();=20=0D
         /* XXX where can we get the groups from? */=0D
-        new.ngroups =3D 0;=0D
+        new.group_info =3D groups_alloc(0);=0D
=20=0D
         push_ctxt(save, &new);=20=0D
 }=0D
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_fs.h linux-2.6.5-rc=
1/fs/intermezzo/intermezzo_fs.h=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_fs.h=092004-02-18 11:57:4=
5.000000000 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/intermezzo_fs.h=092004-03-16 00:10:20.000=
000000 +0800=0D
@@ -152,14 +152,14 @@=0D
         uid_t            fsuid;=0D
         gid_t            fsgid;=0D
         mm_segment_t     fs;=0D
-=09int              ngroups;=0D
-=09gid_t=09         groups[NGROUPS];=0D
+        struct group_info * group_info;=0D
+/*=09int              ngroups;=0D
+=09gid_t=09         groups[NGROUPS];*/=0D
=20=0D
 };=0D
=20=0D
 static inline void push_ctxt(struct run_ctxt *save, struct run_ctxt *new)=
=0D
 {=0D
-        int i;=0D
         save->fs =3D get_fs();=0D
         save->pwd =3D dget(current->fs->pwd);=0D
         save->pwdmnt =3D mntget(current->fs->pwdmnt);=0D
@@ -167,9 +167,10 @@=0D
         save->fsuid =3D current->fsuid;=0D
         save->root =3D current->fs->root;=0D
         save->rootmnt =3D current->fs->rootmnt;=0D
-        save->ngroups =3D current->ngroups;=0D
+        save->group_info =3D current->group_info;=0D
+/*      save->ngroups =3D current->ngroups;=0D
         for (i =3D 0; i< current->ngroups; i++)=20=0D
-                save->groups[i] =3D current->groups[i];=0D
+                save->groups[i] =3D current->groups[i];*/=0D
=20=0D
         set_fs(new->fs);=0D
         lock_kernel();=0D
@@ -179,18 +180,17 @@=0D
         unlock_kernel();=0D
         current->fsuid =3D new->fsuid;=0D
         current->fsgid =3D new->fsgid;=0D
-        if (new->ngroups > 0) {=0D
+        /*if (new->ngroups > 0) {=0D
                 current->ngroups =3D new->ngroups;=0D
                 for (i =3D 0; i< new->ngroups; i++)=20=0D
                         current->groups[i] =3D new->groups[i];=0D
-        }=0D
+        }*/=0D
+        current->group_info =3D new->group_info;=0D
        =20=0D
 }=0D
=20=0D
 static inline void pop_ctxt(struct run_ctxt *saved)=0D
 {=0D
-        int i;=0D
-=0D
         set_fs(saved->fs);=0D
         lock_kernel();=0D
         set_fs_pwd(current->fs, saved->pwdmnt, saved->pwd);=0D
@@ -199,10 +199,12 @@=0D
         unlock_kernel();=0D
         current->fsuid =3D saved->fsuid;=0D
         current->fsgid =3D saved->fsgid;=0D
+        current->group_info =3D saved->group_info;=0D
+/*=0D
         current->ngroups =3D saved->ngroups;=0D
         for (i =3D 0; i< saved->ngroups; i++)=20=0D
                 current->groups[i] =3D saved->groups[i];=0D
-=0D
+*/=0D
         mntput(saved->pwdmnt);=0D
         dput(saved->pwd);=0D
 }=0D
@@ -392,7 +394,7 @@=0D
         uid_t fd_fsuid;=0D
         gid_t fd_fsgid;=0D
         int fd_ngroups;=0D
-        gid_t fd_groups[NGROUPS_MAX];=0D
+        gid_t fd_groups[NGROUPS_SMALL];=0D
         /* information how to complete the close operation */=0D
         struct lento_vfs_context fd_info;=0D
         struct presto_version fd_version;=0D
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_kml.h linux-2.6.5-r=
c1/fs/intermezzo/intermezzo_kml.h=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/intermezzo_kml.h=092004-02-18 12:00:=
00.000000000 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/intermezzo_kml.h=092004-03-16 00:10:35.00=
0000000 +0800=0D
@@ -41,7 +41,7 @@=0D
         u32 fsgid;=0D
         u32 opcode;=0D
         u32 ngroups;=0D
-        u32 groups[NGROUPS_MAX];=0D
+        u32 groups[NGROUPS_SMALL];=0D
 };=0D
=20=0D
 enum kml_opcode {=0D
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/journal.c linux-2.6.5-rc1/fs/i=
ntermezzo/journal.c=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/journal.c=092004-02-18 11:57:12.0000=
00000 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/journal.c=092004-03-16 00:11:06.000000000=
 +0800=0D
@@ -309,7 +309,7 @@=0D
                                        __u32 fsuid, __u32 fsgid)=0D
 {=0D
         struct kml_prefix_hdr p;=0D
-        u32 loggroups[NGROUPS_MAX];=0D
+        u32 loggroups[NGROUPS_SMALL];=0D
=20=0D
         int i;=20=0D
=20=0D
@@ -332,15 +332,15 @@=0D
 static inline char *=0D
 journal_log_prefix(char *buf, int opcode, struct rec_info *rec)=0D
 {=0D
-        __u32 groups[NGROUPS_MAX];=20=0D
+        __u32 groups[NGROUPS_SMALL];=20=0D
         int i;=20=0D
=20=0D
         /* convert 16 bit gid's to 32 bit gid's */=0D
-        for (i=3D0; i<current->ngroups; i++)=20=0D
-                groups[i] =3D (__u32) current->groups[i];=0D
+        for (i=3D0; i<current->group_info->ngroups; i++)=20=0D
+                groups[i] =3D GROUP_AT(current->group_info,i);=0D
        =20=0D
         return journal_log_prefix_with_groups_and_ids(buf, opcode, rec,=0D
-                                                      (__u32)current->ngro=
ups,=0D
+                                                      (__u32)current->grou=
p_info->ngroups,=0D
                                                       groups,=0D
                                                       (__u32)current->fsui=
d,=0D
                                                       (__u32)current->fsgi=
d);=0D
@@ -1319,7 +1319,7 @@=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
         ino =3D cpu_to_le64(dentry->d_inode->i_ino);=0D
         generation =3D cpu_to_le32(dentry->d_inode->i_generation);=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + sizeof(*new_file_ver) +=0D
                 sizeof(ino) + sizeof(generation) + sizeof(pathlen) +=0D
                 sizeof(remote_ino) + sizeof(remote_generation) +=20=0D
@@ -1529,7 +1529,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + sizeof(*old_ver) +=0D
                 sizeof(valid) + sizeof(mode) + sizeof(uid) + sizeof(gid) +=
=0D
                 sizeof(fsize) + sizeof(mtime) + sizeof(ctime) + sizeof(fla=
gs) +=0D
@@ -1600,7 +1600,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + sizeof(pathlen) +=0D
                 size_round(le32_to_cpu(pathlen)) +=0D
                 sizeof(struct kml_suffix);=0D
@@ -1659,7 +1659,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(pathlen=
) +=0D
                 sizeof(struct kml_suffix);=0D
@@ -1715,7 +1715,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(uid) + sizeof(gid) + sizeof(pathlen) +=0D
                 sizeof(targetlen) + sizeof(struct kml_suffix);=0D
@@ -1773,7 +1773,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D sizeof(__u32) * current->ngroups +=20=0D
+        size =3D sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(pathlen=
) +=0D
                 sizeof(struct kml_suffix);=0D
@@ -1828,7 +1828,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dir, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(pathlen) + sizeof(llen) + sizeof(*rb) +=0D
                 sizeof(struct kml_suffix);=0D
@@ -1891,7 +1891,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dentry, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D sizeof(__u32) * current->ngroups +=20=0D
+        size =3D sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(lmode) + sizeof(uid) + sizeof(gid) + sizeof(lmajor)=
 +=0D
                 sizeof(lminor) + sizeof(pathlen) +=0D
@@ -1951,7 +1951,7 @@=0D
         BUFF_ALLOC(buffer, srcbuffer);=0D
         path =3D presto_path(tgt, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(srcpathlen) + sizeof(pathlen) +=0D
                 sizeof(struct kml_suffix);=0D
@@ -2009,7 +2009,7 @@=0D
         BUFF_ALLOC(buffer, srcbuffer);=0D
         path =3D presto_path(tgt, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 4 * sizeof(*src_dir_ver) +=
=0D
                 sizeof(srcpathlen) + sizeof(pathlen) +=0D
                 sizeof(struct kml_suffix);=0D
@@ -2069,7 +2069,7 @@=0D
         BUFF_ALLOC(buffer, NULL);=0D
         path =3D presto_path(dir, root, buffer, PAGE_SIZE);=0D
         pathlen =3D cpu_to_le32(MYPATHLEN(buffer, path));=0D
-        size =3D sizeof(__u32) * current->ngroups +=20=0D
+        size =3D sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) + 3 * sizeof(*tgt_dir_ver) +=
=0D
                 sizeof(pathlen) + sizeof(llen) + sizeof(*rb) +=0D
                 sizeof(old_targetlen) + sizeof(struct kml_suffix);=0D
@@ -2116,7 +2116,7 @@=0D
         __u32 open_fsuid;=0D
         __u32 open_fsgid;=0D
         __u32 open_ngroups;=0D
-        __u32 open_groups[NGROUPS_MAX];=0D
+        __u32 open_groups[NGROUPS_SMALL];=0D
         __u32 open_mode;=0D
         __u32 open_uid;=0D
         __u32 open_gid;=0D
@@ -2146,9 +2146,9 @@=0D
                 open_fsuid =3D fd->fd_fsuid;=0D
                 open_fsgid =3D fd->fd_fsgid;=0D
         } else {=0D
-                open_ngroups =3D current->ngroups;=0D
-                for (i=3D0; i<current->ngroups; i++)=0D
-                        open_groups[i] =3D  (__u32) current->groups[i];=20=
=0D
+                open_ngroups =3D current->group_info->ngroups;=0D
+                for (i=3D0; i<current->group_info->ngroups; i++)=0D
+                        open_groups[i] =3D  (__u32) GROUP_AT(current->grou=
p_info,i);=20=0D
                 open_mode =3D dentry->d_inode->i_mode;=0D
                 open_uid =3D dentry->d_inode->i_uid;=0D
                 open_gid =3D dentry->d_inode->i_gid;=0D
@@ -2246,7 +2246,7 @@=0D
 /* write closes for the local close records in the LML */=20=0D
 int presto_complete_lml(struct presto_file_set *fset)=0D
 {=0D
-        __u32 groups[NGROUPS_MAX];=0D
+        __u32 groups[NGROUPS_SMALL];=0D
         loff_t lml_offset;=0D
         loff_t read_offset;=20=0D
         char *buffer;=0D
@@ -2408,7 +2408,7 @@=0D
          */=0D
         mode=3Dcpu_to_le32(dentry->d_inode->i_mode);=0D
=20=0D
-        size =3D  sizeof(__u32) * current->ngroups +=20=0D
+        size =3D  sizeof(__u32) * current->group_info->ngroups +=20=0D
                 sizeof(struct kml_prefix_hdr) +=20=0D
                 2 * sizeof(struct presto_version) +=0D
                 sizeof(flags) + sizeof(mode) + sizeof(namelen) +=20=0D
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/kml_reint.c linux-2.6.5-rc1/fs=
/intermezzo/kml_reint.c=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/kml_reint.c=092004-02-18 11:59:20.00=
0000000 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/kml_reint.c=092004-03-16 00:08:48.0000000=
00 +0800=0D
@@ -53,11 +53,11 @@=0D
         ctxt.root =3D ctxt.pwd;=0D
         ctxt.rootmnt =3D ctxt.pwdmnt;=0D
         if (rec->prefix.hdr->ngroups > 0) {=0D
-                ctxt.ngroups =3D rec->prefix.hdr->ngroups;=0D
-                for (i =3D 0; i< ctxt.ngroups; i++)=20=0D
-                        ctxt.groups[i] =3D rec->prefix.groups[i];=0D
+                ctxt.group_info =3D groups_alloc(rec->prefix.hdr->ngroups)=
;=0D
+                for (i =3D 0; i< ctxt.group_info->ngroups; i++)=20=0D
+                        GROUP_AT(ctxt.group_info,i)=3D rec->prefix.groups[=
i];=0D
         } else=0D
-                ctxt.ngroups =3D 0;=0D
+                ctxt.group_info =3D groups_alloc(0);=0D
=20=0D
         push_ctxt(saved, &ctxt);=0D
 }=0D
diff -urN linux-2.6.5-rc1/fs/intermezzo.orig/vfs.c linux-2.6.5-rc1/fs/inter=
mezzo/vfs.c=0D
--- linux-2.6.5-rc1/fs/intermezzo.orig/vfs.c=092004-02-18 11:57:22.00000000=
0 +0800=0D
+++ linux-2.6.5-rc1/fs/intermezzo/vfs.c=092004-03-16 22:30:04.000000000 +08=
00=0D
@@ -965,8 +965,6 @@=0D
                 do_rcvd =3D presto_do_rcvd(info, dir);=0D
                 error =3D iops->unlink(dir->d_inode, dentry);=0D
                 unlock_kernel();=0D
-                if (!error)=0D
-                        d_delete(dentry);=0D
         }=0D
=20=0D
         if (linkno > 1) {=20=0D
@@ -988,10 +986,6 @@=0D
         }=0D
=20=0D
         //        up(&dir->d_inode->i_zombie);=0D
-        if (error) {=0D
-                EXIT;=0D
-                goto exit;=0D
-        }=0D
=20=0D
         presto_debug_fail_blkdev(fset, KML_OPCODE_UNLINK | 0x10);=0D
         if ( do_kml )=0D
@@ -1048,6 +1042,8 @@=0D
                 if (nd.last.name[nd.last.len])=0D
                         goto slashes;=0D
                 error =3D presto_do_unlink(fset, nd.dentry, dentry, info);=
=0D
+                if (!error)=0D
+                        d_delete(dentry);=0D
         exit2:=0D
                 EXIT;=0D
                 dput(dentry);=0D
--- linux-2.6.5-rc1/fs/Kconfig.orig=092004-03-15 21:52:48.000000000 +0800=
=0D
+++ linux-2.6.5-rc1/fs/Kconfig=092004-03-16 22:17:55.000000000 +0800=0D
@@ -1585,7 +1587,7 @@=0D
 #=0D
 config INTERMEZZO_FS=0D
 =09tristate "InterMezzo file system support (replicating fs) (EXPERIMENTAL=
)"=0D
-=09depends on INET && EXPERIMENTAL && BROKEN=0D
+=09depends on INET && EXPERIMENTAL=20=0D
 =09help=0D
 =09  InterMezzo is a networked file system with disconnected operation=0D
 =09  and kernel level write back caching.  It is most often used for=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=
=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00=00
------=_20040317115624_56019--
