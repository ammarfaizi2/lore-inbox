Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVINEqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVINEqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbVINEqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:46:42 -0400
Received: from koto.vergenet.net ([210.128.90.7]:424 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932684AbVINEql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:46:41 -0400
Date: Wed, 14 Sep 2005 12:13:57 +0900
From: Horms <horms@verge.net.au>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, micha@debian.org
Subject: Re: [patch 04/09] x86_64: avoid SMP boot up race
Message-ID: <20050914031356.GA19160@verge.net.au>
References: <20050608234637.GG13152@shell0.pdx.osdl.net> <20050609000408.GK13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050609000408.GK13152@shell0.pdx.osdl.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering if anyone could comment on if this could
be conceived as a security bug. My initial instinct was
yes, but on further considertation I can't conceive
a way it could be exploited, well not by anyone
who couldn't DoS the box in any number of other ways,
including shutting it down.

On Wed, Jun 08, 2005 at 05:04:08PM -0700, Chris Wright wrote:
> Keep interrupts disabled during smp bootup
> 
> This avoids a race that breaks SMP bootup on some machines.
> The race is not fully plugged (that is only done with much
> more changes in 2.6.12), but should be good enough
> for most people.
> 
> Keeping the interrupts disabled here is ok because we
> don't rely on the timer interrupt for local APIC
> timer setup, but always read the timer registers
> directly.
> 
> (originally from Rusty Russell iirc) 
> 
> Signed-off-by: ak@suse.de
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> 
> diff -u linux/arch/x86_64/kernel/apic.c-o linux/arch/x86_64/kernel/apic.c
> --- linux/arch/x86_64/kernel/apic.c-o	2005-05-31 16:40:01.000000000 +0200
> +++ linux/arch/x86_64/kernel/apic.c	2005-05-31 16:44:05.000000000 +0200
> @@ -775,9 +775,7 @@
>  
>  void __init setup_secondary_APIC_clock(void)
>  {
> -	local_irq_disable(); /* FIXME: Do we need this? --RR */
>  	setup_APIC_timer(calibration_result);
> -	local_irq_enable();
>  }
>  
>  void __init disable_APIC_timer(void)
> diff -u linux/arch/x86_64/kernel/smpboot.c-o linux-2.6.11/arch/x86_64/kernel/smpboot.c
> --- linux/arch/x86_64/kernel/smpboot.c-o	2005-03-21 14:04:11.000000000 +0100
> +++ linux/arch/x86_64/kernel/smpboot.c	2005-05-31 16:44:07.000000000 +0200
> @@ -309,8 +309,6 @@
>  	Dprintk("CALLIN, before setup_local_APIC().\n");
>  	setup_local_APIC();
>  
> -	local_irq_enable();
> -
>  	/*
>  	 * Get our bogomips.
>  	 */
> @@ -324,8 +322,6 @@
>  	 */
>   	smp_store_cpu_info(cpuid);
>  
> -	local_irq_disable();
> -
>  	/*
>  	 * Allow the master to continue.
>  	 */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Horms
