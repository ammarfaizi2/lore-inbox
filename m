Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUKGHI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUKGHI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 02:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUKGHI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 02:08:56 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:60883 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261550AbUKGHGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 02:06:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=QtKE0VdNEi/ZKxTjIsDUOUlLLX94RrZX/0n2PyfL+Z1jepL+fpJ9p8o+vzX1XzWtzV8cuRqbp8+yyB0BnHrSu5Fc6grovTPwHBuO14m8BNkKZfsu2eOiNSm3kG5gcGLKqDBqQaOJpTpdKK12KpP0jBoWypOqwAAY4T68zLrYMfw=
Message-ID: <aad1205e0411062306690c21f8@mail.gmail.com>
Date: Sun, 7 Nov 2004 15:06:38 +0800
From: andyliu <liudeyan@gmail.com>
Reply-To: andyliu <liudeyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
Cc: akpm@osdl.org, kernel@kolivas.org
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3569_25513921.1099811198838"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3569_25513921.1099811198838
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi

  let's think about the way we access the file which contained in a tar file
may we can untar the whole thing and we find the file we want to access
or we can use the t option with tar to list all the files in the tar
and then untar the only one file we want to access.

  but with the help of the tarfs,we can mount a tar file to some dir and access
it easily and quickly.it's like the tarfs in mc.

 just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
then access the files easily.

it was writen by Kazuto Miyoshi (kaz@earth.email.ne.jp) Hirokazu
Takahashi (h-takaha@mub.biglobe.ne.jp) for linux 2.4.0

and i make it work for linux 2.6.0. now a patch for linux 2.6.10-rc1-mm3

the patch is to big to send it as plain text, so i can only send it as
an attachment

thanks
-- 
Yours andyliu

------=_Part_3569_25513921.1099811198838
Content-Type: text/plain; name="tarfs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="tarfs.patch"

diff -urN linux-2.6.10-rc1/fs/Kconfig linux-2.6.10-rc1-tarfs/fs/Kconfig
--- linux-2.6.10-rc1/fs/Kconfig=092004-11-06 14:49:07.000000000 +0800
+++ linux-2.6.10-rc1-tarfs/fs/Kconfig=092004-11-06 12:29:23.000000000 +0800
@@ -1007,6 +1007,12 @@
=20
 =09  To compile this as a module, choose M here: the module will be called
 =09  ramfs.
+=09
+config TAR_FS
+=09tristate "Tar fs support"
+=09help
+=09  tarfs can help you mount a .tar file. then you can access the files i=
n the
+=09  tar easily.
=20
 endmenu
=20
diff -urN linux-2.6.10-rc1/fs/Makefile linux-2.6.10-rc1-tarfs/fs/Makefile
--- linux-2.6.10-rc1/fs/Makefile=092004-11-06 14:49:07.000000000 +0800
+++ linux-2.6.10-rc1-tarfs/fs/Makefile=092004-11-06 12:23:54.000000000 +080=
0
@@ -97,3 +97,4 @@
 obj-$(CONFIG_HOSTFS)=09=09+=3D hostfs/
 obj-$(CONFIG_HPPFS)=09=09+=3D hppfs/
 obj-$(CONFIG_CACHEFS)=09=09+=3D cachefs/
+obj-$(CONFIG_TAR_FS)=09=09+=3D tarfs/
diff -urN linux-2.6.10-rc1/fs/tarfs/dir.c linux-2.6.10-rc1-tarfs/fs/tarfs/d=
ir.c
--- linux-2.6.10-rc1/fs/tarfs/dir.c=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/dir.c=092004-11-06 12:17:19.000000000 +=
0800
@@ -0,0 +1,99 @@
+/*
+ *  tarfs/dir.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: dir.c,v 1.9 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *
+ */
+
+#include <linux/fs.h>
+
+#include "tarfs.h"
+
+static int tarfs_readdir(struct file * filp,
+=09=09=09 void * dirent, filldir_t filldir)
+{
+  struct inode *inode =3D filp->f_dentry->d_inode;
+  int err;
+  struct tarent *dir_tarent, *ent;
+  int dtype=3D0;
+  int count, stored;
+
+  dir_tarent =3D TARENT(inode);
+
+  message("tarfs: tarfs_readdir (dir_tarent %p, f_pos %ld)\n",
+=09  dir_tarent, (long)filp->f_pos);
+
+  stored=3D0; =20
+
+  /* entry 0: dot */
+  if (filp->f_pos=3D=3D0){
+    err =3D filldir(dirent, ".", 1,
+=09=09  filp->f_pos, inode->i_ino, DT_DIR);
+    filp->f_pos++;
+    stored=3D1;
+    goto out;
+  }
+
+  /* entry 1: dot dot */
+  if (filp->f_pos=3D=3D1){
+    err =3D filldir(dirent, "..", 2,
+=09=09  filp->f_pos, dir_tarent->parent->ino, DT_DIR);
+    filp->f_pos++;
+    stored=3D1;
+    goto out;
+  }
+
+  /* . and .. is already read, we start count from 2 */
+  ent=3Ddir_tarent->children;
+  for(count=3D2; count<filp->f_pos && ent!=3D0; count++){
+    ent=3Dent->neighbors;
+  }
+ =20
+  if (ent=3D=3D0)
+    goto out;
+
+  for(; ent!=3D0; ent=3Dent->neighbors){
+    if (S_ISDIR(ent->mode))
+      dtype=3DDT_DIR;
+    else if (S_ISREG(ent->mode))
+      dtype=3DDT_REG;
+
+    message("tarfs: tarfs_readdir : adding %s\n", ent->name);
+    err =3D filldir(dirent, ent->name, strlen(ent->name),
+=09=09filp->f_pos, ent->ino, dtype);
+    if (err)
+      goto out;
+
+    stored++;
+    filp->f_pos++;
+  }
+
+ out:
+  message("tarfs: tarfs_readdir() done\n");
+  return stored;
+}
+
+struct file_operations tarfs_dir_operations =3D {
+=09read:=09=09generic_read_dir,=09/* just put error */
+=09readdir:=09tarfs_readdir,
+};
diff -urN linux-2.6.10-rc1/fs/tarfs/file.c linux-2.6.10-rc1-tarfs/fs/tarfs/=
file.c
--- linux-2.6.10-rc1/fs/tarfs/file.c=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/file.c=092004-11-06 12:15:25.000000000 =
+0800
@@ -0,0 +1,75 @@
+/*
+ *  tarfs/file.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: file.c,v 1.8 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *
+ */
+
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include "tarfs.h"
+
+static loff_t tarfs_file_lseek(
+=09struct file *file,
+=09loff_t offset,
+=09int origin)
+{
+=09static int event;
+=09struct inode *inode =3D file->f_dentry->d_inode;
+
+=09switch (origin) {
+=09=09case 2:
+=09=09=09offset +=3D inode->i_size;
+=09=09=09break;
+=09=09case 1:
+=09=09=09offset +=3D file->f_pos;
+=09}
+=09if (offset<0)
+=09=09return -EINVAL;
+=09if (((unsigned long long) offset >> 32) !=3D 0) {
+=09=09if (offset > TARFS_MAX_SIZE)
+=09=09=09return -EINVAL;
+=09}=20
+=09if (offset !=3D file->f_pos) {
+=09=09file->f_pos =3D offset;
+=09=09//file->f_reada =3D 0;
+=09=09file->f_version =3D ++event;
+=09}
+=09return offset;
+}
+
+static int tarfs_open_file (struct inode * inode, struct file * filp)
+{
+=09if (!(filp->f_flags & O_LARGEFILE) &&
+=09    inode->i_size > TARFS_MAX_SIZE)
+=09=09return -EFBIG;
+=09return 0;
+}
+
+struct file_operations tarfs_file_operations =3D {
+=09llseek:=09=09tarfs_file_lseek,
+=09read:=09=09generic_file_read,
+=09mmap:=09=09generic_file_mmap,
+=09open:=09=09tarfs_open_file,
+};
+
diff -urN linux-2.6.10-rc1/fs/tarfs/inode.c linux-2.6.10-rc1-tarfs/fs/tarfs=
/inode.c
--- linux-2.6.10-rc1/fs/tarfs/inode.c=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/inode.c=092004-11-06 12:16:10.000000000=
 +0800
