Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264458AbRFIKqA>; Sat, 9 Jun 2001 06:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264459AbRFIKpk>; Sat, 9 Jun 2001 06:45:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59308 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264458AbRFIKpe>;
	Sat, 9 Jun 2001 06:45:34 -0400
Date: Sat, 9 Jun 2001 06:45:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <200106090759.AAA15771@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0106090634050.17657-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Jun 2001, Dawson Engler wrote:

> Hi All,
> 
> we're starting to develop a checker that finds deadlocks by (1)
> computing all lock acquisition paths and (2) checking if two paths
> violate a partial order.
> 
> E.g., for two threads T1 and T2:
> 	T1: foo acquires A --> calls bar which tries to acquire B
> 	T2: baz acquires B --> calls blah which tries to acquire A
> all else being equal, this deadlocks.
> 
> The checker is pretty primitive.  In particular:
> 	- lots of false negatives come from the fact that it does not 
> 	  track interrupt disabling.  A missed deadlock:
> 		foo acquires A
> 		bar interrupts foo, disables interrupts, tries to acquire A
> 	  (Is this the most common deadlock?)
> 
> 	- many potential false positives since it does not realize when
> 	two kernel call traces are mutually exclusive.
> 
> To check it's mechanics I've enclosed what look to me to be two potential
> deadlocks --- given the limits of the tool and my understanding of what
> can happen when, these could be (likely be?) false positive, so I'd
> appreciate any corrective feedback.

BKL is special. It has no nesting constraints wrt. semaphores. It is
a spinlock, but we are allowed to block while holding it - then it will
be released and the next time we get a timeslice we will start with
attempt to reacquire it.

