Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424416AbWKPVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424416AbWKPVGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424615AbWKPVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:06:50 -0500
Received: from mail.timesys.com ([65.117.135.102]:32211 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1424572AbWKPVGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:06:50 -0500
Subject: Re: BUG: cpufreq notification broken
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Miller <davem@davemloft.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.44L0.0611161515430.2399-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0611161515430.2399-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 22:09:28 +0100
Message-Id: <1163711368.10333.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 15:27 -0500, Alan Stern wrote:
> > Hmm, there are no static initializers for srcu and the only way to fix
> > this up is to move the arch calls to postcore_init.
> 
> If you can find a way to invoke init_cpufreq_transition_notifier_list 
> earlier than core_initcall time, that would be okay.  I did it this way 
> because it was easiest, but earlier should be just as good.
> 
> The only requirement is that alloc_percpu() has to be working, so that the 
> SRCU per-cpu data values can be set up.  I don't know how early in the 
> boot process you can do per-cpu memory allocation.
> 
> As an alternative approach, initialization of srcu_notifiers could be 
> broken up into two pieces, one of which could be done statically.  The 
> part that has to be done dynamically (the SRCU initialization) wouldn't 
> mess up the notifier chain.  Provided the dynamic part is carried out 
> while the system is still single-threaded, it would be safe.

There is another issue with this SRCU change:

The notification comes actually after the real change, which is bad. We
try to make the TSC usable by backing it with pm_timer accross such
states, but this behaviour breaks the safety code.

	tglx




	

