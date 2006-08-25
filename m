Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWHYJWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWHYJWL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHYJWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:22:11 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:36482 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932366AbWHYJWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:22:09 -0400
Date: Fri, 25 Aug 2006 18:25:05 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>, saito.tadashi@soft.fujitsu.com,
       ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 4 [1/4] callback subroutine
Message-Id: <20060825182505.5e9ddc8f.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated some dirty codes. maybe easier to read than previous one.

This ps command fix (proc_pid_readdir() fix) fixes the problem by

- attach a callback for updating pointer from file descriptor to a task invoked
  at release_task()
- no additional global lock is required.
- walk through all and only task structs which is thread group leader.

*Bad* point is adding additonal (small) lock and callback in exit path.

ChangeLog take3 -> take4
- renamed struct of a pointer from file descriptor to task
- added callback function feature (to task)
- removed complicated move_watcher().
- added invalidate op

ChangeLog take2 -> take3
- abandoned token in a list approach
- add (safe?) dual-direction pointer handler (should be confirmed...)
- no global lock except for read_lock_rcu()
- just added new member to task struct instead of modifing already used list
- proc_pid_readdir() doesn't use kmalloc(). 
- proc_root_open()/proc_root_release() uses kmalloc() and kfree()
- added llseek handler for proc_root, it returns -ENOTSUPP.
  /proc/root uses filep->f_pos as # of entries , not bytes now.


-Kame
==
A dual-direction pointer for volatile object, which can be freed whenever
unlocked. better name is welcome ;)
A user can register its own callback function which is called when object
is being stale.

invalidate_pointer() should be called under appropriate lock, typically
write_lock() to target object.

With RCU object, add_pointer() and get_pointer() functions should be called
under rcu_read_lock().


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



 include/linux/adaptive_pointer.h |  167 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 167 insertions(+)

