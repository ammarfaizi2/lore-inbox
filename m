Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVBBWcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVBBWcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVBBVbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:31:34 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:60633 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262595AbVBBVaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:30:20 -0500
Date: Wed, 2 Feb 2005 22:30:11 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Kevin Hilman <kevin@hilman.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and GFP_ATOMIC    
In-Reply-To: <83r7jyiyqx.fsf@www2.muking.org>
Message-Id: <Pine.OSF.4.05.10502022149300.30098-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Feb 2005, Kevin Hilman wrote:

> While testing an older driver on an -RT kernel (currently using
> -V0.7.37-03), I noticed something strange.
> 
> The driver was triggering a "sleeping function called from invalid
> context" BUG().  It was coming from a case where the driver was doing
> a __get_free_page(GFP_ATOMIC) while interrupts were disabled (example
> trace below).  I know this is probably real bug and it shouldn't be
> allocating memory with interrupts disabled, but shouldn't this be
> possible?  Isn't the role of GFP_ATOMIC to say that "this caller
> cannot sleep". 
> 
The problem is that almost all locks are replaced by mutexex which
can make yuo sleep. That includes locks around the various allocation
structures.

This is one of those places where I think Ingo have gone too far, but I
see that the code in mm/ is not fitted for for doing anything else
but what Ingo have done right now. It would require some rewriting to fix
it.

The basic allocations should be of the free-list form
  res = first_free;
  if(res) {
         first_free = res->next;
  }
  return res;

I se no problem in protecting this kind of operation by a raw spinlock.
Using a mutex to protect such a list would be a waste: You would have to
lock and unlock the mutex's spinlock twice! If it was made that way, i.e.
the very basic free-list operation was taken out in front of the more
complicated stuff in mm/slap.c GFP_ATOMIC could be made to work as usual.

The hard job is that the refill operation has to be done under a mutex
under PREEMPT_RT. I.e. suddenly there are two locks to take care off.

Esben


