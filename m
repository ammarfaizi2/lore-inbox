Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbSLKTNu>; Wed, 11 Dec 2002 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbSLKTNu>; Wed, 11 Dec 2002 14:13:50 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:33720 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267284AbSLKTNd>; Wed, 11 Dec 2002 14:13:33 -0500
Date: Wed, 11 Dec 2002 12:21:05 -0700
From: Peter Braam <braam@clusterfs.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       intermezzo-devel@lists.sf.net, rddunlap@osdl.org
Subject: [PATCH] intermezzo fixes for 2.5.50
Message-ID: <20021211192105.GA1649@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, 

Please find attached relatively straightforward fixes for intermezzo
problems in 2.5.50.  I think all of them related to:
 - two missing headers
 - use of timespec instead of time_t.

- Peter -

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="intermezzo.patch"


patches to be applied to specific kernels to get intermezzo working


 fs/intermezzo/dir.c            |    6 
 fs/intermezzo/file.c           |    2 
 fs/intermezzo/journal.c        |   12 +
 fs/intermezzo/kml_reint.c      |   42 +++--
 fs/intermezzo/kml_unpack.c     |   12 +
 fs/intermezzo/presto.c         |    6 
 fs/intermezzo/replicator.c     |    3 
 fs/intermezzo/vfs.c            |    4 
 include/linux/fsfilter.h       |  134 ++++++++++++++++++
 include/linux/intermezzo_fs.h  |    2 
 include/linux/intermezzo_idl.h |  304 +++++++++++++++++++++++++++++++++++++++++
 include/linux/intermezzo_lib.h |  168 ++++++++++++++++++++++
 12 files changed, 663 insertions(+), 32 deletions(-)

