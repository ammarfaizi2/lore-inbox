Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVDJDcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVDJDcI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 23:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDJDcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 23:32:08 -0400
Received: from ozlabs.org ([203.10.76.45]:49554 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261323AbVDJD2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 23:28:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16984.40283.49849.249233@cargo.ozlabs.ibm.com>
Date: Sun, 10 Apr 2005 13:28:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Update DRM ioctl compatibility to new world order
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, against 2.6.12-rc2-mm2, updates the DRM ioctl
compatibility code.  Now it is implemented via the compat_ioctl method
in the file_operations structure, rather than using the old
register_ioctl32_conversion thing.  I also use compat_alloc_user_space
rather than doing set_fs.

For now, I have put a lock_kernel/unlock_kernel in there so the DRM
ioctl routines have the same environment (BKL held) as before.  We
will have to do some careful analysis to work out if the DRM code
needs any extra locking to be safe without the BKL, I think, and I'd
rather do that as a separate change.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN 2.6.12-rc2-mm2/drivers/char/drm/drmP.h g5-ppc64/drivers/char/drm/drmP.h
--- 2.6.12-rc2-mm2/drivers/char/drm/drmP.h	2005-04-08 18:21:54.000000000 +1000
+++ g5-ppc64/drivers/char/drm/drmP.h	2005-04-09 22:50:06.000000000 +1000
@@ -316,6 +316,9 @@
 typedef int drm_ioctl_t( struct inode *inode, struct file *filp,
 			 unsigned int cmd, unsigned long arg );
 
+typedef int drm_ioctl_compat_t(struct file *filp, unsigned int cmd,
+			       unsigned long arg);
+
 typedef struct drm_ioctl_desc {
 	drm_ioctl_t	     *func;
 	int		     auth_needed;
@@ -775,6 +778,8 @@
 				  unsigned int cmd, unsigned long arg);
 extern int           drm_ioctl(struct inode *inode, struct file *filp,
 				unsigned int cmd, unsigned long arg);
+extern long	     drm_compat_ioctl(struct file *filp,
+				unsigned int cmd, unsigned long arg);
 extern int           drm_takedown(drm_device_t * dev);
 
 				/* Device support (drm_fops.h) */
@@ -1069,8 +1074,5 @@
 extern unsigned long drm_core_get_map_ofs(drm_map_t *map);
 extern unsigned long drm_core_get_reg_ofs(struct drm_device *dev);
 
-extern int drm_register_ioc32(void);
-extern void drm_unregister_ioc32(void);
-
 #endif /* __KERNEL__ */
 #endif
diff -urN 2.6.12-rc2-mm2/drivers/char/drm/drm_drv.c g5-ppc64/drivers/char/drm/drm_drv.c
--- 2.6.12-rc2-mm2/drivers/char/drm/drm_drv.c	2005-04-08 18:21:54.000000000 +1000
+++ g5-ppc64/drivers/char/drm/drm_drv.c	2005-04-09 22:50:15.000000000 +1000
@@ -407,10 +407,6 @@
 		goto err_p3;
 	}
 		
-#ifdef CONFIG_COMPAT
-	drm_register_ioc32();
-#endif
-
 	DRM_INFO( "Initialized %s %d.%d.%d %s\n",
 		CORE_NAME, CORE_MAJOR, CORE_MINOR, CORE_PATCHLEVEL,
 		CORE_DATE);
@@ -426,9 +422,6 @@
 
 static void __exit drm_core_exit (void)
 {
-#ifdef CONFIG_COMPAT
-	drm_unregister_ioc32();
-#endif
 	remove_proc_entry("dri", NULL);
 	drm_sysfs_destroy(drm_class);
 
diff -urN 2.6.12-rc2-mm2/drivers/char/drm/drm_ioc32.c g5-ppc64/drivers/char/drm/drm_ioc32.c
--- 2.6.12-rc2-mm2/drivers/char/drm/drm_ioc32.c	2005-04-08 18:21:54.000000000 +1000
+++ g5-ppc64/drivers/char/drm/drm_ioc32.c	2005-04-10 13:11:29.000000000 +1000
@@ -79,42 +79,42 @@
 	u32	desc;		  /**< User-space buffer to hold desc */
 } drm_version32_t;
 
-static int compat_drm_version(unsigned int fd, unsigned int cmd, 
-			      unsigned long arg, struct file *file)
+static int compat_drm_version(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
 	drm_version32_t v32;
-	drm_version_t version;
-	mm_segment_t oldfs;
+	drm_version_t __user *version;
 	int err;
 
 	if (copy_from_user(&v32, (void __user *) arg, sizeof(v32)))
 		return -EFAULT;
-	version.name_len = v32.name_len;
-	version.name = (void __user *)(unsigned long)v32.name;
-	version.date_len = v32.date_len;
-	version.date = (void __user *)(unsigned long)v32.date;
-	version.desc_len = v32.desc_len;
-	version.desc = (void __user *)(unsigned long)v32.desc;
-
-	if (!access_ok(VERIFY_WRITE, version.name, version.name_len)
-	    || !access_ok(VERIFY_WRITE, version.date, version.date_len)
-	    || !access_ok(VERIFY_WRITE, version.desc, version.desc_len))
+
+	version = compat_alloc_user_space(sizeof(*version));
+	if (!access_ok(VERIFY_WRITE, version, sizeof(*version)))
+		return -EFAULT;
+	if (__put_user(v32.name_len, &version->name_len)
+	    || __put_user((void __user *)(unsigned long)v32.name,
+			  &version->name)
+	    || __put_user(v32.date_len, &version->date_len)
+	    || __put_user((void __user *)(unsigned long)v32.date,
+			  &version->date)
+	    || __put_user(v32.desc_len, &version->desc_len)
+	    || __put_user((void __user *)(unsigned long)v32.desc,
+			  &version->desc))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_VERSION, (unsigned long) &version);
-	set_fs(oldfs);
+			DRM_IOCTL_VERSION, (unsigned long) version);
 	if (err)
 		return err;
 
-	v32.version_major = version.version_major;
-	v32.version_minor = version.version_minor;
-	v32.version_patchlevel = version.version_patchlevel;
-	v32.name_len = version.name_len;
-	v32.date_len = version.date_len;
-	v32.desc_len = version.desc_len;
+	if (__get_user(v32.version_major, &version->version_major)
+	    || __get_user(v32.version_minor, &version->version_minor)
+	    || __get_user(v32.version_patchlevel, &version->version_patchlevel)
+	    || __get_user(v32.name_len, &version->name_len)
+	    || __get_user(v32.date_len, &version->date_len)
+	    || __get_user(v32.desc_len, &version->desc_len))
+		return -EFAULT;
 
 	if (copy_to_user((void __user *) arg, &v32, sizeof(v32)))
 		return -EFAULT;
@@ -126,58 +126,55 @@
 	u32 unique;	/**< Unique name for driver instantiation */
 } drm_unique32_t;
 
-static int compat_drm_getunique(unsigned int fd, unsigned int cmd, 
-				unsigned long arg, struct file *file)
+static int compat_drm_getunique(struct file *file, unsigned int cmd,
+				unsigned long arg)
 {
-	drm_unique32_t u32;
-	drm_unique_t u;
-	mm_segment_t oldfs;
+	drm_unique32_t uq32;
+	drm_unique_t __user *u;
 	int err;
 
-	if (copy_from_user(&u32, (void __user *) arg, sizeof(u32)))
+	if (copy_from_user(&uq32, (void __user *) arg, sizeof(uq32)))
+		return -EFAULT;
+
+	u = compat_alloc_user_space(sizeof(*u));
+	if (!access_ok(VERIFY_WRITE, u, sizeof(*u)))
 		return -EFAULT;
-	u.unique_len = u32.unique_len;
-	u.unique = (void __user *)(unsigned long) u32.unique;
-	if (!access_ok(VERIFY_WRITE, u.unique, u.unique_len))
+	if (__put_user(uq32.unique_len, &u->unique_len)
+	    || __put_user((void __user *)(unsigned long) uq32.unique,
+			  &u->unique))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_GET_UNIQUE, (unsigned long) &u);
-	set_fs(oldfs);
+			DRM_IOCTL_GET_UNIQUE, (unsigned long) u);
 	if (err)
 		return err;
 
-	u32.unique_len = u.unique_len;
-	if (copy_to_user((void __user *) arg, &u32, sizeof(u32)))
+	if (__get_user(uq32.unique_len, &u->unique_len))
+		return -EFAULT;
+	if (copy_to_user((void __user *) arg, &uq32, sizeof(uq32)))
 		return -EFAULT;
 	return 0;
 }
 
-static int compat_drm_setunique(unsigned int fd, unsigned int cmd, 
-				unsigned long arg, struct file *file)
+static int compat_drm_setunique(struct file *file, unsigned int cmd,
+				unsigned long arg)
 {
-	drm_unique32_t u32;
-	drm_unique_t u;
-	int err;
-	mm_segment_t oldfs;
+	drm_unique32_t uq32;
+	drm_unique_t __user *u;
 
-	if (copy_from_user(&u32, (void __user *) arg, sizeof(u32)))
+	if (copy_from_user(&uq32, (void __user *) arg, sizeof(uq32)))
 		return -EFAULT;
 
-	u.unique_len = u32.unique_len;
-	u.unique = (void __user *)(unsigned long) u32.unique;
-	if (!access_ok(VERIFY_READ, u.unique, u.unique_len))
+	u = compat_alloc_user_space(sizeof(*u));
+	if (!access_ok(VERIFY_WRITE, u, sizeof(*u)))
+		return -EFAULT;
+	if (__put_user(uq32.unique_len, &u->unique_len)
+	    || __put_user((void __user *)(unsigned long) uq32.unique,
+			  &u->unique))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_SET_UNIQUE, (unsigned long) &u);
-	set_fs(oldfs);
-
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_SET_UNIQUE, (unsigned long) u);
 }
 
 typedef struct drm_map32 {
@@ -189,74 +186,80 @@
 	int	mtrr;		/**< MTRR slot used */
 } drm_map32_t;
 
-static int compat_drm_getmap(unsigned int fd, unsigned int cmd, 
-			     unsigned long arg, struct file *file)
+static int compat_drm_getmap(struct file *file, unsigned int cmd,
+			     unsigned long arg)
 {
 	drm_map32_t __user *argp = (void __user *)arg;
 	drm_map32_t m32;
-	drm_map_t map;
+	drm_map_t __user *map;
 	int idx, err;
-	mm_segment_t oldfs;
+	void *handle;
 
 	if (get_user(idx, &argp->offset))
 		return -EFAULT;
-	map.offset = idx;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_GET_MAP, (unsigned long) &map);
-	set_fs(oldfs);
+	map = compat_alloc_user_space(sizeof(*map));
+	if (!access_ok(VERIFY_WRITE, map, sizeof(*map)))
+		return -EFAULT;
+	if (__put_user(idx, &map->offset))
+		return -EFAULT;
 
