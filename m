Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933011AbWFZUNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011AbWFZUNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933013AbWFZUNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 16:13:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39843 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S933011AbWFZUNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 16:13:19 -0400
Subject: Re: 2.6.17-mm2
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, davej@redhat.com,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060625032243.fcce9e2e.akpm@osdl.org>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <20060624172014.GB26273@redhat.com> <20060624143440.0931b4f1.akpm@osdl.org>
	 <200606251051.55355.rjw@sisk.pl>  <20060625032243.fcce9e2e.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Mon, 26 Jun 2006 13:13:16 -0700
Message-Id: <1151352796.27807.22.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 03:22 -0700, Andrew Morton wrote:

> Chandra, this is scary stuff.  I'll tempdrop those patches until we can get
> the kbuild/modprobe infrastructure in place which will allow us to fully
> check your sectioning changes at depmod/modprobe time.
> 
> <thinks>
> 
> Actually, it should still be possible to do this - simply do a `make
> allyesconfig; make' with the patches unapplied, then do it with the patches
> applied and then look for the differences in the warnings.

Andrew, 

After looking at the code closely, IMO, the patch you applied om -mm
(title cpufreq_register_driver-section-fix) seem to be in the right
direction.

It does need another patch to make sure the hotplug version of the cpu
notifier register/unregister is used in cpufreq.

Below is a patch.
> 
> Need to do this with various combinations of CONFIG_MODULES,
> CONFIG_HOTPLUG, CONFIG_HOTPLUG_CPU, CONFIG_MEMORY_HOTPLUG,
> CONFIG_ACPI_HOTPLUG_MEMORY and CONFIG_ACPI_HOTPLUG_MEMORY_MODULE.

I will test these combinations.
---------------------


cpufreq_register_driver() has to made available at all time (not init
only). Hence, we should be using hotplug version of the cpu notifier
register/unregister function instead of the _init time only_ version.

Signed-off-by: Chandra Seetharaman <sekharan@us.ibm.com>
--
 drivers/cpufreq/cpufreq.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6.17/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.17.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.17/drivers/cpufreq/cpufreq.c
@@ -1497,7 +1497,8 @@ int cpufreq_update_policy(unsigned int c
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
-static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
+#ifdef CONFIG_HOTPLUG_CPU
+static int cpufreq_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
@@ -1536,6 +1537,7 @@ static struct notifier_block __cpuinitda
 {
     .notifier_call = cpufreq_cpu_callback,
 };
+#endif /* CONFIG_HOTPLUG_CPU */
 
 /*********************************************************************
  *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
@@ -1596,7 +1598,7 @@ int cpufreq_register_driver(struct cpufr
 	}
 
 	if (!ret) {
-		register_cpu_notifier(&cpufreq_cpu_notifier);
+		register_hotcpu_notifier(&cpufreq_cpu_notifier);
 		dprintk("driver %s up and running\n", driver_data->name);
 		cpufreq_debug_enable_ratelimit();
 	}
@@ -1628,7 +1630,7 @@ int cpufreq_unregister_driver(struct cpu
 	dprintk("unregistering driver %s\n", driver->name);
 
 	sysdev_driver_unregister(&cpu_sysdev_class, &cpufreq_sysdev_driver);
-	unregister_cpu_notifier(&cpufreq_cpu_notifier);
+	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
 	spin_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


