Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbTBNNCS>; Fri, 14 Feb 2003 08:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268403AbTBNNCQ>; Fri, 14 Feb 2003 08:02:16 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:53593
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268384AbTBNNBH>; Fri, 14 Feb 2003 08:01:07 -0500
Date: Fri, 14 Feb 2003 08:09:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Dike <jdike@karaya.com>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5][13/14] smp_call_function_on_cpu - UML
In-Reply-To: <Pine.LNX.4.50.0302140411160.3518-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0302140756500.3518-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0302140411160.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One liner to fix num_cpus == 0 on SMP kernel w/ UP box

Index: linux-2.5.60/arch/um/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/um/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60/arch/um/kernel/smp.c	10 Feb 2003 22:15:17 -0000	1.1.1.1
+++ linux-2.5.60/arch/um/kernel/smp.c	14 Feb 2003 12:59:41 -0000
@@ -255,15 +255,19 @@
 	atomic_inc(&scf_finished);
 }
 
-int smp_call_function(void (*_func)(void *info), void *_info, int nonatomic, 
-		      int wait)
+int smp_call_function_on_cpu(void (*_func)(void *info), void *_info, int wait,
+				unsigned long mask)
 {
-	int cpus = num_online_cpus() - 1;
-	int i;
+	int i, cpu, num_cpus;
 
-	if (!cpus)
+	cpu = get_cpu();
+	mask &= ~(1UL << cpu);
+	num_cpus = hweight32(mask);
+	if (num_cpus == 0) {
+		put_cpu_no_resched();
 		return 0;
-
+	}
+	
 	spin_lock_bh(&call_lock);
 	atomic_set(&scf_started, 0);
 	atomic_set(&scf_finished, 0);
@@ -271,19 +275,24 @@
 	info = _info;
 
 	for (i=0;i<NR_CPUS;i++)
-		if((i != current->thread_info->cpu) && 
-		   test_bit(i, &cpu_online_map))
+		if (cpu_online(i) && ((1UL << i) & mask))
 			write(cpu_data[i].ipi_pipe[1], "C", 1);
 
-	while (atomic_read(&scf_started) != cpus)
+	while (atomic_read(&scf_started) != num_cpus)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&scf_finished) != cpus)
+		while (atomic_read(&scf_finished) != num_cpus)
 			barrier();
 
 	spin_unlock_bh(&call_lock);
+	put_cpu_no_resched();
 	return 0;
+}
+
+int smp_call_function(void (*_func)(void *info), void *_info, int nonatomic, int wait)
+{
+	return smp_call_function_on_cpu(_func, _info, wait, cpu_online_map);
 }
 
 #endif
