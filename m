Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264862AbSJVRxY>; Tue, 22 Oct 2002 13:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbSJVRxX>; Tue, 22 Oct 2002 13:53:23 -0400
Received: from [202.88.156.6] ([202.88.156.6]:17567 "EHLO
	saraswati.hathway.com") by vger.kernel.org with ESMTP
	id <S264862AbSJVRxL>; Tue, 22 Oct 2002 13:53:11 -0400
Date: Tue, 22 Oct 2002 23:23:45 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, levon@movementarian.org
Subject: Re: [PATCH] NMI request/release
Message-ID: <20021022232345.A25716@dikhow>
Reply-To: dipankar@gamebox.net
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB54C53.9010603@mvista.com>; from cminyard@mvista.com on Tue, Oct 22, 2002 at 03:10:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 03:10:06PM +0200, Corey Minyard wrote:
> >If it's possible (and I have no idea, not having looked at RCU at all)
> >it seems the right way.
> >
> I looked, and the rcu code relys on turning off interrupts to avoid 
> preemption.  So it won't work.
> 

Hmm.. Let me see -

You need to walk the list in call_nmi_handlers from nmi interrupt handler where
preemption is not an issue anyway. Using RCU you can possibly do a safe
walking of the nmi handlers. To do this, your update side code
(request/release nmi) will still have to be serialized (spinlock), but
you should not need to wait for completion of any other CPU executing
the nmi handler, instead provide wrappers for nmi_handler
allocation/free and there free the nmi_handler using an RCU callback
(call_rcu()). The nmi_handler will not be freed until all the CPUs
have done a contex switch or executed user-level or been idle.
This will gurantee that *this* nmi_handler is not in execution
and can safely be freed.

This of course is a very simplistic view of the things, there could
be complications that I may have overlooked. But I would be happy
to help out on this if you want.

Thanks
Dipankar

