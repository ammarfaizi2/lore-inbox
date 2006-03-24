Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWCXJza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWCXJza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWCXJza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:55:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:14828 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422822AbWCXJz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:55:29 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Yi Yang <yang.y.yi@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
In-Reply-To: <20060324081149.GC5426@2ka.mipt.ru>
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark>
	 <442349A3.9060907@gmail.com> <1143185750.29668.224.camel@stark>
	 <20060324081149.GC5426@2ka.mipt.ru>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 01:42:17 -0800
Message-Id: <1143193337.29668.241.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 11:11 +0300, Evgeniy Polyakov wrote:
> On Thu, Mar 23, 2006 at 11:35:50PM -0800, Matt Helsley (matthltc@us.ibm.com) wrote:
> > I would argue preemption should be disabled around the if-block at the
> > very least. Suppose your rate limit is 10k calls/sec and you have 4
> > procs. Each proc has a sequence of three instructions:
> > 
> > load fsevent_sum into register rx (rx <= 1000)
> > rx++ (rx <= 1001)
> > store contents of register rx in fsevent_sum (fsevent_sum <= 1001)
> > 
> > 
> > Now consider the following sequence of steps:
> > 
> > load fsevent_sum into rx (rx <= 1000)
> > <preempted>
> > <3 other processors each manage to increment the sum by 3333 bringing us
> > to 9999>
> > <resumed>
> > rx++ (rx <= 1001)
> > store contents of rx in fsevent_sum (fsevent_sum <= 1001)
> > 
> > So every processor now thinks it won't exceed the rate limit by
> > generating more events when in fact we've just exceeded the limit. So,
> > unless my example is flawed, I think you need to disable preemption
> > here.
> 
> Doesn't it just exceed the limit by one event per cpu?

The example exceeds it by one at the time of the final store. Thanks to
the fact that the value is then 1001 it may shortly be exceeded by much
more than 1.

Cheers,
	-Matt Helsley

