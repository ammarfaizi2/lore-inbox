Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWB0Hon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWB0Hon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 02:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWB0Hon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 02:44:43 -0500
Received: from thorn.pobox.com ([208.210.124.75]:61629 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751652AbWB0Hom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 02:44:42 -0500
Date: Mon, 27 Feb 2006 01:50:34 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i386 cpu hotplug bug - instant reboot when onlining secondary
Message-ID: <20060227075033.GK3293@localhost.localdomain>
References: <20060219235826.GF3293@localhost.localdomain> <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602210800290.1579@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Sun, 19 Feb 2006, Nathan Lynch wrote:
> 
> > On a dual P3 Xeon machine, offlining and then onlining a cpu makes the
> > box instantly reboot.  I've been seeing this throughout the 2.6.16-rc
> > series, but wasn't able to collect more information until now.  Not
> > sure when this last worked, unfortunately.
> > 
> > With the debugging patch below, I get this on serial console:
> 
> Does 2.6.14 work? Also i wonder if it gets out of the trampoline...

2.6.14 works (albeit with an APIC error reported).  When retesting
2.6.16-rc4 with your patch on top of my debugging patch, I don't see the
"startup_secondary" line:

[17179709.100000] CPU 1 is now offline
[17179714.636000] Booting processor 1/1 eip 3000
[17179714.688000] CPU 1 irqstacks, hard=7837f000 soft=78377000
[17179714.756000] Setting warm reset code and vector.
[17179714.812000] 1.
[17179714.836000] 2.
[17179714.860000] 3.
[17179714.880000] Asserting INIT.
[17179714.916000] Waiting for send to finish...
[17179714.968000] +<7>Deasserting INIT.
[17179715.024000] Waiting for send to finish...
[17179715.072000] +<7>#startup loops: 2.
[17179715.116000] Sending STARTUP #1.
[17179715.160000] After apic_write.
[17179715.196000] Doing apic_write_around for target chip...
[17179715.260000] Doing apic_write_around to kick the second...

> 
> Index: linux-2.6.16-rc2/arch/i386/kernel/smpboot.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.16-rc2/arch/i386/kernel/smpboot.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 smpboot.c
> --- linux-2.6.16-rc2/arch/i386/kernel/smpboot.c	11 Feb 2006 18:55:06 -0000	1.1.1.1
> +++ linux-2.6.16-rc2/arch/i386/kernel/smpboot.c	21 Feb 2006 16:19:22 -0000
> @@ -514,6 +514,7 @@ static void __devinit start_secondary(vo
>  	cpu_init();
>  	preempt_disable();
>  	smp_callin();
> +	Dprintk("startup_secondary\n");
>  	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
>  		rep_nop();
>  	setup_secondary_APIC_clock();
