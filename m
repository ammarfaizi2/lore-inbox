Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVDAFNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVDAFNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVDAFNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:13:53 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42943 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262624AbVDAFNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:13:51 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050401044307.GB22753@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
	 <1112290916.12543.19.camel@localhost.localdomain>
	 <20050331174927.GA11483@elte.hu>
	 <1112317173.28076.10.camel@localhost.localdomain>
	 <20050401044307.GB22753@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 01 Apr 2005 00:13:46 -0500
Message-Id: <1112332426.28076.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 06:43 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Ingo,
> > 
> > I was wondering if the issue the bit_spin_lock has gone into the side 
> > burner? [...]
> 
> could you send me your latest patch for the bit-spin issue? My main 
> issue was cleanliness, so that the patch doesnt get stuck in the -RT 
> tree forever.

I think that's the main problem. Without changing the design of the ext3
system, I don't think there is a clean patch.  The implementation that I
finally settled down with was to make the j_state and j_journal_head
locks two global locks. I had to make a few modifications to some spots
to avoid deadlocks, but this worked out well. The problem I was worried
about was this causing too much overhead. So the ext3 buffers would have
to contend with each other. I don't have any tests to see if this had
too much of an impact.

If you are still interested, then let me know and I'll pull it out and
send it to you.  I preferred this method over the other wait_on_bit,
since using normal spin_locks gives priority inheritance, but to put
this into the buffer head seemed too much of an overhead.

Also, there was that inverted_lock crap in commit.c that also caused
problems. I just used the expensive wait_queue fix, where instead of
just calling schedule, I put the task on the wait queue to wake up when
the lock was released, and had unlock of j_state_lock wake it up. But
this is expensive since every time j_state_lock is unlocked, you need to
try to wake up a task that is most likely not there.  This I still need
to optimize.

-- Steve