+	err = drm_ioctl(file->f_dentry->d_inode, file,
+			DRM_IOCTL_GET_MAP, (unsigned long) map);
 	if (err)
 		return err;
 
-	m32.offset = map.offset;
-	m32.size   = map.size;
-	m32.type   = map.type;
-	m32.flags  = map.flags;
-	m32.handle = (unsigned long) map.handle;
-	m32.mtrr   = map.mtrr;
+	if (__get_user(m32.offset, &map->offset)
+	    || __get_user(m32.size, &map->size)
+	    || __get_user(m32.type, &map->type)
+	    || __get_user(m32.flags, &map->flags)
+	    || __get_user(handle, &map->handle)
+	    || __get_user(m32.mtrr, &map->mtrr))
+		return -EFAULT;
 
+	m32.handle = (unsigned long) handle;
 	if (copy_to_user(argp, &m32, sizeof(m32)))
 		return -EFAULT;
 	return 0;
 
 }
 
-static int compat_drm_addmap(unsigned int fd, unsigned int cmd, 
-			     unsigned long arg, struct file *file)
+static int compat_drm_addmap(struct file *file, unsigned int cmd,
+			     unsigned long arg)
 {
 	drm_map32_t __user *argp = (void __user *)arg;
 	drm_map32_t m32;
-	drm_map_t map;
+	drm_map_t __user *map;
 	int err;
-	mm_segment_t oldfs;
+	void *handle;
 
 	if (copy_from_user(&m32, argp, sizeof(m32)))
 		return -EFAULT;
 
-	map.offset = m32.offset;
-	map.size   = m32.size;
-	map.type   = m32.type;
-	map.flags  = m32.flags;
+	map = compat_alloc_user_space(sizeof(*map));
+	if (!access_ok(VERIFY_WRITE, map, sizeof(*map)))
+		return -EFAULT;
+	if (__put_user(m32.offset, &map->offset)
+	    || __put_user(m32.size, &map->size)
+	    || __put_user(m32.type, &map->type)
+	    || __put_user(m32.flags, &map->flags))
+		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_ADD_MAP, (unsigned long) &map);
-	set_fs(oldfs);
+			DRM_IOCTL_ADD_MAP, (unsigned long) map);
 	if (err)
 		return err;
 
-	m32.offset = map.offset;
-	m32.mtrr   = map.mtrr;
-	m32.handle = (unsigned long) map.handle;
+	if (__get_user(m32.offset, &map->offset)
+	    || __get_user(m32.mtrr, &map->mtrr)
+	    || __get_user(handle, &map->handle))
+		return -EFAULT;
 
-	if (m32.handle != (unsigned long) map.handle && printk_ratelimit())
+	m32.handle = (unsigned long) handle;
+	if (m32.handle != (unsigned long) handle && printk_ratelimit())
 		printk(KERN_ERR "compat_drm_addmap truncated handle"
-		       " %p for type %d offset %lx\n",
-		       map.handle, map.type, map.offset);
+		       " %p for type %d offset %x\n",
+		       handle, m32.type, m32.offset);
 
 	if (copy_to_user(argp, &m32, sizeof(m32)))
 		return -EFAULT;
@@ -264,27 +267,24 @@
 	return 0;
 }
 
-static int compat_drm_rmmap(unsigned int fd, unsigned int cmd, 
-			    unsigned long arg, struct file *file)
+static int compat_drm_rmmap(struct file *file, unsigned int cmd,
+			    unsigned long arg)
 {
 	drm_map32_t __user *argp = (void __user *)arg;
-	drm_map_t map;
+	drm_map_t __user *map;
 	u32 handle;
-	int err;
-	mm_segment_t oldfs;
 
 	if (get_user(handle, &argp->handle))
 		return -EFAULT;
 
-	map.handle = (void *)(unsigned long) handle;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RM_MAP, (unsigned long) &map);
-	set_fs(oldfs);
+	map = compat_alloc_user_space(sizeof(*map));
+	if (!access_ok(VERIFY_WRITE, map, sizeof(*map)))
+		return -EFAULT;
+	if (__put_user((void *)(unsigned long) handle, &map->handle))
+		return -EFAULT;
 
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RM_MAP, (unsigned long) map);
 }
 
 typedef struct drm_client32 {
@@ -296,33 +296,34 @@
 	u32	iocs;	/**< Ioctl count */
 } drm_client32_t;
 
-static int compat_drm_getclient(unsigned int fd, unsigned int cmd, 
-				unsigned long arg, struct file *file)
+static int compat_drm_getclient(struct file *file, unsigned int cmd,
+				unsigned long arg)
 {
 	drm_client32_t c32;
 	drm_client32_t __user *argp = (void __user *)arg;
-	drm_client_t client;
+	drm_client_t __user *client;
 	int idx, err;
-	mm_segment_t oldfs;
 
 	if (get_user(idx, &argp->idx))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	client.idx = idx;
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_GET_CLIENT, (unsigned long) &client);
-	set_fs(oldfs);
+	client = compat_alloc_user_space(sizeof(*client));
+	if (!access_ok(VERIFY_WRITE, client, sizeof(*client)))
+		return -EFAULT;
+	if (__put_user(idx, &client->idx))
+		return -EFAULT;
 
+	err = drm_ioctl(file->f_dentry->d_inode, file,
+			DRM_IOCTL_GET_CLIENT, (unsigned long) client);
 	if (err)
 		return err;
 
-	c32.auth  = client.auth;
-	c32.pid   = client.pid;
-	c32.uid   = client.uid;
-	c32.magic = client.magic;
-	c32.iocs  = client.iocs;
+	if (__get_user(c32.auth, &client->auth)
+	    || __get_user(c32.pid, &client->pid)
+	    || __get_user(c32.uid, &client->uid)
+	    || __get_user(c32.magic, &client->magic)
+	    || __get_user(c32.iocs, &client->iocs))
+		return -EFAULT;
 
 	if (copy_to_user(argp, &c32, sizeof(c32)))
 		return -EFAULT;
@@ -337,29 +338,29 @@
 	} data[15];
 } drm_stats32_t;
 
-static int compat_drm_getstats(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_getstats(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_stats32_t s32;
 	drm_stats32_t __user *argp = (void __user *)arg;
-	drm_stats_t stats;
-	mm_segment_t oldfs;
+	drm_stats_t __user *stats;
 	int i, err;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_GET_STATS, (unsigned long) &stats);
-	set_fs(oldfs);
+	stats = compat_alloc_user_space(sizeof(*stats));
+	if (!access_ok(VERIFY_WRITE, stats, sizeof(*stats)))
+		return -EFAULT;
 
+	err = drm_ioctl(file->f_dentry->d_inode, file,
+			DRM_IOCTL_GET_STATS, (unsigned long) stats);
 	if (err)
 		return err;
 
-	s32.count = stats.count;
-	for (i = 0; i < 15; ++i) {
-		s32.data[i].value = stats.data[i].value;
-		s32.data[i].type = stats.data[i].type;
-	}
+	if (__get_user(s32.count, &stats->count))
+		return -EFAULT;
+	for (i = 0; i < 15; ++i)
+		if (__get_user(s32.data[i].value, &stats->data[i].value)
+		    || __get_user(s32.data[i].type, &stats->data[i].type))
+			return -EFAULT;
 
 	if (copy_to_user(argp, &s32, sizeof(s32)))
 		return -EFAULT;
@@ -375,66 +376,58 @@
 	u32	      agp_start; /**< Start address in the AGP aperture */
 } drm_buf_desc32_t;
 
-static int compat_drm_addbufs(unsigned int fd, unsigned int cmd, 
-			      unsigned long arg, struct file *file)
+static int compat_drm_addbufs(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
-	drm_buf_desc32_t b32;
 	drm_buf_desc32_t __user *argp = (void __user *)arg;
-	drm_buf_desc_t buf;
-	mm_segment_t oldfs;
+	drm_buf_desc_t __user *buf;
 	int err;
+	unsigned long agp_start;
 
-	if (copy_from_user(&b32, argp, sizeof(b32)))
+	buf = compat_alloc_user_space(sizeof(*buf));
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(*buf))
+	    || !access_ok(VERIFY_WRITE, argp, sizeof(*argp)))
+		return -EFAULT;
+
+	if (__copy_in_user(buf, argp, offsetof(drm_buf_desc32_t, agp_start))
+	    || __get_user(agp_start, &argp->agp_start)
+	    || __put_user(agp_start, &buf->agp_start))
 		return -EFAULT;
-	buf.count = b32.count;
-	buf.size = b32.size;
-	buf.low_mark = b32.low_mark;
-	buf.high_mark = b32.high_mark;
-	buf.flags = b32.flags;
-	buf.agp_start = b32.agp_start;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_ADD_BUFS, (unsigned long) &buf);
-	set_fs(oldfs);
+			DRM_IOCTL_ADD_BUFS, (unsigned long) buf);
 	if (err)
 		return err;
 
-	b32.count = buf.count;
-	b32.size = buf.size;
-	b32.low_mark = buf.low_mark;
-	b32.high_mark = buf.high_mark;
-	b32.flags = buf.flags;
-	b32.agp_start = buf.agp_start;
-	if (copy_to_user(argp, &b32, sizeof(b32)))
+	if (__copy_in_user(argp, buf, offsetof(drm_buf_desc32_t, agp_start))
+	    || __get_user(agp_start, &buf->agp_start)
+	    || __put_user(agp_start, &argp->agp_start))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int compat_drm_markbufs(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_markbufs(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_buf_desc32_t b32;
 	drm_buf_desc32_t __user *argp = (void __user *)arg;
-	drm_buf_desc_t buf;
-	mm_segment_t oldfs;
-	int err;
+	drm_buf_desc_t __user *buf;
 
 	if (copy_from_user(&b32, argp, sizeof(b32)))
 		return -EFAULT;
-	buf.size = b32.size;
-	buf.low_mark = b32.low_mark;
-	buf.high_mark = b32.high_mark;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_MARK_BUFS, (unsigned long) &buf);
-	set_fs(oldfs);
+	buf = compat_alloc_user_space(sizeof(*buf));
+	if (!access_ok(VERIFY_WRITE, buf, sizeof(*buf)))
+		return -EFAULT;
 
-	return err;
+	if (__put_user(b32.size, &buf->size)
+	    || __put_user(b32.low_mark, &buf->low_mark)
+	    || __put_user(b32.high_mark, &buf->high_mark))
+		return -EFAULT;
+
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_MARK_BUFS, (unsigned long) buf);
 }
 
 typedef struct drm_buf_info32 {
@@ -442,65 +435,56 @@
 	u32	       list;
 } drm_buf_info32_t;
 
