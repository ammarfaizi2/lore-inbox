Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSFWUjp>; Sun, 23 Jun 2002 16:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSFWUjp>; Sun, 23 Jun 2002 16:39:45 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:2029 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S317114AbSFWUjo>;
	Sun, 23 Jun 2002 16:39:44 -0400
Date: Sun, 23 Jun 2002 21:40:01 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch-2.5.24] microcode tidy-up + observation
Message-ID: <Pine.LNX.4.33.0206232120390.2650-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

First of all, I attached a small patch, tested under 2.5.24:

o changes KERN_ERR priority for harmless messages to KERN_INFO as
  they are not really errors and shouldn't pollute the console.
  (microcode.c)

o if a write(2) with too large a buffer happens (such as would cause
  BUG() in vmalloc()) we should return -ENOMEM rather than -EINVAL and
  that silently (currently the driver is almost encouraging absurd lengths)
  (microcode.c)

o old reference to my webpage removed and another one updated.
  (CREDITS/MAINTAINERS)

Observation: I noticed that all smp_num_cpus in the driver have been
replaced by NR_CPUS. I assume this was done for the CPU hotplug support,
although if smp_num_cpus reflects the "current" number of online cpus, I
think, the driver would have worked as is and avoided wasting 64k-epsilon
of memory.

Regards
Tigran

diff -X dontdiff -urN linux-2.5.24-orig/CREDITS linux-2.5.24/CREDITS
--- linux-2.5.24-orig/CREDITS	Thu Jun 20 23:53:46 2002
+++ linux-2.5.24/CREDITS	Sun Jun 23 21:11:22 2002
@@ -39,7 +39,7 @@

 N: Tigran A. Aivazian
 E: tigran@veritas.com
-W: http://www.ocston.org/~tigran
+W: http://www.moses.uklinux.net/patches
 D: BFS filesystem
 D: Intel IA32 CPU microcode update support
 D: Various kernel patches
diff -X dontdiff -urN linux-2.5.24-orig/MAINTAINERS linux-2.5.24/MAINTAINERS
--- linux-2.5.24-orig/MAINTAINERS	Thu Jun 20 23:53:54 2002
+++ linux-2.5.24/MAINTAINERS	Sun Jun 23 21:10:28 2002
@@ -255,7 +255,6 @@
 P:	Tigran A. Aivazian
 M:	tigran@veritas.com
 L:	linux-kernel@vger.kernel.org
-W:	http://www.ocston.org/~tigran/patches/bfs
 S:	Maintained

 BLOCK LAYER
diff -X dontdiff -urN linux-2.5.24-orig/arch/i386/kernel/microcode.c linux-2.5.24/arch/i386/kernel/microcode.c
--- linux-2.5.24-orig/arch/i386/kernel/microcode.c	Thu Jun 20 23:53:47 2002
+++ linux-2.5.24/arch/i386/kernel/microcode.c	Sun Jun 23 21:17:50 2002
@@ -260,7 +260,7 @@

 			if (microcode[i].rev < rev) {
 				spin_unlock_irqrestore(&microcode_update_lock, flags);
-				printk(KERN_ERR
+				printk(KERN_INFO
 				       "microcode: CPU%d not 'upgrading' to earlier revision"
 				       " %d (current=%d)\n", cpu_num, microcode[i].rev, rev);
 				return;
@@ -268,7 +268,7 @@
 				/* notify the caller of success on this cpu */
 				req->err = 0;
 				spin_unlock_irqrestore(&microcode_update_lock, flags);
-				printk(KERN_ERR
+				printk(KERN_INFO
 					"microcode: CPU%d already at revision"
 					" %d (current=%d)\n", cpu_num, microcode[i].rev, rev);
 				return;
@@ -337,10 +337,9 @@
 			sizeof(struct microcode));
 		return -EINVAL;
 	}
-	if ((len >> PAGE_SHIFT) > num_physpages) {
-		printk(KERN_ERR "microcode: too much data (max %ld pages)\n", num_physpages);
-		return -EINVAL;
-	}
+	if ((len >> PAGE_SHIFT) > num_physpages)
+		return -ENOMEM;
+
 	down_write(&microcode_rwsem);
 	if (!mc_applied) {
 		mc_applied = kmalloc(NR_CPUS*sizeof(struct microcode),

