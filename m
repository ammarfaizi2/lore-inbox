Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264393AbUEDOmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbUEDOmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUEDOmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:42:19 -0400
Received: from fmr03.intel.com ([143.183.121.5]:61317 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262273AbUEDOmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:42:12 -0400
Date: Tue, 4 May 2004 07:40:39 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, davidm@hpl.hp.com, pj@sgi.com, linux-ia64@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [1/7]
Message-ID: <20040504074039.A1909@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew/David

Here are the next set of patches for supporting CPU hotplug. This is
officially Paul Jackson (pj@sgi.com) blessed for cpumask related issues
the earlier patch introduced. Hopefully ready for David-MT to wave the 
magic wand (blessing) for inclusion in ia64 tree :-)

Thanks to akpm for providing a test base for comments and improve the 
overall acceptability of the patch.

Due to the changes, i had to change the series (patch order) so i had generic 
changes or bug fixes before hotplug ia64.

The real changes in this patch set are really changes to cpu_present.patch.
- Removed ARCH_HAS_CPU_PRESENT_MAP
- No confusing ifdef's around for aliasing with/without hotplug for cpu_present
  and cpu_possible_map
- cpu_present_map is now declared for all architectures, and managed
  transparently for arch's that dont populate those to work seamlessly.
- Tested for hotlug on tiger4 (logical, not physical remove using echo 0 to the
  cpu control file in /sys/devices/system/cpu/cpu#/online).
- pj tested boot on SN2. (thanks for testing and a fix for booting, integrated 
  in this patch)



Name: core_kernel_init.patch
Author: Ashok Raj (Intel Corporation)
D: This patch changes __init to __devinit to init_idle so that when a new cpu
D: arrives, it can call these functions at a later time.


---

 linux-2.6.5-lhcs-root/init/main.c    |    2 +-
 linux-2.6.5-lhcs-root/kernel/sched.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~core_kernel_init kernel/sched.c
--- linux-2.6.5-lhcs/kernel/sched.c~core_kernel_init	2004-05-03 16:29:51.257858100 -0700
+++ linux-2.6.5-lhcs-root/kernel/sched.c	2004-05-03 16:29:51.261764352 -0700
@@ -2657,7 +2657,7 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
-void __init init_idle(task_t *idle, int cpu)
+void __devinit init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
 	unsigned long flags;
diff -puN init/main.c~core_kernel_init init/main.c
--- linux-2.6.5-lhcs/init/main.c~core_kernel_init	2004-05-03 16:29:51.258834663 -0700
+++ linux-2.6.5-lhcs-root/init/main.c	2004-05-03 16:29:51.261764352 -0700
@@ -181,7 +181,7 @@ EXPORT_SYMBOL(loops_per_jiffy);
    better than 1% */
 #define LPS_PREC 8
 
-void __init calibrate_delay(void)
+void __devinit calibrate_delay(void)
 {
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;

_