@@ -0,0 +1,123 @@
+/*=20
+ * tarfs/inode.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: inode.c,v 1.13 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *=20
+ */
+
+#include <linux/fs.h>
+#include <linux/buffer_head.h>
+
+#include "tarfs.h"
+
+extern struct address_space_operations tarfs_aops;
+extern struct inode_operations tarfs_symlink_inode_operations;
+void tarfs_read_inode (struct inode * inode)
+{
+  struct tarent *ent;
+
+  printk("tarfs: tarfs_read_inode(ino=3D%ld)\n", inode->i_ino);
+
+  ent=3Dlookup_tarent(inode->i_sb, inode->i_ino);
+  if (!ent)
+    goto err_out;
+
+  inode->i_mode =3D ent->mode;
+  message("tarfs: tarfs_read_inode() -> mode %d\n", inode->i_mode);
+  inode->i_uid =3D ent->uid;
+  inode->i_gid =3D ent->gid;
+  inode->i_nlink =3D ent->nlink;
+  inode->i_size =3D ent->size;
+  inode->i_atime.tv_sec =3D ent->atime;
+  inode->i_ctime.tv_sec =3D ent->ctime;
+  inode->i_mtime.tv_sec =3D ent->mtime;
+  TARENT(inode) =3D ent;
+ =20
+  if (S_ISREG(inode->i_mode)) {
+    inode->i_fop =3D &tarfs_file_operations;
+    inode->i_mapping->a_ops =3D &tarfs_aops;
+  } else if (S_ISDIR(inode->i_mode)) {
+    inode->i_op =3D &tarfs_dir_inode_operations;
+    inode->i_fop =3D &tarfs_dir_operations;
+  } else if (S_ISLNK(inode->i_mode)) {
+    inode->i_op =3D &tarfs_symlink_inode_operations;
+  } else {
+    /* XXX: dev, fifo, contype etc. */
+    error("tarfs: unsupported file type (i_mode=3D%d)\n", inode->i_mode);
+  }
+
+  return;
+
+ err_out:
+    make_bad_inode(inode);
+    return;
+}
+
+/*
+ * Getblock for tarfs
+ */
+static int tarfs_get_block(struct inode *inode, sector_t iblock, struct bu=
ffer_head *bh_result, int create)
+{
+  if (create){
+    printk("Can not create file on tarfs\n");
+    return -EIO;
+  }
+
+  //bh_result->b_bdev =3D inode->i_bdev;
+  //bh_result->b_blocknr =3D TARENT(inode)->pos + iblock;
+  //bh_result->b_state |=3D (1UL << BH_Mapped);
+  map_bh(bh_result, inode->i_sb, TARENT(inode)->pos + iblock);
+
+  return 0;
+}
+
+/*
+ * Read and fill a page.
+ */
+int tarfs_readpage(struct file *file, struct page *page)
+{
+  printk("tarfs_readpage\n");
+  return block_read_full_page(page, tarfs_get_block);
+}
+
+struct address_space_operations tarfs_aops =3D {
+=09readpage:  tarfs_readpage,
+};
+
+/* symlinks */
+static int tarfs_readlink(struct dentry *dentry, char *buffer, int buflen)
+{
+  char *s =3D (char *)TARENT(dentry->d_inode)->linkname;
+  return vfs_readlink(dentry, buffer, buflen, s);
+}
+
+static int tarfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+  char *s =3D (char *)TARENT(dentry->d_inode)->linkname;
+  return vfs_follow_link(nd, s);
+}
+
+struct inode_operations tarfs_symlink_inode_operations =3D {
+=09readlink:  tarfs_readlink,
+=09follow_link:=09tarfs_follow_link,
+};
diff -urN linux-2.6.10-rc1/fs/tarfs/Makefile linux-2.6.10-rc1-tarfs/fs/tarf=
s/Makefile
--- linux-2.6.10-rc1/fs/tarfs/Makefile=091970-01-01 07:00:00.000000000 +070=
0
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/Makefile=092004-11-06 12:02:26.00000000=
0 +0800
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux tarfs-filesystem routines.
+#
+#
+
+obj-$(CONFIG_TAR_FS) +=3D tarfs.o
+
+tarfs-y  :=3D dir.o file.o inode.o namei.o super.o tarent.o
diff -urN linux-2.6.10-rc1/fs/tarfs/namei.c linux-2.6.10-rc1-tarfs/fs/tarfs=
/namei.c
--- linux-2.6.10-rc1/fs/tarfs/namei.c=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/namei.c=092004-11-06 12:15:24.000000000=
 +0800
