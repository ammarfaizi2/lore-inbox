Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVHDQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVHDQyD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVHDQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:51:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:3203 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262624AbVHDQuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:50:25 -0400
Date: Thu, 4 Aug 2005 09:50:55 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, rostedt@goodmis.org,
       bhuey@lnxw.com, shemminger@osdl.org, rusty@au1.ibm.com
Subject: Re: [RFC,PATCH] RCU and CONFIG_PREEMPT_RT sane patch
Message-ID: <20050804165054.GA1968@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050801171137.GA1754@us.ibm.com> <20050804141527.GA15447@elte.hu> <20050804144933.GB1297@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804144933.GB1297@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 07:49:33AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 04, 2005 at 04:15:27PM +0200, Ingo Molnar wrote:
> > * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > 
> > Cool! I've merged your patch to the -52-12 version of the -RT patch. You 
> > can get it from the usual place:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > also, i've attached a port against 2.6.13-rc4. I have done this because 
> > the PREEMPT_RCU patch in my tree is applied before the core-PREEMPT_RT 
> > patch. I have fixed up the CONFIG_PREEMPT compilation branch and have 
> > removed your #error define - it built and booted fine on an UP box but 
> > there are no guarantees ...
> 
> Sounds great!!!  I will give it a thorough hammering in both the
> CONFIG_PREEMPT and CONFIG_PREEMPT_RT environments.

A couple of minor things thus far:

o	I get a linker error from V0.7.52-12:

	net/built-in.o(.init.text+0x898): In function `sock_aio_read':
	include/net/sock.h:625: undefined reference to `__you_cannot_kmalloc_that_much'

	This is not making much sense to me, since line 625 of sock.h
	is a small function with a container_of() as its only statement.
	The other other kmalloc() I can find in sock_aio_read() is
	allocating a "struct sock_iocb", which is certainly small enough
	for kmalloc() to handle.

	This may be a problem specific to the machine I compiled on,
	so am retrying on another.  Though that machine had absolutely
	no problem compiling and running V0.7.51-27...

	Enlightenment?

o	I messed up the #ifdefs for CONFIG_PREEMPT_RCU, CONFIG_RCU_STATS,
	and CONFIG_RCU_TORTURE_TEST so that it is not possible to build any
	of the following:

	1.	CONFIG_RCU_STATS without also CONFIG_RCU_TORTURE_TEST.

	2.	CONFIG_RCU_TORTURE_TEST without also CONFIG_RCU_STATS.

	3.	CONFIG_RCU_TORTURE_TEST without also CONFIG_PREEMPT_RCU.
		Which makes it tough to torture-test stock RCU.  ;-)

	Am checking out fixes for these, will post once I have untangled
	and tested.  Does not affect people who are not working directly
	on the RCU infrastructure itself.

							Thanx, Paul
