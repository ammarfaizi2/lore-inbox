Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWB1OHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWB1OHC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWB1OG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:06:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:57310 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750850AbWB1OG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:06:58 -0500
X-Authenticated: #14349625
Subject: Re: [Patch] task interactivity calculation (was Strange
	interactivity behaviour)
From: Mike Galbraith <efault@gmx.de>
To: Martin Andersson <martin.andersson@control.lth.se>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <440426FC.6010609@control.lth.se>
References: <4402E52F.6080409@control.lth.se>
	 <440426FC.6010609@control.lth.se>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 15:07:49 +0100
Message-Id: <1141135669.14628.27.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 11:33 +0100, Martin Andersson wrote:
> The appended patch fixes the problem mentioned in 
> http://lkml.org/lkml/2006/2/27/104
> regarding wrong truncations in the calculation of task interactivity 
> when the nice value is negative. The problem causes the interactivity to 
> scale nonlinearly and differ from examples in the code.
> 

Hi (again) Martin,

Patches are required to have a credit/blame line these days ala...

Signed-off-by: Martin Andersson <martin.andersson@control.lth.se>

...and should be sent with a cc to the subsystem maintainer  In this
case, Ingo Molnar.  Things tend to go into mainline through Andrew
Morton after being acked, so I've taken the liberty of adding him as
well. 

Wrt the fix itself, rather than scrunch to fit 80 columns, I'd just...

#define DELTA(p) \
	(SCALE(TASK_NICE(p) + 20, 40, MAX_BONUS) - 20 * MAX_BONUS / 40 + \
	INTERACTIVE_DELTA)

...wrap at the nearest readable spot.

(hmm.  just re-packaging the thing would have wasted fewer electrons;)
 
	-Mike

> /Martin Andersson
> 
> diff -uprN linux-2.6.15.4.orig/kernel/sched.c linux-2.6.15.4/kernel/sched.c
> --- linux-2.6.15.4.orig/kernel/sched.c	2006-02-10 08:22:48.000000000 +0100
> +++ linux-2.6.15.4/kernel/sched.c	2006-02-28 11:10:30.000000000 +0100
> @@ -142,7 +142,7 @@
>   	(v1) * (v2_max) / (v1_max)
> 
>   #define DELTA(p) \
> -	(SCALE(TASK_NICE(p), 40, MAX_BONUS) + INTERACTIVE_DELTA)
> +	(SCALE(TASK_NICE(p)+20,40, MAX_BONUS)-20*MAX_BONUS/40+INTERACTIVE_DELTA)
> 
>   #define TASK_INTERACTIVE(p) \
>   	((p)->prio <= (p)->static_prio - DELTA(p))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