@@ -0,0 +1,52 @@
+/*
+ *  tarfs/namei.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: namei.c,v 1.8 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *
+ */
+
+#include <linux/fs.h>
+#include "tarfs.h"
+
+static struct dentry *tarfs_lookup(struct inode * dir, struct dentry *dent=
ry)
+{
+  struct tarent *ent;
+
+  message("tarfs: tarfs_lookup()\n");
+
+  for(ent=3DTARENT(dir)->children; ent!=3D0; ent=3Dent->neighbors){
+    if (!strcmp(ent->name, dentry->d_name.name)){
+      d_add(dentry, iget(dir->i_sb, ent->ino));
+      goto out;
+    }
+  }
+  d_add(dentry, NULL);
+
+ out:
+  return NULL;
+}
+
+struct inode_operations tarfs_dir_inode_operations =3D {
+  lookup:=09tarfs_lookup,
+};
+
diff -urN linux-2.6.10-rc1/fs/tarfs/README linux-2.6.10-rc1-tarfs/fs/tarfs/=
README
--- linux-2.6.10-rc1/fs/tarfs/README=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/README=092004-11-06 12:04:37.000000000 =
+0800
@@ -0,0 +1,10 @@
+tarfs was writen by =20
+Kazuto Miyoshi (kaz@earth.email.ne.jp)
+Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+
+in 2001 for linux 2.4.0
+
+and I port it to run on Linux 2.6.* in 2004
+
+deyan liu  liudeyan@gmail.com
+=20
diff -urN linux-2.6.10-rc1/fs/tarfs/super.c linux-2.6.10-rc1-tarfs/fs/tarfs=
/super.c
--- linux-2.6.10-rc1/fs/tarfs/super.c=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/super.c=092004-11-06 14:14:32.000000000=
 +0800
