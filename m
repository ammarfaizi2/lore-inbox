Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVHTAfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVHTAfk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVHTAfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:35:39 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:29642
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965206AbVHTAfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:35:39 -0400
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <43067713.4040700@mvista.com>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43067713.4040700@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 20 Aug 2005 02:36:12 +0200
Message-Id: <1124498172.23647.606.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George,

On Fri, 2005-08-19 at 17:19 -0700, George Anzinger wrote:
> > 2. Drift of cyclic timers (armed by set_timer()):
> > 
> > Due to rounding errors and the drift adjustment code, the fixed
> > increment which is precalculated when the timer is set up and added on
> > rearm, I see creeping deviation from the timeline. 
> > 
> > I have a patch lined up to base the rearm on human (nsac) units, so this
> > effect will go away. But this is waste of time until (1.) is not solved.
> > 
> > George ???
> 
> Could I (we) see what you have in mind?

Nothing which applies clean at the moment and I have no access to the
box where the patch floats around.

It's simply explained.

Current code:

set_timer()
	calc interval->jiffies / interval->arch_cycles;
	based on it.interval

rearm()
	timer->expires += interval->jiffies;
	timer->arch_cycle_expires += interval->arch_cycles;
	normalize(timer);

Patched code:

set_timer()
	timer.interval = it.interval; 
	timer.next_expire = it.value; 
	both stored as timespec

rearm()
	next_expire += interval;
	calc timer->expires/arch_cycle_expires;
	
So on each rearm we eliminate the rounding errors and take the drift
adjustment into account.

It adds some calculation overhead to each rearm, but ....

tglx


