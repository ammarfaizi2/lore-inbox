Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286188AbRLaCz2>; Sun, 30 Dec 2001 21:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286187AbRLaCzT>; Sun, 30 Dec 2001 21:55:19 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:62736 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286178AbRLaCzD>; Sun, 30 Dec 2001 21:55:03 -0500
Date: Sun, 30 Dec 2001 18:54:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] scheduler params and nice to ticks logic for 2.5.2-pre4 ...
Message-ID: <Pine.LNX.4.40.0112301851090.935-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, this is the same patch of my last post modified for 2.5.2-pre4
Pls apply because 40ms timeslice seems really better than 60ms



- Davide




diff -Nru linux-2.5.2-pre4.vanilla/kernel/sched.c linux-2.5.2-pre4.psch/kernel/sched.c
--- linux-2.5.2-pre4.vanilla/kernel/sched.c	Sun Dec 30 17:27:45 2001
+++ linux-2.5.2-pre4.psch/kernel/sched.c	Sun Dec 30 18:46:37 2001
@@ -51,25 +51,16 @@
  * NOTE! The unix "nice" value influences how long a process
  * gets. The nice value ranges from -20 to +19, where a -20
  * is a "high-priority" task, and a "+10" is a low-priority
- * task.
- *
- * We want the time-slice to be around 50ms or so, so this
- * calculation depends on the value of HZ.
+ * task. The default time slice for zero-nice tasks will be 43ms.
  */
-#if HZ < 200
-#define TICK_SCALE(x)	((x) >> 2)
-#elif HZ < 400
-#define TICK_SCALE(x)	((x) >> 1)
-#elif HZ < 800
-#define TICK_SCALE(x)	(x)
-#elif HZ < 1600
-#define TICK_SCALE(x)	((x) << 1)
-#else
-#define TICK_SCALE(x)	((x) << 2)
-#endif
-
-#define TASK_TIMESLICE(p)	(TICK_SCALE(20-(p)->nice)+1)
-
+#define NICE_RANGE	40
+#define MIN_NICE_TSLICE	10000
+#define MAX_NICE_TSLICE	80000
+#define TASK_TIMESLICE(p)	((int) ts_table[19 - (p)->nice])
+
+static unsigned char ts_table[NICE_RANGE];
+
+#define MM_AFFINITY_BONUS	1

 /*
  *	Init task must be ok at boot for the ix86 as we will check its signals
@@ -181,7 +172,7 @@

 		/* .. and a slight advantage to the current MM */
 		if (p->mm == this_mm || !p->mm)
-			weight += 1;
+			weight += MM_AFFINITY_BONUS;
 		weight += 20 - p->nice;
 		goto out;
 	}
@@ -1313,6 +1304,15 @@

 extern void init_timervecs (void);

+static void fill_tslice_map(void)
+{
+	int i;
+
+	for (i = 0; i < NICE_RANGE; i++)
+		ts_table[i] = ((MIN_NICE_TSLICE +
+						((MAX_NICE_TSLICE - MIN_NICE_TSLICE) / NICE_RANGE) * i) * HZ) / 1000000;
+}
+
 void __init sched_init(void)
 {
 	/*
@@ -1326,6 +1326,8 @@

 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;
+
+	fill_tslice_map();

 	init_timervecs();


