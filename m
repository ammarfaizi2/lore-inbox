Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUGQB5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUGQB5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 21:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUGQB5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 21:57:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:41691 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266681AbUGQB4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 21:56:39 -0400
Date: Sat, 17 Jul 2004 03:56:33 +0200 (MEST)
Message-Id: <200407170156.i6H1uXIM015042@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] perfctr inheritance 2/3: kernel updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- s/perfctr_copy_thread(&p->thread)/perfctr_copy_task(p, regs)/g
  Needed to access to the task struct (for setting owner in new
  perfctr state) and for accessing regs (for checking user_mode(regs))
- Add perfctr_release_task() callback in kernel/exit.c

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/i386/kernel/process.c   |    2 +-
 arch/ppc/kernel/process.c    |    2 +-
 arch/x86_64/kernel/process.c |    2 +-
 kernel/exit.c                |    2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff -ruN linux-2.6.8-rc1-mm1/arch/i386/kernel/process.c linux-2.6.8-rc1-mm1.perfctr-inheritance/arch/i386/kernel/process.c
--- linux-2.6.8-rc1-mm1/arch/i386/kernel/process.c	2004-07-14 12:59:20.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/arch/i386/kernel/process.c	2004-07-17 00:28:21.832314000 +0200
@@ -368,7 +368,7 @@
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
-	perfctr_copy_thread(&p->thread);
+	perfctr_copy_task(p, regs);
 
 	tsk = current;
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
diff -ruN linux-2.6.8-rc1-mm1/arch/ppc/kernel/process.c linux-2.6.8-rc1-mm1.perfctr-inheritance/arch/ppc/kernel/process.c
--- linux-2.6.8-rc1-mm1/arch/ppc/kernel/process.c	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/arch/ppc/kernel/process.c	2004-07-17 00:28:21.832314000 +0200
@@ -464,7 +464,7 @@
 
 	p->thread.last_syscall = -1;
 
-	perfctr_copy_thread(&p->thread);
+	perfctr_copy_task(p, regs);
 
 	return 0;
 }
diff -ruN linux-2.6.8-rc1-mm1/arch/x86_64/kernel/process.c linux-2.6.8-rc1-mm1.perfctr-inheritance/arch/x86_64/kernel/process.c
--- linux-2.6.8-rc1-mm1/arch/x86_64/kernel/process.c	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/arch/x86_64/kernel/process.c	2004-07-17 00:28:21.832314000 +0200
@@ -367,7 +367,7 @@
 	asm("movl %%es,%0" : "=m" (p->thread.es));
 	asm("movl %%ds,%0" : "=m" (p->thread.ds));
 
-	perfctr_copy_thread(&p->thread);
+	perfctr_copy_task(p, regs);
 
 	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
diff -ruN linux-2.6.8-rc1-mm1/kernel/exit.c linux-2.6.8-rc1-mm1.perfctr-inheritance/kernel/exit.c
--- linux-2.6.8-rc1-mm1/kernel/exit.c	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/kernel/exit.c	2004-07-17 00:28:21.842314000 +0200
@@ -23,6 +23,7 @@
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
+#include <linux/perfctr.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -94,6 +95,7 @@
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
 	p->parent->cnivcsw += p->nivcsw + p->cnivcsw;
+	perfctr_release_task(p);
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
 	spin_unlock(&p->proc_lock);
