Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267722AbSLSW7w>; Thu, 19 Dec 2002 17:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbSLSW7v>; Thu, 19 Dec 2002 17:59:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:4831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267722AbSLSW7n>;
	Thu, 19 Dec 2002 17:59:43 -0500
Subject: [PATCH] (4/5) notifier callback mechanism - read copy update V2
From: Stephen Hemminger <shemminger@osdl.org>
To: vamsi@in.ibm.com, John Levon <levon@movementarian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021219181929.A5265@in.ibm.com>
References: <1040249652.14364.192.camel@dell_ss3.pdx.osdl.net>
	 <20021219181929.A5265@in.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040339247.1079.6.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 15:07:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is third try at using RCU for notifier callbacks.  The difference is
that this version has a separate version for use by kernel profile that does
it's own locking and can sleep.

diff -Nru a/include/linux/notifier.h b/include/linux/notifier.h
--- a/include/linux/notifier.h	Thu Dec 19 14:51:07 2002
+++ b/include/linux/notifier.h	Thu Dec 19 14:51:07 2002
@@ -25,6 +25,7 @@
 extern int notifier_chain_register(struct list_head *, struct notifier_block *);
 extern int notifier_chain_unregister(struct list_head *, struct notifier_block *);
 extern int notifier_call_chain(struct list_head *, unsigned long, void *);
+extern int notifier_call_chain_safe(struct list_head *, unsigned long, void *);
 
 extern int register_panic_notifier(struct notifier_block *);
 extern int unregister_panic_notifier(struct notifier_block *);
diff -Nru a/kernel/profile.c b/kernel/profile.c
--- a/kernel/profile.c	Thu Dec 19 14:51:07 2002
+++ b/kernel/profile.c	Thu Dec 19 14:51:07 2002
@@ -55,21 +55,21 @@
 void profile_exit_task(struct task_struct * task)
 {
 	down_read(&profile_rwsem);
-	notifier_call_chain(&exit_task_notifier, 0, task);
+	notifier_call_chain_safe(&exit_task_notifier, 0, task);
 	up_read(&profile_rwsem);
 }
  
 void profile_exit_mmap(struct mm_struct * mm)
 {
 	down_read(&profile_rwsem);
-	notifier_call_chain(&exit_mmap_notifier, 0, mm);
+	notifier_call_chain_safe(&exit_mmap_notifier, 0, mm);
 	up_read(&profile_rwsem);
 }
 
 void profile_exec_unmap(struct mm_struct * mm)
 {
 	down_read(&profile_rwsem);
-	notifier_call_chain(&exec_unmap_notifier, 0, mm);
+	notifier_call_chain_safe(&exec_unmap_notifier, 0, mm);
 	up_read(&profile_rwsem);
 }
 
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Thu Dec 19 14:51:07 2002
+++ b/kernel/sys.c	Thu Dec 19 14:51:07 2002
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
@@ -95,7 +96,8 @@
 	struct list_head *p;
 
 	INIT_LIST_HEAD(&n->link);
-	write_lock(&notifier_lock);
+
+	spin_lock(&notifier_lock);
 	list_for_each(p, list) {
 		struct notifier_block *e 
 			= list_entry(p, struct notifier_block, link);
@@ -104,7 +106,7 @@
 	}
 
 	list_add(&n->link, p);
-	write_unlock(&notifier_lock);
+	spin_unlock(&notifier_lock);
 	return 0;
 }
 
@@ -122,15 +124,18 @@
 {
 	struct list_head *cur;
 
-	write_lock(&notifier_lock);
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
 			return 0;
 		}
 	}
-	write_unlock(&notifier_lock);
+	spin_unlock(&notifier_lock);
 	return -ENOENT;
 }
 
@@ -148,18 +153,62 @@
  *	the notifier function which halted execution.
  *	Otherwise, the return value is the return value
  *	of the last notifier function called.
+ *
+ *	This might be called from NMI or other context where it
+ *	is impossible to sleep or spin. The restriction is that the
+ *	handler must not sleep since rcu_read_lock disables preempt.
  */
- 
 int notifier_call_chain(struct list_head *list, unsigned long val, void *v)
 {
-	struct list_head *p;
+	struct list_head *p, *nxtp;
 	int ret = NOTIFY_DONE;
 
-	list_for_each(p, list) {
+	rcu_read_lock();
+	list_for_each_safe_rcu(p, nxtp, list) {
+		struct notifier_block *nb =
+			list_entry(p, struct notifier_block, link);
+
+		ret = nb->notifier_call(nb,val,v);
+
+		if (ret & NOTIFY_STOP_MASK) 
+			goto end_loop;
+	}
+
+ end_loop:
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ *	notifier_call_chain_safe - Call functions in a notifier chain
+ *	@n: Pointer to root pointer of notifier chain
+ *	@val: Value passed unmodified to notifier function
+ *	@v: Pointer passed unmodified to notifier function
+ *
+ *	Calls each function in a notifier chain in turn.
+ *
+ *	If the return value of the notifier can be and'd
+ *	with %NOTIFY_STOP_MASK, then notifier_call_chain
+ *	will return immediately, with the return value of
+ *	the notifier function which halted execution.
+ *	Otherwise, the return value is the return value
+ *	of the last notifier function called.
+ *
+ *	This differs from notifier_call_chain because it assumes
+ *	that the caller has done its own mutual exclusion and
+ *	does not want to use read-copy-update.
+ */
+int notifier_call_chain_safe(struct list_head *list, unsigned long val, void *v)
+{
+	struct list_head *p, *nxtp;
+	int ret = NOTIFY_DONE;
+
+	list_for_each_safe(p, nxtp, list) {
 		struct notifier_block *nb =
 			list_entry(p, struct notifier_block, link);
 
 		ret = nb->notifier_call(nb,val,v);
+
 		if (ret & NOTIFY_STOP_MASK) 
 			goto end_loop;
 	}



