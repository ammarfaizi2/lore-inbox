Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266645AbUBFWQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266936AbUBFWQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:16:39 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:4591 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S266645AbUBFWQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:16:09 -0500
Date: Fri, 6 Feb 2004 14:15:45 -0800
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org, viro@math.psu.edu
Subject: PATCH - raise max_anon limit
Message-ID: <20040206221545.GD9155@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a patch to raise the limit of anonymous block devices.  The
sysctl allows the admin to set the order of pages allocated for the unnamed
bitmap from 1 page to the full MINORBITS limit.

what think?

Tim

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="max_anon_sysctl-2.6.2-4.diff"

===== fs/namespace.c 1.52 vs edited =====
--- 1.52/fs/namespace.c	Tue Feb  3 21:37:02 2004
+++ edited/fs/namespace.c	Thu Feb  5 17:20:55 2004
@@ -25,6 +25,7 @@
 
 extern int __init init_rootfs(void);
 extern int __init sysfs_init(void);
+extern void __init max_anon_init(void);
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
@@ -1171,6 +1172,7 @@
 		d++;
 		i--;
 	} while (i);
+	max_anon_init();
 	sysfs_init();
 	init_rootfs();
 	init_mount_tree();
===== fs/super.c 1.110 vs edited =====
--- 1.110/fs/super.c	Sun Oct  5 01:07:55 2003
+++ edited/fs/super.c	Fri Feb  6 12:56:58 2004
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
 #include <linux/acct.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
@@ -34,6 +35,7 @@
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 
 void get_filesystem(struct file_system_type *fs);
@@ -535,16 +537,101 @@
  * filesystems which don't use real block-devices.  -- jrs
  */
 
-enum {Max_anon = 256};
-static unsigned long unnamed_dev_in_use[Max_anon/(8*sizeof(unsigned long))];
+int max_anon_order; /* = 0 */
+static int max_anon;
+static unsigned long *unnamed_dev_in_use;
 static spinlock_t unnamed_dev_lock = SPIN_LOCK_UNLOCKED;/* protects the above */
 
