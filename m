Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSEWBPy>; Wed, 22 May 2002 21:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSEWBPx>; Wed, 22 May 2002 21:15:53 -0400
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:30872 "EHLO gin")
	by vger.kernel.org with ESMTP id <S315544AbSEWBPU>;
	Wed, 22 May 2002 21:15:20 -0400
Date: Thu, 23 May 2002 03:15:19 +0200
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] lvm sanitation in 2.5
Message-ID: <20020523011519.GA8521@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have started cleaning up lvm. The following patch contains the first
steps. It disables a lot of functionallity but the basic things are
there, I'm actually running a kernel with this patch right now, with
/home and /var on lvm. The vg_t/lv_t..-structures are now available in
to versions, one exported to userspace (and that should remain
constant through versions) and one used in kernelspace containing
stuff that should not be exposed to userspace (struct block_device,
kdev_t and such). (this also allows more flexibillity making changes
in the driver without changing the userspace interface). Should i
finish this patch? Would davej accept it?

-- 

//anders/g

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.568.2.1, 2002-05-23 02:23:48+02:00, andersg@heineken.0x63.nu
  This is a first step to sanitize the lvm implementation.
  Snapshotting is disabled as it was already broken.
  The vg_t/lv_t/pv_t structures exported to userspace are only used in the ioctl's talking to userspace.


 drivers/md/Config.in      |    2 
 drivers/md/lvm-fs.c       |  125 +++--
 drivers/md/lvm-internal.h |   36 -
 drivers/md/lvm-snap.c     |    2 
 drivers/md/lvm.c          |  983 ++++++++++++++++++++++++++++++----------------
 include/linux/lvm.h       |  178 ++++++--
 6 files changed, 861 insertions(+), 465 deletions(-)


diff -Nru a/drivers/md/Config.in b/drivers/md/Config.in
--- a/drivers/md/Config.in	Thu May 23 02:55:31 2002
+++ b/drivers/md/Config.in	Thu May 23 02:55:31 2002
@@ -13,6 +13,6 @@
 dep_tristate '  RAID-4/RAID-5 mode' CONFIG_MD_RAID5 $CONFIG_BLK_DEV_MD
 dep_tristate '  Multipath I/O support' CONFIG_MD_MULTIPATH $CONFIG_BLK_DEV_MD
 
-dep_tristate ' Logical volume manager (LVM) support' CONFIG_BLK_DEV_LVM $CONFIG_MD
+dep_tristate ' Logical volume manager (LVM) support (EXPERIMENTAL)' CONFIG_BLK_DEV_LVM $CONFIG_MD $CONFIG_EXPERIMENTAL
 
 endmenu
diff -Nru a/drivers/md/lvm-fs.c b/drivers/md/lvm-fs.c
--- a/drivers/md/lvm-fs.c	Thu May 23 02:55:31 2002
+++ b/drivers/md/lvm-fs.c	Thu May 23 02:55:31 2002
@@ -59,9 +59,9 @@
 static int _proc_read_global(char *page, char **start, off_t off,
 			     int count, int *eof, void *data);
 
-static int _vg_info(vg_t *vg_ptr, char *buf);
-static int _lv_info(vg_t *vg_ptr, lv_t *lv_ptr, char *buf);
-static int _pv_info(pv_t *pv_ptr, char *buf);
+static int _vg_info(kern_vg_t *vg_ptr, char *buf);
+static int _lv_info(kern_vg_t *vg_ptr, kern_lv_t *lv_ptr, char *buf);
+static int _pv_info(kern_pv_t *pv_ptr, char *buf);
 
 static void _show_uuid(const char *src, char *b, char *e);
 
@@ -102,11 +102,16 @@
 	remove_proc_entry(LVM_DIR, &proc_root);
 }
 
