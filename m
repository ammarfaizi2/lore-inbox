Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSFWUNP>; Sun, 23 Jun 2002 16:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSFWUNO>; Sun, 23 Jun 2002 16:13:14 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:15791 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317102AbSFWUNK>;
	Sun, 23 Jun 2002 16:13:10 -0400
Date: Sun, 23 Jun 2002 15:09:50 -0500
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, mingo@elte.hu
Subject: [PATCH] Allow non zero boot cpu
Message-ID: <20020623200950.GA20641@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

A partitioned ppc64 machine can have a boot cpuid anywhere from 0 to 31.
With the non linear cpu changes in 2.5.24 we must set up the initial task
to start on the boot cpu. (since it isnt always 0 now)

With this patch I am able to boot on cpus other than 0. I also tested
discontiguous cpuids:

# cat /proc/cpuinfo 
processor       : 2
cpu             : RS64-IV (sstar)
clock           : 601MHz
revision        : 0.0

processor       : 4
cpu             : RS64-IV (sstar)
clock           : 601MHz
revision        : 0.0

processor       : 6
cpu             : RS64-IV (sstar)
clock           : 601MHz
revision        : 0.0

timebase        : 601583219
machine         : CHRP IBM,7025-F80

So the non linear cpu stuff checks out OK. Nice work Rusty!

Anton

===== kernel/sched.c 1.101 vs edited =====
--- 1.101/kernel/sched.c	Thu Jun 20 23:25:50 2002
+++ edited/kernel/sched.c	Mon Jun 24 05:14:11 2002
@@ -1687,6 +1688,7 @@
 	rq = this_rq();
 	rq->curr = current;
 	rq->idle = current;
+	set_task_cpu(current, smp_processor_id());
 	wake_up_process(current);
 
 	init_timervecs();
