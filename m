Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274515AbRITOYU>; Thu, 20 Sep 2001 10:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274519AbRITOYK>; Thu, 20 Sep 2001 10:24:10 -0400
Received: from donna.siteprotect.com ([64.41.120.44]:14600 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S274515AbRITOYB>; Thu, 20 Sep 2001 10:24:01 -0400
Date: Thu, 20 Sep 2001 10:24:15 -0400 (EDT)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: Kurt Garloff <garloff@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [prelim-PATCH] Enable SSE on K7 without BIOS support.
In-Reply-To: <20010920135943.X9551@gum01m.etpnet.phys.tue.nl>
Message-ID: <Pine.LNX.4.33.0109201016330.1821-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Kurt Garloff wrote:

> On Wed, Sep 19, 2001 at 11:30:41PM -0400, John Clemens wrote:
> > diff -u --recursive linux-orig/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
> > --- linux-orig/arch/i386/kernel/setup.c	Wed Sep 19 22:49:11 2001
> > +++ linux/arch/i386/kernel/setup.c	Wed Sep 19 22:51:34 2001
> > @@ -1272,6 +1272,14 @@
> >
> >  		case 6:	/* An Athlon/Duron. We can trust the BIOS probably */
> >  			mcheck_init(c);
> > +			if (c->x86_model == 6 || c->x86_model == 7) {
> > +			        rdmsr(MSR_K7_HWCR, l, h);
> > +				if ( (h|l) != 0 ) {
> > +					printk(KERN_INFO "Palomino/Morgan: Enabling K7/SSE support (your BIOS didn't..)\n");
> > +					wrmsr(MSR_K7_HWCR, 0, 0);
> > +					set_bit(X86_FEATURE_XMM, &c->x86_capability);
>
> After you enabled it via HWCR, cpuid should report the SSE capability, no?
> You should check it and not unconditionally enable XMM/SSE support flag,
> otherwise it may break on some CPU models.

I think that's a redundant check, as all model 6 and 7 Athlon's are
supposed to support SSE, and we already check for that... Unless someone
from AMD would like to correct me..?

However, I should use the cpuid feature flag to check and see if it's
enabled rather than testing that register for 0.  I'm very leary about
that, as it probably smashes other things.  I'll do some more testing
tonight.

For example, I noticed that with my patch, suddenly the APIC is enabled
(shows up in feature flags and kernel goes "BIOS disabled APIC,
reenabling" on boot)..  This is very strange...

john.c

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


