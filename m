Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWFXTZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWFXTZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWFXTZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:25:24 -0400
Received: from mail.gmx.net ([213.165.64.21]:37563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751055AbWFXTZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:25:24 -0400
X-Authenticated: #5039886
Date: Sat, 24 Jun 2006 21:25:23 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Cc: danial_thom@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060624192523.GA3231@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Mike Galbraith <efault@gmx.de>, danial_thom@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com> <1151128763.7795.9.camel@Homer.TheSimpsons.net> <1151130383.7545.1.camel@Homer.TheSimpsons.net> <20060624092156.GA13142@atjola.homenet> <1151142716.7797.10.camel@Homer.TheSimpsons.net> <1151149317.7646.14.camel@Homer.TheSimpsons.net> <20060624154037.GA2946@atjola.homenet> <1151166193.8516.8.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1151166193.8516.8.camel@Homer.TheSimpsons.net>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.24 18:23:12 +0200, Mike Galbraith wrote:
> On Sat, 2006-06-24 at 17:40 +0200, Björn Steinbrink wrote:
> > On 2006.06.24 13:41:57 +0200, Mike Galbraith wrote:
> > > On Sat, 2006-06-24 at 11:52 +0200, Mike Galbraith wrote:
> > > > On Sat, 2006-06-24 at 11:21 +0200, Björn Steinbrink wrote:
> > > > > 
> > > > > The non-SMP call to update_process_times() is in do_timer_interrupt_hook(),
> > > > > so I guess the above is not the Right Thing to do.
> > > > 
> > > > Ah, there it is.  That's what I was looking for.  I figured that doing
> > > > what I did had to be wrong, but tried it for grins anyway... was pretty
> > > > surprised when it worked (kinda).
> > > 
> > > Calling update_process_times() in do_timer_interrupt_hook() flat does
> > > not work here.  Calling it in smp_local_timer_interrupt() works fine.  
> > > 
> > > Oh joy.
> > 
> > I can reproduce it now, seems to require CONFIG_4KSTACKS to fail. Can
> > you confirm that?
> 
> What a coincidence.  After trying a different compiler, and slogging
> through a bunch of assembler trying to figure out how the heck this can
> happen, I was just booting an 8k stack kernel (as a wild-ass guess;).
> 
> let's see.  Yeah, confirmed.

OK, it also depends on IO APIC being enabled and active, ie. noapic on
the kernel command line will fix it as well as disabling
CONFIG_X86_IO_APIC. That doesn't help me at all to understand why it
happens though.
The only difference with IO APIC disabled seems to be that the irq
doesn't get ACKed before update_process_times() gets called.
And your "fix" makes it being called outside of the xtime_lock spinlock
and with a slightly different stack usage AFAICT.
But none of these should make a difference, right?

Björn
