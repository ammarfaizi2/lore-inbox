Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbTJXVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbTJXVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:49:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36553 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262672AbTJXVtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:49:23 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Nick's scheduler v17
Date: Fri, 24 Oct 2003 16:49:05 -0500
User-Agent: KMail/1.5
References: <3F996B10.4080307@cyberone.com.au>
In-Reply-To: <3F996B10.4080307@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310241649.05310.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 13:10, Nick Piggin wrote:
> Hi,
> http://www.kerneltrap.org/~npiggin/v17/
>
> Still working on SMP and NUMA. Some (maybe) interesting things I put in are
> - Sequential CPU balancing so you don't get a big storm of balances
> every 1/4s.
> - Balancing is trying to err more on the side of caution, I have to start
>   analysing it more thoroughly though.

+
+	*imbalance /= 2;
+	*imbalance = (*imbalance + FPT - 1) / FPT;

I think I see what is going on here, but would something like this work out 
better?

	*imbalance = min(this_load - load_avg, load_avg - max_load)

That way you take just enough to either have busiest_queue or this_rq's length 
be the load_avg.  I suppose you could take even less, but IMO, the /=2 is 
what I really don't like.  Perhaps:

*imbalance = min(this_load - load_avg, load_avg - max_load);
*imbalance = (*imbalance + FPT - 1) / FPT;

This should work well for intranode balances, internode balances may need a 
little optimization, since the load_avg really does not really represent the 
load avg of the two nodes in question, just one cpu from one of them and all 
the cpus from another.


