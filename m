Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285062AbRL3VpZ>; Sun, 30 Dec 2001 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285074AbRL3VpP>; Sun, 30 Dec 2001 16:45:15 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:51468 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285062AbRL3VpH>; Sun, 30 Dec 2001 16:45:07 -0500
Date: Sun, 30 Dec 2001 13:49:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] scheduler params ( cont ) ...
Message-ID: <Pine.LNX.4.40.0112301343390.934-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To have a tslice of == 40ms with HZ == 100, MAX_NICE_TSLICE must be
changed to 80000. That's what i'm testing. MAX_NICE_TSLICE == 70000 leads
to a tslice == 30ms with HZ == 100, and maybe it's a bit short. Maybe, i
did not try it anyway.



- Davide




diff -Nru linux-2.5.2-pre3.vanilla/include/linux/sched.h linux-2.5.2-pre3.psch/include/linux/sched.h
--- linux-2.5.2-pre3.vanilla/include/linux/sched.h	Thu Dec 27 20:11:25 2001
+++ linux-2.5.2-pre3.psch/include/linux/sched.h	Fri Dec 28 10:37:17 2001
@@ -302,7 +302,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	long dyn_prio;
+	unsigned long dyn_prio;
 	long nice;
 	unsigned long policy;
 	struct mm_struct *mm;
@@ -452,7 +452,7 @@
  */
 #define _STK_LIM	(8*1024*1024)

-#define MAX_DYNPRIO	100
+#define MAX_DYNPRIO	40
 #define DEF_TSLICE	(6 * HZ / 100)
 #define MAX_TSLICE	(20 * HZ / 100)
 #define DEF_NICE	(0)
diff -Nru linux-2.5.2-pre3.vanilla/kernel/sched.c linux-2.5.2-pre3.psch/kernel/sched.c
--- linux-2.5.2-pre3.vanilla/kernel/sched.c	Thu Dec 27 20:11:25 2001
+++ linux-2.5.2-pre3.psch/kernel/sched.c	Sun Dec 30 12:49:27 2001
@@ -53,23 +53,17 @@
  * is a "high-priority" task, and a "+10" is a low-priority
  * task.
  *
- * We want the time-slice to be around 50ms or so, so this
+ * We want the time-slice to be around 35ms or so, so this
  * calculation depends on the value of HZ.
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
-#define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)
+#define NICE_RANGE  40
+#define MIN_NICE_TSLICE 10000
+#define MAX_NICE_TSLICE 80000
+#define NICE_TO_TICKS(nice) ts_table[19 - nice]
+
+static unsigned char ts_table[NICE_RANGE];

+#define MM_AFFINITY_BONUS	1

 /*
  *	Init task must be ok at boot for the ix86 as we will check its signals
@@ -181,7 +175,7 @@

 		/* .. and a slight advantage to the current MM */
 		if (p->mm == this_mm || !p->mm)
-			weight += 1;
+			weight += MM_AFFINITY_BONUS;
 		weight += 20 - p->nice;
 		goto out;
 	}
@@ -533,7 +527,7 @@
 		p->need_resched = 1;
 	else {
 		if (!--p->time_slice) {
-			if (p->dyn_prio > 0) {
+			if (p->dyn_prio) {
 				--p->time_slice;
 				--p->dyn_prio;
 			}
@@ -1324,6 +1318,15 @@

 extern void init_timervecs (void);

+static void fill_tslice_map(void)
+{
+    int i;
+
+    for (i = 0; i < NICE_RANGE; i++)
+        ts_table[i] = ((MIN_NICE_TSLICE +
+                        ((MAX_NICE_TSLICE - MIN_NICE_TSLICE) / NICE_RANGE) * i) * HZ) / 1000000;
+}
+
 void __init sched_init(void)
 {
 	/*
@@ -1337,6 +1340,8 @@

 	for(nr = 0; nr < PIDHASH_SZ; nr++)
 		pidhash[nr] = NULL;
+
+	fill_tslice_map();

 	init_timervecs();


