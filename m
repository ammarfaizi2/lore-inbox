Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJHTBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJHTBB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUJHS5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:57:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55945 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264648AbUJHSz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:55:59 -0400
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Erich Focht <efocht@hpce.nec.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
In-Reply-To: <41666E90.2000208@yahoo.com.au>
References: <1097110266.4907.187.camel@arrakis>
	 <200410081214.20907.efocht@hpce.nec.com>  <41666E90.2000208@yahoo.com.au>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097261691.5650.23.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 11:54:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 03:40, Nick Piggin wrote:
> And so you want to make a partition with CPUs {0,1,2,4,5}, and {3,6,7}
> for some crazy reason, the new domains would look like this:
> 
> 0 1  2  4 5    3  6 7
> ---  -  ---    -  ---  <- 0
>   |   |   |     |   |
>   -----   -     -   -   <- 1
>     |     |     |   |
>     -------     -----   <- 2 (global, partitioned)
> 
> Agreed? You don't need to get fancier than that, do you?
> 
> Then how to input the partitions... you could have a sysfs entry that
> takes the complete partition info in the form:
> 
> 0,1,2,3 4,5,6 7,8 ...
> 
> Pretty dumb and simple.

How do we describe the levels other than the first?  We'd either need
to:
1) come up with a language to describe the full tree.  For your example
I quoted above:
   echo "0,1,2,4,5 3,6 7,8;0,1,2 4,5 3 6,7;0,1 2 4,5 3 6,7" > partitions

2) have multiple files:
   echo "0,1,2,4,5 3,6,7" > level2
   echo "0,1,2 4,5 3 6,7" > level1
   echo "0,1 2 4,5 3 6,7" > level0

3) Or do it hierarchically as Paul implemented in cpusets, and as I
described in an earlier mail:
   mkdir level2
   echo "0,1,2,4,5 3,6,7" > level2/partitions
   mkdir level1
   echo "0,1,2 4,5 3 6,7" > level1/partitions
   mkdir level0
   echo "0,1 2 4,5 3 6,7" > level0/partitions

I personally like the hierarchical idea.  Machine topologies tend to
look tree-like, and every useful sched_domain layout I've ever seen has
been tree-like.  I think our interface should match that.

-Matt

