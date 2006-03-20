Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbWCTWCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbWCTWCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWCTWBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:61369 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030543AbWCTWBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:17 -0500
Cc: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/23] kobj_map semaphore to mutex conversion
In-Reply-To: <11428920383213-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920383325-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the kobj_map code to use a mutex instead of a semaphore.  It
converts the single two users as well, genhd.c and char_dev.c.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 block/genhd.c            |   31 ++++++++++++++++---------------
 drivers/base/map.c       |   21 +++++++++++----------
 fs/char_dev.c            |   17 +++++++++--------
 include/linux/kobj_map.h |    4 ++--
 4 files changed, 38 insertions(+), 35 deletions(-)

58383af629efb07e5a0694e445eda0c65b16e1de
diff --git a/block/genhd.c b/block/genhd.c
index db57546..64510fd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -15,12 +15,13 @@
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
 #include <linux/buffer_head.h>
+#include <linux/mutex.h>
 
 #define MAX_PROBE_HASH 255	/* random */
 
 static struct subsystem block_subsys;
 
-static DECLARE_MUTEX(block_subsys_sem);
+static DEFINE_MUTEX(block_subsys_lock);
 
 /*
  * Can be deleted altogether. Later.
@@ -46,7 +47,7 @@ struct blkdev_info {
 /*
  * iterate over a list of blkdev_info structures.  allows
  * the major_names array to be iterated over from outside this file
- * must be called with the block_subsys_sem held
+ * must be called with the block_subsys_lock held
  */
 void *get_next_blkdev(void *dev)
 {
@@ -85,20 +86,20 @@ out:
 
 void *acquire_blkdev_list(void)
 {
-        down(&block_subsys_sem);
+        mutex_lock(&block_subsys_lock);
         return get_next_blkdev(NULL);
 }
 
 void release_blkdev_list(void *dev)
 {
-        up(&block_subsys_sem);
+        mutex_unlock(&block_subsys_lock);
         kfree(dev);
 }
 
 
 /*
  * Count the number of records in the blkdev_list.
- * must be called with the block_subsys_sem held
+ * must be called with the block_subsys_lock held
  */
 int count_blkdev_list(void)
 {
@@ -118,7 +119,7 @@ int count_blkdev_list(void)
 /*
  * extract the major and name values from a blkdev_info struct
  * passed in as a void to *dev.  Must be called with
- * block_subsys_sem held
+ * block_subsys_lock held
  */
 int get_blkdev_info(void *dev, int *major, char **name)
 {
@@ -138,7 +139,7 @@ int register_blkdev(unsigned int major, 
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
 
-	down(&block_subsys_sem);
+	mutex_lock(&block_subsys_lock);
 
 	/* temporary */
 	if (major == 0) {
@@ -183,7 +184,7 @@ int register_blkdev(unsigned int major, 
 		kfree(p);
 	}
 out:
-	up(&block_subsys_sem);
+	mutex_unlock(&block_subsys_lock);
 	return ret;
 }
 
@@ -197,7 +198,7 @@ int unregister_blkdev(unsigned int major
 	int index = major_to_index(major);
 	int ret = 0;
 
-	down(&block_subsys_sem);
+	mutex_lock(&block_subsys_lock);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
@@ -207,7 +208,7 @@ int unregister_blkdev(unsigned int major
 		p = *n;
 		*n = p->next;
 	}
-	up(&block_subsys_sem);
+	mutex_unlock(&block_subsys_lock);
 	kfree(p);
 
 	return ret;
@@ -301,7 +302,7 @@ static void *part_start(struct seq_file 
 	struct list_head *p;
 	loff_t l = *pos;
 
-	down(&block_subsys_sem);
+	mutex_lock(&block_subsys_lock);
 	list_for_each(p, &block_subsys.kset.list)
 		if (!l--)
 			return list_entry(p, struct gendisk, kobj.entry);
@@ -318,7 +319,7 @@ static void *part_next(struct seq_file *
 
 static void part_stop(struct seq_file *part, void *v)
 {
-	up(&block_subsys_sem);
+	mutex_unlock(&block_subsys_lock);
 }
 
 static int show_partition(struct seq_file *part, void *v)
@@ -377,7 +378,7 @@ static struct kobject *base_probe(dev_t 
 
 static int __init genhd_device_init(void)
 {
-	bdev_map = kobj_map_init(base_probe, &block_subsys_sem);
+	bdev_map = kobj_map_init(base_probe, &block_subsys_lock);
 	blk_dev_init();
 	subsystem_register(&block_subsys);
 	return 0;
@@ -611,7 +612,7 @@ static void *diskstats_start(struct seq_
 	loff_t k = *pos;
 	struct list_head *p;
 
-	down(&block_subsys_sem);
+	mutex_lock(&block_subsys_lock);
 	list_for_each(p, &block_subsys.kset.list)
 		if (!k--)
 			return list_entry(p, struct gendisk, kobj.entry);
@@ -628,7 +629,7 @@ static void *diskstats_next(struct seq_f
 
 static void diskstats_stop(struct seq_file *part, void *v)
 {
-	up(&block_subsys_sem);
+	mutex_unlock(&block_subsys_lock);
 }
 
 static int diskstats_show(struct seq_file *s, void *v)
diff --git a/drivers/base/map.c b/drivers/base/map.c
index b449dae..e87017f 100644
--- a/drivers/base/map.c
+++ b/drivers/base/map.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/mutex.h>
 #include <linux/kdev_t.h>
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
@@ -25,7 +26,7 @@ struct kobj_map {
 		int (*lock)(dev_t, void *);
 		void *data;
 	} *probes[255];
-	struct semaphore *sem;
+	struct mutex *lock;
 };
 
 int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
@@ -53,7 +54,7 @@ int kobj_map(struct kobj_map *domain, de
 		p->range = range;
 		p->data = data;
 	}
-	down(domain->sem);
+	mutex_lock(domain->lock);
 	for (i = 0, p -= n; i < n; i++, p++, index++) {
 		struct probe **s = &domain->probes[index % 255];
 		while (*s && (*s)->range < range)
@@ -61,7 +62,7 @@ int kobj_map(struct kobj_map *domain, de
 		p->next = *s;
 		*s = p;
 	}
-	up(domain->sem);
+	mutex_unlock(domain->lock);
 	return 0;
 }
 
@@ -75,7 +76,7 @@ void kobj_unmap(struct kobj_map *domain,
 	if (n > 255)
 		n = 255;
 
-	down(domain->sem);
+	mutex_lock(domain->lock);
 	for (i = 0; i < n; i++, index++) {
 		struct probe **s;
 		for (s = &domain->probes[index % 255]; *s; s = &(*s)->next) {
@@ -88,7 +89,7 @@ void kobj_unmap(struct kobj_map *domain,
 			}
 		}
 	}
-	up(domain->sem);
+	mutex_unlock(domain->lock);
 	kfree(found);
 }
 
@@ -99,7 +100,7 @@ struct kobject *kobj_lookup(struct kobj_
 	unsigned long best = ~0UL;
 
 retry:
-	down(domain->sem);
+	mutex_lock(domain->lock);
 	for (p = domain->probes[MAJOR(dev) % 255]; p; p = p->next) {
 		struct kobject *(*probe)(dev_t, int *, void *);
 		struct module *owner;
@@ -120,7 +121,7 @@ retry:
 			module_put(owner);
 			continue;
 		}
-		up(domain->sem);
+		mutex_unlock(domain->lock);
 		kobj = probe(dev, index, data);
 		/* Currently ->owner protects _only_ ->probe() itself. */
 		module_put(owner);
@@ -128,11 +129,11 @@ retry:
 			return kobj;
 		goto retry;
 	}
-	up(domain->sem);
+	mutex_unlock(domain->lock);
 	return NULL;
 }
 
-struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct semaphore *sem)
+struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct mutex *lock)
 {
 	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
 	struct probe *base = kzalloc(sizeof(*base), GFP_KERNEL);
@@ -149,6 +150,6 @@ struct kobj_map *kobj_map_init(kobj_prob
 	base->get = base_probe;
 	for (i = 0; i < 255; i++)
 		p->probes[i] = base;
-	p->sem = sem;
+	p->lock = lock;
 	return p;
 }
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 21195c4..5c36345 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -19,6 +19,7 @@
 #include <linux/kobject.h>
 #include <linux/kobj_map.h>
 #include <linux/cdev.h>
+#include <linux/mutex.h>
 
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
@@ -28,7 +29,7 @@ static struct kobj_map *cdev_map;
 
 #define MAX_PROBE_HASH 255	/* random */
 
-static DECLARE_MUTEX(chrdevs_lock);
+static DEFINE_MUTEX(chrdevs_lock);
 
 static struct char_device_struct {
 	struct char_device_struct *next;
@@ -88,13 +89,13 @@ out:
 
 void *acquire_chrdev_list(void)
 {
-	down(&chrdevs_lock);
+	mutex_lock(&chrdevs_lock);
 	return get_next_chrdev(NULL);
 }
 
 void release_chrdev_list(void *dev)
 {
-	up(&chrdevs_lock);
+	mutex_unlock(&chrdevs_lock);
 	kfree(dev);
 }
 
@@ -151,7 +152,7 @@ __register_chrdev_region(unsigned int ma
 
 	memset(cd, 0, sizeof(struct char_device_struct));
 
-	down(&chrdevs_lock);
+	mutex_lock(&chrdevs_lock);
 
 	/* temporary */
 	if (major == 0) {
@@ -186,10 +187,10 @@ __register_chrdev_region(unsigned int ma
 	}
 	cd->next = *cp;
 	*cp = cd;
-	up(&chrdevs_lock);
+	mutex_unlock(&chrdevs_lock);
 	return cd;
 out:
-	up(&chrdevs_lock);
+	mutex_unlock(&chrdevs_lock);
 	kfree(cd);
 	return ERR_PTR(ret);
 }
@@ -200,7 +201,7 @@ __unregister_chrdev_region(unsigned majo
 	struct char_device_struct *cd = NULL, **cp;
 	int i = major_to_index(major);
 
-	down(&chrdevs_lock);
+	mutex_lock(&chrdevs_lock);
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major == major &&
 		    (*cp)->baseminor == baseminor &&
@@ -210,7 +211,7 @@ __unregister_chrdev_region(unsigned majo
 		cd = *cp;
 		*cp = cd->next;
 	}
-	up(&chrdevs_lock);
+	mutex_unlock(&chrdevs_lock);
 	return cd;
 }
 
diff --git a/include/linux/kobj_map.h b/include/linux/kobj_map.h
index cbe7d80..bafe178 100644
--- a/include/linux/kobj_map.h
+++ b/include/linux/kobj_map.h
@@ -1,6 +1,6 @@
 #ifdef __KERNEL__
 
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 typedef struct kobject *kobj_probe_t(dev_t, int *, void *);
 struct kobj_map;
@@ -9,6 +9,6 @@ int kobj_map(struct kobj_map *, dev_t, u
 	     kobj_probe_t *, int (*)(dev_t, void *), void *);
 void kobj_unmap(struct kobj_map *, dev_t, unsigned long);
 struct kobject *kobj_lookup(struct kobj_map *, dev_t, int *);
-struct kobj_map *kobj_map_init(kobj_probe_t *, struct semaphore *);
+struct kobj_map *kobj_map_init(kobj_probe_t *, struct mutex *);
 
 #endif
-- 
1.2.4


