Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266169AbSKFW0Z>; Wed, 6 Nov 2002 17:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266168AbSKFW0Z>; Wed, 6 Nov 2002 17:26:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:60621 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266169AbSKFW0X>;
	Wed, 6 Nov 2002 17:26:23 -0500
Message-ID: <3DC99892.A3750D7E@digeo.com>
Date: Wed, 06 Nov 2002 14:32:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
References: <3DC975DC.77231191@digeo.com> <132110000.1036622931@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 22:32:50.0995 (UTC) FILETIME=[70B82830:01C285E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> ...
> ---------------------
> 
> BOOT CPU:
> 
> init
>         smp_prepare_cpus
>                 smp_boot_cpus
>                         setup_local_APIC
>                         foreach cpu
>                                 do_boot_cpu
>                                         wakeup_secondary_via_(NMI|INIT)
>                                         {set bit in cpu_callout_map}
>                                         {spin on cpu_callin_map}
>                         setup_IO_APIC
>                         synchronize_tsc_bp
>         smp_init
>                 foreach cpu
>                         cpu_up
>                                 notifier_call_chain(CPU_UP_PREPARE)
>                                 __cpu_up
>                                         {set bit in smp_commenced_mask}
>                                         {spin on cpu_online_map}
>                                 notifier_call_chain(CPU_ONLINE)
>                 smp_cpus_done
>                 smp_commence

Nice!

> ------------------------
> 
> SECONDARY CPU:
> 
> start_secondary
>         cpu_init
>         smp_callin
>                 {spin on cpu_callout_map}
>                 setup_local_APIC
>                 local_irq_enable
>                 calibrate_delay
>                 disable_APIC_timer
>                 {set our bit in cpu_callin_map}
>                 synchronise_tsc_api
>         {spin on smp_commenced_mask}
>         enable_APIC_timer
>         {set our bit in cpu_online_map}
>         idle

So this is the bug, isn't it?  Can the calibrate_delay stuff be moved
until _after_ the bit has been set in smp_commenced_mask??
 
> 
> 
> > In this case I'd say "all interrupts".  The secondary really
> > should be 100% dormant until all CPU_UP_PREPARE callouts have
> > been run and have returned NOTIFY_OK.
> >
> > At least, that's how I'd have designed it.
> 
> Well that makes sense to me. Apart from when I started doing it,
> it seems that in smp_callin we do calibrate_delay, which looks
> like it needs interrupts enabled (I could be wrong). I suppose
> I could just disable them at the end of smp_callin again, but
> it's all rather ugly. Maybe after we do disable_APIC_timer in
> smp_callin.

Maybe you could copy the boot cpu's calibrate_delay result
over to all cpu_possible secondaries, then redo the calibration
for real once the secondary is actually legally up and running.
