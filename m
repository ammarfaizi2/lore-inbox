Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUAFQbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUAFQbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:31:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:4573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264534AbUAFQ36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:29:58 -0500
Date: Tue, 6 Jan 2004 08:29:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>, johnstultz@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <20040106081947.3d51a1d5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
References: <1073405053.2047.28.camel@mulgrave> <20040106081947.3d51a1d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Andrew Morton wrote:
> 
> Hm, OK.  I hit the same deadlock when running with the "don't require TSCs
> to be synchronised in sched_clock()" patch from -mm.  The fix for that is
> below.  I shall accelerate it.
> 
> --- 25/arch/i386/kernel/timers/timer_tsc.c~sched_clock-2.6.0-A1-deadlock-fix	2003-12-30 00:45:09.000000000 -0800
> +++ 25-akpm/arch/i386/kernel/timers/timer_tsc.c	2003-12-30 00:45:09.000000000 -0800
> @@ -140,7 +140,8 @@ unsigned long long sched_clock(void)
>  #ifndef CONFIG_NUMA
>  	if (!use_tsc)
>  #endif
> -		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
> +		/* jiffies might overflow but this is not a big deal here */
> +		return (unsigned long long)jiffies * (1000000000 / HZ);

Augh. If you cast it to "unsigned long long" anyway, why not just use the 
right value? It's "jiffies_64".

It has other problems, of course, but at least that makes them slightly 
less.

		Linus
