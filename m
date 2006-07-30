Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWG3JKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWG3JKx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWG3JKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:10:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932099AbWG3JKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:10:52 -0400
Date: Sun, 30 Jul 2006 02:03:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: ak@muc.de, smurf@smurf.noris.de, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, bunk@stusta.de, lethal@linux-sh.org,
       hirofumi@mail.parknet.co.jp, asit.k.mallick@intel.com
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-Id: <20060730020346.5d301bb5.akpm@osdl.org>
In-Reply-To: <1153774443.12836.6.camel@localhost>
References: <20060722233638.GC27566@kiste.smurf.noris.de>
	<20060722173649.952f909f.akpm@osdl.org>
	<20060723081604.GD27566@kiste.smurf.noris.de>
	<20060723044637.3857d428.akpm@osdl.org>
	<20060723120829.GA7776@kiste.smurf.noris.de>
	<20060723053755.0aaf9ce0.akpm@osdl.org>
	<1153756738.9440.14.camel@localhost>
	<20060724171711.GA3662@kiste.smurf.noris.de>
	<20060724175150.GD50320@muc.de>
	<1153774443.12836.6.camel@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 13:54:03 -0700
john stultz <johnstul@us.ibm.com> wrote:

> On Mon, 2006-07-24 at 19:51 +0200, Andi Kleen wrote:
> > On Mon, Jul 24, 2006 at 07:17:11PM +0200, Matthias Urlichs wrote:
> > > You can probably assume that they're synced on systems with no more
> > > than one dual-core / hyperthreaded CPU.
> > > 
> > > My system obviously has two of those.
> > 
> > According to Intel on all of their chipsets/motherboard reference
> > designs all the sockets run from a single clock crystal.
> > 
> > I've confirmed this for a long time on 64bit and even to some
> > extent on 32bit on distro kernels.
> 
> Andi: Which 32bit distro patch are you referring to here?
> 
> > Maybe you got a broken BIOS or similar though.
> > 
> > > > Matthias: "clock=pmtmr" is probably the best workaround in the short
> > > > term. Could you send me your dmesg and dmidecode output? We'll try to
> > > > find something to key off of so it will mark the tsc as unstable by
> > > > default on your system.
> > > > 
> > > I'd assume that finding (and, possibly, being unable to correct) TSC skew 
> > 
> > The BIOS normally guarantee it at boot. However maybe you got a broken one.
> > 
> > We used to do TSC sync correction at boot on Intel, but stopped doing 
> > that when we found out that the TSC sync code adds an error
> > To an already perfectly synchronized system.
> > 
> > Actually I think i386 still does it, just x86-64 stopped 
> 
> Indeed i386 still does it. I knew x86-64 had a new ia64 inspired
> algorithm, but I didn't realize that they didn't even try to call it in
> most cases.
> 
> The (untested) patch below will disable it on i386. Matthias, mind
> trying it out to see if the TSC sync code is causing the problem?
> 
> 
> > My first assumption would be that you hit a bug somewhere in the new
> > clock code. What happens when you boot an older kernel (like 2.6.17)
> > with clock=tsc ? 
> 
> Yes, that would be good to confirm the issue. :)
> 
> thanks
> -john
> 
> 
> Hack out the i386 TSC sync code.
> 
> 
> diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
> index 6f5fea0..cd28914 100644
> --- a/arch/i386/kernel/smpboot.c
> +++ b/arch/i386/kernel/smpboot.c
> @@ -435,7 +435,7 @@ static void __devinit smp_callin(void)
>  	/*
>  	 *      Synchronize the TSC with the BP
>  	 */
> -	if (cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
> +	if (0 && cpu_has_tsc && cpu_khz && !tsc_sync_disabled)
>  		synchronize_tsc_ap();
>  }
>  
> @@ -1305,7 +1305,7 @@ static void __init smp_boot_cpus(unsigne
>  	/*
>  	 * Synchronize the TSC with the AP
>  	 */
> -	if (cpu_has_tsc && cpucount && cpu_khz)
> +	if (0 && cpu_has_tsc && cpucount && cpu_khz)
>  		synchronize_tsc_bp();
>  }

I guess Matthias didn't test this patch.  Can we get some obviously-correct
fix in place for 2.6.18?

Also, I was rather hoping we'd be able to work out why write_tsc() isn't
working on this CPU.  If that's fixable, that would be the best fix for
this bug, no?

It is a "CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03".

