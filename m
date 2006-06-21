Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWFUIEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWFUIEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFUIEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:04:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:26021 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751129AbWFUIEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:04:11 -0400
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
From: Matt Helsley <matthltc@us.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
In-Reply-To: <4498DC23.2010400@bigpond.net.au>
References: <1150242721.21787.138.camel@stark>
	 <4498DC23.2010400@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 00:51:31 -0700
Message-Id: <1150876292.21787.911.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 15:41 +1000, Peter Williams wrote:
> Matt Helsley wrote:
> > Task watchers is a notifier chain that sends notifications to registered
> > callers whenever a task forks, execs, changes its [re][ug]id, or exits.
> > The goal is to keep the these paths comparatively simple while
> > enabling the addition of per-task intialization, monitoring, and tear-down
> > functions by existing and proposed kernel features.
> > 
> > The first patch adds a global atomic notifier chain, registration
> > functions, and a function to invoke the callers on the chain.
> > 
> > Later patches:
> > 
> > Register a task watcher for process events, shuffle bits of process events
> > functions around to reduce the code, and turn it into a module. 
> > 
> > Switch task watchers from an atomic to a blocking notifier chain
> > 
> > Register task watchers for:
> > 	Audit
> > 	Per Task Delay Accounting (note: not the taskstats calls)
> > 	Profile
> > 
> > Add a per-task raw notifier chain
> 
> This feature is less useful than it could be in that it only allows a 
> per-task raw notifier to be added to the current task.  For the per 
> process CPU capping client that I'm writing, I'd like to be able to 
> attach one of these to a task that's being forked (from the forking 
> task).  Not being able to do this will force me to go to the expense of 
> maintaining my own hash tables for locating my per task data.

	You're right. The patches are missing the bit that allows the per-task
watcher to be copied on fork. I've got an patch which I'll post and CC
you on shortly. What it does is allow register_per_task_watcher() to
register for the child task.

> On a related note, I can't see where the new task's notify field gets 
> initialized during fork.

It's initialized in kernel/sys.c:notify_per_task_watchers(), which calls
RAW_INIT_NOTIFIER_HEAD(&task->notify) in response to WATCH_TASK_INIT.

Cheers,
	-Matt Helsley

