Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWCSGN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWCSGN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 01:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCSGN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 01:13:58 -0500
Received: from fmr22.intel.com ([143.183.121.14]:6295 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750992AbWCSGN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 01:13:57 -0500
Date: Sat, 18 Mar 2006 22:13:42 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2 uninitialized online_policy_cpus.bits[0]
Message-ID: <20060318221342.A9304@unix-os.sc.intel.com>
References: <20060318044056.350a2931.akpm@osdl.org> <200603191209.54946.kernel@kolivas.org> <20060318173512.313a3453.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060318173512.313a3453.akpm@osdl.org>; from akpm@osdl.org on Sat, Mar 18, 2006 at 05:35:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 05:35:12PM -0800, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> >
> > Wonder if this is related to rc6's oops?
> >  gcc 4.0.3
> > 
> >    CC [M]  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.o
> >  arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c: In function 
> >  'centrino_target':
> >  include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is used 
> >  uninitialized in this function
> >    CC [M]  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.o
> >  arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c: In function 
> >  'acpi_cpufreq_target':
> >  include/linux/bitmap.h:170: warning: 'online_policy_cpus.bits[0]' is used 
> >  uninitialized in this function
> 
> Well conceivably.  That warning is a consequence of my quick hack to make
> the ACPI tree compile on uniprocessor.
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm2/broken-out/git-acpi-up-fix.patch
> 
> My patch is, as the compiler points out, wrong.
> 
> I've sent that patch two or three times to the APCI maintainers, to the
> ACPI mailing list and to the author of the original buggy patch.  The
> response thus far has been dead silence.
> 
> IOW, despite my efforts, the ACPI tree has been in a non-compiling state on
> uniprocessor since February 11.
> 
> This is pathetic.  People are trying to get things done here and ACPI is
> getting in the way.  


Oops. Sorry. It is me who dropped the ball here. I somehow assumed that
your original patch fixed the issue and didn't look at the actual code.

Here is the patch against mm.

Thanks,
Venki



Fix the UP build breakage in acpi-cpufreq and speedstep-centrino due to
previous p-state software coordination patch.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN linux-2.6.15/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c linux-2.6.15-new/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- linux-2.6.15/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-18 19:41:25.000000000 -0800
+++ linux-2.6.15-new/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-18 19:48:10.000000000 -0800
@@ -225,9 +225,11 @@ acpi_cpufreq_target (
 	freqs.old = data->freq_table[cur_state].frequency;
 	freqs.new = data->freq_table[next_state].frequency;
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
 #endif
 
 	for_each_cpu_mask(j, online_policy_cpus) {
diff -purN linux-2.6.15/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c linux-2.6.15-new/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- linux-2.6.15/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-18 19:41:25.000000000 -0800
+++ linux-2.6.15-new/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-18 19:47:46.000000000 -0800
@@ -652,9 +652,11 @@ static int centrino_target (struct cpufr
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
 #endif
 
 	saved_mask = current->cpus_allowed;
