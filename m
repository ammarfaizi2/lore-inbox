Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWFUVfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWFUVfT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWFUVfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:35:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:27551 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932475AbWFUVfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:35:17 -0400
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
From: Matt Helsley <matthltc@us.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
In-Reply-To: <44993079.40300@bigpond.net.au>
References: <1150242721.21787.138.camel@stark>
	 <4498DC23.2010400@bigpond.net.au> <1150876292.21787.911.camel@stark>
	 <44992EAA.6060805@bigpond.net.au>  <44993079.40300@bigpond.net.au>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 14:29:47 -0700
Message-Id: <1150925387.21787.1056.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 21:41 +1000, Peter Williams wrote:
> Peter Williams wrote:
> > Matt Helsley wrote:
> >> On Wed, 2006-06-21 at 15:41 +1000, Peter Williams wrote:
> >>> On a related note, I can't see where the new task's notify field gets 
> >>> initialized during fork.
> >>
> >> It's initialized in kernel/sys.c:notify_per_task_watchers(), which calls
> >> RAW_INIT_NOTIFIER_HEAD(&task->notify) in response to WATCH_TASK_INIT.
> > 
> > I think that's too late.  It needs to be done at the start of 
> > notify_watchers() before any other watchers are called for the new task.

	I don't see why you think it's too late. It needs to be initialized
before it's used. Waiting until notify_per_task_watchers() is called
with WATCH_TASK_INIT does this.

> On second thoughts, it would simpler just before the WATCH_TASK_INIT 
> call in copy_process() in fork.c.  It can be done unconditionally there.
> 
> Peter

	That would work. It would not simplify the control flow of the code.
The branch for WATCH_TASK_INIT in notify_per_task_watchers() is
unavoidable; we need to call the parent task's chain in that case since
we know the child task's is empty.

	It is also counter to one goal of the patches -- reducing the "clutter"
in these paths. Arguably task watchers is the same kind of clutter that
existed before. However, it is a means of factoring such clutter into
fewer instances (ideally one) of the pattern.

Cheers,
	-Matt Helsley

