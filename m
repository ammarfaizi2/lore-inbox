Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWCSCjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWCSCjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWCSCia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:38:30 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:20125 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751358AbWCSCiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:38:10 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm2 uninitialized online_policy_cpus.bits[0]
Date: Sun, 19 Mar 2006 13:37:08 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
References: <20060318044056.350a2931.akpm@osdl.org> <200603191209.54946.kernel@kolivas.org> <20060318173512.313a3453.akpm@osdl.org>
In-Reply-To: <20060318173512.313a3453.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603191337.08942.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 March 2006 12:35, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Wonder if this is related to rc6's oops?
> >  gcc 4.0.3
> >
> >    CC [M]  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o
> >  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c: In function
> >  'centrino_target':
> >  include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is
> > used uninitialized in this function
> >    CC [M]  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o
> >  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c: In function
> >  'acpi_cpufreq_target':
> >  include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is
> > used uninitialized in this function
>
> Well conceivably.  That warning is a consequence of my quick hack to make
> the ACPI tree compile on uniprocessor.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.
>6.16-rc6-mm2/broken-out/git-acpi-up-fix.patch
>
> My patch is, as the compiler points out, wrong.
>
> I've sent that patch two or three times to the APCI maintainers, to the
> ACPI mailing list and to the author of the original buggy patch.  The
> response thus far has been dead silence.

Well this will end up being the wrong place to do it but I needed it to work
 now so this patch fixes it for me. Dunno what else it will break. Works on
a couple of configs fine.

Cheers,
Con
---
Hacky workaround for cpu_online_map not being defined

 arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c       |    2 --
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    2 --
 kernel/sched.c                                    |    4 ++++
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-19 11:15:05.000000000 +1100
+++ linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-19 12:45:56.000000000 +1100
@@ -225,10 +225,8 @@ acpi_cpufreq_target (
 	freqs.old = data->freq_table[cur_state].frequency;
 	freqs.new = data->freq_table[next_state].frequency;
 
-#ifdef CONFIG_SMP
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
-#endif
 
 	for_each_cpu_mask(j, online_policy_cpus) {
 		freqs.cpu = j;
Index: linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-19 11:15:05.000000000 +1100
+++ linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-19 12:45:42.000000000 +1100
@@ -652,10 +652,8 @@ static int centrino_target (struct cpufr
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_SMP
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
-#endif
 
 	saved_mask = current->cpus_allowed;
 	first_cpu = 1;
Index: linux-2.6.16-rc6-mm2/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/sched.c	2006-03-19 13:25:25.000000000 +1100
+++ linux-2.6.16-rc6-mm2/kernel/sched.c	2006-03-19 13:25:36.000000000 +1100
@@ -6366,6 +6366,10 @@ void __init sched_init_smp(void)
 	init_sched_domain_sysctl();
 }
 #else
+/* bitmap of online cpus */
+cpumask_t cpu_online_map __read_mostly;
+EXPORT_SYMBOL(cpu_online_map);
+
 void __init sched_init_smp(void)
 {
 }
