Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbRDGAq0>; Fri, 6 Apr 2001 20:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132359AbRDGAqQ>; Fri, 6 Apr 2001 20:46:16 -0400
Received: from ns.suse.de ([213.95.15.193]:60168 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132352AbRDGAqD>;
	Fri, 6 Apr 2001 20:46:03 -0400
Date: Sat, 7 Apr 2001 02:45:27 +0200
From: Andi Kleen <ak@suse.de>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: rusty@rustcorp.com.au, nigel@nrg.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH for 2.5] preemptible kernel
Message-ID: <20010407024527.A26667@gruyere.muc.suse.de>
In-Reply-To: <OFC4BD5737.728E9896-ON88256A26.008088FF@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OFC4BD5737.728E9896-ON88256A26.008088FF@LocalDomain>; from Paul.McKenney@us.ibm.com on Fri, Apr 06, 2001 at 04:52:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, 

On Fri, Apr 06, 2001 at 04:52:25PM -0700, Paul McKenney wrote:
> 1.   On a busy system, isn't it possible for a preempted task
>      to stay preempted for a -long- time, especially if there are
>      lots of real-time tasks in the mix?

The problem you're describing is probably considered too hard to solve properly (bad answer,
but that is how it is currently) 

Yes there is. You can also force a normal (non preemptive) kernel into complete livelock by 
just giving it enough network traffic to do, so that it always works in the high priority 
network softirq or doing the same with some other interrupt. 

Just when this happens a lot of basic things will stop working (like page cleaning, IO 
flushing etc.), so your callbacks or module unloads not running are probably the least
of your worries.  

The same problem applies to a smaller scale to real time processes; kernel services 
normally do not run real-time, so they can be starved. 

Priority inversion is not handled in Linux kernel ATM BTW, there are already situations
where a realtime task can cause a deadlock with some lower priority system thread
(I believe there is at least one case of this known with realtime ntpd on 2.4) 

> 2.   Isn't it possible to get in trouble even on a UP if a task
>      is preempted in a critical region?  For example, suppose the
>      preempting task does a synchronize_kernel()?

Ugly. I guess one way to solve it would be to readd the 2.2 scheduler taskqueue,
and just queue a scheduler callback in this case.

-Andi