-static int compat_drm_infobufs(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_infobufs(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_buf_info32_t req32;
 	drm_buf_info32_t __user *argp = (void __user *)arg;
 	drm_buf_desc32_t __user *to;
-	drm_buf_info_t request;
-	drm_buf_desc_t *list = NULL;
+	drm_buf_info_t __user *request;
+	drm_buf_desc_t __user *list;
+	size_t nbytes;
 	int i, err;
-	int count;
-	mm_segment_t oldfs;
+	int count, actual;
 
-	if (copy_from_user( &request, argp, sizeof(request)))
+	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
+
 	count = req32.count;
 	to = (drm_buf_desc32_t __user *)(unsigned long) req32.list;
+	if (count < 0)
+		count = 0;
+	if (count > 0
+	    && !access_ok(VERIFY_WRITE, to, count * sizeof(drm_buf_desc32_t)))
+		return -EFAULT;
 
-	if (count > 0) {
-		if (count > DRM_MAX_ORDER + 2)
-			count = DRM_MAX_ORDER + 2;
-		if (!access_ok(VERIFY_WRITE, to,
-			       count * sizeof(drm_buf_desc32_t)))
-			return -EFAULT;
-		list = kmalloc(count * sizeof(drm_buf_desc_t), GFP_KERNEL);
-		if (list == NULL)
-			return -ENOMEM;
-	}
+	nbytes = sizeof(*request) + count * sizeof(drm_buf_desc_t);
+	request = compat_alloc_user_space(nbytes);
+	if (!access_ok(VERIFY_WRITE, request, nbytes))
+		return -EFAULT;
+	list = (drm_buf_desc_t *) (request + 1);
 
-	request.count = count;
-	request.list = (drm_buf_desc_t __user *) list;
+	if (__put_user(count, &request->count)
+	    || __put_user(list, &request->list))
+		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_INFO_BUFS, (unsigned long) &request);
-	set_fs(oldfs);
+			DRM_IOCTL_INFO_BUFS, (unsigned long) request);
 	if (err)
-		goto out;
+		return err;
 
-	err = -EFAULT;
-	if (count >= request.count) {
-		for (i = 0; i < request.count; ++i) {
-			if (__put_user(list[i].count, &to->count) ||
-			    __put_user(list[i].size, &to->size) ||
-			    __put_user(list[i].low_mark, &to->low_mark) ||
-			    __put_user(list[i].high_mark, &to->high_mark))
-				goto out;
-			++to;
-		}
-	}
+	if (__get_user(actual, &request->count))
+		return -EFAULT;
+	if (count >= actual)
+		for (i = 0; i < actual; ++i)
+			if (__copy_in_user(&to[i], &list[i],
+					   offsetof(drm_buf_desc_t, flags)))
+				return -EFAULT;
+
+	if (__put_user(actual, &argp->count))
+		return -EFAULT;
 
-	request.count = count;
-	if (copy_to_user(argp, &request, sizeof(request)))
-		goto out;
-	err = 0;
-
- out:
-	kfree(list);
-	return err;
+	return 0;
 }
 
 typedef struct drm_buf_pub32 {
@@ -516,59 +500,58 @@
 	u32	list;		/**< Buffer information */
 } drm_buf_map32_t;
 
-static int compat_drm_mapbufs(unsigned int fd, unsigned int cmd, 
-			      unsigned long arg, struct file *file)
+static int compat_drm_mapbufs(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
+	drm_buf_map32_t __user *argp = (void __user *)arg;
 	drm_buf_map32_t req32;
 	drm_buf_pub32_t __user *list32;
-	drm_buf_map_t request;
-	drm_buf_pub_t *list;
-	drm_buf_map32_t __user *argp = (void __user *)arg;
-	mm_segment_t oldfs;
+	drm_buf_map_t __user *request;
+	drm_buf_pub_t __user *list;
 	int i, err;
+	int count, actual;
+	size_t nbytes;
+	void __user *addr;
 
 	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
+	count = req32.count;
+	list32 = (void __user *)(unsigned long)req32.list;
+
+	if (count < 0)
+		return -EINVAL;
+	nbytes = sizeof(*request) + count * sizeof(drm_buf_pub_t);
+	request = compat_alloc_user_space(nbytes);
+	if (!access_ok(VERIFY_WRITE, request, nbytes))
+		return -EFAULT;
+	list = (drm_buf_pub_t *) (request + 1);
+
+	if (__put_user(count, &request->count)
+	    || __put_user(list, &request->list))
+		return -EFAULT;
 
-	if (req32.count < 0 || req32.count > 100)
-		return -EINVAL;		/* somewhat arbitrary limit */
-	list = kmalloc(req32.count * sizeof(drm_buf_pub_t), GFP_KERNEL);
-	if (list == NULL)
-		return -ENOMEM;
-
-	request.count = req32.count;
-	request.list = list;
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_MAP_BUFS, (unsigned long) &request);
-	set_fs(oldfs);
+			DRM_IOCTL_MAP_BUFS, (unsigned long) request);
 	if (err)
-		goto out;
+		return err;
 
-	if (req32.count >= request.count) {
-		list32 = (void __user *)(unsigned long)req32.list;
-		for (i = 0; i < request.count; ++i) {
-			err = -EFAULT;
-			if (put_user(list[i].idx, &list32[i].idx) ||
-			    put_user(list[i].total, &list32[i].total) ||
-			    put_user(list[i].used, &list32[i].used) ||
-			    put_user((unsigned long)list[i].address,
-				     &list32[i].address))
-				goto out;
-		}
-	}
-	req32.count = request.count;
-	req32.virtual = (unsigned long) request.virtual;
+	if (__get_user(actual, &request->count))
+		return -EFAULT;
+	if (count >= actual)
+		for (i = 0; i < actual; ++i)
+			if (__copy_in_user(&list32[i], &list[i],
+					   offsetof(drm_buf_pub_t, address))
+			    || __get_user(addr, &list[i].address)
+			    || __put_user((unsigned long) addr,
+					  &list32[i].address))
+				return -EFAULT;
 
-	err = -EFAULT;
-	if (copy_to_user(argp, &req32, sizeof(req32)))
-		goto out;
-	err = 0;
+	if (__put_user(actual, &argp->count)
+	    || __get_user(addr, &request->virtual)
+	    || __put_user((unsigned long) addr, &argp->virtual))
+		return -EFAULT;
 
- out:
-	kfree(list);
-	return err;
+	return 0;
 }
 
 typedef struct drm_buf_free32 {
@@ -576,30 +559,26 @@
 	u32	list;
 } drm_buf_free32_t;
 
-static int compat_drm_freebufs(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_freebufs(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_buf_free32_t req32;
-	drm_buf_free_t request;
+	drm_buf_free_t __user *request;
 	drm_buf_free32_t __user *argp = (void __user *)arg;
-	mm_segment_t oldfs;
-	int err;
 
 	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
 
-	request.count = req32.count;
-	request.list = (int __user *)(unsigned long) req32.list;
-	if (!access_ok(VERIFY_WRITE, request.list, request.count))
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request)))
+		return -EFAULT;
+	if (__put_user(req32.count, &request->count)
+	    || __put_user((int __user *)(unsigned long) req32.list,
+			  &request->list))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_FREE_BUFS, (unsigned long) &request);
-	set_fs(oldfs);
-
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_FREE_BUFS, (unsigned long) request);
 }
 
 typedef struct drm_ctx_priv_map32 {
@@ -607,53 +586,54 @@
 	u32		handle; /**< Handle of map */
 } drm_ctx_priv_map32_t;
 
-static int compat_drm_setsareactx(unsigned int fd, unsigned int cmd, 
-				  unsigned long arg, struct file *file)
+static int compat_drm_setsareactx(struct file *file, unsigned int cmd,
+				  unsigned long arg)
 {
 	drm_ctx_priv_map32_t req32;
-	drm_ctx_priv_map_t request;
+	drm_ctx_priv_map_t __user *request;
 	drm_ctx_priv_map32_t __user *argp = (void __user *)arg;
-	int err;
-	mm_segment_t oldfs;
 
 	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
-	request.ctx_id = req32.ctx_id;
-	request.handle = (void *)(unsigned long) req32.handle;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_SET_SAREA_CTX, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request)))
+		return -EFAULT;
+	if (__put_user(req32.ctx_id, &request->ctx_id)
+	    || __put_user((void *)(unsigned long) req32.handle,
+			  &request->handle))
+		return -EFAULT;
 
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_SET_SAREA_CTX, (unsigned long) request);
 }
 
-static int compat_drm_getsareactx(unsigned int fd, unsigned int cmd, 
-				  unsigned long arg, struct file *file)
+static int compat_drm_getsareactx(struct file *file, unsigned int cmd,
+				  unsigned long arg)
 {
-	drm_ctx_priv_map32_t req32;
-	drm_ctx_priv_map_t request;
+	drm_ctx_priv_map_t __user *request;
 	drm_ctx_priv_map32_t __user *argp = (void __user *)arg;
 	int err;
-	mm_segment_t oldfs;
+	unsigned int ctx_id;
+	void *handle;
 
-	if (copy_from_user(&req32, argp, sizeof(req32)))
+	if (!access_ok(VERIFY_WRITE, argp, sizeof(*argp))
+	    || __get_user(ctx_id, &argp->ctx_id))
+		return -EFAULT;
+
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request)))
+		return -EFAULT;
+	if (__put_user(ctx_id, &request->ctx_id))
 		return -EFAULT;
-	request.ctx_id = req32.ctx_id;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_GET_SAREA_CTX, (unsigned long) &request);
-	set_fs(oldfs);
+			DRM_IOCTL_GET_SAREA_CTX, (unsigned long) request);
 	if (err)
 		return err;
 
-	req32.handle = (unsigned long) request.handle;
-
-	if (copy_to_user(argp, &req32, sizeof(req32)))
+	if (__get_user(handle, &request->handle)
+	    || __put_user((unsigned long) handle, &argp->handle))
 		return -EFAULT;
 
 	return 0;
@@ -664,33 +644,32 @@
 	u32	contexts;
 } drm_ctx_res32_t;
 
