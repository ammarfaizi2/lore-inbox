Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbUCHP6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbUCHP6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:58:30 -0500
Received: from curio.k8.com.br ([200.185.109.36]:50891 "EHLO curio.k8.com.br")
	by vger.kernel.org with ESMTP id S262504AbUCHP60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:58:26 -0500
Message-ID: <1183.200.149.141.175.1078761505.squirrel@wma.k8.com.br>
Date: Mon, 8 Mar 2004 12:58:25 -0300 (BRT)
Subject: [PATCH] limit process tree depth
From: "Marco Molinaro" <marco@digirati.com.br>
To: linux-kernel@vger.kernel.org
Cc: "Alan Cox" <alan@redhat.com>
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
References: 
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description    : Limit the depth of the process tree
Kernel version : 2.6.3
URL            : http://oss.digirati.com.br/fkdepth/

This patch provides limiting facility over the creation of children
processes.
That means if a process depth is set to:
  0 - it can't fork.
  1 - it can fork, but its children can't.
  2 - the process and its children can fork, but its grandchildren can't.
  3 - etc.

It's done using the rlimit framework, which makes the patch really small.
One application is to stop the following exploit:

Mod_php under apache httpd 2.0.x leaks a critical file descriptor that can be
used to hijack the https service. To do so, the proccess needs to fork and

deamonize itself. By setting his process depth to 0 or 1, it just can't
deamonize.

This patch only shows the changes for i386 arch to reduce this mail size,
full
version (all archs) can be found at URL.

Since it's my very first patch attempt I hope I haven't messed it up. Any 
comments and sugestions are appreciated.

Marco


diff -Nur linux-2.6.3/include/asm-i386/resource.h
linux/include/asm-i386/resource.h
--- linux-2.6.3/include/asm-i386/resource.h	2004-02-18 00:57:16.000000000
-0500
+++ linux/include/asm-i386/resource.h	2004-03-07 14:00:09.000000000 -0500
@@ -16,8 +16,9 @@
 #define RLIMIT_MEMLOCK	8		/* max locked-in-memory address space */
 #define RLIMIT_AS	9		/* address space limit */
 #define RLIMIT_LOCKS	10		/* maximum file locks held */
+#define RLIMIT_DEPTH	11		/* max process depth */

-#define RLIM_NLIMITS	11
+#define RLIM_NLIMITS	12

 /*
  * SuS says limits have to be unsigned.
@@ -40,6 +41,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }

 #endif /* __KERNEL__ */
diff -Nur linux-2.6.3/kernel/fork.c linux/kernel/fork.c
--- linux-2.6.3/kernel/fork.c	2004-02-18 00:57:14.000000000 -0500
+++ linux/kernel/fork.c	2004-03-07 13:56:45.000000000 -0500
@@ -1008,6 +1008,20 @@
 		p->real_parent = current;
 	p->parent = p->real_parent;

+
+	/*
+	 *  Check if the RLIMIT_DEPTH was set and then if parent
+	 *  have a spare depth. Finally update child's depth limits.
+	 */
+	if (p->parent->rlim[RLIMIT_DEPTH].rlim_cur != RLIM_INFINITY) {
+		if (!p->parent->rlim[RLIMIT_DEPTH].rlim_cur) {
+			retval = -EPERM;
+			goto bad_fork_cleanup_namespace;
+		}
+		p->rlim[RLIMIT_DEPTH].rlim_cur = p->parent->rlim[RLIMIT_DEPTH].rlim_cur
- 1;
+		p->rlim[RLIMIT_DEPTH].rlim_max = p->parent->rlim[RLIMIT_DEPTH].rlim_max
- 1;
+	}
+
 	if (clone_flags & CLONE_THREAD) {
 		spin_lock(&current->sighand->siglock);
 		/*
