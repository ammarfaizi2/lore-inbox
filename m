Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272576AbRI3FpJ>; Sun, 30 Sep 2001 01:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272588AbRI3FpA>; Sun, 30 Sep 2001 01:45:00 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:32386 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272576AbRI3Fot>; Sun, 30 Sep 2001 01:44:49 -0400
Date: Sat, 29 Sep 2001 22:50:09 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>
Subject: [patch] Race between init_idle and reschedule_idle
Message-ID: <1076429074.1001803809@[10.10.1.2]>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an SMP system, if the boot cpu calls reschedule_idle before the
secondary cpus have all called init_idle, we hit the following code
in reschedule_idle:

...
    for (i = 0; i < smp_num_cpus; i++) {
        cpu = cpu_logical_map(i);
        if (!can_schedule(p, cpu))
            continue;
        tsk = cpu_curr(cpu);
...

Because init_idle hasn't run for all cpus yet, the expression 
"cpu_curr(cpu)"
gives us NULL. When we derefernce an offset of 0x50 off tsk a few
nanoseconds later we panic, complaining vaddr 0x00000050 is invalid.

This is more likely to happen on larger systems, but could happen on any
SMP system (especially if I enable serial console, which really slows down
the secondary procs doing printk ;-) ). If you want to see the panic / 
analysis,
I can send it.

Thanks to Alan Cox & Andrew Morton for showing me how to serialise the
cpus to make the panic legible. The following patch holds back the boot
cpu at the end of smp_init until all the secondarys have done init_idle:

--- virgin-2.4.10/kernel/sched.c	Mon Sep 17 23:03:09 2001
+++ linux-2.4.10/kernel/sched.c	Sat Sep 29 19:57:10 2001
@@ -1309,6 +1309,8 @@
 	atomic_inc(&current->files->count);
 }

+extern volatile unsigned long wait_init_idle;
+
 void __init init_idle(void)
 {
 	struct schedule_data * sched_data;
@@ -1321,6 +1323,7 @@
 	}
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
+	clear_bit(current->processor, &wait_init_idle);
 }

 extern void init_timervecs (void);
--- virgin-2.4.10/init/main.c	Thu Sep 20 21:02:01 2001
+++ linux-2.4.10/init/main.c	Sat Sep 29 21:11:52 2001
@@ -477,6 +477,8 @@
 extern void setup_arch(char **);
 extern void cpu_idle(void);

+volatile unsigned long wait_init_idle = 0UL;
+
 #ifndef CONFIG_SMP

 #ifdef CONFIG_X86_IO_APIC
@@ -490,13 +492,25 @@

 #else

+
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
 {
 	/* Get other processors into their bootup holding patterns. */
 	smp_boot_cpus();
+	wait_init_idle = cpu_online_map;
+	clear_bit(current->processor, &wait_init_idle); /* Don't wait on me! */
+	printk("Waiting on wait_init_idle (map = 0x%lx)\n", wait_init_idle);
 	smp_threads_ready=1;
 	smp_commence();
+
+	/* Wait for the other cpus to set up their idle processes */
+        while (1) {
+                if (!wait_init_idle)
+                        break;
+                rep_nop();
+        }
+	printk("All processors have done init_idle\n");
 }		

 #endif



