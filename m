Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263141AbSITRbb>; Fri, 20 Sep 2002 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSITRbb>; Fri, 20 Sep 2002 13:31:31 -0400
Received: from m084156.ap.plala.or.jp ([219.164.84.156]:17300 "HELO
	mana.fennel.org") by vger.kernel.org with SMTP id <S263141AbSITRb1>;
	Fri, 20 Sep 2002 13:31:27 -0400
Date: Sat, 21 Sep 2002 02:36:22 +0900 (JST)
Message-Id: <20020921.023622.72271649.sian@big.or.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.37 export find_task_by_pid
From: Hiroshi Takekawa <sian@big.or.jp>
X-Mailer: Mew version 3.0.64 on Emacs 21.3 / Mule 5.0
 =?iso-2022-jp?B?KBskQjgtTFobKEIvU0FLQUtJKQ==?=
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

ipt_owner calls find_task_by_pid.
When compiled as module, unresolved error happens.
My fix is below.  I don't know this is right, though error has gone.

--
Hiroshi Takekawa <sian@big.or.jp>


diff -Naur linux-2.5.37/kernel/Makefile linux-2.5.37.patched/kernel/Makefile
--- linux-2.5.37/kernel/Makefile	Sat Sep 21 02:23:20 2002
+++ linux-2.5.37.patched/kernel/Makefile	Sat Sep 21 02:12:41 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o pid.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
diff -Naur linux-2.5.37/kernel/pid.c linux-2.5.37.patched/kernel/pid.c
--- linux-2.5.37/kernel/pid.c	Sat Sep 21 02:23:20 2002
+++ linux-2.5.37.patched/kernel/pid.c	Sat Sep 21 02:09:58 2002
@@ -19,6 +19,7 @@
  * bytes. The typical fastpath is a single successful setbit. Freeing is O(1).
  */
 
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -191,7 +192,7 @@
 	free_pidmap(nr);
 }
 
-extern task_t *find_task_by_pid(int nr)
+task_t *find_task_by_pid(int nr)
 {
 	struct pid *pid = find_pid(PIDTYPE_PID, nr);
 
@@ -199,6 +200,7 @@
 		return NULL;
 	return pid_task(pid->task_list.next, PIDTYPE_PID);
 }
+EXPORT_SYMBOL(find_task_by_pid);
 
 void __init pidhash_init(void)
 {
