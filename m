Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422967AbWCXB0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422967AbWCXB0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbWCXB0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:26:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422967AbWCXB0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:26:04 -0500
Date: Thu, 23 Mar 2006 17:28:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: ak@muc.de, Rafal.Wysocki@fuw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-Id: <20060323172805.00926c13.akpm@osdl.org>
In-Reply-To: <1143161390.2299.36.camel@leatherman>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<200603232317.50245.Rafal.Wysocki@fuw.edu.pl>
	<20060323160426.153fbea9.akpm@osdl.org>
	<1143161390.2299.36.camel@leatherman>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> wrote:
>
> On Thu, 2006-03-23 at 16:04 -0800, Andrew Morton wrote:
> > "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
> > >
> > > On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> > > 
> > > On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> > > just fine, .config attached):
> > 
> > hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.
> > 
> > > }-- snip --{
> > > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > > time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> > > time.c: Detected 1795.400 MHz processor.
> > > disabling early console
> > > Console: colour dummy device 80x25
> > > time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
> > > last cli 0x0
> > > last cli caller 0x0
> > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > > last cli 0x0
> > > last cli caller 0x0
> > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> 
> It seems report_lost_ticks has been set to one w/ 2.6.16-mm1, thus these
> debug messages will be shown.
> 
> Rafael: To properly compare, could you boot 2.6.16-rc6-mm2 w/ the
> "report_lost_ticks" boot option and see if the same sort of messages do
> not appear?

<looks>

OK, we have an andi-easter-egg:
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/x86_64-mm-lost-cli-debug.patch.

So you're right, it's not the time patches.  I just blame you whenever anything
time-related goes wrong - who else is there? ;)

The above patch records the most-recent caller of local_irq_disable() in a
global variable, then prints that out in the lost-ticks handler.  But how
do we know that the global didn't get overwritten between the most-recent
local_irq_enable() and the call to handle_lost_ticks()?

I guess the code assumes that the local_irq_enable() will result in
insta-entry into the timer IRQ handler.  Which is probably good enough, as
interrupts from other sources won't be pending most times.

So why did we lose three ticks after __do_sortirq()'s local_irq_disable()? 
Dunno.

I think a better debugging patch would be:

u64 timestamp[NR_CPUS];

local_irq_disable()
{
	cli;
	timestamp[me] = rdtslcc();
}

local_irq_enable()
{
	if (rdtscll() - timestamp[me] > enough)
		whine();
	sti;
}

(Is there any point in do_softirq() doing local_irq_save() instead of
local_irq_disable()?  __do_softirq() will unconditionally enable anyway..)


