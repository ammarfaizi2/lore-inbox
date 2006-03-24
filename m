Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWCXIMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWCXIMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 03:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWCXIMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 03:12:20 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:16603 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932368AbWCXIMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 03:12:19 -0500
Date: Fri, 24 Mar 2006 11:11:49 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Yi Yang <yang.y.yi@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
Message-ID: <20060324081149.GC5426@2ka.mipt.ru>
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark> <442349A3.9060907@gmail.com> <1143185750.29668.224.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143185750.29668.224.camel@stark>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Mar 2006 11:11:50 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:35:50PM -0800, Matt Helsley (matthltc@us.ibm.com) wrote:
> I would argue preemption should be disabled around the if-block at the
> very least. Suppose your rate limit is 10k calls/sec and you have 4
> procs. Each proc has a sequence of three instructions:
> 
> load fsevent_sum into register rx (rx <= 1000)
> rx++ (rx <= 1001)
> store contents of register rx in fsevent_sum (fsevent_sum <= 1001)
> 
> 
> Now consider the following sequence of steps:
> 
> load fsevent_sum into rx (rx <= 1000)
> <preempted>
> <3 other processors each manage to increment the sum by 3333 bringing us
> to 9999>
> <resumed>
> rx++ (rx <= 1001)
> store contents of rx in fsevent_sum (fsevent_sum <= 1001)
> 
> So every processor now thinks it won't exceed the rate limit by
> generating more events when in fact we've just exceeded the limit. So,
> unless my example is flawed, I think you need to disable preemption
> here.

Doesn't it just exceed the limit by one event per cpu?

> Also, even if you simply disable preemption couldn't this cause the
> cache line containing the sum to bounce frequently on large SMP systems?
> 
> <snip>
> 
> Cheers,
> 	-Matt Helsley

-- 
	Evgeniy Polyakov
