Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTLLHAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 02:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTLLHAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 02:00:53 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:33446 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264493AbTLLHAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 02:00:51 -0500
Message-ID: <3FD9679A.1020404@cyberone.com.au>
Date: Fri, 12 Dec 2003 18:00:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031212052812.E016B2C072@lists.samba.org>
In-Reply-To: <20031212052812.E016B2C072@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>In message <3FD7F1B9.5080100@cyberone.com.au> you write:
>
>>http://www.kerneltrap.org/~npiggin/w26/
>>Against 2.6.0-test11
>>
>>This includes the SMT description for P4. Initial results shows comparable
>>performance to Ingo's shared runqueue's patch on a dual P4 Xeon.
>>
>
>I'm still not convinced.  Sharing runqueues is simple, and in fact
>exactly what you want for HT: you want to balance *runqueues*, not
>CPUs.  In fact, it can be done without a CONFIG_SCHED_SMT addition.
>
>Your patch is more general, more complex, but doesn't actually seem to
>buy anything.  It puts a general domain structure inside the
>scheduler, without putting it anywhere else which wants it (eg. slab
>cache balancing).  My opinion is either (1) produce a general NUMA
>topology which can then be used by the scheduler, or (2) do the
>minimal change in the scheduler which makes HT work well.
>
>Note: some of your changes I really like, it's just that I think this
>is overkill.
>
>I'll produce a patch so we can have something solid to talk about.
>

Thanks for having a look Rusty. I'll try to convince you :)

As you know, the domain classes is not just for HT, but can do multi levels
of NUMA, and it can be built by architecture specific code which is good
for Opteron, for example. It doesn't need CONFIG_SCHED_SMT either, of 
course,
or CONFIG_NUMA even: degenerate domains can just be collapsed (code isn't
there to do that now).

Shared runqueues I find isn't so flexible. I think it perfectly describes
the P4 HT architecture, but what happens if (when) siblings get seperate
L1 caches? What about SMT, CMP, SMP and NUMA levels in the POWER5?

The large SGI (and I imagine IBM's POWER5s) systems need things like
progressive balancing backoff and would probably benefit with a more
heirachical balancing scheme so all the balancing operations don't kill
the system.

w26 does ALL this, while sched.o is 3K smaller than Ingo's shared runqueue
patch on NUMA and SMP, and 1K smaller on UP (although sched.c is 90 lines
longer). kernbench system time is down nearly 10% on the NUMAQ, so it isn't
hurting performance either.

And finally, Linus also wanted the balancing code to be generalised to
handle SMT, and Ingo said he liked my patch from a first look.


