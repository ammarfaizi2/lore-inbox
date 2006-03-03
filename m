Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWCCSOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWCCSOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 13:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWCCSOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 13:14:04 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:12235 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161010AbWCCSOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 13:14:03 -0500
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
	aliasing problem)
From: john stultz <johnstul@us.ibm.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ralf@linux-mips.org
In-Reply-To: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
	 <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
	 <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 10:13:58 -0800
Message-Id: <1141409638.9727.17.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 11:44 +0900, Atsushi Nemoto wrote:
> >>>>> On Thu, 2 Mar 2006 11:09:16 -0800 (PST), Christoph Lameter <clameter@engr.sgi.com> said:
> >> In kernel 2.6, update_times() is called directly in timer
> >> interrupt, so there is no point calculating ticks here.  This also
> >> get rid of difference of jiffies and jiffies_64 due to compiler's
> >> optimization (which was reported previously with subject
> >> "jiffies_64 vs. jiffies").
> 
> clameter> If update_wall_time() and calc_load() are always called with
> clameter> the constant one then you may be able to optimize these two
> clameter> functions as well.
> 
> Sure.  I tried to do only one thing at a time, but it might be better
> to clean them up together.  Patch revised.
> 
> 
> In kernel 2.6, update_times() is called directly in timer interrupt,
> so there is no point calculating ticks here.  Then update_wall_time()
> and calc_load() can also be optimized.  This also get rid of
> difference of jiffies and jiffies_64 due to compiler's optimization
> (which was reported previously with subject "jiffies_64 vs. jiffies").


I'm not opposed to this change, but I'm not sure if the barrier with a
clear comment as to why its needed might be better in the short term.

> Also adjust x86_64 timer interrupt handler with this change.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> index 3080f84..7a1d790 100644
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -423,7 +423,8 @@ void main_timer_handler(struct pt_regs *
>  
>  	if (lost > 0) {
>  		handle_lost_ticks(lost, regs);
> -		jiffies += lost;
> +		while (lost--)
> +			do_timer(regs);
>  	}

i386 also has lost tick processing that will need to be handed as well. 

thanks
-john





