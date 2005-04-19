Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVDSINL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVDSINL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVDSINL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:13:11 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:33933 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261391AbVDSINC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:13:02 -0400
Date: Tue, 19 Apr 2005 10:12:45 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, simon chez Bull <Simon.Derr@bull.net>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
In-Reply-To: <20050418225427.429accd5.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0504190955250.4587@openx3.frec.bull.fr>
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com>
 <20050418225427.429accd5.pj@sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/04/2005 10:22:59,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 19/04/2005 10:23:01,
	Serialize complete at 19/04/2005 10:23:01
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005, Paul Jackson wrote:

> Hmmm ... interesting patch.  My reaction to the changes in
> kernel/cpuset.c are complicated:
> 
>  * I'm supposed to be on vacation the rest of this month,
>    so trying (entirely unsuccessfully so far) not to think
>    about this.
>  * This is perhaps the first non-trivial cpuset patch to come
>    in the last many months from someone other than Simon or
>    myself - welcome.
I'm glad to see this happening.

> This leads to a possible interface.  For each of cpus and
> memory, add four per-cpuset control files.  Let me take the
> cpu case first.
> 
> Add the per-cpuset control files:
>   * domain_cpu_current 		# readonly boolean
>   * domain_cpu_pending		# read/write boolean
>   * domain_cpu_rebuild		# write only trigger
>   * domain_cpu_error		# read only - last error msg

>   4) If the write failed, read the domain_cpu_error file
>      for an explanation.


> Otherwise the write will fail, and an error message explaining
> the problem made available in domain_cpu_error for subsequent
> reading.  Just setting errno would be insufficient in this
> case, as the possible reasons for error are too complex to be
> adequately described that way.

I guess we hit a limit of the filesystem-interface approach here.
Are the possible failure reasons really that complex ?

Is such an error reporting scheme already in use in the kernel ?
I find the two-files approach a bit disturbing -- we have no guarantee 
that the error we read is the error we produced. If this is only to get a 
hint, OK.

On the other hand, there's also no guarantee that what we are triggering 
by writing in domain_cpu_rebuild is what we have set up by writing in 
domain_cpu_pending. User applications will need a bit of self-discipline.

> The above scheme should significantly reduce the number of 
> special cases in the update_sched_domains() routine (which I
> would rename to update_cpu_domains, alongside another one to be
> provided later, update_mem_domains.)  These new update routines
> will verify that all the preconditions are met, tear down all
> the cpu or mem domains within the scope of the specified cpuset,
> and rebuild them according to the partition defined by the
> pending_*_domain flags on the descendent cpusets.  It's the
> same complete rebuild of the partitioning of some subtree,
> each time, without all the special cases for incrementally
> adding and removing cpus or mems from this or that.  Complex
> nested if-else-if-else logic is a breeding ground for bugs --
> good riddance.
Oh yes.
There's already a good bunch of if-then-else logic in the cpusets because 
of the different flags that can apply. We don't need more.

> There -- what do you think of this alternative?
Most of all, that you write mails faster than I am able to read them, so I 
might have missed something. But so far I like your proposal. 

	Simon.