-static int compat_drm_resctx(unsigned int fd, unsigned int cmd, 
-			     unsigned long arg, struct file *file)
+static int compat_drm_resctx(struct file *file, unsigned int cmd,
+			     unsigned long arg)
 {
+	drm_ctx_res32_t __user *argp = (void __user *)arg;
 	drm_ctx_res32_t res32;
-	drm_ctx_res_t res;
+	drm_ctx_res_t __user *res;
 	int err;
-	mm_segment_t oldfs;
 
-	if (copy_from_user(&res32, (void __user *)arg, sizeof(res32)))
+	if (copy_from_user(&res32, argp, sizeof(res32)))
 		return -EFAULT;
 
-	res.count = res32.count;
-	res.contexts = (drm_ctx_t __user *)(unsigned long) res32.contexts;
-	if (!access_ok(VERIFY_WRITE, res.contexts,
-		       res.count * sizeof(drm_ctx_t)))
+	res = compat_alloc_user_space(sizeof(*res));
+	if (!access_ok(VERIFY_WRITE, res, sizeof(*res)))
+		return -EFAULT;
+	if (__put_user(res32.count, &res->count)
+	    || __put_user((drm_ctx_t __user *)(unsigned long) res32.contexts,
+			  &res->contexts))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RES_CTX, (unsigned long) &res);
-	set_fs(oldfs);
+			DRM_IOCTL_RES_CTX, (unsigned long) res);
 	if (err)
 		return err;
 
-	res32.count = res.count;
-	if (copy_to_user((void __user *)arg, &res32, sizeof(res32)))
+	if (__get_user(res32.count, &res->count)
+	    || __put_user(res32.count, &argp->count))
 		return -EFAULT;
 
 	return 0;
@@ -709,54 +688,46 @@
 	int	granted_count;	  /**< Number of buffers granted */
 } drm_dma32_t;
 
-static int compat_drm_dma(unsigned int fd, unsigned int cmd, 
-			  unsigned long arg, struct file *file)
+static int compat_drm_dma(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	drm_dma32_t d32;
 	drm_dma32_t __user *argp = (void __user *) arg;
-	drm_dma_t d;
+	drm_dma_t __user *d;
 	int err;
-	mm_segment_t oldfs;
 
 	if (copy_from_user(&d32, argp, sizeof(d32)))
 		return -EFAULT;
 
-	d.context = d32.context;
-	d.send_count = d32.send_count;
-	d.send_indices = (int __user *)(unsigned long) d32.send_indices;
-	d.send_sizes = (int __user *)(unsigned long) d32.send_sizes;
-	d.flags = d32.flags;
-	d.request_count = d32.request_count;
-	d.request_size = d32.request_size;
-	d.request_indices = (int __user *)(unsigned long) d32.request_indices;
-	d.request_sizes = (int __user *)(unsigned long) d32.request_sizes;
-
-	if (d.send_count) {
-		size_t nb = d.send_count * sizeof(int);
-		if (!access_ok(VERIFY_READ, d.send_indices, nb)
-		    || !access_ok(VERIFY_READ, d.send_sizes, nb))
-			return -EFAULT;
-	}
-	if (d.request_count) {
-		size_t nb = d.request_count * sizeof(int);
-		if (!access_ok(VERIFY_WRITE, d.request_indices, nb)
-		    || !access_ok(VERIFY_WRITE, d.request_sizes, nb))
-			return -EFAULT;
-	}
+	d = compat_alloc_user_space(sizeof(*d));
+	if (!access_ok(VERIFY_WRITE, d, sizeof(*d)))
+		return -EFAULT;
+
+	if (__put_user(d32.context, &d->context)
+	    || __put_user(d32.send_count, &d->send_count)
+	    || __put_user((int __user *)(unsigned long) d32.send_indices,
+			  &d->send_indices)
+	    || __put_user((int __user *)(unsigned long) d32.send_sizes,
+			  &d->send_sizes)
+	    || __put_user(d32.flags, &d->flags)
+	    || __put_user(d32.request_count, &d->request_count)
+	    || __put_user((int __user *)(unsigned long) d32.request_indices,
+			  &d->request_indices)
+	    || __put_user((int __user *)(unsigned long) d32.request_sizes,
+			  &d->request_sizes))
+		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_DMA, (unsigned long) &d);
-	set_fs(oldfs);
+			DRM_IOCTL_DMA, (unsigned long) d);
 	if (err)
 		return err;
 
-	d32.request_size = d.request_size;
-	d32.granted_count = d.granted_count;
-
-	if (copy_to_user(argp, &d32, sizeof(d32)))
+	if (__get_user(d32.request_size, &d->request_size)
+	    || __get_user(d32.granted_count, &d->granted_count)
+	    || __put_user(d32.request_size, &argp->request_size)
+	    || __put_user(d32.granted_count, &argp->granted_count))
 		return -EFAULT;
+
 	return 0;
 }
 
@@ -765,26 +736,22 @@
 	u32 mode;	/**< AGP mode */
 } drm_agp_mode32_t;
 
-static int compat_drm_agp_enable(unsigned int fd, unsigned int cmd, 
-				 unsigned long arg, struct file *file)
+static int compat_drm_agp_enable(struct file *file, unsigned int cmd,
+				 unsigned long arg)
 {
 	drm_agp_mode32_t __user *argp = (void __user *)arg;
 	drm_agp_mode32_t m32;
-	drm_agp_mode_t mode;
-	mm_segment_t oldfs;
-	int err;
+	drm_agp_mode_t __user *mode;
 
-	if (copy_from_user(&m32, argp, sizeof(m32)))
+	if (get_user(m32.mode, &argp->mode))
 		return -EFAULT;
-	mode.mode = m32.mode;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_AGP_ENABLE, (unsigned long) &mode);
-	set_fs(oldfs);
+	mode = compat_alloc_user_space(sizeof(*mode));
+	if (put_user(m32.mode, &mode->mode))
+		return -EFAULT;
 
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_AGP_ENABLE, (unsigned long) mode);
 }
 
 typedef struct drm_agp_info32 {
@@ -801,33 +768,33 @@
 	unsigned short id_device;
 } drm_agp_info32_t;
 
-static int compat_drm_agp_info(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_agp_info(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_agp_info32_t __user *argp = (void __user *)arg;
 	drm_agp_info32_t i32;
-	drm_agp_info_t info;
-	mm_segment_t oldfs;
+	drm_agp_info_t __user *info;
 	int err;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_AGP_INFO, (unsigned long) &info);
-	set_fs(oldfs);
+	info = compat_alloc_user_space(sizeof(*info));
+	if (!access_ok(VERIFY_WRITE, info, sizeof(*info)))
+		return -EFAULT;
 
+	err = drm_ioctl(file->f_dentry->d_inode, file,
+			DRM_IOCTL_AGP_INFO, (unsigned long) info);
 	if (err)
 		return err;
 
-	i32.agp_version_major = info.agp_version_major;
-	i32.agp_version_minor = info.agp_version_minor;
-	i32.mode = info.mode;
-	i32.aperture_base = info.aperture_base;
-	i32.aperture_size = info.aperture_size;
-	i32.memory_allowed = info.memory_allowed;
-	i32.memory_used = info.memory_used;
-	i32.id_vendor = info.id_vendor;
-	i32.id_device = info.id_device;
+	if (__get_user(i32.agp_version_major, &info->agp_version_major)
+	    || __get_user(i32.agp_version_minor, &info->agp_version_minor)
+	    || __get_user(i32.mode, &info->mode)
+	    || __get_user(i32.aperture_base, &info->aperture_base)
+	    || __get_user(i32.aperture_size, &info->aperture_size)
+	    || __get_user(i32.memory_allowed, &info->memory_allowed)
+	    || __get_user(i32.memory_used, &info->memory_used)
+	    || __get_user(i32.id_vendor, &info->id_vendor)
+	    || __get_user(i32.id_device, &info->id_device))
+		return -EFAULT;
 
 	if (copy_to_user(argp, &i32, sizeof(i32)))
 		return -EFAULT;
@@ -842,60 +809,54 @@
         u32 physical;	/**< Physical used by i810 */
 } drm_agp_buffer32_t;
 
-static int compat_drm_agp_alloc(unsigned int fd, unsigned int cmd, 
-				unsigned long arg, struct file *file)
+static int compat_drm_agp_alloc(struct file *file, unsigned int cmd,
+				unsigned long arg)
 {
 	drm_agp_buffer32_t __user *argp = (void __user *)arg;
 	drm_agp_buffer32_t req32;
-	drm_agp_buffer_t request;
-	mm_segment_t oldfs;
+	drm_agp_buffer_t __user *request;
 	int err;
 
 	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
-	request.size = req32.size;
-	request.type = req32.type;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_AGP_ALLOC, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.size, &request->size)
+	    || __put_user(req32.type, &request->type))
+		return -EFAULT;
 
+	err = drm_ioctl(file->f_dentry->d_inode, file,
+			DRM_IOCTL_AGP_ALLOC, (unsigned long) request);
 	if (err)
 		return err;
 
-	req32.handle = request.handle;
-	req32.physical = request.physical;
-	if (copy_to_user(argp, &req32, sizeof(req32))) {
+	if (__get_user(req32.handle, &request->handle)
+	    || __get_user(req32.physical, &request->physical)
+	    || copy_to_user(argp, &req32, sizeof(req32))) {
 		drm_ioctl(file->f_dentry->d_inode, file,
-			  DRM_IOCTL_AGP_FREE, (unsigned long) &request);
+			  DRM_IOCTL_AGP_FREE, (unsigned long) request);
 		return -EFAULT;
 	}
 
 	return 0;
 }
 
-static int compat_drm_agp_free(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_agp_free(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_agp_buffer32_t __user *argp = (void __user *)arg;
-	drm_agp_buffer32_t req32;
-	drm_agp_buffer_t request;
-	mm_segment_t oldfs;
-	int err;
+	drm_agp_buffer_t __user *request;
+	u32 handle;
 
-	if (copy_from_user(&req32, argp, sizeof(req32)))
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || get_user(handle, &argp->handle)
+	    || __put_user(handle, &request->handle))
 		return -EFAULT;
-	request.handle = req32.handle;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_AGP_FREE, (unsigned long) &request);
-	set_fs(oldfs);
-
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_AGP_FREE, (unsigned long) request);
 }
 
 typedef struct drm_agp_binding32 {
@@ -903,109 +864,93 @@
 	u32 offset;	/**< In bytes -- will round to page boundary */
 } drm_agp_binding32_t;
 
