Return-Path: <linux-kernel-owner+w=401wt.eu-S964894AbXABV5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbXABV5T (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754959AbXABV5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:57:19 -0500
Received: from mga07.intel.com ([143.182.124.22]:18577 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754921AbXABV5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:57:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,227,1165219200"; 
   d="scan'208"; a="164538405:sNHT25188702"
Date: Tue, 2 Jan 2007 13:27:58 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dave Jones <davej@redhat.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gautham R Shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] cpufreq lock rewrite bugfix - Fix locking in cpufreq_get
Message-ID: <20070102132758.A17649@unix-os.sc.intel.com>
References: <20061229133543.C12358@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061229133543.C12358@unix-os.sc.intel.com>; from venkatesh.pallipadi@intel.com on Fri, Dec 29, 2006 at 01:35:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incremental bugfix to previous 3 patch patchset of cpufreq lock rewrite.

There was one code path in cpufreq_get, that was using the write lock
in place of read and also potential recursive lock with sysfs
interface of cpuinfo_cur_freq.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.20-rc-mm.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.20-rc-mm/drivers/cpufreq/cpufreq.c
@@ -101,6 +101,7 @@ EXPORT_SYMBOL_GPL(unlock_policy_rwsem_wr
 
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
+static unsigned int __cpufreq_get(unsigned int cpu);
 static void handle_update(struct work_struct *work);
 
 /**
@@ -488,7 +489,7 @@ store_one(scaling_max_freq,max);
 static ssize_t show_cpuinfo_cur_freq (struct cpufreq_policy * policy,
 							char *buf)
 {
-	unsigned int cur_freq = cpufreq_get(policy->cpu);
+	unsigned int cur_freq = __cpufreq_get(policy->cpu);
 	if (!cur_freq)
 		return sprintf(buf, "<unknown>");
 	return sprintf(buf, "%u\n", cur_freq);
@@ -1074,25 +1075,13 @@ unsigned int cpufreq_quick_get(unsigned 
 EXPORT_SYMBOL(cpufreq_quick_get);
 
 
-/**
- * cpufreq_get - get the current CPU frequency (in kHz)
- * @cpu: CPU number
- *
- * Get the CPU current (static) CPU frequency
- */
-unsigned int cpufreq_get(unsigned int cpu)
+static unsigned int __cpufreq_get(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cpufreq_policy *policy = cpufreq_cpu_data[cpu];
 	unsigned int ret_freq = 0;
 
-	if (!policy)
-		return 0;
-
 	if (!cpufreq_driver->get)
-		goto out;
-
-	if (unlikely(lock_policy_rwsem_write(cpu)))
-		goto out;
+		return (ret_freq);
 
 	ret_freq = cpufreq_driver->get(cpu);
 
@@ -1106,11 +1095,32 @@ unsigned int cpufreq_get(unsigned int cp
 		}
 	}
 
-	unlock_policy_rwsem_write(cpu);
+	return (ret_freq);
+}
+
+/**
+ * cpufreq_get - get the current CPU frequency (in kHz)
+ * @cpu: CPU number
+ *
+ * Get the CPU current (static) CPU frequency
+ */
+unsigned int cpufreq_get(unsigned int cpu)
+{
+	unsigned int ret_freq = 0;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		goto out;
+
+	if (unlikely(lock_policy_rwsem_read(cpu)))
+		goto out;
+
+	ret_freq = __cpufreq_get(cpu);
+
+	unlock_policy_rwsem_read(cpu);
 
 out:
 	cpufreq_cpu_put(policy);
-
 	return (ret_freq);
 }
 EXPORT_SYMBOL(cpufreq_get);
