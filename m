Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSHAOrc>; Thu, 1 Aug 2002 10:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSHAOrc>; Thu, 1 Aug 2002 10:47:32 -0400
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:56501 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S315285AbSHAOrb>; Thu, 1 Aug 2002 10:47:31 -0400
Date: Thu, 1 Aug 2002 16:46:49 +0200
From: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: While in irq, who must be charged for a tick?
Message-ID: <20020801144649.GG414@hookipa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: return path set from From: address
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand why a tick is charged to the current process when the
timer interrupt occurs while in hardirq or softirq context. There's
great chance that the hardirq or softirq is not serving 'current'.

Here's what I would do:

--- kernel/timer.c.orig Thu Aug  1 16:08:36 2002
+++ kernel/timer.c      Thu Aug  1 16:09:51 2002
@@ -582,7 +582,9 @@
        int cpu = smp_processor_id(), system = user_tick ^ 1;
 
        update_one_process(p, user_tick, system, cpu);
-       if (p->pid) {
+       if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
+               kstat.per_cpu_system[cpu] += system;
+       else if (p->pid) {
                if (--p->counter <= 0) {
                        p->counter = 0;
                        p->need_resched = 1;
@@ -593,8 +595,7 @@
                        kstat.per_cpu_user[cpu] += user_tick;
 
                kstat.per_cpu_system[cpu] += system;
-       } else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
-               kstat.per_cpu_system[cpu] += system;
+       }
 }
 
 /*

[This is against 2.4.18-vanilla]

I'm certainly missing the point here. Please tell me where I'm wrong.

THX.
-- 
Eric
