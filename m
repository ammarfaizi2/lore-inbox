Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSJCXNt>; Thu, 3 Oct 2002 19:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJCXNt>; Thu, 3 Oct 2002 19:13:49 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:23556 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S261360AbSJCXNr>;
	Thu, 3 Oct 2002 19:13:47 -0400
Message-ID: <3D9CD1C7.70817518@tv-sign.ru>
Date: Fri, 04 Oct 2002 03:24:55 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] timer-2.5.40-F7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

run_timer_tasklet() checks for expired local timers,
i think it is better to do it in run_local_timers()
before tasklet_schedule().

On top of timer-2.5.40-F7:

--- kernel/timer.c.orig	Fri Oct  4 02:18:05 2002
+++ kernel/timer.c	Fri Oct  4 02:53:02 2002
@@ -715,10 +715,7 @@
  */
 static void run_timer_tasklet(unsigned long data)
 {
-	tvec_base_t *base = tvec_bases + smp_processor_id();
-
-	if ((long)(jiffies - base->timer_jiffies) >= 0)
-		__run_timers(base);
+	__run_timers((tvec_base_t*)data);
 }
 
 /*
@@ -726,7 +723,11 @@
  */
 void run_local_timers(void)
 {
-	tasklet_hi_schedule(&per_cpu(timer_tasklet, smp_processor_id()));
+	int cpu = smp_processor_id();
+	tvec_base_t *base = tvec_bases + cpu;
+
+	if ((long)(jiffies - base->timer_jiffies) >= 0)
+		tasklet_hi_schedule(&per_cpu(timer_tasklet, cpu));
 }
 
 /*
@@ -1079,6 +1080,7 @@
 		}
 		for (j = 0; j < TVR_SIZE; j++)
 			INIT_LIST_HEAD(base->tv1.vec + j);
-		tasklet_init(&per_cpu(timer_tasklet, i), run_timer_tasklet, 0);
+		tasklet_init(&per_cpu(timer_tasklet, i),
+			run_timer_tasklet, (unsigned long)base);
 	}
 }
