Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVCXIbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVCXIbu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVCXIbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:31:50 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34779 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262717AbVCXIbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:31:47 -0500
Date: Thu, 24 Mar 2005 03:31:41 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <20050324053456.GA14494@elte.hu>
Message-ID: <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain>
References: <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com>
 <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu>
 <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu>
 <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com>
 <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com>
 <20050324053456.GA14494@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

I've noticed the following situation which is caused by __up_mutex
assigning an owner right away.

Given 3 processes, with priorities 1, 2, 3, where 3 is highest and 1 is
lowest, and call them process A, B, C respectively.

1.  Process A runs and grabs Lock L.
2.  Process B preempts A, tries to grab Lock L.
3.  Process A inherits process B's priority and starts to run.
4.  Process C preempts A, tries to grab Lock L.
5.  Process A inherits process C's priority and starts to run.
6.  Process A releases Lock L loses its priority.
7.  Process C gets Lock L.
8.  Process C runs and releases Lock L.
9.  With __up_mutex, Process B automatically gets Lock L.
10. Process C tries to grab Lock L again, but is now blocked by B.

So we have a needless latency for Procss C, since it should be able to get
lock L again.  The problem arises because process B grabbed the lock
without actually running.

Since I agree with the rule that a lock can't have waiters while not being
owned, I believe that this problem can be solved by adding a flag that
states that the lock is "partially owned".  That is the ownership of the
lock should be transferred at step 9, but a flag is set that it has not
been grabbed. This flag would be cleared when Process B wakes up and
leaves the __down call.

This way when process C tries to get the lock again, it sees that it's
owned, but B hasn't executed yet. So it would be safe for C to take the
lock back from B, that is if C is greater priority than B, otherwise it
would act the same.

If you agree with this approach, I would be willing to write a patch for
you.

-- Steve

