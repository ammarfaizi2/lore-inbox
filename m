Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWFYLMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWFYLMh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWFYLMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:12:37 -0400
Received: from mail.gmx.de ([213.165.64.21]:13743 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932359AbWFYLMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:12:36 -0400
X-Authenticated: #5039886
Date: Sun, 25 Jun 2006 13:12:38 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Mike Galbraith <efault@gmx.de>
Cc: danial_thom@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Message-ID: <20060625111238.GB8223@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Mike Galbraith <efault@gmx.de>, danial_thom@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20060622165808.71704.qmail@web33303.mail.mud.yahoo.com> <1151128763.7795.9.camel@Homer.TheSimpsons.net> <1151130383.7545.1.camel@Homer.TheSimpsons.net> <20060624092156.GA13142@atjola.homenet> <1151142716.7797.10.camel@Homer.TheSimpsons.net> <1151149317.7646.14.camel@Homer.TheSimpsons.net> <20060624154037.GA2946@atjola.homenet> <1151166193.8516.8.camel@Homer.TheSimpsons.net> <20060624192523.GA3231@atjola.homenet> <1151211993.8519.6.camel@Homer.TheSimpsons.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1151211993.8519.6.camel@Homer.TheSimpsons.net>
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.06.25 07:06:33 +0200, Mike Galbraith wrote:
> On Sat, 2006-06-24 at 21:25 +0200, Björn Steinbrink wrote:
> > On 2006.06.24 18:23:12 +0200, Mike Galbraith wrote:
> > > 
> > > let's see.  Yeah, confirmed.
> > 
> > OK, it also depends on IO APIC being enabled and active, ie. noapic on
> > the kernel command line will fix it as well as disabling
> > CONFIG_X86_IO_APIC. That doesn't help me at all to understand why it
> > happens though.
> 
> Ditto.
> 
> > The only difference with IO APIC disabled seems to be that the irq
> > doesn't get ACKed before update_process_times() gets called.
> > And your "fix" makes it being called outside of the xtime_lock spinlock
> > and with a slightly different stack usage AFAICT.
> 
> (it's still under the xtime lock)

No, with IO-APIC enabled, it's using the local APIC timer, thus
using_apic_timer is 1 and the path right after unlocking in
timer_interrupt() is taken towards update_process_times().

> > But none of these should make a difference, right?
> 
> Not that I can see, but then it's pretty dark down here.  Anybody got a
> flashlight I can borrow? ;-)

Guess I found one, not sure if it works correctly though ;)

Using 4K stacks, we have one stack for hard irqs and one for soft irqs,
both having their own threadinfo and thus preemptcount. Thus the call to
softirq_count() in account_system_time() will always return 0 when
called in hard irq context. Additionally preemptcount is always set to
HARDIRQ_OFFSET in hard irq context, so
hardirq_count() - hardirq_offset is 0 all the time as well.

But that doesn't fit the fact that I at least get hard irq accounting
when booting with noapic. And it also doesn't explain why your fix
works, fixing both, soft and hard irq accounting. Am I missing some
code path that calls smp_local_timer_interrupt? There's
smp_apic_timer_interrupt(), but that seems to be unused on i386.

Björn