Index: linux-2.6.18-rc4/include/linux/adaptive_pointer.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4/include/linux/adaptive_pointer.h
@@ -0,0 +1,167 @@
+#ifndef __LINUX_ADAPTIVE_POINTER_H__
+#define __LINUX_ADAPTIVE_POINTER_H__
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+/*
+ * A kind of dual-direction pointer to refer volatile object. which can be
+ * stale whenever unlocked. When the object being stale, callback function
+ * is invoked.
+ *
+ * Freeing of the target object and add/remove callback pointer should be
+ * done under mutual execlusion if not RCU. When the target object uses RCU,
+ * add/remove pointer should be done under rcu_readlock.
+ */
+
+/*
+ * callback function is called under (referred obj's adaptive pointer)->lock.
+ * Then, callback function be careful to avoid dead-lock.
+ * if no callback, pointer is invalidated.
+ * callback's first arg is an owner of callback. 2nd is target of pointer.
+ */
+struct adaptive_pointer {
+	struct list_head list;
+	spinlock_t	 lock;       /* lock for all ops */
+	struct adaptive_pointer *target;   /* pointer to target. */
+	void (*callback)(struct adaptive_pointer *, struct adaptive_pointer *);
+};
+
+#define ADAPTIVE_POINTER_INIT(ap)	\
+	{LIST_HEAD_INIT((ap).list), SPIN_LOCK_UNLOCKED, &(ap), NULL}
+
+/* for referred target objs. */
+#define is_ap_alive(ap)	((ap) == (ap)->target)
+#define ap_alive(ap)	((ap)->target = (ap)) /* obj can be accessed */
+#define ap_dead(ap)	((ap)->target = NULL) /* obj cannot be accessed */
+
+/* for referring pointer */
+#define ADAPTIVE_POINTER_INVAL	((struct adaptive_pointer *) -1)
+#define invalidate_ap(ap)	((ap)->target = ADAPTIVE_POINTER_INVAL)
+#define is_ap_invalid(ap)	((ap)->target == ADAPTIVE_POINTER_INVAL)
+
+static inline void init_adaptive_pointer(struct adaptive_pointer *ap)
+{
+	spin_lock_init(&ap->lock);
+	INIT_LIST_HEAD(&ap->list);
+	ap->target = NULL;
+	ap->callback = NULL;
+}
+
+/*
+ * call_invalidate_ap() -- used at making object stale.
+ *           	      	    calls all registered callbacks.
+ *                         if no callback, pointer is just invalidated.
+ * @obj ..... object being stale
+ */
+static inline void call_invalidate_ap(struct adaptive_pointer *obj)
+{
+	BUG_ON(!is_ap_alive(obj));
+	spin_lock(&obj->lock);
+	/* make this pointer target dead */
+	ap_dead(obj);
+	wmb();
+	if (!list_empty(&obj->list)) {
+		struct adaptive_pointer *ent,*tmp;
+		list_for_each_entry_safe(ent, tmp, &obj->list, list) {
+			list_del(&ent->list);
+			invalidate_ap(ent);
+			if (ent->callback)
+				(*ent->callback)(ent, obj);
+		}
+	}
+	spin_unlock(&obj->lock);
+	return;
+}
+
+/*
+ * add pointer to target object. must be called under read-lock.
+ * returns obj if succeeded.
+ */
+
+static inline struct adaptive_pointer *
+ap_attach(struct adaptive_pointer *new, struct adaptive_pointer*obj)
+{
+	struct adaptive_pointer *ret = NULL;
+	invalidate_ap(new);
+	spin_lock(&obj->lock);
+	if (is_ap_alive(obj)) { /* check the target can be referred */
+		list_add(&new->list, &obj->list);
+		new->target = obj;
+		ret = obj;
+	}
+	spin_unlock(&obj->lock);
+	return ret;
+}
+
+/*
+ * get pointer -- must be called under read lock.
+ * returns NULL if poiter target is lost. must be called under read lock.
+ * read lock will guarantee target object cannot be freed while this access.
+ */
+static inline struct adaptive_pointer *
+__ap_get_pointer(struct adaptive_pointer *ent)
+{
+	struct adaptive_pointer *obj = NULL;
+	struct adaptive_pointer *tmp = NULL;
+retry:
+	smp_read_barrier_depends();
+	obj = ent->target;
+	if (obj && !is_ap_invalid(ent)) {
+		tmp = obj;
+		spin_lock(&tmp->lock);
+		if (!is_ap_alive(obj) || !(obj != ent->target))
+			obj = NULL;
+		spin_unlock(&tmp->lock);
+		if (!obj)
+			goto retry;
+	} else {
+		obj = NULL;
+	}
+	return obj;
+}
+
+/*
+ * get and remove pointer
+ * returns NULL if poiter target is lost. must be called under read lock.
+ * read_lock will guarantee taget object is now freed while this access.
+ */
+static inline struct adaptive_pointer *
+__ap_get_remove_pointer(struct adaptive_pointer *ent)
+{
+	struct adaptive_pointer *obj = NULL;
+	struct adaptive_pointer *tmp = NULL;
+retry:
+	smp_read_barrier_depends();
+	obj = ent->target;
+	if (obj && !is_ap_invalid(ent)) {
+		tmp = obj;
+		spin_lock(&tmp->lock);
+		/* modification to ent->target is done under wh->lock */
+		if (is_ap_alive(obj) && (obj == ent->target)) {
+			list_del(&ent->list);
+			invalidate_ap(ent);
+		} else
+			obj = NULL;
+		spin_unlock(&tmp->lock);
+		if (!obj) /* pointer is old, check again */
+			goto retry;
+	} else {
+		obj = NULL;
+	}
+	return obj;
+}
+
+#define ap_get_pointer(ap, type, memmer) ({\
+	struct adaptive_pointer *__ret;\
+	__ret = __ap_get_pointerr(ap);\
+	((__ret)? container_of(__ret, type, member) : NULL);})
+
+#define ap_get_remove_pointer(ap, type, member) ({\
+	struct adaptive_pointer *__ret;\
+	__ret = __ap_get_remove_pointer(ap);\
+	((__ret)? container_of(__ret, type, member) : NULL);})
+
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_ADAPTIVE_POINTER_H__ */