-static int compat_drm_agp_bind(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_agp_bind(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_agp_binding32_t __user *argp = (void __user *)arg;
 	drm_agp_binding32_t req32;
-	drm_agp_binding_t request;
-	mm_segment_t oldfs;
-	int err;
+	drm_agp_binding_t __user *request;
 
 	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
-	request.handle = req32.handle;
-	request.offset = req32.offset;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_AGP_BIND, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.handle, &request->handle)
+	    || __put_user(req32.offset, &request->offset))
+		return -EFAULT;
 
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_AGP_BIND, (unsigned long) request);
 }
 
-static int compat_drm_agp_unbind(unsigned int fd, unsigned int cmd, 
-				 unsigned long arg, struct file *file)
+static int compat_drm_agp_unbind(struct file *file, unsigned int cmd,
+				 unsigned long arg)
 {
 	drm_agp_binding32_t __user *argp = (void __user *)arg;
-	drm_agp_binding32_t req32;
-	drm_agp_binding_t request;
-	mm_segment_t oldfs;
-	int err;
+	drm_agp_binding_t __user *request;
+	u32 handle;
 
-	if (copy_from_user(&req32, argp, sizeof(req32)))
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || get_user(handle, &argp->handle)
+	    || __put_user(handle, &request->handle))
 		return -EFAULT;
-	request.handle = req32.handle;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_AGP_UNBIND, (unsigned long) &request);
-	set_fs(oldfs);
-
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_AGP_UNBIND, (unsigned long) request);
 }
-#endif
+#endif /* __OS_HAS_AGP */
 
 typedef struct drm_scatter_gather32 {
 	u32 size;	/**< In bytes -- will round to page boundary */
 	u32 handle;	/**< Used for mapping / unmapping */
 } drm_scatter_gather32_t;
 
-static int compat_drm_sg_alloc(unsigned int fd, unsigned int cmd, 
-			       unsigned long arg, struct file *file)
+static int compat_drm_sg_alloc(struct file *file, unsigned int cmd,
+			       unsigned long arg)
 {
 	drm_scatter_gather32_t __user *argp = (void __user *)arg;
-	drm_scatter_gather32_t req32;
-	drm_scatter_gather_t request;
-	mm_segment_t oldfs;
+	drm_scatter_gather_t __user *request;
 	int err;
+	unsigned long x;
 
-	if (copy_from_user(&req32, argp, sizeof(req32)))
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || !access_ok(VERIFY_WRITE, argp, sizeof(*argp))
+	    || __get_user(x, &argp->size)
+	    || __put_user(x, &request->size))
 		return -EFAULT;
-	request.size = req32.size;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_SG_ALLOC, (unsigned long) &request);
-	set_fs(oldfs);
-
+			DRM_IOCTL_SG_ALLOC, (unsigned long) request);
 	if (err)
 		return err;
 
-	req32.handle = request.handle >> PAGE_SHIFT;
-	if (copy_to_user(argp, &req32, sizeof(req32)))
+	/* XXX not sure about the handle conversion here... */
+	if (__get_user(x, &request->handle)
+	    || __put_user(x >> PAGE_SHIFT, &argp->handle))
 		return -EFAULT;
+
 	return 0;
 }
 
-static int compat_drm_sg_free(unsigned int fd, unsigned int cmd, 
-			      unsigned long arg, struct file *file)
+static int compat_drm_sg_free(struct file *file, unsigned int cmd,
+			      unsigned long arg)
 {
-	drm_file_t *priv = file->private_data;
-	drm_device_t *dev = priv->head->dev;
 	drm_scatter_gather32_t __user *argp = (void __user *)arg;
-	drm_scatter_gather32_t req32;
-	drm_scatter_gather_t request;
-	mm_segment_t oldfs;
-	int err;
+	drm_scatter_gather_t __user *request;
+	unsigned long x;
 
-	if (copy_from_user(&req32, argp, sizeof(req32)))
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || !access_ok(VERIFY_WRITE, argp, sizeof(*argp))
+	    || __get_user(x, &argp->handle)
+	    || __put_user(x << PAGE_SHIFT, &request->handle))
 		return -EFAULT;
-	if (!dev->sg || req32.handle != (u32)(dev->sg->handle >> PAGE_SHIFT))
-		return -EINVAL;
-	request.handle = dev->sg->handle;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_SG_FREE, (unsigned long) &request);
-	set_fs(oldfs);
 
-	return err;
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_SG_FREE, (unsigned long) request);
 }
 
 struct drm_wait_vblank_request32 {
@@ -1026,33 +971,34 @@
 	struct drm_wait_vblank_reply32 reply;
 } drm_wait_vblank32_t;
 
-static int compat_drm_wait_vblank(unsigned int fd, unsigned int cmd, 
-				  unsigned long arg, struct file *file)
+static int compat_drm_wait_vblank(struct file *file, unsigned int cmd,
+				  unsigned long arg)
 {
 	drm_wait_vblank32_t __user *argp = (void __user *)arg;
 	drm_wait_vblank32_t req32;
-	drm_wait_vblank_t request;
-	mm_segment_t oldfs;
+	drm_wait_vblank_t __user *request;
 	int err;
 
 	if (copy_from_user(&req32, argp, sizeof(req32)))
 		return -EFAULT;
-	request.request.type = req32.request.type;
-	request.request.sequence = req32.request.sequence;
-	request.request.signal = req32.request.signal;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.request.type, &request->request.type)
+	    || __put_user(req32.request.sequence, &request->request.sequence)
+	    || __put_user(req32.request.signal, &request->request.signal))
+		return -EFAULT;
+
 	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_WAIT_VBLANK, (unsigned long) &request);
-	set_fs(oldfs);
+			DRM_IOCTL_WAIT_VBLANK, (unsigned long) request);
 	if (err)
 		return err;
 
-	req32.reply.type = request.reply.type;
-	req32.reply.sequence = request.reply.sequence;
-	req32.reply.tval_sec = request.reply.tval_sec;
-	req32.reply.tval_usec = request.reply.tval_usec;
+	if (__get_user(req32.reply.type, &request->reply.type)
+	    || __get_user(req32.reply.sequence, &request->reply.sequence)
+	    || __get_user(req32.reply.tval_sec, &request->reply.tval_sec)
+	    || __get_user(req32.reply.tval_usec, &request->reply.tval_usec))
+		return -EFAULT;
 
 	if (copy_to_user(argp, &req32, sizeof(req32)))
 		return -EFAULT;
@@ -1060,118 +1006,64 @@
 	return 0;
 }
 
-#define R	register_ioctl32_conversion
-
-int drm_register_ioc32(void)
-{
-	int err;
-
-	if ((err = R(DRM_IOCTL_VERSION32, compat_drm_version)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_UNIQUE32, compat_drm_getunique)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_MAGIC, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_IRQ_BUSID, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_MAP32, compat_drm_getmap)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_CLIENT32, compat_drm_getclient)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_STATS32, compat_drm_getstats)) != 0 ||
-	    (err = R(DRM_IOCTL_SET_VERSION, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_SET_UNIQUE32, compat_drm_setunique)) != 0 ||
-	    (err = R(DRM_IOCTL_AUTH_MAGIC, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_BLOCK, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_UNBLOCK, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_CONTROL, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_ADD_MAP32, compat_drm_addmap)) != 0 ||
-	    (err = R(DRM_IOCTL_ADD_BUFS32, compat_drm_addbufs)) != 0 ||
-	    (err = R(DRM_IOCTL_MARK_BUFS32, compat_drm_markbufs)) != 0 ||
-	    (err = R(DRM_IOCTL_INFO_BUFS32, compat_drm_infobufs)) != 0 ||
-	    (err = R(DRM_IOCTL_MAP_BUFS32, compat_drm_mapbufs)) != 0 ||
-	    (err = R(DRM_IOCTL_FREE_BUFS32, compat_drm_freebufs)) != 0 ||
-	    (err = R(DRM_IOCTL_RM_MAP32, compat_drm_rmmap)) != 0 ||
-	    (err = R(DRM_IOCTL_SET_SAREA_CTX32, compat_drm_setsareactx)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_SAREA_CTX32, compat_drm_getsareactx)) != 0 ||
-	    (err = R(DRM_IOCTL_ADD_CTX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RM_CTX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_MOD_CTX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_GET_CTX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_SWITCH_CTX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_NEW_CTX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RES_CTX32, compat_drm_resctx)) != 0 ||
-	    (err = R(DRM_IOCTL_ADD_DRAW, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RM_DRAW, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_DMA32, compat_drm_dma)) != 0 ||
-	    (err = R(DRM_IOCTL_LOCK, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_UNLOCK, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_FINISH, NULL)) != 0 ||
+drm_ioctl_compat_t *drm_compat_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_IOCTL_VERSION32)] = compat_drm_version,
+	[DRM_IOCTL_NR(DRM_IOCTL_GET_UNIQUE32)] = compat_drm_getunique,
+	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAP32)] = compat_drm_getmap,
+	[DRM_IOCTL_NR(DRM_IOCTL_GET_CLIENT32)] = compat_drm_getclient,
+	[DRM_IOCTL_NR(DRM_IOCTL_GET_STATS32)] = compat_drm_getstats,
+	[DRM_IOCTL_NR(DRM_IOCTL_SET_UNIQUE32)] = compat_drm_setunique,
+	[DRM_IOCTL_NR(DRM_IOCTL_ADD_MAP32)] = compat_drm_addmap,
+	[DRM_IOCTL_NR(DRM_IOCTL_ADD_BUFS32)] = compat_drm_addbufs,
+	[DRM_IOCTL_NR(DRM_IOCTL_MARK_BUFS32)] = compat_drm_markbufs,
+	[DRM_IOCTL_NR(DRM_IOCTL_INFO_BUFS32)] = compat_drm_infobufs,
+	[DRM_IOCTL_NR(DRM_IOCTL_MAP_BUFS32)] = compat_drm_mapbufs,
+	[DRM_IOCTL_NR(DRM_IOCTL_FREE_BUFS32)] = compat_drm_freebufs,
+	[DRM_IOCTL_NR(DRM_IOCTL_RM_MAP32)] = compat_drm_rmmap,
+	[DRM_IOCTL_NR(DRM_IOCTL_SET_SAREA_CTX32)] = compat_drm_setsareactx,
+	[DRM_IOCTL_NR(DRM_IOCTL_GET_SAREA_CTX32)] = compat_drm_getsareactx,
+	[DRM_IOCTL_NR(DRM_IOCTL_RES_CTX32)] = compat_drm_resctx,
+	[DRM_IOCTL_NR(DRM_IOCTL_DMA32)] = compat_drm_dma,
 #if __OS_HAS_AGP