-void lvm_fs_create_vg(vg_t *vg_ptr) {
+void lvm_fs_create_vg(kern_vg_t *vg_ptr) {
 	struct proc_dir_entry *pde;
+	devfs_handle_t th;
 
-	vg_devfs_handle[vg_ptr->vg_number] =
-		devfs_mk_dir(0, vg_ptr->vg_name, NULL);
+	th=devfs_get_handle(NULL,vg_ptr->vg_name,0,0,0,0);
+
+	if(th==NULL){
+		th=devfs_mk_dir(0, vg_ptr->vg_name, NULL);
+	}
+	vg_devfs_handle[vg_ptr->vg_number] = th;
 
 	ch_devfs_handle[vg_ptr->vg_number] = devfs_register(
 		vg_devfs_handle[vg_ptr->vg_number] , "group",
@@ -129,7 +134,7 @@
 		create_proc_entry(LVM_PV_SUBDIR, S_IFDIR, vg_ptr->vg_dir_pde);
 }
 
-void lvm_fs_remove_vg(vg_t *vg_ptr) {
+void lvm_fs_remove_vg(kern_vg_t *vg_ptr) {
 	int i;
 
 	devfs_unregister(ch_devfs_handle[vg_ptr->vg_number]);
@@ -168,13 +173,13 @@
 	return name;
 }
 
-devfs_handle_t lvm_fs_create_lv(vg_t *vg_ptr, lv_t *lv) {
+devfs_handle_t lvm_fs_create_lv(kern_vg_t *vg_ptr, kern_lv_t *lv) {
 	struct proc_dir_entry *pde;
-	const char *name = _basename(lv->u.lv_name);
+	const char *name = _basename(lv->lv_name);
 
-	lv_devfs_handle[minor(lv->u.lv_dev)] = devfs_register(
+	lv_devfs_handle[minor(lv->lv_kdev)] = devfs_register(
 		vg_devfs_handle[vg_ptr->vg_number], name,
-		DEVFS_FL_DEFAULT, LVM_BLK_MAJOR, minor(lv->u.lv_dev),
+		DEVFS_FL_DEFAULT, LVM_BLK_MAJOR, minor(lv->lv_kdev),
 		S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 		&lvm_blk_dops, NULL);
 
@@ -183,15 +188,15 @@
 		pde->read_proc = _proc_read_lv;
 		pde->data = lv;
 	}
-	return lv_devfs_handle[minor(lv->u.lv_dev)];
+	return lv_devfs_handle[minor(lv->lv_kdev)];
 }
 
-void lvm_fs_remove_lv(vg_t *vg_ptr, lv_t *lv) {
-	devfs_unregister(lv_devfs_handle[minor(lv->u.lv_dev)]);
-	lv_devfs_handle[minor(lv->u.lv_dev)] = NULL;
+void lvm_fs_remove_lv(kern_vg_t *vg_ptr, kern_lv_t *lv) {
+	devfs_unregister(lv_devfs_handle[minor(lv->lv_kdev)]);
+	lv_devfs_handle[minor(lv->lv_kdev)] = NULL;
 
 	if(vg_ptr->lv_subdir_pde) {
-		const char *name = _basename(lv->u.lv_name);
+		const char *name = _basename(lv->lv_name);
 		remove_proc_entry(name, vg_ptr->lv_subdir_pde);
 	}
 }
@@ -211,7 +216,7 @@
 	*b = '\0';
 }
 
-void lvm_fs_create_pv(vg_t *vg_ptr, pv_t *pv) {
+void lvm_fs_create_pv(kern_vg_t *vg_ptr, kern_pv_t *pv) {
 	struct proc_dir_entry *pde;
 	char name[NAME_LEN];
 
@@ -225,7 +230,7 @@
 	}
 }
 
-void lvm_fs_remove_pv(vg_t *vg_ptr, pv_t *pv) {
+void lvm_fs_remove_pv(kern_vg_t *vg_ptr, kern_pv_t *pv) {
 	char name[NAME_LEN];
 
 	if(!vg_ptr->pv_subdir_pde)
@@ -239,7 +244,7 @@
 static int _proc_read_vg(char *page, char **start, off_t off,
 			  int count, int *eof, void *data) {
 	int sz = 0;
-	vg_t *vg_ptr = data;
+	kern_vg_t *vg_ptr = data;
 	char uuid[NAME_LEN];
 
 	sz += sprintf(page + sz, "name:         %s\n", vg_ptr->vg_name);
@@ -267,23 +272,23 @@
 static int _proc_read_lv(char *page, char **start, off_t off,
 			  int count, int *eof, void *data) {
 	int sz = 0;
-	lv_t *lv = data;
+	kern_lv_t *lv = data;
 
-	sz += sprintf(page + sz, "name:         %s\n", lv->u.lv_name);
-	sz += sprintf(page + sz, "size:         %u\n", lv->u.lv_size);
-	sz += sprintf(page + sz, "access:       %u\n", lv->u.lv_access);
-	sz += sprintf(page + sz, "status:       %u\n", lv->u.lv_status);
-	sz += sprintf(page + sz, "number:       %u\n", lv->u.lv_number);
-	sz += sprintf(page + sz, "open:         %u\n", lv->u.lv_open);
-	sz += sprintf(page + sz, "allocation:   %u\n", lv->u.lv_allocation);
-       if(lv->u.lv_stripes > 1) {
+	sz += sprintf(page + sz, "name:         %s\n", lv->lv_name);
+	sz += sprintf(page + sz, "size:         %u\n", lv->lv_size);
+	sz += sprintf(page + sz, "access:       %u\n", lv->lv_access);
+	sz += sprintf(page + sz, "status:       %u\n", lv->lv_status);
+	sz += sprintf(page + sz, "number:       %u\n", lv->lv_number);
+	sz += sprintf(page + sz, "open:         %u\n", lv->lv_open);
+	sz += sprintf(page + sz, "allocation:   %u\n", lv->lv_allocation);
+       if(lv->lv_stripes > 1) {
                sz += sprintf(page + sz, "stripes:      %u\n",
-                             lv->u.lv_stripes);
+                             lv->lv_stripes);
                sz += sprintf(page + sz, "stripesize:   %u\n",
-                             lv->u.lv_stripesize);
+                             lv->lv_stripesize);
        }
 	sz += sprintf(page + sz, "device:       %02u:%02u\n",
-		      major(lv->u.lv_dev), minor(lv->u.lv_dev));
+		      major(lv->lv_kdev), minor(lv->lv_kdev));
 
 	return sz;
 }
@@ -291,7 +296,7 @@
 static int _proc_read_pv(char *page, char **start, off_t off,
 			 int count, int *eof, void *data) {
 	int sz = 0;
-	pv_t *pv = data;
+	kern_pv_t *pv = data;
 	char uuid[NAME_LEN];
 
 	sz += sprintf(page + sz, "name:         %s\n", pv->pv_name);
@@ -304,7 +309,7 @@
 	sz += sprintf(page + sz, "PE total:     %u\n", pv->pe_total);
 	sz += sprintf(page + sz, "PE allocated: %u\n", pv->pe_allocated);
 	sz += sprintf(page + sz, "device:       %02u:%02u\n",
-                      major(pv->pv_dev), minor(pv->pv_dev));
+                      major(pv->pv_kdev), minor(pv->pv_kdev));
 
 	_show_uuid(pv->pv_uuid, uuid, uuid + sizeof(uuid));
 	sz += sprintf(page + sz, "uuid:         %s\n", uuid);
@@ -323,9 +328,9 @@
 	off_t sz_last;
 	static char *buf = NULL;
 	static char dummy_buf[160];	/* sized for 2 lines */
-	vg_t *vg_ptr;
-	lv_t *lv_ptr;
-	pv_t *pv_ptr;
+	kern_vg_t *vg_ptr;
+	kern_lv_t *lv_ptr;
+	kern_pv_t *pv_ptr;
 
 
 #ifdef DEBUG_LVM_PROC_GET_INFO
@@ -350,13 +355,13 @@
 			if (vg_ptr->lv_cur > 0) {
 				for (l = 0; l < vg[v]->lv_max; l++) {
 					if ((lv_ptr = vg_ptr->lv[l]) != NULL) {
-						pe_t_bytes += lv_ptr->u.lv_allocated_le;
+						pe_t_bytes += lv_ptr->lv_allocated_le;
 						hash_table_bytes += lv_ptr->lv_snapshot_hash_table_size;
-						if (lv_ptr->u.lv_block_exception != NULL)
-							lv_block_exception_t_bytes += lv_ptr->u.lv_remap_end;
-						if (lv_ptr->u.lv_open > 0) {
+						if (lv_ptr->lv_block_exception != NULL)
+							lv_block_exception_t_bytes += lv_ptr->lv_remap_end;
+						if (lv_ptr->lv_open > 0) {
 							lv_open_counter++;
-							lv_open_total += lv_ptr->u.lv_open;
+							lv_open_total += lv_ptr->lv_open;
 						}
 					}
 				}
@@ -364,7 +369,7 @@
 		}
 	}
 
-	pe_t_bytes *= sizeof(pe_t);
+	pe_t_bytes *= sizeof(kern_pe_t);
 	lv_block_exception_t_bytes *= sizeof(lv_block_exception_t);
 
 	if (buf != NULL) {
@@ -403,9 +408,9 @@
 			sz += sprintf(LVM_PROC_BUF, ")");
 		sz += sprintf(LVM_PROC_BUF,
 			      "\nGlobal: %lu bytes malloced   IOP version: %d   ",
-			      vg_counter * sizeof(vg_t) +
-			      pv_counter * sizeof(pv_t) +
-			      lv_counter * sizeof(lv_t) +
+			      vg_counter * sizeof(kern_vg_t) +
+			      pv_counter * sizeof(kern_pv_t) +
+			      lv_counter * sizeof(kern_lv_t) +
 			      pe_t_bytes + hash_table_bytes + lv_block_exception_t_bytes + sz_last,
 			      lvm_iop_version);
 
@@ -497,7 +502,7 @@
 /*
  * provide VG info for proc filesystem use (global)
  */
-static int _vg_info(vg_t *vg_ptr, char *buf) {
+static int _vg_info(kern_vg_t *vg_ptr, char *buf) {
 	int sz = 0;
 	char inactive_flag = ' ';
 
@@ -527,21 +532,21 @@
 /*
  * provide LV info for proc filesystem use (global)
  */
-static int _lv_info(vg_t *vg_ptr, lv_t *lv_ptr, char *buf) {
+static int _lv_info(kern_vg_t *vg_ptr, kern_lv_t *lv_ptr, char *buf) {
 	int sz = 0;
 	char inactive_flag = 'A', allocation_flag = ' ',
 		stripes_flag = ' ', rw_flag = ' ', *basename;
 
-	if (!(lv_ptr->u.lv_status & LV_ACTIVE))
+	if (!(lv_ptr->lv_status & LV_ACTIVE))
 		inactive_flag = 'I';
 	rw_flag = 'R';
-	if (lv_ptr->u.lv_access & LV_WRITE)
+	if (lv_ptr->lv_access & LV_WRITE)
 		rw_flag = 'W';
 	allocation_flag = 'D';
-	if (lv_ptr->u.lv_allocation & LV_CONTIGUOUS)
+	if (lv_ptr->lv_allocation & LV_CONTIGUOUS)
 		allocation_flag = 'C';
 	stripes_flag = 'L';
-	if (lv_ptr->u.lv_stripes > 1)
+	if (lv_ptr->lv_stripes > 1)
 		stripes_flag = 'S';
 	sz += sprintf(buf+sz,
 		      "[%c%c%c%c",
@@ -549,29 +554,29 @@
 	 rw_flag,
 		      allocation_flag,
 		      stripes_flag);
-	if (lv_ptr->u.lv_stripes > 1)
+	if (lv_ptr->lv_stripes > 1)
 		sz += sprintf(buf+sz, "%-2d",
-			      lv_ptr->u.lv_stripes);
+			      lv_ptr->lv_stripes);
 	else
 		sz += sprintf(buf+sz, "  ");
 
 	/* FIXME: use _basename */
-	basename = strrchr(lv_ptr->u.lv_name, '/');
-	if ( basename == 0) basename = lv_ptr->u.lv_name;
+	basename = strrchr(lv_ptr->lv_name, '/');
+	if ( basename == 0) basename = lv_ptr->lv_name;
 	else                basename++;
 	sz += sprintf(buf+sz, "] %-25s", basename);
 	if (strlen(basename) > 25)
 		sz += sprintf(buf+sz,
 			      "\n                              ");
 	sz += sprintf(buf+sz, "%9d /%-6d   ",
-		      lv_ptr->u.lv_size >> 1,
-		      lv_ptr->u.lv_size / vg_ptr->pe_size);
+		      lv_ptr->lv_size >> 1,
+		      lv_ptr->lv_size / vg_ptr->pe_size);
 
-	if (lv_ptr->u.lv_open == 0)
+	if (lv_ptr->lv_open == 0)
 		sz += sprintf(buf+sz, "close");
 	else
 		sz += sprintf(buf+sz, "%dx open",
-			      lv_ptr->u.lv_open);
+			      lv_ptr->lv_open);
 
 	return sz;
 }
@@ -580,7 +585,7 @@
 /*
  * provide PV info for proc filesystem use (global)
  */
-static int _pv_info(pv_t *pv, char *buf) {
+static int _pv_info(kern_pv_t *pv, char *buf) {
 	int sz = 0;
 	char inactive_flag = 'A', allocation_flag = ' ';
 	char *pv_name = NULL;
diff -Nru a/drivers/md/lvm-internal.h b/drivers/md/lvm-internal.h
--- a/drivers/md/lvm-internal.h	Thu May 23 02:55:31 2002
+++ b/drivers/md/lvm-internal.h	Thu May 23 02:55:31 2002
@@ -42,7 +42,7 @@
 extern const char *const lvm_name;
 
 
-extern vg_t *vg[];
+extern kern_vg_t *vg[];
 extern struct file_operations lvm_chr_fops;
 
 extern struct block_device_operations lvm_blk_dops;
@@ -73,29 +73,29 @@
 #define P_DEV(fmt, args...)
 #endif
 
-
+#ifdef BROKEN
 /* lvm-snap.c */
 int lvm_get_blksize(kdev_t);
-int lvm_snapshot_alloc(lv_t *);
-int lvm_snapshot_fill_COW_page(vg_t *, lv_t *);
-int lvm_snapshot_COW(kdev_t, ulong, ulong, ulong, vg_t *vg, lv_t *);
-int lvm_snapshot_remap_block(kdev_t *, ulong *, ulong, lv_t *);
-void lvm_snapshot_release(lv_t *);
-int lvm_write_COW_table_block(vg_t *, lv_t *);
-void lvm_hash_link(lv_block_exception_t *, kdev_t, ulong, lv_t *);
-int lvm_snapshot_alloc_hash_table(lv_t *);
-void lvm_drop_snapshot(vg_t *vg, lv_t *, const char *);
-
+int lvm_snapshot_alloc(kern_lv_t *);
+int lvm_snapshot_fill_COW_page(kern_vg_t *, kern_lv_t *);
+int lvm_snapshot_COW(kdev_t, ulong, ulong, ulong, kern_vg_t *vg, kern_lv_t *);
+int lvm_snapshot_remap_block(kdev_t *, ulong *, ulong, kern_lv_t *);
+void lvm_snapshot_release(kern_lv_t *);
+int lvm_write_COW_table_block(kern_vg_t *, kern_lv_t *);
+void lvm_hash_link(lv_block_exception_t *, kdev_t, ulong, kern_lv_t *);
+int lvm_snapshot_alloc_hash_table(kern_lv_t *);
+void lvm_drop_snapshot(kern_vg_t *vg, kern_lv_t *, const char *);
+#endif
 
 /* lvm_fs.c */
 void lvm_init_fs(void);
 void lvm_fin_fs(void);
 
-void lvm_fs_create_vg(vg_t *vg_ptr);
-void lvm_fs_remove_vg(vg_t *vg_ptr);
-devfs_handle_t lvm_fs_create_lv(vg_t *vg_ptr, lv_t *lv);
-void lvm_fs_remove_lv(vg_t *vg_ptr, lv_t *lv);
-void lvm_fs_create_pv(vg_t *vg_ptr, pv_t *pv);
-void lvm_fs_remove_pv(vg_t *vg_ptr, pv_t *pv);
+void lvm_fs_create_vg(kern_vg_t *vg_ptr);
+void lvm_fs_remove_vg(kern_vg_t *vg_ptr);
+devfs_handle_t lvm_fs_create_lv(kern_vg_t *vg_ptr, kern_lv_t *lv);
+void lvm_fs_remove_lv(kern_vg_t *vg_ptr, kern_lv_t *lv);
+void lvm_fs_create_pv(kern_vg_t *vg_ptr, kern_pv_t *pv);
+void lvm_fs_remove_pv(kern_vg_t *vg_ptr, kern_pv_t *pv);
 
 #endif
diff -Nru a/drivers/md/lvm-snap.c b/drivers/md/lvm-snap.c
--- a/drivers/md/lvm-snap.c	Thu May 23 02:55:31 2002
+++ b/drivers/md/lvm-snap.c	Thu May 23 02:55:31 2002
@@ -1,3 +1,4 @@
+#ifdef BROKEN
 /*
  * kernel/lvm-snap.c
  *
@@ -698,3 +699,4 @@
 }
 
 MODULE_LICENSE("GPL");
+#endif /* broken */
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Thu May 23 02:55:31 2002
+++ b/drivers/md/lvm.c	Thu May 23 02:55:31 2002
@@ -1,4 +1,10 @@
+#define IGNORE_AL_VIRO
+
+
+#ifndef IGNORE_AL_VIRO
 #error Broken until maintainers will sanitize kdev_t handling
+#endif
+
 /*
  * kernel/lvm.c
  *
@@ -212,7 +218,6 @@
 #include <linux/proc_fs.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
-#include <linux/locks.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <asm/ioctl.h>
@@ -244,8 +249,8 @@
 static int lvm_blk_open(struct inode *, struct file *);
 
 static int lvm_blk_close(struct inode *, struct file *);
-static int lvm_get_snapshot_use_rate(lv_t *lv_ptr, void *arg);
-static int lvm_user_bmap(struct inode *, struct lv_bmap *);
+static int lvm_get_snapshot_use_rate(kern_lv_t *lv_ptr, void *arg);
+/*static int lvm_user_bmap(struct inode *, struct lv_bmap *);*/
 
 static int lvm_chr_open(struct inode *, struct file *);
 static int lvm_chr_close(struct inode *, struct file *);
@@ -266,39 +271,49 @@
 #endif
 static int lvm_map(struct bio *);
 static int lvm_do_lock_lvm(void);
-static int lvm_do_le_remap(vg_t *, void *);
+//static int lvm_do_le_remap(vg_t *, void *);
 
-static int lvm_do_pv_create(pv_t *, vg_t *, ulong);
-static int lvm_do_pv_remove(vg_t *, ulong);
-static int lvm_do_lv_create(int, char *, userlv_t *);
-static int lvm_do_lv_extend_reduce(int, char *, userlv_t *);
+static int lvm_do_pv_create(user_pv_t *, kern_vg_t *, ulong);
+static int lvm_do_pv_remove(kern_vg_t *, ulong);
+static int lvm_do_lv_create(int, char *, user_lv_t *);
+//static int lvm_do_lv_extend_reduce(int, char *, user_lv_t *);
 static int lvm_do_lv_remove(int, char *, int);
-static int lvm_do_lv_rename(vg_t *, lv_req_t *, userlv_t *);
-static int lvm_do_lv_status_byname(vg_t *r, void *);
-static int lvm_do_lv_status_byindex(vg_t *, void *);
-static int lvm_do_lv_status_bydev(vg_t *, void *);
+static int lvm_do_lv_rename(kern_vg_t *, lv_req_t *, user_lv_t *);
+static int lvm_do_lv_status_byname(kern_vg_t *r, void *);
+static int lvm_do_lv_status_byindex(kern_vg_t *, void *);
+static int lvm_do_lv_status_bydev(kern_vg_t *, void *);
 
-static int lvm_do_pe_lock_unlock(vg_t *r, void *);
+static int lvm_do_pe_lock_unlock(kern_vg_t *r, void *);
 
-static int lvm_do_pv_change(vg_t*, void*);
-static int lvm_do_pv_status(vg_t *, void *);
+static int lvm_do_pv_change(kern_vg_t*, void*);
+static int lvm_do_pv_status(kern_vg_t *, void *);
 static int lvm_do_pv_flush(void *);
 
 static int lvm_do_vg_create(void *, int minor);
-static int lvm_do_vg_extend(vg_t *, void *);
-static int lvm_do_vg_reduce(vg_t *, void *);
-static int lvm_do_vg_rename(vg_t *, void *);
+static int lvm_do_vg_extend(kern_vg_t *, void *);
+static int lvm_do_vg_reduce(kern_vg_t *, void *);
+static int lvm_do_vg_rename(kern_vg_t *, void *);
 static int lvm_do_vg_remove(int);
 static void lvm_geninit(struct gendisk *);
-static void __update_hardsectsize(lv_t *lv);
+static void __update_hardsectsize(kern_lv_t *lv);
 
 
 static void _queue_io(struct bio *bh, int rw);
 static struct bio *_dequeue_io(void);
 static void _flush_io(struct bio *bh);
 
-static int _open_pv(pv_t *pv);
-static void _close_pv(pv_t *pv);
+static int _open_pv(kern_pv_t *pv);
+static void _close_pv(kern_pv_t *pv);
+
+/* function for converting between kernelspace and
+   userspace versions of structures */
+static void kernpv_to_userpv(const kern_pv_t *const kpv,user_pv_t *const upv);
+static void userpv_to_kernpv(const user_pv_t *const upv,kern_pv_t *const kpv);
+static void kernvg_to_uservg(const kern_vg_t *const kvg,user_vg_t *const uvg);
+static void uservg_to_kernvg(const user_vg_t *const uvg,kern_vg_t *const kvg);
+static void kernlv_to_userlv(const kern_lv_t *const klv,user_lv_t *const ulv);
+static void userlv_to_kernlv(const user_lv_t *const ulv,kern_lv_t *const klv);
+
 
 static unsigned long _sectors_to_k(unsigned long sect);
 
@@ -316,7 +331,7 @@
 
 
 /* volume group descriptor area pointers */
-vg_t *vg[ABS_MAX_VG];
+kern_vg_t *vg[ABS_MAX_VG];
 
 /* map from block minor number to VG and LV numbers */
 typedef struct {
@@ -327,10 +342,10 @@
 
 
 /* Request structures (lvm_chr_ioctl()) */
-static pv_change_req_t pv_change_req;
+/* static pv_change_req_t pv_change_req; */
 static pv_status_req_t pv_status_req;
 volatile static pe_lock_req_t pe_lock_req;
-static le_remap_req_t le_remap_req;
+/* static le_remap_req_t le_remap_req; */
 static lv_req_t lv_req;
 
 #ifdef LVM_TOTAL_RESET
@@ -338,7 +353,6 @@
 #endif
 
 static char pv_name[NAME_LEN];
-/* static char rootvg[NAME_LEN] = { 0, }; */
 static int lock = 0;
 static int _lock_open_count = 0;
 static uint vg_count = 0;
@@ -513,25 +527,25 @@
 static int lvm_chr_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = minor(inode->i_rdev);
-
+	
 	P_DEV("chr_open MINOR: %d  VG#: %d  mode: %s%s  lock: %d\n",
 	      minor, VG_CHR(minor), MODE_TO_STR(file->f_mode), lock);
-
+	
 	/* super user validation */
 	if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-
+	
 	/* Group special file open */
 	if (VG_CHR(minor) > MAX_VG) return -ENXIO;
-
-       spin_lock(&lvm_lock);
-       if(lock == current->pid)
-               _lock_open_count++;
-       spin_unlock(&lvm_lock);
-
+	
+	spin_lock(&lvm_lock);
+	if(lock == current->pid)
+		_lock_open_count++;
+	spin_unlock(&lvm_lock);
+	
 	lvm_chr_open_count++;
-
+	
 	MOD_INC_USE_COUNT;
-
+	
 	return 0;
 } /* lvm_chr_open() */
 
@@ -544,13 +558,13 @@
  *
  */
 static int lvm_chr_ioctl(struct inode *inode, struct file *file,
-		  uint command, ulong a)
+			 uint command, ulong a)
 {
 	int minor = minor(inode->i_rdev);
 	uint extendable, l, v;
 	void *arg = (void *) a;
-	userlv_t ulv;
-	vg_t* vg_ptr = vg[VG_CHR(minor)];
+	user_lv_t ulv;
+	kern_vg_t* vg_ptr = vg[VG_CHR(minor)];
 
 	/* otherwise cc will complain about unused variables */
 	(void) lvm_lock;
@@ -597,7 +611,8 @@
 
 	case LE_REMAP:
 		/* remap a logical extent (after moving the physical extent) */
-		return lvm_do_le_remap(vg_ptr,arg);
+		return -ENOSYS;
+//		return lvm_do_le_remap(vg_ptr,arg);
 
 	case PE_LOCK_UNLOCK:
 		/* lock/unlock i/o to a physical extent to move it to another
@@ -608,10 +623,10 @@
 		/* create a VGDA */
 		return lvm_do_vg_create(arg, minor);
 
-       case VG_CREATE:
-               /* create a VGDA, assume VG number is filled in */
+	case VG_CREATE:
+		/* create a VGDA, assume VG number is filled in */
 		return lvm_do_vg_create(arg, -1);
-
+		
 	case VG_EXTEND:
 		/* extend a volume group */
 		return lvm_do_vg_extend(vg_ptr, arg);
@@ -645,14 +660,23 @@
 		return 0;
 
 
-	case VG_STATUS:
+	case VG_STATUS:{
+		user_vg_t *tmpuvg;
 		/* get volume group data (only the vg_t struct) */
 		if (vg_ptr == NULL) return -ENXIO;
-		if (copy_to_user(arg, vg_ptr, sizeof(vg_t)) != 0)
+
+		tmpuvg=kmalloc(sizeof(user_vg_t),GFP_KERNEL);
+		if(tmpuvg==NULL){
+			return -ENOMEM;
+		}
+                kernvg_to_uservg(vg_ptr,tmpuvg);
+		if(copy_to_user(arg,tmpuvg,sizeof(user_vg_t))!=0){
 			return -EFAULT;
+		}
+		kfree(tmpuvg);
 		return 0;
 
-
+	}
 	case VG_STATUS_GET_COUNT:
 		/* get volume group count */
 		if (copy_to_user(arg, &vg_count, sizeof(vg_count)) != 0)
@@ -685,7 +709,7 @@
 			return -EFAULT;
 
 		if (command != LV_REMOVE) {
-			if (copy_from_user(&ulv, lv_req.lv, sizeof(userlv_t)) != 0)
+			if (copy_from_user(&ulv, lv_req.lv, sizeof(user_lv_t)) != 0)
 				return -EFAULT;
 		}
 		switch (command) {
@@ -694,7 +718,7 @@
 
 		case LV_EXTEND:
 		case LV_REDUCE:
-			return lvm_do_lv_extend_reduce(minor, lv_req.lv_name, &ulv);
+			return -ENOSYS;//lvm_do_lv_extend_reduce(minor, lv_req.lv_name, &ulv);
 		case LV_REMOVE:
 			return lvm_do_lv_remove(minor, lv_req.lv_name, -1);
 
@@ -793,8 +817,8 @@
 static int lvm_blk_open(struct inode *inode, struct file *file)
 {
 	int minor = minor(inode->i_rdev);
-	lv_t *lv_ptr;
-	vg_t *vg_ptr = vg[VG_BLK(minor)];
+	kern_lv_t *lv_ptr;
+	kern_vg_t *vg_ptr = vg[VG_BLK(minor)];
 
 	P_DEV("blk_open MINOR: %d  VG#: %d  LV#: %d  mode: %s%s\n",
 	      minor, VG_BLK(minor), LV_BLK(minor), MODE_TO_STR(file->f_mode));
@@ -811,23 +835,23 @@
 	    LV_BLK(minor) < vg_ptr->lv_max) {
 
 		/* Check parallel LV spindown (LV remove) */
-		if (lv_ptr->u.lv_status & LV_SPINDOWN) return -EPERM;
+		if (lv_ptr->lv_status & LV_SPINDOWN) return -EPERM;
 
 		/* Check inactive LV and open for read/write */
 		/* We need to be able to "read" an inactive LV
 		   to re-activate it again */
 		if ((file->f_mode & FMODE_WRITE) &&
-		    (!(lv_ptr->u.lv_status & LV_ACTIVE)))
+		    (!(lv_ptr->lv_status & LV_ACTIVE)))
 		    return -EPERM;
 
-		if (!(lv_ptr->u.lv_access & LV_WRITE) &&
+		if (!(lv_ptr->lv_access & LV_WRITE) &&
 		    (file->f_mode & FMODE_WRITE))
 			return -EACCES;
 
 
                 /* be sure to increment VG counter */
-		if (lv_ptr->u.lv_open == 0) vg_ptr->lv_open++;
-		lv_ptr->u.lv_open++;
+		if (lv_ptr->lv_open == 0) vg_ptr->lv_open++;
+		lv_ptr->lv_open++;
 
 		MOD_INC_USE_COUNT;
 
@@ -846,8 +870,8 @@
 			 uint command, ulong a)
 {
 	int minor = minor(inode->i_rdev);
-	vg_t *vg_ptr = vg[VG_BLK(minor)];
-	lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
+	kern_vg_t *vg_ptr = vg[VG_BLK(minor)];
+	kern_lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
 	void *arg = (void *) a;
 	struct hd_geometry *hd = (struct hd_geometry *) a;
 
@@ -862,13 +886,13 @@
 
 	case BLKGETSIZE:
 		/* return device size */
-		P_IOCTL("BLKGETSIZE: %u\n", lv_ptr->u.lv_size);
-		if (put_user(lv_ptr->u.lv_size, (unsigned long *)arg))
+		P_IOCTL("BLKGETSIZE: %u\n", lv_ptr->lv_size);
+		if (put_user(lv_ptr->lv_size, (unsigned long *)arg))
 			return -EFAULT;
 		break;
 
 	case BLKGETSIZE64:
-		if (put_user((u64)lv_ptr->u.lv_size << 9, (u64 *)arg))
+		if (put_user((u64)lv_ptr->lv_size << 9, (u64 *)arg))
 			return -EFAULT;
 		break;
 
@@ -892,7 +916,7 @@
 			unsigned char heads = 64;
 			unsigned char sectors = 32;
 			long start = 0;
-			short cylinders = lv_ptr->u.lv_size / heads / sectors;
+			short cylinders = lv_ptr->lv_size / heads / sectors;
 
 			if (copy_to_user((char *) &hd->heads, &heads,
 					 sizeof(heads)) != 0 ||
@@ -913,34 +937,36 @@
 	case LV_SET_ACCESS:
 		/* set access flags of a logical volume */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		lv_ptr->u.lv_access = (ulong) arg;
-		if ( lv_ptr->u.lv_access & LV_WRITE)
-			set_device_ro(lv_ptr->u.lv_dev, 0);
+		lv_ptr->lv_access = (ulong) arg;
+		if ( lv_ptr->lv_access & LV_WRITE)
+			set_device_ro(lv_ptr->lv_kdev, 0);
 		else
-			set_device_ro(lv_ptr->u.lv_dev, 1);
+			set_device_ro(lv_ptr->lv_kdev, 1);
 		break;
 
 
 	case LV_SET_STATUS:
 		/* set status flags of a logical volume */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		if (!((ulong) arg & LV_ACTIVE) && lv_ptr->u.lv_open > 1)
+		if (!((ulong) arg & LV_ACTIVE) && lv_ptr->lv_open > 1)
 			return -EPERM;
-		lv_ptr->u.lv_status = (ulong) arg;
+		lv_ptr->lv_status = (ulong) arg;
 		break;
 
 	case LV_BMAP:
+		/* BROKEN */
+		return -ENOSYS; /*lvm_user_bmap(inode, (struct lv_bmap *) arg);*/
+
+
                 /* turn logical block into (dev_t, block).  non privileged. */
                 /* don't bmap a snapshot, since the mapping can change */
-		if(lv_ptr->u.lv_access & LV_SNAPSHOT)
+		if(lv_ptr->lv_access & LV_SNAPSHOT)
 			return -EPERM;
 
-		return lvm_user_bmap(inode, (struct lv_bmap *) arg);
-
 	case LV_SET_ALLOCATION:
 		/* set allocation flags of a logical volume */
 		if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-		lv_ptr->u.lv_allocation = (ulong) arg;
+		lv_ptr->lv_allocation = (ulong) arg;
 		break;
 
 	case LV_SNAPSHOT_USE_RATE:
@@ -963,26 +989,26 @@
 static int lvm_blk_close(struct inode *inode, struct file *file)
 {
 	int minor = minor(inode->i_rdev);
-	vg_t *vg_ptr = vg[VG_BLK(minor)];
-	lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
+	kern_vg_t *vg_ptr = vg[VG_BLK(minor)];
+	kern_lv_t *lv_ptr = vg_ptr->lv[LV_BLK(minor)];
 
 	P_DEV("blk_close MINOR: %d  VG#: %d  LV#: %d\n",
 	      minor, VG_BLK(minor), LV_BLK(minor));
 
-	if (lv_ptr->u.lv_open == 1) vg_ptr->lv_open--;
-	lv_ptr->u.lv_open--;
+	if (lv_ptr->lv_open == 1) vg_ptr->lv_open--;
+	lv_ptr->lv_open--;
 
 	MOD_DEC_USE_COUNT;
 
 	return 0;
 } /* lvm_blk_close() */
 
-static int lvm_get_snapshot_use_rate(lv_t *lv, void *arg)
+static int lvm_get_snapshot_use_rate(kern_lv_t *lv, void *arg)
 {
 	lv_snapshot_use_rate_req_t lv_rate_req;
 
-	if (!(lv->u.lv_access & LV_SNAPSHOT))
-		return -EPERM;
+	if (!(lv->lv_access & LV_SNAPSHOT))
+		return -EPERM; /* PERM?? INVAL*/
 
 	if (copy_from_user(&lv_rate_req, arg, sizeof(lv_rate_req)))
 		return -EFAULT;
@@ -993,7 +1019,7 @@
 	switch (lv_rate_req.block) {
 	case 0:
 		lv->lv_snapshot_use_rate = lv_rate_req.rate;
-		if (lv->u.lv_remap_ptr * 100 / lv->u.lv_remap_end <
+		if (lv->lv_remap_ptr * 100 / lv->lv_remap_end <
 		    lv->lv_snapshot_use_rate)
 			interruptible_sleep_on(&lv->lv_snapshot_wait);
 		break;
@@ -1004,12 +1030,12 @@
 	default:
 		return -EINVAL;
 	}
-	lv_rate_req.rate = lv->u.lv_remap_ptr * 100 / lv->u.lv_remap_end;
+	lv_rate_req.rate = lv->lv_remap_ptr * 100 / lv->lv_remap_end;
 
 	return copy_to_user(arg, &lv_rate_req,
 			    sizeof(lv_rate_req)) ? -EFAULT : 0;
 }
-
+/*
 static int lvm_user_bmap(struct inode *inode, struct lv_bmap *user_result)
 {
 	struct bio bio;
@@ -1020,8 +1046,8 @@
 		return -EFAULT;
 
 	memset(&bio,0,sizeof(bio));
-	bio.bi_dev = inode->i_rdev;
-	bio.bi_size = block_size(bio.bi_dev); /* NEEDED by bio_sectors */
+	bio.bi_bdev = inode->i_bdev;
+	bio.bi_size = block_size(bio.bi_bdev); / NEEDED by bio_sectors /
  	bio.bi_sector = block * bio_sectors(&bio);
 	bio.bi_rw = READ;
 	if ((err=lvm_map(&bio)) < 0)  {
@@ -1029,12 +1055,12 @@
 		return -EINVAL;
 	}
 
-	return put_user(kdev_t_to_nr(bio.bi_dev), &user_result->lv_dev) ||
+	return put_user(kdev_t_to_nr(bio.bi_bdev), &user_result->lv_dev) ||
 	       put_user(bio.bi_sector/bio_sectors(&bio), &user_result->lv_block) ?
 	       -EFAULT : 0;
 }
-
-
+*/
+#ifdef BROKEN
 /*
  * block device support function for /usr/src/linux/drivers/block/ll_rw_blk.c
  * (see init_module/lvm_init)
@@ -1067,20 +1093,20 @@
 		/* we haven't yet copied this block to the snapshot */
 		__remap_snapshot(rdev, rsector, pe_start, lv, vg);
 }
-
+#endif
 
 /*
  * extents destined for a pe that is on the move should be deferred
  */
-static inline int _should_defer(kdev_t pv, ulong sector, uint32_t pe_size) {
+static inline int _should_defer(struct block_device *pv, ulong sector, uint32_t pe_size) {
 	return ((pe_lock_req.lock == LOCK_PE) &&
-		kdev_same(pv, pe_lock_req.data.pv_dev) &&
+		kdev_same(to_kdev_t(pv->bd_dev), pe_lock_req.data.pv_dev) &&
 		(sector >= pe_lock_req.data.pv_offset) &&
 		(sector < (pe_lock_req.data.pv_offset + pe_size)));
 }
 
 static inline int _defer_extent(struct bio *bh, int rw,
-				kdev_t pv, ulong sector, uint32_t pe_size)
+				struct block_device *pv, ulong sector, uint32_t pe_size)
 {
 	if (pe_lock_req.lock == LOCK_PE) {
 		down_read(&_pe_lock);
@@ -1097,32 +1123,31 @@
 	return 0;
 }
 
-static int lvm_map(struct bio *bi)
-{
-	int minor = minor(bi->bi_dev);
+static int lvm_map(struct bio *bi){
+	int minor = minor(to_kdev_t(bi->bi_bdev->bd_dev));
 	ulong index;
 	ulong pe_start;
 	ulong size = bio_sectors(bi);
 	ulong rsector_org = bi->bi_sector;
 	ulong rsector_map;
-	kdev_t rdev_map;
-	vg_t *vg_this = vg[VG_BLK(minor)];
-	lv_t *lv = vg_this->lv[LV_BLK(minor)];
+	struct block_device *rbd_map;
+	kern_vg_t *vg_this = vg[VG_BLK(minor)];
+	kern_lv_t *lv = vg_this->lv[LV_BLK(minor)];
 	int rw = bio_rw(bi);
 
 	down_read(&lv->lv_lock);
-	if (!(lv->u.lv_status & LV_ACTIVE)) {
+	if (!(lv->lv_status & LV_ACTIVE)) {
 		printk(KERN_ALERT
 		       "%s - lvm_map: ll_rw_blk for inactive LV %s\n",
-		       lvm_name, lv->u.lv_name);
+		       lvm_name, lv->lv_name);
 		goto bad;
 	}
 
 	if ((rw == WRITE || rw == WRITEA) &&
-	    !(lv->u.lv_access & LV_WRITE)) {
+	    !(lv->lv_access & LV_WRITE)) {
 		printk(KERN_CRIT
 		       "%s - lvm_map: ll_rw_blk write for readonly LV %s\n",
-		       lvm_name, lv->u.lv_name);
+		       lvm_name, lv->lv_name);
 		goto bad;
 	}
 
@@ -1131,7 +1156,7 @@
 	      kdevname(bi->bi_dev),
 	      rsector_org, size);
 
-	if (rsector_org + size > lv->u.lv_size) {
+	if (rsector_org + size > lv->lv_size) {
 		printk(KERN_ALERT
 		       "%s - lvm_map access beyond end of device; *rsector: "
                        "%lu or size: %lu wrong for minor: %2d\n",
@@ -1140,39 +1165,39 @@
 	}
 
 
-	if (lv->u.lv_stripes < 2) { /* linear mapping */
+	if (lv->lv_stripes < 2) { /* linear mapping */
 		/* get the index */
 		index = rsector_org / vg_this->pe_size;
-		pe_start = lv->u.lv_current_pe[index].pe;
-		rsector_map = lv->u.lv_current_pe[index].pe +
+		pe_start = lv->lv_current_pe[index].pe;
+		rsector_map = lv->lv_current_pe[index].pe +
 			(rsector_org % vg_this->pe_size);
-		rdev_map = lv->u.lv_current_pe[index].dev;
+		rbd_map = lv->lv_current_pe[index].bdev;
 
 		P_MAP("u.lv_current_pe[%ld].pe: %d  rdev: %s  rsector:%ld\n",
-		      index, lv->u.lv_current_pe[index].pe,
+		      index, lv->lv_current_pe[index].pe,
 		      kdevname(rdev_map), rsector_map);
 
 	} else {		/* striped mapping */
 		ulong stripe_index;
 		ulong stripe_length;
 
-		stripe_length = vg_this->pe_size * lv->u.lv_stripes;
+		stripe_length = vg_this->pe_size * lv->lv_stripes;
 		stripe_index = (rsector_org % stripe_length) /
-			lv->u.lv_stripesize;
+			lv->lv_stripesize;
 		index = rsector_org / stripe_length +
-			(stripe_index % lv->u.lv_stripes) *
-			(lv->u.lv_allocated_le / lv->u.lv_stripes);
-		pe_start = lv->u.lv_current_pe[index].pe;
-		rsector_map = lv->u.lv_current_pe[index].pe +
+			(stripe_index % lv->lv_stripes) *
+			(lv->lv_allocated_le / lv->lv_stripes);
+		pe_start = lv->lv_current_pe[index].pe;
+		rsector_map = lv->lv_current_pe[index].pe +
 			(rsector_org % stripe_length) -
-			(stripe_index % lv->u.lv_stripes) * lv->u.lv_stripesize -
-			stripe_index / lv->u.lv_stripes *
-			(lv->u.lv_stripes - 1) * lv->u.lv_stripesize;
-		rdev_map = lv->u.lv_current_pe[index].dev;
+			(stripe_index % lv->lv_stripes) * lv->lv_stripesize -
+			stripe_index / lv->lv_stripes *
+			(lv->lv_stripes - 1) * lv->lv_stripesize;
+		rbd_map = lv->lv_current_pe[index].bdev;
 
 		P_MAP("u.lv_current_pe[%ld].pe: %d  rdev: %s  rsector:%ld\n"
 		      "stripe_length: %ld  stripe_index: %ld\n",
-		      index, lv->u.lv_current_pe[index].pe, kdevname(rdev_map),
+		      index, lv->lv_current_pe[index].pe, kdevname(rdev_map),
 		      rsector_map, stripe_length, stripe_index);
 	}
 
@@ -1182,24 +1207,24 @@
 	 * we need to queue this request, because this is in the fast path.
 	 */
 	if (rw == WRITE || rw == WRITEA) {
-		if(_defer_extent(bi, rw, rdev_map,
+		if(_defer_extent(bi, rw, rbd_map,
 				 rsector_map, vg_this->pe_size)) {
 
 			up_read(&lv->lv_lock);
 			return 0;
 		}
 
-		lv->u.lv_current_pe[index].writes++;	/* statistic */
+		lv->lv_current_pe[index].writes++;	/* statistic */
 	} else
-		lv->u.lv_current_pe[index].reads++;	/* statistic */
+		lv->lv_current_pe[index].reads++;	/* statistic */
 
 	/* snapshot volume exception handling on physical device address base */
-	if (!(lv->u.lv_access & (LV_SNAPSHOT|LV_SNAPSHOT_ORG)))
+	if (!(lv->lv_access & (LV_SNAPSHOT|LV_SNAPSHOT_ORG)))
 		goto out;
-
+#ifdef BROKEN
 	if (lv->u.lv_access & LV_SNAPSHOT) { /* remap snapshot */
 		if (lv->u.lv_block_exception)
-			lvm_snapshot_remap_block(&rdev_map, &rsector_map,
+			lvm_snapshot_remap_block(&rbd_map, &rsector_map,
 						 pe_start, lv);
 		else
 			goto bad;
@@ -1217,13 +1242,13 @@
 
 			/* Serializes the COW with the accesses to the
 			   snapshot device */
-			_remap_snapshot(rdev_map, rsector_map,
+			_remap_snapshot(rbd_map, rsector_map,
 					 pe_start, snap, vg_this);
 		}
  	}
-
+#endif
  out:
-	bi->bi_dev = rdev_map;
+	bi->bi_bdev = rbd_map;
 	bi->bi_sector = rsector_map;
 	up_read(&lv->lv_lock);
 	return 1;
@@ -1302,7 +1327,7 @@
 /*
  * character device support function lock/unlock physical extend
  */
-static int lvm_do_pe_lock_unlock(vg_t *vg_ptr, void *arg)
+static int lvm_do_pe_lock_unlock(kern_vg_t *vg_ptr, void *arg)
 {
 	pe_lock_req_t new_lock;
 	struct bio *bh;
@@ -1317,7 +1342,7 @@
 		for (p = 0; p < vg_ptr->pv_max; p++) {
 			if (vg_ptr->pv[p] != NULL &&
 			    kdev_same(new_lock.data.pv_dev,
-				      vg_ptr->pv[p]->pv_dev))
+				      vg_ptr->pv[p]->pv_kdev))
 				break;
 		}
 		if (p == vg_ptr->pv_max) return -ENXIO;
@@ -1367,14 +1392,14 @@
 	return 0;
 }
 
-
+#ifdef BROKEN
 /*
  * character device support function logical extend remap
  */
-static int lvm_do_le_remap(vg_t *vg_ptr, void *arg)
+static int lvm_do_le_remap(kern_vg_t *vg_ptr, void *arg)
 {
 	uint l, le;
-	lv_t *lv_ptr;
+	kern_lv_t *lv_ptr;
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(&le_remap_req, arg,
@@ -1387,7 +1412,7 @@
 		    strcmp(lv_ptr->u.lv_name,
 			       le_remap_req.lv_name) == 0) {
 			for (le = 0; le < lv_ptr->u.lv_allocated_le; le++) {
-			  if (kdev_same(lv_ptr->u.lv_current_pe[le].dev,
+			  if (kdev_same(lv_ptr->u.lv_current_pe[le].bdev,
 					le_remap_req.old_dev) &&
 				    lv_ptr->u.lv_current_pe[le].pe ==
 				    le_remap_req.old_pe) {
@@ -1405,6 +1430,172 @@
 	}
 	return -ENXIO;
 } /* lvm_do_le_remap() */
+#endif
+
+static void userlv_to_kernlv(const user_lv_t *const ulv,kern_lv_t *const klv){
+	memcpy(klv->vg_name,ulv->vg_name,NAME_LEN);
+	memcpy(klv->lv_name,ulv->lv_name,NAME_LEN);
+	klv->lv_access=ulv->lv_access;
+	klv->lv_status=ulv->lv_status;
+	klv->lv_open=ulv->lv_open;
+	klv->lv_kdev=to_kdev_t(ulv->lv_dev);
+	klv->lv_number=ulv->lv_number;
+	klv->lv_size=ulv->lv_size;
+	klv->lv_current_pe=NULL;
+	klv->lv_allocated_le=ulv->lv_allocated_le;
+	klv->lv_current_le=ulv->lv_current_le;
+	klv->lv_stripes=ulv->lv_stripes;
+	klv->lv_stripesize=ulv->lv_stripesize;
+	klv->lv_iobuf=NULL;
+	klv->lv_COW_table_iobuf=NULL;
+	init_rwsem(&klv->lv_lock);
+	klv->lv_snapshot_hash_table=NULL;
+	klv->lv_snapshot_hash_table_size=0;
+	klv->lv_snapshot_hash_mask=0;
+/*
+	klv->lv_snapshot_wait=NULL;  */
+	klv->lv_snapshot_use_rate=0;
+	klv->vg=NULL;
+	klv->lv_allocated_snapshot_le=0;
+	klv->lv_snapshot_org=NULL;
+	klv->lv_snapshot_prev=NULL;
+	klv->lv_snapshot_next=NULL;
+	klv->lv_block_exception=NULL;
+	klv->lv_remap_ptr=0;
+	klv->lv_remap_end=0;
+	klv->lv_chunk_size=0;
+}
+
+static void kernlv_to_userlv(const kern_lv_t *const klv,user_lv_t *const ulv){
+	memcpy(ulv->vg_name,klv->vg_name,NAME_LEN);
+	memcpy(ulv->lv_name,klv->lv_name,NAME_LEN);
+	ulv->lv_access=klv->lv_access;
+	ulv->lv_status=klv->lv_status;
+	ulv->lv_open=klv->lv_open;
+	ulv->lv_dev=kdev_t_to_nr(klv->lv_kdev);
+	ulv->lv_number=klv->lv_number;
+	ulv->lv_size=klv->lv_size;
+	ulv->lv_allocated_le=klv->lv_allocated_le;
+	ulv->lv_current_le=klv->lv_current_le;
+	ulv->lv_stripes=klv->lv_stripes;
+	ulv->lv_stripesize=klv->lv_stripesize;
+}
+
+static void uservg_to_kernvg(const user_vg_t *const uvg,kern_vg_t *const kvg){
+	int i;
+	memcpy(kvg->vg_name,uvg->vg_name,NAME_LEN);
+	kvg->vg_number=uvg->vg_number;
+	kvg->vg_access=uvg->vg_access;
+	kvg->vg_status=uvg->vg_status;
+	kvg->lv_max=uvg->lv_max;
+	kvg->lv_cur=uvg->lv_cur;
+	kvg->lv_open=uvg->lv_open;
+	kvg->pv_max=uvg->pv_max;
+	kvg->pv_cur=uvg->pv_cur;
+	kvg->pv_act=uvg->pv_act;
+	kvg->dummy=0;
+	kvg->vgda=uvg->vgda;
+	kvg->pe_size=uvg->pe_size;
+	kvg->pe_total=uvg->pe_total;
+	kvg->pe_allocated=uvg->pe_allocated;
+	kvg->pvg_total=uvg->pvg_total;
+	kvg->proc=NULL;
+	for(i=0;i<ABS_MAX_PV+1;i++){
+		kvg->pv[i]=NULL;
+	}
+	for(i=0;i<ABS_MAX_LV+1;i++){
+		kvg->lv[i]=NULL;
+	}
+	memcpy(kvg->vg_uuid,uvg->vg_uuid,UUID_LEN+1);
+
+	kvg->vg_dir_pde=NULL;
+	kvg->lv_subdir_pde=NULL;
+	kvg->pv_subdir_pde=NULL;
+	
+}
+
+
+static void kernvg_to_uservg(const kern_vg_t *const kvg,user_vg_t *const uvg){
+	int i;
+	memcpy(uvg->vg_name,kvg->vg_name,NAME_LEN);
+	uvg->vg_number=kvg->vg_number;
+	uvg->vg_access=kvg->vg_access;
+	uvg->vg_status=kvg->vg_status;
+	uvg->lv_max=kvg->lv_max;
+	uvg->lv_cur=kvg->lv_cur;
+	uvg->lv_open=kvg->lv_open;
+	uvg->pv_max=kvg->pv_max;
+	uvg->pv_cur=kvg->pv_cur;
+	uvg->pv_act=kvg->pv_act;
+	uvg->dummy=0;
+	uvg->vgda=kvg->vgda;
+	uvg->pe_size=kvg->pe_size;
+	uvg->pe_total=kvg->pe_total;
+	uvg->pe_allocated=kvg->pe_allocated;
+	uvg->pvg_total=kvg->pvg_total;
+	for(i=0;i<ABS_MAX_LV+1;i++){
+		uvg->lv[i]=(user_lv_t *)0xDEADBEEF;
+	}
+	for(i=0;i<ABS_MAX_PV+1;i++){
+		uvg->pv[i]=(user_pv_t *)0xDEADC0DE;
+	}
+
+	memcpy(uvg->vg_uuid,kvg->vg_uuid,UUID_LEN+1);
+}
+
+static void userpv_to_kernpv(const user_pv_t *const upv,kern_pv_t *const kpv){
+	kpv->id[0]=upv->id[0];
+	kpv->id[1]=upv->id[1];
+	kpv->version=upv->version;
+	memcpy(&kpv->pv_on_disk,&upv->pv_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&kpv->vg_on_disk,&upv->vg_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&kpv->pv_uuidlist_on_disk,&upv->pv_uuidlist_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&kpv->lv_on_disk,&upv->lv_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&kpv->pe_on_disk,&upv->pe_on_disk,sizeof(lvm_disk_data_t));
+
+	memcpy(&kpv->pv_name,&upv->pv_name,NAME_LEN);
+	memcpy(&kpv->vg_name,&upv->vg_name,NAME_LEN);
+	memcpy(&kpv->system_id,&upv->system_id,NAME_LEN);
+	kpv->pv_kdev=to_kdev_t(upv->pv_dev);
+	kpv->pv_number=upv->pv_number;
+	kpv->pv_status =upv->pv_status;
+	kpv->pv_allocatable =upv->pv_allocatable;
+	kpv->pv_size =upv->pv_size;
+        kpv->lv_cur =upv->lv_cur;
+	kpv->pe_size =upv->pe_size;
+	kpv->pe_total =upv->pe_total;
+	kpv->pe_allocated =upv->pe_allocated;
+	kpv->pe_stale =upv->pe_stale;
+	kpv->pe=NULL;
+	kpv->bd=NULL;
+	memcpy(kpv->pv_uuid,upv->pv_uuid,UUID_LEN+1);
+}
+
+static void kernpv_to_userpv(const kern_pv_t *const kpv, user_pv_t *const upv){
+	upv->id[0]=kpv->id[0];
+	upv->id[1]=kpv->id[1];
+	upv->version=kpv->version;
+	memcpy(&upv->pv_on_disk,&kpv->pv_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&upv->vg_on_disk,&kpv->vg_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&upv->pv_uuidlist_on_disk,&kpv->pv_uuidlist_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&upv->lv_on_disk,&kpv->lv_on_disk,sizeof(lvm_disk_data_t));
+	memcpy(&upv->pe_on_disk,&kpv->pe_on_disk,sizeof(lvm_disk_data_t));
+
+	memcpy(&upv->pv_name,&kpv->pv_name,NAME_LEN);
+	memcpy(&upv->vg_name,&kpv->vg_name,NAME_LEN);
+	memcpy(&upv->system_id,&kpv->system_id,NAME_LEN);
+	upv->pv_dev=kdev_t_to_nr(kpv->pv_kdev);
+	upv->pv_number=kpv->pv_number;
+	upv->pv_status =kpv->pv_status;
+	upv->pv_allocatable =kpv->pv_allocatable;
+	upv->pv_size =kpv->pv_size;
+        upv->lv_cur =kpv->lv_cur;
+	upv->pe_size =kpv->pe_size;
+	upv->pe_total =kpv->pe_total;
+	upv->pe_allocated =kpv->pe_allocated;
+	upv->pe_stale =kpv->pe_stale;
+	memcpy(upv->pv_uuid,kpv->pv_uuid,UUID_LEN+1);
+}
 
 
 /*
@@ -1414,26 +1605,31 @@
 {
 	int ret = 0;
 	ulong l, ls = 0, p, size;
-	vg_t *vg_ptr;
-	lv_t **snap_lv_ptr;
-	lv_t *tmplv;
+	kern_vg_t *vg_ptr;
+	kern_lv_t **snap_lv_ptr;
+	user_vg_t *tmpuvg;
+	user_lv_t *tmpulv;
+
+	tmpuvg=kmalloc(sizeof(user_vg_t),GFP_KERNEL);
 
-	if ((vg_ptr = kmalloc(sizeof(vg_t),GFP_KERNEL)) == NULL) {
+	/* this will be our new vg */
+	if ((vg_ptr = kmalloc(sizeof(kern_vg_t),GFP_KERNEL)) == NULL) {
 		printk(KERN_CRIT
 		       "%s -- VG_CREATE: kmalloc error VG at line %d\n",
 		       lvm_name, __LINE__);
 		return -ENOMEM;
 	}
 
-	/* get the volume group structure */
-	if (copy_from_user(vg_ptr, arg, sizeof(vg_t)) != 0) {
+	/* copy userdata into kernspace */
+	if (copy_from_user(tmpuvg, arg, sizeof(user_vg_t)) != 0) {
 		P_IOCTL("lvm_do_vg_create ERROR: copy VG ptr %p (%d bytes)\n",
 			arg, sizeof(vg_t));
 		kfree(vg_ptr);
 		return -EFAULT;
 	}
 
-
+	/* set up as much as possible from user_vg_t */
+	uservg_to_kernvg(tmpuvg,vg_ptr);
 
         /* VG_CREATE now uses minor number in VG structure */
         if (minor == -1) minor = vg_ptr->vg_number;
@@ -1473,10 +1669,16 @@
 	/* get the physical volume structures */
 	vg_ptr->pv_act = vg_ptr->pv_cur = 0;
 	for (p = 0; p < vg_ptr->pv_max; p++) {
-		pv_t *pvp;
+		user_pv_t tmpupv;
+
 		/* user space address */
-		if ((pvp = vg_ptr->pv[p]) != NULL) {
-			ret = lvm_do_pv_create(pvp, vg_ptr, p);
+		if(tmpuvg->pv[p]!=NULL){
+			if (copy_from_user(&tmpupv, tmpuvg->pv[p], sizeof(user_pv_t)) != 0) {
+				P_IOCTL("lvm_do_pv_create ERROR: copy PV ptr %p (%d bytes)\n",
+					tmpuvg->pv[p], sizeof(user_pv_t));
+				return -EFAULT;
+			}
+			ret = lvm_do_pv_create(&tmpupv, vg_ptr, p);
 			if ( ret != 0) {
 				lvm_do_vg_remove(minor);
 				return ret;
@@ -1484,7 +1686,7 @@
 		}
 	}
 
-	size = vg_ptr->lv_max * sizeof(lv_t *);
+	size = vg_ptr->lv_max * sizeof(kern_lv_t *);
 	if ((snap_lv_ptr = vmalloc ( size)) == NULL) {
 		printk(KERN_CRIT
 		       "%s -- VG_CREATE: vmalloc error snapshot LVs at line %d\n",
@@ -1494,7 +1696,7 @@
 	}
 	memset(snap_lv_ptr, 0, size);
 
-	if ((tmplv = kmalloc(sizeof(lv_t),GFP_KERNEL)) == NULL) {
+	if ((tmpulv = kmalloc(sizeof(user_lv_t),GFP_KERNEL)) == NULL) {
 		printk(KERN_CRIT
 		       "%s -- VG_CREATE: kmalloc error LV at line %d\n",
 		       lvm_name, __LINE__);
@@ -1505,30 +1707,32 @@
 	/* get the logical volume structures */
 	vg_ptr->lv_cur = 0;
 	for (l = 0; l < vg_ptr->lv_max; l++) {
-		lv_t *lvp;
-		
-		/* user space address */
-		if ((lvp = vg_ptr->lv[l]) != NULL) {
-			if (copy_from_user(tmplv, lvp, sizeof(userlv_t)) != 0) {
+		void *lvp; /* user space address */
+
+		if ((lvp = tmpuvg->lv[l]) != NULL) {
+
+			if (copy_from_user(tmpulv, lvp, sizeof(user_lv_t)) != 0) {
 				P_IOCTL("ERROR: copying LV ptr %p (%d bytes)\n",
 					lvp, sizeof(lv_t));
 				lvm_do_vg_remove(minor);
 				vfree(snap_lv_ptr);
-				kfree(tmplv);
+				kfree(tmpulv);
 				return -EFAULT;
 			}
-			if ( tmplv->u.lv_access & LV_SNAPSHOT) {
+
+			if ( tmpulv->lv_access & LV_SNAPSHOT) {
 				snap_lv_ptr[ls] = lvp;
 				vg_ptr->lv[l] = NULL;
 				ls++;
 				continue;
 			}
 			vg_ptr->lv[l] = NULL;
+
 			/* only create original logical volumes for now */
-			if (lvm_do_lv_create(minor, tmplv->u.lv_name, &tmplv->u) != 0) {
+			if (lvm_do_lv_create(minor, tmpulv->lv_name, tmpulv) != 0) {
 				lvm_do_vg_remove(minor);
 				vfree(snap_lv_ptr);
-				kfree(tmplv);
+				kfree(tmpulv);
 				return -EFAULT;
 			}
 		}
@@ -1536,24 +1740,25 @@
 
 	/* Second path to correct snapshot logical volumes which are not
 	   in place during first path above */
+#ifdef BROKEN
 	for (l = 0; l < ls; l++) {
 		lv_t *lvp = snap_lv_ptr[l];
-		if (copy_from_user(tmplv, lvp, sizeof(userlv_t)) != 0) {
+		if (copy_from_user(tmpulv, lvp, sizeof(user_lv_t)) != 0) {
 			lvm_do_vg_remove(minor);
 			vfree(snap_lv_ptr);
-			kfree(tmplv);
+			kfree(tmpulv);
 			return -EFAULT;
 		}
-		if (lvm_do_lv_create(minor, tmplv->u.lv_name, &tmplv->u) != 0) {
+		if (lvm_do_lv_create(minor, tmpulv->lv_name, tmpulv) != 0) {
 			lvm_do_vg_remove(minor);
 			vfree(snap_lv_ptr);
-			kfree(tmplv);
+			kfree(tmpulv);
 			return -EFAULT;
 		}
 	}
-
+#endif
 	vfree(snap_lv_ptr);
-	kfree(tmplv);
+	kfree(tmpulv);
 	vg_count++;
 
 
@@ -1569,17 +1774,26 @@
 /*
  * character device support function VGDA extend
  */
-static int lvm_do_vg_extend(vg_t *vg_ptr, void *arg)
+static int lvm_do_vg_extend(kern_vg_t *vg_ptr, void *arg)
 {
 	int ret = 0;
 	uint p;
-	pv_t *pv_ptr;
+	kern_pv_t *pv_ptr;
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (vg_ptr->pv_cur < vg_ptr->pv_max) {
 		for (p = 0; p < vg_ptr->pv_max; p++) {
 			if ( ( pv_ptr = vg_ptr->pv[p]) == NULL) {
-				ret = lvm_do_pv_create(arg, vg_ptr, p);
+				user_pv_t tmpupv;
+
+				/* user space address */
+				if (copy_from_user(&tmpupv, arg, sizeof(user_pv_t)) != 0) {
+					P_IOCTL("lvm_do_pv_create ERROR: copy PV ptr %p (%d bytes)\n",
+						arg, sizeof(user_pv_t));
+					return -EFAULT;
+				}
+				
+				ret = lvm_do_pv_create(&tmpupv, vg_ptr, p);
 				if ( ret != 0) return ret;
 				pv_ptr = vg_ptr->pv[p];
 				vg_ptr->pe_total += pv_ptr->pe_total;
@@ -1594,9 +1808,9 @@
 /*
  * character device support function VGDA reduce
  */
-static int lvm_do_vg_reduce(vg_t *vg_ptr, void *arg) {
+static int lvm_do_vg_reduce(kern_vg_t *vg_ptr, void *arg) {
 	uint p;
-	pv_t *pv_ptr;
+	kern_pv_t *pv_ptr;
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(pv_name, arg, sizeof(pv_name)) != 0)
@@ -1623,9 +1837,10 @@
 /*
  * character device support function VG rename
  */
-static int lvm_do_vg_rename(vg_t *vg_ptr, void *arg)
+static int lvm_do_vg_rename(kern_vg_t *vg_ptr, void *arg)
 {
-	int l = 0, p = 0, len = 0;
+	return -ENOSYS;
+/*	int l = 0, p = 0, len = 0;
 	char vg_name[NAME_LEN] = { 0,};
 	char lv_name[NAME_LEN] = { 0,};
 	char *ptr = NULL;
@@ -1643,15 +1858,15 @@
 	for ( l = 0; l < vg_ptr->lv_max; l++)
 	{
 		if ((lv_ptr = vg_ptr->lv[l]) == NULL) continue;
-		strncpy(lv_ptr->u.vg_name, vg_name, sizeof ( vg_name));
-		ptr = strrchr(lv_ptr->u.lv_name, '/');
-		if (ptr == NULL) ptr = lv_ptr->u.lv_name;
+		strncpy(lv_ptr->vg_name, vg_name, sizeof ( vg_name));
+		ptr = strrchr(lv_ptr->lv_name, '/');
+		if (ptr == NULL) ptr = lv_ptr->lv_name;
 		strncpy(lv_name, ptr, sizeof ( lv_name));
 		len = sizeof(LVM_DIR_PREFIX);
-		strcpy(lv_ptr->u.lv_name, LVM_DIR_PREFIX);
-		strncat(lv_ptr->u.lv_name, vg_name, NAME_LEN - len);
+		strcpy(lv_ptr->lv_name, LVM_DIR_PREFIX);
+		strncat(lv_ptr->lv_name, vg_name, NAME_LEN - len);
 		len += strlen ( vg_name);
-		strncat(lv_ptr->u.lv_name, lv_name, NAME_LEN - len);
+		strncat(lv_ptr->lv_name, lv_name, NAME_LEN - len);
 	}
 	for ( p = 0; p < vg_ptr->pv_max; p++)
 	{
@@ -1661,7 +1876,7 @@
 
 	lvm_fs_create_vg(vg_ptr);
 
-	return 0;
+	return 0;*/
 } /* lvm_do_vg_rename */
 
 
@@ -1671,8 +1886,8 @@
 static int lvm_do_vg_remove(int minor)
 {
 	int i;
-	vg_t *vg_ptr = vg[VG_CHR(minor)];
-	pv_t *pv_ptr;
+	kern_vg_t *vg_ptr = vg[VG_CHR(minor)];
+	kern_pv_t *pv_ptr;
 
 	if (vg_ptr == NULL) return -ENXIO;
 
@@ -1693,7 +1908,7 @@
 	/* first free snapshot logical volumes */
 	for (i = 0; i < vg_ptr->lv_max; i++) {
 		if (vg_ptr->lv[i] != NULL &&
-		    vg_ptr->lv[i]->u.lv_access & LV_SNAPSHOT) {
+		    vg_ptr->lv[i]->lv_access & LV_SNAPSHOT) {
 			lvm_do_lv_remove(minor, NULL, i);
 			current->state = TASK_UNINTERRUPTIBLE;
 			schedule_timeout(1);
@@ -1731,11 +1946,11 @@
 /*
  * character device support function physical volume create
  */
-static int lvm_do_pv_create(pv_t *pvp, vg_t *vg_ptr, ulong p) {
-	pv_t *pv;
+static int lvm_do_pv_create(user_pv_t *upv, kern_vg_t *vg_ptr, ulong p) {
+	kern_pv_t *pv;
 	int err;
 
-	pv = kmalloc(sizeof(pv_t),GFP_KERNEL);
+	pv = kmalloc(sizeof(kern_pv_t),GFP_KERNEL);
 	if (pv == NULL) {
 		printk(KERN_CRIT
 		       "%s -- PV_CREATE: kmalloc error PV at line %d\n",
@@ -1745,12 +1960,7 @@
 
 	memset(pv, 0, sizeof(*pv));
 
-	if (copy_from_user(pv, pvp, sizeof(pv_t)) != 0) {
-		P_IOCTL("lvm_do_pv_create ERROR: copy PV ptr %p (%d bytes)\n",
-			pvp, sizeof(pv_t));
-		kfree(pv);
-		return -EFAULT;
-	}
+	userpv_to_kernpv(upv,pv);
 
 	if ((err = _open_pv(pv))) {
 		kfree(pv);
@@ -1774,8 +1984,8 @@
 /*
  * character device support function physical volume remove
  */
-static int lvm_do_pv_remove(vg_t *vg_ptr, ulong p) {
-	pv_t *pv = vg_ptr->pv[p];
+static int lvm_do_pv_remove(kern_vg_t *vg_ptr, ulong p) {
+	kern_pv_t *pv = vg_ptr->pv[p];
 
 	lvm_fs_remove_pv(vg_ptr, pv);
 
@@ -1792,12 +2002,12 @@
 }
 
 
-static void __update_hardsectsize(lv_t *lv) {
+static void __update_hardsectsize(kern_lv_t *lv) {
 	int le, e;
 	int max_hardsectsize = 0, hardsectsize;
 
-	for (le = 0; le < lv->u.lv_allocated_le; le++) {
-		hardsectsize = get_hardsect_size(lv->u.lv_current_pe[le].dev);
+	for (le = 0; le < lv->lv_allocated_le; le++) {
+		hardsectsize = bdev_hardsect_size(lv->lv_current_pe[le].bdev);
 		if (hardsectsize == 0)
 			hardsectsize = 512;
 		if (hardsectsize > max_hardsectsize)
@@ -1805,10 +2015,10 @@
 	}
 
 	/* only perform this operation on active snapshots */
-	if ((lv->u.lv_access & LV_SNAPSHOT) &&
-	    (lv->u.lv_status & LV_ACTIVE)) {
-		for (e = 0; e < lv->u.lv_remap_end; e++) {
-			hardsectsize = get_hardsect_size( lv->u.lv_block_exception[e].rdev_new);
+	if ((lv->lv_access & LV_SNAPSHOT) &&
+	    (lv->lv_status & LV_ACTIVE)) {
+		for (e = 0; e < lv->lv_remap_end; e++) {
+			hardsectsize = get_hardsect_size( lv->lv_block_exception[e].rdev_new);
 			if (hardsectsize == 0)
 				hardsectsize = 512;
 			if (hardsectsize > max_hardsectsize)
@@ -1820,16 +2030,15 @@
 /*
  * character device support function logical volume create
  */
-static int lvm_do_lv_create(int minor, char *lv_name, userlv_t *ulv)
+static int lvm_do_lv_create(int minor, char *lv_name, user_lv_t *ulv)
 {
-	int e, ret, l, le, l_new, p, size, activate = 1;
+	int l, le, l_new, p, size, activate = 1;
 	ulong lv_status_save;
-	lv_block_exception_t *lvbe = ulv->lv_block_exception;
-	vg_t *vg_ptr = vg[VG_CHR(minor)];
-	lv_t *lv_ptr = NULL;
-	pe_t *pep;
+	kern_vg_t *vg_ptr = vg[VG_CHR(minor)];
+	kern_lv_t *lv_ptr = NULL;
+	void *user_pep;
 
-	if (!(pep = ulv->lv_current_pe))
+	if (!(user_pep = ulv->lv_current_pe))
 		return -EINVAL;
 
 	if (_sectors_to_k(ulv->lv_chunk_size) > LVM_SNAPSHOT_MAX_CHUNK)
@@ -1837,7 +2046,7 @@
 
 	for (l = 0; l < vg_ptr->lv_cur; l++) {
 		if (vg_ptr->lv[l] != NULL &&
-		    strcmp(vg_ptr->lv[l]->u.lv_name, lv_name) == 0)
+		    strcmp(vg_ptr->lv[l]->lv_name, lv_name) == 0)
 			return -EEXIST;
 	}
 
@@ -1854,37 +2063,28 @@
 	if (l_new == -1) return -EPERM;
 	else             l = l_new;
 
-	if ((lv_ptr = kmalloc(sizeof(lv_t),GFP_KERNEL)) == NULL) {;
+	if ((lv_ptr = kmalloc(sizeof(kern_lv_t),GFP_KERNEL)) == NULL) {;
 		printk(KERN_CRIT "%s -- LV_CREATE: kmalloc error LV at line %d\n",
 		       lvm_name, __LINE__);
 		return -ENOMEM;
 	}
-	/* copy preloaded LV */
-	memcpy((char *) lv_ptr, (char *) ulv, sizeof(userlv_t));
 
-	lv_status_save = lv_ptr->u.lv_status;
-	lv_ptr->u.lv_status &= ~LV_ACTIVE;
-	lv_ptr->u.lv_snapshot_org = NULL;
-	lv_ptr->u.lv_snapshot_prev = NULL;
-	lv_ptr->u.lv_snapshot_next = NULL;
-	lv_ptr->u.lv_block_exception = NULL;
-	lv_ptr->lv_iobuf = NULL;
-	lv_ptr->lv_COW_table_iobuf = NULL;
-	lv_ptr->lv_snapshot_hash_table = NULL;
-	lv_ptr->lv_snapshot_hash_table_size = 0;
-	lv_ptr->lv_snapshot_hash_mask = 0;
-	init_rwsem(&lv_ptr->lv_lock);
 
-	lv_ptr->lv_snapshot_use_rate = 0;
+	userlv_to_kernlv(ulv,lv_ptr);
+
+	lv_status_save = lv_ptr->lv_status;
+	lv_ptr->lv_status &= ~LV_ACTIVE;
 
 	vg_ptr->lv[l] = lv_ptr;
 
 	/* get the PE structures from user space if this
 	   is not a snapshot logical volume */
-	if (!(lv_ptr->u.lv_access & LV_SNAPSHOT)) {
-		size = lv_ptr->u.lv_allocated_le * sizeof(pe_t);
+	if (!(lv_ptr->lv_access & LV_SNAPSHOT)) {
+		user_pe_t tmpupe;
+
+		size = lv_ptr->lv_allocated_le * sizeof(kern_pe_t);
 
-		if ((lv_ptr->u.lv_current_pe = vmalloc(size)) == NULL) {
+		if ((lv_ptr->lv_current_pe = vmalloc(size)) == NULL) {
 			printk(KERN_CRIT
 			       "%s -- LV_CREATE: vmalloc error LV_CURRENT_PE of %d Byte "
 			       "at line %d\n",
@@ -1894,24 +2094,53 @@
 			vg_ptr->lv[l] = NULL;
 			return -ENOMEM;
 		}
-		if (copy_from_user(lv_ptr->u.lv_current_pe, pep, size)) {
-			P_IOCTL("ERROR: copying PE ptr %p (%d bytes)\n",
-				pep, sizeof(size));
-			vfree(lv_ptr->u.lv_current_pe);
-			kfree(lv_ptr);
-			vg_ptr->lv[l] = NULL;
-			return -EFAULT;
+
+		/* just to be sure */
+		memset(lv_ptr->lv_current_pe,0,size);
+
+		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
+			/* copy the pe's one by one */
+			if (copy_from_user(&tmpupe, user_pep+(le*sizeof(user_pe_t)), sizeof(user_pe_t))) {
+				P_IOCTL("ERROR: copying PE(%d) ptr %p (%d bytes)\n",
+					le,user_pep+(le*sizeof(user_pe_t)),
+					sizeof(user_lv_t));
+				vfree(lv_ptr->lv_current_pe);
+				kfree(lv_ptr);
+				vg_ptr->lv[l] = NULL;
+				return -EFAULT;
+			}
+			
+			lv_ptr->lv_current_pe[le].bdev = 
+				bdget(tmpupe.dev);
+			lv_ptr->lv_current_pe[le].pe = 
+				tmpupe.pe;
+			lv_ptr->lv_current_pe[le].reads =
+				tmpupe.reads;
+			lv_ptr->lv_current_pe[le].writes =
+				tmpupe.writes;
+			if(lv_ptr->lv_current_pe[le].bdev==NULL){
+				printk(KERN_CRIT "%s bdget failed\n",lvm_name);
+				vfree(lv_ptr->lv_current_pe);
+				kfree(lv_ptr);
+				return -EINVAL;
+			}
 		}
+		
+
 		/* correct the PE count in PVs */
-		for (le = 0; le < lv_ptr->u.lv_allocated_le; le++) {
+		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
 			vg_ptr->pe_allocated++;
 			for (p = 0; p < vg_ptr->pv_cur; p++) {
-				if (kdev_same(vg_ptr->pv[p]->pv_dev,
-					      lv_ptr->u.lv_current_pe[le].dev))
+				if (kdev_same(vg_ptr->pv[p]->pv_kdev,
+					      to_kdev_t(lv_ptr->lv_current_pe[le].bdev->bd_dev)))
 					vg_ptr->pv[p]->pe_allocated++;
 			}
 		}
-	} else {
+	} else { /* snapshot */
+		return -ENOSYS;
+#ifdef BROKEN	      
+/*	
+  void *lvbe = ulv->lv_block_exception; */
 		/* Get snapshot exception data and block list */
 		if (lvbe != NULL) {
 			lv_ptr->u.lv_snapshot_org =
@@ -2004,22 +2233,25 @@
 			vg_ptr->lv[l] = NULL;
 			return -EINVAL;
 		}
+#endif /* BROKEN */
 	} /* if ( vg[VG_CHR(minor)]->lv[l]->u.lv_access & LV_SNAPSHOT) */
 
+
 	lv_ptr = vg_ptr->lv[l];
-	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].start_sect = 0;
-	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].nr_sects = lv_ptr->u.lv_size;
-	lvm_size[minor(lv_ptr->u.lv_dev)] = lv_ptr->u.lv_size >> 1;
-	vg_lv_map[minor(lv_ptr->u.lv_dev)].vg_number = vg_ptr->vg_number;
-	vg_lv_map[minor(lv_ptr->u.lv_dev)].lv_number = lv_ptr->u.lv_number;
+	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].start_sect = 0;
+	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].nr_sects = lv_ptr->lv_size;
+	lvm_size[minor(lv_ptr->lv_kdev)] = lv_ptr->lv_size >> 1;
+	vg_lv_map[minor(lv_ptr->lv_kdev)].vg_number = vg_ptr->vg_number;
+	vg_lv_map[minor(lv_ptr->lv_kdev)].lv_number = lv_ptr->lv_number;
 	vg_ptr->lv_cur++;
-	lv_ptr->u.lv_status = lv_status_save;
+	lv_ptr->lv_status = lv_status_save;
 
 	__update_hardsectsize(lv_ptr);
 
 	/* optionally add our new snapshot LV */
-	if (lv_ptr->u.lv_access & LV_SNAPSHOT) {
-		lv_t *org = lv_ptr->u.lv_snapshot_org, *last;
+	if (lv_ptr->lv_access & LV_SNAPSHOT) {
+#ifdef BROKEN
+		lv_t *org = lv_ptr->lv_snapshot_org, *last;
 
 		/* sync the original logical volume */
 		fsync_dev(org->u.lv_dev);
@@ -2037,28 +2269,30 @@
 		lv_ptr->u.lv_snapshot_prev = last;
 		last->u.lv_snapshot_next = lv_ptr;
 		up_write(&org->lv_lock);
+#endif /* BROKEN */
 	}
 
 	/* activate the logical volume */
 	if(activate)
-		lv_ptr->u.lv_status |= LV_ACTIVE;
+		lv_ptr->lv_status |= LV_ACTIVE;
 	else
-		lv_ptr->u.lv_status &= ~LV_ACTIVE;
+		lv_ptr->lv_status &= ~LV_ACTIVE;
 
-	if ( lv_ptr->u.lv_access & LV_WRITE)
-		set_device_ro(lv_ptr->u.lv_dev, 0);
+	if ( lv_ptr->lv_access & LV_WRITE)
+		set_device_ro(lv_ptr->lv_kdev, 0);
 	else
-		set_device_ro(lv_ptr->u.lv_dev, 1);
+		set_device_ro(lv_ptr->lv_kdev, 1);
+
 
 #ifdef	LVM_VFS_ENHANCEMENT
 /* VFS function call to unlock the filesystem */
-	if (lv_ptr->u.lv_access & LV_SNAPSHOT)
-		unlockfs(lv_ptr->u.lv_snapshot_org->u.lv_dev);
+	if (lv_ptr->lv_access & LV_SNAPSHOT)
+		unlockfs(lv_ptr->lv_snapshot_org->lv_kdev);
 #endif
 
 	lv_ptr->vg = vg_ptr;
 
-	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].de =
+	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].de =
 		lvm_fs_create_lv(vg_ptr, lv_ptr);
 
 	return 0;
@@ -2071,13 +2305,13 @@
 static int lvm_do_lv_remove(int minor, char *lv_name, int l)
 {
 	uint le, p;
-	vg_t *vg_ptr = vg[VG_CHR(minor)];
-	lv_t *lv_ptr;
+	kern_vg_t *vg_ptr = vg[VG_CHR(minor)];
+	kern_lv_t *lv_ptr;
 
 	if (l == -1) {
 		for (l = 0; l < vg_ptr->lv_max; l++) {
 			if (vg_ptr->lv[l] != NULL &&
-			    strcmp(vg_ptr->lv[l]->u.lv_name, lv_name) == 0) {
+			    strcmp(vg_ptr->lv[l]->lv_name, lv_name) == 0) {
 				break;
 			}
 		}
@@ -2086,21 +2320,23 @@
 
 	lv_ptr = vg_ptr->lv[l];
 #ifdef LVM_TOTAL_RESET
-	if (lv_ptr->u.lv_open > 0 && lvm_reset_spindown == 0)
+	if (lv_ptr->lv_open > 0 && lvm_reset_spindown == 0)
 #else
-	if (lv_ptr->u.lv_open > 0)
+	if (lv_ptr->lv_open > 0)
 #endif
 		return -EBUSY;
 
 	/* check for deletion of snapshot source while
 	   snapshot volume still exists */
-	if ((lv_ptr->u.lv_access & LV_SNAPSHOT_ORG) &&
-	    lv_ptr->u.lv_snapshot_next != NULL)
+	if ((lv_ptr->lv_access & LV_SNAPSHOT_ORG) &&
+	    lv_ptr->lv_snapshot_next != NULL)
 		return -EPERM;
 
 	lvm_fs_remove_lv(vg_ptr, lv_ptr);
 
-	if (lv_ptr->u.lv_access & LV_SNAPSHOT) {
+	if (lv_ptr->lv_access & LV_SNAPSHOT) {
+		return -ENOSYS;
+#ifdef BROKEN
 		/*
 		 * Atomically make the the snapshot invisible
 		 * to the original lv before playing with it.
@@ -2125,43 +2361,44 @@
 
 		/* Update the VG PE(s) used by snapshot reserve space. */
 		vg_ptr->pe_allocated -= lv_ptr->lv_allocated_snapshot_le;
+#endif
 	}
 
-	lv_ptr->u.lv_status |= LV_SPINDOWN;
+	lv_ptr->lv_status |= LV_SPINDOWN;
 
 	/* sync the buffers */
-	fsync_dev(lv_ptr->u.lv_dev);
+	fsync_dev(lv_ptr->lv_kdev);
 
-	lv_ptr->u.lv_status &= ~LV_ACTIVE;
+	lv_ptr->lv_status &= ~LV_ACTIVE;
 
 	/* invalidate the buffers */
-	invalidate_buffers(lv_ptr->u.lv_dev);
+	invalidate_buffers(lv_ptr->lv_kdev);
 
 	/* reset generic hd */
-	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].start_sect = -1;
-	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].nr_sects = 0;
-	lvm_gendisk.part[minor(lv_ptr->u.lv_dev)].de = 0;
-	lvm_size[minor(lv_ptr->u.lv_dev)] = 0;
+	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].start_sect = -1;
+	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].nr_sects = 0;
+	lvm_gendisk.part[minor(lv_ptr->lv_kdev)].de = 0;
+	lvm_size[minor(lv_ptr->lv_kdev)] = 0;
 
 	/* reset VG/LV mapping */
-	vg_lv_map[minor(lv_ptr->u.lv_dev)].vg_number = ABS_MAX_VG;
-	vg_lv_map[minor(lv_ptr->u.lv_dev)].lv_number = -1;
+	vg_lv_map[minor(lv_ptr->lv_kdev)].vg_number = ABS_MAX_VG;
+	vg_lv_map[minor(lv_ptr->lv_kdev)].lv_number = -1;
 
 	/* correct the PE count in PVs if this is not a snapshot
            logical volume */
-	if (!(lv_ptr->u.lv_access & LV_SNAPSHOT)) {
+	if (!(lv_ptr->lv_access & LV_SNAPSHOT)) {
 		/* only if this is no snapshot logical volume because
 		   we share the u.lv_current_pe[] structs with the
 		   original logical volume */
-		for (le = 0; le < lv_ptr->u.lv_allocated_le; le++) {
+		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
 			vg_ptr->pe_allocated--;
 			for (p = 0; p < vg_ptr->pv_cur; p++) {
-				if (kdev_same(vg_ptr->pv[p]->pv_dev,
-					      lv_ptr->u.lv_current_pe[le].dev))
+				if (kdev_same(vg_ptr->pv[p]->pv_kdev,
+					      to_kdev_t(lv_ptr->lv_current_pe[le].bdev->bd_dev)))
 					vg_ptr->pv[p]->pe_allocated--;
 			}
 		}
-		vfree(lv_ptr->u.lv_current_pe);
+		vfree(lv_ptr->lv_current_pe);
 	}
 
 	P_KFREE("%s -- kfree %d\n", lvm_name, __LINE__);
@@ -2171,11 +2408,11 @@
 	return 0;
 } /* lvm_do_lv_remove() */
 
-
+#ifdef BROKEN
 /*
  * logical volume extend / reduce
  */
-static int __extend_reduce_snapshot(vg_t *vg_ptr, lv_t *old_lv, lv_t *new_lv) {
+static int __extend_reduce_snapshot(kern_vg_t *vg_ptr, lv_t *old_lv, lv_t *new_lv) {
         ulong size;
         lv_block_exception_t *lvbe;
 
@@ -2206,12 +2443,12 @@
         return 0;
 }
 
-static int __extend_reduce(vg_t *vg_ptr, lv_t *old_lv, lv_t *new_lv) {
+static int __extend_reduce(kern_vg_t *vg_ptr, lv_t *old_lv, lv_t *new_lv) {
         ulong size, l, p, end;
         pe_t *pe;
 
         /* allocate space for new pe structures */
-        size = new_lv->u.lv_current_le * sizeof(pe_t);
+        size = new_lv->lv_current_le * sizeof(pe_t);
         if ((pe = vmalloc(size)) == NULL) {
                 printk(KERN_CRIT
                        "%s -- lvm_do_lv_extend_reduce: "
@@ -2221,7 +2458,7 @@
         }
 
         /* get the PE structures from user space */
-        if (copy_from_user(pe, new_lv->u.lv_current_pe, size)) {
+        if (copy_from_user(pe, new_lv->lv_current_pe, size)) {
                 if(old_lv->u.lv_access & LV_SNAPSHOT)
                         vfree(new_lv->lv_snapshot_hash_table);
                 vfree(pe);
@@ -2235,7 +2472,7 @@
                 vg_ptr->pe_allocated--;
                 for (p = 0; p < vg_ptr->pv_cur; p++) {
 			if (kdev_same(vg_ptr->pv[p]->pv_dev,
-				      old_lv->u.lv_current_pe[l].dev)) {
+				      to_kdev_t(old_lv->u.lv_current_pe[l].bdev->bd_dev))) {
                                 vg_ptr->pv[p]->pe_allocated--;
                                 break;
                         }
@@ -2247,7 +2484,7 @@
                 vg_ptr->pe_allocated++;
                 for (p = 0; p < vg_ptr->pv_cur; p++) {
 			if (kdev_same(vg_ptr->pv[p]->pv_dev,
-				      new_lv->u.lv_current_pe[l].dev)) {
+				      to_kdev_t(new_lv->u.lv_current_pe[l].bdev->bd_dev))) {
                                 vg_ptr->pv[p]->pe_allocated++;
                                 break;
                         }
@@ -2288,13 +2525,13 @@
         return 0;
 }
 
-static int lvm_do_lv_extend_reduce(int minor, char *lv_name, userlv_t *ulv)
+static int lvm_do_lv_extend_reduce(int minor, char *lv_name, user_lv_t *ulv)
 {
         int r;
         ulong l, e, size;
-        vg_t *vg_ptr = vg[VG_CHR(minor)];
-        lv_t *old_lv;
-	lv_t *new_lv;
+        kern_vg_t *vg_ptr = vg[VG_CHR(minor)];
+        kern_lv_t *old_lv;
+	kern_lv_t *new_lv;
         pe_t *pe;
 
 	if((new_lv = kmalloc(sizeof(lv_t),GFP_KERNEL)) == NULL){
@@ -2304,7 +2541,7 @@
 		return -ENOMEM;
 	}
 	memset(new_lv,0,sizeof(lv_t));
-	memcpy(&new_lv->u,ulv,sizeof(userlv_t));
+	memcpy(&new_lv->u,ulv,sizeof(user_lv_t));
 
         if ((pe = new_lv->u.lv_current_pe) == NULL)
                 return -EINVAL;
@@ -2319,11 +2556,13 @@
         old_lv = vg_ptr->lv[l];
 
 	if (old_lv->u.lv_access & LV_SNAPSHOT) {
+		return -ENOSYS;
 		/* only perform this operation on active snapshots */
-		if (old_lv->u.lv_status & LV_ACTIVE)
+/*		if (old_lv->u.lv_status & LV_ACTIVE)
                 r = __extend_reduce_snapshot(vg_ptr, old_lv, new_lv);
-        else
-			r = -EPERM;
+		else
+		r = -EPERM;
+*/
 
 	} else
                 r = __extend_reduce(vg_ptr, old_lv, new_lv);
@@ -2335,6 +2574,9 @@
 	down_write(&old_lv->lv_lock);
 
         if(new_lv->u.lv_access & LV_SNAPSHOT) {
+		return -ENOSYS;
+
+/*
                 size = (new_lv->u.lv_remap_end > old_lv->u.lv_remap_end) ?
                         old_lv->u.lv_remap_ptr : new_lv->u.lv_remap_end;
                 size *= sizeof(lv_block_exception_t);
@@ -2354,10 +2596,9 @@
                         lvm_hash_link(new_lv->u.lv_block_exception + e,
                                       new_lv->u.lv_block_exception[e].rdev_org,
                                     new_lv->u.lv_block_exception[e].rsector_org,
-                                      new_lv);
+				    new_lv);*/
 
         } else {
-
                 vfree(old_lv->u.lv_current_pe);
                 vfree(old_lv->lv_snapshot_hash_table);
 
@@ -2395,18 +2636,19 @@
 
         return 0;
 } /* lvm_do_lv_extend_reduce() */
-
+#endif
 
 /*
  * character device support function logical volume status by name
  */
-static int lvm_do_lv_status_byname(vg_t *vg_ptr, void *arg)
+static int lvm_do_lv_status_byname(kern_vg_t *vg_ptr, void *arg)
 {
 	uint l;
 	lv_status_byname_req_t lv_status_byname_req;
 	void *saved_ptr1;
 	void *saved_ptr2;
-	lv_t *lv_ptr;
+	kern_lv_t *lv_ptr;
+	user_lv_t tmpulv; /* we're rather heavy on stack here */
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(&lv_status_byname_req, arg,
@@ -2415,30 +2657,74 @@
 
 	if (lv_status_byname_req.lv == NULL) return -EINVAL;
 
+	if (copy_from_user(&tmpulv, lv_status_byname_req.lv,
+			   sizeof(user_lv_t)) != 0)
+		return -EFAULT;
+
 	for (l = 0; l < vg_ptr->lv_max; l++) {
 		if ((lv_ptr = vg_ptr->lv[l]) != NULL &&
-		    strcmp(lv_ptr->u.lv_name,
+		    strcmp(lv_ptr->lv_name,
 			   lv_status_byname_req.lv_name) == 0) {
+
 		        /* Save usermode pointers */
-		        if (copy_from_user(&saved_ptr1, &lv_status_byname_req.lv->u.lv_current_pe, sizeof(void*)) != 0)
-				return -EFAULT;
-			if (copy_from_user(&saved_ptr2, &lv_status_byname_req.lv->u.lv_block_exception, sizeof(void*)) != 0)
-			        return -EFAULT;
+			saved_ptr1=tmpulv.lv_current_pe;
+			saved_ptr2=tmpulv.lv_block_exception;
+
+			kernlv_to_userlv(lv_ptr,&tmpulv);
+
+			/* Restore usermode pointers */
+			tmpulv.lv_current_pe=saved_ptr1;
+			tmpulv.lv_block_exception=saved_ptr2;
+			
 		        if (copy_to_user(lv_status_byname_req.lv,
-					 lv_ptr,
-					 sizeof(userlv_t)) != 0)
+					 &tmpulv,
+					 sizeof(user_lv_t)) != 0)
 				return -EFAULT;
 
 			if (saved_ptr1 != NULL) {
+
+
+/* REVERSED IS:
+
+		for (le = 0; le < lv_ptr->lv_allocated_le; le++) {
+			if (copy_from_user(&tmpupe, user_pep+(le*sizeof(user_pe_t)), sizeof(user_pe_t))) {
+				P_IOCTL("ERROR: copying PE(%d) ptr %p (%d bytes)\n",
+					le,user_pep+(le*sizeof(user_pe_t)),
+					sizeof(user_lv_t));
+				printk(KERN_CRIT "err doin le %d\n",le);
+				
+				vfree(lv_ptr->lv_current_pe);
+				kfree(lv_ptr); 
+				vg_ptr->lv[l] = NULL;
+				return -EFAULT;
+			}
+			
+			lv_ptr->lv_current_pe[le].bdev = 
+				bdget(tmpupe.dev);
+			lv_ptr->lv_current_pe[le].pe = 
+				tmpupe.pe;
+			lv_ptr->lv_current_pe[le].reads =
+				tmpupe.reads;
+			lv_ptr->lv_current_pe[le].writes =
+				tmpupe.writes;
+			if(lv_ptr->lv_current_pe[le].bdev==NULL){
+				printk(KERN_CRIT " bdget failed\n");
+				return -EINVAL;
+			}
+		}
+
+
+
+
+
+				// DO CORRECT COPYING! kern vs us pe_t
 				if (copy_to_user(saved_ptr1,
-						 lv_ptr->u.lv_current_pe,
-						 lv_ptr->u.lv_allocated_le *
-				       		 sizeof(pe_t)) != 0)
-					return -EFAULT;
+						 lv_ptr->lv_current_pe,
+						 lv_ptr->lv_allocated_le *
+				       		 sizeof(kern_pe_t)) != 0)
+						 return -EFAULT;*/
 			}
-			/* Restore usermode pointers */
-			if (copy_to_user(&lv_status_byname_req.lv->u.lv_current_pe, &saved_ptr1, sizeof(void*)) != 0)
-			        return -EFAULT;
+
 			return 0;
 		}
 	}
@@ -2449,12 +2735,12 @@
 /*
  * character device support function logical volume status by index
  */
-static int lvm_do_lv_status_byindex(vg_t *vg_ptr,void *arg)
+static int lvm_do_lv_status_byindex(kern_vg_t *vg_ptr,void *arg)
 {
 	lv_status_byindex_req_t lv_status_byindex_req;
 	void *saved_ptr1;
 	void *saved_ptr2;
-	lv_t *lv_ptr;
+	kern_lv_t *lv_ptr;
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(&lv_status_byindex_req, arg,
@@ -2470,23 +2756,23 @@
 		return -ENXIO;
 
 	/* Save usermode pointers */
-	if (copy_from_user(&saved_ptr1, &lv_status_byindex_req.lv->u.lv_current_pe, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr1, &lv_status_byindex_req.lv->lv_current_pe, sizeof(void*)) != 0)
 	        return -EFAULT;
-	if (copy_from_user(&saved_ptr2, &lv_status_byindex_req.lv->u.lv_block_exception, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr2, &lv_status_byindex_req.lv->lv_block_exception, sizeof(void*)) != 0)
 	        return -EFAULT;
 
-	if (copy_to_user(lv_status_byindex_req.lv, lv_ptr, sizeof(userlv_t)) != 0)
+	if (copy_to_user(lv_status_byindex_req.lv, lv_ptr, sizeof(user_lv_t)) != 0)
 		return -EFAULT;
 	if (saved_ptr1 != NULL) {
 		if (copy_to_user(saved_ptr1,
-				 lv_ptr->u.lv_current_pe,
-				 lv_ptr->u.lv_allocated_le *
-		       		 sizeof(pe_t)) != 0)
+				 lv_ptr->lv_current_pe,
+				 lv_ptr->lv_allocated_le *
+		       		 sizeof(kern_pe_t)) != 0) //FIXME!!
 			return -EFAULT;
 	}
 
 	/* Restore usermode pointers */
-	if (copy_to_user(&lv_status_byindex_req.lv->u.lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
+	if (copy_to_user(&lv_status_byindex_req.lv->lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
 	        return -EFAULT;
 
 	return 0;
@@ -2496,12 +2782,18 @@
 /*
  * character device support function logical volume status by device number
  */
-static int lvm_do_lv_status_bydev(vg_t * vg_ptr, void * arg) {
+
+
+/* rewrite this to do proper coping */
+static int lvm_do_lv_status_bydev(kern_vg_t * vg_ptr, void * arg) {
+
+	return -ENOSYS;
+#ifdef BROKEN
 	int l;
 	lv_status_bydev_req_t lv_status_bydev_req;
 	void *saved_ptr1;
 	void *saved_ptr2;
-	lv_t *lv_ptr;
+	kern_lv_t *lv_ptr;
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(&lv_status_bydev_req, arg,
@@ -2510,7 +2802,7 @@
 
 	for ( l = 0; l < vg_ptr->lv_max; l++) {
 		if ( vg_ptr->lv[l] == NULL) continue;
-		if ( kdev_same(vg_ptr->lv[l]->u.lv_dev,
+		if ( kdev_same(vg_ptr->lv[l]->lv_kdev,
 			       to_kdev_t(lv_status_bydev_req.dev)))
 			break;
 	}
@@ -2519,44 +2811,50 @@
 	lv_ptr = vg_ptr->lv[l];
 
 	/* Save usermode pointers */
-	if (copy_from_user(&saved_ptr1, &lv_status_bydev_req.lv->u.lv_current_pe, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr1, &lv_status_bydev_req.lv->lv_current_pe, sizeof(void*)) != 0)
 	        return -EFAULT;
-	if (copy_from_user(&saved_ptr2, &lv_status_bydev_req.lv->u.lv_block_exception, sizeof(void*)) != 0)
+	if (copy_from_user(&saved_ptr2, &lv_status_bydev_req.lv->lv_block_exception, sizeof(void*)) != 0)
 	        return -EFAULT;
 
-	if (copy_to_user(lv_status_bydev_req.lv, lv_ptr, sizeof(lv_t)) != 0)
+/* FIXME!	if (copy_kernlv_to_userlv(lv_ptr,lv_status_bydev_req.lv) != 0)
+   kernlv_to_userlv()
+   copy_to_user
+
+ */
+	if (copy_to_user(lv_status_bydev_req.lv, lv_ptr, sizeof(user_lv_t)) != 0)
 		return -EFAULT;
 	if (saved_ptr1 != NULL) {
 		if (copy_to_user(saved_ptr1,
-				 lv_ptr->u.lv_current_pe,
-				 lv_ptr->u.lv_allocated_le *
-		       		 sizeof(pe_t)) != 0)
+				 lv_ptr->lv_current_pe,
+				 lv_ptr->lv_allocated_le *
+		       		 sizeof(kern_pe_t)) != 0) // BROKEN!
 			return -EFAULT;
 	}
 	/* Restore usermode pointers */
-	if (copy_to_user(&lv_status_bydev_req.lv->u.lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
+	if (copy_to_user(&lv_status_bydev_req.lv->lv_current_pe, &saved_ptr1, sizeof(void *)) != 0)
 	        return -EFAULT;
 
 	return 0;
+#endif
 } /* lvm_do_lv_status_bydev() */
 
 
 /*
  * character device support function rename a logical volume
  */
-static int lvm_do_lv_rename(vg_t *vg_ptr, lv_req_t *lv_req, userlv_t *ulv)
+static int lvm_do_lv_rename(kern_vg_t *vg_ptr, lv_req_t *lv_req, user_lv_t *ulv)
 {
 	int l = 0;
 	int ret = 0;
-	lv_t *lv_ptr = NULL;
+	kern_lv_t *lv_ptr = NULL;
 
 	for (l = 0; l < vg_ptr->lv_max; l++)
 	{
 		if ( (lv_ptr = vg_ptr->lv[l]) == NULL) continue;
-		if (kdev_same(lv_ptr->u.lv_dev, ulv->lv_dev))
+		if (kdev_same(lv_ptr->lv_kdev, to_kdev_t(ulv->lv_dev)))
 		{
 			lvm_fs_remove_lv(vg_ptr, lv_ptr);
-			strncpy(lv_ptr->u.lv_name,
+			strncpy(lv_ptr->lv_name,
 				lv_req->lv_name,
 				NAME_LEN);
 			lvm_fs_create_lv(vg_ptr, lv_ptr);
@@ -2572,8 +2870,10 @@
 /*
  * character device support function physical volume change
  */
-static int lvm_do_pv_change(vg_t *vg_ptr, void *arg)
+static int lvm_do_pv_change(kern_vg_t *vg_ptr, void *arg)
 {
+	return -ENOSYS;
+#ifdef BROKEN
 	uint p;
 	pv_t *pv_ptr;
 	struct block_device *bd;
@@ -2603,15 +2903,17 @@
 		}
 	}
 	return -ENXIO;
+#endif
 } /* lvm_do_pv_change() */
 
 /*
  * character device support function get physical volume status
  */
-static int lvm_do_pv_status(vg_t *vg_ptr, void *arg)
+static int lvm_do_pv_status(kern_vg_t *vg_ptr, void *arg)
 {
 	uint p;
-	pv_t *pv_ptr;
+	kern_pv_t *pv_ptr;
+	user_pv_t tmpupv;
 
 	if (vg_ptr == NULL) return -ENXIO;
 	if (copy_from_user(&pv_status_req, arg,
@@ -2623,9 +2925,10 @@
 		if (pv_ptr != NULL &&
 		    strcmp(pv_ptr->pv_name,
 			       pv_status_req.pv_name) == 0) {
+			kernpv_to_userpv(pv_ptr,&tmpupv);
 			if (copy_to_user(pv_status_req.pv,
-					 pv_ptr,
-				         sizeof(pv_t)) != 0)
+					 &tmpupv,
+				         sizeof(user_pv_t)) != 0)
 				return -EFAULT;
 			return 0;
 		}
@@ -2643,9 +2946,9 @@
        if (copy_from_user(&pv_flush_req, arg,
                           sizeof(pv_flush_req)) != 0)
                return -EFAULT;
-
-       fsync_dev(pv_flush_req.pv_dev);
-       invalidate_buffers(pv_flush_req.pv_dev);
+       /* FIXME! find kern__pv and use that? */
+       fsync_dev(to_kdev_t(pv_flush_req.pv_dev)); 
+       invalidate_buffers(to_kdev_t(pv_flush_req.pv_dev));
 
        return 0;
 }
@@ -2668,7 +2971,7 @@
 	}
 
 	blk_size[MAJOR_NR] = lvm_size;
-	blksize_size[MAJOR_NR] = lvm_blocksizes;
+/*	blksize_size[MAJOR_NR] = lvm_blocksizes;*/
 
 	return;
 } /* lvm_gen_init() */
@@ -2715,11 +3018,11 @@
 /*
  * we must open the pv's before we use them
  */
-static int _open_pv(pv_t *pv) {
+static int _open_pv(kern_pv_t *pv) {
 	int err;
 	struct block_device *bd;
 
-	if (!(bd = bdget(kdev_t_to_nr(pv->pv_dev))))
+	if (!(bd = bdget(kdev_t_to_nr(pv->pv_kdev))))
 		return -ENOMEM;
 
 	err = blkdev_get(bd, FMODE_READ|FMODE_WRITE, 0, BDEV_FILE);
@@ -2730,7 +3033,7 @@
 	return 0;
 }
 
-static void _close_pv(pv_t *pv) {
+static void _close_pv(kern_pv_t *pv) {
 	if (pv) {
 		struct block_device *bdev = pv->bd;
 		pv->bd = NULL;
diff -Nru a/include/linux/lvm.h b/include/linux/lvm.h
--- a/include/linux/lvm.h	Thu May 23 02:55:31 2002
+++ b/include/linux/lvm.h	Thu May 23 02:55:31 2002
@@ -383,7 +383,7 @@
  */
 
 /* core */
-typedef struct pv_v2 {
+typedef struct user_pv_v2 {
 	char id[2];		/* Identifier */
 	unsigned short version;	/* HM lvm version */
 	lvm_disk_data_t pv_on_disk;
@@ -394,7 +394,7 @@
 	char pv_name[NAME_LEN];
 	char vg_name[NAME_LEN];
 	char system_id[NAME_LEN];	/* for vgexport/vgimport */
-	kdev_t pv_dev;
+	dev_t pv_dev;
 	uint pv_number;
 	uint pv_status;
 	uint pv_allocatable;
@@ -407,11 +407,39 @@
 	pe_disk_t *pe;		/* HM */
 	struct block_device *bd;
 	char pv_uuid[UUID_LEN+1];
-
-#ifndef __KERNEL__
 	uint32_t pe_start;	/* in sectors */
+} user_pv_t;
+
+#ifdef __KERNEL__
+typedef struct kern_pv_v2 {
+	char id[2];		/* Identifier */
+	unsigned short version;	/* HM lvm version */
+	lvm_disk_data_t pv_on_disk;
+	lvm_disk_data_t vg_on_disk;
+	lvm_disk_data_t pv_uuidlist_on_disk;
+	lvm_disk_data_t lv_on_disk;
+	lvm_disk_data_t pe_on_disk;
+	char pv_name[NAME_LEN];
+	char vg_name[NAME_LEN];
+	char system_id[NAME_LEN];	/* for vgexport/vgimport */
+	kdev_t pv_kdev;
+	uint pv_number;
+	uint pv_status;
+	uint pv_allocatable;
+	uint pv_size;		/* HM */
+	uint lv_cur;
+	uint pe_size;
+	uint pe_total;
+	uint pe_allocated;
+	uint pe_stale;		/* for future use */
+	pe_disk_t *pe;		/* HM */
+	struct block_device *bd;
+	char pv_uuid[UUID_LEN+1];
+} kern_pv_t;
+#else
+typedef user_pv_t pv_t;
 #endif
-} pv_t;
+
 
 
 /* disk */
@@ -448,20 +476,28 @@
 
 /* core PE information */
 typedef struct {
-	kdev_t dev;
+        dev_t dev;
 	uint32_t pe;		/* to be changed if > 2TB */
 	uint32_t reads;
 	uint32_t writes;
-} pe_t;
+} user_pe_t;
 
+/* core PE information */
 typedef struct {
+	struct block_device *bdev;
+	uint32_t pe;		/* to be changed if > 2TB */
+	uint32_t reads;
+	uint32_t writes;
+} kern_pe_t;
+
+/*typedef struct {
 	char lv_name[NAME_LEN];
 	kdev_t old_dev;
 	kdev_t new_dev;
 	uint32_t old_pe;
 	uint32_t new_pe;
 } le_remap_req_t;
-
+*/
 typedef struct lv_bmap {
 	uint32_t lv_block;
 	dev_t lv_dev;
@@ -477,28 +513,19 @@
  * Structure Logical Volume (LV) Version 3
  */
 
-struct kern_lv_v5;
-struct user_lv_v5;
-typedef struct user_lv_v5 userlv_t;
-#ifdef __KERNEL__
-typedef struct kern_lv_v5 lv_t;
-#else
-typedef struct user_lv_v5 lv_t;
-#endif
-
 struct user_lv_v5 {
 	char lv_name[NAME_LEN];
 	char vg_name[NAME_LEN];
 	uint lv_access;
 	uint lv_status;
 	uint lv_open;		/* HM */
-	kdev_t lv_dev;		/* HM */
+	dev_t lv_dev;		/* HM */
 	uint lv_number;		/* HM */
 	uint lv_mirror_copies;	/* for future use */
 	uint lv_recovery;	/*       "        */
 	uint lv_schedule;	/*       "        */
 	uint lv_size;
-	pe_t *lv_current_pe;	/* HM */
+	user_pe_t *lv_current_pe;	/* HM */
 	uint lv_current_le;	/* for future use */
 	uint lv_allocated_le;
 	uint lv_stripes;
@@ -509,20 +536,41 @@
 	uint lv_read_ahead;
 
 	/* delta to version 1 starts here */
-	lv_t *lv_snapshot_org;
-	lv_t *lv_snapshot_prev;
-	lv_t *lv_snapshot_next;
-	lv_block_exception_t *lv_block_exception;
+  	struct user_lv_v5 *lv_snapshot_org;
+  	struct user_lv_v5 *lv_snapshot_prev;
+  	struct user_lv_v5 *lv_snapshot_next;
+  	lv_block_exception_t *lv_block_exception;
 	uint lv_remap_ptr;
 	uint lv_remap_end;
 	uint lv_chunk_size;
-	uint lv_snapshot_minor;
+  	uint lv_snapshot_minor;
 };
 
-struct kern_lv_v5{
-	struct user_lv_v5 u;
+typedef struct user_lv_v5 user_lv_t;
+
+#ifdef __KERNEL__
+struct kern_vg;
+typedef struct kern_vg kern_vg_t;
+
+typedef struct kern_lv_v5{
+	char lv_name[NAME_LEN];
+	char vg_name[NAME_LEN];
+	uint lv_access;
+	uint lv_status;
+	uint lv_open;
+	kdev_t lv_kdev;		/* dev_t in userspace */
+	uint lv_number;
+	uint lv_size;
+	kern_pe_t *lv_current_pe;
+	uint lv_allocated_le;
+	uint lv_current_le;	/* DOES nothing in kernel, 
+				   but userspacetools want it... */
+	uint lv_stripes;
+	uint lv_stripesize;
+	uint lv_allocation;
+
 	struct kiobuf *lv_iobuf;
-	sector_t blocks[LVM_MAX_SECTORS];
+  /*	sector_t blocks[LVM_MAX_SECTORS];*/
 	struct kiobuf *lv_COW_table_iobuf;
 	struct rw_semaphore lv_lock;
 	struct list_head *lv_snapshot_hash_table;
@@ -530,9 +578,23 @@
 	uint32_t lv_snapshot_hash_mask;
 	wait_queue_head_t lv_snapshot_wait;
 	int	lv_snapshot_use_rate;
-	struct vg_v3	*vg;
+	kern_vg_t *vg;
 	uint lv_allocated_snapshot_le;
-};
+
+  	struct kern_lv_v5 *lv_snapshot_org;
+  	struct kern_lv_v5 *lv_snapshot_prev;
+  	struct kern_lv_v5 *lv_snapshot_next;
+	lv_block_exception_t *lv_block_exception;
+	uint lv_remap_ptr;
+	uint lv_remap_end;
+
+	uint lv_chunk_size;
+} kern_lv_t;
+
+#else
+typedef struct user_lv_v5 lv_t;
+#endif
+
 
 /* disk */
 typedef struct lv_disk_v3 {
@@ -564,7 +626,7 @@
  */
 
 /* core */
-typedef struct vg_v3 {
+typedef struct user_vg_v3 {
 	char vg_name[NAME_LEN];	/* volume group name */
 	uint vg_number;		/* volume group number */
 	uint vg_access;		/* read/write */
@@ -582,17 +644,41 @@
 	uint pe_allocated;	/* allocated physical extents */
 	uint pvg_total;		/* physical volume groups FU */
 	struct proc_dir_entry *proc;
-	pv_t *pv[ABS_MAX_PV + 1];	/* physical volume struct pointers */
-	lv_t *lv[ABS_MAX_LV + 1];	/* logical  volume struct pointers */
+	user_pv_t *pv[ABS_MAX_PV + 1];	/* physical volume struct pointers */
+	user_lv_t *lv[ABS_MAX_LV + 1];	/* logical  volume struct pointers */
 	char vg_uuid[UUID_LEN+1];	/* volume group UUID */
+	char dummy1[200];
+} user_vg_t;
+
 #ifdef __KERNEL__
+struct kern_vg {
+	char vg_name[NAME_LEN];	/* volume group name */
+	uint vg_number;		/* volume group number */
+	uint vg_access;		/* read/write */
+	uint vg_status;		/* active or not */
+	uint lv_max;		/* maximum logical volumes */
+	uint lv_cur;		/* current logical volumes */
+	uint lv_open;		/* open    logical volumes */
+	uint pv_max;		/* maximum physical volumes */
+	uint pv_cur;		/* current physical volumes FU */
+	uint pv_act;		/* active physical volumes */
+	uint dummy;		/* was obsolete max_pe_per_pv */
+	uint vgda;		/* volume group descriptor arrays FU */
+	uint pe_size;		/* physical extent size in sectors */
+	uint pe_total;		/* total of physical extents */
+	uint pe_allocated;	/* allocated physical extents */
+	uint pvg_total;		/* physical volume groups FU */
+	struct proc_dir_entry *proc;
+	kern_pv_t *pv[ABS_MAX_PV + 1];	/* physical volume struct pointers */
+	kern_lv_t *lv[ABS_MAX_LV + 1];	/* logical  volume struct pointers */
+	char vg_uuid[UUID_LEN+1];	/* volume group UUID */
 	struct proc_dir_entry *vg_dir_pde;
 	struct proc_dir_entry *lv_subdir_pde;
 	struct proc_dir_entry *pv_subdir_pde;
+};
 #else
-	char dummy1[200];
+typedef user_vg_t vg_t;
 #endif
-} vg_t;
 
 
 /* disk */
@@ -624,13 +710,13 @@
 /* Request structure PV_STATUS_BY_NAME... */
 typedef struct {
 	char pv_name[NAME_LEN];
-	pv_t *pv;
+	user_pv_t *pv;
 } pv_status_req_t, pv_change_req_t;
 
 /* Request structure PV_FLUSH */
 typedef struct {
 	char pv_name[NAME_LEN];
-	kdev_t pv_dev;
+	dev_t pv_dev;
 } pv_flush_req_t;
 
 
@@ -650,13 +736,13 @@
 /* Request structure LV_STATUS_BYNAME */
 typedef struct {
 	char lv_name[NAME_LEN];
-	lv_t *lv;
+	user_lv_t *lv;
 } lv_status_byname_req_t, lv_req_t;
 
 /* Request structure LV_STATUS_BYINDEX */
 typedef struct {
 	uint32_t lv_index;
-	lv_t *lv;
+	user_lv_t *lv;
 	/* Transfer size because user space and kernel space differ */
 	ushort size;
 } lv_status_byindex_req_t;
@@ -664,7 +750,7 @@
 /* Request structure LV_STATUS_BYDEV... */
 typedef struct {
 	dev_t dev;
-	lv_t *lv;
+	user_lv_t *lv;
 } lv_status_bydev_req_t;
 
 
@@ -684,15 +770,15 @@
 static inline ulong div_up(ulong n, ulong size) {
 	return round_up(n, size) / size;
 }
-
-static int inline LVM_GET_COW_TABLE_CHUNKS_PER_PE(vg_t *vg, lv_t *lv) {
-	return vg->pe_size / lv->u.lv_chunk_size;
+#ifdef __KERNEL__
+static int inline LVM_GET_COW_TABLE_CHUNKS_PER_PE(kern_vg_t *vg, kern_lv_t *lv) {
+	return vg->pe_size / lv->lv_chunk_size;
 }
 
-static int inline LVM_GET_COW_TABLE_ENTRIES_PER_PE(vg_t *vg, lv_t *lv) {
-	ulong chunks = vg->pe_size / lv->u.lv_chunk_size;
+static int inline LVM_GET_COW_TABLE_ENTRIES_PER_PE(kern_vg_t *vg, kern_lv_t *lv) {
+	ulong chunks = vg->pe_size / lv->lv_chunk_size;
 	ulong entry_size = sizeof(lv_COW_table_disk_t);
-	ulong chunk_size = lv->u.lv_chunk_size * SECTOR_SIZE;
+	ulong chunk_size = lv->lv_chunk_size * SECTOR_SIZE;
 	ulong entries = (vg->pe_size * SECTOR_SIZE) /
 		(entry_size + chunk_size);
 
@@ -706,5 +792,5 @@
 
 	return entries;
 }
-
+#endif
 #endif				/* #ifndef _LVM_H_INCLUDE */

===================================================================


This BitKeeper patch contains the following changesets:
1.568.2.1
## Wrapped with gzip_uu ##


begin 664 bkpatch1613
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
:<5U6I262Z\O'_:PL>FE^?N=?NY^4SN::````
`
end
