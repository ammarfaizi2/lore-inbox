Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbUAFQeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUAFQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:32:10 -0500
Received: from [139.30.44.16] ([139.30.44.16]:4744 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264522AbUAFQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:31:25 -0500
Date: Tue, 6 Jan 2004 17:30:39 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>, johnstultz@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <20040106081947.3d51a1d5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0401061727270.8423@gockel.physik3.uni-rostock.de>
References: <1073405053.2047.28.camel@mulgrave> <20040106081947.3d51a1d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Andrew Morton wrote:

> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> >
> > This patch
> > 
> > 
> >  ChangeSet@1.1534.5.2, 2003-12-30 15:40:23-08:00, akpm@osdl.org
> >    [PATCH] ia32 jiffy wrapping fixes
> > 
> >  Causes the voyager boot to hang.  The problem is this change:
> > 
> >  --- a/arch/i386/kernel/timers/timer_tsc.c       Tue Jan  6 09:57:34 2004
> >  +++ b/arch/i386/kernel/timers/timer_tsc.c       Tue Jan  6 09:57:34 2004
> >  @@ -141,7 +140,7 @@
> >   #ifndef CONFIG_NUMA
> >          if (!use_tsc)
> >   #endif
> >  -               return (unsigned long long)jiffies * (1000000000 / HZ);
> >  +               return (unsigned long long)get_jiffies_64() *
> >  (1000000000 / HZ);
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
>  
>  	/* Read the Time Stamp Counter */
>  	rdtscll(this_offset);

Yes, please revert that change. When I tested it, I didn't realize I need 
NUMA or clear use_tsc to actually cover the change. And it's indeed not a 
big deal.

The proposed get_jiffies_64() change however looks quite fragile to me.

Sorry,
Tim