@@ -0,0 +1,215 @@
+/*
+ *  tarfs/super.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: super.c,v 1.18 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *
+ */
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/statfs.h>
+#include <linux/buffer_head.h>
+
+#include "tarfs.h"
+
+void tarfs_put_super (struct super_block * sb)
+{
+
+  printk("tarfs : tarfs_put_super\n");
+
+
+  /* Drop all tarent hash table */
+  delete_all_tarents_and_hash(sb);
+
+  /* Drop fs dependent sb data */
+  if (TARSB(sb)){
+    kfree(TARSB(sb));
+  }
+}
+
+int tarfs_statfs (struct super_block * sb, struct kstatfs * buf)
+{
+  message("tarfs : tarfs_statfs\n");
+
+  buf->f_type =3D TARFS_SUPER_MAGIC;
+  buf->f_bsize =3D sb->s_blocksize;
+  buf->f_blocks =3D TARSB(sb)->s_files;
+  buf->f_bfree =3D 0;
+  buf->f_bavail =3D 0;
+  buf->f_files =3D TARSB(sb)->s_files;
+  buf->f_ffree =3D 0;
+  buf->f_namelen =3D TARFS_NAME_LEN;
+  return 0;
+}
+
+int tarfs_remount (struct super_block * sb, int * flags, char * data)
+{
+  message("tarfs : tarfs_remount\n");
+ =20
+  if (!(*flags & MS_RDONLY)){
+    /* Remount as RDWR */
+    return -EINVAL;
+  }
+
+  return 0;
+}
+
+static int check_magic(struct super_block *sb)
+{
+  struct buffer_head *bh;
+  struct posix_header *ph;
+  extern int allow_v7_format;
+  int ok=3D0;
+
+  if (allow_v7_format){
+    /* Dangerous when corrupted/non-tar file is specified. */
+    return 1;
+  }
+
+  bh =3D sb_bread(sb, 0);
+  if (!bh)
+    return 0;
+
+  ph =3D (struct posix_header*)((char *)bh->b_data);
+  message("magic %s\n", ph->magic);
+  ok =3D !strncmp(ph->magic, "ustar", 5);
+  brelse(bh);
+
+  return ok;
+}
+
+
+extern struct super_operations tarfs_sops;
+
+static int tarfs_fill_super(struct super_block *sb, void *data, int silent=
)
+{
+
+  sb_set_blocksize(sb, TAR_BLOCKSIZE);
+
+  printk("tarfs: tarfs_fill_super()\n");
+  message("tarfs: mount flags: %ld\n", sb->s_flags);
+  //sb->s_blocksize_bits =3D 9; /* Log2(TAR_BLOCKSIZE) */
+  //sb->s_blocksize =3D TAR_BLOCKSIZE;
+
+  if (!check_magic(sb)){
+    printk("tarfs: Not a tar file, or old v7 format\n");
+    goto err_out;
+  }
+
+  /* Alloc tarfs dependent data */
+  TARSB(sb) =3D kmalloc(sizeof(struct tarfs_sb_info), GFP_KERNEL);
+  if (!TARSB(sb)){
+    printk("tarfs: Can not allocate fs dependent sb data\n");
+    goto err_out;
+  }
+
+  TARSB(sb)->parsed=3D0;
+  TARSB(sb)->ihash=3D(struct tarent**)
+    kmalloc(sizeof(struct tarent *[TARENT_HASHSIZE]), GFP_KERNEL);
+  if (!TARSB(sb)->ihash)
+    goto err_out;
+  memset(TARSB(sb)->ihash, 0, sizeof(struct tarent *[TARENT_HASHSIZE]));
+
+  TARSB(sb)->s_files=3D0;
+  TARSB(sb)->s_blocks=3D0;
+  TARSB(sb)->s_maxino=3D1;
+
+  sb->s_op =3D &tarfs_sops;
+  sb->s_root =3D d_alloc_root(iget(sb, TARFS_ROOT_INO));
+  if (!sb->s_root) {
+    goto err_out;
+  }
+ =20
+  /* Read-only fs */
+  sb->s_flags =3D MS_RDONLY;
+  sb->s_dirt =3D 0;
+  return 0;
+ =20
+ err_out:
+  if (TARSB(sb) && TARSB(sb)->ihash){
+    kfree(TARSB(sb)->ihash);
+  }
+  if (TARSB(sb)){
+    kfree(TARSB(sb));
+  }
+  printk("tarfs:fillsuper error\n");
+  return 1;
+}
+
+static struct super_block * tarfs_get_super (struct file_system_type * fs_=
type,=20
+=09int flags, const char *dev_name, void * data)
+{
+=09return get_sb_bdev(fs_type, flags, dev_name, data, tarfs_fill_super);
+}
+
+extern void tarfs_read_inode (struct inode * inode);
+extern void tarfs_write_inode (struct inode * inode, int wait);
+extern void tarfs_put_inode (struct inode * inode);
+extern void tarfs_delete_inode (struct inode * inode);
+extern void tarfs_truncate (struct inode * inode);
+
+static struct super_operations tarfs_sops =3D {
+=09read_inode:=09tarfs_read_inode,
+=09put_super:=09tarfs_put_super,
+=09statfs:=09=09tarfs_statfs,
+=09remount_fs:=09tarfs_remount,
+};
+
+//static DECLARE_FSTYPE_DEV(tar_fs_type, "tarfs", tarfs_read_super);
+
+static struct file_system_type tar_fs_type =3D {
+=09owner: =09=09 THIS_MODULE,
+=09name:=09=09 "tarfs",
+=09get_sb:=09=09 tarfs_get_super,
+=09kill_sb:=09kill_block_super,
+=09fs_flags:=09        FS_REQUIRES_DEV,
+};
+
+/* Implemented as module */
+
+MODULE_DESCRIPTION("Linux 2.4 Design & Implementation sample module");
+MODULE_AUTHOR("Linux Japan magazine");
+
+int tarfs_debug=3D0;
+int allow_v7_format=3D0;
+MODULE_PARM(tarfs_debug, "i");
+MODULE_PARM_DESC(debug, "Tarfs debug output flag");
+MODULE_PARM(allow_v7_format, "i");
+MODULE_PARM_DESC(allow_v7_format, "Allow v7 format (no magic check)");
+
+static int __init init_tar_fs(void)
+{
+  printk(KERN_INFO "tarfs: init_tar_fs (debug=3D%d)\n", tarfs_debug);
+  return register_filesystem(&tar_fs_type);
+}
+
+static void __exit exit_tar_fs(void)
+{
+  printk(KERN_INFO "tarfs: exit_tar_fs\n");
+  unregister_filesystem(&tar_fs_type);
+}
+
+//EXPORT_NO_SYMBOLS;
+
+module_init(init_tar_fs)
+module_exit(exit_tar_fs)
diff -urN linux-2.6.10-rc1/fs/tarfs/tarent.c linux-2.6.10-rc1-tarfs/fs/tarf=
s/tarent.c
--- linux-2.6.10-rc1/fs/tarfs/tarent.c=091970-01-01 07:00:00.000000000 +070=
0
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/tarent.c=092004-11-06 12:16:32.00000000=
0 +0800
@@ -0,0 +1,608 @@
+/*
+ *  tarfs/tarent.c
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: tarent.c,v 1.18 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *=20
+ */
+
+#include <linux/fs.h>
+#include <linux/ctype.h>
+#include <asm/current.h>
+#include <linux/buffer_head.h>
+
+#include "tarfs.h"
+
+/*=20
+ * Octal strtoul for tarfs.
+ * tar size, mtime, etc. sometimes NOT null terminated.
+ */
+static unsigned long getval8(char *p, size_t siz)
+{
+  char buf[512];
+  unsigned long val;
+  int i;
+
+  if (siz>512 || siz <=3D0){
+    error("tarfs: zero or too long siz for getval8\n");
+  }
+ =20
+  for(i=3D0; i<siz; i++){
+    if (!isspace(p[i]))=09/* '\0' is control character */
+      break;
+  }
+
+  memcpy(buf, p+i, siz-i);
+  buf[siz-i]=3D'\0';
+
+  val=3Dsimple_strtoul(buf, NULL, 8);
+  message("getval8 [%s] %ld\n", buf, val);
+
+  return val;
+}
+
+/*
+ * Feed a new ino
+ */
+static unsigned long get_new_ino(struct super_block *sb)
+{
+  message("tarfs: feeding ino %ld\n", TARSB(sb)->s_maxino);
+  return ++(TARSB(sb)->s_maxino);
+}
+
+/*
+ * Add tarent to hash table
+ */
+static void hash_tarent(struct super_block *sb, struct tarent *t, unsigned=
 long ino)
