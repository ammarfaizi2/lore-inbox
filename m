Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTFLG0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTFLG0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:26:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7377 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263628AbTFLG0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:26:33 -0400
Date: Thu, 12 Jun 2003 08:40:10 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Andi Kleen <ak@suse.de>,
       vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
Message-ID: <20030612084010.B12126@ucw.cz>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com> <20030611191815.GA30411@wotan.suse.de> <1055361411.17154.83.camel@serpentine.internal.keyresearch.com> <1055362249.17154.86.camel@serpentine.internal.keyresearch.com> <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com> <1055367412.17154.100.camel@serpentine.internal.keyresearch.com> <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com>; from johnstul@us.ibm.com on Wed, Jun 11, 2003 at 05:33:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 05:33:55PM -0700, john stultz wrote:
 
> This patch applies on top of Bryan's patch, and solves the major time
> inconsistencies I was seeing earlier. I don't like that I still have to
> have the sanity check on offset to ensure it doesn't go negative
> (frequently I get offsets of -1),

IMO this is to be expected and not a problem. In the case of offset of
'-1' the time will jump one usec forward on the timer interrupt, but
that's harmless and nothing worse should happen.

> and that along with the fact that I'm
> seeing a steady drift forward on every kernel I've run (2.4/2.5) makes
> me think that the timer interrupt frequency may be a bit higher then we
> intend. Might just be the dev hardware I'm running on, though.

The devel hardware's RTC crystals are quite a bit off the correct
frequency, but still in the range fixable by NTP.

> I'm also got some cleanup changes I'd like to make, but I'll wait until
> after things work to polish that stuff up. 
> 
> Let me know if you have any issues with this patch. 

Looks OK to me.

> thanks
> -john
> 
> diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> --- a/arch/x86_64/kernel/time.c	Wed Jun 11 17:28:07 2003
> +++ b/arch/x86_64/kernel/time.c	Wed Jun 11 17:28:07 2003
> @@ -254,11 +254,14 @@
>  		vxtime.last = offset;
>  	} else {
>  		offset = (((tsc - vxtime.last_tsc) *
> -			   vxtime.tsc_quot) >> 32) - tick_usec;
> +			   vxtime.tsc_quot) >> 32) - (USEC_PER_SEC/HZ);
> +		/* sanity check on offset */
> +		if(offset < 0)
> +			offset = 0;
>  
> -		if (offset > tick_usec) {
> -			lost = offset / tick_usec;
> -			offset %= tick_usec;
> +		if (offset > (USEC_PER_SEC/HZ)) {
> +			lost = offset / (USEC_PER_SEC/HZ);
> +			offset %= (USEC_PER_SEC/HZ);
>  		}
>  
>  		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
> @@ -275,10 +278,7 @@
>  			       "tick(s)! (rip %016lx)\n",
>  			       (offset - vxtime.last) / hpet_tick - 1,
>  			       regs->rip);
> -		// XXX The accounting of lost ticks is way off right
> -		// now. -bos
> -
> -		// jiffies += lost;
> +		jiffies += lost;
>  	}
>  
>  /*
> 
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
