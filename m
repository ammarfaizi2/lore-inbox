Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVDEJaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVDEJaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVDEJ2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:28:54 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:908 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261650AbVDEJ0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:26:31 -0400
Date: Tue, 5 Apr 2005 11:25:55 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
In-Reply-To: <20050405053410.GA18839@elte.hu>
Message-Id: <Pine.OSF.4.05.10504051105040.10558-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Ingo Molnar wrote:

> 
> * Esben Nielsen <simlo@phys.au.dk> wrote:
> 
> > > Now the question is, who will fix it? Preferably the maintainers, but I
> > > don't know how much of a priority this is to them. I don't have the time
> > > now to look at this and understand enough about the code to be able to
> > > make a proper fix, and I'm sure you have other things to do too.
> > 
> > How about adding a
> >  if(rt_task(current)) {
> >         WARN_ON(1);
> >         mutex_setprio(current, MAX_PRIO-1)
> >  }
> > ?
> > 
> > to find all calls to yields from rt-tasks. That will force the user 
> > (aka the real-time developer) to either stop calling the subsystems 
> > still using yield from his RT-tasks, or fix those subsystems.
> 
> i've added this to the -43-08 patch, so that we can see the scope of the 
> problem. But any yield() use could become a problem due to priority 
> inheritance. (which might eventually be expanded to userspace locking 
> too)
> 
Any calls to non-deterministic subsystems breaks the real-time properties.
yield() is certainly not the only problem. Code waiting for RCU-completion
or whatever is bad too. Calling code like that from RT-tasks or calling
them while having locks shared with RT-tasks is just bad. Anyone knowing
about RT development _has_ to know that. Putting warnings and traces into
the kernel is a nice feature. 

Static code analyzes would also help quite a bit. What about having a new
attribute "nonrt" for functions and locks? yield() and syncronize_kernel() are 
certain candidates. Any function having nonrt operations are marked 
nonrt. Any lock becomes held while doing a nonrt operation is marked
nonrt. Taking a nonrt lock is a nonrt operation. (Might end up marking the
whole kernel nonrt....)

Esben

> 	Ingo



