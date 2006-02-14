Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWBNBOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWBNBOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 20:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWBNBOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 20:14:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47030 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750828AbWBNBOJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 20:14:09 -0500
Subject: Re: [BUG -rt] -rt16 hang w/ realtime thread test
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0602111033400.13041@gandalf.stny.rr.com>
References: <1139626674.28536.30.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0602111033400.13041@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 17:14:06 -0800
Message-Id: <1139879647.28536.127.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-11 at 10:34 -0500, Steven Rostedt wrote:
> On Fri, 10 Feb 2006, john stultz wrote:
> 
> > Hey Ingo,
> > 	I've been hunting a report that lower priority realtime threads are not
> > preempting higher priority realtime threads. However, in generating test
> > cases, I found I was locking the system quite frequently.
> >
> > The attached test runs to completion on 2.6.15, but with 2.6.15-rt16, it
> > hangs the box. It could very well be a test issue, but I'm not sure I
> > see where the problem is.
> 
> Have you turned on nmi_watchdog and softlockup detect?  Just so we can see
> where it is hung.

With both of those enabled, I get nothing.

The only thing I could trigger was with Ingo's lock debugging, I got the
following at bootup, although I doubt its the problem.


sleeping function called from invalid context modprobe(2917) at
mm/slab.c:2134
in_atomic():1 [00000002], irqs_disabled():0
 [<c011af7a>] __might_sleep+0xcf/0xda (8)  
 [<c015da2e>] kmem_cache_alloc+0x1c/0xaf (40)
 [<c02b8b5b>] __alloc_skb+0x29/0x11f (20)    
 [<f8a7d6d8>] inet6_rt_notify+0x52/0x105 [ipv6] (28)
 [<f8a7decb>] fib6_add_rt2node+0x11d/0x145 [ipv6] (24)
 [<f8a7df52>] fib6_add+0x3f/0xb0 [ipv6] (36)          
 [<f8a7b380>] ip6_ins_rt+0x26/0x3a [ipv6] (24)
 [<f8a79cdd>] __ipv6_ifa_notify+0x3f/0x11e [ipv6] (24)
 [<f8a79de4>] ipv6_ifa_notify+0x28/0x34 [ipv6] (16)   
 [<f8a77d49>] init_loopback+0x93/0xaa [ipv6] (12)  
 [<f8a78027>] addrconf_notify+0xb1/0x196 [ipv6] (12)
 [<c02bd3da>] register_netdevice_notifier+0x42/0x52 (20)
 [<f881a2ed>] addrconf_init+0x60/0xb2 [ipv6] (16)       
 [<f881a197>] inet6_init+0x131/0x1d3 [ipv6] (8)  
 [<c013cb1c>] sys_init_module+0xa9/0x1d7 (8)   
 [<c01029ef>] sysenter_past_esp+0x54/0x75 (12)
---------------------------                   
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c03166d5>] .... _raw_read_lock+0xd/0x1c
.....[<00000000>] ..   ( <= _stext+0x3feffd68/0x3e)
.. [<c0316838>] .... _raw_write_lock+0xd/0x1f      
.....[<00000000>] ..   ( <= _stext+0x3feffd68/0x3e)
                                                   
------------------------------
| showing all locks held by: |  (modprobe/2917 [f798f7d0, 117]):
------------------------------                                  
                              
#001:             [c03bba44] {rtnl_sem.lock}
... acquired at:               register_netdevice_notifier+0xa/0x52


thanks
-john

