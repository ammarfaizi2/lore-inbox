Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUHWBRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUHWBRm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 21:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUHWBRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 21:17:42 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:39402 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S264954AbUHWBRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 21:17:39 -0400
Subject: Re: [PATCH][2.6] Hotplug cpu: Fix APIC queued timer vector race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0408221044180.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com>
	 <1093145533.4888.106.camel@bach>
	 <Pine.LNX.4.58.0408221044180.27390@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1093223788.4888.213.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 11:16:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 00:47, Zwane Mwaikambo wrote:
> On Sun, 22 Aug 2004, Rusty Russell wrote:
> 
> > On Sun, 2004-08-22 at 00:10, Zwane Mwaikambo wrote:
> > > Some timer interrupt vectors were queued on the Local APIC and were being
> > > serviced when we enabled interrupts again in fixup_irqs(), so we need to
> > > mask the APIC timer, enable interrupts so that any queued interrupts get
> > > processed whilst the processor is still on the online map and then clear
> > > ourselves from the online map. 1ms is a nice safe number even under heavy
> > > interrupt load with higher priority vectors queued. Andrew this is
> > > the patch i promised, Rusty, i'm not sure if you find
> > > __attribute__((weak)) offensive...
> >
> > It's horrible.  Please move the unsetting of the cpu_online bit into the
> > arch-specific __cpu_disable() code for each arch, which is consistent
> > and also simplifies things.
> 
> Alright this should do it then;
> 
> Thanks
> 
> Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>
> 
>  arch/i386/kernel/smpboot.c |   10 ++++++++--
>  arch/ia64/kernel/smpboot.c |    1 +
>  arch/ppc64/kernel/smp.c    |    4 +++-
>  arch/s390/kernel/smp.c     |    4 +++-
>  kernel/cpu.c               |    3 ---
>  5 files changed, 15 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6.8.1-mm2/kernel/cpu.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.8.1-mm2/kernel/cpu.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 cpu.c
> --- linux-2.6.8.1-mm2/kernel/cpu.c	19 Aug 2004 20:52:08 -0000	1.1.1.1
> +++ linux-2.6.8.1-mm2/kernel/cpu.c	22 Aug 2004 14:28:17 -0000
> @@ -89,9 +89,6 @@ static int take_cpu_down(void *unused)
>  {
>  	int err;
> 
> -	/* Take offline: makes arch_cpu_down somewhat easier. */
> -	cpu_clear(smp_processor_id(), cpu_online_map);
> -
>  	/* Ensure this CPU doesn't handle any more interrupts. */
>  	err = __cpu_disable();
>  	if (err < 0)

Hmm, I actually mean you to remove the cpu_set just after this, too, and
make the archs re-set th online_map if they failed.

A little more invasive, but more coherent.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

