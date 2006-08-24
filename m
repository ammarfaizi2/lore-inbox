Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWHXLzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWHXLzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWHXLzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:55:07 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:674 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751174AbWHXLzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:55:04 -0400
Date: Thu, 24 Aug 2006 20:57:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: kamezawa.hiroyu@jp.fujitsu.com, Andrew Morton <akpm@osdl.org>,
       saito.tadashi@soft.fujitsu.com, ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 3 [1/4]  pointer to unstable
 object
Message-Id: <20060824205754.a316a719.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is take3. against 2.6.18-rc4 again.

ChangeLog take2 -> take3
- abandoned token in a list approach
- add (safe?) dual-direction pointer handler (should be confirmed...)
- no global lock except for read_lock_rcu()
- just added new member to task struct instead of modifing already used list
- proc_pid_readdir() doesn't use kmalloc(). 
- proc_root_open()/proc_root_release() uses kmalloc() and kfree()
- added llseek handler for proc_root, it returns -ENOTSUPP.
  /proc/root uses filep->f_pos as # of entries , not bytes now.

This ver. of proc_pid_readdir() uses struct watch_head in patch [1/4].
tested on i386/SMP sytem. fork()/kill()/ps tight loop works well for 2 hours.

To be honest, this approach looks complicated, it's maybe better to use
Eric's simple pidmap scannning. but implementing this was fun ;)

Good point of this ver. is
- no (additional) global lock
- readdir() doesn't call kmalloc/kfree
- of course, we can catch all exisiting processes.

-Kame
==
A dual-direction pointer for volatile object, which can be freed whenever
unlocked. better name is welcome...

How to use:

1. When creating new object(obj), which contains a member of struct watch_head
   as wh,  and it turns to be accessible,

   init_watch(&obj->wh);

2. If someone want to make a pointer to obj, it calls add_watcher() with
   its own watch_head.

   read_lock_hoo();
   add_watcher(&new_pointer, &obj->wh);
   read_unlock_hoo();

3-1. When obj becomes stale and above pointer should be invalidated.
   write_lock_hoo();
   move_watcher(&obj->wh, NULL);
   write_unlock_hoo();

3-2. When obj becomes stale and above pointer should be changed to point
   another object objX.
   write_lock_hoo();
   move_watcher(&obj->wh, &objX->wh);
   write_unlock_hoo();


4-1. When a user want to get and remove reference to object
   read_lock_hoo();
   return_obj = wh_get_remove_pointer(new_pointer, type, member);
   /* do some job */
   read_unlock_hoo();
   return_obj can be NULL if new_pointer is invalidated.

4-2 When a user want to get reference to object
   read_lock_hoo();
   return_obj = wh_get_pointer(new_pointer, type, member);
   /* do some job */
   read_unlock_hoo();
   return_obj can be NULL if new_pointer is invalidated.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



 include/linux/watch_head.h |  167 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 167 insertions(+)

