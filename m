Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTAVFkY>; Wed, 22 Jan 2003 00:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTAVFkY>; Wed, 22 Jan 2003 00:40:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:27397
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267049AbTAVFkX>; Wed, 22 Jan 2003 00:40:23 -0500
Date: Wed, 22 Jan 2003 00:49:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Dike <jdike@karaya.com>
Subject: [PATCH][2.5][16/18] smp_call_function_on_cpu - uml
Message-ID: <Pine.LNX.4.44.0301220048500.29944-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one might need eyeballing...

Index: linux-2.5.59/arch/um/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59/arch/um/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59/arch/um/kernel/smp.c	17 Jan 2003 11:14:54 -0000	1.1.1.1
+++ linux-2.5.59/arch/um/kernel/smp.c	22 Jan 2003 02:19:28 -0000
@@ -254,8 +254,43 @@
 	atomic_inc(&scf_finished);
 }
 
-int smp_call_function(void (*_func)(void *info), void *_info, int nonatomic, 
-		      int wait)
+int smp_call_function_on_cpu(void (*_func)(void *info), void *_info, int wait,
+				unsigned long mask)
+{
+	int i, cpu, num_cpus = hweight32(mask);
+
+	if (num_cpus == 0)
+		return 0;
+
+	cpu = get_cpu();
+	if ((1UL << cpu) && mask) {
+		put_cpu_no_resched();
+		return 0;
+	}
+	
+	spin_lock_bh(&call_lock);
+	atomic_set(&scf_started, 0);
+	atomic_set(&scf_finished, 0);
+	func = _func;
+	info = _info;
+
+	for (i=0;i<NR_CPUS;i++)
+		if (cpu_online(i) && ((1UL << i) & mask))
+			write(cpu_data[i].ipi_pipe[1], "C", 1);
+
+	while (atomic_read(&scf_started) != num_cpus)
+		barrier();
+
+	if (wait)
+		while (atomic_read(&scf_finished) != num_cpus)
+			barrier();
+
+	spin_unlock_bh(&call_lock);
+	put_cpu_no_resched();
+	return 0;
+}
+
+int smp_call_function(void (*_func)(void *info), void *_info, int wait)
 {
 	int cpus = num_online_cpus() - 1;
 	int i;

-- 
function.linuxpower.ca


