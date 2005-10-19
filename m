Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751547AbVJSHEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbVJSHEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 03:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbVJSHEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 03:04:21 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:18062 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751545AbVJSHEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 03:04:20 -0400
Date: Wed, 19 Oct 2005 00:10:09 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andy Isaacson <adi@hexapodia.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Andi Kleen <ak@suse.de>
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
In-Reply-To: <m1k6gbf102.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0510182358110.13932@montezuma.fsmlabs.com>
References: <20051018070513.GC28997@hexapodia.org> <m1k6gbf102.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Eric W. Biederman wrote:

> Andy Isaacson <adi@hexapodia.org> writes:
> 
> > +static __init void nmi_cpu_busy(void *data)
> > +{
> > +	volatile int *endflag = data;
> > +	local_irq_enable();
> > +	while (*endflag == 0)
> > +		barrier();
> > +}
> >  static int __init check_nmi_watchdog(void)
> >  {
> > +	volatile int endflag = 0;
> > ...
> > +	if (nmi_watchdog == NMI_LOCAL_APIC)
> > +		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
> > ...
> > +	endflag = 1;
> > 	printk("OK.\n");
> >         if (nmi_watchdog == NMI_LOCAL_APIC)
> > 		nmi_hz = 1;
> > +       kfree(prev_nmi_count);
> > 	return 0;
> > }
> 
> Probably a counter, to ensure the code exits.  The code prints

Why not just use the 'wait' variable to smp_call_function to at least 
ensure that the lifetime of endflag isn't exceeded? Something like;

static __init void nmi_cpu_busy(void *data)
{
	volatile int *endflag = data;
	local_irq_enable();
	while (*endflag == 0) {
		cpu_relax();
		rmb();
	}
}

static int __init check_nmi_watchdog(void)
{
	volatile int endflag = 0;
...
	if (nmi_watchdog == NMI_LOCAL_APIC)
		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 1);
...
	endflag = 1;
	wmb();

Thanks,
	Zwane
