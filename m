Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTJFI7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTJFI7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 04:59:53 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:7164 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262790AbTJFI7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 04:59:43 -0400
Date: Mon, 6 Oct 2003 14:30:03 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 1/6] sysfs-kobject.patch
Message-ID: <20031006090003.GF4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006085915.GE4220@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch adds new fields to struct kobject for providing 
  parent-child-sibling  based hierarchy. Using these links we can traverse 
  the hierarchy in both directions. All these fields are intialised in 
  kobject_init and modified accordingly in kobject_add and kobject_del.

o The new fields attr, and attr_groups link the attributes and attribute
  groups to the kobject. These are linked using the new structures 
  kobject_attr and kobject_attr_group as we cannot link the struct attribute
  directly to the kobject because these are generally embedded in other 
  struct and are referenced with offsets.

o All the lists are protected by the read-write semaphore k_rwsem.

o All the subsystems are linked in the kobj_subsystem_list which is protected
  using spinlock kobj_subsystem_lock.


 include/linux/kobject.h |   33 ++++++++++++++++++++++++++++++
 lib/kobject.c           |   52 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 1 deletion(-)

diff -puN include/linux/kobject.h~sysfs-kobject include/linux/kobject.h
--- linux-2.6.0-test6/include/linux/kobject.h~sysfs-kobject	2003-10-06 11:48:37.000000000 +0530
+++ linux-2.6.0-test6-maneesh/include/linux/kobject.h	2003-10-06 11:48:51.000000000 +0530
@@ -32,6 +32,12 @@ struct kobject {
 	struct kset		* kset;
 	struct kobj_type	* ktype;
 	struct dentry		* dentry;
+ 	struct list_head	k_sibling;
+ 	struct list_head	k_children;
+	struct list_head	attr;
+	struct list_head	attr_group;
+	struct rw_semaphore	k_rwsem;
+	char 			*k_symlink;
 };
 
 extern int kobject_set_name(struct kobject *, const char *, ...)
