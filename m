Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266352AbUGBHIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266352AbUGBHIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUGBHIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:08:09 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:46269 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S266352AbUGBHIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:08:00 -0400
Date: Fri, 2 Jul 2004 00:06:30 -0700 (PDT)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@localhost.localdomain
To: Nathan Scott <nathans@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
In-Reply-To: <20040702043524.GA1203@frodo>
Message-ID: <Pine.LNX.4.44.0407012259030.5069-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan, thanks for the feedback! This is indeed a false alarm. The tool
was able to infer the semantics of _sv_wait, but failed to used it due to
a bug in my checker... Problem fixed now and I will rerun the checker
tonight. I will update the error reports when the results are ready. 
Best,
Yichen

On Fri, 2 Jul 2004, Nathan Scott wrote:

> On Thu, Jul 01, 2004 at 06:01:00PM -0700, Yichen Xie wrote:
> > Hi all, 
> 
> Hi there,
> 
> > We are a group of researchers at Stanford working on program analysis
> > algorithms.  We have been building a precision enhanced program analysis
> > engine at Stanford, and our first application was to derive mutex/lock
> > behavior in the linux kernel. In the process, we found 99 likely
> > synchronization errors in linux kernel version 2.6.5:
> > 
> >     http://glide.stanford.edu/linux-lock/err1.html (69 errors)
> >     http://glide.stanford.edu/linux-lock/err2.html (30 errors)
> > 
> >  ...
> > 
> > As always, feedbacks and confirmations will be greatly appreciated!
> 
> >From looking through the XFS reports, I suspect your tools aren't
> following the sv_wait semantics correctly (or else I'm misreading
> the code).  Many of the reported XFS items stem from this - e.g.
> this one...
> [NOTE] BUG forgot to unlock before "goto try_again" (line 2293)
> ERROR: fs/xfs/xfs_log.c:2948: lock check failed!
> ERROR: fs/xfs/xfs_log.c:xlog_state_sync
> 
> the code in question does this:
> 
>   try_again:
> 	s = LOG_LOCK(log); /* spin_lock(&log->l_icloglock); */
> 	    ...
> 		sv_wait(&iclog->ic_prev->ic_writesema, PSWP,
> 			&log->l_icloglock, s);
> 		already_slept = 1;
> 		goto try_again;
> 
> and the tools seem to be missing that the log->l_icloglock is
> unlocked by the sv_wait routine.  Well, that or I've overlooked
> something that the tools have not. :)
> 
> A couple of the others were definately missed unlocks on error
> paths though (fixed now) - thanks!
> 
> cheers.
> 
> 