--- linux-2.5.50/fs/intermezzo/dir.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/dir.c	Tue Dec 10 20:53:33 2002
@@ -342,7 +342,7 @@ int presto_setattr(struct dentry *de, st
         int error;
         struct presto_cache *cache;
         struct presto_file_set *fset;
-        struct lento_vfs_context info = { 0, 0, 0 };
+        struct lento_vfs_context info = { 0, {0}, 0 };
 
         ENTRY;
 
@@ -358,8 +358,8 @@ int presto_setattr(struct dentry *de, st
         CDEBUG(D_INODE, "valid %#x, mode %#o, uid %u, gid %u, size %Lu, "
                "atime %lu mtime %lu ctime %lu flags %d\n",
                iattr->ia_valid, iattr->ia_mode, iattr->ia_uid, iattr->ia_gid,
-               iattr->ia_size, iattr->ia_atime, iattr->ia_mtime,
-               iattr->ia_ctime, iattr->ia_attr_flags);
+               iattr->ia_size, iattr->ia_atime.tv_sec, iattr->ia_mtime.tv_sec,
+               iattr->ia_ctime.tv_sec, iattr->ia_attr_flags);
         
         if ( presto_get_permit(de->d_inode) < 0 ) {
                 EXIT;
--- linux-2.5.50/fs/intermezzo/file.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/file.c	Tue Dec 10 20:53:33 2002
@@ -61,7 +61,7 @@ extern int presto_permission(struct inod
 
 static int presto_open_upcall(int minor, struct dentry *de)
 {
-        int rc;
+        int rc = 0;
         char *path, *buffer;
         struct presto_file_set *fset;
         int pathlen;
--- linux-2.5.50/fs/intermezzo/journal.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/journal.c	Tue Dec 10 20:59:09 2002
@@ -363,8 +363,10 @@ static inline char *log_dentry_version(c
 
         presto_getversion(&version, dentry->d_inode);
         
-        version.pv_mtime = HTON__u64(version.pv_mtime);
-        version.pv_ctime = HTON__u64(version.pv_ctime);
+        version.pv_mtime_sec = HTON__u32(version.pv_mtime_sec);
+        version.pv_ctime_sec = HTON__u32(version.pv_ctime_sec);
+        version.pv_mtime_nsec = HTON__u32(version.pv_mtime_nsec);
+        version.pv_ctime_nsec = HTON__u32(version.pv_ctime_nsec);
         version.pv_size = HTON__u64(version.pv_size);
 
         return logit(buf, &version, sizeof(version));
@@ -376,8 +378,10 @@ static inline char *log_version(char *bu
 
         memcpy(&version, pv, sizeof(version));
         
-        version.pv_mtime = HTON__u64(version.pv_mtime);
-        version.pv_ctime = HTON__u64(version.pv_ctime);
+        version.pv_mtime_sec = HTON__u32(version.pv_mtime_sec);
+        version.pv_mtime_nsec = HTON__u32(version.pv_mtime_nsec);
+        version.pv_ctime_sec = HTON__u32(version.pv_ctime_sec);
+        version.pv_ctime_nsec = HTON__u32(version.pv_ctime_nsec);
         version.pv_size = HTON__u64(version.pv_size);
 
         return logit(buf, &version, sizeof(version));
--- linux-2.5.50/fs/intermezzo/kml_reint.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/kml_reint.c	Tue Dec 10 21:08:12 2002
@@ -100,7 +100,8 @@ static inline int version_equal(struct p
                 return 0;
         }
 
-        if (inode->i_mtime == a->pv_mtime &&
+        if (inode->i_mtime.tv_sec == a->pv_mtime_sec &&
+            inode->i_mtime.tv_nsec == a->pv_mtime_nsec &&
             (S_ISDIR(inode->i_mode) || inode->i_size == a->pv_size))
                 return 1;
 
@@ -126,8 +127,10 @@ static int reint_close(struct kml_rec *r
                 struct iattr iattr;
 
                 iattr.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_SIZE;
-                iattr.ia_mtime = (time_t)rec->new_objectv->pv_mtime;
-                iattr.ia_ctime = (time_t)rec->new_objectv->pv_ctime;
+                iattr.ia_mtime.tv_sec = (time_t)rec->new_objectv->pv_mtime_sec;
+                iattr.ia_mtime.tv_nsec = (time_t)rec->new_objectv->pv_mtime_nsec;
+                iattr.ia_ctime.tv_sec = (time_t)rec->new_objectv->pv_ctime_sec;
+                iattr.ia_ctime.tv_nsec = (time_t)rec->new_objectv->pv_ctime_nsec;
                 iattr.ia_size = (time_t)rec->new_objectv->pv_size;
 
                 /* no kml record, but update last rcvd */
@@ -144,7 +147,8 @@ static int reint_close(struct kml_rec *r
         } else {
                 int minor = presto_f2m(fset);
 
-                info.updated_time = rec->new_objectv->pv_mtime;
+                info.updated_time.tv_sec = rec->new_objectv->pv_mtime_sec;
+                info.updated_time.tv_nsec = rec->new_objectv->pv_mtime_nsec;
                 memcpy(&info.remote_version, rec->old_objectv, 
                        sizeof(*rec->old_objectv));
                 info.remote_ino = rec->ino;
@@ -180,7 +184,8 @@ static int reint_create(struct kml_rec *
         int     error;        ENTRY;
 
         CDEBUG (D_KML, "=====REINT_CREATE::%s\n", rec->path);
-        info->updated_time = rec->new_objectv->pv_ctime;
+        info->updated_time.tv_sec = rec->new_objectv->pv_ctime_sec;
+        info->updated_time.tv_nsec = rec->new_objectv->pv_ctime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_create(rec->path, rec->mode, info);
         pop_ctxt(&saved_ctxt); 
@@ -198,7 +203,8 @@ static int reint_link(struct kml_rec *re
         ENTRY;
 
         CDEBUG (D_KML, "=====REINT_LINK::%s -> %s\n", rec->path, rec->target);
-        info->updated_time = rec->new_objectv->pv_mtime;
+        info->updated_time.tv_sec = rec->new_objectv->pv_mtime_sec;
+        info->updated_time.tv_nsec = rec->new_objectv->pv_mtime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_link(rec->path, rec->target, info);
         pop_ctxt(&saved_ctxt); 
@@ -216,7 +222,8 @@ static int reint_mkdir(struct kml_rec *r
         ENTRY;
 
         CDEBUG (D_KML, "=====REINT_MKDIR::%s\n", rec->path);
-        info->updated_time = rec->new_objectv->pv_ctime;
+        info->updated_time.tv_sec = rec->new_objectv->pv_ctime_sec;
+        info->updated_time.tv_nsec = rec->new_objectv->pv_ctime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_mkdir(rec->path, rec->mode, info);
         pop_ctxt(&saved_ctxt); 
@@ -234,7 +241,8 @@ static int reint_mknod(struct kml_rec *r
         ENTRY;
 
         CDEBUG (D_KML, "=====REINT_MKNOD::%s\n", rec->path);
-        info->updated_time = rec->new_objectv->pv_ctime;
+        info->updated_time.tv_sec = rec->new_objectv->pv_ctime_sec;
+        info->updated_time.tv_nsec = rec->new_objectv->pv_ctime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
 
         dev = rec->rdev ?: MKDEV(rec->major, rec->minor);
@@ -262,7 +270,8 @@ static int reint_rename(struct kml_rec *
         ENTRY;
 
         CDEBUG (D_KML, "=====REINT_RENAME::%s -> %s\n", rec->path, rec->target);
-        info->updated_time = rec->new_objectv->pv_mtime;
+        info->updated_time.tv_sec = rec->new_objectv->pv_mtime_sec;
+        info->updated_time.tv_nsec = rec->new_objectv->pv_mtime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_rename(rec->path, rec->target, info);
         pop_ctxt(&saved_ctxt); 
@@ -287,7 +296,8 @@ static int reint_rmdir(struct kml_rec *r
         }
 
         CDEBUG (D_KML, "=====REINT_RMDIR::%s\n", path);
-        info->updated_time = rec->new_parentv->pv_mtime;
+        info->updated_time.tv_sec = rec->new_parentv->pv_mtime_sec;
+        info->updated_time.tv_nsec = rec->new_parentv->pv_mtime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_rmdir(path, info);
         pop_ctxt(&saved_ctxt); 
@@ -311,8 +321,10 @@ static int reint_setattr(struct kml_rec 
         iattr.ia_uid   = (uid_t)rec->uid;
         iattr.ia_gid   = (gid_t)rec->gid;
         iattr.ia_size  = (off_t)rec->size;
-        iattr.ia_ctime = (time_t)rec->ctime;
-        iattr.ia_mtime = (time_t)rec->mtime;
+        iattr.ia_ctime.tv_sec = rec->ctime_sec;
+        iattr.ia_ctime.tv_nsec = rec->ctime_nsec;
+        iattr.ia_mtime.tv_sec = rec->mtime_sec;
+        iattr.ia_mtime.tv_nsec = rec->mtime_nsec;
         iattr.ia_atime = iattr.ia_mtime; /* We don't track atimes. */
         iattr.ia_attr_flags = rec->flags;
 
@@ -334,7 +346,8 @@ static int reint_symlink(struct kml_rec 
         ENTRY;
 
         CDEBUG (D_KML, "=====REINT_SYMLINK::%s -> %s\n", rec->path, rec->target);
-        info->updated_time = rec->new_objectv->pv_ctime;
+        info->updated_time.tv_sec = rec->new_objectv->pv_ctime_sec;
+        info->updated_time.tv_nsec = rec->new_objectv->pv_ctime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_symlink(rec->target, rec->path, info);
         pop_ctxt(&saved_ctxt); 
@@ -359,7 +372,8 @@ static int reint_unlink(struct kml_rec *
         }
 
         CDEBUG (D_KML, "=====REINT_UNLINK::%s\n", path);
-        info->updated_time = rec->new_parentv->pv_mtime;
+        info->updated_time.tv_sec = rec->new_parentv->pv_mtime_sec;
+        info->updated_time.tv_nsec = rec->new_parentv->pv_mtime_nsec;
         kmlreint_pre_secure(rec, dir, &saved_ctxt);
         error = lento_unlink(path, info);
         pop_ctxt(&saved_ctxt); 
--- linux-2.5.50/fs/intermezzo/kml_unpack.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/kml_unpack.c	Tue Dec 10 21:12:16 2002
@@ -67,8 +67,10 @@ int kml_unpack_version(struct presto_ver
 
 	UNLOGP(*ver, struct presto_version, ptr, end);
         pv = *ver;
-        pv->pv_mtime   = NTOH__u64(pv->pv_mtime);
-        pv->pv_ctime   = NTOH__u64(pv->pv_ctime);
+        pv->pv_mtime_sec   = NTOH__u32(pv->pv_mtime_sec);
+        pv->pv_mtime_nsec   = NTOH__u32(pv->pv_mtime_nsec);
+        pv->pv_ctime_sec   = NTOH__u32(pv->pv_ctime_sec);
+        pv->pv_ctime_nsec   = NTOH__u32(pv->pv_ctime_nsec);
         pv->pv_size    = NTOH__u64(pv->pv_size);
 
 	*buf = ptr;
@@ -247,8 +249,10 @@ static int kml_unpack_setattr(struct kml
 	LUNLOGV(rec->uid, __u32, ptr, end);
 	LUNLOGV(rec->gid, __u32, ptr, end);
 	LUNLOGV(rec->size, __u64, ptr, end);
-	LUNLOGV(rec->mtime, __u64, ptr, end);
-	LUNLOGV(rec->ctime, __u64, ptr, end);
+	LUNLOGV(rec->mtime_sec, __u32, ptr, end);
+	LUNLOGV(rec->mtime_nsec, __u32, ptr, end);
+	LUNLOGV(rec->ctime_sec, __u32, ptr, end);
+	LUNLOGV(rec->ctime_nsec, __u32, ptr, end);
 	LUNLOGV(rec->flags, __u32, ptr, end);
         LUNLOGV(rec->old_mode, __u32, ptr, end);
         LUNLOGV(rec->old_rdev, __u32, ptr, end);
--- linux-2.5.50/fs/intermezzo/presto.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/presto.c	Tue Dec 10 21:13:20 2002
@@ -627,8 +627,10 @@ int presto_put_permit(struct inode * ino
 void presto_getversion(struct presto_version * presto_version,
                        struct inode * inode)
 {
-        presto_version->pv_mtime = (__u64)inode->i_mtime;
-        presto_version->pv_ctime = (__u64)inode->i_ctime;
+        presto_version->pv_mtime_sec = inode->i_mtime.tv_sec;
+        presto_version->pv_mtime_nsec = inode->i_mtime.tv_nsec;
+        presto_version->pv_ctime_sec = inode->i_ctime.tv_sec;
+        presto_version->pv_ctime_nsec = inode->i_ctime.tv_nsec;
         presto_version->pv_size  = (__u64)inode->i_size;
 }
 
--- linux-2.5.50/fs/intermezzo/replicator.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/replicator.c	Tue Dec 10 21:15:33 2002
@@ -29,7 +29,8 @@
 #include <asm/uaccess.h>
 
 #include <linux/errno.h>
-
+#include <linux/fs.h>
+#include <linux/fsfilter.h>
 #include <linux/intermezzo_fs.h>
 
 /*
--- linux-2.5.50/fs/intermezzo/vfs.c~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/fs/intermezzo/vfs.c	Tue Dec 10 21:17:06 2002
@@ -186,7 +186,7 @@ inline void presto_debug_fail_blkdev(str
 
         if (errorval && errorval == (long)value && !is_read_only(dev)) {
                 CDEBUG(D_SUPER, "setting device %s read only\n", kdevname(dev));
-                BLKDEV_FAIL(dev, 1);
+                BLKDEV_FAIL(kdev_val(dev), 1);
                 izo_channels[minor].uc_errorval = -kdev_val(dev);
         }
 }
@@ -475,7 +475,7 @@ int lento_setattr(const char *name, stru
                name, iattr->ia_valid, iattr->ia_mode, iattr->ia_uid,
                iattr->ia_gid, iattr->ia_size);
         CDEBUG(D_PIOCTL, "atime %#lx, mtime %#lx, ctime %#lx, attr_flags %#x\n",
-               iattr->ia_atime, iattr->ia_mtime.tv_sec, iattr->ia_ctime.tv_sec,
+               iattr->ia_atime.tv_sec, iattr->ia_mtime.tv_sec, iattr->ia_ctime.tv_sec,
                iattr->ia_attr_flags);
         CDEBUG(D_PIOCTL, "offset %d, recno %d, flags %#x\n",
                info->slot_offset, info->recno, info->flags);
--- /dev/null	Fri Aug 30 17:31:37 2002
+++ linux-2.5.50-root/include/linux/fsfilter.h	Wed Nov 27 15:35:47 2002
@@ -0,0 +1,134 @@
+/* -*- mode: c; c-basic-offset: 8; indent-tabs-mode: nil; -*-
+ * vim:expandtab:shiftwidth=8:tabstop=8:
+ */
+
+#ifndef __FILTER_H_
+#define __FILTER_H_ 1
+
+#ifdef __KERNEL__
+
+/* cachetype.c */
+
+/* 
+ * it is important that things like inode, super and file operations
+ * for intermezzo are not defined statically.  If methods are NULL
+ * the VFS takes special action based on that.  Given that different
+ * cache types have NULL ops at different slots, we must install opeation 
+ * talbes for InterMezzo with NULL's in the same spot
+ */
+
+struct filter_ops { 
+        struct super_operations filter_sops;
+
+        struct inode_operations filter_dir_iops;
+        struct inode_operations filter_file_iops;
+        struct inode_operations filter_sym_iops;
+
+        struct file_operations filter_dir_fops;
+        struct file_operations filter_file_fops;
+        struct file_operations filter_sym_fops;
+
+        struct dentry_operations filter_dentry_ops;
+};
+
+struct cache_ops {
+        /* operations on the file store */
+        struct super_operations *cache_sops;
+
+        struct inode_operations *cache_dir_iops;
+        struct inode_operations *cache_file_iops;
+        struct inode_operations *cache_sym_iops;
+
+        struct file_operations *cache_dir_fops;
+        struct file_operations *cache_file_fops;
+        struct file_operations *cache_sym_fops;
+
+        struct dentry_operations *cache_dentry_ops;
+};
+
+
+#define FILTER_DID_SUPER_OPS 0x1
+#define FILTER_DID_INODE_OPS 0x2
+#define FILTER_DID_FILE_OPS 0x4
+#define FILTER_DID_DENTRY_OPS 0x8
+#define FILTER_DID_DEV_OPS 0x10
+#define FILTER_DID_SYMLINK_OPS 0x20
+#define FILTER_DID_DIR_OPS 0x40
+
+struct filter_fs {
+        int o_flags;
+        struct filter_ops o_fops;
+        struct cache_ops  o_caops;
+        struct journal_ops *o_trops;
+        struct snapshot_ops *o_snops;
+};
+
+#define FILTER_FS_TYPES 6
+#define FILTER_FS_EXT2 0
+#define FILTER_FS_EXT3 1
+#define FILTER_FS_REISERFS 2
+#define FILTER_FS_XFS 3
+#define FILTER_FS_OBDFS 4
+#define FILTER_FS_TMPFS 5
+extern struct filter_fs filter_oppar[FILTER_FS_TYPES];
+
+struct filter_fs *filter_get_filter_fs(const char *cache_type);
+void filter_setup_journal_ops(struct filter_fs *ops, char *cache_type);
+inline struct super_operations *filter_c2usops(struct filter_fs *cache);
+inline struct inode_operations *filter_c2ufiops(struct filter_fs *cache);
+inline struct inode_operations *filter_c2udiops(struct filter_fs *cache);
+inline struct inode_operations *filter_c2usiops(struct filter_fs *cache);
+inline struct file_operations *filter_c2uffops(struct filter_fs *cache);
+inline struct file_operations *filter_c2udfops(struct filter_fs *cache);
+inline struct file_operations *filter_c2usfops(struct filter_fs *cache);
+inline struct super_operations *filter_c2csops(struct filter_fs *cache);
+inline struct inode_operations *filter_c2cfiops(struct filter_fs *cache);
+inline struct inode_operations *filter_c2cdiops(struct filter_fs *cache);
+inline struct inode_operations *filter_c2csiops(struct filter_fs *cache);
+inline struct file_operations *filter_c2cffops(struct filter_fs *cache);
+inline struct file_operations *filter_c2cdfops(struct filter_fs *cache);
+inline struct file_operations *filter_c2csfops(struct filter_fs *cache);
+inline struct dentry_operations *filter_c2cdops(struct filter_fs *cache);
+inline struct dentry_operations *filter_c2udops(struct filter_fs *cache);
+
+void filter_setup_super_ops(struct filter_fs *cache, struct super_operations *cache_ops, struct super_operations *filter_sops);
+void filter_setup_dir_ops(struct filter_fs *cache, struct inode *cache_inode, struct inode_operations *filter_iops, struct file_operations *ffops);
+void filter_setup_file_ops(struct filter_fs *cache, struct inode *cache_inode, struct inode_operations *filter_iops, struct file_operations *filter_op);
+void filter_setup_symlink_ops(struct filter_fs *cache, struct inode *cache_inode, struct inode_operations *filter_iops, struct file_operations *filter_op);
+void filter_setup_dentry_ops(struct filter_fs *cache, struct dentry_operations *cache_dop,  struct dentry_operations *filter_dop);
+
+
+#define PRESTO_DEBUG
+#ifdef PRESTO_DEBUG
+/* debugging masks */
+#define D_SUPER     1  
+#define D_INODE     2   /* print entry and exit into procedure */
+#define D_FILE      4
+#define D_CACHE     8   /* cache debugging */
+#define D_MALLOC    16  /* print malloc, de-alloc information */
+#define D_JOURNAL   32
+#define D_UPCALL    64  /* up and downcall debugging */
+#define D_PSDEV    128
+#define D_PIOCTL   256
+#define D_SPECIAL  512
+#define D_TIMING  1024
+#define D_DOWNCALL 2048
+
+#define FDEBUG(mask, format, a...)                                      \
+        do {                                                            \
+                if (filter_debug & mask) {                              \
+                        printk("(%s,l. %d): ", __FUNCTION__, __LINE__); \
+                        printk(format, ##a); }                          \
+        } while (0)
+
+#define FENTRY                                                          \
+        if(filter_print_entry)                                          \
+                printk("Process %d entered %s\n", current->pid, __FUNCTION__)
+
+#define FEXIT                                                           \
+        if(filter_print_entry)                                          \
+                printk("Process %d leaving %s at %d\n", current->pid,   \
+                       __FUNCTION__,__LINE__)
+#endif
+#endif
+#endif
--- linux-2.5.50/include/linux/intermezzo_fs.h~intermezzo	Tue Dec 10 20:53:33 2002
+++ linux-2.5.50-root/include/linux/intermezzo_fs.h	Tue Dec 10 20:53:33 2002
@@ -39,7 +39,7 @@ typedef __u8 uuid_t[16];
 
 struct lento_vfs_context {
         __u64 kml_offset;
-        __u64 updated_time;
+        struct timespec updated_time;
         __u64 remote_ino;
         __u64 remote_generation;
         __u32 slot_offset;
--- /dev/null	Fri Aug 30 17:31:37 2002
+++ linux-2.5.50-root/include/linux/intermezzo_idl.h	Tue Dec 10 21:10:33 2002
@@ -0,0 +1,304 @@
+/* -*- mode: c; c-basic-offset: 8; indent-tabs-mode: nil; -*-
+ * vim:expandtab:shiftwidth=8:tabstop=8:
+ *
+ *  Copyright (C) 2001, 2002 Cluster File Systems, Inc.
+ *  Copyright (C) 2001 Tacit Networks, Inc.
+ *
+ *   This file is part of InterMezzo, http://www.inter-mezzo.org.
+ *
+ *   InterMezzo is free software; you can redistribute it and/or
+ *   modify it under the terms of version 2 of the GNU General Public
+ *   License as published by the Free Software Foundation.
+ *
+ *   InterMezzo is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with InterMezzo; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __INTERMEZZO_IDL_H__
+#define __INTERMEZZO_IDL_H__
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* this file contains all data structures used in InterMezzo's interfaces:
+ * - upcalls
+ * - ioctl's
+ * - KML records
+ * - RCVD records
+ * - rpc's
+ */ 
+
+/* UPCALL */
+#define INTERMEZZO_MINOR 248   
+
+
+#define IZO_UPC_VERSION 0x00010002
+#define IZO_UPC_PERMIT        1
+#define IZO_UPC_CONNECT       2
+#define IZO_UPC_GO_FETCH_KML  3
+#define IZO_UPC_OPEN          4
+#define IZO_UPC_REVOKE_PERMIT 5
+#define IZO_UPC_KML           6
+#define IZO_UPC_BACKFETCH     7
+#define IZO_UPC_KML_TRUNC     8
+#define IZO_UPC_SET_KMLSIZE   9
+#define IZO_UPC_BRANCH_UNDO   10
+#define IZO_UPC_BRANCH_REDO   11
+#define IZO_UPC_GET_FILEID    12
+#define IZO_UPC_CLIENT_MAKE_BRANCH    13
+#define IZO_UPC_SERVER_MAKE_BRANCH    14
+#define IZO_UPC_REPSTATUS    15
+
+#define IZO_UPC_LARGEST_OPCODE 15
+
+struct izo_upcall_hdr {
+        __u32 u_len;
+        __u32 u_version;
+        __u32 u_opc;
+        __u32 u_uniq;
+        __u32 u_pid;
+        __u32 u_uid;
+        __u32 u_pathlen;
+        __u32 u_fsetlen;
+        __u64 u_offset;
+        __u64 u_length;
+        __u32 u_first_recno;
+        __u32 u_last_recno;
+        __u32 u_async;
+        __u32 u_reclen;
+        __u8  u_uuid[16];
+};
+
+/* This structure _must_ sit at the beginning of the buffer */
+struct izo_upcall_resp {
+        __u32 opcode;
+        __u32 unique;    
+        __u32 result;
+};
+
+
+/* IOCTL */
+
+#define IZO_IOCTL_VERSION 0x00010003
+
+/* maximum size supported for ioc_pbuf1 */
+#define KML_MAX_BUF (64*1024)
+
+struct izo_ioctl_hdr { 
+        __u32  ioc_len;
+        __u32  ioc_version;
+};
+
+struct izo_ioctl_data {
+        __u32 ioc_len;
+        __u32 ioc_version;
+        __u32 ioc_izodev;
+        __u32 ioc_kmlrecno;
+        __u64 ioc_kmlsize;
+        __u32 ioc_flags;
+        __s32 ioc_inofd;
+        __u64 ioc_ino;
+        __u64 ioc_generation;
+        __u32 ioc_mark_what;
+        __u32 ioc_and_flag;
+        __u32 ioc_or_flag;
+        __u32 ioc_dev;
+        __u32 ioc_offset;
+        __u32 ioc_slot;
+        __u64 ioc_uid;
+        __u8  ioc_uuid[16];
+
+        __u32 ioc_inllen1;   /* path */
+        char *ioc_inlbuf1;
+        __u32 ioc_inllen2;   /* fileset */
+        char *ioc_inlbuf2;
+
+        __u32 ioc_plen1;     /* buffers in user space (KML) */
+        char *ioc_pbuf1;
+        __u32 ioc_plen2;     /* buffers in user space (KML) */
+        char *ioc_pbuf2;
+
+        char  ioc_bulk[0];
+};
+
+#define IZO_IOC_DEVICE          _IOW ('p',0x50, void *)
+#define IZO_IOC_REINTKML        _IOW ('p',0x51, void *)
+#define IZO_IOC_GET_RCVD        _IOW ('p',0x52, void *)
+#define IZO_IOC_SET_IOCTL_UID   _IOW ('p',0x53, void *)
+#define IZO_IOC_GET_KML_SIZE    _IOW ('p',0x54, void *)
+#define IZO_IOC_PURGE_FILE_DATA _IOW ('p',0x55, void *)
+#define IZO_IOC_CONNECT         _IOW ('p',0x56, void *)
+#define IZO_IOC_GO_FETCH_KML    _IOW ('p',0x57, void *)
+#define IZO_IOC_MARK            _IOW ('p',0x58, void *)
+#define IZO_IOC_CLEAR_FSET      _IOW ('p',0x59, void *)
+#define IZO_IOC_CLEAR_ALL_FSETS _IOW ('p',0x60, void *)
+#define IZO_IOC_SET_FSET        _IOW ('p',0x61, void *)
+#define IZO_IOC_REVOKE_PERMIT   _IOW ('p',0x62, void *)
+#define IZO_IOC_SET_KMLSIZE     _IOW ('p',0x63, void *)
+#define IZO_IOC_CLIENT_MAKE_BRANCH _IOW ('p',0x64, void *)
+#define IZO_IOC_SERVER_MAKE_BRANCH _IOW ('p',0x65, void *)
+#define IZO_IOC_BRANCH_UNDO    _IOW ('p',0x66, void *)
+#define IZO_IOC_BRANCH_REDO    _IOW ('p',0x67, void *)
+#define IZO_IOC_SET_PID        _IOW ('p',0x68, void *)
+#define IZO_IOC_SET_CHANNEL    _IOW ('p',0x69, void *)
+#define IZO_IOC_GET_CHANNEL    _IOW ('p',0x70, void *)
+#define IZO_IOC_GET_FILEID    _IOW ('p',0x71, void *)
+#define IZO_IOC_ADJUST_LML    _IOW ('p',0x72, void *)
+#define IZO_IOC_SET_FILEID    _IOW ('p',0x73, void *)
+#define IZO_IOC_REPSTATUS    _IOW ('p',0x74, void *)
+
+/* marking flags for fsets */
+#define FSET_CLIENT_RO        0x00000001
+#define FSET_LENTO_RO         0x00000002
+#define FSET_HASPERMIT        0x00000004 /* we have a permit to WB */
+#define FSET_INSYNC           0x00000008 /* this fileset is in sync */
+#define FSET_PERMIT_WAITING   0x00000010 /* Lento is waiting for permit */
+#define FSET_STEAL_PERMIT     0x00000020 /* take permit if Lento is dead */
+#define FSET_JCLOSE_ON_WRITE  0x00000040 /* Journal closes on writes */
+#define FSET_DATA_ON_DEMAND   0x00000080 /* update data on file_open() */
+#define FSET_PERMIT_EXCLUSIVE 0x00000100 /* only one permitholder allowed */
+#define FSET_HAS_BRANCHES     0x00000200 /* this fileset contains branches */
+#define FSET_IS_BRANCH        0x00000400 /* this fileset is a branch */
+#define FSET_FLAT_BRANCH      0x00000800 /* this fileset is ROOT with branches */
+
+/* what to mark indicator (ioctl parameter) */
+#define MARK_DENTRY   101
+#define MARK_FSET     102
+#define MARK_CACHE    103
+#define MARK_GETFL    104
+
+/* KML */
+
+#define KML_MAJOR_VERSION 0x00010000
+#define KML_MINOR_VERSION 0x00000002
+#define KML_OPCODE_NOOP          0
+#define KML_OPCODE_CREATE        1
+#define KML_OPCODE_MKDIR         2
+#define KML_OPCODE_UNLINK        3
+#define KML_OPCODE_RMDIR         4
+#define KML_OPCODE_CLOSE         5
+#define KML_OPCODE_SYMLINK       6
+#define KML_OPCODE_RENAME        7
+#define KML_OPCODE_SETATTR       8
+#define KML_OPCODE_LINK          9
+#define KML_OPCODE_OPEN          10
+#define KML_OPCODE_MKNOD         11
+#define KML_OPCODE_WRITE         12
+#define KML_OPCODE_RELEASE       13
+#define KML_OPCODE_TRUNC         14
+#define KML_OPCODE_SETEXTATTR    15
+#define KML_OPCODE_DELEXTATTR    16
+#define KML_OPCODE_KML_TRUNC     17
+#define KML_OPCODE_GET_FILEID    18
+#define KML_OPCODE_NUM           19
+/* new stuff */
+struct presto_version {
+        __u32 pv_mtime_sec;
+        __u32 pv_mtime_nsec;
+        __u32 pv_ctime_sec;
+        __u32 pv_ctime_nsec;
+        __u64 pv_size;
+};
+
+struct kml_prefix_hdr {
+        __u32                    len;
+        __u32                    version;
+        __u32                    pid;
+        __u32                    auid;
+        __u32                    fsuid;
+        __u32                    fsgid;
+        __u32                    opcode;
+        __u32                    ngroups;
+};
+
+struct kml_prefix { 
+        struct kml_prefix_hdr    *hdr;
+        __u32                    *groups;
+};
+
+struct kml_suffix { 
+        __u32                    prevrec;
+        __u32                    recno;
+        __u32                    time;
+        __u32                    len;
+};
+
+struct kml_rec {
+        char                   *buf;
+        struct kml_prefix       prefix;
+        __u64                   offset;
+        char                   *path;
+        int                     pathlen;
+        char                   *name;
+        int                     namelen;
+        char                   *target;
+        int                     targetlen;
+        struct presto_version  *old_objectv;
+        struct presto_version  *new_objectv;
+        struct presto_version  *old_parentv;
+        struct presto_version  *new_parentv;
+        struct presto_version  *old_targetv;
+        struct presto_version  *new_targetv;
+        __u32                   valid;
+        __u32                   mode;
+        __u32                   uid;
+        __u32                   gid;
+        __u64                   size;
+        __u32                   mtime_sec;
+        __u32                   mtime_nsec;
+        __u32                   ctime_sec;
+        __u32                   ctime_nsec;
+        __u32                   flags;
+        __u32                   ino;
+        __u32                   rdev;
+        __u32                   major;
+        __u32                   minor;
+        __u32                   generation;
+        __u32                   old_mode;
+        __u32                   old_rdev;
+        __u64                   old_uid;
+        __u64                   old_gid;
+        char                   *old_target;
+        int                     old_targetlen;
+        struct kml_suffix      *suffix;
+};
+
+
+/* RCVD */ 
+
+/* izo_rcvd_rec fills the .intermezzo/fset/last_rcvd file and provides data about
+ * our view of reintegration offsets for a given peer.
+ *
+ * The only exception is the last_rcvd record which has a UUID consisting of all
+ * zeroes; this record's lr_local_offset field is the logical byte offset of our
+ * KML, which is updated when KML truncation takes place.  All other fields are
+ * reserved. */
+
+/* XXX - document how clean shutdowns are recorded */
+
+struct izo_rcvd_rec { 
+        __u8    lr_uuid[16];       /* which peer? */
+        __u64   lr_remote_recno;   /* last confirmed remote recno  */
+        __u64   lr_remote_offset;  /* last confirmed remote offset */
+        __u64   lr_local_recno;    /* last locally reinted recno   */
+        __u64   lr_local_offset;   /* last locally reinted offset  */
+        __u64   lr_last_ctime;     /* the largest ctime that has reintegrated */
+};
+
+/* Cache purge database
+ *
+ * Each DB entry is this structure followed by the path name, no trailing NUL. */
+struct izo_purge_entry {
+        __u64 p_atime;
+        __u32 p_pathlen;
+};
+
+/* RPC */
+
+#endif
--- /dev/null	Fri Aug 30 17:31:37 2002
+++ linux-2.5.50-root/include/linux/intermezzo_lib.h	Tue Dec 10 20:53:33 2002
@@ -0,0 +1,168 @@
+/* -*- mode: c; c-basic-offset: 8; indent-tabs-mode: nil; -*-
+ * vim:expandtab:shiftwidth=8:tabstop=8:
+ *
+ * Copyright (C) 2001 Cluster File Systems, Inc. <braam@clusterfs.com>
+ *
+ *   This file is part of InterMezzo, http://www.inter-mezzo.org.
+ *
+ *   InterMezzo is free software; you can redistribute it and/or
+ *   modify it under the terms of version 2 of the GNU General Public
+ *   License as published by the Free Software Foundation.
+ *
+ *   InterMezzo is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with InterMezzo; if not, write to the Free Software
+ *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Data structures unpacking/packing macros & inlines
+ *
+ */
+
+#ifndef _INTERMEZZO_LIB_H
+#define _INTERMEZZO_LIB_H
+
+#ifdef __KERNEL__
+# include <linux/types.h>
+#else
+# include <string.h>
+# include <sys/types.h>
+#endif
+
+#undef MIN
+#define MIN(a,b) (((a)<(b)) ? (a): (b))
+#undef MAX
+#define MAX(a,b) (((a)>(b)) ? (a): (b))
+#define MKSTR(ptr) ((ptr))? (ptr) : ""
+
+static inline int size_round (int val)
+{
+	return (val + 3) & (~0x3);
+}
+
+static inline int size_round0(int val)
+{
+        if (!val) 
+                return 0;
+	return (val + 1 + 3) & (~0x3);
+}
+
+static inline size_t round_strlen(char *fset)
+{
+	return size_round(strlen(fset) + 1);
+}
+
+#ifdef __KERNEL__
+# define NTOH__u32(var) le32_to_cpu(var)
+# define NTOH__u64(var) le64_to_cpu(var)
+# define HTON__u32(var) cpu_to_le32(var)
+# define HTON__u64(var) cpu_to_le64(var)
+#else
+# include <glib.h>
+# define NTOH__u32(var) GUINT32_FROM_LE(var)
+# define NTOH__u64(var) GUINT64_FROM_LE(var)
+# define HTON__u32(var) GUINT32_TO_LE(var)
+# define HTON__u64(var) GUINT64_TO_LE(var)
+#endif
+
+/* 
+ * copy sizeof(type) bytes from pointer to var and move ptr forward.
+ * return EFAULT if pointer goes beyond end
+ */
+#define UNLOGV(var,type,ptr,end)                \
+do {                                            \
+        var = *(type *)ptr;                     \
+        ptr += sizeof(type);                    \
+        if (ptr > end )                         \
+                return -EFAULT;                 \
+} while (0)
+
+/* the following two macros convert to little endian */
+/* type MUST be __u32 or __u64 */
+#define LUNLOGV(var,type,ptr,end)               \
+do {                                            \
+        var = NTOH##type(*(type *)ptr);         \
+        ptr += sizeof(type);                    \
+        if (ptr > end )                         \
+                return -EFAULT;                 \
+} while (0)
+
+/* now log values */
+#define LOGV(var,type,ptr)                      \
+do {                                            \
+        *((type *)ptr) = var;                   \
+        ptr += sizeof(type);                    \
+} while (0)
+
+/* and in network order */
+#define LLOGV(var,type,ptr)                     \
+do {                                            \
+        *((type *)ptr) = HTON##type(var);       \
+        ptr += sizeof(type);                    \
+} while (0)
+
+
+/* 
+ * set var to point at (type *)ptr, move ptr forward with sizeof(type)
+ * return from function with EFAULT if ptr goes beyond end
+ */
+#define UNLOGP(var,type,ptr,end)                \
+do {                                            \
+        var = (type *)ptr;                      \
+        ptr += sizeof(type);                    \
+        if (ptr > end )                         \
+                return -EFAULT;                 \
+} while (0)
+
+#define LOGP(var,type,ptr)                      \
+do {                                            \
+        memcpy(ptr, var, sizeof(type));         \
+        ptr += sizeof(type);                    \
+} while (0)
+
+/* 
+ * set var to point at (char *)ptr, move ptr forward by size_round(len);
+ * return from function with EFAULT if ptr goes beyond end
+ */
+#define UNLOGL(var,type,len,ptr,end)                    \
+do {                                                    \
+        if (len == 0)                                   \
+                var = (type *)0;                        \
+        else {                                          \
+                var = (type *)ptr;                      \
+                ptr += size_round(len * sizeof(type));  \
+        }                                               \
+        if (ptr > end )                                 \
+                return -EFAULT;                         \
+} while (0)
+
+#define UNLOGL0(var,type,len,ptr,end)                           \
+do {                                                            \
+        UNLOGL(var,type,len+1,ptr,end);                         \
+        if ( *((char *)ptr - size_round(len+1) + len) != '\0')  \
+                        return -EFAULT;                         \
+} while (0)
+
+#define LOGL(var,len,ptr)                               \
+do {                                                    \
+        size_t __fill = size_round(len);                \
+        /* Prevent data leakage. */                     \
+        if (__fill > 0)                                 \
+                memset((char *)ptr, 0, __fill);         \
+        memcpy((char *)ptr, (const char *)var, len);    \
+        ptr += __fill;                                  \
+} while (0)
+
+#define LOGL0(var,len,ptr)                              \
+do {                                                    \
+        if (!len) break;                                \
+        memcpy((char *)ptr, (const char *)var, len);    \
+        *((char *)(ptr) + len) = 0;                     \
+        ptr += size_round(len + 1);                     \
+} while (0)
+
+#endif /* _INTERMEZZO_LIB_H */
+

_

--vkogqOf2sHV7VnPd--
