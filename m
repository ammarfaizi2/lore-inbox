Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSLPTFe>; Mon, 16 Dec 2002 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSLPTFd>; Mon, 16 Dec 2002 14:05:33 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:48071 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S261290AbSLPTFd>;
	Mon, 16 Dec 2002 14:05:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Fix CPU bitmask truncation
Date: Mon, 16 Dec 2002 12:13:29 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212161213.29230.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some obviously incorrect bitmask truncations in 2.4.20.

diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Mon Dec 16 11:58:42 2002
+++ b/include/linux/sched.h	Mon Dec 16 11:58:42 2002
@@ -482,8 +482,8 @@
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
-    cpus_runnable:	-1,						\
-    cpus_allowed:	-1,						\
+    cpus_runnable:	~0UL,						\
+    cpus_allowed:	~0UL,						\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Mon Dec 16 11:58:42 2002
+++ b/kernel/sched.c	Mon Dec 16 11:58:42 2002
@@ -116,7 +116,7 @@
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
 #define can_schedule(p,cpu) \
-	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
+	((p)->cpus_runnable & (p)->cpus_allowed & (1UL << cpu))
 
 #else
 
@@ -359,7 +359,7 @@
 	if (task_on_runqueue(p))
 		goto out;
 	add_to_runqueue(p);
-	if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
+	if (!synchronous || !(p->cpus_allowed & (1UL << smp_processor_id())))
 		reschedule_idle(p);
 	success = 1;
 out:

