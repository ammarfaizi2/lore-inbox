Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTBIMI6>; Sun, 9 Feb 2003 07:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTBIMIk>; Sun, 9 Feb 2003 07:08:40 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:10320
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267229AbTBIL7l>; Sun, 9 Feb 2003 06:59:41 -0500
Date: Sun, 9 Feb 2003 07:08:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5][13/15] smp_call_function/_on_cpu - uml
Message-ID: <Pine.LNX.4.50.0302090656150.2812-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 smp.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 37 insertions(+), 2 deletions(-)

Index: linux-2.5.59-bk/arch/um/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.59-bk/arch/um/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.59-bk/arch/um/kernel/smp.c	9 Feb 2003 09:08:37 -0000	1.1.1.1
+++ linux-2.5.59-bk/arch/um/kernel/smp.c	9 Feb 2003 09:23:30 -0000
@@ -255,8 +255,43 @@
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
