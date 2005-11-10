Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVKJPng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVKJPng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 10:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVKJPng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 10:43:36 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:45729 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S1751073AbVKJPnf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 10:43:35 -0500
Date: Thu, 10 Nov 2005 15:11:11 +0000
From: Alexander Clouter <alex-kernel@digriz.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: davej@redhat.com, davej@codemonkey.org.uk, blaisorblade@yahoo.it
Subject: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051110151111.GA16994@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The use of the 'ignore_nice' sysfs file is confusing to anyone using it.  
This removes the sysfs file 'ignore_nice' and in its place creates a 
'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes are 
not counted towards the 'business' caclulation.

WARNING: this obvious breaks any userland tools that expected 'ignore_nice' 
to exist, to draw attention to this fact it was concluded on the mailing list 
that the entry should be removed altogether so the userland app breaks and so 
the author can build simple to detect workaround.  Having said that it seems 
currently very few tools even make use of this functionality; all I could 
find was a Gentoo Wiki entry.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_inverse_ignore_nice_flag.diff"

diff -r -u -d linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_conservative.c \
                linux-2.6.14-rc2/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_conservative.c	2005-10-03 \
                20:05:30.742334750 +0100
+++ linux-2.6.14-rc2/drivers/cpufreq/cpufreq_conservative.c	2005-10-06 \
21:10:47.785133750 +0100 @@ -93,7 +93,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ? 
+		( dbs_tuners_ins.ignore_nice ? 
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -127,7 +127,7 @@
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
 show_one(down_threshold, down_threshold);
-show_one(ignore_nice, ignore_nice);
+show_one(ignore_nice_load, ignore_nice);
 show_one(freq_step, freq_step);
 
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused, 
@@ -207,7 +207,7 @@
 	return count;
 }
 
-static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+static ssize_t store_ignore_nice_load(struct cpufreq_policy *policy,
 		const char *buf, size_t count)
 {
 	unsigned int input;
@@ -272,7 +272,7 @@
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
-define_one_rw(ignore_nice);
+define_one_rw(ignore_nice_load);
 define_one_rw(freq_step);
 
 static struct attribute * dbs_attributes[] = {
@@ -282,7 +282,7 @@
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
 	&down_threshold.attr,
-	&ignore_nice.attr,
+	&ignore_nice_load.attr,
 	&freq_step.attr,
 	NULL
 };
@@ -515,7 +515,7 @@
 			def_sampling_rate = (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate = def_sampling_rate;
-			dbs_tuners_ins.ignore_nice = 0;
+			dbs_tuners_ins.ignore_nice = 1;
 			dbs_tuners_ins.freq_step = 5;
 
 			dbs_timer_init();
diff -r -u -d linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_ondemand.c \
                linux-2.6.14-rc2/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.14-rc2.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-10-03 \
                20:05:30.742334750 +0100
+++ linux-2.6.14-rc2/drivers/cpufreq/cpufreq_ondemand.c	2005-10-06 21:10:23.979646000 \
+0100 @@ -86,7 +86,7 @@
 {
 	return	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( !dbs_tuners_ins.ignore_nice ? 
+		( dbs_tuners_ins.ignore_nice ? 
 		  kstat_cpu(cpu).cpustat.nice :
 		  0);
 }
@@ -119,7 +119,7 @@
 show_one(sampling_rate, sampling_rate);
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
-show_one(ignore_nice, ignore_nice);
+show_one(ignore_nice_load, ignore_nice);
 
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused, 
 		const char *buf, size_t count)
@@ -179,7 +179,7 @@
 	return count;
 }
 
-static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+static ssize_t store_ignore_load_tasks(struct cpufreq_policy *policy,
 		const char *buf, size_t count)
 {
 	unsigned int input;
@@ -220,7 +220,7 @@
 define_one_rw(sampling_rate);
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
-define_one_rw(ignore_nice);
+define_one_rw(ignore_nice_load);
 
 static struct attribute * dbs_attributes[] = {
 	&sampling_rate_max.attr,
@@ -228,7 +228,7 @@
 	&sampling_rate.attr,
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
-	&ignore_nice.attr,
+	&ignore_nice_load.attr,
 	NULL
 };
 
@@ -424,7 +424,7 @@
 			def_sampling_rate = (latency / 1000) *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
 			dbs_tuners_ins.sampling_rate = def_sampling_rate;
-			dbs_tuners_ins.ignore_nice = 0;
+			dbs_tuners_ins.ignore_nice = 1;
 
 			dbs_timer_init();
 		}

--u3/rZRmxL6MmkK24--
