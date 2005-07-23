Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVGWTMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVGWTMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVGWTL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 15:11:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:47262 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261339AbVGWTLY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 15:11:24 -0400
Date: Sat, 23 Jul 2005 12:06:26 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}() interfaces
Message-ID: <20050723190626.GA4345@us.ibm.com>
References: <20050707213138.184888000@homer> <20050708160824.10d4b606.akpm@osdl.org> <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain> <Pine.LNX.4.61.0507231247460.3743@scrub.home> <1122116986.3582.7.camel@localhost.localdomain> <Pine.LNX.4.61.0507231340070.3743@scrub.home> <20050723163753.GC4951@us.ibm.com> <Pine.LNX.4.61.0507231854180.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507231854180.3728@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.2005 [19:01:57 +0200], Roman Zippel wrote:
> Hi,
> 
> On Sat, 23 Jul 2005, Nishanth Aravamudan wrote:
> 
> > 	set_current_state(TASK_{,UN}INTERRUPTIBLE);
> > 	schedule_timeout(msecs_to_jiffies(some_constant_msecs));
> > 
> > just have an interface that allows
> > 
> > 	schedule_timeout_msecs_{,un}interruptible(some_constant_msecs);
> > 
> > and push the jiffies conversion to common code?
> 
> What's wrong with just:
> 
> 	schedule_timeout_{,un}interruptible(msecs_to_jiffies(some_constant_msecs));

Nothing, I suppose. I just prefer directly using msecs. I understand
your point more now, I think. You are worried about those people that
actually use the return value of schedule_timeout().

> The majority of users use a constant, which can already be converted at 
> compile tile.
> Additionally such an interface also had to return a ms value and instead 
> of that constant conversion, the user is better off to work with jiffies 
> directly.

So, I just spent a good hour looking at every caller of
schedule_timeout() which actually stores the return value. Beyond the
other wrappers for it (wait_event(), wait_for_completion(),
sys_nanosleep(), etc., which I will leave alone using schedule_timeout()
until I can change *their* parameters ;) ), I found two cases.

1) Sleep, see if you actually slept the whole time:

	remainder = schedule_timeout(some_value_in_jiffies);
	if (!remaining)
		report_timeout();

2) Sleep in a loop, keeping track of remaining timeout each iteration:

	while (timeout) {
		do_some_stuff();
		timeout = schedule_timeout(timeout);
		if (some_condition)
			break;
	}

Clearly, neither needs to use jiffies. The former only wants to know if
the full timeout elapsed. I didn't find anyone returning that stored
value (again, excepting wrapper interfaces) to the caller. They just
want to know if they should return -ETIME{,DOUT}. The latter just is a
means to guarantee the entire time is slept, but doesn't care about the
units.

Now, some of these might depend on structures which have members with
jiffy-unit values. But I will be more than happy to try and either leave
them alone or convert those structures. We'll see about that on a
case-by-case basis?

Thanks,
Nish
