Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSLURg5>; Sat, 21 Dec 2002 12:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSLURg4>; Sat, 21 Dec 2002 12:36:56 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:35265 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262296AbSLURgw>; Sat, 21 Dec 2002 12:36:52 -0500
Date: Sat, 21 Dec 2002 18:41:09 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5] cpufreq: update system-wide loops_per_jiffy only on UP
Message-ID: <20021221174109.GA1149@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loops_per_jiffy should only be updated on UP systems - on SMP the CPUs might
have different such values when frequency scaling is active. On SMP it's
safest to use the default value calculated during the boot process.

	Dominik

diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2002-12-21 14:53:52.000000000 +0100
+++ linux/kernel/cpufreq.c	2002-12-21 18:20:53.000000000 +0100
@@ -936,17 +936,23 @@
  * adjust_jiffies - adjust the system "loops_per_jiffy"
  *
  * This function alters the system "loops_per_jiffy" for the clock
- * speed change. Note that loops_per_jiffy is only updated if all
- * CPUs are affected - else there is a need for per-CPU loops_per_jiffy
- * values which are provided by various architectures. 
+ * speed change. Note that loops_per_jiffy cannot be updated on SMP
+ * systems as each CPU might be scaled differently. So, use the arch 
+ * per-CPU loops_per_jiffy value wherever possible.
  */
+#ifndef CONFIG_SMP
 static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 {
 	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
 	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new))
-		if (ci->cpu == CPUFREQ_ALL_CPUS)
-			loops_per_jiffy = cpufreq_scale(loops_per_jiffy, ci->old, ci->new);
+		loops_per_jiffy = cpufreq_scale(loops_per_jiffy, ci->old, ci->new);
 }
+#else
+static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
+{
+	return;
+}
+#endif
 
 
 /**

