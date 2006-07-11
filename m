Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWGKNcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWGKNcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWGKNcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:32:50 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:48863 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750763AbWGKNct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:32:49 -0400
Date: Tue, 11 Jul 2006 06:24:22 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] i386 adds smp_call_function_single
Message-ID: <20060711132422.GB28851@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Continiung the series of small patches necessary for the perfmon subsystem, here
is a patch that adds support for the smp_call_function_single() function for i386.
It exists for almost all other architectures but i386. The perfmon subsystem
needs it in one case to free some state on a designated remote CPU.

Changelog:
	- adds smp_call_function_single() to i386 tree. This function
	  is used to invoked a procedure on a designated remote CPU.

<signed-off-by>: eranian@hpl.hp.com

diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -634,3 +634,69 @@ fastcall void smp_call_function_interrup
 	}
 }
 
+/*
+ * this function sends a 'generic call function' IPI to one other CPU
+ * in the system.
+ *
+ * cpu is a standard Linux logical CPU number.
+ */
+static void
+__smp_call_function_single(int cpu, void (*func) (void *info), void *info,
+				int nonatomic, int wait)
+{
+	struct call_data_struct data;
+	int cpus = 1;
+  
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	call_data = &data;
+	wmb();
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_mask(cpumask_of_cpu(cpu), CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != cpus)
+		cpu_relax();
+
+	if (!wait)
+		return;
+
+	while (atomic_read(&data.finished) != cpus)
+		cpu_relax();
+}
+
+/*
+ * smp_call_function_single - Run a function on another CPU
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @nonatomic: Currently unused.
+ * @wait: If true, wait until function has completed on other CPUs.
+ *
+ * Retrurns 0 on success, else a negative status code.
+ *
+ * Does not return until the remote CPU is nearly ready to execute <func>
+ * or is or has executed.
+ */
+
+int smp_call_function_single (int cpu, void (*func) (void *info), void *info,
+	int nonatomic, int wait)
+{
+	/* prevent preemption and reschedule on another processor */
+	int me = get_cpu();
+	if (cpu == me) {
+		WARN_ON(1);
+		put_cpu();
+		return -EBUSY;
+	}
+	spin_lock_bh(&call_lock);
+	__smp_call_function_single(cpu, func, info, nonatomic, wait);
+	spin_unlock_bh(&call_lock);
+	put_cpu();
+	return 0;
+}
+EXPORT_SYMBOL(smp_call_function_single);
