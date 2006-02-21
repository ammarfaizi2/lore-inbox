Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWBUVhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWBUVhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWBUVhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:37:45 -0500
Received: from fnord.at ([217.160.110.113]:14088 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S1161051AbWBUVho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:37:44 -0500
Date: Tue, 21 Feb 2006 22:37:42 +0100
From: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Subject: [PATCH] cpufrequency change on AC-Adapter Event
Message-ID: <20060221213742.GC26413@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem Description:
Whenever the status of the AC-Adapter on my laptop changes, the CPU
frequency automatically changes as well. For example, if the AC adapter
is online my CPU has the highest frequency (3,06 GHz). When the adapter
is unplugged, the frequency automatically decreases to 1,6 GHz. However,
currently the Kernel simply doesn't notice. It looks like the system is
still running at 3,06 GHz (/proc/cpuinfo and
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq both show that),
but it doesn't like a simple test program showed.

My patch solves this problem: Whenever the status of the AC Adapter
changes, it calls 'cpufreq_reinit' which in turn reinits the CPUfreq
driver.

This, of course, only works if the ACPI AC driver is compiled in.

Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>

--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpufreq.diff"

diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/acpi/ac.c linux-2.6.15.4/drivers/acpi/ac.c
--- linux-2.6.15/drivers/acpi/ac.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/drivers/acpi/ac.c	2006-02-19 17:50:20.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/cpufreq.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
@@ -213,6 +214,8 @@
 		break;
 	}
 
+	cpufreq_reinit();
+
 	return_VOID;
 }
 
diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/cpufreq/cpufreq.c linux-2.6.15.4/drivers/cpufreq/cpufreq.c
--- linux-2.6.15/drivers/cpufreq/cpufreq.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/drivers/cpufreq/cpufreq.c	2006-02-21 20:00:06.000000000 +0100
@@ -863,6 +863,30 @@
 
 
 /**
+ * cpufreq_reinit - reinitialize CPU frequency of all CPUs
+ */
+
+int cpufreq_reinit(void)
+{
+	int cpu, ret;
+	struct cpufreq_policy *policy;
+
+	for_each_online_cpu (cpu) {
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			return -EINVAL;
+		ret = cpufreq_driver->exit(policy);
+		if (ret)
+			return ret;
+		ret = cpufreq_driver->init(policy);
+		if (ret)
+			return ret;
+	}
+	return (0);
+}
+EXPORT_SYMBOL(cpufreq_reinit);
+
+/**
  *	cpufreq_suspend - let the low level driver prepare for suspend
  */
 
--- linux-2.6.15/include/linux/cpufreq.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15.4/include/linux/cpufreq.h	2006-02-21 20:37:27.000000000 +0100
@@ -256,6 +256,11 @@
 /* query the current CPU frequency (in kHz). If zero, cpufreq couldn't detect it */
 unsigned int cpufreq_get(unsigned int cpu);
 
+#ifdef CONFIG_CPU_FREQ
+int cpu_freq_reinit(void);
+#else
+static inline int cpu_freq_reinit(void) { return 0; }
+#endif
 
 /*********************************************************************
  *                       CPUFREQ DEFAULT GOVERNOR                    *

--SkvwRMAIpAhPCcCJ--
