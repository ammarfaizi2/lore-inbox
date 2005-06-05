Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFEAxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFEAxt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 20:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFEAxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 20:53:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25334 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261450AbVFEAxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 20:53:45 -0400
Date: Sat, 4 Jun 2005 17:53:28 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: patch] Real-Time Preemption, plist fixes
In-Reply-To: <1117930633.20785.239.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.44.0506041748060.17923-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2005, Thomas Gleixner wrote:

> The patch fixes a couple of really annoying issues in the PI code of the
> Real-Time-Preemption patch

You mean really annoying in the plist code?
 
> 1. Fix the insertion order according to the specified intentions
> 
> The desired action was inserting in descending priority and FIFO mode
> for matching priority. The resulting action of the code was inserting in
> descending priority and inverse FIFO mode for matching priority. 

This is good.
 
> 2. Add the proper list_head initializer in the replacement path.

Not sure what you mean here.
 
> 3. Remove the bogus checks in the delete function for 
>  A. !list_empty(&pl->sp_node)
>  B. else if (pl->prio == pl_new->prio)
> 
> Those checks just covered the dumbest implementation detail of plist at
> all. See 4.)
> 
> 4. Make plist_entry() work as expected by anybody who ever used
> list_entry(). Add a plist_first_entry macro for those places where the
> provided functionality was accidentaly correct.
> 
> Application example:
> 
> plist_for_each_safe(curr1, next1, &old_owner->pi_waiters) {
> 	w = plist_entry(curr1, struct rt_mutex_waiter, pi_list);
> 	.....
> }
> 
> A moderate experienced Linux programmer would expect, that
> plist_entry(curr1,...) returns the first entry of the list
> &old_owner->pi_waiters. Looking into the plist_entry macro after
> spending hours of witchcrafting reviels that the result is the next
> entry of the first entry of the list.
> 
> #define plist_entry(ptr, type, member) \
> 	container_of(plist_first(ptr), type, member)
> 
> No further comment necessary.

I already released a patch to fix this.
 
> 5. Modify the comments in the header file to explain the real intention
> of the implemenation.
> 
> Changing fundamental implemtation details and keeping the original
> comments is just provoking false assumptions. I apologize hereby for all
> maledictions I addressed to the original author.

You should wait till it's stable before you finalize the documentation.

> + * (C) 2005 Thomas Gleixner <tglx@linutronix.de>
> + * Tested and made it functional. I'm still pondering if it is
> + * worth the trouble.
> + *

Gimme a break Thomas..

Daniel

