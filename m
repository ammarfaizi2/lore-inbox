Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbSJWJ3V>; Wed, 23 Oct 2002 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263270AbSJWJ3V>; Wed, 23 Oct 2002 05:29:21 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:64580 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S263207AbSJWJ3R>; Wed, 23 Oct 2002 05:29:17 -0400
Date: Wed, 23 Oct 2002 02:43:44 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: linux-kernel@vger.kernel.org
cc: lkcd-devel@lists.sourceforge.net
Subject: [PATCH] LKCD for 2.5.44 (2/8): dump notifier
In-Reply-To: <Pine.LNX.4.44.0210230241050.27315-100000@nakedeye.aparity.com>
Message-ID: <Pine.LNX.4.44.0210230243240.27315-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dump notification additions, similar to panic lists, but for dump
specific modules (per design).

 sys.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+)

diff -Naur linux-2.5.44.orig/kernel/sys.c linux-2.5.44.lkcd/kernel/sys.c
--- linux-2.5.44.orig/kernel/sys.c	Fri Oct 18 21:01:11 2002
+++ linux-2.5.44.lkcd/kernel/sys.c	Sat Oct 19 12:39:15 2002
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
+#include <linux/dump.h>
 #include <linux/security.h>
 #include <linux/dcookies.h>
 
@@ -77,6 +78,7 @@
  */
 
 static struct notifier_block *reboot_notifier_list;
+struct notifier_block *dump_notifier_list;
 rwlock_t notifier_lock = RW_LOCK_UNLOCKED;
 
 /**
@@ -195,6 +197,37 @@
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
@@ -1384,3 +1417,6 @@
 EXPORT_SYMBOL(unregister_reboot_notifier);
 EXPORT_SYMBOL(in_group_p);
 EXPORT_SYMBOL(in_egroup_p);
+EXPORT_SYMBOL(register_dump_notifier);
+EXPORT_SYMBOL(unregister_dump_notifier);
+EXPORT_SYMBOL(dump_notifier_list);

