Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVCTV6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVCTV6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCTV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:58:05 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:58126 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261294AbVCTV5k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:57:40 -0500
Date: Sun, 20 Mar 2005 13:59:38 -0800
To: Bill Huey <bhuey@lnxw.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, tglx@linutronix.de,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       dipankar@in.ibm.com, shemminger@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, gh@us.ibm.com,
       LKML <linux-kernel@vger.kernel.org>, "Bill Huey (hui)" <bhuey@lnxw.com>
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050320215938.GB23167@nietzsche.lynx.com>
References: <20050318002026.GA2693@us.ibm.com> <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu> <423BB299.4010906@colorfullife.com> <20050319162601.GA28958@elte.hu> <423D19FE.7020902@colorfullife.com> <1111310736.17944.24.camel@tglx.tec.linutronix.de> <423DAB73.2030904@colorfullife.com> <20050320213824.GA23167@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320213824.GA23167@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 01:38:24PM -0800, Bill Huey wrote:
> On Sun, Mar 20, 2005 at 05:57:23PM +0100, Manfred Spraul wrote:
> > That was just one random example.
> > Another one would be :
> > 
> > drivers/chat/tty_io.c, __do_SAK() contains
> >    read_lock(&tasklist_lock);
> >    task_lock(p);
> > 
> > kernel/sys.c, sys_setrlimit contains
> >    task_lock(current->group_leader);
> >    read_lock(&tasklist_lock);
> > 
> > task_lock is a shorthand for spin_lock(&p->alloc_lock). If read_lock is 
> > a normal spinlock, then this is an A/B B/A deadlock.
> 
> That code was already dubious in the first place just because it
> contained that circularity. If you had a rwlock that block on an
> upper read count maximum[,] a deadlock situation would trigger anyways,
> say, upon a flood of threads trying to do that sequence of aquires.

The RT patch uses the lock ordering "in place" and whatevery nasty
situation was going on previously will be effectively under high load,
which increases the chance of it being triggered. Removal of the read
side semantic just increases load more so that those cases can trigger.

I disagree with this approach and I have an alternate implementation
here that restores it. It's only half tested and fairly meaningless
until an extreme contention case is revealed with the current rt lock
implementation. Numbers need to be gather to prove or disprove this
conjecture.

> I'd probably experiment with using the {spin,read,write}-trylock
> logic and release the all locks contains in a sequence like that
> on the failure to aquire any of the locks in the chain as an
> initial fix. A longer term fix might be to break things up a bit
> so that whatever ordering being done would have that circularity.

Excuse me, ...would *not* have that circularity.

bill

