Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTFALKF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTFALKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:10:05 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:48627 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263522AbTFALKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:10:03 -0400
Date: Sun, 1 Jun 2003 13:23:18 +0200 (MEST)
Message-Id: <200306011123.h51BNIT7019716@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: zwane@linuxpower.ca
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
Cc: alan@lxorguk.ukuu.org.uk, brian@interlinx.bc.ca,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 23:30:10 -0400 (EDT), Zwane Mwaikambo wrote:
>--- linux-2.5/arch/i386/kernel/apic.c	30 May 2003 20:14:41 -0000	1.50
>+++ linux-2.5/arch/i386/kernel/apic.c	31 May 2003 05:53:34 -0000
>@@ -665,6 +665,7 @@ static int __init detect_init_APIC (void
> 	return 0;
> 
> no_apic:
>+	dont_enable_local_apic = 1;
> 	printk("No local APIC present or hardware disabled\n");
> 	return -1;
> }
>@@ -1127,6 +1128,9 @@ asmlinkage void smp_error_interrupt(void
>  */
> int __init APIC_init_uniprocessor (void)
> {
>+	if (dont_enable_local_apic)
>+		return -1;
>+
> 	if (!smp_found_config && !cpu_has_apic)
> 		return -1;

I didn't follow this thread closely, but:

1. dont_enable_local_apic was originally only intended for those
   systems (i.e., Dell laptops) where enabling the local APIC in
   HW (via APIC_BASE MSR) causes problems due to broken BIOSen.
   It was never intended as a "Kernel, please don't use the local
   APIC even though I configured it" option. It doesn't help you
   if your machine boots with the local APIC enabled, but the
   local APIC doesn't work for some reason.

2. The only way to reach no_apic is if we boot on a vendor/model
   combination that isn't known to have a local APIC that can be
   enabled in software. And the second patch hunk only makes a
   difference if the CPU boots with an enabled local APIC.

   So what vendor/model CPU is used in the failure case?

   (And if its local APIC is broken, cpu_has_apic should be cleared
   rather than setting the dont_enable flag. Post-boot code may
   access the local APIC if CONFIG_X86_LOCAL_APIC && cpu_has_apic.)

3. What is the exact failure? Hang or crash? Where? UP or SMP kernel?
   (If SMP kernel, does booting with "nosmp" help?)

/Mikael
