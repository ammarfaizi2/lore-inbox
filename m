Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUFJW5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUFJW5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUFJW5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:57:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:46552 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263167AbUFJW5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:57:15 -0400
Date: Thu, 10 Jun 2004 15:56:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Performance degredation with latest scheduler code
Message-ID: <337010000.1086908187@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something messed with the sched peformance between the last copy I picked 
up (2.6.5_rc3_mm1) and the stuff that got checked into mainline. I lose
about 17% througput on SDET at high loads, though it's slightly better at
VERY low loads (less processes than nodes). (OK, I'm kind of *assuming*
it's the scheduler, though that seems like by far the most obvious candidate)

Kernbench is worse at lower loads (processes ~= 2x CPUs)

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
           2.6.6-rc3-mjb3       44.90       79.80      586.18     1483.67
           2.6.7-rc1-mjb1       45.34      101.04      574.67     1489.00

But actually a bit better at very high loads ...

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
           2.6.6-rc3-mjb3       45.56       91.59      590.72     1497.67
           2.6.7-rc1-mjb1       44.24       89.98      574.73     1503.33

Diffprofile for kernbench (lower load)

     14605    11.2% total
      6027   154.2% __copy_from_user_ll
      2908    64.8% __copy_to_user_ll
      2148   241.6% finish_task_switch
      1441   248.0% __wake_up
...
     -1714    -3.4% default_idle
     -1962   -11.5% do_anonymous_page

What the hell happened there? I'd guess it's the balance on wake stuff,
but removing it doesn't seem to help ... this was the part of the diff
I did to try to revert stuff, which didn't help:



--- 2.6.7-rc1/include/linux/sched.h     2004-05-27 16:22:38.000000000 -0700
+++ 2.6.7-rc1-fixsched/include/linux/sched.h    2004-06-10 09:43:03.000000000 -0700
@@ -630,10 +630,7 @@ struct sched_domain {
        .cache_nice_tries       = 1,                    \
        .per_cpu_gain           = 100,                  \
        .flags                  = SD_BALANCE_NEWIDLE    \
-                               | SD_BALANCE_EXEC       \
-                               | SD_BALANCE_CLONE      \
-                               | SD_WAKE_AFFINE        \
-                               | SD_WAKE_BALANCE,      \
+                               | SD_WAKE_AFFINE,       \
        .last_balance           = jiffies,              \
        .balance_interval       = 1,                    \
        .nr_balance_failed      = 0,                    \
@@ -646,15 +643,13 @@ struct sched_domain {
        .parent                 = NULL,                 \
        .groups                 = NULL,                 \
        .min_interval           = 8,                    \
-       .max_interval           = 32,                   \
+       .max_interval           = 256*fls(num_online_cpus()),\
        .busy_factor            = 32,                   \
        .imbalance_pct          = 125,                  \
        .cache_hot_time         = (10*1000000),         \
        .cache_nice_tries       = 1,                    \
        .per_cpu_gain           = 100,                  \
-       .flags                  = SD_BALANCE_EXEC       \
-                               | SD_BALANCE_CLONE      \
-                               | SD_WAKE_BALANCE,      \
+       .flags                  = SD_BALANCE_EXEC,      \
        .last_balance           = jiffies,              \
        .balance_interval       = 1,                    \
        .nr_balance_failed      = 0,                    \

