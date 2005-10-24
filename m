Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVJXNDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVJXNDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 09:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVJXNDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 09:03:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46482 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750899AbVJXNDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 09:03:23 -0400
Date: Mon, 24 Oct 2005 18:33:11 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
Message-ID: <20051024130311.GA5853@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com> <20051021133306.GC3799@in.ibm.com> <m1ach3dj47.fsf@ebiederm.dsl.xmission.com> <20051022145207.GA4501@in.ibm.com> <m11x2deft5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11x2deft5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2005 at 09:23:34AM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:

[..]

> 
> 
> >> apic_id_registered expands to:
> >> static inline int apic_id_registered(void)
> >> {
> >> return physid_isset(GET_APIC_ID(apic_read(APIC_ID)), phys_cpu_present_map);
> >> }
> >> 
> >> Which indicates to me that the code that, there is something
> >> wrong in the logic of:
> >> 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
> >> 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
> >> 				boot_cpu_physical_apicid);
> >> 		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
> >> 	}
> >> 
> >> Currently we are refering to the boot cpus apicid with 3 different expressions
> >> one of them appears to be wrong.
> >> 
> >
> > Looks like apic_id_registered() is failing. I had put two debug printk()
> > statements and to my surprise hard_smp_processor_id() is returning different
> > value then GET_APIC_ID(apic_read(APIC_ID)).
> >
> > source code of hard_smp_processor_id() shows that it is also reading APIC_ID
> > register only. Then how can two values be different. (Until and unless
> > somebody modified the value in between two reads).
> 
> It appears the buggy expression is hard_smp_processor_id.  Quite
> possibly because it doesn't call apic_read() and instead open codes
> it.
> 
> boot_cpu_physical_apicid also returns apicid #1, before we have
> a problem.
> 
> So either we want to change hard_smp_processor_id to use apic_read()
> or we can just use boot_cpu_physical_apicid when fixing the apicid present
> bitmap.
> 
> > I am pasting another failure log with my debug messages(prefixed with "Debug:").
> > My debug patch is also attached with the mail.
> 
> See above but I am pretty certain we know enough to get farther.  For
> testing you may want to hard code your first kernel to use the second
> cpu.
> 
> The fact that hard_smp_processor_id gets the wrong value makes me wonder
> if your kernel will boot all of the way once we get past this problem.
> 
> I suspect if you disassemble the code for hard_smp_processor_id we
> will see the compiler doing the wrong thing.


You are right. hard_smp_processor_id() is hard-coded to zero in case of a
non SMP kernel (include/linux/smp.h) and that's why the problem is happening.
I am booting a non-SMP capture kernel. In case of kexec on panic, we can very
well boot on a cpu whose id is not zero.

I have attached a patch with the mail which is now using
boot_cpu_physical_apicid to hard set presence of boot cpu instead of
hard_smp_processor_id(). But the interesting questoin remains why BIOS is
not reporting the boot cpu.

Thanks
Vivek


o Removes the unnecessary call to local_irq_disable().

o Kdump was failing while second kernel was coming up. Check for presence
  of boot cpu apic id was failing in (apic_id_registered), hence hitting
  BUG().

o This should not have failed because before calling setup_local_APIC(), it is
  ensured that even if BIOS has not reported boot cpu, then hard set the
  prence of it. Problem happens because of usage of hard_smp_processor_id()
  which is hardcoded to zero in case of non SMP kernel. In kdump case second
  kernel can boot on a cpu whose boot cpu id is not zero. 

o Using boot_cpu_physical_apicid instead to hard set the presence of boot cpu.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.14-rc4-mm1-16M-root/arch/i386/kernel/apic.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/i386/kernel/apic.c~kdump-i386-apic-verification-failure-fix arch/i386/kernel/apic.c
--- linux-2.6.14-rc4-mm1-16M/arch/i386/kernel/apic.c~kdump-i386-apic-verification-failure-fix	2005-10-24 17:40:08.000000000 +0530
+++ linux-2.6.14-rc4-mm1-16M-root/arch/i386/kernel/apic.c	2005-10-24 18:19:53.000000000 +0530
@@ -1055,7 +1055,6 @@ void __init setup_boot_APIC_clock(void)
 	using_apic_timer = 1;
 
 	local_irq_save(flags);
-	local_irq_disable();
 
 	calibration_result = calibrate_APIC_clock();
 	/*
@@ -1299,7 +1298,7 @@ int __init APIC_init(void)
 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 				boot_cpu_physical_apicid);
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(boot_cpu_physical_apicid, phys_cpu_present_map);
 	}
 
 	/*
_

