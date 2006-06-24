Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933364AbWFXJsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbWFXJsO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933374AbWFXJsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:48:14 -0400
Received: from mail.gmx.net ([213.165.64.21]:42381 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S933364AbWFXJsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:48:13 -0400
X-Authenticated: #14349625
Subject: Re: Measuring tools - top and interrupts
From: Mike Galbraith <efault@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: danial_thom@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060624092156.GA13142@atjola.homenet>
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com>
	 <1151128763.7795.9.camel@Homer.TheSimpsons.net>
	 <1151130383.7545.1.camel@Homer.TheSimpsons.net>
	 <20060624092156.GA13142@atjola.homenet>
Content-Type: text/plain; charset=utf-8
Date: Sat, 24 Jun 2006 11:51:56 +0200
Message-Id: <1151142716.7797.10.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 11:21 +0200, Björn Steinbrink wrote:
> On 2006.06.24 08:26:23 +0200, Mike Galbraith wrote:
> > On Sat, 2006-06-24 at 07:59 +0200, Mike Galbraith wrote:
> > > On Thu, 2006-06-22 at 09:58 -0700, Danial Thom wrote:
> > > 
> > > > And 75K pps may not be "much", but its still at
> > > > least 10% of what the system can handle, so it
> > > > should measure around a 10% load. 2.4 measures
> > > > about 12% load. So the only conclusion is that
> > > > load accounting is broken in 2.6.
> > > 
> > > For UP, yes.  SMP kernel accounts irq processing time properly.
> 
> Do you actually see 100% idle?

Yes.

>  On both, UP and SMP, I see non-zero hi/si
> values using "top". With IO-APIC enabled, I see only non-zero si values
> for my tg3 NICs, and non-zero hi and si values for the nVidia NIC. With
> IO-APIC disabled, I also see a non-zero hi value for the tg3 on UP,
> guess that's normal... But I never see 100% idle while flooding the box
> with pings.

I have APIC and IO-APIC enabled.

> > For my little box, the below cures it.
> > 
> > --- linux-2.6.17x/arch/i386/kernel/apic.c.org	2006-06-24 08:08:46.000000000 +0200
> > +++ linux-2.6.17x/arch/i386/kernel/apic.c	2006-06-24 08:09:16.000000000 +0200
> > @@ -1175,9 +1175,7 @@ EXPORT_SYMBOL(switch_ipi_to_APIC_timer);
> >  inline void smp_local_timer_interrupt(struct pt_regs * regs)
> >  {
> >  	profile_tick(CPU_PROFILING, regs);
> > -#ifdef CONFIG_SMP
> >  	update_process_times(user_mode_vm(regs));
> > -#endif
> >  
> >  	/*
> >  	 * We take the 'long' return path, and there every subsystem
> 
> The non-SMP call to update_process_times() is in do_timer_interrupt_hook(),
> so I guess the above is not the Right Thing to do.

Ah, there it is.  That's what I was looking for.  I figured that doing
what I did had to be wrong, but tried it for grins anyway... was pretty
surprised when it worked (kinda).

	-Mike

