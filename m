Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132971AbRDKTat>; Wed, 11 Apr 2001 15:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132968AbRDKTak>; Wed, 11 Apr 2001 15:30:40 -0400
Received: from [32.97.182.101] ([32.97.182.101]:31433 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S132971AbRDKTah>;
	Wed, 11 Apr 2001 15:30:37 -0400
Importance: Normal
Subject: Bug in sys_sched_yield
To: <mingo@elte.hu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        <lse-tech@lists.sourceforge.net>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFC3243AAE.31877E4B-ON85256A2B.006AE9C3@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 11 Apr 2001 15:31:37 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/11/2001 03:30:21 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In the recent optimizations to sys_sched_yield a bug was introduced.
In the current implementation of sys_sched_yield()
the aligned_data and idle_tasks are indexed by logical cpu-#.

They should however be indexed by physical cpu-#.
Since logical==physical on the x86 platform, it doesn't matter there,
for other platforms where this is not true it will matter.
Below is the fix.


diff -uwrbBN linux-2.4.3/kernel/sched.c linux-2.4.3-fix/kernel/sched.c
--- linux-2.4.3/kernel/sched.c     Thu Mar 22 12:20:45 2001
+++ linux-2.4.3-fix/kernel/sched.c Wed Apr 11 11:27:16 2001
@@ -1024,9 +1024,11 @@
     int i;

     // Substract non-idle processes running on other CPUs.
-    for (i = 0; i < smp_num_cpus; i++)
-         if (aligned_data[i].schedule_data.curr != idle_task(i))
+    for (i = 0; i < smp_num_cpus; i++) {
+         int cpu = cpu_logical_map(i);
+         if (aligned_data[cpu].schedule_data.curr != idle_task(cpu))
               nr_pending--;
+    }
 #else
     // on UP this process is on the runqueue as well
     nr_pending--;

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)

email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003




