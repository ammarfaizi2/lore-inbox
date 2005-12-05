Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVLEWal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVLEWal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 17:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLEWal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 17:30:41 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:61672 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750961AbVLEWal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 17:30:41 -0500
Date: Mon, 5 Dec 2005 23:30:16 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: david singleton <dsingleton@mvista.com>
Cc: robustmutexes@lists.osdl.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: robust futex heap support patch
In-Reply-To: <2F3CDB0C-5E50-11DA-8242-000A959BB91E@mvista.com>
Message-Id: <Pine.OSF.4.05.10512052144530.26388-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I got a little time to look at your current patch (2.6.14-rt21-rf8).
I noticed a problem in futex_wake_robust(). You have a "goto retry" to
solve the following situation:

  Task A                             Task B
      takes futex in userspace
                                     Tries to take mutex and sets the
                                     waiting bit in user space
      releases futex, notices task B
      calls kernel and enters
      futex_wake_robust()

    retry:
      if not owner in rt_mutex
         goto retry;      
                                     Calls kernel
                                     Makes A owner in rt_mutex
                                     blocks
       Leaves retry-loop and 
       completes the futex wake 
       operation as normally.
       

However,  if Task A is RT on a UP machine it will go on in the retry loop
forever. Task B will never get the CPU to complete it's kernel-call. 

You have probably by manipulating the userspace flag from within the
rt_mutex code :-(

Esben
                    

On Fri, 25 Nov 2005, david singleton wrote:

> There is a new patch, patch-2.6.14-rt15-rf1,  that adds support for 
> robust and priority inheriting
> pthread_mutexes on the 'heap'.
> 
> The previous patches only supported either file based pthread_mutexes 
> or mmapped anonymous memory based pthread_mutexes.  This patch allows 
> pthread_mutexes
> to be 'malloc'ed while using the PTHREAD_MUTEX_ROBUST_NP attribute
> or PTHREAD_PRIO_INHERIT attribute.
> 
> The patch can be found at:
> 
> http://source.mvista.com/~dsingleton
> 
> David
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

