Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVEID4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVEID4r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 23:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVEID4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 23:56:47 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:9195 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263035AbVEID4p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 23:56:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t5Pa+6HdFr9weLVHKikHIBgmUIgkj+PjyZhIxpU8UaHBM60kR/uPsy35e+L/XCojXWsN4h3Srpq8SBm96VhwUbKC6G0MZZ4xNymIhFvSYkQuOEHCNCgcdg3jW6JXFaHOuoyJKnY0pyYKdiHlWAGJ2s6jLSPXicEHs9LL/AB+q8I=
Message-ID: <d6e6e6dd0505082056538221bd@mail.gmail.com>
Date: Sun, 8 May 2005 23:56:44 -0400
From: Haoqiang Zheng <haoqiang@gmail.com>
Reply-To: Haoqiang Zheng <haoqiang@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [RFC PATCH] swap-sched: schedule with dynamic dependency detection (2.6.12-rc3)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505090926.59335.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6e6e6dd050507231174d99fb0@mail.gmail.com>
	 <200505081733.31907.kernel@kolivas.org>
	 <d6e6e6dd05050808556d83feb7@mail.gmail.com>
	 <200505090926.59335.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/05, Con Kolivas <kernel@kolivas.org> wrote:
> On Mon, 9 May 2005 01:55, Haoqiang Zheng wrote:
> > I am not quite sure about what do you mean for " a ring of dependent
> > tasks".  Do you mean the situation that A depends on B while at the
> > same time B depends on A?  It shouldn't happen since in swap-sched,
> > the dependency is generated on the fly. Task A depends on B only when
> > A blocks on waiting for B. For example, if task A blocks on
> > "read(pipe_fd,...)" and B is the task that can do
> > "write(pipe_fd,...)", then A is depending on B.  Once A is waked up,
> >  A no longer depends on any other task. So the "ring of dependent
> > tasks" shouldn't happen, otherwise it's a deadlock.
> 
> Ok so how does it respond to process_load in contest?

Based on my measurements, the "process_load" processes run at a
dynamic priority of 115--122.  Which is also pretty much the dynamic
priority range of the gcc processes.  At a certain point, the vanilla
Linux scheduler may select either a process_load process or a gcc/make
process to run, depending on which current runnable task has the
highest dynamic priority.

With swap-sched enabled, the virtual runnable tasks (tasks that are
blocked because of waiting for another task) are kept in runqueue. 
For example, if a contest process_load task A with prio 115 blocks on
waiting for another contest task B with prio 122, task A will remain
in runqueue.  Task A may be selected by the vanilla scheduler to run
since it has a high priority. On noticing that A is a virtual runnable
task, swap-sched further select B to run in place of A. So in the end,
B will be select to run. Without swap-sched, A will be removed from
the runqueue once it's blocked, and task B can hardly get a chance to
run since it has a low priority. That's why at
http://swap-sched.sourceforge.net/node9.html, process_load has a much
higher LCPU% when swap-sched is enabled.

Haoqiang
