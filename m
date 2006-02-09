Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWBIUki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWBIUki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWBIUki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:40:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWBIUkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:40:37 -0500
Date: Thu, 9 Feb 2006 12:37:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, ntl@pobox.com, dada1@cosmosbay.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209123729.5fcd3808.akpm@osdl.org>
In-Reply-To: <20060209105230.A10147@unix-os.sc.intel.com>
References: <20060209160808.GL18730@localhost.localdomain>
	<20060209090321.A9380@unix-os.sc.intel.com>
	<20060209100429.03f0b1c3.akpm@osdl.org>
	<20060209105230.A10147@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
>  > 
>  > Does the ACPI problem which you describe occur with present-CPUs,
>  > or only with possible-but-not-present ones?
> 
>  Describing present cpus is not problem.
> 
>  Only knowing possible-but-not-present upfront is an issue.
> 
>  logical-cpu-hotplug only: cpu_present_map == cpu_possible_map always
>  physical-cpu-hotplug: At boot, cpu_present_map is a subset of possible_map.
> 
>  Think its best to NOT set cpu_present_map to MASK_ALL as its being proposed,
>  but let the arch/platform code figure out early enough to set possible_map 
>  accurately for that platform. If a platform has no way to determine it, 
>  then it could use cmdline like what x86_64 introduced (additional_cpus=)
>  to overcome that.

There is no proposal to change cpu_present_map.

The problem is cpu_possible_map.  That is presently being initialised to
CPU_MASK_ALL, which adversely affects perfoermance.  An NR_CPUS=16 kernel
on a 2-way presently has cpu_possible_map=0xffff, which will hurt.

The proposal is this:


From: Andrew Morton <akpm@osdl.org>

Initialising cpu_possible_map to all-ones with CONFIG_HOTPLUG_CPU means that

a) All for_each_cpu() loops will iterate across all NR_CPUS CPUs, rather
   than over possible ones.  That can be quite expensive.

b) Soon we'll be allocating per-cpu areas only for possible CPUs.  So with
   CPU_MASK_ALL, we'll be wasting memory.

I also switched voyager over to not use CPU_MASK_ALL in the non-CPU-hotplug
case.  Will that break it?

I note that parisc is also using CPU_MASK_ALL.  Suggest that it stop doing
that.

Cc: James Bottomley <James.Bottomley@steeleye.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Paul Jackson <pj@sgi.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Paul Jackson <pj@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/smpboot.c           |    4 ----
 arch/i386/mach-voyager/voyager_smp.c |    2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~x86-dont-initialise-cpu_possible_map-to-all-ones arch/i386/kernel/smpboot.c
--- devel/arch/i386/kernel/smpboot.c~x86-dont-initialise-cpu_possible_map-to-all-ones	2006-02-09 01:11:55.000000000 -0800
+++ devel-akpm/arch/i386/kernel/smpboot.c	2006-02-09 01:12:24.000000000 -0800
@@ -87,11 +87,7 @@ EXPORT_SYMBOL(cpu_online_map);
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 EXPORT_SYMBOL(cpu_callout_map);
-#ifdef CONFIG_HOTPLUG_CPU
-cpumask_t cpu_possible_map = CPU_MASK_ALL;
-#else
 cpumask_t cpu_possible_map;
-#endif
 EXPORT_SYMBOL(cpu_possible_map);
 static cpumask_t smp_commenced_mask;
 
diff -puN arch/i386/mach-voyager/voyager_smp.c~x86-dont-initialise-cpu_possible_map-to-all-ones arch/i386/mach-voyager/voyager_smp.c
--- devel/arch/i386/mach-voyager/voyager_smp.c~x86-dont-initialise-cpu_possible_map-to-all-ones	2006-02-09 01:11:55.000000000 -0800
+++ devel-akpm/arch/i386/mach-voyager/voyager_smp.c	2006-02-09 01:12:43.000000000 -0800
@@ -240,7 +240,7 @@ static cpumask_t smp_commenced_mask = CP
 cpumask_t cpu_callin_map = CPU_MASK_NONE;
 cpumask_t cpu_callout_map = CPU_MASK_NONE;
 EXPORT_SYMBOL(cpu_callout_map);
-cpumask_t cpu_possible_map = CPU_MASK_ALL;
+cpumask_t cpu_possible_map = CPU_MASK_NONE;
 EXPORT_SYMBOL(cpu_possible_map);
 
 /* The per processor IRQ masks (these are usually kept in sync) */
_

