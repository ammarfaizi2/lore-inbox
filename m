Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266121AbSKFVrU>; Wed, 6 Nov 2002 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266132AbSKFVrU>; Wed, 6 Nov 2002 16:47:20 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:22932 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266121AbSKFVrT>;
	Wed, 6 Nov 2002 16:47:19 -0500
Date: Wed, 06 Nov 2002 14:48:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
Message-ID: <132110000.1036622931@flay>
In-Reply-To: <3DC975DC.77231191@digeo.com>
References: <3DC9719B.AC139E50@digeo.com> <121150000.1036615519@flay> <3DC975DC.77231191@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know.  This sequencing really needs to be thought about
> and written down, else we'll just have an ongoing fiasco trying
> to graft stuff onto it.

OK, well here's a first cut at a rough diagram of the sequencing. 
I'm told arches other than i386 have less problems (not sure why
we all feel the need to be different on this issue, but no doubt
there's some good reason. Or not). Whilst digging around, I found
the following comment, which was amusing, if frustrating:

/* These are wrappers to interface to the new boot process.  Someone
   who understands all this stuff should rewrite it properly. --RR 15/Jul/02 */

---------------------

BOOT CPU:

init
	smp_prepare_cpus
		smp_boot_cpus
			setup_local_APIC
			foreach cpu
				do_boot_cpu
					wakeup_secondary_via_(NMI|INIT)
					{set bit in cpu_callout_map}
					{spin on cpu_callin_map}
			setup_IO_APIC
			synchronize_tsc_bp
	smp_init
		foreach cpu 
			cpu_up
				notifier_call_chain(CPU_UP_PREPARE)
				__cpu_up
					{set bit in smp_commenced_mask}
					{spin on cpu_online_map}
				notifier_call_chain(CPU_ONLINE)
		smp_cpus_done
		smp_commence

------------------------

SECONDARY CPU:

start_secondary
	cpu_init
	smp_callin
		{spin on cpu_callout_map}
		setup_local_APIC
		local_irq_enable
		calibrate_delay
		disable_APIC_timer
		{set our bit in cpu_callin_map}
		synchronise_tsc_api	
	{spin on smp_commenced_mask}
	enable_APIC_timer
	{set our bit in cpu_online_map}
	idle


	

> In this case I'd say "all interrupts".  The secondary really
> should be 100% dormant until all CPU_UP_PREPARE callouts have
> been run and have returned NOTIFY_OK.
> 
> At least, that's how I'd have designed it.

Well that makes sense to me. Apart from when I started doing it,
it seems that in smp_callin we do calibrate_delay, which looks
like it needs interrupts enabled (I could be wrong). I suppose 
I could just disable them at the end of smp_callin again, but 
it's all rather ugly. Maybe after we do disable_APIC_timer in
smp_callin.

M.

