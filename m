Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbSLRWIj>; Wed, 18 Dec 2002 17:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbSLRWH0>; Wed, 18 Dec 2002 17:07:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267368AbSLRWG0>;
	Wed, 18 Dec 2002 17:06:26 -0500
Subject: [PATCH] (5/5) improved notifier callback mechanism -- remove old
	locking
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1040249656.14358.194.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 14:14:16 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patches, the notifier interface now has it's own
locking.  Therefore the existing locking done by the profile interface
is superfluous.

This has been tested by repeated loading/unloading the oprofile driver
while profiling was on.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.985   -> 1.986  
#	arch/i386/kernel/profile.c	1.2     -> 1.3    
#	    kernel/profile.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/17	shemminger@osdl.org	1.986
# Locking now handled by notifier
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/profile.c b/arch/i386/kernel/profile.c
--- a/arch/i386/kernel/profile.c	Tue Dec 17 11:25:47 2002
+++ b/arch/i386/kernel/profile.c	Tue Dec 17 11:25:47 2002
@@ -6,40 +6,25 @@
  */
 
 #include <linux/profile.h>
-#include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <linux/irq.h>
 #include <asm/hw_irq.h> 
  
 static LIST_HEAD(profile_listeners);
-static rwlock_t profile_lock = RW_LOCK_UNLOCKED;
  
 int register_profile_notifier(struct notifier_block * nb)
 {
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_register(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
+	return notifier_chain_register(&profile_listeners, nb);
 }
 
 
 int unregister_profile_notifier(struct notifier_block * nb)
 {
-	int err;
-	write_lock_irq(&profile_lock);
-	err = notifier_chain_unregister(&profile_listeners, nb);
-	write_unlock_irq(&profile_lock);
-	return err;
+	return notifier_chain_unregister(&profile_listeners, nb);
 }
 
 
 void x86_profile_hook(struct pt_regs * regs)
 {
-	/* we would not even need this lock if
-	 * we had a global cli() on register/unregister
-	 */ 
-	read_lock(&profile_lock);
 	notifier_call_chain(&profile_listeners, 0, regs);
-	read_unlock(&profile_lock);
 }
diff -Nru a/kernel/profile.c b/kernel/profile.c
--- a/kernel/profile.c	Tue Dec 17 11:25:47 2002
+++ b/kernel/profile.c	Tue Dec 17 11:25:47 2002
@@ -47,38 +47,29 @@
  
 #ifdef CONFIG_PROFILING
  
-static DECLARE_RWSEM(profile_rwsem);
 static LIST_HEAD(exit_task_notifier);
 static LIST_HEAD(exit_mmap_notifier);
 static LIST_HEAD(exec_unmap_notifier);
  
 void profile_exit_task(struct task_struct * task)
 {
-	down_read(&profile_rwsem);
 	notifier_call_chain(&exit_task_notifier, 0, task);
-	up_read(&profile_rwsem);
 }
  
 void profile_exit_mmap(struct mm_struct * mm)
 {
-	down_read(&profile_rwsem);
 	notifier_call_chain(&exit_mmap_notifier, 0, mm);
-	up_read(&profile_rwsem);
 }
 
 void profile_exec_unmap(struct mm_struct * mm)
 {
-	down_read(&profile_rwsem);
 	notifier_call_chain(&exec_unmap_notifier, 0, mm);
-	up_read(&profile_rwsem);
 }
 
 int profile_event_register(enum profile_type type, struct
notifier_block * n)
 {
 	int err = -EINVAL;
  
-	down_write(&profile_rwsem);
- 
 	switch (type) {
 		case EXIT_TASK:
 			err = notifier_chain_register(&exit_task_notifier, n);
@@ -91,8 +82,6 @@
 			break;
 	}
  
-	up_write(&profile_rwsem);
- 
 	return err;
 }
 
@@ -101,8 +90,6 @@
 {
 	int err = -EINVAL;
  
-	down_write(&profile_rwsem);
- 
 	switch (type) {
 		case EXIT_TASK:
 			err = notifier_chain_unregister(&exit_task_notifier, n);
@@ -115,7 +102,6 @@
 			break;
 	}
 
-	up_write(&profile_rwsem);
 	return err;
 }
 



