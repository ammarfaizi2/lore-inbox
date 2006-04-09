Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWDIFGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDIFGy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 01:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDIFGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 01:06:54 -0400
Received: from [212.33.163.207] ([212.33.163.207]:1284 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932307AbWDIFGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 01:06:54 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Sun, 9 Apr 2006 08:04:40 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200604031459.51542.a1426z@gawab.com> <200604082331.56715.a1426z@gawab.com> <44387855.30004@bigpond.net.au>
In-Reply-To: <44387855.30004@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604090804.40867.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > This is especially visible in spa_no_frills, and spa_ws recovers from
> > this lockup somewhat and starts exhibiting this problem as a choking
> > behavior.
> >
> > Running '# top d.1 (then shift T)' on another vt shows this choking
> > behavior as the proc gets boosted.
>
> But anyway, based on the evidence, I think the problem is caused by the
> fact that the eatm tasks are running to completion in less than one time
> slice without sleeping and this means that they never have their
> priorities reassessed. 

Yes.

> The reason that spa_ebs doesn't demonstrate the
> problem is that it uses a smaller time slice for the first time slice
> that a task gets. The reason that it does this is that it gives newly
> forked processes a fairly high priority and if they're left to run for a
> full 120 msecs at that high priority they can hose the system.  Having a
> shorter first time slice gives the scheduler a chance to reassess the
> task's priority before it does much damage.

But how does this explain spa_no_frills setting promotion to max not having 
this problem?

> The reason that the other schedulers don't have this strategy is that I
> didn't think that it was necessary.  Obviously I was wrong and should
> extend it to the other schedulers.  It's doubtful whether this will help
> a great deal with spa_no_frills as it is pure round robin and doesn't
> reassess priorities except when nice changes of the task changes
> policies.

Would it hurt to add it to spa_no_frills and let the children inherit it?

> This is one good reason not to use spa_no_frills on
> production systems.

spa_ebs is great, but rather bursty.  Even setting max_ia_bonus=0 doesn't fix 
that.  Is there a way to smooth it like spa_no_frills?

> Perhaps you should consider creating a child
> scheduler on top of it that meets your needs?

Perhaps.

> Anyway, an alternative (and safer) way to reduce the effects of this
> problem (while your waiting for me to do the above change) is to reduce
> the size of the time slice.  The only bad effects of doing this is that
> you'll do slightly worse (less than 1%) on kernbench.

Actually, setting timeslice to 5,50,100 gives me better performance on 
kernbench.  After closer inspection, I found 120ms a rather awkward 
timeslice whereas 5,50, and 100 exhibited a smoother and faster response, 
which may be machine dependent, thus the need for an autotuner.

Thanks!

--
Al

