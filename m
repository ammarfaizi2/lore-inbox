Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUHYWuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUHYWuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 18:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUHYWsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 18:48:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:37275 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266465AbUHYWhD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 18:37:03 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
In-Reply-To: <1093473388797@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 25 Aug 2004 15:36:28 -0700
Message-Id: <10934733881261@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1803.64.8, 2004/08/25 12:30:41-07:00, greg@kroah.com

kobject: convert struct kobject use kref.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>



 include/linux/kobject.h |    3 ++-
 lib/Makefile            |    5 +----
 lib/kobject.c           |   19 ++++++++++---------
 3 files changed, 13 insertions(+), 14 deletions(-)


diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	2004-08-25 14:54:37 -07:00
+++ b/include/linux/kobject.h	2004-08-25 14:54:37 -07:00
@@ -19,6 +19,7 @@
 #include <linux/list.h>
 #include <linux/sysfs.h>
 #include <linux/rwsem.h>
+#include <linux/kref.h>
 #include <asm/atomic.h>
 
 #define KOBJ_NAME_LEN	20
@@ -26,7 +27,7 @@
 struct kobject {
 	char			* k_name;
 	char			name[KOBJ_NAME_LEN];
-	atomic_t		refcount;
+	struct kref		kref;
 	struct list_head	entry;
 	struct kobject		* parent;
 	struct kset		* kset;
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	2004-08-25 14:54:37 -07:00
+++ b/lib/Makefile	2004-08-25 14:54:37 -07:00
@@ -5,11 +5,8 @@
 
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
-	 kobject.o idr.o div64.o parser.o int_sqrt.o \
+	 kobject.o kref.o idr.o div64.o parser.o int_sqrt.o \
 	 bitmap.o extable.o
-
-# hack for now till some static code uses krefs, then it can move up above...
-obj-y += kref.o
 
 lib-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	2004-08-25 14:54:37 -07:00
+++ b/lib/kobject.c	2004-08-25 14:54:37 -07:00
@@ -243,10 +243,9 @@
  *	kobject_init - initialize object.
  *	@kobj:	object in question.
  */
-
 void kobject_init(struct kobject * kobj)
 {
-	atomic_set(&kobj->refcount,1);
+ 	kref_init(&kobj->kref);
 	INIT_LIST_HEAD(&kobj->entry);
 	kobj->kset = kset_get(kobj->kset);
 }
@@ -447,10 +446,8 @@
 
 struct kobject * kobject_get(struct kobject * kobj)
 {
-	if (kobj) {
-		WARN_ON(!atomic_read(&kobj->refcount));
-		atomic_inc(&kobj->refcount);
-	}
+	if (kobj)
+		kref_get(&kobj->kref);
 	return kobj;
 }
 
@@ -477,17 +474,21 @@
 		kobject_put(parent);
 }
 
+static void kobject_release(struct kref *kref)
+{
+	kobject_cleanup(container_of(kref, struct kobject, kref));
+}
+
 /**
  *	kobject_put - decrement refcount for object.
  *	@kobj:	object.
  *
  *	Decrement the refcount, and if 0, call kobject_cleanup().
  */
-
 void kobject_put(struct kobject * kobj)
 {
-	if (atomic_dec_and_test(&kobj->refcount))
-		kobject_cleanup(kobj);
+	if (kobj)
+		kref_put(&kobj->kref, kobject_release);
 }
 
 

