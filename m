Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVCJAzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVCJAzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVCJAvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:51:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:59039 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262632AbVCJAme convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:34 -0500
Cc: gregkh@suse.de
Subject: [PATCH] kmap: remove usage of rwsem from kobj_map.
In-Reply-To: <1110414886692@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:46 -0800
Message-Id: <11104148863225@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2052, 2005/03/09 15:06:02-08:00, gregkh@suse.de

[PATCH] kmap: remove usage of rwsem from kobj_map.

This forces the caller to provide the lock, but as they all already had one, it's not a big change.
It also removes the now-unneeded cdev_subsys.  Thanks to Jon Corbet for reminding me about that.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/map.c       |   21 ++++++++++-----------
 drivers/block/genhd.c    |    2 +-
 fs/char_dev.c            |   26 +++++++++-----------------
 include/linux/kobj_map.h |    2 +-
 4 files changed, 21 insertions(+), 30 deletions(-)


diff -Nru a/drivers/base/map.c b/drivers/base/map.c
--- a/drivers/base/map.c	2005-03-09 16:28:24 -08:00
+++ b/drivers/base/map.c	2005-03-09 16:28:24 -08:00
@@ -25,7 +25,7 @@
 		int (*lock)(dev_t, void *);
 		void *data;
 	} *probes[255];
-	struct rw_semaphore *sem;
+	struct semaphore *sem;
 };
 
 int kobj_map(struct kobj_map *domain, dev_t dev, unsigned long range,
@@ -53,7 +53,7 @@
 		p->range = range;
 		p->data = data;
 	}
-	down_write(domain->sem);
+	down(domain->sem);
 	for (i = 0, p -= n; i < n; i++, p++, index++) {
 		struct probe **s = &domain->probes[index % 255];
 		while (*s && (*s)->range < range)
@@ -61,7 +61,7 @@
 		p->next = *s;
 		*s = p;
 	}
-	up_write(domain->sem);
+	up(domain->sem);
 	return 0;
 }
 
@@ -75,7 +75,7 @@
 	if (n > 255)
 		n = 255;
 
-	down_write(domain->sem);
+	down(domain->sem);
 	for (i = 0; i < n; i++, index++) {
 		struct probe **s;
 		for (s = &domain->probes[index % 255]; *s; s = &(*s)->next) {
@@ -88,7 +88,7 @@
 			}
 		}
 	}
-	up_write(domain->sem);
+	up(domain->sem);
 	kfree(found);
 }
 
@@ -99,7 +99,7 @@
 	unsigned long best = ~0UL;
 
 retry:
-	down_read(domain->sem);
+	down(domain->sem);
 	for (p = domain->probes[MAJOR(dev) % 255]; p; p = p->next) {
 		struct kobject *(*probe)(dev_t, int *, void *);
 		struct module *owner;
@@ -120,7 +120,7 @@
 			module_put(owner);
 			continue;
 		}
-		up_read(domain->sem);
+		up(domain->sem);
 		kobj = probe(dev, index, data);
 		/* Currently ->owner protects _only_ ->probe() itself. */
 		module_put(owner);
@@ -128,12 +128,11 @@
 			return kobj;
 		goto retry;
 	}
-	up_read(domain->sem);
+	up(domain->sem);
 	return NULL;
 }
 
