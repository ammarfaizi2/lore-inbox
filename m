Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287009AbSABUjG>; Wed, 2 Jan 2002 15:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286996AbSABUiz>; Wed, 2 Jan 2002 15:38:55 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:36366 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286999AbSABUiq>; Wed, 2 Jan 2002 15:38:46 -0500
Date: Wed, 2 Jan 2002 12:41:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] scheduler fixups ...
Message-ID: <Pine.LNX.4.40.0201021236390.1034-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, this contain the sleep_time removal, a still lower ts and a ceiling
for dyn_prio in yield.
BTW, pre6 has still some kdev_t problem that prevents builds



- Davide




diff -Nru linux-2.5.2-pre6.vanilla/include/linux/sched.h linux-2.5.2-pre6.psch/include/linux/sched.h
--- linux-2.5.2-pre6.vanilla/include/linux/sched.h	Wed Jan  2 11:26:58 2002
+++ linux-2.5.2-pre6.psch/include/linux/sched.h	Wed Jan  2 12:22:28 2002
@@ -322,7 +322,6 @@
 	 */
 	struct list_head run_list;
 	long time_slice;
-	unsigned long sleep_time;
 	/* recalculation loop checkpoint */
 	unsigned long rcl_last;

@@ -886,7 +885,6 @@
 static inline void del_from_runqueue(struct task_struct * p)
 {
 	nr_running--;
-	p->sleep_time = jiffies;
 	list_del(&p->run_list);
 	p->run_list.next = NULL;
 }
diff -Nru linux-2.5.2-pre6.vanilla/kernel/sched.c linux-2.5.2-pre6.psch/kernel/sched.c
--- linux-2.5.2-pre6.vanilla/kernel/sched.c	Wed Jan  2 11:27:04 2002
+++ linux-2.5.2-pre6.psch/kernel/sched.c	Wed Jan  2 12:28:32 2002
@@ -51,11 +51,11 @@
  * NOTE! The unix "nice" value influences how long a process
  * gets. The nice value ranges from -20 to +19, where a -20
  * is a "high-priority" task, and a "+10" is a low-priority
- * task. The default time slice for zero-nice tasks will be 43ms.
+ * task. The default time slice for zero-nice tasks will be 37ms.
  */
 #define NICE_RANGE	40
 #define MIN_NICE_TSLICE	10000
-#define MAX_NICE_TSLICE	80000
+#define MAX_NICE_TSLICE	65000
 #define TASK_TIMESLICE(p)	((int) ts_table[19 - (p)->nice])

 static unsigned char ts_table[NICE_RANGE];
@@ -1070,7 +1070,8 @@
 		current->need_resched = 1;

 		current->time_slice = 0;
-		current->dyn_prio++;
+		if (++current->dyn_prio > MAX_DYNPRIO)
+			current->dyn_prio = MAX_DYNPRIO;
 	}
 	return 0;
 }
@@ -1325,7 +1326,8 @@

 	for (i = 0; i < NICE_RANGE; i++)
 		ts_table[i] = ((MIN_NICE_TSLICE +
-						((MAX_NICE_TSLICE - MIN_NICE_TSLICE) / NICE_RANGE) * i) * HZ) / 1000000;
+						((MAX_NICE_TSLICE -
+						  MIN_NICE_TSLICE) / (NICE_RANGE - 1)) * i) * HZ) / 1000000;
 }

 void __init sched_init(void)

