Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261788AbSJIPlE>; Wed, 9 Oct 2002 11:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSJIPlE>; Wed, 9 Oct 2002 11:41:04 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:45870 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261788AbSJIPlA>; Wed, 9 Oct 2002 11:41:00 -0400
Date: Wed, 9 Oct 2002 17:34:39 +0200
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH][2.5.] cpufreq: parallel use of /proc/sys/cpu/ and /proc/cpufreq interfaces
Message-ID: <20021009173439.A926@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both the deprecated /proc/sys/cpu/ interface, and the new policy-based
/proc/cpufreq interface can work nicely in the same kernel. 

	Dominik

--- /usr/src/linux/kernel/cpufreq.c	Wed Oct  9 00:50:41 2002
+++ linux/kernel/cpufreq.c	Tue Oct  8 16:54:23 2002
@@ -4,7 +4,7 @@
  *  Copyright (C) 2001 Russell King
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *
- *  $Id: cpufreq.c,v 1.43 2002/09/21 09:05:29 db Exp $
+ *  $Id: cpufreq.c,v 1.45 2002/10/08 14:54:23 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,13 +21,10 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/ctype.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_CPU_FREQ_26_API
-#include <linux/proc_fs.h>
-#endif
-
 #ifdef CONFIG_CPU_FREQ_24_API
 #include <linux/sysctl.h>
 #endif
@@ -200,7 +197,6 @@
 __setup("cpufreq=", cpufreq_setup);
 
 
-#ifdef CONFIG_CPU_FREQ_26_API
 #ifdef CONFIG_PROC_FS
 
 /**
@@ -335,7 +331,6 @@
 	return;
 }
 #endif /* CONFIG_PROC_FS */
-#endif /* CONFIG_CPU_FREQ_26_API */
 
 
 
@@ -344,10 +339,6 @@
  *********************************************************************/
 
 #ifdef CONFIG_CPU_FREQ_24_API
-/* NOTE #1: when you use this API, you may not use any other calls,
- * except cpufreq_[un]register_notifier, of course.
- */
-
 /** 
  * cpufreq_set - set the CPU frequency
  * @freq: target frequency in kHz
@@ -879,7 +870,7 @@
 		cpufreq_driver->policy[policy->cpu].max    = policy->max;
 		cpufreq_driver->policy[policy->cpu].policy = policy->policy;
 	}
-	
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	if (policy->cpu == CPUFREQ_ALL_CPUS) {
 		for (i=0;i<NR_CPUS;i++)
@@ -945,6 +936,13 @@
 	case CPUFREQ_POSTCHANGE:
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANGE, freqs);
+#ifdef CONFIG_CPU_FREQ_24_API
+		if (freqs->cpu == CPUFREQ_ALL_CPUS) {
+			for (i=0;i<NR_CPUS;i++)
+				cpu_cur_freq[i] = freqs->new;
+		} else
+			cpu_cur_freq[freqs->cpu] = freqs->new;
+#endif
 		break;
 	}
 	up(&cpufreq_notifier_sem);
@@ -992,9 +990,7 @@
 
 	ret = cpufreq_set_policy(&default_policy);
 
-#ifdef CONFIG_CPU_FREQ_26_API
 	cpufreq_proc_init();
-#endif
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	down(&cpufreq_driver_sem);
@@ -1042,9 +1038,7 @@
 
 	up(&cpufreq_driver_sem);
 
-#ifdef CONFIG_CPU_FREQ_26_API
 	cpufreq_proc_exit();
-#endif
 
 #ifdef CONFIG_CPU_FREQ_24_API
 	cpufreq_sysctl_exit();
@@ -1086,13 +1080,7 @@
 		policy.cpu    = i;
 		up(&cpufreq_driver_sem);
 
-#ifdef CONFIG_CPU_FREQ_26_API
 		cpufreq_set_policy(&policy);
-#endif
-
-#ifdef CONFIG_CPU_FREQ_24_API
-		cpufreq_set(cpu_cur_freq[i], i);
-#endif
 	}
 
 	return 0;
--- /usr/src/linux/include/linux/cpufreq.h	Wed Oct  9 00:50:41 2002
+++ linux/include/linux/cpufreq.h	Tue Oct  8 16:54:23 2002
@@ -5,7 +5,7 @@
  *            (C) 2002 Dominik Brodowski <linux@brodo.de>
  *            
  *
- * $Id: cpufreq.h,v 1.26 2002/09/21 09:05:29 db Exp $
+ * $Id: cpufreq.h,v 1.27 2002/10/08 14:54:23 db Exp $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -148,11 +148,9 @@
 int cpufreq_set_policy(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 
-#ifdef CONFIG_CPU_FREQ_26_API
 #ifdef CONFIG_PM
 int cpufreq_restore(void);
 #endif
-#endif
 
 
 #ifdef CONFIG_CPU_FREQ_24_API
@@ -160,9 +158,6 @@
  *                        CPUFREQ 2.4. INTERFACE                     *
  *********************************************************************/
 int cpufreq_setmax(unsigned int cpu);
-#ifdef CONFIG_PM
-int cpufreq_restore(void);
-#endif
 int cpufreq_set(unsigned int kHz, unsigned int cpu);
 unsigned int cpufreq_get(unsigned int cpu);
 
--- linux/arch/i386/Config.help.original	Tue Oct  8 16:09:36 2002
+++ linux/arch/i386/Config.help	Tue Oct  8 16:12:02 2002
@@ -852,12 +852,10 @@
 
 CONFIG_CPU_FREQ_24_API
   This enables the /proc/sys/cpu/ sysctl interface for controlling
-  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. Note
-  that some drivers do not support this interface or offer less
-  functionality. 
-
-  If you say N here, you'll be able to control CPUFreq using the
-  new /proc/cpufreq interface.
+  CPUFreq, as known from the 2.4.-kernel patches for CPUFreq. 2.5
+  uses /proc/cpufreq instead. Please note that some drivers do not 
+  work with the 2.4. /proc/sys/cpu sysctl interface, so if in doubt,
+  say N here.
 
   For details, take a look at linux/Documentation/cpufreq. 
 
--- linux/arch/i386/config.in.original	Tue Oct  8 16:09:43 2002
+++ linux/arch/i386/config.in	Tue Oct  8 16:12:49 2002
@@ -192,10 +192,7 @@
 
 bool 'CPU Frequency scaling' CONFIG_CPU_FREQ
 if [ "$CONFIG_CPU_FREQ" = "y" ]; then
-   bool ' /proc/sys/cpu/ interface (2.4.)' CONFIG_CPU_FREQ_24_API
-   if [ "$CONFIG_CPU_FREQ_24_API" = "n" ]; then
-       define_bool CONFIG_CPU_FREQ_26_API y
-   fi
+   bool ' /proc/sys/cpu/ interface (2.4. / OLD)' CONFIG_CPU_FREQ_24_API
    tristate ' AMD Mobile K6-2/K6-3 PowerNow!' CONFIG_X86_POWERNOW_K6
    if [ "$CONFIG_MELAN" = "y" ]; then
        tristate ' AMD Elan' CONFIG_ELAN_CPUFREQ
