Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269477AbUJLGY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269477AbUJLGY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269489AbUJLGY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:24:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63121 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269477AbUJLGX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:23:58 -0400
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
From: Dave Hansen <haveblue@us.ibm.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <1097560787.6557.99.camel@biclops>
References: <20041001204533.GA18684@elte.hu>
	 <20041001204642.GA18750@elte.hu> <20041001143332.7e3a5aba.akpm@osdl.org>
	 <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com>
	 <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>
	 <1097560787.6557.99.camel@biclops>
Content-Type: text/plain
Message-Id: <1097562219.8085.732.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 23:23:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 22:59, Nathan Lynch wrote:
> On Mon, 2004-10-11 at 03:19, Zwane Mwaikambo wrote:
> > Hi Andrew,
> > 	Find attached the i386 cpu hotplug patch updated for Ingo's latest 
> > round of goodies. In order to avoid dumping cpu hotplug code into 
> > kernel/irq/* i dropped the cpu_online check in do_IRQ() by modifying 
> > fixup_irqs(). The difference being that on cpu offline, fixup_irqs() is 
> > called before we clear the cpu from cpu_online_map and a long delay in 
> > order to ensure that we never have any queued external interrupts on the 
> > APICs. Due to my usual test victims being in boxes a continent away this 
> > hasn't been tested, but i'll cover bug reports (nudge, Nathan! ;)
> 
> Had to apply the patch to 2.6.9-rc4-mm1 (2.6.9-rc3-mm3 doesn't detect my
> scsi controller).  Tested on a dual Pentium 3.  Simple offline/online
> tests seem ok, except I see these warnings when taking a cpu down:
> 
> using smp_processor_id() in preemptible code: bash/3436
>  [<c0106f37>] dump_stack+0x17/0x20
>  [<c011a087>] smp_processor_id+0x87/0xa0
>  [<c0134d54>] cpu_down+0x134/0x240
>  [<c02770d9>] store_online+0x39/0x70
>  [<c0274487>] sysdev_store+0x37/0x50
>  [<c019339e>] flush_write_buffer+0x2e/0x40
>  [<c0193427>] sysfs_write_file+0x77/0x90
>  [<c015aa20>] vfs_write+0xe0/0x120
>  [<c015ab0d>] sys_write+0x3d/0x70
>  [<c0106123>] syscall_call+0x7/0xb

I think this warning is likely bogus:

        /* Move it here so it can run. */
        kthread_bind(p, smp_processor_id());

That just makes sure that the thread can get cleaned up somewhere on
some active cpu.  The only problem would be if the cpu that the thread
was bound to also went down.  But, I think that's prevented by the big
cpu hotplug semaphore.  (the "down"ing CPU can't be "down"ed in the
process of "down"ing :)

> diff -puN kernel/cpu.c~cpu_down-fix-smp_processor_id-warning kernel/cpu.c
> --- 2.6.9-rc4-mm1/kernel/cpu.c~cpu_down-fix-smp_processor_id-warning	2004-10-11 23:28:47.000000000 -0500
> +++ 2.6.9-rc4-mm1-nathanl/kernel/cpu.c	2004-10-11 23:34:36.000000000 -0500
> @@ -129,7 +129,8 @@ int cpu_down(unsigned int cpu)
>  	__cpu_die(cpu);
>  
>  	/* Move it here so it can run. */
> -	kthread_bind(p, smp_processor_id());
> +	kthread_bind(p, get_cpu());
> +	put_cpu();

This doesn't do much more than suppress the warning.  If there was some
kind race there before, then it's still there but is now hidden.  

-- Dave

