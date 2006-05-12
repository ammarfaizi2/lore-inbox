Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWELIQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWELIQr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 04:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWELIQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 04:16:47 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42928 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750814AbWELIQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 04:16:46 -0400
Date: Fri, 12 May 2006 10:16:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Hounschell <markh@compro.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt20 patch question
Message-ID: <20060512081628.GA26736@elte.hu>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605101556580.22959@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> I traced this down.  It is caused by the disable_irq in vortex_timer 
> that is called via run_timer_softirq.
> 
> disable_irq can call synchronize_irq which can schedule.
> 
> And thus you get this bug since we are in a softirq.

hm. When there are threaded interrupts, we quite naturally have to 
synchronize via scheduling, in synchronize_irq() - the interrupt we are 
waiting on might be scheduled away!

> So I guess we have a case that we can schedule, but while atomic and 
> BUG when it's really not bad.  Should we add something like this:

that's not good enough, we must not schedule with the preempt_count() 
set.

one solution would be to forbid disable_irq() from softirq contexts, and 
to convert the vortex timeout function to a workqueue and use the 
*_delayed_work() APIs to drive it - and cross fingers there's not many 
places to fix.

another solution would be to make softirqs preemptible if they are 
threaded. I'm a bit uneasy about that though. In that case we'd also 
have to make HARDIRQ threading dependent on softirq threading, in the 
Kconfig.

	Ingo
