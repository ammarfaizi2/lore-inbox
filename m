Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWFSTzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWFSTzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWFSTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:55:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964871AbWFSTzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:55:45 -0400
Date: Mon, 19 Jun 2006 12:55:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to
 1 min
Message-Id: <20060619125531.4c72b8cc.akpm@osdl.org>
In-Reply-To: <20060619113943.GA18321@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
	<20060617100710.ec05131f.akpm@osdl.org>
	<20060619070229.GA8293@elte.hu>
	<20060619005955.b05840e8.akpm@osdl.org>
	<20060619081252.GA13176@elte.hu>
	<20060619013238.6d19570f.akpm@osdl.org>
	<20060619083518.GA14265@elte.hu>
	<20060619021314.a6ce43f5.akpm@osdl.org>
	<20060619113943.GA18321@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 13:39:44 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > The write_trylock + __delay in the loop is not a problem or a bug, as 
> > > the trylock will at most _increase_ the delay - and our goal is to not 
> > > have a false positive, not to be absolutely accurate about the 
> > > measurement here.
> > 
> > Precisely.  We have delays of over a second (but we don't know how 
> > much more than a second).  Let's say two seconds.  The NMI watchdog 
> > timeout is, what?  Five seconds?
> 
> i dont see the problem.

It's taking over a second to acquire a write_lock.  A lock which is
unlikely to be held for more than a microsecond anywhere.  That's really
bad, isn't it?  Being on the edge of an NMI watchdog induced system crash
is bad, too.

> We'll have tried that lock hundreds of thousands 
> of times before this happens. The NMI watchdog will only trigger if we 
> do this with IRQs disabled.

tree_lock uses write_lock_irq().

> And it's not like the normal 
> __write_lock_failed codepath would be any different: for heavily 
> contended workloads the overhead is likely in the cacheline bouncing, 
> not in the __delay().

Yes, it might also happen with !CONFIG_DEBUG_SPINLOCK.  We need to find out
if that's so and if so, why.

> > That's getting too close.  The result will be a total system crash.  
> > And RH are shipping this.
> 
> I dont see a connection. Pretty much the only thing the loop condition 
> impacts is the condition under which we print out a 'i think we 
> deadlocked' message.

I'm assuming that the additional delay in the debug code has worsened the
situation.

> Have i missed your point perhaps?

I get that impression ;) If it takes 1-2 seconds to get this lock then it
can take five seconds.  a) that's just gross and b) the NMI watchdog will
nuke the box.

Why is it taking so long to get the lock?

Does it happen in non-debug mode?

What do we do about it?
