Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbTFLTnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 15:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTFLTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 15:43:00 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:63924 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264965AbTFLTm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 15:42:58 -0400
Date: Thu, 12 Jun 2003 21:55:26 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Andi Kleen <ak@suse.de>,
       vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
Message-ID: <20030612215526.B25043@ucw.cz>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com> <20030611191815.GA30411@wotan.suse.de> <1055361411.17154.83.camel@serpentine.internal.keyresearch.com> <1055362249.17154.86.camel@serpentine.internal.keyresearch.com> <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com> <1055367412.17154.100.camel@serpentine.internal.keyresearch.com> <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com> <1055440030.1043.7.camel@serpentine.internal.keyresearch.com> <1055446795.18644.148.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1055446795.18644.148.camel@w-jstultz2.beaverton.ibm.com>; from johnstul@us.ibm.com on Thu, Jun 12, 2003 at 12:39:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:39:55PM -0700, john stultz wrote:
> On Thu, 2003-06-12 at 10:47, Bryan O'Sullivan wrote:
> > On Wed, 2003-06-11 at 17:33, john stultz wrote:
> > 
> > > Let me know if you have any issues with this patch. 
> > 
> > Thanks, John.  Your updated patch has survived some beating on my test
> > systems.  I've also applied Vojtech's fix to hpet_tick.
> 
> One little tweak, you're still subtracting tick_usec when calculating
> offset. Doesn't cause any major problems since you're catching error
> with the offset<0 switch. However we won't catch lost interrupts
> properly if we're always negative. 
> 
> thanks
> -john
> 
> 
> Patch for that should be:
> 
> --- 1.22/arch/x86_64/kernel/time.c	Thu Jun 12 11:40:33 2003
> +++ edited/arch/x86_64/kernel/time.c	Thu Jun 12 11:42:43 2003
> @@ -254,7 +254,7 @@
>  		vxtime.last = offset;
>  	} else {
>  		offset = (((tsc - vxtime.last_tsc) *
> -			   vxtime.tsc_quot) >> 32) - tick_usec;
> +			   vxtime.tsc_quot) >> 32) - (USEC_PER_SEC / HZ);
>  
>  		if (offset < 0)
>  			offset = 0;

In my opinion the "if (offset < 0)" check above is not needed once the
problem you describe is fixed, since the code below actually expects
that offset can be negative and doesn't do anything in that case.

Thinking more about it, the

	if ((((tsc - vxtime.last_tsc) * vxtime.tsc_quot) >> 32) < offset)

statement is comparing unsigned and signed values, and should probably
be fixed to do a signed comparison.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
