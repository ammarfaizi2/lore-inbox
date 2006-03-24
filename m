Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWCXOEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWCXOEP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWCXOEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:04:15 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:15079 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932600AbWCXOEO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:04:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GThgciQLrW81Y9q8/JIHU45jNWipzSTmTpv5EYJSQ7YiqjjqJNcO32bN4sr6W80pZxlA7bC5KiUaj2gPyPgm0mo7icKWQlkVvREJ110Ngmv0pIep4WOUvS5rjZXYsCDwLW8Rp4fMzO9rde6MNA1Q1wUxPmdlTdKtLqC1RhpBBPU=
Message-ID: <4c4443230603240604u6c999f2fsb83bce68801f04b8@mail.gmail.com>
Date: Fri, 24 Mar 2006 22:04:13 +0800
From: yang.y.yi@gmail.com
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: Connector: Filesystem Events Connector
Cc: "Matt Helsley" <matthltc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Michael Kerrisk" <michael.kerrisk@gmx.net>
In-Reply-To: <20060324100934.GA21697@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44216612.3060406@gmail.com> <1143099809.29668.89.camel@stark>
	 <442349A3.9060907@gmail.com> <1143185750.29668.224.camel@stark>
	 <20060324081149.GC5426@2ka.mipt.ru> <1143193337.29668.241.camel@stark>
	 <20060324100934.GA21697@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Fri, Mar 24, 2006 at 01:42:17AM -0800, Matt Helsley (matthltc@us.ibm.com)
> wrote:
> > On Fri, 2006-03-24 at 11:11 +0300, Evgeniy Polyakov wrote:
> > > On Thu, Mar 23, 2006 at 11:35:50PM -0800, Matt Helsley
> (matthltc@us.ibm.com) wrote:
> > > > I would argue preemption should be disabled around the if-block at the
> > > > very least. Suppose your rate limit is 10k calls/sec and you have 4
> > > > procs. Each proc has a sequence of three instructions:
> > > >
> > > > load fsevent_sum into register rx (rx <= 1000)
> > > > rx++ (rx <= 1001)
> > > > store contents of register rx in fsevent_sum (fsevent_sum <= 1001)
> > > >
> > > >
> > > > Now consider the following sequence of steps:
> > > >
> > > > load fsevent_sum into rx (rx <= 1000)
> > > > <preempted>
> > > > <3 other processors each manage to increment the sum by 3333 bringing
> us
> > > > to 9999>
> > > > <resumed>
> > > > rx++ (rx <= 1001)
> > > > store contents of rx in fsevent_sum (fsevent_sum <= 1001)
> > > >
> > > > So every processor now thinks it won't exceed the rate limit by
> > > > generating more events when in fact we've just exceeded the limit. So,
> > > > unless my example is flawed, I think you need to disable preemption
> > > > here.
> > >
> > > Doesn't it just exceed the limit by one event per cpu?
> >
> > The example exceeds it by one at the time of the final store. Thanks to
> > the fact that the value is then 1001 it may shortly be exceeded by much
> > more than 1.
>
> +
> +       if (jiffies - last <= fsevent_ratelimit) {
> +               if (fsevent_sum > fsevent_burst_limit)
> +                       return -2;
> +               fsevent_sum++;
>
> Only process (and not process' syscall) can preempt us here,
> so fsevent_sum can only exceed fsevent_burst_limit by one per process
> (process can not preempt itself, so when it has finished syscall which
> ends up in event generation, fsevent_sum will be increased).
>
> +       } else {
> +               last = jiffies;
> +               fsevent_sum = 0;
> +       }
>
> Actually, since jiffies and atomic operations are already used, I do not
> think addition of new atomic_inc_return or something similar will
> even somehow change the picture.
rate limit is just for some abnormal cases, for example, an
application leads to a unlimited event loop, it should be very few, in
the worst case, the user application which induced this case will
terminate, this should be a reasonable result.
rate limit is intent to prevent this kind of case and avoid DoS of system.
>
>
> > Cheers,
> > 	-Matt Helsley
>
> --
> 	Evgeniy Polyakov
>
