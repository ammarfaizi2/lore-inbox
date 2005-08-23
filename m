Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVHWVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVHWVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVHWVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:44:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11190 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932414AbVHWVoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:09 -0400
To: torvalds@osdl.org
Subject: [PATCH] (29/43) alpha spinlock code and bogus constraints
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gbw-0007DJ-2b@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"=m" (lock->lock) / "1" (lock->lock) makes gcc4 unhappy; fixed by s/1/m/,
same as in case of i386 rwsem.h where such variant had been accepted
by both Linus and rth.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-alpha-xchg/arch/alpha/kernel/smp.c RC13-rc6-git13-alpha-constraints/arch/alpha/kernel/smp.c
--- RC13-rc6-git13-alpha-xchg/arch/alpha/kernel/smp.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-alpha-constraints/arch/alpha/kernel/smp.c	2005-08-21 13:17:11.000000000 -0400
@@ -1036,7 +1036,7 @@
 	"	br	1b\n"
 	".previous"
 	: "=r" (tmp), "=m" (lock->lock), "=r" (stuck)
-	: "1" (lock->lock), "2" (stuck) : "memory");
+	: "m" (lock->lock), "2" (stuck) : "memory");
 
 	if (stuck < 0) {
 		printk(KERN_WARNING
@@ -1115,7 +1115,7 @@
 	".previous"
 	: "=m" (*(volatile int *)lock), "=&r" (regx), "=&r" (regy),
 	  "=&r" (stuck_lock), "=&r" (stuck_reader)
-	: "0" (*(volatile int *)lock), "3" (stuck_lock), "4" (stuck_reader) : "memory");
+	: "m" (*(volatile int *)lock), "3" (stuck_lock), "4" (stuck_reader) : "memory");
 
 	if (stuck_lock < 0) {
 		printk(KERN_WARNING "write_lock stuck at %p\n", inline_pc);
@@ -1153,7 +1153,7 @@
 	"	br	1b\n"
 	".previous"
 	: "=m" (*(volatile int *)lock), "=&r" (regx), "=&r" (stuck_lock)
-	: "0" (*(volatile int *)lock), "2" (stuck_lock) : "memory");
+	: "m" (*(volatile int *)lock), "2" (stuck_lock) : "memory");
 
 	if (stuck_lock < 0) {
 		printk(KERN_WARNING "read_lock stuck at %p\n", inline_pc);
