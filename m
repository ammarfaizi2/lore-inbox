Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUIJOxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUIJOxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUIJOxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:53:41 -0400
Received: from fw-us-hou19.bmc.com ([198.207.223.240]:46060 "EHLO
	mangrove.bmc.com") by vger.kernel.org with ESMTP id S267446AbUIJOxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:53:34 -0400
Message-ID: <1094828013.19339.1000.camel@levlinux.boston.bmc.com>
From: "Makhlis, Lev" <Lev_Makhlis@bmc.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Makhlis, Lev" <Lev_Makhlis@bmc.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc1-mm4] fix BUG in do_task_stat()
Date: Fri, 10 Sep 2004 09:53:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> kernel BUG in next_thread at kernel/exit.c:852!
> cpu 0x2: Vector: 700 (Program Check) at [c00000027bcf3770]
>     pc: c000000000058454: .next_thread+0x14/0x48
>     lr: c0000000000f1a84: .do_task_stat+0x238/0x53c
> 

I've been able to reproduce this.  This patch makes sure next_thread()
is only called while holding ->sighand->siglock.  Ran it overnight with
a load, and no problems so far.

Signed-off-by: Lev Makhlis <mlev@despammed.com>

diff -pruN linux-2.6.9-rc1-mm4/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.6.9-rc1-mm4/fs/proc/array.c	2004-09-09 18:06:19.265831912 -0400
+++ linux/fs/proc/array.c	2004-09-09 18:01:34.221165288 -0400
@@ -336,6 +336,16 @@ static int do_task_stat(struct task_stru
 		spin_lock_irq(&task->sighand->siglock);
 		num_threads = atomic_read(&task->signal->count);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
+		if (whole) {
+			t = task;
+			do {
+				min_flt += t->min_flt;
+				maj_flt += t->maj_flt;
+				utime += t->utime;
+				stime += t->stime;
+				t = next_thread(t);
+			} while (t != task);
+		}
 		spin_unlock_irq(&task->sighand->siglock);
 	}
 	if (task->signal) {
@@ -350,22 +360,12 @@ static int do_task_stat(struct task_stru
 		cutime = task->signal->cutime;
 		cstime = task->signal->cstime;
 		if (whole) {
-			min_flt = task->signal->min_flt;
-			maj_flt = task->signal->maj_flt;
-			utime = task->signal->utime;
-			stime = task->signal->stime;
+			min_flt += task->signal->min_flt;
+			maj_flt += task->signal->maj_flt;
+			utime += task->signal->utime;
+			stime += task->signal->stime;
 		}
 	}
-	if (whole) {
-		t = task;
-		do {
-			min_flt += t->min_flt;
-			maj_flt += t->maj_flt;
-			utime += t->utime;
-			stime += t->stime;
-			t = next_thread(t);
-		} while (t != task);
-	}
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);