@@ -57,6 +63,29 @@ extern struct kobject * kobject_get(stru
 extern void kobject_put(struct kobject *);
 
 
+struct kobject_attr {
+	struct list_head 	list;
+	int 			flags;
+	union {
+		const struct attribute	* attr;
+		const struct bin_attribute * bin_attr;
+	} attr_u;
+};
+
+#define KOBJ_TEXT_ATTR		0x0001
+#define KOBJ_BINARY_ATTR	0x0002
+
+static inline const struct attribute * 
+kobject_attr(struct kobject_attr * k_attr) 
+{
+	return ((k_attr->flags & KOBJ_TEXT_ATTR) ? k_attr->attr_u.attr : &k_attr->attr_u.bin_attr->attr);
+}
+
+struct kobject_attr_group {
+	struct list_head 	list;
+	const struct attribute_group	* attr_group;
+};
+
 struct kobj_type {
 	void (*release)(struct kobject *);
 	struct sysfs_ops	* sysfs_ops;
@@ -140,8 +169,12 @@ extern struct kobject * kset_find_obj(st
 struct subsystem {
 	struct kset		kset;
 	struct rw_semaphore	rwsem;
+	struct list_head	next;
 };
 
+extern spinlock_t kobj_subsystem_lock;
+extern struct list_head kobj_subsystem_list;
+
 #define decl_subsys(_name,_type,_hotplug_ops) \
 struct subsystem _name##_subsys = { \
 	.kset = { \
diff -puN lib/kobject.c~sysfs-kobject lib/kobject.c
--- linux-2.6.0-test6/lib/kobject.c~sysfs-kobject	2003-10-06 11:48:44.000000000 +0530
+++ linux-2.6.0-test6-maneesh/lib/kobject.c	2003-10-06 11:51:51.000000000 +0530
@@ -17,6 +17,9 @@
 #include <linux/module.h>
 #include <linux/stat.h>
 
+spinlock_t kobj_subsystem_lock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(kobj_subsystem_list);
+
 /**
  *	populate_dir - populate directory with attributes.
  *	@kobj:	object we're working on.
@@ -216,6 +219,12 @@ void kobject_init(struct kobject * kobj)
 	atomic_set(&kobj->refcount,1);
 	INIT_LIST_HEAD(&kobj->entry);
 	kobj->kset = kset_get(kobj->kset);
+	kobj->dentry = NULL;
+	init_rwsem(&kobj->k_rwsem);
+ 	INIT_LIST_HEAD(&kobj->k_children);
+	INIT_LIST_HEAD(&kobj->attr);
+	INIT_LIST_HEAD(&kobj->attr_group);
+	kobj->k_symlink = NULL;
 }
 
 
@@ -236,8 +245,12 @@ static void unlink(struct kobject * kobj
 		list_del_init(&kobj->entry);
 		up_write(&kobj->kset->subsys->rwsem);
 	}
-	if (kobj->parent) 
+	if (kobj->parent) {
+		down_write(&kobj->parent->k_rwsem);
+		list_del_init(&kobj->k_sibling);
+		up_write(&kobj->parent->k_rwsem);
 		kobject_put(kobj->parent);
+	}
 	kobject_put(kobj);
 }
 
@@ -273,6 +286,15 @@ int kobject_add(struct kobject * kobj)
 	}
 	kobj->parent = parent;
 
+	if (kobj->parent) {
+		down_write(&parent->k_rwsem);
+		list_add(&kobj->k_sibling, &kobj->parent->k_children);
+		up_write(&parent->k_rwsem);
+	}
+	else {
+		INIT_LIST_HEAD(&kobj->k_sibling);
+	}
+
 	error = create_dir(kobj);
 	if (error)
 		unlink(kobj);
@@ -443,11 +465,32 @@ void kobject_cleanup(struct kobject * ko
 {
 	struct kobj_type * t = get_ktype(kobj);
 	struct kset * s = kobj->kset;
+	struct list_head * tmp = kobj->attr.next;
 
 	pr_debug("kobject %s: cleaning up\n",kobject_name(kobj));
+
+	down_write(&kobj->k_rwsem);
 	if (kobj->k_name != kobj->name)
 		kfree(kobj->k_name);
 	kobj->k_name = NULL;
+ 
+	while (tmp != &kobj->attr) {
+		struct kobject_attr * k_attr;
+		k_attr = list_entry(tmp, struct kobject_attr, list);
+		tmp = tmp->next;
+		list_del(&k_attr->list);
+		kfree(k_attr);
+	}
+	tmp = kobj->attr_group.next;
+	while (tmp != &kobj->attr_group) {
+		struct kobject_attr_group * k_attr_group;
+		k_attr_group = list_entry(tmp, struct kobject_attr_group, list);
+		tmp = tmp->next;
+		list_del(&k_attr_group->list);
+		kfree(k_attr_group);
+	}
+	up_write(&kobj->k_rwsem);
+
 	if (t && t->release)
 		t->release(kobj);
 	if (s)
@@ -557,6 +600,7 @@ void subsystem_init(struct subsystem * s
 {
 	init_rwsem(&s->rwsem);
 	kset_init(&s->kset);
+	INIT_LIST_HEAD(&s->next);
 }
 
 /**
@@ -578,6 +622,9 @@ int subsystem_register(struct subsystem 
 	if (!(error = kset_add(&s->kset))) {
 		if (!s->kset.subsys)
 			s->kset.subsys = s;
+		spin_lock(&kobj_subsystem_lock);
+		list_add(&s->next, &kobj_subsystem_list);
+		spin_unlock(&kobj_subsystem_lock);
 	}
 	return error;
 }
@@ -585,6 +632,9 @@ int subsystem_register(struct subsystem 
 void subsystem_unregister(struct subsystem * s)
 {
 	pr_debug("subsystem %s: unregistering\n",s->kset.kobj.name);
+	spin_lock(&kobj_subsystem_lock);
+	list_del_init(&s->next);
+	spin_unlock(&kobj_subsystem_lock);
 	kset_unregister(&s->kset);
 }
 

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
