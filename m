Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbVHQGrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbVHQGrD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 02:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVHQGrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 02:47:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55682 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750934AbVHQGrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 02:47:02 -0400
Date: Wed, 17 Aug 2005 08:47:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt6
Message-ID: <20050817064750.GA8395@elte.hu>
References: <1124208507.5764.20.camel@localhost.localdomain> <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu> <20050816165247.GA10386@elte.hu> <20050816170805.GA12959@elte.hu> <1124214647.5764.40.camel@localhost.localdomain> <1124215631.5764.43.camel@localhost.localdomain> <1124218245.5764.52.camel@localhost.localdomain> <1124252419.5764.83.camel@localhost.localdomain> <1124257580.5764.105.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124257580.5764.105.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2005-08-17 at 00:20 -0400, Steven Rostedt wrote:
> > Ingo,
> > 
> > FYI, I ran this on my laptop (Pentium4 HT) and it locked up shortly
> > after it started INIT.  I rebooted, and now it's up and running 
> > with no problems!?!  I'll reboot it a few more times to see if it will
> > lock up again.
> 
> With a small change it locks up all the time :-)

unfortunately the space of "patches that break the kernel" is infinitely 
larger (and infinitely easier to generate) than the space of "patches 
that improve the kernel" - so i'll skip your patch for now ;-)

> > Oh, I also did get the message when it started:
> > 
> > WARNING: kstopmachine/859 changed soft IRQ-flags.
> >  [<c0149e0b>] stop_machine+0x11b/0x160 (8)
> >  [<c0149e7e>] do_stop+0xe/0x70 (32)
> >  [<c0139c5a>] kthread+0xba/0xc0 (16)
> >  [<c0139ba0>] kthread+0x0/0xc0 (28)
> >  [<c0101385>] kernel_thread_helper+0x5/0x10 (16)
> 
> I replaced this with raw_local_irq_disable and it really locks up 
> everytime now.  I need to look into how this is best done.

how come it is stopping the machine during bootup? Or does the lockup 
occur during shutdown? changing the local_irq_disable() to 
raw_local_irq_disable() looks wrong because sooner or later we hit 
complete(). You are probably locking up earlier than that though, 
perhaps in stopmachine_set_state()?

but stop_machine() looks quite preempt-unsafe to begin with. The 
local_irq_disable() would not be needed at all if prior the 
for_each_online_cpu() loop we'd use set_cpus_allowed. The current method 
of achieving 'no preemption' is simply racy even during normal 
CONFIG_PREEMPT.

	Ingo
