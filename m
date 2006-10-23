Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWJWHiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWJWHiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWJWHiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:38:17 -0400
Received: from poczta.o2.pl ([193.17.41.142]:2280 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751688AbWJWHiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:38:16 -0400
Date: Mon, 23 Oct 2006 09:43:28 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, akpm@osdl.org
Subject: [PATCH] lockdep: misc fixes in lockdep.c
Message-ID: <20061023074328.GA2375@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In lockdep.c: 
- numeric string size replaced with constant
in print_lock_name and print_lockdep_cache,
- return on null pointer in print_lock_dependencies,
- one more lockdep return with 0 with unlocking fix
in mark_lock.

This patch was prepared against 2.6.19-rc2-git3 plus
the patch titled
     lockdep: internal locking fixes
has been added to the -mm tree.  Its filename is
     lockdep-internal-locking-fixes.patch


Signed-off-by: Jarek Poplawski <jarkao2@o2.pl>
---

diff -Nurp linux-2.6.19-rc2-git3-/kernel/lockdep.c linux-2.6.19-rc2-git3/kernel/lockdep.c
--- linux-2.6.19-rc2-git3-/kernel/lockdep.c	2006-10-20 14:58:21.000000000 +0200
+++ linux-2.6.19-rc2-git3/kernel/lockdep.c	2006-10-22 22:09:36.000000000 +0200
@@ -359,7 +359,7 @@ get_usage_chars(struct lock_class *class
 
 static void print_lock_name(struct lock_class *class)
 {
-	char str[128], c1, c2, c3, c4;
+	char str[KSYM_NAME_LEN + 1], c1, c2, c3, c4;
 	const char *name;
 
 	get_usage_chars(class, &c1, &c2, &c3, &c4);
@@ -381,7 +381,7 @@ static void print_lock_name(struct lock_
 static void print_lockdep_cache(struct lockdep_map *lock)
 {
 	const char *name;
-	char str[128];
+	char str[KSYM_NAME_LEN + 1];
 
 	name = lock->name;
 	if (!name)
@@ -451,7 +451,9 @@ static void print_lock_dependencies(stru
 	print_lock_class_header(class, depth);
 
 	list_for_each_entry(entry, &class->locks_after, entry) {
-		DEBUG_LOCKS_WARN_ON(!entry->class);
+		if (DEBUG_LOCKS_WARN_ON(!entry->class))
+			return;
+
 		print_lock_dependencies(entry->class, depth + 1);
 
 		printk("%*s ... acquired at:\n",depth,"");
@@ -1733,6 +1735,7 @@ static int mark_lock(struct task_struct 
 		debug_atomic_dec(&nr_unused_locks);
 		break;
 	default:
+		__raw_spin_unlock(&hash_lock);
 		debug_locks_off();
 		WARN_ON(1);
 		return 0;