+static int set_max_anon_order(int old_order, int new_order)
+{
+	unsigned long *new_map;
+	unsigned long *old_map;
+	int new_bytes;
+	int old_bytes;
+
+	/*
+	 * you can only raise the order, or we have to handle the case of
+	 * having used bits that will not exist after lowering the order
+	 */
+	if (new_order < old_order) {
+		/* the sysctl proc_handler has already stored the value */
+		max_anon_order = old_order;
+		return -EINVAL;
+	}
+
+	/*
+	 * writing too high a value clamps to the highest value
+	 * max order is : 2^MINORBITS / 8 (bits per byte) / 2^PAGE_SHIFT
+	 */
+	if (new_order > (MINORBITS - PAGE_SHIFT - 3))
+		new_order = MINORBITS - PAGE_SHIFT - 3;
+
+	if (new_order == old_order)
+		return 0;
+
+	new_map = (unsigned long *)__get_free_pages(GFP_KERNEL, new_order);
+	if (!new_map) {
+		printk(KERN_ERR "Could not allocate new anonymous device map");
+		max_anon_order = old_order;
+		return -ENOMEM;
+	}
+	new_bytes = (1U << new_order) * PAGE_SIZE;
+
+	old_bytes = (1U << old_order) * PAGE_SIZE;
+
+	/* zero and copy old bit array, save the state */
+	memset(new_map, 0, new_bytes);
+	spin_lock(&unnamed_dev_lock);
+	old_map = unnamed_dev_in_use;
+	memcpy(new_map, old_map, old_bytes);
+	unnamed_dev_in_use = new_map;
+	max_anon = new_bytes * 8;
+	spin_unlock(&unnamed_dev_lock);
+	free_pages((unsigned long)old_map, old_order);
+	max_anon_order = new_order;
+
+	return 0;
+}
+
+int max_anon_sysctl_handler(ctl_table *table, int write, struct file *filp,
+    void __user *buffer, size_t *lenp)
+{
+	int ret;
+	int old_order;
+	static DECLARE_MUTEX(max_anon_sem);
+
+	down(&max_anon_sem);
+	old_order = max_anon_order;
+	ret = proc_dointvec(table, write, filp, buffer, lenp);
+	if (ret)
+		goto out;
+	if (write)
+		ret = set_max_anon_order(old_order, max_anon_order);
+out:
+	up(&max_anon_sem);
+	return ret;
+}
+
+void __init max_anon_init(void)
+{
+	int new_bytes;
+
+	unnamed_dev_in_use = (unsigned long *)__get_free_pages(GFP_ATOMIC,
+	    max_anon_order);
+	if (!unnamed_dev_in_use) {
+		panic("Could not initialize anonymous device map");
+	}
+	new_bytes = (1U << max_anon_order) * PAGE_SIZE;
+	memset(unnamed_dev_in_use, 0, new_bytes);
+	max_anon = new_bytes * 8;
+}
+
 int set_anon_super(struct super_block *s, void *data)
 {
 	int dev;
 	spin_lock(&unnamed_dev_lock);
-	dev = find_first_zero_bit(unnamed_dev_in_use, Max_anon);
-	if (dev == Max_anon) {
+	dev = find_first_zero_bit(unnamed_dev_in_use, max_anon);
+	if (dev == max_anon) {
 		spin_unlock(&unnamed_dev_lock);
 		return -EMFILE;
 	}
===== include/linux/fs.h 1.283 vs edited =====
--- 1.283/include/linux/fs.h	Mon Jan 19 15:38:10 2004
+++ edited/include/linux/fs.h	Thu Feb  5 17:20:55 2004
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/sysctl.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -1045,6 +1046,8 @@
 			void *data);
 struct super_block *get_sb_pseudo(struct file_system_type *, char *,
 			struct super_operations *ops, unsigned long);
+int max_anon_sysctl_handler(ctl_table *table, int write, struct file *filp,
+			void __user *buffer, size_t *lenp);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
===== include/linux/sysctl.h 1.59 vs edited =====
--- 1.59/include/linux/sysctl.h	Sun Feb  1 11:17:41 2004
+++ edited/include/linux/sysctl.h	Thu Feb  5 17:20:55 2004
@@ -615,6 +615,7 @@
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
 	FS_DQSTATS=16,	/* disc quota usage statistics */
 	FS_XFS=17,	/* struct: control xfs parameters */
+	FS_MAX_ANON_ORDER=18, /* int: max anonymous blockdevs oreder */
 };
 
 /* /proc/sys/fs/quota/ */
===== kernel/sysctl.c 1.59 vs edited =====
--- 1.59/kernel/sysctl.c	Tue Feb  3 21:30:55 2004
+++ edited/kernel/sysctl.c	Thu Feb  5 17:20:55 2004
@@ -38,6 +38,7 @@
 #include <linux/security.h>
 #include <linux/initrd.h>
 #include <linux/times.h>
+#include <linux/fs.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_ROOT_NFS
@@ -63,6 +64,7 @@
 extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
+extern int max_anon_order;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -813,6 +815,14 @@
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_MAX_ANON_ORDER,
+		.procname	= "max-anon-order",
+		.data		= &max_anon_order,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &max_anon_sysctl_handler,
 	},
 	{ .ctl_name = 0 }
 };
===== Documentation/sysctl/fs.txt 1.2 vs edited =====
--- 1.2/Documentation/sysctl/fs.txt	Mon Dec 30 04:29:09 2002
+++ edited/Documentation/sysctl/fs.txt	Thu Feb  5 17:31:17 2004
@@ -23,6 +23,7 @@
 - inode-max
 - inode-nr
 - inode-state
+- max-anon-order
 - overflowuid
 - overflowgid
 - super-max
@@ -116,6 +117,19 @@
 preshrink is nonzero when the nr_inodes > inode-max and the
 system needs to prune the inode list instead of allocating
 more.
+
+==============================================================
+
+max-anon-order
+
+Unnamed block devices are dummy devices used by virtual filesystems which
+don't use real block-devices, such as NFS.  The maximum number of unnamed
+block devices is controlled by this sysctl value.  The value represents a
+power-of-two page size.  For example, setting the default order, 0, results
+in 2^0 = 1 page being allocated for the anonymous device bitmap.  Setting
+the order to 2 results in 2^2 = 4 pages being allocated for the bitmap.
+Once increased, this value can not be decreased.  There is a limit of
+2^MINORBITS bits available at maximum.
 
 ==============================================================
 

--NhBACjNc9vV+/oop--
