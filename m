Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVGUWqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVGUWqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVGUWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:43:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48032 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261946AbVGUWnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:43:40 -0400
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
From: Matthew Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       LKML <linux-kernel@vger.kernel.org>, Gerrit Huizenga <gh@us.ibm.com>
In-Reply-To: <20050717082000.349b391f.pj@sgi.com>
References: <20050715013653.36006990.akpm@osdl.org>
	 <20050715150034.GA6192@infradead.org>
	 <20050715131610.25c25c15.akpm@osdl.org>
	 <20050717082000.349b391f.pj@sgi.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 15:37:28 -0700
Message-Id: <1121985448.5242.90.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 08:20 -0700, Paul Jackson wrote:
<snip>

> It is somewhat intrusive in the areas it controls, such as some large
> ifdef's in kernel/sched.c.

I don't see the large ifdefs you're referring to in -mm's
kernel/sched.c.

> The sched hooks may well impact the cost of maintaining the sched code,
> which is always a hotbed of Linux kernel development.  However others
> who work in that area will have to speak to that concern.

I don't see the hooks you're referring to in the -mm scheduler.

> I tried just now to read through the ckrm hooks in fork, to see
> what sort of impact they might have on scalability on large systems.
> But I gave up after a couple layers of indirection.  I saw several
> atomic counters and a couple of spinlocks that I suspect (not at all
> sure) lay on the fork main code path.  I'd be surprised if this didn't
> impact scalability.  Earlier, according to my notes, I saw mention of
> lmbench results in the OLS 2004 slides, indicating a several percent
> cost of available cpu cycles.

	The OLS2004 slides are roughly 1 year old. Have you looked at more
recent benchmarks posted on CKRM-Tech around April 15th 2005? They
should be available in the CKRM-Tech archives on SourceForge at
http://sourceforge.net/mailarchive/forum.php?thread_id=7025751&forum_id=35191

(OLS 2004 Slide 24 of
http://ckrm.sourceforge.net/downloads/ckrm-ols04-slides.pdf )

	The OLS slide indicates that the overhead is generally less than
0.5usec compared to a total context switch time of anywhere from 2 to
5.5usec. There appears to be little difference in scalability since the
overhead appears to oscillate around a constant.

<snip>

> vendor has a serious middleware software product that provides full
> CKRM support.  Acceptance of CKRM would be easier if multiple competing
> middleware vendors were using it.  It is also a concern that CKRM
> is not really usable for its primary intended purpose except if it
> is accompanied by this corresponding middleware, which I presume is

	The Rule-Based Classification Engine (RBCE) makes CKRM useful without
middleware. It uses a table of rules to classify tasks. For example
rules that would classify shells:

echo 'path=/bin/bash,class=/rcfs/taskclass/shells' > /rcfs/ce/rules/classify_bash_shells
echo 'path=/bin/tcsh,class=/rcfs/taskclass/shells' > /rcfs/ce/rules/classify_tcsh_shells
..

And class shares would control the fork rate of those shells:

echo 'res=numtasks,forkrate=10000,forkrate_interval=1' > '/rcfs/taskclass/config'
echo 'res=numtasks,guarantee=1000,limit=5000' > '/rcfs/taskclass/shells'

No middleware necessary.

<snip> 

> CKRM is in part a generalization and descendent of what I call fair
> share schedulers.  For example, the fork hooks for CKRM include a
> forkrates controller, to slow down the rate of forking of tasks using
> too much resources.
> 
> No doubt the CKRM experts are already familiar with these, but for
> the possible benefit of other readers:
> 
>   UNICOS Resource Administration - Chapter 4. Fair-share Scheduler
>   http://oscinfo.osc.edu:8080/dynaweb/all/004-2302-001/@Generic__BookTextView/22883
> 
>   SHARE II -- A User Administration and Resource Control System for UNIX
>   http://www.c-side.com/c/papers/lisa-91.html
> 
>   Solaris Resource Manager White Paper
>   http://wwws.sun.com/software/resourcemgr/wp-mixed/
> 
>   ON THE PERFORMANCE IMPACT OF FAIR SHARE SCHEDULING
>   http://www.cs.umb.edu/~eb/goalmode/cmg2000final.htm
> 
>   A Fair Share Scheduler, J. Kay and P. Lauder
>   Communications of the ACM, January 1988, Volume 31, Number 1, pp 44-55.
> 
> The documentation that I've noticed (likely I've missed something)
> doesn't do an adequate job of making the case - providing the
> motivation and context essential to understanding this patch set.

	The choice of algorithm is entirely up to the scheduler, memory
allocator, etc. CKRM currently provides an interface for reading share
values and does not impose any meaning on those shares -- that is the
role of the scheduler.

> Because CKRM provides an infrastructure for multiple controllers
> (limiting forks, memory allocation and network rates) and multiple
> classifiers and policies, its critical interfaces have rather
> generic and abstract names.  This makes it difficult for others to
> approach CKRM, reducing the rate of peer review by other Linux kernel
> developers, which is perhaps the key impediment to acceptance of CKRM.
> If anything, CKRM tends to be a little too abstract.

	Generic and abstract names are appropriate for infrastructure that is
not tied to hardware. If you could be more specific I'd be able to
respond in less general and abstract terms.

<snip>

> My notes from many months ago indicate something about a 128 CPU
> limit in CKRM.  I don't know why, nor if it still applies.  It is
> certainly a smaller limit than the systems I care about.

I haven't seen this limitation in the CKRM patches that went into -mm
and I'd like to look into this. Where did you see this limit?

Thanks,
	-Matt Helsley

