Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWDULwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWDULwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 07:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWDULwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 07:52:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:4239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751290AbWDULwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 07:52:07 -0400
X-Authenticated: #14349625
Subject: Re: [RFC][PATCH 3/9] CPU controller - Adds timeslice scaling
From: Mike Galbraith <efault@gmx.de>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <44489E27.2090108@jp.fujitsu.com>
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <20060421022742.13598.7230.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>
	 <1145607449.10016.47.camel@homer>  <44489E27.2090108@jp.fujitsu.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 13:53:11 +0200
Message-Id: <1145620391.7614.35.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 17:56 +0900, MAEDA Naoaki wrote:
> Mike Galbraith wrote:
> > Why does timeslice scaling become undesirable if TASK_INTERACTIVE(p)?
> > With this barrier, you will completely disable scaling for many loads.
> 
> Because interactive tasks tend to spend very small timeslice at one
> time, scaling timeslice for these tasks is not effective to control
> CPU spent.

True.

> Or, do you say that lots of non-interactive tasks are misjudged as
> TASK_INTERACTIVE(p)?

Almost.  TASK_INTERACTIVE(p) doesn't mean the task is an interactive
task, only that it sleeps enough that it may be.  Interactive tasks can
generally be categorized as doing quite a bit of sleeping, but so do
other things.  HTTP/FTP daemons etc etc.

In the presence of a mixed load with several "interactive" components,
timeslice scaling can only do harm to throughput by further fragmenting
the already shattered time a task spends on cpu.  You don't want to
increase the context switch rate if you want throughput.
 
> > Is it possible you meant !rt_task(p)?
> > 
> > (The only place I can see scaling as having a large effect is on gobs of
> > non-sleeping tasks.  Slice width doesn't mean much otherwise.)
> 
> Yes. But these non-sleeping CPU-hog tasks tend to dominant CPU, so
> it is worth controlling them.

Time spent in the expired array limits the !TASK_INTERACTIVE(p).  In a
mixed load, the sleeping task component is the one which needs
controlling, because it will always preempt and get it's share of cpu.
In a pure hog load, the scheduler is pure round-robin, so no scaling is
needed.  It's the sleep deprived who need protection from the swarms of
preempt enabled.

	-Mike

