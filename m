Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbSLRWIg>; Wed, 18 Dec 2002 17:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267366AbSLRWHg>; Wed, 18 Dec 2002 17:07:36 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267370AbSLRWG1>;
	Wed, 18 Dec 2002 17:06:27 -0500
Subject: [PATCH] (4/5) improved notifier callback mechanism - read copy
	update
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 14:14:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The notifier interface was only partially locked. The
notifier_call_chain needs to be called in places where it is impossible
to safely without having deadlocks; for example, NMI watchdog timeout.

This patch uses read-copy-update to manage the list.  One extra bit of
safety is using a reference count on the notifier_blocks to allow for
cases like oprofile which need to sleep in a callback.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.983   -> 1.984  
#	include/linux/notifier.h	1.7     -> 1.8    
#	        kernel/sys.c	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/18	shemminger@osdl.org	1.984
# 04-notifier-rcu.patch
# --------------------------------------------
#
diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Wed Dec 18 10:00:43 2002
+++ b/include/linux/notifier.h	Wed Dec 18 10:00:43 2002
@@ -11,14 +11,15 @@
 #define _LINUX_NOTIFIER_H
 
 #include <linux/list.h>
+#include <asm/atomic.h>
 
 struct notifier_block {
 	int (*notifier_call)(struct notifier_block *, unsigned long, void *);
-	int priority;
+	int 		priority;
 
+	atomic_t 	inuse;
 	struct list_head link;
-};
-
+} ____cacheline_aligned;
 
 #ifdef __KERNEL__
 
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Dec 18 10:00:43 2002
+++ b/kernel/sys.c	Wed Dec 18 10:00:43 2002
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/dcookies.h>
 #include <linux/suspend.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -78,7 +79,7 @@
  */
 
 static LIST_HEAD(reboot_notifier_list);
-static rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
+static spinlock_t notifier_lock = SPIN_LOCK_UNLOCKED;
 
 /**
  *	notifier_chain_register	- Add notifier to a notifier chain
@@ -95,7 +96,9 @@
 	struct list_head *p;
 
 	INIT_LIST_HEAD(&n->link);
-	write_lock(&notifier_lock);
+	atomic_set(&n->inuse, 0);
+
+	spin_lock(&notifier_lock);
 	list_for_each(p, list) {
 		struct notifier_block *e 
 			= list_entry(p, struct notifier_block, link);
@@ -104,7 +107,7 @@
 	}
 
 	list_add(&n->link, p);
-	write_unlock(&notifier_lock);
+	spin_unlock(&notifier_lock);
 	return 0;
 }
 
@@ -122,15 +125,24 @@
 {
 	struct list_head *cur;
 
-	write_lock(&notifier_lock);
+	might_sleep();
+
+	spin_lock(&notifier_lock);
 	list_for_each(cur, list) {
 		if (n == list_entry(cur, struct notifier_block, link)) {
-			list_del(cur);
-			write_unlock(&notifier_lock);
+			list_del_rcu(cur);
+			spin_unlock(&notifier_lock);
+			
+			synchronize_kernel();
+
+			/* notifier may be sleeping */
+			while (atomic_read(&n->inuse) > 0)
+				yield();
+
 			return 0;
 		}
 	}
-	write_unlock(&notifier_lock);
+	spin_unlock(&notifier_lock);
 	return -ENOENT;
 }
 
@@ -148,23 +160,31 @@
  *	the notifier function which halted execution.
  *	Otherwise, the return value is the return value
  *	of the last notifier function called.
+ *
+ *	This might be called from NMI or other context where it
+ *	is impossible to sleep or spin.
  */
  
 int notifier_call_chain(struct list_head *list, unsigned long val, void
*v)
 {
-	struct list_head *p;
+	struct list_head *p, *nxtp;
 	int ret = NOTIFY_DONE;
 
-	list_for_each(p, list) {
+	rcu_read_lock();
+	list_for_each_safe_rcu(p, nxtp, list) {
 		struct notifier_block *nb =
 			list_entry(p, struct notifier_block, link);
 
+		atomic_inc(&nb->inuse);
 		ret = nb->notifier_call(nb,val,v);
+		atomic_dec(&nb->inuse);
+
 		if (ret & NOTIFY_STOP_MASK) 
 			goto end_loop;
 	}
 
  end_loop:
+	rcu_read_unlock();
 	return ret;
 }
 



