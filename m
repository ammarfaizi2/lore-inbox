Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVD1DSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVD1DSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 23:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVD1DSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 23:18:44 -0400
Received: from fmr17.intel.com ([134.134.136.16]:47776 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261851AbVD1DSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 23:18:42 -0400
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050427125622.GG13305@wotan.suse.de>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
	 <20050426132149.GF5098@wotan.suse.de>
	 <1114564068.12809.7.camel@sli10-desk.sh.intel.com>
	 <20050427125622.GG13305@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1114658144.22110.31.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 11:15:44 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 20:56, Andi Kleen wrote:
> > > No way we are making this common operation much slower just
> > > to fix an obscure race at boot time. PLease come up with a fix
> > > that only impacts the boot process.
> > We can't prevent a CPU to receive a broadcast interrupt. Ack the
> > interrupt and mark the cpu online can't be atomic operation, so the CPU
> > either receives unexpected interrupt or loses interrupt.
> 
> Cant you just check at the end of the CPU bootup if the CPU
> got such an APIC interrupt and ack it then? 
Ok, There are two solutions:
1. boot sequence hold the 'call_lock' before LAPIC is initialized. So no
broadcast IPI will be received. But you possibly think the lock is hold
too long time.
2. Hold the lock later.
The boot sequence does:
a.hold 'call_lock' (prevent upcoming IPI)
b.enable interrupt (let stale IPI get handled)
c.set cpu online
d.unlock the lock.
The smp_call_function_interrupt does:
if (cpu is offline)
	ack the interrupt and return
But this approach will add check in smp_call_function_interrupt and
enable interrupt before set online map. Don't know if it's an issue.

Seems no other approaches. The ISR and IRR registers are read only.
BTW, send_ipi_mask_bitmask sends a CPU group one time, is it really much
slower than broadcast IPI? I guess we can ignore the overhead, since the
overhead is lighter against the call function interrupt handler.

Thanks,
Shaohua

