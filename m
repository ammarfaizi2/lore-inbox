Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUCDHUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUCDHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:20:17 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:34026 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261528AbUCDHUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:20:11 -0500
Date: Thu, 4 Mar 2004 08:20:30 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nmi_watchdog=2 and P4-HT
Message-ID: <20040304082030.GD683@zaniah>
References: <20040304054215.GA683@zaniah> <20040303213033.6348a08b.akpm@osdl.org> <20040304072630.GB683@zaniah> <20040303223235.177685dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303223235.177685dd.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 at 22:32 +0000, Andrew Morton wrote:

> Philippe Elie <phil.el@wanadoo.fr> wrote:
> >
> > 
> >  What do you think about the feature "the performance doesn't increment
> >  counter in hlt mode".
> 
> That sounds OK.  If the CPU halts with local interrupts disabled (is this
> possible?) then I assume it'll never come back.  But this possibility isn't
> worth worrying about, surely.
> 
> Can we scale the performance counter multiplier down a bit?  1000 NMIs per
> second sounds excessive.

yups and on HT it's 2000 NMI on one physical processor

I think to something like this, it's just a quick draw so you get the
idea. it's the less bad patch I can provide, get a look at the apic.c
chunk, I needed to remove the check_nmi_watchdog(); test for UP else
this test will complete in 10 seconds. Look like ugly but anyway on
SMP and with nmi_watchdog=2 we never call check_nmi_watchdog() and
I think the purpose of check_nmi_watchdog() is to test IO apic not
local apic after all if a local apic is up it must be sane ?

Phil sleeping

--- linux-2.6/arch/i386/kernel/nmi.c~	2004-03-04 08:05:48.000000000 +0000
+++ linux-2.6/arch/i386/kernel/nmi.c	2004-03-04 08:05:55.000000000 +0000
@@ -347,6 +347,8 @@ static int setup_p4_watchdog(void)
 
 void setup_apic_nmi_watchdog (void)
 {
+	nmi_hz = 1;
+
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 		if (boot_cpu_data.x86 != 6 && boot_cpu_data.x86 != 15)
--- linux-2.6.orig/arch/i386/kernel/apic.c	2004-03-04 05:05:19.000000000 +0000
+++ linux-2.6/arch/i386/kernel/apic.c	2004-03-04 07:44:50.000000000 +0000
@@ -1182,9 +1182,6 @@ int __init APIC_init_uniprocessor (void)
 	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 
 	setup_local_APIC();
-
-	if (nmi_watchdog == NMI_LOCAL_APIC)
-		check_nmi_watchdog();
 #ifdef CONFIG_X86_IO_APIC
 	if (smp_found_config)
 		if (!skip_ioapic_setup && nr_ioapics)
