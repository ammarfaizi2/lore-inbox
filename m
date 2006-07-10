Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWGJRsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWGJRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWGJRsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:48:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63932 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422731AbWGJRsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:48:08 -0400
Date: Mon, 10 Jul 2006 10:48:46 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: mingo@elte.hu, oleg@tv-sign.ru, linux-kernel@vger.kernel.org,
       dino@us.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH -rt] catch put_task_struct RCU handling up to mainline
Message-ID: <20060710174846.GD1446@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060707192955.GA2219@us.ibm.com> <Pine.LNX.4.64.0607072352390.12372@localhost.localdomain> <20060707231524.GI1296@us.ibm.com> <Pine.LNX.4.64.0607081450150.11051@localhost.localdomain> <20060710155147.GB1446@us.ibm.com> <Pine.LNX.4.64.0607101855410.14469@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607101855410.14469@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 07:10:49PM +0100, Esben Nielsen wrote:
> On Mon, 10 Jul 2006, Paul E. McKenney wrote:
> >On Sat, Jul 08, 2006 at 02:59:37PM +0100, Esben Nielsen wrote:

[ . . . ]

> >>The work should be defered to a low priority task. Using rcu is
> >>probably overkill because it also introduces other delays. A tasklet
> >>or a dedicated task would be better.
> >
> >Agreed -- if there is in fact a legitimate non-error code path, then
> >a patch that used some deferral mechanism would be good.  But RCU is
> >overkill, and misleading overkill at that!
> >
> 
> I think this is a legitimate situation. lock 1 is owned by B which is
> blocked on lock 2 which is owned by C
> 
>  CPU1:                                      CPU2
>     RT task A locks lock 1                C runs something
>     A boosts B to RT
>     A does get_task_struct B
>     A enables interrupts                  C unlocks lock 2
>     An very long interrupt is running     B unlocks lock 2
>                                           B unlocks lock 1
>                                           B is deboosted
>                                           B exits
>     A gets CPU1 again
>     A does put_task_struct B
> 
> I don't know if the timing is realistic, but theoretically it is possible.
> It might also be possible the B exits on another CPU even without the long
> interrupt handler. If A has cpu affinity to CPU1 it is enough if a higher 
> priority task preempts it on CPU1.

For this to happen, either A has to be at a lower priority than the irq
tasks or the interrupt has to be a hard irq (e.g., scheduling clock
interrupt).  In the first case, the added cleanup processing seems
inconsequential compared to (say) an interrupt doing network protocol
processing.  In the second case, B does not do its put_task_struct()
until after the hard irq returns (because the put_task_struct() is invoked
from a call_rcu() callback), which makes the above scenario unlikely,
though perhaps not impossible.

If the second scenario is in fact possible, would you be willing to
supply the appropriate deferral code?  I believe we both agree that RCU
is not really the right deferral mechanism in this situation.

							Thanx, Paul