+{
+  struct tarent **tentp =3D TARSB(sb)->ihash+ino%TARENT_HASHSIZE;
+
+  /*
+   * Adding prior to the exiting entries.
+   * Duplicated entries are hidden by the new one.
+   */
+  t->next_hash =3D *tentp;
+  *tentp =3D t;
+}
+
+/*
+ * Lookup tarent by ino
+ */
+struct tarent *lookup_tarent(struct super_block *sb, unsigned long ino)
+{
+  struct tarent *ent;
+
+  if (!TARSB(sb)->parsed){
+    message("tarfs: !!! sb->parsed =3D=3D 0\n");
+    if (parse_tar(sb))
+      goto err_out;
+    TARSB(sb)->parsed=3D1;
+  }
+
+  if (ino < 2){
+    error("tarfs: lookup_tarent() no such inode %ld\n", ino);
+    return 0;
+  }
+
+  for(ent=3DTARSB(sb)->ihash[ino%TARENT_HASHSIZE];
+      ent!=3D0;
+      ent=3DNEXT_HASH(ent)){
+    if (ent->ino=3D=3Dino){
+      return (ent->hardlinked ? ent->hardlinked : ent);
+    }
+  }
+ =20
+ err_out:
+  return 0;
+}
+
+static struct tarent *add_tarent(struct super_block *, unsigned long,
+=09=09=09  struct posix_header *, char *);
+
+/*
+ * Fill contents of 'te' according to the posix header 'ph'
+ */
+static void set_tarent(struct super_block *sb,
+=09=09struct posix_header *ph, struct tarent *te, int blk)
+{
+  unsigned long mode;
+  time_t mtime;
+  struct tarent *link;
+
+  message("set_tarent (blk=3D%d)\n", blk);
+
+  mode=3Dgetval8(ph->mode, sizeof(ph->mode));
+  switch(ph->typeflag){
+  case TARFS_DIRTYPE:
+    /* Directory */
+    te->mode =3D S_IFDIR|(mode & TARFS_MODEMASK);
+    /*
+     * Do not overwrite size/nlink, because get_new_tarent()
+     * and following add_to_parent() correctly count up
+     * these value.
+     */
+    break;
+
+  case TARFS_LNKTYPE:
+    /* Hardlinks */
+    te->linkname =3D kmalloc(strlen(ph->linkname)+1, GFP_KERNEL);
+    if (!te->linkname){
+      error("tarfs: Can not assign linkname\n");
+      te->linkname =3D 0;
+    }
+    strcpy(te->linkname, ph->linkname);
+    message("hardlink %s->%s\n", te->name, te->linkname);
+
+    /* Lookup (preassign) original entry */
+    link=3Dadd_tarent(sb, 0, 0, te->linkname);
+    te->hardlinked =3D link;
+    break;
+
+  case TARFS_SYMTYPE:
+    /* Symlinks */
+    te->mode =3D S_IFLNK|(mode & TARFS_MODEMASK);
+    te->nlink =3D 1;
+    te->linkname =3D kmalloc(strlen(ph->linkname)+1, GFP_KERNEL);
+    if (!te->linkname){
+      error("tarfs: Can not assign linkname\n");
+      te->linkname =3D 0;
+    }
+    strcpy(te->linkname, ph->linkname);
+    message("symlink %s->%s\n", te->name, te->linkname);
+    break;
+
+  case TARFS_REGTYPE:
+  case TARFS_AREGTYPE:
+    /* Regular files */
+
+    te->mode =3D S_IFREG|(mode & TARFS_MODEMASK);
+    /*
+     * Overwrite size and nlink, because at the first time,
+     * tarent is created as directory
+     */
+    te->size =3D getval8(ph->size, sizeof(ph->size));
+    te->nlink =3D 1;
+    break;
+
+  default:
+    /* Unsupported types, dev, fifo */
+    error("Unsupported typeflag %d (%c) blk %d, ignored\n",
+=09  ph->typeflag, ph->typeflag, blk);
+    te->mode =3D S_IFREG|(mode & TARFS_MODEMASK);
+    te->size =3D getval8(ph->size, sizeof(ph->size));
+    te->nlink =3D 1;
+    break;
+  }
+
+  mtime=3Dgetval8(ph->mtime, sizeof(ph->mtime));
+  te->mtime =3D mtime;
+  te->atime =3D mtime;
+  te->ctime =3D mtime;
+
+  te->uid =3D getval8(ph->uid, sizeof(ph->uid));
+  te->gid =3D getval8(ph->gid, sizeof(ph->gid));
+  te->pos =3D blk;
+}
+
+/*
+ * Alloacte a new tarent (default value)
+ */
+static struct tarent *get_new_tarent(char *n, int len, unsigned long ino)
+{
+  struct tarent *te;
+
+  te =3D (struct tarent *)kmalloc(sizeof(struct tarent), GFP_KERNEL);
+  if (!te)
+    goto err_out;
+  te->name=3Dkmalloc(len+1, GFP_KERNEL);
+  if (!te->name)
+    goto err_out;
+
+  strcpy(te->name, n);
+
+  te->linkname=3D0;
+
+  te->ino=3Dino;
+  te->children=3Dte->neighbors=3D0;
+  te->parent=3Dte;
+
+  /*
+   * Default value for the directories which IS NOT contained=20
+   * in the tar file.
+   * For the files contained in the tarfile,
+   * set_tarent() overwrites these values.
+   */
+  te->mtime =3D 0;
+  te->atime =3D 0;
+  te->ctime =3D 0;
+
+  //te->uid =3D current->fsuid;
+  //te->gid =3D current->fsgid;
+  te->pos =3D 0;
+
+  te->nlink =3D te->size =3D 2;
+  te->mode=3DS_IFDIR|0777;
+
+  te->hardlinked =3D 0;
+
+  return te;
+
+ err_out:
+  if (te && te->name)
+    kfree(te->name);
+  if (te)
+    kfree(te);
+
+  return 0;
+}
+
+static void delete_tarent(struct tarent *te)
+{
+  if (te){
+    if (te->name){
+      kfree(te->name);
+    }
+    kfree(te);
+  }
+}
+
+/*
+ * Link c to p as a child tarent
+ */
+static void add_to_parent(struct tarent *p, struct tarent *c)
+{
+  message("tarfs: add_to_parent %p %p\n", p, c);
+
+  if (!(p && S_ISDIR(p->mode)))
+    BUG();
+
+  if (c=3D=3D0)
+    BUG();
+
+  c->parent =3D p;
+  c->neighbors =3D p->children;
+  p->children =3D c;
+  p->size+=3D1;
+  p->nlink+=3D1;
+}
+
+static struct tarent *lookup_child_and_chop(struct tarent *p, char *n,
+=09=09=09=09     char **next, int *len)
+{
+  char *c;
+  struct tarent *pp;
+  int i;
+
+  if (p=3D=3D0)
+    BUG();
+
+  message("tarfs: lookup_child_and_chop %p %p\n", p, n);
+  if (n){
+    message("tarfs: name =3D %s\n", n);
+  }
+
+  /* chop */
+  for(c=3Dn, i=3D0; ; i++, c++){
+    if (*c=3D=3D'/'){
+      *c=3D0;
+      *next=3Dc+1;
+      break;
+    }
+    if (*c=3D=3D'\0'){
+      *next=3D0;
+      break;
+    }
+  }
+
+  message("tarfs: len %d\n", i);
+  *len=3Di;
+
+  for(pp=3Dp->children; pp!=3D0; pp=3Dpp->neighbors){
+    message("pp %p\n", pp);
+    if (pp=3D=3D0){
+      message("pp=3D=3D0 BUG!\n");
+      break;
+    }else if (pp->name=3D=3D0){
+      message("pp->name=3D=3D0. BUG!\n");
+      break;
+    }else{
+      message("comparing %s to %s\n", pp->name, n);
+    }
+    if (!strcmp(pp->name, n)){
+      message("tarfs: lookup_child_and_chop found child\n");
+      return pp;
+    }
+  }
+  message("tarfs: lookup_child_and_chop found NO child\n");
+  return 0;
+}
+
+static struct tarent *add_until_slash(struct super_block *sb,
+=09=09=09       struct tarent *p, char *n, char **next)
+{
+  struct tarent *te;
+  int len;
+  unsigned long ino;
+
+  message("add_until_slash (%s)\n", n);
+  te =3D lookup_child_and_chop(p, n, next, &len);
+  if (te){
+    return te;
+  }
+
+  ino=3Dget_new_ino(sb);
+
+  te =3D get_new_tarent(n, len, ino);
+  if (!te)
+    goto err_out;
+
+  hash_tarent(sb, te, ino);
+  add_to_parent(p, te);
+
+  return te;
+
+ err_out:
+  if (te)
+    delete_tarent(te);
+  return 0;
+}
+
+static char *skip_slash(char *n)
+{
+  for(; *n=3D=3D'/'; n++)
+    ;
+
+  return n;
+}
+
+/*
+ * Count tar header length from 'blk'
+ */
+static unsigned long count_header_blocks(struct super_block *sb,
+=09=09=09=09  unsigned long blk, int *fatal)
+{
+  struct buffer_head *bh;
+  int i;
+  int blocks=3D0;
+  int typeflag, isextended;
+
+  bh =3D sb_bread(sb, blk);
+  if (!bh){
+    error("tarfs: failed to read headers\n");
+    goto err_out;
+  }
+
+  blocks++;
+  typeflag =3D ((struct posix_header *)(bh->b_data))->typeflag;
+  brelse(bh);
+
+  switch(typeflag){
+  case TARFS_REGTYPE:
+  case TARFS_AREGTYPE:
+  case TARFS_LNKTYPE:
+  case TARFS_SYMTYPE:
+  case TARFS_CHRTYPE:
+  case TARFS_BLKTYPE:
+  case TARFS_DIRTYPE:
+  case TARFS_FIFOTYPE:
+  case TARFS_CONTTYPE:
+    /* Posix header only */
+    break;
+  case TARFS_GNU_DUMPDIR:
+  case TARFS_GNU_LONGLINK:
+  case TARFS_GNU_LONGNAME:
+  case TARFS_GNU_MULTIVOL:
+  case TARFS_GNU_NAMES:
+  case TARFS_GNU_SPARSE:
+  case TARFS_GNU_VOLHDR:
+    /* Gnu extra header exists */
+    printk("Encountering guu extra header\n");
+    bh =3D sb_bread(sb, blk+1);
+    if (!bh){
+      error("tarfs: failed to read extra headers\n");
+      goto err_out;
+    }
+    blocks++;
+    isextended =3D ((struct extra_header *)(bh->b_data))->isextended;
+    brelse(bh);
+    if (isextended)
+      goto out;
+
+    /* Gnu sparse header exists */
+    printk("Encountering guu sparce header\n");
+    for(i=3D0;;i++, blocks++){
+      bh =3D sb_bread(sb, blk+2+i);
+      if (!bh){
+=09error("tarfs: failed to read extra headers\n");
+=09goto err_out;
+      }
+      isextended =3D ((struct sparse_header *)(bh->b_data))->isextended;
+      brelse(bh);
+      if (isextended)
+=09break;
+    }
+    break;
+  default:
+    error("tarfs: invalid or unsupported typeflag. Headers can not be skip=
ped correctly.\n");
+    goto err_out;
+  }
+
+ out:
+  message("non fatal %d\n", blocks);
+  *fatal=3D0;
+  return blocks;
+
+ err_out:
+  message("fatal\n");
+  *fatal=3D1;
+  return 0;
+}
+
+/*
+ * Add tarent
+ * ph !=3D 0, name=3D=3D0 : normal use.
+ * ph =3D=3D 0, name!=3D0 : just pre-assign a entry (for hardlink)
+ */
+static struct tarent *add_tarent(struct super_block *sb, unsigned long blk=
,
+=09=09=09  struct posix_header *ph, char *name)
+{
+  char *n=3D0;
+  struct tarent *te=3D0;
+  struct tarent *parent;
+
+  /* lookup_tarent can not be used here */
+  parent =3D TARSB(sb)->root_tarent;
+
+  n =3D (name ? name : ph->name);
+
+  message("Adding tarentry [%s]\n", ph->name);
+
+  for(;;){
+    if (n=3D=3D0){
+      message("tarfs: no more components(1).\n");
+      goto out;
+    }
+
+    n =3D skip_slash(n);
+    if (*n=3D=3D'\0'){
+      message("tarfs: no more components(2).\n");
+      goto out;
+    }
+    if ( *n=3D=3D'.' && (*(n+1)=3D=3D'/' || *(n+1)=3D=3D'\0') ){
+      message("tarfs: skipping dot\n");
+      n++;
+      continue;
+    }
+    if ( *n=3D=3D'.' && *(n+1)=3D=3D'.' && (*(n+2)=3D=3D'/' || *(n+2)=3D=
=3D'\0') ){
+      n+=3D2;
+      if (parent=3D=3DTARSB(sb)->root_tarent){
+=09message("tarfs: Oops going higher than root, ignored.\n");
+
+=09/* Drop this entry */
+=09goto err_out;
+      }
+      parent=3Dparent->parent;
+
+      continue;
+    }
+   =20
+    te=3Dadd_until_slash(sb, parent, n, &n);
+    parent =3D te;
+  }
+
+ out:
+  if (ph)
+    set_tarent(sb, ph, parent, blk);
+=20
+ err_out:
+  return parent;
+}
+
+/*
+ * Deleet all tarents and hash.
+ */
+void delete_all_tarents_and_hash(struct super_block *sb)
+{
+  struct tarent *te, **tp;
+  int i;
+
+  if ( (tp=3DTARSB(sb)->ihash)=3D=3D0 )
+    return;
+ =20
+  for(i=3D0; i<TARENT_HASHSIZE; i++){
+    for(te=3D*(tp+i); te!=3D0; te=3DNEXT_HASH(te))
+      delete_tarent(te);
+  }
+  kfree(TARSB(sb)->ihash);
+}
+
+/*
+ * Parse tar archive and gather necessary information
+ */
+static int parse_tar(struct super_block *sb)
+{
+  struct buffer_head *bh;
+  struct tarent **tent=3D0, *root;
+  int tarblk, fatal;
+  struct posix_header *ph;
+  //dev_t dev;
+  unsigned long size, headers;
+
+  //dev =3D sb->s_dev;
+  //printk("tarfs: parse start (%d,%d)\n", MAJOR(dev), MINOR(dev));
+
+  /* create dummy root */
+  root=3Dget_new_tarent("root", 4, 2);
+  if (!root)
+    goto err_out;
+  hash_tarent(sb, root, get_new_ino(sb) /* 2 */);
+  root->mode=3DS_IFDIR|0777;
+  TARSB(sb)->root_tarent=3Droot;
+
+  tarblk=3D0;
+  for(;;){
+    bh =3D sb_bread(sb, tarblk);
+    if (!bh){
+      /* XXX: disk error or end-of-device */
+      break;
+    }
+
+    ph =3D (struct posix_header*)((char *)bh->b_data);
+    if (ph->name[0] =3D=3D '\0'){
+      brelse(bh);
+      break;
+    }
+
+    /* Skip headers */
+    headers=3Dcount_header_blocks(sb, tarblk, &fatal);
+    if (fatal){
+      error("Encountering unsupported typeflag blk %d, abort parsing\n",
+=09    tarblk);
+      break;
+    }
+
+    tarblk+=3Dheaders;
+    add_tarent(sb, tarblk, ph, 0);
+
+    /* Skip contents of the file */
+    size=3Dgetval8(ph->size, sizeof(ph->size));
+    tarblk +=3D (size+TAR_BLOCKSIZE-1)/TAR_BLOCKSIZE;
+
+    brelse(bh);
+  }
+
+  printk("tarfs: parse done (%ld inodes created)\n",
+=09 TARSB(sb)->s_maxino-2);
+
+  /* XXX: Poor statistics info  */
+  TARSB(sb)->s_files =3D TARSB(sb)->s_maxino-2;
+  TARSB(sb)->s_blocks =3D tarblk;
+
+  return 0;
+
+ err_out:
+  if (tent)
+    *tent =3D 0;
+  if (root)
+    delete_tarent(root);
+  return -1;
+}
diff -urN linux-2.6.10-rc1/fs/tarfs/tarfs.h linux-2.6.10-rc1-tarfs/fs/tarfs=
/tarfs.h
--- linux-2.6.10-rc1/fs/tarfs/tarfs.h=091970-01-01 07:00:00.000000000 +0700
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/tarfs.h=092004-11-06 12:16:56.000000000=
 +0800
@@ -0,0 +1,118 @@
+/*
+ *  tarfs/tarfs.h
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: tarfs.h,v 1.13 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Copyright (C) 2001
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *
+ */
+
+#include "tarinf.h"
+
+/* Debug support */
+extern int tarfs_debug;
+#define message if (tarfs_debug) printk
+#define error printk
+
+/* 'tafs' in little endian */
+#define TARFS_SUPER_MAGIC 0x73666174
+
+/* Size, root ino, etc. */
+#define TAR_BLOCKSIZE 512
+#define TARFS_NAME_LEN 255
+#define TARFS_MAX_SIZE=09((unsigned long)0x7fffffff)
+#define TARFS_ROOT_INO  2
+
+#define TARENT(inode)  ((struct tarent*)((inode)->u.generic_ip))
+
+/* Each file */
+struct tarent
+{
+  /* File attributes */
+  umode_t mode;
+  uid_t uid;
+  gid_t gid;
+  loff_t size;
+  nlink_t nlink;
+  time_t atime;
+  time_t ctime;
+  time_t mtime;
+
+  /* Offset from start of the archive */
+  unsigned long pos;
+
+  /* File name */
+  char *name;
+
+  /* Symlink */
+  char *linkname;
+
+  /* Inodo nr assigned to the file */
+  int ino;
+
+  /* Parent directory, link to children, neighbors */
+  struct tarent *parent;
+  struct tarent *children;
+  struct tarent *neighbors;
+
+  /* Link to hash */
+  struct tarent *next_hash;
+
+  /* Link to hardlinked original */
+  struct tarent *hardlinked;
+};
+
+#define TARENT_HASHSIZE 1024
+#define NEXT_HASH(ent)=09((ent)->next_hash)
+
+/* Additional information for tarfs superblock */
+struct tarfs_sb_info {
+  /* 1 if already have archive information */
+  int parsed;
+
+  /* Root tarent */
+  struct tarent *root_tarent;
+
+  /* Hash table */
+  struct tarent **ihash;
+
+  /* Information for statfs */
+  unsigned long s_files;
+  unsigned long s_blocks;
+
+  /* Max inode assigned */
+  unsigned long s_maxino;
+};
+
+#define TARSB(sb)  ((struct tarfs_sb_info*)((sb)->s_fs_info))
+
+/* Prototypes */
+struct tarent *lookup_tarent(struct super_block *sb, unsigned long ino);
+extern struct inode_operations tarfs_dir_inode_operations;
+extern struct inode_operations tarfs_file_inode_operations;
+extern struct file_operations tarfs_file_operations;
+extern struct file_operations tarfs_dir_operations;
+int parse_tar(struct super_block *sb);
+void delete_all_tarents_and_hash(struct super_block *sb);
+ssize_t tarfs_read(struct inode *inode,
+=09=09   char * buf, size_t count, loff_t *ppos);
+int tarfs_writepage(struct page *page);
+int tarfs_readpage(struct file *file, struct page *page);
diff -urN linux-2.6.10-rc1/fs/tarfs/tarinf.h linux-2.6.10-rc1-tarfs/fs/tarf=
s/tarinf.h
--- linux-2.6.10-rc1/fs/tarfs/tarinf.h=091970-01-01 07:00:00.000000000 +070=
0
+++ linux-2.6.10-rc1-tarfs/fs/tarfs/tarinf.h=092004-11-06 12:17:02.00000000=
0 +0800
@@ -0,0 +1,115 @@
+/*
+ *  tarfs/tarinf.h
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Version: $Id: tarinf.h,v 1.3 2001/02/25 21:39:03 kaz Exp $
+ *
+ * Origilal file tar-1.13 src/tar.h
+ * Modified by
+ * Kazuto Miyoshi (kaz@earth.email.ne.jp)
+ * Hirokazu Takahashi (h-takaha@mub.biglobe.ne.jp)
+ *
+ * 2004 deyan liu (liudeyan@gmail.com) make it work in Linux 2.6.*
+ *
+ */
+
+/* Information in tar archive */
+
+#define TARFS_REGTYPE  '0'
+#define TARFS_AREGTYPE '\0'
+#define TARFS_LNKTYPE  '1'
+#define TARFS_SYMTYPE  '2'
+#define TARFS_CHRTYPE  '3'
+#define TARFS_BLKTYPE  '4'
+#define TARFS_DIRTYPE  '5'
+#define TARFS_FIFOTYPE '6'
+#define TARFS_CONTTYPE '7'
+
+#define TARFS_GNU_DUMPDIR  'D'
+#define TARFS_GNU_LONGLINK 'K'
+#define TARFS_GNU_LONGNAME 'L'
+#define TARFS_GNU_MULTIVOL 'M'
+#define TARFS_GNU_NAMES    'N'
+#define TARFS_GNU_SPARSE   'S'
+#define TARFS_GNU_VOLHDR   'V'
+
+/* Mode field */
+#define TARFS_SUID     04000
+#define TARFS_SGID     02000
+#define TARFS_SVTX     01000
+#define TARFS_MODEMASK 00777
+
+struct posix_header
+{
+  char name[100];
+  char mode[8];
+  char uid[8];
+  char gid[8];
+  char size[12];
+  char mtime[12];
+  char chksum[8];
+  char typeflag;
+  char linkname[100];
+  char magic[6];
+  char version[2];
+  char uname[32];
+  char gname[32];
+  char devmajor[8];
+  char devminor[8];
+  char prefix[155];
+};
+
+#define SPARSES_IN_EXTRA_HEADER  16
+#define SPARSES_IN_OLDGNU_HEADER 4
+#define SPARSES_IN_SPARSE_HEADER 21
+
+struct sparse
+{
+  char offset[12];
+  char numbytes[12];
+};
+
+/* GNU extra header */
+struct extra_header
+{
+  char atime[12];
+  char ctime[12];
+  char offset[12];
+  char realsize[12];
+  char longnames[4];
+  char unused_pad1[68];
+  struct sparse sp[SPARSES_IN_EXTRA_HEADER];
+  char isextended;
+};
+
+struct sparse_header
+{
+  struct sparse sp[SPARSES_IN_SPARSE_HEADER];
+  char isextended;
+};
+
+struct oldgnu_header
+{
+  char unused_pad1[345];
+  char atime[12];
+  char ctime[12];
+  char offset[12];
+  char longnames[4];
+  char unused_pad2;
+  struct sparse sp[SPARSES_IN_OLDGNU_HEADER];
+  char isextended;
+  char realsize[12];
+};

------=_Part_3569_25513921.1099811198838--