-struct kobj_map *kobj_map_init(kobj_probe_t *base_probe,
-		struct subsystem *s)
+struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct semaphore *sem)
 {
 	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
 	struct probe *base = kmalloc(sizeof(struct probe), GFP_KERNEL);
@@ -151,6 +150,6 @@
 	base->get = base_probe;
 	for (i = 0; i < 255; i++)
 		p->probes[i] = base;
-	p->sem = &s->rwsem;
+	p->sem = sem;
 	return p;
 }
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2005-03-09 16:28:24 -08:00
+++ b/drivers/block/genhd.c	2005-03-09 16:28:24 -08:00
@@ -302,7 +302,7 @@
 
 static int __init genhd_device_init(void)
 {
-	bdev_map = kobj_map_init(base_probe, &block_subsys);
+	bdev_map = kobj_map_init(base_probe, &block_subsys_sem);
 	blk_dev_init();
 	subsystem_register(&block_subsys);
 	return 0;
diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	2005-03-09 16:28:24 -08:00
+++ b/fs/char_dev.c	2005-03-09 16:28:24 -08:00
@@ -29,7 +29,7 @@
 /* degrade to linked list for small systems */
 #define MAX_PROBE_HASH (CONFIG_BASE_SMALL ? 1 : 255)
 
-static DEFINE_RWLOCK(chrdevs_lock);
+static DECLARE_MUTEX(chrdevs_lock);
 
 static struct char_device_struct {
 	struct char_device_struct *next;
@@ -55,13 +55,13 @@
 
 	len = sprintf(page, "Character devices:\n");
 
-	read_lock(&chrdevs_lock);
+	down(&chrdevs_lock);
 	for (i = 0; i < ARRAY_SIZE(chrdevs) ; i++) {
 		for (cd = chrdevs[i]; cd; cd = cd->next)
 			len += sprintf(page+len, "%3d %s\n",
 				       cd->major, cd->name);
 	}
-	read_unlock(&chrdevs_lock);
+	up(&chrdevs_lock);
 
 	return len;
 }
@@ -91,7 +91,7 @@
 
 	memset(cd, 0, sizeof(struct char_device_struct));
 
-	write_lock_irq(&chrdevs_lock);
+	down(&chrdevs_lock);
 
 	/* temporary */
 	if (major == 0) {
@@ -126,10 +126,10 @@
 	}
 	cd->next = *cp;
 	*cp = cd;
-	write_unlock_irq(&chrdevs_lock);
+	up(&chrdevs_lock);
 	return cd;
 out:
-	write_unlock_irq(&chrdevs_lock);
+	up(&chrdevs_lock);
 	kfree(cd);
 	return ERR_PTR(ret);
 }
@@ -140,7 +140,7 @@
 	struct char_device_struct *cd = NULL, **cp;
 	int i = major_to_index(major);
 
-	write_lock_irq(&chrdevs_lock);
+	up(&chrdevs_lock);
 	for (cp = &chrdevs[i]; *cp; cp = &(*cp)->next)
 		if ((*cp)->major == major &&
 		    (*cp)->baseminor == baseminor &&
@@ -150,7 +150,7 @@
 		cd = *cp;
 		*cp = cd->next;
 	}
-	write_unlock_irq(&chrdevs_lock);
+	up(&chrdevs_lock);
 	return cd;
 }
 
@@ -381,8 +381,6 @@
 }
 
 
-static decl_subsys(cdev, NULL, NULL);
-
 static void cdev_default_release(struct kobject *kobj)
 {
 	struct cdev *p = container_of(kobj, struct cdev, kobj);
@@ -435,13 +433,7 @@
 
 void __init chrdev_init(void)
 {
-/*
- * Keep cdev_subsys around because (and only because) the kobj_map code
- * depends on the rwsem it contains.  We don't make it public in sysfs,
- * however.
- */
-	subsystem_init(&cdev_subsys);
-	cdev_map = kobj_map_init(base_probe, &cdev_subsys);
+	cdev_map = kobj_map_init(base_probe, &chrdevs_lock);
 }
 
 
diff -Nru a/include/linux/kobj_map.h b/include/linux/kobj_map.h
--- a/include/linux/kobj_map.h	2005-03-09 16:28:24 -08:00
+++ b/include/linux/kobj_map.h	2005-03-09 16:28:24 -08:00
@@ -7,6 +7,6 @@
 	     kobj_probe_t *, int (*)(dev_t, void *), void *);
 void kobj_unmap(struct kobj_map *, dev_t, unsigned long);
 struct kobject *kobj_lookup(struct kobj_map *, dev_t, int *);
-struct kobj_map *kobj_map_init(kobj_probe_t *, struct subsystem *);
+struct kobj_map *kobj_map_init(kobj_probe_t *, struct semaphore *);
 
 #endif

