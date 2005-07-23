Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVGWQiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVGWQiG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 12:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVGWQiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 12:38:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6641 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262378AbVGWQhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 12:37:53 -0400
Date: Sat, 23 Jul 2005 09:37:53 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723163753.GC4951@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507231340070.3743@scrub.home>
X-Operating-System: Linux 2.6.13-rc3-mm1 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [13:55:58 +0200], Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Arjan van de Ven wrote:
> 
> > > What's wrong with using jiffies? 
> > 
> > A lot of the (driver) users want a wallclock based timeout. For that,
> > miliseconds is a more obvious API with less chance to get the jiffies/HZ
> > conversion wrong by the driver writer.
> 
> We have helper functions for that. The point about using jiffies is to 
> make it _very_ clear, that the timeout is imprecise and for most users 
> this is sufficient.

We do have helper functions for human-time <-> jiffies (I keep adding
new ones :) ). But why not, instead of

	set_current_state(TASK_{,UN}INTERRUPTIBLE);
	schedule_timeout(msecs_to_jiffies(some_constant_msecs));

just have an interface that allows

	schedule_timeout_msecs_{,un}interruptible(some_constant_msecs);

and push the jiffies conversion to common code?

There are some 300 or so users of schedule_timeout() in 2.6.12. I would
say about half are doing something along the lines of

	set_current_state(TASK_{,UN}INTERRUPTIBLE);
	schedule_timeout(HZ/some_constant);

These would be replaced with

	schedule_timeout_msecs_{,un}interruptible(1000/some_constant);

I would *not* be changing the callers that do

	set_current_state(TASK_{,UN}INTERRUPTIBLE);
	schedule_timeout(some_other_constant);

even though I think most of these are 2.4 remnants that don't need
short, e.g.  1 or 2 timer interrupt, sleeps, but actually can use a 10
or 20 millisecond (HZ=100, 1 or 2 jiffies) sleep.

This emphasizes another advantage of adding these new interfaces, the
delay requested does not change with HZ. Internally it does, certainly,
but the callers don't need to know that :)

Thanks,
Nish