-	    (err = R(DRM_IOCTL_AGP_ACQUIRE, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_RELEASE, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_ENABLE32, compat_drm_agp_enable)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_INFO32, compat_drm_agp_info)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_ALLOC32, compat_drm_agp_alloc)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_FREE32, compat_drm_agp_free)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_BIND32, compat_drm_agp_bind)) != 0 ||
-	    (err = R(DRM_IOCTL_AGP_UNBIND32, compat_drm_agp_unbind)) != 0 ||
+	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ENABLE32)] = compat_drm_agp_enable,
+	[DRM_IOCTL_NR(DRM_IOCTL_AGP_INFO32)] = compat_drm_agp_info,
+	[DRM_IOCTL_NR(DRM_IOCTL_AGP_ALLOC32)] = compat_drm_agp_alloc,
+	[DRM_IOCTL_NR(DRM_IOCTL_AGP_FREE32)] = compat_drm_agp_free,
+	[DRM_IOCTL_NR(DRM_IOCTL_AGP_BIND32)] = compat_drm_agp_bind,
+	[DRM_IOCTL_NR(DRM_IOCTL_AGP_UNBIND32)] = compat_drm_agp_unbind,
 #endif
-	    (err = R(DRM_IOCTL_SG_ALLOC32, compat_drm_sg_alloc)) != 0 ||
-	    (err = R(DRM_IOCTL_SG_FREE32, compat_drm_sg_free)) != 0 ||
-	    (err = R(DRM_IOCTL_WAIT_VBLANK32, compat_drm_wait_vblank)) != 0) {
-		printk(KERN_ERR "DRM: couldn't register ioctl conversions"
-		       " (error %d)\n", err);
-		return err;
-	}
-	return 0;
-}
-#undef R
+	[DRM_IOCTL_NR(DRM_IOCTL_SG_ALLOC32)] = compat_drm_sg_alloc,
+	[DRM_IOCTL_NR(DRM_IOCTL_SG_FREE32)] = compat_drm_sg_free,
+	[DRM_IOCTL_NR(DRM_IOCTL_WAIT_VBLANK32)] = compat_drm_wait_vblank,
+};
 
-#define U	unregister_ioctl32_conversion
+/** 
+ * Called whenever a 32-bit process running under a 64-bit kernel
+ * performs an ioctl on /dev/drm.
+ *
+ * \param filp file pointer.
+ * \param cmd command.
+ * \param arg user argument.
+ * \return zero on success or negative number on failure.
+ */
+long drm_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	unsigned int nr = DRM_IOCTL_NR(cmd);
+	drm_ioctl_compat_t *fn;
+	int ret;
+
+	if (nr >= DRM_ARRAY_SIZE(drm_compat_ioctls))
+		return -ENOTTY;
+
+	fn = drm_compat_ioctls[nr];
+
+	lock_kernel();		/* XXX for now */
+	if (fn != NULL)
+		ret = (*fn)(filp, cmd, arg);
+	else
+		ret = drm_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+	unlock_kernel();
 
-void drm_unregister_ioc32(void)
-{
-	U(DRM_IOCTL_VERSION32);
-	U(DRM_IOCTL_GET_UNIQUE32);
-	U(DRM_IOCTL_GET_MAGIC);
-	U(DRM_IOCTL_IRQ_BUSID);
-	U(DRM_IOCTL_GET_MAP32);
-	U(DRM_IOCTL_GET_CLIENT32);
-	U(DRM_IOCTL_GET_STATS32);
-	U(DRM_IOCTL_SET_VERSION);
-	U(DRM_IOCTL_SET_UNIQUE32);
-	U(DRM_IOCTL_AUTH_MAGIC);
-	U(DRM_IOCTL_BLOCK);
-	U(DRM_IOCTL_UNBLOCK);
-	U(DRM_IOCTL_CONTROL);
-	U(DRM_IOCTL_ADD_MAP32);
-	U(DRM_IOCTL_ADD_BUFS32);
-	U(DRM_IOCTL_MARK_BUFS32);
-	U(DRM_IOCTL_INFO_BUFS32);
-	U(DRM_IOCTL_MAP_BUFS32);
-	U(DRM_IOCTL_FREE_BUFS32);
-	U(DRM_IOCTL_RM_MAP32);
-	U(DRM_IOCTL_SET_SAREA_CTX32);
-	U(DRM_IOCTL_GET_SAREA_CTX32);
-	U(DRM_IOCTL_ADD_CTX);
-	U(DRM_IOCTL_RM_CTX);
-	U(DRM_IOCTL_MOD_CTX);
-	U(DRM_IOCTL_GET_CTX);
-	U(DRM_IOCTL_SWITCH_CTX);
-	U(DRM_IOCTL_NEW_CTX);
-	U(DRM_IOCTL_RES_CTX32);
-	U(DRM_IOCTL_ADD_DRAW);
-	U(DRM_IOCTL_RM_DRAW);
-	U(DRM_IOCTL_DMA32);
-	U(DRM_IOCTL_LOCK);
-	U(DRM_IOCTL_UNLOCK);
-	U(DRM_IOCTL_FINISH);
-#if __OS_HAS_AGP
-	U(DRM_IOCTL_AGP_ACQUIRE);
-	U(DRM_IOCTL_AGP_RELEASE);
-	U(DRM_IOCTL_AGP_ENABLE32);
-	U(DRM_IOCTL_AGP_INFO32);
-	U(DRM_IOCTL_AGP_ALLOC32);
-	U(DRM_IOCTL_AGP_FREE32);
-	U(DRM_IOCTL_AGP_BIND32);
-	U(DRM_IOCTL_AGP_UNBIND32);
-#endif
-	U(DRM_IOCTL_SG_ALLOC32);
-	U(DRM_IOCTL_SG_FREE32);
-	U(DRM_IOCTL_WAIT_VBLANK32);
+	return ret;
 }
+EXPORT_SYMBOL(drm_compat_ioctl);
diff -urN 2.6.12-rc2-mm2/drivers/char/drm/radeon_drv.c g5-ppc64/drivers/char/drm/radeon_drv.c
--- 2.6.12-rc2-mm2/drivers/char/drm/radeon_drv.c	2005-04-08 18:21:54.000000000 +1000
+++ g5-ppc64/drivers/char/drm/radeon_drv.c	2005-04-09 22:49:39.000000000 +1000
@@ -101,6 +101,9 @@
 		.mmap = drm_mmap,
 		.poll = drm_poll,
 		.fasync = drm_fasync,
+#ifdef CONFIG_COMPAT
+		.compat_ioctl = radeon_compat_ioctl,
+#endif
 	},
 	.pci_driver = {
 		.name          = DRIVER_NAME,
@@ -110,9 +113,6 @@
 
 static int __init radeon_init(void)
 {
-#ifdef CONFIG_COMPAT
-	radeon_register_ioc32();
-#endif
 	driver.num_ioctls = radeon_max_ioctl;
 	return drm_init(&driver);
 }
@@ -120,9 +120,6 @@
 static void __exit radeon_exit(void)
 {
 	drm_exit(&driver);
-#ifdef CONFIG_COMPAT
-	radeon_unregister_ioc32();
-#endif
 }
 
 module_init(radeon_init);
diff -urN 2.6.12-rc2-mm2/drivers/char/drm/radeon_drv.h g5-ppc64/drivers/char/drm/radeon_drv.h
--- 2.6.12-rc2-mm2/drivers/char/drm/radeon_drv.h	2005-04-08 18:21:54.000000000 +1000
+++ g5-ppc64/drivers/char/drm/radeon_drv.h	2005-04-09 22:48:30.000000000 +1000
@@ -317,8 +317,8 @@
 extern int radeon_postinit( struct drm_device *dev, unsigned long flags );
 extern int radeon_postcleanup( struct drm_device *dev );
 
-extern int radeon_register_ioc32(void);
-extern void radeon_unregister_ioc32(void);
+extern long radeon_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg);
 
 /* Flags for stats.boxes
  */
diff -urN 2.6.12-rc2-mm2/drivers/char/drm/radeon_ioc32.c g5-ppc64/drivers/char/drm/radeon_ioc32.c
--- 2.6.12-rc2-mm2/drivers/char/drm/radeon_ioc32.c	2005-04-08 18:21:54.000000000 +1000
+++ g5-ppc64/drivers/char/drm/radeon_ioc32.c	2005-04-10 13:11:47.000000000 +1000
@@ -35,25 +35,6 @@
 #include "radeon_drm.h"
 #include "radeon_drv.h"
 
-#define DRM_IOCTL_RADEON_CP_INIT32  \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_RADEON_CP_INIT, drm_radeon_init32_t)
-#define DRM_IOCTL_RADEON_CLEAR32    \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_RADEON_CLEAR, drm_radeon_clear32_t)
-#define DRM_IOCTL_RADEON_STIPPLE32  \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_RADEON_STIPPLE, drm_radeon_stipple32_t)
-#define DRM_IOCTL_RADEON_TEXTURE32  \
-	DRM_IOWR(DRM_COMMAND_BASE + DRM_RADEON_TEXTURE, drm_radeon_texture32_t)
-#define DRM_IOCTL_RADEON_VERTEX2_32 \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_RADEON_VERTEX2, drm_radeon_vertex2_32_t)
-#define DRM_IOCTL_RADEON_CMDBUF32   \
-	DRM_IOW(DRM_COMMAND_BASE + DRM_RADEON_CMDBUF, drm_radeon_cmd_buffer32_t)
-#define DRM_IOCTL_RADEON_GETPARAM32 \
-	DRM_IOWR(DRM_COMMAND_BASE + DRM_RADEON_GETPARAM, drm_radeon_getparam32_t)
-#define DRM_IOCTL_RADEON_ALLOC32    \
-	DRM_IOWR(DRM_COMMAND_BASE + DRM_RADEON_ALLOC, drm_radeon_mem_alloc32_t)
-#define DRM_IOCTL_RADEON_IRQ_EMIT32 \
-	DRM_IOWR(DRM_COMMAND_BASE + DRM_RADEON_IRQ_EMIT, drm_radeon_irq_emit32_t)
-
 typedef struct drm_radeon_init32 {
 	int func;
 	u32 sarea_priv_offset;
@@ -77,45 +58,43 @@
 	u32 gart_textures_offset;
 } drm_radeon_init32_t;
 
