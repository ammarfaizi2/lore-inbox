Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263430AbTJ0RDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTJ0RDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:03:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:23199 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263430AbTJ0RDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:03:11 -0500
From: Andrew Theurer <habanero@us.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Nick's scheduler v17
Date: Mon, 27 Oct 2003 12:02:58 -0500
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <3F996B10.4080307@cyberone.com.au> <3F99CE07.6030905@cyberone.com.au> <3F9B6D24.7050003@cyberone.com.au>
In-Reply-To: <3F9B6D24.7050003@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310271102.59041.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>     *imbalance = min(this_load - load_avg, load_avg - max_load)
> >>
> >> That way you take just enough to either have busiest_queue or
> >> this_rq's length be the load_avg.  I suppose you could take even
> >> less, but IMO, the /=2 is what I really don't like.  Perhaps:
> >
> > That is _exactly_ what I had before! Thats probably the way to go. Thanks
> > for having a look at it.
> >
> >> *imbalance = min(this_load - load_avg, load_avg - max_load);
> >> *imbalance = (*imbalance + FPT - 1) / FPT;
> >>
> >> This should work well for intranode balances, internode balances may
> >> need a little optimization, since the load_avg really does not really
> >> represent the load avg of the two nodes in question, just one cpu
> >> from one of them and all the cpus from another.
>
> Oh, actually, after my path, load_avg represents the load average of _all_
> the nodes. Have a look at find_busiest_node. Which jogs my memory of why
> its not always a good idea to do your *imbalance min(...) thing (I actually
> saw this happening).

Oops, I meant avg_load, which you calculate in find_busiest_queue on the fly.  

> 5 CPUs, 4 processes running on one cpu. load_avg would be 0.8 for all cpus.
> balancing doesn't happen. I have to think about this a bit more...

Actually, if we use avg_load, I guess it would be 0, since this is an unsigned 
long.  Maybe avg_load needs to have a min value of 1.  Then if we apply:

*imbalance = min(max_load - avg_load, avg_load - this_load)
	     min(4 - 1, 1 - 0)
	     	

And imbalance looks a lot better.  Only concern would be an idle cpu stealing 
from another, leaving the other cpu idle.  I guess a check could be put 
there.	
	     


