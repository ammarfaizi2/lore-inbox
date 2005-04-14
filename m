Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVDNCVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVDNCVr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 22:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDNCVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 22:21:47 -0400
Received: from fmr23.intel.com ([143.183.121.15]:30392 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261442AbVDNCVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 22:21:14 -0400
Date: Wed, 13 Apr 2005 19:21:04 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH] X86_64: no legacy HPET fix
Message-ID: <20050413192103.A27092@unix-os.sc.intel.com>
References: <1113360197.19541.43.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1113360197.19541.43.camel@cog.beaverton.ibm.com>; from johnstul@us.ibm.com on Tue, Apr 12, 2005 at 07:43:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This adds another timer combination of PIT/HPET to go with
HPET/HPET, HPET/TSC and PIT/TSC!
This system that has HPET and doesn't have Legacy support, does it support
routing HPET interrupts through IOAPIC in standard routing option? If yes,
then I think adding support to route HPET interrupts in a non-legacy way
(using IRQs other than IRQ 0) is another option here. I looked at that 
when adding initial HPET support on i386, but dropped that idea after looking
at all the changes required and also due to the reason that all HPET capable
systems I had also had Legacy Support.


Some comments on the patch inlined below..

On Tue, Apr 12, 2005 at 07:43:16PM -0700, john stultz wrote:
> 
> Its likely a similar patch will be necessary for i386.
Yes. Pretty much similar change will be required in i386 as well..

> linux-2.6.12-rc2_hpet-nolegacy-fix_A0
> =====================================
> diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c	2005-04-12 19:31:50 -07:00
> +++ b/arch/x86_64/kernel/time.c	2005-04-12 19:31:50 -07:00
> @@ -373,8 +374,10 @@
>  
>  	write_seqlock(&xtime_lock);
>  
> -	if (vxtime.hpet_address) {
> -		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
> +	if (vxtime.hpet_address)
> +		offset = hpet_readl(HPET_COUNTER);
> +
> +	if (hpet_use_timer) {
>  		delay = hpet_readl(HPET_COUNTER) - offset;

Probably this has to change to use HPET_T0_CMP for offset, when hpet_use_timer.
Otherwise we will always have delay close to zero in case of hpet_use_timer,
which is a change in behaviour.

>  	} else {
>  		spin_lock(&i8253_lock);
> @@ -732,7 +735,7 @@
>  	struct hpet_data	hd;
>  	unsigned int 		ntimer;
>  
> -	if (!vxtime.hpet_address)
> +	if (!hpet_use_timer)
>            return -1;

We may need to do some initialization here even in case of !hpet_use_timer.
Like reserving particular HPET timer for timer use. Otherwise, someone
else (/dev/hpet) can overwrite the counter. I think we just need to skip 
setting the interupts part.


Thanks,
Venki
