Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273096AbRIOWIC>; Sat, 15 Sep 2001 18:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273105AbRIOWHw>; Sat, 15 Sep 2001 18:07:52 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:4329 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S273096AbRIOWHl> convert rfc822-to-8bit; Sat, 15 Sep 2001 18:07:41 -0400
From: Roberto Ragusa <robertoragusa@technologist.com>
To: linux-kernel@vger.kernel.org
CC: Roberto Ragusa <robertoragusa@technologist.com>
Date: Sat, 15 Sep 2001 23:58:43 +0200
Message-ID: <yam8658.2192.152344160@mail.inwind.it>
X-Mailer: YAM 2.2 [060] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch
Subject: [PATCH] A nicer nice scheduling
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider including this patch in the main kernel.
It was proposed on 11/04/2001 by Rik van Riel
([test-PATCH] Re: [QUESTION] 2.4.x nice level)

This patch has been working great for me, I applied it to
every new kernel out.

Without this patch, a nice=19 busy-looping process is given
15% of CPU cycles when there is a busy-looping nice=0 process.

Well, if one runs background CPU-consuming programs
(dnetc), this patch makes a nice speed boost.

Please CC to me any replies.

diff -urN linux-2.4.8-lmshsbrnc1/include/linux/sched.h linux-2.4.8-lmshsbrnc1_/include/linux/sched.h
--- linux-2.4.8-lmshsbrnc1/include/linux/sched.h    Sun Aug 12 10:18:03 2001
+++ linux-2.4.8-lmshsbrnc1_/include/linux/sched.h    Sun Aug 12 12:19:16 2001
@@ -305,7 +305,8 @@
  * the goodness() loop in schedule().
  */
     long counter;
-    long nice;
+    short nice_calc;
+    short nice;
     unsigned long policy;
     struct mm_struct *mm;
     int has_cpu, processor;
diff -urN linux-2.4.8-lmshsbrnc1/kernel/sched.c linux-2.4.8-lmshsbrnc1_/kernel/sched.c
--- linux-2.4.8-lmshsbrnc1/kernel/sched.c    Sun Aug 12 10:18:03 2001
+++ linux-2.4.8-lmshsbrnc1_/kernel/sched.c    Sun Aug 12 12:19:16 2001
@@ -680,8 +680,26 @@
         struct task_struct *p;
         spin_unlock_irq(&runqueue_lock);
         read_lock(&tasklist_lock);
-        for_each_task(p)
+        for_each_task(p) {
+            if (p->nice <= 0) {
+            /* The normal case... */
             p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+            } else {
+            /*
+             * Niced tasks get less CPU less often, leading to
+             * the following distribution of CPU time:
+             *
+             * Nice    0    5   10   15   19
+             * %CPU  100   56   25    6    1    
+             */
+            short prio = 20 - p->nice;
+            p->nice_calc += prio;
+            if (p->nice_calc >= 20) {
+                p->nice_calc -= 20;
+                p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
+            }
+            }
+        }
         read_unlock(&tasklist_lock);
         spin_lock_irq(&runqueue_lock);
     }


-- 
            Roberto Ragusa   robertoragusa at technologist.com

