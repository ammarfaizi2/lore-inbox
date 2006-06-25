Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWFYUpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWFYUpy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFYUpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:45:54 -0400
Received: from web33307.mail.mud.yahoo.com ([68.142.206.122]:22374 "HELO
	web33307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932358AbWFYUpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:45:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PFOLQdTFdoEHEmhzhaaoHvG/q/8MhHoLAo0Ihtj5MN831MMDSQzn3H5vRT6yHEddlJttLVREDxT4c0gMJHdBBCdSfV+oClZCfY1ZiMwl4yfi+CXaVqCuYkzHED5zaRS+t4CI0oZYOIo52JUkmIt9FdyhlvTKDq6XUA51lBvJNEo=  ;
Message-ID: <20060625204553.52734.qmail@web33307.mail.mud.yahoo.com>
Date: Sun, 25 Jun 2006 13:45:53 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: Measuring tools - top and interrupts
To: =?ISO-8859-1?Q?=20=22Bj=F6rn=22?= Steinbrink 
	 <B.Steinbrink@gmx.de>,
       Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060625111238.GB8223@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Björn Steinbrink <B.Steinbrink@gmx.de> wrote:

> On 2006.06.25 07:06:33 +0200, Mike Galbraith
> wrote:
> > On Sat, 2006-06-24 at 21:25 +0200, Björn
> Steinbrink wrote:
> > > On 2006.06.24 18:23:12 +0200, Mike
> Galbraith wrote:
> > > > 
> > > > let's see.  Yeah, confirmed.
> > > 
> > > OK, it also depends on IO APIC being
> enabled and active, ie. noapic on
> > > the kernel command line will fix it as well
> as disabling
> > > CONFIG_X86_IO_APIC. That doesn't help me at
> all to understand why it
> > > happens though.
> > 
> > Ditto.
> > 
> > > The only difference with IO APIC disabled
> seems to be that the irq
> > > doesn't get ACKed before
> update_process_times() gets called.
> > > And your "fix" makes it being called
> outside of the xtime_lock spinlock
> > > and with a slightly different stack usage
> AFAICT.
> > 
> > (it's still under the xtime lock)
> 
> No, with IO-APIC enabled, it's using the local
> APIC timer, thus
> using_apic_timer is 1 and the path right after
> unlocking in
> timer_interrupt() is taken towards
> update_process_times().
> 
> > > But none of these should make a difference,
> right?
> > 
> > Not that I can see, but then it's pretty dark
> down here.  Anybody got a
> > flashlight I can borrow? ;-)
> 
> Guess I found one, not sure if it works
> correctly though ;)
> 
> Using 4K stacks, we have one stack for hard
> irqs and one for soft irqs,
> both having their own threadinfo and thus
> preemptcount. Thus the call to
> softirq_count() in account_system_time() will
> always return 0 when
> called in hard irq context. Additionally
> preemptcount is always set to
> HARDIRQ_OFFSET in hard irq context, so
> hardirq_count() - hardirq_offset is 0 all the
> time as well.
> 
> But that doesn't fit the fact that I at least
> get hard irq accounting
> when booting with noapic. And it also doesn't
> explain why your fix
> works, fixing both, soft and hard irq
> accounting. Am I missing some
> code path that calls smp_local_timer_interrupt?
> There's
> smp_apic_timer_interrupt(), but that seems to
> be unused on i386.
> 
> Björn

I think the one thing we can surmise from this
thread is that you can't rely on kernel usage
statistics to be accurate, as its likely that
there are many, many cases that don't work
properly. It was always wrong in 2.4 as well.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
