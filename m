Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbSJJTzy>; Thu, 10 Oct 2002 15:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262185AbSJJTye>; Thu, 10 Oct 2002 15:54:34 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:10574 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S262182AbSJJTuT>; Thu, 10 Oct 2002 15:50:19 -0400
Date: Thu, 10 Oct 2002 13:04:21 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210102004.g9AK4LZ29554@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, yakker@aparity.com
Subject: [PATCH] 2.5.41: lkcd (2/8): dump notifier
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dump notification additions, similar to panic lists, but for dump
specific modules (per design).


 sys.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)


diff -Naur linux-2.5.41.orig/kernel/sys.c linux-2.5.41.lkcd/kernel/sys.c
--- linux-2.5.41.orig/kernel/sys.c	Mon Oct  7 11:23:25 2002
+++ linux-2.5.41.lkcd/kernel/sys.c	Tue Oct  8 02:16:22 2002
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
+#include <linux/dump.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -76,6 +77,7 @@
  */
 
 static struct notifier_block *reboot_notifier_list;
+struct notifier_block *dump_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
@@ -194,6 +196,37 @@
 	return notifier_chain_unregister(&reboot_notifier_list, nb);
 }
 
+/**
+ *	register_dump_notifier - Register function to be called at dump time
+ *	@nb: Info about notifier function to be called
+ *
+ *	Registers a function with the list of functions
+ *	to be called at dump time.
+ *
+ *	Currently always returns zero, as notifier_chain_register
+ *	always returns zero.
+ */
+ 
+int register_dump_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_register(&dump_notifier_list, nb);
+}
+
+/**
+ *	unregister_dump_notifier - Unregister previously registered dump notifier
+ *	@nb: Hook to be unregistered
+ *
+ *	Unregisters a previously registered dump
+ *	notifier function.
+ *
+ *	Returns zero on success, or %-ENOENT on failure.
+ */
+ 
+int unregister_dump_notifier(struct notifier_block * nb)
+{
+	return notifier_chain_unregister(&dump_notifier_list, nb);
+}
+
 asmlinkage long sys_ni_syscall(void)
 {
 	return -ENOSYS;
@@ -1382,3 +1415,6 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(register_dump_notifier);
+EXPORT_SYMBOL(unregister_dump_notifier);
+EXPORT_SYMBOL(dump_notifier_list);