Index: linux-2.6.18-rc4/include/linux/watch_head.h
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4/include/linux/watch_head.h
@@ -0,0 +1,167 @@
+#ifndef __LINUX_WATCH_HEAD_H__
+#define __LINUX_WATCH_HEAD_H__
+#ifdef __KERNEL__
+
+/*
+ * A kind of dual-direction pointer to refer volatile object which can be
+ * stale whenever unlocked.
+ * If the target object includes 'struct watch_head', a user can point
+ * it by his own watch_head. When target object is removed, pointer watch_head
+ * to target object is properly modified (guarded by spin lock).
+ *
+ * Freeing of the target object and add/remove watch pointer should be
+ * done under mutual execlusion if not RCU. When the target object uses RCU,
+ * add/remove watcher should be done under rcu_readlock.
+ */
+
+struct watch_head {
+	struct list_head list;
+	spinlock_t	 lock;       /* lock for list entry */
+	struct watch_head *target;   /* point to watch target. */
+};
+
+#define WATCH_HEAD_INIT(wl)	\
+	{LIST_HEAD_INIT((wl).list), SPIN_LOCK_UNLOCKED, &(wl)}
+
+/* for watched target ops. */
+#define is_target(wh)	((wh) == (wh)->target)
+#define make_watch_ready(wh)	((wh)->target = (wh))
+#define deny_watch(wh)	((wh)->target = NULL)
+
+/* for invalidating pointer */
+#define WATCH_TARGET_INVAL	((struct watch_head *) -1)
+#define invalidate_wh(wh)	((wh)->target = WATCH_TARGET_INVAL)
+#define is_wh_invalid(wh)	((wh)->target == WATCH_TARGET_INVAL)
+
+static inline void init_watch(struct watch_head *wh)
+{
+	spin_lock_init(&wh->lock);
+	INIT_LIST_HEAD(&wh->list);
+	wh->target = NULL;
+}
+
+/*
+ * move_watcher() -- used when freeing or make object stale. modifies watcher
+ *                   and move pointer to 'new' if specified
+ *                   This has to be called under writer-lock to this object.
+ *                   This function does deny_watch(old).
+ * @old ..... object being stale
+ * @new ..... move watcher to this object, if NULL, all pointers are
+ *	      invalidated.
+ *
+ * A user has to guarantee move_watchhead(a,b) is not called against (a,b) and
+ * (b,a) at the same time.
+ */
+static inline void
+move_watcher(struct watch_head *old, struct watch_head *new)
+{
+	struct watch_head *ent,*tmp;
+	BUG_ON(!is_target(old));
+	BUG_ON(!is_target(new));
+	spin_lock(&old->lock);
+	deny_watch(old);
+	if (!list_empty(&old->list)) {
+		if (new) {
+			spin_lock(&new->lock);
+			list_for_each_entry(ent, &old->list, list) {
+				ent->target = new;
+			}
+			list_splice(&old->list, &new->list);
+			spin_unlock(&new->lock);
+		} else {
+			list_for_each_entry_safe(ent, tmp, &old->list, list) {
+				list_del(&ent->list);
+				invalidate_wh(ent);
+			}
+		}
+	}
+	spin_unlock(&old->lock);
+	return;
+}
+
+/*
+ * add watch pointer to target object. must be called under read-lock.
+ */
+
+static inline
+int add_watcher(struct watch_head *new, struct watch_head *wh)
+{
+	new->target = NULL;
+	spin_lock(&wh->lock);
+	if (is_target(wh)) { /* check the target can be referred */
+		list_add(&new->list, &wh->list);
+		new->target = wh;
+	}
+	spin_unlock(&wh->lock);
+	return (new->target)? 1 : 0;
+}
+
+/*
+ * get pointer -- must be called under read lock.
+ * read lock will guarantee target object cannot be freed while this access.
+ */
+static inline struct watch_head *
+wh_get_pointer(struct watch_head *ent)
+{
+	struct watch_head *wh = NULL;
+	struct watch_head *tmp = NULL;
+retry:
+	smp_read_barrier_depends();
+	wh = ent->target;
+	if (wh && wh != WATCH_TARGET_INVAL) {
+		tmp = wh;
+		spin_lock(&tmp->lock);
+		if (!is_target(wh) || !(wh == ent->target))
+			wh = NULL;
+		spin_unlock(&tmp->lock);
+		if (!wh)
+			goto retry;
+	} else {
+		wh = NULL;
+	}
+	return wh;
+}
+
+/*
+ * get and remove pointer
+ * returns NULL if poiter target is lost. must be called under read lock.
+ * read_lock will guarantee taget object is now freed while this access.
+ */
+static inline struct watch_head *
+wh_get_and_remove_watcher(struct watch_head *ent)
+{
+	struct watch_head *wh = NULL;
+	struct watch_head *tmp = NULL;
+retry:
+	smp_read_barrier_depends();
+	wh = ent->target;
+	if (wh && wh != WATCH_TARGET_INVAL) {
+		tmp = wh;
+		spin_lock(&tmp->lock);
+		/* modification to ent->target is done under wh->lock */
+		if (is_target(wh) && (wh == ent->target)) {
+			list_del(&ent->list);
+			ent->target = NULL;
+		} else
+			wh = NULL;
+		spin_unlock(&tmp->lock);
+		if (!wh) /* watch head is moved, check again */
+			goto retry;
+	} else {
+		wh = NULL;
+	}
+	return wh;
+}
+#define wh_get_pointer(wh, type, memmer) ({\
+	struct watch_head *__ret;\
+	__ret = wh_get_watcher(wh);\
+	((__ret)? container_of(__ret, type, member) : NULL);})
+
+#define wh_get_remove_pointer(wh, type, member) ({\
+	struct watch_head *__ret;\
+	__ret = wh_get_and_remove_watcher(wh);\
+	((__ret)? container_of(__ret, type, member) : NULL);})
+
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_WATCH_HEAD_H__ */