-static int compat_radeon_cp_init(unsigned int fd, unsigned int cmd, 
-				 unsigned long arg, struct file *file)
+static int compat_radeon_cp_init(struct file *file, unsigned int cmd,
+				 unsigned long arg)
 {
 	drm_radeon_init32_t init32;
-	drm_radeon_init_t init;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_init_t __user *init;
 
 	if (copy_from_user(&init32, (void __user *)arg, sizeof(init32)))
 		return -EFAULT;
-	init.func = init32.func;
-	init.sarea_priv_offset = init32.sarea_priv_offset;
-	init.is_pci = init32.is_pci;
-	init.cp_mode = init32.cp_mode;
-	init.gart_size = init32.gart_size;
-	init.ring_size = init32.ring_size;
-	init.usec_timeout = init32.usec_timeout;
-	init.fb_bpp = init32.fb_bpp;
-	init.front_offset = init32.front_offset;
-	init.front_pitch = init32.front_pitch;
-	init.back_offset = init32.back_offset;
-	init.back_pitch = init32.back_pitch;
-	init.depth_bpp = init32.depth_bpp;
-	init.depth_offset = init32.depth_offset;
-	init.depth_pitch = init32.depth_pitch;
-	init.fb_offset = init32.fb_offset;
-	init.mmio_offset = init32.mmio_offset;
-	init.ring_offset = init32.ring_offset;
-	init.ring_rptr_offset = init32.ring_rptr_offset;
-	init.buffers_offset = init32.buffers_offset;
-	init.gart_textures_offset = init32.gart_textures_offset;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_CP_INIT, (unsigned long) &init);
-	set_fs(oldfs);
 
-	return err;
+	init = compat_alloc_user_space(sizeof(*init));
+	if (!access_ok(VERIFY_WRITE, init, sizeof(*init))
+	    || __put_user(init32.func, &init->func)
+	    || __put_user(init32.sarea_priv_offset, &init->sarea_priv_offset)
+	    || __put_user(init32.is_pci, &init->is_pci)
+	    || __put_user(init32.cp_mode, &init->cp_mode)
+	    || __put_user(init32.gart_size, &init->gart_size)
+	    || __put_user(init32.ring_size, &init->ring_size)
+	    || __put_user(init32.usec_timeout, &init->usec_timeout)
+	    || __put_user(init32.fb_bpp, &init->fb_bpp)
+	    || __put_user(init32.front_offset, &init->front_offset)
+	    || __put_user(init32.front_pitch, &init->front_pitch)
+	    || __put_user(init32.back_offset, &init->back_offset)
+	    || __put_user(init32.back_pitch, &init->back_pitch)
+	    || __put_user(init32.depth_bpp, &init->depth_bpp)
+	    || __put_user(init32.depth_offset, &init->depth_offset)
+	    || __put_user(init32.depth_pitch, &init->depth_pitch)
+	    || __put_user(init32.fb_offset, &init->fb_offset)
+	    || __put_user(init32.mmio_offset, &init->mmio_offset)
+	    || __put_user(init32.ring_offset, &init->ring_offset)
+	    || __put_user(init32.ring_rptr_offset, &init->ring_rptr_offset)
+	    || __put_user(init32.buffers_offset, &init->buffers_offset)
+	    || __put_user(init32.gart_textures_offset,
+			  &init->gart_textures_offset))
+		return -EFAULT;
+
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_CP_INIT, (unsigned long) init);
 }
 
 typedef struct drm_radeon_clear32 {
@@ -127,60 +106,52 @@
 	u32	     depth_boxes;
 } drm_radeon_clear32_t;
 
-static int compat_radeon_cp_clear(unsigned int fd, unsigned int cmd, 
-				  unsigned long arg, struct file *file)
+static int compat_radeon_cp_clear(struct file *file, unsigned int cmd,
+				  unsigned long arg)
 {
 	drm_radeon_clear32_t clr32;
-	drm_radeon_clear_t clr;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_clear_t __user *clr;
 
 	if (copy_from_user(&clr32, (void __user *)arg, sizeof(clr32)))
 		return -EFAULT;
-	clr.flags = clr32.flags;
-	clr.clear_color = clr32.clear_color;
-	clr.clear_depth = clr32.clear_depth;
-	clr.color_mask = clr32.color_mask;
-	clr.depth_mask = clr32.depth_mask;
-	clr.depth_boxes = (void __user *)(unsigned long)clr32.depth_boxes;
-	if (!access_ok(VERIFY_READ, clr.depth_boxes,
-		    RADEON_NR_SAREA_CLIPRECTS * sizeof(drm_radeon_clear_rect_t)))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_CLEAR, (unsigned long) &clr);
-	set_fs(oldfs);
 
-	return err;	
+	clr = compat_alloc_user_space(sizeof(*clr));
+	if (!access_ok(VERIFY_WRITE, clr, sizeof(*clr))
+	    || __put_user(clr32.flags, &clr->flags)
+	    || __put_user(clr32.clear_color, &clr->clear_color)
+	    || __put_user(clr32.clear_depth, &clr->clear_depth)
+	    || __put_user(clr32.color_mask, &clr->color_mask)
+	    || __put_user(clr32.depth_mask, &clr->depth_mask)
+	    || __put_user((void __user *)(unsigned long)clr32.depth_boxes,
+			  &clr->depth_boxes))
+		return -EFAULT;
+
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_CLEAR, (unsigned long) clr);
 }
 
 typedef struct drm_radeon_stipple32 {
-	unsigned int __user *mask;
+	u32 mask;
 } drm_radeon_stipple32_t;
 
-static int compat_radeon_cp_stipple(unsigned int fd, unsigned int cmd, 
-				    unsigned long arg, struct file *file)
+static int compat_radeon_cp_stipple(struct file *file, unsigned int cmd,
+				    unsigned long arg)
 {
-	drm_radeon_stipple32_t req32;
-	drm_radeon_stipple_t request;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_stipple32_t __user *argp = (void __user *) arg;
+	drm_radeon_stipple_t __user *request;
+	u32 mask;
 
-	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
-		return -EFAULT;
-	request.mask = (unsigned int __user *)(unsigned long) req32.mask;
-	if (!access_ok(VERIFY_READ, request.mask, 32 * sizeof(u32)))
+	if (get_user(mask, &argp->mask))
 		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_STIPPLE, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user((unsigned int __user *)(unsigned long) mask,
+			  &request->mask))
+		return -EFAULT;
 
-	return err;	
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_STIPPLE, (unsigned long) request);
 }
 
 typedef struct drm_radeon_tex_image32 {
@@ -198,15 +169,13 @@
 	u32 image;
 } drm_radeon_texture32_t;
 
-static int compat_radeon_cp_texture(unsigned int fd, unsigned int cmd, 
-				    unsigned long arg, struct file *file)
+static int compat_radeon_cp_texture(struct file *file, unsigned int cmd,
+				    unsigned long arg)
 {
 	drm_radeon_texture32_t req32;
-	drm_radeon_texture_t request;
+	drm_radeon_texture_t __user *request;
 	drm_radeon_tex_image32_t img32;
-	drm_radeon_tex_image_t image;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_tex_image_t __user *image;
 
 	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
 		return -EFAULT;
@@ -216,29 +185,28 @@
 			   sizeof(img32)))
 		return -EFAULT;
 
-	request.offset = req32.offset;
-	request.pitch = req32.pitch;
-	request.format = req32.format;
-	request.width = req32.width;
-	request.height = req32.height;
-	request.image = &image;
-
-	image.x = img32.x;
-	image.y = img32.y;
-	image.width = img32.width;
-	image.height = img32.height;
-	image.data = (const void __user *)(unsigned long)img32.data;
-	/* XXX check this */
-	if (!access_ok(VERIFY_READ, image.data, 4 * image.width * image.height))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_TEXTURE, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request) + sizeof(*image));
+	if (!access_ok(VERIFY_WRITE, request,
+		       sizeof(*request) + sizeof(*image)))
+		return -EFAULT;
+	image = (drm_radeon_tex_image_t __user *) (request + 1);
+
+	if (__put_user(req32.offset, &request->offset)
+	    || __put_user(req32.pitch, &request->pitch)
+	    || __put_user(req32.format, &request->format)
+	    || __put_user(req32.width, &request->width)
+	    || __put_user(req32.height, &request->height)
+	    || __put_user(image, &request->image)
+	    || __put_user(img32.x, &image->x)
+	    || __put_user(img32.y, &image->y)
+	    || __put_user(img32.width, &image->width)
+	    || __put_user(img32.height, &image->height)
+	    || __put_user((const void __user *)(unsigned long)img32.data,
+			  &image->data))
+		return -EFAULT;
 
-	return err;	
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_TEXTURE, (unsigned long) request);
 }
 
 typedef struct drm_radeon_vertex2_32 {
@@ -250,35 +218,29 @@
 	u32 prim;
 } drm_radeon_vertex2_32_t;
 
-static int compat_radeon_cp_vertex2(unsigned int fd, unsigned int cmd, 
-				    unsigned long arg, struct file *file)
+static int compat_radeon_cp_vertex2(struct file *file, unsigned int cmd,
+				    unsigned long arg)
 {
 	drm_radeon_vertex2_32_t req32;
-	drm_radeon_vertex2_t request;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_vertex2_t __user *request;
 
 	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
 		return -EFAULT;
-	request.idx = req32.idx;
-	request.discard = req32.discard;
-	request.nr_states = req32.nr_states;
-	request.state = (void __user *)(unsigned long)req32.state;
-	request.nr_prims = req32.nr_prims;
-	request.prim = (void __user *)(unsigned long)req32.prim;
-	if (!access_ok(VERIFY_READ, request.state,
-		       request.nr_states * sizeof(drm_radeon_state_t))
-	    || !access_ok(VERIFY_READ, request.prim,
-			  request.nr_prims * sizeof(drm_radeon_prim_t)))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_VERTEX2, (unsigned long) &request);
-	set_fs(oldfs);
 
-	return err;	
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.idx, &request->idx)
+	    || __put_user(req32.discard, &request->discard)
+	    || __put_user(req32.nr_states, &request->nr_states)
+	    || __put_user((void __user *)(unsigned long)req32.state,
+			  &request->state)
+	    || __put_user(req32.nr_prims, &request->nr_prims)
+	    || __put_user((void __user *)(unsigned long)req32.prim,
+			  &request->prim))
+		return -EFAULT;
+
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_VERTEX2, (unsigned long) request);
 }
 
 typedef struct drm_radeon_cmd_buffer32 {
@@ -288,32 +250,27 @@
 	u32 boxes;
 } drm_radeon_cmd_buffer32_t;
 
