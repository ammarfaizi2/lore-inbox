Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSKIJ6G>; Sat, 9 Nov 2002 04:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbSKIJ6G>; Sat, 9 Nov 2002 04:58:06 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64463 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264679AbSKIJ6F>;
	Sat, 9 Nov 2002 04:58:05 -0500
Date: Sat, 9 Nov 2002 15:36:34 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] get/put_cpu in up need not disable preemption
Message-ID: <20021109153634.M2298@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS, get_cpu, put_cpu and put_cpu_no_resched need not disable 
preemption on a uniprocessor. Foll patch removes the disable/enable
premeption stuff for the UP case.  Tested on a PIII 4 way for both
UP and SMP configs. Pls apply.

Thanks,
Kiran


diff -ruN -X dontdiff linux-2.5.46/include/linux/smp.h get_cpu-2.5.46/include/linux/smp.h
--- linux-2.5.46/include/linux/smp.h	Tue Nov  5 04:00:31 2002
+++ get_cpu-2.5.46/include/linux/smp.h	Sat Nov  9 12:27:46 2002
@@ -78,6 +78,11 @@
 extern void unregister_cpu_notifier(struct notifier_block *nb);
 
 int cpu_up(unsigned int cpu);
+
+#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
+#define put_cpu()		preempt_enable()
+#define put_cpu_no_resched()	preempt_enable_no_resched()
+
 #else /* !SMP */
 
 /*
@@ -106,10 +111,11 @@
 static inline void unregister_cpu_notifier(struct notifier_block *nb)
 {
 }
-#endif /* !SMP */
 
-#define get_cpu()		({ preempt_disable(); smp_processor_id(); })
-#define put_cpu()		preempt_enable()
-#define put_cpu_no_resched()	preempt_enable_no_resched()
+#define get_cpu()		smp_processor_id()
+#define put_cpu()		do { } while (0)
+#define put_cpu_no_resched()	do { } while (0)
+
+#endif /* !SMP */
 
 #endif /* __LINUX_SMP_H */
