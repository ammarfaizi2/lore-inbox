Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268161AbUHYSEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268161AbUHYSEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268170AbUHYSEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:04:33 -0400
Received: from holomorphy.com ([207.189.100.168]:21134 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268161AbUHYSDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:03:46 -0400
Date: Wed, 25 Aug 2004 11:03:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [2/2] move user-related stuff to linux/user.h
Message-ID: <20040825180342.GB2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825180138.GA2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 11:01:38AM -0700, William Lee Irwin III wrote:
> I hereby declare open season on linux/sched.h!
> In preparation for moving all user-related bits out of sched.h and
> coopting linux/user.h for this purpose, this patch converts all
> inclusions of linux/user.h to asm/user.h
> The #error in linux/user.h is blown away by the successor to this
> patch, which fills it in with user-related bits split off from sched.h.
> vs. 2.6.8.1-mm4

This patch moves all user bits from linux/sched.h to linux/user.h and
sweeps all files fiddling with users.


Index: mm4-2.6.8.1/include/linux/init_task.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/init_task.h	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/include/linux/init_task.h	2004-08-25 10:04:12.546839624 -0700
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
+#include <linux/user.h>
 #include <asm/resource.h>
 
 #define INIT_FILES \
Index: mm4-2.6.8.1/include/linux/key.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/key.h	2004-08-23 16:11:14.000000000 -0700
+++ mm4-2.6.8.1/include/linux/key.h	2004-08-25 10:04:48.598358960 -0700
@@ -59,6 +59,7 @@
 struct key_owner;
 struct keyring_list;
 struct keyring_name;
+struct user_struct;
 
 /*****************************************************************************/
 /*
Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-25 09:54:27.149833496 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-25 10:02:20.833822584 -0700
@@ -334,32 +334,7 @@
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
 
-/*
- * Some day this will be a full-fledged user tracking system..
- */
-struct user_struct {
-	atomic_t __count;	/* reference count */
-	atomic_t processes;	/* How many processes does this user have? */
-	atomic_t files;		/* How many open files does this user have? */
-	atomic_t sigpending;	/* How many pending signals does this user have? */
-	/* protected by mq_lock	*/
-	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
-	unsigned long locked_shm; /* How many pages of mlocked shm ? */
-
-#ifdef CONFIG_KEYS
-	struct key *uid_keyring;	/* UID specific keyring */
-	struct key *session_keyring;	/* UID's default session keyring */
-#endif
-
-	/* Hash table maintenance information */
-	struct list_head uidhash_list;
-	uid_t uid;
-};
-
-extern struct user_struct *find_user(uid_t);
-
-extern struct user_struct root_user;
-#define INIT_USER (&root_user)
+struct user_struct;
 
 typedef struct prio_array prio_array_t;
 struct backing_dev_info;
@@ -698,16 +673,6 @@
 extern void set_special_pids(pid_t session, pid_t pgrp);
 extern void __set_special_pids(pid_t session, pid_t pgrp);
 
-/* per-UID process charging. */
-extern struct user_struct * alloc_uid(uid_t);
-static inline struct user_struct *get_uid(struct user_struct *u)
-{
-	atomic_inc(&u->__count);
-	return u;
-}
-extern void free_uid(struct user_struct *);
-extern void switch_uid(struct user_struct *);
-
 #include <asm/current.h>
 
 extern unsigned long itimer_ticks;
Index: mm4-2.6.8.1/include/linux/user.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/user.h	2004-08-25 09:54:39.896895648 -0700
+++ mm4-2.6.8.1/include/linux/user.h	2004-08-25 10:07:11.597619768 -0700
@@ -1 +1,41 @@
-#error do not include this header
+#ifndef _LINUX_USER_H
+#define _LINUX_USER_H
+
+/*
+ * Some day this will be a full-fledged user tracking system..
+ */
+struct user_struct {
+	atomic_t __count;	/* reference count */
+	atomic_t processes;	/* How many processes does this user have? */
+	atomic_t files;		/* How many open files does this user have? */
+	atomic_t sigpending;	/* How many pending signals does this user have? */
+	/* protected by mq_lock	*/
+	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
+	unsigned long locked_shm; /* How many pages of mlocked shm ? */
+
+#ifdef CONFIG_KEYS
+	struct key *uid_keyring;	/* UID specific keyring */
+	struct key *session_keyring;	/* UID's default session keyring */
+#endif
+
+	/* Hash table maintenance information */
+	struct list_head uidhash_list;
+	uid_t uid;
+};
+
+#define INIT_USER (&root_user)
+extern struct user_struct root_user;
+
+/* per-UID process charging. */
+struct user_struct *find_user(uid_t);
+struct user_struct *alloc_uid(uid_t);
+void free_uid(struct user_struct *);
+void switch_uid(struct user_struct *);
+
+static inline struct user_struct *get_uid(struct user_struct *u)
+{
+	atomic_inc(&u->__count);
+	return u;
+}
+
+#endif /* _LINUX_USER_H */
Index: mm4-2.6.8.1/ipc/mqueue.c
===================================================================
--- mm4-2.6.8.1.orig/ipc/mqueue.c	2004-08-23 16:11:12.000000000 -0700
+++ mm4-2.6.8.1/ipc/mqueue.c	2004-08-25 10:05:14.862366224 -0700
@@ -22,6 +22,7 @@
 #include <linux/msg.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/user.h>
 #include <net/sock.h>
 #include "util.h"
 
Index: mm4-2.6.8.1/kernel/exit.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/exit.c	2004-08-23 16:11:20.000000000 -0700
+++ mm4-2.6.8.1/kernel/exit.c	2004-08-25 10:05:25.034819776 -0700
@@ -27,6 +27,7 @@
 #include <linux/cpuset.h>
 #include <linux/perfctr.h>
 #include <linux/cpu.h>
+#include <linux/user.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
Index: mm4-2.6.8.1/kernel/fork.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/fork.c	2004-08-25 09:54:39.834905072 -0700
+++ mm4-2.6.8.1/kernel/fork.c	2004-08-25 10:05:34.743343856 -0700
@@ -41,6 +41,7 @@
 #include <linux/profile.h>
 #include <linux/rmap.h>
 #include <linux/hash.h>
+#include <linux/user.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
Index: mm4-2.6.8.1/kernel/signal.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/signal.c	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/kernel/signal.c	2004-08-25 10:05:46.339580960 -0700
@@ -21,6 +21,7 @@
 #include <linux/binfmts.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
+#include <linux/user.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
Index: mm4-2.6.8.1/kernel/sys.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/sys.c	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/kernel/sys.c	2004-08-25 10:05:56.775994384 -0700
@@ -26,6 +26,7 @@
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
 #include <linux/key.h>
+#include <linux/user.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
Index: mm4-2.6.8.1/kernel/user.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/user.c	2004-08-23 16:11:14.000000000 -0700
+++ mm4-2.6.8.1/kernel/user.c	2004-08-25 10:08:24.277570736 -0700
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/key.h>
+#include <linux/user.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
Index: mm4-2.6.8.1/mm/mlock.c
===================================================================
--- mm4-2.6.8.1.orig/mm/mlock.c	2004-08-23 16:11:13.000000000 -0700
+++ mm4-2.6.8.1/mm/mlock.c	2004-08-25 10:06:06.915452952 -0700
@@ -7,7 +7,7 @@
 
 #include <linux/mman.h>
 #include <linux/mm.h>
-
+#include <linux/user.h>
 
 static int mlock_fixup(struct vm_area_struct * vma, 
 	unsigned long start, unsigned long end, unsigned int newflags)
Index: mm4-2.6.8.1/security/keys/key.c
===================================================================
--- mm4-2.6.8.1.orig/security/keys/key.c	2004-08-23 16:11:14.000000000 -0700
+++ mm4-2.6.8.1/security/keys/key.c	2004-08-25 10:06:18.519688840 -0700
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
+#include <linux/user.h>
 #include "internal.h"
 
 static kmem_cache_t	*key_jar;
Index: mm4-2.6.8.1/security/keys/process_keys.c
===================================================================
--- mm4-2.6.8.1.orig/security/keys/process_keys.c	2004-08-23 16:11:14.000000000 -0700
+++ mm4-2.6.8.1/security/keys/process_keys.c	2004-08-25 10:06:30.147921080 -0700
@@ -16,6 +16,7 @@
 #include <linux/prctl.h>
 #include <linux/fs.h>
 #include <linux/err.h>
+#include <linux/user.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