-static int compat_radeon_cp_cmdbuf(unsigned int fd, unsigned int cmd, 
-				   unsigned long arg, struct file *file)
+static int compat_radeon_cp_cmdbuf(struct file *file, unsigned int cmd,
+				   unsigned long arg)
 {
 	drm_radeon_cmd_buffer32_t req32;
-	drm_radeon_cmd_buffer_t request;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_cmd_buffer_t __user *request;
 
 	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
 		return -EFAULT;
-	request.bufsz = req32.bufsz;
-	request.buf = (void __user *)(unsigned long)req32.buf;
-	request.nbox = req32.nbox;
-	request.boxes = (void __user *)(unsigned long)req32.boxes;
-	if (!access_ok(VERIFY_READ, request.buf, request.bufsz)
-	    || !access_ok(VERIFY_READ, request.boxes,
-			  request.nbox * sizeof(drm_clip_rect_t)))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_CMDBUF, (unsigned long) &request);
-	set_fs(oldfs);
 
-	return err;	
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.bufsz, &request->bufsz)
+	    || __put_user((void __user *)(unsigned long)req32.buf,
+			  &request->buf)
+	    || __put_user(req32.nbox, &request->nbox)
+	    || __put_user((void __user *)(unsigned long)req32.boxes,
+			  &request->boxes))
+		return -EFAULT;
+
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_CMDBUF, (unsigned long) request);
 }
 
 typedef struct drm_radeon_getparam32 {
@@ -321,28 +278,24 @@
 	u32 value;
 } drm_radeon_getparam32_t;
 
-static int compat_radeon_cp_getparam(unsigned int fd, unsigned int cmd, 
-				     unsigned long arg, struct file *file)
+static int compat_radeon_cp_getparam(struct file *file, unsigned int cmd,
+				     unsigned long arg)
 {
 	drm_radeon_getparam32_t req32;
-	drm_radeon_getparam_t request;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_getparam_t __user *request;
 
 	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
 		return -EFAULT;
-	request.param = req32.param;
-	request.value = (void __user *)(unsigned long)req32.value;
-	if (!access_ok(VERIFY_WRITE, request.value, sizeof(int)))
-		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_GETPARAM, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.param, &request->param)
+	    || __put_user((void __user *)(unsigned long)req32.value,
+			  &request->value))
+		return -EFAULT;
 
-	return err;	
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_GETPARAM, (unsigned long) request);
 }
 
 typedef struct drm_radeon_mem_alloc32 {
@@ -352,130 +305,91 @@
 	u32 region_offset;	/* offset from start of fb or GART */
 } drm_radeon_mem_alloc32_t;
 
-static int compat_radeon_mem_alloc(unsigned int fd, unsigned int cmd, 
-				   unsigned long arg, struct file *file)
+static int compat_radeon_mem_alloc(struct file *file, unsigned int cmd,
+				   unsigned long arg)
 {
 	drm_radeon_mem_alloc32_t req32;
-	drm_radeon_mem_alloc_t request;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_mem_alloc_t __user *request;
 
 	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
 		return -EFAULT;
-	request.region = req32.region;
-	request.alignment = req32.alignment;
-	request.size = req32.size;
-	request.region_offset = (int __user *)(unsigned long)req32.region_offset;
-	if (!access_ok(VERIFY_WRITE, request.region_offset, sizeof(int)))
-		return -EFAULT;
 
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_ALLOC, (unsigned long) &request);
-	set_fs(oldfs);
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user(req32.region, &request->region)
+	    || __put_user(req32.alignment, &request->alignment)
+	    || __put_user(req32.size, &request->size)
+	    || __put_user((int __user *)(unsigned long)req32.region_offset,
+			  &request->region_offset))
+		return -EFAULT;
 
-	return err;	
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_ALLOC, (unsigned long) request);
 }
 
 typedef struct drm_radeon_irq_emit32 {
 	u32 irq_seq;
 } drm_radeon_irq_emit32_t;
 
-static int compat_radeon_irq_emit(unsigned int fd, unsigned int cmd, 
-				  unsigned long arg, struct file *file)
+static int compat_radeon_irq_emit(struct file *file, unsigned int cmd,
+				  unsigned long arg)
 {
 	drm_radeon_irq_emit32_t req32;
-	drm_radeon_irq_emit_t request;
-	int err;
-	mm_segment_t oldfs;
+	drm_radeon_irq_emit_t __user *request;
 
 	if (copy_from_user(&req32, (void __user *) arg, sizeof(req32)))
 		return -EFAULT;
-	request.irq_seq = (int __user *)(unsigned long)req32.irq_seq;
-	if (!access_ok(VERIFY_WRITE, request.irq_seq, sizeof(int)))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = drm_ioctl(file->f_dentry->d_inode, file,
-			DRM_IOCTL_RADEON_IRQ_EMIT, (unsigned long) &request);
-	set_fs(oldfs);
-
-	return err;	
-}
 
-#define R	register_ioctl32_conversion
+	request = compat_alloc_user_space(sizeof(*request));
+	if (!access_ok(VERIFY_WRITE, request, sizeof(*request))
+	    || __put_user((int __user *)(unsigned long)req32.irq_seq,
+			  &request->irq_seq))
+		return -EFAULT;
+
+	return drm_ioctl(file->f_dentry->d_inode, file,
+			 DRM_IOCTL_RADEON_IRQ_EMIT, (unsigned long) request);
+}
+
+drm_ioctl_compat_t *radeon_compat_ioctls[] = {
+	[DRM_RADEON_CP_INIT] = compat_radeon_cp_init,
+	[DRM_RADEON_CLEAR] = compat_radeon_cp_clear,
+	[DRM_RADEON_STIPPLE] = compat_radeon_cp_stipple,
+	[DRM_RADEON_TEXTURE] = compat_radeon_cp_texture,
+	[DRM_RADEON_VERTEX2] = compat_radeon_cp_vertex2,
+	[DRM_RADEON_CMDBUF] = compat_radeon_cp_cmdbuf,
+	[DRM_RADEON_GETPARAM] = compat_radeon_cp_getparam,
+	[DRM_RADEON_ALLOC] = compat_radeon_mem_alloc,
+	[DRM_RADEON_IRQ_EMIT] = compat_radeon_irq_emit,
+};
+
+/** 
+ * Called whenever a 32-bit process running under a 64-bit kernel
+ * performs an ioctl on /dev/dri/card<n>.
+ *
+ * \param filp file pointer.
+ * \param cmd command.
+ * \param arg user argument.
+ * \return zero on success or negative number on failure.
+ */
+long radeon_compat_ioctl(struct file *filp, unsigned int cmd,
+			 unsigned long arg)
+{
+	unsigned int nr = DRM_IOCTL_NR(cmd);
+	drm_ioctl_compat_t *fn = NULL;
+	int ret;
+
+	if (nr < DRM_COMMAND_BASE)
+		return drm_compat_ioctl(filp, cmd, arg);
+
+	if (nr < DRM_COMMAND_BASE + DRM_ARRAY_SIZE(radeon_compat_ioctls))
+		fn = radeon_compat_ioctls[nr - DRM_COMMAND_BASE];
+
+	lock_kernel();		/* XXX for now */
+	if (fn != NULL)
+		ret = (*fn)(filp, cmd, arg);
+	else
+		ret = drm_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+	unlock_kernel();
 
-int radeon_register_ioc32(void)
-{
-	int err;
-
-	if ((err = R(DRM_IOCTL_RADEON_CP_INIT32, compat_radeon_cp_init)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CP_START, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CP_STOP, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CP_RESET, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CP_IDLE, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_RESET, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_FULLSCREEN, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_SWAP, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CLEAR32, compat_radeon_cp_clear)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_VERTEX, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_INDICES, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_STIPPLE32, compat_radeon_cp_stipple)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_INDIRECT, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_TEXTURE32, compat_radeon_cp_texture)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_VERTEX2_32, compat_radeon_cp_vertex2)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CMDBUF32, compat_radeon_cp_cmdbuf)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_GETPARAM32, compat_radeon_cp_getparam)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_FLIP, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_ALLOC32, compat_radeon_mem_alloc)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_FREE, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_INIT_HEAP, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_IRQ_EMIT32, compat_radeon_irq_emit)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_IRQ_WAIT, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_CP_RESUME, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_SETPARAM, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_SURF_ALLOC, NULL)) != 0 ||
-	    (err = R(DRM_IOCTL_RADEON_SURF_FREE, NULL)) != 0) {
-		printk(KERN_ERR "radeon DRM: couldn't register ioctl conversions"
-		       " (error %d)\n", err);
-		return err;
-	}
-	return 0;
+	return ret;
 }
-#undef R
-
-#define U	unregister_ioctl32_conversion
-
-void radeon_unregister_ioc32(void)
-{
-	U(DRM_IOCTL_RADEON_CP_INIT32);
-	U(DRM_IOCTL_RADEON_CP_START);
-	U(DRM_IOCTL_RADEON_CP_STOP);
-	U(DRM_IOCTL_RADEON_CP_RESET);
-	U(DRM_IOCTL_RADEON_CP_IDLE);
-	U(DRM_IOCTL_RADEON_RESET);
-	U(DRM_IOCTL_RADEON_FULLSCREEN);
-	U(DRM_IOCTL_RADEON_SWAP);
-	U(DRM_IOCTL_RADEON_CLEAR32);
-	U(DRM_IOCTL_RADEON_VERTEX);
-	U(DRM_IOCTL_RADEON_INDICES);
-	U(DRM_IOCTL_RADEON_STIPPLE32);
-	U(DRM_IOCTL_RADEON_INDIRECT);
-	U(DRM_IOCTL_RADEON_TEXTURE32);
-	U(DRM_IOCTL_RADEON_VERTEX2_32);
-	U(DRM_IOCTL_RADEON_CMDBUF32);
-	U(DRM_IOCTL_RADEON_GETPARAM32);
-	U(DRM_IOCTL_RADEON_FLIP);
-	U(DRM_IOCTL_RADEON_ALLOC32);
-	U(DRM_IOCTL_RADEON_FREE);
-	U(DRM_IOCTL_RADEON_INIT_HEAP);
-	U(DRM_IOCTL_RADEON_IRQ_EMIT32);
-	U(DRM_IOCTL_RADEON_IRQ_WAIT);
-	U(DRM_IOCTL_RADEON_CP_RESUME);
-	U(DRM_IOCTL_RADEON_SETPARAM);
-	U(DRM_IOCTL_RADEON_SURF_ALLOC);
-	U(DRM_IOCTL_RADEON_SURF_FREE);
-}
-
